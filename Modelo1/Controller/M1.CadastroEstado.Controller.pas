unit M1.CadastroEstado.Controller;

interface

uses
  M1.Estado.Model,
  FM.Controller.CRUD.Impl,
  FM.DAO.Base,
  Classes, FM.Model.Base;

type
  TCadastroEstadoController = class(TCRUDController) // , ICRUDController, IFindController)
  private
    FDAO: IDAO<TEstadoModel>;
    FModel: TEstadoModel;
  public
    constructor Create; override;
    destructor Destroy; override;

    procedure FindCadastroDemo(const Name: string);
    procedure ListCadastroDemo;

    function GetModel: TModelBase; override;
    function Validate(const AAttribute: string = ''): Boolean; override;

    procedure New; override;
    procedure Edit; override;
    procedure Save; override;
    procedure Delete; override;

    procedure Config; override;

    property Model: TModelBase read GetModel;
  end;

implementation

uses
  M1.Estado.DAO, SysUtils, DDC.Validator.Impl, DDC.Validator, M1.Exceptions,
  RTTI, DDC.ValidationInfo;

{ TCadastroEstadoController }



procedure TCadastroEstadoController.Config;
begin
  inherited;

end;



constructor TCadastroEstadoController.Create;
begin
  inherited;
  { DONE : modelo tornar uma interface... revisar os casts q foram necessarios.tornar a interface do tipo de uma classe }
  {não vi algo que torne viável a criação da interface a não ser o fato de dar free}
  FModel := TEstadoModel.Create;
  FDAO   := TDAOEstado.Create;
end;



procedure TCadastroEstadoController.Delete;
begin
  inherited;

end;



destructor TCadastroEstadoController.Destroy;
begin
  { DONE : modelo tornar uma interface... revisar os casts q foram necessarios.tornar a interface do tipo de uma classe }
  FModel.Free;
  inherited;
end;



procedure TCadastroEstadoController.Edit;
begin
  inherited;

end;



procedure TCadastroEstadoController.FindCadastroDemo(const Name: string);
begin

end;



function TCadastroEstadoController.GetModel: TModelBase;
begin
  Result := FModel;
end;



procedure TCadastroEstadoController.ListCadastroDemo;
begin

end;



procedure TCadastroEstadoController.New;
begin
  inherited;

end;



procedure TCadastroEstadoController.Save;
begin
  inherited;
  if Validate then
    FDAO.Save(FModel);

end;



function TCadastroEstadoController.Validate(const AAttribute: string): Boolean;
begin
  Result := inherited Validate(AAttribute);
end;

end.
