unit AConhecimentoTransporte;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Componentes1, Localizacao, ComCtrls, Buttons, ExtCtrls,
  PainelGradiente, Grids, DBGrids, Tabela, DBKeyViolation, DB, DBClient, UnNotasFiscaisFor;

type
  TFConhecimentoTransporte = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    Label1: TLabel;
    Label4: TLabel;
    SpeedButton8: TSpeedButton;
    LTransportadora: TLabel;
    CPeriodo: TCheckBox;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    ETransportadora: TEditLocaliza;
    Grade: TGridIndice;
    PanelColor3: TPanelColor;
    BFechar: TBitBtn;
    localiza: TConsultaPadrao;
    BCadastrar: TBitBtn;
    BAlterar: TBitBtn;
    BtExcluir: TBitBtn;
    BConsulta: TBitBtn;
    CONHECIMENTOTRANSPORTE: TSQL;
    DataCONHECIMENTOTRANSPORTE: TDataSource;
    EFilial: TRBEditLocaliza;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    Label3: TLabel;
    CONHECIMENTOTRANSPORTENUMCONHECIMENTO: TFMTBCDField;
    CONHECIMENTOTRANSPORTEDATCONHECIMENTO: TSQLTimeStampField;
    CONHECIMENTOTRANSPORTEVALCONHECIMENTO: TFMTBCDField;
    CONHECIMENTOTRANSPORTEVALBASEICMS: TFMTBCDField;
    CONHECIMENTOTRANSPORTEVALICMS: TFMTBCDField;
    CONHECIMENTOTRANSPORTEPESFRETE: TFMTBCDField;
    CONHECIMENTOTRANSPORTEVALNAOTRIBUTADO: TFMTBCDField;
    CONHECIMENTOTRANSPORTEC_NOM_CLI: TWideStringField;
    CONHECIMENTOTRANSPORTEI_NRO_NOT: TFMTBCDField;
    CONHECIMENTOTRANSPORTENOMTIPODOCUMENTOFISCAL: TWideStringField;
    Label5: TLabel;
    Econhecimento: TEditColor;
    CONHECIMENTOTRANSPORTEI_COD_CLI: TFMTBCDField;
    CONHECIMENTOTRANSPORTECODFILIALNOTA: TFMTBCDField;
    CONHECIMENTOTRANSPORTESEQNOTASAIDA: TFMTBCDField;
    CONHECIMENTOTRANSPORTESEQCONHECIMENTO: TFMTBCDField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BCadastrarClick(Sender: TObject);
    procedure EFilialFimConsulta(Sender: TObject);
    procedure ETransportadoraFimConsulta(Sender: TObject);
    procedure CPeriodoClick(Sender: TObject);
    procedure EDatInicioExit(Sender: TObject);
    procedure EDatFimExit(Sender: TObject);
    procedure EconhecimentoExit(Sender: TObject);
    procedure BConsultaClick(Sender: TObject);
    procedure BAlterarClick(Sender: TObject);
    procedure BtExcluirClick(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
  private
    FunNotaFor : TFuncoesNFFor;
    procedure AtualizaConsulta;
    procedure AdicionaFiltros(VpaSelect : TStrings);
  public
    { Public declarations }
  end;

var
  FConhecimentoTransporte: TFConhecimentoTransporte;

implementation

uses AConhecimentoTransporteSaida, FunSql, APrincipal, Constantes, FunData,
  AConhecimentoTransporteEntrada, ConstMsg;

{$R *.DFM}


{ **************************************************************************** }
procedure TFConhecimentoTransporte.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunNotaFor := TFuncoesNFFor.criar(self,FPrincipal.BaseDados);
  EDatInicio.Date:= PrimeiroDiaMesAnterior;
  EDatFim.Date:= UltimoDiaMesAnterior;
  EFilial.AInteiro:= varia.CodigoEmpFil;
  Efilial.Atualiza;
  AtualizaConsulta;
end;

{ *************************************************************************** }
procedure TFConhecimentoTransporte.AdicionaFiltros(VpaSelect: TStrings);
begin
  if EFilial.AInteiro <> 0 then
    VpaSelect.Add(' AND CON.CODFILIALNOTA = ' + IntToStr(EFilial.AInteiro));

  if ETransportadora.AInteiro <> 0 then
    VpaSelect.Add(' AND CON.CODTRANSPORTADORA = ' + IntToStr(ETransportadora.AInteiro));

  if Econhecimento.AInteiro <> 0 then
    VpaSelect.Add(' AND CON.NUMCONHECIMENTO = ' + IntToStr(Econhecimento.AInteiro));

  if CPeriodo.Checked then
    VpaSelect.add(' AND ' + SQLTextoDataEntreAAAAMMDD('CON.DATCONHECIMENTO',EDatInicio.Date,EDatFim.Date,FALSE));
end;

{ *************************************************************************** }
procedure TFConhecimentoTransporte.AtualizaConsulta;
begin
  CONHECIMENTOTRANSPORTE.Close;
  LimpaSQLTabela(CONHECIMENTOTRANSPORTE);
  AdicionaSQLTabela(CONHECIMENTOTRANSPORTE,
                     'SELECT CON.NUMCONHECIMENTO, CON.DATCONHECIMENTO, CON.VALCONHECIMENTO, CON.SEQNOTASAIDA, ' +
                     ' CON.VALBASEICMS, CON.VALICMS, CON.PESFRETE, CON.VALNAOTRIBUTADO, CON.CODFILIALNOTA, CON.SEQCONHECIMENTO, ' +
                     ' CLI.C_NOM_CLI, CLI.I_COD_CLI, ' +
                     ' NOF.I_NRO_NOT, ' +
                     ' TIP.NOMTIPODOCUMENTOFISCAL ' +
                     ' FROM CONHECIMENTOTRANSPORTE CON, CADCLIENTES CLI, CADNOTAFISCAIS NOF, TIPODOCUMENTOFISCAL TIP ' +
                     ' WHERE CON.CODTRANSPORTADORA = CLI.I_COD_CLI ' +
                     ' AND CON.SEQNOTASAIDA = NOF.I_SEQ_NOT ' +
                     ' AND CON.CODMODELODOCUMENTO = TIP.CODTIPODOCUMENTOFISCAL ' +
                     ' AND CON.SEQNOTASAIDA IS NOT NULL ');
  AdicionaFiltros(CONHECIMENTOTRANSPORTE.SQL);
  CONHECIMENTOTRANSPORTE.sql.add('order by CON.DATCONHECIMENTO, CON.NUMCONHECIMENTO');
  CONHECIMENTOTRANSPORTE.open;
end;

{ *************************************************************************** }
procedure TFConhecimentoTransporte.BAlterarClick(Sender: TObject);
begin
  FConhecimentoTransporteEntrada := TFConhecimentoTransporteEntrada.CriarSDI(self,'',true);
  FConhecimentoTransporteEntrada.ConsultarConhecimento(CONHECIMENTOTRANSPORTEI_COD_CLI.AsInteger, CONHECIMENTOTRANSPORTECODFILIALNOTA.AsInteger, CONHECIMENTOTRANSPORTESEQNOTASAIDA.AsInteger, false);
  FConhecimentoTransporteEntrada.Free;
end;

{ *************************************************************************** }
procedure TFConhecimentoTransporte.BCadastrarClick(Sender: TObject);
begin
  FConhecimentoTransporteSaida := TFConhecimentoTransporteSaida.CriarSDI(self,'',true);
  FConhecimentoTransporteSaida.NovoConhecimento;
  FConhecimentoTransporteSaida.Free;
end;

{ *************************************************************************** }
procedure TFConhecimentoTransporte.BConsultaClick(Sender: TObject);
begin
  FConhecimentoTransporteEntrada := TFConhecimentoTransporteEntrada.CriarSDI(self,'',true);
  FConhecimentoTransporteEntrada.ConsultarConhecimento(CONHECIMENTOTRANSPORTEI_COD_CLI.AsInteger, CONHECIMENTOTRANSPORTECODFILIALNOTA.AsInteger, CONHECIMENTOTRANSPORTESEQNOTASAIDA.AsInteger, false);
  FConhecimentoTransporteEntrada.Free;
end;

{ *************************************************************************** }
procedure TFConhecimentoTransporte.BFecharClick(Sender: TObject);
begin
  Close;
end;

{ *************************************************************************** }
procedure TFConhecimentoTransporte.BImprimirClick(Sender: TObject);
begin

end;

{ *************************************************************************** }
procedure TFConhecimentoTransporte.BtExcluirClick(Sender: TObject);
var
  VpfResultado: String;
begin
 if Confirmacao('Deseja realmente excluir o conhecimento : ' + IntToStr(CONHECIMENTOTRANSPORTENUMCONHECIMENTO.AsInteger)+ ' - ' + CONHECIMENTOTRANSPORTEC_NOM_CLI.AsString) then
  VpfResultado:= FunNotaFor.ExcluiConhecimentoTransporte(CONHECIMENTOTRANSPORTECODFILIALNOTA.AsInteger, CONHECIMENTOTRANSPORTESEQCONHECIMENTO.AsInteger, CONHECIMENTOTRANSPORTEI_COD_CLI.AsInteger);

 if VpfResultado <> '' then
   aviso(VpfResultado);
 AtualizaConsulta;
end;

{ *************************************************************************** }
procedure TFConhecimentoTransporte.CPeriodoClick(Sender: TObject);
begin
  AtualizaConsulta;
end;

{ *************************************************************************** }
procedure TFConhecimentoTransporte.EconhecimentoExit(Sender: TObject);
begin
  AtualizaConsulta;
end;

{ *************************************************************************** }
procedure TFConhecimentoTransporte.EDatFimExit(Sender: TObject);
begin
  AtualizaConsulta;
end;

{ *************************************************************************** }
procedure TFConhecimentoTransporte.EDatInicioExit(Sender: TObject);
begin
  AtualizaConsulta;
end;

{ *************************************************************************** }
procedure TFConhecimentoTransporte.EFilialFimConsulta(Sender: TObject);
begin
  AtualizaConsulta;
end;

{ *************************************************************************** }
procedure TFConhecimentoTransporte.ETransportadoraFimConsulta(Sender: TObject);
begin
  AtualizaConsulta;
end;

{ *************************************************************************** }
procedure TFConhecimentoTransporte.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunNotaFor.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFConhecimentoTransporte]);
end.
