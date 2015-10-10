unit DDC.ValidationInfo;

interface

uses
  FM.Model.Base,
  DDC.ViewMessages;

type

  TValidationInfo = class
  private
    FPropertyName: string;
    FValidationMessage: string;
    FValid: Boolean;
    FModelBase: TModelBase;
    FTypeMessage: LongInt;
  public
    property PropertyName: string read FPropertyName write FPropertyName;
    property Valid: Boolean read FValid write FValid;
    property ValidationMessage: string read FValidationMessage write FValidationMessage;
    property Model: TModelBase read FModelBase write FModelBase;
    property TypeMessage: LongInt read FTypeMessage write FTypeMessage;

    class procedure New(Model: TModelBase; const PropertyName: string; Valid: Boolean; const ValidationMessage: string;
      const TypeMessage: LongInt);
  end;

implementation

uses
  DDC.Notification.Service;

{ TValidationInfo }



class procedure TValidationInfo.New(Model: TModelBase; const PropertyName: string; Valid: Boolean;
  const ValidationMessage: string; const TypeMessage: LongInt);
var
  ValidationInfo: TValidationInfo;
begin
  ValidationInfo := TValidationInfo.Create;
  try
    ValidationInfo.Model             := Model;
    ValidationInfo.PropertyName      := PropertyName;
    ValidationInfo.Valid             := Valid;
    ValidationInfo.ValidationMessage := ValidationMessage;
    ValidationInfo.TypeMessage       := TypeMessage;

    NotificationService.SendMessage(ValidationInfo, TViewMsgs.ShowValidationResult);
  finally
    ValidationInfo.Free;
  end;
end;

end.
