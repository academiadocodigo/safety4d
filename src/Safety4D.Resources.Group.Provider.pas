unit Safety4D.Resources.Group.Provider;

interface

uses
  System.Generics.Collections,
  Safety4D.Interfaces;

type
  TSafety4DResourcesGroupProvider = class(TInterfacedObject, iSafety4DResourcesGroupProvider)
    private
      [weak]
      FParent : iSafety4DResourcesGroup;
      FProviderName : String;
      FProviderNameList : TDictionary<string, iSafety4DResourcesGroupProviderActions>;
    public
      constructor Create(aParent : iSafety4DResourcesGroup);
      destructor Destroy; override;
      class function New(aParent : iSafety4DResourcesGroup) : iSafety4DResourcesGroupProvider;
      function add(aValue : String) : iSafety4DResourcesGroupProvider;
      function getProviderNames : TDictionary<string, iSafety4DResourcesGroupProviderActions>;
      function actions : iSafety4DResourcesGroupProviderActions;
      function &End : iSafety4DResourcesGroup;
  end;

implementation

uses
  Safety4D.Resources.Group.Provider.Actions;

{ TSafety4DProviderName }

function TSafety4DResourcesGroupProvider.&end : iSafety4DResourcesGroup;
begin
    Result := FParent;
end;

function TSafety4DResourcesGroupProvider.getProviderNames: TDictionary<string, iSafety4DResourcesGroupProviderActions>;
begin
  Result := FProviderNameList;
end;

function TSafety4DResourcesGroupProvider.actions: iSafety4DResourcesGroupProviderActions;
begin
  Result := FProviderNameList.Items[FProviderName];
end;

function TSafety4DResourcesGroupProvider.add(aValue: String): iSafety4DResourcesGroupProvider;
begin
  Result := Self;
  FProviderName := aValue;
  FProviderNameList.Add(aValue, TSafety4DResourcesGroupProviderActions.New(Self));
end;

constructor TSafety4DResourcesGroupProvider.Create(aParent : iSafety4DResourcesGroup);
begin
  FParent := aParent;
  FProviderNameList := TDictionary<string, iSafety4DResourcesGroupProviderActions>.Create;
end;

destructor TSafety4DResourcesGroupProvider.Destroy;
begin
  FProviderNameList.DisposeOf;
  inherited;
end;

class function TSafety4DResourcesGroupProvider.New(aParent : iSafety4DResourcesGroup): iSafety4DResourcesGroupProvider;
begin
  Result := Self.Create(aParent);
end;

end.
