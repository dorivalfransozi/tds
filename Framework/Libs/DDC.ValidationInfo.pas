unit DDC.ValidationInfo;

interface

uses
  FM.Model.Base;

type

  TValidationInfo = class
  private
    FPropertyName: string;
    FValidationMessage: string;
    FValid: Boolean;
    FModelBase: TModelBase;
  public
    property PropertyName: string read FPropertyName write FPropertyName;
    property Valid: Boolean read FValid write FValid;
    property ValidationMessage: string read FValidationMessage write FValidationMessage;
    property Model: TModelBase read FModelBase write FModelBase;

    class procedure New(Model: TModelBase; const PropertyName: string; Valid: Boolean; const ValidationMessage: string);
  end;

implementation

uses
  DDC.Notification.Service, DDC.ViewMessages;

{ TValidationInfo }

class procedure TValidationInfo.New(Model: TModelBase; const PropertyName: string; Valid: Boolean;
  const ValidationMessage: string);
var
  ValidationInfo: TValidationInfo;
begin
  ValidationInfo := TValidationInfo.Create;
  try
    ValidationInfo.Model             := Model;
    ValidationInfo.PropertyName      := PropertyName;
    ValidationInfo.Valid             := Valid;
    ValidationInfo.ValidationMessage := ValidationMessage;

    NotificationService.SendMessage(ValidationInfo, TViewMsgs.ShowValidationResult);
  finally
    ValidationInfo.Free;
  end;
end;


end.
