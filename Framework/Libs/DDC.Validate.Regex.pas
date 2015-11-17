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
    constructor Create(const ARegex: String; const AColumnTitle: String); overload;
    constructor Create(const ARegex: String; const AColumnTitle, ACustomErrorMessage: String); overload;
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



constructor TRegexValidate.Create(const ARegex, AColumnTitle: String);
begin
  FRegex      := ARegex;
  ColumnTitle := AColumnTitle;
end;



constructor TRegexValidate.Create(const ARegex, AColumnTitle,
  ACustomErrorMessage: String);
begin
  FRegex             := ARegex;
  ColumnTitle        := AColumnTitle;
  CustomErrorMessage := ACustomErrorMessage;
end;



function TRegexValidate.GetErrorMessage: string;
begin
  Result := Format(ifThen(CustomErrorMessage = EmptyStr, ERROR_MESSAGE, CustomErrorMessage), [ColumnTitle]);
end;



function TRegexValidate.isValid(const AValue: TValue): Boolean;
begin
  try
    Result := TRegEx.IsMatch(AValue.AsString, FRegex);
  Except
    Result := False;
  end;
end;

end.
