unit DDC.Validate.IsNaturalNoZero;

interface

uses
  DDC.Validate.CustomAttribute,
  DDC.Validate,
  DDC.Validator.ResourceStrings,
  System.Rtti;

type
  TIsNaturalNoZero = class(TValidateCustomAttribute, IValidate)
  private
    const
    ERROR_MESSAGE: String = TResourceStringsValidator.RSValidation_IsNaturalNoZero;
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

{ TIsNaturalNoZero }



constructor TIsNaturalNoZero.Create(const AColumnTitle: String);
begin
  ColumnTitle := AColumnTitle;
end;



constructor TIsNaturalNoZero.Create(const AColumnTitle,
  ACustomErrorMessage: String);
begin
  ColumnTitle        := AColumnTitle;
  CustomErrorMessage := ACustomErrorMessage;
end;



function TIsNaturalNoZero.GetErrorMessage: string;
begin
  Result := Format(ifThen(CustomErrorMessage = EmptyStr, ERROR_MESSAGE, CustomErrorMessage), [ColumnTitle]);
end;



function TIsNaturalNoZero.isValid(const AValue: TValue): Boolean;
begin
  Self.Value := AValue;
  case AValue.Kind of
    tkInteger:
      Result := AValue.AsInteger > 0;
    tkInt64:
      Result := AValue.AsInt64 > 0;
  else
    // não aplica validação em outros tipos
    Result := False;
  end;
end;

end.
