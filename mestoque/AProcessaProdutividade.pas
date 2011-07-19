unit AProcessaProdutividade;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, ComCtrls, Componentes1, Buttons, ExtCtrls, PainelGradiente, Db, UnOrdemProducao,
  DBTables, DBClient, Tabela;

type
  TFProcessaProdutividade = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BarraStatus: TStatusBar;
    Progresso: TProgressBar;
    BProcessar: TBitBtn;
    BFechar: TBitBtn;
    EData: TCalendario;
    Label1: TLabel;
    Aux: TSQL;
    Celulas: TSQL;
    Produtividade: TSQL;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BProcessarClick(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
  private
    { Private declarations }
    FunOrdemProducao : TRBFuncoesOrdemProducao;
    function RQtdCelulas(VpaData: TDateTime):Integer;
    procedure CorrigeProdutividadeColetas(VpaCodCelula : Integer;VpaData : TDateTime);
    procedure ProcessaProdutividade;
    procedure AtualizaStatus(VpaTexto : String);
  public
    { Public declarations }
  end;

var
  FProcessaProdutividade: TFProcessaProdutividade;

implementation

uses APrincipal, FunSql, Fundata, FunNumeros, FunString;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFProcessaProdutividade.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EData.DateTime := date;
  FunOrdemProducao := TRBFuncoesOrdemProducao.cria(FPrincipal.BaseDados);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFProcessaProdutividade.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunOrdemProducao.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

function TFProcessaProdutividade.RQtdCelulas(VpaData: TDateTime):Integer;
Begin
  AdicionaSQLAbreTabela(Aux,'select COUNT(DISTINCT(CODCELULA)) QTD from COLETAFRACAOOP '+
                            ' Where '+SQLTextoDataEntreAAAAMMDD('DATINICIO',VpaDAta,INCDia(VpaData,1),false));
  result := Aux.FieldByName('QTD').AsInteger;
  Aux.Close;
end;

{******************************************************************************}
procedure TFProcessaProdutividade.CorrigeProdutividadeColetas(VpaCodCelula : Integer;VpaData : TDateTime);
var
  VpfQtdIdeal : Double;
  VpfProdutividade : Integer;
begin
  AdicionaSQLAbreTabela(Produtividade,'select COL.CODFILIAL, COL.SEQORDEM, COL.SEQFRACAO, COL.SEQESTAGIO, COL.SEQCOLETA, '+
                                      ' COL.QTDMINUTOS, COL.QTDCOLETADO, ESP.QTDPRODUCAOHORA '+
                                      ' from COLETAFRACAOOP COL, FRACAOOPESTAGIO FRE, PRODUTOESTAGIO ESP '+
                                      ' where COL.CODCELULA = '+IntToStr(VpaCodCelula)+
                                      SQLTextoDataEntreAAAAMMDD('DATINICIO',VpaDAta,INCDia(VpaData,1),true)+
                                      ' AND COL.CODFILIAL = FRE.CODFILIAL '+
                                      ' AND COL.SEQORDEM = FRE.SEQORDEM '+
                                      ' AND COL.SEQFRACAO = FRE.SEQFRACAO '+
                                      ' AND COL.SEQESTAGIO = FRE.SEQESTAGIO '+
                                      ' AND FRE.SEQPRODUTO = ESP.SEQPRODUTO '+
                                      ' AND FRE.SEQESTAGIO = ESP.SEQESTAGIO');
  While not Produtividade.Eof do
  begin
    AtualizaStatus('Reprocessando produtividade celula '+IntToStr(VpaCodCelula)+' - Coleta '+Produtividade.FieldByName('SEQCOLETA').AsString);
    VpfQtdIdeal := (Produtividade.FieldByName('QTDMINUTOS').AsInteger * Produtividade.FieldByName('QTDPRODUCAOHORA').AsFloat)/60;
    VpfProdutividade := RetornaInteiro((Produtividade.FieldByName('QTDCOLETADO').AsFloat * 100)/VpfQtdIdeal);
    ExecutaComandoSql(Aux,'Update COLETAFRACAOOP '+
                          ' SET QTDPRODUCAOIDEAL = '+SubstituiStr(FormatFloat('0.00',VpfQtdIdeal),',','.')+
                          ' , QTDPRODUCAOHORA = '+SubstituiStr(FormatFloat('0.0000',Produtividade.FieldByName('QTDPRODUCAOHORA').AsFloat),',','.')+
                          ' , PERPRODUTIVIDADE = '+IntToStr(VpfProdutividade)+
                          ' Where CODFILIAL = '+Produtividade.FieldByName('CODFILIAL').AsString+
                          ' AND SEQORDEM = '+Produtividade.FieldByName('SEQORDEM').AsString+
                          ' AND SEQFRACAO = '+Produtividade.FieldByName('SEQFRACAO').AsString+
                          ' AND SEQESTAGIO = '+Produtividade.FieldByName('SEQESTAGIO').AsString+
                          ' AND SEQCOLETA = '+Produtividade.FieldByName('SEQCOLETA').AsString);
    Produtividade.next;
  end;
  Produtividade.close;
end;

{******************************************************************************}
procedure TFProcessaProdutividade.ProcessaProdutividade;
begin
  Progresso.Max := RQtdCelulas(EData.DateTime);
  Progresso.Position := 0;

  AdicionaSQLAbreTabela(Celulas,'select DISTINCT(CODCELULA) CELULA from COLETAFRACAOOP '+
                            'Where '+SQLTextoDataEntreAAAAMMDD('DATINICIO',EData.DateTime,INCDia(EData.DateTime,1),false));
  While not Celulas.Eof do
  begin
    CorrigeProdutividadeColetas(Celulas.FieldByName('CELULA').AsInteger,EData.DateTime);
    AtualizaStatus('Processando produtividade Celula '+Celulas.FieldByName('CELULA').AsString);
    FunOrdemProducao.ProcessaProdutividadeCelula(Celulas.FieldByName('CELULA').AsInteger,EData.DateTime);
    Celulas.next;
    Progresso.Position := Progresso.Position + 1;
  end;
  Celulas.Close;
  AtualizaStatus('Produtividade reprocessada com sucesso.');
end;

{******************************************************************************}
procedure TFProcessaProdutividade.AtualizaStatus(VpaTexto : String);
begin
  BarraStatus.Panels[0].Text := VpaTexto;
end;

{******************************************************************************}
procedure TFProcessaProdutividade.BProcessarClick(Sender: TObject);
begin
  ProcessaProdutividade;
end;

{******************************************************************************}
procedure TFProcessaProdutividade.BFecharClick(Sender: TObject);
begin
  close;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFProcessaProdutividade]);
end.
