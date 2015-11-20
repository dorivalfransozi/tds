unit M1.Marca.Model;

interface

uses
  FM.Model.Base,
  DDC.Validator.Impl;

type
  TModelBase = FM.Model.Base.TModelBase;

  // [TFMTableName('GCEMRC01')]
  TMarcaModel = class(TModelBase)
  private
    FCodigo: integer;
    FDescricao: string;
    FDescricaoReduzida: string;
    FDataCadatro: TDateTime;
    FDataManutencao: TDateTime;
    FUsuario: integer;
  public
    // [TFMCollumnName('COD'), TFMVisible(True)]
    [TColumnTitle('C�digo')]
    [TIsNaturalNoZero, TMaxValue(100), TMinValue(1)] // <-- valida��es
    property Codigo: integer read FCodigo write FCodigo;

    // [TFMCollumnName('DSC'), TFMVisible(True)]
    [TColumnTitle('Descri��o')]
    [TRequired, TMinLength(10), TMaxLength(30)] // <-- valida��es
    property Descricao: string read FDescricao write FDescricao;

    // [TFMCollumnName('DSR'), TFMVisible(True)]
    [TColumnTitle('Descri��o reduzida')]
    [TRequired, TMinLength(5), TMaxLength(10)] // <-- valida��es
    property DescricaoReduzida: string read FDescricaoReduzida write FDescricaoReduzida;

    // [TFMCollumnName('DTC'), TFMVisible(True)]
    property DataCadatro: TDateTime read FDataCadatro write FDataCadatro;

    // [TFMCollumnName('DTM'), TFMVisible(False)]
    property DataManutencao: TDateTime read FDataManutencao write FDataManutencao;

    // [TFMCollumnName('USR'), TFMVisible(False)]
    //[TExists('sgrusr01', 'cod'), TIsUnique('sgrusr01', 'cod')]
    property Usuario: integer read FUsuario write FUsuario;
  end;

implementation

end.
