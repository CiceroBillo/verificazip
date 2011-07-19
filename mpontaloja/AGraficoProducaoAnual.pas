unit AGraficoProducaoAnual;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Spin, Buttons, Series, TeeProcs,TeEngine,
  Graficos, Db, DBTables, ComCtrls, Localizacao, FMTBcd, SqlExpr;

type
  TFGraficoProducaoAnual = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BGerar: TBitBtn;
    BFechar: TBitBtn;
    Grafico: TRBGraDinamico;
    Producao: TSQLQuery;
    PainelTempo1: TPainelTempo;
    BMensal: TBitBtn;
    Label3: TLabel;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    Label4: TLabel;
    EVendedor: TRBEditLocaliza;
    Label1: TLabel;
    LNomVendedor: TLabel;
    SpeedButton1: TSpeedButton;
    CEntradaPedidos: TRadioButton;
    CMetrosFaturados: TRadioButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BGerarClick(Sender: TObject);
    procedure BMensalClick(Sender: TObject);
  private
    { Private declarations }
    function RQtdMetros(VpaTabela : TSQLQUERY):Double;
    function RQtdMetrosMes(VpaTabela : TSQLQUERY;VpaMes : Integer;VpaCampoData : String):Double;
    function RQtdMetrosDia(VpaTabela : TSQLQUERY;VpaDia : TDateTime;VpaCampo : string):Double;
    procedure LocalizaNotas(VpaTabela : TSQLQUERY; VpaDatInicio, VpaDatFim : TDateTime;VpaCodVendedor : Integer);
    procedure LocalizaPedidos(VpaTabela : TSQLQUERY; VpaDatInicio, VpaDatFim : TDateTime;VpaCodVendedor : Integer);
    procedure GeraGraficoMensal;
    procedure GeraGrafico;
    procedure GraficoEntradaMensal;
    procedure GraficoEntradaDiario;
  public
    { Public declarations }
  end;

var
  FGraficoProducaoAnual: TFGraficoProducaoAnual;

implementation

uses APrincipal, FunData, FunSql, ConstMsg, FunNumeros;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFGraficoProducaoAnual.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EDatInicio.DateTime := PrimeiroDiaMes(date);
  EDatFim.DateTime := UltimoDiaMes(date);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFGraficoProducaoAnual.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
procedure TFGraficoProducaoAnual.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFGraficoProducaoAnual.BGerarClick(Sender: TObject);
begin
  if CMetrosFaturados.Checked then
    GeraGrafico
  else
    GraficoEntradaMensal;
end;

{******************************************************************************}
function TFGraficoProducaoAnual.RQtdMetrosDia(VpaTabela : TSQLQUERY;VpaDia : TDateTime;VpaCampo : string):Double;
begin
  result := 0;
  while not(VpaTabela.Eof) and (VpaTabela.FieldByName(VpaCampo).AsDateTime = VpaDia) do
  begin
    result := result + RQtdMetros(VpaTabela);
    VpaTabela.Next;
  end;
end;

{******************************************************************************}
function TFGraficoProducaoAnual.RQtdMetros(VpaTabela : TSQLQUERY):Double;
begin
  result := 0;
  if UpperCase(VpaTabela.FieldByName('C_COD_UNI').AsString) = 'MT' then
    result := VpaTabela.FieldByName('N_QTD_PRO').AsFloat
  else
    if UpperCase(VpaTabela.FieldByName('C_COD_UNI').AsString) = 'KM' then
      result := (VpaTabela.FieldByName('N_QTD_PRO').AsFloat * 1000)
    else
      if UpperCase(VpaTabela.FieldByName('C_COD_UNI').AsString) = 'CM' then
        result := (VpaTabela.FieldByName('N_QTD_PRO').AsFloat /100)
      else
      begin
        if VpaTabela.FieldByName('I_CMP_PRO').AsInteger = 0 then
          aviso('Produto "'+VpaTabela.FieldByName('C_COD_PRO').AsString +'-'+ VpaTabela.FieldByName('C_NOM_PRO').AsString+'", está cadastrado em "'+VpaTabela.FieldByName('C_COD_UNI').AsString+'", e não possui a quantidade de metros do cadastrada')
        else
          result := ((VpaTabela.FieldByName('N_QTD_PRO').AsFloat * VpaTabela.FieldByName('I_CMP_PRO').AsInteger)  /100);
      end;
end;

{******************************************************************************}
function TFGraficoProducaoAnual.RQtdMetrosMes(VpaTabela : TSQLQUERY;VpaMes : Integer;VpaCampoData : String):Double;
begin
  result := 0;
  while not(VpaTabela.Eof) and (mes(VpaTabela.FieldByName(VpaCampoData).AsDateTime) = VpaMes) do
  begin
    result := result + RQtdMetros(VpaTabela);
    VpaTabela.Next;
  end;
end;

