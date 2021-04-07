unit Safety4D.UserKey.Register;

interface

uses
  System.Generics.Collections,
  Safety4D.Interfaces;

type
  TSafety4DUserKeyRegister = class(TInterfacedObject, iSafety4DUserKeyRegister)
    private
      [weak]
      FParent : iSafety4DUserKey;
      FList : TDictionary<string, iSafety4DUserKeyRegisterGroupPermission>;
    public
      constructor Create(aParent : iSafety4DUserKey);
      destructor Destroy; override;
      class function New(aParent : iSafety4DUserKey) : iSafety4DUserKeyRegister;
      function GetUserKeyRegister : TDictionary<string, iSafety4DUserKeyRegisterGroupPermission>;
      function add ( aValue : String ) : iSafety4DUserKeyRegisterGroupPermission;
      function &End : iSafety4DUserKey;
  end;

implementation

uses
  Safety4D.UserKey.Register.PermissionGroup,
  System.SysUtils,
  System.StrUtils;

{ TSafety4DUserKeyRegister }

function TSafety4DUserKeyRegister.&end : iSafety4DUserKey;
begin
    Result := FParent;
end;

function TSafety4DUserKeyRegister.GetUserKeyRegister: TDictionary<string, iSafety4DUserKeyRegisterGroupPermission>;
begin
  Result := FList;
end;

function TSafety4DUserKeyRegister.add(
  aValue: String): iSafety4DUserKeyRegisterGroupPermission;
var
  aGuid : String;
begin
  aGuid := TGuid.NewGuid.ToString;

  if ContainsText(aValue, '{') and ContainsText(aValue, '}') then
    aGuid := aValue;

  FList.Add(aGuid, TSafety4DUserKeyRegisterPermissionGroup.New(Self));
  Result := FList.Items[aGuid].description(aValue);
end;

constructor TSafety4DUserKeyRegister.Create(aParent : iSafety4DUserKey);
begin
  FParent := aParent;
  FList := TDictionary<string, iSafety4DUserKeyRegisterGroupPermission>.Create;
end;

destructor TSafety4DUserKeyRegister.Destroy;
begin
  FList.DisposeOf;
  inherited;
end;

class function TSafety4DUserKeyRegister.New(aParent : iSafety4DUserKey): iSafety4DUserKeyRegister;
begin
  Result := Self.Create(aParent);
end;

end.
