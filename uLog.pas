unit uLog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,IniFiles;

type
  TForm2 = class(TForm)
    btn1: TButton;
    GroupBox1: TGroupBox;
    edt1: TEdit;
    edt2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    GroupBox2: TGroupBox;
    Edit3: TEdit;
    procedure btn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

  vUserName:string;
  vUserPass:string;
  vUserLanguage:string;
  vSearchLanguages:string;

implementation

{$R *.dfm}

procedure TForm2.btn1Click(Sender: TObject);
begin
close;
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
var
   IniFile : TIniFile;
 begin
   IniFile := TIniFile.Create(ChangeFileExt(Application.ExeName,'.ini')) ;
   IniFile.WriteString('setup', 'user', edt1.Text);
   IniFile.WriteString('setup', 'pass', edt2.Text);
   IniFile.WriteString('setup', 'SearchLanguage', Edit3.Text);
   IniFile.WriteString('setup', 'language', 'pt');
   IniFile.WriteString('setup', 'version', '0.0.2');


   IniFile.destroy;

   vUserName:=edt1.Text ;
   vUserPass:=edt2.Text;
   vSearchLanguages:=Edit3.Text;
end;

procedure TForm2.FormCreate(Sender: TObject);
var
   IniFile : TIniFile;
 begin
   IniFile := TIniFile.Create(ChangeFileExt(Application.ExeName,'.ini')) ;
   form2.edt1.Text:=   IniFile.ReadString('setup', 'user', '');
   form2.edt2.Text:=   IniFile.ReadString('setup', 'pass', '');
   vSearchLanguages:=  IniFile.ReadString('setup', 'SearchLanguage', 'por,pob');
   vUserLanguage:=IniFile.ReadString('setup', 'language', 'pt');
   IniFile.ReadString('setup', 'version', '0.0.2');
   vUserName:=edt1.Text ;
   vUserPass:=edt2.Text;
   Edit3.Text:=vSearchLanguages;
   IniFile.destroy;

end;

end.


{
QueryNumber

SubFileName
SubFormat
SubAddDate
SubRating
SubDownloadsCnt

 IDMovieImdb
 MovieImdbRating
 MovieReleaseName

 UserNickName

 LanguageName

 SubDownloadLink
 ZipDownloadLink
 SubtitlesLink

 SubComments

 MovieFPS
 MovieYear
}