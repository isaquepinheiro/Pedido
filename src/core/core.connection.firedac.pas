unit core.connection.firedac;

interface

uses
  FireDAC.Comp.Client,
  FireDAC.VCLUI.Wait,
  FireDAC.DApt,
  FireDAC.Stan.Def,
  FireDAC.Stan.Async,
  FireDAC.Phys.MySQLDef,
  FireDAC.Phys,
  FireDAC.Phys.MySQL,
  FireDAC.Stan.Option,
  core.database.interfaces,
  core.dataset.firedac,
  Data.DB;

type
  TConnectionFireDAC = class(TInterfacedObject, IDBConnection)
  private
    FConnection: TFDConnection;
  public
    constructor Create(const ADriverName, AServer, ADatabase, AUserName,
      APassword: string; APort: Integer = 0);
    destructor Destroy; override;
    procedure Disconnect;
    procedure StartTransaction;
    procedure Commit;
    procedure Rollback;
    function Connect: Boolean;
    function IsConnected: Boolean;
    function InTransaction: Boolean;
    function DataSet: IDBDataSet;
    function ExecSQL(const ASQL: String; const AParams: array of Variant): LongInt;
  end;

implementation

uses
  System.SysUtils;

{ TConnectionFireDAC }

constructor TConnectionFireDAC.Create(const ADriverName, AServer, ADatabase,
  AUserName, APassword: string; APort: Integer = 0);
begin
  inherited Create;
  FConnection := TFDConnection.Create(nil);
  FConnection.DriverName := ADriverName;
  FConnection.Params.Database := ADatabase;
  FConnection.Params.UserName := AUserName;
  FConnection.Params.Password := APassword;
  FConnection.Params.Add('Server=' + AServer);
  FConnection.Params.Add('Port=' + APort.ToString);
  FConnection.TxOptions.AutoCommit := True;
  FConnection.TxOptions.Isolation := xiReadCommitted;
end;

destructor TConnectionFireDAC.Destroy;
begin
  if FConnection.Connected then
    FConnection.Connected := False;
  FConnection.Free;
  inherited;
end;

procedure TConnectionFireDAC.Commit;
begin
  if FConnection.InTransaction then
    FConnection.Commit;
end;

function TConnectionFireDAC.Connect: Boolean;
begin
  Result := False;
  try
    FConnection.Connected := True;
    Result := True;
  except
    on E: Exception do
    begin
      raise Exception.Create('Não foi possível conectar ao banco!');
    end;
  end;
end;

procedure TConnectionFireDAC.Disconnect;
begin
  if FConnection.Connected then
    FConnection.Connected := False;
end;

function TConnectionFireDAC.ExecSQL(const ASQL: String;
  const AParams: array of Variant): LongInt;
begin
  Result := FConnection.ExecSQL(ASQL, AParams);
end;

function TConnectionFireDAC.DataSet: IDBDataSet;
begin
  Result := TDataSetFireDAC.Create(FConnection);
end;

function TConnectionFireDAC.InTransaction: Boolean;
begin
  Result := FConnection.InTransaction;
end;

function TConnectionFireDAC.IsConnected: Boolean;
begin
  Result := FConnection.Connected;
end;

procedure TConnectionFireDAC.Rollback;
begin
  if FConnection.InTransaction then
    FConnection.Rollback;
end;

procedure TConnectionFireDAC.StartTransaction;
begin
  FConnection.StartTransaction;
end;


end.
