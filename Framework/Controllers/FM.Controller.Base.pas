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

  ICRUDController = interface
    procedure New;
    procedure Edit;
    procedure Save;
  end;

  TControllerBase = class(TInterfacedObject, IControllerBase)
    constructor Create; virtual;

    function Validate: Boolean; virtual;

    function GetModel: TModelBase; virtual;
    property Model: TModelBase read GetModel;
  end;

  TControllerBaseClass = class of TControllerBase;

  TCRUDController = class(TControllerBase, ICRUDController)
  public
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
