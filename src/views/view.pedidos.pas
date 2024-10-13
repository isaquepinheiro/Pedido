unit view.pedidos;

interface

uses
  Vcl.Dialogs,
  Data.DB,
  controller.pedidos,
  System.Classes;

type
  TViewPedidos = class
  private
    FController: IControllerPedidos;
    FPedido: TDataSet;
    FPedidoItens: TDataSet;
    FClientes: TDataSet;
    FProdutos: TDataSet;
    FCliente: Integer;
    FProduto: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Button_PesquisaClienteClick(Sender: TObject);
    procedure Image_DeleteClick(Sender: TObject);
    procedure Edit_ProdutoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button_InsertClick(Sender: TObject; const ACodigo: Integer);
    procedure Button_PesquisaProdutoClick(Sender: TObject);
    procedure Edit_ProdutoEnter(Sender: TObject);
    procedure PDFind(Sender: TObject; const ACodigo: Integer);
    //
    function Controller: IControllerPedidos;
    function Pedido: TDataSet;
    function PedidoItens: TDataSet;
    function Cliente: Integer;
    function Produto: Integer;
    procedure Open;
    procedure ConfigureMasterDetail(const AMasterDataSet: TDataSource;
      const AMasterFields, AChildFields: String);
  end;

implementation

uses
  Winapi.Windows,
  System.SysUtils,
  Vcl.StdCtrls,
  Vcl.Controls,
  model.cliente,
  model.produto,
  frm_find_cliente,
  frm_find_produto;

{ TViewPedidos }

procedure TViewPedidos.Button_InsertClick(Sender: TObject;
  const ACodigo: Integer);
begin
  FController.Model.FindProduto(ACodigo);
end;

procedure TViewPedidos.PDFind(Sender: TObject; const ACodigo: Integer);
begin
  FController.FindPedido(ACodigo);
end;

procedure TViewPedidos.Button_PesquisaClienteClick(Sender: TObject);
var
  LResult: TModelCliente;
begin
  if FPedido.State in [dsBrowse] then
    raise Exception.Create('Antes de pesquisar um cliente, insira ou edite o pedido!');

  LResult := TFormFindCliente.Show_Modal(Self);
  if LResult = Default(TModelCliente) then
    Exit;
  // Seta o código selecionado
  FController.Model.SetCliente(LResult);
end;

procedure TViewPedidos.Button_PesquisaProdutoClick(Sender: TObject);
var
  LResult: TModelProduto;
begin
  if FPedido.State in [dsBrowse] then
    raise Exception.Create('Antes de pesquisar um produto, insira ou edite o pedido!');

  LResult := TFormFindProduto.Show_Modal(Self);
  if LResult = Default(TModelProduto) then
    Exit;
  // Seta o código selecionado
  FController.Model.SetProduto(LResult);
end;

function TViewPedidos.Cliente: Integer;
begin
  Result := FCliente;
end;

procedure TViewPedidos.ConfigureMasterDetail(const AMasterDataSet: TDataSource;
  const AMasterFields, AChildFields: String);
begin
  FController.ConfigureMasterDetail(AMasterDataSet, 'pd_id', 'pd_id');
end;

function TViewPedidos.Controller: IControllerPedidos;
begin
  Result := FController;
end;

constructor TViewPedidos.Create;
begin
  FController := TControllerPedidos.Create;
  FPedido := FController.Model.Pedido;
  FPedidoItens := FController.Model.PedidoItens;
  FClientes := FController.Model.Clientes;
  FProdutos := FController.Model.Produtos;
  FCliente := 0;
  FProduto := 0;
end;

destructor TViewPedidos.Destroy;
begin

  inherited;
end;

procedure TViewPedidos.Edit_ProdutoEnter(Sender: TObject);
begin
  if FPedidoItens.State in [dsEdit, dsInsert] then
    FPedidoItens.Post;
end;

procedure TViewPedidos.Edit_ProdutoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_UP:
      FPedidoItens.Prior;
    VK_DOWN:
      FPedidoItens.Next;
  end;
  if FPedido.State in [dsBrowse] then
  begin
    TEdit(Sender).Text := '';
    Key := 0;
    Exit;
  end;
end;

procedure TViewPedidos.Image_DeleteClick(Sender: TObject);
begin
  if FPedido.State in [dsBrowse] then
    raise Exception.Create('Edite do pedido antes, para conseguir excluir um produto!');

  if MessageDlg('Deseja realmente excluir este item?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    FController.DeleteItem;
  end
end;

procedure TViewPedidos.Open;
begin
  FController.Open;
end;

function TViewPedidos.Pedido: TDataSet;
begin
  Result := FPedido;
end;

function TViewPedidos.PedidoItens: TDataSet;
begin
  Result := FPedidoItens;
end;

function TViewPedidos.Produto: Integer;
begin
  Result := FProduto;
end;

end.
