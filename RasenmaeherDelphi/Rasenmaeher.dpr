// JCL_DEBUG_EXPERT_GENERATEJDBG OFF
// JCL_DEBUG_EXPERT_INSERTJDBG OFF
// JCL_DEBUG_EXPERT_DELETEMAPFILE OFF
program Rasenmaeher;


uses
  Forms,
  uSpielfeld in 'uSpielFeld.pas' {TfrmMain}, 
  uMowboter in 'uMowboter.pas', 
  uAI in 'uAI.pas';  

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.

