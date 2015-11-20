unit FM.UI.BaseForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.StdCtrls, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FM.Model.Base, FM.Controller.Base;

type
  THackCustomEdit = class(TCustomEdit);

  TBaseFormView = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  protected
    // FModel: TModelBase;
    FController: IControllerBase;
    procedure SetController(const Value: IControllerBase); virtual;
  protected
    function DoControlCheck(Control: TWinControl = nil): Boolean; virtual;
    function DoUpdateModel: Boolean; virtual; abstract;
    function DoInternalValidate: Boolean; virtual; abstract;
    procedure DoControlChange(Sender: TObject); virtual;
    procedure DoInitialize; virtual;
    procedure ShowValidationResult(Sender: TObject); virtual;
  public
    property Controller: IControllerBase read FController write SetController;
  end;

  TBaseFormViewClass = class of TBaseFormView;

var
  BaseFormView: TBaseFormView;

implementation

uses
  DDC.ValidationInfo,
  DDC.Notification.Service,
  DDC.ViewMessages, System.Rtti;

{$R *.dfm}

{ TBaseFormView }



procedure TBaseFormView.DoControlChange(Sender: TObject);
begin
  DoUpdateModel;
end;



function TBaseFormView.DoControlCheck(Control: TWinControl): Boolean;
begin
  { DONE -oDev -cRever : Esse código que trata a exception esta duplicada, aqui e no controller.base. }
  { foi removido o dointernalvalidate, o model tem o método isvalid e o validate do controller passa a ser responsável por capturar a exception levantada }
  Result := FController.Validate(Copy(Control.Name, pos('_', Control.Name) + 1, Length(Control.Name)));
end;



procedure TBaseFormView.DoInitialize;
var
  i: SmallInt;
  oRttiProp: TRttiProperty;
  oRttiCtx: TRttiContext;
begin
  { DONE : validar se fica o codigo abaixo }
  { adicionado rtti para setar onchange }
  oRttiCtx := TRttiContext.Create.Create;
  try
    for i := 0 to pred(Self.ComponentCount) do
    begin
      oRttiProp := oRttiCtx.GetType(Self.Components[i].ClassType).GetProperty('OnChange');
      if (oRttiProp <> nil) then
        oRttiProp.SetValue(Self.Components[i], TValue.From<TNotifyEvent>(DoControlChange));
    end;
  finally
    oRttiCtx.Free;
  end;
end;



procedure TBaseFormView.FormCreate(Sender: TObject);
begin
  NotificationService.Subscribe(ShowValidationResult, TViewMsgs.ShowValidationResult);
end;



procedure TBaseFormView.FormDestroy(Sender: TObject);
begin
  NotificationService.UnSubscribe(ShowValidationResult);
end;



procedure TBaseFormView.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if ((Key = #13) and (DoControlCheck(ActiveControl))) then
  begin
    SelectNext(ActiveControl, True, True);
    Key := #0;
  end
end;



procedure TBaseFormView.SetController(const Value: IControllerBase);
begin
  FController := Value;
  DoInitialize;
end;



procedure TBaseFormView.ShowValidationResult(Sender: TObject);
var
  ValidationInfo: TValidationInfo;
begin
  ValidationInfo := TValidationInfo(Sender);

  { DONE : PORQUÊ DESSE IF ABAIXO }
  { pq a notificação pode ser enviada para a view mas o modelo que gerou a notificação é diferente }
  if FController.Model = ValidationInfo.Model then
  begin
    if Assigned(ValidationInfo) then
    begin
      if not ValidationInfo.Valid then
        Application.MessageBox(PWideChar(ValidationInfo.ValidationMessage), 'Erro...',
          mb_ok + ValidationInfo.TypeMessage);
    end;
  end;
end;

end.
