object FrmMain: TFrmMain
  Left = 0
  Top = 0
  Caption = 'Projeto Gest'#227'o de Posto de Combust'#237'vel'
  ClientHeight = 523
  ClientWidth = 930
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MainMenu1
  Position = poScreenCenter
  DesignSize = (
    930
    523)
  TextHeight = 15
  object Label1: TLabel
    Left = 457
    Top = 320
    Width = 410
    Height = 142
    Anchors = [akRight, akBottom]
    Caption = 'Gest'#227'o de Posto de Combust'#237'vel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -53
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
    WordWrap = True
  end
  object MainMenu1: TMainMenu
    Left = 296
    Top = 216
    object Cadastr1: TMenuItem
      Caption = '&Cadastros'
      object Abastecimento3: TMenuItem
        Caption = '&Abastecimento'
        OnClick = Abastecimento3Click
      end
      object BombadeCombustvel1: TMenuItem
        Caption = '&Bomba de Combust'#237'vel'
        OnClick = BombadeCombustvel1Click
      end
      object Imposto1: TMenuItem
        Caption = 'Imposto'
        OnClick = Imposto1Click
      end
      object anquedeCombustvel1: TMenuItem
        Caption = '&Tanque de Combust'#237'vel'
        OnClick = anquedeCombustvel1Click
      end
      object ipodeCombustvel1: TMenuItem
        Caption = 'Tipo de Combust'#237'vel'
        OnClick = ipodeCombustvel1Click
      end
    end
    object Abastecimento2: TMenuItem
      Caption = '&Relat'#243'rios'
      object AbastecimentoporDiaTanqueBomba1: TMenuItem
        Caption = 'Abastecimento por Dia / Tanque / Bomba'
        OnClick = AbastecimentoporDiaTanqueBomba1Click
      end
    end
    object Sair1: TMenuItem
      Caption = '&Sair'
      OnClick = Sair1Click
    end
  end
end
