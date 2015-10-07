{
Descrição: Padrão Visual do Sysmo S1 - Configuração
}

unit FM.UI.Configuracao;

interface

uses
  FM.UI.Consulta, Vcl.StdCtrls, Vcl.Buttons, System.Classes,
  Vcl.Controls, Vcl.ExtCtrls;

type
  TConfiguracaoFormView = class(TConsultaFormView)
    BtnOk: TBitBtn;
    BtnPadrao: TBitBtn;
    procedure BtnOkClick(Sender: TObject);
    procedure BtnPadraoClick(Sender: TObject);
  end;



implementation


{$R *.dfm}



procedure TConfiguracaoFormView.BtnOkClick(Sender: TObject);
begin
//  oControlador.Executar;
end;



procedure TConfiguracaoFormView.BtnPadraoClick(Sender: TObject);
begin
//  oControlador.UtilizarPadrao;
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
