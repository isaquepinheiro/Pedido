object FormFindProduto: TFormFindProduto
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Pesquisar Produto'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object Grid_Cliente: TDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 618
    Height = 398
    Margins.Bottom = 40
    Align = alClient
    DataSource = Produto
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'pro_codigo'
        Title.Caption = 'C'#243'digo'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'pro_descricao'
        Title.Caption = 'Descri'#231#227'o'
        Width = 380
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'pro_preco_venda'
        Title.Alignment = taRightJustify
        Title.Caption = 'Pre'#231'o Venda'
        Width = 120
        Visible = True
      end>
  end
  object Button_Cancel: TButton
    Left = 516
    Top = 408
    Width = 100
    Height = 25
    Cancel = True
    Caption = 'Cancelar'
    ModalResult = 2
    TabOrder = 2
  end
  object Button_Close: TButton
    Left = 410
    Top = 408
    Width = 100
    Height = 25
    Caption = 'Selecionar'
    ModalResult = 1
    TabOrder = 1
  end
  object Produto: TDataSource
    AutoEdit = False
    Left = 282
    Top = 186
  end
end
