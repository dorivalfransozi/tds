unit DDC.Validator.Impl;

interface

uses
  System.StrUtils,
  System.Generics.Collections,
  System.Classes,
  System.Rtti,

  DDC.Validator.Extend,
  DDC.Validator,

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

    procedure InternalValidateModel(const AModel: T; const AExitOnFirstError: Boolean);
    procedure InternalValidateExtend(const AExitOnFirstError: Boolean);
  public
    constructor Create; reintroduce;
    destructor Destroy; override;

    function Make(const AModel: T; const AExitOnFirstError: Boolean = False): IValidator<T>;
    function MakeAttribute(const AModelAttribute: Pointer; const AExitOnFirstError: Boolean = False): IValidator<T>;
    function Fails: Boolean;
    function ErrorMessages: TStringList;
    procedure AddExtend(const AValue: TValue; const AErrorMessage: String; const AValidator: TAnonymousExtendValidator);
  end;

implementation

uses
  System.Variants,
  System.SysUtils,
  System.TypInfo;

{ TValidator<T> }



procedure TValidator<T>.AddExtend(const AValue: TValue; const AErrorMessage: String;
  const AValidator: TAnonymousExtendValidator);
begin
  FExtendValidationList.Add(TExtendValidation.Create(AValue, AErrorMessage), AValidator);
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



procedure TValidator<T>.InternalValidateExtend(const AExitOnFirstError: Boolean);
var
  oExtendValidation: TExtendValidation;
  oSuccess: Boolean;
begin
  for oExtendValidation in FExtendValidationList.Keys do
  begin
    oSuccess := FExtendValidationList.Items[oExtendValidation](oExtendValidation.Value);
    if (not(oSuccess)) then
    begin
      FErrorList.Add(Format(oExtendValidation.ErrorMessage, [oExtendValidation.Value.AsVariant]));
      if (AExitOnFirstError) then
        Exit;
    end;
  end;
end;



procedure TValidator<T>.InternalValidateModel(const AModel: T; const AExitOnFirstError: Boolean);
var
  oRttiCtx: TRttiContext;
  oRttiTp: TRttiType;
  oRttiProp: TRttiProperty;
  oCstAttr: TCustomAttribute;
  oRttiMetIsValid: TRttiMethod;
  oRttiMetGetErrorMessage: TRttiMethod;
  oValidate: IValidate;
begin
  oRttiCtx := TRttiContext.Create.Create;
  try
    oRttiTp := oRttiCtx.GetType(AModel.ClassType);
    for oRttiProp in oRttiTp.GetProperties do
      for oCstAttr in oRttiProp.GetAttributes do
      begin
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
    oRttiCtx.Free;
  end;
end;



function TValidator<T>.Make(const AModel: T; const AExitOnFirstError: Boolean = False): IValidator<T>;
begin
  InternalValidateModel(AModel, AExitOnFirstError);
  FFails := FErrorList.Count > 0;

  if ((AExitOnFirstError) and (FFails)) then
    Exit(Self);

  InternalValidateExtend(AExitOnFirstError);
  FFails := FErrorList.Count > 0;

  Result := Self;
end;



function TValidator<T>.MakeAttribute(const AModelAttribute: Pointer;
  const AExitOnFirstError: Boolean): IValidator<T>;
begin
  { TODO -oDev -cDesenvolver : Falta desenvolver a validação passando um único atributo do modelo }
  Result := Self;
end;



function TValidator<T>.ErrorMessages: TStringList;
begin
  Result := FErrorList;
end;

end.
