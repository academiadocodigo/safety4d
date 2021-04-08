unit Safety4D.Interfaces;

interface

uses
  System.Generics.Collections,
  System.JSON;

type
  iSafety4DResourcesRegister = interface;
  iSafety4DResourcesGroup = interface;
  iSafety4DResourcesGroupProvider = interface;
  iSafety4DResourcesGroupProviderActions = interface;
  iSafety4DResources = interface;
  iSafety4DResourcesGroupProviderActionsMsg = interface;
  iSafety4DGroup = interface;
  iSafety4DUserKey = interface;
  iSafety4DValidation = interface;
  iSafety4DConfiguration = interface;


  iSafety4D = interface
    ['{055941C3-EBA3-4D4E-ADB0-75C9FCE6DF18}']
    function Validation : iSafety4DValidation;
    function resources : iSafety4DResources;
    function groupPermission : iSafety4DGroup;
    function configurations : iSafety4DConfiguration;
    function userKey : iSafety4DUserKey;
    function getConfig (var aJson : TJsonObject ) : iSafety4D;
    function SaveToStorage ( aPath : String = '' ) : iSafety4D;
    function LoadConfig ( aJson : TJsonObject ) : iSafety4D;
  end;

  iSafety4DConfiguration = interface
    ['{E5561A2B-42D5-4A53-9EE6-57C1882C610D}']
    function exceptions( aValue : Boolean ) : iSafety4DConfiguration; overload;
    function exceptions : boolean; overload;
    function &end : iSafety4D;
  end;

  iSafety4DValidation = interface
    ['{3EB75190-778C-4E0B-ABE7-A17A78103C5B}']
    function userKey( aValue : String ) : iSafety4DValidation; overload;
    function userKey : String; overload;
    function resource ( aValue : String ) : iSafety4DValidation; overload;
    function resource : string; overload;
    function action ( aValue : String ) : iSafety4DValidation; overload;
    function action : string; overload;
    function application ( aValue : String ) : iSafety4DValidation; overload;
    function application : string; overload;
    function validate : boolean;
    function &end : iSafety4D;
  end;

  {$region 'Resources'}

  iSafety4DResources = interface
    ['{B6BDB9F9-0E07-42C2-82BF-B3425CA2C3FA}']
    function registerResources : iSafety4DResourcesRegister;
    function getResource ( var aJson : TJsonObject ) : iSafety4DResources;
    function exists ( aApplication : String;  aResource : String; aAction : String ) : Boolean;
    function &end : iSafety4D;
  end;

  iSafety4DResourcesRegister = interface
    ['{11448984-3C63-45C5-8F8A-3B6D679B93A9}']
    function resourcesGroupName : iSafety4DResourcesGroup;
    function getResourceGroups : TDictionary<string, iSafety4DResourcesGroupProvider>;
    function &end : iSafety4DResources;
  end;

  iSafety4DResourcesGroup = interface
    ['{02F44B1B-3AEB-4DCB-BB60-6959EB46830D}']
    function add ( aValue : String ) : iSafety4DResourcesGroup;
    function providerName : iSafety4DResourcesGroupProvider;
    function getResourcesGroupList : TDictionary<string, iSafety4DResourcesGroupProvider>;
    function &end : iSafety4DResourcesRegister;
  end;

  iSafety4DResourcesGroupProvider = interface
    ['{FB08025C-9831-4616-AFEE-22D40F25147D}']
    function add(aValue : String) : iSafety4DResourcesGroupProvider;
    function getProviderNames : TDictionary<string, iSafety4DResourcesGroupProviderActions>;
    function actions : iSafety4DResourcesGroupProviderActions;
    function &end : iSafety4DResourcesGroup;
  end;

  iSafety4DResourcesGroupProviderActions = interface
    ['{94AAE52D-4317-4262-9E1A-DB04D8A95E68}']
    function add(aValue : String) : iSafety4DResourcesGroupProviderActionsMsg;
    function getActions : TDictionary<string, iSafety4DResourcesGroupProviderActionsMsg>;
    function &end : iSafety4DResourcesGroupProvider;
  end;

  iSafety4DResourcesGroupProviderActionsMsg = interface
    ['{36CAC0FD-138E-41CE-A483-3D2AE768AACD}']
    function description( aValue : String ) : iSafety4DResourcesGroupProviderActionsMsg; overload;
    function errormsg ( aValue : String ) : iSafety4DResourcesGroupProviderActionsMsg; overload;
    function description : String; overload;
    function errormsg : String; overload;
    function &end : iSafety4DResourcesGroupProviderActions;
  end;
  {$endregion}

  {$region 'Group'}
  iSafety4DGroupActions = interface;
  iSafety4DGroupNotActions = interface;
  iSafety4DGroupRegister = interface;
  iSafety4DGroupListActions = interface;

  iSafety4DGroup = interface
    ['{F3E9A643-5FA7-49FA-994A-430B7DDE9FBF}']
    function groupRegister : iSafety4DGroupRegister;
    function getGroups (var aJson : TJsonObject ) : iSafety4DGroup;
    function getGroupPermission ( aValue : String ) : iSafety4DGroupListActions;
    function &end : iSafety4D;
  end;

  iSafety4DGroupRegister = interface
    function add ( aRoleName : String ) : iSafety4DGroupRegister;
    function actions : iSafety4DGroupActions;
    function notActions : iSafety4DGroupNotActions;
    function key ( aValue : String ) : iSafety4DGroupRegister; overload;
    function key : String; overload;
    function description (aValue : String ) : iSafety4DGroupRegister; overload;
    function description : String; overload;
    function getGroupsRegisters : TDictionary<string, iSafety4DGroupListActions>;
    function &end : iSafety4DGroup;
  end;

  iSafety4DGroupListActions = interface
    function key ( aValue : String ) : iSafety4DGroupListActions; overload;
    function key : string; overload;
    function description ( aValue : String ) : iSafety4DGroupListActions; overload;
    function description : String; overload;
    function actions : iSafety4DGroupActions;
    function notActions : iSafety4DGroupNotActions;
    function &end : iSafety4DGroupRegister;
  end;

  iSafety4DGroupActions = interface
    function add ( aValue : String ) : iSafety4DGroupActions;
    function getActions : TList<String>;
    function &end : iSafety4DGroupRegister;
  end;

  iSafety4DGroupNotActions = interface
    function add ( aValue : String ) : iSafety4DGroupNotActions;
    function getNotActions : TList<String>;
    function &end : iSafety4DGroupRegister;
  end;

  {$endregion}

  {$region 'userkey'}
  iSafety4DUserKeyRegister = interface;
  iSafety4DUserKeyRegisterGroupPermission = interface;

  iSafety4DUserKey = interface
    ['{89576374-693F-44F5-9B96-42DECA780927}']
    function registerUserKey : iSafety4DUserKeyRegister;
    function getUserKey (var aJson : TJsonObject ) : iSafety4DUserKey;
    function getUserKeyPermissions (aUserKey : String) : TArray<string>;
    function exists ( aUserKey : String ) : Boolean;
    function &end : iSafety4D;
  end;

  iSafety4DUserKeyRegister = interface
    ['{ACA41435-459E-4394-849B-E260B7993068}']
    function add ( aValue : String ) : iSafety4DUserKeyRegisterGroupPermission;
    function GetUserKeyRegister : TDictionary<string, iSafety4DUserKeyRegisterGroupPermission>;
    function &end : iSafety4DUserKey;
  end;

  iSafety4DUserKeyRegisterGroupPermission = interface
    ['{5D217EF2-579D-48AB-BCF9-432E68BFACD8}']
    function description ( aValue : String ) : iSafety4DUserKeyRegisterGroupPermission;  overload;
    function description : String; overload;
    function addPermission ( aValue : String ) : iSafety4DUserKeyRegisterGroupPermission;
    function GetPermissions : TList<String>;
    function &end : iSafety4DUserKeyRegister;
  end;
  {$endregion}

implementation

end.
