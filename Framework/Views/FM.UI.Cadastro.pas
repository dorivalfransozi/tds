{
Descrição: Padrão Visual do Sysmo S1 - Cadastro
}

unit FM.UI.Cadastro;

interface

uses
  Vcl.Forms, Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, Classes, Vcl.ExtCtrls, FM.UI.Consulta,
  FM.Controller.CRUD;

type
  TFormCadastro = class(TFormConsulta)
    BtnSalvar: TBitBtn;
    BtnExcluir: TBitBtn;
    BtnRelatorio: TBitBtn;
    BtnEfetivar: TBitBtn;
    BtnEditar: TBitBtn;
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnConfigurarClick(Sender: TObject);
  public
    function GetCRUDController: ICRUDController;
  end;

implementation


{$R *.dfm}

{ TFormCadastro }

procedure TFormCadastro.BtnConfigurarClick(Sender: TObject);
begin
  inherited;
  GetCRUDController.Delete;
end;

procedure TFormCadastro.BtnExcluirClick(Sender: TObject);
begin
  inherited;
  GetCRUDController.Delete;
end;

procedure TFormCadastro.BtnSalvarClick(Sender: TObject);
begin
  inherited;
  GetCRUDController.Save;
end;

function TFormCadastro.GetCRUDController: ICRUDController;
begin
  result := Controller as ICRUDController;
end;

end.

