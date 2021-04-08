unit Safety4D.Groups;

interface

uses
    Safety4D.Interfaces, System.JSON;

type
  TSafety4DGroups = class(TInterfacedObject, iSafety4DGroup)
    private
      [weak]
      FParent : iSafety4D;
      FgroupRegister : iSafety4DGroupRegister;
    public
      constructor Create(aParent : iSafety4D);
      destructor Destroy; override;
      class function New(aParent : iSafety4D) : iSafety4DGroup;
      function groupRegister : iSafety4DGroupRegister;
      function getGroups (var aJson : TJsonObject ) : iSafety4DGroup;
      function getGroupPermission ( aValue : String ) : iSafety4DGroupListActions;
      function &End : iSafety4D;
  end;

implementation

uses
  Safety4D.Groups.Register;

{ TSafety4DGroups }

function TSafety4DGroups.&end : iSafety4D;
begin
    Result := FParent;
end;

function TSafety4DGroups.getGroupPermission(
  aValue: String): iSafety4DGroupListActions;
begin
  FgroupRegister.getGroupsRegisters.TryGetValue(aValue, Result);
end;

function TSafety4DGroups.getGroups(
  var aJson: TJsonObject): iSafety4DGroup;
var
  aJsonActions : TJsonArray;
  aJsonGroup : TJsonObject;
begin
  Result := Self;
  for var group in groupRegister.getGroupsRegisters do
  begin
    aJson.AddPair(group.Key, TJsonObject.Create);
    aJsonGroup := aJson.GetValue<TJsonObject>(group.Key);
    aJsonGroup
      .AddPair('key', group.Value.key)
      .AddPair('description', group.Value.description)
      .AddPair('Actions', TJSONArray.Create)
      .AddPair('NotActions', TJSONArray.Create);

    for var Action in group.Value.actions.getActions do
    begin
      aJsonActions := aJsonGroup.GetValue<TJsonArray>('Actions');
      aJsonActions.Add(Action);
    end;

    for var NotAction in group.Value.notActions.getNotActions do
    begin
      aJsonActions := aJsonGroup.GetValue<TJsonArray>('NotActions');
      aJsonActions.Add(NotAction);
    end;
  end;
//  aJson
//    .AddPair('Key', FKey)
//    .AddPair('RoleName', FRoleName)
//    .AddPair('Description', FDescription)
//    .AddPair('Actions', TJSONArray.Create)
//    .AddPair('NotActions', TJSONArray.Create);

//  for var Action in FActions.getActions do
//  begin
//    aJsonActions := aJson.GetValue<TJsonArray>('Actions');
//    aJsonActions.Add(Action);
//  end;

//  for var NotAction in FNotActions.getNotActions do
//  begin
//    aJsonActions := aJson.GetValue<TJsonArray>('NotActions');
//    aJsonActions.Add(NotAction);
//  end;

end;

function TSafety4DGroups.groupRegister: iSafety4DGroupRegister;
begin
  if not Assigned(FgroupRegister) then
    FgroupRegister := TSafety4DGroupRegister.New(Self);
  Result := FgroupRegister;
end;

constructor TSafety4DGroups.Create(aParent : iSafety4D);
begin
  FParent := aParent;
end;

destructor TSafety4DGroups.Destroy;
begin

  inherited;
end;

class function TSafety4DGroups.New(aParent : iSafety4D): iSafety4DGroup;
begin
  Result := Self.Create(aParent);
end;

end.
