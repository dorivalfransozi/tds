unit FM.Controller.Base;

interface

uses
  FM.Model.Base;

type

  IControllerBase = interface
  ['{E92762E7-1465-48FA-B7A8-7E33B1708FD0}']
    function Validate(const AAttribute: string = ''): Boolean;

    function GetModel: TModelBase;
    property Model: TModelBase read GetModel;
  end;


implementation

end.
