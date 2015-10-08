unit FM.DAO.Base;

interface

uses
  FM.Model.Base, System.Generics.Collections;

type
  TModelBase = FM.Model.Base.TModelBase;

  IDAO = interface
    procedure Save(var AModel: TModelBase);
    procedure Delete(var AModel: TModelBase);
    function Find(var AModel: TModelBase; const ASetModel: boolean=true): boolean;
    function FindAll(var AListModel: TObjectList<TModelBase>): boolean;
  end;

implementation

end.
