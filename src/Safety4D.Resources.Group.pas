unit Safety4D.Resources.Group;

interface

uses
  System.Generics.Collections,
  Safety4D.Interfaces;

type
  TSafety4DResourcesGroup = class(TInterfacedObject, iSafety4DResourcesGroup)
    private
      [weak]
      FParent : iSafety4DResourcesRegister;
      FResourceGroup : String;
      FResourceGroupNameList : TDictionary<string, iSafety4DResourcesGroupProvider>;
    public
      constructor Create(aParent : iSafety4DResourcesRegister);
      destructor Destroy; override;
      class function New(aParent : iSafety4DResourcesRegister) : iSafety4DResourcesGroup;
      function add ( aValue : String ) : iSafety4DResourcesGroup;
      function getResourcesGroupList : TDictionary<string, iSafety4DResourcesGroupProvider>;
      function providerName : iSafety4DResourcesGroupProvider;
      function &end : iSafety4DResourcesRegister;
  end;

implementation

{ TSafety4DResourcesGrupName }

uses
  Safety4D.Resources.Group.Provider;

function TSafety4DResourcesGroup.&end : iSafety4DResourcesRegister;
begin
    Result := FParent;
end;

function TSafety4DResourcesGroup.getResourcesGroupList: TDictionary<string, iSafety4DResourcesGroupProvider>;
begin
  Result := FResourceGroupNameList;
end;

function TSafety4DResourcesGroup.add(
  aValue: String): iSafety4DResourcesGroup;
begin
  Result := Self;
  FResourceGroup := aValue;
  FResourceGroupNameList.Add(aValue, TSafety4DResourcesGroupProvider.New(Self));
end;

constructor TSafety4DResourcesGroup.Create(aParent : iSafety4DResourcesRegister);
begin
  FParent := aParent;
  FResourceGroupNameList := TDictionary<string, iSafety4DResourcesGroupProvider>.Create;
end;

destructor TSafety4DResourcesGroup.Destroy;
begin
  FResourceGroupNameList.DisposeOf;
  inherited;
end;

class function TSafety4DResourcesGroup.New(aParent : iSafety4DResourcesRegister): iSafety4DResourcesGroup;
begin
  Result := Self.Create(aParent);
end;

function TSafety4DResourcesGroup.providerName: iSafety4DResourcesGroupProvider;
begin
  Result := FResourceGroupNameList.Items[FResourceGroup];
end;

end.
