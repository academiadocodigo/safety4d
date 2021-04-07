unit Safety4D.Groups.NotActions;

interface

uses
  System.Generics.Collections,
  Safety4D.Interfaces;

type
  TSafety4DGroupNotActions = class(TInterfacedObject, iSafety4DGroupNotActions)
    private
      [weak]
      FParent : iSafety4DGroupRegister;
      FList : TList<string>;
    public
      constructor Create(aParent : iSafety4DGroupRegister);
      destructor Destroy; override;
      class function New(aParent : iSafety4DGroupRegister) : iSafety4DGroupNotActions;
      function add ( aValue : String ) : iSafety4DGroupNotActions;
      function getNotActions : TList<String>;
      function &End : iSafety4DGroupRegister;
  end;

implementation

{ TSafety4DGroupNotActions }

function TSafety4DGroupNotActions.&end : iSafety4DGroupRegister;
begin
    Result := FParent;
end;

function TSafety4DGroupNotActions.add(aValue: String): iSafety4DGroupNotActions;
begin
  Result := Self;
  FList.Add(aValue);
end;

function TSafety4DGroupNotActions.getNotActions: TList<String>;
begin
  Result := FList;
end;

constructor TSafety4DGroupNotActions.Create(aParent : iSafety4DGroupRegister);
begin
  FParent := aParent;
  FList := TList<string>.Create;
end;

destructor TSafety4DGroupNotActions.Destroy;
begin
  FList.DisposeOf;
  inherited;
end;

class function TSafety4DGroupNotActions.New(aParent : iSafety4DGroupRegister): iSafety4DGroupNotActions;
begin
  Result := Self.Create(aParent);
end;

end.
