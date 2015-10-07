unit FM.Security.Interceptor;

interface

uses
  System.Rtti,
  FM.UI.View.Factory;

  type
   TSecurityInterceptor = class
   public
     class procedure Apply(View: TView);
   end;


implementation

{ TSecurityInterceptor }

class procedure TSecurityInterceptor.Apply(View: TView);
begin

end;

end.
