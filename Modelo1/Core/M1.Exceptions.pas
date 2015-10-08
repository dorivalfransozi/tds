unit M1.Exceptions;

interface

uses
  System.SysUtils;

type

  ExceptionValidation = class(Exception);
  ExceptionValidationError = class(ExceptionValidation);
  ExceptionValidationInfo = class(ExceptionValidation);

implementation

end.
