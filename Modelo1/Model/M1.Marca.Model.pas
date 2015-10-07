unit M1.Marca.Model;

interface

uses
  FM.Model.Base;

type
  TModelBase = FM.Model.Base.TModelBase;

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
    property Codigo: integer read FCodigo write SetCodigo;
    property Descricao: string read FDescricao write SetDescricao;
    property DescricaoReduzida: string read FDescricaoReduzida write SetDescricaoReduzida;
    property DataCadatro: TDateTime read FDataCadatro write SetDataCadatro;
    property DataManutencao: TDateTime read FDataManutencao write SetDataManutencao;
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
  if Value.IsEmpty then
    raise ExceptionValidation.Create(TResourceStrings.RSConteudoInvalido);
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
