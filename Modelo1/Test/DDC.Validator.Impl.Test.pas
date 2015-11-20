unit DDC.Validator.Impl.Test;
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
  System.Generics.Collections,
  DDC.Validate.MinLength,
  DDC.Validate,
  DDC.Validator.Extend,
  DDC.Validator.Impl,
  DDC.Validator,
  FM.Model.Base,
  System.StrUtils,
  System.Classes,
  System.Rtti,
  Delphi.Mocks;

type
  TModelMock = class(TModelBase)
  private
    FMaxLength: String;
    FMinValue: Integer;
    FIsNaturalNoZero: Integer;
    FIsNatural: Integer;
    FMinLength: String;
    FExactLength: String;
    FValidMail: String;
    FRequired: string;
    FMaxValue: Integer;
    FIsInteger: Integer;
    FRegexValidate: string;
  public
    [TColumnTitle('IsInteger'), TIsInteger]
    property IsInteger: Integer read FIsInteger write FIsInteger;

    [TColumnTitle('IsNatural'), TIsNatural]
    property IsNatural: Integer read FIsNatural write FIsNatural;

    [TColumnTitle('IsNaturalNoZero'), TIsNaturalNoZero]
    property IsNaturalNoZero: Integer read FIsNaturalNoZero write FIsNaturalNoZero;

    [TColumnTitle('MaxValue'), TMaxValue(1)]
    property MaxValue: Integer read FMaxValue write FMaxValue;

    [TColumnTitle('MinValue'), TMinValue(1)]
    property MinValue: Integer read FMinValue write FMinValue;

    [TColumnTitle('MinLength'), TMinLength(2)]
    property MinLength: String read FMinLength write FMinLength;

    [TColumnTitle('MaxLength'), TMaxLength(3)]
    property MaxLength: String read FMaxLength write FMaxLength;

    [TColumnTitle('ExactLength'), TExactLength(2)]
    property ExactLength: String read FExactLength write FExactLength;

    [TColumnTitle('ValidEmail'), TValidEmail]
    property ValidMail: String read FValidMail write FValidMail;

    [TColumnTitle('RegexValidate'), TRegexValidate('[A-Z]')]
    property RegexValidate: string read FRegexValidate write FRegexValidate;

    [TColumnTitle('Required'), TRequired]
    property Required: string read FRequired write FRequired;
  end;

type
  // Test methods for class TValidator
  TestTValidator = class(TTestCase)
  public
    const
    PROP_NAME: String = 'RegexValidate';
  strict private
    FModel: TModelMock;
    FValidator: IValidator<TModelMock>;
  private
    procedure SetValueTrue;
    procedure SetValueFalse;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure AttributeNotFound;
    procedure AttributeValid;
    procedure AttributeNotValid;
    procedure ModelValid;
    procedure ModelNotValid;
    procedure ModelIsNil;
    procedure ErrorMessagesNotValid;
    procedure ErrorMessagesValid;
    procedure TestAddExtendValidateModel;
    procedure TestAddExtendValidateAttribute;
    procedure TestAddExtendValidateAttributeNotFound;
  end;

implementation

uses
  System.SysUtils, DDC.Validator.ResourceStrings;



procedure TestTValidator.SetUp;
begin
  FModel     := TModelMock.Create;
  FValidator := TValidator<TModelMock>.Create;
end;



procedure TestTValidator.SetValueFalse;
begin
  (FModel as TModelMock).IsInteger       := 0;
  (FModel as TModelMock).IsNatural       := -1;
  (FModel as TModelMock).IsNaturalNoZero := 0;
  (FModel as TModelMock).MaxValue        := 11;
  (FModel as TModelMock).MinValue        := 0;
  (FModel as TModelMock).MaxLength       := '1111';
  (FModel as TModelMock).MinLength       := '1';
  (FModel as TModelMock).ExactLength     := '1';
  (FModel as TModelMock).ValidMail       := 'eurides.sysmo.com.br';
  (FModel as TModelMock).RegexValidate   := 'abc';
  (FModel as TModelMock).Required        := '';
end;



