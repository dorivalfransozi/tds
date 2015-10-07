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
  end;


implementation

end.