{******************************************************************************}
procedure TFGraficoProducaoAnual.LocalizaNotas(VpaTabela : TSQLQUERY; VpaDatInicio, VpaDatFim : TDateTime;VpaCodVendedor : Integer);
begin
  VpaTabela.sql.clear;
  VpaTabela.sql.add('SELECT CAD.D_DAT_EMI, MOV.C_COD_UNI, MOV.N_QTD_PRO, PRO.I_CMP_PRO, MOV.C_COD_PRO, PRO.C_NOM_PRO '+
                                 ' FROM CADNOTAFISCAIS CAD, MOVNOTASFISCAIS MOV, CADPRODUTOS PRO '+
                                 ' WHERE CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                                 ' AND CAD.I_SEQ_NOT = MOV.I_SEQ_NOT '+
                                 ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO '+
                                 ' AND CAD.C_FIN_GER = ''S'''+
                                 ' AND CAD.C_NOT_CAN = ''N'''+
                                 ' and CAD.C_NOT_IMP = ''S'''+
                                 ' AND CAD.D_DAT_EMI >= ' + SQLTextoDataAAAAMMMDD(VpaDatInicio)+
                                 ' AND CAD.D_DAT_EMI <= '+ SQLTextoDataAAAAMMMDD(VpaDatFim));
  if VpaCodVendedor <> 0 then
    VpaTabela.sql.add('and CAD.I_COD_VEN = '+IntToStr(VpaCodVendedor));
  VpaTabela.sql.add(' order by CAD.D_DAT_EMI ');
  VpaTabela.open;
end;

{******************************************************************************}
procedure TFGraficoProducaoAnual.LocalizaPedidos(VpaTabela : TSQLQUERY; VpaDatInicio, VpaDatFim : TDateTime;VpaCodVendedor : Integer);
begin
  VpaTabela.sql.clear;
  VpaTabela.sql.add('SELECT CAD.D_DAT_ORC, MOV.C_COD_UNI, MOV.N_QTD_PRO, PRO.I_CMP_PRO, MOV.C_COD_PRO, PRO.C_NOM_PRO '+
                                 ' FROM CADORCAMENTOS CAD, MOVORCAMENTOS MOV, CADPRODUTOS PRO '+
                                 ' WHERE CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                                 ' AND CAD.I_LAN_ORC = MOV.I_LAN_ORC '+
                                 ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO '+
                                 ' AND CAD.C_IND_CAN = ''N'''+
                                 ' AND CAD.D_DAT_ORC >= ' + SQLTextoDataAAAAMMMDD(VpaDatInicio)+
                                 ' AND CAD.D_DAT_ORC <= '+ SQLTextoDataAAAAMMMDD(VpaDatFim));
  if VpaCodVendedor <> 0 then
    VpaTabela.sql.add('and CAD.I_COD_VEN = '+IntToStr(VpaCodVendedor));
  VpaTabela.sql.add(' order by CAD.D_DAT_ORC ');
  VpaTabela.open;
end;

{******************************************************************************}
procedure TFGraficoProducaoAnual.GeraGraficoMensal;
var
  VpfQtdMetros : Double;
  VpfData : String;
  VpfSerie : TBarSeries;
begin
  PainelTempo1.execute('Carregando Gráfico. Aguarde...');
  LocalizaNotas(Producao,EDatInicio.DateTime,EDatFim.DateTime,EVendedor.AInteiro);
  Grafico.InicializaGrafico;
  VpfSerie := TBarSeries.Create(Self);
  Grafico.AGrafico.AddSeries(VpfSerie);
  while not Producao.Eof do
  begin
    VpfData := FormatDateTime('DD/MM/YYYY',Producao.FieldByName('D_DAT_EMI').AsDateTime);
    VpfQtdMetros := RQtdMetrosDia(Producao,Producao.FieldByName('D_DAT_EMI').AsDateTime,'D_DAT_EMI');
    Grafico.AGrafico.Series[0].Add(ArredondaDecimais(VpfQtdMetros,1),VpfData);
    Producao.next;
  end;
  Grafico.AInfo.TituloGrafico := 'Metros Faturados Mensal - '+FormatDateTime('DD/MM/YY',EDatInicio.DateTime)+' - '+FormatDateTime('DD/MM/YY',EDatFim.DateTime) ;
  if EVendedor.AInteiro <> 0 then
    Grafico.AInfo.TituloGrafico := Grafico.AInfo.TituloGrafico + ' - Vendedor : '+LNomVendedor.Caption;
  VpfSerie.Marks.Style := smsValue;
  VpfSerie.ColorEachPoint := true;
  Grafico.Executa;
  PainelTempo1.fecha;
end;

{******************************************************************************}
procedure TFGraficoProducaoAnual.GeraGrafico;
var
  VpfQtdMetros : Double;
  VpfData : String;
  VpfSerie : TBarSeries;
