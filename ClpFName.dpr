program ClpFName;

uses
  Forms,
  MainFrm in 'MainFrm.pas' {MainForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'ファイル名一覧';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
