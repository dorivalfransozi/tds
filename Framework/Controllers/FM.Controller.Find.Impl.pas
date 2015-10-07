unit FM.Controller.Find.Impl;

interface

uses
  FM.Controller.Base.Impl, FM.Controller.Find;

type

  TFindController = class(TControllerBase, IFindController)
  public
    procedure Config; virtual; abstract;
  end;



implementation

end.
