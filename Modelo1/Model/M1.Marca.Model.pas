unit M1.Marca.Model;

interface

uses
  FM.Model.Base,
  DDC.Validator;

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
    [TIsNaturalNoZero('C�digo'), TMaxValue(100, 'C�digo'), TMinValue(1, 'C�digo')]
    // <-- valida��es
    property Codigo: integer read FCodigo write FCodigo;

    // [TFMCollumnName('DSC'), TFMVisible(True)]
    [TRequired('Descri��o'), TMinLength(10, 'Descri��o'), TMaxLength(30, 'Descri��o')]
    // <-- valida��es
    property Descricao: string read FDescricao write FDescricao;

    // [TFMCollumnName('DSR'), TFMVisible(True)]
    [TRequired('Descri��o reduzida'), TMinLength(5, 'Descri��o reduzida'), TMaxLength(10, 'Descri��o reduzida')]
    // <-- valida��es
    property DescricaoReduzida: string read FDescricaoReduzida write FDescricaoReduzida;

    // [TFMCollumnName('DTC'), TFMVisible(True)]
    property DataCadatro: TDateTime read FDataCadatro write FDataCadatro;

    // [TFMCollumnName('DTM'), TFMVisible(False)]
    property DataManutencao: TDateTime read FDataManutencao write FDataManutencao;

    // [TFMCollumnName('USR'), TFMVisible(False)]
    property Usuario: integer read FUsuario write FUsuario;

    function New: TModelBase; override;
  end;

implementation

uses
  SysUtils;

{ TMarcaModel }



function TMarcaModel.New: TModelBase;
begin
  Result := TMarcaModel.Create;
end;

end.
