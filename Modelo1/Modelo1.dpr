program Modelo1;

uses
  Vcl.Forms,
  M1.Main.UI.Form in 'M1.Main.UI.Form.pas' {Form1},
  M1.CadastroDemo.UI.Form in 'Comercial\M1.CadastroDemo.UI.Form.pas' {ViewCadastroDemo},
  M1.CadastroDemo.Controller in 'Comercial\M1.CadastroDemo.Controller.pas',
  M1.CadastroDemo.Model in 'Comercial\M1.CadastroDemo.Model.pas',
  FM.Model.Base in '..\Framework\Models\FM.Model.Base.pas',
  FM.UI.BaseForm in '..\Framework\Views\FM.UI.BaseForm.pas' {BaseFormView},
  FM.Controller.Base in '..\Framework\Controllers\FM.Controller.Base.pas';
  FM.UI.Consulta in '..\Framework\Views\FM.UI.Consulta.pas' {ConsultaFormView};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := true;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
