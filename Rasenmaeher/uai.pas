unit uAI;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  SysUtils,
  uMowboter;

type

  { TRoboterAI }

  TRoboterAI = class(TObject)
    procedure OnNextStep(ARobot: TRoboter);
  end;

implementation

{ TRoboterAI }

procedure TRoboterAI.OnNextStep(ARobot: TRoboter);
begin
  Arobot.MotorAn := true;
  if ARobot.BenutzeSensor in [Begrenzung, RasenGemaeht, LadeStation]then
    Case ARobot.Richtung of
      Hoch:
        ARobot.Richtung := Links;
      Runter:
        ARobot.Richtung := Rechts;
      Links:
        ARobot.Richtung := Runter;
      Rechts:
        ARobot.Richtung := Hoch;
    end;
end;

end.

