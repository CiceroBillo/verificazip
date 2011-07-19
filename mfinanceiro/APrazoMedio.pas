unit APrazoMedio;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente, Db, DBTables,
  ComCtrls, Mask, numericos, Graficos,Series,TeeProcs,TeEngine, DBClient, Tabela;

type
  TFPrazoMedio = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BFechar: TBitBtn;
    Label1: TLabel;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    Label2: TLabel;
    Prazo: TSQL;
    DataPrazo: TDataSource;
    PanelColor3: TPanelColor;
    Label3: TLabel;
    Label4: TLabel;
    EPrazoRecebimento: Tnumerico;
    EPrazoPagamento: Tnumerico;
    BCalcular: TBitBtn;
    BGrafico: TBitBtn;
    Tabela: TSQL;
    Grafico: TRBGraDinamico;
    Label5: TLabel;
    CAgruparpor: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BCalcularClick(Sender: TObject);
    procedure BGraficoClick(Sender: TObject);
  private
    { Private declarations }
    procedure PosPrazoRecebimento(VpaTabela : TSQL);
    function RPrazoMedioRecebimento(VpaDatInicio, VpaDatFim : TDateTime):Double;
    function RPrazoMedioPagamento(VpaDatInicio, VpaDatFim : TDateTime):Double;
    function RPrazoMedioPagamentoGrafico(VpaData : Double):Double;
    procedure CalculaPrazoMedio;
  public
    { Public declarations }
  end;

var
  FPrazoMedio: TFPrazoMedio;

implementation

uses APrincipal,FunData, FunSql, FunNumeros;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFPrazoMedio.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EDatInicio.DateTime := PrimeiroDiaMes(date);
  EDatFim.DateTime := UltimoDiaMes(date);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFPrazoMedio.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFPrazoMedio.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
