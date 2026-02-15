unit uTarefaRepository;

interface

uses
  System.Generics.Collections, FireDAC.Comp.Client, uTarefa, Data.DB, uITarefaRepository;

type
  TTarefaDAO = class(TInterfacedObject, ITarefaRepository)
  private
    FQuery: TFDQuery;
  public
    constructor Create(prQuery: TFDQuery);
    procedure Inserir(prTarefa: TTarefa);
    procedure Atualizar(prTarefa: TTarefa);
    procedure Excluir(prId: Integer);
    function TarefaPorId(prId : Integer) : TTarefa;
    function GetDSTarefas(prStatus: Integer = -1) : TDataSet;
  end;

implementation

constructor TTarefaDAO.Create(prQuery: TFDQuery);
begin
  FQuery := prQuery;
end;

procedure TTarefaDAO.Inserir(prTarefa: TTarefa);
begin
  FQuery.SQL.Text := 'INSERT INTO tarefas (titulo, descricao, status, data_vencimento) ' +
                     'VALUES (:titulo, :descricao, :status, :data_vencimento)';

  FQuery.ParamByName('titulo').AsString             := prTarefa.Titulo;
  FQuery.ParamByName('descricao').AsString          := prTarefa.Descricao;
  FQuery.ParamByName('status').AsInteger            := Ord(prTarefa.Status);
  FQuery.ParamByName('data_vencimento').AsDateTime  := prTarefa.DataVencimento;
  FQuery.ExecSQL;

  prTarefa.Id := FQuery.Connection.GetLastAutoGenValue('tarefas');
end;

procedure TTarefaDAO.Atualizar(prTarefa: TTarefa);
begin
  FQuery.SQL.Text := 'UPDATE tarefas SET titulo = :titulo, descricao = :descricao, status = :status, data_vencimento = :data_vencimento ' +
                     'WHERE id=:id';

  FQuery.ParamByName('id').AsInteger                := prTarefa.Id;
  FQuery.ParamByName('titulo').AsString             := prTarefa.Titulo;
  FQuery.ParamByName('descricao').AsString          := prTarefa.Descricao;
  FQuery.ParamByName('status').AsInteger            := Ord(prTarefa.Status);
  FQuery.ParamByName('data_vencimento').AsDateTime  := prTarefa.DataVencimento;
  FQuery.ExecSQL;
end;

procedure TTarefaDAO.Excluir(prId: Integer);
begin
  FQuery.SQL.Text := 'DELETE FROM tarefas WHERE id=:id';
  FQuery.ParamByName('id').AsInteger := prId;
  FQuery.ExecSQL;
end;

function TTarefaDAO.GetDSTarefas(prStatus: Integer): TDataSet;
var
  wQry: TFDQuery;
begin
  wQry := TFDQuery.Create(nil);
  try
    wQry.Connection := FQuery.Connection;
    wQry.SQL.Add('SELECT id, titulo, CAST(descricao AS VARCHAR(255)) AS descricao, ' +
                 'status, data_criacao, data_vencimento ' +
                 'FROM tarefas');

    if prStatus >= 0 then
      begin
        wQry.SQL.Add('WHERE status = :status');
        wQry.ParamByName('status').AsInteger := prStatus;
      end;

    wQry.SQL.Add('ORDER BY data_criacao DESC');
    wQry.Open;

    Result := wQry;
  except
    wQry.Free;
    raise;
  end;
end;

function TTarefaDAO.TarefaPorId(prId: Integer): TTarefa;
var
  wTarefa : TTarefa;
begin
  FQuery.SQL.Text := 'SELECT * from tarefas where id = :id';
  FQuery.ParamByName('id').AsInteger := prId;

  FQuery.Open;

  if not FQuery.Eof then
    begin
      wTarefa             := TTarefa.Create;
      wTarefa.Id          := FQuery.FieldByName('id').AsInteger;
      wTarefa.Titulo      := FQuery.FieldByName('titulo').AsString;
      wTarefa.Descricao   := FQuery.FieldByName('descricao').AsString;
      wTarefa.Status      := TStatusTarefa(FQuery.FieldByName('status').AsInteger);
      wTarefa.DataCriacao := FQuery.FieldByName('data_criacao').AsDateTime;

      Result := wTarefa;
    end
  else
    Result := nil;
end;

end.