begin
  PainelTempo1.execute('Carregando Gráfico. Aguarde...');
  LocalizaNotas(Producao,EDatInicio.DateTime,EDatFim.DateTime,EVendedor.Ainteiro);
  Grafico.InicializaGrafico;
  VpfSerie := TBarSeries.Create(Self);
  Grafico.AGrafico.AddSeries(VpfSerie);
  while not Producao.Eof do
  begin
    VpfData := IntToStr(mes(Producao.FieldByName('D_DAT_EMI').AsDateTime))+'/'+IntToStr(ANO(Producao.FieldByName('D_DAT_EMI').AsDateTime));
    VpfQtdMetros := rQtdMetrosMes(Producao,Mes(Producao.FieldByName('D_DAT_EMI').AsDateTime),'D_DAT_EMI');
    Grafico.AGrafico.Series[0].Add(ArredondaDecimais(VpfQtdMetros,1),VpfData);
  end;
  Grafico.AInfo.TituloGrafico := 'Metros Faturados Anual - '+ FormatDateTime('DD/MM/YY',EDatInicio.DateTime)+' - '+FormatDateTime('DD/MM/YY',EDatFim.DateTime) ;
  if EVendedor.AInteiro <> 0 then
    Grafico.AInfo.TituloGrafico := Grafico.AInfo.TituloGrafico + ' - Vendedor : '+LNomVendedor.Caption;
  VpfSerie.Marks.Style := smsValue;
  VpfSerie.ColorEachPoint := true;
  Grafico.Executa;
  PainelTempo1.fecha;
end;

{******************************************************************************}
procedure TFGraficoProducaoAnual.GraficoEntradaMensal;
var
  VpfQtdMetros : Double;
  VpfData : String;
  VpfSerie : TBarSeries;
begin
  PainelTempo1.execute('Carregando Gráfico. Aguarde...');
  LocalizaPedidos(Producao,EDatInicio.DateTime,EDatFim.DateTime,EVendedor.Ainteiro);
  Grafico.InicializaGrafico;
  VpfSerie := TBarSeries.Create(Self);
  Grafico.AGrafico.AddSeries(VpfSerie);
  while not Producao.Eof do
  begin
    VpfData := IntToStr(mes(Producao.FieldByName('D_DAT_ORC').AsDateTime))+'/'+IntToStr(ANO(Producao.FieldByName('D_DAT_ORC').AsDateTime));
    VpfQtdMetros := rQtdMetrosMes(Producao,Mes(Producao.FieldByName('D_DAT_ORC').AsDateTime),'D_DAT_ORC');
    Grafico.AGrafico.Series[0].Add(ArredondaDecimais(VpfQtdMetros,1),VpfData);
  end;
  Grafico.AInfo.TituloGrafico := 'Entrada Metros Anual - '+ FormatDateTime('DD/MM/YY',EDatInicio.DateTime)+' - '+FormatDateTime('DD/MM/YY',EDatFim.DateTime) ;
  if EVendedor.AInteiro <> 0 then
    Grafico.AInfo.TituloGrafico := Grafico.AInfo.TituloGrafico + ' - Vendedor : '+LNomVendedor.Caption;
  VpfSerie.Marks.Style := smsValue;
  VpfSerie.ColorEachPoint := true;
  Grafico.Executa;
  PainelTempo1.fecha;
end;

{******************************************************************************}
procedure TFGraficoProducaoAnual.GraficoEntradaDiario;
var
  VpfQtdMetros : Double;
  VpfData : String;
  VpfSerie : TBarSeries;
begin
  PainelTempo1.execute('Carregando Gráfico. Aguarde...');
  LocalizaPedidos(Producao,EDatInicio.DateTime,EDatFim.DateTime,EVendedor.AInteiro);
  Grafico.InicializaGrafico;
  VpfSerie := TBarSeries.Create(Self);
  Grafico.AGrafico.AddSeries(VpfSerie);
  while not Producao.Eof do
  begin
    VpfData := FormatDateTime('DD/MM/YYYY',Producao.FieldByName('D_DAT_ORC').AsDateTime);
    VpfQtdMetros := RQtdMetrosDia(Producao,Producao.FieldByName('D_DAT_ORC').AsDateTime,'D_DAT_ORC');
    Grafico.AGrafico.Series[0].Add(ArredondaDecimais(VpfQtdMetros,1),VpfData);
    Producao.next;
  end;
  Grafico.AInfo.TituloGrafico := 'Entrada Metros Mensal - '+FormatDateTime('DD/MM/YY',EDatInicio.DateTime)+' - '+FormatDateTime('DD/MM/YY',EDatFim.DateTime) ;
  if EVendedor.AInteiro <> 0 then
    Grafico.AInfo.TituloGrafico := Grafico.AInfo.TituloGrafico + ' - Vendedor : '+LNomVendedor.Caption;
  VpfSerie.Marks.Style := smsValue;
  VpfSerie.ColorEachPoint := true;
  Grafico.Executa;
  PainelTempo1.fecha;
end;

{******************************************************************************}
procedure TFGraficoProducaoAnual.BMensalClick(Sender: TObject);
begin
  if CMetrosFaturados.Checked then
    GeraGraficoMensal
  else
    GraficoEntradaDiario;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFGraficoProducaoAnual]);
end.
