unit AFaturamentoMensal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Grids, DBGrids, Tabela, DBKeyViolation, Componentes1,
  ExtCtrls, PainelGradiente, Db, DBTables, UnCrystal,UnDados, UnClientes, UnImpressaoBoleto,
  ComCtrls, UnContrato, FMTBcd, SqlExpr, DBClient;

type
  TFFaturamentoMensal = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    BNovo: TBitBtn;
    BBoletos: TBitBtn;
    BEnvelopes: TBitBtn;
    BFechar: TBitBtn;
    PanelColor1: TPanelColor;
    GridIndice2: TGridIndice;
    GridIndice1: TGridIndice;
    ContratoProcessado: TSQL;
    DataContratoProcessado: TDataSource;
    ContratoProcessadoSEQPROCESSADO: TFMTBCDField;
    ContratoProcessadoDATPROCESSADO: TSQLTimeStampField;
    ContratoProcessadoC_NOM_USU: TWideStringField;
    ItensProcessados: TSQL;
    ItensProcessadosINDPROCESSADO: TWideStringField;
    ItensProcessadosDESERRO: TWideStringField;
    ItensProcessadosI_LAN_ORC: TFMTBCDField;
    ItensProcessadosN_VLR_TOT: TFMTBCDField;
    ItensProcessadosC_NRO_NOT: TWideStringField;
    ItensProcessadosC_NOM_CLI: TWideStringField;
    ItensProcessadosNUMCONTRATO: TWideStringField;
    DataItensProcessados: TDataSource;
    ContratoProcessadoCODFILIAL: TFMTBCDField;
    Splitter1: TSplitter;
    ItensProcessadosCODFILIAL: TFMTBCDField;
    ItensProcessadosI_COD_CLI: TFMTBCDField;
    BReprocessar: TBitBtn;
    Aux: TSQLQuery;
    BImprimir: TBitBtn;
    PanelColor3: TPanelColor;
    Label3: TLabel;
    EDataInicial: TCalendario;
    Label4: TLabel;
    EDataFinal: TCalendario;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BNovoClick(Sender: TObject);
    procedure ContratoProcessadoAfterScroll(DataSet: TDataSet);
    procedure BEnvelopesClick(Sender: TObject);
    procedure BReprocessarClick(Sender: TObject);
    procedure BBoletosClick(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure EDataInicialCloseUp(Sender: TObject);
  private
    { Private declarations }
    FunImpFolhaBranca: TImpressaoBoleto;
    FunContrato : TRBFuncoesContrato;
    procedure AtualizaConsulta;
    procedure PosConsultaItem;
  public
    { Public declarations }
  end;

var
  FFaturamentoMensal: TFFaturamentoMensal;

implementation

uses APrincipal, ANovoFaturamentoMensal, Constantes, FunSql, FunData, dmRave;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFFaturamentoMensal.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EDataInicial.DateTime := PrimeiroDiaMes(date);
  EDataFinal.DateTime := UltimoDiaMes(date);
  FunImpFolhaBranca := TImpressaoBoleto.cria(FPrincipal.BaseDados);
  FunContrato := TRBFuncoesContrato.cria(FPrincipal.BaseDados);
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFFaturamentoMensal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunImpFolhaBranca.free;
  FunContrato.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
procedure TFFaturamentoMensal.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFFaturamentoMensal.BNovoClick(Sender: TObject);
begin
  FNovoFaturamentoMensal := TFNovoFaturamentoMensal.CriarSDI(application,'', FPrincipal.VerificaPermisao('FNovoFaturamentoMensal'));
  FNovoFaturamentoMensal.ShowModal;
  FNovoFaturamentoMensal.free;
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFFaturamentoMensal.AtualizaConsulta;
begin
  ContratoProcessado.close;
  ContratoProcessado.SQL.Clear;
  ContratoProcessado.SQL.Add('select CON.CODFILIAL, CON.SEQPROCESSADO, CON.DATPROCESSADO, USU.C_NOM_USU '+
                             ' from CONTRATOPROCESSADOCORPO CON, CADUSUARIOS USU '+
                             ' Where CON.CODUSUARIO = USU.I_COD_USU '+
                             ' and CON.CODFILIAL = '+IntToStr(Varia.CodigoEmpFil));
  ContratoProcessado.sql.add(SQLTextoDataEntreAAAAMMDD('TRUNC(CON.DATPROCESSADO)',EDataInicial.Datetime,EDataFinal.DateTime,true));
  ContratoProcessado.SQL.Add('order by CON.SEQPROCESSADO');
  ContratoProcessado.Open;
end;

{******************************************************************************}
procedure TFFaturamentoMensal.PosConsultaItem;
begin
  ItensProcessados.Close;
  ItensProcessados.Sql.Clear;
  ItensProcessados.Sql.add('select CON.CODFILIAL,CON.INDPROCESSADO, CON.DESERRO, ' +
                           ' ORC.I_LAN_ORC, ORC.N_VLR_TOT, ORC.C_NRO_NOT, '+
                           ' CLI.C_NOM_CLI, CLI.I_COD_CLI, '+
                           ' COC.NUMCONTRATO '+
                           ' from CONTRATOPROCESSADOITEM CON, CADORCAMENTOS ORC, CADCLIENTES CLI, CONTRATOCORPO COC '+
                           ' Where CON.CODFILIAL = ORC.I_EMP_FIL ' +
                           ' and CON.LANORCAMENTO = ORC.I_LAN_ORC '+
                           ' AND ORC.I_COD_CLI = CLI.I_COD_CLI '+
                           ' AND '+SQLTextoRightJoin('CON.CODFILIAL','COC.CODFILIAL')+
                           ' AND '+SQLTextoRightJoin('CON.SEQCONTRATO','COC.SEQCONTRATO')+
                           ' AND CON.CODFILIAL = '+ContratoProcessadoCODFILIAL.AsString +
                           ' AND CON.SEQPROCESSADO = '+ContratoProcessadoSEQPROCESSADO.AsString);
  ItensProcessados.Sql.add('order by CON.LANORCAMENTO');
  ItensProcessados.open;
end;

{******************************************************************************}
procedure TFFaturamentoMensal.ContratoProcessadoAfterScroll(
  DataSet: TDataSet);
begin
  PosConsultaItem;
end;

{******************************************************************************}
procedure TFFaturamentoMensal.BEnvelopesClick(Sender: TObject);
var
  VpfDCliente : TRBDCliente;
begin
  ItensProcessados.First;
  while not ItensProcessados.Eof do
  begin
    if ((config.ImprimirEnvolopeSomentecomNotaFatMensal) and (ItensProcessadosC_NRO_NOT.AsString <> '')) or
       not(config.ImprimirEnvolopeSomentecomNotaFatMensal) then
    begin
      VpfDCliente := TRBDCliente.cria;
      VpfDCliente.CodCliente := ItensProcessadosI_COD_CLI.AsInteger;
      FunClientes.CarDCliente(VpfDCliente);
      dtRave := TdtRave.create(self);
      if VpfDCliente.DesEnderecoEntrega <> '' then
        dtRave.ImprimeEnvelopeEntrega(VpfDCliente)
      else
        dtRave.ImprimeEnvelope(VpfDCliente);
      dtRave.free;
    end;
    ItensProcessados.Next;
  end;
end;

{******************************************************************************}
procedure TFFaturamentoMensal.BReprocessarClick(Sender: TObject);
begin
  FunContrato.SetaReprocessarContratos(ContratoProcessadoCODFILIAL.AsInteger,ContratoProcessadoSEQPROCESSADO.AsInteger);
end;

{******************************************************************************}
procedure TFFaturamentoMensal.BBoletosClick(Sender: TObject);
var
  VpfCotacaoAnterior : Integer;
begin
  VpfCotacaoAnterior := -1;
  ItensProcessados.First;
  while not ItensProcessados.Eof do
  begin
    if VpfCotacaoAnterior <> ItensProcessadosI_LAN_ORC.AsInteger then
    begin
      FunContrato.ImprimirBoleto(ItensProcessadosCODFILIAL.AsInteger,ItensProcessadosI_LAN_ORC.AsInteger,ItensProcessadosI_COD_CLI.AsInteger);
      VpfCotacaoAnterior := ItensProcessadosI_LAN_ORC.AsInteger;
    end;
    ItensProcessados.Next;
  end;
end;

{******************************************************************************}
procedure TFFaturamentoMensal.BImprimirClick(Sender: TObject);
begin
  FunCrystal.ImprimeRelatorio(Varia.PathRelatorios+ '\Contratos\XX_ContratosProcessados.rpt',[ContratoProcessadoCODFILIAL.AsString,ContratoProcessadoSEQPROCESSADO.AsString]);
end;

{******************************************************************************}
procedure TFFaturamentoMensal.EDataInicialCloseUp(Sender: TObject);
begin
  AtualizaConsulta;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFFaturamentoMensal]);
end.
