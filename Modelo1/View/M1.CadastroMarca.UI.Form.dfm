inherited FormCadastroMarca: TFormCadastroMarca
  Caption = 'FormCadastroMarca'
  ClientHeight = 200
  ClientWidth = 528
  ExplicitWidth = 544
  ExplicitHeight = 238
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnlArea: TPanel
    Width = 522
    Height = 153
    ExplicitWidth = 522
    ExplicitHeight = 153
    object EdtDescrReduz: TEditText
      Left = 122
      Top = 81
      Width = 104
      Height = 21
      CharCase = ecUpperCase
      Enabled = True
      MaxLength = 10
      TabOrder = 2
      BtnConsult = False
      BtnRegist = False
      Caption = 'Descri'#231#227'o reduzida:'
    end
    object EdtDescricao: TEditText
      Left = 122
      Top = 52
      Width = 264
      Height = 21
      CharCase = ecUpperCase
      Enabled = True
      MaxLength = 30
      TabOrder = 1
      BtnConsult = False
      BtnRegist = False
      Caption = 'Descri'#231#227'o:'
    end
    object EdtCodigo: TEditNum
      Left = 122
      Top = 25
      Width = 54
      Height = 21
      Alignment = enaLeftJustify
      CharCase = ecUpperCase
      Enabled = True
      MaxLength = 4
      TabOrder = 0
      Text = ' '
      BtnConsult = True
      BtnRegist = False
      Caption = ' &1 - C'#243'digo:'
      Decimals = 0
      ValMax = 99999999.000000000000000000
    end
  end
  inherited PnlBotao: TPanel
    Top = 159
    Width = 528
    ExplicitTop = 159
    ExplicitWidth = 528
    inherited BtnFechar: TBitBtn
      Left = 445
      ExplicitLeft = 445
    end
    inherited BtnConfigurar: TBitBtn
      Left = 263
      ExplicitLeft = 263
    end
    inherited BtnSalvar: TBitBtn
      Left = 91
      Enabled = True
      ExplicitLeft = 91
    end
    inherited BtnExcluir: TBitBtn
      Left = 177
      ExplicitLeft = 177
    end
    inherited BtnRelatorio: TBitBtn
      Left = 349
      ExplicitLeft = 349
    end
    inherited BtnEfetivar: TBitBtn
      Left = 5
      Visible = True
      ExplicitLeft = 5
    end
    inherited BtnEditar: TBitBtn
      Left = -81
      ExplicitLeft = -81
    end
  end
end
