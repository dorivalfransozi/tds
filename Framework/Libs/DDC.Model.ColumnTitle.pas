unit DDC.Model.ColumnTitle;

interface

type
  TColumnTitle = class(TCustomAttribute)
  private
    FColumnTitle: String;
  public
    constructor Create(const AColumnTitle: String);
    function GetColumnTitle: String;
  end;

implementation

{ TColumnTitle }



constructor TColumnTitle.Create(const AColumnTitle: String);
begin
  FColumnTitle := AColumnTitle;
end;



function TColumnTitle.GetColumnTitle: String;
begin
  Result := FColumnTitle
end;

end.
