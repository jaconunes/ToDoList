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
begin
  FDriver.VendorLib      := ExtractFilePath(ParamStr(0)) + 'libmysql.dll';
  FDConnection.Connected := False;

  FDConnection.Params.Clear;
  FDConnection.Params.DriverID := 'MySQL';

  FDConnection.Params.Add('Server=localhost');
  FDConnection.Params.Add('Database=db_tarefas');
  FDConnection.Params.Add('User_Name=admin');
  FDConnection.Params.Add('Password=123456');
  FDConnection.Params.Add('Port=3306');
  FDConnection.Params.Add('CharacterSet=utf8mb4');

  FDConnection.LoginPrompt := False;
  FDConnection.Connected   := True;
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
