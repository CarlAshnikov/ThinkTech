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

end;

end.

