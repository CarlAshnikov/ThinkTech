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
  ExtCtrls, Buttons, ActnList,
  uMowboter,
  uAI;

type

  { TForm1 }

  TForm1 = class(TForm)
    actPlay: TAction;
    alMain: TActionList;
    BitBtn1: TBitBtn;
    iLadeStation: TImage;
    iRasenLang: TImage;
    iRasenKurz: TImage;
    iRoboterLinks: TImage;
    iRoboterHoch: TImage;
    iRoboterRechts: TImage;
    iRoboterRunter: TImage;
    pRight: TPanel;
    pControl: TPanel;
    pbSpielFeld: TPaintBox;
    tSpielRunde: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pbSpielFeldPaint(Sender: TObject);
    procedure tSpielRundeTimer(Sender: TObject);
  private
    fRoboter: TRoboter;
    fAI: TRoboterAI;
    fFieldWidth, fFieldHeight: integer;
    fFields: array of array of TFeldTyp;
    function AllFieldsAreMowed: Boolean;
    procedure DoGameOver(const AReason: string);
    procedure DoGameWon;
    function GetFieldAtPosition(X, Y: integer): TFeldTyp;
    function GetPicForField(const AFieldType: TFeldTyp): TBitmap;
    function GetPicForRobot(const ARobot: TRoboter): TBitmap;
    procedure PruefeSpielregeln;
    procedure ResetField;
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

const
  cFieldSize = 50;

procedure TForm1.pbSpielFeldPaint(Sender: TObject);
var
  vRec: TRect;
  X, Y: integer;
begin
  for X := 0 to fFieldWidth - 1 do
    for Y := 0 to fFieldHeight - 1 do
    begin
      vRec.Left := X * cFieldSize;
      vRec.Top := Y * cFieldSize;
      vRec.Right := vRec.Left + cFieldSize;
      vRec.Bottom := vRec.Top + cFieldSize;
      pbSpielFeld.Canvas.StretchDraw(vRec, GetPicForField(fFields[x,y]));

      if (x = fRoboter.X) and (y = fRoboter.Y) then
        pbSpielFeld.Canvas.StretchDraw(vRec, GetPicForRobot(fRoboter));
    end;
end;

function TForm1.GetPicForField(const AFieldType: TFeldTyp): TBitmap;
begin
  case AFieldType of
    RasenLang:
      result := iRasenLang.Picture.Bitmap;
    RasenGemaeht:
      result := iRasenKurz.Picture.Bitmap;
    Ladestation:
      result := iLadeStation.Picture.Bitmap;
  else
    result := iRasenLang.Picture.Bitmap;
  end;
end;

function TForm1.GetPicForRobot(const ARobot: TRoboter): TBitmap;
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

procedure TForm1.FormCreate(Sender: TObject);
begin
  fAI := TRoboterAI.Create();
  fFieldWidth := 8;
  fFieldHeight := 6;
  fRoboter := TRoboter.Create(@GetFieldAtPosition, 1, 0);
  ResetField();
end;

procedure TForm1.ResetField();
begin
  Setlength(fFields, Width, Height);
  fFields[0,0] := Ladestation;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  fRoboter.Free;
  fAI.Free;
end;

procedure TForm1.tSpielRundeTimer(Sender: TObject);
begin
  fAI.OnNextStep(fRoboter);
  fRoboter.FahreEinenSchritt();
  PruefeSpielregeln();
  pbSpielFeld.Invalidate;
end;

function TForm1.AllFieldsAreMowed(): Boolean;
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

procedure TForm1.PruefeSpielregeln();
begin
  if AllFieldsAreMowed() then
  begin
    DoGameWon();
    exit();
  end;
  Case fFields[fRoboter.X, fRoboter.Y] of
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
  end;
end;

procedure TForm1.DoGameWon();
begin
  tSpielRunde.Enabled := false;
  ShowMessage('Runde Gewonnen!');
end;

procedure TForm1.DoGameOver(const AReason: string);
begin
  tSpielRunde.Enabled := false;
  ShowMessage('Game Over: ' + AReason);
  ResetField();
  pbSpielFeld.Invalidate;
end;

function TForm1.GetFieldAtPosition(X, Y: integer): TFeldTyp;
begin
  if (X < 0) or (X > fFieldWidth - 1) or (Y < 0) or (Y > fFieldHeight - 1) then
    result := TFeldTyp.Begrenzung
  else
    result := fFields[X, Y];
end;


end.

