unit FM.Controller.Base.Impl;

interface

uses
  FM.Model.Base, FM.Controller.Base, DDC.ViewMessages, Winapi.Windows;

type
  TControllerBase = class(TInterfacedObject, IControllerBase)
  public
    { TODO : COLOCAR PARA QUE RECEBA A CONEXAO POR REFERENCIA }
    constructor Create; virtual; abstract;

    function Validate(const AAttribute: string = ''): boolean; virtual;
    function GetModel: TModelBase; virtual; abstract;

    property Model: TModelBase read GetModel;
  end;

  TControllerBaseClass = class of TControllerBase;

implementation

uses
  DDC.ValidationInfo;

{ TControllerBase }



function TControllerBase.Validate(const AAttribute: string): boolean;
begin
  Result := False;
  try
    Result := GetModel.IsValid(AAttribute);
  except
    on E: ExceptionValidationInfo do
      TValidationInfo.New(GetModel, 'E.PropertyName', False, E.Message, MB_ICONEXCLAMATION);
    on E: ExceptionValidationError do
      TValidationInfo.New(GetModel, 'E.PropertyName', False, E.Message, MB_ICONERROR);
  end;

end;

end.
