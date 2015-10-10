unit DDC.Validate.MinValue;

interface

uses
  DDC.Validate.CustomAttribute,
  DDC.Validate,
  M1.ResourceStrings,
  System.Rtti;

type
  TMinValue = class(TValidateCustomAttribute, IValidate)
  private
    const
    ERROR_MESSAGE: String = TResourceStrings.RSValidation_RegexValidate;
  private
    FMinValue: Integer;
  public
    constructor Create(const AMinValue: Integer); overload;
    constructor Create(const AMinValue: Integer; const AColumnTitle: String); overload;
    constructor Create(const AMinValue: Integer; const AColumnTitle, ACustomErrorMessage: String); overload;
    function GetErrorMessage: string;
    function isValid(const AValue: TValue): Boolean;
  end;

implementation

uses
  System.StrUtils,
  System.TypInfo,
  System.SysUtils;

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
  Result := Format(ifThen(CustomErrorMessage = EmptyStr, ERROR_MESSAGE, CustomErrorMessage),
    [ColumnTitle, FMinValue.ToString]);
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

end.
