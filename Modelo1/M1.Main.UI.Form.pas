unit M1.Main.UI.Form;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


uses
  M1.Forms.Factory,
  M1.CadastroDemo.Controller,
  M1.CadastroDemo.UI.Form;



procedure TForm1.Button1Click(Sender: TObject);
begin
  ViewFactory.InvokeShow(TM1Forms.CadastroMarca);
end;



procedure TForm1.Button2Click(Sender: TObject);
begin
  ViewFactory.InvokeShow(TM1Forms.CadastroDemo,
    procedure(View: TView)
    begin
      TCadastroDemoController(View.Controller).FindCadastroDemo('Diego');
    end
    );
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  ViewFactory.InvokeShow(TM1Forms.CadastroEstado);
end;

end.
