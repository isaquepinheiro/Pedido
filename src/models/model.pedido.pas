unit model.pedido;

interface

uses
  Data.DB,
  core.database,
  core.database.interfaces,
  model.cliente,
  model.produto;

type
  IModelPedidos = interface
    ['{A67AC772-40B2-4D16-97F2-C980E2535F41}']
    function Pedido: TDataSet;
    function PedidoItens: TDataSet;
    function Clientes: TDataSet;
    function Produtos: TDataSet;
    function FindProduto(const ACodigo: Integer): Boolean;
    function FindPedido(const ACodigo: Integer): Boolean;
    procedure Open;
    procedure DeleteItem;
    procedure SetCliente(const AModel: TModelCliente);
    procedure SetProduto(const AModel: TModelProduto);
    procedure ConfigureMasterDetail(const AMasterDataSet: TDataSource;
      const AMasterFields, AChildFields: string);
  end;

  TModelPedidos = class(TInterfacedObject, IModelPedidos)
  private
    FPedido: IDBDataSet;
    FPedidoItens: IDBDataSet;
    FClientes: IDBDataSet;
    FProdutos: IDBDataSet;
    FSequence: IDBDataSet;
    procedure _DefineDataSetPedido;
    procedure _DefineDataSetPedidoItens;
    procedure _DefineDataSetCliente;
    procedure _DefineDataSetProduto;
    procedure _DefineDataSetSequence;
    procedure _AddPedidoFields;
    procedure _AddPedidoItensFields;
    procedure _AddPedidoFieldsCalculed;
    procedure _AddPedidoItensFieldsCalculed;
    procedure _AddPedidoItensFieldsAggregate;
    // Pedido
    procedure _OnCalcFieldsPedido(DataSet: TDataSet);
    procedure _AfterPostPedido(DataSet: TDataSet);
    procedure _AfterOpenPedido(DataSet: TDataSet);
    procedure _BeforePostPedido(DataSet: TDataSet);
    procedure _OnNewRecordPedido(DataSet: TDataSet);
    // Pedido Itens
    procedure _OnCalcFieldsPedidoItens(DataSet: TDataSet);
    procedure _BeforeEditPedidoItens(DataSet: TDataSet);
    procedure _BeforePostPedidoItens(DataSet: TDataSet);
    procedure _OnNewRecordPedidoItens(DataSet: TDataSet);
    function GetAutoInc(const ATable: String): Integer;
  public
    constructor Create;
    destructor Destroy; override;
    function Pedido: TDataSet;
    function PedidoItens: TDataSet;
    function Clientes: TDataSet;
    function Produtos: TDataSet;
    function FindProduto(const ACodigo: Integer): Boolean;
    function FindPedido(const ACodigo: Integer): Boolean;
    procedure Open;
    procedure DeleteItem;
    procedure SetCliente(const AModel: TModelCliente);
    procedure SetProduto(const AModel: TModelProduto);
    procedure ConfigureMasterDetail(const AMasterDataSet: TDataSource;
      const AMasterFields, AChildFields: string);
  end;

implementation

uses
  System.SysUtils,
  System.Classes;

{ TModelPedidos }

function TModelPedidos.Clientes: TDataSet;
begin
  Result := FClientes.AsDataSet;
end;

procedure TModelPedidos.ConfigureMasterDetail(const AMasterDataSet: TDataSource;
  const AMasterFields, AChildFields: string);
begin
  FPedidoItens.ConfigureMasterDetail(AMasterDataSet, AMasterFields, AChildFields);
end;

constructor TModelPedidos.Create;
begin
  _DefineDataSetPedido;
  _DefineDataSetPedidoItens;
  _DefineDataSetCliente;
  _DefineDataSetProduto;
  _DefineDataSetSequence;
end;

procedure TModelPedidos.DeleteItem;
begin
  try
    FPedidoItens.Delete;
  except
    on E: Exception do
      raise Exception.Create('Houve um error ao tentar excluir o produto!');
  end;
end;

destructor TModelPedidos.Destroy;
begin
  inherited;
end;

function TModelPedidos.FindPedido(const ACodigo: Integer): Boolean;
begin
  FPedido.Close;
  FPedido.ParamByName('pd_id', ACodigo);
  FPedido.Open;
