unit FM.Controller.Base.Impl;

interface

uses
  FM.Model.Base, FM.Controller.Base;

type
  TControllerBase = class(TInterfacedObject, IControllerBase)
  protected
    function DoInternalValidate: boolean;
  public
    constructor Create; virtual; abstract;
    function Validate: Boolean; virtual; abstract;
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
    begin
      TValidationInfo.New(Model, 'E.PropertyName', False, E.Message);
    end;
  end;
end;

end.
