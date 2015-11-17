inherited FormCadastroMarca: TFormCadastroMarca
  Caption = 'FormCadastroMarca'
  ClientHeight = 200
  ClientWidth = 624
  ExplicitWidth = 640
  ExplicitHeight = 238
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnlArea: TPanel
    Width = 618
    Height = 153
    ExplicitWidth = 522
    ExplicitHeight = 153
    object EdtDescricao: TLabeledEdit
      Left = 16
      Top = 65
      Width = 297
      Height = 21
      EditLabel.Width = 50
      EditLabel.Height = 13
      EditLabel.Caption = 'Descri'#231#227'o:'
      TabOrder = 1
      OnChange = ControlChange
    end
    object EdtDescricaoReduzida: TLabeledEdit
      Left = 16
      Top = 112
      Width = 297
      Height = 21
      EditLabel.Width = 94
      EditLabel.Height = 13
      EditLabel.Caption = 'Descri'#231#227'o reduzida:'
      TabOrder = 2
      OnChange = ControlChange
    end
    object EdtCodigo: TEditNum
      Left = 16
      Top = 24
      Width = 113
      Height = 21
      Alignment = enaLeftJustify
      CharCase = ecUpperCase
      Enabled = True
      TabOrder = 0
      Text = ' '
      BtnConsult = True
      BtnRegist = False
      Caption = 'C'#243'digo:'
      LabelPosition = lpAbove
      Decimals = 0
      ValMax = 99999999.000000000000000000
      OnChange = ControlChange
    end
  end
  inherited PnlBotao: TPanel
    Top = 159
    Width = 624
    ExplicitTop = 159
    ExplicitWidth = 528
    inherited BtnFechar: TBitBtn
      Left = 541
      ExplicitLeft = 445
    end
    inherited BtnConfigurar: TBitBtn
      Left = 359
      ExplicitLeft = 263
    end
    inherited BtnSalvar: TBitBtn
      Left = 187
      Enabled = True
      ExplicitLeft = 91
    end
    inherited BtnExcluir: TBitBtn
      Left = 273
      ExplicitLeft = 177
    end
    inherited BtnRelatorio: TBitBtn
      Left = 445
      ExplicitLeft = 349
    end
    inherited BtnEfetivar: TBitBtn
      Left = 101
      Visible = True
      ExplicitLeft = 5
    end
    inherited BtnEditar: TBitBtn
      Left = 15
      ExplicitLeft = -81
    end
  end
end
