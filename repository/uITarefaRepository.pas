unit uITarefaRepository;

interface

uses
  Data.DB, uTarefa;

type
  ITarefaRepository = interface
    ['{B3E1A2F4-8C55-4F5A-9C7E-123456789001}']
    procedure Inserir(prTarefa: TTarefa);
    procedure Atualizar(prTarefa: TTarefa);
    procedure Excluir(prId: Integer);
    function TarefaPorId(prId : Integer) : TTarefa;
    function GetDSTarefas(prStatus: Integer = -1) : TDataSet;
  end;

implementation

end.

