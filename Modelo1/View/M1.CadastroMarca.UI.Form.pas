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
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCadastroMarca: TFormCadastroMarca;

implementation

{$R *.dfm}




procedure TFormCadastroMarca.BtnExcluirClick(Sender: TObject);
begin
  inherited;
  GetCRUDController.Delete;
end;



procedure TFormCadastroMarca.BtnSalvarClick(Sender: TObject);
begin
  inherited;
  GetCRUDController.Save;
end;

end.
