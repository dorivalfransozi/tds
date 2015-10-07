unit M1.Marca.DAO;

interface

uses
  FM.DAO.Base.Impl,
  M1.Marca.Model,
  System.Generics.Collections;

type

  TDAOMarca = class(TDAOBase)
  private
    function GetModel: TMarcaModel;
  public
    procedure Save(var AModel: TModelBase); override;
    procedure Delete(var AModel: TModelBase); override;
    function Find(var AModel: TModelBase): boolean; override;
    function FindAll(var AListModel: TObjectList<TModelBase>): boolean; override;
  end;

implementation

uses
  SysUtils;



{ TDAOMarca }
procedure TDAOMarca.Save(var AModel: TModelBase);
begin
  inherited;
  { TODO: find se existe...
    update
    else
    insert }
end;



procedure TDAOMarca.Delete(var AModel: TModelBase);
begin
  inherited;
  { TODO: find se existe...
    update set dtx
  }
end;



function TDAOMarca.Find(var AModel: TModelBase): boolean;
begin
  { TODO -oDorival -cHelper : Trocar por um helper que abra o dataset }

  FSQLDataSet.Close;
  FSQLDataSet.CommandText := 'select COD, DSC, DSR, DTC, DTM, USR from GCEMRC01 where COD = ' + GetModel.Codigo.ToString;
  FSQLDataSet.Open;
  result := not FSQLDataSet.IsEmpty;
  if result then
  begin
    GetModel.Codigo            := FSQLDataSet.FieldByName('COD').AsInteger;
    GetModel.Descricao         := FSQLDataSet.FieldByName('DSC').AsString;
    GetModel.DescricaoReduzida := FSQLDataSet.FieldByName('DSR').AsString;
    GetModel.DataCadatro       := FSQLDataSet.FieldByName('DTC').AsDateTime;
    GetModel.DataManutencao    := FSQLDataSet.FieldByName('DTM').AsDateTime;
    GetModel.Usuario           := FSQLDataSet.FieldByName('USR').AsInteger;
  end
  else
    GetModel.ClearAll;
end;



function TDAOMarca.FindAll(var AListModel: TObjectList<TModelBase>): boolean;
begin
  { TODO: fazer o find all }
end;



function TDAOMarca.GetModel: TMarcaModel;
begin
  result := TMarcaModel(FModel);
end;

end.
