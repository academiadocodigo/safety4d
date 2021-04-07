unit Safety4D.UserKey.Register.PermissionGroup;

interface

uses
  System.Generics.Collections,
  Safety4D.Interfaces;

type
  TSafety4DUserKeyRegisterPermissionGroup = class(TInterfacedObject, iSafety4DUserKeyRegisterGroupPermission)
    private
      [weak]
      FParent : iSafety4DUserKeyRegister;
      FList : TList<String>;
      FDescription : String;
    public
      constructor Create(aParent : iSafety4DUserKeyRegister);
      destructor Destroy; override;
      class function New(aParent : iSafety4DUserKeyRegister) : iSafety4DUserKeyRegisterGroupPermission;
      function addPermission ( aValue : String ) : iSafety4DUserKeyRegisterGroupPermission;
      function description ( aValue : String ) : iSafety4DUserKeyRegisterGroupPermission;  overload;
      function description : String; overload;
      function GetPermissions : TList<String>;
      function &End : iSafety4DUserKeyRegister;
  end;

implementation

{ TSafety4DUserKeyRegisterPermissionGroup }

function TSafety4DUserKeyRegisterPermissionGroup.&end : iSafety4DUserKeyRegister;
begin
    Result := FParent;
end;

function TSafety4DUserKeyRegisterPermissionGroup.GetPermissions: TList<String>;
begin
  Result := FList;
end;

function TSafety4DUserKeyRegisterPermissionGroup.addPermission(
  aValue: String): iSafety4DUserKeyRegisterGroupPermission;
begin
  Result := Self;
  FList.Add(aValue);
end;

constructor TSafety4DUserKeyRegisterPermissionGroup.Create(aParent : iSafety4DUserKeyRegister);
begin
  FParent := aParent;
  FList := TList<String>.Create;
end;

function TSafety4DUserKeyRegisterPermissionGroup.description: String;
begin
  Result := FDescription;
end;

function TSafety4DUserKeyRegisterPermissionGroup.description(
  aValue: String): iSafety4DUserKeyRegisterGroupPermission;
begin
  Result := Self;
  FDescription := aValue;
end;

destructor TSafety4DUserKeyRegisterPermissionGroup.Destroy;
begin
  FList.DisposeOf;
  inherited;
end;

class function TSafety4DUserKeyRegisterPermissionGroup.New(aParent : iSafety4DUserKeyRegister): iSafety4DUserKeyRegisterGroupPermission;
begin
  Result := Self.Create(aParent);
end;

end.
