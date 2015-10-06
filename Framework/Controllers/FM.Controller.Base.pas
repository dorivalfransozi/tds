unit FM.Controller.Base;

interface

uses
  FM.Model.Base;

type
  TControllerBase = class
  protected
    function GetModel: TModelBase; virtual; abstract;
  public
    property Model: TModelBase read GetModel;
  end;

  TCRUDController = class(TControllerBase)
  public
    function Validate: Boolean; virtual; abstract;

    procedure New; virtual; abstract;
    procedure Edit; virtual; abstract;
    procedure Save; virtual; abstract;
  end;

  TReadOnlyController = class(TControllerBase)
  public

  end;

  TProccessController = class(TControllerBase)
  public

  end;

implementation

{ TControllerBase }


end.
