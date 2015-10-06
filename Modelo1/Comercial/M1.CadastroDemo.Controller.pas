unit M1.CadastroDemo.Controller;

interface

uses
 M1.CadastroDemo.Model,
 FM.Controller.Base,
 Classes;

type
  TCadastroDemoController = class(TCRUDController)
  protected
    function GetModel: TModelBase; override;
  private
    FModel: TCadastroDemoModel;
  public
    constructor Create;
    destructor Destroy; override;

    procedure FindCadastroDemo(const Name: string);
    procedure ListCadastroDemo;

    function Validate: Boolean; override;

    procedure New; override;
    procedure Edit; override;
    procedure Save; override;
  public
    property Model: TModelBase read GetModel;
  end;

implementation

uses
  DDC.Notification.Service,
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
 //Consultar do DAO para pegar a instancia do objeto populada.
 //DAODemo.FinCadastroDemo(Name, FModel);

 FModel.Name := 'Diego';
 FModel.Age  := 31;

 NotificationService.SendMessage(FModel, TCadastroDemoViewlMsgs.RefreshView);
end;

function TCadastroDemoController.GetModel: TModelBase;
begin
  Result := FModel as TModelBase;
end;

procedure TCadastroDemoController.ListCadastroDemo;
begin
 //Repassar para DAO busca e popular lista de objects
 //Em seguida notificar as views com a referencia dos itens retornados.
end;

procedure TCadastroDemoController.New;
begin
  inherited;

end;

procedure TCadastroDemoController.Save;
begin
 //Passar para DAO o Model para que seja persistido.
end;

function TCadastroDemoController.Validate: Boolean;
  //Validara pelo BO usando DAO
  function GetValidAge: Integer;
  begin
    Result := 31;
  end;
begin
   Result := FModel.Age > GetValidAge;

   if Result then
     TValidationInfo.New(FModel, 'Age', False, 'Idade informada não é valida.');



//    ValidationInfo := TValidationInfo.New(Model, 'Name', False, E.Message);

//  Result := not Assigned(ValidationInfo);
//
//  if not Result then
//   begin
//    NotificationService.SendMessage(ValidationInfo, TCadastroDemoViewlMsgs.ShowValidationResult);
//    ValidationInfo.Free;
//   end;
end;

end.
