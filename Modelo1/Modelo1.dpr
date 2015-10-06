program Modelo1;

uses
  Vcl.Forms,
  M1.Main.UI.Form in 'M1.Main.UI.Form.pas' {Form1},
  M1.CadastroDemo.UI.Form in 'Comercial\M1.CadastroDemo.UI.Form.pas' {ViewCadastroDemo},
  M1.CadastroDemo.Controller in 'Comercial\M1.CadastroDemo.Controller.pas',
  M1.CadastroDemo.Model in 'Comercial\M1.CadastroDemo.Model.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);

  Application.Run;
end.