function TFPrazoMedio.RPrazoMedioRecebimento(VpaDatInicio, VpaDatFim : TDateTime):Double;
begin
  AdicionaSQLAbreTabela(Prazo,'select SUM((MOV.D_DAT_VEN - CAD.D_DAT_EMI)) / COUNT(CAD.I_EMP_FIL) PRAZO '+
                              ' from CADCONTASARECEBER CAD, MOVCONTASARECEBER MOV '+
                              ' WHERE CAD.I_EMP_FIL = MOV.I_EMP_FIL ' +
                              ' AND CAD.I_LAN_REC = MOV.I_LAN_REC ' +
                              SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_EMI',VpaDatInicio,VpaDatFim,true));
  result := Prazo.FieldByname('PRAZO').AsFloat;
  Prazo.close;
end;

{******************************************************************************}
procedure TFPrazoMedio.PosPrazoRecebimento(VpaTabela : TSQL);
begin
  VpaTabela.sql.clear;
  case CAgruparpor.ItemIndex of
    0 : VpaTabela.Sql.Add('select SUM((MOV.D_DAT_VEN - CAD.D_DAT_EMI)) / COUNT(CAD.I_EMP_FIL) PRAZO, CAD.D_DAT_EMI DATA1, CAD.D_DAT_EMI DATA');
    1 : VpaTabela.Sql.Add('select SUM((MOV.D_DAT_VEN - CAD.D_DAT_EMI)) / COUNT(CAD.I_EMP_FIL) PRAZO, ('+SQLTextoAno('CAD.D_DAT_EMI')+' *100)+'+SQLTextoMes('CAD.D_DAT_EMI')+'  DATA1,' +SQLTextoMes('CAD.D_DAT_EMI')+' ||''/''|| '+SQLTextoAno('CAD.D_DAT_EMI')+' DATA');
    2 : VpaTabela.Sql.Add('select SUM((MOV.D_DAT_VEN - CAD.D_DAT_EMI)) / COUNT(CAD.I_EMP_FIL) PRAZO, '+ SQLTextoAno('CAD.D_DAT_EMI')+' DATA1,'+SQLTextoAno('CAD.D_DAT_EMI')+' DATA');
  end;
  VpaTabela.sql.add(' from CADCONTASARECEBER CAD, MOVCONTASARECEBER MOV '+
                              ' WHERE CAD.I_EMP_FIL = MOV.I_EMP_FIL ' +
                              ' AND CAD.I_LAN_REC = MOV.I_LAN_REC ' +
                              SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_EMI',EDatInicio.DateTime,EDatFim.DateTime,true));
  case CAgruparpor.ItemIndex of
    0 : VpaTabela.Sql.Add(' group by CAD.D_DAT_EMI, CAD.D_DAT_EMI order by 2');
    1 : VpaTabela.Sql.Add(' group by ('+SQLTextoAno('CAD.D_DAT_EMI')+' *100)+'+SQLTextoMes('CAD.D_DAT_EMI')+' ,' +SQLTextoMes('CAD.D_DAT_EMI')+' ||''/''|| '+SQLTextoAno('CAD.D_DAT_EMI')+
                    ' order by 2');
    2 : VpaTabela.Sql.Add(' group by '+ SQLTextoAno('CAD.D_DAT_EMI')+', '+SQLTextoAno('CAD.D_DAT_EMI')+
                    ' order by 2');
  end;

  VpaTabela.Open;
end;

{******************************************************************************}
function TFPrazoMedio.RPrazoMedioPagamento(VpaDatInicio, VpaDatFim : TDateTime):Double;
begin
  AdicionaSQLAbreTabela(Prazo,'select SUM((MOV.D_DAT_VEN - CAD.D_DAT_EMI)) / COUNT(CAD.I_EMP_FIL) PRAZO '+
                              ' from CADCONTASAPAGAR CAD, MOVCONTASAPAGAR MOV '+
                              ' WHERE CAD.I_EMP_FIL = MOV.I_EMP_FIL ' +
                              ' AND CAD.I_LAN_APG = MOV.I_LAN_APG ' +
                              SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_EMI',VpaDatInicio,VpaDatFim,true));
  result := Prazo.FieldByname('PRAZO').AsFloat;
  Prazo.close;
end;

{******************************************************************************}
function TFPrazoMedio.RPrazoMedioPagamentoGrafico(VpaData : Double):Double;
var
  VpfMes : TDateTime;
begin
  Prazo.sql.clear;
  Prazo.Sql.add('select SUM((MOV.D_DAT_VEN - CAD.D_DAT_EMI)) / COUNT(CAD.I_EMP_FIL) PRAZO '+
                              ' from CADCONTASAPAGAR CAD, MOVCONTASAPAGAR MOV '+
                              ' WHERE CAD.I_EMP_FIL = MOV.I_EMP_FIL ' +
                              ' AND CAD.I_LAN_APG = MOV.I_LAN_APG ');
  case CAgruparpor.ItemIndex of
    0 : Prazo.Sql.Add(SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_EMI',VpaData,VpaData,true));
    1 :begin
         VpfMes := MontaData(1,StrToint(copy(FloattoStr(VpaData),5,2)),StrToInt(copy(FloattoStr(VpaData),1,4)));
         Prazo.Sql.Add(SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_EMI',PrimeiroDiaMes(VpfMes),UltimoDiaMes(vpfMes),true));
       end;
    2 : Prazo.Sql.Add(SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_EMI',MontaData(1,1,ano(EDatInicio.DateTime)),MontaData(31,12,ano(EDatFim.DateTime)),true));
  end;
  Prazo.sql.savetofile('c:\consulta.sql');
  Prazo.open;
  result := Prazo.FieldByname('PRAZO').AsFloat;
  Prazo.close;
end;

{******************************************************************************}
procedure TFPrazoMedio.CalculaPrazoMedio;
begin
  EPrazoRecebimento.AValor := RPrazoMedioRecebimento(EDatInicio.DateTime,EDatFim.DateTime);
  EPrazoPagamento.AValor := RPrazoMedioPagamento(EDatInicio.DateTime,EDatFim.DateTime);
end;

{******************************************************************************}
procedure TFPrazoMedio.BCalcularClick(Sender: TObject);
begin
  CalculaPrazoMedio;
end;

{******************************************************************************}
procedure TFPrazoMedio.BGraficoClick(Sender: TObject);
var
  VpfQtdMetros : Double;
  VpfData : String;
  VpfSerieReceber, VpfSeriePagar : TBarSeries;
begin
  Grafico.InicializaGrafico;
  VpfSerieReceber := TBarSeries.Create(Self);
  Grafico.AGrafico.AddSeries(VpfSerieReceber);
  VpfSerieReceber.Marks.Style := smsValue;
  VpfSerieReceber.ColorEachPoint := false;
  VpfSerieReceber.BarBrush.Color := clRed;
  VpfSerieReceber.Title := 'Recebimento';

  VpfSeriePagar := TBarSeries.Create(Self);
  Grafico.AGrafico.AddSeries(VpfSeriePagar);
  VpfSeriePagar.Marks.Style := smsValue;
  VpfSeriePagar.ColorEachPoint := false;
  VpfSeriePagar.BarBrush.Color := clGreen;
  VpfSeriePagar.Title := 'Pagamento';
  PosPrazoRecebimento(Tabela);
  while not Tabela.Eof do
  begin
    Grafico.AGrafico.Series[0].Add(ArredondaDecimais(Tabela.FieldByName('PRAZO').AsFloat,0),Tabela.FieldByName('DATA').AsString);
    Grafico.AGrafico.Series[1].Add(ArredondaDecimais(RPrazoMedioPagamentoGrafico(Tabela.FieldByName('DATA1').AsFloat),0),Tabela.FieldByName('DATA').AsString);
    Tabela.Next;
  end;
  Grafico.AInfo.TituloGrafico := 'Prazo Medio Recebimento X Pagamento ('+ FormatDateTime('DD/MM/YYYY',EDatInicio.DateTime)+'-'+FormatDateTime('DD/MM/YYYY',EDatFim.DateTime)+')';
  Grafico.AInfo.TituloFormulario := 'Prazo Medio Recebimento X Pagamento';
  Grafico.AInfo.TituloY := 'Prazo Medio';
  Grafico.AInfo.RodapeGrafico := 'Prazo Medio Recebimento X Pagamento ('+ FormatDateTime('DD/MM/YYYY',EDatInicio.DateTime)+'-'+FormatDateTime('DD/MM/YYYY',EDatFim.DateTime)+')';
  Grafico.Executa;
  Tabela.Close;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFPrazoMedio]);
end.
