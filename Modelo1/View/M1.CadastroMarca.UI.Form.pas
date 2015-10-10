unit M1.CadastroMarca.UI.Form;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FM.UI.Cadastro, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls;

type
  TFormCadastroMarca = class(TFormCadastro)
    EdtDescrReduz: TEdit;
    EdtDescricao: TEdit;
    EdtCodigo: TEdit;
  protected
    function DoUpdateModel: Boolean; override;
  end;

var
  FormCadastroMarca: TFormCadastroMarca;

implementation

uses
  M1.Marca.Model, DDC.ValidationInfo, M1.Exceptions;

{$R *.dfm}




function TFormCadastroMarca.DoUpdateModel: Boolean;
begin
  // removida a exception pq se der erro ao setar o model deve cair no stack
  (FModel as TMarcaModel).Codigo            := StrToIntDef(EdtCodigo.Text, 0);
  (FModel as TMarcaModel).Descricao         := EdtDescricao.Text;
  (FModel as TMarcaModel).DescricaoReduzida := EdtDescrReduz.Text;

  Result := True;
end;

end.