end;

function TModelPedidos.FindProduto(const ACodigo: Integer): Boolean;
var
  LQuery: IDBDataSet;
const
  C_SQL = 'select pro_preco_venda from produtos where pro_codigo = %s';
begin
  Result := False;
  try
    LQuery := TDatabase.Get.Connection.DataSet;
    LQuery.SQL.Text := Format(C_SQL, [ACodigo.ToString]);
    LQuery.Open;
    if LQuery.RecordCount > 0 then
    begin
      FPedidoItens.AsDataSet.Append;
      FPedidoItens.FieldByName('pd_id').AsInteger := FPedido.FieldByName('pd_id').AsInteger;
      FPedidoItens.FieldByName('pro_codigo').AsInteger := ACodigo;
      FPedidoItens.FieldByName('item_quantidade').AsCurrency := 1;
      FPedidoItens.FieldByName('item_preco_venda').AsCurrency := LQuery.FieldByName('pro_preco_venda').AsCurrency;
      FPedidoItens.FieldByName('item_total').AsCurrency := FPedidoItens.FieldByName('item_quantidade').AsCurrency *
                                                           LQuery.FieldByName('pro_preco_venda').AsCurrency;
      FPedidoItens.AsDataSet.Post;
      Result := True;
    end;
  except
    on E: Exception do
    begin
      raise Exception.Create('Houve um error ao tentar inserir o produto no pedido!');
    end;
  end;
end;

function TModelPedidos.GetAutoInc(const ATable: String): Integer;
begin
  Result := 0;
  TDatabase.Get.Connection.StartTransaction;
  try
  TDatabase.Get
           .Connection
           .ExecSQL('update sequence set auto_inc = auto_inc + 1 where sequence.`table` = :table', [ATable]);
    TDatabase.Get.Connection.Commit;
  except
    on E: Exception do
    begin
      TDatabase.Get.Connection.Rollback;
      raise Exception.Create(E.Message);
    end;
  end;
  FSequence.ParamByName('table', ATable);
  FSequence.Open;
  try
    if FSequence.RecordCount > 0 then
      Result := FSequence.FieldByName('auto_inc').AsInteger;
  finally
    FSequence.Close;
  end;
end;

procedure TModelPedidos.Open;
begin
  try
    FPedido.Open;
  except
    on E: Exception do
      raise Exception.Create('Houve um error ao abrir a tabela de pedido!');
  end;
end;

function TModelPedidos.Pedido: TDataSet;
begin
  Result := FPedido.AsDataSet;
end;

function TModelPedidos.PedidoItens: TDataSet;
begin
  Result := FPedidoItens.AsDataSet;
end;

function TModelPedidos.Produtos: TDataSet;
begin
  Result := FProdutos.AsDataSet;
end;

procedure TModelPedidos.SetCliente(const AModel: TModelCliente);
begin
  FPedido.FieldByName('cli_codigo').AsInteger := AModel.cli_codigo;
end;

procedure TModelPedidos.SetProduto(const AModel: TModelProduto);
begin
  FPedidoItens.AsDataSet.Append;
  FPedidoItens.FieldByName('pd_id').AsInteger := FPedido.FieldByName('pd_id').AsInteger;
  FPedidoItens.FieldByName('pro_codigo').AsInteger := AModel.pro_codigo;
  FPedidoItens.FieldByName('item_quantidade').AsCurrency := 1;
  FPedidoItens.FieldByName('item_preco_venda').AsCurrency := AModel.pro_preco_venda;
  FPedidoItens.FieldByName('item_total').AsCurrency := FPedidoItens.FieldByName('item_quantidade').AsCurrency *
                                                       AModel.pro_preco_venda;
  FPedidoItens.Post;
end;

procedure TModelPedidos._AddPedidoFields;
var
  LField: TField;
