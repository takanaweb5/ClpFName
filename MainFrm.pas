unit MainFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Clipbrd, ShlObj, ShellAPI, ActiveX, ComObj, ExtCtrls,
  Menus, Buttons, ToolWin, ImgList, Shell32_TLB;

type
  TMainForm = class(TForm)
    ToolBar1: TToolBar;
    btnFolder: TSpeedButton;
    btnOpen: TSpeedButton;
    btnPath: TSpeedButton;
    btnShort: TSpeedButton;
    btnCopy: TSpeedButton;
    Memo: TMemo;
    PopupMenu: TPopupMenu;
    Paste1: TMenuItem;
    Copy1: TMenuItem;
    OpenFolder: TMenuItem;
    SelectAll: TMenuItem;
    btnLink: TSpeedButton;
    StatusBar: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnClick(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure PopupMenuPopup(Sender: TObject);
    procedure Paste1Click(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure SelectAllClick(Sender: TObject);
    procedure OpenFolderClick(Sender: TObject);
    procedure MemoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MemoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MemoMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MemoChange(Sender: TObject);
  private
    FileList: TStringList;
    procedure WMDropFiles(var Msg: TWMDropFiles); message WM_DROPFILES;
    procedure SetFileList(Drop: THANDLE);
    procedure SetMemo;
    function GetLinkPath(FileName: String): string;
    function GetDisplayFileName(strFileName: string): string;
    function GetFolderName(): string;
    procedure ChangeCursorPos;
    procedure ChangeSelection;
  protected
  public
    { Public 宣言 }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}


//*****************************************************************************
//[イベント]　FormCreate
//[ 概  要 ]　フォーム作成時
//[ 引  数 ]　TObject
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.FormCreate(Sender: TObject);
//  procedure ChangeCheckStyle(Handle: HWnd);
//  begin
//    SetWindowLong(Handle, GWL_STYLE, GetWindowLong(Handle, GWL_STYLE) or BS_PUSHLIKE);
//  SetWindowLong(Edit1.Handle, GWL_STYLE, GetWindowLong(Edit1.Handle, GWL_STYLE) or ES_RIGHT);
//  end;
var
  j: integer;
  FileName: TFileName;
begin
  FileList := TStringList.Create;

  //ファイルのドラッグを受付ける
  DragAcceptFiles(Handle,True);

  //起動時のパラメータ（ファイル名）をリストに格納する
  for j:=1 to ParamCount do begin
    FileName := ParamStr(j);
    FileList.Add(FileName);
  end;
  SetMemo();
end;

//*****************************************************************************
//[イベント]　FormDestroy
//[ 概  要 ]　フォーム破棄時
//[ 引  数 ]　TObject
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FileList.Free;
end;

//*****************************************************************************
//[イベント]　FormResize
//[ 概  要 ]　フォームのサイズの変更時にボタンの幅を自動調整
//[ 引  数 ]　TObject
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.FormResize(Sender: TObject);
begin
  btnPath.Width   := ToolBar1.Width div 6;
  btnLink.Width   := ToolBar1.Width div 6;
  btnFolder.Width := ToolBar1.Width div 6;
  btnShort.Width  := ToolBar1.Width div 6;
  btnCopy.Width   := ToolBar1.Width div 6;
  btnOpen.Width   := ToolBar1.Width - (ToolBar1.Width div 6) * 5;
end;

//*****************************************************************************
//[イベント]　btnClick
//[ 概  要 ]　「ファイル名」「パスの表示」「リンクの表示」「短い名前」ボタン押下時
//[ 引  数 ]　TObject
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.btnClick(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  SetMemo();
  Screen.Cursor := crDefault;

  btnOpen.Enabled := (GetFolderName() <> '');
end;

//*****************************************************************************
//[イベント]　btnCopyClick
//[ 概  要 ]　「コピー」ボタン押下時
//[ 引  数 ]　TObject
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.btnCopyClick(Sender: TObject);
begin
  //Memoの文字列が選択されているか？
  if Memo.SelLength > 0 then begin
    Memo.CopyToClipboard;
  end
  else begin
    Memo.SelectAll;
    Memo.CopyToClipboard;
  end;
end;

//*****************************************************************************
//[イベント]　btnOpenClick
//[ 概  要 ]　「フォルダを開く」ボタン押下時
//[ 引  数 ]　TObject
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.btnOpenClick(Sender: TObject);
var
  strFolderName: string;
begin
  strFolderName := Memo.SelText;
  if not DirectoryExists(strFolderName) then
  begin
    strFolderName := GetFolderName();
  end;

  if DirectoryExists(strFolderName) then
  begin
    ShellExecute(Handle,nil,PChar(strFolderName),nil,nil,SW_NORMAL);
  end;
end;

//*****************************************************************************
//[イベント]　PopupMenuPopup
//[ 概  要 ]　右クリックメニュー表示時
//[ 引  数 ]　TObject
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.PopupMenuPopup(Sender: TObject);
begin
  //クリップボードにExplorerからのコピー形式があれば
  Paste1.Enabled := (Clipboard.HasFormat(CF_HDROP));

  Copy1.Enabled      := btnCopy.Enabled;
  OpenFolder.Enabled := btnOpen.Enabled;
end;

//*****************************************************************************
//[イベント]　Paste1Click
//[ 概  要 ]　「貼り付け」メニュー選択時
//[ 引  数 ]　TObject
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.Paste1Click(Sender: TObject);
var
  Drop: THandle;
begin
  Drop := 0;
  Screen.Cursor := crHourGlass;
  //クリップボードにExplorerからのコピー形式があれば
  if Clipboard.HasFormat(CF_HDROP) then begin
    Clipboard.Open;
    try
      Drop := GetClipboardData(CF_HDROP);
      SetFileList(Drop);
      ClipBoard.Clear;
    finally
      if Drop <> 0 then GlobalUnlock(Drop);
      Clipboard.Close;
    end;
    SetMemo();
  end;
  Screen.Cursor := crDefault;
end;

//*****************************************************************************
//[イベント]　Copy1Click
//[ 概  要 ]　「コピー」メニュー選択時
//[ 引  数 ]　TObject
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.Copy1Click(Sender: TObject);
begin
  btnCopyClick(self);
end;

//*****************************************************************************
//[イベント]　SelectAllClick
//[ 概  要 ]　「すべて選択」メニュー選択時
//[ 引  数 ]　TObject
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.SelectAllClick(Sender: TObject);
begin
  Memo.SelectAll;
end;

//*****************************************************************************
//[イベント]　OpenFolderClick
//[ 概  要 ]　「フォルダを開く」メニュー選択時
//[ 引  数 ]　TObject
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.OpenFolderClick(Sender: TObject);
begin
  btnOpenClick(self);
end;

//*****************************************************************************
//[イベント]　MemoChange
//[ 概  要 ]　対象が1ファイル(フォルダ)の時、｢フォルダを開く｣ボタンを有効にする
//[ 引  数 ]　TObject
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.MemoChange(Sender: TObject);
begin
  StatusBar.Panels[1].Text := '';
  btnOpen.Enabled := (GetFolderName() <> '');

  if Memo.Lines.Count = 1 then
  begin
    StatusBar.Panels[1].Text := Memo.Lines[0];
  end;
end;

//*****************************************************************************
//[イベント]　MemoKeyUp
//[ 概  要 ]　Memoでカーソル位置を変更した時
//[ 引  数 ]　TObject
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.MemoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  ChangeCursorPos();
  ChangeSelection();
end;

//*****************************************************************************
//[イベント]　MemoMouseDown
//[ 概  要 ]　Memoでカーソル位置を変更した時
//[ 引  数 ]　TObject
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.MemoMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ChangeCursorPos();
  ChangeSelection();
end;

//*****************************************************************************
//[イベント]　MemoMouseUp
//[ 概  要 ]　Memoでカーソル位置を変更した時
//[ 引  数 ]　TObject
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.MemoMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ChangeCursorPos();
  ChangeSelection();
end;

//*****************************************************************************
//[イベント]　ChangeCursorPos
//[ 概  要 ]　Memoでカーソル位置を変更した時
//[ 引  数 ]　TObject
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.ChangeCursorPos();
var
  p: TPoint;
begin
  if FileList.Count = 0 then
  begin
    Exit;
  end;

//  Y := SendMessage(Memo.Handle, EM_LINEFROMCHAR, -1, 0);

  p := Memo.CaretPos;
  if p.Y >= Memo.Lines.Count  then
  begin
    Exit;
  end;

  //ステータスバーに選択中の行のファイルを表示
  StatusBar.Panels[1].Text := GetDisplayFileName(FileList[p.Y]);
end;


//*****************************************************************************
//[イベント]　ChangeSelection
//[ 概  要 ]　Memoで選択範囲を変更した時
//[ 引  数 ]　TObject
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.ChangeSelection();
begin
  if FileList.Count = 0 then
  begin
    Exit;
  end;

  if GetFolderName() = '' then
  begin
    btnOpen.Enabled := DirectoryExists(Memo.SelText);
  end;
end;

//*****************************************************************************
//[イベント]　WMDropFiles
//[ 概  要 ]　ExplorerからDropされた時
//[ 引  数 ]　Msg
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.WMDropFiles(var Msg: TWMDropFiles);
begin
  Screen.Cursor := crHourGlass;
  SetFileList(Msg.Drop);
  DragFinish(Msg.Drop);
  SetMemo();
  Screen.Cursor := crDefault;
end;

//*****************************************************************************
//[ 関　数 ]　SetMemo
//[ 概  要 ]　ファイルリストから｢パスの表示｣｢リンクの表示｣の状態に応じて
//            Memoに一覧を設定する
//[ 引  数 ]　なし
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.SetMemo();
var
  i: integer;
begin
  Memo.Lines.BeginUpdate;
  Memo.Lines.Clear;

  //ファイルの数だけループ
  for i:=0 to FileList.Count - 1 do begin
    Memo.Lines.Add(GetDisplayFileName(FileList[i]));
  end;

  StatusBar.Panels[0].Text := Format(' %d %s',[FileList.Count,'個のファイル']);

  Memo.Lines.EndUpdate;
end;

//*****************************************************************************
//[ 関　数 ]　GetDisplayFileName
//[ 概  要 ]　｢パスの表示｣｢リンクの表示｣の状態に応じて表示するファイル名を取得
//[ 引  数 ]　元のファイル名
//[ 戻り値 ]　表示するファイル名
//*****************************************************************************
function TMainForm.GetDisplayFileName(strFileName: string): string;
var
  strFileExtaa: string;    //拡張子
begin
  //拡張子を小文字で取得
  strFileExtaa := LowerCase(ExtractFileExt(strFileName));

  //「リンクの表示」選択時
  if btnLink.Down = true then
  begin
    strFileName := GetLinkPath(strFileName);

    //拡張子の判定
    if strFileExtaa = '.url' then begin
      result := strFileName;
      Exit;
    end;
  end;

  //「短いファイル名」選択時
  if btnShort.Down = True then begin
    if ExtractShortPathName(strFileName) <> '' then
    begin
      strFileName := ExtractShortPathName(strFileName);
    end;
  end;

  //「フォルダ名のみ」非選択時
  if btnFolder.Down = True then begin
    if ExtractFileDir(strFileName) <> '' then
    begin
      strFileName := ExtractFileDir(strFileName);
    end;
  end;

  //「パスの表示」非選択時
  if btnPath.Down = false then begin
    if ExtractFileName(strFileName) <> '' then
    begin
      strFileName := ExtractFileName(strFileName);
      if btnFolder.Down = true then
      begin
        strFileName := strFileName + '\';
      end;
    end;
  end;

  result := strFileName;
end;

//*****************************************************************************
//[ 関　数 ]　GetFolderName
//[ 概  要 ]　「フォルダを開く」で対象となるフォルダを取得する
//[ 引  数 ]　なし
//[ 戻り値 ]　フォルダ名
//*****************************************************************************
function TMainForm.GetFolderName(): string;
var
  strFileName: string;
begin
  if FileList.Count = 0 then
  begin
    Exit;
  end;

  if (btnLink.Down = True) and (FileList.Count > 1) then
  begin
    Exit;
  end;

  strFileName := FileList[0];

  if btnLink.Down = True then
  begin
    strFileName := GetLinkPath(strFileName);
  end;

  Result := ExtractFileDir(strFileName);

  //フォルダが実際に存在するかどうか？
  if DirectoryExists(Result) = False then
  begin
    Result := '';
  end;
end;

//*****************************************************************************
//[ 関　数 ]　SetFileList
//[ 概  要 ]　ExplorerからのDrop または クリップボードから貼り付けられた時
//            そのハンドルからファイル名の一覧を取得する
//[ 引  数 ]　ハンドル
//[ 戻り値 ]　なし
//*****************************************************************************
procedure TMainForm.SetFileList(Drop: THANDLE);
var
  szFileName: array[0..MAX_PATH + 1] of Char;
  i: integer;
  iCount: integer;
begin
  FileList.Clear;
  iCount := DragQueryFile(Drop,Cardinal(-1), nil, 0);
  for i:=0 to iCount - 1 do begin
    DragQueryFile(Drop, i, szFileName, MAX_PATH + 1);
    FileList.Add(szFileName);
  end;
end;

//*****************************************************************************
//[ 関　数 ]　GetLinkPath
//[ 概  要 ]　ショートカットファイルならリンク先を取得する
//[ 引  数 ]　ファイル名
//[ 戻り値 ]　ショートカットファイルならリンク先 or URL
//            以外なら元のファイル名
//*****************************************************************************
function TMainForm.GetLinkPath(FileName: String): String;
var
  objShell: Shell;
  FItem: FolderItem;
begin
  try
    objShell := CreateOleObject('Shell.Application') as Shell;
    FItem := objShell.NameSpace(0).ParseName(FileName);

    //ショートカットファイル(*.lnk,*.pif,*.url)ならTrue
    if FItem.IsLink then
      Result := (FItem.GetLink as ShellLinkObject).Path
    else
      Result := FileName;

    if Result = '' then
      Result := FileName;

  except on E: Exception do
    Result := FileName;
  end;

//  VarClear(FItem);
//  VarClear(Shell);
//=============================================================================
//  IShellLinkを使用するにusesにShlObjが必要
//  IPersistFileを使用するにはusesにActiveXが必要
//  CreateComObjectを使用するにはusesにComObjが必要
//=============================================================================
///////////////////////////////////////////////////////////////////////
//var
//     ShellLink   : IShellLink;
//     PersistFile : IPersistFile;
//     FilePath    : array[0..MAX_PATH] of char;
//     WorkDir     : array[0..MAX_PATH] of char ;
//     Arg         : array[0..MAX_PATH] of char;
//     FileLink    : String;
//     wsz         : array[0..MAX_PATH] of WideChar;
//     pfd         : TWin32FindData;
//begin
//     FileLink := FileName;
//     ShellLink := CreateComObject(CLSID_ShellLink) as IShellLink;
//     OleCheck(ShellLink.QueryInterface(IPersistFile,PersistFile));

//    Assert(Assigned(PersistFile));
//     MultiByteToWideChar(CP_ACP,0,PChar(FileLink),-1,wsz,MAX_PATH);
//     OleCheck(PersistFile.Load(wsz,0));
//     OleCheck(ShellLink.GetPath(FilePath,MAX_PATH,pfd,SLGP_RAWPATH));
//     OleCheck(ShellLink.GetWorkingDirectory(WorkDir,MAX_PATH));
//     OleCheck(ShellLink.GetArguments(Arg, MAX_PATH));
//     result := FilePath;
///////////////////////////////////////////////////////////////////////
end;

//*****************************************************************************
//[ 関　数 ]　GetLongFileName
//[ 概  要 ]　ロングファイル名を取得する
//[ 引  数 ]　ファイル名
//[ 戻り値 ]　ロングファイル名
//*****************************************************************************
//function GetLongFileName(AFileName: TFileName): TFileName;
//var
//  SHFileInfo: TSHFileInfo;
//begin
//  SHGetFileInfo(PChar(AFileName),
//                0,
//                SHFileInfo,
//                Sizeof(TSHFileInfo),
//                SHGFI_DISPLAYNAME);
//  Result := SHFileInfo.szDisplayName;
//end;
end.


