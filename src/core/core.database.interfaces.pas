unit core.database.interfaces;

interface

uses
  DB,
  System.Classes;

type
  IDBDataSet = interface
    ['{E67A39C9-B005-4D13-B0D1-C8D5144DBCD5}']
    // Eventos relacionados ao ciclo de vida do DataSet
    function GetOnBeforeOpen: TDataSetNotifyEvent;
    procedure SetOnBeforeOpen(AEvent: TDataSetNotifyEvent);
    function GetOnAfterOpen: TDataSetNotifyEvent;
    procedure SetOnAfterOpen(AEvent: TDataSetNotifyEvent);
    //
    procedure Open;
    procedure Close;
    procedure First;
    procedure Next;
    procedure Prior;
    procedure Last;
    procedure Edit;
    procedure Post;
    procedure Cancel;
    procedure Delete;
    procedure CancelUpdates;
    function SQL: TStrings;
    function Eof: Boolean;
    function Bof: Boolean;
    function RecordCount: Integer;
    function FieldByName(const AFieldName: String): TField;
    procedure ParamByName(const AParamName: String; const AFieldType: TFieldType); overload;
    procedure ParamByName(const AParamName: String; const AValue: Variant); overload;
    procedure ConfigureMasterDetail(const AMasterDataSet: TDataSource;
      const AMasterFields, AChildFields: string);
    function ApplyUpdates(const AMaxErros: Integer): Integer;
    function AsDataSet: TDataSet;
    // etc...
    property BeforeOpen: TDataSetNotifyEvent read GetOnBeforeOpen write SetOnBeforeOpen;
    property AfterOpen: TDataSetNotifyEvent read GetOnAfterOpen write SetOnAfterOpen;
    // etc...
  end;

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
    function DataSet: IDBDataSet;
    function ExecSQL(const ASQL: String; const AParams: array of Variant): LongInt;
  end;

implementation

end.
