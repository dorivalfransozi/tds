unit M1.Marca.Model;

interface

uses
  FM.Model.Base;

type
  TModelBase = FM.Model.Base.TModelBase;

  [TFMTableName('GCEMRC01')]
  TMarcaModel = class(TModelBase)
  private
    FCodigo: integer;
    FDescricao: string;
    FDescricaoReduzida: string;
    FDataCadatro: TDateTime;
    FDataManutencao: TDateTime;
    FUsuario: integer;
    procedure SetCodigo(const Value: integer);
    procedure SetDescricao(const Value: string);
    procedure SetDescricaoReduzida(const Value: string);
    procedure SetDataCadatro(const Value: TDateTime);
    procedure SetDataManutencao(const Value: TDateTime);
    procedure SetUsuario(const Value: integer);
  public
    [TFMCollumnName('COD'), TFMVisible(True)]
    property Codigo: integer read FCodigo write SetCodigo;
    [TFMCollumnName('DSC'), TFMVisible(True)]
    property Descricao: string read FDescricao write SetDescricao;
    [TFMCollumnName('DSR'), TFMVisible(True)]
    property DescricaoReduzida: string read FDescricaoReduzida write SetDescricaoReduzida;
    [TFMCollumnName('DTC'), TFMVisible(True)]
    property DataCadatro: TDateTime read FDataCadatro write SetDataCadatro;
    [TFMCollumnName('DTM'), TFMVisible(False)]
    property DataManutencao: TDateTime read FDataManutencao write SetDataManutencao;
    [TFMCollumnName('USR'), TFMVisible(False)]
    property Usuario: integer read FUsuario write SetUsuario;

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



procedure TMarcaModel.SetCodigo(const Value: integer);
begin
  FCodigo := Value;
end;



procedure TMarcaModel.SetDataCadatro(const Value: TDateTime);
begin
  FDataCadatro := Value;
end;



procedure TMarcaModel.SetDataManutencao(const Value: TDateTime);
begin
  FDataManutencao := Value;
end;



procedure TMarcaModel.SetDescricao(const Value: string);
begin
  {if Value.IsEmpty then
    raise ExceptionValidation.Create(TResourceStrings.RSConteudoInvalido); sai daqui pois sera no controller}
  FDescricao := Value;
end;



procedure TMarcaModel.SetDescricaoReduzida(const Value: string);
begin
  FDescricaoReduzida := Value;
end;



procedure TMarcaModel.SetUsuario(const Value: integer);
begin
  FUsuario := Value;
end;

end.
