unit DDC.Validator.ResourceStrings;

interface

type
  TResourceStringsValidator = class
  public
    const
    RSValidator_ModelIsNil = 'O modelo n�o instanciado.';
    RSValidator_AttrNotFound = 'A valida��o n�o pode ser aplicada ao modelo "%s". '+#13#10+'O atributo "%s" n�o foi encontrado no modelo indicado.';
    RSValidation_Required = 'O campo %s � requerido.';
    RSValidation_IsNatural = 'O campo %s deve conter somente n�meros positivos.';
    RSValidation_IsInteger = 'O campo %s deve conter um n�mero inteiro.';
    RSValidation_IsNaturalNoZero = 'O campo %s deve conter um n�mero positivo diferente de zero.';
    RSValidation_ExactLength = 'O campo %s deve ter exatamente %s caracteres.';
    RSValidation_MaxValue = 'O campo %s deve conter um n�mero menor que %s.';
    RSValidation_MinValue = 'O campo %s deve conter um n�mero maior que %s.';
    RSValidation_MaxLength = 'O campo %s deve ter no m�ximo %s caracteres.';
    RSValidation_MinLength = 'O campo %s deve ter no m�nimo %s caracteres.';
    RSValidation_RegexValidate = 'O formato do valor para o campo %s � inv�lido.';
    RSValidation_ValidEmail = 'O campo %s deve conter um email v�lido.';
  end;

implementation

end.
