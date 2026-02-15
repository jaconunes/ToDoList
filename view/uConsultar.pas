unit uConsultar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, System.ImageList,
  Vcl.ImgList, Vcl.ComCtrls, Vcl.ToolWin, uTarefa, Vcl.ExtCtrls, uITarefaService, uServiceFactory;

type
  TfrmConsultar = class(TForm)
    grTarefas: TDBGrid;
    dsTarefas: TDataSource;
    cbStatus: TComboBox;
    ImageList1: TImageList;
    ToolBar1: TToolBar;
    btRetroceder: TToolButton;
    ToolButton1: TToolButton;
    btAvancar: TToolButton;
    ToolButton2: TToolButton;
    btAtualizar: TToolButton;
    ToolButton3: TToolButton;
    btExcluir: TToolButton;
    btEditar: TToolButton;
    ToolButton5: TToolButton;
    ToolButton4: TToolButton;
    ToolButton6: TToolButton;
    pnPrincipal: TPanel;
    procedure FormShow(Sender: TObject);
    procedure cbStatusChange(Sender: TObject);
    procedure btRetrocederClick(Sender: TObject);
    procedure btAvancarClick(Sender: TObject);
    procedure btAtualizarClick(Sender: TObject);
    procedure StatusSetText(Sender: TField; const Text: string);
    procedure grTarefasCellClick(Column: TColumn);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btExcluirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btEditarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grTarefasDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    FDSTarefas        : TDataSet;
    FTarefa           : TTarefa;
    FTarefaService    : ITarefaService;
    function GetStatusText(aIndex: Integer): string;
    procedure CarregaTarefas;
  public
    { Public declarations }
  end;

var
  frmConsultar: TfrmConsultar;

implementation

uses uCadastrar;

{$R *.dfm}

{ TfrmConsultar }

procedure TfrmConsultar.btAtualizarClick(Sender: TObject);
begin
  if dsTarefas.DataSet.State = dsEdit then
    dsTarefas.DataSet.Post;

  if Assigned(FTarefa) then
    FTarefa := TTarefa.Create;

  FTarefa.Id          := dsTarefas.DataSet.FieldByName('id').AsInteger;
  FTarefa.Titulo      := dsTarefas.DataSet.FieldByName('titulo').AsString;
  FTarefa.Descricao   := dsTarefas.DataSet.FieldByName('descricao').AsString;
  FTarefa.Status      := TStatusTarefa(dsTarefas.DataSet.FieldByName('status').AsInteger);
  FTarefa.DataCriacao := dsTarefas.DataSet.FieldByName('data_criacao').AsDateTime;

  FTarefaService.SetStatusDAO(sdUpdate);
  FTarefaService.Salvar(FTarefa);
end;

procedure TfrmConsultar.btAvancarClick(Sender: TObject);
begin
  FDSTarefas.Next;
end;

procedure TfrmConsultar.btEditarClick(Sender: TObject);
var
  wCad : TfrmCadastrar;
begin
  wCad := TfrmCadastrar.Create(Self);

  wCad.edCod.Text := FDSTarefas.FieldByName('id').AsString;
  wCad.edCod.OnExit(wCad.edCod);
  wCad.Show;
end;

procedure TfrmConsultar.btExcluirClick(Sender: TObject);
begin
  if FTarefaService.Excluir(dsTarefas.DataSet.FieldByName('id').AsInteger) then
    cbStatus.OnChange(cbStatus);
end;

procedure TfrmConsultar.btRetrocederClick(Sender: TObject);
begin
  FDSTarefas.Prior;
end;

procedure TfrmConsultar.CarregaTarefas;
begin
  if Assigned(FDSTarefas) then
    FDSTarefas.Free;

  FDSTarefas := FTarefaService.GetDSTarefas(cbStatus.ItemIndex - 1);

  dsTarefas.DataSet := FDSTarefas;
end;

function TfrmConsultar.GetStatusText(aIndex: Integer): string;
begin
  case aIndex of
    0: Result := 'Pendente';
    1: Result := 'Em andamento';
    2: Result := 'Concluída';
  else
    Result := '';
  end;
end;

procedure TfrmConsultar.cbStatusChange(Sender: TObject);
begin
  CarregaTarefas;
end;

procedure TfrmConsultar.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if (Owner <> nil) and (Owner.ClassName = 'TfrmCadastrar') then
     TForm(Owner).Enabled := True;

  FTarefa.Free;
end;

procedure TfrmConsultar.FormCreate(Sender: TObject);
begin
  FTarefa := TTarefa.Create;
  FTarefaService := TServiceFactory.CreateTarefaService;
end;

procedure TfrmConsultar.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) then
    btAtualizar.Click
  else
  if (Key = VK_DELETE) then
    btExcluir.Click;
end;

procedure TfrmConsultar.FormShow(Sender: TObject);
begin
  if (Owner <> nil) and (Owner.ClassName = 'TfrmCadastrar') then
     TForm(Owner).Enabled := False;

  CarregaTarefas;
  dsTarefas.DataSet.FieldByName('status').OnSetText := StatusSetText;
end;

procedure TfrmConsultar.grTarefasCellClick(Column: TColumn);
begin
  if Column.FieldName = 'status' then
    begin
      if not (dsTarefas.DataSet.State in dsEditModes) then
        dsTarefas.DataSet.Edit;

      grTarefas.SelectedField := Column.Field;
      grTarefas.EditorMode := True;
    end;
end;

procedure TfrmConsultar.grTarefasDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  wText: string;
  wStatusIndex: Integer;
begin
  if Column.FieldName = 'status' then
    begin
      wStatusIndex := Column.Field.AsInteger;
      
      if wStatusIndex = 0 then
        begin
          grTarefas.Canvas.Font.Color := clWhite;
          grTarefas.Canvas.Brush.Color := clRed;
          wText := 'Pendente';
        end
      else if wStatusIndex = 1 then
        begin
          grTarefas.Canvas.Font.Color := clWhite;
          grTarefas.Canvas.Brush.Color := $0000A5FF;
          wText := 'Em andamento';
        end
      else if wStatusIndex = 2 then
        begin
          grTarefas.Canvas.Font.Color := clWhite;
          grTarefas.Canvas.Brush.Color := clGreen;
          wText := 'Concluída';
        end
      else
        begin
          wText := '';
        end;

      grTarefas.Canvas.FillRect(Rect);
      grTarefas.Canvas.TextOut(Rect.Left + 2, Rect.Top + 2, wText);
      Exit;
    end;

  grTarefas.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmConsultar.StatusSetText(Sender: TField; const Text: string);
begin
  if SameText(Text, 'Pendente') or SameText(Text, '0') then
    Sender.AsInteger := 0
  else if SameText(Text, 'Em andamento') or SameText(Text, '1') then
    Sender.AsInteger := 1
  else if SameText(Text, 'Concluída') or SameText(Text, '2') then
    Sender.AsInteger := 2;
end;

end.
