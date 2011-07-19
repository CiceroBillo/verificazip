unit AGraficoAnaliseCidade;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente, Localizacao,
  ComCtrls, Graficos;

type
  TFGraficoAnaliseCidade = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BGerar: TBitBtn;
    BFechar: TBitBtn;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    Label1: TLabel;
    Label2: TLabel;
    Localiza: TConsultaPadrao;
    CAgruparpor: TRadioGroup;
    Label4: TLabel;
    GraficosTrio: TGraficosTrio;
    PCidade: TPanelColor;
    Label3: TLabel;
    ECidade: TEditLocaliza;
    LCidade: TLabel;
    SpeedButton2: TSpeedButton;
    PVendedor: TPanelColor;
    EVendedor: TEditLocaliza;
    Label11: TLabel;
    SpeedButton4: TSpeedButton;
    LNomVendedor: TLabel;
    Label24: TLabel;
    SpeedButton5: TSpeedButton;
    LFilial: TLabel;
    EFilial: TEditLocaliza;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BGerarClick(Sender: TObject);
  private
    { Private declarations }
    procedure MostraPanel(VpaTipoGrafico : Integer);
    procedure GeraGraficoCidade;
    procedure GeraGraficoVendedor;
  public
    { Public declarations }
    procedure GraficoCidade;
    procedure GraficoVendedor;
  end;

var
  FGraficoAnaliseCidade: TFGraficoAnaliseCidade;

implementation

uses APrincipal, funData, FunSql, ConstMsg, Constantes;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFGraficoAnaliseCidade.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  CAgruparpor.ItemIndex := 1;
  EDatInicio.DateTime := decmes(PrimeiroDiaMes(Date),3);
  EDatFim.Datetime := UltimoDiaMes(Date);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFGraficoAnaliseCidade.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFGraficoAnaliseCidade.GraficoCidade;
begin
  MostraPanel(1);
  showmodal;
end;

{******************************************************************************}
procedure TFGraficoAnaliseCidade.GraficoVendedor;
begin
  MostraPanel(2);
  Showmodal;
end;

{******************************************************************************}
procedure TFGraficoAnaliseCidade.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFGraficoAnaliseCidade.BGerarClick(Sender: TObject);
begin
  if PCidade.Visible then
    GeraGraficoCidade
  else
    if PVendedor.Visible then
      GeraGraficoVendedor;
end;

{******************************************************************************}
procedure TFGraficoAnaliseCidade.MostraPanel(VpaTipoGrafico : Integer);
begin
  PCidade.Visible := false;
  PVendedor.Visible := false;
  case VpaTipoGrafico of
    1 : begin
          PCidade.visible := true;
          PainelGradiente1.Caption := '  Análise Cidade   ';
          Caption := 'Análise Cidade';
        end;
    2 : begin
          PVendedor.visible := true;
          PainelGradiente1.Caption := '  Análise Vendedor   ';
          Caption := 'Análise Vendedor';
        end;
  end;
end;

