unit APesquisaSatisfacaoChamado;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Grids, DBGrids, Tabela, Series,TeeProcs,TeEngine,
  DBKeyViolation, Db, DBTables, StdCtrls, Buttons, ComCtrls, Localizacao,
  DBCtrls, Graficos, DBClient;

type
  TFPesquisaSatisfacaoChamado = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BGraficos: TBitBtn;
    BFechar: TBitBtn;
    PesquisaCorpo: TSQL;
    DataPesquisaCorpo: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    Localiza: TConsultaPadrao;
    Label8: TLabel;
    SpeedButton3: TSpeedButton;
    LNomTecnico: TLabel;
    ETecnico: TEditLocaliza;
    PesquisaCorpoCODFILIAL: TFMTBCDField;
    PesquisaCorpoSEQPESQUISA: TFMTBCDField;
    PesquisaCorpoDATPESQUISA: TSQLTimeStampField;
    PesquisaCorpoNUMCHAMADO: TFMTBCDField;
    PesquisaCorpoNOMTECNICO: TWideStringField;
    PesquisaCorpoC_NOM_USU: TWideStringField;
    PesquisaCorpoNOMPESQUISA: TWideStringField;
    PesquisaItem: TSQL;
    DataPesquisaItem: TDataSource;
    PesquisaItemDESSIMNAO: TWideStringField;
    PesquisaItemDESTEXTO: TWideStringField;
    PesquisaItemNUMNOTA: TFMTBCDField;
    PesquisaItemNUMBOMRUIM: TFMTBCDField;
    PesquisaItemDESTITULO: TWideStringField;
    PesquisaItemDESPERGUNTA: TWideStringField;
    PesquisaItemTIPRESPOSTA: TFMTBCDField;
    PanelColor3: TPanelColor;
    GridIndice1: TGridIndice;
    PanelColor4: TPanelColor;
    PanelColor5: TPanelColor;
    DBMemoColor1: TDBMemoColor;
    PanelColor6: TPanelColor;
    DBMemoColor2: TDBMemoColor;
    GridIndice2: TGridIndice;
    PesquisaItemResposta: TWideStringField;
    Splitter1: TSplitter;
    Label3: TLabel;
    SpeedButton1: TSpeedButton;
    LNomPesquisa: TLabel;
    ECodPesquisa: TEditLocaliza;
    Perguntas: TSQL;
    Grafico: TRBGraDinamico;
    Resposta: TSQL;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    PesquisaCorpoC_NOM_CLI: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure PesquisaItemCalcFields(DataSet: TDataSet);
    procedure PesquisaCorpoAfterScroll(DataSet: TDataSet);
    procedure ETecnicoFimConsulta(Sender: TObject);
    procedure BGraficosClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
    procedure AtualizaConsulta;
    procedure AdicionaFiltros(VpaSelect : TStrings);
    procedure CarTitulosGrafico;
    procedure PosPerguntas;
    procedure GraficoPerguntaSimNao(VpaSeqPergunta : Integer;VpaTitulo : String;VpfSerieSim, VpfSerieNao : TBarSeries);
    procedure GraficoOtimoRuim(VpaSeqPergunta : Integer;VpaTitulo : String; VpaSerieOtimo,VpfSerieBom,VpfSerieRegular,VpfSerieRuim,VpfSeriePessimo,VpfSerieSemOpiniao : TBarSeries);
    procedure GraficoNota(VpaSeqPergunta : Integer;VpaTitulo : String; VpfSerieNota : TBarSeries);
    procedure GeraGraficoOtimoRuim;
    procedure GeraGraficoNota;
    procedure GeraGraficoPesquisa;
  public
    { Public declarations }
  end;

var
  FPesquisaSatisfacaoChamado: TFPesquisaSatisfacaoChamado;

implementation

