unit DDC.Validator;

interface

uses
  System.StrUtils,
  System.Generics.Collections,
  System.Classes,
  FM.Model.Base,
  System.Rtti;

type
  IValidate = interface
    ['{BEC53519-B865-4283-ADEA-A5D72BF0703B}']
    function isValid(const AValue: TValue): Boolean;
    function GetErrorMessage: string;
  end;

  TMyCustomAttribute = class(TCustomAttribute, IInterface)
  private
    FCustomErrorMessage: String;
    FColumnTitle: String;
    FValue: TValue;
  protected
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;

    property CustomErrorMessage: String read FCustomErrorMessage write FCustomErrorMessage;
    property ColumnTitle: String read FColumnTitle write FColumnTitle;
    property Value: TValue read FValue write FValue;
  end;

  TMinLength = class(TMyCustomAttribute, IValidate)
  private
    const
    ERROR_MESSAGE: String = TResourceStrings.RSValidation_MinLength;
  private
    FMinLength: Integer;
  public
    constructor Create(const AMinLength: Integer); overload;
    constructor Create(const AMinLength: Integer; const AColumnTitle: String); overload;
    constructor Create(const AMinLength: Integer; const AColumnTitle, ACustomErrorMessage: String); overload;
    function GetErrorMessage: string;
    function isValid(const AValue: TValue): Boolean;
  end;

  TMaxLength = class(TMyCustomAttribute, IValidate)
  private
    const
    ERROR_MESSAGE: String = TResourceStrings.RSValidation_MaxLength;
  private
    FMaxLength: Integer;
  public
    constructor Create(const AMaxLength: Integer); overload;
    constructor Create(const AMaxLength: Integer; const AColumnTitle: String); overload;
    constructor Create(const AMaxLength: Integer; const AColumnTitle, ACustomErrorMessage: String); overload;
    function GetErrorMessage: string;
    function isValid(const AValue: TValue): Boolean;
  end;

  TMinValue = class(TMyCustomAttribute, IValidate)
  private
    const
    ERROR_MESSAGE: String = TResourceStrings.RSValidation_MinValue;
  private
    FMinValue: Integer;
  public
    constructor Create(const AMinValue: Integer); overload;
    constructor Create(const AMinValue: Integer; const AColumnTitle: String); overload;
    constructor Create(const AMinValue: Integer; const AColumnTitle, ACustomErrorMessage: String); overload;
    function GetErrorMessage: string;
    function isValid(const AValue: TValue): Boolean;
  end;

  TMaxValue = class(TMyCustomAttribute, IValidate)
  private
    const
    ERROR_MESSAGE: String = TResourceStrings.RSValidation_MaxValue;
  private
    FMaxValue: Integer;
  public
    constructor Create(const AMaxValue: Integer); overload;
    constructor Create(const AMaxValue: Integer; const AColumnTitle: String); overload;
    constructor Create(const AMaxValue: Integer; const AColumnTitle, ACustomErrorMessage: String); overload;
    function GetErrorMessage: string;
    function isValid(const AValue: TValue): Boolean;
  end;

  TExactLength = class(TMyCustomAttribute, IValidate)
  private
    const
    ERROR_MESSAGE: String = TResourceStrings.RSValidation_ExactLength;
  private
    FExactLength: Integer;
  public
    constructor Create(const AExactLength: Integer); overload;
    constructor Create(const AExactLength: Integer; const AColumnTitle: String); overload;
    constructor Create(const AExactLength: Integer; const AColumnTitle, ACustomErrorMessage: String); overload;
    function GetErrorMessage: string;
    function isValid(const AValue: TValue): Boolean;
  end;

  TRequired = class(TMyCustomAttribute, IValidate)
  private
    const
    ERROR_MESSAGE: String = TResourceStrings.RSValidation_Required;
  public
    constructor Create(const AColumnTitle: String); overload;
    constructor Create(const AColumnTitle, ACustomErrorMessage: String); overload;
    function GetErrorMessage: string;
    function isValid(const AValue: TValue): Boolean;
  end;

  TIsNatural = class(TMyCustomAttribute, IValidate)
  private
    const
    ERROR_MESSAGE: String = TResourceStrings.RSValidation_IsNatural;
  public
    constructor Create(const AColumnTitle: String); overload;
    constructor Create(const AColumnTitle, ACustomErrorMessage: String); overload;
    function GetErrorMessage: string;
    function isValid(const AValue: TValue): Boolean;
  end;

  TIsNaturalNoZero = class(TMyCustomAttribute, IValidate)
  private
    const
    ERROR_MESSAGE: String = TResourceStrings.RSValidation_IsNaturalNoZero;
  public
    constructor Create(const AColumnTitle: String); overload;
    constructor Create(const AColumnTitle, ACustomErrorMessage: String); overload;
    function GetErrorMessage: string;
    function isValid(const AValue: TValue): Boolean;
  end;

  TAnonymousExtendValidator = reference to function(const AValue: TValue): Boolean;

  IValidator<T: class> = interface
    ['{A3A5A5A9-899D-4D1D-BD29-CC2FE3A50585}']
    function Make(const AModel: T; const AExitOnFirstError: Boolean = False): IValidator<T>;
    function Fails: Boolean;
    function ValidationErrors: TStringList;
    procedure AddExtend(const AValue: TValue; const AErrorMessage: String; const AValidator: TAnonymousExtendValidator);
  end;

  TExtendValidation = record
    Value: TValue;
    ErrorMessage: string;
    constructor Create(const AValue: TValue; const AErrorMessage: String);
  end;

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
    function ValidationErrors: TStringList;
    procedure AddExtend(const AValue: TValue; const AErrorMessage: String; const AValidator: TAnonymousExtendValidator);
  end;

