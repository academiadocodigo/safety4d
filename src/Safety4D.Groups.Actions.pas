unit Safety4D.Groups.Actions;

interface

uses
  System.Generics.Collections,
  Safety4D.Interfaces;

type
  TSafety4DGroupActions = class(TInterfacedObject, iSafety4DGroupActions)
    private
      [weak]
      FParent : iSafety4DGroupRegister;
      FList : TList<string>;
    public
      constructor Create(aParent : iSafety4DGroupRegister);
      destructor Destroy; override;
      class function New(aParent : iSafety4DGroupRegister) : iSafety4DGroupActions;
      function add ( aValue : String ) : iSafety4DGroupActions;
      function getActions : TList<String>;
      function &End : iSafety4DGroupRegister;
  end;

implementation

{ TSafety4DGroupActions }

function TSafety4DGroupActions.&end : iSafety4DGroupRegister;
begin
    Result := FParent;
end;

function TSafety4DGroupActions.add(aValue: String): iSafety4DGroupActions;
begin
  Result := Self;
  FList.Add(aValue);
end;

function TSafety4DGroupActions.getActions: TList<String>;
begin
  Result := FList;
end;

constructor TSafety4DGroupActions.Create(aParent : iSafety4DGroupRegister);
begin
  FParent := aParent;
  FList := TList<string>.Create;
end;

destructor TSafety4DGroupActions.Destroy;
begin
  FList.DisposeOf;
  inherited;
end;

class function TSafety4DGroupActions.New(aParent : iSafety4DGroupRegister): iSafety4DGroupActions;
begin
  Result := Self.Create(aParent);
end;

end.
