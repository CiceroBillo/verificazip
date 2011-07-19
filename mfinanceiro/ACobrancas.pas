unit ACobrancas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Grids, DBGrids, Tabela,
  DBKeyViolation, Db, DBTables, StdCtrls, Localizacao, Buttons, Mask,
  numericos, DBCtrls, ComCtrls, Graficos, DBClient;

type
  TFCobrancas = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Cobranca: TSQL;
    Localiza: TConsultaPadrao;
    SpeedButton5: TSpeedButton;
    ECodFilial: TEditLocaliza;
    Label24: TLabel;
    Label25: TLabel;
    ELanReceber: Tnumerico;
    Label1: TLabel;
    Label2: TLabel;
    ENumParcela: Tnumerico;
    BFechar: TBitBtn;
    DataCobranca: TDataSource;
    CobrancaSEQCOBRANCA: TFMTBCDField;
    CobrancaDATCOBRANCA: TSQLTimeStampField;
    CobrancaC_NOM_CLI: TWideStringField;
    CobrancaDESHISTORICO: TWideStringField;
    CobrancaDESFALADOCOM: TWideStringField;
    CobrancaC_NOM_USU: TWideStringField;
    CobrancaDESOBSERVACAO: TWideStringField;
    CobrancaDATPROXIMALIGACAO: TSQLTimeStampField;
    CobrancaDATPROMESSAPAGAMENTO: TSQLTimeStampField;
    CobrancaDESOBSPROXIMALIGACAO: TWideStringField;
    PanelColor3: TPanelColor;
    GridIndice1: TGridIndice;
    DBMemoColor1: TDBMemoColor;
    CPeriodo: TCheckBox;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    Label3: TLabel;
    ECodCliente: TEditLocaliza;
    Label18: TLabel;
    SpeedButton4: TSpeedButton;
    Label20: TLabel;
    Label4: TLabel;
    ECodUsuario: TEditLocaliza;
    SpeedButton1: TSpeedButton;
    Label5: TLabel;
    CobrancaItem: TSQL;
    DataCobrancaItem: TDataSource;
    GridIndice2: TGridIndice;
    CobrancaItemI_EMP_FIL: TFMTBCDField;
    CobrancaItemI_LAN_REC: TFMTBCDField;
    CobrancaItemI_NRO_PAR: TFMTBCDField;
    CobrancaItemD_DAT_VEN: TSQLTimeStampField;
    CobrancaItemN_VLR_PAR: TFMTBCDField;
    CobrancaItemC_NRO_DUP: TWideStringField;
    CobrancaItemI_QTD_LIG: TFMTBCDField;
    CobrancaItemI_QTD_ATE: TFMTBCDField;
    CobrancaItemC_NOM_FRM: TWideStringField;
    BGraficoDia: TBitBtn;
    GraficosTrio: TGraficosTrio;
    CObservacoes: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure EDatInicioCloseUp(Sender: TObject);
    procedure CobrancaAfterScroll(DataSet: TDataSet);
    procedure BGraficoDiaClick(Sender: TObject);
  private
    { Private declarations }
    procedure Atualizaconsulta;
    procedure AdicionaFiltros(VpaComando : TStrings);
    procedure AtualizaConsultaItem;
    procedure GraficoCobrancasPorDia;
  public
    { Public declarations }
    procedure HistoricoCobranca(VpaCodfilia,VpaLanReceber,VpaNumParcela : Integer);
    procedure ConsultaCobrancas;
  end;

var
  FCobrancas: TFCobrancas;

implementation

uses APrincipal,Constantes, funData,funSql;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFCobrancas.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EDatInicio.DateTime := PrimeirodiaMes(date);
  EDAtFim.DateTime := UltimodiaMes(date)
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFCobrancas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFCobrancas.Atualizaconsulta;
begin
  Cobranca.close;
  Cobranca.SQL.clear;
  Cobranca.Sql.add('select SEQCOBRANCA, DATCOBRANCA, CLI.C_NOM_CLI, HIS.DESHISTORICO,'+
                   'COB.DESFALADOCOM, USU.C_NOM_USU, COB.DESOBSERVACAO, COB.DATPROXIMALIGACAO,'+
                   ' COB.DATPROMESSAPAGAMENTO, DESOBSPROXIMALIGACAO '+
                   ' from COBRANCACORPO COB, HISTORICOLIGACAO HIS, CADUSUARIOS USU, CADCLIENTES CLI '+
                   ' WHERE HIS.CODHISTORICO = COB.CODHISTORICO '+
                   ' AND COB.CODUSUARIO = USU.I_COD_USU '+
                   ' AND COB.CODCLIENTE = CLI.I_COD_CLI');
  AdicionaFiltros(Cobranca.sql);
  Cobranca.Sql.add('order by COB.DATCOBRANCA');

  Cobranca.open;
