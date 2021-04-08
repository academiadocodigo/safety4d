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
  Vcl.StdCtrls, Vcl.ExtCtrls;

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
    GroupBox1: TGroupBox;
    edtUserKey: TLabeledEdit;
    edtApplication: TLabeledEdit;
    edtResource: TLabeledEdit;
    edtAction: TLabeledEdit;
    Button8: TButton;
    Button9: TButton;
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
    procedure __ReloadConfig;
    procedure __ReWriteMemoConfig;
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
    Memo1.Lines.Add(aJsonSafety4D.Format);
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
    Memo1.Lines.Add(aJsonSafety4D.Format);
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
    Memo1.Lines.Add(aJsonSafety4D.Format);
  finally
    aJsonSafety4D.Free;
  end;
end;

procedure TForm1.__ReloadConfig;
var
  aJson : TJsonObject;
begin
  vSafety4D := nil;
  aJson := TJSONObject.ParseJSONValue(Memo1.Lines.Text) as TJsonObject;
  try
    TSafety4D
    .New
      .LoadConfig(aJson);
  finally
    aJson.Free;
  end;
end;

procedure TForm1.__ReWriteMemoConfig;
var
  aJsonConfig : TJsonObject;
begin
  Memo1.Lines.Clear;
  aJsonConfig := TJsonObject.Create;
  try
    TSafety4D.New.getConfig(aJsonConfig);
    Memo1.Lines.Add(aJsonConfig.Format);
  finally
    aJsonConfig.Free;
  end;
end;

procedure TForm1.GetResourcesClick(Sender: TObject);
begin
  _GetResources;
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
    Memo1.Lines.Add(aJsonSafety4D.Format);
  finally
    aJsonSafety4D.Free;
  end;

end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  TSafety4D
  .New
    .resources
      .registerResources
        .resourcesGroupName
          .add('newapplication')
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
          .&end;

  __ReWriteMemoConfig;
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
  __ReloadConfig;
  try
    TSafety4D.New
    .configurations
      .exceptions(True)
    .&end
    .Validation
      .userKey(edtUserKey.Text)
      .application(edtApplication.Text)
      .resource(edtResource.Text)
      .action(edtAction.Text)
    .validate;
    ShowMessage('Usuario Autorizado');
  except on e : Exception do
    raise Exception.Create(e.Message);
  end;
end;

procedure TForm1.RegisterResources;
begin
  
end;

end.
