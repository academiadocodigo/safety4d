unit Unit1;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    GetResources: TButton;
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Edit1: TEdit;
    procedure GetResourcesClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
  private
    { Private declarations }
    procedure RegisterResources;
    procedure _GetResources;
    procedure _GetGroupsPermissions;
    procedure _GetUserKeys;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  Safety4D,
  System.JSON,
  Rest.Json,
  System.IOUtils;

procedure TForm1._GetGroupsPermissions;
var
  aJsonSafety4D : TJsonObject;
begin
  aJsonSafety4D := TJSONObject.Create;
  try
    TSafety4D
    .New
      .groupPermission
        .getGroups(aJsonSafety4D);

    Memo1.Lines.Clear;
    Memo1.Lines.Add(TJson.Format(aJsonSafety4D));
  finally
    aJsonSafety4D.Free;
  end;

end;

procedure TForm1._GetResources;
var
  aJsonSafety4D : TJsonObject;
begin
  aJsonSafety4D := TJSONObject.Create;
  try
    TSafety4D
    .New
      .resources
        .getResource(aJsonSafety4D);

    Memo1.Lines.Clear;
    Memo1.Lines.Add(TJson.Format(aJsonSafety4D));
  finally
    aJsonSafety4D.Free;
  end;
end;

procedure TForm1._GetUserKeys;
var
  aJsonSafety4D : TJsonObject;
begin
  aJsonSafety4D := TJSONObject.Create;
  try
    TSafety4D
    .New
      .userKey
        .getUserKey(aJsonSafety4D);

    Memo1.Lines.Clear;
    Memo1.Lines.Add(TJson.Format(aJsonSafety4D));
  finally
    aJsonSafety4D.Free;
  end;
end;

procedure TForm1.GetResourcesClick(Sender: TObject);
begin
  _GetResources;

  {*
    TRbac4D
    .New

      //Como registrar os recursos
      //Default Resource [view, read, write, delete, action]

      //<sGroup, TDictionary<sProviderName, TDictionary<sActions, string>>>;




      //Buscar grupo de permissões
      TRbac4D
        .New
          .getFunctionDefinitions; //TArray<TFunctionDefinition>


      //Busar Resources
      TRbac4D
        .New
          .getResourcesGroup('GroupName'); //TArray<TResourcesGroupName>


      //Como validar o acesso a um recurso
      TRbac4D
        .New
          .validateAccess
            .roleName('operador')
            .group('housex')
            .provider('user')
            .resource('Actions.getSaldo')
          .Execute; //Boolean


      //Atribuir as Roles na instancia global
      TRbac4D
        .New
          .roleName('operador|marketing|gerente');


      TRbac4D
        .New
          .loadConfiguration(aJsonString);

      TRbac4D
        .New
          .saveConfiguration; //Retorna JsonString;

  *}
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  TSafety4D
    .New
      .groupPermission
        .groupRegister
          .add('Gerente')
            .description('Permissões completa de gestão do Sistema')
            .actions
              .add('*')
            .&end
            .notActions
              .add('users.delete')
              .add('users.write')
            .&end
          .&end

          .groupRegister
            .add('Comercial')
            .description('Permissões de Recursos Comerciais')
            .actions
              .add('*')
            .&end
            .notActions
              .add('users.delete')
              .add('users.write')
            .&end
          .&end
        .&end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  TSafety4D
    .New
      .userKey
        .registerUserKey
          .Add('Fulano de Tal')
            .addPermission('Gerente')
          .&end
          .Add('Beltrano')
            .addPermission('Comercial')
          .&end
        .&end
      .&end;

  _GetUserKeys;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  aJsonSafety4D : TJsonObject;
begin
  aJsonSafety4D := TJSONObject.Create;
  try
    TSafety4D.New.getConfig(aJsonSafety4D);

    Memo1.Lines.Clear;
    Memo1.Lines.Add(TJson.Format(aJsonSafety4D));
  finally
    aJsonSafety4D.Free;
  end;

end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  RegisterResources;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  TSafety4D.New.SaveToStorage();
end;

procedure TForm1.Button6Click(Sender: TObject);
var
  JSONValue : TJsonValue;
  LFileName: string;
begin
  LFileName := ChangeFileExt(ParamStr(0), '.s4d');
  JSONValue := TJSONObject.ParseJSONValue(TFile.ReadAllText(LFileName));
  try
    TSafety4D.New.LoadConfig(JSONValue as TJSONObject);
  finally
    JSONValue.Free;
  end;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  _GetGroupsPermissions;
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  try
    TSafety4D.New
    .Validation
      .userKey('{34C940ED-50E7-4CE3-B701-03CF1E15F28B}')
      .application('delphitohero')
      .resource('users')
      .action(edit1.Text)
    .validate;
    ShowMessage('Usuario Autorizado');
  except on e : Exception do
    raise Exception.Create(e.Message);
  end;
end;

procedure TForm1.RegisterResources;
begin
  TSafety4D
  .New
    .resources
      .registerResources
        .resourcesGroupName
          .add('delphitohero')
          .providerName
            .add('users')
            .actions
              .add('read')
                .description('read-only')
                .errormsg('not permit')
              .&end
              .add('write')
                .description('read-write')
                .errormsg('not write data')
              .&end
              .add('delete')
                .description('delete-data')
                .errormsg('not delete data')
              .&end
              .add('view')
                .description('view data')
                .errormsg('not view data')
              .&end
            .&end
          .&end
        .&end
      .&end
    .&end;
end;

end.
