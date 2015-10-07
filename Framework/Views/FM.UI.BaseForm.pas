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
  protected
    procedure DoInitialize; virtual;
    function DoUpdateModel: Boolean; virtual; abstract;
    function DoInternalValidate: Boolean; virtual; abstract;
    procedure DoInternalSave; virtual;
  public
    property Controller: IControllerBase read FController write SetController;
  end;

  TBaseFormViewClass = class of TBaseFormView;

var
  BaseFormView: TBaseFormView;

implementation

{$R *.dfm}

{ TBaseFormView }

procedure TBaseFormView.DoInitialize;
begin
  if Assigned(FController) then
   FModel := FController.Model;
end;


procedure TBaseFormView.DoInternalSave;
begin
//  Controller.Save;
end;

procedure TBaseFormView.SetController(const Value: IControllerBase);
begin
  FController := Value;
  DoInitialize;
end;

end.