begin
  // Campo pd_id (BIGINT, AutoIncrement)
  LField := TLargeintField.Create(FPedido.AsDataSet);
  LField.FieldName := 'pd_id';
  LField.DataSet := FPedido.AsDataSet;
  LField.Alignment := taCenter;
  LField.Required := True;
  LField.ProviderFlags := [pfInUpdate, pfInWhere, pfInKey];

  // Campo pd_data_emissao (DATETIME)
  LField := TDateTimeField.Create(FPedido.AsDataSet);
  LField.FieldName := 'pd_data_emissao';
  LField.DataSet := FPedido.AsDataSet;
  LField.Required := True;
  LField.Alignment := taCenter;
  LField.EditMask := '!99/99/0000;0;_';
  LField.ProviderFlags := [pfInUpdate];

  // Campo pd_Itens_total (DECIMAL)
  LField := TBCDField.Create(FPedido.AsDataSet);
  TBCDField(LField).Precision := 12;
  TBCDField(LField).Size := 2;
  LField.FieldName := 'pd_Itens_total';
  LField.DataSet := FPedido.AsDataSet;
  LField.Required := True;
  LField.DefaultExpression := '0';
  LField.Alignment := taRightJustify;
  TBCDField(LField).DisplayFormat := '#,##0';
  LField.ProviderFlags := [pfInUpdate];

  // Campo cli_codigo (BIGINT, Foreign Key)
  LField := TLargeintField.Create(FPedido.AsDataSet);
  LField.FieldName := 'cli_codigo';
  LField.DataSet := FPedido.AsDataSet;
  LField.Required := True;
  LField.Alignment := taCenter;
  LField.ProviderFlags := [pfInUpdate];
end;

procedure TModelPedidos._AddPedidoItensFields;
var
  LField: TField;
begin
  // Campo item_id (BIGINT, AutoIncrement)
  LField := TLargeintField.Create(FPedidoItens.AsDataSet);
  LField.FieldName := 'item_id';
  LField.DataSet := FPedidoItens.AsDataSet;
  LField.Alignment := taCenter;
  LField.Required := True;
  LField.ProviderFlags := [pfInUpdate, pfInWhere, pfInKey];

  // Campo pd_id (BIGINT, Foreign Key)
  LField := TLargeintField.Create(FPedidoItens.AsDataSet);
  LField.FieldName := 'pd_id';
  LField.DataSet := FPedidoItens.AsDataSet;
  LField.Alignment := taCenter;
  LField.Required := True;
  LField.ProviderFlags := [pfInUpdate];

  // Campo pro_codigo (BIGINT, Foreign Key)
  LField := TLargeintField.Create(FPedidoItens.AsDataSet);
  LField.FieldName := 'pro_codigo';
  LField.DataSet := FPedidoItens.AsDataSet;
  LField.Alignment := taCenter;
  LField.Required := True;
  LField.ProviderFlags := [pfInUpdate];

  // Campo item_quantidade (DECIMAL(10,2))
  LField := TBCDField.Create(FPedidoItens.AsDataSet);
  TBCDField(LField).Precision := 10;
  TBCDField(LField).Size := 2;
  LField.FieldName := 'item_quantidade';
  LField.DataSet := FPedidoItens.AsDataSet;
  LField.Required := True;
  LField.DefaultExpression := '0';
  LField.Alignment := taRightJustify;
  TBCDField(LField).DisplayFormat := '#,##0.00';
  LField.ProviderFlags := [pfInUpdate];

  // Campo item_preco_venda (DECIMAL(10,2))
  LField := TBCDField.Create(FPedidoItens.AsDataSet);
  TBCDField(LField).Precision := 10;
  TBCDField(LField).Size := 2;
  LField.FieldName := 'item_preco_venda';
  LField.DataSet := FPedidoItens.AsDataSet;
  LField.Required := True;
  LField.DefaultExpression := '0';
  LField.Alignment := taRightJustify;
  TBCDField(LField).DisplayFormat := '#,##0.00';
  LField.ProviderFlags := [pfInUpdate];

  // Campo item_total (DECIMAL(10,2))
  LField := TBCDField.Create(FPedidoItens.AsDataSet);
  TBCDField(LField).Precision := 10;
  TBCDField(LField).Size := 2;
  LField.FieldName := 'item_total';
  LField.DataSet := FPedidoItens.AsDataSet;
  LField.Required := True;
  LField.DefaultExpression := '0';
  LField.Alignment := taRightJustify;
  TBCDField(LField).DisplayFormat := '#,##0.00';
  LField.ProviderFlags := [pfInUpdate];
