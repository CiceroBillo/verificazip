unit AGraficosContasaReceber;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, PainelGradiente, StdCtrls, Buttons, ComCtrls, DBCidade,
  Componentes1, Localizacao, Db, DBTables, Graficos, FMTBcd, SqlExpr;

type
  TFGraficosCR = class(TFormularioPermissao)
    Painel: TPanelColor;
    GraficosTrio: TGraficosTrio;
    GraficosLinhas: TGraficosLinhas;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Aux: TSQLQuery;
    localiza: TConsultaPadrao;
    BitBtn7: TBitBtn;
    Botao: TBitBtn;
    BitBtn5: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure BotaoClick(Sender: TObject);
  private
      largura, altura : integer;
      PosX,PosY : Integer;
      function StringFilial : String;
      function NomeEmpresaFilial : string;
  public
    CodigoEmpresa, CodigoFilial : string;
    NomeEmpresa, NomeFilial : string;
    Data1, Data2 : TDateTime
  end;

var
  FGraficosCR: TFGraficosCR;

implementation

uses APrincipal, constantes, FunData, FunSql;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFGraficosCR.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  PosX := self.Left;
  PosY := self.Top;
  altura := self.Width;
  largura := self.Height;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFGraficosCR.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 { fecha tabelas }
 { chamar a rotina de atualização de menus }
 Action := CaFree;
 FGraficosCR := nil;
end;


function TFGraficosCR.StringFilial : String;
begin
if CodigoFilial <> '' then
  result := ' and MCR.I_EMP_FIL = ' + CodigoFilial
else
   if CodigoEmpresa <> '' then
      result := ' and MCR.I_EMP_FIL in (Select FIL.I_EMP_FIL from CadEmpresas emp, CadFiliais fil ' +
                ' where EMP.I_COD_EMP = FIL.I_COD_EMP ' +
                ' and EMP.I_COD_EMP = ' + CodigoEmpresa + ')'
   else
       result := ' ';
end;

function TFGraficosCR.NomeEmpresaFilial : string;
begin
  result := 'Empresa : ' + nomeEmpresa + ' - Filial : ' + NomeFilial + '    - Período de '+ DateToStr(data1) + ' à ' + DateToStr(data2);
end;

{******************carrega o grafico pelo filtro de clientes*******************}

procedure TFGraficosCR.BitBtn1Click(Sender: TObject);
begin
    graficostrio.info.ComandoSQL :=  'Select sum(N_Vlr_PAR) valor, C.C_NOM_CLI from ' +
                                     ' MovContasareceber MCR, ' +
                                     ' CadContasaReceber CR, ' +
                                     ' CadClientes C ' +
                                     ' where ' +
                                     ' CR.I_EMP_FIL = MCR.I_EMP_FIL ' +
                                     ' and CR.I_LAN_REC = MCR.I_LAN_REC ' +
                                     ' and CR.I_COD_CLI = C.I_COD_CLI ' +
                                     StringFilial +
                                     SQLTextoDataEntreAAAAMMDD('D_DAT_VEN',Data1,Data2,true)+
                                     ' GROUP BY CR.I_COD_CLI, C_NOM_CLI';
    graficostrio.info.CampoRotulo := 'C_NOM_CLI';
    graficostrio.info.CampoValor := 'valor';
    graficostrio.info.TituloGrafico := 'Valor por Cliente ';
    graficostrio.info.RodapeGrafico := NomeEmpresaFilial;
    graficostrio.info.TituloFormulario := 'Gráfico de Clientes';
    graficostrio.info.TituloY := 'valor';
    graficostrio.info.TituloX := 'Clientes';
    self.Visible := false;
    graficostrio.execute;
    self.Visible := true;
end;

{**************Carrega o grafico pelas duplicatas do cliente*******************}

