unit FM.UI.BaseForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FM.Model.Base, FM.Controller.Base;

type
  TBaseFormView = class(TForm)
  protected
    FModel: TModelBase;
    FController: IControllerBase;
    procedure SetController(const Value: IControllerBase); virtual;
  private
    procedure ShowValidationResult(Sender: TObject);
  protected
    procedure DoInitialize; virtual;
    function DoUpdateModel: Boolean; virtual; abstract;
    function DoInternalValidate: Boolean; virtual; abstract;
  public
    property Controller: IControllerBase read FController write SetController;
  end;

  TBaseFormViewClass = class of TBaseFormView;

var
  BaseFormView: TBaseFormView;

implementation

uses
  DDC.ValidationInfo;

{$R *.dfm}

{ TBaseFormView }

procedure TBaseFormView.DoInitialize;
begin
  if Assigned(FController) then
   FModel := FController.Model;
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
        Application.MessageBox('Ocorreu um erro na validação!', 'Erro...', mb_ok + mb_iconerror );
    end;
  end;
end;


end.
