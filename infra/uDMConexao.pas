unit uDMConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Comp.UI,
  FireDAC.Phys.MySQL, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.PG,
  FireDAC.Phys.PGDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TudmConexao = class(TDataModule)
    FDConnection : TFDConnection;
    FDriver      : TFDPhysMySQLDriverLink;
    FDWaitCursor : TFDGUIxWaitCursor;
    FDQuery      : TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  public
    function GetFDQuery : TFDQuery;
    procedure Conectar;
    function GetConnection : TFDConnection;
  end;

var
  dmConexao: TudmConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TudmConexao.Conectar;
var
  wSLConfig : TStringList;
begin
  wSLConfig := TStringList.Create;
  try
    wSLConfig.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'tarefas.config');
    FDriver.VendorLib      := ExtractFilePath(ParamStr(0)) + 'libmysql.dll';
    FDConnection.Connected := False;

    FDConnection.Params.Clear;
    FDConnection.Params.DriverID := 'MySQL';

    FDConnection.Params.Add(Format('Server=%s', [wSLConfig.Values['server']]));
    FDConnection.Params.Add(Format('Database=%s', [wSLConfig.Values['database']]));
    FDConnection.Params.Add(Format('User_Name=%s', [wSLConfig.Values['username']]));
    FDConnection.Params.Add(Format('Password=%s', [wSLConfig.Values['password']]));
    FDConnection.Params.Add(Format('Port=%s', [wSLConfig.Values['port']]));
    FDConnection.Params.Add('CharacterSet=utf8mb4');

    FDConnection.LoginPrompt := False;
    FDConnection.Connected   := True;
  finally
    wSLConfig.Free;
  end;
end;

procedure TudmConexao.DataModuleCreate(Sender: TObject);
begin
  FDQuery.Connection := FDConnection;
end;

function TudmConexao.GetConnection: TFDConnection;
begin
  Result := FDConnection;
end;

function TudmConexao.GetFDQuery: TFDQuery;
begin
  Result := FDQuery;
end;

end.
