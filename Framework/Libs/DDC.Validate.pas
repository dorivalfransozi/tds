unit DDC.Validate;

interface

uses
  System.Rtti;

type
  IValidate = interface
    ['{BEC53519-B865-4283-ADEA-A5D72BF0703B}']
    function isValid(const AValue: TValue): Boolean;
    function GetErrorMessage: string;
  end;

implementation

end.
