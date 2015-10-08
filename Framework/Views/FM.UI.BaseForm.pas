unit FM.UI.BaseForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FM.Model.Base, FM.Controller.Base;

type
  TBaseFormView = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  protected
    FModel: TModelBase;
    FController: IControllerBase;
    procedure SetController(const Value: IControllerBase); virtual;
  protected
    procedure DoInitialize; virtual;
    function DoUpdateModel: Boolean; virtual; abstract;
    function DoInternalValidate: Boolean; virtual; abstract;
    procedure ShowValidationResult(Sender: TObject); virtual;
  public
    property Controller: IControllerBase read FController write SetController;
  end;

  TBaseFormViewClass = class of TBaseFormView;

var
  BaseFormView: TBaseFormView;

implementation

uses
  DDC.ValidationInfo, DDC.Notification.Service, DDC.ViewMessages;

{$R *.dfm}

{ TBaseFormView }



procedure TBaseFormView.DoInitialize;
begin
  if Assigned(FController) then
    FModel := FController.Model;
end;



procedure TBaseFormView.FormCreate(Sender: TObject);
begin
  NotificationService.Subscribe(ShowValidationResult, TViewMsgs.ShowValidationResult);
end;



procedure TBaseFormView.FormDestroy(Sender: TObject);
begin
  NotificationService.UnSubscribe(ShowValidationResult);
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

  if FModel = ValidationInfo.Model then
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
