unit controller.pedidos;

interface

uses
  model.pedido,
  Data.DB;

type
  IControllerPedidos = interface
    ['{C4122C69-C4D4-4BAA-A36F-53CCC14EC711}']
    function Model: IModelPedidos;
    function FindProduto(const ACodigo: Integer): Boolean;
    function FindPedido(const ACodigo: Integer): Boolean;
    procedure Open;
    procedure DeleteItem;
    procedure ConfigureMasterDetail(const AMasterDataSet: TDataSource;
      const AMasterFields, AChildFields: String);
  end;

  TControllerPedidos = class(TInterfacedObject, IControllerPedidos)
  private
    FModel: IModelPedidos;
  public
    constructor Create;
    destructor Destroy; override;
    function Model: IModelPedidos;
    function FindProduto(const ACodigo: Integer): Boolean;
    function FindPedido(const ACodigo: Integer): Boolean;
    procedure Open;
    procedure DeleteItem;
    procedure ConfigureMasterDetail(const AMasterDataSet: TDataSource;
      const AMasterFields, AChildFields: String);
  end;

implementation

{ TControllerPedidos }

procedure TControllerPedidos.ConfigureMasterDetail(
  const AMasterDataSet: TDataSource; const AMasterFields, AChildFields: String);
begin
  FModel.ConfigureMasterDetail(AMasterDataSet, AMasterFields, AChildFields);
end;

constructor TControllerPedidos.Create;
begin
  FModel := TModelPedidos.Create;
end;

procedure TControllerPedidos.DeleteItem;
begin
  FModel.DeleteItem;
end;

destructor TControllerPedidos.Destroy;
begin

  inherited;
end;

function TControllerPedidos.FindPedido(const ACodigo: Integer): Boolean;
begin
  FModel.FindPedido(ACodigo);
end;

function TControllerPedidos.FindProduto(const ACodigo: Integer): Boolean;
begin
  Result := FModel.FindProduto(ACodigo);
end;

function TControllerPedidos.Model: IModelPedidos;
begin
  Result := FModel;
end;

procedure TControllerPedidos.Open;
begin
  FModel.Open;
end;

end.
