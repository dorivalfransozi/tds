unit FM.Model.Base;

interface

uses
  M1.Exceptions, M1.ResourceStrings;

type
  ExceptionValidationWarning = M1.Exceptions.ExceptionValidationWarning;
  ExceptionValidationError = M1.Exceptions.ExceptionValidationError;
  ExceptionValidationInfo = M1.Exceptions.ExceptionValidationInfo;
  TResourceStrings = M1.ResourceStrings.TResourceStrings;

  TModelBase = class
  public
    function New: TModelBase; virtual; abstract;
    procedure Clear;
  end;

implementation

{ TModelBase }



procedure TModelBase.Clear;
begin
  { TODO -oDorival -cRTTI : Limpar atributos do metodo }
end;

end.
