unit USubtile;

interface
uses classes,SysUtils;


type
  TSubtile=class
  public
   nomeDaProcura:string;
   SubFileName,
   SubLanguageID,
   SubFormat,
   SubAuthorComment,
   SubAddDate,
   MovieReleaseName,
   IDMovieImdb,
   MovieName,
   MovieYear,
   MovieImdbRating,
   LanguageName,
   SubRating,
   UserNickName,
   SubDownloadLink:string;
   SubDownloadsCnt,query:Integer;
   function toString():string;
   constructor Create();
  end;

  TSubtileList = class( TList )
  protected
    function Get( Index : Integer ) : TSubtile;
    procedure Put( Index : Integer; Item : TSubtile );
  public
    property Items[ Index : Integer ] : TSubtile read Get write Put; default;

    procedure Del(Idx: Integer);
    procedure Clear; override;

    function Add(obj: TSubtile): TSubtile;

    function Exists(name:string):boolean;
    function GetContains(Name: String): Boolean;
    function IndexOf(Item: TSubtile): Integer; overload;
    function IndexOf(const Name: String): Integer;     overload;
    function Find   (const Name: string): TSubtile;
    destructor Destroy();

  end;

implementation
   constructor TSubtile.Create();
   begin
     nomeDaProcura:='';
   SubFileName:='';
   SubLanguageID:='';
   SubFormat:='';
   SubAuthorComment:='';
   SubAddDate:='';
   MovieReleaseName:='';
   IDMovieImdb:='';
   MovieName:='';
   MovieYear:='';
   MovieImdbRating:='';
   LanguageName:='';
   SubRating:='';
   UserNickName:='';
   SubDownloadLink:='';
   SubDownloadsCnt:=0;
   query:=0;
   end;
   function TSubtile.toString():string;
   begin

   Result:='('+
   SubFileName+'#10#13'+
   SubLanguageID+'#10#13'+
   MovieReleaseName+'#10#13'+
   IDMovieImdb+'#10#13'+
   MovieName+'#10#13'+
   MovieYear+'#10#13'+
   MovieImdbRating+'#10#13'+
   SubRating+'#10#13'+
   UserNickName+')';


   end;


function TSubtileList.Get( Index : Integer ) : TSubtile;
begin
  Result := inherited Get( Index );
end;

procedure TSubtileList.Put( Index : Integer; Item : TSubtile );
begin
  inherited Put( Index, Item );
end;
function TSubtileList.Add(Obj: TSubtile): TSubtile;
begin

  Result := TSubtile(inherited Add(Pointer(Obj)));
 
end;

procedure TSubtileList.Del(Idx: Integer);
begin
  TSubtile(Items[Idx]).Free;
  inherited;
end;
function TSubtileList.Exists(name:string):boolean;
var Index: Integer;
begin
  Index:=IndexOf(Name);
  IF Index <> -1 then
  begin
  result:=true;
  end else
  begin
  result:=false;
  end;
end;
function TSubtileList.Find(const Name: string): TSubtile;
var Index: Integer;
begin
  Index:=IndexOf(Name);
  IF Index <> -1 then
  begin
    result:=Items[Index]
  end ;
end;
function TSubtileList.GetContains(Name: String): Boolean;
begin
  Result:=IndexOf(Name) <> -1 ;
end;

procedure TSubtileList.Clear;
var
  i : Integer;
begin
 // for i := 0 to Count - 1 do
 // TSubtile(Items[i]).Free;
  inherited;
end;

destructor TSubtileList.Destroy();
begin
clear;
inherited;
end;



function TSubtileList.IndexOf(Item: TSubtile): Integer;
begin
  Result:=inherited IndexOf(Item);
end;

//------------------------------------------------------------------------------
function TSubtileList.IndexOf(const Name: String): Integer;
var x: Integer;
begin
  Result:=-1;
  For x:=0 to Count - 1 do
  IF Items[x].nomeDaProcura = Name then
   begin
    Result:=x;
    Exit;
  end;
end;

end.
