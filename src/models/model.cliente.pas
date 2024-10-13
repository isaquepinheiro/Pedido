unit model.cliente;

interface

type
  TModelCliente = record
  private
    Fcli_codigo: Integer;
    procedure _Setcli_codigo(const Value: Integer);
  public
    class operator Equal(A, B: TModelCliente): Boolean;
    property cli_codigo: Integer read Fcli_codigo write _Setcli_codigo;
  end;

implementation

class operator TModelCliente.Equal(A, B: TModelCliente): Boolean;
begin
  Result := (A.Fcli_codigo = B.Fcli_codigo);
end;

{ TModelCliente }

procedure TModelCliente._Setcli_codigo(const Value: Integer);
begin
  Fcli_codigo := Value;
end;

end.
