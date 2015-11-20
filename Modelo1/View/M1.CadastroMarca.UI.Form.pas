unit M1.CadastroMarca.UI.Form;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FM.UI.Cadastro, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls
{$IFDEF SYSMO}
    , editnum
{$ENDIF};

type
  TFormCadastroMarca = class(TFormCadastro)
    Edt_Codigo: TLabeledEdit;
    Edt_Descricao: TLabeledEdit;
    Edt_DescricaoReduzida: TLabeledEdit;

    procedure ControlChange(Sender: TObject);
  protected
    function DoUpdateModel: Boolean; override;
  end;

var
  FormCadastroMarca: TFormCadastroMarca;

implementation

uses
  M1.Marca.Model;

{$R *.dfm}




function TFormCadastroMarca.DoUpdateModel: Boolean;
begin
  // removida a exception pq se der erro ao setar o model deve cair no stack
  { DONE : padronizar o nome do componente para que o updatemodel seja automatizado }
  { Padrão foi definido como sendo o profixo delimitado por um underline, após isso deve ser igual ao atributo do modelo }
  (FController.GetModel as TMarcaModel).Codigo            := StrToIntDef(Edt_Codigo.Text, 0);
  (FController.GetModel as TMarcaModel).Descricao         := Edt_Descricao.Text;
  (FController.GetModel as TMarcaModel).DescricaoReduzida := Edt_DescricaoReduzida.Text;

  Result := True;
end;



procedure TFormCadastroMarca.ControlChange(Sender: TObject);
begin
  inherited;

  { TODO -oDev -cRever : Não temos uma interface para as views, assim esse método controlchange pode não seguir um padrão.... }
  DoControlChange(Sender);
end;

end.
