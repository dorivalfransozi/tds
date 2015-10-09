unit DDC.Validator.Extend;

interface

uses
  System.Rtti;

type
  TExtendValidation = record
    Value: TValue;
    ErrorMessage: string;
    constructor Create(const AValue: TValue; const AErrorMessage: String);
  end;

implementation


{ TExtendValidation }



constructor TExtendValidation.Create(const AValue: TValue;
  const AErrorMessage: String);
begin
  Value        := AValue;
  ErrorMessage := AErrorMessage
end;

end.