uses APrincipal, FunData, FunSql, Constmsg, UnCrystal, Constantes;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFPesquisaSatisfacaoChamado.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EDatInicio.DateTime := PrimeiroDiaMes(date);
  EDatFim.DateTime := UltimoDiaMes(date);
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFPesquisaSatisfacaoChamado.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  PesquisaCorpo.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
procedure TFPesquisaSatisfacaoChamado.AtualizaConsulta;
begin
  PesquisaCorpo.Close;
  PesquisaCorpo.Sql.Clear;
  PesquisaCorpo.sql.add('SELECT SAC.CODFILIAL, SAC.SEQPESQUISA, SAC.DATPESQUISA, SAC.NUMCHAMADO, '+
                        ' TEC.NOMTECNICO, ' +
                        ' USU.C_NOM_USU, ' +
                        ' PES.NOMPESQUISA, '+
                        ' CLI.C_NOM_CLI '+
                        ' FROM  SATISFACAOCHAMADOCORPO SAC, TECNICO TEC, CADUSUARIOS USU, PESQUISASATISFACAOCORPO PES, CHAMADOCORPO CHA, CADCLIENTES CLI ' +
                        ' Where TEC.CODTECNICO = SAC.CODTECNICO '+
                        ' AND SAC.CODUSUARIO = USU.I_COD_USU '+
                        ' AND SAC.CODPESQUISA = PES.CODPESQUISA '+
                        ' AND SAC.CODFILIAL = CHA.CODFILIAL '+
                        ' AND SAC.NUMCHAMADO = CHA.NUMCHAMADO '+
                        ' AND CHA.CODCLIENTE = CLI.I_COD_CLI ' );
  AdicionaFiltros(PesquisaCorpo.sql);
  PesquisaCorpo.open;
end;

{******************************************************************************}
procedure TFPesquisaSatisfacaoChamado.AdicionaFiltros(VpaSelect : TStrings);
begin
  VpaSelect.add(SQLTextoDataEntreAAAAMMDD('SAC.DATPESQUISA',EDatInicio.DateTime,IncDia(EDatFim.DateTime,1),true));
  if ETecnico.AInteiro <> 0 then
    VpaSelect.add('and SAC.CODTECNICO = '+ETecnico.Text);
  if ECodPesquisa.AInteiro <> 0 THEN
    VpaSelect.Add('and SAC.CODPESQUISA = ' +ECodPesquisa.Text);
end;

{******************************************************************************}
procedure TFPesquisaSatisfacaoChamado.PosPerguntas;
begin
  PesquisaItem.CLOSE;
  IF PesquisaCorpoCODFILIAL.AsInteger <> 0 THEN
    AdicionaSQLAbreTabela(PesquisaItem,' Select SCI.DESSIMNAO, SCI.DESTEXTO, SCI.NUMNOTA, SCI.NUMBOMRUIM, '+
                        ' PSI.DESTITULO, PSI.DESPERGUNTA, PSI.TIPRESPOSTA '+
                        ' from SATISFACAOCHAMADOITEM SCI, PESQUISASATISFACAOITEM PSI '+
                        ' Where SCI.CODPESQUISA = PSI.CODPESQUISA ' +
                        ' AND SCI.SEQPERGUNTA = PSI.SEQPERGUNTA ' +
                        ' AND SCI.CODFILIAL = ' +PesquisaCorpoCODFILIAL.AsString+
                        ' AND SCI.SEQPESQUISA = ' +PesquisaCorpoSEQPESQUISA.AsString+
                        ' order by SCI.SEQPERGUNTA');
end;

{******************************************************************************}
procedure TFPesquisaSatisfacaoChamado.CarTitulosGrafico;
begin
  if ETecnico.AInteiro <> 0 then
    Grafico.AInfo.TituloGrafico := 'Pesquisa Satisfação '+LNomTecnico.caption
  else
    Grafico.AInfo.TituloGrafico := 'Pesquisa Satisfação ';

  Grafico.AInfo.TituloFormulario := 'Pesquisa Satisfação';
  Grafico.AInfo.TituloY := 'Critérios';
    Grafico.AInfo.RodapeGrafico := 'Pesquisa : ' + ECodPesquisa.Text +'-'+LNomPesquisa.caption;
