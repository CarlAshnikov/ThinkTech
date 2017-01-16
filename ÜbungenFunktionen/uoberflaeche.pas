unit uOberflaeche;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  SysUtils,
  FileUtil,
  Forms,
  Controls,
  Graphics,
  Dialogs,
  StdCtrls,
  ExtCtrls,
  uFunktionen;

type

  { TForm1 }

  TMyProc = function(): Boolean of object;

  { TTests }

  TTests = class(TObject)
    fProc: TMyProc;
    fText: string;
    fIsDone: Boolean;
    fPanel: TPanel;
    constructor Create(AProc: TMyProc; AText: string);
  end;

  TForm1 = class(TForm)
    bTestAll: TButton;
    bClear: TButton;
    bIWantWhattesting: TButton;
    FlowPanel1: TFlowPanel;
    lbLog: TListBox;
    Panel1: TPanel;
    procedure bClearClick(Sender: TObject);
    procedure bIWantWhattestingClick(Sender: TObject);
    procedure bTestAllClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    fTests: TList;
    fUebungen: TUebungen;
    procedure AddTests;
    procedure BuildPanel(ANumber: integer);
    procedure BuildPanels;
    procedure ButtonClicked(Sender: Tobject);
    procedure CheckAllTests;
    procedure ExecuteTest(const ANumber: integer);
    function Test1: Boolean;
    function Test2: Boolean;
    function Test3: Boolean;
    function Test4: Boolean;
    function Test5: Boolean;
    function Test6: Boolean;
    function Test7: Boolean;
    function Test8: Boolean;
    function Test9: Boolean;
    function Test10: Boolean;
    function Test11: Boolean;
    procedure Log(AText: string);
  public

  end;

var
  Form1: TForm1;

implementation


{$R *.lfm}

{ TTests }

constructor TTests.Create(AProc: TMyProc; AText: string);
begin
  fProc := AProc;
  fText := AText;
end;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  fTests := TList.Create;
  AddTests;
  BuildPanels;
  fUebungen := Tuebungen.Create();
end;

