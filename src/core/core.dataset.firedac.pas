unit core.dataset.firedac;

interface

uses
  DB,
  FireDAC.Comp.Client,
  System.Classes,
  core.database.interfaces;

type
  TDataSetFireDAC = class(TInterfacedObject, IDBDataSet)
  private
    FDataSet: TFDQuery;
    FOnBeforeOpen: TDataSetNotifyEvent;
    FOnAfterOpen: TDataSetNotifyEvent;
    procedure _DoBeforeOpen(Sender: TDataSet);
    procedure _DoAfterOpen(Sender: TDataSet);
  protected
    function GetOnBeforeOpen: TDataSetNotifyEvent;
    procedure SetOnBeforeOpen(AEvent: TDataSetNotifyEvent);
    function GetOnAfterOpen: TDataSetNotifyEvent;
    procedure SetOnAfterOpen(AEvent: TDataSetNotifyEvent);
  public
    constructor Create(AConnection: TFDConnection);
    destructor Destroy; override;
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
    function ApplyUpdates(const AMaxErros: Integer): Integer;
    function AsDataSet: TDataSet;
    procedure ConfigureMasterDetail(const AMasterDataSet: TDataSource;
      const AMasterFields, AChildFields: string);
    //
    property BeforeOpen: TDataSetNotifyEvent read GetOnBeforeOpen write SetOnBeforeOpen;
    property AfterOpen: TDataSetNotifyEvent read GetOnAfterOpen write SetOnAfterOpen;
  end;

implementation

{ TDataSetImpl }

constructor TDataSetFireDAC.Create(AConnection: TFDConnection);
begin
  FDataSet := TFDQuery.Create(nil);
  FDataSet.Connection := AConnection;
  FDataSet.CachedUpdates := True;
  FDataSet.AggregatesActive := True;
  // Atribui os eventos internos para monitorar o ciclo do dataset
  FDataSet.BeforeOpen := _DoBeforeOpen;
  FDataSet.AfterOpen := _DoAfterOpen;
end;

procedure TDataSetFireDAC.Open;
begin
  FDataSet.Open;
end;

procedure TDataSetFireDAC.Cancel;
begin
  FDataSet.Cancel;
end;

procedure TDataSetFireDAC.CancelUpdates;
begin
  FDataSet.CancelUpdates;
end;

procedure TDataSetFireDAC.ParamByName(const AParamName: String; const AFieldType: TFieldType);
begin
  FDataSet.ParamByName(AParamName).DataType := AFieldType;
end;

procedure TDataSetFireDAC.ParamByName(const AParamName: String;
  const AValue: Variant);
begin
  FDataSet.ParamByName(AParamName).Value := AValue;
end;

procedure TDataSetFireDAC.Post;
begin
  FDataSet.Post;
end;

procedure TDataSetFireDAC.Prior;
begin
  FDataSet.Prior;
end;

function TDataSetFireDAC.RecordCount: Integer;
begin
  Result := FDataSet.RecordCount;
end;

procedure TDataSetFireDAC.Close;
begin
  FDataSet.Close;
end;

procedure TDataSetFireDAC.ConfigureMasterDetail(const AMasterDataSet: TDataSource;
  const AMasterFields, AChildFields: string);
begin
  FDataSet.FetchOptions.RowsetSize := -1;
  FDataSet.MasterFields := AMasterFields;
  FDataSet.IndexFieldNames := AChildFields;
  FDataSet.MasterSource := AMasterDataSet;
end;

procedure TDataSetFireDAC.Edit;
begin
  FDataSet.Edit;
end;

function TDataSetFireDAC.Eof: Boolean;
begin
  Result := FDataSet.Eof;
end;

function TDataSetFireDAC.FieldByName(const AFieldName: String): TField;
begin
  Result := FDataSet.FieldByName(AFieldName);
end;

procedure TDataSetFireDAC.First;
begin
  FDataSet.First;
end;

function TDataSetFireDAC.ApplyUpdates(const AMaxErros: Integer): Integer;
begin
  Result := FDataSet.ApplyUpdates(AMaxErros);
end;

function TDataSetFireDAC.Bof: Boolean;
begin
  Result := FDataSet.Bof;
end;

procedure TDataSetFireDAC._DoBeforeOpen(Sender: TDataSet);
begin
  if Assigned(FOnBeforeOpen) then
    FOnBeforeOpen(Sender);
end;

function TDataSetFireDAC.AsDataSet: TDataSet;
begin
  Result := FDataSet;
end;

procedure TDataSetFireDAC.Delete;
begin
  FDataSet.Delete;
end;

destructor TDataSetFireDAC.Destroy;
begin
  if Assigned(FDataSet) then
  begin
    if FDataSet.Active then
      FDataSet.Close;
    FDataSet.Free;
  end;
  inherited;
end;

procedure TDataSetFireDAC._DoAfterOpen(Sender: TDataSet);
begin
  if Assigned(FOnAfterOpen) then
    FOnAfterOpen(Sender);
end;

function TDataSetFireDAC.GetOnBeforeOpen: TDataSetNotifyEvent;
begin
  Result := FOnBeforeOpen;
end;

procedure TDataSetFireDAC.Last;
begin
  FDataSet.Last;
end;

procedure TDataSetFireDAC.Next;
begin
  FDataSet.Next;
end;

procedure TDataSetFireDAC.SetOnBeforeOpen(AEvent: TDataSetNotifyEvent);
begin
  FOnBeforeOpen := AEvent;
end;

function TDataSetFireDAC.SQL: TStrings;
begin
  Result := FDataSet.SQL;
end;

function TDataSetFireDAC.GetOnAfterOpen: TDataSetNotifyEvent;
begin
  Result := FOnAfterOpen;
end;

procedure TDataSetFireDAC.SetOnAfterOpen(AEvent: TDataSetNotifyEvent);
begin
  FOnAfterOpen := AEvent;
end;

end.

