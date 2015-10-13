unit DDC.Validator;

interface

uses
  System.Classes,
  System.Rtti;

type
  TAnonymousExtendValidator = reference to function(const AValue: TValue): Boolean;

  IValidator<T: class> = interface
    ['{A3A5A5A9-899D-4D1D-BD29-CC2FE3A50585}']
    function MakeAttribute(const AModelAttribute: Pointer; const AExitOnFirstError: Boolean = False): IValidator<T>;
    function Make(const AModel: T; const AExitOnFirstError: Boolean = False): IValidator<T>;
    function Fails: Boolean;
    function ErrorMessages: TStringList;
    procedure AddExtend(const AValue: TValue; const AErrorMessage: String; const AValidator: TAnonymousExtendValidator);
  end;

implementation

end.
