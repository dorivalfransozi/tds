unit DDC.Singleton;
interface

uses
  Classes,
  Windows;

type
 ///	<summary>
 ///    Permite implementar o design pattern Singleton de forma simples, r�pida e thread-safe.
 ///    <br />Design pattern Singleton � definico como: Garante utiliza��o de uma �nica inst�ncia
 ///     de uma classe e disponibiliza uma forma de acesso global a ela. <br />
 ///    Refer�ncia: http://docs.google.com/View?id=dfqjvfjv_139ggzk9r2
 ///	</summary>
 ///	<typeparam name="T">
 ///	  Classe que ser� aplicado o Singleton, ver exemplo a seguir.
 ///	</typeparam>
 ///	<remarks>
 ///	  N�o sobreescreva o constructor Create nem o destructor Destroy, pois a
 ///	  classe TSingleton implementa seu c�digo e por padr�o gera uma exce��o
 ///	  para manter o funcionamento estipulado pelo design pattern Singleton.
 ///	  <list type="number">
 ///	    <item>
 ///        Use a class property chamada Instance para pegar uma inst�ncia da singleton.
 ///	    </item>
 ///	    <item>
 ///        Uma classe concreta de TSingleton pode sobreescrever os M�todos AfterConstruction
 ///        e BeforeDestruction se necess�rio.
 ///	      <para>
 ///	        <b>AfterConstruction</b> � disparado ap�s a constru��o da classe e
 ///	        utilizado como Construtor. Este � o local correto para se
 ///	        inst�nciar qualquer Field da classe TNotificationService que
 ///	        necessite ser compartilhando durante todo o ciclo de vida do
 ///	        objeto.
 ///	      </para>
 ///	      <para>
 ///	        <b>BeforeDestruction</b> Disparado antes da inst�ncia da classe
 ///	        ser Destruida. Este � o local correto para se desinst�nciar
 ///	        qualquer Field da classe TNotificationService que tenha sido
 ///	        compartilhado durante todo o ciclo de vida do objeto.
 ///	      </para>
 ///	    </item>
 ///	    <item>
 ///        N�o chame diretamente os met�dos Create/Free ou uma excess�o do tipo
 ///        EInvalidOperation ser� levantada.
 ///	    </item>
 ///	  </list>
 ///	  <code>
 ///	   TApplicationContext = class(TSingleton&lt;TApplicationContext&gt;)
 ///	   public
 ///	     procedure AfterConstruction; override;
 ///	     procedure BeforeDestruction; override;
 ///	   end;
 ///
 ///	  </code>
 ///	</remarks>
 TSingleton<T: class> = class abstract
  strict private
    class var FInstance: T;
    class destructor Destroy;
    class function GetInstance: T; static;
    class function CreateSingleton: T; static;
    class procedure FreeSingleton(var Instance: T); static;
  public
    constructor Create;
    destructor Destroy; override;
    class property Instance: T read GetInstance;
  end;

resourcestring
  SInvalidOperationSingletonCreate   = 'Utilize a class property TSingleton<T>.Instance.';
  SInvalidOperationSingletonDestroy  = 'Opera��es inv�lidas: Free e Destroy';
  
implementation

uses
  SysUtils;

class destructor TSingleton<T>.Destroy;
begin
  FreeSingleton(FInstance);
end;

class function TSingleton<T>.GetInstance: T;
var
  NewInstance: T;
begin
  if FInstance = nil then
  begin
    NewInstance := CreateSingleton;
    if InterlockedCompareExchangePointer(PPointer(@FInstance)^, PPointer(@NewInstance)^, nil) <> nil then
      TSingleton<T>(NewInstance).FreeInstance
    else
      TSingleton<T>(NewInstance).AfterConstruction;
  end;
  Result := FInstance;
end;

class function TSingleton<T>.CreateSingleton: T;
begin
  Result := T(T.NewInstance);
end;

class procedure TSingleton<T>.FreeSingleton(var Instance: T);
begin
  if Instance <> nil then
  begin
    TSingleton<T>(Instance).BeforeDestruction;
    TSingleton<T>(Instance).FreeInstance;
    Instance := nil;
  end;
end;

constructor TSingleton<T>.Create;
begin
  raise EInvalidOperation.Create(SInvalidOperationSingletonCreate);
end;

destructor TSingleton<T>.Destroy;
begin
  if ExceptObject = nil then
    raise EInvalidOperation.Create(SInvalidOperationSingletonDestroy);
end;

end.
