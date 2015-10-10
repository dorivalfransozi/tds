unit DDC.Validate.Required;

interface

uses
  DDC.Validate.CustomAttribute,
  DDC.Validate,
  M1.ResourceStrings,
  System.Rtti;

type
  TRequired = class(TValidateCustomAttribute, IValidate)
  private
    const
    ERROR_MESSAGE: String = TResourceStrings.RSValidation_Required;
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

{ TRequired }



constructor TRequired.Create(const AColumnTitle: String);
begin
  ColumnTitle := AColumnTitle;
end;



constructor TRequired.Create(const AColumnTitle, ACustomErrorMessage: String);
begin
  ColumnTitle        := AColumnTitle;
  CustomErrorMessage := ACustomErrorMessage;
end;



function TRequired.GetErrorMessage: string;
begin
  Result := Format(ifThen(CustomErrorMessage = EmptyStr, ERROR_MESSAGE, CustomErrorMessage), [ColumnTitle]);
end;



function TRequired.isValid(const AValue: TValue): Boolean;
begin
  Self.Value := AValue;
  case AValue.Kind of
    tkString, tkChar, tkWChar, tkLString, tkWString, tkUString:
      Result := trim(AValue.AsString) <> EmptyStr;
  else
    // não aplica validação em outros tipos
    Result := False;
  end;
end;

end.
