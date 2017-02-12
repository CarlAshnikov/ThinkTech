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

  IRobot = interface
    ['{DA230DCA-43E8-4D5C-B151-FB366A858C73}']
    function BenutzeSensor: TFeldTyp;
    function GetMotor: Boolean;
    function GetRichtung: TRichtung;
    procedure SetMotor(AValue: Boolean);
    procedure SetRichtung(AValue: TRichtung);
    property Richtung: TRichtung read GetRichtung write SetRichtung;
    property MotorAn: Boolean read GetMotor write SetMotor;
  end;

  IRobotExtended = interface(IRobot)
    ['{E20347A0-F605-4AD9-A0EB-704A0F055E81}']
    function GetX: integer;
    function GetY: integer;
    function GetEnergie: integer;
    function GetSensorFeld: TPoint;
    procedure FahreEinenSchritt();
    property Y: integer read GetY;
    property X: integer read GetX;
    property SensorFeld: TPoint read GetSensorFeld;
    property Energie: integer read GetEnergie;
  end;


  { TRoboter }
  TRoboter = class(TInterfacedObject, IRobot, IRobotExtended)
  private
    fMotor: Boolean;
    fRichtung: TRichtung;
    fX: integer;
    fY: integer;
    fFieldGetter: TFieldGetter;
    fEnergie: integer;
    function GetEnergie: integer;
    function GetMotor: Boolean;
    function GetRichtung: TRichtung;
    function GetSensorFeld: TPoint;
    function GetX: integer;
    function GetY: integer;
    procedure SetMotor(AValue: Boolean);
    procedure SetRichtung(AValue: TRichtung);
  public
    constructor Create(const AFieldGetter: TFieldGetter; const StartX, StartY: integer);
    function BenutzeSensor: TFeldTyp;
    procedure FahreEinenSchritt();
    property Richtung: TRichtung read GetRichtung write SetRichtung;
    property MotorAn: Boolean read GetMotor write SetMotor;
    property Y: integer read GetY;
    property X: integer read GetX;
    property SensorFeld: TPoint read GetSensorFeld;
    property Energie: integer read GetEnergie;
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

function TRoboter.GetX: integer;
begin
  result := fX;
end;

function TRoboter.GetY: integer;
begin
  result := fY;
end;

function TRoboter.GetMotor: Boolean;
begin
  result := fMotor;
end;

function TRoboter.GetRichtung: TRichtung;
begin
  result := fRichtung;
end;

function TRoboter.GetEnergie: integer;
begin
  result := fEnergie;
end;

procedure TRoboter.SetMotor(AValue: Boolean);
begin
  fMotor := AValue;
end;

procedure TRoboter.SetRichtung(AValue: TRichtung);
begin
  fRichtung := AValue;
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

