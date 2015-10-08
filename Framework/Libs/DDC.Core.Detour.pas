unit DDC.Core.Detour;

interface

type
  TXRedirCode = packed record
    Jump: Byte;
    Offset: Integer;
  end;

function GetVirtualMethodIndex(ClassType: TClass; Code: Pointer): Integer;
procedure HookCode(const Proc, Dest: Pointer; var BackupCode: TXRedirCode);
procedure OverrideVirtualMethod(ClassType: TClass; Index: Integer; Code: Pointer);
procedure PatchCode(const Proc, Dest: Pointer);
procedure UnhookCode(const Proc: Pointer; var BackupCode: TXRedirCode);
procedure WriteMem(const Location, Buffer: Pointer; const Size: Cardinal);

implementation

uses
  SysUtils,
  Windows;

resourcestring
  RMemoryWriteError = 'Error writing memory (%s)';

function GetVirtualMethodIndex(ClassType: TClass; Code: Pointer): Integer;
var
  p: PPointer;
begin
  Result := 0;
  p := PPointer(ClassType);
  while p^ <> Code do
  begin
    Inc(p);
    Inc(Result);
  end;
end;

procedure HookCode(const Proc, Dest: Pointer; var BackupCode: TXRedirCode);
var
  Code: TXRedirCode;
  ReadBytes: {$IF CompilerVersion > 22}NativeUInt{$ELSE}Cardinal{$IFEND};
begin
  if ReadProcessMemory(GetCurrentProcess, Proc, @BackupCode, SizeOf(BackupCode), ReadBytes) then
  begin
    Code.Jump := $E9;
    Code.Offset := PByte(Dest) - PByte(Proc) - SizeOf(Code);
    WriteProcessMemory(GetCurrentProcess, Proc, @Code, SizeOf(Code), ReadBytes);
  end;
end;

procedure OverrideVirtualMethod(ClassType: TClass; Index: Integer; Code: Pointer);
begin
  PatchCode(Pointer(NativeInt(ClassType) + SizeOf(Pointer) * Index), Code);
end;

procedure PatchCode(const Proc, Dest: Pointer);
begin
  WriteMem(Proc, @Dest, SizeOf(Pointer));
end;

procedure UnhookCode(const Proc: Pointer; var BackupCode: TXRedirCode);
var
  WrittenBytes: {$IF CompilerVersion > 22}NativeUInt{$ELSE}Cardinal{$IFEND};
begin
  if (BackupCode.Jump <> 0) and (Proc <> nil) then
  begin
    WriteProcessMemory(GetCurrentProcess, Proc, @BackupCode, SizeOf(BackupCode), WrittenBytes);
    BackupCode.Jump := 0;
  end;
end;

procedure WriteMem(const Location, Buffer: Pointer; const Size: Cardinal);
var
  WrittenBytes: {$IF COMPILERVERSION > 22}NativeUInt;{$ELSE}Cardinal;{$IFEND}
  SaveFlag: Cardinal;
begin
  if VirtualProtect(Location, Size, PAGE_EXECUTE_READWRITE, @SaveFlag) then
  try
    if not WriteProcessMemory(GetCurrentProcess, Location, Buffer, Size, WrittenBytes) then
      raise Exception.CreateResFmt(@RMemoryWriteError, [SysErrorMessage(GetLastError)]);
  finally
    VirtualProtect(Location, Size, SaveFlag, @SaveFlag);
  end;

  if WrittenBytes <> Size then
    raise Exception.CreateResFmt(@RMemoryWriteError, [IntToStr(WrittenBytes)]);

  FlushInstructionCache(GetCurrentProcess, Location, Size);
end;

end.
