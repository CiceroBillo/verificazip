unit ARelFaturamento;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, ComCtrls, Componentes1, ExtCtrls,
  PainelGradiente, Localizacao;

type
  TFRelFaturamento = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor3: TPanelColor;
    Label8: TLabel;
    Label10: TLabel;
    Data1: TCalendario;
    data2: TCalendario;
    PanelColor1: TPanelColor;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Localiza: TConsultaPadrao;
    Label18: TLabel;
    EditLocaliza4: TEditLocaliza;
    SpeedButton4: TSpeedButton;
    Label20: TLabel;
    BitBtn4: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
  private
    procedure CarregaFatAnalitico;
    procedure CarregaFatSinteticoData;
    procedure CarregaFatSinteticoHistorico;
    procedure CarregaFatSinteticoFrmPag;
    function  TextoFilial : string;
    function  TextoData : string;
    function  TextoCliente : string;
  public
    procedure AtivaRelatorio( tipo : integer );
    procedure AcertaDados( dataini, datafim : TdateTime; CodigoCliente : string );
  end;

var
  FRelFaturamento: TFRelFaturamento;

implementation

uses APrincipal, constantes, fundata;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFRelFaturamento.FormCreate(Sender: TObject);
begin
{data1.date :=  PrimeiroDiaMes(date);
data2.date :=  UltimoDiaMes(date);
FaturamentoAnalitico.ReportName := varia.PathRel + 'faturamentoAnalitico.rpt';
FaturamentoSinteticoData.ReportName := varia.PathRel + 'faturamentoSinteticoData.rpt';
FaturamentoSinteticoHistorico.ReportName := varia.PathRel + 'faturamentoSinteticoHistorico.rpt';}
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFRelFaturamento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := CaFree;
end;

function  TFRelFaturamento.TextoCliente : string;
begin
result := ' ';
if EditLocaliza4.Text <> '' then
   result :=  'AND  CADCONTASARECEBER."I_COD_CLI" = ' + EditLocaliza4.Text ;
end;

function  TFRelFaturamento.TextoFilial : string;
begin
  result :=  'AND  CADCONTASARECEBER."I_EMP_FIL" = ' + IntToStr(varia.CodigoEmpFil);
end;

