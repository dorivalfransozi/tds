{
  Descrição: Padrão Visual do Sysmo S1 - Formulário Interno
}

unit FM.UI.FormularioInterno;

interface

uses
  SysUtils, Vcl.Forms, Vcl.StdCtrls, Vcl.Buttons, Classes, Vcl.Controls, Vcl.ExtCtrls,
  FM.UI.BaseForm;

type
  TFormFormularioInterno = class(TBaseFormView)
    PnlArea: TPanel;
  public
    constructor Create(AOwner: TComponent; AComponentePai: TWinControl); reintroduce;
  end;

implementation

{$R *.dfm}

{ TFormularioInternoFormView }



constructor TFormFormularioInterno.Create(AOwner: TComponent;
  AComponentePai: TWinControl);
begin
  inherited Create(AOwner);
  Constraints.MaxHeight := 0;
  Constraints.MaxWidth  := 0;
  Constraints.MinHeight := 0;
  Constraints.MinWidth  := 0;
  Self.Top              := 0;
  Self.Left             := 0;
  Self.Height           := AComponentePai.Height;
  Self.Width            := AComponentePai.Width;
  Self.Parent           := AComponentePai;
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
