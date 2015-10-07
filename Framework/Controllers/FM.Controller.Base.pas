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

  IReadOnlyController = interface
    procedure Config;
  end;

  ICRUDController = interface
    procedure New;
    procedure Edit;
    procedure Save;
  end;

  IProccessController = interface
    procedure Execute;
  end;

  TControllerBase = class(TInterfacedObject, IControllerBase)
  public
    constructor Create; virtual;

    function Validate: Boolean; virtual;

    function GetModel: TModelBase; virtual;

    property Model: TModelBase read GetModel;
  end;

  TControllerBaseClass = class of TControllerBase;

  TCRUDController = class(TControllerBase, IReadOnlyController, ICRUDController)
  public
    procedure New; virtual; abstract;
    procedure Edit; virtual; abstract;
    procedure Save; virtual; abstract;

    procedure Config; virtual; abstract;
  end;

  TReadOnlyController = class(TControllerBase, IReadOnlyController)
  public
    procedure Config; virtual; abstract;
  end;

  TProccessController = class(TControllerBase)
  public

  end;

implementation

{ TControllerBase }

constructor TControllerBase.Create;
begin

end;

function TControllerBase.GetModel: TModelBase;
begin

end;

function TControllerBase.Validate: Boolean;
begin

end;

end.
