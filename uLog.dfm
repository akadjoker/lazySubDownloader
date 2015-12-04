object Form2: TForm2
  Left = 399
  Top = 257
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'Configuration'
  ClientHeight = 245
  ClientWidth = 286
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object btn1: TButton
    Left = 112
    Top = 208
    Width = 75
    Height = 25
    Caption = 'Ok'
    TabOrder = 0
    OnClick = btn1Click
  end
  object GroupBox1: TGroupBox
    Left = 16
    Top = 16
    Width = 249
    Height = 105
    Caption = 'OpenSubtile User'
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 18
      Width = 52
      Height = 13
      Caption = 'User Name'
    end
    object Label2: TLabel
      Left = 19
      Top = 58
      Width = 47
      Height = 13
      Caption = 'User Pass'
    end
    object edt1: TEdit
      Left = 11
      Top = 34
      Width = 217
      Height = 21
      TabOrder = 0
      Text = 'Name'
    end
    object edt2: TEdit
      Left = 11
      Top = 74
      Width = 217
      Height = 21
      TabOrder = 1
      Text = 'Pass'
    end
  end
  object GroupBox2: TGroupBox
    Left = 16
    Top = 128
    Width = 249
    Height = 65
    Caption = 'Search Languages '
    TabOrder = 2
    object Edit3: TEdit
      Left = 8
      Top = 28
      Width = 225
      Height = 21
      TabOrder = 0
      Text = 'por,pob'
    end
  end
end
