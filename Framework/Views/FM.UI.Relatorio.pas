{
Descri��o: Padr�o Visual do Sysmo S1 - Relat�rio
}

unit FM.UI.Relatorio;

interface

uses
  SysUtils, Vcl.Forms, Vcl.StdCtrls, Vcl.Buttons, Classes, Vcl.Controls, Vcl.ExtCtrls,
  FM.UI.Consulta;

type
  TRelatorioFormView = class(TConsultaFormView)
    BtnOk: TBitBtn;
    BtnAgendar: TBitBtn;
    procedure BtnOkClick(Sender: TObject);
    procedure BtnAgendarClick(Sender: TObject);
  end;



implementation



{$R *.dfm}



procedure TRelatorioFormView.BtnAgendarClick(Sender: TObject);
begin
//  oControlador.Agendar;
end;



procedure TRelatorioFormView.BtnOkClick(Sender: TObject);
begin
//  oControlador.Executar;
end;



{
Vers�o do projeto: 2.17.08
  Vers�o: 1.00
  Desenvolvedor: Eliane Balbinotti
  Data: 03/10/2012 15:40
  Tarefa: 7767
  Descri��o: Classe base para cria��o de formul�rios.
}



end.

