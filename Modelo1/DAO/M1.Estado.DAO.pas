unit M1.Estado.DAO;

interface

uses
  FM.DAO.Base.Impl,
  M1.Estado.Model,
  System.Generics.Collections;

type

  TDAOEstado = class(TDAOBase<TEstadoModel>)
  protected
    procedure SetModel(var AModel: TEstadoModel); override;
  public
    procedure Save(var AModel: TEstadoModel); override;
    procedure Delete(var AModel: TEstadoModel); override;
    function Find(var AModel: TEstadoModel; const ASetModel: boolean = true): boolean; override;
    function FindAll(var AListModel: TObjectList<TEstadoModel>): boolean; override;
  end;

implementation

uses
  SysUtils,
  DDC.Resource,
  System.Rtti,
  DDC.Core.Reflection,
  Data.DB;

const
  M1EstadoDAOFind = 'M1EstadoDAOFind';

  { TDAOEstado }


procedure TDAOEstado.Save(var AModel: TEstadoModel);
  procedure Update;
  begin
    FUpdate.Limpar;
    FUpdate.Add('DSC', FModel.Descricao);
    FUpdate.Add('DTM', now);
    FUpdate.AddWhere('COD', FModel.Codigo);
    FUpdate.SetTabela('TRSEST01');
    FSqlConnection.Execute(FUpdate.SQL, FUpdate.Params);
  end;

  procedure Insert;
  begin
    FInsert.Limpar;
    FInsert.Add('COD', FModel.Codigo);
    FInsert.Add('DSC', FModel.Descricao);
    FInsert.Add('DTC', date);
    FInsert.Add('DTM', date);
    FInsert.SetTabela('TRSEST01');
    FSqlConnection.Execute(FInsert.SQL, FInsert.Params);
  end;

begin
  inherited;

  if Find(AModel, false) then
    Update
  else
    Insert;
end;




procedure TDAOEstado.SetModel(var AModel: TEstadoModel);
begin
  inherited;
  FModel := AModel;
end;





procedure TDAOEstado.Delete(var AModel: TEstadoModel);
begin
  inherited;
  { TODO: find se existe...
    update set dtx
  }
end;



function TDAOEstado.Find(var AModel: TEstadoModel; const ASetModel: boolean = true): boolean;
begin
  inherited;
{$IFDEF USE_SYSMO_LIBS}
  { TODO -oDorival -cHelper : Trocar por um helper que abra o dataset }
  FSQLDataSet.Close;

  FSQLDataSet.CommandText               := TResource.ToString(M1EstadoDAOFind);
  FSQLDataSet.Params.ParamValues['COD'] := FModel.Codigo;

  FSQLDataSet.Open;
  result := not(FSQLDataSet.IsEmpty);

  if not(ASetModel) then
    exit;

  if result then
  begin
    FModel.Codigo            := FSQLDataSet.FieldByName('COD').AsInteger;
    FModel.Descricao         := FSQLDataSet.FieldByName('DSC').AsString;
    FModel.DescricaoReduzida := FSQLDataSet.FieldByName('DSR').AsString;
    FModel.DataCadatro       := FSQLDataSet.FieldByName('DTC').AsDateTime;
    FModel.DataManutencao    := FSQLDataSet.FieldByName('DTM').AsDateTime;
    FModel.Usuario           := FSQLDataSet.FieldByName('USR').AsInteger;
  end
  else
    FModel.Clear;
{$ELSE}
  result := false;
{$ENDIF}
end;



function TDAOEstado.FindAll(var AListModel: TObjectList<TEstadoModel>): boolean;
begin
  { TODO: fazer o find all }
  result := false;
end;

end.

