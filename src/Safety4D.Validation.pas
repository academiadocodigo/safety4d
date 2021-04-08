unit Safety4D.Validation;

interface

uses
    Safety4D.Interfaces;

type
  TSafety4DValidation = class(TInterfacedObject, iSafety4DValidation)
    private
      [weak]
      FParent : iSafety4D;
      FuserKey : String;
      FResource : String;
      FAction : String;
      FApplication : String;
    public
      constructor Create(aParent : iSafety4D);
      destructor Destroy; override;
      class function New(aParent : iSafety4D) : iSafety4DValidation;
      function userKey( aValue : String ) : iSafety4DValidation; overload;
      function userKey : String; overload;
      function resource ( aValue : String ) : iSafety4DValidation; overload;
      function resource : string; overload;
      function action ( aValue : String ) : iSafety4DValidation; overload;
      function action : string; overload;
      function application ( aValue : String ) : iSafety4DValidation; overload;
      function application : string; overload;
      function validate : boolean;
      function &End : iSafety4D;
  end;

implementation

uses
 System.SysUtils;

{ TSafety4DValidation }

function TSafety4DValidation.&end : iSafety4D;
begin
    Result := FParent;
end;

function TSafety4DValidation.action(aValue: String): iSafety4DValidation;
begin
  Result := Self;
  FAction := aValue;
end;

function TSafety4DValidation.action: string;
begin
  Result := FAction;
end;

function TSafety4DValidation.application: string;
begin
  Result := FApplication;
end;

function TSafety4DValidation.application(aValue: String): iSafety4DValidation;
begin
  Result := Self;
  FApplication := aValue;
end;

constructor TSafety4DValidation.Create(aParent : iSafety4D);
begin
  FParent := aParent;
end;

destructor TSafety4DValidation.Destroy;
begin

  inherited;
end;

class function TSafety4DValidation.New(aParent : iSafety4D): iSafety4DValidation;
begin
  Result := Self.Create(aParent);
end;

function TSafety4DValidation.resource: string;
begin
  Result := FResource;
end;

function TSafety4DValidation.resource(aValue: String): iSafety4DValidation;
begin
  Result := Self;
  FResource := aValue;
end;

function TSafety4DValidation.userKey(aValue: String): iSafety4DValidation;
begin
  Result := Self;
  FuserKey := aValue;
end;

function TSafety4DValidation.userKey: String;
begin
  Result := FuserKey;
end;

function TSafety4DValidation.validate: boolean;
var
  FAllAcess : Boolean;
  FAllBlock : Boolean;
  iGroupPermission : iSafety4DGroupListActions;
begin
  Result := False;
  FAllAcess := False;
  FAllBlock := False;
  try
    FParent.resources.exists(FApplication, FResource, FAction);
    FParent.userKey.exists(FuserKey);

    for var UserPermission in FParent.userKey.getUserKeyPermissions(FuserKey) do
    begin
      iGroupPermission := FParent.groupPermission.getGroupPermission(UserPermission);

      for var aAction in iGroupPermission.actions.getActions do
      begin
        if UpperCase(aAction) = UpperCase(FResource+'.'+FAction) then
        begin
          Result := True;
          exit;
        end;

        if aAction = '*' then
          FAllAcess := True;
      end;

      for var aNotAction in iGroupPermission.notActions.getNotActions do
      begin
        if UpperCase(aNotAction) = UpperCase(FResource+'.'+FAction) then
          if FParent.configurations.exceptions then
            raise Exception.Create('Access not allowed to these resources');

        if aNotAction = '*' then
          FAllBlock := True;
      end;

      if not Result and FAllAcess then Result := FAllAcess;
      if not Result and FAllBlock then
        if FParent.configurations.exceptions then
          raise Exception.Create('Access not allowed to these resources');
    end;
  except on e : Exception do
    raise Exception.Create(e.Message);
  end;
end;

end.
