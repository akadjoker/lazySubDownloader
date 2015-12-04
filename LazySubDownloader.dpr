program LazySubDownloader;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  uLog in 'uLog.pas' {Form2},
  USubtile in 'USubtile.pas',
  Unit3 in 'Unit3.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
