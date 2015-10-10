unit FM.Controller.Base.Impl;

interface

uses
  FM.Model.Base, FM.Controller.Base, DDC.ViewMessages, Winapi.Windows;

type
  TControllerBase = class(TInterfacedObject, IControllerBase)
  protected
    function DoInternalValidate: boolean;
    function GetModel: TModelBase; virtual; abstract;
  public
    constructor Create; virtual; abstract;
    function Validate: boolean; virtual; abstract;

    property Model: TModelBase read GetModel;
  end;

  TControllerBaseClass = class of TControllerBase;

implementation

uses
  DDC.ValidationInfo;

{ TControllerBase }



function TControllerBase.DoInternalValidate: boolean;
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
