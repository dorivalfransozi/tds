unit M1.Marca.DAO;

interface

uses
  FM.DAO.Base.Impl,
  M1.Marca.Model,
  System.Generics.Collections;

type

  TDAOMarca = class(TDAOBase<TMarcaModel>)
  public
    procedure Save(var AModel: TMarcaModel); override;
    procedure Delete(var AModel: TMarcaModel); override;
    function Find(var AModel: TMarcaModel; const ASetModel: boolean=true): boolean; override;
    function FindAll(var AListModel: TObjectList<TMarcaModel>): boolean; override;
  end;

implementation

uses
  SysUtils, DDC.Resource, System.Rtti,
  DDC.Core.Reflection;

const
  M1MarcaDAOFind = 'M1MarcaDAOFind';

{ TDAOMarca }

{$IFDEF USE_SYSMO_LIBS}
procedure TDAOMarca.Save(var AModel: TModelBase);
  procedure Update;
  begin
    FUpdate.Limpar;
    FUpdate.Add('DSC', FModel.Descricao);
    FUpdate.Add('DSR', FModel.DescricaoReduzida);
    FUpdate.Add('USR', FModel.Usuario);
    FUpdate.Add('DTM', now);
    FUpdate.AddWhere('COD', FModel.Codigo);
    FUpdate.SetTabela('GCEMRC01');
    FSqlConnection.Execute(FUpdate.SQL, FUpdate.Params);
  end;

  procedure Insert;
  begin
    FInsert.Limpar;
    FInsert.Add('COD', FModel.Codigo);
    FInsert.Add('DSC', FModel.Descricao);
    FInsert.Add('DSR', FModel.DescricaoReduzida);
    FInsert.Add('DTC', date);
    FInsert.Add('DTM', date);
    FInsert.Add('USR', FModel.Usuario);
    FInsert.SetTabela('GCEMRC01');
    FSqlConnection.Execute(FInsert.SQL, FInsert.Params);
  end;

begin
  inherited;

  if Find(AModel, false) then
    Update
  else
    Insert;
end;
{$ELSE}
procedure TDAOMarca.Save(var AModel: TMarcaModel);
begin

end;
{$ENDIF}




procedure TDAOMarca.Delete(var AModel: TMarcaModel);
begin
  inherited;
  { TODO: find se existe...
    update set dtx
  }
end;



function TDAOMarca.Find(var AModel: TMarcaModel; const ASetModel: boolean=true): boolean;
begin
  inherited;
{$IFDEF USE_SYSMO_LIBS}
  { TODO -oDorival -cHelper : Trocar por um helper que abra o dataset }
  FSQLDataSet.Close;

  FSQLDataSet.CommandText := TResource.ToString( M1MarcaDAOFind );
  FSQLDataSet.Params.ParamValues['COD'] := FModel.Codigo;

  FSQLDataSet.Open;
  result := not(FSQLDataSet.IsEmpty);

  if not(ASetModel) then
    exit;

  if result then
  begin
    FModel.Codigo            := FSQLDataSet.FieldByName( 'COD' ).AsInteger;
    FModel.Descricao         := FSQLDataSet.FieldByName( 'DSC' ).AsString;
    FModel.DescricaoReduzida := FSQLDataSet.FieldByName( 'DSR' ).AsString;
    FModel.DataCadatro       := FSQLDataSet.FieldByName( 'DTC' ).AsDateTime;
    FModel.DataManutencao    := FSQLDataSet.FieldByName( 'DTM' ).AsDateTime;
    FModel.Usuario           := FSQLDataSet.FieldByName( 'USR' ).AsInteger;
  end
  else
    FModel.Clear;
{$ENDIF}
end;



function TDAOMarca.FindAll(var AListModel: TObjectList<TMarcaModel>): boolean;
begin
  { TODO: fazer o find all }
end;


end.
