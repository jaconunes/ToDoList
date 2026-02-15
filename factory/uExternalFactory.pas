unit uExternalFactory;

interface

uses uIFeriadoService;

type
  TExternalFactory = class
  public
    class function CreateFeriadoService: IFeriadoService;
  end;

implementation

uses
  uFeriadoService;

class function TExternalFactory.CreateFeriadoService: IFeriadoService;
begin
  Result := TFeriadoService.Create;
end;

end.

