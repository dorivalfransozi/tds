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
  end;



implementation

{$R *.dfm}


procedure TConsultaFormView.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

end.



