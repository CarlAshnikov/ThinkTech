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
    ActionList1: TActionList;
    BitBtn1: TBitBtn;
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
    function GetFieldAtPosition(X, Y: integer): TFeldTyp;
    function GetPicForRobot(const ARobot: TRoboter): TBitmap;
    procedure PruefeSpielregeln;
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
      pbSpielFeld.Canvas.StretchDraw(vRec, iRasenLang.Picture.Bitmap);
      if (x = fRoboter.X) and (y = fRoboter.Y) then
        pbSpielFeld.Canvas.StretchDraw(vRec, GetPicForRobot(fRoboter));
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
  fRoboter := TRoboter.Create(@GetFieldAtPosition, 1, 1);
  fAI := TRoboterAI.Create();
  fFieldWidth := 8;
  fFieldHeight := 6;
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

procedure TForm1.PruefeSpielregeln();
begin

end;

function TForm1.GetFieldAtPosition(X, Y: integer): TFeldTyp;
begin
  if (X < 0) or (X > fFieldWidth - 1) or (Y < 0) or (Y > fFieldHeight - 1) then
    result := TFeldTyp.Begrenzung
  else
    result := TFeldTyp.RasenLang;
end;


end.

