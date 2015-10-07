unit DDC.Resource;

interface

uses
 Windows,
 Classes,
 SysUtils;

type

  ///	<summary>
  ///	  Classe para manipulação e informações de recursos embutidos no programa.
  ///	</summary>
  TResource = class
  public
    class var Handle: NativeUInt;
    class constructor Create;

    class function ToString(const ResourceName: string): string; reintroduce; static;
    ///	<summary>
    ///	  Extrai um recurso do executável e salva.
    ///	</summary>
    ///	<param name="ResourceName">
    ///	  Nome do recurso a extrair.
    ///	</param>
    ///	<param name="FileName">
    ///	  Nome do arquivo para salvar.
    ///	</param>
    class procedure ToFile(const ResourceName, FileName: string); static;
    class procedure ToStrings(const ResourceName: string; Strings: TStrings); static;

    ///	<summary>
    ///	  Substitui uma resourcestring definida no Delphi.
    ///	</summary>
    ///	<param name="ResString">
    ///	  Resource a ser substituído, ex: @SMsgDlgYes
    ///	</param>
    ///	<param name="Value">
    ///	  Nova string para o resource, ex: 'Sim';
    ///	</param>
    /// <remarks>
    /// <code>
    /// uses
    ///   Vcl.Consts,
    ///   Vcl.Dialogs;
    ///  ...
    /// begin
    ///   TResource.SetString(@SMsgDlgInformation, 'Informação');
    ///   TResource.SetString(@SMsgDlgYes, 'Sim');
    ///   TResource.SetString(@SMsgDlgNo, 'Não');
    ///   TResource.SetString(@SMsgDlgCancel, 'Cancelar');
    ///   MessageDlg('Test', mtInformation, [mbYes, mbNo, mbCancel], 0);
    /// end;
    /// </code>
    /// </remarks>
    class procedure SetString(ResString: PResStringRec; const Value: string); overload; static;
    class procedure SetString(ResString: PResStringRec; Value: PChar); overload; static;
  end;


implementation

  { TResource }

class constructor TResource.Create;
begin
  TResource.Handle := 0;
end;

class procedure TResource.SetString(ResString: PResStringRec; Value: PChar);
var
  OldProtect: DWORD;
begin
  VirtualProtect(ResString, SizeOf(ResString^), PAGE_EXECUTE_READWRITE, @OldProtect);
  ResString^.Identifier := Integer(Value);
  VirtualProtect(ResString, SizeOf(ResString^), OldProtect, @OldProtect);
end;

class procedure TResource.SetString(ResString: PResStringRec; const Value: string);
begin
  TResource.SetString(ResString, PChar(Value));
end;

class procedure TResource.ToFile(const ResourceName, FileName: string);
var
  ResourceData: TResourceStream;
begin
  ResourceData := TResourceStream.Create(0, ResourceName, RT_RCDATA);
  try
    ResourceData.Position := 0;
    ResourceData.SaveToFile(FileName);
  finally
    ResourceData.Free;
  end;
end;

class function TResource.ToString(const ResourceName: string): string;
var
  Strings: TStringList;
begin
  Strings := TStringList.Create;
  try
    TResource.ToStrings(ResourceName, Strings);
    Result := Strings.Text;
  finally
    Strings.Free;
  end;
end;

class procedure TResource.ToStrings(const ResourceName: string; Strings: TStrings);
var
  ResourceData: TResourceStream;
begin
  Assert(Strings <> nil);
  ResourceData := TResourceStream.Create(TResource.Handle, ResourceName, RT_RCDATA);
  try
    ResourceData.Position := 0;
    Strings.Clear;
    Strings.LoadFromStream(ResourceData);
  finally
    ResourceData.Free;
  end;
end;

end.

