unit M1.CadastroDemo.UI.Form;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, M1.CadastroDemo.Controller, M1.CadastroDemo.Model,
  FM.UI.BaseForm;

type
  TViewCadastroDemo = class(TBaseFormView)
    VCName: TEdit;
    Label1: TLabel;
    VCAge: TEdit;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    function GetController: TCadastroDemoController;

    procedure RefreshScreen(Sender: TObject);
    procedure ShowValidationResult(Sender: TObject);
  private
    function DoUpdateModel: Boolean; override;
    function DoInternalValidate: Boolean; override;
    procedure DoInternalSave; override;
  public
    class procedure Execute(Controller: TCadastroDemoController; AfterCreate: TProc = nil);
  end;

var
  ViewCadastroDemo: TViewCadastroDemo;

implementation

uses
  DDC.Notification.Service,
  System.Rtti;

{$R *.dfm}

procedure TViewCadastroDemo.Button1Click(Sender: TObject);
begin
  if DoInternalValidate then
    DoInternalSave;
end;

procedure TViewCadastroDemo.DoInternalSave;
begin
  GetController.Save;
end;

function TViewCadastroDemo.DoInternalValidate: Boolean;
begin
  Result := DoUpdateModel and GetController.Validate;
end;

function TViewCadastroDemo.DoUpdateModel: Boolean;
begin
  Result := True;

  try
   //Usar RTTI para setar properties do Modelo

   (FModel as TCadastroDemoModel).Name := VCName.Text;
   (FModel as TCadastroDemoModel).Age  := StrToInt(VCAge.Text);

  except
   //Criar Exception base para validações que já contenha o validation info.
   on E: Exception do
    begin
     Result := False;
     TValidationInfo.New(FModel, 'E.PropertyName', False, E.Message);
    end;
  end;
end;

class procedure TViewCadastroDemo.Execute(Controller: TCadastroDemoController; AfterCreate: TProc = nil);
var
 View: TViewCadastroDemo;
begin
  View := TViewCadastroDemo.Create(nil);
  try
    View.Controller := Controller;
    View.DoInitialize;

    if Assigned(AfterCreate) then
     AfterCreate();

    View.ShowModal;

  finally
    View.Free;
  end;
end;

procedure TViewCadastroDemo.FormCreate(Sender: TObject);
begin
  NotificationService.Subscribe(RefreshScreen, TCadastroDemoViewlMsgs.RefreshView);
  NotificationService.Subscribe(ShowValidationResult, TCadastroDemoViewlMsgs.ShowValidationResult);
end;

procedure TViewCadastroDemo.FormDestroy(Sender: TObject);
begin
  NotificationService.UnSubscribe(RefreshScreen);
  NotificationService.UnSubscribe(ShowValidationResult);
end;

function TViewCadastroDemo.GetController: TCadastroDemoController;
begin
  Result := FController as TCadastroDemoController;
end;

procedure TViewCadastroDemo.RefreshScreen(Sender: TObject);
const
  ComponentPrefix = 'VC';
var
  ctx: TRttiContext;
  objType: TRttiType;
  Prop: TRttiProperty;
  ViewComponent: TComponent;
begin
  ctx := TRttiContext.Create;
  objType := ctx.GetType(Sender.ClassInfo);
  try

   for Prop in objType.GetProperties do
    begin
      ViewComponent := FindComponent(ComponentPrefix + Prop.Name);

      if Assigned(ViewComponent) then
       begin
         if ViewComponent is TEdit then
          TEdit(ViewComponent).Text := Prop.GetValue(Sender).ToString;
       end;
    end;

  finally
   ctx.Free;
  end;
end;

procedure TViewCadastroDemo.ShowValidationResult(Sender: TObject);
var
 ValidationInfo: TValidationInfo;
begin
 ValidationInfo := TValidationInfo(Sender);

 if FModel = ValidationInfo.Model then
  begin
   if Assigned(ValidationInfo) then
    begin
      if not ValidationInfo.Valid then
        Application.MessageBox('Ocorreu um erro na validação!', 'Erro...', mb_ok + mb_iconerror );
    end;
  end;
end;

end.
