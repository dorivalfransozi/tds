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
    ExplicitWidth = 618
    ExplicitHeight = 153
    object Edt_Codigo: TLabeledEdit
      Left = 16
      Top = 24
      Width = 64
      Height = 21
      EditLabel.Width = 37
      EditLabel.Height = 13
      EditLabel.Caption = 'C'#243'digo:'
      TabOrder = 0
      OnChange = ControlChange
    end
    object Edt_Descricao: TLabeledEdit
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
    object Edt_DescricaoReduzida: TLabeledEdit
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
  end
  inherited PnlBotao: TPanel
    Top = 159
    Width = 624
    ExplicitTop = 159
    ExplicitWidth = 624
    inherited BtnFechar: TBitBtn
      Left = 541
      ExplicitLeft = 541
    end
    inherited BtnConfigurar: TBitBtn
      Left = 359
      ExplicitLeft = 359
    end
    inherited BtnSalvar: TBitBtn
      Left = 187
      Enabled = True
      ExplicitLeft = 187
    end
    inherited BtnExcluir: TBitBtn
      Left = 273
      ExplicitLeft = 273
    end
    inherited BtnRelatorio: TBitBtn
      Left = 445
      ExplicitLeft = 445
    end
    inherited BtnEfetivar: TBitBtn
      Left = 101
      Visible = True
      ExplicitLeft = 101
    end
    inherited BtnEditar: TBitBtn
      Left = 15
      ExplicitLeft = 15
    end
  end
end
