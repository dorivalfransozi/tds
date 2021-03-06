unit DDC.Validate.ExactLength;

interface

uses
  DDC.Validate.CustomAttribute,
  DDC.Validate,
  System.Rtti,
  DDC.Validator.ResourceStrings;

{ DONE -oDev -cRefatorar : Criar um custom attribute apenas para t�tulos. }
{ DONE -oDev -cRefatorar : Remover dos Validate os overload que recebem o t�tulo da coluna }
type
  TExactLength = class(TValidateCustomAttribute, IValidate)
  private
    const
    ERROR_MESSAGE: String = TResourceStringsValidator.RSValidation_ExactLength;
  private
    FExactLength: Integer;
  public
    constructor Create(const AExactLength: Integer); overload;
    constructor Create(const AExactLength: Integer; const ACustomErrorMessage: String); overload;
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



constructor TExactLength.Create(const AExactLength: Integer; const ACustomErrorMessage: String);
begin
  FExactLength       := AExactLength;
  CustomErrorMessage := ACustomErrorMessage;
end;



function TExactLength.GetErrorMessage: string;
begin
  Result := Format(ifThen(CustomErrorMessage = EmptyStr, ERROR_MESSAGE, CustomErrorMessage),
    [FORMAT_COLUMN_TITLE, FExactLength.ToString]);
end;



function TExactLength.isValid(const AValue: TValue): Boolean;
begin
  Self.Value := AValue;
  case AValue.Kind of
    tkString, tkChar, tkWChar, tkLString, tkWString, tkUString:
      begin
        if (AValue.AsString.Equals(EmptyStr)) then
          Exit(True);

        Result := Length(AValue.AsString) = FExactLength;
      end
  else
    // n�o aplica valida��o em outros tipos
    Result := False;
  end;
end;

end.
