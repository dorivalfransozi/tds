unit M1.CadastroMarca.Controller;

interface

uses
 M1.Marca.Model,
 FM.Controller.CRUD.Impl,
 Classes;

type
  TCadastroMarcaController = class(TCRUDController)
  protected
    function GetModel: TModelBase; override;
  private
    FModel: TMarcaModel;
  public
    constructor Create; override;
    destructor Destroy; override;

    procedure FindCadastroDemo(const Name: string);
    procedure ListCadastroDemo;

    function Validate: Boolean; override;

    procedure New; override;
    procedure Edit; override;
    procedure Save; override;
  public
    property Model: TModelBase read GetModel;
  end;


implementation

{ TCadastroMarcaController }

constructor TCadastroMarcaController.Create;
begin
  inherited;

end;

destructor TCadastroMarcaController.Destroy;
begin

  inherited;
end;

procedure TCadastroMarcaController.Edit;
begin
  inherited;

end;

procedure TCadastroMarcaController.FindCadastroDemo(const Name: string);
begin
end;

function TCadastroMarcaController.GetModel: TModelBase;
begin

end;

procedure TCadastroMarcaController.ListCadastroDemo;
begin

end;

procedure TCadastroMarcaController.New;
begin
  inherited;

end;

procedure TCadastroMarcaController.Save;
begin
  inherited;

end;

function TCadastroMarcaController.Validate: Boolean;
begin

end;

end.
