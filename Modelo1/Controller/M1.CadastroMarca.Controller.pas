unit M1.CadastroMarca.Controller;

interface

uses
  M1.Marca.Model,
  FM.Controller.CRUD.Impl,
  FM.DAO.Base,
  Classes, FM.Model.Base;

type
  TCadastroMarcaController = class(TCRUDController) // , ICRUDController, IFindController)
  private
    FModel: TMarcaModel;
    FDAO: IDAO<TMarcaModel>;
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
  public
    property Model: TModelBase read GetModel;
  end;

implementation

uses
  M1.Marca.DAO,
  SysUtils,
  System.TypInfo,
  M1.Exceptions,
  DDC.ValidationInfo,
  System.Rtti,
  DDC.Validator.Impl,
  DDC.Validator;

{ TCadastroMarcaController }



procedure TCadastroMarcaController.Config;
begin

end;



constructor TCadastroMarcaController.Create;
begin
  inherited;
  FModel := TMarcaModel.Create;
  FDAO   := TDAOMarca.Create;
  { TODO -oDorival -cDI : Remover dependencia e colocar injeção de dependencia }
end;



procedure TCadastroMarcaController.Delete;
begin

end;



destructor TCadastroMarcaController.Destroy;
begin
  FModel.Free;
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
  result := FModel;
end;



procedure TCadastroMarcaController.ListCadastroDemo;
begin

end;



procedure TCadastroMarcaController.New;
begin
  inherited;
  { DONE -oDev -cRever : Mesma coisa que o save }
end;



procedure TCadastroMarcaController.Save;
begin
  inherited;
  { DONE -oDev -cRever : Acho que aqui poderiamos jogar essas chamadas para o controller CRUD,
    mas pra isso temos que levar o FDao e FModel para o base.
    Comentado em fazer com que o controller tb receba um modelo (semelhante ao dao).
  }

  {não encontrei uma forma viável de jogar esses códigos para uma classe base}
  if Validate then
    FDAO.Save(FModel);
end;



function TCadastroMarcaController.Validate(const AAttribute: string = ''): Boolean;
begin
  { DONEDO -oDev -cRever : Ter um overload? ou esse if abaixo para testar se a validação é todal? }
  result := inherited Validate(AAttribute);
end;

end.
