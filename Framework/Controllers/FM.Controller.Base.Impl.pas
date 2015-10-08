unit FM.Controller.Base.Impl;

interface

uses
  FM.Model.Base, FM.Controller.Base, DDC.ViewMessages, Winapi.Windows;

type
  TControllerBase = class(TInterfacedObject, IControllerBase)
  protected
    function DoInternalValidate: boolean;
  public
    constructor Create; virtual; abstract;
    function Validate: boolean; virtual; abstract;
    function GetModel: TModelBase; virtual; abstract;
    property Model: TModelBase read GetModel;

  end;

  TControllerBaseClass = class of TControllerBase;

implementation

uses
  DDC.ValidationInfo;

{ TControllerBase }



function TControllerBase.DoInternalValidate: boolean;
begin
  try
    result := Validate;
  except
    on E: ExceptionValidation do
      TValidationInfo.New(Model, 'E.PropertyName', False, E.Message, MB_ICONERROR);
    on E: ExceptionValidation do
      TValidationInfo.New(Model, 'E.PropertyName', False, E.Message, MB_ICONEXCLAMATION);

  end;
end;

end.
