unit DDC.Validate.MinLength;

interface

uses
  DDC.Validate.CustomAttribute,
  DDC.Validate,
  DDC.Validator.ResourceStrings,
  System.Rtti;

type
  TMinLength = class(TValidateCustomAttribute, IValidate)
  private
    const
    ERROR_MESSAGE: String = TResourceStringsValidator.RSValidation_MinLength;
  private
    FMinLength: Integer;
  public
    constructor Create(const AMinLength: Integer); overload;
    constructor Create(const AMinLength: Integer; const ACustomErrorMessage: String); overload;
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



constructor TMinLength.Create(const AMinLength: Integer; const ACustomErrorMessage: String);
begin
  FMinLength         := AMinLength;
  CustomErrorMessage := ACustomErrorMessage;
end;



function TMinLength.GetErrorMessage: string;
begin
  Result := Format(ifThen(CustomErrorMessage = EmptyStr, ERROR_MESSAGE, CustomErrorMessage),
    [FORMAT_COLUMN_TITLE, FMinLength.ToString]);
end;



function TMinLength.isValid(const AValue: TValue): Boolean;
begin
  Self.Value := AValue;
  case AValue.Kind of
    tkString, tkChar, tkWChar, tkLString, tkWString, tkUString:
      begin
        if (AValue.AsString.Equals(EmptyStr)) then
          Exit(True);

        Result := Length(AValue.AsString) >= FMinLength;
      end
  else
    // não aplica validação em outros tipos
    Result := False;
  end;
end;

end.
