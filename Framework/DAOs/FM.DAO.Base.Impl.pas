unit FM.DAO.Base.Impl;

interface

uses
  FM.DAO.Base,

  DDC.Attributes,
  Helper.HSQLBuilder,
  SysmoSQL,
  System.Generics.Collections;

type
  TFMTableName = DDC.Attributes.TFMTableName;
  TFMCollumnName = DDC.Attributes.TFMCollumnName;
  TFMVisible = DDC.Attributes.TFMVisible;

  TDAOBase<T: class> = class(TInterfacedObject, IDAO<T>)
  protected
    FModel: T;
  protected
    FSqlConnection: TPSQLConnection;
    FSqlDataSet: TPSQLDataSet;
    FInsert: TSQLBuilderInsert;
    FUpdate: TSQLBuilderUpdate;
    FDelete: TSQLBuilderDelete;
    procedure SetModel(var AModel: T); virtual; abstract;
  public
    constructor Create; overload;
    destructor Destroy; override;

    procedure Save(var AModel: T); virtual;
    procedure Delete(var AModel: T); virtual;
    function Find(var AModel: T; const ASetModel: boolean = true): boolean; virtual;
    function FindAll(var AListModel: TObjectList<T>): boolean; virtual;

    property Model: T read FModel write FModel;
  end;

implementation

uses
  Helper.DB.HConexao;

{ TDAOBase }



constructor TDAOBase<T>.Create;
begin
  inherited Create;

  FSqlConnection := TPSQLConnection.Create(nil);
  THlpConexao.Conectar(FSqlConnection);

  FInsert := TSQLBuilderInsert.Create(FSqlConnection);
  FUpdate := TSQLBuilderUpdate.Create(FSqlConnection);
  FDelete := TSQLBuilderDelete.Create(FSqlConnection);

  FSqlDataSet               := TPSQLDataSet.Create(nil);
  FSqlDataSet.SQLConnection := FSqlConnection;
  FSqlDataSet.GetMetadata   := false;
end;



procedure TDAOBase<T>.Delete(var AModel: T);
begin
  SetModel(AModel);
end;



destructor TDAOBase<T>.Destroy;
begin
  FUpdate.Free;
  FInsert.Free;
  FDelete.Free;
  FSqlDataSet.Free;
  FSqlConnection.Free;

  inherited;
end;



function TDAOBase<T>.Find(var AModel: T;
  const ASetModel: boolean): boolean;
begin
  SetModel(AModel);
end;



function TDAOBase<T>.FindAll(var AListModel: TObjectList<T>): boolean;
begin
end;



procedure TDAOBase<T>.Save(var AModel: T);
begin
  SetModel(AModel);
end;

end.
