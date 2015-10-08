unit FM.UI.View.Factory;

interface

uses
  Generics.Collections,
  System.SysUtils,
  Vcl.Controls,
  Vcl.Forms,
  FM.UI.BaseForm,
  FM.Controller.Base.Impl,
  DDC.Singleton;

const
  UniqueInstance: Boolean = True;

type
  TView = TBaseFormView;
  TViewClass = TBaseFormViewClass;
  TControllerClass = TControllerBaseClass;

  TAfterNotificationProc = reference to procedure(View: TView);

  TViewInfo = record
    Unique: Boolean;
    ViewClass: TViewClass;
    ControllerClass: TControllerClass;
  end;

  TViewFactory = class
  private
    class function GetControllerClassID(const ControllerClassName: string): TGUID; static;
    class function GetControllerClass(const ID: TGUID): TControllerClass; static;
    class function GetViewClassID(const ViewClassName: string): TGUID; static;
    class function GetViewClass(const ID: TGUID): TViewClass; static;
    class function GetViewInfo(const ID: TGUID): TViewInfo; overload; static;
    class function IsDashBoard(const ID: TGUID): Boolean; static;
  public
    class function InvokeCreateView(const ID: TGUID): TView; overload; static;
    class function InvokeCreateView(ViewClass: TViewClass; ControllerClass: TControllerClass): TView; overload; static;
    class function InvokeShow(const ID: TGUID): TView; overload; static;
    class function InvokeShow(const ID: TGUID; AfterNotificationProc: TAfterNotificationProc): TView; overload; static;
    class function InvokeShowModal(const ID: TGUID): TModalResult; static;
  end;

  TCreateViewEvent = procedure(View: TView; ID: TGUID) of object;
  TCreateFormEvent = function(FormClass: TFormClass): TForm of object;

  TViewRegistry = class(TSingleton<TViewRegistry>)
  private
    type
      TViewInfoList = TDictionary<TGUID, TViewInfo>;
  private
    FDashboardID: TGUID;
    FItems: TViewInfoList;
    FOnAfterCreateView: TCreateViewEvent;
    FOnCreateForm: TCreateFormEvent;
    function GetItems(const ID: TGUID): TViewInfo;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    procedure Add(const ID: TGUID; ViewClass: TViewClass; ControllerClass: TControllerClass; Unique: Boolean = False); overload;
    property DashboardID: TGUID read FDashboardID write FDashboardID;
    property Items[const ID: TGUID]: TViewInfo read GetItems; default;
    property OnAfterCreateView: TCreateViewEvent read FOnAfterCreateView write FOnAfterCreateView;
    property OnCreateForm: TCreateFormEvent read FOnCreateForm write FOnCreateForm;
  end;

  EViewFactory = class(Exception);

function ViewRegistry: TViewRegistry;

implementation

uses
  DDC.Notification.Service, FM.Security.Interceptor;

resourcestring
  SCreateFormEventNotAssigned = 'ViewRegistry.OnCreateForm not Assigned.';

function ViewRegistry: TViewRegistry;
begin
  Result := TViewRegistry.Instance;
end;

{ TFormFactory }

class function TViewFactory.InvokeCreateView(const ID: TGUID): TView;
var
 ViewClass: TViewClass;
 ControllerClass: TControllerClass;
begin
  ViewClass := GetViewClass(ID);
  ControllerClass := GetControllerClass(ID);

  if IsDashBoard(ID) then
   Result := ViewClass.Create(Application)
  else
   Result := InvokeCreateView(ViewClass, ControllerClass);

  if (Result <> nil) and Assigned(ViewRegistry.OnAfterCreateView) then
  begin
    ViewRegistry.OnAfterCreateView(Result, ID);
  end;
end;

class function TViewFactory.GetViewClassID(const ViewClassName: string): TGUID;
var
  ID: TGUID;
  ViewInfo: TViewInfo;
begin
  ID := TGUID.Empty;

  for ID in ViewRegistry.FItems.Keys do
  begin
    ViewInfo := ViewRegistry.FItems.Items[ID];
    if Assigned(ViewInfo.ViewClass) and (ViewInfo.ViewClass.ClassName = ViewClassName) then
     Exit(ID);
  end;
end;

class function TViewFactory.InvokeCreateView(ViewClass: TViewClass; ControllerClass: TControllerClass): TView;
begin
  Result := nil;
  if ViewClass.InheritsFrom(TForm) then
  begin
    if Assigned(ViewRegistry.OnCreateForm) then
      Result := TView(ViewRegistry.OnCreateForm(TFormClass(ViewClass)))
    else
      Result := ViewClass.Create(Application);

    Result.Controller := ControllerClass.Create;

    TSecurityInterceptor.Apply(Result);
  end;
end;

class function TViewFactory.IsDashBoard(const ID: TGUID): Boolean;
begin
  Result := ID = ViewRegistry.DashboardID;
end;

class function TViewFactory.GetControllerClass(
  const ID: TGUID): TControllerClass;
begin
  Result := GetViewInfo(ID).ControllerClass;
end;

class function TViewFactory.GetControllerClassID(
  const ControllerClassName: string): TGUID;
var
  ID: TGUID;
  ViewInfo: TViewInfo;
begin
  ID := TGUID.Empty;

  for ID in ViewRegistry.FItems.Keys do
  begin
    ViewInfo := ViewRegistry.FItems.Items[ID];
    if Assigned(ViewInfo.ControllerClass) and (ViewInfo.ControllerClass.ClassName = ControllerClassName) then
     Exit(ID);
  end;
end;

class function TViewFactory.GetViewClass(const ID: TGUID): TViewClass;
begin
  Result := GetViewInfo(ID).ViewClass;
end;

class function TViewFactory.GetViewInfo(const ID: TGUID): TViewInfo;
begin
  Result := ViewRegistry.Items[ID];
end;

class function TViewFactory.InvokeShow(const ID: TGUID): TView;
begin
  Result := InvokeCreateView(ID);
  Result.Show;
end;

class function TViewFactory.InvokeShow(const ID: TGUID;
  AfterNotificationProc: TAfterNotificationProc): TView;
begin
  Result := InvokeShow(ID);
  if Assigned(AfterNotificationProc) then
   AfterNotificationProc(Result);
end;

class function TViewFactory.InvokeShowModal(const ID: TGUID): TModalResult;
var
 View: TView;
begin
  View := InvokeCreateView(ID);
  try
    if View.InheritsFrom(TForm) then
      Result := TForm(View).ShowModal
    else
      Result := mrNone;
  finally
    View.Free;
  end;
end;

{ TViewRegistry }

procedure TViewRegistry.Add(const ID: TGUID; ViewClass: TViewClass; ControllerClass: TControllerClass; Unique: Boolean = False);
var
  ViewInfo: TViewInfo;
begin
  ViewInfo.ViewClass := ViewClass;
  ViewInfo.ControllerClass := ControllerClass;
  ViewInfo.Unique := Unique;
  FItems.AddOrSetValue(ID, ViewInfo);
end;

procedure TViewRegistry.AfterConstruction;
begin
  inherited;
  FItems := TViewInfoList.Create;
end;

procedure TViewRegistry.BeforeDestruction;
begin
  inherited;
  FItems.Free;
end;

function TViewRegistry.GetItems(const ID: TGUID): TViewInfo;
begin
  Result := FItems[ID];
end;

end.

