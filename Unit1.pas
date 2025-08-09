unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ShellAPI, XPMan, ComCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    StatusBar1: TStatusBar;
    Image1: TImage;
    CheckBox1: TCheckBox;
    Label3: TLabel;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    GroupBox16: TGroupBox;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    CheckBox8: TCheckBox;
    Edit2: TEdit;
    GroupBox15: TGroupBox;
    Label17: TLabel;
    Label18: TLabel;
    CheckBox9: TCheckBox;
    ScrollBar2: TScrollBar;
    ScrollBar1: TScrollBar;
    Label4: TLabel;
    CheckBox10: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CheckBox8Click(Sender: TObject);
    procedure CheckBox9Click(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure ScrollBar2Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  app: String;

implementation

{$R *.dfm}
function Get_File_Size4(const S: string): Int64;
var
  FD: TWin32FindData;
  FH: THandle;
begin
  FH := FindFirstFile(PChar(S), FD);
  if FH = INVALID_HANDLE_VALUE then Result := 0
  else
    try
      Result := FD.nFileSizeHigh;
      Result := Result shl 32;
      Result := Result + FD.nFileSizeLow;
    finally
      //CloseHandle(FH);
    end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  If OpenDialog1.Execute then
    begin
      Edit1.Text := OpenDialog1.FileName;
      Button2.Enabled := True;
      Label3.Caption := '';
    end;
   StatusBar1.Panels[1].Text := IntToStr( Get_File_Size4(OpenDialog1.FileName) div 1000) + ' Kb';
end;

procedure TForm1.Button2Click(Sender: TObject);
var p : string;
begin
  Label3.Caption := '';

  if CheckBox1.Checked = true then Label3.Caption := Label3.Caption + ' -f';
  if CheckBox2.Checked = true then Label3.Caption := Label3.Caption + ' -brute';
  if CheckBox3.Checked = true then Label3.Caption := Label3.Caption + ' -pdt';
  if CheckBox4.Checked = true then Label3.Caption := Label3.Caption + ' -rai';
  if CheckBox5.Checked = true then Label3.Caption := Label3.Caption + ' -srt';
  if CheckBox6.Checked = true then Label3.Caption := Label3.Caption + ' -set';
  if CheckBox7.Checked = true then Label3.Caption := Label3.Caption + ' -red';
  if CheckBox8.Checked = true then Label3.Caption := Label3.Caption + ' -rlc ' + Edit2.Text;
  if CheckBox9.Checked = true then
  Label3.Caption := Label3.Caption + ' -c' + IntToStr(ScrollBar1.Position) +
                ' -f' + IntToStr(ScrollBar2.Position);

  app := ExtractFilePath(Application.ExeName)+'uPack\uPack.exe';

  try
    if CheckBox10.Checked = true then begin
    ShellExecute(Handle, 'open', PChar(app),
               PChar(' ' + Edit1.Text + Label3.Caption), nil, SW_SHOWNORMAL);
    end else begin
    ShellExecute(Handle, 'open', PChar(app),
               PChar(' ' + Edit1.Text + Label3.Caption), nil, SW_HIDE);
    end;
  finally
  end;
  Sleep(2000);

  StatusBar1.Panels[3].Text := IntToStr( Get_File_Size4(Edit1.Text) div 1000) + ' Kb'
end;

procedure TForm1.CheckBox8Click(Sender: TObject);
begin
  if CheckBox8.Checked = true then begin
  Label19.Enabled := true; Label20.Enabled := true;
  Label21.Enabled := true; Edit2.Enabled := true;
  end else begin
  Label19.Enabled := false; Label20.Enabled := false;
  Label21.Enabled := false; Edit2.Enabled := false;
  end;
end;

procedure TForm1.CheckBox9Click(Sender: TObject);
begin
  if CheckBox9.Checked = true then begin
  Label17.Enabled := true; Label18.Enabled := true;
  ScrollBar1.Enabled := true; ScrollBar2.Enabled := true;
  end else begin
  Label17.Enabled := false; Label18.Enabled := false;
  ScrollBar1.Enabled := false; ScrollBar2.Enabled := false;
  end;
end;

procedure TForm1.FormShow(Sender: TObject);
begin

  CheckBox9.OnClick(sender);
end;

procedure TForm1.ScrollBar1Change(Sender: TObject);
begin
  Label17.Caption := 'Level : ' + IntToStr(ScrollBar1.Position);
end;

procedure TForm1.ScrollBar2Change(Sender: TObject);
begin
  Label18.Caption := 'Force Bytes : ' + IntToStr(ScrollBar2.Position);
end;

end.
