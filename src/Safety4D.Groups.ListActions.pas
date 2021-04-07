unit Safety4D.Groups.ListActions;

interface

uses
    Safety4D.Interfaces;

type
  TSafety4DGroupsListActions = class(TInterfacedObject, iSafety4DGroupListActions)
    private
      [weak]
      FParent : iSafety4DGroupRegister;
      FActions : iSafety4DGroupActions;
      FNotActions : iSafety4DGroupNotActions;
      FDescription : String;
      FKey : String;
    public
      constructor Create(aParent : iSafety4DGroupRegister);
      destructor Destroy; override;
      class function New(aParent : iSafety4DGroupRegister) : iSafety4DGroupListActions;
      function actions : iSafety4DGroupActions;
      function notActions : iSafety4DGroupNotActions;
      function description ( aValue : String ) : iSafety4DGroupListActions; overload;
      function description : String; overload;
      function key ( aValue : String ) : iSafety4DGroupListActions; overload;
      function key : string; overload;
      function &End : iSafety4DGroupRegister;
  end;

implementation

uses
  Safety4D.Groups.Actions, Safety4D.Groups.NotActions;

{ TSafety4DGroupsListActions }

function TSafety4DGroupsListActions.&end : iSafety4DGroupRegister;
begin
    Result := FParent;
end;

function TSafety4DGroupsListActions.key: string;
begin
  Result := FKey;
end;

function TSafety4DGroupsListActions.key(
  aValue: String): iSafety4DGroupListActions;
begin
  Result := Self;
  FKey := aValue;
end;

function TSafety4DGroupsListActions.actions: iSafety4DGroupActions;
begin
  if not Assigned(FActions) then
    FActions := TSafety4DGroupActions.New(FParent);

  Result := FActions;
end;

constructor TSafety4DGroupsListActions.Create(aParent : iSafety4DGroupRegister);
begin
  FParent := aParent;
end;

function TSafety4DGroupsListActions.description: String;
begin
  Result := FDescription;
end;

function TSafety4DGroupsListActions.description(
  aValue: String): iSafety4DGroupListActions;
begin
  Result := Self;
  FDescription := aValue;
end;

destructor TSafety4DGroupsListActions.Destroy;
begin

  inherited;
end;

class function TSafety4DGroupsListActions.New(aParent : iSafety4DGroupRegister): iSafety4DGroupListActions;
begin
  Result := Self.Create(aParent);
end;

function TSafety4DGroupsListActions.notActions: iSafety4DGroupNotActions;
begin
  if not Assigned(FNotActions) then
    FNotActions := TSafety4DGroupNotActions.New(FParent);

  Result := FNotActions;
end;

end.
