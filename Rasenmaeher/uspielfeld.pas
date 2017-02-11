unit uSpielfeld;

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
  ExtCtrls, Buttons, ActnList, StdCtrls,
  uMowboter,
  uAI;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    actPause: TAction;
    actStep: TAction;
    actPlay: TAction;
    alMain: TActionList;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    iLadeStation: TImage;
    iBlumen: TImage;
    iRasenLang: TImage;
    iRasenKurz: TImage;
    iRoboterLinks: TImage;
    iRoboterHoch: TImage;
    iRoboterRechts: TImage;
    iRoboterRunter: TImage;
    lbRobotInfo: TListBox;
    pRight: TPanel;
    pControl: TPanel;
    pbSpielFeld: TPaintBox;
    RadioGroup1: TRadioGroup;
    tSpielRunde: TTimer;
    procedure actPauseExecute(Sender: TObject);
    procedure actPauseUpdate(Sender: TObject);
    procedure actPlayExecute(Sender: TObject);
    procedure actPlayUpdate(Sender: TObject);
    procedure actStepExecute(Sender: TObject);
    procedure actStepUpdate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pbSpielFeldPaint(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure tSpielRundeTimer(Sender: TObject);
  private
    fRoboter: TRoboter;
    fAI: TRoboterAI;
    fFieldWidth, fFieldHeight: integer;
    fFields: array of array of TFeldTyp;
    fIsRandomField, fHasFlowers, fRandomDirection: Boolean;
    fDifficulty: integer;
    function AllFieldsAreMowed: Boolean;
    function GetRandomField: TPoint;
    function GetStationField: TPoint;
    procedure DoGameOver(const AReason: string);
    procedure DoGameWon;
    procedure SetDifficulty(const ADiff: integer);
    function GetFieldAtPosition(X, Y: integer): TFeldTyp;
    function GetPicForField(const AFieldType: TFeldTyp): TBitmap;
    function GetPicForRobot(const ARobot: TRoboter): TBitmap;
    procedure PruefeSpielregeln;
    procedure ResetField;
    procedure UpdateInfo();
  public

  end;

var
  frmMain: TfrmMain;

implementation

uses

  typinfo;

{$R *.lfm}

{ TfrmMain }

procedure TfrmMain.pbSpielFeldPaint(Sender: TObject);
var
  vRec: TRect;
  X, Y: integer;
  vFieldWidth, vFieldHeight: integer;
begin
  vFieldWidth := round(pbSpielFeld.Width / fFieldWidth);
  vFieldHeight := round(pbSpielFeld.Height / fFieldHeight);

  for X := 0 to fFieldWidth - 1 do
    for Y := 0 to fFieldHeight - 1 do
    begin
      vRec.Left := X * vFieldWidth;
      vRec.Top := Y * vFieldHeight;
      vRec.Right := vRec.Left + vFieldWidth;
      vRec.Bottom := vRec.Top + vFieldHeight;
      pbSpielFeld.Canvas.StretchDraw(vRec, GetPicForField(fFields[x,y]));

      if (x = fRoboter.X) and (y = fRoboter.Y) then
        pbSpielFeld.Canvas.StretchDraw(vRec, GetPicForRobot(fRoboter));
    end;
end;

procedure TfrmMain.RadioGroup1Click(Sender: TObject);
begin
  SetDifficulty(Radiogroup1.ItemIndex);
end;

function TfrmMain.GetPicForField(const AFieldType: TFeldTyp): TBitmap;
begin
  case AFieldType of
    RasenLang:
      result := iRasenLang.Picture.Bitmap;
    RasenGemaeht:
      result := iRasenKurz.Picture.Bitmap;
    Ladestation:
      result := iLadeStation.Picture.Bitmap;
    Blumen:
      result := iBlumen.Picture.Bitmap;
  else
    result := iRasenLang.Picture.Bitmap;
  end;
end;

function TfrmMain.GetPicForRobot(const ARobot: TRoboter): TBitmap;
begin
  case ARobot.Richtung of
    Hoch:
      result := iRoboterHoch.Picture.Bitmap;
    Runter:
      result := iRoboterRunter.Picture.Bitmap;
    Links:
      result := iRoboterLinks.Picture.Bitmap;
    Rechts:
      result := iRoboterRechts.Picture.Bitmap;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  fAI := TRoboterAI.Create();
  fFieldWidth := 8;
  fFieldHeight := 6;
  fDifficulty := -1;
  SetDifficulty(0);
  UpdateInfo();
end;

procedure TfrmMain.actPlayExecute(Sender: TObject);
begin
  tSpielRunde.Enabled := true;
end;

procedure TfrmMain.actPauseExecute(Sender: TObject);
begin
  tSpielRunde.Enabled := false;
end;

procedure TfrmMain.actPauseUpdate(Sender: TObject);
begin
  actPause.Enabled := tSpielRunde.Enabled;
end;

procedure TfrmMain.actPlayUpdate(Sender: TObject);
begin
  actPlay.Enabled := not tSpielRunde.Enabled;
end;

procedure TfrmMain.actStepExecute(Sender: TObject);
begin
  tSpielRundeTimer(nil);
end;

procedure TfrmMain.actStepUpdate(Sender: TObject);
begin
  actStep.Enabled := not tSpielRunde.Enabled;
end;

procedure TfrmMain.ResetField();
var
  X, Y: integer;
  stationPos, FlowerPos: TPoint;
begin
  if assigned(fRoboter) then
    fRoboter.Free;

  stationPos := GetStationField();
  fRoboter := TRoboter.Create(@GetFieldAtPosition, stationPos.X, stationPos.Y);
  if fRandomDirection then
    fRoboter.Richtung := TRichtung(Random(4))
  else
    fRoboter.Richtung := Runter;

  if fHasFlowers then
  begin
    flowerPos := GetRandomField();
    while (flowerPos.X = stationPos.X) and (flowerPos.Y = flowerPos.Y) do
      flowerPos := GetRandomField();
  end;

  Setlength(fFields, Width, Height);

  for X := 0 to fFieldWidth - 1 do
    for Y := 0 to fFieldHeight - 1 do
      fFields[x, y] := RasenLang;
  fFields[stationPos.X, stationPos.Y] := Ladestation;
  if fHasFlowers then
    fFields[flowerPos.X, flowerPos.Y] := Blumen;
  pbSpielFeld.Invalidate;
end;

procedure TfrmMain.UpdateInfo;
begin
  with lbRobotInfo.Items do
  begin
    Clear;
    Add('Roboterinfo:');
    Add('Richtung: ' + GetEnumName(TypeInfo(fRoboter.Richtung),Ord(fRoboter.Richtung)));
    if fRoboter.MotorAn then Add('Motor an') else Add('Motor aus');
    Add('Koordinate X: ' + IntToStr(fRoboter.X) + ' Y: ' + IntToStr(fRoboter.Y));
    Add('Energie: ' + IntToStr(fRoboter.Energie));
    Add('Sensor sieht: ' + GetEnumName(TypeInfo(fRoboter.BenutzeSensor),Ord(fRoboter.BenutzeSensor)))
  end;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  fRoboter.Free;
  fAI.Free;
end;

procedure TfrmMain.tSpielRundeTimer(Sender: TObject);
begin
  fAI.OnNextStep(fRoboter);
  fRoboter.FahreEinenSchritt();
  PruefeSpielregeln();
  pbSpielFeld.Invalidate;
  UpdateInfo();
end;

function TfrmMain.AllFieldsAreMowed(): Boolean;
var
 X, Y: integer;
begin
  result := true;
  for X := 0 to fFieldWidth - 1 do
    for Y := 0 to fFieldHeight - 1 do
    begin
      If fFields[x, y] = RasenLang then
        Exit(false);
    end;
end;

function TfrmMain.GetStationField: TPoint;
begin
  if fIsRandomField then
  begin
    result := GetRandomField();
  end
  else
  begin
   result.x := 0;
   result.Y := 0;
  end;

end;

function TfrmMain.GetRandomField(): TPoint;
begin
  result.X := Random(fFieldWidth);
  result.Y := Random(fFieldHeight);
end;

procedure TfrmMain.PruefeSpielregeln();
begin
  if AllFieldsAreMowed() then
  begin
    DoGameWon();
    exit();
  end;

  Case GetFieldAtPosition(fRoboter.X, fRoboter.Y) of
    RasenLang:
      begin
        if fRoboter.MotorAn then
          fFields[fRoboter.X, fRoboter.Y] := RasenGemaeht;
      end;
    RasenGemaeht:
      begin
        if fRoboter.MotorAn then
          DoGameOver('Kurzer Rasen gemaeht');
      end;
    Begrenzung:
      DoGameOver('Außerhalb des Spielfeldes');
    Blumen:
      DoGameOver('Auf dem Blumenbeet!');
  end;
end;

procedure TfrmMain.DoGameWon();
begin
  tSpielRunde.Enabled := false;
  ShowMessage('Runde Gewonnen!');
end;

procedure TfrmMain.SetDifficulty(const ADiff: integer);
begin
  if fDifficulty = ADiff then
    Exit();
  fDifficulty := ADiff;
  case fDifficulty of
    0:
      begin
        fIsRandomField := false;
        fHasFlowers := false;
        fRandomDirection := false;
      end;
    1:
      begin
        fIsRandomField := true;
        fHasFlowers := false;
        fRandomDirection := true;
      end;
    2:
      begin
        fIsRandomField := true;
        fHasFlowers := true;
        fRandomDirection := true;
      end;
  end;
  ResetField();
end;

procedure TfrmMain.DoGameOver(const AReason: string);
begin
  tSpielRunde.Enabled := false;
  ShowMessage('Game Over: ' + AReason);
  ResetField();
  pbSpielFeld.Invalidate;
end;

function TfrmMain.GetFieldAtPosition(X, Y: integer): TFeldTyp;
begin
  if (X < 0) or (X > fFieldWidth - 1) or (Y < 0) or (Y > fFieldHeight - 1) then
    result := TFeldTyp.Begrenzung
  else
    result := fFields[X, Y];
end;

end.

