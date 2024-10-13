unit core.database;

interface

uses
  core.database.interfaces;

type
  TDatabase = class
  private
    class var FInstance: TDatabase;
    FConnection: IDBConnection;
    constructor Create;
  public
    class function Get: TDatabase;
    procedure SetConnection(const AConnection: IDBConnection);
    function Connection: IDBConnection;
  end;

implementation

uses
  SysUtils;

{ TDatabase }

constructor TDatabase.Create;
begin
  inherited Create;
end;

class function TDatabase.Get: TDatabase;
begin
  if FInstance = nil then
    FInstance := TDatabase.Create;
  Result := FInstance;
end;

function TDatabase.Connection: IDBConnection;
begin
  Result := FConnection;
end;

procedure TDatabase.SetConnection(const AConnection: IDBConnection);
begin
  FConnection := AConnection;
end;

initialization
  TDatabase.FInstance := nil;

finalization
  if Assigned(TDatabase.FInstance) then
    TDatabase.FInstance.Free;

end.

