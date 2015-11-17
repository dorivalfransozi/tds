unit DDC.Validate.MinValue.Test;
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
  DDC.Validate.MinValue,
  DDC.Validate.CustomAttribute,
  System.Rtti;

type
  // Test methods for class TMinValue

  TestTMinValue = class(TTestCase)
  strict private
    FMinValue: TMinValue;
  public
    const
    COLUMN_NAME: String = 'MyProp';
    MIN_VALUE: Integer = 10;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure GetErrorMessage;
    procedure IsValidString;
    procedure IsValidCurrencyLittle;
    procedure IsValidCurrencyEqual;
    procedure IsValidCurrencyGreat;
    procedure IsValidIntegerLittle;
    procedure IsValidIntegerEqual;
    procedure IsValidIntegerGreat;
  end;

implementation

uses
  System.SysUtils,
  DDC.Validator.ResourceStrings;



procedure TestTMinValue.SetUp;
begin
  FMinValue := TMinValue.Create(MIN_VALUE, COLUMN_NAME);
end;



procedure TestTMinValue.TearDown;
begin
  FMinValue.Free;
  FMinValue := nil;
end;



procedure TestTMinValue.GetErrorMessage;
begin
  CheckTrue(FMinValue.GetErrorMessage = Format(TResourceStringsValidator.RSValidation_MinValue, [COLUMN_NAME, MIN_VALUE.ToString]), 'Erro ao formatar mensagem');
end;



procedure TestTMinValue.IsValidCurrencyEqual;
var
  AValue: TValue;
begin
  AValue := 10.0;
  CheckTrue(FMinValue.isValid(AValue), 'Erro ao validar o n�mero ' + AValue.ToString);
end;



procedure TestTMinValue.IsValidCurrencyGreat;
var
  AValue: TValue;
begin
  AValue := 11.0;
  CheckTrue(FMinValue.isValid(AValue), 'Erro ao validar o n�mero ' + AValue.ToString);
end;



procedure TestTMinValue.IsValidCurrencyLittle;
var
  AValue: TValue;
begin
  AValue := 9.0;
  CheckFalse(FMinValue.isValid(AValue), 'Erro ao validar o n�mero ' + AValue.ToString);
end;



procedure TestTMinValue.IsValidIntegerEqual;
var
  AValue: TValue;
begin
  AValue := 10;
  CheckTrue(FMinValue.isValid(AValue), 'Erro ao validar o n�mero ' + AValue.ToString);
end;



procedure TestTMinValue.IsValidIntegerGreat;
var
  AValue: TValue;
begin
  AValue := 11;
  CheckTrue(FMinValue.isValid(AValue), 'Erro ao validar o n�mero ' + AValue.ToString);
end;



procedure TestTMinValue.IsValidIntegerLittle;
var
  AValue: TValue;
begin
  AValue := 9;
  CheckFalse(FMinValue.isValid(AValue), 'Erro ao validar o n�mero ' + AValue.ToString);
end;



procedure TestTMinValue.IsValidString;
var
  AValue: TValue;
begin
  AValue := 'abcd';
  CheckFalse(FMinValue.isValid(AValue), 'String inv�lida ' + AValue.ToString);
end;

initialization

// Register any test cases with the test runner
RegisterTest(TestTMinValue.Suite);

end.
