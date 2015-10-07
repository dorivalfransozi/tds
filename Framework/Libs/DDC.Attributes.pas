unit DDC.Attributes;

interface

uses
  System.Rtti;

type

  TFMTableName = class(TCustomAttribute)
  private
    FTableName: string;
  public
    property TableName: string read FTableName write FTableName;
    constructor Create(ATableName: String);
  end;

  TFMCollumnName = class(TCustomAttribute)
  private
    FCollumnName: string;
  public
    property CollumnName: string read FCollumnName write FCollumnName;
    constructor Create(ACollumnName: String);
  end;

  TFMVisible = class(TCustomAttribute)
  private
    FVisible: boolean;
  public
    property Visible: boolean read FVisible write FVisible;
    constructor Create(AVisible: boolean);
  end;


implementation

{ TFMCollumnName }

constructor TFMCollumnName.Create(ACollumnName: String);
begin
  CollumnName := ACollumnName;
end;

{ TFMTableName }

constructor TFMTableName.Create(ATableName: String);
begin
  TableName := ATableName;
end;

{ TFMVisible }

constructor TFMVisible.Create(AVisible: boolean);
begin
  Visible := AVisible;
end;

end.
