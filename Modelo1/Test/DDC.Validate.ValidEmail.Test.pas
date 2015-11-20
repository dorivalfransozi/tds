unit DDC.Validate.ValidEmail.Test;
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
  DDC.Validate.ValidEmail,
  System.Rtti;

type
  // Test methods for class TValidEmail

  TestTValidEmail = class(TTestCase)
  strict private
    FValidEmail: TValidEmail;
  public
    const
    COLUMN_NAME: String = 'MyProp';
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure GetErrorMessage;
    procedure IsValid;
    procedure IsNotValid;
  end;

implementation

uses
  System.SysUtils,
  DDC.Validator.ResourceStrings;



procedure TestTValidEmail.SetUp;
begin
  FValidEmail := TValidEmail.Create;
end;



procedure TestTValidEmail.TearDown;
begin
  FValidEmail.Free;
  FValidEmail := nil;
end;



procedure TestTValidEmail.GetErrorMessage;
begin
  CheckTrue(FValidEmail.GetErrorMessage = TResourceStringsValidator.RSValidation_ValidEmail,
    'Erro ao formatar mensagem');
end;



procedure TestTValidEmail.IsNotValid;
var
  AValue: TValue;
begin
  AValue := 'eurides@sysmo.125';
  CheckFalse(FValidEmail.IsValid(AValue), 'Email v�lido: ' + AValue.ToString);
end;



procedure TestTValidEmail.IsValid;
var
  AValue: TValue;
begin
  AValue := 'eurides@sysmo.com.br';
  CheckTrue(FValidEmail.IsValid(AValue), 'Email inv�lido: ' + AValue.ToString);
end;

initialization

// Register any test cases with the test runner
RegisterTest(TestTValidEmail.Suite);

end.
