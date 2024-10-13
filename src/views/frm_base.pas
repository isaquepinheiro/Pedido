unit frm_base;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.DBCtrls, Vcl.ExtCtrls, Vcl.TitleBarCtrls;

type
  TFrmBase = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmBase: TFrmBase;

implementation

{$R *.dfm}

initialization
    ReportMemoryLeaksOnShutdown := True;

end.
