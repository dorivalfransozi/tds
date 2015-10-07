unit FM.Controller.Base;

interface

uses
  FM.Model.Base;

type

  IControllerBase = interface
    function Validate: Boolean;

    function GetModel: TModelBase;
    property Model: TModelBase read GetModel;
  end;


implementation

end.
