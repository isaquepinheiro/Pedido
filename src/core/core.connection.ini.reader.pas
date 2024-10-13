unit core.connection.ini.reader;

interface

uses
  System.SysUtils,
  System.IniFiles;

type
  TConnectionIniReader = class
  private
    FDriverName: String;
    FHost: String;
    FPort: Integer;
    FDatabaseName: String;
    FUsername: String;
    FPassword: String;
  public
    constructor Create(const AIniFilePath: String);
    procedure LoadFromIni(const AIniFilePath: String);
    // Propriedades para acessar os dados de conexão
    property DriverName: String read FDriverName;
    property Host: String read FHost;
    property Port: Integer read FPort;
    property DatabaseName: String read FDatabaseName;
    property Username: String read FUsername;
    property Password: String read FPassword;
  end;

implementation

{ TDatabaseConnectionInfo }

constructor TConnectionIniReader.Create(const AIniFilePath: String);
begin
  LoadFromIni(AIniFilePath);
end;

procedure TConnectionIniReader.LoadFromIni(const AIniFilePath: String);
var
  LIniFile: TIniFile;
begin
  LIniFile := TIniFile.Create(AIniFilePath);
  try
    // Lê os valores da seção [Database]
    FDriverName := LIniFile.ReadString('Database', 'DriverName', '');
    FHost := LIniFile.ReadString('Database', 'Host', '127.0.0.1');
    FPort := LIniFile.ReadInteger('Database', 'Port', 3306);
    FDatabaseName := LIniFile.ReadString('Database', 'DatabaseName', '');
    FUsername := LIniFile.ReadString('Database', 'Username', '');
    FPassword := LIniFile.ReadString('Database', 'Password', '');
  finally
    LIniFile.Free;
  end;
end;

end.