procedure TForm1.bTestAllClick(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to fTests.Count - 1 do
    ExecuteTest(i);

  CheckAllTests;
end;

procedure TForm1.bClearClick(Sender: TObject);
begin
  lbLog.Items.Clear;
  lbLog.Items.Add('Ausgabe:');
end;

procedure TForm1.bIWantWhattestingClick(Sender: TObject);
begin

end;

procedure TForm1.BuildPanels();
var
  i: integer;
begin
  for i := 0 to fTests.Count - 1 do
    BuildPanel(i);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  fTests.Free;
  fUebungen.Free;
end;

procedure TForm1.BuildPanel(ANumber: integer);
var
  fPanel: TPanel;
  fLabel: TLabel;
  fButton: TButton;
begin
  fPanel := TPanel.Create(FlowPanel1);
  fPanel.Parent := FlowPanel1;
  fPanel.Height := 80;
  fPanel.Color := clRed;
  fLabel := TLabel.Create(fPanel);
  fLabel.Parent := fPanel;
  fLabel.Caption := TTests(fTests[ANumber]).fText;
  fLabel.Align := alTop;
  fLabel.WordWrap := true;
  fButton := TButton.Create(fPanel);
  fButton.Parent:= fPanel;
  fButton.Caption := 'Test';
  fButton.Tag := ANumber;
  fButton.Align := alTop;
  fButton.OnClick := @ButtonClicked;
  TTests(fTests[ANumber]).fPanel := fPanel;
end;

procedure TForm1.ButtonClicked(Sender: Tobject);
var
  vBut: TButton;
begin
  vBut := TButton(Sender);
  if vBut.Tag > fTests.Count - 1 then
    Exit();

  ExecuteTest(vBut.Tag);

  CheckAllTests();
end;

procedure Tform1.ExecuteTest(Const ANumber: integer);
var
   vTest: TTests;
begin
  Log('Test ' + IntToStr(ANumber + 1));
  vTest := TTests(fTests[ANumber]);
  if vTest.fProc() then
    vTest.fIsDone := true;
end;

procedure TForm1.CheckAllTests();
var
  I, fReadyCount: integer;
begin
  fReadyCount := 0;
  for i := 0 to fTests.Count - 1 do
    with TTests(fTests[i]) do
      if fIsDone then
      begin
        fPanel.Color := clGreen;
        inc(fReadyCount);
      end
      else
        fPanel.Color := clRed;
  Log(IntToStr(fReadyCount) + ' von ' + IntToStr(fTests.Count) + ' Aufgaben erledigt');
  if fReadyCount = fTests.Count then
    ShowMessage('Herzlichen Glückwunsch du hast alle Aufgaben erledigt !');
end;

procedure TForm1.AddTests;
begin
  fTests.Add(TTests.Create(@Test1, 'Aufgabe 1 Bin ich drin?'));
  fTests.Add(TTests.Create(@Test2, 'Aufgabe 2 Berechne die Summe aller Zahlen von 1 bis n.'));
  fTests.Add(TTests.Create(@Test3, 'Aufgabe 3 !murehtrhekreV'));
  fTests.Add(TTests.Create(@Test4, 'Aufgabe 4 Zähle alle Vokale!'));
  fTests.Add(TTests.Create(@Test5, 'Aufgabe 5 Buchstabiere das Wort!'));
  fTests.Add(TTests.Create(@Test6, 'Aufgabe 6 Sage die Ziffern!'));
  fTests.Add(TTests.Create(@Test7, 'Aufgabe 7 Berechne die Summe!'));
  fTests.Add(TTests.Create(@Test8, 'Aufgabe 8 Welche Zahl in der Folge fehlt?'));
  fTests.Add(TTests.Create(@Test9, 'Aufgabe 9 Begrüße mich!'));
  fTests.Add(TTests.Create(@Test10, 'Aufgabe 10 Berechne die Hypotenuse'));
  fTests.Add(TTests.Create(@Test11, 'Aufgabe 11 Sags mir später.'));
end;

function TForm1.Test1: Boolean;
begin
  result := false;
  Log('Teste 1 2 3');
  if fUebungen.BinIchDrin(1, 2, 3) then
  begin
    Log('Ergebnis nicht korrekt');
    Exit();
  end;
  Log('Teste 1 2 2');
  if not fUebungen.BinIchDrin(1, 2, 2) then
  begin
    Log('Ergebnis nicht korrekt');
    Exit();
  end;

  Log('Teste 1 2 1');
  if not fUebungen.BinIchDrin(1, 2, 1) then
  begin
    Log('Ergebnis nicht korrekt');
    Exit();
  end;

  Log('Teste 2 45 1');
  if fUebungen.BinIchDrin(2, 45, 1) then
  begin
    Log('Ergebnis nicht korrekt');
    Exit();
  end;
  result := true;
end;

function TForm1.Test2: Boolean;
begin
  result := false;
  Log('Teste 4');
  if fUebungen.Summe1bisN(4) <> 10 then
  begin
    Log('Ergebnis nicht korrekt');
    Exit();
  end;

  Log('Teste 125');
  if fUebungen.Summe1bisN(125) <> 7875 then
  begin
    Log('Ergebnis nicht korrekt');
    Exit();
  end;
  result := true;
end;

function TForm1.Test3: Boolean;
begin
  result := false;

  Log('Teste Hallo Welt');
  if not (fUebungen.murehtrhekreV('Hallo') = 'tleW ollaH') then
  begin
    Log('Ergebnis nicht korrekt');
    Exit();
  end;

  Log('Teste murehtrhekreV');
  if not (fUebungen.murehtrhekreV('murehtrhekreV') = 'Verkehrtherum')then
  begin
    Log('Ergebnis nicht korrekt');
    Exit();
  end;

  result := true;
end;

function TForm1.Test4: Boolean;
begin
  result := false;
  Log('Teste Hallo Welt');
  if fUebungen.ZaehleDieVokale('Hallo Welt') <> 3 then
  begin
    Log('Ergebnis nicht korrekt');
    Exit();
  end;

  Log('Teste Skrzlbt');
  if not fUebungen.ZaehleDieVokale('Skrzlbt') <> 0 then
  begin
    Log('Ergebnis nicht korrekt');
    Exit();
  end;

  Log('Teste AeIoU');
  if fUebungen.ZaehleDieVokale('AeIoU') <> 5 then
  begin
    Log('Ergebnis nicht korrekt');
    Exit();
  end;

  result := true;
end;

function TForm1.Test5: Boolean;
begin
  result := false;

  Log('Teste abcdefghijklmnopqrstuvwxyz');
  if not (fUebungen.BuchstabiereDasWort('abc') = 'a be ce de e ef ge ha i jot ka el em en o pe qu er es te u vau we ix ypsilon zet') then
  begin
    Log('Ergebnis nicht korrekt');
    Exit();
  end;

  Log('Teste Hippopotamus');
  if not (fUebungen.BuchstabiereDasWort('Hippopotamus') = 'Ha i pe pe o te o te a em u es') then
  begin
    Log('Ergebnis nicht korrekt');
    Exit();
  end;

  Log('Teste Dampfschifffahrtkapitaen');
  if not (fUebungen.BuchstabiereDasWort('Hippopotamus') = 'De a em pe ef es ce ha i ef ef ef a ha er te ka a pe i te a e en') then
  begin
    Log('Ergebnis nicht korrekt');
    Exit();
  end;

  result := true;
end;

function TForm1.Test6: Boolean;
begin
  result := false;
  Log('Teste 12345');
  if not (fUebungen.SageDieZiffern(12345) = 'eins zwei drei vier fünf') then
  begin
    Log('Ergebnis nicht korrekt');
    Exit();
  end;
  Log('Teste 9084563217');
  if not (fUebungen.SageDieZiffern(9084567) = 'neun null acht vier fünf sechs sieben') then
  begin
    Log('Ergebnis nicht korrekt');
    Exit();
  end;
  result := true;
end;

function TForm1.Test7: Boolean;
begin
  result := false;

  Log('Teste "1 2 3 4"');
  if fUebungen.BerechneDieSumme('1 2 3 4') = 10 then
  begin
    Log('Ergebnis nicht korrekt');
    Exit();
  end;

  Log('Teste "12 3456 1 9999999"');
  if fUebungen.BerechneDieSumme('12 3456 1 9999999') <> 10003468 then
  begin
    Log('Ergebnis nicht korrekt');
    Exit();
  end;

  result := true;
end;

function TForm1.Test8: Boolean;
const
  vTestArr1: array[0..2] of Integer = (1, 2, 4);
  vTestArr2: array[0..6] of Integer = (1, 2, 3, 4, 5, 6, 7);
  vTestArr3: array[0..0] of Integer = (7);
  vTestArr4: array[0..3] of Integer = (7, 8, 10, 11);
begin
  result := false;
  Log('Teste 1 2 4');
  if fUebungen.WelcheZahlFehlt(vTestArr1) <> 3 then
  begin
    Log('Ergebnis nicht korrekt');
    Exit();
  end;

  Log('Teste 1 2 3 4 5 6 7');
  if fUebungen.WelcheZahlFehlt(vTestArr2) <> 0 then
  begin
    Log('Ergebnis nicht korrekt');
    Exit();
  end;

  Log('Teste 7');
  if fUebungen.WelcheZahlFehlt(vTestArr3) <> 0 then
  begin
    Log('Ergebnis nicht korrekt');
    Exit();
  end;

  Log('Teste 7 8 10 11');
  if fUebungen.WelcheZahlFehlt(vTestArr4) <> 9 then
  begin
    Log('Ergebnis nicht korrekt');
    Exit();
  end;

  result := true;
end;

function TForm1.Test9: Boolean;
begin
  result := false;

  Log('Teste morgens Horst');
  if not (fUebungen.BegruesseMich(morgens, 'Horst') = 'Guten Morgen, Horst!') then
  begin
    Log('Ergebnis nicht korrekt');
    Exit();
  end;

  Log('Teste mittags Schantall');
  if not (fUebungen.BegruesseMich(mittags, 'Schantall') = 'Mahlzeit, Schantall!') then
  begin
    Log('Ergebnis nicht korrekt');
    Exit();
  end;

  Log('Teste abends Terminator');
  if not (fUebungen.BegruesseMich(Abends, 'Terminator') = 'Guten Abend, Terminator!') then
  begin
    Log('Ergebnis nicht korrekt');
    Exit();
  end;

  Log('Teste nachts Marie');
  if not (fUebungen.BegruesseMich(nachts, 'Marie') = 'Gute Nacht, Marie!') then
  begin
    Log('Ergebnis nicht korrekt');
    Exit();
  end;

  result := true;
end;

function TForm1.Test10: Boolean;
begin
  result := false;

  Log('Teste 1 2');
  if not (round(fUebungen.Pythagokrass(1, 2) * 1000) = 2236) then
  begin
    Log('Ergebnis nicht korrekt');
    Exit();
  end;

  Log('Teste 3 7');
  if not (round(fUebungen.Pythagokrass(3, 7) * 1000) = 7615) then
  begin
    Log('Ergebnis nicht korrekt');
    Exit();
  end;

  result := true;
end;

function TForm1.Test11: Boolean;
begin
  result := false;

  Log('Teste Hallo');
  if not (fUebungen.SagsMirSpaeter('Hallo') = '') then
  begin
    Log('Ergebnis nicht korrekt');
    Exit();
  end;

  Log('Teste Was geht ab?');
  if not (fUebungen.SagsMirSpaeter('Was geht ab?') = 'Hallo') then
  begin
    Log('Ergebnis nicht korrekt');
    Exit();
  end;

  Log('Teste Auch egal');
  if not (fUebungen.SagsMirSpaeter('Auch egal') = 'Teste Was geht ab?') then
  begin
    Log('Ergebnis nicht korrekt');
    Exit();
  end;

  result := true;
end;

procedure TForm1.Log(AText: string);
begin
  lbLog.Items.Add(AText);
end;

end.

