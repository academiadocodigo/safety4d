unit Safety4D;

interface

uses
  Safety4D.Interfaces,
  System.JSON,
  System.Generics.Collections;

type
  TSafety4D = class(TInterfacedObject, iSafety4D)
    private
      FResources : iSafety4DResources;
      FGroupPermission : iSafety4DGroup;
      FuserKey : iSafety4DUserKey;
      FValidation : iSafety4DValidation;
      FConfigurations : iSafety4DConfiguration;
      procedure __loadResourcesJson(var aJson : TJsonObject);
      procedure __loadGroupPermissionJson(var aJson : TJsonObject);
      procedure __loadUserKeysJson(var aJson : TJsonObject);
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iSafety4D;
      function Validation : iSafety4DValidation;
      function resources : iSafety4DResources;
      function groupPermission : iSafety4DGroup;
      function configurations : iSafety4DConfiguration;
      function userKey : iSafety4DUserKey;
      function getConfig (var aJson : TJsonObject ) : iSafety4D;
      function SaveToStorage ( aPath : String = '' ) : iSafety4D;
      function LoadConfig ( aJson : TJsonObject ) : iSafety4D;
  end;

var
  vSafety4D : iSafety4D;

implementation

uses
  Safety4D.Resources.Register,
  Safety4D.Resources,
  Safety4D.Groups,
  Safety4D.UserKey,
  System.SysUtils,
  System.Classes,
  Rest.Json, Safety4D.Validation, Safety4D.Configuration;

{ TSafety4D }

function TSafety4D.configurations: iSafety4DConfiguration;
begin
  if not Assigned(FConfigurations) then
    FConfigurations := TSafety4DConfiguration.New(Self);

  Result := FConfigurations;
end;

constructor TSafety4D.Create;
begin

end;

destructor TSafety4D.Destroy;
begin

  inherited;
end;

function TSafety4D.getConfig(var aJson: TJsonObject): iSafety4D;
var
  aResource, aGroup, aUser : TJsonObject;
begin
  Result := Self;
  aJson
    .AddPair('resources', TJSONObject.Create)
    .AddPair('groupPermission', TJSONObject.Create)
    .AddPair('userKeys', TJSONObject.Create);
  aResource := aJson.GetValue<TJsonObject>('resources');
  aGroup := aJson.GetValue<TJsonObject>('groupPermission');
  aUser := aJson.GetValue<TJsonObject>('userKeys');
  resources.getResource(aResource);
  groupPermission.getGroups(aGroup);
  userKey.getUserKey(aUser);
end;

function TSafety4D.groupPermission: iSafety4DGroup;
begin
  if not Assigned(FGroupPermission) then
    FGroupPermission := TSafety4DGroups.New(self);

  Result := FGroupPermission;
end;

function TSafety4D.LoadConfig(aJson: TJsonObject): iSafety4D;
var
  aJsonResources : TJsonObject;
  aJsonGroupPermission : TJsonObject;
  aJsonUserKeys : TJsonObject;
  aTeste: string;
begin
  aTeste := aJson.ToString;
  if aJson.TryGetValue<TJsonObject>('resources', aJsonResources) then
    __loadResourcesJson(aJsonResources);

  if aJson.TryGetValue<TJsonObject>('groupPermission', aJsonGroupPermission)  then
    __loadGroupPermissionJson(aJsonGroupPermission);

  if aJson.TryGetValue<TJsonObject>('userKeys', aJsonUserKeys)  then
    __loadUserKeysJson(aJsonUserKeys);
end;

class function TSafety4D.New: iSafety4D;
begin
  if not Assigned(vSafety4D) then
    vSafety4D := Self.Create;

  Result := vSafety4D;
end;

function TSafety4D.resources: iSafety4DResources;
begin
  if not Assigned(FResources) then
    FResources := TSafety4DResources.New(Self);

  Result := FResources;
end;

function TSafety4D.SaveToStorage(aPath: String): iSafety4D;
var
  aJsonResult : TJsonObject;
  StrList : TStringList;
begin
  if Trim(aPath) = '' then
    aPath := ChangeFileExt(ParamStr(0), '.s4d');
  aJsonResult := TJsonObject.Create;
  StrList := TStringList.Create;
  try
    Self.getConfig(aJsonResult);
    StrList.Add(aJsonResult.Format);
    StrList.SaveToFile(aPath);
  finally
    StrList.DisposeOf;
    aJsonResult.DisposeOf;
  end;
