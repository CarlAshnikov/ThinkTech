unit uMain;

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
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Samples.Spin,
  IdBaseComponent,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  System.Actions,
  Vcl.ActnList,
  IdContext,
  IdCustomTCPServer,
  IdTCPServer;

type

  TMachineState = (msERROR, msRUNNING, msWAITING, msSTANDBY);

  TfrmMachineSimulator = class(TForm)
    idtcpclnt1: TIdTCPClient;
    l1: TLabel;
    eIPAddress: TEdit;
    l2: TLabel;
    sePort: TSpinEdit;
    gb1: TGroupBox;
    bConnect: TButton;
    actlst1: TActionList;
    actConnect: TAction;
    gb2: TGroupBox;
    gpMachinedata: TGridPanel;
    l3: TLabel;
    lMachineState: TLabel;
    l4: TLabel;
    lIdentification: TLabel;
    l5: TLabel;
    lMachineType: TLabel;
    tmr1: TTimer;
    gb3: TGroupBox;
    chk1: TCheckBox;
    shpConnected: TShape;
    l6: TLabel;
    chk2: TCheckBox;
    procedure idtcpclnt1Connected(Sender: TObject);
    procedure actConnectUpdate(Sender: TObject);
    procedure actConnectExecute(Sender: TObject);
    procedure eIPAddressChange(Sender: TObject);
    procedure sePortChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
    procedure chk1Click(Sender: TObject);
    procedure idtcpsrvr1Execute(AContext: TIdContext);
    procedure idtcpclnt1Disconnected(Sender: TObject);
    procedure chk2Click(Sender: TObject);

  private
    fIP:          string;
    fPort:        integer;
    fConnected:   Boolean;
    fID:          string;
    fMachineType: string;
    fState:       TMachineState;
    fSwitchStates: Boolean;
    fSendHeartbeat: Boolean;
    function StateToString(const AState: TMachineState): string;
    procedure SetConnect(const AValue: Boolean);
    procedure Connect();
    procedure Disconnect();
    procedure SendHeartBeat;
    procedure SendStuff(const AText: string);
    procedure SetState(const ANewState: TMachineState);
    procedure NextState;
  public

  end;

var
  frmMachineSimulator: TfrmMachineSimulator;

implementation

{$R *.dfm}

procedure TfrmMachineSimulator.actConnectExecute(Sender: TObject);
begin
  if fConnected then
    Disconnect()
  else
    Connect();
end;

procedure TfrmMachineSimulator.actConnectUpdate(Sender: TObject);
begin
  if not fConnected then
    actConnect.Caption := 'Verbinden'
  else
    actConnect.Caption := 'Abmelden';
end;

procedure TfrmMachineSimulator.chk1Click(Sender: TObject);
begin
  fSwitchStates := chk1.Checked;
end;

procedure TfrmMachineSimulator.chk2Click(Sender: TObject);
begin
  fSendHeartbeat := chk2.Checked;
end;

procedure TfrmMachineSimulator.Connect;
begin
  idtcpclnt1.Host := fIP;
  idtcpclnt1.Port := fPort;
  idtcpclnt1.Connect;
  SendStuff('<CONNECT|' + fID + '>');
  fConnected := true;
end;

procedure TfrmMachineSimulator.Disconnect;
begin
  SendStuff('<DISCONNECT>');
  idtcpclnt1.Disconnect;
end;

procedure TfrmMachineSimulator.eIPAddressChange(Sender: TObject);
begin
  fIP := eIPAddress.Text;
end;

procedure TfrmMachineSimulator.FormCreate(Sender: TObject);
begin
  fPort := 50000;
  fIP := 'localhost';
  fID := '0123456-7891021-2345';
  fMachineType := 'VicoXTec';
  sePort.Value := fPort;
  eIPAddress.Text := fIP;
  lMachineType.Caption := fMachineType;
  lMachineState.Caption := StateToString(fState);
  lIdentification.Caption := fID;
end;

procedure TfrmMachineSimulator.idtcpclnt1Connected(Sender: TObject);
begin
  SetConnect(True);
end;

procedure TfrmMachineSimulator.idtcpclnt1Disconnected(Sender: TObject);
begin
  SetConnect(False);
end;

procedure TfrmMachineSimulator.idtcpsrvr1Execute(AContext: TIdContext);
var
  clientmessage: string;
begin
  if not idtcpclnt1.Connected then
    Exit;
  while idtcpclnt1.IOHandler.CheckForDataOnSource(100) do
  begin
    clientmessage := idtcpclnt1.IOHandler.InputBufferAsString.Trim;
    if clientmessage = '<GETSTATE>' then
      SendStuff('<STATE|' + StateToString(fState) + '>')
    else
    if clientmessage = '<GETTYPE>' then
      SendStuff('<TYPE|' + fMachineType + '>');
  end;
end;

procedure TfrmMachineSimulator.sePortChange(Sender: TObject);
begin
  fPort := sePort.Value;
end;

procedure TfrmMachineSimulator.SetConnect(const AValue: Boolean);
begin
  if AValue then
    shpConnected.Brush.Color := clGreen
  else
    shpConnected.Brush.Color := clRed;
  fConnected := AValue;
end;

procedure TfrmMachineSimulator.SetState(const ANewState: TMachineState);
begin
  if ANewState = fState then
    Exit();

  //SendStuff('<STATECHANGED|' + StateToString(fState) + '|' + StateToString(ANewState) + '>');

  fState := ANewState;
  SendStuff('<STATE|' + StateToString(fState) + '>');
  lMachineState.Caption := StateToString(fState);
end;

function TfrmMachineSimulator.StateToString(const AState: TMachineState): string;
begin
  case AState of
    msERROR:
      result := 'ERROR';
    msRUNNING:
      result := 'RUNNING';
    msWAITING:
      result := 'WAITING';
    msSTANDBY:
      result := 'STANDBY';
  else
    raise Exception.Create('Wrong Type');
  end;
end;

procedure TfrmMachineSimulator.NextState();
begin
  SetState( TMachineState((Ord(fState) + 1) mod 4));
end;

procedure TfrmMachineSimulator.tmr1Timer(Sender: TObject);
begin
  if idtcpclnt1.Connected and fSendHeartbeat then
    Sendheartbeat();

  if fSwitchStates then
    NextState;

  idtcpsrvr1Execute(nil);
end;

procedure TfrmMachineSimulator.SendStuff(const AText: string);
begin
  if not idtcpclnt1.Connected then
    Exit();

  idtcpclnt1.IOHandler.Write(AText);
end;

procedure TfrmMachineSimulator.SendHeartBeat();
begin
  SendStuff('<HEARTBEAT>')
end;

end.
