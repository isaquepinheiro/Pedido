unit model.produto;

interface

type
  TModelProduto = record
  private
    Fpro_codigo: Integer;
    Fpro_preco_venda: Currency;
    procedure _Setpro_codigo(const Value: Integer);
    procedure _Setpro_preco_venda(const Value: Currency);
  public
    class operator Equal(A, B: TModelProduto): Boolean;
    property pro_codigo: Integer read Fpro_codigo write _Setpro_codigo;
    property pro_preco_venda: Currency read Fpro_preco_venda write _Setpro_preco_venda;
  end;

implementation

class operator TModelProduto.Equal(A, B: TModelProduto): Boolean;
begin
  Result := (A.Fpro_codigo = B.Fpro_codigo);
end;

{ TModelProduto }

procedure TModelProduto._Setpro_preco_venda(const Value: Currency);
begin
  Fpro_preco_venda := Value;
end;

procedure TModelProduto._Setpro_codigo(const Value: Integer);
begin
  Fpro_codigo := Value;
end;

end.
