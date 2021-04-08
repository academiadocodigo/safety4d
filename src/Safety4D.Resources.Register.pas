unit Safety4D.Resources.Register;

interface

uses
  System.Generics.Collections,
  Safety4D.Interfaces;

type
  TSafety4DResourcesRegister = class(TInterfacedObject, iSafety4DResourcesRegister)
    private
      [weak]
      FParent : iSafety4DResources;
      FResourceGroupName : iSafety4DResourcesGroup;
    public
      constructor Create(aParent : iSafety4DResources);
      destructor Destroy; override;
      class function New(aParent : iSafety4DResources) : iSafety4DResourcesRegister;
      function resourcesGroupName : iSafety4DResourcesGroup;
      function getResourceGroups : TDictionary<string, iSafety4DResourcesGroupProvider>;
      function &End : iSafety4DResources;
  end;

implementation

uses
  Safety4D.Resources.Group;

{ TSafety4DRegisterResources }

function TSafety4DResourcesRegister.&end : iSafety4DResources;
begin
    Result := FParent;
end;

function TSafety4DResourcesRegister.getResourceGroups: TDictionary<string, iSafety4DResourcesGroupProvider>;
begin
  Result := resourcesGroupName.getResourcesGroupList;
end;

constructor TSafety4DResourcesRegister.Create(aParent : iSafety4DResources);
begin
  FParent := aParent;
end;

destructor TSafety4DResourcesRegister.Destroy;
begin

  inherited;
end;

class function TSafety4DResourcesRegister.New(aParent : iSafety4DResources) : iSafety4DResourcesRegister;
begin
  Result := Self.Create(aParent);
end;

function TSafety4DResourcesRegister.resourcesGroupName: iSafety4DResourcesGroup;
begin
  if not assigned(FResourceGroupName) then
    FResourceGroupName := TSafety4DResourcesGroup.New(Self);

  Result := FResourceGroupName;
end;

end.
