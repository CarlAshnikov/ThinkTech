program MachineSimulator;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {frmMachineSimulator};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMachineSimulator, frmMachineSimulator);
  Application.Run;
end.
