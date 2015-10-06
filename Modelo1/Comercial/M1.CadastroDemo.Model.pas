unit M1.CadastroDemo.Model;

interface

type

  //Generalizar para mais de um cadastro
  TCadastroDemoViewlMsgs = class
  public
    const RefreshView: TGUID = '{C7C2A617-39FD-4CED-A18D-9BB09C2C794A}';
    const ShowValidationResult: TGUID = '{66C67F03-DFD6-48FD-BEB7-56AD71082D97}';
  end;

  IValidation = interface
    function LastErrorMsg: string;
    function IsValid: Boolean;
  end;

  TModelBase = class
  public
    function New: TModelBase; virtual; abstract;
  end;

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

  TCadastroDemoModel = class(TModelBase)
  private
    FName: string;
    FAge: Integer;
    procedure SetAge(const Value: Integer);
    procedure SetName(const Value: string);
  public
    property Name: string read FName write SetName;
    property Age: Integer read FAge write SetAge;

    function New: TModelBase; override;
  end;

//  TModelPedido = class
//   property ItensPedido: TList<TModelItensPedido>;
//  end;
//
//
//  TCadastroDemoComposto = class(TModelBase)
//    property ModelPedido: TModelPedido;
//    property ModelInformacoesAdcionais: TModelInformacoesAdicionais;
//  end;

implementation

uses
  System.SysUtils,
  DDC.Notification.Service;

{ TCadastroDemoModel }

function TCadastroDemoModel.New: TModelBase;
begin
  Result := TCadastroDemoModel.Create;
end;

procedure TCadastroDemoModel.SetAge(const Value: Integer);
begin
  FAge := Value;
end;

procedure TCadastroDemoModel.SetName(const Value: string);
begin
  if Value <> 'Diego' then
   raise Exception.Create('Valor invalido!');

  FName := Value;
end;

{ TValidationInfo }

class procedure TValidationInfo.New(Model: TModelBase; const PropertyName: string; Valid: Boolean; const ValidationMessage: string);
var
 ValidationInfo: TValidationInfo;
begin
  ValidationInfo := TValidationInfo.Create;
  try
    ValidationInfo.Model := Model;
    ValidationInfo.PropertyName := PropertyName;
    ValidationInfo.Valid := Valid;
    ValidationInfo.ValidationMessage := ValidationMessage;

    NotificationService.SendMessage(ValidationInfo, TCadastroDemoViewlMsgs.ShowValidationResult);
  finally
    ValidationInfo.Free;
  end;
end;


end.
