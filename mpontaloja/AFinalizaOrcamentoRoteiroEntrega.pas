unit AFinalizaOrcamentoRoteiroEntrega;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Localizacao, StdCtrls, Mask, DBCtrls, Tabela, Buttons, Componentes1, ExtCtrls,
  PainelGradiente, FunSql, DB, DBClient, ConstMsg;

type
  TFAlteraEntregador = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    panel: TPanelColor;
    Label1: TLabel;
    PanelColor2: TPanelColor;
    BTransportadora: TSpeedButton;
    LTransportadora: TLabel;
    localiza: TConsultaPadrao;
    BFechar: TBitBtn;
    BitBtn1: TBitBtn;
    Aux: TSQL;
    ESeqRoteiro: TEditLocaliza;
    DataUax: TDataSource;
    ETransportadora: TEditLocaliza;
    EFilial: TEditLocaliza;
    ESeqOrcamento: TEditLocaliza;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
     function RSeqRoteiroEntregadorDisponivel: integer;
  public
    function FinalizaRoteiroEntrega(VpaSeqRoteiro:integer):string;
    function FinalizaRoteiroEntregaItem(VpaSeqRoteiro: integer): string;
    function AlteraEntregador(VpaSeqRoteiro: integer): string;
  end;

var
  FAlteraEntregador: TFAlteraEntregador;
  VprSeqRoteiroEntrega: integer;

implementation

uses APrincipal, ARoteiroEntrega, UnCotacao, Constantes;

{$R *.DFM}


{ **************************************************************************** }
procedure TFAlteraEntregador.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  ETransportadora.Atualiza;
end;

{******************************************************************************}
function TFAlteraEntregador.RSeqRoteiroEntregadorDisponivel: integer;
begin
  Aux.sql.clear;
  AdicionaSQLAbreTabela(Aux, ' SELECT SEQORCAMENTOROTEIRO, CODENTREGADOR, DATABERTURA, DATFECHAMENTO ' +
                             ' FROM ORCAMENTOROTEIROENTREGA ' +
                             ' WHERE CODENTREGADOR = ' + IntToStr(ETransportadora.AInteiro)+
                             ' AND DATFECHAMENTO IS NULL ');
  if not aux.Eof then
    result := Aux.FieldByName('SEQORCAMENTOROTEIRO').AsInteger
  else
    Result:= 0;
  Aux.Close;
end;

{ *************************************************************************** }
function TFAlteraEntregador.AlteraEntregador(VpaSeqRoteiro: integer): string;
var
  VpfSeqRoteiroEntregadorDestino: Integer;
begin
  if VpaSeqRoteiro <> 0 then
  begin
    Aux.sql.clear;
    VpfSeqRoteiroEntregadorDestino:= RSeqRoteiroEntregadorDisponivel;
    if VpfSeqRoteiroEntregadorDestino <> 0 then
    begin
      AdicionaSQLAbreTabela(Aux, ' SELECT * ' +
                                 ' FROM ORCAMENTOROTEIROENTREGAITEM ' +
                                 ' WHERE SEQORCAMENTOROTEIRO = ' + IntToStr(VpfSeqRoteiroEntregadorDestino));
      if not aux.Eof then
      begin
        Aux.Insert;
        Aux.FieldByName('SEQORCAMENTOROTEIRO').AsInteger := VpfSeqRoteiroEntregadorDestino;
        Aux.FieldByName('SEQORCAMENTO').AsInteger := ESeqOrcamento.AInteiro;
        Aux.FieldByName('CODFILIALORCAMENTO').AsInteger := EFilial.AInteiro;
        Aux.Post;
        result := Aux.AMensagemErroGravacao;
      end;
      Aux.Close;
      Aux.sql.clear;
      ExecutaComandoSql(Aux, ' DELETE FROM ORCAMENTOROTEIROENTREGAITEM '+
                             ' WHERE SEQORCAMENTOROTEIRO = ' + IntToStr(ESeqRoteiro.AInteiro) +
                             ' AND SEQORCAMENTO = ' + IntToStr(ESeqOrcamento.AInteiro) +
                             ' AND CODFILIALORCAMENTO = ' + IntToStr(EFilial.AInteiro));
      result := Aux.AMensagemErroGravacao;
    end;
  close;
end;
end;

{******************************************************************************}
procedure TFAlteraEntregador.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFAlteraEntregador.BitBtn1Click(Sender: TObject);
var
  VpfResultado: String;
begin
  VpfResultado:= AlteraEntregador(StrToInt(ESeqRoteiro.Text));
  if VpfResultado <> '' then
    aviso(VpfResultado)
end;

function TFAlteraEntregador.FinalizaRoteiroEntrega(
  VpaSeqRoteiro: integer): string;
begin
  if VpaSeqRoteiro <> 0 then
  begin
    Aux.sql.clear;
    AdicionaSQLAbreTabela(Aux, ' SELECT SEQORCAMENTOROTEIRO, CODENTREGADOR, DATABERTURA, DATFECHAMENTO ' +
                               ' FROM ORCAMENTOROTEIROENTREGA ' +
                               ' WHERE SEQORCAMENTOROTEIRO = ' + IntToStr(VpaSeqRoteiro));
    Aux.Edit;
    Aux.FieldByName('DATFECHAMENTO').AsDateTime := now;
    if Aux.FieldByName('CODENTREGADOR').AsInteger <> StrToInt(ETransportadora.Text) then
      Aux.FieldByName('CODENTREGADOR').AsInteger := StrToInt(ETransportadora.Text);
    Aux.Post;
    result := Aux.AMensagemErroGravacao;
    Aux.Close;

    FinalizaRoteiroEntregaItem(VpaSeqRoteiro);
  end;
  close;
end;

{******************************************************************************}
function TFAlteraEntregador.FinalizaRoteiroEntregaItem(
  VpaSeqRoteiro: integer): string;
begin
if VpaSeqRoteiro <> 0 then
  begin
    Aux.sql.clear;
    AdicionaSQLAbreTabela(Aux, ' SELECT DATFECHAMENTO, CODFILIALORCAMENTO, SEQORCAMENTO ' +
                               ' FROM ORCAMENTOROTEIROENTREGAITEM ' +
                               ' WHERE SEQORCAMENTOROTEIRO = ' + IntToStr(VpaSeqRoteiro));
    while not aux.Eof do
    begin
      Aux.Edit;
      Aux.FieldByName('DATFECHAMENTO').AsDateTime := now;
      Aux.Post;
      result := Aux.AMensagemErroGravacao;
      FunCotacao.AlteraEstagioCotacao(Aux.FieldByName('CODFILIALORCAMENTO').AsInteger,varia.CodigoUsuario,Aux.FieldByName('SEQORCAMENTO').AsInteger, varia.EstagioFinalOrdemProducao, '');
      aux.Next;
    end;
    Aux.Close;
 end;
  close;
end;

{******************************************************************************}
procedure TFAlteraEntregador.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Aux.Close;
  FRoteiroEntrega.ORCAMENTOROTEIROENTREGA.Close;
  FRoteiroEntrega.ORCAMENTOROTEIROENTREGA.Open;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFAlteraEntregador]);
end.
