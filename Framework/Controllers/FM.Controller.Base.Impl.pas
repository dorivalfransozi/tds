unit FM.Controller.Base.Impl;

interface

uses
  FM.Model.Base, FM.Controller.Base, DDC.ViewMessages, Winapi.Windows;

type
  TControllerBase = class(TInterfacedObject, IControllerBase)
  protected
    function DoInternalValidate(const AAttribute: string = ''): boolean;
    function GetModel: TModelBase; virtual; abstract;
  public
    constructor Create; virtual; abstract;
    function Validate(const AAttribute: string = ''): boolean; virtual; abstract;

    property Model: TModelBase read GetModel;
  end;

  TControllerBaseClass = class of TControllerBase;

implementation

uses
  DDC.ValidationInfo;

{ TControllerBase }



function TControllerBase.DoInternalValidate(const AAttribute: string = ''): boolean;
begin
  Result := False;
  try
    Result := Validate;
  except
    on E: ExceptionValidationInfo do
      TValidationInfo.New(Model, 'E.PropertyName', False, E.Message, MB_ICONEXCLAMATION);
    on E: ExceptionValidationError do
      TValidationInfo.New(Model, 'E.PropertyName', False, E.Message, MB_ICONERROR);
  end;
end;

end.
