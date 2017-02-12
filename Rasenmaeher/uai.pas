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
    procedure OnNextStep(ARobot: IRobot);
  end;

implementation

{ TRoboterAI }

procedure TRoboterAI.OnNextStep(ARobot: IRobot);
begin

end;

end.