implementation

uses
  M1.Exceptions,
  System.Variants,
  System.SysUtils, System.TypInfo;

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



function TValidator<T>.ValidationErrors: TStringList;
begin
  Result := FErrorList;
end;

{ TMinLength }



constructor TMinLength.Create(const AMinLength: Integer);
begin
  FMinLength := AMinLength;
end;



constructor TMinLength.Create(const AMinLength: Integer; const AColumnTitle: String);
begin
  FMinLength  := AMinLength;
  ColumnTitle := AColumnTitle;
end;



constructor TMinLength.Create(const AMinLength: Integer; const AColumnTitle, ACustomErrorMessage: String);
begin
  FMinLength          := AMinLength;
  ColumnTitle         := AColumnTitle;
  FCustomErrorMessage := ACustomErrorMessage;
end;



function TMinLength.GetErrorMessage: string;
begin
  Result := Format(ifThen(CustomErrorMessage = EmptyStr, ERROR_MESSAGE, CustomErrorMessage), [ColumnTitle, FMinLength.ToString]);
end;



function TMinLength.isValid(const AValue: TValue): Boolean;
begin
  Self.Value := AValue;
  case AValue.Kind of
    tkString, tkChar, tkWChar, tkLString, tkWString, tkUString:
      Result := Length(AValue.AsString) >= FMinLength;
  else
    // não aplica validação em outros tipos
    Result := False;
  end;
end;

{ TMyCustomAttribute }



function TMyCustomAttribute.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := S_OK
  else
    Result := E_NOINTERFACE;
end;



function TMyCustomAttribute._AddRef: Integer;
begin
  Result := -1;
end;



function TMyCustomAttribute._Release: Integer;
begin
  Result := -1;
end;

{ TMaxValue }



constructor TMaxValue.Create(const AMaxValue: Integer);
begin
  FMaxValue := AMaxValue
end;



constructor TMaxValue.Create(const AMaxValue: Integer; const AColumnTitle: String);
begin
  FMaxValue   := AMaxValue;
  ColumnTitle := AColumnTitle;
