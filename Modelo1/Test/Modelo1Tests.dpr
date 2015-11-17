program Modelo1Tests;
{

  Delphi DUnit Test Project
  -------------------------
  This project contains the DUnit test framework and the GUI/Console test runners.
  Add "CONSOLE_TESTRUNNER" to the conditional defines entry in the project options
  to use the console test runner.  Otherwise the GUI test runner will be used by
  default.

}

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}


uses
  DUnitTestRunner,
  FM.Model.Base in '..\..\Framework\Models\FM.Model.Base.pas',
  M1.Exceptions in '..\Core\M1.Exceptions.pas',
  M1.ResourceStrings in '..\Core\M1.ResourceStrings.pas',
  DDC.Validator.ResourceStrings in '..\..\Framework\Resource\DDC.Validator.ResourceStrings.pas',
  DDC.Validate in '..\..\Framework\Libs\DDC.Validate.pas',
  DDC.Validator in '..\..\Framework\Libs\DDC.Validator.pas',
  DDC.Validate.CustomAttribute in '..\..\Framework\Libs\DDC.Validate.CustomAttribute.pas',
  DDC.Validator.Extend in '..\..\Framework\Libs\DDC.Validator.Extend.pas',

  DDC.Validate.ExactLength.Test in 'DDC.Validate.ExactLength.Test.pas',
  DDC.Validate.ExactLength in '..\..\Framework\Libs\DDC.Validate.ExactLength.pas',
  DDC.Validate.IsInteger.Test in 'DDC.Validate.IsInteger.Test.pas',
  DDC.Validate.IsInteger in '..\..\Framework\Libs\DDC.Validate.IsInteger.pas',
  DDC.Validate.IsNatural.Test in 'DDC.Validate.IsNatural.Test.pas',
  DDC.Validate.IsNatural in '..\..\Framework\Libs\DDC.Validate.IsNatural.pas',
  DDC.Validate.IsNaturalNoZero.Test in 'DDC.Validate.IsNaturalNoZero.Test.pas',
  DDC.Validate.IsNaturalNoZero in '..\..\Framework\Libs\DDC.Validate.IsNaturalNoZero.pas',
  DDC.Validate.MaxLength.Test in 'DDC.Validate.MaxLength.Test.pas',
  DDC.Validate.MaxLength in '..\..\Framework\Libs\DDC.Validate.MaxLength.pas',
  DDC.Validate.MaxValue.Test in 'DDC.Validate.MaxValue.Test.pas',
  DDC.Validate.MaxValue in '..\..\Framework\Libs\DDC.Validate.MaxValue.pas',
  DDC.Validate.MinLength.Test in 'DDC.Validate.MinLength.Test.pas',
  DDC.Validate.MinLength in '..\..\Framework\Libs\DDC.Validate.MinLength.pas',
  DDC.Validate.MinValue.Test in 'DDC.Validate.MinValue.Test.pas',
  DDC.Validate.MinValue in '..\..\Framework\Libs\DDC.Validate.MinValue.pas',
  DDC.Validate.Regex.Test in 'DDC.Validate.Regex.Test.pas',
  DDC.Validate.Regex in '..\..\Framework\Libs\DDC.Validate.Regex.pas',
  DDC.Validate.Required.Test in 'DDC.Validate.Required.Test.pas',
  DDC.Validate.Required in '..\..\Framework\Libs\DDC.Validate.Required.pas',
  DDC.Validate.ValidEmail.Test in 'DDC.Validate.ValidEmail.Test.pas',
  DDC.Validate.ValidEmail in '..\..\Framework\Libs\DDC.Validate.ValidEmail.pas',
  DDC.Validator.Impl.Test in 'DDC.Validator.Impl.Test.pas',
  DDC.Validator.Impl in '..\..\Framework\Libs\DDC.Validator.Impl.pas';

{ R *.RES }



begin
  DUnitTestRunner.RunRegisteredTests;

end.
