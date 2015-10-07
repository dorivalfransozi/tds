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

    function Validate: Boolean; override;

    procedure New; override;
    procedure Edit; override;
    procedure Save; override;
  public
    property Model: TModelBase read GetModel;
  end;

implementation

uses
  System.SysUtils;

{ TCadastroMarcaController }



constructor TCadastroMarcaController.Create;
begin
  inherited;

  FModel := TMarcaModel.Create;
end;



destructor TCadastroMarcaController.Destroy;
begin
  if (FModel <> nil) then
    FreeAndNil(FModel);

  inherited;
end;



function TCadastroMarcaController.GetModel: TModelBase;
begin
  Result := FModel as TModelBase;
end;



procedure TCadastroMarcaController.Edit;
begin
  inherited;

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
