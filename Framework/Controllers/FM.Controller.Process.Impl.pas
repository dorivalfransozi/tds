unit FM.Controller.Process.Impl;

interface

uses
  FM.Controller.Base.Impl, FM.Controller.Process;

type

  TProcessController = class(TControllerBase, IProcessController)
  public
    procedure Execute; virtual; abstract;
  end;


implementation

end.
