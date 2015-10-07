unit M1.Forms.Factory;

interface

uses
 Vcl.Forms,
 FM.UI.View.Factory;

type
  ViewFactory = FM.UI.View.Factory.TViewFactory;
  TView = FM.UI.View.Factory.TView;

  TM1Forms = record
   const
    CadastroDemo: TGUID = '{86447309-B6BB-4FF6-9EE4-622380FB9094}';
  end;

  TM1FormsRegister = class
  private
    class function CreateForm(FormClass: TFormClass): TForm;
  public
    class procedure Execute;
  end;

implementation

uses
 M1.CadastroDemo.UI.Form,
 M1.CadastroDemo.Controller;

{ TM1FormsRegister }

class function TM1FormsRegister.CreateForm(FormClass: TFormClass): TForm;
begin

end;

class procedure TM1FormsRegister.Execute;
begin
  ViewRegistry.Add(TM1Forms.CadastroDemo, TViewCadastroDemo, TCadastroDemoController, False);
end;

initialization
  TM1FormsRegister.Execute;

end.