procedure TFGraficosCR.BitBtn2Click(Sender: TObject);
begin
   self.Visible := false;
    Localiza.info.DataBase := Fprincipal.BaseDados;
    Localiza.info.ComandoSQL := 'Select * from dba.cadclientes Where c_nom_cli like ''@%'' order by c_nom_cli asc';
    Localiza.info.caracterProcura := '@';
    Localiza.info.ValorInicializacao := '';
    Localiza.info.CamposMostrados[0] := 'i_cod_cli';
    Localiza.info.CamposMostrados[1] := 'c_nom_cli';
    Localiza.info.DescricaoCampos[0] := 'codigo';
    Localiza.info.DescricaoCampos[1] := 'nome';
    Localiza.info.TamanhoCampos[0] := 8;
    Localiza.info.TamanhoCampos[1] := 40;
    Localiza.info.CamposRetorno[0] := 'i_cod_cli';
    Localiza.info.CamposRetorno[1] := 'c_nom_cli';
    Localiza.info.SomenteNumeros := false;
    Localiza.info.CorFoco := FPrincipal.CorFoco;
    Localiza.info.CorForm := FPrincipal.CorForm;
    Localiza.info.CorPainelGra := FPrincipal.CorPainelGra;
    Localiza.info.TituloForm := 'Localizar Clientes';

if localiza.execute then
begin
    graficostrio.info.ComandoSQL :=  'Select month(MCR.D_DAT_VEN) as mes, sum(MCR.N_Vlr_PAR) as valor from ' +
                                     'dba.MovContasaReceber as MCR, ' +
                                     'dba.CadContasaReceber as CR, ' +
                                     'dba.CadClientes as C, ' +
                                     'where ' +
                                     'CR.I_EMP_FIL = MCR.I_EMP_FIL ' +
                                     'and CR.I_LAN_REC = MCR.I_LAN_REC ' +
                                     'and CR.I_COD_CLI = C.I_COD_CLI ' +
                                     'and CR.I_COD_CLI = ' + localiza.retorno[0] +
                                     StringFilial +
                                     ' and D_DAT_VEN between ''' + DataToStrFormato(AAAAMMDD,Data1,'/') + '''' +
                                     ' and ''' + DataToStrFormato(AAAAMMDD,Data2,'/') + '''' +
                                     'GROUP BY year(MCR.D_DAT_VEN), month(MCR.D_DAT_VEN)';
    graficostrio.info.CampoRotulo := 'mes';
    graficostrio.info.CampoValor := 'valor';
    graficostrio.info.TituloGrafico := 'Valores do Cliente ' + localiza.retorno[1] ;
    graficostrio.info.TituloFormulario := 'Gráfico de Cliente';
    graficostrio.info.RodapeGrafico := NomeEmpresaFilial;
    graficostrio.info.TituloY := 'valor';
    graficostrio.info.TituloX := 'Mes';
    graficostrio.execute;
end;
self.Visible := true;
end;

{*****************Carrega o grafico pelo historico padrao**********************}

procedure TFGraficosCR.BitBtn3Click(Sender: TObject);
begin
    self.Visible := false;
    graficostrio.info.ComandoSQL :=  ' Select sum(N_Vlr_PAR) as valor, P.C_NOM_PLA from ' +
                                     ' MovContasaReceber as MCR, ' +
                                     ' CadContasaReceber as CR, ' +
                                     ' Cad_Plano_conta as P, ' +
                                     ' where ' +
                                     ' CR.I_EMP_FIL = MCR.I_EMP_FIL ' +
                                     ' and CR.I_LAN_REC = MCR.I_LAN_REC ' +
                                     ' and CR.C_CLA_PLA = P.C_CLA_PLA ' +
                                     StringFilial +
                                     ' and D_DAT_VEN between ''' + DataToStrFormato(AAAAMMDD,Data1,'/') + '''' +
                                     ' and ''' + DataToStrFormato(AAAAMMDD,Data2,'/') + '''' +
                                     'GROUP BY P.C_CLA_PLA, P.C_NOM_PLA';
    graficostrio.info.CampoRotulo := 'C_NOM_PLA';
    graficostrio.info.CampoValor := 'valor';
    graficostrio.info.TituloGrafico := 'Valor por Plano de Contas';
    graficostrio.info.RodapeGrafico := NomeEmpresaFilial;
    graficostrio.info.TituloFormulario := 'Gráfico de Plano de Contas';
    graficostrio.info.TituloY := 'valor';
    graficostrio.info.TituloX := 'Plano';
    graficostrio.execute;
    self.Visible := true;
end;

{******************carrega o grafico pelo historico****************************}

procedure TFGraficosCR.BitBtn4Click(Sender: TObject);
begin
self.Visible := false;
    Localiza.info.DataBase := Fprincipal.BaseDados;
    Localiza.info.ComandoSQL := 'Select * from Cad_Plano_Conta where C_NOM_PLA like ''@%''' +
                                ' and c_tip_pla = ''C'' order by c_nom_pla asc';
    Localiza.info.caracterProcura := '@';
    Localiza.info.ValorInicializacao := '';
    Localiza.info.CamposMostrados[0] := 'C_CLA_PLA';
    Localiza.info.CamposMostrados[1] := 'C_NOM_PLA';
    Localiza.info.DescricaoCampos[0] := 'codigo';
    Localiza.info.DescricaoCampos[1] := 'nome';
    Localiza.info.TamanhoCampos[0] := 8;
    Localiza.info.TamanhoCampos[1] := 40;
    Localiza.info.CamposRetorno[0] := 'C_CLA_PLA';
    Localiza.info.CamposRetorno[1] := 'c_nom_pla';
    Localiza.info.SomenteNumeros := false;
    Localiza.info.CorFoco := FPrincipal.CorFoco;
    Localiza.info.CorForm := FPrincipal.CorForm;
    Localiza.info.CorPainelGra := FPrincipal.CorPainelGra;
    Localiza.info.TituloForm := 'Localizar Plano de Contas';

