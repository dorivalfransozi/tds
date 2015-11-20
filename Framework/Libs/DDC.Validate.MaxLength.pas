unit DDC.Validate.MaxLength;

interface

uses
  DDC.Validate.CustomAttribute,
  DDC.Validate,
  DDC.Validator.ResourceStrings,
  System.Rtti;

type
  TMaxLength = class(TValidateCustomAttribute, IValidate)
  private
    const
    ERROR_MESSAGE: String = TResourceStringsValidator.RSValidation_MaxLength;
  private
    FMaxLength: Integer;
  public
    constructor Create(const AMaxLength: Integer); overload;
    constructor Create(const AMaxLength: Integer; const ACustomErrorMessage: String); overload;
    function GetErrorMessage: string;
    function isValid(const AValue: TValue): Boolean;
  end;

implementation

uses
  System.SysUtils,
  System.StrUtils,
  System.TypInfo;

{ TMaxLength }



constructor TMaxLength.Create(const AMaxLength: Integer);
begin
  FMaxLength := AMaxLength;
end;



constructor TMaxLength.Create(const AMaxLength: Integer; const ACustomErrorMessage: String);
begin
  FMaxLength         := AMaxLength;
  CustomErrorMessage := ACustomErrorMessage;
end;



function TMaxLength.GetErrorMessage: string;
begin
  Result := Format(ifThen(CustomErrorMessage = EmptyStr, ERROR_MESSAGE, CustomErrorMessage),
    [FORMAT_COLUMN_TITLE, FMaxLength.ToString]);
end;



function TMaxLength.isValid(const AValue: TValue): Boolean;
begin
  Self.Value := AValue;
  case AValue.Kind of
    tkString, tkChar, tkWChar, tkLString, tkWString, tkUString:
      begin
        if (AValue.AsString.Equals(EmptyStr)) then
          Exit(True);

        Result := Length(AValue.AsString) <= FMaxLength;
      end
  else
    // não aplica validação em outros tipos
    Result := False;
  end;
end;

end.
