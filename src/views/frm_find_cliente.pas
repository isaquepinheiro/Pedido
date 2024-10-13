unit frm_find_cliente;

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
  model.cliente;

type
  TFormFindCliente = class(TForm)
    Grid_Cliente: TDBGrid;
    Button_Cancel: TButton;
    Button_Close: TButton;
    Cliente: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    class var FViewPedidos: TViewPedidos;
  public
    { Public declarations }
    class function Show_Modal(const AViewPedidos: TViewPedidos): TModelCliente;
  end;

implementation

uses
  core.database;

{$R *.dfm}

procedure TFormFindCliente.FormCreate(Sender: TObject);
begin
  Cliente.DataSet := FViewPedidos.Controller.Model.Clientes;
  Cliente.DataSet.Open;
end;

procedure TFormFindCliente.FormDestroy(Sender: TObject);
begin
  Cliente.DataSet.Close;
  inherited;
end;

class function TFormFindCliente.Show_Modal(const AViewPedidos: TViewPedidos): TModelCliente;
var
  LFormFind: TFormFindCliente;
begin
  Result := Default(TModelCliente);
  FViewPedidos := AViewPedidos;
  LFormFind := TFormFindCliente.Create(nil);
  try
    if LFormFind.ShowModal = mrOK then
      Result.cli_codigo := FViewPedidos.Controller.Model.Clientes.FieldByName('cli_codigo').AsInteger;
  finally
    FreeAndNil(LFormFind);
  end;
end;

end.
