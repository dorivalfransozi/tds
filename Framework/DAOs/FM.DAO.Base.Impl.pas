unit FM.DAO.Base.Impl;

interface

uses
  FM.DAO.Base, SysmoSQL,
  System.Generics.Collections;

type

  TDAOBase = class(TInterfacedObject, IDAO)
  protected
    FModel: TModelBase;
    FSqlConnection: TPSQLConnection;
    FSqlDataSet: TPSQLDataSet;
  public
    property Model: TModelBase read FModel write FModel;

    constructor Create(var AModel: TModelBase); overload; reintroduce;
    destructor Destroy; override;

    procedure Save(var AModel: TModelBase); virtual; abstract;
    procedure Delete(var AModel: TModelBase); virtual; abstract;
    function Find(var AModel: TModelBase): boolean; virtual; abstract;
    function FindAll(var AListModel: TObjectList<TModelBase>): boolean; virtual; abstract;
  end;


implementation

uses
  Helper.DB.HConexao;

{ TDAOBase }

constructor TDAOBase.Create(var AModel: TModelBase);
begin
  inherited;

  FSqlConnection := TPSQLConnection.Create(nil);
  THlpConexao.Conectar(FSqlConnection);
  { TODO: testar se conexao funcionou...  }

  FSqlDataSet    := TPSQLDataSet.Create(nil);
  FSqlDataSet.SQLConnection := FSqlConnection;
  FSqlDataSet.GetMetadata := false;

  FModel := AModel;
end;

destructor TDAOBase.Destroy;
begin
  FSqlDataSet.Free;
  FSqlConnection.Free;

  inherited;
end;

end.
