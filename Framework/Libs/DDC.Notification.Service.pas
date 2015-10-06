///	<summary>
///	  Cont�m classe respons�vel por realizar notifica��es entre classes e
///	  objetos.
///	</summary>
///	<remarks>
///	  N�o crie uma inst�ncia de TNotificationService, utilize a fun��o
///	  NotificationService.
///	</remarks>
unit DDC.Notification.Service;

interface

uses
  Classes,
  DDC.Singleton,
  Generics.Collections;

type
  ///	<summary>
  ///	  Utilizada para registrar e disparar notifica��es entre classes.
  ///	</summary>
  ///	<remarks>
  ///	  N�o crie uma inst�ncia de TNotificationService, utilize�o Singleton
  ///	  retornado pelo m�todo�NotificationService: TNotificationService.
  ///	</remarks>
  TNotificationService = class(TSingleton<TNotificationService>)
  private
    FSubscribers: TDictionary<TNotifyEvent, TGUID>;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    ///	<summary>
    ///	  Envia uma mensagem especificada pelo par�metro MessageID com ou sem�
    ///	  um objeto especificado.
    ///	</summary>
    ///	<param name="Sender">
    ///	  Objeto que ser� enviado ao receptor da Mensagem.
    ///	</param>
    ///	<param name="MessageID">
    ///	  Constante do tipo TGUID que id�ntifica o tipo de Notifica��o.
    ///	</param>
    ///	<remarks>
    ///	  Exemplo:
    ///	  <code>
    ///	    var
    ///	      Something: TSomething;
    ///	    begin
    ///	      Something := TSomething.Create;
    ///	      try
    ///	        NotificatioService.SendMessage(Something, NMMsgSomething);
    ///	      finally
    ///	        Something.Free;
    ///	      end;
    ///	    end;
    ///
    ///	  </code>
    ///	</remarks>
    procedure SendMessage(Sender: TObject; MessageID: TGUID);
    ///	<summary>
    ///	  Registra uma nova nova mensagem e seu respectivo metodo para�disparar
    ///	  a notifica��o.
    ///	</summary>
    ///	<param name="Event">
    ///	  Evento que dever� ser disparado quando o NotificationService receber
    ///	  a mensagem especificada pelo parametro MessageID.
    ///	</param>
    ///	<param name="MessageID">
    ///	  Constante do tipo TGUID que identifica o tipo de Notifica��o
    ///	  registrada.
    ///	</param>
    ///	<remarks>
    ///	  Exemplo:�
    ///   <code>NotificationService.Subscribe(DoSomething, NMMsgSomething);</code>
    ///	</remarks>
    procedure Subscribe(Event: TNotifyEvent; MessageID: TGUID);
    ///	<summary>
    ///	  Desregistra um evento pr�viamente registrado utilizando o M�todo
    ///	  Subscribe.
    ///	</summary>
    ///	<param name="Event">
    ///	  Evento que deve ser desregistrado.
    ///	</param>
    procedure UnSubscribe(Event: TNotifyEvent);
  end;

function NotificationService: TNotificationService;

implementation

function NotificationService: TNotificationService;
begin
 Result := TNotificationService.Instance;
end;

procedure TNotificationService.AfterConstruction;
begin
  inherited;
  FSubscribers := TDictionary<TNotifyEvent, TGUID>.Create;
end;

procedure TNotificationService.BeforeDestruction;
begin
  FSubscribers.Free;
  inherited;
end;

procedure TNotificationService.SendMessage(Sender: TObject; MessageID: TGUID);
var
  Pair: TPair<TNotifyEvent, TGUID>;
  SubscribersCount: Integer;
begin
  SubscribersCount := FSubscribers.Count;
  for Pair in FSubscribers do
  begin
    if (Pair.Value = MessageID) and (SubscribersCount = FSubscribers.Count) then
      Pair.Key(Sender);
  end;
end;

procedure TNotificationService.Subscribe(Event: TNotifyEvent; MessageID: TGUID);
begin
  FSubscribers.AddOrSetValue(Event, MessageID);
end;

procedure TNotificationService.UnSubscribe(Event: TNotifyEvent);
begin
  FSubscribers.Remove(Event);
end;

end.
