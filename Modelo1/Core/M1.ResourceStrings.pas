unit M1.ResourceStrings;

interface

type

  TResourceStrings = class
  public
    const
    RSConteudoInvalido = 'Conteúdo inválido.';
    RSClasseNaoImplementaMetodo = 'A classe %s não implementa o método %s.';
    RSObjetoNil = 'Objeto não instanciado.';
    RSValidation_Required = 'O campo %s é requerido.';
    RSValidation_IsNatural = 'O campo %s deve conter somente números positivos.';
    RSValidation_IsInteger = 'O campo %s deve conter um número inteiro.';
    RSValidation_IsNaturalNoZero = 'O campo %s deve conter um número positivo diferente de zero.';
    RSValidation_ExactLength = 'O campo %s deve ter exatamente %s caracteres.';
    RSValidation_MaxValue = 'O campo %s deve conter um número menor que %s.';
    RSValidation_MinValue = 'O campo %s deve conter um número maior que %s.';
    RSValidation_MaxLength = 'O campo %s deve ter no máximo %s caracteres.';
    RSValidation_MinLength = 'O campo %s deve ter no mínimo %s caracteres.';

  end;

implementation


end.
