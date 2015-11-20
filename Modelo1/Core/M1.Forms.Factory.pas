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
    CadastroDemo  : TGUID = '{86447309-B6BB-4FF6-9EE4-622380FB9094}';
    CadastroMarca : TGUID = '{9F55DEBE-BE81-4D31-BEBA-72335C3E1CF8}';
    CadastroEstado: TGUID = '{BE86067B-6506-43F4-9346-5840AAD83360}';
  end;

  TM1FormsRegister = class
  public
    class procedure Execute;
  end;

implementation

uses
 M1.CadastroDemo.UI.Form,
 M1.CadastroDemo.Controller,
 M1.CadastroMarca.UI.Form,
 M1.CadastroMarca.Controller,
 M1.CadastroEstado.UI.Form,
 M1.CadastroEstado.Controller
 ;

{ TM1FormsRegister }


class procedure TM1FormsRegister.Execute;
begin
  ViewRegistry.Add(TM1Forms.CadastroDemo  , TViewCadastroDemo  , TCadastroDemoController  , False);
  ViewRegistry.Add(TM1Forms.CadastroMarca , TFormCadastroMarca , TCadastroMarcaController , False);
  ViewRegistry.Add(TM1Forms.CadastroEstado, TFormCadastroEstado, TCadastroEstadoController, False);
end;

initialization
  TM1FormsRegister.Execute;

end.
