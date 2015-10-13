unit DDC.Validate.MinLength.Test;
{

  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit
  being tested.

}

interface

uses
  TestFramework, DDC.Validate, DDC.Validate.CustomAttribute, M1.ResourceStrings,
  DDC.Validate.MinLength, System.Rtti;

type
  // Test methods for class TMinLength

  TestTMinLength = class(TTestCase)
  strict private
    FMinLength: TMinLength;
  public
    const
    COLUMN_NAME: String = 'MyProp';
    MIN_LENGTH: Integer = 4;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure GetErrorMessage;
    procedure IsValidStringGreat;
    procedure IsValidStringEqual;
    procedure IsValidStringLittle;
    procedure IsValidCurrency;
    procedure IsValidInteger;
  end;

implementation

uses
  System.SysUtils;



procedure TestTMinLength.SetUp;
begin
  FMinLength := TMinLength.Create(MIN_LENGTH, COLUMN_NAME);
end;



procedure TestTMinLength.TearDown;
begin
  FMinLength.Free;
  FMinLength := nil;
end;



procedure TestTMinLength.GetErrorMessage;
begin
  CheckTrue(FMinLength.GetErrorMessage = Format(TResourceStrings.RSValidation_MinLength,
    [COLUMN_NAME, MIN_LENGTH.ToString]), 'Erro ao formatar mensagem');
end;



procedure TestTMinLength.IsValidCurrency;
var
  AValue: TValue;
begin
  AValue := 0123.4;
  CheckFalse(FMinLength.isValid(AValue), 'N�o valida length diferente de string');
end;



procedure TestTMinLength.IsValidInteger;
var
  AValue: TValue;
begin
  AValue := 1234;
  CheckFalse(FMinLength.isValid(AValue), 'N�o valida length diferente de string');
end;



procedure TestTMinLength.IsValidStringGreat;
var
  AValue: TValue;
begin
  AValue := 'abcde';
  CheckTrue(FMinLength.isValid(AValue), 'A erro ao validar a string ' + AValue.ToString);
end;



procedure TestTMinLength.IsValidStringLittle;
var
  AValue: TValue;
begin
  AValue := 'abc';
  CheckFalse(FMinLength.isValid(AValue), 'A erro ao validar a string ' + AValue.ToString);
end;



procedure TestTMinLength.IsValidStringEqual;
var
  AValue: TValue;
begin
  AValue := 'abcd';
  CheckTrue(FMinLength.isValid(AValue), 'A erro ao validar a string ' + AValue.ToString);
end;

initialization

// Register any test cases with the test runner
RegisterTest(TestTMinLength.Suite);

end.