unit DDC.Validator.Impl;

interface

uses
  System.StrUtils,
  System.Generics.Collections,
  System.Classes,
  System.SysUtils,
  System.Rtti,

  DDC.Validator.Extend,
  DDC.Validator,

  DDC.Model.ColumnTitle,

  DDC.Validate,
  DDC.Validate.CustomAttribute,
  DDC.Validate.MinLength,
  DDC.Validate.MaxLength,
  DDC.Validate.MinValue,
  DDC.Validate.MaxValue,
  DDC.Validate.ExactLength,
  DDC.Validate.Required,
  DDC.Validate.IsNatural,
  DDC.Validate.IsNaturalNoZero,
  DDC.Validate.IsInteger,
  DDC.Validate.Regex,
  DDC.Validate.ValidEmail;

type
  TColumnTitle = DDC.Model.ColumnTitle.TColumnTitle;

  TExtendValidation = DDC.Validator.Extend.TExtendValidation;
  IValidate = DDC.Validate.IValidate;

  TValidatorCustomAttribute = DDC.Validate.CustomAttribute.TValidateCustomAttribute;

  TMinLength = DDC.Validate.MinLength.TMinLength;
  TMaxLength = DDC.Validate.MaxLength.TMaxLength;
  TMinValue = DDC.Validate.MinValue.TMinValue;
  TMaxValue = DDC.Validate.MaxValue.TMaxValue;
  TExactLength = DDC.Validate.ExactLength.TExactLength;
  TRequired = DDC.Validate.Required.TRequired;
  TIsNatural = DDC.Validate.IsNatural.TIsNatural;
  TIsNaturalNoZero = DDC.Validate.IsNaturalNoZero.TIsNaturalNoZero;
  TIsInteger = DDC.Validate.IsInteger.TIsInteger;
  TRegexValidate = DDC.Validate.Regex.TRegexValidate;
  TValidEmail = DDC.Validate.ValidEmail.TValidEmail;

  TValidator<T: class> = class(TInterfacedObject, IValidator<T>)
  private
    FExtendValidationList: TDictionary<TExtendValidation, TAnonymousExtendValidator>;
    FErrorList: TStringList;
    FFails: Boolean;

    procedure SetColumnTitle(const AColumnTitle: string);

    procedure InternalMake(const AModel: T; const AAttributeName: String; const AExitOnFirstError: Boolean = False);
    procedure InternalValidateModel(const AModel: T; const AExitOnFirstError: Boolean; const AAttributeName: String = '');
    procedure InternalValidateExtend(const AExitOnFirstError: Boolean; const AAttributeName: String = '');
  public
    constructor Create; reintroduce;
    destructor Destroy; override;

    function MakeAttribute(const AModel: T; const AAttributeName: String; const AExitOnFirstError: Boolean = False): IValidator<T>;
    function MakeAll(const AModel: T; const AExitOnFirstError: Boolean = False): IValidator<T>;
    function Fails: Boolean;
    function ErrorMessages: TStringList;
    procedure AddExtend(const AAttributeName: string; const AValue: TValue; const AErrorMessage: String; const AValidator: TAnonymousExtendValidator);
  end;

implementation

uses
  System.Variants,
  System.TypInfo,
  DDC.Validator.ResourceStrings;

{ TValidator<T> }



procedure TValidator<T>.AddExtend(const AAttributeName: string; const AValue: TValue; const AErrorMessage: String; const AValidator: TAnonymousExtendValidator);
begin
  FExtendValidationList.Add(TExtendValidation.Create(AAttributeName, AValue, AErrorMessage), AValidator);
end;



constructor TValidator<T>.Create;
begin
  FExtendValidationList := TDictionary<TExtendValidation, TAnonymousExtendValidator>.Create;
  FErrorList            := TStringList.Create;
end;



destructor TValidator<T>.Destroy;
begin
  FExtendValidationList.Free;
  FErrorList.Free;

  inherited;
end;



function TValidator<T>.Fails: Boolean;
begin
  Result := FFails;
end;



