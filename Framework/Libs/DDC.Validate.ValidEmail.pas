unit DDC.Validate.ValidEmail;

interface

uses
  DDC.Validate.CustomAttribute, DDC.Validate, M1.ResourceStrings, System.Rtti;

type
  TValidEmail = class(TValidateCustomAttribute, IValidate)
  private
    const
    ERROR_MESSAGE: String = TResourceStrings.RSValidation_ValidEmail;
  public
    constructor Create(const AColumnTitle: String); overload;
    constructor Create(const AColumnTitle, ACustomErrorMessage: String); overload;
    function GetErrorMessage: string;
    function isValid(const AValue: TValue): Boolean;
  end;

implementation

uses
  System.SysUtils, System.StrUtils, System.RegularExpressions;

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
  EMAIL_REGEX: String = '^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,6}$';
begin
  try
    Result := TRegEx.IsMatch(AValue.AsString, EMAIL_REGEX);
  Except
    Result := False;
  end;
end;

end.
