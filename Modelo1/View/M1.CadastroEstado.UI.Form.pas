unit M1.CadastroEstado.UI.Form;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FM.UI.Cadastro, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Buttons;

type
  TFormCadastroEstado = class(TFormCadastro)
    Edt_Codigo: TLabeledEdit;
    Edt_Descricao: TLabeledEdit;
  protected
    function DoUpdateModel: Boolean; override;
  end;

var
  FormCadastroEstado: TFormCadastroEstado;

implementation

uses
  M1.Estado.Model;

{$R *.dfm}

{ TFormCadastroEstado }



function TFormCadastroEstado.DoUpdateModel: Boolean;
begin
  // removida a exception pq se der erro ao setar o model deve cair no stack
  (FController.GetModel as TEstadoModel).Codigo    := Edt_Codigo.Text;
  (FController.GetModel as TEstadoModel).Descricao := Edt_Descricao.Text;

  Result := True;
end;

end.
