unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TForm2 = class(TForm)
    Shape_Head: TShape;
    Shape_Feed: TShape;
    b_count: TLabel;
    Label2: TLabel;
    Timer1: TTimer;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    MoveLength: integer;
    FKey: word;
    { Private declarations }
  public
    procedure newPos_Feed();
    procedure newBody_Snake();
    procedure moveBody();
    procedure checkGameOver();
    { Public declarations }
  end;

  TsnakeBody=class(TShape)
  public
  constructor Create(AOwner: TComponent); override;

  end;

var
  Form2: TForm2;
  list: Tlist;
implementation

{$R *.dfm}
uses math;
procedure TForm2.FormCreate(Sender: TObject);
var
   snakeHead_startPos:TPoint;
begin
   MoveLength := Shape_Head.Width;
   // Shape_Head.Width;
   Randomize;
   snakeHead_startPos.X:= RandomRange(0,Self.ClientWidth-2*MoveLength);
   snakeHead_startPos.Y:= RandomRange(0,Self.ClientHeight-2*MoveLength);
   snakeHead_startPos.X:= (snakeHead_startPos.X div MoveLength)*MoveLength;
   snakeHead_startPos.Y:= (snakeHead_startPos.Y div MoveLength)*MoveLength;

   Shape_Head.Top := snakeHead_startPos.Y;
   Shape_Head.Left := snakeHead_startPos.X;
   newPos_Feed();

   list:=Tlist.Create;
   Fkey := VK_RIGHT;
end;

constructor TsnakeBody.Create(AOwner: TComponent);
begin
  inherited;
  Self.Width:=20;
  Self.Height:=20;
  Self.Brush.Color:=clGreen;
  Self.Shape:=stCircle;

end;


procedure TForm2.FormDestroy(Sender: TObject);
var
  i: integer;
  b: TsnakeBody;
begin
      if Assigned(list) then
      begin
        for i := 0 to list.Count-1 do
        begin
           b:=TsnakeBody(list.Items[i]);
           FreeAndNil(b);
        end;

        list.Clear;
        FreeAndNil(list);
      end;

end;

procedure TForm2.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  movebody;
  case Key of
    VK_UP:
    begin
      if Fkey <> VK_DOWN then
      begin
        Shape_Head.Top:=Shape_Head.Top-MoveLength;
        Fkey:=Key;
        checkGameOver;
      end;
    end;
    VK_DOWN:
    begin
      if Fkey <> VK_UP then
      begin
         Shape_Head.Top:=Shape_Head.Top+MoveLength;
         Fkey:=Key;
      end;
    end;
    VK_RIGHT:
    begin
      if Fkey <> VK_LEFT then
      begin
         Shape_Head.Left:=Shape_Head.Left+MoveLength;
         Fkey:=Key;
      end;
    end;
    VK_LEFT:
    begin
      if Fkey <> VK_RIGHT then
      begin
         Shape_Head.Left:=Shape_Head.Left-MoveLength;
         Fkey:=Key;
      end;
    end;
  end;
  if (Shape_Head.Left = Shape_Feed.Left) and (Shape_Head.Top=Shape_Feed.Top) then
      begin
        newPos_Feed();
        newBody_Snake();
      end;

  if Shape_Head.Left >= self.ClientWidth then
    Shape_Head.Left:=0
  else if Shape_Head.Left < 0 then
    Shape_Head.Left:=((self.ClientWidth) div MoveLength)*MoveLength;

  if Shape_Head.Top >= self.ClientHeight then
    Shape_Head.Top:=0
  else if Shape_Head.Top<0 then
    Shape_Head.Top := ((self.ClientHeight)div MoveLength)*MoveLength;



end;


procedure Tform2.newPos_Feed;
var
   feed_startPos:TPoint;
begin
   feed_startPos.X:= RandomRange(0,Self.ClientWidth-2*MoveLength);
   feed_startPos.Y:= RandomRange(0,Self.ClientHeight-2*MoveLength);
   feed_startPos.X:= (feed_startPos.X div MoveLength)*MoveLength;
   feed_startPos.Y:= (feed_startPos.Y div MoveLength)*MoveLength;

   Shape_Feed.Top := feed_startPos.Y;
   Shape_Feed.Left := feed_startPos.X;
end;



procedure Tform2.newBody_Snake;
var
  b,last_b:TsnakeBody;
begin
  b:=TsnakeBody.Create(self);
  b.Parent:=self;
  if list.Count>0 then
  begin
    last_b:=TsnakeBody(list.Items[list.Count-1]);
    b.Left:=last_b.Left;
    b.Top:=last_b.Top;
    last_b:=nil;
  end
  else
  begin
    b.Left:=Shape_Head.Left;
    b.Top:=Shape_Head.Top;
  end;
  list.Add(b);
  b:=nil;
  b_count.Caption:=IntToStr(list.Count);
end;


procedure Tform2.moveBody;
var
  i: integer;
  bottomBody,topBody:TsnakeBody;
begin
  for i := list.Count-1 downto 1 do
  begin
    bottomBody:=TsnakeBody(list.Items[i-1]);
    topBody:=TsnakeBody(list.Items[i]);
    topBody.Left:= bottombody.Left;
    topBody.Top:= bottomBody.Top;
  end;
  if list.Count>0 then
    begin
      bottomBody:=TsnakeBody(list.Items[0]);
      bottomBody.Left:=Shape_Head.Left;
      bottomBody.Top:=Shape_Head.Top;
    end;
  bottombody:=nil;
  topBody:=nil;
end;

procedure TForm2.Timer1Timer(Sender: TObject);
begin
  FormKeyDown(self,FKey,[]);
end;

procedure TForm2.checkGameOver;
begin
  Timer1.Enabled:=False;
end;

end.