{******************************************************************************}
procedure TFGraficoAnaliseCidade.GeraGraficoCidade;
begin
  if ECidade.Text = '' then
    aviso('CIDADE INVÁLIDA!!!'#13'Para gerar o gráfico é necessário escolher a cidade')
  else
  begin
    case CAgruparpor.ItemIndex of
      0 : graficostrio.info.ComandoSQL :=  'Select Sum(Orc.N_Vlr_LIQ) Valor, Orc.D_DAT_ORC DATA1, Orc.D_DAT_ORC DATA ';
      1 : graficostrio.info.ComandoSQL :=  'Select Sum(Orc.N_Vlr_LIQ) Valor, (YEAR(orc.d_dat_orc) *100)+month(orc.d_dat_orc) DATA1, month(Orc.D_DAT_ORC)||''/''|| year(ORC.D_DAT_ORC) DATA ';
      3 : graficostrio.info.ComandoSQL :=  'Select Sum(Orc.N_Vlr_LIQ) Valor,  year(ORC.D_DAT_ORC) DATA1, year(ORC.D_DAT_ORC) DATA ';
    end;
    graficostrio.info.ComandoSQL :=  graficostrio.info.ComandoSQL + ' from CadOrcamentos Orc, '+
                                    ' CadClientes Cli '+
                                    ' Where Orc.I_Emp_Fil = ' + IntToStr(Varia.CodigoEmpFil)+
                                    ' '+SQLTextoDataEntreAAAAMMDD('D_DAT_ORC', EDatInicio.Datetime,EDatFim.Datetime,true) +
                                    ' and ORC.I_COD_CLI = CLI.I_COD_CLI '+
                                    ' AND CLI.C_CID_CLI = '''+LCidade.Caption+''''+
                                    ' group by DATA1, DATA '  +
                                    ' order by 2';
   graficostrio.info.CampoValor := 'Valor';
   graficostrio.info.TituloY := 'Valor';
   graficostrio.info.CampoRotulo := 'DATA';
   graficostrio.info.TituloGrafico := 'Analise de Cidades - ' + LCidade.Caption;
   graficostrio.info.RodapeGrafico := '  Análise da Cidade - '+ varia.NomeFilial;
   graficostrio.info.TituloFormulario := '  Análise da Cidade  '+ LCidade.Caption;
   graficostrio.info.TituloX := 'Datas';
   graficostrio.execute;
  end;
end;

{******************************************************************************}
procedure TFGraficoAnaliseCidade.GeraGraficoVendedor;
begin
  if EVendedor.AInteiro = 0 then
    aviso('VENDEDOR INVÁLIDO!!!'#13'Para gerar o gráfico é necessário escolher o vendedor')
  else
  begin
    case CAgruparpor.ItemIndex of
      0 : graficostrio.info.ComandoSQL :=  'Select Sum(Orc.N_Vlr_LIQ) Valor, Orc.D_DAT_ORC DATA1, Orc.D_DAT_ORC DATA ';
      1 : graficostrio.info.ComandoSQL :=  'Select Sum(Orc.N_Vlr_LIQ) Valor, ('+SQLTextoAno('orc.d_dat_orc')+' *100)+ '+SQLTextoMes('orc.d_dat_orc')+' DATA1, '+SQLTextoMes('Orc.D_DAT_ORC')+' ||''/''|| '+SQLTextoAno('ORC.D_DAT_ORC')+' DATA ';
      3 : graficostrio.info.ComandoSQL :=  'Select Sum(Orc.N_Vlr_LIQ) Valor,'+SQLTextoAno('ORC.D_DAT_ORC')+' DATA1, '+SQLTextoAno('ORC.D_DAT_ORC')+' DATA ';
    end;
    graficostrio.info.ComandoSQL :=  graficostrio.info.ComandoSQL + ' from CadOrcamentos Orc '+
                                    ' Where ORC.I_COD_VEN = '+ EVendedor.Text +
                                    ' '+SQLTextoDataEntreAAAAMMDD('D_DAT_ORC', EDatInicio.Datetime,EDatFim.Datetime,true) ;

   if EFilial.AInteiro <> 0 then
     graficostrio.info.ComandoSQL :=  graficostrio.info.ComandoSQL + 'and Orc.I_Emp_Fil = ' + EFilial.Text;
   if ((varia.CNPJFilial = CNPJ_Kairos) or
      (varia.CNPJFilial = CNPJ_AviamentosJaragua))and
      (EFilial.AInteiro = 0) then
     graficostrio.info.ComandoSQL :=  graficostrio.info.ComandoSQL + 'and Orc.I_Emp_Fil <> 13';

    case CAgruparpor.ItemIndex of
      0 : graficostrio.info.ComandoSQL := graficostrio.info.ComandoSQL+ 'group by  Orc.D_DAT_ORC DATA1, Orc.D_DAT_ORC DATA ';
      1 : graficostrio.info.ComandoSQL := graficostrio.info.ComandoSQL+ 'group by ('+SQLTextoAno('orc.d_dat_orc')+' *100)+ '+SQLTextoMes('orc.d_dat_orc')+', '+SQLTextoMes('Orc.D_DAT_ORC')+' ||''/''|| '+SQLTextoAno('ORC.D_DAT_ORC');
      3 : graficostrio.info.ComandoSQL := graficostrio.info.ComandoSQL+ 'group by '+SQLTextoAno('ORC.D_DAT_ORC')+', '+SQLTextoAno('ORC.D_DAT_ORC');
    end;
   graficostrio.info.ComandoSQL :=  graficostrio.info.ComandoSQL +
                                    ' order by 2';
   graficostrio.info.CampoValor := 'Valor';
   graficostrio.info.TituloY := 'Valor';
   graficostrio.info.CampoRotulo := 'DATA';
   graficostrio.info.TituloGrafico := 'Analise do Vendedor - ' + LNomVendedor.Caption;
   graficostrio.info.RodapeGrafico := '  Análise do Vendedor - '+ varia.NomeFilial;
   graficostrio.info.TituloFormulario := '  Análise do vendedor  '+ LCidade.Caption;
   graficostrio.info.TituloX := 'Datas';
   graficostrio.execute;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFGraficoAnaliseCidade]);
end.
