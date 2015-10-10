unit DDC.Validate.ExactLength.Test;
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
  DDC.Validate.ExactLength,
  DDC.Validate.CustomAttribute,
  System.Rtti;

type
  // Test methods for class TExactLength

  TestTExactLength = class(TTestCase)
  strict private
    FExactLength: TExactLength;
  public
    const
    COLUMN_NAME: String = 'MyProp';
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure GetErrorMessage;
    procedure IsValidString;
    procedure IsValidInteger;
    procedure IsValidCurrency;
  end;

implementation

uses
  System.SysUtils, M1.ResourceStrings;



procedure TestTExactLength.SetUp;
begin
  FExactLength := TExactLength.Create(5, COLUMN_NAME);
end;



procedure TestTExactLength.TearDown;
begin
  FExactLength.Free;
  FExactLength := nil;
end;



procedure TestTExactLength.GetErrorMessage;
begin
  CheckFalse(FExactLength.GetErrorMessage = Format(TResourceStrings.RSValidation_IsInteger, [COLUMN_NAME]),
    'Erro ao formatar mensagem');
end;



procedure TestTExactLength.IsValidCurrency;
var
  AValue: TValue;
begin
  AValue := 0123.4;
  CheckFalse(FExactLength.isValid(AValue), 'N�o esta apto a validar currency');
end;



procedure TestTExactLength.IsValidInteger;
var
  AValue: TValue;
begin
  AValue := 01234;
  CheckFalse(FExactLength.isValid(AValue), 'N�o esta apto a validar inteiros');
end;



procedure TestTExactLength.IsValidString;
var
  AValue: TValue;
begin
  AValue := 'abcde';
  CheckTrue(FExactLength.isValid(AValue), 'String ' + AValue.ToString + ' <> diferente de length 5.');
end;

initialization

// Register any test cases with the test runner
RegisterTest(TestTExactLength.Suite);

end.
