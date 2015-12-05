unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm4 = class(TForm)
    Image1: TImage;
    Memo1: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Update();

    { Public declarations }
  end;

var
  Form4: TForm4;

  imdbTitle:string;
  imdbPlot:string;
  imdbRate:string;
  imdbImage:string;
  imdbId:string;
   path:string;

implementation

uses Unit1;

{$R *.dfm}

procedure downloadFile(url,saveto:string);
var
 // Http: TIdHTTP;
  MS: TMemoryStream;
  data:TStringStream;
  path:string;
begin
   if (FileExists(path+saveto))then
   begin
     Form4.Image1.Picture.LoadFromFile(path+saveto);
     Exit;
   end;

 try
    MS := TMemoryStream.Create;
    try
     form1.IdHTTP2.Get(url, MS);
     MS.SaveToFile(path+saveto);

     if (FileExists(path+saveto))then
     begin
       Form4.Image1.Picture.LoadFromFile(path+saveto);
     end;

    finally
      MS.Destroy;
    end;
  finally
   form1.IdHTTP2.Disconnect();
   form1.JvBalloonHint1.ActivateHint(form1.ListBox1,'Download Complete.. ','Information',3000);
  end;
  end;

procedure TForm4.FormCreate(Sender: TObject);
begin
 imdbTitle:='';
 imdbPlot:='';
 imdbRate:='';
 imdbImage:='';
 imdbId:='';
 path:=  ExtractFilePath(Application.ExeName);


  if (DirectoryExists(path+'covers')=False) then
  begin
     CreateDir(path+'covers');
  end;


end;

procedure TForm4.Button1Click(Sender: TObject);
begin
   imdbTitle:='';
 imdbPlot:='';
 imdbRate:='';
 imdbImage:='';
  memo1.Lines.Clear;
close;
end;
procedure TForm4.Update();
begin
  Label1.Caption:='Name :'+imdbTitle;
  Label2.Caption:='Rating :'+imdbRate;
  memo1.Lines.Add(imdbPlot);
  downloadFile(imdbImage,path+'covers\'+imdbId+'.jpeg');
  Caption:='IMDB ('+ imdbTitle+')';
  show;
end;


end.
