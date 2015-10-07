unit FM.DAO.Base.Impl;

interface

uses
  FM.DAO.Base, SysmoSQL, DDC.Attributes,
  System.Generics.Collections,
  Helper.HSQLBuilder;

type
  TFMTableName = DDC.Attributes.TFMTableName;
  TFMCollumnName = DDC.Attributes.TFMCollumnName;
  TFMVisible = DDC.Attributes.TFMVisible;


  TDAOBase = class(TInterfacedObject, IDAO)
  protected
    FSqlConnection: TPSQLConnection;
    FSqlDataSet: TPSQLDataSet;
    FInsert: TSQLBuilderInsert;
    FUpdate: TSQLBuilderUpdate;
    procedure SetModel(var AModel: TModelBase); virtual; abstract;
  public
    constructor Create; overload;
    destructor Destroy; override;

    procedure Save(var AModel: TModelBase); virtual;
    procedure Delete(var AModel: TModelBase); virtual;
    function Find(var AModel: TModelBase; const ASetModel: boolean=true): boolean; virtual;
    function FindAll(var AListModel: TObjectList<TModelBase>): boolean; virtual;
  end;


implementation

uses
  Helper.DB.HConexao;

{ TDAOBase }

constructor TDAOBase.Create;
begin
  inherited Create;
  FSqlConnection := TPSQLConnection.Create(nil);
  THlpConexao.Conectar(FSqlConnection);
  { TODO: testar se conexao funcionou...  }

  FInsert := TSQLBuilderInsert.Create(FSqlConnection);
  FUpdate := TSQLBuilderUpdate.Create(FSqlConnection);

  FSqlDataSet    := TPSQLDataSet.Create(nil);
  FSqlDataSet.SQLConnection := FSqlConnection;
  FSqlDataSet.GetMetadata := false;
end;

procedure TDAOBase.Delete(var AModel: TModelBase);
begin
  SetModel(AModel);
end;

destructor TDAOBase.Destroy;
begin
  FUpdate.Free;
  FInsert.Free;
  FSqlDataSet.Free;
  FSqlConnection.Free;

  inherited;
end;

function TDAOBase.Find(var AModel: TModelBase;
  const ASetModel: boolean): boolean;
begin
  SetModel(AModel);
end;

function TDAOBase.FindAll(var AListModel: TObjectList<TModelBase>): boolean;
begin
end;

procedure TDAOBase.Save(var AModel: TModelBase);
begin
  SetModel(AModel);
end;

end.
