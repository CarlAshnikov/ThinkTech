object Form1: TForm1
  Left = 516
  Top = 233
  Caption = #195#339'bungen'
  ClientHeight = 619
  ClientWidth = 888
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object FlowPanel1: TFlowPanel
    Left = 0
    Top = 0
    Width = 574
    Height = 619
    Align = alClient
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 574
    Top = 0
    Width = 314
    Height = 619
    Align = alRight
    Anchors = []
    Caption = 'Panel1'
    TabOrder = 1
    object lbLog: TListBox
      Left = 1
      Top = 1
      Width = 312
      Height = 473
      Align = alTop
      ItemHeight = 13
      Items.Strings = (
        'Ausgabe:')
      TabOrder = 0
    end
    object bTestAll: TButton
      Left = 1
      Top = 474
      Width = 191
      Height = 94
      Align = alClient
      Caption = 'Teste alle'
      TabOrder = 1
      OnClick = bTestAllClick
    end
    object bClear: TButton
      Left = 192
      Top = 474
      Width = 121
      Height = 94
      Align = alRight
      Caption = 'L'#246'schen'
      TabOrder = 2
      OnClick = bClearClick
    end
    object bIWantWhattesting: TButton
      Left = 1
      Top = 568
      Width = 312
      Height = 50
      Align = alBottom
      Caption = 'Ich will was testen!'
      TabOrder = 3
    end
  end
end
