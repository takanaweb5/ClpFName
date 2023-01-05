object MainForm: TMainForm
  Left = 135
  Top = 187
  Caption = #12501#12449#12452#12523#21517#19968#35239
  ClientHeight = 241
  ClientWidth = 511
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  Icon.Data = {
    0000010001001010040000000000280100001600000028000000100000002000
    0000010004000000000080000000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    00000000000000000000000004EC0000000000004ECC000000000004ECC07888
    8880007FCC0078FFFF0EEE07000078FFF0EEEEE0000078F0F0ECCEE0000078FF
    F0EEEEE0000078F0FF0EEE08000078FFFFF000F8000078777778887800007844
    4F0F0F080000784444444448000078888888888800007777777777777000FFFC
    0000FFF80000FFF0000000010000000300000007000000070000000700000007
    000000070000000700000007000000070000000700000007000000070000}
  OldCreateOrder = False
  Visible = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  PixelsPerInch = 120
  TextHeight = 15
  object Memo: TMemo
    Left = 0
    Top = 22
    Width = 511
    Height = 198
    Align = alClient
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
    Font.Style = []
    Lines.Strings = (
      '1'
      '2'
      '3'
      '4'
      '5'
      '6'
      '7'
      '8'
      '9'
      '10'
      '11'
      '12'
      '13'
      '14'
      '15')
    ParentFont = False
    PopupMenu = PopupMenu
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
    OnChange = MemoChange
    OnKeyUp = MemoKeyUp
    OnMouseDown = MemoMouseDown
    OnMouseUp = MemoMouseUp
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 511
    Height = 22
    AutoSize = True
    Caption = 'ToolBar1'
    Font.Charset = SHIFTJIS_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #65325#65331' '#12468#12471#12483#12463
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object btnPath: TSpeedButton
      Left = 0
      Top = 0
      Width = 85
      Height = 22
      Hint = #12501#12449#12452#12523#12398#12501#12523#12497#12473#12434#34920#31034#12375#12414#12377
      AllowAllUp = True
      GroupIndex = 1
      Down = True
      Caption = #12497#12473#12398#34920#31034
      Font.Charset = SHIFTJIS_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #65325#65331' '#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Transparent = False
      OnClick = btnClick
    end
    object btnLink: TSpeedButton
      Left = 85
      Top = 0
      Width = 85
      Height = 22
      Hint = #12471#12519#12540#12488#12459#12483#12488#12501#12449#12452#12523#12398#22580#21512#12522#12531#12463#20808#12434#34920#31034#12375#12414#12377
      AllowAllUp = True
      GroupIndex = 2
      Down = True
      Caption = #12522#12531#12463#12398#34920#31034
      Font.Charset = SHIFTJIS_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #65325#65331' '#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Transparent = False
      OnClick = btnClick
    end
    object btnFolder: TSpeedButton
      Left = 170
      Top = 0
      Width = 85
      Height = 22
      Hint = #12501#12457#12523#12480#12398#12415#34920#31034#12375#12414#12377
      AllowAllUp = True
      GroupIndex = 3
      Caption = #12501#12457#12523#12480#12398#12415
      Font.Charset = SHIFTJIS_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #65325#65331' '#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Transparent = False
      OnClick = btnClick
    end
    object btnShort: TSpeedButton
      Left = 255
      Top = 0
      Width = 85
      Height = 22
      Hint = #12471#12519#12540#12488#12501#12449#12452#12523#21517#12391#34920#31034#12375#12414#12377
      AllowAllUp = True
      GroupIndex = 4
      Caption = #30701#12356#21517#21069
      Font.Charset = SHIFTJIS_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #65325#65331' '#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Transparent = False
      OnClick = btnClick
    end
    object btnCopy: TSpeedButton
      Left = 340
      Top = 0
      Width = 85
      Height = 22
      Hint = #12486#12461#12473#12488#12398#20869#23481#12434#12463#12522#12483#12503#12508#12540#12489#12395#12467#12500#12540#12375#12414#12377
      Caption = #12467#12500#12540
      Font.Charset = SHIFTJIS_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #65325#65331' '#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Transparent = False
      OnClick = btnCopyClick
    end
    object btnOpen: TSpeedButton
      Left = 425
      Top = 0
      Width = 85
      Height = 22
      Hint = #12459#12540#12477#12523#20301#32622#12398#12501#12449#12452#12523#12398#12501#12457#12523#12480#12434#38283#12365#12414#12377
      Caption = #12501#12457#12523#12480#12434#38283#12367
      Enabled = False
      Font.Charset = SHIFTJIS_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #65325#65331' '#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Transparent = False
      OnClick = btnOpenClick
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 220
    Width = 511
    Height = 21
    Panels = <
      item
        Width = 150
      end
      item
        Width = 50
      end>
  end
  object PopupMenu: TPopupMenu
    OnPopup = PopupMenuPopup
    Left = 152
    Top = 160
    object Paste1: TMenuItem
      Caption = #36028#12426#20184#12369'(&P)'
      ShortCut = 16470
      OnClick = Paste1Click
    end
    object Copy1: TMenuItem
      Caption = #12467#12500#12540'(&C)'
      ShortCut = 16451
      OnClick = Copy1Click
    end
    object SelectAll: TMenuItem
      Caption = #12377#12409#12390#36984#25246'(&A)'
      ShortCut = 16449
      OnClick = SelectAllClick
    end
    object OpenFolder: TMenuItem
      Caption = #12501#12457#12523#12480#12434#38283#12367'(&O)'
      OnClick = OpenFolderClick
    end
  end
end
