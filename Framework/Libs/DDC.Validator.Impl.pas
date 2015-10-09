unit DDC.Validator.Impl;

interface

uses
  System.StrUtils,
  System.Generics.Collections,
  System.Classes,
  FM.Model.Base,
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

  TValidatorCustomAttribute = TValidateCustomAttribute;

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
    function Fails: Boolean;
    function ErrorMessages: TStringList;
    procedure AddExtend(const AValue: TValue; const AErrorMessage: String; const AValidator: TAnonymousExtendValidator);
  end;

implementation

uses
  M1.Exceptions,
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
    oSuccess := FExtendValidationList.Items[oExtendValidation].Invoke(oExtendValidation.Value);
    if (not(oSuccess)) then
    begin
      FErrorList.Add(Format(oExtendValidation.ErrorMessage, [oExtendValidation.Value.AsVariant]));
      if (AExitOnFirstError) then
        Exit;
    end;
  end;
end;



procedure TValidator<T>.InternalValidateModel(const AModel: T; const AExitOnFirstError: Boolean);
const
  METHOD_IS_VALID: String = 'isValid';
  METHOD_GET_ERROR: String = 'GetErrorMessage';
var
  oRttiCtx: TRttiContext;
  oRttiTp: TRttiType;
  oRttiProp: TRttiProperty;
  oCstAttr: TCustomAttribute;
  oRttiMetIsValid: TRttiMethod;
  oRttiMetGetErrorMessage: TRttiMethod;
  Args: Array Of TValue;
  oSuccess: Boolean;
begin
  oRttiCtx := TRttiContext.Create.Create;
  try
    oRttiTp := oRttiCtx.GetType(AModel.ClassType);
    for oRttiProp in oRttiTp.GetProperties do
      for oCstAttr in oRttiProp.GetAttributes do
      begin
        oRttiMetIsValid := oRttiCtx.GetType(oCstAttr.ClassInfo).GetMethod(METHOD_IS_VALID);
        if (oRttiMetIsValid = nil) then
          raise Exception.Create(Format(TResourceStrings.RSClasseNaoImplementaMetodo,
            [oCstAttr.ClassName, METHOD_IS_VALID]));

        SetLength(Args, 1);
        Args[0]  := oRttiProp.GetValue(Pointer(AModel));
        oSuccess := oRttiMetIsValid.Invoke(oCstAttr, Args).AsBoolean;
        if (not(oSuccess)) then
        begin
          oRttiMetGetErrorMessage := oRttiCtx.GetType(oCstAttr.ClassInfo).GetMethod(METHOD_GET_ERROR);
          if (oRttiMetGetErrorMessage = nil) then
            raise Exception.Create(Format(TResourceStrings.RSClasseNaoImplementaMetodo,
              [oCstAttr.ClassName, METHOD_GET_ERROR]));

          FErrorList.Add(oRttiMetGetErrorMessage.Invoke(oCstAttr, []).AsString);
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



function TValidator<T>.ErrorMessages: TStringList;
begin
  Result := FErrorList;
end;

end.
