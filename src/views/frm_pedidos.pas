unit frm_pedidos;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Mask,
  Vcl.DBCtrls,
  Vcl.DBCGrids,
  System.ImageList,
  Vcl.ImgList,
  Vcl.Buttons,
  Data.DB,
  frm_base,
  view.pedidos, Vcl.DBActns, System.Actions, Vcl.ActnList;

type
  TFrmPedidos = class(TFrmBase)
    Grid_Produtos: TDBCtrlGrid;
    Label1: TLabel;
    Edit_Produto: TButtonedEdit;
    Label2: TLabel;
    Edit_Emissao: TDBEdit;
    ImageList: TImageList;
    Edit_Quantidade: TDBEdit;
    Edit_PrecoVenda: TDBEdit;
    Label3: TLabel;
    Label4: TLabel;
    Button_PesquisaProduto: TSpeedButton;
    Label_Cliente: TLabel;
    Edit_Cliente: TDBEdit;
    Edit_Nome: TDBEdit;
    Button_PesquisaCliente: TSpeedButton;
    Label5: TLabel;
    Edit_Cidade: TDBEdit;
    Label6: TLabel;
    Edit_UF: TDBEdit;
    Pedido: TDataSource;
    PedidoItens: TDataSource;
    Panel_Detalhe: TPanel;
    Text_Codigo: TDBEdit;
    Text_Descricao: TDBEdit;
    Text_Quantidade: TDBEdit;
    Text_PrecoVenda: TDBEdit;
    Text_Total: TDBEdit;
    Panel_Title: TPanel;
    Label_Codigo: TLabel;
    Label_Descricao: TLabel;
    Label_Quantidade: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Button_Insert: TSpeedButton;
    ActionList: TActionList;
    DatasetInsert: TDataSetInsert;
    DatasetEdit: TDataSetEdit;
    DatasetPost: TDataSetPost;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    DatasetCancel: TDataSetCancel;
    DatasetDelete: TDataSetDelete;
    Button5: TButton;
    Label9: TLabel;
    Edit_agg_pd_total: TDBEdit;
    Edit_ID: TDBEdit;
    Label10: TLabel;
    Image_Delete: TImage;
    Panel_PDFind: TPanel;
    Edit_PD: TEdit;
    Label_PD: TLabel;
    Button_Find: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Image_DeleteClick(Sender: TObject);
    procedure Edit_ProdutoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button_PesquisaClienteClick(Sender: TObject);
    procedure Button_PesquisaProdutoClick(Sender: TObject);
    procedure Button_InsertClick(Sender: TObject);
    procedure Edit_QuantidadeKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit_PrecoVendaKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit_ProdutoEnter(Sender: TObject);
    procedure Edit_ProdutoChange(Sender: TObject);
    procedure Button_FindClick(Sender: TObject);
    procedure Edit_PDKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    FViewPedidos: TViewPedidos;
  public
    { Public declarations }
  end;

var
  FrmPedidos: TFrmPedidos;

implementation

{$R *.dfm}

procedure TFrmPedidos.Button_FindClick(Sender: TObject);
begin
  inherited;
  Panel_PDFind.Top := Edit_ID.Top;
  Panel_PDFind.Left := Edit_Nome.Left;
  Panel_PDFind.Visible := not Panel_PDFind.Visible;
  if Panel_PDFind.Visible then
    Edit_PD.SetFocus;
end;

procedure TFrmPedidos.Button_InsertClick(Sender: TObject);
begin
  inherited;
  try
    try
      FViewPedidos.Button_InsertClick(Sender, StrToInt(Edit_Produto.Text));
    except
      on E: Exception do
        ShowMessage(E.Message);
    end;
  finally
    Edit_Produto.Clear;
  end;
end;

procedure TFrmPedidos.Button_PesquisaClienteClick(Sender: TObject);
begin
  inherited;
  try
    FViewPedidos.Button_PesquisaClienteClick(Sender);
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

procedure TFrmPedidos.Button_PesquisaProdutoClick(Sender: TObject);
begin
  inherited;
  try
    try
      FViewPedidos.Button_PesquisaProdutoClick(Sender);
    except
      on E: Exception do
        ShowMessage(E.Message);
    end;
  finally
    Edit_Produto.Clear;
  end;
end;

procedure TFrmPedidos.Edit_PDKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_RETURN: FViewPedidos.PDFind(Sender, StrToIntDef(Edit_PD.Text, -1));
  end;
end;

procedure TFrmPedidos.Edit_PrecoVendaKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_RETURN: Edit_Produto.SetFocus;
  end;
end;

procedure TFrmPedidos.Edit_ProdutoChange(Sender: TObject);
begin
  inherited;
  Button_Insert.Enabled := Edit_Produto.Text <> '';
end;

procedure TFrmPedidos.Edit_ProdutoEnter(Sender: TObject);
begin
  inherited;
  FViewPedidos.Edit_ProdutoEnter(Sender);
end;

procedure TFrmPedidos.Edit_ProdutoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Edit_Produto.Text = '' then
  begin
    case Key of
      VK_RETURN: Edit_Quantidade.SetFocus;
    end;
  end;
  FViewPedidos.Edit_ProdutoKeyUp(Sender, Key, Shift);
end;

procedure TFrmPedidos.Edit_QuantidadeKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_RETURN: Edit_PrecoVenda.SetFocus;
  end;
end;

procedure TFrmPedidos.FormCreate(Sender: TObject);
begin
  inherited;
  FViewPedidos := TViewPedidos.Create;
  Pedido.DataSet := FViewPedidos.Pedido;
  PedidoItens.DataSet := FViewPedidos.PedidoItens;
  FViewPedidos.ConfigureMasterDetail(Pedido, 'pd_id', 'pd_id');
  try
    FViewPedidos.Open;
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

procedure TFrmPedidos.FormDestroy(Sender: TObject);
begin
  FViewPedidos.Free;
  inherited;
end;

procedure TFrmPedidos.Image_DeleteClick(Sender: TObject);
begin
  inherited;
  try
    FViewPedidos.Image_DeleteClick(Sender);
  except
    on E: Exception do
      ShowMessage('Erro ao excluir o item: ' + E.Message);
  end;
end;

end.
