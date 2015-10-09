unit DDC.Validate.CustomAttribute;

interface

uses
  System.Rtti;

type
  TValidateCustomAttribute = class(TCustomAttribute, IInterface)
  private
    FCustomErrorMessage: String;
    FColumnTitle: String;
    FValue: TValue;
  protected
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;

    property CustomErrorMessage: String read FCustomErrorMessage write FCustomErrorMessage;
    property ColumnTitle: String read FColumnTitle write FColumnTitle;
    property Value: TValue read FValue write FValue;
  end;

implementation

{ TValidateCustomAttribute }



function TValidateCustomAttribute.QueryInterface(const IID: TGUID;
  out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := S_OK
  else
    Result := E_NOINTERFACE;
end;



function TValidateCustomAttribute._AddRef: Integer;
begin
  Result := -1;
end;



function TValidateCustomAttribute._Release: Integer;
begin
  Result := -1;
end;

end.
