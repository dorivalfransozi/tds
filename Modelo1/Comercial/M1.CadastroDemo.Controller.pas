unit M1.CadastroDemo.Controller;

interface

uses
  M1.CadastroDemo.Model,
  FM.Controller.CRUD, FM.Controller.CRUD.Impl,
  Classes, FM.Model.Base;

type
  TCadastroDemoController = class(TCRUDController)
  private
    FModel: TCadastroDemoModel;
  public
    constructor Create; override;
    destructor Destroy; override;

    procedure FindCadastroDemo(const Name: string);
    procedure ListCadastroDemo;

    function Validate(const AAttribute: string = ''): Boolean; override;

    procedure New; override;
    procedure Edit; override;
    procedure Save; override;
  end;

implementation

uses
  DDC.Notification.Service, DDC.ValidationInfo,
  System.SysUtils;

{ TCadastroDemoController }



constructor TCadastroDemoController.Create;
begin
  FModel := TCadastroDemoModel.Create;
end;



destructor TCadastroDemoController.Destroy;
begin
  FModel.Free;
  inherited;
end;



procedure TCadastroDemoController.Edit;
begin
  inherited;

end;



procedure TCadastroDemoController.FindCadastroDemo(const Name: string);
begin
  // Consultar do DAO para pegar a instancia do objeto populada.
  // DAODemo.FinCadastroDemo(Name, FModel);

  FModel.Name := 'Diego';
  FModel.Age  := 31;

  NotificationService.SendMessage(FModel, TCadastroDemoViewlMsgs.RefreshView);
end;






procedure TCadastroDemoController.ListCadastroDemo;
begin
  // Repassar para DAO busca e popular lista de objects
  // Em seguida notificar as views com a referencia dos itens retornados.
end;



procedure TCadastroDemoController.New;
begin
  inherited;

end;



procedure TCadastroDemoController.Save;
begin
  // Passar para DAO o Model para que seja persistido.
end;



function TCadastroDemoController.Validate(const AAttribute: string = ''): Boolean;
// Validara pelo BO usando DAO
  function GetValidAge: Integer;
  begin
    Result := 31;
  end;



begin
  Result := FModel.Age > GetValidAge;

{  if Result then
    TValidationInfo.New(FModel, 'Age', False, 'Idade informada n�o � valida.');
}


  // ValidationInfo := TValidationInfo.New(Model, 'Name', False, E.Message);

  // Result := not Assigned(ValidationInfo);
  //
  // if not Result then
  // begin
  // NotificationService.SendMessage(ValidationInfo, TCadastroDemoViewlMsgs.ShowValidationResult);
  // ValidationInfo.Free;
  // end;
end;

end.
