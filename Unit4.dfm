object Form4: TForm4
  Left = 283
  Top = 157
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'IMDB '
  ClientHeight = 475
  ClientWidth = 729
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 24
    Top = 88
    Width = 329
    Height = 329
    Stretch = True
  end
  object Label1: TLabel
    Left = 40
    Top = 16
    Width = 34
    Height = 13
    Caption = 'Name :'
  end
  object Label2: TLabel
    Left = 40
    Top = 42
    Width = 38
    Height = 13
    Caption = 'Rating :'
  end
  object Memo1: TMemo
    Left = 376
    Top = 88
    Width = 329
    Height = 329
    Color = cl3DDkShadow
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clYellow
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object Button1: TButton
    Left = 312
    Top = 440
    Width = 75
    Height = 25
    Caption = 'Ok'
    TabOrder = 1
    OnClick = Button1Click
  end
end
