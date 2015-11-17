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
    constructor Create(const AColumnTitle: String); overload;
    constructor Create(const AColumnTitle, ACustomErrorMessage: String); overload;
    function GetErrorMessage: string;
    function isValid(const AValue: TValue): Boolean;
  end;

implementation

uses
  System.SysUtils,
  System.StrUtils,
  System.RegularExpressions;

{ TValidEmail }



constructor TValidEmail.Create(const AColumnTitle: String);
begin
  ColumnTitle := AColumnTitle;
end;



constructor TValidEmail.Create(const AColumnTitle, ACustomErrorMessage: String);
begin
  ColumnTitle        := AColumnTitle;
  CustomErrorMessage := ACustomErrorMessage;
end;



function TValidEmail.GetErrorMessage: string;
begin
  Result := Format(ifThen(CustomErrorMessage = EmptyStr, ERROR_MESSAGE, CustomErrorMessage), [ColumnTitle]);
end;



function TValidEmail.isValid(const AValue: TValue): Boolean;
const
  EMAIL_REGEX: String = '^[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]@[\w-\.]*[a-zA-Z0-9]\.[a-zA-Z]{2,7}$';
begin
  try
    Result := TRegEx.IsMatch(AValue.AsString, EMAIL_REGEX);
  Except
    Result := False;
  end;
end;

end.
