unit dtm_pedido;

interface

uses
  Data.DB,
  System.SysUtils,
  System.Classes,
  core.database,
  core.connection.firedac,
  core.connection.ini.reader;

type
  TDtmPedidos = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DtmPedidos: TDtmPedidos;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDtmPedidos.DataModuleCreate(Sender: TObject);
var
  LConnectionIniReader: TConnectionIniReader;
begin
  LConnectionIniReader := TConnectionIniReader.Create('./connection.ini');
  try
    TDatabase.Get.SetConnection( TConnectionFireDAC.Create(LConnectionIniReader.DriverName,
                                                           LConnectionIniReader.Host,
                                                           LConnectionIniReader.DatabaseName,
                                                           LConnectionIniReader.Username,
                                                           LConnectionIniReader.Password,
                                                           LConnectionIniReader.Port) );
  finally
    LConnectionIniReader.Free;
  end;
  TDatabase.Get.Connection.Connect;
end;

end.
