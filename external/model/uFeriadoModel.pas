unit uFeriadoModel;

interface

uses
  System.SysUtils;

type
  TFeriado = class
  private
    FData: TDate;
    FDescricao: string;
  public
    constructor Create(const prData: TDate; const prDescricao: string);

    property Data      : TDate  read FData;
    property Descricao : string read FDescricao;
  end;

implementation

constructor TFeriado.Create(const prData: TDate; const prDescricao: string);
begin
  FData      := prData;
  FDescricao := prDescricao;
end;

end.

