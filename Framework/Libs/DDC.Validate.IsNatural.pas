unit DDC.Validate.IsNatural;

interface

uses
  DDC.Validate.CustomAttribute,
  DDC.Validate,
  DDC.Validator.ResourceStrings,
  System.Rtti;

type
  TIsNatural = class(TValidateCustomAttribute, IValidate)
  private
    const
    ERROR_MESSAGE: String = TResourceStringsValidator.RSValidation_IsNatural;
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

{ TIsNatural }



constructor TIsNatural.Create(const AColumnTitle: String);
begin
  ColumnTitle := AColumnTitle;
end;



constructor TIsNatural.Create(const AColumnTitle, ACustomErrorMessage: String);
begin
  ColumnTitle        := AColumnTitle;
  CustomErrorMessage := ACustomErrorMessage;
end;



function TIsNatural.GetErrorMessage: string;
begin
  Result := Format(ifThen(CustomErrorMessage = EmptyStr, ERROR_MESSAGE, CustomErrorMessage), [ColumnTitle]);
end;



function TIsNatural.isValid(const AValue: TValue): Boolean;
begin
  Self.Value := AValue;
  case AValue.Kind of
    tkInteger:
      Result := AValue.AsInteger > -1;
    tkInt64:
      Result := AValue.AsInt64 > -1;
  else
    // não aplica validação em outros tipos
    Result := False;
  end;
end;

end.
