program Modelo1;

{$R *.dres}

uses
  Vcl.Forms,
  DBXDevartInterbase,
  DBXDevArtPostgresql,
  M1.Main.UI.Form in 'M1.Main.UI.Form.pas' {Form1},
  M1.CadastroDemo.UI.Form in 'Comercial\M1.CadastroDemo.UI.Form.pas' {ViewCadastroDemo},
  M1.CadastroDemo.Controller in 'Comercial\M1.CadastroDemo.Controller.pas',
  M1.CadastroDemo.Model in 'Comercial\M1.CadastroDemo.Model.pas',
  FM.Model.Base in '..\Framework\Models\FM.Model.Base.pas',
  FM.Controller.Base.Impl in '..\Framework\Controllers\FM.Controller.Base.Impl.pas',
  M1.Forms.Factory in 'Core\M1.Forms.Factory.pas',
  FM.UI.BaseForm in '..\Framework\Views\FM.UI.BaseForm.pas' {BaseFormView},
  FM.UI.Cadastro in '..\Framework\Views\FM.UI.Cadastro.pas' {FormCadastro},
  FM.UI.Configuracao in '..\Framework\Views\FM.UI.Configuracao.pas' {FormConfiguracao},
  FM.UI.Consulta in '..\Framework\Views\FM.UI.Consulta.pas' {FormConsulta},
  FM.UI.FormularioInterno in '..\Framework\Views\FM.UI.FormularioInterno.pas' {FormFormularioInterno},
  FM.UI.Processo.CRUD in '..\Framework\Views\FM.UI.Processo.CRUD.pas' {FormProcessoCRUD},
  FM.UI.Processo in '..\Framework\Views\FM.UI.Processo.pas' {FormProcesso},
  FM.UI.Relatorio in '..\Framework\Views\FM.UI.Relatorio.pas' {FormRelatorio},
  FM.UI.View.Factory in '..\Framework\Views\FM.UI.View.Factory.pas',
  M1.CadastroMarca.UI.Form in 'View\M1.CadastroMarca.UI.Form.pas' {FormCadastroMarca},
  M1.CadastroMarca.Controller in 'Controller\M1.CadastroMarca.Controller.pas',
  M1.Marca.Model in 'Model\M1.Marca.Model.pas',
  M1.Exceptions in 'Core\M1.Exceptions.pas',
  M1.ResourceStrings in 'Core\M1.ResourceStrings.pas',
  FM.Controller.CRUD.Impl in '..\Framework\Controllers\FM.Controller.CRUD.Impl.pas',
  FM.Controller.CRUD in '..\Framework\Controllers\FM.Controller.CRUD.pas',
  FM.Controller.Find.Impl in '..\Framework\Controllers\FM.Controller.Find.Impl.pas',
  FM.Controller.Find in '..\Framework\Controllers\FM.Controller.Find.pas',
  FM.Controller.Process.Impl in '..\Framework\Controllers\FM.Controller.Process.Impl.pas',
  FM.Controller.Process in '..\Framework\Controllers\FM.Controller.Process.pas',
  FM.Controller.Base in '..\Framework\Controllers\FM.Controller.Base.pas',
  M1.Marca.DAO in 'DAO\M1.Marca.DAO.pas',
  FM.DAO.Base in '..\Framework\DAOs\FM.DAO.Base.pas',
  FM.DAO.Base.Impl in '..\Framework\DAOs\FM.DAO.Base.Impl.pas',
  DDC.Resource in '..\Framework\Libs\DDC.Resource.pas',
  DDC.Attributes in '..\Framework\Libs\DDC.Attributes.pas',
  DDC.Core.Detour in '..\Framework\Libs\DDC.Core.Detour.pas',
  DDC.Core.Reflection in '..\Framework\Libs\DDC.Core.Reflection.pas',
  DDC.ValidationInfo in '..\Framework\Libs\DDC.ValidationInfo.pas',
  DDC.ViewMessages in '..\Framework\Libs\DDC.ViewMessages.pas',
  DDC.Validator.Impl in '..\Framework\Libs\DDC.Validator.Impl.pas',
  DDC.Validate in '..\Framework\Libs\DDC.Validate.pas',
  DDC.Validate.CustomAttribute in '..\Framework\Libs\DDC.Validate.CustomAttribute.pas',
  DDC.Validate.MinLength in '..\Framework\Libs\DDC.Validate.MinLength.pas',
  DDC.Validate.MaxLength in '..\Framework\Libs\DDC.Validate.MaxLength.pas',
  DDC.Validate.MinValue in '..\Framework\Libs\DDC.Validate.MinValue.pas',
  DDC.Validate.MaxValue in '..\Framework\Libs\DDC.Validate.MaxValue.pas',
  DDC.Validate.ExactLength in '..\Framework\Libs\DDC.Validate.ExactLength.pas',
  DDC.Validate.Required in '..\Framework\Libs\DDC.Validate.Required.pas',
  DDC.Validate.IsNatural in '..\Framework\Libs\DDC.Validate.IsNatural.pas',
  DDC.Validate.IsNaturalNoZero in '..\Framework\Libs\DDC.Validate.IsNaturalNoZero.pas',
  DDC.Validator in '..\Framework\Libs\DDC.Validator.pas',
  DDC.Validator.Extend in '..\Framework\Libs\DDC.Validator.Extend.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := true;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
