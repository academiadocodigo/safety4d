unit Safety4D.Groups.Register;

interface

uses
    System.Generics.Collections,
    Safety4D.Interfaces,
    System.JSON;

type
  TSafety4DGroupRegister = class(TInterfacedObject, iSafety4DGroupRegister)
    private
      [weak]
      FParent : iSafety4DGroup;
      FActions : iSafety4DGroupListActions;
      FList : TDictionary<string, iSafety4DGroupListActions>;
    public
      constructor Create(aParent : iSafety4DGroup);
      destructor Destroy; override;
      class function New(aParent : iSafety4DGroup) : iSafety4DGroupRegister;
      function add ( aRoleName : String ) : iSafety4DGroupRegister;
      function description (aValue : String ) : iSafety4DGroupRegister; overload;
      function description : String; overload;
      function key ( aValue : String ) : iSafety4DGroupRegister; overload;
      function key : String; overload;
      function actions : iSafety4DGroupActions;
      function notActions : iSafety4DGroupNotActions;
      function getGroupsRegisters : TDictionary<string, iSafety4DGroupListActions>;
      function &end : iSafety4DGroup;
  end;

implementation

uses
  Safety4D.Groups.Actions,
  Safety4D.Groups.NotActions,
  Safety4D.Groups.ListActions,
  System.SysUtils,
  System.StrUtils;

{ TSafety4DGroups }

function TSafety4DGroupRegister.&end: iSafety4DGroup;
begin
  Result := FParent;
end;

function TSafety4DGroupRegister.getGroupsRegisters: TDictionary<string, iSafety4DGroupListActions>;
begin
  Result := FList;
end;

function TSafety4DGroupRegister.key: String;
begin
  Result := FActions.key;
end;

function TSafety4DGroupRegister.key(aValue: String): iSafety4DGroupRegister;
begin
  Result := Self;
  FActions.key(aValue);
end;

function TSafety4DGroupRegister.actions: iSafety4DGroupActions;
begin
  Result := FActions.actions;
end;

function TSafety4DGroupRegister.add(aRoleName: String): iSafety4DGroupRegister;
var
  aGuid : String;
begin
  aGuid := TGuid.NewGuid.ToString;
  if ContainsText(aRoleName, '{') and ContainsText(aRoleName, '}') then
    aGuid := aRoleName;

  Result := Self;
  FList.Add(aGuid, TSafety4DGroupsListActions.New(Self));
  FActions := FList.Items[aGuid];
  FActions.key(aRoleName);
end;

constructor TSafety4DGroupRegister.Create(aParent : iSafety4DGroup);
begin
  FParent := aParent;
  FList := TDictionary<string, iSafety4DGroupListActions>.Create;
end;

function TSafety4DGroupRegister.description: String;
begin
  Result := FActions.description;
end;

function TSafety4DGroupRegister.description(
  aValue: String): iSafety4DGroupRegister;
begin
  Result := FActions.description(aValue).&end;
end;

destructor TSafety4DGroupRegister.Destroy;
begin
  FList.DisposeOf;
  inherited;
end;

class function TSafety4DGroupRegister.New(aParent : iSafety4DGroup) : iSafety4DGroupRegister;
begin
  Result := Self.Create(aParent);
end;

function TSafety4DGroupRegister.notActions: iSafety4DGroupNotActions;
begin
  Result := FActions.notActions;
end;

end.
