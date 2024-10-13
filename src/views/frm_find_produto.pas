unit frm_find_produto;

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
  Data.DB,
  Vcl.ExtCtrls,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  view.pedidos,
  model.produto;

type
  TFormFindProduto = class(TForm)
    Grid_Cliente: TDBGrid;
    Button_Cancel: TButton;
    Button_Close: TButton;
    Produto: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    class var FViewPedidos: TViewPedidos;
  public
    { Public declarations }
    class function Show_Modal(const AViewPedidos: TViewPedidos): TModelProduto;
  end;

implementation

uses
  core.database;

{$R *.dfm}

procedure TFormFindProduto.FormCreate(Sender: TObject);
begin
  Produto.DataSet := FViewPedidos.Controller.Model.Produtos;
  Produto.DataSet.Open;
end;

procedure TFormFindProduto.FormDestroy(Sender: TObject);
begin
  Produto.DataSet.Close;
  inherited;
end;

class function TFormFindProduto.Show_Modal(const AViewPedidos: TViewPedidos): TModelProduto;
var
  LFormFind: TFormFindProduto;
begin
  Result := Default(TModelProduto);
  FViewPedidos := AViewPedidos;
  LFormFind := TFormFindProduto.Create(nil);
  try
    if LFormFind.ShowModal = mrOK then
      Result.pro_codigo := FViewPedidos.Controller.Model.Produtos.FieldByName('pro_codigo').AsInteger;
      Result.pro_preco_venda := FViewPedidos.Controller.Model.Produtos.FieldByName('pro_codigo').AsCurrency;
  finally
    FreeAndNil(LFormFind);
  end;
end;

end.