procedure TValidator<T>.InternalMake(const AModel: T; const AAttributeName: String; const AExitOnFirstError: Boolean);
begin
  FFails := False;
  FErrorList.Clear;

  InternalValidateModel(AModel, AExitOnFirstError, AAttributeName);
  FFails := FErrorList.Count > 0;

  if ((AExitOnFirstError) and (FFails)) then
    Exit;

  InternalValidateExtend(AExitOnFirstError, AAttributeName);
  FFails := FErrorList.Count > 0;
end;



procedure TValidator<T>.InternalValidateExtend(const AExitOnFirstError: Boolean; const AAttributeName: String);
var
  oExtendValidation: TExtendValidation;
  oSuccess: Boolean;
  bAttrFound: Boolean;

begin
  for oExtendValidation in FExtendValidationList.Keys do
  begin
    if ((AAttributeName <> EmptyStr) and (oExtendValidation.AttributeName.ToLower.Trim <> AAttributeName.ToLower.Trim))
    then
      Continue;

    bAttrFound := True;
    oSuccess   := FExtendValidationList.Items[oExtendValidation](oExtendValidation.Value);
    if (not(oSuccess)) then
    begin
      FErrorList.Add(Format(oExtendValidation.ErrorMessage, [oExtendValidation.Value.AsVariant]));
      if (AExitOnFirstError) then
        Exit;
    end;
  end;
end;



procedure TValidator<T>.InternalValidateModel(const AModel: T; const AExitOnFirstError: Boolean; const AAttributeName: String);
var
  oRttiCtx: TRttiContext;
  oRttiTp: TRttiType;
  oRttiProp: TRttiProperty;
  oCstAttr: TCustomAttribute;
  oValidate: IValidate;
  bAttrFound: Boolean;
  sColumnTitle: String;
begin
  if (AModel = nil) then
    raise Exception.Create(TResourceStringsValidator.RSValidator_ModelIsNil);

  oRttiCtx := TRttiContext.Create.Create;
  try
    oRttiTp := oRttiCtx.GetType(AModel.ClassType);
    for oRttiProp in oRttiTp.GetProperties do
    begin
      if (oRttiProp.propertytype.typekind in [tkClass, tkRecord]) then
      begin
        InternalValidateModel(oRttiProp.GetValue(TObject(AModel)).AsObject, AExitOnFirstError, AAttributeName);
        Continue;
      end;

      if ((AAttributeName <> EmptyStr) and (oRttiProp.Name.ToLower.Trim <> AAttributeName.ToLower.Trim)) then
        Continue;

      bAttrFound := True;
      try
        sColumnTitle := EmptyStr;
        for oCstAttr in oRttiProp.GetAttributes do
        begin
          if (oCstAttr is TColumnTitle) then
            sColumnTitle := (oCstAttr as TColumnTitle).GetColumnTitle;

          if not(Supports(oCstAttr, IValidate, oValidate)) then
            Continue;

          if (not(oValidate.isValid(oRttiProp.GetValue(Pointer(AModel))))) then
          begin
            FErrorList.Add(oValidate.GetErrorMessage);
            if (AExitOnFirstError) then
              Exit;
          end;
        end;
      finally
        if(FErrorList.Count > 0) then
          SetColumnTitle(sColumnTitle);
      end;
    end;

    if ((AAttributeName <> EmptyStr) and not(bAttrFound)) then
      FErrorList.Add(Format(TResourceStringsValidator.RSValidator_AttrNotFound, [AModel.ClassName, AAttributeName]));
  finally
    oRttiCtx.Free;
  end;
end;



function TValidator<T>.MakeAll(const AModel: T; const AExitOnFirstError: Boolean = False): IValidator<T>;
begin
  InternalMake(AModel, EmptyStr, AExitOnFirstError);
  Result := Self;
end;



function TValidator<T>.MakeAttribute(const AModel: T; const AAttributeName: String; const AExitOnFirstError: Boolean): IValidator<T>;
begin
  InternalMake(AModel, AAttributeName, AExitOnFirstError);
  Result := Self;
end;



procedure TValidator<T>.SetColumnTitle(const AColumnTitle: string);
var
  iIndex: Integer;
begin
  for iIndex := 0 to Pred(FErrorList.Count) do
    FErrorList[iIndex] := Format(FErrorList[iIndex], [AColumnTitle]);
end;



function TValidator<T>.ErrorMessages: TStringList;
begin
  Result := FErrorList;
end;

end.
