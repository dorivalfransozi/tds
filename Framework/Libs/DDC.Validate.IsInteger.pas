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
    constructor Create(const ACustomErrorMessage: String); overload;
    function GetErrorMessage: string;
    function isValid(const AValue: TValue): Boolean;
  end;

implementation

uses
  System.SysUtils,
  System.StrUtils,
  System.TypInfo;

{ TIsInteger }



constructor TIsInteger.Create(const ACustomErrorMessage: String);
begin
  CustomErrorMessage := ACustomErrorMessage;
end;



function TIsInteger.GetErrorMessage: string;
begin
  Result := Format(ifThen(CustomErrorMessage = EmptyStr, ERROR_MESSAGE, CustomErrorMessage), [FORMAT_COLUMN_TITLE]);
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