end;

{******************************************************************************}
procedure TFCobrancas.AdicionaFiltros(VpaComando : TStrings);
begin
  if CPeriodo.Checked then
    VpaComando.add(SQLTextoDataEntreAAAAMMDD('DATCOBRANCA',EDatInicio.DateTime,EDatFim.Datetime,true));
  if CObservacoes.Checked then
    VpaComando.Add('AND DESOBSPROXIMALIGACAO IS NOT NULL');
  if Ecodcliente.Ainteiro <> 0 then
    VpaComando.add('and COB.CODCLIENTE = '+ECodCliente.Text);
  if ECodUsuario.AInteiro <> 0 then
    VpaComando.Add('and COB.CODUSUARIO = ' + ECodUsuario.Text);

  if (ECodFilial.AInteiro <> 0) and (ENumParcela.AsInteger <> 0) and (ELanReceber.AsInteger <> 0) then
    VpaComando.add(' AND EXISTS '+
                     '(SELECT * FROM COBRANCAITEM ITE '+
                     ' WHERE COB.SEQCOBRANCA = ITE.SEQCOBRANCA '+
                     ' AND ITE.CODFILIAL = ' +ECodFilial.Text+
                     ' AND ITE.LANRECEBER = '+ELanReceber.Text+
                     ' AND ITE.NUMPARCELA = '+ENumParcela.Text+' )');

end;

{******************************************************************************}
procedure TFCobrancas.AtualizaConsultaItem;
begin
  AdicionaSQLAbreTabela(CobrancaItem,'select MOV.I_EMP_FIL, MOV.I_LAN_REC, MOV.I_NRO_PAR, MOV.D_DAT_VEN, MOV.N_VLR_PAR, '+
                                     ' MOV.C_NRO_DUP, MOV.I_QTD_LIG, MOV.I_QTD_ATE, FRM.C_NOM_FRM '+
                                     ' from MOVCONTASARECEBER MOV, CADFORMASPAGAMENTO FRM, COBRANCAITEM ITE '+
                                     ' WHERE MOV.I_COD_FRM = FRM.I_COD_FRM '+
                                     ' AND MOV.I_EMP_FIL = ITE.CODFILIAL '+
                                     ' AND MOV.I_LAN_REC = ITE.LANRECEBER '+
                                     ' AND MOV.I_NRO_PAR = ITE.NUMPARCELA '+
                                     ' AND ITE.SEQCOBRANCA = '+CobrancaSEQCOBRANCA.AsString);
end;

{******************************************************************************}
procedure TFCobrancas.GraficoCobrancasPorDia;
var
  vpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.create;
  VpfComandoSql.add('SELECT COUNT(SEQCOBRANCA)QTD, DATEFORMAT(DATCOBRANCA,''DD/MM/YY'') DATA '+
                ' FROM COBRANCACORPO COB'+
                ' Where COB.CODHISTORICO <> ' + IntToStr(varia.CodHistoricoNaoLigado));
  AdicionaFiltros(vpfComandoSql);
  vpfComandoSql.add('GROUP BY DATEFORMAT(DATCOBRANCA,''DD/MM/YY'') '+
                    ' ORDER BY 2');
  graficostrio.info.CampoValor := 'Qtd';
  graficostrio.info.TituloY := 'Quantidade';

  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'DATA';
  graficostrio.info.TituloGrafico := 'Qtd Cobranças por Dia - ' + Varia.NomeFilial;
  graficostrio.info.RodapeGrafico := 'Qtd Cobrancas por Dia';
  graficostrio.info.TituloFormulario := 'Gráfico de Cobranças';
  graficostrio.info.TituloX := 'Cobrança';
  graficostrio.execute;
end;

{******************************************************************************}
procedure TFCobrancas.HistoricoCobranca(VpaCodfilia,VpaLanReceber,VpaNumParcela : Integer);
begin
  ECodFilial.AInteiro := VpaCodfilia;
  ECodFilial.Atualiza;
  ELanReceber.AsInteger := VpaLanReceber;
  ENumParcela.Asinteger :=  VpaNumParcela;
  CPeriodo.Checked :=false;
  Atualizaconsulta;
  ShowModal;
end;

{******************************************************************************}
procedure TFCobrancas.ConsultaCobrancas;
begin
  Atualizaconsulta;
  Showmodal;
end;

{******************************************************************************}
procedure TFCobrancas.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFCobrancas.EDatInicioCloseUp(Sender: TObject);
begin
  Atualizaconsulta;
end;

{******************************************************************************}
procedure TFCobrancas.CobrancaAfterScroll(DataSet: TDataSet);
begin
  AtualizaConsultaItem;
end;

{******************************************************************************}
procedure TFCobrancas.BGraficoDiaClick(Sender: TObject);
begin
  GraficoCobrancasPorDia;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFCobrancas]);
end.
