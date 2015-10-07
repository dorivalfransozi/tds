inherited FormCadastroMarca: TFormCadastroMarca
  Caption = 'FormCadastroMarca'
  ClientHeight = 374
  ClientWidth = 682
  ExplicitWidth = 698
  ExplicitHeight = 412
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnlArea: TPanel
    Width = 676
    Height = 327
    ExplicitWidth = 676
    ExplicitHeight = 327
  end
  inherited PnlBotao: TPanel
    Top = 333
    Width = 682
    ExplicitTop = 333
    ExplicitWidth = 682
    inherited BtnFechar: TBitBtn
      Left = 599
      ExplicitLeft = 599
    end
    inherited BtnConfigurar: TBitBtn
      Left = 417
      ExplicitLeft = 417
    end
    inherited BtnSalvar: TBitBtn
      Left = 245
      OnClick = BtnSalvarClick
      ExplicitLeft = 245
    end
    inherited BtnExcluir: TBitBtn
      Left = 331
      OnClick = BtnExcluirClick
      ExplicitLeft = 331
    end
    inherited BtnRelatorio: TBitBtn
      Left = 503
      ExplicitLeft = 503
    end
    inherited BtnEfetivar: TBitBtn
      Left = 159
      ExplicitLeft = 159
    end
    inherited BtnEditar: TBitBtn
      Left = 73
      ExplicitLeft = 73
    end
  end
end
