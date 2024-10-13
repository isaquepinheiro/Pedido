unit core.connection.interfaces;

interface

type
  // Para engines que tenha componentes de transação fora do componente
  // de conexão.
  IDBTransaction = interface
    ['{ECA57A36-294E-4CDA-A49B-6307BD18CD4C}']
    procedure StartTransaction;
    procedure Commit;
    procedure Rollback;
    function InTransaction: Boolean;
  end;

  IDBConnection = interface
    ['{801B63E5-CB49-4597-8AC4-55E0BC17C3CA}']
    procedure Disconnect;
    procedure StartTransaction;
    procedure Commit;
    procedure Rollback;
    function Connect: Boolean;
    function IsConnected: Boolean;
    function InTransaction: Boolean;
  end;

implementation

end.
