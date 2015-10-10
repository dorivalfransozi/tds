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
  DDC.Validate.ExactLength.Test in 'DDC.Validate.ExactLength.Test.pas',
  M1.ResourceStrings in '..\Core\M1.ResourceStrings.pas',
  DDC.Validate in '..\..\Framework\Libs\DDC.Validate.pas',
  DDC.Validate.CustomAttribute in '..\..\Framework\Libs\DDC.Validate.CustomAttribute.pas',
  DDC.Validate.ExactLength in '..\..\Framework\Libs\DDC.Validate.ExactLength.pas';

{R *.RES}

begin
  DUnitTestRunner.RunRegisteredTests;
end.

