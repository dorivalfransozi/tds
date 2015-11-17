unit DDC.Validate.IsInteger;

interface

uses
  DDC.Validate.CustomAttribute,
  DDC.Validate,
  DDC.Validator.ResourceStrings,
  System.Rtti;

type
  TIsInteger = class(TValidateCustomAttribute, IValidate)
  private
    const
    ERROR_MESSAGE: String = TResourceStringsValidator.RSValidation_IsInteger;
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
  System.TypInfo;

{ TIsInteger }



constructor TIsInteger.Create(const AColumnTitle: String);
begin
  ColumnTitle := AColumnTitle;
end;



constructor TIsInteger.Create(const AColumnTitle, ACustomErrorMessage: String);
begin
  ColumnTitle        := AColumnTitle;
  CustomErrorMessage := ACustomErrorMessage;
end;



function TIsInteger.GetErrorMessage: string;
begin
  Result := Format(ifThen(CustomErrorMessage = EmptyStr, ERROR_MESSAGE, CustomErrorMessage), [ColumnTitle]);
end;



function TIsInteger.isValid(const AValue: TValue): Boolean;
var
  iInteger: Integer;
begin
  try
    iInteger := AValue.AsInteger;
    Result   := iInteger = AValue.AsInteger;
  except
    Result := False;
  end;
end;

end.
