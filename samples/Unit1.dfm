object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 846
  ClientWidth = 843
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    843
    846)
  PixelsPerInch = 96
  TextHeight = 13
  object GetResources: TButton
    Left = 401
    Top = 353
    Width = 161
    Height = 35
    Caption = 'GetResources'
    TabOrder = 0
    OnClick = GetResourcesClick
  end
  object Memo1: TMemo
    Left = 8
    Top = 8
    Width = 387
    Height = 833
    Anchors = [akLeft, akTop, akBottom]
    Lines.Strings = (
      '{'
      '    "resources": {'
      '        "safety4d": {'
      '            "users": {'
      '                "actions": {'
      '                    "read": {'
      '                        "description": "read-only",'
      '                        "errormsg": "not permit"'
      '                    },'
      '                    "write": {'
      '                        "description": "read-write",'
      '                        "errormsg": "not write data"'
      '                    },'
      '                    "delete": {'
      '                        "description": "delete-data",'
      '                        "errormsg": "not delete data"'
      '                    },'
      '                    "view": {'
      '                        "description": "view data",'
      '                        "errormsg": "not view data"'
      '                    }'
      '                }'
      '            }'
      '        }'
      '    },'
      '    "groupPermission": {'
      '        "{4D62E4C3-C73D-488A-8518-03A9545B5611}": {'
      '            "key": "Gerente",'
      
        '            "description": "Permissoes completa de gestao do Sis' +
        'tema",'
      '            "Actions": ['
      '                "users.write"'
      '            ],'
      '            "NotActions": ['
      '                "*"'
      '            ]'
      '        },'
      '        "{C188D1AB-EC28-4380-96E0-D1B13A29A8B3}": {'
      '            "key": "Comercial",'
      '            "description": "Permissoes de Recursos Comerciais",'
      '            "Actions": ['
      '                "*"'
      '            ],'
      '            "NotActions": ['
      '                "users.delete",'
      '                "users.write"'
      '            ]'
      '        }'
      '    },'
      '    "userKeys": {'
      '        "{34C940ED-50E7-4CE3-B701-03CF1E15F28B}": {'
      '            "description": "Fulano de Tal",'
      '            "permissionGroups": ['
      '                "{4D62E4C3-C73D-488A-8518-03A9545B5611}"'
      '            ]'
      '        },'
      '        "{96B4C46F-0EBB-443B-B309-09C81844406E}": {'
      '            "description": "Beltrano",'
      '            "permissionGroups": ['
      '                "{C188D1AB-EC28-4380-96E0-D1B13A29A8B3}"'
      '            ]'
      '        }'
      '    }'
      '}')
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object Button1: TButton
    Left = 401
    Top = 394
    Width = 161
    Height = 35
    Caption = 'CreateGroupPermission'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 568
    Top = 271
    Width = 161
    Height = 35
    Caption = 'RegisterUserKeys'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 568
    Top = 312
    Width = 161
    Height = 35
    Caption = 'GetSafety4DConfig'
    TabOrder = 4
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 401
    Top = 312
    Width = 161
    Height = 35
    Caption = 'RegisterResource'
    TabOrder = 5
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 568
    Top = 353
    Width = 161
    Height = 35
    Caption = 'SaveSafety4DConfig'
    TabOrder = 6
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 568
    Top = 394
    Width = 161
    Height = 35
    Caption = 'LoadSafety4DConfig'
    TabOrder = 7
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 401
    Top = 435
    Width = 161
    Height = 35
    Caption = 'GetGroupsPermissions'
    TabOrder = 8
    OnClick = Button7Click
  end
  object GroupBox1: TGroupBox
    Left = 401
    Top = 8
    Width = 434
    Height = 257
    Caption = 'Validar Permiss'#227'o'
    TabOrder = 9
    object edtUserKey: TLabeledEdit
      Left = 16
      Top = 40
      Width = 401
      Height = 21
      EditLabel.Width = 40
      EditLabel.Height = 13
      EditLabel.Caption = 'UserKey'
      TabOrder = 0
      Text = '{34C940ED-50E7-4CE3-B701-03CF1E15F28B}'
    end
    object edtApplication: TLabeledEdit
      Left = 16
      Top = 80
      Width = 401
      Height = 21
      EditLabel.Width = 52
      EditLabel.Height = 13
      EditLabel.Caption = 'Application'
      TabOrder = 1
      Text = 'safety4d'
    end
    object edtResource: TLabeledEdit
      Left = 16
      Top = 120
      Width = 401
      Height = 21
      EditLabel.Width = 45
      EditLabel.Height = 13
      EditLabel.Caption = 'Resource'
      TabOrder = 2
      Text = 'users'
    end
    object edtAction: TLabeledEdit
      Left = 16
      Top = 160
      Width = 401
      Height = 21
      EditLabel.Width = 30
      EditLabel.Height = 13
      EditLabel.Caption = 'Action'
      TabOrder = 3
      Text = 'delete'
    end
    object Button8: TButton
      Left = 216
      Top = 200
      Width = 202
      Height = 33
      Caption = 'Validar Permiss'#227'o'
      TabOrder = 4
      OnClick = Button8Click
    end
  end
  object Button9: TButton
    Left = 401
    Top = 271
    Width = 161
    Height = 35
    Caption = 'RegisterApplication'
    TabOrder = 10
    OnClick = Button4Click
  end
end
