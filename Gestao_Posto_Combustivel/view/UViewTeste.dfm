object FrmTeste: TFrmTeste
  Left = 0
  Top = 0
  Caption = 'FrmTeste'
  ClientHeight = 484
  ClientWidth = 835
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  inline FrameBaseCadastro1: TFrameBaseCadastro
    Left = 0
    Top = 0
    Width = 835
    Height = 480
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    ExplicitWidth = 839
    inherited pnlBotoes: TPanel
      Width = 835
      inherited btnIncluir: TSpeedButton
        Left = 423
        ExplicitLeft = 423
      end
      inherited btnGravar: TSpeedButton
        Left = 586
        ExplicitLeft = 586
      end
      inherited btnAlterar: TSpeedButton
        Left = 504
        ExplicitLeft = 504
      end
      inherited btnExcluir: TSpeedButton
        Left = 668
        ExplicitLeft = 668
      end
      inherited btnSair: TSpeedButton
        Left = 750
        ExplicitLeft = 750
      end
    end
    inherited DBGrid: TDBGrid
      Width = 835
    end
    inherited pnlEdicao: TPanel
      Width = 835
      ExplicitTop = 365
      ExplicitWidth = 640
    end
  end
end
