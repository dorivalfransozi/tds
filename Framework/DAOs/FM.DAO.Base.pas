unit FM.DAO.Base;

interface

uses
  FM.Model.Base, System.Generics.Collections;

type
  TModelBase = FM.Model.Base.TModelBase;

  IDAO<T: class> = interface
    procedure Save(var AModel: T);
    procedure Delete(var AModel: T);
    function Find(var AModel: T; const ASetModel: boolean=true): boolean;
    function FindAll(var AListModel: TObjectList<T>): boolean;
  end;

implementation

end.
