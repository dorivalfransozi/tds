unit DDC.Validate.ExactLength;

interface

uses
  DDC.Validate.CustomAttribute,
  DDC.Validate,
  System.Rtti,
  M1.ResourceStrings;

{ TODO -oDev -cRefatorar : Criar um custom attribute apenas para títulos. }
{ TODO -oDev -cRefatorar : Remover dos Validate os overload que recebem o título da coluna }
type
  TExactLength = class(TValidateCustomAttribute, IValidate)
  private
    const
    ERROR_MESSAGE: String = TResourceStrings.RSValidation_ExactLength;
  private
    FExactLength: Integer;
  public
    constructor Create(const AExactLength: Integer); overload;
    constructor Create(const AExactLength: Integer; const AColumnTitle: String); overload;
    constructor Create(const AExactLength: Integer; const AColumnTitle, ACustomErrorMessage: String); overload;
    function GetErrorMessage: string;
    function isValid(const AValue: TValue): Boolean;
  end;

implementation

uses
  System.SysUtils,
  System.StrUtils,
  System.TypInfo;

{ TExactLength }



constructor TExactLength.Create(const AExactLength: Integer);
begin
  FExactLength := AExactLength;
end;



constructor TExactLength.Create(const AExactLength: Integer; const AColumnTitle: String);
begin
  FExactLength := AExactLength;
  ColumnTitle  := AColumnTitle;
end;



constructor TExactLength.Create(const AExactLength: Integer; const AColumnTitle, ACustomErrorMessage: String);
begin
  FExactLength       := AExactLength;
  ColumnTitle        := AColumnTitle;
  CustomErrorMessage := ACustomErrorMessage;
end;



function TExactLength.GetErrorMessage: string;
begin
  Result := Format(ifThen(CustomErrorMessage = EmptyStr, ERROR_MESSAGE, CustomErrorMessage),
    [ColumnTitle, FExactLength.ToString]);
end;



function TExactLength.isValid(const AValue: TValue): Boolean;
begin
  Self.Value := AValue;
  case AValue.Kind of
    tkString, tkChar, tkWChar, tkLString, tkWString, tkUString:
      Result := Length(AValue.AsString) = FExactLength;
  else
    // não aplica validação em outros tipos
    Result := False;
  end;
end;

end.