if localiza.execute then
begin
    graficostrio.info.ComandoSQL :=  ' Select month(MCR.D_DAT_VEN) as mes, sum(MCR.N_Vlr_PAR) as valor from ' +
                                     ' MovContasaReceber as MCR, ' +
                                     ' CadContasaReceber as CR, ' +
                                     ' Cad_Plano_Conta as P, ' +
                                     ' where ' +
                                     ' CR.I_EMP_FIL = MCR.I_EMP_FIL ' +
                                     ' and CR.I_LAN_REC = MCR.I_LAN_REC ' +
                                     ' and CR.C_CLA_PLA = P.C_CLA_PLA '+
                                     ' and CR.C_CLA_PLA = ''' + localiza.retorno[0] + '''' +
                                     StringFilial +
                                     ' and D_DAT_VEN between ''' + DataToStrFormato(AAAAMMDD,Data1,'/') + '''' +
                                     ' and ''' + DataToStrFormato(AAAAMMDD,Data2,'/') + '''' +
                                     'GROUP BY year(MCR.D_DAT_VEN), month(MCR.D_DAT_VEN)';
    graficostrio.info.CampoRotulo := 'mes';
    graficostrio.info.CampoValor := 'valor';
    graficostrio.info.TituloGrafico := localiza.retorno[1] ;
    graficostrio.info.TituloFormulario := 'Gráfico de Plano de Contas';
    graficostrio.info.RodapeGrafico := NomeEmpresaFilial;
    graficostrio.info.TituloY := 'valor';
    graficostrio.info.TituloX := 'Mes';
    graficostrio.execute;
end;
self.Visible := true;
end;

procedure TFGraficosCR.BitBtn7Click(Sender: TObject);
begin
close;
end;

procedure TFGraficosCR.FormDeactivate(Sender: TObject);
begin
  self.ClientWidth := botao.Width;
  self.ClientHeight := botao.Height;
  Botao.Visible := true;
end;

procedure TFGraficosCR.BotaoClick(Sender: TObject);
begin
self.Left := PosX;
self.Top := PosY;
self.Width := altura;
self.Height := largura;
Botao.Visible := false;
end;


Initialization
 RegisterClasses([TFGraficosCR]);
end.