end;

{******************************************************************************}
procedure TFPesquisaSatisfacaoChamado.GraficoPerguntaSimNao(VpaSeqPergunta : Integer;VpaTitulo : String;VpfSerieSim, VpfSerieNao : TBarSeries);
var
  VpfQtdSim, VpfQtdNao : Integer;
begin
  Resposta.Sql.clear;
  Resposta.sql.add('select  COUNT(DESSIMNAO) QTD ,  DESSIMNAO '+
                   ' FROM SATISFACAOCHAMADOCORPO SAC, SATISFACAOCHAMADOITEM SCI, PESQUISASATISFACAOITEM PSI ' +
                   ' Where SAC.CODFILIAL = SCI.CODFILIAL '+
                   ' AND SAC.SEQPESQUISA = SCI.SEQPESQUISA '+
                   ' AND SCI.CODPESQUISA = PSI.CODPESQUISA '+
                   ' AND SCI.SEQPERGUNTA = PSI.SEQPERGUNTA '+
                   ' AND SCI.SEQPERGUNTA = ' + IntToStr(VpaSeqPergunta));
  AdicionaFiltros(Resposta.Sql);
  Resposta.sql.add('GROUP BY SCI.DESSIMNAO ');
  Resposta.open;

  VpfQtdSim := 0;
  VpfQtdNao := 0;
  While not Resposta.Eof do
  begin
    if Resposta.FieldByname('DESSIMNAO').AsString = 'S' THEN
      VpfQtdSim := Resposta.FieldByname('QTD').AsInteger
    Else
      VpfQtdNao := Resposta.FieldByname('QTD').AsInteger;
    resposta.next;
  end;
  Resposta.close;
  Grafico.AGrafico.series[0].AddY(VpfQtdSim,VpaTitulo,clGreen);
  Grafico.AGrafico.series[1].AddY(VpfQtdNao,VpaTitulo,clRed);
end;

{******************************************************************************}
procedure TFPesquisaSatisfacaoChamado.GraficoOtimoRuim(VpaSeqPergunta : Integer;VpaTitulo : String; VpaSerieOtimo,VpfSerieBom,VpfSerieRegular,VpfSerieRuim,VpfSeriePessimo,VpfSerieSemOpiniao : TBarSeries);
var
  VpfQtdOtimo, VpfQtdBom, VpfQtdRegular, VpfQtdRuim, VpfQtdPessimo, VpfQtdSemOpiniao : Integer;
begin
  Resposta.Sql.clear;
  Resposta.sql.add('select  COUNT(NUMBOMRUIM) QTD ,  NUMBOMRUIM '+
                   ' FROM SATISFACAOCHAMADOCORPO SAC, SATISFACAOCHAMADOITEM SCI, PESQUISASATISFACAOITEM PSI ' +
                   ' Where SAC.CODFILIAL = SCI.CODFILIAL '+
                   ' AND SAC.SEQPESQUISA = SCI.SEQPESQUISA '+
                   ' AND SCI.CODPESQUISA = PSI.CODPESQUISA '+
                   ' AND SCI.SEQPERGUNTA = PSI.SEQPERGUNTA '+
                   ' AND SCI.SEQPERGUNTA = ' + IntToStr(VpaSeqPergunta));
  AdicionaFiltros(Resposta.Sql);
  Resposta.sql.add('GROUP BY SCI.NUMBOMRUIM');
  Resposta.open;

  VpfQtdOtimo := 0;
  VpfQtdBom := 0;
  VpfQtdRegular := 0;
  VpfQtdRuim := 0;
  VpfQtdPessimo := 0;
  VpfQtdSemOpiniao := 0;
  While not Resposta.Eof do
  begin
    case Resposta.FieldByname('NUMBOMRUIM').AsInteger of
      0 : VpfQtdOtimo := Resposta.FieldByname('QTD').AsInteger;
      1 : VpfQtdBom := Resposta.FieldByname('QTD').AsInteger;
      2 : VpfQtdRegular := Resposta.FieldByname('QTD').AsInteger;
      3 : VpfQtdRuim := Resposta.FieldByname('QTD').AsInteger;
      4 : VpfQtdPessimo := Resposta.FieldByname('QTD').AsInteger;
      5 : VpfQtdSemOpiniao := Resposta.FieldByname('QTD').AsInteger;
    end;
    resposta.next;
  end;
  Resposta.close;
  Grafico.AGrafico.series[0].Add(VpfQtdOtimo,VpaTitulo,clGreen);
  Grafico.AGrafico.series[1].Add(VpfQtdBom,VpaTitulo,clOlive);
  Grafico.AGrafico.series[2].Add(VpfQtdRegular,VpaTitulo,clgray);
  Grafico.AGrafico.series[3].Add(VpfQtdRuim,VpaTitulo,$00B8BFEB);
  Grafico.AGrafico.series[4].Add(VpfQtdPessimo,VpaTitulo,clRed);
  Grafico.AGrafico.series[5].Add(VpfQtdSemOpiniao,VpaTitulo,clwhite);
