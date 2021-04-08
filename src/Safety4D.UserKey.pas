unit Safety4D.UserKey;

interface

uses
    Safety4D.Interfaces, System.JSON;

type
  TSafety4DUserKey = class(TInterfacedObject, iSafety4DUserKey)
    private
      [weak]
      FParent : iSafety4D;
      FRegisterUserKey : iSafety4DUserKeyRegister;
    public
      constructor Create(aParent : iSafety4D);
      destructor Destroy; override;
      class function New(aParent : iSafety4D) : iSafety4DUserKey;
      function registerUserKey : iSafety4DUserKeyRegister;
      function getUserKey (var aJson : TJsonObject ) : iSafety4DUserKey;
      function exists ( aUserKey : String ) : Boolean;
      function getUserKeyPermissions(aUserKey : String) : TArray<string>;
      function &End : iSafety4D;
  end;

implementation

uses
  Safety4D.UserKey.Register, System.SysUtils;

{ TSafety4DUserKey }

function TSafety4DUserKey.&end : iSafety4D;
begin
    Result := FParent;
end;

function TSafety4DUserKey.exists(aUserKey: String): Boolean;
var
  iUser : iSafety4DUserKeyRegisterGroupPermission;
begin
  Result := True;
  if not FRegisterUserKey.GetUserKeyRegister.TryGetValue(aUserKey, iUser) then
  begin
    Result := False;
    if FParent.configurations.exceptions then
      raise Exception.Create('User key not registered');
  end;
end;

function TSafety4DUserKey.getUserKey(var aJson: TJsonObject): iSafety4DUserKey;
var
  aJsonRegister : TJsonObject;
  aJsonPermission : TJsonArray;
begin
  for var userRegister in registerUserKey.GetUserKeyRegister do
  begin
    aJson.AddPair(userRegister.Key, TJsonObject.Create);
    aJsonRegister := aJson.GetValue<TJsonObject>(userRegister.Key);
    aJsonRegister.AddPair('description', userRegister.Value.description);
    aJsonRegister.AddPair('permissionGroups', TJsonArray.Create);

    for var Permission in userRegister.Value.GetPermissions do
    begin
      aJsonPermission := aJsonRegister.GetValue<TJsonArray>('permissionGroups');
      aJsonPermission.Add(Permission);
    end;

  end;

end;

function TSafety4DUserKey.getUserKeyPermissions(aUserKey : String): TArray<string>;
var
  iUserPermitions : iSafety4DUserKeyRegisterGroupPermission;
begin
  if FRegisterUserKey.GetUserKeyRegister.TryGetValue(aUserKey, iUserPermitions) then
    Result := iUserPermitions.GetPermissions.ToArray;
end;

constructor TSafety4DUserKey.Create(aParent : iSafety4D);
begin
  FParent := aParent;
end;

destructor TSafety4DUserKey.Destroy;
begin

  inherited;
end;

class function TSafety4DUserKey.New(aParent : iSafety4D): iSafety4DUserKey;
begin
  Result := Self.Create(aParent);
end;

function TSafety4DUserKey.registerUserKey: iSafety4DUserKeyRegister;
begin
  if not Assigned(FRegisterUserKey) then
    FRegisterUserKey := TSafety4DUserKeyRegister.New(Self);

  Result := FRegisterUserKey;
end;

end.
