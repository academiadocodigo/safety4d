unit Safety4D.Resources.Group.Provider.Actions.Msg;

interface

uses
    Safety4D.Interfaces;

type
  TSafety4DResourcesGroupProviderActionsMsg = class(TInterfacedObject, iSafety4DResourcesGroupProviderActionsMsg)
    private
      [weak]
      FParent : iSafety4DResourcesGroupProviderActions;
      FDescription : String;
      FErrorMsg : String;
    public
      constructor Create(aParent : iSafety4DResourcesGroupProviderActions);
      destructor Destroy; override;
      class function New(aParent : iSafety4DResourcesGroupProviderActions) : iSafety4DResourcesGroupProviderActionsMsg;
      function description( aValue : String ) : iSafety4DResourcesGroupProviderActionsMsg; overload;
      function errormsg ( aValue : String ) : iSafety4DResourcesGroupProviderActionsMsg; overload;
      function description : String; overload;
      function errormsg : String; overload;
      function &End : iSafety4DResourcesGroupProviderActions;
  end;

implementation

{ TSafety4DResourcesGroupProviderActionsMsg }

function TSafety4DResourcesGroupProviderActionsMsg.&end : iSafety4DResourcesGroupProviderActions;
begin
    Result := FParent;
end;

function TSafety4DResourcesGroupProviderActionsMsg.errormsg: String;
begin
  Result := FErrorMsg;
end;

function TSafety4DResourcesGroupProviderActionsMsg.errormsg(aValue: String): iSafety4DResourcesGroupProviderActionsMsg;
begin
  Result := Self;
  FErrorMsg := aValue;
end;

constructor TSafety4DResourcesGroupProviderActionsMsg.Create(aParent : iSafety4DResourcesGroupProviderActions);
begin
  FParent := aParent;
end;

function TSafety4DResourcesGroupProviderActionsMsg.description(
  aValue: String): iSafety4DResourcesGroupProviderActionsMsg;
begin
  Result := Self;
  FDescription := aValue;
end;

function TSafety4DResourcesGroupProviderActionsMsg.description: String;
begin
  Result := FDescription;
end;

destructor TSafety4DResourcesGroupProviderActionsMsg.Destroy;
begin

  inherited;
end;

class function TSafety4DResourcesGroupProviderActionsMsg.New(aParent : iSafety4DResourcesGroupProviderActions): iSafety4DResourcesGroupProviderActionsMsg;
begin
  Result := Self.Create(aParent);
end;

end.
