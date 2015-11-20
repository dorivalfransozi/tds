inherited FormCadastroEstado: TFormCadastroEstado
  Caption = 'FormCadastroEstado'
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnlArea: TPanel
    object Edt_Codigo: TLabeledEdit
      Left = 56
      Top = 32
      Width = 121
      Height = 21
      EditLabel.Width = 55
      EditLabel.Height = 13
      EditLabel.Caption = 'Edt_Codigo'
      TabOrder = 0
    end
    object Edt_Descricao: TLabeledEdit
      Left = 56
      Top = 88
      Width = 121
      Height = 21
      EditLabel.Width = 61
      EditLabel.Height = 13
      EditLabel.Caption = 'LabeledEdit1'
      TabOrder = 1
    end
  end
  inherited PnlBotao: TPanel
    inherited BtnSalvar: TBitBtn
      Enabled = True
    end
    inherited BtnExcluir: TBitBtn
      Enabled = True
    end
  end
end
