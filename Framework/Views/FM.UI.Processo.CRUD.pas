{
Descrição: Padrão Visual do Sysmo S1 - Processo CRUD
}

unit FM.UI.Processo.CRUD;

interface

uses
  SysUtils, Vcl.Forms, Vcl.StdCtrls, Vcl.Buttons, Classes, Vcl.Controls, Vcl.ExtCtrls,
  FM.UI.Consulta;

type
  TFormProcessoCRUD = class(TFormConsulta)
    BtnIniciar: TBitBtn;
    BtnAgendar: TBitBtn;
    BtnRelatorio: TBitBtn;
    BtnExcluir: TBitBtn;
    procedure BtnIniciarClick(Sender: TObject);
    procedure BtnAgendarClick(Sender: TObject);
    procedure BtnRelatorioClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
  end;



implementation

{$R *.dfm}



procedure TFormProcessoCRUD.BtnAgendarClick(Sender: TObject);
begin
//  oControlador.Agendar;
end;



procedure TFormProcessoCRUD.BtnExcluirClick(Sender: TObject);
begin
//  oControlador.Excluir;
end;



procedure TFormProcessoCRUD.BtnIniciarClick(Sender: TObject);
begin
//  oControlador.Executar;
end;



procedure TFormProcessoCRUD.BtnRelatorioClick(Sender: TObject);
begin
//  oControlador.ImprimirRelatorio;
end;



{
Versão do projeto: 2.17.12
  Versão: 1.00
  Desenvolvedor: Fhelipe Carvalho
  Data: 02/05/2014
  Tarefa: 12337
  Descrição: Classe base para criação de formulários.
}



end.

