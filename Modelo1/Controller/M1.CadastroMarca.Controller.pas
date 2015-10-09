unit M1.CadastroMarca.Controller;

interface

uses
  M1.Marca.Model,
  FM.Controller.CRUD.Impl,
  FM.DAO.Base,
  Classes;

type
  TCadastroMarcaController = class(TCRUDController) // , ICRUDController, IFindController)
  protected
    function GetModel: TModelBase; override;
  private
    FModel: TMarcaModel;
    FDAO: IDAO;
  public
    constructor Create; override;
    destructor Destroy; override;

    procedure FindCadastroDemo(const Name: string);
    procedure ListCadastroDemo;

    function Validate: Boolean; override;

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
  M1.Exceptions,
  DDC.ValidationInfo,
  System.Rtti,
  DDC.Validator.Impl, DDC.Validator;

{ TCadastroMarcaController }



procedure TCadastroMarcaController.Config;
begin

end;



constructor TCadastroMarcaController.Create;
begin
  inherited;
  FModel := TMarcaModel.Create;
  FDAO   := TDAOMarca.Create; { TODO -oDorival -cDI : Remover dependencia e colocar inje��o de dependencia }
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

end;



procedure TCadastroMarcaController.Save;
begin
  inherited;
  if DoInternalValidate then
    FDAO.Save(TModelBase(FModel));
end;



function TCadastroMarcaController.Validate: Boolean;
var
  oValidator: IValidator<TMarcaModel>;
begin
  {
    TODO: definir se a validacao ficar� aqui ou no modelo. ver TFindMarca
  }

  oValidator := TValidator<TMarcaModel>.Create;
  oValidator.AddExtend(FModel.Codigo, 'Teste extend: valor informado %s  � igual a 2.',
    function(const AValue: TValue): Boolean
    begin
      result := AValue.AsInteger <> 2;
    end
    );

  result := oValidator.Make(FModel).Fails;
  if (result) then
    raise ExceptionValidationInfo.Create(oValidator.ValidationErrors.Text);
end;

end.
