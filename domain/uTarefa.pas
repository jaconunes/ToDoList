unit uTarefa;

interface

type
  TStatusTarefa = (stPendente, stEmAndamento, stConcluida);

  TTarefa = class
  private
    FId             : Integer;
    FTitulo         : string;
    FDescricao      : string;
    FStatus         : TStatusTarefa;
    FDataCriacao    : TDateTime;
    FDataVencimento : TDateTime;
  public
    property Id             : Integer        read FId             write FId;
    property Titulo         : string         read FTitulo         write FTitulo;
    property Descricao      : string         read FDescricao      write FDescricao;
    property Status         : TStatusTarefa  read FStatus         write FStatus;
    property DataCriacao    : TDateTime      read FDataCriacao    write FDataCriacao;
    property DataVencimento : TDateTime      read FDataVencimento write FDataVencimento;
  end;

implementation

end.