end;

{******************************************************************************}
procedure TFPesquisaSatisfacaoChamado.GraficoNota(VpaSeqPergunta : Integer;VpaTitulo : String;VpfSerieNota : TBarSeries);
var
  VpfQtdSim, VpfQtdNao : Integer;
begin
  Resposta.Sql.clear;
  Resposta.sql.add('select  COUNT(SCI.NUMNOTA) QTD ,  SUM(SCI.NUMNOTA)NOTA '+
                   ' FROM SATISFACAOCHAMADOCORPO SAC, SATISFACAOCHAMADOITEM SCI, PESQUISASATISFACAOITEM PSI ' +
                   ' Where SAC.CODFILIAL = SCI.CODFILIAL '+
                   ' AND SAC.SEQPESQUISA = SCI.SEQPESQUISA '+
                   ' AND SCI.CODPESQUISA = PSI.CODPESQUISA '+
                   ' AND SCI.SEQPERGUNTA = PSI.SEQPERGUNTA '+
                   ' and SCI.NUMNOTA >= 0 '+
                   ' AND SCI.SEQPERGUNTA = ' + IntToStr(VpaSeqPergunta));
  AdicionaFiltros(Resposta.Sql);
  Resposta.open;

  Grafico.AGrafico.series[0].Add(Resposta.FieldByname('NOTA').AsFloat /Resposta.FieldByname('QTD').AsInteger ,VpaTitulo,clBlue);
  Resposta.close;
end;

{******************************************************************************}
procedure TFPesquisaSatisfacaoChamado.GeraGraficoOtimoRuim;
var
  VpfSerieOtimo, VpfSerieBom,VpfSerieRegular,VpfSerieRuim, VpfSeriePessimo,VpfSerieSemOpiniao : TBarSeries;
