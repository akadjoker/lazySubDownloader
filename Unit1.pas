unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, XmlRpcTypes,IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  ComCtrls,IniFiles, Menus, ExtCtrls,WinInet,gzIO,USubtile, ImgList,
  JvComponentBase, JvBalloonHint, jpeg, Grids, ValEdit;

   const
  BUFLEN       = 16384 ;

type
  TForm1 = class(TForm)
    IdHTTP1: TIdHTTP;
    stat1: TStatusBar;
    mmo1: TMemo;
    mm1: TMainMenu;
    Log1: TMenuItem;
    Loggin1: TMenuItem;
    pnl1: TPanel;
    pnl2: TPanel;
    N1: TMenuItem;
    Log2: TMenuItem;
    LogOut1: TMenuItem;
    ListBox1: TListBox;
    Panel1: TPanel;
    Edit1: TEdit;
    Button1: TButton;
    PopupMenu1: TPopupMenu;
    Limpa1: TMenuItem;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Memo1: TMemo;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Edit2: TEdit;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    pb1: TProgressBar;
    Button3: TButton;
    Button4: TButton;
    IdHTTP2: TIdHTTP;
    N2: TMenuItem;
    ClearAll1: TMenuItem;
    JvBalloonHint1: TJvBalloonHint;
    ImageList2: TImageList;
    About1: TMenuItem;
    Edit3: TEdit;
    Image1: TImage;
    Button2: TButton;
    Panel2: TPanel;
    lst1: TListBox;
    ValueListEditor1: TValueListEditor;
    Button5: TButton;
    Edit4: TEdit;
    Label23: TLabel;
    Edit5: TEdit;
    Edit6: TEdit;
    Label24: TLabel;
    Label25: TLabel;
    N3: TMenuItem;
    SearchAll1: TMenuItem;
    Bevel1: TBevel;
    Button6: TButton;
    procedure IdHTTP1Status(ASender: TObject; const AStatus: TIdStatus;const AStatusText: String);
    procedure IdHTTP1Disconnected(Sender: TObject);
    procedure IdHTTP1Connected(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Loggin1Click(Sender: TObject);
    procedure Log2Click(Sender: TObject);
    procedure LogOut1Click(Sender: TObject);
    procedure idhtpDownloadWorkBegin(Sender: TObject; AWorkMode: TWorkMode; const AWorkCountMax: Integer);
    procedure idhtpDownloadWorkEnd(Sender: TObject; AWorkMode: TWorkMode);
    procedure btn2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure lst1DblClick(Sender: TObject);
    procedure Limpa1Click(Sender: TObject);
    procedure ListBox2Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit2DblClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure HttpWork(Sender: TObject; AWorkMode: TWorkMode;      const AWorkCount: Integer);
    procedure IdHTTP1WorkEnd(Sender: TObject; AWorkMode: TWorkMode);
    procedure IdHTTP1Work(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCount: Integer);
    procedure IdHTTP1WorkBegin(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCountMax: Integer);
    procedure IdHTTP2Status(ASender: TObject; const AStatus: TIdStatus;
      const AStatusText: String);
    procedure IdHTTP2Work(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCount: Integer);
    procedure IdHTTP2WorkBegin(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCountMax: Integer);
    procedure IdHTTP2WorkEnd(Sender: TObject; AWorkMode: TWorkMode);
    procedure ListBox2DblClick(Sender: TObject);
    procedure ClearAll1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure ValueListEditor1Click(Sender: TObject);
    procedure ValueListEditor1DblClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Edit5KeyPress(Sender: TObject; var Key: Char);
    procedure Edit6KeyPress(Sender: TObject; var Key: Char);
    procedure SearchAll1Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
     function IsSupportedFileType(const FileName: string): Boolean;
    procedure AddFile(const FileName: string);
    procedure DisplayFile(Idx: Integer);
    procedure WMDropFiles(var Msg: TWMDropFiles); message WM_DROPFILES;


  public

  end;

  procedure processStruct(struct:IRpcStruct);
  procedure processArray(a:IRpcArray);
  procedure processIMDBArray(a:IRpcArray);
  procedure processIMDBStruct(struct:IRpcStruct);
  procedure processIMDBArraySubtile(a:IRpcArray);
procedure processIMDBStructSubtile(struct:IRpcStruct);


  procedure trace(msg:string)  ;
var
  Form1: TForm1;

  userId:string='';
  xmlConnect:string;
  isConnect:Boolean=false;

        nomeAprocurar:string;

        endOfWorld:Boolean;

      subCount:Integer=0;
      listaLegendas:TSubtileList;
    

implementation

uses  ShellApi,uLog, Unit3, Unit4;

const
  cSupportedExts = '*.avi;*.mp4;*.mkv;*.dvx;*.h264;*.mpeg;*.*;';

{$R *.dfm}

procedure TForm1.AddFile(const FileName: string);
function elementExists(name:string):Boolean;
var
  i:Integer;
begin
 Result:=False;
for i:=0 to form1.lst1.Items.Count-1 do
begin

 if (UpperCase(form1.lst1.Items[i]) = UpperCase(name)) then
 begin
   Result:=True;
   Break;
 end;

end;
end;

begin
  if IsSupportedFileType(FileName) then
  begin

   if (not elementExists(ExtractFileName(ChangeFileExt(FileName,'')))) then
    begin

     form1.ListBox1.Items.Add(filename);
     form1.lst1.Items.Add(ExtractFileName(ChangeFileExt(FileName,'')));
     end;

   
 end
 // else
  //  ShowMessageFmt('File %s is not a supported type', [FileName]);
end;

procedure TForm1.DisplayFile(Idx: Integer);
var
  FileName: string;
begin
  {
  if Idx >= 0 then
  begin
    FileName := ListBox1.Items[Idx];
    ListBox1.ItemIndex := Idx;
    Memo1.Lines.LoadFromFile(FileName);
    StatusBar1.SimpleText := FileName;
  end
  else
  begin
    Memo1.Clear;
    StatusBar1.SimpleText := 'N0 FILE SELECTED';
  end;
  }
end;


procedure AddAllFilesInDir(const Dir: string);
var
  SR: TSearchRec;
begin

  if FindFirst(IncludeTrailingBackslash(Dir) + '*.*', faAnyFile or faDirectory, SR) = 0 then
    try
      repeat
        if (SR.Attr and faDirectory) = 0 then
        begin
          form1.AddFile(IncludeTrailingBackslash(Dir)+SR.Name);
        end
        else if (SR.Name <> '.') and (SR.Name <> '..') then
          AddAllFilesInDir(IncludeTrailingBackslash(Dir) + SR.Name);  // recursive call!
          Application.ProcessMessages;
      until FindNext(Sr) <> 0;
    finally
      FindClose(SR);
    end;
end;

function TForm1.IsSupportedFileType(const FileName: string): Boolean;
begin
  Result := AnsiPos('*' + ExtractFileExt(FileName) + ';', cSupportedExts) > 0;
end;

   procedure TForm1.WMDROPFILES(var msg: TWMDropFiles) ;
 const
   MAXFILENAME = 255;
 var
   cnt, fileCount : integer;
   fileName : array [0..MAXFILENAME] of char;
   pt:TPoint;
   SR      : TSearchRec;
   fn:string;
 begin
   DragQueryPoint(msg.Drop, pt);
   fileCount := DragQueryFile(msg.Drop, $FFFFFFFF, fileName, MAXFILENAME) ;
//   trace('Num files drag'+inttostr(fileCount));



   for cnt := 0 to -1 + fileCount do
   begin
     DragQueryFile(msg.Drop, cnt, fileName, MAXFILENAME) ;

   if(fileCount=1) then
   begin
      if(DirectoryExists(fileName)) then
      begin
         AddAllFilesInDir(fileName);
      end else
      begin
       AddFile(filename);
      end;


   end else
   begin
         AddFile(filename);
   end;

              Application.ProcessMessages;

     //do something with the file(s)
//     trace( fileName) ;
   end;
 
   //release memory
   DragFinish(msg.Drop) ;
 end;

  {[
procedure TForm1.WMDropFiles(var Msg: TWMDropFiles);
  // Handle WM_DROPFILES message
var
  I: Integer;                 // loops thru all dropped files
  DropPoint: TPoint;          // point where files dropped
  Catcher: TFileCatcher;      // file catcher class
   SR      : TSearchRec;
begin
  inherited;
  // Create file catcher object to hide all messy details
  Catcher := TFileCatcher.Create(Msg.Drop);
  try
    // Try to add each dropped file to display
    for I := 0 to Pred(Catcher.FileCount) do
    begin
      if(DirectoryExists(Catcher.Files[I])) then
      begin
        if FindFirst(Catcher.Files[I] + '*.*', faArchive, SR) = 0 then
          begin
            repeat
              AddFile(SR.Name);
               // DirList.Add(SR.Name); //Fill the list
            until FindNext(SR) <> 0;
            FindClose(SR);
          end;
      end else

      AddFile(Catcher.Files[I]);
    end;
    // Get drop point and display message about it
    DropPoint := Catcher.DropPoint;
   // ShowMessageFmt('%d file(s) dropped at (%d,%d)',
   //   [Catcher.FileCount, DropPoint.X, DropPoint.Y]);
  finally
    Catcher.Free;
  end;
  // Notify Windows we handled message
  Msg.Result := 0;
end;
   }

procedure TForm1.HttpWork(Sender: TObject; AWorkMode: TWorkMode;      const AWorkCount: Integer);
var
  Http: TIdHTTP;
  ContentLength: Int64;
  Percent: Integer;
begin
  Http := TIdHTTP(Sender);
  ContentLength := Http.Response.ContentLength;

 // form1.pb1.Max:=ContentLength;


if (Pos('chunked', LowerCase(Http.Response.ResponseText)) = 0) and(ContentLength > 0) then
begin
    Percent := 100*AWorkCount div ContentLength;
    form1.pb1.Position:=Percent;
//    trace(IntToStr(ContentLength )+','+inttostr(percent)+','+inttostr(AWorkCount));


   // MemoOutput.Lines.Add(IntToStr(Percent));
end;

end;



procedure gz_uncompress (infile:gzFile;  outfile:string);
var
  len     : integer;
  written : uInt;
  ioerr   : integer;
  err     : integer;
   buf  : packed array [0..BUFLEN-1] of byte;
   fileExtract:TMemoryStream;
begin
fileExtract:=TMemoryStream.Create;



  while true do
 begin
    len := gzread (infile, @buf, BUFLEN);
    if (len < 0)       then trace (gzerror (infile, err));
    if (len = 0)       then break;
    fileExtract.WriteBuffer(buf,len);
end;

   fileExtract.SaveToFile(outfile);
   fileExtract.Destroy;

end;


procedure extractfile(url,saveto:string);
var
 infile  : gzFile;
begin

infile:=gzopen(url,'r');
if (infile = NIL) then
  begin
   exit;
  end;

gz_uncompress(infile,saveto);

  if (gzclose (infile) <> 0{Z_OK})
    then trace ('gzclose error');



end;
procedure extractStream(st:TStream;saveto:string);
var
 infile  : gzFile;
begin

infile:=gzopen(st,'r',false);
if (infile = NIL) then
  begin
   trace ('gzopen error');
   exit;
  end;

gz_uncompress(infile,saveto);

  if (gzclose (infile) <> 0)
    then trace ('gzclose error');



end;

procedure downloadFile(url,saveto:string);
var
 // Http: TIdHTTP;
  MS: TMemoryStream;
  data:TStringStream;
  path:string;
begin


 try
    MS := TMemoryStream.Create;
    try

     form1.IdHTTP2.Get(url, MS);
    // path:=  ExtractFilePath(Application.ExeName);


    //  MS.SaveToFile(path+saveto);

       form1.JvBalloonHint1.ActivateHint(form1.ListBox1,'Extract Subtile.. ','Information',3000);

      trace('Extract subtile');
      ms.Position:=0;
      extractStream(ms,saveto);


    finally
      MS.Destroy;
    end;
  finally
   form1.IdHTTP2.Disconnect();
   form1.JvBalloonHint1.ActivateHint(form1.ListBox1,'Download Complete.. ','Information',3000);



  end;
  {

        trace('Download subtile');
  Http := TIdHTTP.Create(nil);
  try
    MS := TMemoryStream.Create;
    try
      Http.OnWorkBegin:=form1.idhtpDownloadWorkBegin;
      Http.OnWork:= Form1.IdHTTP1Work;
      Http.OnWorkEnd:=Form1.IdHTTP1WorkEnd;

     Http.Get(url, MS);
     path:=  ExtractFilePath(Application.ExeName);


    //  MS.SaveToFile(path+saveto);

      trace('Extract subtile');
      ms.Position:=0;
      extractStream(ms,saveto);


    finally
      MS.Free;
    end;
  finally
      Http.OnWorkBegin:=nil;
      Http.OnWork:= nil;
      Http.OnWorkEnd:=nil;
    Http.Free;
  end;
   }
end;

procedure element(name,data:string);
begin
  trace(name+' : '+data+'.');
end;

procedure processStruct(struct:IRpcStruct);
var
  id,i:Integer;
  sItem:TRpcStructItem;
  value:TRpcStructItem;

    subtile:TSubtile;
begin
 // trace('porcess STRUCT('+inttostr( struct.Count)+' )elements');




             ///**********************************************
     if (struct.KeyExists('MatchedBy')) then
    begin
        value:=struct.Keys['MatchedBy'];
         Inc(subCount);
        subtile:=TSubtile.Create;
        subtile.nomeDaProcura:=nomeAprocurar;
    //    trace('START read server information');

     //estamos na legenda
    end;










       if (struct.KeyExists('QueryParameters')) then
       begin
       value:=struct.Keys['QueryParameters'];

       if (struct.KeyExists('SubLanguageID')) then
       begin
        value:=struct.Keys['SubLanguageID'];
          if(Assigned(subtile)) then
          begin
            subtile.SubLanguageID:=value.AsString;
          end;
       end;

        if (struct.KeyExists('SubRating')) then
    begin
       value:=struct.Keys['SubRating'];
        if(Assigned(subtile)) then
        begin
          subtile.SubRating:=value.AsString;
        end;
    end;

         if (struct.KeyExists('SubFileName')) then
    begin
       value:=struct.Keys['SubFileName'];
    //   element('SubFileName',value.AsString);
         if(Assigned(subtile)) then
         begin
             subtile.SubFileName:=value.AsString;
           //  form1.ListBox2.Items.Add( value.AsString+ '      Subtile Rating('+subtile.SubRating+')');
             form1.ValueListEditor1.InsertRow(value.AsString,subtile.SubRating,True);
          end;
    end;

    if (struct.KeyExists('SubDownloadsCnt')) then
    begin
       value:=struct.Keys['SubDownloadsCnt'];
        if(Assigned(subtile)) then
        begin
          subtile.SubDownloadsCnt:=StrToInt(value.AsString);

        end;
    end;

      if (struct.KeyExists('SubFormat')) then
    begin
       value:=struct.Keys['SubFormat'];
        if(Assigned(subtile)) then
        begin
         subtile.SubFormat:=value.AsString;
        end;

    end;
      if (struct.KeyExists('SubAuthorComment')) then
    begin
       value:=struct.Keys['SubAuthorComment'];
        if(Assigned(subtile)) then
        begin
          subtile.SubAuthorComment:=value.AsString;
        end;
    end;
      if (struct.KeyExists('SubAddDate')) then
    begin
       value:=struct.Keys['SubAddDate'];
        if(Assigned(subtile)) then
        begin
          subtile.SubAddDate:=value.AsString;
        end;

//       element('SubAddDate',value.AsString);
     //
    end;
      if (struct.KeyExists('MovieReleaseName')) then
    begin
       value:=struct.Keys['MovieReleaseName'];
        if(Assigned(subtile)) then
        begin
         subtile.MovieReleaseName:=value.AsString;
        end;

    end;
      if (struct.KeyExists('IDMovieImdb')) then
    begin
       value:=struct.Keys['IDMovieImdb'];
        if(Assigned(subtile)) then
        begin
          subtile.IDMovieImdb:=value.AsString;
        end;

    end;
       if (struct.KeyExists('MovieName')) then
    begin
       value:=struct.Keys['MovieName'];
        if(Assigned(subtile)) then
        begin
          subtile.MovieName:=value.AsString;
        end;


    end;
       if (struct.KeyExists('MovieYear')) then
    begin
       value:=struct.Keys['MovieYear'];
        if(Assigned(subtile)) then
        begin
          subtile.MovieYear:=value.AsString;
        end;

    end;
     if (struct.KeyExists('UserNickName')) then
    begin
       value:=struct.Keys['UserNickName'];
        if(Assigned(subtile)) then
        begin
          subtile.UserNickName:=value.AsString;
        end;

    end;



    if (struct.KeyExists('LanguageName')) then
    begin
       value:=struct.Keys['LanguageName'];
        if(Assigned(subtile)) then
        begin
          subtile.LanguageName:=value.AsString;
        end;

    end;

     if (struct.KeyExists('MovieImdbRating')) then
    begin
       value:=struct.Keys['MovieImdbRating'];
        if(Assigned(subtile)) then
        begin
          subtile.MovieImdbRating:=value.AsString;
        end;

    end;

       end;



    if (struct.KeyExists('SubDownloadLink')) then
    begin
       value:=struct.Keys['SubDownloadLink'];
        if(Assigned(subtile)) then
        begin
          subtile.SubDownloadLink:=value.AsString;
        end;


    end;
     if (struct.KeyExists('QueryNumber')) then
    begin
       value:=struct.Keys['QueryNumber'];
        if(Assigned(subtile)) then
        begin
          subtile.query:=value.AsInteger;
        end;

        listaLegendas.Add(subtile);
    //    trace('STOP read server information');


    end;



  for i:=0 to struct.Count-1 do
  begin
    sItem:=struct.Items[i];
     if (sItem.IsStruct) then
     begin
        processStruct(sItem.AsStruct);
     end else
     if (sItem.IsArray) then
     begin
       processArray(sItem.AsArray);
     end else
     ///********************************//
       if (sItem.IsString) then
      begin


       //  trace('item :'+inttostr(i)+'  '+sItem.Name+' is string');
       //  trace( sItem.AsString);
      end else
       if (sItem.IsDate) then
      begin
      //   trace('item :'+inttostr(i)+' is IsDate');
      end else
        if (sItem.IsBase64) then
      begin
       //  trace('item :'+inttostr(i)+' is IsBase64');
      end else
        if (sItem.IsInteger) then
      begin
        // trace('item :'+inttostr(i)+' is IsInteger');

      end else
        if (sItem.IsFloat) then
      begin
//        trace('item :'+inttostr(i)+        sItem.Name+' is IsFloat');

      end else
      begin
      //  trace( sItem.Name+' -----OUTRO');
      end;

               Application.ProcessMessages;
  end;

end;
procedure processArray(a:IRpcArray);
var
  i:Integer;
    aItem:TRpcArrayItem;
begin
  //trace('porcess ARRAY('+inttostr( a.Count)+') elements');
for i:=0 to a.Count-1 do
begin
    aItem:=a.Items[i];



    if (aitem.IsArray) then
    begin
      processArray(aItem.AsArray);
    end else
    if (aitem.IsStruct) then
    begin
      processStruct(aItem.AsStruct);
    end else
    ///*************************************
     if (aitem.IsString) then
      begin


        // trace('item :'+inttostr(i)+' is string');
      //   trace( aitem.AsString);
      end else
       if (aitem.IsDate) then
      begin
        // trace('item :'+inttostr(i)+' is IsDate');
      end else
        if (aitem.IsBase64) then
      begin
       //  trace('item :'+inttostr(i)+' is IsBase64');
      end else
        if (aitem.IsInteger) then
      begin
       //  trace('item :'+inttostr(i)+' is IsInteger');

      end else
        if (aitem.IsFloat) then
      begin
//        trace('item :'+inttostr(i)+' is IsFloat');
       //   form1.stat1.Panels[1].Text:= FloatToStr( aItem.asFloat) +'.ms';
      end else
      begin
      //  trace( ' -----OUTRO');
      end;
           Application.ProcessMessages;
end;

end;


function XML_RPC(aRPCRequest: string): string;
const
  cURL= 'http://api.opensubtitles.org/xml-rpc';
var

  Source,
  ResponseContent: TStringStream;
begin

  Form1.IdHTTP1.Request.ContentType := 'text/xml';
  Form1.IdHTTP1.Request.Accept := '*/*';
  Form1.IdHTTP1.Request.Connection := 'Keep-Alive';
  Form1.IdHTTP1.Request.Method :=hmPost;
  Form1.IdHTTP1.Request.UserAgent := 'OS Test User Agent';
  Source := TStringStream.Create(aRPCRequest);
  ResponseContent:= TStringStream.Create('');
  try
    try
      Form1.IdHTTP1.Post(cURL, Source, ResponseContent);
      Result:= ResponseContent.DataString;
     // Form1.IdHTTP1.Disconnect();
    except
      Result:= '';
    end;
  finally
    Source.Free;
  //  lHTTP.Free;
    ResponseContent.Free;
  end;
end;


function XML_RPC_Send(aRPCRequest: string): string;
const
  cURL= 'http://api.opensubtitles.org/xml-rpc';
var

  Source,
  ResponseContent: TStringStream;
begin
  Source := TStringStream.Create(aRPCRequest);
  ResponseContent:= TStringStream.Create('');
  try
    try
      Form1.IdHTTP1.Post(cURL, Source, ResponseContent);
      Result:= ResponseContent.DataString;
    except
      Result:= '';
    end;
  finally
    Source.Free;
  //  lHTTP.Free;
    ResponseContent.Free;
  end;
end;


function LogIn(aUsername, aPassword, aLanguage: string): string;
var
  LOG_IN:string;
begin
LOG_IN := '<?xml version="1.0"?>' +
           '<methodCall>' +
           '  <methodName>LogIn</methodName>' +
           '  <params>'   +
           '    <param>'  +
           '      <value><string>'+aUsername+'</string></value>' +
           '    </param>' +
           '    <param>'  +
           '      <value><string>'+aPassword+'</string></value>' +
           '    </param>' +
           '    <param>'  +
           '      <value><string>'+aLanguage+'</string></value>' +
           '    </param>' +
           '    <param>'  +
           '      <value><string>FileBot v4.5.6</string></value>' +
           '    </param>' +
           '  </params>'  +
           '</methodCall>';

  Result:= XML_RPC(LOG_IN);
end;


function LogOut(aToken: string): string;
const
  LOG_OUT = '<?xml version="1.0"?>' +
           '<methodCall>' +
           '  <methodName>LogOut</methodName>' +
           '  <params>'   +
           '    <param>'  +
           '      <value><string>%0:s</string></value>' +
           '    </param>' +
           '  </params>'  +
           '</methodCall>';
begin
  //TODO: XML Encoding
  Result:= XML_RPC_Send(Format(LOG_OUT, [aToken]));
   Form1.IdHTTP1.Disconnect();
end;

function SearchMovieImdb(aToken,  aImdbID: String): string;
var
  data:string;

begin
data:='<methodCall>'+
      '<methodName>GetIMDBMovieDetails</methodName>'+
      '<params>'+
      '<param>'+
      '<value><string>'+atoken+'</string></value>'+
      '</param>'+
      '<param>'+
      '<value><string>'+aImdbID+'</string></value>'+
      '</param>'+
      '</params>'+
      '</methodCall>';


  Result:= XML_RPC_Send(data);
end;

function SearchSubtitlesImdb(aToken, aSublanguageID: string; aImdbID: Cardinal): string;
const
  SEARCH_SUBTITLES = '<?xml version="1.0"?>' +
                     '<methodCall>' +
                     '  <methodName>SearchSubtitles</methodName>' +
                     '  <params>' +
                     '    <param>' +
                     '      <value><string>%0:s</string></value>' +
                     '    </param>' +
                     '  <param>' +
                     '   <value>' +
                     '    <array>' +
                     '     <data>' +
                     '      <value>' +
                     '       <struct>' +
                     '        <member>' +
                     '         <name>sublanguageid</name>' +
                     '         <value><string>%1:s</string>' +
                     '         </value>' +
                     '        </member>' +
                     '        <member>' +
                     '         <name>imdbid</name>' +
                     '         <value><string>%2:d</string></value>' +
                     '        </member>' +
                     '       </struct>' +
                     '      </value>' +
                     '     </data>' +
                     '    </array>' +
                     '   </value>' +
                     '  </param>' +
                     ' </params>' +
                     '</methodCall>';

begin
   nomeAprocurar:=IntToStr(aImdbID);
  Result:= XML_RPC_Send(Format(SEARCH_SUBTITLES, [aToken, aSublanguageID, aImdbID]));
end;

function SearchSubtitles(aToken, aSublanguageID, aQuery: string): string;
const
  SEARCH_SUBTITLES = '<?xml version="1.0"?>' +
                     '<methodCall>' +
                     '  <methodName>SearchSubtitles</methodName>' +
                     '  <params>' +
                     '    <param>' +
                     '      <value><string>%0:s</string></value>' +
                     '    </param>' +
                     '  <param>' +
                     '   <value>' +
                     '    <array>' +
                     '     <data>' +
                     '      <value>' +
                     '       <struct>' +
                     '        <member>' +
                     '         <name>sublanguageid</name>' +
                     '         <value><string>%1:s</string>' +
                     '         </value>' +
                     '        </member>' +
                     '        <member>' +
                     '         <name>query</name>' +
                     '         <value><string>%2:s</string></value>' +
                     '        </member>' +
                     '       </struct>' +
                     '      </value>' +
                     '     </data>' +
                     '    </array>' +
                     '   </value>' +
                     '  </param>' +
                     ' </params>' +
                     '</methodCall>';

begin

   nomeAprocurar:=aQuery;
  Result:=XML_RPC_Send (Format(SEARCH_SUBTITLES, [aToken, aSublanguageID, aQuery]));
end;

function SearchMultiSubtitles(aToken, aSublanguageID: string;list:TStrings): string;
var
  SEARCH_SUBTITLES:string;
  i:Integer;

  function addTag(value:string):string ;
  begin
                Result:=    '       <struct>' +
                     '        <member>' +
                     '         <name>sublanguageid</name>' +
                     '         <value><string>aSublanguageID</string>' +
                     '         </value>' +
                     '        </member>' +
                     '        <member>' +
                     '         <name>query</name>' +
                     '         <value><string>value</string></value>' +
                     '        </member>' +
                     '       </struct>' ;
  end;

  var tags:string;

begin

  tags:='';
for i:=0 to list.Count-1 do
begin
  tags:=tags+addtag(list.Strings[i]);

end;


  SEARCH_SUBTITLES := '<?xml version="1.0"?>' +
                     '<methodCall>' +
                     '  <methodName>SearchSubtitles</methodName>' +
                     '  <params>' +
                     '    <param>' +
                     '      <value><string>aToken</string></value>' +
                     '    </param>' +
                     '  <param>' +
                     '   <value>' +
                     '    <array>' +
                     '     <data>' +
                     '      <value>' +
                     tags+
                     '      </value>' +
                     '     </data>' +
                     '    </array>' +
                     '   </value>' +
                     '  </param>' +
                     ' </params>' +
                     '</methodCall>';



  Result:=XML_RPC_Send (SEARCH_SUBTITLES);
end;

function SearchSubtitlesForSerie(aToken, aSublanguageID, aQuery:string;season,episode: integer): string;
const
SEARCH_SUBTITLES = '<?xml version="1.0"?>' +
                     '<methodCall>' +
                     '  <methodName>SearchSubtitles</methodName>' +
                     '  <params>' +
                     '    <param>' +
                     '      <value><string>%0:s</string></value>' +
                     '    </param>' +
                     '  <param>' +
                     '   <value>' +
                     '    <array>' +
                     '     <data>' +
                     '      <value>' +
                     '       <struct>' +
                     '        <member>' +
                     '         <name>sublanguageid</name>' +
                     '         <value><string>%1:s</string>' +
                     '         </value>' +
                     '        </member>' +
                     '        <member>' +
                     '         <name>query</name>' +
                     '         <value><string>%2:s</string></value>' +
                     '        </member>' +
                     '        <member>' +
                     '         <name>season</name>' +
                     '         <value><int>%3:d</int></value>' +
                     '        </member>' +					 
                     '        <member>' +
                     '         <name>episode</name>' +
                     '         <value><int>%4:d</int></value>' +
                     '        </member>' +					 
                     '       </struct>' +
                     '      </value>' +
                     '     </data>' +
                     '    </array>' +
                     '   </value>' +
                     '  </param>' +
                     ' </params>' +
                     '</methodCall>';

begin

   nomeAprocurar:=aQuery;
  Result:=XML_RPC_Send (Format(SEARCH_SUBTITLES, [aToken, aSublanguageID, aQuery,season,episode]));
end;

procedure trace(msg:string)  ;
begin
 form1.mmo1.Lines.Add(msg);

end;





procedure ConnectTo(xml:string);
var

 parser:TRpcParser;
   struct:IRpcStruct;
    FRpcResult: IRpcResult;
   begin


   parser:=TRpcParser.Create();
   FRpcResult:=parser.Parse(xml);

   if (FRpcResult.IsError) then
   begin
      trace('Error : '+ FRpcResult.ErrorMsg);
      parser.Destroy;
      Exit;
   end;


  if (  FRpcResult.IsStruct) then
  begin
   struct:= FRpcResult.AsStruct;



 if ( struct.KeyExists('token')) then
 begin
  userId:=struct.Keys['token'].AsString;
  form1.stat1.Panels[2].Text:='User ID:'+userid;
 end;

 if ( struct.KeyExists('status')) then
 begin
  form1.stat1.Panels[0].Text:=struct.Keys['status'].AsString;

 end;

 if ( struct.KeyExists('seconds')) then
 begin
    form1.stat1.Panels[1].Text:= FloatToStr( struct.Keys['seconds'].asFloat) +'.ms';
 end;

  end;




 parser.Destroy;

end;


procedure findSubtileTo(xml:string);
var


    subId:Integer;

i,j,index:integer;
data:TRpcStruct;
aItem:TRpcArrayItem;
item:TRpcStructItem;
iArray:iRpcArray;

 parser:TRpcParser;
 FRpcResult:IRpcResult;

begin



   parser:=TRpcParser.Create();
   FRpcResult:=parser.Parse(xml);


       subCount:=0;

if (       FRpcResult.IsError) then
begin
      trace('Error : '+ FRpcResult.ErrorMsg);
      parser.Destroy;
      endOfWorld:=True;
      Exit;

end;


if (FRpcResult.IsArray) then
begin
 // trace('is array');
end;
if(FRpcResult.IsString) then
begin
  //trace('is string');
end;
if (FRpcResult.IsStruct) then
begin


  for index:=0 to FRpcResult.AsStruct.Count-1 do
  begin
      item:=FRpcResult.AsStruct.Items[index];
      if (item.IsArray) then
      begin

      processArray(item.AsArray);

      end else
      if (item.IsStruct) then
      begin
        processStruct(item.AsStruct);
        // trace('item :'+inttostr(index)+' is struct');
      end else
       if (item.IsString) then
      begin
        // trace('item :'+inttostr(index)+'  '+item.Name+' is string');
       // trace( item.AsString);
      end else
       if (item.IsDate) then
      begin
        // trace('item :'+inttostr(index)+' is IsDate');
//        trace( item.AsString);
      end else
        if (item.IsBase64) then
      begin
        // trace('item :'+inttostr(index)+' is IsBase64');
//        trace( item.AsString);
      end else
        if (item.IsInteger) then
      begin
        // trace('item :'+inttostr(index)+' is IsInteger');
//        trace( item.AsString);
      end else
        if (item.IsFloat) then
      begin
          form1.stat1.Panels[1].Text:= FloatToStr( item.asFloat) +'.ms';
//        trace('item :'+inttostr(index)+        item.Name+', is IsFloat');
//        trace( item.AsString);
      end else
      begin
       // trace('outro');
      end;

              Application.ProcessMessages;

  end;



end;


  trace('Num Subtiles :'+inttostr(  subCount));
//  trace('Num Subtiles'+inttostr(  DataResult.Count));

form1.JvBalloonHint1.ActivateHint(form1.lst1,'Find ('+inttostr(subCount)+') Subtiles ','Information',3000);

//    JvBalloonHint1.ActivateHint(LCtrl, memMessage.Text, edtHeader.Text, LVisibleTime);


parser.Destroy;

end;
///********************************

/////IMDB

procedure processIMDBStruct(struct:IRpcStruct);
var
  id,i:Integer;
  sItem:TRpcStructItem;
  value:TRpcStructItem;
begin



             ///**********************************************
     if (struct.KeyExists('plot')) then
    begin
       value:=struct.Keys['plot'];
      imdbPlot:=value.AsString;
    end;

     if (struct.KeyExists('title')) then
    begin
       value:=struct.Keys['title'];
       imdbTitle:=value.AsString;
    end;

     if (struct.KeyExists('rating')) then
    begin
       value:=struct.Keys['rating'];
       imdbRate:=value.AsString;
    end;

     if (struct.KeyExists('cover')) then
    begin
       value:=struct.Keys['cover'];
       imdbImage:=value.AsString;
    end;


      if (struct.KeyExists('id')) then
    begin
       value:=struct.Keys['id'];
       imdbId:=value.AsString;
    end;







  for i:=0 to struct.Count-1 do
  begin
    sItem:=struct.Items[i];
     if (sItem.IsStruct) then
     begin
        processIMDBStruct(sItem.AsStruct);
     end else
     if (sItem.IsArray) then
     begin
       processIMDBArray(sItem.AsArray);
     end else
     ///********************************//
       if (sItem.IsString) then
      begin


         trace('item :'+inttostr(i)+'  '+sItem.Name+' is string');
         trace( sItem.AsString);
      end else
       if (sItem.IsDate) then
      begin
      //   trace('item :'+inttostr(i)+' is IsDate');
      end else
        if (sItem.IsBase64) then
      begin
       //  trace('item :'+inttostr(i)+' is IsBase64');
      end else
        if (sItem.IsInteger) then
      begin
        // trace('item :'+inttostr(i)+' is IsInteger');

      end else
        if (sItem.IsFloat) then
      begin
//        trace('item :'+inttostr(i)+        sItem.Name+' is IsFloat');

      end else
      begin
      //  trace( sItem.Name+' -----OUTRO');
      end;

               Application.ProcessMessages;
  end;

end;
procedure processIMDBArray(a:IRpcArray);
var
  i:Integer;
    aItem:TRpcArrayItem;
begin
  //trace('porcess ARRAY('+inttostr( a.Count)+') elements');
for i:=0 to a.Count-1 do
begin
    aItem:=a.Items[i];



    if (aitem.IsArray) then
    begin
      processIMDBArray(aItem.AsArray);
    end else
    if (aitem.IsStruct) then
    begin
      processIMDBStruct(aItem.AsStruct);
    end else
    ///*************************************
     if (aitem.IsString) then
      begin


        // trace('item :'+inttostr(i)+' is string');
      //   trace( aitem.AsString);
      end else
       if (aitem.IsDate) then
      begin
        // trace('item :'+inttostr(i)+' is IsDate');
      end else
        if (aitem.IsBase64) then
      begin
       //  trace('item :'+inttostr(i)+' is IsBase64');
      end else
        if (aitem.IsInteger) then
      begin
       //  trace('item :'+inttostr(i)+' is IsInteger');

      end else
        if (aitem.IsFloat) then
      begin
//        trace('item :'+inttostr(i)+' is IsFloat');
       //   form1.stat1.Panels[1].Text:= FloatToStr( aItem.asFloat) +'.ms';
      end else
      begin
      //  trace( ' -----OUTRO');
      end;
           Application.ProcessMessages;
end;

end;
///--

procedure findImdbTo(xml:string);
var

    subId:Integer;
    FRpcResult:IRpcResult;



i,j,index:integer;
data:TRpcStruct;
aItem:TRpcArrayItem;
item:TRpcStructItem;
iArray:iRpcArray;

 parser:TRpcParser;

begin



   parser:=TRpcParser.Create();
   FRpcResult:=parser.Parse(xml);


       subCount:=0;

if (       FRpcResult.IsError) then
begin
      trace('Error : '+ FRpcResult.ErrorMsg);
      parser.Destroy;
      endOfWorld:=True;
      Exit;

end;



if (FRpcResult.IsArray) then
begin
 // trace('is array');
end;
if(FRpcResult.IsString) then
begin
  trace('is string');
end;
if (FRpcResult.IsStruct) then
begin


  for index:=0 to FRpcResult.AsStruct.Count-1 do
  begin
      item:=FRpcResult.AsStruct.Items[index];
      if (item.IsArray) then
      begin
      processIMDBArray(item.AsArray);

      end else
      if (item.IsStruct) then
      begin
        processIMDBStruct(item.AsStruct);
        // trace('item :'+inttostr(index)+' is struct');
      end else
       if (item.IsString) then
      begin
         trace('item :'+inttostr(index)+'  '+item.Name+' is string');
       // trace( item.AsString);
      end else
       if (item.IsDate) then
      begin
        // trace('item :'+inttostr(index)+' is IsDate');
//        trace( item.AsString);
      end else
        if (item.IsBase64) then
      begin
        // trace('item :'+inttostr(index)+' is IsBase64');
//        trace( item.AsString);
      end else
        if (item.IsInteger) then
      begin
        // trace('item :'+inttostr(index)+' is IsInteger');
//        trace( item.AsString);
      end else
        if (item.IsFloat) then
      begin
          form1.stat1.Panels[1].Text:= FloatToStr( item.asFloat) +'.ms';
      end else
      begin
       // trace('outro');
      end;

              Application.ProcessMessages;

  end;



end;

form1.JvBalloonHint1.ActivateHint(form1.lst1,'Operation Complete ','Information',3000);


parser.Destroy;

end;
//*******************************************************************************


/////IMDB

procedure processIMDBStructSubtile(struct:IRpcStruct);
var
  id,i:Integer;
  sItem:TRpcStructItem;
  value:TRpcStructItem;
   subtile:TSubtile;
begin

   
             ///**********************************************
             //fir member so start ready subtile ... time for coffe ;)
     if (struct.KeyExists('MatchedBy')) then
    begin
        value:=struct.Keys['MatchedBy'];
         Inc(subCount);
        subtile:=TSubtile.Create;
        subtile.nomeDaProcura:=nomeAprocurar;
    //    trace('START read server information');

     //estamos na legenda
    end;









           //if in the last    member get all values (is more safe)
       if (struct.KeyExists('SubDownloadLink')) then
       begin


        value:=struct.Keys['SubDownloadLink'];
        if(Assigned(subtile)) then
        begin
          subtile.SubDownloadLink:=value.AsString;
        end;

       if (struct.KeyExists('SubLanguageID')) then
       begin
        value:=struct.Keys['SubLanguageID'];
          if(Assigned(subtile)) then
          begin
            subtile.SubLanguageID:=value.AsString;
          end;
       end;

        if (struct.KeyExists('SubRating')) then
    begin
       value:=struct.Keys['SubRating'];
        if(Assigned(subtile)) then
        begin
          subtile.SubRating:=value.AsString;
        end;
    end;

         if (struct.KeyExists('SubFileName')) then
    begin
       value:=struct.Keys['SubFileName'];
    //   element('SubFileName',value.AsString);
         if(Assigned(subtile)) then
         begin
             subtile.SubFileName:=value.AsString;
           //  form1.ListBox2.Items.Add( value.AsString+ '      Subtile Rating('+subtile.SubRating+')');
             form1.ValueListEditor1.InsertRow(value.AsString,subtile.SubRating,True);
          end;
    end;

    if (struct.KeyExists('SubDownloadsCnt')) then
    begin
       value:=struct.Keys['SubDownloadsCnt'];
        if(Assigned(subtile)) then
        begin
          subtile.SubDownloadsCnt:=StrToInt(value.AsString);

        end;
    end;

      if (struct.KeyExists('SubFormat')) then
    begin
       value:=struct.Keys['SubFormat'];
        if(Assigned(subtile)) then
        begin
         subtile.SubFormat:=value.AsString;
        end;

    end;
      if (struct.KeyExists('SubAuthorComment')) then
    begin
       value:=struct.Keys['SubAuthorComment'];
        if(Assigned(subtile)) then
        begin
          subtile.SubAuthorComment:=value.AsString;
        end;
    end;
      if (struct.KeyExists('SubAddDate')) then
    begin
       value:=struct.Keys['SubAddDate'];
        if(Assigned(subtile)) then
        begin
          subtile.SubAddDate:=value.AsString;
        end;

//       element('SubAddDate',value.AsString);
     //
    end;
      if (struct.KeyExists('MovieReleaseName')) then
    begin
       value:=struct.Keys['MovieReleaseName'];
        if(Assigned(subtile)) then
        begin
         subtile.MovieReleaseName:=value.AsString;
        end;

    end;
      if (struct.KeyExists('IDMovieImdb')) then
    begin
       value:=struct.Keys['IDMovieImdb'];
        if(Assigned(subtile)) then
        begin
          subtile.IDMovieImdb:=value.AsString;
        end;

    end;
       if (struct.KeyExists('MovieName')) then
    begin
       value:=struct.Keys['MovieName'];
        if(Assigned(subtile)) then
        begin
          subtile.MovieName:=value.AsString;
        end;


    end;
       if (struct.KeyExists('MovieYear')) then
    begin
       value:=struct.Keys['MovieYear'];
        if(Assigned(subtile)) then
        begin
          subtile.MovieYear:=value.AsString;
        end;

    end;
     if (struct.KeyExists('UserNickName')) then
    begin
       value:=struct.Keys['UserNickName'];
        if(Assigned(subtile)) then
        begin
          subtile.UserNickName:=value.AsString;
        end;

    end;



    if (struct.KeyExists('LanguageName')) then
    begin
       value:=struct.Keys['LanguageName'];
        if(Assigned(subtile)) then
        begin
          subtile.LanguageName:=value.AsString;
        end;

    end;

     if (struct.KeyExists('MovieImdbRating')) then
    begin
       value:=struct.Keys['MovieImdbRating'];
        if(Assigned(subtile)) then
        begin
          subtile.MovieImdbRating:=value.AsString;
        end;

    end;









        listaLegendas.Add(subtile);
    //    trace('STOP read server information');


    end;








  for i:=0 to struct.Count-1 do
  begin
    sItem:=struct.Items[i];
     if (sItem.IsStruct) then
     begin
        processIMDBStructSubtile(sItem.AsStruct);
     end else
     if (sItem.IsArray) then
     begin
       processIMDBArraySubtile(sItem.AsArray);
     end else
     ///********************************//
       if (sItem.IsString) then
      begin


       //  trace('item :'+inttostr(i)+'  '+sItem.Name+' is string');
      //   trace( sItem.AsString);
      end else
       if (sItem.IsDate) then
      begin
      //   trace('item :'+inttostr(i)+' is IsDate');
      end else
        if (sItem.IsBase64) then
      begin
       //  trace('item :'+inttostr(i)+' is IsBase64');
      end else
        if (sItem.IsInteger) then
      begin
        // trace('item :'+inttostr(i)+' is IsInteger');

      end else
        if (sItem.IsFloat) then
      begin
//        trace('item :'+inttostr(i)+        sItem.Name+' is IsFloat');

      end else
      begin
      //  trace( sItem.Name+' -----OUTRO');
      end;

               Application.ProcessMessages;
  end;

end;
procedure processIMDBArraySubtile(a:IRpcArray);
var
  i:Integer;
    aItem:TRpcArrayItem;
begin
  //trace('porcess ARRAY('+inttostr( a.Count)+') elements');
for i:=0 to a.Count-1 do
begin
    aItem:=a.Items[i];



    if (aitem.IsArray) then
    begin
      processIMDBArraySubtile(aItem.AsArray);
    end else
    if (aitem.IsStruct) then
    begin
      processIMDBStructSubtile(aItem.AsStruct);
    end else
    ///*************************************
     if (aitem.IsString) then
      begin


        // trace('item :'+inttostr(i)+' is string');
      //   trace( aitem.AsString);
      end else
       if (aitem.IsDate) then
      begin
        // trace('item :'+inttostr(i)+' is IsDate');
      end else
        if (aitem.IsBase64) then
      begin
       //  trace('item :'+inttostr(i)+' is IsBase64');
      end else
        if (aitem.IsInteger) then
      begin
       //  trace('item :'+inttostr(i)+' is IsInteger');

      end else
        if (aitem.IsFloat) then
      begin
//        trace('item :'+inttostr(i)+' is IsFloat');
       //   form1.stat1.Panels[1].Text:= FloatToStr( aItem.asFloat) +'.ms';
      end else
      begin
      //  trace( ' -----OUTRO');
      end;
           Application.ProcessMessages;
end;

end;
///--

procedure findImdbToSubtile(xml:string);
var


    subId:Integer;

i,j,index:integer;
data:TRpcStruct;
aItem:TRpcArrayItem;
item:TRpcStructItem;
iArray:iRpcArray;

 parser:TRpcParser;
     FRpcResult:IRpcResult;

begin



   parser:=TRpcParser.Create();
   FRpcResult:=parser.Parse(xml);


       subCount:=0;

if (       FRpcResult.IsError) then
begin
      trace('Error : '+ FRpcResult.ErrorMsg);
      parser.Destroy;
      endOfWorld:=True;
      Exit;

end;





if (FRpcResult.IsArray) then
begin
 // trace('is array');
end;
if(FRpcResult.IsString) then
begin
 // trace('is string');
end;
if (FRpcResult.IsStruct) then
begin


  for index:=0 to FRpcResult.AsStruct.Count-1 do
  begin
      item:=FRpcResult.AsStruct.Items[index];
      if (item.IsArray) then
      begin
      processIMDBArraySubtile(item.AsArray);

      end else
      if (item.IsStruct) then
      begin
        processIMDBStructSubtile(item.AsStruct);
        // trace('item :'+inttostr(index)+' is struct');
      end else
       if (item.IsString) then
      begin
      //   trace('item :'+inttostr(index)+'  '+item.Name+' is string');
       // trace( item.AsString);
      end else
       if (item.IsDate) then
      begin
        // trace('item :'+inttostr(index)+' is IsDate');
//        trace( item.AsString);
      end else
        if (item.IsBase64) then
      begin
        // trace('item :'+inttostr(index)+' is IsBase64');
//        trace( item.AsString);
      end else
        if (item.IsInteger) then
      begin
        // trace('item :'+inttostr(index)+' is IsInteger');
//        trace( item.AsString);
      end else
        if (item.IsFloat) then
      begin
          form1.stat1.Panels[1].Text:= FloatToStr( item.asFloat) +'.ms';
      end else
      begin
       // trace('outro');
      end;

              Application.ProcessMessages;

  end;



end;

form1.JvBalloonHint1.ActivateHint(form1.lst1,'Operation Complete ','Information',3000);



parser.Destroy;

end;


procedure TForm1.IdHTTP1Status(ASender: TObject; const AStatus: TIdStatus; const AStatusText: String);
begin
trace('Status : '+astatustext);
end;

procedure TForm1.IdHTTP1Disconnected(Sender: TObject);
begin
//trace('disconected');
isConnect:=False;

end;

procedure TForm1.IdHTTP1Connected(Sender: TObject);
begin
 // trace('logged in');
 isConnect:=true;

end;

procedure TForm1.btn1Click(Sender: TObject);
var
   connect:TStringList;
   xml:string;
begin

   

end;
           {
procedure TForm1.WMDROPFILES(var msg: TWMDropFiles) ;
 const
   MAXFILENAME = 255;
 var
   cnt, fileCount : integer;
   fileName : array [0..MAXFILENAME] of char;
 begin
   // how many files dropped?
   fileCount := DragQueryFile(msg.Drop, $FFFFFFFF, fileName, MAXFILENAME) ;
    trace('Num files drag'+inttostr(fileCount));
   // query for file names
   for cnt := 0 to -1 + fileCount do
   begin
     DragQueryFile(msg.Drop, cnt, fileName, MAXFILENAME) ;

     //do something with the file(s)
     trace( fileName) ;
   end;
 
   //release memory
   DragFinish(msg.Drop) ;
 end;
      }
procedure TForm1.FormCreate(Sender: TObject);
var
   IniFile : TIniFile;
 begin
        IdHTTP1.OnWork:=HttpWork;
       listaLegendas:=TSubtileList.Create;


   IniFile := TIniFile.Create(ChangeFileExt(Application.ExeName,'.ini')) ;
   vUserName:=   IniFile.ReadString('setup', 'user', '');
   vUserPass:=   IniFile.ReadString('setup', 'pass', '');
   vSearchLanguages:=  IniFile.ReadString('setup', 'SearchLanguage', 'por,pob');
   vUserLanguage:=IniFile.ReadString('setup', 'language', 'pt');
   IniFile.ReadString('setup', 'version', '0.0.2');
   IniFile.destroy;

   Caption:='Lazy Subtile Download 0.0.2 By Luis Santos AKA DJOKER';
   trace(caption);

   Form1.stat1.Panels[3].Text:=vUserName;


   DragAcceptFiles( Handle, True ) ;

Log2Click(Self);

end;

procedure TForm1.Loggin1Click(Sender: TObject);
begin
form2.show;
end;

procedure TForm1.Log2Click(Sender: TObject);
var
   connect:TStringList;
begin

    xmlConnect:=LogIn(vUserName, vUserPass, vUserLanguage);

   connect:=TStringList.Create();
   connect.Add(xmlConnect);
   connect.SaveToFile('_connect.xml');
   connect.Destroy;



 //  trace(xmlConnect);

     ConnectTo(xmlConnect);

end;

procedure TForm1.LogOut1Click(Sender: TObject);
begin
   LogOut(  userId);
end;



procedure TForm1.idhtpDownloadWorkBegin(Sender: TObject;
  AWorkMode: TWorkMode; const AWorkCountMax: Integer);
begin
  form1.pb1.Position:=0;
end;

procedure TForm1.idhtpDownloadWorkEnd(Sender: TObject;
  AWorkMode: TWorkMode);
begin
  form1.pb1.Position:=0;
end;

procedure TForm1.btn2Click(Sender: TObject);

begin


//url:='http://dl.opensubtitles.org/en/download/sub/src-api/vrf-f53b0bb8/sid-71srfnm30lni4fgbgs58ota977/6406339';
//downloadFile(url,'sub/subtile.zip');



      //      <string>http://dl.opensubtitles.org/en/download/sub/src-api/vrf-f53b0bb8/sid-71srfnm30lni4fgbgs58ota977/6406339</string>

        //    <string>http://www.opensubtitles.org/en/subtitles/6406339/sid-71srfnm30lni4fgbgs58ota977/valley-of-love-pb</string>

end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
listaLegendas.Destroy;
DragAcceptFiles( Handle, false ) ;
end;


procedure TForm1.Button1Click(Sender: TObject);
var
   xml:string;
 connect:TStringList;
begin
      if (Edit1.Text='') then
    begin
      form1.JvBalloonHint1.ActivateHint(form1.lst1,'You stupid asshole   !!! nothing to search.. ','Information',3000);
      exit;
    end;

  listaLegendas.Clear;
  Form1.lst1.Items.Clear;
  form1.ListBox1.Items.Clear;
//  form1.ListBox2.Items.Clear;
  form1.ValueListEditor1.Strings.Clear;

    xml:=SearchSubtitles(userId, vSearchLanguages,Edit1.Text);


  // connect:=TStringList.Create();
 //  connect.Add(xml);
 //  connect.SaveToFile('_busca.xml');
  // connect.Destroy;

    findSubtileTo(xml);
end;

procedure TForm1.lst1DblClick(Sender: TObject);
var
 connect:TStringList;
   xml:string;
begin
listaLegendas.Clear;
//  form1.ListBox2.Items.Clear;
   ValueListEditor1.Strings.Clear;
   
    xml:=SearchSubtitles(userId,vSearchLanguages, lst1.Items.Strings[lst1.ItemIndex]);

  // connect:=TStringList.Create();
  // connect.Add(xml);
  // connect.SaveToFile('_busca.xml');
  // connect.Destroy;
    findSubtileTo(xml);

//Caption:=form1.lst1.Items.Strings[form1.lst1.ItemIndex];

end;

procedure TForm1.Limpa1Click(Sender: TObject);
begin
lst1.Items.Clear;
ValueListEditor1.Strings.Clear;
listaLegendas.Clear;

end;

procedure TForm1.ListBox2Click(Sender: TObject);
var
  select:Integer;
  sub:TSubtile;
begin
{   select:=ListBox2.ItemIndex;
   if (listaLegendas.Count>0) then
   begin
     sub:=listaLegendas.Items[select];
     if  (Assigned(sub)) then
     begin
         Label10.Caption:=sub.SubLanguageID;
         Label11.Caption:=sub.SubFormat;
         Label12.Caption:=sub.SubAddDate;
         Label13.Caption:=sub.LanguageName;
         Label14.Caption:=sub.MovieName;
         Label15.Caption:=sub.MovieYear;
         Label16.Caption:=sub.MovieImdbRating;
         Label18.Caption:=sub.SubRating;
         Label20.Caption:=IntToStr(sub.SubDownloadsCnt);
         Label22.Caption:=sub.UserNickName;
         Edit2.Text:=sub.IDMovieImdb;
         Memo1.Lines.Add(sub.SubAuthorComment);


     end;
   end;
   }
end;

procedure TForm1.Button2Click(Sender: TObject);
var
   xml:string;
 connect:TStringList;
begin
      if (Edit3.Text='') then
    begin
      form1.JvBalloonHint1.ActivateHint(form1.lst1,'You stupid asshole   !!! nothing to search.. ','Information',3000);
      exit;
    end;

    
  listaLegendas.Clear;
  Form1.lst1.Items.Clear;
  form1.ListBox1.Items.Clear;
  form1.ValueListEditor1.Strings.Clear;

    xml:=SearchSubtitlesImdb(userId, vSearchLanguages,StrToInt(Edit3.Text));


  // connect:=TStringList.Create();
  // connect.Add(xml);
  // connect.SaveToFile('_buscaImdb.xml');
 //connect.Destroy;

 findImdbToSubtile(xml);

  //  findImdbTo(xml);
   //findSubtileTo(xml);




end;

procedure TForm1.Edit2DblClick(Sender: TObject);
var
  url:string;
begin
url:='http://www.imdb.com/title/tt'+edit2.Text;
ShellExecute(0, 'OPEN', PChar(url), '', '', SW_SHOWNORMAL);
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  select:Integer;
  sub:TSubtile;
 InputString,filme,filmename, filmepath,path, filetosave:string;
  index:Integer;
   buttonSelected : Integer;
  function getNewname(filename:string):string;
  var
    fext,filetosave,fName:string;
    busca:boolean;
  begin

  fext:=ExtractFileExt(filename);
  fName:=ChangeFileExt(filename,'');



    index:=0;
    busca:=True;
  while (busca) do
  begin
     Application.ProcessMessages;
     filetosave:=fname+'_'+inttostr(index)+fext;
     if (not FileExists(filetosave)) then
      begin
        busca:=False;
      end;
     Inc(INDEX);
  end;
    Result:=filetosave;
  end;

begin
      index:=0;

    //busca por nome
      path:=  ExtractFilePath(Application.ExeName);

  if (DirectoryExists(path+'sub')=False) then
  begin
     CreateDir(path+'sub');
  end;

    if(ListBox1.Items.Count>0) then
  begin
   filme:= ListBox1.Items[lst1.ItemIndex];
   trace(filme);
   if(FileExists(filme)) then
   begin
      filmename:=ExtractFileName(filme);
      filmepath:=ExtractFileDir(filme);

      //   trace(filmename);
     //    trace(filmepath);

     if (listaLegendas.Count>0) then
   begin
     select:=ValueListEditor1.Row-1;
     if (select >listaLegendas.Count) then Exit;
     sub:=listaLegendas.Items[select];

     if  (Assigned(sub)) then
     begin
     filetosave:=filmepath+'\'+ChangeFileExt(filmename,'.'+sub.SubFormat);

      if (FileExists(filetosave)) then
     begin
     buttonSelected := MessageDlg('Subtile already exist. Replase?',mtConfirmation , [mbYes,mbNo] , 0);
     if buttonSelected = mrNo then
     begin
      filetosave:= getNewname(filetosave);
     end;
    end;


      downloadFile(sub.SubDownloadLink,filetosave);
     end;

   end;
   end;
  end else
  begin



   if (listaLegendas.Count>0) then
   begin
//        select:=ListBox2.ItemIndex;
  select:=ValueListEditor1.Row-1;
  if (select >listaLegendas.Count) then Exit;
   sub:=listaLegendas.Items[select];
     if  (Assigned(sub)) then
     begin
         filetosave:=path+'sub\'+sub.SubFileName;

     if (FileExists(filetosave)) then
     begin
     buttonSelected := MessageDlg('Subtile already exist. Replase?',mtConfirmation , [mbYes,mbNo] , 0);
     if buttonSelected = mrNo then
     begin
      filetosave:= getNewname(filetosave);
     end;
    end;
     downloadFile(sub.SubDownloadLink,filetosave);
    end;
   end;
 end;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  select:Integer;
  sub:TSubtile;
 InputString,filme,filmename, filmepath,path, filetosave:string;
  index:Integer;
   buttonSelected : Integer;
  function getNewname(filename:string):string;
  var
    fext,filetosave,fName:string;
    busca:boolean;
  begin

  fext:=ExtractFileExt(filename);
  fName:=ChangeFileExt(filename,'');



    index:=0;
    busca:=True;
  while (busca) do
  begin
     Application.ProcessMessages;
     filetosave:=fname+'_'+inttostr(index)+fext;
     if (not FileExists(filetosave)) then
      begin
        busca:=False;
      end;
     Inc(INDEX);
  end;
    Result:=filetosave;
  end;

begin
      index:=0;


    //busca por nome
      path:=  ExtractFilePath(Application.ExeName);

  if (DirectoryExists(path+'\sub')=False) then
  begin
     CreateDir(path+'\sub');
  end;


  
    if(ListBox1.Items.Count>0) then
  begin
   filme:= ListBox1.Items[lst1.ItemIndex];
   trace(filme);
   if(FileExists(filme)) then
   begin
      filmename:=ExtractFileName(filme);
      filmepath:=ExtractFileDir(filme);

      //   trace(filmename);
     //    trace(filmepath);

     if (listaLegendas.Count>0) then
   begin

       for select:=0 to listaLegendas.Count-1 do
     begin



    if (select >listaLegendas.Count) then Exit;

     if  (Assigned(sub)) then
     begin
     filetosave:=filmepath+'\'+ChangeFileExt(filmename,'.'+sub.SubFormat);

      if (FileExists(filetosave)) then
     begin
     buttonSelected := MessageDlg('Subtile already exist. Replase?',mtConfirmation , [mbYes,mbNo] , 0);
     if buttonSelected = mrNo then
     begin
      filetosave:= getNewname(filetosave);
     end;
    end;


      downloadFile(sub.SubDownloadLink,filetosave);
     end;
   end;
   end;
   end;
  end else
  begin


//   select:=ListBox2.ItemIndex;
  select:=ValueListEditor1.Row-1;
  if (select >listaLegendas.Count) then Exit;


   if (listaLegendas.Count>0) then
   begin
       for select:=0 to listaLegendas.Count-1 do
     begin
                 Application.ProcessMessages;
  
     sub:=listaLegendas.Items[select];
     if  (Assigned(sub)) then
     begin


     if  (Assigned(sub)) then
     begin
         filetosave:=path+'sub\'+sub.SubFileName;

     if (FileExists(filetosave)) then
     begin
     buttonSelected := MessageDlg('Subtile already exist. Replase?',mtConfirmation , [mbYes,mbNo] , 0);
     if buttonSelected = mrNo then
     begin
      filetosave:= getNewname(filetosave);
     end;
    end;
     downloadFile(sub.SubDownloadLink,filetosave);
    end;
   end;
  end;
 end;
end;




end;



procedure TForm1.IdHTTP1WorkEnd(Sender: TObject; AWorkMode: TWorkMode);
begin
    form1.pb1.Position:=0;
end;

procedure TForm1.IdHTTP1Work(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCount: Integer);
var
  Http: TIdHTTP;
  ContentLength: Int64;
  Percent: Integer;
begin
  Http := TIdHTTP(Sender);
  ContentLength := Http.Response.ContentLength;

 // form1.pb1.Max:=ContentLength;


//if (Pos('chunked', LowerCase(Http.Response.ResponseText)) = 0) and(ContentLength > 0) then
begin
    Percent := 100*AWorkCount div ContentLength;
    form1.pb1.Position:=Percent;
   // trace(IntToStr(ContentLength )+','+inttostr(percent)+','+inttostr(AWorkCount));


   // MemoOutput.Lines.Add(IntToStr(Percent));
end;

end;

procedure TForm1.IdHTTP1WorkBegin(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCountMax: Integer);
begin
    form1.pb1.Position:=0;
end;

procedure TForm1.IdHTTP2Status(ASender: TObject; const AStatus: TIdStatus;
  const AStatusText: String);
begin
trace('Status : '+astatustext);
end;

procedure TForm1.IdHTTP2Work(Sender: TObject; AWorkMode: TWorkMode; const AWorkCount: Integer);
var
  Http: TIdHTTP;
  ContentLength: Int64;
  Percent: Integer;
begin
  Http := TIdHTTP(Sender);
  ContentLength := abs(Http.Response.ContentLength);



 // form1.pb1.Max:=ContentLength;


//if (Pos('chunked', LowerCase(Http.Response.ResponseText)) = 0) and(ContentLength > 0) then
begin
    Percent := abs(100*abs(AWorkCount) div abs(ContentLength));
    form1.pb1.Position:=Percent;
  //  trace(IntToStr(ContentLength )+','+inttostr(percent)+','+inttostr(AWorkCount));


   // MemoOutput.Lines.Add(IntToStr(Percent));
end;
end;

procedure TForm1.IdHTTP2WorkBegin(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCountMax: Integer);
begin
    form1.pb1.Position:=0;
end;

procedure TForm1.IdHTTP2WorkEnd(Sender: TObject; AWorkMode: TWorkMode);
begin
    form1.pb1.Position:=0;
    //   form1.JvBalloonHint1.ActivateHint(form1.ListBox1,'Download Complete.. ','Information',3000);
end;

procedure TForm1.ListBox2DblClick(Sender: TObject);
var
  select:Integer;
  sub:TSubtile;
filme,filmename, filmepath,path, filetosave:string;
  index:Integer;
    buttonSelected : Integer;
  function getNewname(filename:string):string;
  var
    fext,filetosave,fName:string;
    busca:boolean;
  begin

  fext:=ExtractFileExt(filename);
  fName:=ChangeFileExt(filename,'');



    index:=0;
    busca:=True;
  while (busca) do
  begin
     Application.ProcessMessages;
     filetosave:=fname+'_'+inttostr(index)+fext;
     if (not FileExists(filetosave)) then
      begin
        busca:=False;
      end;
     Inc(INDEX);
  end;
    Result:=filetosave;
  end;

begin
      index:=0;

   //se procuramos poelo filme
  if(ListBox1.Items.Count>0) then
  begin
   filme:= ListBox1.Items[lst1.ItemIndex];
   trace(filme);
   if(FileExists(filme)) then
   begin
      filmename:=ExtractFileName(filme);
      filmepath:=ExtractFileDir(filme);

      //   trace(filmename);
     //    trace(filmepath);

     if (listaLegendas.Count>0) then
   begin
//     select:=ListBox2.ItemIndex;
  select:=ValueListEditor1.Row-1;
     sub:=listaLegendas.Items[select];
     if  (Assigned(sub)) then
     begin
     filetosave:=filmepath+'\'+ChangeFileExt(filmename,'.'+sub.SubFormat);

      if (FileExists(filetosave)) then
     begin
     buttonSelected := MessageDlg('Subtile already exist. Replase?',mtConfirmation , [mbYes,mbNo] , 0);
     if buttonSelected = mrNo then
     begin
      filetosave:= getNewname(filetosave);
     end;
    end;


      downloadFile(sub.SubDownloadLink,filetosave);
     end;
   end;
   end;

  end else
  begin

     if (listaLegendas.Count>0) then
   begin
//        select:=ListBox2.ItemIndex;
  select:=ValueListEditor1.Row-1;
     sub:=listaLegendas.Items[select];
     if  (Assigned(sub)) then
     begin
         filetosave:=path+'sub\'+sub.SubFileName;

     if (FileExists(filetosave)) then
     begin
     buttonSelected := MessageDlg('Subtile already exist. Replase?',mtConfirmation , [mbYes,mbNo] , 0);
     if buttonSelected = mrNo then
     begin
      filetosave:= getNewname(filetosave);
     end;
    end;
     downloadFile(sub.SubDownloadLink,filetosave);
    end;
   end;

  end;


end;

procedure TForm1.ClearAll1Click(Sender: TObject);
begin
 listaLegendas.Clear;
 Form1.lst1.Items.Clear;
 form1.ListBox1.Items.Clear;
//  form1.ListBox2.Items.Clear;
   ValueListEditor1.Strings.Clear;
end;

procedure TForm1.About1Click(Sender: TObject);
begin
form3.show;
end;

procedure TForm1.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
   if ord(Key) = VK_RETURN then
  begin
    Key := #0;
    Button2Click(Self);
  end;

if not (Key in [#8, '0'..'9']) then
 begin
    Key := #0;
  end;
end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
   if ord(Key) = VK_RETURN then
  begin
    Key := #0;
    Button1Click(Self);
  end;
end;

procedure TForm1.ValueListEditor1Click(Sender: TObject);
var
  select:Integer;
  sub:TSubtile;
begin

   select:=ValueListEditor1.Row-1;

   if (select >listaLegendas.Count) then Exit;

   if (listaLegendas.Count>0) then
   begin
     sub:=listaLegendas.Items[select];
     if  (Assigned(sub)) then
     begin
         Label10.Caption:=sub.SubLanguageID;
         Label11.Caption:=sub.SubFormat;
         Label12.Caption:=sub.SubAddDate;
         Label13.Caption:=sub.LanguageName;
         Label14.Caption:=sub.MovieName;
         Label15.Caption:=sub.MovieYear;
         Label16.Caption:=sub.MovieImdbRating;
         Label18.Caption:=sub.SubRating;
         Label20.Caption:=IntToStr(sub.SubDownloadsCnt);
         Label22.Caption:=sub.UserNickName;
         Edit2.Text:=sub.IDMovieImdb;
         Memo1.Lines.Add(sub.SubAuthorComment);


     end;
   end;

end;

procedure TForm1.ValueListEditor1DblClick(Sender: TObject);
var
  select:Integer;
  sub:TSubtile;
filme,filmename, filmepath,path, filetosave:string;
  index:Integer;
    buttonSelected : Integer;
  function getNewname(filename:string):string;
  var
    fext,filetosave,fName:string;
    busca:boolean;
  begin

  fext:=ExtractFileExt(filename);
  fName:=ChangeFileExt(filename,'');



    index:=0;
    busca:=True;
  while (busca) do
  begin
     Application.ProcessMessages;
     filetosave:=fname+'_'+inttostr(index)+fext;
     if (not FileExists(filetosave)) then
      begin
        busca:=False;
      end;
     Inc(INDEX);
  end;
    Result:=filetosave;
  end;

begin
      index:=0;

   //se procuramos poelo filme
  if(ListBox1.Items.Count>0) then
  begin
   filme:= ListBox1.Items[lst1.ItemIndex];
 //  trace(filme);
   if(FileExists(filme)) then
   begin
      filmename:=ExtractFileName(filme);
      filmepath:=ExtractFileDir(filme);

      //   trace(filmename);
     //    trace(filmepath);

     if (listaLegendas.Count>0) then
   begin
        select:=ValueListEditor1.Row-1;
        if (select >listaLegendas.Count) then Exit;


     sub:=listaLegendas.Items[select];
     if  (Assigned(sub)) then
     begin
     filetosave:=filmepath+'\'+ChangeFileExt(filmename,'.'+sub.SubFormat);

      if (FileExists(filetosave)) then
     begin
     buttonSelected := MessageDlg('Subtile already exist. Replase?',mtConfirmation , [mbYes,mbNo] , 0);
     if buttonSelected = mrNo then
     begin
      filetosave:= getNewname(filetosave);
     end;
    end;


      downloadFile(sub.SubDownloadLink,filetosave);
     end;
   end;
   end;

  end else
  begin

     if (listaLegendas.Count>0) then
   begin
          select:=ValueListEditor1.Row-1;
          if (select >listaLegendas.Count) then Exit;

     sub:=listaLegendas.Items[select];
     if  (Assigned(sub)) then
     begin
         filetosave:=path+'sub\'+sub.SubFileName;

     if (FileExists(filetosave)) then
     begin
     buttonSelected := MessageDlg('Subtile already exist. Replase?',mtConfirmation , [mbYes,mbNo] , 0);
     if buttonSelected = mrNo then
     begin
      filetosave:= getNewname(filetosave);
     end;
    end;
     downloadFile(sub.SubDownloadLink,filetosave);
    end;
   end;

  end;

end;

procedure TForm1.Button5Click(Sender: TObject);
var
   xml:string;
 connect:TStringList;
 list:string;
season,episode, i:Integer;
begin
    if (Edit4.Text='')  then
    begin
      form1.JvBalloonHint1.ActivateHint(form1.lst1,'You stupid asshole   !!! nothing to search.. ','Information',3000);
      exit;
    end;
    if (Edit5.Text='') then
    begin
      form1.JvBalloonHint1.ActivateHint(form1.lst1,'You stupid asshole   !!! type the season .. ','Information',3000);
      exit;
    end;
    if  (Edit6.text='') then
    begin
      form1.JvBalloonHint1.ActivateHint(form1.lst1,'You stupid asshole   !!! type the episode.. ','Information',3000);
      exit;
    end;


  listaLegendas.Clear;
  Form1.lst1.Items.Clear;
  form1.ListBox1.Items.Clear;
//  form1.ListBox2.Items.Clear;
  form1.ValueListEditor1.Strings.Clear;

//  array('query' => 'south park', 'season' => 1, 'episode' => 1, 'sublanguageid'=>'all'),
   season:=StrToInt(Edit5.Text);
   episode:=StrToInt(Edit6.text);

    xml:=SearchSubtitlesForSerie(userId, vSearchLanguages,Edit4.Text,season,episode);


   connect:=TStringList.Create();
   connect.Add(xml);
   connect.SaveToFile('_busca.xml');
   connect.Destroy;

    findSubtileTo(xml);
end;

procedure TForm1.Edit5KeyPress(Sender: TObject; var Key: Char);
begin
 

if not (Key in [#8, '0'..'9']) then
 begin
    Key := #0;
  end;
end;

procedure TForm1.Edit6KeyPress(Sender: TObject; var Key: Char);
begin


if not (Key in [#8, '0'..'9']) then
 begin
    Key := #0;
  end;
end;

procedure TForm1.SearchAll1Click(Sender: TObject);
var
  i:Integer;

var
   xml:string;
 connect:TStringList;
begin

xml:=  SearchMultiSubtitles(userId, vSearchLanguages,lst1.items);


   connect:=TStringList.Create();
   connect.Add(xml);
   connect.SaveToFile('_busca.xml');
   connect.Destroy;

    findSubtileTo(xml);

end;

procedure TForm1.Button6Click(Sender: TObject);
var
   xml:string;
 connect:TStringList;
begin

    xml:=SearchMovieImdb(userId,  Edit3.Text);

    if (Edit3.Text='') then
    begin
      form1.JvBalloonHint1.ActivateHint(form1.lst1,'You stupid asshole   !!! nothing to search.. ','Information',3000);
      exit;
    end;
    // trace(xml);
  // connect:=TStringList.Create();
 //  connect.Add(xml);
  // connect.SaveToFile('_imdb.xml');
  // connect.Destroy;


    findImdbTo(xml);

       form4.Update();
    


end;

end.
