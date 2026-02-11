unit uServiceFactory;

interface

uses uITarefaService;

type
  TServiceFactory = class
  public
    class function CreateTarefaService: ITarefaService;
  end;

implementation

uses FireDAC.Comp.Client, uDMConexao, uTarefaRepository, uTarefaService,uITarefaRepository;

class function TServiceFactory.CreateTarefaService: ITarefaService;
var
  wQuery : TFDQuery;
  wDAO   : ITarefaRepository;
begin
  wQuery := TFDQuery.Create(nil);
  wQuery.Connection := dmConexao.FDConnection;

  wDAO := TTarefaDAO.Create(wQuery);
  Result := TTarefaService.Create(wDAO);
end;

end.

