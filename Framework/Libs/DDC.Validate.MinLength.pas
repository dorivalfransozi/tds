unit DDC.Validate.MinLength;

interface

uses
  DDC.Validate.CustomAttribute,
  DDC.Validate,
  M1.ResourceStrings,
  System.Rtti;

type
  TMinLength = class(TValidateCustomAttribute, IValidate)
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

implementation

uses
  System.SysUtils,
  System.StrUtils,
  System.TypInfo;

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
  FMinLength         := AMinLength;
  ColumnTitle        := AColumnTitle;
  CustomErrorMessage := ACustomErrorMessage;
end;



function TMinLength.GetErrorMessage: string;
begin
  Result := Format(ifThen(CustomErrorMessage = EmptyStr, ERROR_MESSAGE, CustomErrorMessage),
    [ColumnTitle, FMinLength.ToString]);
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

end.
