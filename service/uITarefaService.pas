unit uITarefaService;

interface

uses Data.DB, uTarefa;

type
  TStatusDAO = (sdInsert, sdUpdate);

type
  ITarefaService = interface
    procedure Salvar(prTarefa: TTarefa);
    procedure Excluir(prId: Integer);
    function TarefaPorId(prId: Integer) : TTarefa;
    function GetDSTarefas(prStatus: Integer = -1): TDataSet;
    function GetStatusDAO : TStatusDAO;
    procedure SetStatusDAO(prStatusDAO : TStatusDAO);
  end;


implementation

end.
