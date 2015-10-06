{
Descrição: Padrão Visual do Sysmo S1 - Consulta
}

unit FM.UI.Consulta;

interface

uses
  SysUtils, Vcl.Forms, Vcl.StdCtrls, Vcl.Buttons, Classes, Vcl.Controls, Vcl.ExtCtrls,
  FM.UI.BaseForm;

type
  TConsultaFormView = class(TBaseFormView)
    PnlArea: TPanel;
    PnlBotao: TPanel;
    BtnFechar: TBitBtn;
    BtnConfigurar: TBitBtn;
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnConfigurarClick(Sender: TObject);
  end;



implementation

{$R *.dfm}

procedure TConsultaFormView.BtnFecharClick(Sender: TObject);
begin
  oControlador.Fechar;
end;



procedure TConsultaFormView.BtnConfigurarClick(Sender: TObject);
begin
  oControlador.Configurar;
end;



{
Versão do projeto: 2.17.08
  Versão: 1.00
  Desenvolvedor: Eliane Balbinotti
  Data: 03/10/2012 15:40
  Tarefa: 7767
  Descrição: Classe base para criação de formulários.
}



end.