function  TFRelFaturamento.TextoData : string;
begin
  result := ' AND CADCONTASARECEBER."D_DAT_EMI" >= ''' + DataToStrFormato(AAAAMMDD,data1.DateTime,'/') + '''' +
            ' AND CADCONTASARECEBER."D_DAT_EMI" <= ''' + DataToStrFormato(AAAAMMDD,data2.DateTime,'/') + '''';
end;

procedure TFRelFaturamento.CarregaFatAnalitico;
begin
{if FaturamentoAnalitico.SQL.Query.Count > 15 then
begin
  FaturamentoAnalitico.SQL.Query.Delete(17);
  FaturamentoAnalitico.SQL.Query.Delete(16);
  FaturamentoAnalitico.SQL.Query.Delete(15);
end;
  FaturamentoAnalitico.SQL.Query.Insert(15,TextoFilial);
  FaturamentoAnalitico.SQL.Query.Insert(16,TextoData);
  FaturamentoAnalitico.SQL.Query.Insert(17,TextoCliente);
  FaturamentoAnalitico.ReportTitle := varia.NomeEmpresa + ' - ' + varia.NomeFilial + ' - Período de ' + DateToStr(data1.DateTime) + ' à ' + DateToStr(data2.DateTime);}
end;

procedure TFRelFaturamento.CarregaFatSinteticoData;
begin
{if FaturamentoSinteticoData.SQL.Query.Count > 14 then
begin
  FaturamentoSinteticoData.SQL.Query.Delete(14);
  FaturamentoSinteticoData.SQL.Query.Delete(13);
  FaturamentoSinteticoData.SQL.Query.Delete(12);
end;
  FaturamentoSinteticoData.SQL.Query.Insert(12,TextoFilial);
  FaturamentoSinteticoData.SQL.Query.Insert(13,TextoData);
  FaturamentoSinteticoData.SQL.Query.Insert(14,TextoCliente);
  FaturamentoSinteticoData.ReportTitle := varia.NomeEmpresa + ' - ' + varia.NomeFilial + ' - Período de ' + DateToStr(data1.DateTime) + ' à ' + DateToStr(data2.DateTime);}
end;

procedure TFRelFaturamento.CarregaFatSinteticoHistorico;
begin
{if FaturamentoSinteticoHistorico.SQL.Query.Count > 14 then
begin
  FaturamentoSinteticoHistorico.SQL.Query.Delete(14);
  FaturamentoSinteticoHistorico.SQL.Query.Delete(13);
  FaturamentoSinteticoHistorico.SQL.Query.Delete(12);
end;
  FaturamentoSinteticoHistorico.SQL.Query.Insert(12,TextoFilial);
  FaturamentoSinteticoHistorico.SQL.Query.Insert(13,TextoData);
  FaturamentoSinteticoHistorico.SQL.Query.Insert(14,TextoCliente);
  FaturamentoSinteticoHistorico.ReportTitle := varia.NomeEmpresa + ' - ' + varia.NomeFilial + ' - Período de ' + DateToStr(data1.DateTime) + ' à ' + DateToStr(data2.DateTime);}
end;

procedure TFRelFaturamento.CarregaFatSinteticoFrmPag;
begin
{if FaturamentoSinteticoFrmPag.SQL.Query.Count > 17 then
begin
  FaturamentoSinteticoFrmPag.SQL.Query.Delete(17);
  FaturamentoSinteticoFrmPag.SQL.Query.Delete(16);
  FaturamentoSinteticoFrmPag.SQL.Query.Delete(15);
end;
  FaturamentoSinteticoFrmPag.SQL.Query.Insert(15,TextoFilial);
  FaturamentoSinteticoFrmPag.SQL.Query.Insert(16,TextoData);
  FaturamentoSinteticoFrmPag.SQL.Query.Insert(17,TextoCliente);
  FaturamentoSinteticoFrmPag.ReportTitle := varia.NomeEmpresa + ' - ' + varia.NomeFilial + ' - Período de ' + DateToStr(data1.DateTime) + ' à ' + DateToStr(data2.DateTime);}
end;


procedure TFRelFaturamento.AcertaDados( dataini, datafim : TdateTime; CodigoCliente : string );
begin
data1.DateTime := dataIni;
data2.DateTime := dataFim;
EditLocaliza4.Text := CodigoCliente;
end;

procedure TFRelFaturamento.AtivaRelatorio( tipo : integer );
begin
{case tipo of
0 : begin
     self.CarregaFatAnalitico;
     FaturamentoAnalitico.Execute;
    end;
1 : begin
      self.CarregaFatSinteticoData;
      FaturamentoSinteticoData.Execute;
    end;
2 : begin
      self.CarregaFatSinteticoHistorico;
      FaturamentoSinteticoHistorico.Execute;
    end;
3 : begin
      self.CarregaFatSinteticoFrmPag;
      FaturamentoSinteticoFrmPag.Execute;
    end;

end;}
end;

procedure TFRelFaturamento.BitBtn1Click(Sender: TObject);
begin
AtivaRelatorio(0);
end;

procedure TFRelFaturamento.BitBtn2Click(Sender: TObject);
begin
AtivaRelatorio(1);
end;

procedure TFRelFaturamento.BitBtn3Click(Sender: TObject);
begin
AtivaRelatorio(2);
end;


procedure TFRelFaturamento.BitBtn4Click(Sender: TObject);
begin
AtivaRelatorio(3);
end;

Initialization
 RegisterClasses([TFRelFaturamento]);
end.
