unit FM.Controller.CRUD;

interface

uses
  FM.Controller.Base;

type
  ICRUDController = interface(IControllerBase)
  ['{B257A883-E451-4B4F-A68D-32BECBA5084A}']
    procedure New;
    procedure Edit;
    procedure Save;
    procedure Delete;
  end;

implementation

end.
