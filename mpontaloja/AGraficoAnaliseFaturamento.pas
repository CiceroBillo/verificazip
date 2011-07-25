unit AGraficoAnaliseFaturamento;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Graficos, StdCtrls, Buttons, ExtCtrls, ComCtrls, Componentes1, Series,TeeProcs,TeEngine,
  PainelGradiente, Db, DBTables, Localizacao, Spin, UnContasAReceber, FMTBcd,
  SqlExpr, Mask, numericos;

type
  TFGraficoAnaliseFaturamento = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    CAgruparpor: TRadioGroup;
    BGerar: TBitBtn;
    BFechar: TBitBtn;
    Grafico: TRBGraDinamico;
    Tabela: TSQLQuery;
    Localiza: TConsultaPadrao;
    PVendedor: TPanelColor;
    Label11: TLabel;
    SpeedButton4: TSpeedButton;
    LNomVendedor: TLabel;
    EVendedor: TEditLocaliza;
    EPerMeta: TSpinEditColor;
    Label3: TLabel;
    Label5: TLabel;
    Aux: TSQLQuery;
    Label24: TLabel;
    SpeedButton5: TSpeedButton;
    LFilial: TLabel;
    EFilial: TEditLocaliza;
    BMostrarConta: TSpeedButton;
    PMeta: TPanelColor;
    EMeta: Tnumerico;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BGerarClick(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure BMostrarContaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    VprTipoGrafico : Integer; //0 - Analise Faturamento; 1-Metas Vendedor; 2 - Metas  Vendedor X Realizado;
    VprMostrarContas,
    VprPressionadoR : Boolean;
    procedure MostraPanel(VpaTipGrafico : Integer);
    procedure PosContasAReceber(VpaTabela : TSQLQuery);
    procedure PosPedidos(VpaTabela : TSQLQUERY);
    procedure PosPedidosEmitidos(VpaTabela :TSQLQUERY);
    procedure PosAReceberEmissao(VpaTabela :TSQLQUERY);
    procedure PosAReceberVencimento(VpaTabela :TSQLQUERY);
    procedure PosMetasVendedor(VpaTabela : TSQLQUERY);
    procedure PosMetasVendedorRealizado(VpaTabela : TSQLQUERY);
    function RValRealizado(VpaData : Double;VpaCodVendedor : String):Double;
    function RValCREmitido(VpaData : Double) : Double;
    function RValCPVencimento(VpaData : Double) : Double;
    function RValCPEmitido(VpaData : Double) : Double;
    function RNomVendedor(VpaCodVendedor :String):String;
    procedure GeraGraficoFaturamento;
    procedure GerarGraficoMetaFaturamento;
    procedure GeraGraficoVendedor;
    procedure GeraGraficoVendedorXRealizado;
    procedure GeraGraficoPedidosEmitidos;
    procedure GeraGraficoReceberEmissao;
    procedure GerarGraficoReceberXPagar;
    procedure GeraGraficoComparativoAnoCliente;
  public
    { Public declarations }
    procedure GraficoFaturamento;
    procedure GraficoMetaVendedor;
    procedure GraficoMetaVendedorRealizado;
    procedure GraficoPedidos;
    procedure GraficoReceberPorEmissao;
    procedure GraficoReceberXPagar;
    procedure GraficoMetaFaturamento;
  end;

var
  FGraficoAnaliseFaturamento: TFGraficoAnaliseFaturamento;

implementation

uses APrincipal, FunSql, FunNumeros, FunData, Constantes, ConstMsg;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFGraficoAnaliseFaturamento.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  CAgruparpor.ItemIndex := 1;
  EDatInicio.DateTime := decmes(PrimeiroDiaMes(Date),3);
  EDatFim.Datetime := UltimoDiaMes(Date);
  VprMostrarContas := false;
  VprPressionadoR := false;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFGraficoAnaliseFaturamento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
function TFGraficoAnaliseFaturamento.RNomVendedor(VpaCodVendedor :String):String;
begin
  AdicionaSQLAbreTabela(Aux,'Select C_NOM_VEN from CADVENDEDORES '+
                            ' Where I_COD_VEN = '+ VpaCodVendedor);
  result := Aux.FieldByName('C_NOM_VEN').AsString;
  Aux.close;
end;

{******************************************************************************}
procedure TFGraficoAnaliseFaturamento.GeraGraficoFaturamento;
var
  VpfData : String;
  VpfSerie : TBarSeries;
begin
  Grafico.InicializaGrafico;
  VpfSerie := TBarSeries.Create(Self);
  Grafico.AGrafico.AddSeries(VpfSerie);
  PosContasAReceber(Tabela);
  while not Tabela.Eof do
  begin
    Grafico.AGrafico.Series[0].Add(ArredondaDecimais(Tabela.FieldByName('VALOR').AsFloat,2),Tabela.FieldByName('DATA').AsString);
    Tabela.Next;
  end;
  VpfSerie.Marks.Style := smsValue;
  VpfSerie.ColorEachPoint := false;
  VpfSerie.BarBrush.Color := clYellow;
  VpfSerie.Title := 'Faturamento';

  VpfSerie := TBarSeries.Create(Self);
  Grafico.AGrafico.AddSeries(VpfSerie);
  PosPedidos(Tabela);
  while not Tabela.Eof do
  begin
    Grafico.AGrafico.Series[1].Add(ArredondaDecimais(Tabela.FieldByName('VALOR').AsFloat,2),Tabela.FieldByName('DATA').AsString);
    Tabela.Next;
  end;
  Grafico.AInfo.TituloGrafico := '   Analise Faturamento X Pedido  ';
  Grafico.AInfo.TituloFormulario := 'Analise Faturamento X Pedido';
  VpfSerie.Marks.Style := smsValue;
  VpfSerie.ColorEachPoint := false;
  VpfSerie.BarBrush.Color := clGreen;
  VpfSerie.Title := 'Pedidos';
  Grafico.AInfo.TituloY := 'Valor';

  Grafico.Executa;
  Tabela.Close;
end;

{******************************************************************************}
procedure TFGraficoAnaliseFaturamento.GeraGraficoVendedor;
var
  VpfQtdMetros : Double;
  VpfData : String;
  VpfSerie1, VpfSerie2 : TBarSeries;
begin
  if EVendedor.AInteiro = 0 then
    aviso('VENDEDOR INVÁLIDO!!!'#13'Para gerar o gráfico é necessário escolher o vendedor')
  else
  begin
    Grafico.InicializaGrafico;
    VpfSerie1 := TBarSeries.Create(Self);
    Grafico.AGrafico.AddSeries(VpfSerie1);
    VpfSerie1.Marks.Style := smsValue;
    VpfSerie1.ColorEachPoint := false;
    VpfSerie1.BarBrush.Color := clYellow;
    VpfSerie1.Title := 'Pedidos';

    VpfSerie2 := TBarSeries.Create(Self);
    Grafico.AGrafico.AddSeries(VpfSerie2);
    VpfSerie2.Marks.Style := smsValue;
    VpfSerie2.ColorEachPoint := false;
    VpfSerie2.BarBrush.Color := clYellow;
    VpfSerie2.Title := 'Meta';
    PosMetasVendedor(Tabela);
    while not Tabela.Eof do
    begin
      Grafico.AGrafico.Series[0].Add(ArredondaDecimais(Tabela.FieldByName('VALOR').AsFloat,2),Tabela.FieldByName('DATA').AsString);
      Grafico.AGrafico.Series[1].Add(ArredondaDecimais((Tabela.FieldByName('VALOR').AsFloat)+((Tabela.FieldByName('VALOR').AsFloat * EPerMeta.Value)/100),2),Tabela.FieldByName('DATA').AsString);
      Tabela.Next;
    end;
    Grafico.AInfo.TituloGrafico := 'Metas Vendedor de '+IntToStr(EPerMeta.Value) +'% - '+ LNomVendedor.Caption;
    Grafico.AInfo.TituloFormulario := 'Metas Vendedor';
    Grafico.AInfo.TituloY := 'Valor Pedidos';
    Grafico.AInfo.RodapeGrafico := 'Metas de '+IntToStr(EPerMeta.Value) +'%';

    Grafico.Executa;
    Tabela.Close;
  end;
end;

{******************************************************************************}
procedure TFGraficoAnaliseFaturamento.GeraGraficoVendedorXRealizado;
var
  VpfQtdMetros : Double;
  VpfData : String;
  VpfSerie1, VpfSerie2 : TBarSeries;
  VpfNomVendedor : String;
begin
  Grafico.InicializaGrafico;
  VpfSerie1 := TBarSeries.Create(Self);
  Grafico.AGrafico.AddSeries(VpfSerie1);
  VpfSerie1.Marks.Style := smsValue;
  VpfSerie1.ColorEachPoint := false;
  VpfSerie1.BarBrush.Color := clYellow;
  VpfSerie1.Title := 'Metas';

  VpfSerie2 := TBarSeries.Create(Self);
  Grafico.AGrafico.AddSeries(VpfSerie2);
  VpfSerie2.Marks.Style := smsValue;
  VpfSerie2.ColorEachPoint := false;
  VpfSerie2.BarBrush.Color := clYellow;
  VpfSerie2.Title := 'Realizado';
  PosMetasVendedorRealizado(Tabela);
  while not Tabela.Eof do
  begin
    VpfNomVendedor := Tabela.FieldByName('DATA').AsString+#13+RNomVendedor(Tabela.FieldByName('I_COD_VEN').AsString);
    Grafico.AGrafico.Series[0].Add(ArredondaDecimais((Tabela.FieldByName('VALOR').AsFloat)+((Tabela.FieldByName('VALOR').AsFloat * EPerMeta.Value)/100),2),VpfNomVendedor);
    Grafico.AGrafico.Series[1].Add(ArredondaDecimais(RValRealizado(Tabela.FieldByName('DATA1').AsFloat,Tabela.FieldByName('I_COD_VEN').AsString) ,2),VpfNomVendedor);
    Tabela.Next;
  end;
  Grafico.AInfo.TituloGrafico := 'Metas Vendedor de '+IntToStr(EPerMeta.Value) +'% - '+ LNomVendedor.Caption;
  Grafico.AInfo.TituloFormulario := 'Metas Vendedor';
  Grafico.AInfo.TituloY := 'Valor Pedidos';
  Grafico.AInfo.RodapeGrafico := 'Metas de '+IntToStr(EPerMeta.Value) +'%';

  Grafico.Executa;
  Tabela.Close;
end;

{******************************************************************************}
procedure TFGraficoAnaliseFaturamento.GeraGraficoPedidosEmitidos;
var
  VpfQtdMetros : Double;
  VpfData : String;
  VpfSerie1 : TBarSeries;
  VpfNomVendedor : String;
begin
  Grafico.InicializaGrafico;
  VpfSerie1 := TBarSeries.Create(Self);
  Grafico.AGrafico.AddSeries(VpfSerie1);
  VpfSerie1.Marks.Style := smsValue;
  VpfSerie1.ColorEachPoint := false;
  VpfSerie1.BarBrush.Color := clYellow;
  VpfSerie1.Title := 'Pedidos';

  PosPedidosEmitidos(Tabela);
  while not Tabela.Eof do
  begin
    Grafico.AGrafico.Series[0].Add(ArredondaDecimais((Tabela.FieldByName('VALOR').AsFloat),2),Tabela.FieldByName('DATA').AsString);
    Tabela.Next;
  end;
  Grafico.AInfo.TituloGrafico := 'Pedidos Emitidos entre '+FormatDateTime('DD/MM/YYYY',EDatInicio.DateTime)+ ' -  '+FormatDateTime('DD/MM/YYYY',EDatFim.DateTime) + ' - '+ varia.NomeFilial;
  Grafico.AInfo.TituloFormulario := 'Pedidos Emitidos';
  Grafico.AInfo.TituloY := 'Valor Pedidos';
  Grafico.AInfo.RodapeGrafico := 'Pedidos Emitidos';
  Grafico.Executa;
  Tabela.Close;
end;

{******************************************************************************}
procedure TFGraficoAnaliseFaturamento.GeraGraficoReceberEmissao;
var
  VpfQtdMetros : Double;
  VpfData : String;
  VpfSerie1 : TBarSeries;
begin
  Grafico.InicializaGrafico;
  VpfSerie1 := TBarSeries.Create(Self);
  Grafico.AGrafico.AddSeries(VpfSerie1);
  VpfSerie1.Marks.Style := smsValue;
  VpfSerie1.ColorEachPoint := false;
  VpfSerie1.BarBrush.Color := clYellow;
  VpfSerie1.Title := 'Faturamento';

  PosAReceberEmissao(Tabela);
  while not Tabela.Eof do
  begin
    Grafico.AGrafico.Series[0].Add(ArredondaDecimais((Tabela.FieldByName('VALOR').AsFloat),2),Tabela.FieldByName('DATA').AsString);
    Tabela.Next;
  end;
  Grafico.AInfo.TituloGrafico := 'Faturamento de '+FormatDateTime('DD/MM/YYYY',EDatInicio.DateTime)+ ' -  '+FormatDateTime('DD/MM/YYYY',EDatFim.DateTime) + ' - '+ varia.NomeFilial;
  Grafico.AInfo.TituloFormulario := 'Faturamento';
  Grafico.AInfo.TituloY := 'Valor Faturado';
  Grafico.AInfo.RodapeGrafico := 'Faturados';
  Grafico.Executa;
  Tabela.Close;
end;

{******************************************************************************}
procedure TFGraficoAnaliseFaturamento.GerarGraficoMetaFaturamento;
var
  VpfData : String;
  VpfSerie1, VpfSerie2 : TBarSeries;
  VpfDia, VpfQtdDias : Integer;
  VpfDataInicial, VpfDatafinal : TDateTime;
  VpfValDiario, VpfValorFaturado, VpfValFaturadoAcumulado : Double;
begin
  Grafico.InicializaGrafico;
  VpfSerie1 := TBarSeries.Create(Self);
  Grafico.AGrafico.AddSeries(VpfSerie1);
  VpfSerie1.Marks.Style := smsValue;
  VpfSerie1.ColorEachPoint := false;
  VpfSerie1.BarBrush.Color := clYellow;
  VpfSerie1.Title := 'Metas';

  VpfSerie2 := TBarSeries.Create(Self);
  Grafico.AGrafico.AddSeries(VpfSerie2);
  VpfSerie2.Marks.Style := smsValue;
  VpfSerie2.ColorEachPoint := false;
  VpfSerie2.BarBrush.Color := clYellow;
  VpfSerie2.Title := 'Realizado';

  PosContasAReceber(Tabela);
  VpfDataInicial := PrimeiroDiaMes(date);
  VpfDatafinal := UltimoDiaMes(date);
  VpfValDiario := (EMeta.AValor - VpfValorFaturado) / (QdadeDiasUteis(VpfDataInicial,VpfDatafinal)+1);
  VpfValorFaturado :=0;

  for VpfDia :=  1 to dia(UltimoDiaMes(Date)) do
  begin
    if (DiaSemanaNumerico(MontaData(vpfDia,Mes(VpfDataInicial),Ano(VpfDataInicial)))  in  [1,7]) then
      continue;
    VpfValFaturadoAcumulado := 0;
    if VpfDia <= Dia(date) then
    begin
      VpfQtdDias :=QdadeDiasUteis(MontaData(VpfDia,Mes(VpfDataInicial),Ano(VpfDataInicial)),VpfDatafinal)+1;
      VpfValDiario := ((EMeta.AValor - VpfValorFaturado)) / VpfQtdDias;
      while (Dia(Tabela.FieldByName('DATA1').AsDateTime) <= VpfDia)   and not Tabela.Eof do
      begin
        VpfValorFaturado := VpfValorFaturado + Tabela.FieldByName('VALOR').AsFloat;
        VpfValFaturadoAcumulado := VpfValFaturadoAcumulado + Tabela.FieldByName('VALOR').AsFloat;
        Tabela.Next;
      end;
    end
    else
      if VpfDia >= dia(date) then
      begin
        VpfValDiario := (EMeta.AValor - VpfValorFaturado) / (QdadeDiasUteis(date,VpfDatafinal)+1);
      end;
    Grafico.AGrafico.Series[1].Add(ArredondaDecimais(VpfValFaturadoAcumulado,2),FormatDateTime('DD/MM/YY',MontaData(VpfDia,Mes(VpfDataInicial),Ano(VpfDataInicial))));
    Grafico.AGrafico.Series[0].Add(ArredondaDecimais(VpfValDiario,2),FormatDateTime('DD/MM/YY',MontaData(VpfDia,Mes(VpfDataInicial),Ano(VpfDataInicial))));
  end;

  Grafico.AInfo.TituloGrafico := 'Metas Faturamento  '+EMeta.Text;
  Grafico.AInfo.TituloFormulario := 'Metas';
  Grafico.AInfo.TituloY := 'Valor Faturamento';
  Grafico.AInfo.RodapeGrafico := 'Metas de '+EMeta.Text;
  Grafico.Executa;
  Tabela.Close;
end;

{******************************************************************************}
procedure TFGraficoAnaliseFaturamento.GerarGraficoReceberXPagar;
var
  VpfQtdMetros : Double;
  VpfData : String;
  VpfSerie1, VpfSerie2, VpfSerie3,VpfSerie4: TBarSeries;
begin
  Grafico.InicializaGrafico;
  VpfSerie1 := TBarSeries.Create(Self);
  Grafico.AGrafico.AddSeries(VpfSerie1);
  VpfSerie1.Marks.Style := smsValue;
  VpfSerie1.ColorEachPoint := false;
  VpfSerie1.BarBrush.Color := clGreen;
  VpfSerie1.Title := 'CR Vencimento';

  VpfSerie2 := TBarSeries.Create(Self);
  Grafico.AGrafico.AddSeries(VpfSerie2);
  VpfSerie2.Marks.Style := smsValue;
  VpfSerie2.ColorEachPoint := false;
  VpfSerie2.BarBrush.Color := clFuchsia;
  VpfSerie2.Title := 'CR Emissão';

  VpfSerie3 := TBarSeries.Create(Self);
  Grafico.AGrafico.AddSeries(VpfSerie3);
  VpfSerie3.Marks.Style := smsValue;
  VpfSerie3.ColorEachPoint := false;
  VpfSerie3.BarBrush.Color := cmBlackness;
  VpfSerie3.Title := 'CP Vencimento';

  VpfSerie4 := TBarSeries.Create(Self);
  Grafico.AGrafico.AddSeries(VpfSerie4);
  VpfSerie4.Marks.Style := smsValue;
  VpfSerie4.ColorEachPoint := false;
  VpfSerie4.BarBrush.Color := cmBlackness;
  VpfSerie4.Title := 'CP Emissão';

  PosAReceberVencimento(Tabela);
  while not Tabela.Eof do
  begin
    Grafico.AGrafico.Series[0].Add(ArredondaDecimais((Tabela.FieldByName('VALOR').AsFloat),2),Tabela.FieldByName('DATA').AsString);
    Grafico.AGrafico.Series[1].Add(ArredondaDecimais(RValCREmitido(Tabela.FieldByName('DATA1').AsFloat) ,2),Tabela.FieldByName('DATA').AsString);
    Grafico.AGrafico.Series[2].Add(ArredondaDecimais(RValCPVencimento(Tabela.FieldByName('DATA1').AsFloat) ,2),Tabela.FieldByName('DATA').AsString);
    Grafico.AGrafico.Series[3].Add(ArredondaDecimais(RValCPEmitido(Tabela.FieldByName('DATA1').AsFloat) ,2),Tabela.FieldByName('DATA').AsString);
    Tabela.Next;
  end;
  Grafico.AInfo.TituloGrafico := 'Analise Financeira de '+FormatDateTime('DD/MM/YYYY',EDatInicio.DateTime)+ ' -  '+FormatDateTime('DD/MM/YYYY',EDatFim.DateTime) + ' - '+ varia.NomeFilial;
  Grafico.AInfo.TituloFormulario := 'Analise Fianceira';
  Grafico.AInfo.TituloY := 'Valores';
  Grafico.AInfo.RodapeGrafico := 'Analise Financeira';
  Grafico.Executa;
  Tabela.Close;
end;

{******************************************************************************}
procedure TFGraficoAnaliseFaturamento.GeraGraficoComparativoAnoCliente;
var
  VpfqtdDia,VpfQtdMes,VpfQtdAnos : word;
  VpfQtdMetros : Double;
  VpfData : String;
  VpfSerie1, VpfSerie2, VpfSerie3,VpfSerie4: TBarSeries;
begin
  Grafico.InicializaGrafico;
  DiferencaData(EDatInicio.Date,EDatFim.Date,VpfQtdDia,VpfQtdMes,VpfQtdAnos);
  aviso(InttoStr(vpfQTdAnos));

  exit;
  VpfSerie1 := TBarSeries.Create(Self);
  Grafico.AGrafico.AddSeries(VpfSerie1);
  VpfSerie1.Marks.Style := smsValue;
  VpfSerie1.ColorEachPoint := false;
  VpfSerie1.BarBrush.Color := clGreen;
  VpfSerie1.Title := 'CR Vencimento';

  VpfSerie2 := TBarSeries.Create(Self);
  Grafico.AGrafico.AddSeries(VpfSerie2);
  VpfSerie2.Marks.Style := smsValue;
  VpfSerie2.ColorEachPoint := false;
  VpfSerie2.BarBrush.Color := clFuchsia;
  VpfSerie2.Title := 'CR Emissão';

  VpfSerie3 := TBarSeries.Create(Self);
  Grafico.AGrafico.AddSeries(VpfSerie3);
  VpfSerie3.Marks.Style := smsValue;
  VpfSerie3.ColorEachPoint := false;
  VpfSerie3.BarBrush.Color := cmBlackness;
  VpfSerie3.Title := 'CP Vencimento';

  VpfSerie4 := TBarSeries.Create(Self);
  Grafico.AGrafico.AddSeries(VpfSerie4);
  VpfSerie4.Marks.Style := smsValue;
  VpfSerie4.ColorEachPoint := false;
  VpfSerie4.BarBrush.Color := cmBlackness;
  VpfSerie4.Title := 'CP Emissão';

  PosAReceberVencimento(Tabela);
  while not Tabela.Eof do
  begin
    Grafico.AGrafico.Series[0].Add(ArredondaDecimais((Tabela.FieldByName('VALOR').AsFloat),2),Tabela.FieldByName('DATA').AsString);
    Grafico.AGrafico.Series[1].Add(ArredondaDecimais(RValCREmitido(Tabela.FieldByName('DATA1').AsFloat) ,2),Tabela.FieldByName('DATA').AsString);
    Grafico.AGrafico.Series[2].Add(ArredondaDecimais(RValCPVencimento(Tabela.FieldByName('DATA1').AsFloat) ,2),Tabela.FieldByName('DATA').AsString);
    Grafico.AGrafico.Series[3].Add(ArredondaDecimais(RValCPEmitido(Tabela.FieldByName('DATA1').AsFloat) ,2),Tabela.FieldByName('DATA').AsString);
    Tabela.Next;
  end;
  Grafico.AInfo.TituloGrafico := 'Analise Financeira de '+FormatDateTime('DD/MM/YYYY',EDatInicio.DateTime)+ ' -  '+FormatDateTime('DD/MM/YYYY',EDatFim.DateTime) + ' - '+ varia.NomeFilial;
  Grafico.AInfo.TituloFormulario := 'Analise Fianceira';
  Grafico.AInfo.TituloY := 'Valores';
  Grafico.AInfo.RodapeGrafico := 'Analise Financeira';
  Grafico.Executa;
  Tabela.Close;
end;

procedure TFGraficoAnaliseFaturamento.GraficoFaturamento;
begin
  VprTipoGrafico := 0;
  MostraPanel(0);
  ShowModal;
end;

{******************************************************************************}
procedure TFGraficoAnaliseFaturamento.GraficoMetaFaturamento;
begin
  Caption := 'Meta Faturamento';
  PainelGradiente1.Caption := '  Meta Faturamento  ';
  VprTipoGrafico := 6;
  MostraPanel(6);
  showmodal;
end;

{******************************************************************************}
procedure TFGraficoAnaliseFaturamento.GraficoMetaVendedor;
begin
  Caption := 'Meta Vendedor';
  PainelGradiente1.Caption := '  Meta Vendedor   ';
  VprTipoGrafico := 1;
  MostraPanel(1);
  showmodal;
end;

{******************************************************************************}
procedure TFGraficoAnaliseFaturamento.GraficoMetaVendedorRealizado;
begin
  Caption := 'Meta Vendedor X Realizado';
  PainelGradiente1.Caption := '  Meta Vendedor X Realizado   ';
  VprTipoGrafico := 2;
  MostraPanel(2);
  EDatInicio.Datetime := PrimeiroDiaMes(date);
  EDatFim.Datetime := UltimoDiaMes(Date);
  showmodal;
end;

{******************************************************************************}
procedure TFGraficoAnaliseFaturamento.GraficoPedidos;
begin
  Caption := 'Pedidos Emitidos';
  PainelGradiente1.Caption := '  Pedidos Emitidos   ';
  VprTipoGrafico := 3;
  MostraPanel(3);
  EDatInicio.Datetime := PrimeiroDiaMes(date);
  EDatFim.Datetime := UltimoDiaMes(Date);
  showmodal;
end;

{******************************************************************************}
procedure TFGraficoAnaliseFaturamento.GraficoReceberPorEmissao;
begin
  caption := 'Por Emissão';
  PainelGradiente1.Caption := '  Por Emissão   ';
  VprTipoGrafico := 4;
  MostraPanel(4);
  EDatInicio.Datetime := PrimeiroDiaMes(date);
  EDatFim.Datetime := UltimoDiaMes(Date);
  showmodal;
end;

{******************************************************************************}
procedure TFGraficoAnaliseFaturamento.GraficoReceberXPagar;
begin
  caption := 'Receber X Pagar';
  PainelGradiente1.Caption := '  Receber X Pagar   ';
  VprTipoGrafico := 5;
  MostraPanel(5);
  EDatInicio.Datetime := PrimeiroDiaMes(date);
  EDatFim.Datetime := UltimoDiaMes(Date);
  showmodal;
end;

{******************************************************************************}
procedure TFGraficoAnaliseFaturamento.MostraPanel(VpaTipGrafico : Integer);
begin
  PVendedor.Visible := False;
  PMeta.Visible := false;
  case VpaTipGrafico of
    1,2 : PVendedor.visible := true;
    6 : begin
          PMeta.Visible := true;
          EDatInicio.Date := PrimeiroDiaMes(date);
          CAgruparpor.ItemIndex := 0;
        end;
  end;
end;

{******************************************************************************}
procedure TFGraficoAnaliseFaturamento.PosContasAReceber(VpaTabela : TSQLQuery);
begin
  VpaTabela.Sql.Clear;
  case CAgruparpor.ItemIndex of
    0 : VpaTabela.Sql.Add('Select SUM(N_VLR_TOT) VALOR, D_DAT_EMI DATA1, D_DAT_EMI DATA ');
    1 : VpaTabela.Sql.Add('Select SUM(N_VLR_TOT) VALOR, (YEAR(D_DAT_EMI) *100)+month(D_DAT_EMI) DATA1, month(D_DAT_EMI)||''/''|| year(D_DAT_EMI) DATA ');
    2 : VpaTabela.Sql.Add('Select SUM(N_VLR_TOT) VALOR, year(D_DAT_EMI) DATA1, year(D_DAT_EMI) DATA ');
  end;
  VpaTabela.Sql.add(' from CADCONTASARECEBER '+
                    ' Where ' +SQLTextoDataEntreAAAAMMDD('D_DAT_EMI',EDatInicio.DateTime,EDatFim.DateTime,false)+
                    ' and C_IND_CON IS NULL ');

  if EFilial.AInteiro <> 0 then
    VpaTabela.sql.add(' and I_EMP_FIL = '+EFilial.Text);

  if ((varia.CNPJFilial = CNPJ_Kairos) or
     (varia.CNPJFilial = CNPJ_AviamentosJaragua))and
     (EFilial.AInteiro = 0) then
    VpaTabela.sql.add(' and I_EMP_FIL <> 13');

  VpaTabela.Sql.add(' group by D_DAT_EMI '  +
                    ' order by 2');
  VpaTabela.Open;
end;

{******************************************************************************}
procedure TFGraficoAnaliseFaturamento.PosPedidos(VpaTabela : TSQLQUERY);
begin
  VpaTabela.Sql.Clear;
  case CAgruparpor.ItemIndex of
    0 : VpaTabela.Sql.Add('Select Sum(Orc.N_Vlr_LIQ) Valor, Orc.D_DAT_ORC DATA1, Orc.D_DAT_ORC DATA ');
    1 : VpaTabela.Sql.Add('Select Sum(Orc.N_Vlr_LIQ) Valor, (YEAR(orc.d_dat_orc) *100)+month(orc.d_dat_orc) DATA1, month(Orc.D_DAT_ORC)||''/''|| year(ORC.D_DAT_ORC) DATA ');
    2 : VpaTabela.Sql.Add('Select Sum(Orc.N_Vlr_LIQ) Valor,  year(ORC.D_DAT_ORC) DATA1, year(ORC.D_DAT_ORC) DATA ');
  end;
  VpaTabela.Sql.add(' from CadOrcamentos Orc '+
                    ' Where  '+SQLTextoDataEntreAAAAMMDD('D_DAT_ORC', EDatInicio.Datetime,EDatFim.Datetime,false));
  if EFilial.AInteiro <> 0 then
    VpaTabela.sql.add(' and ORC.I_EMP_FIL = '+EFilial.Text);
  if ((varia.CNPJFilial = CNPJ_Kairos) or
     (varia.CNPJFilial = CNPJ_AviamentosJaragua))and
     (EFilial.AInteiro = 0) then
    VpaTabela.sql.add(' and ORC.I_EMP_FIL <> 13');

  VpaTabela.sql.add(' group by DATA1, DATA '  +
                    ' order by 2');
  VpaTabela.Open;
end;

{******************************************************************************}
procedure TFGraficoAnaliseFaturamento.PosPedidosEmitidos(VpaTabela :TSQLQUERY);
begin
  VpaTabela.Sql.Clear;
  case CAgruparpor.ItemIndex of
    0 : VpaTabela.Sql.Add('Select Sum(Orc.N_Vlr_LIQ) Valor, Orc.D_DAT_ORC DATA1, Orc.D_DAT_ORC DATA ');
    1 : VpaTabela.Sql.Add('Select Sum(Orc.N_Vlr_LIQ) Valor, (YEAR(orc.d_dat_orc) *100)+month(orc.d_dat_orc) DATA1, month(Orc.D_DAT_ORC)||''/''|| year(ORC.D_DAT_ORC) DATA ');
    2 : VpaTabela.Sql.Add('Select Sum(Orc.N_Vlr_LIQ) Valor,  year(ORC.D_DAT_ORC) DATA1, year(ORC.D_DAT_ORC) DATA ');
  end;
  VpaTabela.Sql.add(' from CadOrcamentos Orc '+
                    ' Where '+SQLTextoDataEntreAAAAMMDD('D_DAT_ORC', EDatInicio.Datetime,EDatFim.Datetime,false));
  if EFilial.AInteiro <> 0 then
    VpaTabela.sql.add(' and ORC.I_EMP_FIL = '+EFilial.Text);
  if ((varia.CNPJFilial = CNPJ_Kairos) or
     (varia.CNPJFilial = CNPJ_AviamentosJaragua))and
     (EFilial.AInteiro = 0) then
    VpaTabela.sql.add(' and ORC.I_EMP_FIL <> 13');

  VpaTabela.sql.add(' group by DATA1, DATA '  +
                    ' order by 2');

  VpaTabela.Open;
end;

{******************************************************************************}
procedure TFGraficoAnaliseFaturamento.PosAReceberEmissao(VpaTabela :TSQLQUERY);
begin
  VpaTabela.Sql.Clear;
  case CAgruparpor.ItemIndex of
    0 : VpaTabela.Sql.Add('Select Sum('+SQLTextoIsNull('MOV.N_VLR_PAG','MOV.N_VLR_PAR')+') Valor, CAD.D_DAT_EMI DATA1, CAD.D_DAT_EMI DATA ');
    1 : VpaTabela.Sql.Add('Select Sum('+SQLTextoIsNull('MOV.N_VLR_PAG','MOV.N_VLR_PAR')+') Valor, ('+SQLTextoAno('CAD.D_DAT_EMI')+' *100)+ '+ SQLTextoMes('CAD.D_DAT_EMI')+' DATA1, '+SQLTextoMes('CAD.D_DAT_EMI')+'||''/''|| '+SQLTextoAno('CAD.D_DAT_EMI')+' DATA ');
    2 : VpaTabela.Sql.Add('Select Sum('+SQLTextoIsNull('MOV.N_VLR_PAG','MOV.N_VLR_PAR')+') Valor, ' +SQLTextoAno('CAD.D_DAT_EMI')+ ' DATA1, ' +SQLTextoAno('CAD.D_DAT_EMI')+ ' DATA ');
  end;
  VpaTabela.Sql.add(' from CADCONTASARECEBER CAD, MOVCONTASARECEBER MOV '+
                    ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                    ' AND CAD.I_LAN_REC = MOV.I_LAN_REC '+SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_EMI', EDatInicio.Datetime,EDatFim.Datetime,true));
  if EFilial.AInteiro <> 0 then
    VpaTabela.sql.add(' and CAD.I_EMP_FIL = '+EFilial.Text);
  if ((varia.CNPJFilial = CNPJ_Kairos) or
     (varia.CNPJFilial = CNPJ_AviamentosJaragua))and
     (EFilial.AInteiro = 0) then
    VpaTabela.sql.add(' and CAD.I_EMP_FIL <> 13');
  if not VprMostrarContas then
    VpaTabela.sql.add(' and MOV.C_IND_CAD = ''N''');
  case CAgruparpor.ItemIndex of
    0 :  VpaTabela.sql.add(' group by CAD.D_DAT_EMI');
    1 :  VpaTabela.sql.add(' group by ('+SQLTextoAno('CAD.D_DAT_EMI')+' *100)+ '+ SQLTextoMes('CAD.D_DAT_EMI')+', '+ SQLTextoMes('CAD.D_DAT_EMI')+'||''/''|| '+SQLTextoAno('CAD.D_DAT_EMI'));
    2 :  VpaTabela.sql.add(' group by '+SQLTextoAno('CAD.D_DAT_EMI')+', '+ SQLTextoAno('CAD.D_DAT_EMI'));
  end;
  VpaTabela.sql.add(' order by 2');
  VpaTabela.Open;
end;

{******************************************************************************}
procedure TFGraficoAnaliseFaturamento.PosMetasVendedor(VpaTabela : TSQLQUERY);
begin
  VpaTabela.Sql.Clear;
  case CAgruparpor.ItemIndex of
    0 : VpaTabela.Sql.Add('Select Sum(Orc.N_Vlr_LIQ) Valor, Orc.D_DAT_ORC DATA1, Orc.D_DAT_ORC DATA ');
    1 : VpaTabela.Sql.Add('Select Sum(Orc.N_Vlr_LIQ) Valor, ('+SQLTextoAno('orc.D_DAT_ORC')+' *100)+ '+SQLTextoMes('orc.d_dat_orc')+' DATA1, '+SQLTextoMes('Orc.D_DAT_ORC')+'||''/''|| '+SQLTextoAno('ORC.D_DAT_ORC')+' DATA ');
    2 : VpaTabela.Sql.Add('Select Sum(Orc.N_Vlr_LIQ) Valor,  '+SQLTextoAno('ORC.D_DAT_ORC')+' DATA1, '+SQLTextoAno('ORC.D_DAT_ORC')+' DATA ');
  end;
  VpaTabela.Sql.add(' from CadOrcamentos Orc, CADVENDEDORES VEN, CADCLIENTES CLI '+
                    ' Where  '+SQLTextoDataEntreAAAAMMDD('D_DAT_ORC', EDatInicio.Datetime,EDatFim.Datetime,false) +
                    ' and CLI.I_COD_CLI = ORC.I_COD_CLI '+
                    ' AND VEN.C_IND_ATI = ''S'''+
                    ' AND ORC.I_TIP_ORC = '+IntToStr(Varia.TipoCotacaoPedido)+
                    ' AND ORC.C_IND_CAN = ''N''');
    if EVendedor.AInteiro <> 0 then
      VpaTabela.Sql.add(' and VEN.I_COD_VEN = ' + EVendedor.Text);
  if config.MetaVendedorpelaCarteiradeClientes then
    Tabela.sql.Add('and VEN.I_COD_VEN = CLI.I_COD_VEN ')
  else
    Tabela.sql.Add('and VEN.I_COD_VEN = ORC.I_COD_VEN ');

  if EFilial.AInteiro <> 0 then
    VpaTabela.sql.add(' and ORC.I_EMP_FIL = '+EFilial.Text);
  if ((varia.CNPJFilial = CNPJ_Kairos) or
     (varia.CNPJFilial = CNPJ_AviamentosJaragua))and
     (EFilial.AInteiro = 0) then
    VpaTabela.sql.add(' and ORC.I_EMP_FIL <> 13');

  case CAgruparpor.ItemIndex of
    0 : VpaTabela.Sql.Add(' group by orc.D_DAT_ORC '+
                          ' order by 2');
    1 : VpaTabela.Sql.Add(' group by ('+SQLTextoAno('orc.D_DAT_ORC')+' *100)+ '+SQLTextoMes('orc.d_dat_orc')+', '+SQLTextoMes('Orc.D_DAT_ORC')+'||''/''|| '+SQLTextoAno('ORC.D_DAT_ORC')+
                          ' order by 2');
    2 : VpaTabela.Sql.Add(' group by '+SQLTextoAno('ORC.D_DAT_ORC')+', '+SQLTextoAno('ORC.D_DAT_ORC')+
                    ' order by 2');
  end;
  VpaTabela.Open;
end;

{******************************************************************************}
procedure TFGraficoAnaliseFaturamento.PosAReceberVencimento(VpaTabela :TSQLQUERY);
begin
  VpaTabela.Sql.Clear;
  case CAgruparpor.ItemIndex of
    0 : VpaTabela.Sql.Add('Select Sum(isnull(MOV.N_VLR_PAG,MOV.N_VLR_PAR)) Valor, MOV.D_DAT_VEN DATA1, MOV.D_DAT_VEN DATA ');
    1 : VpaTabela.Sql.Add('Select Sum('+SQLTextoIsNull('MOV.N_VLR_PAG','MOV.N_VLR_PAR')+') Valor, ('+SQLTextoAno('MOV.D_DAT_VEN')+' *100)+ '+SQLTextoMes('MOV.D_DAT_VEN')+ ' DATA1, '+SQLTextoMes('MOV.D_DAT_VEN')+'||''/''|| '+SQLTextoAno('MOV.D_DAT_VEN')+' DATA ');
    2 : VpaTabela.Sql.Add('Select Sum(isnull(MOV.N_VLR_PAG,MOV.N_VLR_PAR)) Valor,  year(MOV.D_DAT_VEN) DATA1, year(MOV.D_DAT_VEN) DATA ');
  end;
  VpaTabela.Sql.add(' from CADCONTASARECEBER CAD, MOVCONTASARECEBER MOV '+
                    ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                    ' AND CAD.I_LAN_REC = MOV.I_LAN_REC '+SQLTextoDataEntreAAAAMMDD('MOV.D_DAT_VEN', EDatInicio.Datetime,EDatFim.Datetime,true));
  if EFilial.AInteiro <> 0 then
    VpaTabela.sql.add(' and CAD.I_EMP_FIL = '+EFilial.Text);
  if ((varia.CNPJFilial = CNPJ_Kairos) or
     (varia.CNPJFilial = CNPJ_AviamentosJaragua))and
     (EFilial.AInteiro = 0) then
    VpaTabela.sql.add(' and CAD.I_EMP_FIL <> 13');

  if not VprMostrarContas then
    VpaTabela.sql.add(' and MOV.C_IND_CAD = ''N''');

  case CAgruparpor.ItemIndex of
    1 : VpaTabela.Sql.Add('GROUP BY ('+SQLTextoAno('MOV.D_DAT_VEN')+' *100)+ '+SQLTextoMes('MOV.D_DAT_VEN')+ ', '+SQLTextoMes('MOV.D_DAT_VEN')+'||''/''|| '+SQLTextoAno('MOV.D_DAT_VEN'));
  end;
    VpaTabela.sql.add(' order by 2');
  VpaTabela.Open;
end;

{******************************************************************************}
procedure TFGraficoAnaliseFaturamento.PosMetasVendedorRealizado(VpaTabela : TSQLQUERY);
begin
  VpaTabela.Sql.Clear;
  case CAgruparpor.ItemIndex of
    0 : VpaTabela.Sql.Add('Select Sum(Orc.N_Vlr_LIQ) Valor, Orc.D_DAT_ORC DATA1, Orc.D_DAT_ORC DATA, VEN.I_COD_VEN ');
    1 : VpaTabela.Sql.Add('Select Sum(Orc.N_Vlr_LIQ) Valor, (EXTRACT(YEAR FROM orc.d_dat_orc) *100)+EXTRACT(month FROM orc.d_dat_orc) DATA1, EXTRACT(month FROM Orc.D_DAT_ORC)||''/''|| EXTRACT(year FROM ORC.D_DAT_ORC) DATA, VEN.I_COD_VEN ');
    2 : VpaTabela.Sql.Add('Select Sum(Orc.N_Vlr_LIQ) Valor,  EXTRACT(year FROM ORC.D_DAT_ORC) DATA1, EXTRACT(year FROM ORC.D_DAT_ORC) DATA, VEN.I_COD_VEN ');
  end;
  VpaTabela.Sql.add(' from CadOrcamentos Orc, CADVENDEDORES VEN, CADCLIENTES CLI '+
                    ' Where '+SQLTextoDataEntreAAAAMMDD('D_DAT_ORC', Decano(EDatInicio.Datetime,1),ultimodiames(decano(decdia(EDatFim.Datetime,2),1)),false) +
                    ' AND ORC.I_COD_CLI = CLI.I_COD_CLI '+
                    ' AND ORC.I_TIP_ORC = '+IntToStr(Varia.TipoCotacaoPedido)+
                    ' AND ORC.C_IND_CAN = ''N'''+
                    ' AND VEN.C_IND_ATI = ''S''');
  if EVendedor.AInteiro <> 0 then
    VpaTabela.Sql.add(' and VEN.I_COD_VEN = ' + EVendedor.Text);

  if config.MetaVendedorpelaCarteiradeClientes then
    Tabela.sql.Add('and VEN.I_COD_VEN = CLI.I_COD_VEN ')
  else
    Tabela.sql.Add('and VEN.I_COD_VEN = ORC.I_COD_VEN ');


  if EFilial.AInteiro <> 0 then
    VpaTabela.sql.add(' and ORC.I_EMP_FIL = '+EFilial.Text);
  if ((varia.CNPJFilial = CNPJ_Kairos) or
     (varia.CNPJFilial = CNPJ_AviamentosJaragua))and
     (EFilial.AInteiro = 0) then
    VpaTabela.sql.add(' and ORC.I_EMP_FIL <> 13');

  // DATA1 , DATA
  case CAgruparpor.ItemIndex of
    0: VpaTabela.Sql.Add(' group by Orc.D_DAT_ORC, Orc.D_DAT_ORC, VEN.I_COD_VEN '  +
                    ' order by 2,4');
    1: VpaTabela.Sql.Add(' group by (EXTRACT(YEAR FROM orc.d_dat_orc) *100)+EXTRACT(month FROM orc.d_dat_orc), EXTRACT(month FROM Orc.D_DAT_ORC)||''/''|| EXTRACT(year FROM ORC.D_DAT_ORC), VEN.I_COD_VEN '  +
                    ' order by 2,4');
    2: VpaTabela.Sql.Add(' group by EXTRACT(year FROM ORC.D_DAT_ORC), EXTRACT(year FROM ORC.D_DAT_ORC), VEN.I_COD_VEN '  +
                    ' order by 2,4');
  end;

  VpaTabela.Open;
end;

{******************************************************************************}
function TFGraficoAnaliseFaturamento.RValRealizado(VpaData : Double;VpaCodVendedor : String):Double;
var
  vpfMes : TDateTime;
begin
  Aux.Sql.Clear;
  Aux.Sql.Add('Select SUM(N_VLR_LIQ) VALOR FROM CADORCAMENTOS '+
              ' Where I_COD_VEN = '+ VpaCodVendedor);
  case CAgruparpor.ItemIndex of
    0 : Aux.Sql.Add(SQLTextoDataEntreAAAAMMDD('D_DAT_ORC',VpaData,VpaData,true));
    1 :begin
         VpfMes := MontaData(1,StrToint(copy(FloattoStr(VpaData),5,2)),StrToInt(copy(FloattoStr(VpaData),1,4))+1);
         Aux.Sql.Add(SQLTextoDataEntreAAAAMMDD('D_DAT_ORC',PrimeiroDiaMes(VpfMes),UltimoDiaMes(vpfMes),true));
       end;
    2 : Aux.Sql.Add(SQLTextoDataEntreAAAAMMDD('D_DAT_ORC',MontaData(1,1,ano(EDatInicio.DateTime)),MontaData(31,12,ano(EDatFim.DateTime)),true));
  end;
  if EFilial.AInteiro <> 0 then
    Aux.sql.add(' and I_EMP_FIL = '+EFilial.Text);
  if ((varia.CNPJFilial = CNPJ_Kairos) or
     (varia.CNPJFilial = CNPJ_AviamentosJaragua))and
     (EFilial.AInteiro = 0) then
    Aux.sql.add(' and I_EMP_FIL <> 13');
  Aux.Open;
  result := Aux.FieldByName('VALOR').AsFloat;
  Aux.Close;
end;

{******************************************************************************}
function TFGraficoAnaliseFaturamento.RValCREmitido(VpaData : Double) : Double;
var
  vpfMes : TDateTime;
begin
  Aux.Sql.Clear;
  Aux.Sql.Add('Select Sum('+SQLTextoIsNull('MOV.N_VLR_PAG','MOV.N_VLR_PAR')+') VALOR FROM CADCONTASARECEBER CAD, MOVCONTASARECEBER MOV '+
              ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
              ' AND CAD.I_LAN_REC = MOV.I_LAN_REC ');
  case CAgruparpor.ItemIndex of
    0 : Aux.Sql.Add(SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_EMI',VpaData,VpaData,true));
    1 :begin
         VpfMes := MontaData(1,StrToint(copy(FloattoStr(VpaData),5,2)),StrToInt(copy(FloattoStr(VpaData),1,4)));
         Aux.Sql.Add(SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_EMI',PrimeiroDiaMes(VpfMes),UltimoDiaMes(vpfMes),true));
       end;
    2 : Aux.Sql.Add(SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_EMI',MontaData(1,1,ano(EDatInicio.DateTime)),MontaData(31,12,ano(EDatFim.DateTime)),true));
  end;
  if EFilial.AInteiro <> 0 then
    Aux.sql.add(' and CAD.I_EMP_FIL = '+EFilial.Text);
  if ((varia.CNPJFilial = CNPJ_Kairos) or
     (varia.CNPJFilial = CNPJ_AviamentosJaragua))and
     (EFilial.AInteiro = 0) then
    Aux.sql.add(' and CAD.I_EMP_FIL <> 13');
  if not VprMostrarContas then
    Aux.sql.add(' and MOV.C_IND_CAD = ''N''');
  Aux.Open;
  result := Aux.FieldByName('VALOR').AsFloat;
  Aux.Close;
end;

{******************************************************************************}
function TFGraficoAnaliseFaturamento.RValCPVencimento(VpaData : Double) : Double;
var
  vpfMes : TDateTime;
begin
  Aux.Sql.Clear;
  Aux.Sql.Add('Select Sum('+SQLTextoIsNull('MOV.N_VLR_PAG','MOV.N_VLR_DUP')+') VALOR FROM CADCONTASAPAGAR CAD, MOVCONTASAPAGAR MOV '+
              ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
              ' AND CAD.I_LAN_APG = MOV.I_LAN_APG ');
  case CAgruparpor.ItemIndex of
    0 : Aux.Sql.Add(SQLTextoDataEntreAAAAMMDD('MOV.D_DAT_VEN',VpaData,VpaData,true));
    1 :begin
         VpfMes := MontaData(1,StrToint(copy(FloattoStr(VpaData),5,2)),StrToInt(copy(FloattoStr(VpaData),1,4)));
         Aux.Sql.Add(SQLTextoDataEntreAAAAMMDD('MOV.D_DAT_VEN',PrimeiroDiaMes(VpfMes),UltimoDiaMes(vpfMes),true));
       end;
    2 : Aux.Sql.Add(SQLTextoDataEntreAAAAMMDD('MOV.D_DAT_VEN',MontaData(1,1,ano(EDatInicio.DateTime)),MontaData(31,12,ano(EDatFim.DateTime)),true));
  end;
  if EFilial.AInteiro <> 0 then
    Aux.sql.add(' and CAD.I_EMP_FIL = '+EFilial.Text);
  if not VprMostrarContas then
    Aux.sql.add(' and CAD.C_IND_CAD = ''N''')
  Else
    Aux.sql.add(' and CAD.C_IND_CAD is null');
  Aux.Open;
  result := Aux.FieldByName('VALOR').AsFloat;
  Aux.Close;
end;

{******************************************************************************}
function TFGraficoAnaliseFaturamento.RValCPEmitido(VpaData : Double) : Double;
var
  vpfMes : TDateTime;
begin
  Aux.Sql.Clear;
  Aux.Sql.Add('Select Sum('+SQLTextoIsNull('MOV.N_VLR_PAG','MOV.N_VLR_DUP')+') VALOR FROM CADCONTASAPAGAR CAD, MOVCONTASAPAGAR MOV '+
              ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
              ' AND CAD.I_LAN_APG = MOV.I_LAN_APG ');
  case CAgruparpor.ItemIndex of
    0 : Aux.Sql.Add(SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_EMI',VpaData,VpaData,true));
    1 :begin
         VpfMes := MontaData(1,StrToint(copy(FloattoStr(VpaData),5,2)),StrToInt(copy(FloattoStr(VpaData),1,4)));
         Aux.Sql.Add(SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_EMI',PrimeiroDiaMes(VpfMes),UltimoDiaMes(vpfMes),true));
       end;
    2 : Aux.Sql.Add(SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_EMI',MontaData(1,1,ano(EDatInicio.DateTime)),MontaData(31,12,ano(EDatFim.DateTime)),true));
  end;
  if EFilial.AInteiro <> 0 then
    Aux.sql.add(' and CAD.I_EMP_FIL = '+EFilial.Text);
  if not VprMostrarContas then
    Aux.sql.add(' and CAD.C_IND_CAD = ''N''')
  Else
    Aux.sql.add(' and CAD.C_IND_CAD is null');
  Aux.Open;
  result := Aux.FieldByName('VALOR').AsFloat;
  Aux.Close;
end;

{******************************************************************************}
procedure TFGraficoAnaliseFaturamento.BGerarClick(Sender: TObject);
begin
  case VprTipoGrafico of
    0 : GeraGraficoFaturamento;
    1 : GeraGraficoVendedor;
    2 : GeraGraficoVendedorXRealizado;
    3 : GeraGraficoPedidosEmitidos;
    4 : GeraGraficoReceberEmissao;
    5 : GerarGraficoReceberXPagar;
    6 : GerarGraficoMetaFaturamento;
  end;
end;

procedure TFGraficoAnaliseFaturamento.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFGraficoAnaliseFaturamento.BMostrarContaClick(Sender: TObject);
begin
  VprMostrarContas := false;
  BMostrarConta.visible := false;
end;

{******************************************************************************}
procedure TFGraficoAnaliseFaturamento.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Shift = [ssCtrl,ssAlt])  then
  begin
    if (key = 82) then
      VprPressionadoR := true
    else
      if VprPressionadoR then
        if (key = 77) then
        begin
          VprMostrarContas := true;
          BMostrarConta.Visible := true;
          VprPressionadoR := false;
        end
        else
          VprPressionadoR := false;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFGraficoAnaliseFaturamento]);
end.
