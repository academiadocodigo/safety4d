unit Safety4D.Resources;

interface

uses
  System.JSON,
  Safety4D.Interfaces;

type
  TSafety4DResources = class(TInterfacedObject, iSafety4DResources)
    private
      [weak]
      FParent : iSafety4D;
      FRegisterResources : iSafety4DResourcesRegister;
    public
      constructor Create(aParent : iSafety4D);
      destructor Destroy; override;
      class function New(aParent : iSafety4D) : iSafety4DResources;
      function registerResources : iSafety4DResourcesRegister;
      function getResource ( var aJson : TJsonObject ) : iSafety4DResources;
      function exists ( aApplication : String;  aResource : String; aAction : String ) : Boolean;
      function &End : iSafety4D;
  end;

implementation

uses
  Safety4D.Resources.Register, System.SysUtils;

{ TSafety4DResources }

function TSafety4DResources.&end : iSafety4D;
begin
    Result := FParent;
end;

function TSafety4DResources.exists( aApplication : String;  aResource : String; aAction : String ) : Boolean;
var
  iResource : iSafety4DResourcesGroupProvider;
  iResourceActions : iSafety4DResourcesGroupProviderActions;
  iActionMessage : iSafety4DResourcesGroupProviderActionsMsg;
begin
  Result := False;

  if not FRegisterResources.getResourceGroups.TryGetValue(aApplication, iResource) then
    raise Exception.Create('Unregistered Application');

  if not iResource.getProviderNames.TryGetValue(aResource, iResourceActions) then
    raise Exception.Create('Unregistered resource');

  if not iResourceActions.getActions.TryGetValue(aAction, iActionMessage) then
    raise Exception.Create('unregistered action');
end;

function TSafety4DResources.getResource(
  var aJson: TJsonObject): iSafety4DResources;
var
  aJsonResources : TJsonObject;
  aJsonGroup : TJsonObject;
  aJsonProvider : TJsonObject;
  aJsonActions : TJsonObject;
begin
  Result := Self;
  //aJson.AddPair('resources', TJSONArray.Create.Add(TJSONObject.Create));
  for var Resource in FRegisterResources.getResourceGroups do
  begin
    //aJsonResources := (aJson.GetValue<TJsonArray>('resources').Items[0] as TJsonObject);
    aJson.AddPair(Resource.Key, TJSONObject.Create);
    for var Provider in Resource.Value.getProviderNames do
    begin
      aJsonGroup := aJson.GetValue<TJsonObject>(Resource.Key);
      aJsonGroup.AddPair(Provider.Key, TJSONObject.Create);
      aJsonProvider := aJsonGroup.GetValue<TJsonObject>(Provider.Key);
      aJsonProvider.AddPair('actions', TJSONObject.Create);
      for var Action in Provider.Value.getActions do
      begin
        aJsonActions := aJsonProvider.GetValue<TJsonObject>('actions');
        aJsonActions.AddPair(Action.Key, TJsonObject.Create);
        aJsonActions.GetValue<TJsonObject>(Action.Key).AddPair('description', Action.Value.description);
        aJsonActions.GetValue<TJsonObject>(Action.Key).AddPair('errormsg', Action.Value.errormsg);
      end;
    end;
  end;
end;

constructor TSafety4DResources.Create(aParent : iSafety4D);
begin
  FParent := aParent;
end;

destructor TSafety4DResources.Destroy;
begin

  inherited;
end;

class function TSafety4DResources.New(aParent : iSafety4D): iSafety4DResources;
begin
  Result := Self.Create(aParent);
end;

function TSafety4DResources.registerResources: iSafety4DResourcesRegister;
begin
  if not assigned(FRegisterResources) then
    FRegisterResources := TSafety4DResourcesRegister.New(Self);

  Result := FRegisterResources;
end;

end.