end;

procedure TModelPedidos._AddPedidoItensFieldsAggregate;
var
  LField: TAggregateField;
begin
  LField := TAggregateField.Create(FPedidoItens.AsDataSet);
  LField.FieldName := 'agg_pd_total';
  LField.DataSet := FPedidoItens.AsDataSet;
  LField.Precision := 2;
  LField.FieldKind := fkAggregate;
  LField.Alignment := taRightJustify;
  LField.Expression := 'sum(item_quantidade * item_preco_venda)';
  LField.Active := True;
  LField.DisplayFormat := '#,##0.00';
end;

procedure TModelPedidos._AddPedidoItensFieldsCalculed;
var
  LField: TField;
begin
  // cli_nome
  LField := TStringField.Create(FPedidoItens.AsDataSet);
  LField.FieldName := 'pro_descricao';
  LField.DataSet := FPedidoItens.AsDataSet;
  LField.Size := 100;
  LField.Calculated := True;
  LField.FieldKind := fkInternalCalc;
end;

procedure TModelPedidos._AfterOpenPedido(DataSet: TDataSet);
begin
  FPedidoItens.Open;
end;

procedure TModelPedidos._AfterPostPedido(DataSet: TDataSet);
const
  C_MSG = 'Houve um error ao tentar salvar os dados no banco. ';
begin
  TDatabase.Get.Connection.StartTransaction;
  try
    FPedido.ApplyUpdates(0);
    FPedidoItens.ApplyUpdates(0);
    TDatabase.Get.Connection.Commit;
  except
    on E: Exception do
    begin
      TDatabase.Get.Connection.Rollback;
      raise Exception.Create(E.Message);
    end;
  end;
end;

procedure TModelPedidos._BeforeEditPedidoItens(DataSet: TDataSet);
begin
  if FPedido.AsDataSet.State in [dsBrowse] then
    Abort;
end;

procedure TModelPedidos._BeforePostPedido(DataSet: TDataSet);
begin
  if FPedidoItens.AsDataSet.State in [dsInsert, dsEdit] then
    FPedidoItens.Post;
  FPedido.FieldByName('pd_itens_total').AsCurrency := FPedidoItens.FieldByName('agg_pd_total').Value;
end;

procedure TModelPedidos._BeforePostPedidoItens(DataSet: TDataSet);
begin
  FPedidoItens.FieldByName('item_total').AsCurrency := FPedidoItens.FieldByName('item_quantidade').AsCurrency *
                                                       FPedidoItens.FieldByName('item_preco_venda').AsCurrency;
end;

procedure TModelPedidos._DefineDataSetCliente;
begin
  FClientes := TDatabase.Get.Connection.DataSet;
  FClientes.SQL.Text := 'select * from clientes order by cli_nome';
end;

procedure TModelPedidos._DefineDataSetPedido;
begin
  FPedido := TDatabase.Get.Connection.DataSet;
  FPedido.SQL.Text := 'select * from pedidos where pd_id = :pd_id order by pd_data_emissao, pd_id';
  FPedido.ParamByName('pd_id', ftInteger);
  FPedido.ParamByName('pd_id', -1);

  _AddPedidoFields;
  _AddPedidoFieldsCalculed;

  FPedido.AsDataSet.OnCalcFields := _OnCalcFieldsPedido;
  FPedido.AsDataSet.AfterOpen := _AfterOpenPedido;
  FPedido.AsDataSet.AfterPost := _AfterPostPedido;
  FPedido.AsDataSet.BeforePost := _BeforePostPedido;
  FPedido.AsDataSet.OnNewRecord := _OnNewRecordPedido;
end;

procedure TModelPedidos._DefineDataSetPedidoItens;
begin
  FPedidoItens := TDatabase.Get.Connection.DataSet;
  FPedidoItens.SQL.Text := 'select * from pedidos_itens where pd_id = :pd_id order by pd_id, item_id';
  FPedidoItens.ParamByName('pd_id', ftLargeint);

  _AddPedidoItensFields;
  _AddPedidoItensFieldsCalculed;
  _AddPedidoItensFieldsAggregate;

  FPedidoItens.AsDataSet.BeforeEdit := _BeforeEditPedidoItens;
  FPedidoItens.AsDataSet.OnCalcFields := _OnCalcFieldsPedidoItens;
  FPedidoItens.AsDataSet.BeforePost := _BeforePostPedidoItens;
  FPedidoItens.AsDataSet.OnNewRecord := _OnNewRecordPedidoItens;
