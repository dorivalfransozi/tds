unit DDC.Validator;

interface

uses
  System.StrUtils,
  System.Generics.Collections,
  System.Classes;

type
  IValidate = interface
    ['{BEC53519-B865-4283-ADEA-A5D72BF0703B}']
    function isValid(const AValue: Variant): Boolean;
    function GetErrorMessage: string;
  end;

  TMyCustomAttribute = class(TCustomAttribute, IInterface)
  private
    FCustomErrorMessage: String;
    FColumnTitle: String;
  protected
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;

    property CustomErrorMessage: String read FCustomErrorMessage write FCustomErrorMessage;
    property ColumnTitle: String read FColumnTitle write FColumnTitle;
  end;

  TMinLength = class(TMyCustomAttribute, IValidate)
  private
    const
    ERROR_MESSAGE: String = 'O campo %s deve ter no mínimo %s caracteres.';
  private
    FMinLength: Integer;
  public
    constructor Create(const AMinLength: Integer); overload;
    constructor Create(const AMinLength: Integer; const AColumnTitle: String); overload;
    constructor Create(const AMinLength: Integer; const AColumnTitle, ACustomErrorMessage: String); overload;
    function GetErrorMessage: string;
    function isValid(const AValue: Variant): Boolean;
  end;

  TMaxLength = class(TMyCustomAttribute, IValidate)
  private
    const
    ERROR_MESSAGE: String = 'O campo %s deve ter no máximo %s caracteres.';
  private
    FMaxLength: Integer;
  public
    constructor Create(const AMaxLength: Integer); overload;
    constructor Create(const AMaxLength: Integer; const AColumnTitle: String); overload;
    constructor Create(const AMaxLength: Integer; const AColumnTitle, ACustomErrorMessage: String); overload;
    function GetErrorMessage: string;
    function isValid(const AValue: Variant): Boolean;
  end;

  TMinValue = class(TMyCustomAttribute, IValidate)
  private
    const
    ERROR_MESSAGE: String = 'O campo %s deve conter um número maior que %s.';
  private
    FMinValue: Integer;
  public
    constructor Create(const AMinValue: Integer); overload;
    constructor Create(const AMinValue: Integer; const AColumnTitle: String); overload;
    constructor Create(const AMinValue: Integer; const AColumnTitle, ACustomErrorMessage: String); overload;
    function GetErrorMessage: string;
    function isValid(const AValue: Variant): Boolean;
  end;

  TMaxValue = class(TMyCustomAttribute, IValidate)
  private
    const
    ERROR_MESSAGE: String = 'O campo %s deve conter um número menor que %s.';
  private
    FMaxValue: Integer;
  public
    constructor Create(const AMaxValue: Integer); overload;
    constructor Create(const AMaxValue: Integer; const AColumnTitle: String); overload;
    constructor Create(const AMaxValue: Integer; const AColumnTitle, ACustomErrorMessage: String); overload;
    function GetErrorMessage: string;
    function isValid(const AValue: Variant): Boolean;
  end;

  TExactLength = class(TMyCustomAttribute, IValidate)
  private
    const
    ERROR_MESSAGE: String = 'O campo %s deve ter exatamente %s caracteres.';
  private
    FExactLength: Integer;
  public
    constructor Create(const AExactLength: Integer); overload;
    constructor Create(const AExactLength: Integer; const AColumnTitle: String); overload;
    constructor Create(const AExactLength: Integer; const AColumnTitle, ACustomErrorMessage: String); overload;
    function GetErrorMessage: string;
    function isValid(const AValue: Variant): Boolean;
  end;

  TAnonymousExtendValidator = reference to function(const AValue: Variant): Boolean;

  IValidator<T> = interface
    ['{A3A5A5A9-899D-4D1D-BD29-CC2FE3A50585}']
    function Validate(const AModel: T): Boolean;
    procedure AddExtend(const AValue: Variant; const AErrorMessage: String;
      const AValidator: TAnonymousExtendValidator);
  end;

  PExtendValidation = ^TExtendValidation;

  TExtendValidation = record
    Value: Variant;
    ErrorMessage: string;
    constructor Create(const AValue: Variant; const AErrorMessage: String);
  end;

  TValidator<T> = class(TInterfacedObject, IValidator<T>)
  private
    FExtendValidationList: TDictionary<TExtendValidation, TAnonymousExtendValidator>;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;

    function Validate(const AModel: T): Boolean;
    procedure AddExtend(const AValue: Variant; const AErrorMessage: String;
      const AValidator: TAnonymousExtendValidator);
  end;

implementation

uses
  M1.Exceptions,
  System.Variants,
  System.SysUtils;

{ TValidator<T> }



procedure TValidator<T>.AddExtend(const AValue: Variant; const AErrorMessage: String;
  const AValidator: TAnonymousExtendValidator);
begin
  FExtendValidationList.Add(TExtendValidation.Create(AValue, AErrorMessage), AValidator);
end;



constructor TValidator<T>.Create;
begin
  FExtendValidationList := TDictionary<TExtendValidation, TAnonymousExtendValidator>.Create;
end;



destructor TValidator<T>.Destroy;
begin
  FExtendValidationList.Free;

  inherited;
end;



function TValidator<T>.Validate(const AModel: T): Boolean;
var
  oExtendValidation: TExtendValidation;
  oAnonymousExtendValidator: TAnonymousExtendValidator;
begin
  { TODO -oDev -cDesenvolver : Passar com rtti pelo modelo aplicando os validators }

  for oExtendValidation in FExtendValidationList.Keys do
  begin
    oAnonymousExtendValidator := FExtendValidationList.Items[oExtendValidation];
    Result                    := oAnonymousExtendValidator(oExtendValidation.Value);
    if (not(Result)) then
      raise ExceptionValidationInfo.Create(Format(oExtendValidation.ErrorMessage, [oExtendValidation.Value]));
  end;

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
  Result := ifThen(CustomErrorMessage.IsEmpty, ERROR_MESSAGE, CustomErrorMessage);
end;



function TMinLength.isValid(const AValue: Variant): Boolean;
begin
  Result := Length(VarToStrDef(AValue, EmptyStr)) <= FMinLength;
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
  Result := ifThen(CustomErrorMessage.IsEmpty, ERROR_MESSAGE, CustomErrorMessage);
end;



function TMaxValue.isValid(const AValue: Variant): Boolean;
begin
  Result := StrToInt(VarToStrDef(AValue, '0')) <= FMaxValue;
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
  Result := ifThen(CustomErrorMessage.IsEmpty, ERROR_MESSAGE, CustomErrorMessage);
end;



function TMinValue.isValid(const AValue: Variant): Boolean;
begin
  Result := StrToInt(VarToStrDef(AValue, '0')) >= FMinValue;
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
  Result := ifThen(CustomErrorMessage.IsEmpty, ERROR_MESSAGE, CustomErrorMessage);
end;



function TMaxLength.isValid(const AValue: Variant): Boolean;
begin
  Result := Length(VarToStrDef(AValue, EmptyStr)) <= FMaxLength;
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
  Result := ifThen(CustomErrorMessage.IsEmpty, ERROR_MESSAGE, CustomErrorMessage);
end;



function TExactLength.isValid(const AValue: Variant): Boolean;
begin
  Result := Length(VarToStrDef(AValue, EmptyStr)) = FExactLength;
end;

{ TExtendValidation }



constructor TExtendValidation.Create(const AValue: Variant;
  const AErrorMessage: String);
begin
  Value        := AValue;
  ErrorMessage := AErrorMessage
end;

end.
