inherited FormRelatorio: TFormRelatorio
  Caption = 'PadraoVisualRelatorio'
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnlBotao: TPanel
    inherited BtnFechar: TBitBtn
      TabOrder = 3
    end
    inherited BtnConfigurar: TBitBtn
      Left = 205
      TabOrder = 2
      ExplicitLeft = 205
    end
    object BtnOk: TBitBtn
      AlignWithMargins = True
      Left = 119
      Top = 8
      Width = 80
      Height = 25
      Margins.Top = 8
      Margins.Bottom = 8
      Align = alRight
      Caption = '&Ok'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        04000000000068010000120B0000120B00001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      TabOrder = 0
      OnClick = BtnOkClick
    end
    object BtnAgendar: TBitBtn
      AlignWithMargins = True
      Left = 291
      Top = 8
      Width = 80
      Height = 25
      Margins.Top = 8
      Margins.Bottom = 8
      Align = alRight
      Caption = 'A&gendar'
      Enabled = False
      Glyph.Data = {
        36060000424D3606000000000000360000002800000020000000100000000100
        1800000000000006000000000000000000000000000000000000FFE6FFB1DACB
        6F7B9FBFBAE7FFE6FFFFE6FFFFE6FFFFE6FFFFE6FFFFE6FFFFE6FFFFE6FFBEA3
        AD978885D3F6DBFFE6FFFFE6FFEFEBEFBDBABDE7E3E7FFE6FFFFE6FFFFE6FFFF
        E6FFFFE6FFFFE6FFFFE6FFFFE6FFD6D3D6C6C3C6FFE6FFFFE6FFFFE6FFB3D0CD
        3A4D78152455A2B2C998AEB44E6B702E55630C4362477EA37CA4C18FA5BE625C
        734A454EFFE6FFFFE6FFFFE6FFE7EBE78C8E8C4A514ADEDFDED6DBD6A5A6A58C
        8E8C847984BDBABDD6D3D6D6D7D69C9E9C847D84FFE6FFFFE6FFFFE6FFFFE6FF
        6A8EC43D76B402467131789D357BA3549DCF4B9FE0065D9F00447A2971A1335B
        8BADBEDFFFE6FFFFE6FFFFE6FFFFE6FFC6CBC6B5B6B5847D84B5B2B5B5B6B5D6
        D3D6D6D3D69CA29C848684ADAEAD9C9E9CE7E3E7FFE6FFFFE6FFFFE6FFFFE6FF
        3D73A83B8CC56AC0EA79CAEF9DE0FF9EDFFF86CCFF84D1FF60BAF02C85B8002E
        6691B8E5FFE6FFFFE6FFFFE6FFFFE6FFB5B2B5C6C7C6E7E3E7E7E7E7EFF3EFEF
        F3EFEFEBEFEFEFEFDEE3DEC6C3C66B656BDEE3DEFFE6FFFFE6FFFFE6FFAEC9E4
        236E9483DDFF96DEEFBCEEFACAE0F2D3DCF0CFD7EEC5DBF493C6E073BDDF318A
        BC003663D7DAEFFFE6FFFFE6FFE7EBE7ADAAADEFF3EFEFEFEFF7FBF7EFF3EFEF
        F3EFEFEFEFEFF3EFE7E7E7DEE3DEC6C3C66B6D6BFFE6FFFFE6FFFFE6FF365F7F
        77CAE988DFF3C6FEFFB8D4CEF4F9F7E5DAD6DCCBC2EEE8E3D4EAEF9DD6EC4BA7
        DA004376909CB8FFE6FFFFE6FF9C9E9CE7E7E7EFF3EFFFFFFFE7EBE7FFFBFFEF
        EFEFE7E7E7F7F7F7F7F7F7EFEFEFD6D7D6847D84D6D3D6FFE6FF98C1EE4D84AB
        92E2FF95E0EED7FAF6D2E1D3AAB5A5F0F3DDFFFFDEDBD4B9CFD3CDBADCF370C4
        FE3685C4273A5FFFE6FFE7E7E7C6C3C6EFF3EFEFF3EFFFFBFFEFF3EFDEDBDEF7
        FBF7FFFBFFE7EBE7E7EBE7EFF3EFE7E7E7C6C3C6737173FFE6FF8DC6ED5292B4
        8AD8EFBAFAFFE5FCF8DFE7DC90A19372826BCDCEACEFE9CCF2ECE7AEC2DB8AD6
        FF4693D22B4668DFE1F3E7E7E7C6CBC6EFEFEFFFFBFFFFFFFFF7F3F7CECFCEB5
        B6B5E7E7E7F7F3F7F7F7F7E7E7E7EFEFEFCECBCE848684FFE6FF78BDCC569DAB
        8DDCE7C8FFFFDFF1F2FBFFFF8DA2A430464499A295F8F6EBD0C5CDDFEAFF81C4
        FD519CD02C4B5AE1EDE7DEDFDECECBCEEFEFEFFFFFFFF7FBF7FFFFFFD6D3D673
        7973CECFCEFFFBFFE7E7E7F7FBF7E7E7E7D6D3D6848684FFE6FF8FE0E7499FA5
        8CE6F1A2E9F3E6FFFFC6CBD48C99A9A4ADBABFBEC2E9E2E7E1D9EADBEEFF74BE
        F63A8AB94E7A81E4FEF1EFEFEFCECBCEEFF3EFF7F7F7FFFFFFE7EBE7CECBCED6
        DBD6DEE3DEF7F3F7EFF3EFF7FBF7E7E7E7C6C3C6B5B2B5FFE6FF5DBEC800626F
        61D4E985E5FCB6E5F39AA5B3CEC5DAFFF5FFFEE0F3F2DCEFDBDCF6B3DAFF65C0
        F700608E16545F9CCAC4DEDFDE949A94E7EBE7F7F3F7F7F7F7D6D3D6E7E7E7FF
        FBFFF7F7F7EFF3EFEFF3EFEFF3EFE7E7E79C9E9C8C8A8CE7E7E7237F9C004A6D
        098BBA5DD7FF81D3F2C5EDFFF3F5FFF9E8FFF3E0FFD8D7FFC1E4FF76BFF1228E
        CE00508A014465346378B5B6B5848684C6C3C6EFEFEFEFEBEFF7FBF7FFFBFFF7
        FBF7F7F7F7EFF3EFF7F7F7E7E3E7C6CBC6948E948479849CA29C4D91D463BFFF
        0991EB1DB1FF2EAFE878D7FFB1E1FFC1DBFFC6E2FF87BBFD5AB9F82CA5EB0683
        D82F96EC4077BC173673CECBCEE7E7E7CECBCEDEDFDEDEDBDEEFEFEFF7F3F7EF
        F3EFF7F7F7E7E7E7DEE3DED6D7D6C6C3C6D6D3D6BDBABD7371734B75B666ACF9
        1A98FE1AB3FF1CB1F430AAE07AC0FB91C2FF6DA7F953A9FD1A99E427B4FF43BD
        FF3F98E9365AA08995D5BDBABDDEDFDED6D3D6DEDFDEDEDBDED6DBD6E7E7E7E7
        E7E7DEDBDEDEDFDECED3CEDEDFDEE7E3E7D6D3D69CA29CD6D3D6B3C2DC709DC9
        3197E935BEFF33C5FF1895C8165F9D1149961559B82F8FED25A9F637BDFD4BAD
        E92C659859678BFFE6FFE7E7E7D6D3D6D6D3D6E7E3E7E7E7E7C6CBC6A5A2A58C
        8E8CA5A6A5CECFCED6DBD6DEE3DEDEDBDEA5AAA5A5AAA5FFE6FFFFE6FFACCDE7
        2B85CC006BBD007DB60074A7024C8C9CD7FF347EE40054B7007CCA007CB61065
        9785AFD2FFE6FFFFE6FFFFE6FFE7EBE7C6C3C6ADAEADBDBABDADAEAD8C8E8CFF
        E6FFC6C3C69C9E9CBDBEBDB5B6B5A5A6A5DEDBDEFFE6FFFFE6FF}
      NumGlyphs = 2
      TabOrder = 1
      Visible = False
      OnClick = BtnAgendarClick
    end
  end
end
