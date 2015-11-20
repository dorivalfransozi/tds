unit FM.Model.Base;

interface

uses
  M1.Exceptions, M1.ResourceStrings, DDC.Validator;

type
  ExceptionValidationWarning = M1.Exceptions.ExceptionValidationWarning;
  ExceptionValidationError = M1.Exceptions.ExceptionValidationError;
  ExceptionValidationInfo = M1.Exceptions.ExceptionValidationInfo;
  TResourceStrings = M1.ResourceStrings.TResourceStrings;

  TModelBase = class
  private
    FValidator: IValidator<TModelBase>;
  public
    property Validator: IValidator<TModelBase> read FValidator;

    constructor Create; reintroduce; virtual;
    function IsValid(const AAttribute: String): Boolean; virtual;
    procedure Clear; virtual;
  end;

implementation

uses
  DDC.Validator.Impl,
  System.SysUtils,
  Helper.HRTTI;

{ TModelBase }



procedure TModelBase.Clear;
begin
  { DONE -oDorival -cRTTI : Limpar atributos do metodo }
  THelperRTTI.ClearProperties(Self);
end;



constructor TModelBase.Create;
begin
  FValidator := TValidator<TModelBase>.Create;
end;



function TModelBase.IsValid(const AAttribute: String): Boolean;
begin
  if (AAttribute <> EmptyStr) then
    result := not FValidator.MakeAttribute(Self, AAttribute).Fails
  else
    result := not FValidator.MakeAll(Self).Fails;

  if not(result) then
    raise ExceptionValidationInfo.Create(FValidator.ErrorMessages.Text);
end;

end.
