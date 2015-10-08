unit FM.Model.Base;

interface

uses
  M1.Exceptions, M1.ResourceStrings;

type
  ExceptionValidation = M1.Exceptions.ExceptionValidation;
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
