unit FM.Controller.CRUD.Impl;

interface

uses
  FM.Controller.Base.Impl, FM.Controller.CRUD, FM.Controller.Find, FM.DAO.Base,
  M1.Marca.Model;

type
  TCRUDController = class(TControllerBase, ICRUDController, IFindController)
  public
    procedure New; virtual; abstract;
    procedure Edit; virtual; abstract;
    procedure Save; virtual; abstract;
    procedure Delete; virtual; abstract;

    procedure Config; virtual; abstract;
  end;

implementation

end.
