object Form2: TForm2
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Form2'
  ClientHeight = 510
  ClientWidth = 810
  Color = clBackground
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Shape_Head: TShape
    Left = 264
    Top = 112
    Width = 20
    Height = 20
    Brush.Color = clLime
    Shape = stCircle
  end
  object Shape_Feed: TShape
    Left = 440
    Top = 232
    Width = 20
    Height = 20
    Brush.Color = clRed
    Shape = stCircle
  end
  object b_count: TLabel
    Left = 779
    Top = 9
    Width = 10
    Height = 22
    Caption = '0'
    Color = clRed
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clRed
    Font.Height = -19
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object Label2: TLabel
    Left = 728
    Top = 8
    Width = 44
    Height = 22
    Caption = 'score'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clRed
    Font.Height = -19
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 648
    Top = 128
  end
end
