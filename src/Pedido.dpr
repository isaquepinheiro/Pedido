program Pedido;

uses
  Vcl.Forms,
  frm_base in 'views\frm_base.pas' {FrmBase},
  frm_pedidos in 'views\frm_pedidos.pas' {FrmPedidos},
  core.connection.firedac in 'core\core.connection.firedac.pas',
  core.database.interfaces in 'core\core.database.interfaces.pas',
  core.dataset.firedac in 'core\core.dataset.firedac.pas',
  core.database in 'core\core.database.pas',
  dtm_pedido in 'views\dtm_pedido.pas' {DtmPedidos: TDataModule},
  core.connection.ini.reader in 'core\core.connection.ini.reader.pas',
  controller.clientes in 'controllers\controller.clientes.pas',
  controller.produtos in 'controllers\controller.produtos.pas',
  controller.pedidos in 'controllers\controller.pedidos.pas',
  model.cliente in 'models\model.cliente.pas',
  model.produto in 'models\model.produto.pas',
  model.pedido in 'models\model.pedido.pas',
  view.pedidos in 'views\view.pedidos.pas',
  frm_find_produto in 'views\frm_find_produto.pas' {FormFindProduto},
  frm_find_cliente in 'views\frm_find_cliente.pas' {FormFindCliente};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDtmPedidos, DtmPedidos);
  Application.CreateForm(TFrmPedidos, FrmPedidos);
  Application.Run;
end.
