unit uMowboter;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  TFeldTyp = (Rasen, Erde, Begrenzung);

  { TRoboter }

  TRoboter = class(TObject)
  private
    fMotor: Boolean;
    fX: integer;
    fY: integer;
  public
    function BenutzeSensor: TFeldTyp;
    procedure FahreEinenSchritt();
    property Motor: Boolean read fMotor write fMotor;
    property Y: integer read fY;
    property X: integer read fX;
  end;

implementation

{ TRoboter }

function TRoboter.BenutzeSensor: TFeldTyp;
begin

end;

procedure TRoboter.FahreEinenSchritt;
begin

end;

end.

