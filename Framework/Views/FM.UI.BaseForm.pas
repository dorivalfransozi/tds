unit FM.UI.BaseForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FM.Model.Base, FM.Controller.Base;

type
  TBaseFormView = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  protected
    FModel: TModelBase;
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
  DDC.ViewMessages;

{$R *.dfm}

{ TBaseFormView }



procedure TBaseFormView.DoControlChange(Sender: TObject);
begin
  DoUpdateModel;
end;



function TBaseFormView.DoControlCheck(Control: TWinControl): Boolean;
begin
  { TODO -oDev -cREver : Esse código que trata a exception esta duplicada, aqui e no controller.base. }
  Result := False;
  try
    Result := FController.Validate(Copy(Control.Name, 4, Length(Control.Name)));
  except
    on E: ExceptionValidationInfo do
      TValidationInfo.New(FModel, 'E.PropertyName', False, E.Message, MB_ICONEXCLAMATION);
    on E: ExceptionValidationError do
      TValidationInfo.New(FModel, 'E.PropertyName', False, E.Message, MB_ICONERROR);
  end;
end;



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
