{
Descrição: Padrão Visual do Sysmo S1 - Cadastro
}

unit FM.UI.Cadastro;

interface

uses
  Vcl.Forms, Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, Classes, Vcl.ExtCtrls, FM.UI.Consulta;

type
  TFormCadastro = class(TFormConsulta)
    BtnSalvar: TBitBtn;
    BtnExcluir: TBitBtn;
    BtnRelatorio: TBitBtn;
    BtnEfetivar: TBitBtn;
    BtnEditar: TBitBtn;
  public
    procedure BtnSalvarClick(Sender: TObject); virtual; abstract;
    procedure BtnExcluirClick(Sender: TObject); virtual; abstract;
    procedure BtnRelatorioClick(Sender: TObject); virtual; abstract;
    procedure BtnEfetivarClick(Sender: TObject); virtual; abstract;
    procedure BtnEditarClick(Sender: TObject); virtual; abstract;
  end;

implementation


{$R *.dfm}

end.

