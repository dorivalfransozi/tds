{
  Descri��o: Padr�o Visual do Sysmo S1 - Processo
}

unit FM.UI.Processo;

interface

uses
  SysUtils, Vcl.Forms, Vcl.StdCtrls, Vcl.Buttons, Classes, Vcl.Controls, Vcl.ExtCtrls, FM.UI.Consulta;

type
  TProcessoFormView = class(TConsultaFormView)
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




procedure TProcessoFormView.BtnAgendarClick(Sender: TObject);
begin
//  oControlador.Agendar;
end;



procedure TProcessoFormView.BtnEfetivarClick(Sender: TObject);
begin
//  oControlador.Efetivar;
end;



procedure TProcessoFormView.BtnImportarClick(Sender: TObject);
begin
//  oControlador.Importar;
end;



procedure TProcessoFormView.BtnOkClick(Sender: TObject);
begin
//  oControlador.Executar;
end;



procedure TProcessoFormView.BtnRelatorioClick(Sender: TObject);
begin
//  oControlador.ImprimirRelatorio;
end;

{
  Vers�o do projeto: 2.17.08
  Vers�o: 1.00
  Desenvolvedor: Eliane Balbinotti
  Data: 03/10/2012 15:40
  Tarefa:
  Descri��o: Classe base para cria��o de formul�rios.
}

end.
