program Modelo1;

uses
  Vcl.Forms,
  M1.Main.UI.Form in 'M1.Main.UI.Form.pas' {Form1},
  M1.CadastroDemo.UI.Form in 'Comercial\M1.CadastroDemo.UI.Form.pas' {ViewCadastroDemo},
  M1.CadastroDemo.Controller in 'Comercial\M1.CadastroDemo.Controller.pas',
  M1.CadastroDemo.Model in 'Comercial\M1.CadastroDemo.Model.pas',
  FM.Model.Base in '..\Framework\Models\FM.Model.Base.pas',
  FM.Controller.Base in '..\Framework\Controllers\FM.Controller.Base.pas',
  M1.Forms.Factory in 'Core\M1.Forms.Factory.pas',
  FM.UI.BaseForm in '..\Framework\Views\FM.UI.BaseForm.pas' {BaseFormView},
  FM.UI.Cadastro in '..\Framework\Views\FM.UI.Cadastro.pas' {FormCadastro},
  FM.UI.Configuracao in '..\Framework\Views\FM.UI.Configuracao.pas' {FormConfiguracao},
  FM.UI.Consulta in '..\Framework\Views\FM.UI.Consulta.pas' {FormConsulta},
  FM.UI.FormularioInterno in '..\Framework\Views\FM.UI.FormularioInterno.pas' {FormFormularioInterno},
  FM.UI.Processo.CRUD in '..\Framework\Views\FM.UI.Processo.CRUD.pas' {FormProcessoCRUD},
  FM.UI.Processo in '..\Framework\Views\FM.UI.Processo.pas' {FormProcesso},
  FM.UI.Relatorio in '..\Framework\Views\FM.UI.Relatorio.pas' {FormRelatorio},
  FM.UI.View.Factory in '..\Framework\Views\FM.UI.View.Factory.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := true;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
