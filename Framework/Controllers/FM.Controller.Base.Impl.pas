unit FM.Controller.Base.Impl;

interface

uses
  FM.Model.Base, FM.Controller.Base;

type
  TControllerBase = class(TInterfacedObject, IControllerBase)
  public
    constructor Create; virtual; abstract;
    function Validate: Boolean; virtual; abstract;
    function GetModel: TModelBase; virtual; abstract;
    property Model: TModelBase read GetModel;
  end;

  TControllerBaseClass = class of TControllerBase;

implementation

end.
