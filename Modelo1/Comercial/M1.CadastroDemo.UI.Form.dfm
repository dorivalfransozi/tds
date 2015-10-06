object ViewCadastroDemo: TViewCadastroDemo
  Left = 0
  Top = 0
  Caption = 'ViewCadastroDemo'
  ClientHeight = 154
  ClientWidth = 324
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 29
    Width = 27
    Height = 13
    Caption = 'Name'
  end
  object Label2: TLabel
    Left = 168
    Top = 32
    Width = 19
    Height = 13
    Caption = 'Age'
  end
  object VCName: TEdit
    Left = 24
    Top = 48
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'VCName'
  end
  object VCAge: TEdit
    Left = 168
    Top = 48
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'VCAge'
  end
  object Button1: TButton
    Left = 118
    Top = 96
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 214
    Top = 96
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 3
  end
end
