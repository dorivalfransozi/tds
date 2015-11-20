unit DDC.Validate.IsNaturalNoZero.Test;
{

  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit
  being tested.

}

interface

uses
  TestFramework,
  DDC.Validate,
  DDC.Validate.CustomAttribute,
  DDC.Validate.IsNaturalNoZero,
  System.Rtti;

type
  // Test methods for class TIsNaturalNoZero

  TestTIsNaturalNoZero = class(TTestCase)
  strict private
    FIsNaturalNoZero: TIsNaturalNoZero;
  public
    const
    COLUMN_NAME: String = 'MyProp';
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure GetErrorMessage;
    procedure IsValidString;
    procedure IsValidCurrency;
    procedure IsValidInteger;
    procedure IsValidZero;
  end;

implementation

uses
  System.SysUtils,
  DDC.Validator.ResourceStrings;



procedure TestTIsNaturalNoZero.SetUp;
begin
  FIsNaturalNoZero := TIsNaturalNoZero.Create;
end;



procedure TestTIsNaturalNoZero.TearDown;
begin
  FIsNaturalNoZero.Free;
  FIsNaturalNoZero := nil;
end;



procedure TestTIsNaturalNoZero.GetErrorMessage;
begin
  CheckTrue(FIsNaturalNoZero.GetErrorMessage = TResourceStringsValidator.RSValidation_IsNaturalNoZero,
    'Erro ao formatar mensagem');
end;



procedure TestTIsNaturalNoZero.IsValidCurrency;
var
  AValue: TValue;
begin
  AValue := 0123.4;
  CheckFalse(FIsNaturalNoZero.isValid(AValue), 'N�o � um n�mero natural: ' + AValue.ToString);
end;



procedure TestTIsNaturalNoZero.IsValidInteger;
var
  AValue: TValue;
begin
  AValue := 1234;
  CheckTrue(FIsNaturalNoZero.isValid(AValue), 'Erro ao validar n�mero natural maior que zero: ' + AValue.ToString);
end;



procedure TestTIsNaturalNoZero.IsValidString;
var
  AValue: TValue;
begin
  AValue := 'abcde';
  CheckFalse(FIsNaturalNoZero.isValid(AValue), 'N�o � um n�mero natural: ' + AValue.ToString);
end;



procedure TestTIsNaturalNoZero.IsValidZero;
var
  AValue: TValue;
begin
  AValue := 0;
  CheckFalse(FIsNaturalNoZero.isValid(AValue), 'N�o � um n�mero natural maior que zero: ' + AValue.ToString);
end;

initialization

// Register any test cases with the test runner
RegisterTest(TestTIsNaturalNoZero.Suite);

end.
