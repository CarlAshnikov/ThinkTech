object frmMachineSimulator: TfrmMachineSimulator
  Left = 0
  Top = 0
  Caption = 'MachineSimulator'
  ClientHeight = 261
  ClientWidth = 469
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
  object gb1: TGroupBox
    Left = 8
    Top = 0
    Width = 161
    Height = 137
    Caption = 'Verbindung'
    TabOrder = 0
    object l1: TLabel
      Left = 8
      Top = 16
      Width = 49
      Height = 13
      Caption = 'IPAdresse'
    end
    object l2: TLabel
      Left = 8
      Top = 48
      Width = 20
      Height = 13
      Caption = 'Port'
    end
    object shpConnected: TShape
      Left = 8
      Top = 76
      Width = 145
      Height = 24
    end
    object l6: TLabel
      Left = 49
      Top = 82
      Width = 52
      Height = 13
      Caption = 'Verbunden'
    end
    object eIPAddress: TEdit
      Left = 64
      Top = 16
      Width = 89
      Height = 21
      TabOrder = 0
      Text = 'localhost'
      OnChange = eIPAddressChange
    end
    object sePort: TSpinEdit
      Left = 64
      Top = 48
      Width = 89
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 1
      Value = 50000
      OnChange = sePortChange
    end
    object bConnect: TButton
      Left = 8
      Top = 101
      Width = 145
      Height = 32
      Action = actConnect
      TabOrder = 2
    end
  end
  object gb2: TGroupBox
    Left = 175
    Top = 0
    Width = 282
    Height = 137
    Caption = 'Machinendaten'
    TabOrder = 1
    object gpMachinedata: TGridPanel
      Left = 2
      Top = 15
      Width = 278
      Height = 120
      Align = alClient
      ColumnCollection = <
        item
          Value = 39.999975999990400000
        end
        item
          Value = 60.000024000009600000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = l3
          Row = 0
        end
        item
          Column = 1
          Control = lMachineState
          Row = 0
        end
        item
          Column = 0
          Control = l4
          Row = 1
        end
        item
          Column = 1
          Control = lIdentification
          Row = 1
        end
        item
          Column = 0
          Control = l5
          Row = 2
        end
        item
          Column = 1
          Control = lMachineType
          Row = 2
        end>
      RowCollection = <
        item
          Value = 33.333333333333340000
        end
        item
          Value = 33.333333333333340000
        end
        item
          Value = 33.333333333333340000
        end>
      TabOrder = 0
      DesignSize = (
        278
        120)
      object l3: TLabel
        Left = 36
        Top = 14
        Width = 39
        Height = 13
        Anchors = []
        Caption = 'Zustand'
        ExplicitLeft = 29
      end
      object lMachineState: TLabel
        Left = 160
        Top = 14
        Width = 67
        Height = 13
        Anchors = []
        Caption = 'lMachineState'
        ExplicitLeft = 161
      end
      object l4: TLabel
        Left = 24
        Top = 53
        Width = 63
        Height = 13
        Anchors = []
        Caption = 'Identifikation'
        ExplicitLeft = 17
      end
      object lIdentification: TLabel
        Left = 156
        Top = 53
        Width = 75
        Height = 13
        Anchors = []
        Caption = 'QWERTZUIOP'#220
        ExplicitLeft = 160
      end
      object l5: TLabel
        Left = 47
        Top = 92
        Width = 18
        Height = 13
        Anchors = []
        Caption = 'Typ'
        ExplicitLeft = 44
      end
      object lMachineType: TLabel
        Left = 161
        Top = 92
        Width = 65
        Height = 13
        Anchors = []
        Caption = 'lMachineType'
        ExplicitLeft = 190
      end
    end
  end
  object gb3: TGroupBox
    Left = 176
    Top = 139
    Width = 279
    Height = 56
    Caption = 'Verhalten'
    TabOrder = 2
    object chk1: TCheckBox
      Left = 9
      Top = 16
      Width = 97
      Height = 17
      Caption = #196'ndere Status'
      TabOrder = 0
      OnClick = chk1Click
    end
    object chk2: TCheckBox
      Left = 112
      Top = 16
      Width = 97
      Height = 17
      Caption = 'Sende Heartbeat'
      TabOrder = 1
      OnClick = chk2Click
    end
  end
  object idtcpclnt1: TIdTCPClient
    OnDisconnected = idtcpclnt1Disconnected
    OnConnected = idtcpclnt1Connected
    ConnectTimeout = 0
    IPVersion = Id_IPv4
    Port = 0
    ReadTimeout = -1
    Left = 232
    Top = 208
  end
  object actlst1: TActionList
    Left = 280
    Top = 208
    object actConnect: TAction
      Caption = 'actConnect'
      OnExecute = actConnectExecute
      OnUpdate = actConnectUpdate
    end
  end
  object tmr1: TTimer
    OnTimer = tmr1Timer
    Left = 184
    Top = 208
  end
end
