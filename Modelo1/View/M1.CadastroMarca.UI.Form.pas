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
{$IFDEF SYSMO}
    EdtCodigo: TEditNum;
{$ELSE}
    EdtCodigo: TLabeledEdit;
{$ENDIF}
    EdtDescricao: TLabeledEdit;
    EdtDescricaoReduzida: TLabeledEdit;

    procedure ControlChange(Sender: TObject);
  protected
    function DoUpdateModel: Boolean; override;
  end;

var
  FormCadastroMarca: TFormCadastroMarca;

implementation

uses
  M1.Marca.Model,
  DDC.ValidationInfo,
  M1.Exceptions;

{$IFDEF SYSMO}
{$R M1.CadastroMarca.UI.Form_sysmo.dfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}




function TFormCadastroMarca.DoUpdateModel: Boolean;
begin
  // removida a exception pq se der erro ao setar o model deve cair no stack
  (FModel as TMarcaModel).Codigo            := StrToIntDef(EdtCodigo.Text, 0);
  (FModel as TMarcaModel).Descricao         := EdtDescricao.Text;
  (FModel as TMarcaModel).DescricaoReduzida := EdtDescricaoReduzida.Text;

  Result := True;
end;



procedure TFormCadastroMarca.ControlChange(Sender: TObject);
begin
  inherited;
  DoControlChange(Sender);
end;

end.