procedure TestTValidator.SetValueTrue;
begin
  (FModel as TModelMock).IsInteger       := 1;
  (FModel as TModelMock).IsNatural       := 1;
  (FModel as TModelMock).IsNaturalNoZero := 1;
  (FModel as TModelMock).MaxValue        := 1;
  (FModel as TModelMock).MinValue        := 1;
  (FModel as TModelMock).MaxLength       := '11';
  (FModel as TModelMock).MinLength       := '11';
  (FModel as TModelMock).ExactLength     := '11';
  (FModel as TModelMock).ValidMail       := 'eurides@sysmo.com.br';
  (FModel as TModelMock).RegexValidate   := 'ABC';
  (FModel as TModelMock).Required        := '1';
end;



procedure TestTValidator.TearDown;
begin
  FModel.Free;
  FModel := nil;
end;



procedure TestTValidator.ModelValid;
begin
  SetValueTrue;
  CheckFalse(FValidator.MakeAll(FModel).Fails, 'Erro ao validar modelo');
end;



procedure TestTValidator.ErrorMessagesValid;
begin
  SetValueTrue;
  FValidator.MakeAll(FModel);
  CheckTrue(FValidator.ErrorMessages.Count = 0, 'Erro ao validar modelo');
end;



procedure TestTValidator.ModelIsNil;
begin
  StartExpectingException(Exception);
  FValidator.MakeAll(nil);
  StopExpectingException('Erro ao validar modelo');
end;



procedure TestTValidator.ModelNotValid;
begin
  SetValueFalse;
  CheckTrue(FValidator.MakeAll(FModel).Fails, 'Erro ao validar modelo');
end;



procedure TestTValidator.AttributeNotFound;
begin
  SetValueTrue;
  FValidator.MakeAttribute(FModel, PROP_NAME + '_1');
  CheckEqualsString(StringReplace(StringReplace(FValidator.ErrorMessages.Text, #10, EmptyStr, [rfReplaceAll]), #13,
    EmptyStr, [rfReplaceAll]), StringReplace(StringReplace(Format(TResourceStringsValidator.RSValidator_AttrNotFound,
    [FModel.ClassName, PROP_NAME + '_1']), #10, EmptyStr, [rfReplaceAll]), #13, EmptyStr, [rfReplaceAll]));
end;



procedure TestTValidator.AttributeNotValid;
begin
  SetValueFalse;
  CheckTrue(FValidator.MakeAttribute(FModel, PROP_NAME).Fails, 'Erro ao validar modelo');
end;



procedure TestTValidator.AttributeValid;
begin
  SetValueTrue;
  CheckFalse(FValidator.MakeAttribute(FModel, PROP_NAME).Fails, 'Erro ao validar modelo');
end;



procedure TestTValidator.ErrorMessagesNotValid;
begin
  SetValueFalse;
  FValidator.MakeAll(FModel);
  CheckTrue(FValidator.ErrorMessages.Count = 10, 'Erro ao validar modelo');
end;



procedure TestTValidator.TestAddExtendValidateAttribute;
begin
  SetValueTrue;
  FValidator.AddExtend(PROP_NAME, 1, 'Extend true',
    function(const AValue: TValue): Boolean
    begin
      result := True;
    end
    );

  FValidator.MakeAttribute(FModel, PROP_NAME);
  CheckTrue(FValidator.ErrorMessages.Count = 0, 'Erro ao validar extend');
end;



procedure TestTValidator.TestAddExtendValidateAttributeNotFound;
begin
  SetValueTrue;
  FValidator.AddExtend(PROP_NAME + '_1', 1, 'Extend true',
    function(const AValue: TValue): Boolean
    begin
      result := True;
    end
    );

  FValidator.MakeAttribute(FModel, PROP_NAME + '_1');
  CheckTrue(FValidator.ErrorMessages.Count = 1, 'Erro ao validar extend');
end;



procedure TestTValidator.TestAddExtendValidateModel;
begin
  SetValueTrue;
  FValidator.AddExtend(EmptyStr, 1, 'Teste extend: valor informado %s  � igual a 1.',
    function(const AValue: TValue): Boolean
    begin
      result := AValue.AsInteger <> 1;
    end
    );

  FValidator.MakeAll(FModel);
  CheckTrue(FValidator.ErrorMessages.Count = 1, 'Erro ao validar extend');
end;


initialization

// Register any test cases with the test runner
RegisterTest(TestTValidator.Suite);

end.