end;



constructor TMaxValue.Create(const AMaxValue: Integer; const AColumnTitle, ACustomErrorMessage: String);
begin
  FMaxValue          := AMaxValue;
  ColumnTitle        := AColumnTitle;
  CustomErrorMessage := ACustomErrorMessage;
end;



function TMaxValue.GetErrorMessage: string;
begin
  Result := Format(ifThen(CustomErrorMessage = EmptyStr, ERROR_MESSAGE, CustomErrorMessage), [ColumnTitle, FMaxValue.ToString]);
end;



function TMaxValue.isValid(const AValue: TValue): Boolean;
begin
  Self.Value := AValue;
  case AValue.Kind of
    tkInteger:
      Result := AValue.AsInteger <= FMaxValue;
    tkInt64:
      Result := AValue.AsInt64 <= FMaxValue;
    tkFloat:
      Result := AValue.AsExtended <= FMaxValue;
  else
    // não aplica validação em outros tipos
    Result := False;
  end;
end;

{ TMinValue }



constructor TMinValue.Create(const AMinValue: Integer);
begin
  FMinValue := AMinValue;
end;



constructor TMinValue.Create(const AMinValue: Integer; const AColumnTitle: String);
begin
  FMinValue   := AMinValue;
  ColumnTitle := AColumnTitle;
end;



constructor TMinValue.Create(const AMinValue: Integer; const AColumnTitle, ACustomErrorMessage: String);
begin
  FMinValue          := AMinValue;
  ColumnTitle        := AColumnTitle;
  CustomErrorMessage := ACustomErrorMessage;
end;



function TMinValue.GetErrorMessage: string;
begin
  Result := Format(ifThen(CustomErrorMessage = EmptyStr, ERROR_MESSAGE, CustomErrorMessage), [ColumnTitle, FMinValue.ToString]);
end;



function TMinValue.isValid(const AValue: TValue): Boolean;
begin
  Self.Value := AValue;
  case AValue.Kind of
    tkInteger:
      Result := AValue.AsInteger >= FMinValue;
    tkInt64:
      Result := AValue.AsInt64 >= FMinValue;
    tkFloat:
      Result := AValue.AsExtended >= FMinValue;
  else
    // não aplica validação em outros tipos
    Result := False;
  end;
end;

{ TMaxLength }



constructor TMaxLength.Create(const AMaxLength: Integer);
begin
  FMaxLength := AMaxLength;
end;



constructor TMaxLength.Create(const AMaxLength: Integer; const AColumnTitle: String);
begin
  FMaxLength  := AMaxLength;
  ColumnTitle := AColumnTitle;
end;



constructor TMaxLength.Create(const AMaxLength: Integer; const AColumnTitle, ACustomErrorMessage: String);
begin
  FMaxLength         := AMaxLength;
  ColumnTitle        := AColumnTitle;
  CustomErrorMessage := ACustomErrorMessage;
end;



function TMaxLength.GetErrorMessage: string;
begin
  Result := Format(ifThen(CustomErrorMessage = EmptyStr, ERROR_MESSAGE, CustomErrorMessage), [ColumnTitle, FMaxLength.ToString]);
end;



function TMaxLength.isValid(const AValue: TValue): Boolean;
begin
  Self.Value := AValue;
  case AValue.Kind of
    tkString, tkChar, tkWChar, tkLString, tkWString, tkUString:
      Result := Length(AValue.AsString) <= FMaxLength;
  else
    // não aplica validação em outros tipos
    Result := False;
  end;
end;

{ TExactLength }



constructor TExactLength.Create(const AExactLength: Integer);
begin
  FExactLength := AExactLength;
end;



constructor TExactLength.Create(const AExactLength: Integer; const AColumnTitle: String);
begin
  FExactLength := AExactLength;
  ColumnTitle  := AColumnTitle;
end;



