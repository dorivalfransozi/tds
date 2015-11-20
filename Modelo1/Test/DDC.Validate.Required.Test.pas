unit DDC.Validate.Required.Test;
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
  DDC.Validate.Required,
  System.Rtti;

type
  // Test methods for class TRequired

  TestTRequired = class(TTestCase)
  strict private
    FRequired: TRequired;
  public
    const
    COLUMN_NAME: String = 'MyProp';
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure GetErrorMessage;
    procedure IsValidString;
    procedure IsNotValidString;
    procedure IsValidCurrency;
    procedure IsValidInteger;
  end;

implementation

uses
  System.SysUtils,
  DDC.Validator.ResourceStrings;



procedure TestTRequired.SetUp;
begin
  FRequired := TRequired.Create;
end;



procedure TestTRequired.TearDown;
begin
  FRequired.Free;
  FRequired := nil;
end;



procedure TestTRequired.GetErrorMessage;
begin
  CheckTrue(FRequired.GetErrorMessage = TResourceStringsValidator.RSValidation_Required, 'Erro ao formatar mensagem');
end;



procedure TestTRequired.IsValidCurrency;
var
  AValue: TValue;
begin
  AValue := 10.0;
  CheckFalse(FRequired.isValid(AValue), 'N�o esta apto a validar num�ricos ' + AValue.ToString);
end;



procedure TestTRequired.IsValidInteger;
var
  AValue: TValue;
begin
  AValue := 10;
  CheckFalse(FRequired.isValid(AValue), 'N�o esta apto a validar inteiros ' + AValue.ToString);
end;



procedure TestTRequired.IsValidString;
var
  AValue: TValue;
begin
  AValue := 'abcd';
  CheckTrue(FRequired.isValid(AValue), 'String n�o existe ' + AValue.ToString);
end;



procedure TestTRequired.IsNotValidString;
var
  AValue: TValue;
begin
  AValue := '';
  CheckFalse(FRequired.isValid(AValue), 'String existe ' + AValue.ToString);
end;

initialization

// Register any test cases with the test runner
RegisterTest(TestTRequired.Suite);

end.
