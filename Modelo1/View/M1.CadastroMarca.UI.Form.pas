unit M1.CadastroMarca.UI.Form;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FM.UI.Cadastro, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, editnum;

type
  TFormCadastroMarca = class(TFormCadastro)
    EdtDescrReduz: TEditText;
    EdtDescricao: TEditText;
    EdtCodigo: TEditNum;
  private
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
  Result := True;
  try
    (FModel as TMarcaModel).Codigo            := StrToIntDef(EdtCodigo.Text, 0);
    (FModel as TMarcaModel).Descricao         := EdtDescricao.Text;
    (FModel as TMarcaModel).DescricaoReduzida := EdtDescrReduz.Text;

  except
    // Criar Exception base para validações que já contenha o validation info.
    on E: ExceptionValidation do
    begin
      Result := False;
      TValidationInfo.New(FModel, 'E.PropertyName', False, E.Message, MB_ICONERROR);
    end;
  end;
end;

end.