end;

procedure TModelPedidos._DefineDataSetProduto;
begin
  FProdutos := TDatabase.Get.Connection.DataSet;
  FProdutos.SQL.Text := 'select * from produtos order by pro_descricao';
end;

procedure TModelPedidos._DefineDataSetSequence;
begin
  FSequence := TDatabase.Get.Connection.DataSet;
  FSequence.SQL.Text := 'select auto_inc from sequence where sequence.`table` = :table';
  FSequence.ParamByName('table', ftString);
end;

procedure TModelPedidos._AddPedidoFieldsCalculed;
var
  LField: TField;
begin
  // cli_nome
  LField := TStringField.Create(FPedido.AsDataSet);
  LField.FieldName := 'cli_nome';
  LField.DataSet := FPedido.AsDataSet;
  LField.Size := 100;
  LField.Calculated := True;
  LField.FieldKind := fkInternalCalc;
  // cli_cidade
  LField := TStringField.Create(FPedido.AsDataSet);
  LField.FieldName := 'cli_cidade';
  LField.DataSet := FPedido.AsDataSet;
  LField.Size := 100;
  LField.Calculated := True;
  LField.FieldKind := fkInternalCalc;
  // cli_uf
  LField := TStringField.Create(FPedido.AsDataSet);
  LField.FieldName := 'cli_uf';
  LField.DataSet := FPedido.AsDataSet;
  LField.Size := 2;
  LField.Calculated := True;
  LField.FieldKind := fkInternalCalc;
  LField.Alignment := taCenter;
end;

procedure TModelPedidos._OnCalcFieldsPedido(DataSet: TDataSet);
var
  LDataSet: IDBDataSet;
const
  C_SQL = 'select * from clientes where cli_codigo = %s';
begin
  if (DataSet.FieldByName('cli_codigo').AsInteger <> 0) and
     (DataSet.State <> dsInternalCalc) then
  begin
    LDataSet := TDatabase.Get.Connection.DataSet;
    LDataSet.SQL.Text := Format(C_SQL, [DataSet.FieldByName('cli_codigo').AsString]);
    LDataSet.Open;
    try
      if LDataSet.RecordCount = 0 then
        Exit;
      DataSet.FieldByName('cli_nome').AsString := LDataSet.FieldByName('cli_nome').AsString;
      DataSet.FieldByName('cli_cidade').AsString := LDataSet.FieldByName('cli_cidade').AsString;
      DataSet.FieldByName('cli_uf').AsString := LDataSet.FieldByName('cli_uf').AsString;
    finally
      LDataSet.Close;
    end;
  end;
end;

procedure TModelPedidos._OnCalcFieldsPedidoItens(DataSet: TDataSet);
var
  LDataSet: IDBDataSet;
const
  C_SQL = 'select * from produtos where pro_codigo = %s';
begin
  if (DataSet.FieldByName('pro_codigo').AsInteger <> 0) and
     (DataSet.State <> dsInternalCalc) then
  begin
    LDataSet := TDatabase.Get.Connection.DataSet;
    LDataSet.SQL.Text := Format(C_SQL, [DataSet.FieldByName('pro_codigo').AsString]);
    LDataSet.Open;
    try
      if LDataSet.RecordCount = 0 then
        Exit;
      DataSet.FieldByName('pro_descricao').AsString := LDataSet.FieldByName('pro_descricao').AsString;
    finally
      LDataSet.Close;
    end;
  end;
end;

procedure TModelPedidos._OnNewRecordPedido(DataSet: TDataSet);
begin
  DataSet.FieldByName('pd_id').AsInteger := GetAutoInc('pedido');
end;

procedure TModelPedidos._OnNewRecordPedidoItens(DataSet: TDataSet);
begin
  DataSet.FieldByName('item_id').AsInteger := GetAutoInc('pedido_itens');;
end;

end.
