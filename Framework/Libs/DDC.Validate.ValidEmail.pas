unit DDC.Validate.ValidEmail;

interface

uses
  DDC.Validate.CustomAttribute,
  DDC.Validate,
  DDC.Validator.ResourceStrings,
  System.Rtti;

type
  TValidEmail = class(TValidateCustomAttribute, IValidate)
  private
    const
    ERROR_MESSAGE: String = TResourceStringsValidator.RSValidation_ValidEmail;
  public
    constructor Create(ACustomErrorMessage: String); overload;
    function GetErrorMessage: string;
    function isValid(const AValue: TValue): Boolean;
  end;

implementation

uses
  System.SysUtils,
  System.StrUtils,
  System.RegularExpressions;

{ TValidEmail }



constructor TValidEmail.Create(ACustomErrorMessage: String);
begin
  CustomErrorMessage := ACustomErrorMessage;
end;



function TValidEmail.GetErrorMessage: string;
begin
  Result := Format(ifThen(CustomErrorMessage = EmptyStr, ERROR_MESSAGE, CustomErrorMessage), [FORMAT_COLUMN_TITLE]);
end;



function TValidEmail.isValid(const AValue: TValue): Boolean;
const
  EMAIL_REGEX: String = '^[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]@[\w-\.]*[a-zA-Z0-9]\.[a-zA-Z]{2,7}$';
begin
  try
    if (AValue.AsString.Equals(EmptyStr)) then
      Exit(True);

    Result := TRegEx.IsMatch(AValue.AsString, EMAIL_REGEX);
  Except
    Result := False;
  end;
end;

end.
