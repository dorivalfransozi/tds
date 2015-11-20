unit M1.Estado.Model;

interface

uses
  FM.Model.Base,
  DDC.Validator.Impl;

type
  TModelBase = FM.Model.Base.TModelBase;

  TEstadoModel = class(TModelBase)
  private
    FCodigo: string;
    FDescricao: string;
    FUsuario: Integer;
  public
    [TExactLength(2), TRequired]
    [TColumnTitle('Código')]
    property Codigo: string read FCodigo write FCodigo;

    [TColumnTitle('Descrição')]
    [TRequired, TMinLength(1), TMaxLength(30)]
    property Descricao: string read FDescricao write FDescricao;
    property Usuario: Integer read FUsuario write FUsuario;

    function IsValid(const AAttribute: string): Boolean; override;
  end;

implementation

uses
  System.Rtti;

{ TEstadoModel }



function TEstadoModel.IsValid(const AAttribute: string): Boolean;
begin
  Validator.AddExtend('Usuario', Self.Usuario, 'Usuário inválido!',
    function(const AValue: TValue): Boolean
    begin
      Result := AValue.AsInteger = 0;
    end
    );

  Result := inherited IsValid(AAttribute);
end;

end.
