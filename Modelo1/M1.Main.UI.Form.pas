unit M1.Main.UI.Form;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses M1.CadastroDemo.Controller, M1.CadastroDemo.UI.Form;

procedure TForm1.Button1Click(Sender: TObject);
var
 Controller: TCadastroDemoController;
begin
  Controller := TCadastroDemoController.Create;
  try
    TViewCadastroDemo.Execute(Controller,
      procedure
      begin
       Controller.FindCadastroDemo('Diego');
      end);
  finally
    Controller.Free;
  end;
end;

end.