unit FM.DAO.Base.Impl;

interface

uses
  FM.DAO.Base,

  DDC.Attributes,
{$IFDEF USE_SYSMO_LIBS}
  Helper.HSQLBuilder,
  SysmoSQL,
{$ENDIF}
  System.Generics.Collections;

type
  TFMTableName = DDC.Attributes.TFMTableName;
  TFMCollumnName = DDC.Attributes.TFMCollumnName;
  TFMVisible = DDC.Attributes.TFMVisible;


  TDAOBase<T: class> = class(TInterfacedObject, IDAO<T>)
  protected
    FModel: T;
  protected
{$IFDEF USE_SYSMO_LIBS}
    FSqlConnection: TPSQLConnection;
    FSqlDataSet: TPSQLDataSet;
    FInsert: TSQLBuilderInsert;
    FUpdate: TSQLBuilderUpdate;
{$ENDIF}
    procedure SetModel(var AModel: T); virtual; abstract;
  public
    constructor Create; overload;
    destructor Destroy; override;

    procedure Save(var AModel: T); virtual;
    procedure Delete(var AModel: T); virtual;
    function Find(var AModel: T; const ASetModel: boolean=true): boolean; virtual;
    function FindAll(var AListModel: TObjectList<T>): boolean; virtual;

    property Model: T read FModel write FModel;
  end;


implementation

{$IFDEF USE_SYSMO_LIBS}
uses
  Helper.DB.HConexao;
{$ENDIF}

{ TDAOBase }

constructor TDAOBase<T>.Create;
begin
  inherited Create;

{$IFDEF USE_SYSMO_LIBS}
  FSqlConnection := TPSQLConnection.Create(nil);
  THlpConexao.Conectar(FSqlConnection);
  { TODO: testar se conexao funcionou...  }

  FInsert := TSQLBuilderInsert.Create(FSqlConnection);
  FUpdate := TSQLBuilderUpdate.Create(FSqlConnection);

  FSqlDataSet    := TPSQLDataSet.Create(nil);
  FSqlDataSet.SQLConnection := FSqlConnection;
  FSqlDataSet.GetMetadata := false;
{$ENDIF}
end;

procedure TDAOBase<T>.Delete(var AModel: T);
begin
  SetModel(AModel);
end;

destructor TDAOBase<T>.Destroy;
begin
{$IFDEF USE_SYSMO_LIBS}
  FUpdate.Free;
  FInsert.Free;
  FSqlDataSet.Free;
  FSqlConnection.Free;
{$ENDIF}

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