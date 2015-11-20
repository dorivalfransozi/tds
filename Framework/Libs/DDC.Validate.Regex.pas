unit DDC.Validate.Regex;

interface

uses
  DDC.Validate.CustomAttribute,
  DDC.Validate,
  DDC.Validator.ResourceStrings,
  System.Rtti;

type
  TRegexValidate = class(TValidateCustomAttribute, IValidate)
  private
    const
    ERROR_MESSAGE: String = TResourceStringsValidator.RSValidation_RegexValidate;
  private
    FRegex: String;
  public
    constructor Create(const ARegex: String); overload;
    constructor Create(const ARegex: String; const ACustomErrorMessage: String); overload;
    function GetErrorMessage: string;
    function isValid(const AValue: TValue): Boolean;
  end;

implementation

uses
  System.SysUtils,
  System.StrUtils,
  System.RegularExpressions;

{ TRegexValidate }



constructor TRegexValidate.Create(const ARegex: String);
begin
  FRegex := ARegex;
end;



constructor TRegexValidate.Create(const ARegex, ACustomErrorMessage: String);
begin
  FRegex             := ARegex;
  CustomErrorMessage := ACustomErrorMessage;
end;



function TRegexValidate.GetErrorMessage: string;
begin
  Result := Format(ifThen(CustomErrorMessage = EmptyStr, ERROR_MESSAGE, CustomErrorMessage), [FORMAT_COLUMN_TITLE]);
end;



function TRegexValidate.isValid(const AValue: TValue): Boolean;
begin
  try
    if (AValue.AsString.Equals(EmptyStr)) then
      Exit(True);

    Result := TRegEx.IsMatch(AValue.AsString, FRegex);
  Except
    Result := False;
  end;
end;

end.