begin
  if ECodPesquisa.AInteiro <> 0 then
  begin
    Grafico.InicializaGrafico;

    VpfSerieOtimo := TBarSeries.Create(self);
    Grafico.AGrafico.AddSeries(VpfSerieOtimo);
    VpfSerieOtimo.Marks.Style := smsValue;
    VpfSerieOtimo.ColorEachPoint := false;
    VpfSerieOtimo.BarBrush.Color := clGreen;
    VpfSerieOtimo.Title := 'Otimo';

    VpfSerieBom := TBarSeries.Create(self);
    Grafico.AGrafico.AddSeries(VpfSerieBom);
    VpfSerieBom.Marks.Style := smsValue;
    VpfSerieBom.ColorEachPoint := false;
    VpfSerieBom.BarBrush.Color := clOlive;
    VpfSerieBom.Title := 'Bom';

    VpfSerieRegular := TBarSeries.Create(self);
    Grafico.AGrafico.AddSeries(VpfSerieRegular);
    VpfSerieRegular.Marks.Style := smsValue;
    VpfSerieRegular.ColorEachPoint := false;
    VpfSerieRegular.BarBrush.Color := clGray;
    VpfSerieRegular.Title := 'Regular';

    VpfSerieRuim := TBarSeries.Create(self);
    Grafico.AGrafico.AddSeries(VpfSerieRuim);
    VpfSerieRuim.Marks.Style := smsValue;
    VpfSerieRuim.ColorEachPoint := false;
    VpfSerieRuim.BarBrush.Color := $00B8BFEB;
    VpfSerieRuim.Title := 'Ruim';

    VpfSeriePessimo := TBarSeries.Create(self);
    Grafico.AGrafico.AddSeries(VpfSeriePessimo);
    VpfSeriePessimo.Marks.Style := smsValue;
    VpfSeriePessimo.ColorEachPoint := false;
    VpfSeriePessimo.BarBrush.Color := clred;
    VpfSeriePessimo.Title := 'Péssimo';

    VpfSerieSemOpiniao := TBarSeries.Create(self);
    Grafico.AGrafico.AddSeries(VpfSerieSemOpiniao);
    VpfSerieSemOpiniao.Marks.Style := smsValue;
    VpfSerieSemOpiniao.ColorEachPoint := false;
    VpfSerieSemOpiniao.BarBrush.Color := clwhite;
    VpfSerieSemOpiniao.Title := 'Sem Opinião';

    AdicionaSQLAbreTabela(Perguntas,'Select * from PESQUISASATISFACAOITEM PSI '+
                                  ' Where CODPESQUISA = ' +ECodPesquisa.text+
                                  ' AND TIPRESPOSTA = 2 '+
                                  ' order by SEQPERGUNTA');
    While not  perguntas.eof do
    begin
      GraficoOtimoRuim(Perguntas.FieldByname('SEQPERGUNTA').AsInteger,Perguntas.FieldByname('DESTITULO').AsString,VpfSerieOtimo,VpfSerieBom,VpfSerieRegular,VpfSerieRuim,VpfSeriePessimo,VpfSerieSemOpiniao);
      Perguntas.next;
    end;
    CarTitulosGrafico;
    Grafico.Executa;
  end
  else
    aviso('PESQUISA NÃO PREENCHIDO!!!#13É necessário escolher o codigo da pesquisa nos filtros acima.');
end;

{******************************************************************************}
procedure TFPesquisaSatisfacaoChamado.GeraGraficoNota;
var
  VpfSerieNota : TBarSeries;
begin
  if ECodPesquisa.AInteiro <> 0 then
  begin
    Grafico.InicializaGrafico;

    VpfSerieNota := TBarSeries.Create(self);
    Grafico.AGrafico.AddSeries(VpfSerieNota);
    VpfSerieNota.Marks.Style := smsValue;
    VpfSerieNota.ColorEachPoint := false;
    VpfSerieNota.BarBrush.Color := clBlue;
    VpfSerieNota.Title := 'Nota';

    AdicionaSQLAbreTabela(Perguntas,'Select * from PESQUISASATISFACAOITEM PSI '+
                                  ' Where CODPESQUISA = ' +ECodPesquisa.text+
                                  ' AND TIPRESPOSTA = 3 '+
                                  ' order by SEQPERGUNTA');
    While not  perguntas.eof do
    begin
      GraficoNota(Perguntas.FieldByname('SEQPERGUNTA').AsInteger,Perguntas.FieldByname('DESTITULO').AsString,VpfSerieNota);
      Perguntas.next;
    end;
    CarTitulosGrafico;
    Grafico.Executa;
  end
  else
    aviso('PESQUISA NÃO PREENCHIDO!!!#13É necessário escolher o codigo da pesquisa nos filtros acima.');
end;

{******************************************************************************}
procedure TFPesquisaSatisfacaoChamado.GeraGraficoPesquisa;
var
  VpfSerieSim, VpfSerieNao : TBarSeries;