constructor TExactLength.Create(const AExactLength: Integer; const AColumnTitle, ACustomErrorMessage: String);
begin
  FExactLength       := AExactLength;
  ColumnTitle        := AColumnTitle;
  CustomErrorMessage := ACustomErrorMessage;
end;



function TExactLength.GetErrorMessage: string;
begin
  Result := Format(ifThen(CustomErrorMessage = EmptyStr, ERROR_MESSAGE, CustomErrorMessage), [ColumnTitle, FExactLength.ToString]);
end;



function TExactLength.isValid(const AValue: TValue): Boolean;
begin
  Self.Value := AValue;
  case AValue.Kind of
    tkString, tkChar, tkWChar, tkLString, tkWString, tkUString:
      Result := Length(AValue.AsString) = FExactLength;
  else
    // não aplica validação em outros tipos
    Result := False;
  end;
end;

{ TExtendValidation }



constructor TExtendValidation.Create(const AValue: TValue;
  const AErrorMessage: String);
begin
  Value        := AValue;
  ErrorMessage := AErrorMessage
end;

{ TRequired }



constructor TRequired.Create(const AColumnTitle: String);
begin
  ColumnTitle := AColumnTitle;
end;



constructor TRequired.Create(const AColumnTitle, ACustomErrorMessage: String);
begin
  ColumnTitle        := AColumnTitle;
  CustomErrorMessage := ACustomErrorMessage;
end;



function TRequired.GetErrorMessage: string;
begin
  Result := Format(ifThen(CustomErrorMessage = EmptyStr, ERROR_MESSAGE, CustomErrorMessage), [ColumnTitle]);
end;



function TRequired.isValid(const AValue: TValue): Boolean;
begin
  Self.Value := AValue;
  case AValue.Kind of
    tkString, tkChar, tkWChar, tkLString, tkWString, tkUString:
      Result := trim(AValue.AsString) <> EmptyStr;
  else
    // não aplica validação em outros tipos
    Result := False;
  end;
end;

{ TIsNatural }



constructor TIsNatural.Create(const AColumnTitle: String);
begin
  ColumnTitle := AColumnTitle;
end;



constructor TIsNatural.Create(const AColumnTitle, ACustomErrorMessage: String);
begin
  ColumnTitle        := AColumnTitle;
  CustomErrorMessage := ACustomErrorMessage;
end;



function TIsNatural.GetErrorMessage: string;
begin
  Result := Format(ifThen(CustomErrorMessage = EmptyStr, ERROR_MESSAGE, CustomErrorMessage), [ColumnTitle]);
end;



function TIsNatural.isValid(const AValue: TValue): Boolean;
begin
  Self.Value := AValue;
  case AValue.Kind of
    tkInteger:
      Result := AValue.AsInteger > -1;
    tkInt64:
      Result := AValue.AsInt64 > -1;
  else
    // não aplica validação em outros tipos
    Result := False;
  end;
end;

{ TIsNaturalNoZero }



constructor TIsNaturalNoZero.Create(const AColumnTitle: String);
begin
  ColumnTitle := AColumnTitle;
end;



constructor TIsNaturalNoZero.Create(const AColumnTitle,
  ACustomErrorMessage: String);
begin
  ColumnTitle        := AColumnTitle;
  CustomErrorMessage := ACustomErrorMessage;
end;



function TIsNaturalNoZero.GetErrorMessage: string;
begin
  Result := Format(ifThen(CustomErrorMessage = EmptyStr, ERROR_MESSAGE, CustomErrorMessage), [ColumnTitle]);
end;



function TIsNaturalNoZero.isValid(const AValue: TValue): Boolean;
begin
  Self.Value := AValue;
  case AValue.Kind of
    tkInteger:
      Result := AValue.AsInteger > 0;
    tkInt64:
      Result := AValue.AsInt64 > 0;
  else
    // não aplica validação em outros tipos
    Result := False;
  end;
end;

end.
