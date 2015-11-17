unit DDC.Validator.Extend;

interface

uses
  System.Rtti;

type
  TExtendValidation = record
    AttributeName: String;
    Value: TValue;
    ErrorMessage: string;
    constructor Create(const AAttributeName: string; const AValue: TValue; const AErrorMessage: String);
  end;

implementation


{ TExtendValidation }



constructor TExtendValidation.Create(const AAttributeName: string; const AValue: TValue; const AErrorMessage: String);
begin
  AttributeName := AAttributeName;
  Value        := AValue;
  ErrorMessage := AErrorMessage
end;

end.
