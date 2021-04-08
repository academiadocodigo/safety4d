unit Safety4D.Resources.Group.Provider.Actions;

interface

uses
    Safety4D.Interfaces,
    System.Generics.Collections;

type
  TSafety4DResourcesGroupProviderActions = class(TInterfacedObject, iSafety4DResourcesGroupProviderActions)
    private
      [weak]
      FParent : iSafety4DResourcesGroupProvider;
      FActionList : TDictionary<string, iSafety4DResourcesGroupProviderActionsMsg>;
    public
      constructor Create(aParent : iSafety4DResourcesGroupProvider);
      destructor Destroy; override;
      class function New(aParent : iSafety4DResourcesGroupProvider) : iSafety4DResourcesGroupProviderActions;
      function add(aValue : String) : iSafety4DResourcesGroupProviderActionsMsg;
      function getActions : TDictionary<string, iSafety4DResourcesGroupProviderActionsMsg>;
      function &end : iSafety4DResourcesGroupProvider;
  end;

implementation

uses
  Safety4D.Resources.Group.Provider.Actions.Msg;

{ TSafety4DProviderName }

function TSafety4DResourcesGroupProviderActions.&end: iSafety4DResourcesGroupProvider;
begin
  Result := FParent;
end;

function TSafety4DResourcesGroupProviderActions.getActions: TDictionary<string, iSafety4DResourcesGroupProviderActionsMsg>;
begin
  Result := FActionList;
end;

function TSafety4DResourcesGroupProviderActions.add(
  aValue: String): iSafety4DResourcesGroupProviderActionsMsg;
begin
  FActionList.Add(aValue, TSafety4DResourcesGroupProviderActionsMsg.New(Self));
  Result := FActionList.Items[aValue];
end;

constructor TSafety4DResourcesGroupProviderActions.Create(aParent : iSafety4DResourcesGroupProvider);
begin
  FParent := aParent;
  FActionList := TDictionary<string, iSafety4DResourcesGroupProviderActionsMsg>.Create;
end;

destructor TSafety4DResourcesGroupProviderActions.Destroy;
begin
  FActionList.DisposeOf;
  inherited;
end;

class function TSafety4DResourcesGroupProviderActions.New(aParent : iSafety4DResourcesGroupProvider): iSafety4DResourcesGroupProviderActions;
begin
  Result := Self.Create(aParent);
end;

end.