begin
  if ECodPesquisa.AInteiro <> 0 then
  begin
    Grafico.InicializaGrafico;
    VpfSerieSim := TBarSeries.Create(self);
    Grafico.AGrafico.AddSeries(VpfSerieSim);
    VpfSerieSim.Marks.Style := smsValue;
    VpfSerieSim.ColorEachPoint := false;
    VpfSerieSim.BarBrush.Color := clGreen;
    VpfSerieSim.Title := 'Sim';

    VpfSerieNao := TBarSeries.Create(self);
    Grafico.AGrafico.AddSeries(VpfSerieNao);
    VpfSerieNao.Marks.Style := smsValue;
    VpfSerieNao.ColorEachPoint := false;
    VpfSerieNao.BarBrush.Color := clGreen;
    VpfSerieNao.Title := 'Não';

    AdicionaSQLAbreTabela(Perguntas,'Select * from PESQUISASATISFACAOITEM PSI '+
                                  ' Where CODPESQUISA = ' +ECodPesquisa.text+
                                  ' AND TIPRESPOSTA = 1 '+
                                  ' order by SEQPERGUNTA');
    While not  perguntas.eof do
    begin
      GraficoPerguntaSimNao(Perguntas.FieldByname('SEQPERGUNTA').AsInteger,Perguntas.FieldByname('DESTITULO').AsString,VpfSerieSim,VpfSerieNao);
      Perguntas.next;
    end;
    CarTitulosGrafico;
    Grafico.Executa;
  end
  else
    aviso('PESQUISA NÃO PREENCHIDO!!!#13É necessário escolher o codigo da pesquisa nos filtros acima.');
end;

{******************************************************************************}
procedure TFPesquisaSatisfacaoChamado.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFPesquisaSatisfacaoChamado.PesquisaItemCalcFields(
  DataSet: TDataSet);
begin
  case PesquisaItemTIPRESPOSTA.AsInteger of
    1 :
      begin
        if PesquisaItemDESSIMNAO.AsString = 'S' then
          PesquisaItemResposta.AsString := 'Sim'
        else
          PesquisaItemResposta.AsString := 'Não';
      end;
    2 :
      begin
        case PesquisaItemNUMBOMRUIM.AsInteger of
          0 : PesquisaItemResposta.AsString := 'Ótimo';
          1 : PesquisaItemResposta.AsString := 'Bom';
          2 : PesquisaItemResposta.AsString := 'Regular';
          3 : PesquisaItemResposta.AsString := 'Ruim';
          4 : PesquisaItemResposta.AsString := 'Péssimo';
          5 : PesquisaItemResposta.AsString := 'Sem Opinião';
        end;
      end;
    3 : PesquisaItemResposta.AsString := IntToStr(PesquisaItemNUMNOTA.Asinteger);
    4 : PesquisaItemResposta.Clear;
  end;
end;

{******************************************************************************}
procedure TFPesquisaSatisfacaoChamado.PesquisaCorpoAfterScroll(
  DataSet: TDataSet);
begin
  PosPerguntas;
end;

{******************************************************************************}
procedure TFPesquisaSatisfacaoChamado.ETecnicoFimConsulta(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFPesquisaSatisfacaoChamado.BGraficosClick(Sender: TObject);
begin
  GeraGraficoPesquisa;
end;

{******************************************************************************}
procedure TFPesquisaSatisfacaoChamado.BitBtn1Click(Sender: TObject);
begin
  GeraGraficoNota;
end;

{******************************************************************************}
procedure TFPesquisaSatisfacaoChamado.BitBtn2Click(Sender: TObject);
begin
  GeraGraficoOtimoRuim;
end;

procedure TFPesquisaSatisfacaoChamado.BitBtn3Click(Sender: TObject);
begin
  FunCrystal.ImprimeRelatorio(Varia.PathRelatorios+ '\Chamados\XX_PesquisaSatisfacao.rpt',[FormatDateTime('DD/MM/YYYY',EDatInicio.datetime),FormatDateTime('DD/MM/YYYY',EDatFim.dateTime),IntToStr(ETecnico.AInteiro),LNomTecnico.caption,IntToStr(ECodPesquisa.Ainteiro),LNomPesquisa.Caption ]);
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFPesquisaSatisfacaoChamado]);
end.