end;

function TSafety4D.userKey: iSafety4DUserKey;
begin
  if not assigned(FuserKey) then
    FuserKey := TSafety4DUserKey.New(Self);

  Result := FuserKey;
end;

function TSafety4D.Validation: iSafety4DValidation;
begin
  if not Assigned(FValidation) then
    FValidation := TSafety4DValidation.New(Self);

  Result := FValidation;
end;

procedure TSafety4D.__loadGroupPermissionJson(var aJson: TJsonObject);
var
  I : Integer;
  FGroupName : String;
  aJsonGroup : TJsonObject;
  iAction : iSafety4DGroupActions;
  iNotAction : iSafety4DGroupNotActions;
  aJsonActions : TJsonArray;
  aJsonNotActions : TJsonArray;
  X: Integer;
begin
  for I := 0 to Pred(aJson.Count) do
  begin
    FGroupName := aJson.Pairs[I].JsonString.Value;
    aJsonGroup := aJson.Pairs[I].JsonValue as TJsonObject;
    aJsonActions := aJsonGroup.GetValue<TJsonArray>('Actions');
    aJsonNotActions := aJsonGroup.GetValue<TJsonArray>('NotActions');

    iAction :=
    groupPermission
      .groupRegister
        .add(FGroupName)
        .description(aJsonGroup.GetValue<string>('description'))
        .key(aJsonGroup.GetValue<string>('key'))
        .actions;

    for X := 0 to Pred(aJsonActions.Count) do
    begin
      iAction.add(aJsonActions.Items[X].Value);
    end;

    iNotAction := iAction.&end.notActions;

    for X := 0 to Pred(aJsonNotActions.Count) do
    begin
      iNotAction.add(aJsonNotActions.Items[X].Value);
    end;
  end;
end;

procedure TSafety4D.__loadResourcesJson(var aJson : TJsonObject);
var
  I: Integer;
  FGroupName: string;
  FProviderName : String;
  aJsonGroup : TJsonObject;
  aJsonProvider : TJsonObject;
  aJsonActions : TJsonObject;
  J: Integer;
  iProviderAction : iSafety4DResourcesGroupProviderActions;
  K: Integer;
begin
  for I := 0 to Pred(aJson.Count) do
  begin
    FGroupName := aJson.Pairs[I].JsonString.Value;
    aJsonGroup := aJson.Pairs[I].JsonValue as TJSONObject;
    for J := 0 to Pred(aJsonGroup.Count) do
    begin
      FProviderName := aJsonGroup.Pairs[J].JsonString.Value;
      aJsonProvider := aJsonGroup.Pairs[I].JsonValue as TJSONObject;
      aJsonActions := aJsonProvider.GetValue<TJsonObject>('actions');

      iProviderAction :=
        resources
        .registerResources
          .resourcesGroupName
            .add(FGroupName)
            .providerName
              .add(FProviderName)
              .actions;

      for K := 0 to Pred(aJsonActions.Count) do
      begin
        iProviderAction
          .add(aJsonActions.Pairs[K].JsonString.Value)
          .description(aJsonActions.Pairs[K].JsonValue.GetValue<String>('description'))
          .errormsg(aJsonActions.Pairs[K].JsonValue.GetValue<String>('errormsg'))
      end;
    end;
  end;
end;

procedure TSafety4D.__loadUserKeysJson(var aJson: TJsonObject);
var
  I : Integer;
  FGroupName : String;
  aJsonGroup : TJsonObject;
  aJsonPermission : TJsonArray;
  X: Integer;
  iPermissionGroup : iSafety4DUserKeyRegisterGroupPermission;
begin
  for I := 0 to Pred(aJson.Count) do
  begin
    FGroupName := aJson.Pairs[I].JsonString.Value;
    aJsonGroup := aJson.Pairs[I].JsonValue as TJsonObject;
    aJsonPermission := aJsonGroup.GetValue<TJsonArray>('permissionGroups');

    iPermissionGroup :=
      userKey
      .registerUserKey
        .add(FGroupName)
          .description(aJsonGroup.GetValue<String>('description'));

    for X := 0 to Pred(aJsonPermission.Count) do
    begin
      iPermissionGroup.addPermission(aJsonPermission.Items[X].Value);
    end;
  end;
end;

end.
