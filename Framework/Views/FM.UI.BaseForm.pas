unit FM.UI.BaseForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FM.Model.Base;

type
  TBaseFormView = class(TForm)
  private
    FModel: TModelBase;
  public
    procedure DoInitialize; virtual;
    function DoUpdateModel: Boolean; virtual; abstract;
    function DoInternalValidate: Boolean; virtual; abstract;
    procedure DoInternalSave; virtual;
  end;

var
  BaseFormView: TBaseFormView;

implementation

{$R *.dfm}

{ TBaseFormView }

procedure TBaseFormView.DoInitialize;
begin
{  if Assigned(FController) then
   FModel := Controller.Model;}
end;


procedure TBaseFormView.DoInternalSave;
begin
//  Controller.Save;

end;

end.
