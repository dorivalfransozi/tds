unit FM.Security.Interceptor;

interface

uses
  System.Rtti,
  FM.UI.View.Factory;

  type
   TSecurityInterceptor = class
   private
     class function GetAcessoMethodName(View: TObject): string;
     class function GetSalvarMethodName(View: TObject): string;
     class function GetExcluirMethodName(View: TObject): string;
     class function GetConfigMethodName(View: TObject): string;
     class function GetAgendarMethodName(View: TObject): string;
     class function GetDispositivoMethodName(View: TObject): string;
   public
     class procedure Apply(View: TView);
   end;




implementation

uses
  FM.UI.Cadastro;

var
 _CRUDInterceptor: TVirtualMethodInterceptor;

{ TSecurityInterceptor }

const
  IdAcesso  = 1; //Acesso ao programa
  IdSalvar  = 2; //Botão Salvar
  IdExcluir = 3; //Botão Excluir
  IdConfig  = 4; //Botão Config
  IdAgendar = 5; //Botão Agendar
  IdDisp    = 9; //Dispositivo fixo

function PermiteAcesso(IdSalvar: Byte; Tag: Integer; Mobile: Boolean = False): Boolean;
begin
  Result := False; //Mockeeeeed old behavior
end;

class procedure TSecurityInterceptor.Apply(View: TView);
var
 Interceptor: TVirtualMethodInterceptor;
begin
  Assert(View <> nil, 'View não pode estar vazia para aplicar interceptor.');

  if View.InheritsFrom(TFormCadastro) then
   begin
    Interceptor := TVirtualMethodInterceptor.Create(View.ClassType);
    try
      Interceptor.OnBefore :=
        procedure(Instance: TObject; Method: TRttiMethod;
          const Args: TArray<TValue>; out DoInvoke: Boolean; out Result: TValue)
        begin
//          DoInvoke := True;
//          if Method.Name = GetAcessoMethodName(View) then
//            DoInvoke := PermiteAcesso(IdAcesso, 1);

          if Method.Name = GetSalvarMethodName(Instance) then
            DoInvoke := PermiteAcesso(IdSalvar, 1);

          if Method.Name = GetExcluirMethodName(Instance) then
            DoInvoke := PermiteAcesso(IdExcluir, 1);

          if Method.Name = GetConfigMethodName(Instance) then
            DoInvoke := PermiteAcesso(IdConfig, 1);

//          if Method.Name = GetAgendarMethodName(Instance) then
//            DoInvoke := PermiteAcesso(IdAgendar, 1);

//          if Method.Name = GetDispositivoMethodName(Instance) then
//            DoInvoke := PermiteAcesso(IdDisp, 1);
        end;

//       Interceptor.Proxify(View);

    finally
      Interceptor.Free;
    end;
   end;
end;

class function TSecurityInterceptor.GetAcessoMethodName(View: TObject): string;
begin
  Result := TFormCadastro.MethodName(@TFormCadastro(View).OnCreate)
end;

class function TSecurityInterceptor.GetAgendarMethodName(View: TObject): string;
begin
  Result := '';
//  Result := TFormCadastro.MethodName(@TFormCadastro(View).BtnAgendar.OnClick)
end;

class function TSecurityInterceptor.GetConfigMethodName(View: TObject): string;
begin
  Result := TFormCadastro.MethodName(@TFormCadastro(View).BtnConfigurar.OnClick)
end;

class function TSecurityInterceptor.GetDispositivoMethodName(View: TObject): string;
begin
  Result := '';
//  Result := TFormCadastro.MethodName(@TFormCadastro(View).BtnDispositivo.OnClick)
end;

class function TSecurityInterceptor.GetExcluirMethodName(View: TObject): string;
begin
  Result := TFormCadastro.MethodName(@TFormCadastro(View).BtnExcluir.OnClick)
end;

class function TSecurityInterceptor.GetSalvarMethodName(View: TObject): string;
begin
  Result := TFormCadastro.MethodName(@TFormCadastro(View).BtnSalvar.OnClick)
end;


end.
