{
  Descrição: Padrão Visual do Sysmo S1 - Processo
}

unit FM.UI.Processo;

interface

uses
  SysUtils, Vcl.Forms, Vcl.StdCtrls, Vcl.Buttons, Classes, Vcl.Controls, Vcl.ExtCtrls, FM.UI.Consulta;

type
  TFormProcesso = class(TFormConsulta)
    BtnOk: TBitBtn;
    BtnAgendar: TBitBtn;
    BtnRelatorio: TBitBtn;
    BtnEfetivar: TBitBtn;
    BtnImportar: TBitBtn;
    procedure BtnOkClick(Sender: TObject);
    procedure BtnAgendarClick(Sender: TObject);
    procedure BtnRelatorioClick(Sender: TObject);
    procedure BtnEfetivarClick(Sender: TObject);
    procedure BtnImportarClick(Sender: TObject);
  end;

implementation

{$R *.dfm}




procedure TFormProcesso.BtnAgendarClick(Sender: TObject);
begin
//  oControlador.Agendar;
end;



procedure TFormProcesso.BtnEfetivarClick(Sender: TObject);
begin
//  oControlador.Efetivar;
end;



procedure TFormProcesso.BtnImportarClick(Sender: TObject);
begin
//  oControlador.Importar;
end;



procedure TFormProcesso.BtnOkClick(Sender: TObject);
begin
//  oControlador.Executar;
end;



procedure TFormProcesso.BtnRelatorioClick(Sender: TObject);
begin
//  oControlador.ImprimirRelatorio;
end;

{
  Versão do projeto: 2.17.08
  Versão: 1.00
  Desenvolvedor: Eliane Balbinotti
  Data: 03/10/2012 15:40
  Tarefa:
  Descrição: Classe base para criação de formulários.
}

end.
