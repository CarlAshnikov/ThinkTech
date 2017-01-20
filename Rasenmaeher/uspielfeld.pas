unit uSpielfeld;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    PaintBox1: TPaintBox;
    Timer1: TTimer;
    procedure PaintBox1Paint(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    fMowBoterPosX: integer;
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.PaintBox1Paint(Sender: TObject);
var
  vRec: TRect;
  X, Y: integer;
begin
  for X := 0 to 7 do
    for Y := 0 to 5 do
    begin
      vRec.Left := X * 50;
      vRec.Top := Y * 50;
      vRec.Right := vRec.Left + 50;
      vRec.Bottom := vRec.Top + 50;
      PaintBox1.Canvas.StretchDraw(vRec, Image1.Picture.Bitmap);
      if (x = fMowBoterPosX) and (y = 0) then
        PaintBox1.Canvas.StretchDraw(vRec, Image2.Picture.Bitmap);
    end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  inc(fMowBoterPosX);
  fMowBoterPosX := fMowBoterPosX mod 8;
  PaintBox1.Invalidate;
end;

end.

