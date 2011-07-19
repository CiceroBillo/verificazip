unit ANovoECF;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Localizacao, Buttons,
  Grids, CGrades, Db, DBTables, Mask, DBCtrls, Tabela, UnECF, ComCtrls, UnContasAReceber,
  DBGrids, DBKeyViolation, numericos,UnDadosCR, UnDadosProduto, UnCotacao, UnDados, UnClientes,
  UnVendedor, FMTBcd, SqlExpr, DBClient, OleCtrls, SHDocVw;

type
  TFNovoECF = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    Label1: TLabel;
    ECodCliente: TEditLocaliza;
    SpeedButton1: TSpeedButton;
    ConsultaPadrao1: TConsultaPadrao;
    Label2: TLabel;
    Bevel1: TBevel;
    CadNotaFiscal: TSQL;
    DataCadNotaFiscal: TDataSource;
    BNovo: TBitBtn;
    MovNotasFiscais: TSQL;
    MovNotasFiscaisI_EMP_FIL: TFMTBCDField;
    MovNotasFiscaisI_SEQ_NOT: TFMTBCDField;
    MovNotasFiscaisC_COD_UNI: TWideStringField;
    MovNotasFiscaisN_QTD_PRO: TFMTBCDField;
    MovNotasFiscaisN_VLR_PRO: TFMTBCDField;
    MovNotasFiscaisN_PER_ICM: TFMTBCDField;
    MovNotasFiscaisN_PER_IPI: TFMTBCDField;
    MovNotasFiscaisN_TOT_PRO: TFMTBCDField;
    MovNotasFiscaisC_COD_CST: TWideStringField;
    MovNotasFiscaisI_ORD_FIS: TFMTBCDField;
    MovNotasFiscaisC_CLA_FIS: TWideStringField;
    MovNotasFiscaisI_SEQ_MOV: TFMTBCDField;
    MovNotasFiscaisI_NUM_ITE: TFMTBCDField;
    MovNotasFiscaisI_SEQ_PRO: TFMTBCDField;
    MovNotasFiscaisC_COD_PRO: TWideStringField;
    MovNotasFiscaisD_ULT_ALT: TSQLTimeStampField;
    DataMovNotasFiscais: TDataSource;
    MostraItens: TSQL;
    MostraItensC_COD_PRO: TWideStringField;
    MostraItensC_COD_UNI: TWideStringField;
    MostraItensN_QTD_PRO: TFMTBCDField;
    MostraItensN_VLR_PRO: TFMTBCDField;
    MostraItensN_PER_ICM: TFMTBCDField;
    MostraItensN_TOT_PRO: TFMTBCDField;
    MostraItensC_NOM_PRO: TWideStringField;
    MostraItensI_NUM_ITE: TFMTBCDField;
    MostraItensI_SEQ_PRO: TFMTBCDField;
    DataMostraItens: TDataSource;
    cadProdutos: TSQLQuery;
    MovNotasFiscaisN_PER_DES: TFMTBCDField;
    ECodCondicaoPagamento: TEditLocaliza;
    Label10: TLabel;
    SpeedButton3: TSpeedButton;
    LCondicaoPagamento: TLabel;
    MostraItensI_SEQ_MOV: TFMTBCDField;
    MostraItensN_PER_DES: TFMTBCDField;
    PanelColor4: TPanelColor;
    BarraStatus: TStatusBar;
    PanelColor3: TPanelColor;
    BCancelaCupom: TBitBtn;
    LNroCupom: TLabel;
    BFechamento: TBitBtn;
    BCancelaItem: TBitBtn;
    BFechar: TBitBtn;
    MovServicoNota: TSQL;
    MovServicoNotaI_EMP_FIL: TFMTBCDField;
    MovServicoNotaI_COD_SER: TFMTBCDField;
    MovServicoNotaI_SEQ_NOT: TFMTBCDField;
    MovServicoNotaN_VLR_SER: TFMTBCDField;
    MovServicoNotaI_COD_EMP: TFMTBCDField;
    MovServicoNotaN_QTD_SER: TFMTBCDField;
    MovServicoNotaN_TOT_SER: TFMTBCDField;
    MovServicoNotaD_ULT_ALT: TSQLTimeStampField;
    MovServico: TDataSource;
    MostraServicos: TSQL;
    DataMostraServicos: TDataSource;
    MostraServicosI_COD_SER: TFMTBCDField;
    MostraServicosN_QTD_SER: TFMTBCDField;
    MostraServicosN_VLR_SER: TFMTBCDField;
    MostraServicosN_TOT_SER: TFMTBCDField;
    MostraServicosC_NOM_SER: TWideStringField;
    MovServicoNotaI_SEQ_MOV: TFMTBCDField;
    MostraItensC_PRO_REF: TWideStringField;
    PanelColor5: TPanelColor;
    wBobina: TWebBrowser;
    MBobina: TMemo;
    Paginas: TPageControl;
    PCupom: TTabSheet;
    PProduto: TTabSheet;
    PServico: TTabSheet;
    PanelColor6: TPanelColor;
    GProdutos: TGridIndice;
    GridIndice2: TGridIndice;
    PanelColor2: TPanelColor;
    Label3: TLabel;
    Label4: TLabel;
    Label23: TLabel;
    DBEditColor7: TDBEditColor;
    ETotalDescontos: Tnumerico;
    DBEditColor1: TDBEditColor;
    Label30: TLabel;
    ECoDVendedor: TDBEditLocaliza;
    SpeedButton7: TSpeedButton;
    Label12: TLabel;
    Label11: TLabel;
    DBEditColor2: TDBEditColor;
    Label31: TLabel;
    EDescontoAcrescimo: Tnumerico;
    CAcrescimoDesconto: TRadioGroup;
    CValorPercentual: TRadioGroup;
    PCanelado: TPanel;
    EProduto: TDBEditColor;
    LProduto: TLabel;
    SpeedButton2: TSpeedButton;
    LNomProduto: TLabel;
    CUnidade: TDBComboBoxColor;
    LUnidade: TLabel;
    EQuantidade: TDBEditNumerico;
    Label9: TLabel;
    Label5: TLabel;
    EValorUnitario: TDBEditNumerico;
    EPerDeconto: TDBEditNumerico;
    Label8: TLabel;
    EValTotal: TDBEditColor;
    Label6: TLabel;
    DBText1: TDBText;
    Label13: TLabel;
    Label7: TLabel;
    Bevel2: TBevel;
    PanelColor7: TPanelColor;
    CDescontoItem: TRadioButton;
    CAcrescimoItem: TRadioButton;
    PanelColor8: TPanelColor;
    CValorItem: TRadioButton;
    CPercentualItem: TRadioButton;
    MovNotasFiscaisC_IND_CAN: TWideStringField;
    MostraItensC_IND_CAN: TWideStringField;
    BitBtn1: TBitBtn;
    MovNotasFiscaisC_TPA_ECF: TWideStringField;
    PainelTempo: TPainelTempo;
    CadNotaFiscalI_EMP_FIL: TFMTBCDField;
    CadNotaFiscalI_SEQ_NOT: TFMTBCDField;
    CadNotaFiscalC_SER_NOT: TWideStringField;
    CadNotaFiscalI_COD_PAG: TFMTBCDField;
    CadNotaFiscalI_COD_VEN: TFMTBCDField;
    CadNotaFiscalI_NRO_NOT: TFMTBCDField;
    CadNotaFiscalI_COD_CLI: TFMTBCDField;
    CadNotaFiscalI_COD_TRA: TFMTBCDField;
    CadNotaFiscalC_COD_NAT: TWideStringField;
    CadNotaFiscalI_COD_PED: TFMTBCDField;
    CadNotaFiscalC_TIP_NOT: TWideStringField;
    CadNotaFiscalD_DAT_EMI: TSQLTimeStampField;
    CadNotaFiscalD_DAT_SAI: TSQLTimeStampField;
    CadNotaFiscalT_HOR_SAI: TSQLTimeStampField;
    CadNotaFiscalI_QTD_VOL: TFMTBCDField;
    CadNotaFiscalC_MAR_PRO: TWideStringField;
    CadNotaFiscalC_NRO_PLA: TWideStringField;
    CadNotaFiscalC_TIP_EMB: TWideStringField;
    CadNotaFiscalL_OBS_NOT: TWideStringField;
    CadNotaFiscalI_TIP_FRE: TFMTBCDField;
    CadNotaFiscalC_INS_EST: TWideStringField;
    CadNotaFiscalN_BAS_CAL: TFMTBCDField;
    CadNotaFiscalN_VLR_ICM: TFMTBCDField;
    CadNotaFiscalN_BAS_SUB: TFMTBCDField;
    CadNotaFiscalN_VLR_SUB: TFMTBCDField;
    CadNotaFiscalN_TOT_PRO: TFMTBCDField;
    CadNotaFiscalN_VLR_FRE: TFMTBCDField;
    CadNotaFiscalN_VLR_SEG: TFMTBCDField;
    CadNotaFiscalN_OUT_DES: TFMTBCDField;
    CadNotaFiscalN_TOT_IPI: TFMTBCDField;
    CadNotaFiscalN_TOT_NOT: TFMTBCDField;
    CadNotaFiscalN_PES_BRU: TFMTBCDField;
    CadNotaFiscalN_PES_LIQ: TFMTBCDField;
    CadNotaFiscalC_EST_PLA: TWideStringField;
    CadNotaFiscalI_NRO_LOJ: TFMTBCDField;
    CadNotaFiscalI_NRO_CAI: TFMTBCDField;
    CadNotaFiscalI_NRO_TEC: TFMTBCDField;
    CadNotaFiscalC_FLA_ECF: TWideStringField;
    CadNotaFiscalC_END_DES: TWideStringField;
    CadNotaFiscalC_NOT_IMP: TWideStringField;
    CadNotaFiscalC_NOT_CAN: TWideStringField;
    CadNotaFiscalL_OB1_NOT: TWideStringField;
    CadNotaFiscalN_TOT_SER: TFMTBCDField;
    CadNotaFiscalN_VLR_ISQ: TFMTBCDField;
    CadNotaFiscalC_NRO_PAC: TWideStringField;
    CadNotaFiscalC_TEX_CLA: TWideStringField;
    CadNotaFiscalC_NOT_DEV: TWideStringField;
    CadNotaFiscalI_LAN_ORC: TFMTBCDField;
    CadNotaFiscalI_SEQ_DEV: TFMTBCDField;
    CadNotaFiscalI_ITE_NAT: TFMTBCDField;
    CadNotaFiscalD_ULT_ALT: TSQLTimeStampField;
    CadNotaFiscalC_ORD_COM: TWideStringField;
    CadNotaFiscalC_FIN_GER: TWideStringField;
    CadNotaFiscalN_VLR_DES: TFMTBCDField;
    CadNotaFiscalN_PER_DES: TFMTBCDField;
    CadNotaFiscalN_PER_COM: TFMTBCDField;
    CadNotaFiscalC_NUM_PED: TWideStringField;
    CadNotaFiscalI_COD_FRM: TFMTBCDField;
    CadNotaFiscalI_VEN_PRE: TFMTBCDField;
    CadNotaFiscalN_COM_PRE: TFMTBCDField;
    CadNotaFiscalN_PER_ISQ: TFMTBCDField;
    CadNotaFiscalI_COD_USU: TFMTBCDField;
    CadNotaFiscalI_NRO_NSU: TFMTBCDField;
    CadNotaFiscalD_DAT_NSU: TSQLTimeStampField;
    CadNotaFiscalN_VLR_TRO: TFMTBCDField;
    CadNotaFiscalC_CHA_NFE: TWideStringField;
    CadNotaFiscalC_REC_NFE: TWideStringField;
    CadNotaFiscalC_PRO_NFE: TWideStringField;
    CadNotaFiscalC_STA_NFE: TWideStringField;
    CadNotaFiscalC_MOT_NFE: TWideStringField;
    CadNotaFiscalC_PRC_NFE: TWideStringField;
    CadNotaFiscalC_MOC_NFE: TWideStringField;
    CadNotaFiscalC_ENV_NFE: TWideStringField;
    CadNotaFiscalC_COT_TRA: TWideStringField;
    CadNotaFiscalC_FLA_EXP: TWideStringField;
    CadNotaFiscalD_DAT_EXP: TSQLTimeStampField;
    CadNotaFiscalI_NUM_COO: TFMTBCDField;
    CadNotaFiscalC_VEN_CON: TWideStringField;
    CadNotaFiscalI_NUM_CRZ: TFMTBCDField;
    CadNotaFiscalC_SUB_SER: TWideStringField;
    CadNotaFiscalC_ASS_REG: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BNovoClick(Sender: TObject);
    procedure EProdutoEnter(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure EProdutoExit(Sender: TObject);
    procedure EProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ECodClienteRetorno(Retorno1, Retorno2: String);
    procedure CUnidadeChange(Sender: TObject);
    procedure EQuantidadeExit(Sender: TObject);
    procedure EValTotalExit(Sender: TObject);
    procedure ECodClienteCadastrar(Sender: TObject);
    procedure ECodClienteAlterar(Sender: TObject);
    procedure BCancelaCupomClick(Sender: TObject);
    procedure EDescontoAcrescimoExit(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BFechamentoClick(Sender: TObject);
    procedure ECoDVendedorRetorno(Retorno1, Retorno2: String);
    procedure BFecharClick(Sender: TObject);
    procedure BCancelaItemClick(Sender: TObject);
    procedure GProdutosDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure BitBtn1Click(Sender: TObject);
    procedure CadNotaFiscalAfterPost(DataSet: TDataSet);
    procedure MovNotasFiscaisAfterPost(DataSet: TDataSet);
    procedure CadNotaFiscalBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
    VprICMSPadrao,
    VprICMSAliquotaInterna,
    VprValUnitarioOriginal : Double;
    VprUMOriginal : String;
    VprOrcamento,
    VprAcao : Boolean;
    VprDOrcamento : TRBDOrcamento;
    VprDCliente : TRBDCliente;
    FunECF : TRBFuncoesECF;
    FunVendedor : TRBFuncoesVendedor;
    function DadosNovoCupomValdos : String;
    procedure ValidaVariaveis;
    procedure AtualizaValTotalProdutos;
    procedure PosicionaCupomAberto;
    function LimiteCreditoOK(VpaDCliente : TRBDCliente) : string;
    function SituacaoFinanceiraOK(VpaDCliente : TRBDCliente) : string;
    procedure AtualizaMostraItem;
    procedure AtualizaStatus(VpaTexto : String);
    function AbreLocalizacaoProduto : Boolean;
    procedure ExtornaEstoqueItem;
    function ValidaProduto : Boolean;
    procedure ValidaValorUnitario;
    procedure AdicionaItemsProduto( VpaCodFilial,VpaSeqProduto : Integer );
    procedure AdicionaItemsCotacao(VpaDCotacao : TRBDOrcamento);
    function DadosItensValidos : string;
    function DadosValidos : string;
    procedure HabilitaCamposTela(VpaCupomAberto : Boolean);
    procedure CarDescontoAcrescimoBD;
    procedure CarDescontoAcrescimoTela;
    procedure CalculaValorTotalComDesconto;
    procedure EfetuaFechamentoCupom;
    procedure EfetuaFechamentoCupomCotacao;
    function GeraFinanceiroCupom(VpaCodFormaPagamento : Integer) : String;
    procedure NovoCupom;
    procedure CalculaValorTotalItem;
  public
    { Public declarations }
    function GeraECFAPartirCotacao(VpaDCotacao : TRBDOrcamento):Boolean;
    procedure NovoECF;
  end;

var
  FNovoECF: TFNovoECF;

implementation

uses APrincipal, Constantes, ConstMsg, FunSql, ALocalizaProdutos, Unprodutos, UnNotaFiscal, FunObjeto,
  ANovoCliente, AFormaPagamentoECF, UnSistema, AMenuFiscalECF;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovoECF.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunECF := TRBFuncoesECF.cria(BarraStatus,Fprincipal.BaseDados);
  FunECF.AssociaBobina(MBobina, WBobina);
  ValidaVariaveis;
  VprDCliente := TRBDCliente.cria;
  VprOrcamento := false;
  VprAcao := false;
  FunVendedor := TRBFuncoesVendedor.cria(FPrincipal.BaseDados);
  if FunECF.ExisteCupomAberto then
  begin
    aviso('existe cupom aberto');
    PosicionaCupomAberto
  end
  else
    NovoCupom;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovoECF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  MostraItens.close;
  MovNotasFiscais.close;
  CadNotaFiscal.close;
  VprDCliente.free;
  FunECF.free;
  FunVendedor.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFNovoECF.BNovoClick(Sender: TObject);
var
  VpfResultado : string;
begin
  VpfResultado := DadosNovoCupomValdos;
  if VpfResultado = '' then
  begin
    VpfResultado := FunECF.CadastraECF(CadNotaFiscal,ECodCondicaoPagamento.Ainteiro,VprDCliente);
    if VpfResultado = '' then
    begin
      LNroCupom.Caption := 'Cupom : '+CadNotaFiscalI_NRO_NOT.ASString;
      AtualizaMostraItem;
      HabilitaCamposTela(true);
      ActiveControl := EProduto;
    end;
  end;
  if VpfResultado <> '' then
    aviso(VpfResultado);
end;

{******************************************************************************}
procedure TFNovoECF.ValidaValorUnitario;
var
  VpfValOriginal : Double;
begin
  VpfValOriginal := FunProdutos.ValorPelaUnidade(cadProdutos.FieldByName('C_COD_UNI').AsString,MovNotasFiscaisC_COD_UNI.AsString,MovNotasFiscaisI_SEQ_PRO.AsInteger,VprValUnitarioOriginal);
  if MovNotasFiscaisN_VLR_PRO.AsFloat <> VpfValOriginal  then
  begin
    CValorItem.Checked := true;
    if MovNotasFiscaisN_VLR_PRO.AsFloat > VpfValOriginal then
    begin
      MovNotasFiscaisN_PER_DES.AsFloat := MovNotasFiscaisN_VLR_PRO.AsFloat - VpfValOriginal;
      CAcrescimoItem.Checked := true;
    end
    else
    begin
      MovNotasFiscaisN_PER_DES.AsFloat := VpfValOriginal - MovNotasFiscaisN_VLR_PRO.AsFloat;
      CDescontoItem.Checked := true;
    end;
    MovNotasFiscaisN_VLR_PRO.AsFloat := VpfValOriginal;
  end;
end;

{******************************************************************************}
procedure TFNovoECF.ValidaVariaveis;
begin
  if varia.CodOperacaoEstoqueECF = 0 then
    aviso('OPERAÇÃO ESTOQUE DO ECF NÃO PREENCHIDO!!!'#13'Para um perfeito funcionamento do sistema é necessário preencher a operação de estoque nas configurações do ECF');
  if varia.CodPlanoContasECF = '' then
    aviso('PLANO DE CONTAS DO ECF NÃO PREENCHIDO!!!'#13'Para um perfeito funcionamento do sistema é necessário preencher o plano de contas nas configurações do ECF');
end;


{******************************************************************************}
procedure TFNovoECF.AtualizaValTotalProdutos;
begin
    MostraItens.First;
    if CadNotaFiscal.State = dsedit then
      CadNotaFiscalN_TOT_PRO.AsFloat := 0;
    ETotalDescontos.AValor :=0;
    While not MostraItens.Eof do
    begin
      if MostraItensC_IND_CAN.AsString = 'N' then
      begin
        if CadNotaFiscal.State = dsedit then
          CadNotaFiscalN_TOT_PRO.AsFloat := CadNotaFiscalN_TOT_PRO.AsFloat + (MostraItensN_TOT_PRO.AsFloat);

        if MostraItensN_PER_DES.AsFloat <> 0 then
          ETotalDescontos.AValor := ETotalDescontos.Avalor + ((MostraItensN_QTD_PRO.AsFloat * MostraItensN_VLR_PRO.AsFloat) - MostraItensN_TOT_PRO.AsFloat);
      end;
      MostraItens.Next;
    end;
    MostraServicos.first;
    While not MostraServicos.Eof do
    begin
      if CadNotaFiscal.State = dsedit then
        CadNotaFiscalN_TOT_SER.AsFloat := CadNotaFiscalN_TOT_SER.AsFloat + (MostraServicosN_TOT_SER.AsFloat);
      MostraServicos.Next;
    end;
    CadNotaFiscalN_TOT_NOT.AsFloat := CadNotaFiscalN_TOT_PRO.AsFloat + CadNotaFiscalN_TOT_SER.AsFloat;

    if CadNotaFiscal.State = dsedit then
      CalculaValorTotalComDesconto;
end;

{******************************************************************************}
procedure TFNovoECF.PosicionaCupomAberto;
begin
  FunECF.LocalizaECF(CadNotaFiscal,varia.CodigoEmpfil,FunECF.RNumECF,FunECF.RNumSerieECF);
  if CadNotaFiscal.Eof then
  begin
    FunECF.CancelaCupomAberto;
    NovoCupom;
  end
  else
  begin
    CadNotaFiscal.Edit;
    LNroCupom.Caption := 'Cupom : '+CadNotaFiscalI_NRO_NOT.ASString;
    ECodCliente.Ainteiro := CadNotaFiscalI_COD_CLI.AsInteger;
    ECodCliente.Atualiza;
    ECodCondicaoPagamento.AInteiro := CadNotaFiscalI_COD_PAG.AsInteger;
    ECodCondicaoPagamento.Atualiza;
    ECoDVendedor.Atualiza;
    CarDescontoAcrescimoTela;
    AtualizaMostraItem;
    HabilitaCamposTela(true);
    CarDescontoAcrescimoTela;
    AdicionaSqlAbreTabela(MovNotasFiscais,'Select * from MOVNOTASFISCAIS Where I_EMP_FIL = -1');
    Paginas.ActivePage := PProduto;
  end;
end;

{******************************************************************************}
procedure TFNovoECF.AtualizaMostraItem;
begin
  AdicionaSqlAbreTabela(MostraItens,'select MOV.I_SEQ_MOV, MOV.I_SEQ_PRO, MOV.C_COD_PRO, ' +
                                   ' MOV.C_COD_UNI, MOV.N_QTD_PRO, N_VLR_PRO, MOV.N_PER_ICM,MOV.C_PRO_REF, '+
                                   ' MOV.N_TOT_PRO, MOV.I_NUM_ITE, MOV.N_PER_DES,MOV.C_PRO_REF, MOV.C_IND_CAN, '+
                                   ' PRO.C_NOM_PRO '+
                                   ' from MOVNOTASFISCAIS MOV, CADPRODUTOS PRO '+
                                   ' Where MOV.I_SEQ_PRO = PRO.I_SEQ_PRO '+
                                   ' AND MOV.I_EMP_FIL = '+CadNotaFiscalI_EMP_FIL.asString+
                                   ' and MOV.I_SEQ_NOT = '+CadNotaFiscalI_SEQ_NOT.AsString);
  AdicionaSqlAbreTabela(MostraServicos,'select MOV.I_COD_SER, MOV.N_QTD_SER, MOV.N_VLR_SER, '+
                                    ' MOV.N_TOT_SER, CAD.C_NOM_SER ' +
                                    ' From MOVSERVICONOTA MOV, CADSERVICO CAD '+
                                   ' Where MOV.I_COD_SER = CAD.I_COD_SER '+
                                   ' AND MOV.I_EMP_FIL = '+CadNotaFiscalI_EMP_FIL.asString+
                                   ' and MOV.I_SEQ_NOT = '+CadNotaFiscalI_SEQ_NOT.AsString);
  AtualizaValTotalProdutos;
end;

{******************************************************************************}
function TFNovoECF.LimiteCreditoOK(VpaDCliente : TRBDCliente) : string;
begin
  result := '';
  if config.LimiteCreditoCliente then
  begin
    if (VprDCliente.LimiteCredito < (VprDCliente.DuplicatasEmAberto + CadNotaFiscalN_TOT_NOT.AsFloat)) then
    begin
     result := 'CLIENTE COM LIMITE DE CRÉDITO ESTOURADO!!!'#13'Esse cliente possui um limite de crédito de "'+FormatFloat('#,###,###,##0.00',VprDCliente.LimiteCredito)+
            '", e o valor das duplicatas em aberto somam "'+FormatFloat('#,###,###,##0.00',VprDCliente.DuplicatasEmAberto + CadNotaFiscalN_TOT_NOT.AsFloat)+ '".';
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoECF.MovNotasFiscaisAfterPost(DataSet: TDataSet);
begin
  FunNotaFiscal.AssinaRegistroNotaProduto(MovNotasFiscaisI_EMP_FIL.AsInteger,MovNotasFiscaisI_SEQ_NOT.AsInteger,MovNotasFiscaisI_SEQ_MOV.AsInteger);
end;

{******************************************************************************}
function TFNovoECF.SituacaoFinanceiraOK(VpaDCliente : TRBDCliente) : string;
begin
  result := LimiteCreditoOK(VpaDCliente);
  if result = '' then
  begin
    if config.BloquearClienteEmAtraso then
    begin
      if VprDCliente.DuplicatasEmAtraso > 0 then
      begin
        if not Confirmacao('CLIENTE COM DUPLICATAS VENCIDAS!!!'#13'Este cliente possui duplicatas vencidas no valor de "'+FormatFloat('#,###,###,###,##0.00',VprDCliente.DuplicatasEmAtraso)+'". Deseja faturar para esse cliente ?') then
        begin
          ECodCliente.Clear;
          VprDCliente.CodCliente := 0;
        end;
      end;
    end;
  end;
end;


{******************************************************************************}
procedure TFNovoECF.AtualizaStatus(VpaTexto : String);
begin
  BarraStatus.Panels[2].Text := VpaTexto;
  BarraStatus.Refresh;
end;

{******************** localiza um produto *********************************** }
function TFNovoECF.AbreLocalizacaoProduto : Boolean;
var
  VpfSeqProduto :integer;
  VpfCodProduto : string;
  Vpfcadastrou : boolean;
  VpfEstoqueAtual : Double;
begin
   Vpfcadastrou := true;
   FLocalizaProduto := TFLocalizaProduto.CriarSDI(application,'',true);
   result := FLocalizaProduto.LocalizaProduto( VpfCadastrou, VpfSeqProduto, VpfCodProduto, VpfEstoqueAtual,ECodCliente.Ainteiro );
   if result then
   begin
     if not (MovNotasFiscais.State in [ dsEdit, dsInsert ]) then
       MovNotasFiscais.Insert;
     MovNotasFiscaisI_SEQ_PRO.AsInteger := VpfSeqProduto;
     MovNotasFiscaisC_COD_PRO.AsString := VpfcodProduto;
   end;
end;

{******************************************************************************}
procedure TFNovoECF.ExtornaEstoqueItem;
var
  VpfSeqEstoqueBarra : Integer;
  VpfDProduto : TRBDProduto;
begin
  if (not VprOrcamento) and (config.BaixarEstoqueECF) then
  begin
    VpfDProduto := TRBDProduto.Cria;
    FunProdutos.CarDProduto(VpfDProduto,0,CadNotaFiscalI_EMP_FIL.AsInteger, MostraItensI_SEQ_PRO.AsInteger);
    FunProdutos.BaixaProdutoEstoque(VpfDProduto, CadNotaFiscalI_EMP_FIL.AsInteger, Varia.OperacaoEstoqueEstornoEntrada,CadNotaFiscalI_SEQ_NOT.AsInteger,
                                  CadNotaFiscalI_NRO_NOT.AsInteger,0,varia.MoedaBase,0,0,date,MostraItensN_QTD_PRO.AsFloat,MostraItensN_TOT_PRO.AsFloat,
                                  MostraItensC_COD_UNI.AsString,MostraItensC_PRO_REF.AsString,false,VpfSeqEstoqueBarra,true);
  end;
  FunProdutos.BaixaEstoqueFiscal(CadNotaFiscalI_EMP_FIL.AsInteger, MostraItensI_SEQ_PRO.AsInteger,0,0,MostraItensN_QTD_PRO.AsFloat,MostraItensC_COD_UNI.AsString,
                                 FunProdutos.UnidadePadrao(MostraItensI_SEQ_PRO.AsInteger),'E');
end;

{*********************** Valida o  Produto ********************************** }
function TFNovoECF.ValidaProduto : Boolean;
var
  VpfSeqProduto : integer;
begin
  result := true;
  if MovNotasFiscais.State in [ dsedit, dsinsert ] then
  begin
    if FunNotaFiscal.VerificaExisteProduto(EProduto.Text, VpfSeqProduto) then // valida o campo codigo caso esteja vazio
      MovNotasFiscaisI_SEQ_PRO.AsInteger := VpfSeqProduto
    else
      result := AbreLocalizacaoProduto;
  end;
end;

{********* adiciona os itens do produto localizado *************************** }
procedure TFNovoECF.AdicionaItemsProduto(VpaCodFilial, VpaSeqProduto : Integer );
begin
  MovNotasFiscaisI_EMP_FIL.AsInteger := VpaCodFilial;
  FunNotaFiscal.LocalizaProdutoQdadeTabelaSeqPro(CadProdutos,VpaCodFilial,VpaSeqProduto,ECodCliente.AInteiro);
  lNomProduto.Caption := CadProdutos.FieldByName('C_NOM_PRO').AsString;

  MovNotasFiscaisI_SEQ_NOT.AsInteger := cadNotaFiscalI_SEQ_NOT.AsInteger;
  MovNotasFiscaisC_COD_UNI.AsString := CadProdutos.FieldByname('c_cod_uni').AsString;
  VprUmOriginal := CadProdutos.FieldByname('c_cod_uni').AsString;
  MovNotasFiscaisN_VLR_PRO.AsFloat := CadProdutos.FieldByname('n_vlr_ven').AsFloat;
  VprValUnitarioOriginal := MovNotasFiscaisN_VLR_PRO.AsFloat;
  MovNotasFiscaisN_PER_ICM.AsFloat := VprICMSPAdrao;
  MovNotasFiscaisN_QTD_PRO.AsFloat := 1;
  if ECodCondicaoPagamento.AInteiro = varia.CondPagtoVista then
    MovNotasFiscaisN_PER_DES.AsFloat := CadProdutos.FieldByname('N_PER_KIT').AsFloat;
  MovNotasFiscaisC_IND_CAN.AsString := 'N';
  MovNotasFiscaisD_ULT_ALT.AsDateTime := Sistema.RDataServidor;
  Sistema.MarcaTabelaParaImportar('MOVNOTASFISCAIS');

  // icms
  if (CadProdutos.FieldByname('n_red_icm').AsFloat <> 0) AND (cadProdutos.FieldByname('N_PER_ICM').AsFloat = 0) then  // caso haja reducao de icms
      MovNotasFiscaisN_PER_ICM.AsFloat := CadProdutos.FieldByname('n_red_icm').AsFloat;

  if (cadProdutos.FieldByname('N_PER_ICM').AsFloat <> 0) and (CadProdutos.FieldByname('n_red_icm').AsFloat = 0) then  // caso haja icms then
    MovNotasFiscaisN_PER_ICM.AsFloat := CadProdutos.FieldByname('N_PER_ICM').AsFloat;
end;

{******************************************************************************}
procedure TFNovoECF.AdicionaItemsCotacao(VpaDCotacao : TRBDOrcamento);
var
  VpfDItem : TRBDOrcProduto;
  VpfDItemServico : TRBDOrcServico;
  VpfLaco : Integer;
  VpfResultado : String;
  VpfPerDesconto : Double;
  VpfFaturarTodos : Boolean;
  VpfPerIcms, VpfPerISSQN : Double;
  VpfQtdCupom : Integer;
  VpfTotalizadorParcial : string;
begin
  VpfFaturarTodos := FunCotacao.FaturarTodosProdutos(VpaDCotacao);

  for VpfLaco := 0 to VpaDCotacao.Produtos.Count - 1 do
  begin
    VpfDItem := TRBDOrcProduto(VpaDCotacao.Produtos.Items[VpfLaco]);
    if VpfFaturarTodos or VpfDItem.IndFaturar then
    begin
      if ECodCondicaoPagamento.AInteiro = varia.CondPagtoVista then
        VpfPerDesconto := VpfDItem.PerDesconto
      else
        VpfPerDesconto := 0;
      VpfPerIcms := VprICMSPadrao;
      if (VpfDItem.RedICMS  <> 0) and (VpfDItem.PerICMS = 0) then
        VpfPerIcms := VpfDItem.RedICMS;
      if (VpfDItem.RedICMS  = 0) and (VpfDItem.PerICMS <> 0) then
        VpfPerIcms := VpfDItem.PerICMS;

      VpfResultado := FunECF.VendeItem(VpfDItem.CodProduto,VpfDItem.NomProduto,VpfDItem.UM,VpfDItem.QtdProduto,VpfDItem.ValUnitario,VpfPerDesconto,VpfPerIcms,VpfDItem.IndSubstituicaoTributaria,true,true,true,VpfTotalizadorParcial);
      if VpfResultado = '' then
      begin
        MovNotasFiscais.Insert;
        MovNotasFiscaisI_EMP_FIL.AsInteger := CadNotaFiscalI_EMP_FIL.AsInteger;
        MovNotasFiscaisI_SEQ_NOT.AsInteger := CadNotaFiscalI_SEQ_NOT.AsInteger;
        MovNotasFiscaisI_SEQ_MOV.AsInteger := VpfLaco +1;
        MovNotasFiscaisI_NUM_ITE.AsInteger := FunECF.RNumeroUltimoItemVendido;
        MovNotasFiscaisI_SEQ_PRO.AsInteger := VpfDItem.SeqProduto;
        MovNotasFiscaisC_COD_PRO.AsString := VpfDItem.CodProduto;
        MovNotasFiscaisC_COD_UNI.AsString := VpfDItem.UM;
        MovNotasFiscaisN_QTD_PRO.AsFloat := VpfDItem.QtdProduto;
        MovNotasFiscaisN_VLR_PRO.AsFloat := VpfDItem.ValUnitario;
        MovNotasFiscaisN_PER_DES.AsFloat := VpfPerDesconto;
        MovNotasFiscaisC_IND_CAN.AsString := 'N';
        MovNotasFiscaisN_TOT_PRO.AsFloat := (MovNotasFiscaisN_QTD_PRO.AsFloat * MovNotasFiscaisN_VLR_PRO.AsFloat);
        if MovNotasFiscaisN_Per_Des.AsFloat <> 0 then
          MovNotasFiscaisN_Tot_Pro.AsFloat := MovNotasFiscaisN_Tot_Pro.AsFloat - ((MovNotasFiscaisN_Tot_Pro.AsFloat * MovNotasFiscaisN_Per_Des.AsFloat)/100);
        MovNotasFiscaisN_PER_ICM.AsFloat := VpfPerIcms;
        MovNotasFiscaisC_TPA_ECF.AsString := VpfTotalizadorParcial;
        MovNotasFiscaisD_ULT_ALT.AsDateTime := Sistema.RDataServidor;
        MovNotasFiscais.post;
        Sistema.MarcaTabelaParaImportar('MOVNOTASFISCAIS');
        FunProdutos.BaixaEstoqueFiscal(CadNotaFiscalI_EMP_FIL.AsInteger, MovNotasFiscaisI_SEQ_PRO.AsInteger,0,0,MovNotasFiscaisN_QTD_PRO.AsFloat,
                                       MovNotasFiscaisC_COD_UNI.asString,FunProdutos.UnidadePadrao(MovNotasFiscaisI_SEQ_PRO.AsInteger),'S');
      end
      else
        break;
    end;
  end;

  if VpfResultado  = '' then
  begin
    if not(varia.CNPJFilial = CNPJ_KABRAN) then
    for VpfLaco := 0 to VpaDCotacao.Servicos.Count - 1 do
    begin
      VpfDItemServico := TRBDOrcServico(VpaDCotacao.Servicos.Items[VpfLaco]);

      if VpfDItemServico.PerISSQN <> 0 then
        VpfPerISSQN := VpfDItemServico.PerISSQN
      else
        VpfPerISSQN := varia.ISSQN;
      VpfPerDesconto := 0;
      VpfResultado := FunECF.VendeItem(IntToStr(VpfDItemServico.CodServico),VpfDItemServico.NomServico,'SE',VpfDItemServico.QtdServico,VpfDItemServico.ValUnitario,VpfPerDesconto,VpfPerISSQN,false,true,true,false,VpfTotalizadorParcial);
      if VpfResultado = '' then
      begin
        MovServicoNota.Insert;
        MovServicoNotaI_EMP_FIL.AsInteger := CadNotaFiscalI_EMP_FIL.AsInteger;
        MovServicoNotaI_SEQ_NOT.AsInteger := CadNotaFiscalI_SEQ_NOT.AsInteger;
        MovServicoNotaI_SEQ_MOV.AsInteger := VpfLaco + 1;
        MovServicoNotaI_COD_SER.AsInteger := VpfDItemServico.CodServico;
        MovServicoNotaN_VLR_SER.AsFloat := VpfDItemServico.ValUnitario;
        MovServicoNotaI_COD_EMP.AsInteger := Varia.CodigoEmpresa;
        MovServicoNotaN_QTD_SER.AsFloat := VpfDItemServico.QtdServico;
        MovServicoNotaN_TOT_SER.AsFloat := VpfDItemServico.ValTotal;
        MovServicoNotaD_ULT_ALT.AsDatetime := date;
        MovServicoNota.post;
      end
      else
        break;
    end;
  end;
  if VpfResultado ='' then
    AtualizaMostraItem
  else
    aviso(VpfResultado);
end;

{******************************************************************************}
function TFNovoECF.DadosItensValidos : string;
begin
  result := '';
  if MovNotasFiscaisI_SEQ_PRO.AsInteger = 0 then
    result := 'CODIGO PRODUTO VAZIO!!!'#13'É necessário digitar o código do produto.'
  else
    if MovNotasFiscaisN_QTD_PRO.AsFloat <= 0 then
      result := 'QUANTIDADE DO PRODUTO VAZIO OU NEGATIVO!!!'#13'É necessário digitar a quantidade do produto'
    else
      if MovNotasFiscaisN_VLR_PRO.AsFloat <= 0 then
        result := 'VALOR UNITARIO VAZIO OU NEGATIVO!!!'#13'É necessário digitar o valor unitário do produto.'
      else
        if MovNotasFiscaisC_COD_UNI.AsString = '' then
          result := 'UNIDADE DE MEDIDA VAZIA!!!'#13'É necessário digitar a unidade de medida do produto'
        else
          if MovNotasFiscaisN_PER_DES.AsFloat < 0 then
            result := 'DESCONTO SOBRE O ITEM COM VALOR NEGATIVO!!!'#13'Não é permitido digitar valores negativos para o desconto do item.'
end;

{******************************************************************************}
function TFNovoECF.DadosNovoCupomValdos: String;
begin
  result := '';
  if ECodCliente.AInteiro = 0 then
    Result :=  'CODIGO DO CLIENTE VAZIO!!!'#13'É necessário preencher o código do cliente.';
  if result = '' then
  begin
    if ECodCondicaoPagamento.AInteiro = 0 then
      result := 'CONDIÇÃO DE PAGAMENTO VAZIA!!!'#13'É necessário preencher a condição de pagamento.';
  end;
end;

{******************************************************************************}
function TFNovoECF.DadosValidos: string;
begin
  result := '';
  if EDescontoAcrescimo.AValor < 0 then
    result := 'VALOR ACRESCIMO/DESCONTO NEGATIVO!!!'#13'O valor de desconto/acrescimo não pode ser negativo.';
end;

{******************************************************************************}
procedure TFNovoECF.HabilitaCamposTela(VpaCupomAberto : Boolean);
begin
  AlterarEnabledDet(self,1,not VpaCupomAberto);
  AlterarEnabledDet(self,2,VpaCupomAberto);
  if VpaCupomAberto then
    PCanelado.visible := false;
end;

{******************************************************************************}
procedure TFNovoECF.CarDescontoAcrescimoBD;
var
  VpfValor : Double;
begin
  if CadNotaFiscal.State = dsedit then
  begin
    CadNotaFiscaln_vlr_des.Clear;
    CadNotaFiscaln_Per_des.Clear;
    if EDescontoAcrescimo.AValor <> 0 then
    begin
      if CAcrescimoDesconto.ItemIndex = 0 then// acrescimo
        VpfValor := EDescontoAcrescimo.AValor * -1
      else
        VpfValor := EDescontoAcrescimo.AValor;

      if CValorPercentual.ItemIndex = 0 then //valor
        CadNotaFiscalN_VLR_DES.AsFloat := VpfValor
      else
        CadNotaFiscalN_PER_DES.AsFloat := VpfValor;
    end;
    CalculaValorTotalComDesconto;
  end;
end;

{******************************************************************************}
procedure TFNovoECF.CarDescontoAcrescimoTela;
begin
  CAcrescimoDesconto.OnClick := nil;
  CValorPercentual.ONClick := nil;
  if CadNotaFiscalN_VLR_DES.AsFloat <> 0 then
  begin
    if CadNotaFiscalN_VLR_DES.AsFloat > 0 then
    begin
      EDescontoAcrescimo.AValor := CadNotaFiscalN_VLR_DES.AsFloat;
      CAcrescimoDesconto.ItemIndex := 1;
    end
    else
    begin
      EDescontoAcrescimo.Avalor :=CadNotaFiscalN_VLR_DES.AsFloat * -1;
      CAcrescimoDesconto.itemIndex := 0;
    end;
    CValorPercentual.ItemIndex := 0;
  end
  else
    if CadNotaFiscalN_PER_DES.AsFloat <> 0 then
    begin
      if CadNotaFiscalN_PER_DES.AsFloat > 0 then
      begin
        EDescontoAcrescimo.Avalor := CadNotaFiscalN_PER_DES.AsFloat;
        CAcrescimoDesconto.ItemIndex := 1;
      end
      else
      begin
        EDescontoAcrescimo.Avalor := CadNotaFiscalN_PER_DES.AsFloat * -1;
        CAcrescimoDesconto.ItemIndex := 0;
      end;
      CValorPercentual.ItemIndex := 1;
    end;
  CAcrescimoDesconto.OnClick := EDescontoAcrescimoExit;
  CValorPercentual.ONClick := EDescontoAcrescimoExit;
end;

{******************************************************************************}
procedure TFNovoECF.CadNotaFiscalAfterPost(DataSet: TDataSet);
begin
//  FunNotaFiscal.AssinaRegistroNota(CadNotaFiscalI_EMP_FIL.AsInteger,CadNotaFiscalI_SEQ_NOT.AsInteger);
end;

procedure TFNovoECF.CadNotaFiscalBeforePost(DataSet: TDataSet);
begin
  CadNotaFiscalC_ASS_REG.AsString := Sistema.RAssinaturaRegistro(CadNotaFiscal);
end;

{******************************************************************************}
procedure TFNovoECF.CalculaValorTotalComDesconto;
var
  VpfValDesconto : Double;
begin
  if CadNotaFiscal.State = dsedit then
  begin
    VpfValDesconto := 0;
    if EDescontoAcrescimo.AValor <> 0 then
    begin
      if CValorPercentual.ItemIndex = 0 then
      begin
        if CAcrescimoDesconto.ItemIndex = 0 then
          VpfValDesconto := EDescontoAcrescimo.AValor * -1
        else
          VpfValDesconto := EDEscontoacrescimo.AVAlor;
      end
      else
      begin
        VpfValDesconto := (CadNotaFiscalN_TOT_NOT.asFloat * EDescontoAcrescimo.AValor)/100;
        if CAcrescimoDesconto.ItemIndex = 0 then
          VpfValDesconto := VpfValdesconto * -1;
      end;
    end;

    CadNotaFiscalN_TOT_NOT.AsFloat := CadNotaFiscalN_TOT_PRO.Asfloat - VpfValdesconto;
  end;
end;

{******************************************************************************}
procedure TFNovoECF.CalculaValorTotalItem;
begin
  if MovNotasFiscais.State = dsinsert then
  begin
    MovNotasFiscaisN_TOT_PRO.AsFloat := (MovNotasFiscaisN_QTD_PRO.AsFloat * MovNotasFiscaisN_VLR_PRO.AsFloat);
    if MovNotasFiscaisN_Per_Des.AsFloat <> 0 then
    begin
      if CAcrescimoItem.Checked then
      begin
        if CValorItem.Checked then
          MovNotasFiscaisN_Tot_Pro.AsFloat := MovNotasFiscaisN_Tot_Pro.AsFloat + MovNotasFiscaisN_Per_Des.AsFloat
        else
          MovNotasFiscaisN_Tot_Pro.AsFloat := MovNotasFiscaisN_Tot_Pro.AsFloat + ((MovNotasFiscaisN_Tot_Pro.AsFloat * MovNotasFiscaisN_Per_Des.AsFloat)/100);
      end
      else
      begin
        if CValorItem.Checked then
          MovNotasFiscaisN_Tot_Pro.AsFloat := MovNotasFiscaisN_Tot_Pro.AsFloat - MovNotasFiscaisN_Per_Des.AsFloat
        else
          MovNotasFiscaisN_Tot_Pro.AsFloat := MovNotasFiscaisN_Tot_Pro.AsFloat - ((MovNotasFiscaisN_Tot_Pro.AsFloat * MovNotasFiscaisN_Per_Des.AsFloat)/100);
      end;
    end;
  end;

end;

{******************************************************************************}
procedure TFNovoECF.EfetuaFechamentoCupom;
var
  VpfResultado, VpfNumCupom : String;
  VpfVencimentos : TStringList;
  VpfAcrescimoDesconto,VpfValPago : Double;
  VpfDFormaPagamento : TRBDFormaPagamento;
begin

  VpfNumCupom := CadNotaFiscalI_NRO_NOT.AsString;
  VpfAcrescimoDesconto := 0;
  if EDescontoAcrescimo.AValor <> 0 then
  begin
    if CValorPercentual.ItemIndex = 0 then
      VpfAcrescimoDesconto := EDescontoAcrescimo.AValor
    else
      VpfAcrescimoDesconto := ((CadNotaFiscalN_TOT_PRO.AsFloat +CadNotaFiscalN_TOT_SER.AsFloat)* EDescontoAcrescimo.AValor)/100;
    if CAcrescimoDesconto.ItemIndex = 1 then
      VpfAcrescimoDesconto :=  VpfAcrescimoDesconto * -1;
  end;
  VpfDFormaPagamento := TRBDFormaPagamento.cria;
  VpfDFormaPagamento.CodForma := Varia.FormaPagamentoPadrao;
  FFormaPagamentoECF := TFFormaPagamentoECF.CriarSDI(application,'', FPrincipal.VerificaPermisao('FFormaPagamentoECF'));
  if FFormaPagamentoECF.MostraFormaPagamento(VpfDFormaPagamento,VpfValPago, CadNotaFiscalN_TOT_NOT.Asfloat,FunECF) then
  begin
    CadNotaFiscalI_COD_FRM.AsInteger := VpfDFormaPagamento.CodForma;
    if (config.GerarFinanceiroECF) then
      VpfResultado := GeraFinanceiroCupom(VpfDFormaPagamento.CodForma);
    if VpfResultado = '' then
    begin
      if (VpfDFormaPagamento.FlaTipo in [fpCartaoCredito,fpCartaoDebito]) and
         ConfigModulos.TEF then
      begin
        PainelTempo.execute('Processando TEF. Aguarde.');
        FunECF.FechacomTEF(CadNotaFiscalN_TOT_NOT.Asfloat,VpfDFormaPagamento);
        PainelTempo.fecha;
      end
      else
      begin
        VpfResultado := FunECF.IniciaFechamento(VpfAcrescimoDesconto);
        if VpfResultado = '' then
        begin
          FunECF.FormaPagamentoCupom(VpfDFormaPagamento.NomForma,LCondicaoPagamento.Caption,VpfValPago);
          if VpfResultado = '' then
          begin
            if not VprOrcamento then
              VpfVencimentos := FunECF.RTextoVencimentos(CadNotaFiscalI_EMP_FIL.AsInteger,CadNotaFiscalI_SEQ_NOT.AsInteger)
            else
              VpfVencimentos := FunECF.RTextoVencimentoCotacao(CadNotaFiscalI_EMP_FIL.AsInteger,VprDOrcamento.LanOrcamento);

            if VprOrcamento then
            begin
              if (VprDOrcamento.CodTipoOrcamento = Varia.TipoCotacaoChamado) then
                VpfVencimentos.Insert(0,'DAV-OS'+FormatFloat('0000000000',VprDOrcamento.LanOrcamento))
              else
                VpfVencimentos.Insert(0,'DAV'+FormatFloat('0000000000',VprDOrcamento.LanOrcamento))
            end;
            VpfVencimentos.Insert(0,'MD5='+VARIA.MD5);
            FunECF.FinalizaCupom(VpfVencimentos);
            VpfVencimentos.free;
          end;
        end;
      end;
    end;
    if CadNotaFiscal.state in [dsedit,dsinsert] then
      CadNotaFiscal.Post;
  end
  else
    VpfResultado := 'FECHAMENTO DO CUPOM CANCELADO!!!';

  if VpfResultado <> '' then
    Aviso(vpfResultado)
  else
  begin
    if not VprOrcamento then
      NovoCupom
    else
    begin
      FunNotaFiscal.AssociaNotaOrcamento(CadNotaFiscalI_EMP_FIL.AsInteger,CadNotaFiscalI_SEQ_NOT.Asinteger,VprDOrcamento.LanOrcamento,VprDOrcamento.CodEmpFil);
      VprDOrcamento.NumCupomfiscal := VpfNumCupom;
    end;
    HabilitaCamposTela(false);
    VprAcao := true;
  end;
end;

{******************************************************************************}
procedure TFNovoECF.EfetuaFechamentoCupomCotacao;
var
  VpfDescontoAcrescimo,VpfValorPercentual, VpfResultado, VpfNumCupom : String;
  VpfVencimentos : TStringList;
  VpfAcrescimoDesconto : Double;
begin
  VpfNumCupom := CadNotaFiscalI_NRO_NOT.AsString;
  VpfAcrescimoDesconto := 0;
  if EDescontoAcrescimo.AValor <> 0 then
  begin
    if CValorPercentual.ItemIndex =0 then
      VpfAcrescimoDesconto := EDescontoAcrescimo.AValor
    else
      VpfAcrescimoDesconto := ((CadNotaFiscalN_TOT_PRO.AsFloat +CadNotaFiscalN_TOT_SER.AsFloat)* EDescontoAcrescimo.AValor)/100;
    if CAcrescimoDesconto.ItemIndex = 1 then
      VpfAcrescimoDesconto :=  VpfAcrescimoDesconto * -1;
  end;
  VpfResultado := FunECF.IniciaFechamento(VpfAcrescimoDesconto);
  if VpfResultado = '' then
  begin
    if config.GerarFinanceiroECF then
      VpfVencimentos := FunECF.RTextoVencimentoCotacao(CadNotaFiscalI_EMP_FIL.AsInteger,VprDOrcamento.LanOrcamento)
    else
      VpfVencimentos := TStringList.Create;
    VpfVencimentos.Insert(0,'DAV'+FormatFloat('0000000000',VprDOrcamento.LanOrcamento));
    VpfVencimentos.Insert(0,'MD5='+VARIA.MD5 );
    FunECF.FinalizaCupom(VpfVencimentos);
    if CadNotaFiscal.state in [dsedit,dsinsert] then
    begin
      CadNotaFiscalI_COD_FRM.AsInteger := VprDOrcamento.CodFormaPaqamento;
      CadNotaFiscal.Post;
    end;
    VpfVencimentos.free;
  end;
  if VpfResultado = '' then
  begin
    VprAcao := true;
  end;
end;

{******************************************************************************}
function TFNovoECF.GeraFinanceiroCupom(VpaCodFormaPagamento : Integer):String;
var
  VpfDContaReceber : TRBDContasCR;
begin
  result := '';
  try
    if ConfigModulos.ContasAReceber then
    begin
      AtualizaStatus('Criando parcelas nos contas a receber...');
      if  Varia.CodplanocontasECF <> '' then
      begin
        VpfDContaReceber := TRBDContasCR.Cria;
        VpfDContaReceber.CodEmpFil := CadNotaFiscalI_EMP_FIL.AsInteger;
        VpfDContaReceber.NroNota := CadNotaFiscalI_NRO_NOT.AsInteger;
        VpfDContaReceber.SeqNota := CadNotaFiscalI_SEQ_NOT.AsInteger;
        VpfDContaReceber.CodCondicaoPgto := CadNotaFiscalI_COD_PAG.AsInteger;
        VpfDContaReceber.CodCliente := CadNotaFiscalI_COD_CLI.AsInteger;
        VpfDContaReceber.CodFrmPagto := VpaCodFormaPagamento;
        VpfDContaReceber.CodMoeda :=  varia.MoedaBase;
        VpfDContaReceber.CodUsuario := varia.CodigoUsuario;
        VpfDContaReceber.DatMov := Date;
        VpfDContaReceber.DatEmissao := Date;
        VpfDContaReceber.PlanoConta := varia.CodPlanoContasECF;

        VpfDContaReceber.ValTotal := CadNotaFiscalN_TOT_NOT.AsFloat;;
        VpfDContaReceber.PercentualDesAcr := 0;
        VpfDContaReceber.MostrarParcelas := true;
        VpfDContaReceber.CodVendedor := CadNotaFiscalI_COD_VEN.AsInteger;

        // comissao
        if CadNotaFiscalI_COD_VEN.AsInteger <> 0 then
        begin
          VpfDContaReceber.TipComissao := FunVendedor.RTipComissao(VpfDContaReceber.CodVendedor);
          VpfDContaReceber.PerComissao := CadNotaFiscalN_PER_COM.AsFloat;
          VpfDContaReceber.ValComissao := FunECF.RValComissao(CadNotaFiscalN_TOT_NOT.AsFloat,VpfDContaReceber.PerComissao,0,VpfDContaReceber.TipComissao,
                                                      VpfDContaReceber.CodVendedor,MovNotasFiscais);
        end;
        VpfDContaReceber.EsconderConta := false;
        VpfDContaReceber.IndGerarComissao := true;
        FunContasAReceber.CriaContasaReceber(VpfDContaReceber,result,true);
      end
      else
        result := 'PLANO DE CONTAS DO ECF NÃO PREENCHIDO!!!'#13'É necessário preencher o plano de contas do ECF nas configurações do ECF.';
    end;
  except
    on e : Exception do result := 'ERRO NA GERAÇÃO DO CONTAS A RECEBER!!!'#13+e.message;
  end;
end;


procedure TFNovoECF.GProdutosDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if (MostraItensC_IND_CAN.AsString = 'S') then
  begin
    GProdutos.Canvas.Brush.Color:= clRed;
    GProdutos.DefaultDrawDataCell(Rect, GProdutos.columns[datacol].field, State);
  end;
end;


{******************************************************************************}
procedure TFNovoECF.NovoCupom;
begin
  ECodCondicaoPagamento.Clear;
  ECodCondicaoPagamento.Atualiza;
  if Varia.ClientePadraoECF <> 0 then
  begin
    ECodCliente.AInteiro := Varia.ClientePadraoECF;
    ECodCliente.Atualiza;
  end;
  if varia.CodCondicaoPagamentoECF <> 0 then
  begin
    ECodCondicaoPagamento.AInteiro := Varia.CodCondicaoPagamentoECF;
    ECodCondicaoPagamento.atualiza;
  end;
  AdicionaSqlAbreTabela(MovNotasFiscais,'Select * from MOVNOTASFISCAIS Where I_EMP_FIL = -1');
  AdicionaSQLAbreTabela(MovServicoNota,'Select * from MOVSERVICONOTA Where I_EMP_FIL = -1');
  AdicionaSqlAbreTabela(CadNotaFiscal,'Select * from CADNOTAFISCAIS Where I_EMP_FIL = -1');
  HabilitaCamposTela(false);
  ECoDVendedor.atualiza;
  CAcrescimoDesconto.ItemIndex := 1;
  CValorPercentual.ItemIndex := 1;
  EDescontoAcrescimo.Avalor := 0;
  ETotalDescontos.AValor := 0;
end;

{******************************************************************************}
procedure TFNovoECF.EProdutoEnter(Sender: TObject);
begin
  if (MovNotasFiscais.Active) and (MovNotasFiscais.State <> dsinsert) then
    MovNotasFiscais.Insert;
end;

{******************************************************************************}
procedure TFNovoECF.SpeedButton2Click(Sender: TObject);
begin
  if not (MovNotasFiscais.State in [ dsEdit, dsInsert ]) then
    MovNotasFiscais.insert;
  EProduto.SetFocus;
  AbreLocalizacaoProduto;
end;

{******************************************************************************}
procedure TFNovoECF.EProdutoExit(Sender: TObject);
begin
  if (EProduto.Text <> '') and (MovNotasFiscais.State in [ dsEdit, dsInsert]) then
    if ValidaProduto then
    begin
      AdicionaItemsProduto(varia.CodigoEmpFil, MovNotasFiscaisI_SEQ_PRO.AsInteger);
    end;
end;

{******************************************************************************}
procedure TFNovoECF.EProdutoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 114 then
    AbreLocalizacaoProduto;
end;

{******************************************************************************}
procedure TFNovoECF.ECodClienteRetorno(Retorno1, Retorno2: String);
var
  VpfResultado : String;
  VpfValReducaoUFICMS: Double;
  VpfIndSubstituicaTributaria : Boolean;
begin
  if ECodCliente.AInteiro <> VprDCliente.CodCliente then
  begin
    VprDCliente.CodCliente :=  ECodCliente.AInteiro;
    if VprDCliente.CodCliente <> 0 then
    begin
      FunClientes.CarDCliente(VprDCliente);
      FunNotaFiscal.CarValICMSPadrao(VprICMSPAdrao,VprICMSAliquotaInterna,VpfValReducaoUFICMS,VprDCliente.DesUF,VprDCliente.InscricaoEstadual,VprDCliente.TipoPessoa = 'J',true,VpfIndSubstituicaTributaria);
      if not VprOrcamento then
        VpfResultado := SituacaoFinanceiraOK(VprDCliente);
      if VpfResultado <> '' then
        aviso(VpfResultado);
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoECF.CUnidadeChange(Sender: TObject);
begin
  MovNotasFiscaisN_VLR_PRO.AsFloat := FunProdutos.ValorPelaUnidade(cadProdutos.FieldByName('C_COD_UNI').AsString,MovNotasFiscaisC_COD_UNI.AsString,MovNotasFiscaisI_SEQ_PRO.AsInteger,VprValUnitarioOriginal);
end;

{******************************************************************************}
procedure TFNovoECF.EQuantidadeExit(Sender: TObject);
begin
  CalculaValorTotalItem;
end;

{******************************************************************************}
procedure TFNovoECF.EValTotalExit(Sender: TObject);
var
  VpfResultado : String;
  VpfTotalizadorParcial : String;
  VpfSeqEstoqueBarra : integer;
  VpfDProduto : TRBDProduto;
begin
  VpfResultado := DadosItensValidos;
  if VpfResultado = '' then
  begin
    if not FunProdutos.VerificaEstoque( MovNotasFiscaisC_COD_UNI.AsString, cadProdutos.fieldByName('c_cod_uni').AsString, MovNotasFiscaisN_QTD_PRO.AsFloat,MovNotasFiscaisI_SEQ_PRO.AsInteger,0,0) then
    begin
       EProduto.SetFocus;
       VpfResultado := 'PRODUTO SEM ESTOQUE!!!';
    end;
    VpfDProduto := TRBDProduto.cria;
    FunProdutos.CarDProduto(VpfDProduto,0,CadNotaFiscalI_EMP_FIL.AsInteger, MovNotasFiscaisI_SEQ_PRO.AsInteger);
    ValidaValorUnitario;
    if VpfREsultado = '' then
    begin
      VpfResultado := FunECF.VendeItem(MovNotasFiscaisC_COD_PRO.AsString,cadProdutos.FieldByName('C_NOM_PRO').AsString,MovNotasFiscaisC_COD_UNI.AsString ,MovNotasFiscaisN_QTD_PRO.AsFloat,MovNotasFiscaisN_VLR_PRO.AsFloat,MovNotasFiscaisN_PER_DES.AsFloat,MovNotasFiscaisN_PER_ICM.AsFloat,CadProdutos.FieldByName('C_SUB_TRI').AsString = 'S',CDescontoItem.Checked,CPercentualItem.Checked,true,VpfTotalizadorParcial);
      if Vpfresultado = '' then
      begin
        MovNotasFiscaisI_NUM_ITE.AsInteger := FunECF.RNumeroUltimoItemVendido;
        MovNotasFiscaisI_SEQ_MOV.AsInteger := FunNotaFiscal.RSeqMovNotaFiscalDisponivel(MovNotasFiscaisI_EMP_FIL.AsInteger,MovNotasFiscaisI_SEQ_NOT.AsInteger);
        MovNotasFiscaisC_TPA_ECF.AsString := VpfTotalizadorParcial;
        MovNotasFiscais.Post;
        if (config.BaixarEstoqueECF) then
        begin
          FunProdutos.BaixaProdutoEstoque(VpfDProduto,CadNotaFiscalI_EMP_FIL.AsInteger, varia.CodOperacaoEstoqueECF,
                                        MovNotasFiscaisI_SEQ_NOT.AsInteger,CadNotaFiscalI_NRO_NOT.AsInteger,0,varia.MoedaBase,
                                        0,0,Date,MovNotasFiscaisN_QTD_PRO.AsFloat,MovNotasFiscaisN_TOT_PRO.AsFloat,
                                        MovNotasFiscaisC_COD_UNI.asString,'',false,VpfSeqEstoqueBarra,true);
        end;

        FunProdutos.BaixaEstoqueFiscal(CadNotaFiscalI_EMP_FIL.AsInteger, MovNotasFiscaisI_SEQ_PRO.AsInteger,0,0,MovNotasFiscaisN_QTD_PRO.AsFloat,
                                       MovNotasFiscaisC_COD_UNI.asString,VprUMOriginal,'S');
        EProduto.SetFocus;
        AtualizaMostraItem;
      end;
    end;
    VpfDProduto.Free;
  end;
  if Vpfresultado <> '' then
    aviso(VpfResultado);
end;

{******************************************************************************}
procedure TFNovoECF.ECodClienteCadastrar(Sender: TObject);
begin
  FNovoCliente := TFNovoCliente.CriarSDI(application,'', FPrincipal.VerificaPermisao('FNovoCliente'));
  FNovoCliente.CadClientes.Insert;
  FNovoCliente.showmodal;
  FNovoCliente.free;
end;

{******************************************************************************}
procedure TFNovoECF.ECodClienteAlterar(Sender: TObject);
begin
  if ECodCliente.ALocaliza.Loca.Tabela.FieldByName(ECodCliente.AInfo.CampoCodigo).AsInteger <> 0 then
  begin
    FNovoCliente := TFNovoCliente.criarSDI(Application,'',FPrincipal.VerificaPermisao('FNovoCliente'));
    FNovoCliente.CadClientes.FindKey([ECodCliente.ALocaliza.Loca.Tabela.FieldByName(ECodCliente.AInfo.CampoCodigo).Value]);
//    FNovoCliente.AtualizaLocalizas;
    FNovoCliente.CadClientes.Edit;
    FNovoCliente.ShowModal;
    ConsultaPadrao1.AtualizaConsulta;
    FNovoCliente.free;
  end;
end;

{******************************************************************************}
procedure TFNovoECF.BCancelaCupomClick(Sender: TObject);
begin
  if confirmacao('Tem certeza que deseja cancelar o cupom?') then
  begin
    FunECF.CancelaCupom(CadNotaFiscal,MostraItens,not VprOrcamento);
    PCanelado.visible := true;
    HabilitaCamposTela(false);
  end;
end;

{******************************************************************************}
procedure TFNovoECF.EDescontoAcrescimoExit(Sender: TObject);
begin
  CarDescontoAcrescimoBD;
end;

{******************************************************************************}
procedure TFNovoECF.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if FunECF.ExisteCupomAberto then
  begin
    if confirmacao('O cupom não foi finalizado. Tem certeza que deseja sair?') then
    begin
      if CadNotaFiscal.State = dsEdit then
        CadNotaFiscal.Post;
      canclose := true;
    end
    else
      canclose := false;
  end;
end;

{******************************************************************************}
procedure TFNovoECF.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    115 :
    begin
      if PossuiFoco(PanelColor1) then
        ECoDVendedor.SetFocus
      else
        if PossuiFoco(PanelColor2) then
          ActiveControl := EProduto;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoECF.BFechamentoClick(Sender: TObject);
var
  VpfResultado : string;
begin
  VpfResultado := DadosValidos;
  if VpfResultado = ''  then
    EfetuaFechamentoCupom
  else
    aviso(VpfResultado);
end;

{******************************************************************************}
procedure TFNovoECF.ECoDVendedorRetorno(Retorno1, Retorno2: String);
begin
  if retorno1 <> '' then
  begin
    CadNotaFiscalN_PER_COM.AsFloat := StrToFloat(Retorno1);
  end
  else
    CadNotaFiscalN_PER_COM.Clear;
end;

{******************************************************************************}
procedure TFNovoECF.BFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFNovoECF.BitBtn1Click(Sender: TObject);
begin
  FMenuFiscalECF := TFMenuFiscalECF.CriarSDI(self,'',true);
  FMenuFiscalECF.ShowModal;
  FMenuFiscalECF.Free;
end;

{******************************************************************************}
procedure TFNovoECF.BCancelaItemClick(Sender: TObject);
begin
  if FunECF.CancelaItem(CadNotaFiscalI_EMP_FIL.AsInteger,CadNotaFiscalI_SEQ_NOT.asinteger,MostraItensI_SEQ_MOV.AsInteger,MostraItensI_NUM_ITE.AsInteger) then
  begin
    ExtornaEstoqueItem;
    AtualizaMostraItem;
  end;
end;

{******************************************************************************}
function TFNovoECF.GeraECFAPartirCotacao(VpaDCotacao : TRBDOrcamento):Boolean;
begin
  VprDOrcamento := VpaDCotacao;
  if not FunECF.ExisteCupomAberto then
  begin
    VprDOrcamento := VpaDCotacao;
    VprOrcamento := true;
    ECodCliente.AInteiro := VpaDCotacao.CodCliente;
    ECodCliente.Atualiza;
    ECodCondicaoPagamento.AInteiro := VpaDCotacao.CodCondicaoPagamento;
    ECodCondicaoPagamento.Atualiza;
    BNovo.Click;
    CadNotaFiscalI_COD_VEN.AsInteger := VpaDCotacao.CodVendedor;
    ECoDVendedor.Atualiza;
    if config.PassarDescontodaCotacao then
    begin
      CadNotaFiscalN_PER_COM.AsFloat := VpaDCotacao.PerComissao;
      CadNotaFiscalN_PER_DES.AsFloat := VpaDCotacao.PerDesconto;
      CadNotaFiscalN_VLR_DES.AsFloat := VpaDCotacao.ValDesconto;
    end;
    CarDescontoAcrescimoTela;
    AdicionaItemsCotacao(VpaDCotacao);
    FunNotaFiscal.AssociaNotaOrcamento(VpaDCotacao.CodEmpFil,CadNotaFiscalI_SEQ_NOT.AsInteger,VpaDCotacao.LanOrcamento,VpaDCotacao.CodEmpFil);
    if VprDOrcamento.NumNotas <> '' then
      VprDOrcamento.NumNotas := VprDOrcamento.NumNotas + '/ ';
    VprDOrcamento.NumNotas := VprDOrcamento.NumNotas + 'CF'+CadNotaFiscalI_NRO_NOT.AsString ;
    VprDOrcamento.NumCupomfiscal := CadNotaFiscalI_NRO_NOT.AsString;
    VprDOrcamento.NumContadorOrdemOperacao := FunECF.RNumCOO;

  end;
  if config.MostrarFormaPagamentoECFGeradoPelaCotacao then
    BFechamento.Click
  else
    EfetuaFechamentoCupomCotacao;
  result := VprAcao;
end;

{******************************************************************************}
procedure TFNovoECF.NovoECF;
begin
  showmodal;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovoECF]);
end.

