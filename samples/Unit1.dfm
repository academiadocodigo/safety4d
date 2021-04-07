object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 574
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
    574)
  PixelsPerInch = 96
  TextHeight = 13
  object GetResources: TButton
    Left = 8
    Top = 49
    Width = 161
    Height = 35
    Caption = 'GetResources'
    TabOrder = 0
    OnClick = GetResourcesClick
  end
  object Memo1: TMemo
    Left = 320
    Top = 8
    Width = 515
    Height = 558
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
    ExplicitWidth = 451
    ExplicitHeight = 438
  end
  object Button1: TButton
    Left = 8
    Top = 90
    Width = 161
    Height = 35
    Caption = 'CreateGroupPermission'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 174
    Width = 161
    Height = 35
    Caption = 'RegisterUserKeys'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 231
    Width = 161
    Height = 35
    Caption = 'GetSafety4DConfig'
    TabOrder = 4
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 8
    Top = 8
    Width = 161
    Height = 35
    Caption = 'RegisterResource'
    TabOrder = 5
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 8
    Top = 295
    Width = 161
    Height = 35
    Caption = 'SaveSafety4DConfig'
    TabOrder = 6
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 8
    Top = 359
    Width = 161
    Height = 35
    Caption = 'LoadSafety4DConfig'
    TabOrder = 7
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 8
    Top = 131
    Width = 161
    Height = 35
    Caption = 'GetGroupsPermissions'
    TabOrder = 8
    OnClick = Button7Click
  end
  object Button8: TButton
    Left = 48
    Top = 464
    Width = 121
    Height = 25
    Caption = 'Button8'
    TabOrder = 9
    OnClick = Button8Click
  end
  object Edit1: TEdit
    Left = 48
    Top = 437
    Width = 121
    Height = 21
    TabOrder = 10
    Text = 'delete'
  end
end
