unit uIFeriadoService;

interface

uses
  System.SysUtils, uFeriadoModel;

type
  IFeriadoService = interface
    ['{A12B34C5-D678-4E9F-ABCD-123456789999}']
    function GetFeriado(const prData: TDate): TFeriado;
  end;

implementation

end.

