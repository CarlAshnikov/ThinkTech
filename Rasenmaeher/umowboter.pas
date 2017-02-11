unit uMowboter;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

const
  DirectionNames: array[0..3] of String = ('Hoch', 'Runter', 'Links', 'Rechts');

type

  TRichtung = (Hoch, Runter, Links, Rechts);
  TFeldTyp = (RasenLang, RasenGemaeht, Begrenzung, Ladestation, Blumen);
  TFieldGetter = function (X, Y: integer): TFeldTyp of object;

  { TRoboter }

  TRoboter = class(TObject)
  private
    fMotor: Boolean;
    fRichtung: TRichtung;
    fX: integer;
    fY: integer;
    fFieldGetter: TFieldGetter;
    fEnergie: integer;
    function GetSensorFeld: TPoint;
  public
    constructor Create(const AFieldGetter: TFieldGetter; const StartX, StartY: integer);
    function BenutzeSensor: TFeldTyp;
    procedure FahreEinenSchritt();
    property Richtung: TRichtung read fRichtung write fRichtung;
    property MotorAn: Boolean read fMotor write fMotor;
    property Y: integer read fY;
    property X: integer read fX;
    property SensorFeld: TPoint read GetSensorFeld;
    property Energie: integer read fEnergie;
  end;

implementation

{ TRoboter }

function TRoboter.GetSensorFeld: TPoint;
begin
  result.X := fX;
  result.Y := fY;
  case fRichtung of
    Hoch:
      result.y := result.y - 1;
    Runter:
      result.y := result.y + 1;
    Links:
      result.x := result.x - 1;
    Rechts:
      result.x := result.x + 1;
  end;

end;

constructor TRoboter.Create(const AFieldGetter: TFieldGetter; const StartX, StartY: integer);
begin
  fFieldGetter := AFieldGetter;
  fX := StartX;
  fY := StartY;
  fEnergie := 100;
end;

function TRoboter.BenutzeSensor: TFeldTyp;
begin
  result := fFieldGetter(GetSensorFeld.X, GetSensorFeld.Y);
end;

procedure TRoboter.FahreEinenSchritt;
begin
  case fRichtung of
    Hoch:
      dec(fY);
    Runter:
      inc(fY);
    Links:
      dec(fX);
    Rechts:
      inc(fX);
  end;
end;

end.

