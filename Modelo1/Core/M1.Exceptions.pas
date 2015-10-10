unit M1.Exceptions;

interface

uses
  System.SysUtils;

type

  ExceptionValidationWarning = class(Exception);
  ExceptionValidationError = class(Exception);
  ExceptionValidationInfo = class(Exception);

implementation

end.
