unit DDC.Validate.MaxValue;

interface

uses
  DDC.Validate.CustomAttribute,
  DDC.Validate,
  DDC.Validator.ResourceStrings,
  System.Rtti;

type
  TMaxValue = class(TValidateCustomAttribute, IValidate)
  private
    const
    ERROR_MESSAGE: String = TResourceStringsValidator.RSValidation_MaxValue;
  private
    FMaxValue: Integer;
  public
    constructor Create(const AMaxValue: Integer); overload;
    constructor Create(const AMaxValue: Integer; const AColumnTitle: String); overload;
    constructor Create(const AMaxValue: Integer; const AColumnTitle, ACustomErrorMessage: String); overload;
    function GetErrorMessage: string;
    function isValid(const AValue: TValue): Boolean;
  end;

implementation

uses
  System.SysUtils,
  System.StrUtils,
  System.TypInfo;

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
  Result := Format(ifThen(CustomErrorMessage = EmptyStr, ERROR_MESSAGE, CustomErrorMessage),
    [ColumnTitle, FMaxValue.ToString]);
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

end.
