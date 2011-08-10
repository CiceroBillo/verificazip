unit ALocalizaProdutos;
{          Autor: Rafael Budag
    Data Criação: 16/04/1999;
          Função: Gerar um orçamento

    Motivo alteração:
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Localizacao, StdCtrls, Buttons, Componentes1, Db, DBTables, ExtCtrls,
  PainelGradiente, Grids, DBGrids, Tabela, DBKeyViolation, DBCtrls, Mask,
  numericos, LabelCorMove, CheckLst, Parcela, BotaoCadastro,
  EditorImagem, ConvUnidade, UnProdutos, UnDadosProduto, UnClassificacao, UnDados,
  DBClient, Menus;

type
  TFlocalizaProduto = class(TFormularioPermissao)
    CadProdutos: TSQL;
    Localiza: TConsultaPadrao;
    DataCadProdutos: TDataSource;
    PanelColor2: TPanelColor;
    PanelColor16: TPanelColor;
    CadProdutosC_COD_PRO: TWideStringField;
    CadProdutosC_COD_UNI: TWideStringField;
    CadProdutosC_NOM_PRO: TWideStringField;
    CadProdutosC_ATI_PRO: TWideStringField;
    CadProdutosC_KIT_PRO: TWideStringField;
    CadProdutosL_DES_TEC: TWideStringField;
    CadProdutosN_PER_KIT: TFMTBCDField;
    CadProdutosN_QTD_MIN: TFMTBCDField;
    CadProdutosN_QTD_PRO: TFMTBCDField;
    GProdutos: TGridIndice;
    CadProdutosI_SEQ_PRO: TFMTBCDField;
    DBMemoColor1: TDBMemoColor;
    BKit: TSpeedButton;
    PainelGradiente1: TPainelGradiente;
    CadProdutosN_QTD_RES: TFMTBCDField;
    CadProdutosQdadeReal: TFMTBCDField;
    BFechar: TBitBtn;
    BitBtn1: TBitBtn;
    BCadastrar: TBitBtn;
    CadProdutosN_QTD_PED: TFMTBCDField;
    CadProdutosC_Cod_Bar: TWideStringField;
    CadProdutosC_CLA_FIS: TWideStringField;
    CadProdutosI_COD_COR: TFMTBCDField;
    CadProdutosN_PES_LIQ: TFMTBCDField;
    CadProdutosN_PES_BRU: TFMTBCDField;
    CadProdutosN_RED_ICM: TFMTBCDField;
    CadProdutosN_PER_IPI: TFMTBCDField;
    CadProdutosN_QTD_FIS: TFMTBCDField;
    CadProdutosC_IND_RET: TWideStringField;
    CadProdutosC_NOM_CLA: TWideStringField;
    CadProdutosI_PRI_ATI: TFMTBCDField;
    CadProdutosC_IND_GEN: TWideStringField;
    CadProdutosPrincipioAtivo: TWideStringField;
    CadProdutosGenerico: TWideStringField;
    CadProdutosC_IND_CRA: TWideStringField;
    BConsultar: TBitBtn;
    CadProdutosC_PAT_FOT: TWideStringField;
    BAlterar: TBitBtn;
    CadProdutosC_REG_MSM: TWideStringField;
    PanelColor1: TPanelColor;
    PCartuchos: TPanelColor;
    Label10: TLabel;
    CChipNovo: TCheckBox;
    ECodigoReduzido: TEditColor;
    CCilindroNovo: TCheckBox;
    CCartuchoTexto: TCheckBox;
    CProdutoOriginal: TCheckBox;
    PanelColor5: TPanelColor;
    Label3: TLabel;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    LCliente: TLabel;
    SpeedButton4: TSpeedButton;
    Label20: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    SpeedButton2: TSpeedButton;
    Label6: TLabel;
    Label9: TLabel;
    CProAti: TCheckBox;
    ENomeProduto: TEditColor;
    ECliente: TEditLocaliza;
    ECodigo: TEditColor;
    EClassificacaoProduto: TEditColor;
    ESumula: TEditColor;
    ETabelaPreco: TEditLocaliza;
    CadProdutosC_COD_CTB: TWideStringField;
    CadProdutosC_CIL_NOV: TWideStringField;
    CadProdutosC_CHI_NOV: TWideStringField;
    CadProdutosC_CAR_TEX: TWideStringField;
    CadProdutosC_IND_ORI: TWideStringField;
    CadProdutosI_QTD_PAG: TFMTBCDField;
    ESuperPesquisa: TEditColor;
    Label11: TLabel;
    Label12: TLabel;
    SpeedButton3: TSpeedButton;
    LNomProduto: TLabel;
    EImpressora: TEditLocaliza;
    SpeedButton6: TSpeedButton;
    CadProdutosN_VLR_CUS: TFMTBCDField;
    ESeqProduto: TEditColor;
    Label13: TLabel;
    CadProdutosN_VLR_COM: TFMTBCDField;
    CadProdutosI_ALT_PRO: TFMTBCDField;
    CadProdutosN_PER_COM: TFMTBCDField;
    CadProdutosPERCOMISSAOCLASSIFICACAO: TFMTBCDField;
    CadProdutosC_COD_CLA: TWideStringField;
    CadProdutosI_IND_COV: TFMTBCDField;
    CadProdutosI_MES_GAR: TFMTBCDField;
    CadProdutosI_COD_TAM: TFMTBCDField;
    CadProdutosI_ORI_PRO: TFMTBCDField;
    CadProdutosN_QTD_ARE: TFMTBCDField;
    PReferenciaCliente: TPanelColor;
    ERefCliente: TEditColor;
    Label7: TLabel;
    CadProdutosN_PER_PER: TFMTBCDField;
    Label8: TLabel;
    EPrateleira: TEditColor;
    CadProdutosN_DEN_VOL: TFMTBCDField;
    CadProdutosN_ESP_ACO: TFMTBCDField;
    CadProdutosC_PRA_PRO: TWideStringField;
    CadProdutosC_SUB_TRI: TWideStringField;
    MGrade: TPopupMenu;
    ConsultaFraesAReservar1: TMenuItem;
    CadProdutosNOM_COR: TWideStringField;
    CadProdutosNOMTAMANHO: TWideStringField;
    CadProdutosN_VLR_VEN: TFMTBCDField;
    CadProdutosN_VLR_REV: TFMTBCDField;
    CadProdutosC_NOM_MOE: TWideStringField;
    CadProdutosC_REC_PRE: TWideStringField;
    CadProdutosN_PER_ICM: TFMTBCDField;
    CadProdutosN_PER_MAX: TFMTBCDField;
    CadProdutosDESCONTOMAXIMOCLASSIFICACAO: TFMTBCDField;
    CadProdutosDESCONTOMAXIMOTABELAPRECO: TFMTBCDField;
    CadProdutosN_PER_SUT: TFMTBCDField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CProAtiClick(Sender: TObject);
    procedure BKitClick(Sender: TObject);
    procedure EClassificacaoProdutoSelect(Sender: TObject);
    procedure EClassificacaoProdutoRetorno(Retorno1, Retorno2: String);
    procedure BFecharClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure CadProdutosAfterScroll(DataSet: TDataSet);
    procedure BCadastrarClick(Sender: TObject);
    procedure EClassificacaoProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ENomeProdutoEnter(Sender: TObject);
    procedure BBAjudaClick(Sender: TObject);
    procedure EClienteFimConsulta(Sender: TObject);
    procedure CadProdutosCalcFields(DataSet: TDataSet);
    procedure EClassificacaoProdutoExit(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure BConsultarClick(Sender: TObject);
    procedure EClassificacaoProdutoEnter(Sender: TObject);
    procedure ENomeProdutoExit(Sender: TObject);
    procedure ECodigoEnter(Sender: TObject);
    procedure ECodigoExit(Sender: TObject);
    procedure ESumulaExit(Sender: TObject);
    procedure ETabelaPrecoSelect(Sender: TObject);
    procedure BAlterarClick(Sender: TObject);
    procedure EImpressoraRetorno(Retorno1, Retorno2: String);
    procedure EImpressoraExit(Sender: TObject);
    procedure EImpressoraEnter(Sender: TObject);
    procedure ECodigoReduzidoExit(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure ESeqProdutoEnter(Sender: TObject);
    procedure ESeqProdutoExit(Sender: TObject);
    procedure ERefClienteExit(Sender: TObject);
    procedure ConsultaFraesAReservar1Click(Sender: TObject);
    procedure GProdutosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    Cadastrou : Boolean;
    VprAcao,
    VprFornecedor,
    VprIndSolicitacaoCompra : boolean;
    VprCodClassificacao,
    VprNomProduto,
    VprCodProduto,
    VprSeqProduto,
    VprSumula : String;
    VprSeqImpressora : Integer;
    FunClassificacao : TFuncoesClassificacao;
    procedure ConfiguraPermissaoUsuario;
    procedure AtualizaConsulta(VpaPosicionar : Boolean = false);
    procedure AdicionaFiltrosProduto(VpaSelect : TStrings);
    procedure configuraTela;
    function LocalizaClassificacao : Boolean;
    function DadosProdutosValidos : Boolean;
  public
    function LocalizaProduto( var Cadastrou : Boolean; var seqPRoduto : integer; var codProduro : string; Var EstoqueAtual : Double;VpaCodCliente : Integer  ) : boolean; overload;
    function LocalizaProduto( Var Cadastrou : Boolean; var seqPRoduto : integer; var codProduro, VpaNomProduto : string ) : boolean; overload;
    function LocalizaProduto( var VpaseqPRoduto : integer; var VpacodProduro, VpaNomProduto : string;Var VpaDensidadeVolumetrica, VpaEspessuraAco : Double ) : boolean; overload;
    function LocalizaProduto( Var Cadastrou : Boolean; var seqPRoduto : integer; var codProduro, CodUnidade : string; Var ValorVenda, QtdEstoque, QtdPedido, QtdMinima  : Double) : boolean; overload;
    function LocalizaProduto( var seqPRoduto : integer; var codProduro, NomProduto, CodUnidade : string; Var ValorVenda, QtdEstoque, QtdPedido, QtdMinima  : Double;VpaCodCliente : Integer) : boolean; overload;
    function LocalizaProduto( var VpaSeqPRoduto : integer; var VpacodProduro, VpaNomProduto, VpaCodUnidade, VpaClaFiscal : string) : boolean; overload;
    function LocalizaProduto( var VpaSeqPRoduto : integer) : boolean; overload;
    function LocalizaProduto(VpaDCotacao : TRBDORcamento;VpaDProCotacao : TRBDOrcProduto;VpaCodCliente,VpaCodTabelaPreco : Integer): Boolean;overload;
    function LocalizaProduto(VpaDProdutoNota : TRBDNotaFiscalProduto;VpaCodCliente : Integer): Boolean;overload;
    function LocalizaProduto(VpaDProNotaFor : TRBDNotaFiscalForItem) : Boolean;overload;
    function LocalizaProduto(VpaDProProposta : TRBDPropostaProduto;VpaCodTabelaPreco : Integer): Boolean;overload;
    function LocalizaProduto(VpaDProConsumo : TRBDConsumoMP):boolean;overload;
    function LocalizaProduto(VpaDProAmostra: TRBDConsumoAmostra): Boolean; overload;
    function LocalizaProduto(VpaDProdutoPedido: TRBDProdutoPedidoCompra;VpaCodFornecedor : Integer): Boolean; overload;
    function LocalizaProduto(VpaDProdutoOrcamento: TRBDOrcamentoCompraProduto): Boolean; overload;
    function LocalizaProduto(VpaDOrcamentoItens: TRBDSolicitacaoCompraItem): Boolean; overload;
    function LocalizaProduto(VpaDPropostaLocacao: TRBDPropostaLocacaoCorpo): Boolean; overload;
    function LocalizaProduto(VpaDMaterialAcabamento: TRBDPropostaMaterialAcabamento): Boolean; overload;
    function LocalizaProduto(VpaDProdutoRotulado : TRBDPropostaProdutoASerRotulado):Boolean;overload;
    function LocalizaProduto(VpaDChamado : TRBDChamado;VpaDProdutoOrcado : TRBDChamadoProdutoOrcado):Boolean;overload;
    function LocalizaProduto(VpaDChamado : TRBDChamado;VpaDProdutoaProduzir : TRBDChamadoProdutoaProduzir):Boolean;overload;
    function LocalizaProduto(VpaDProdutoAdicional : TRBDPropostaVendaAdicional):boolean;overload;
    function LocalizaProduto(VpaDItemEspecial : TRBDItensEspeciaisAmostra):boolean;overload;
    function LocalizaProduto : Boolean;overload;
    function LocalizaEntretela(VpaDProConsumo : TRBDConsumoMP):boolean;
    function LocalizaTermoColante(VpaDProConsumo : TRBDConsumoMP):boolean;
  end;

var
  FlocalizaProduto, FLocalizaProdutoConsumo: TFlocalizaProduto;

implementation

uses APrincipal, Constantes,ConstMsg, AProdutosKit,ANovoProdutoPro,
  ALocalizaClassificacao, Unsistema, FunSql,FunObjeto, AOPProdutosAReservar;
{$R *.DFM}


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                               eventos do filtro superior
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{****************** carrega a select do localiza classificacao ****************}
procedure TFlocalizaProduto.EClassificacaoProdutoSelect(Sender: TObject);
begin
end;

{**************** chama a rotina para atualizar a consulta ********************}
procedure TFlocalizaProduto.EClassificacaoProdutoRetorno(Retorno1,
  Retorno2: String);
begin
  AtualizaConsulta;
end;

{*************Chama a Rotina para atualizar a select dos produtos**************}
procedure TFlocalizaProduto.ConsultaFraesAReservar1Click(Sender: TObject);
begin
  if CadProdutosI_SEQ_PRO.AsInteger <> 0 then
  begin
    FOPProdutosAReservar := TFOPProdutosAReservar.criarSDI(Application,'',FPrincipal.VerificaPermisao('FOPProdutosAReservar'));
    FOPProdutosAReservar.MostraFracoesEstoqueAReservar(CadProdutosI_SEQ_PRO.AsInteger,CadProdutosI_COD_COR.AsInteger);
    FOPProdutosAReservar.free;
  end;
end;

{******************************************************************************}
procedure TFlocalizaProduto.CProAtiClick(Sender: TObject);
begin
  AtualizaConsulta;
  BFechar.Default := true;
end;

{******************************************************************************}
function TFlocalizaProduto.DadosProdutosValidos: Boolean;
begin
  result := true;
  exit;
  if config.EmiteNFe or config.EmiteSped then
  begin
    if CadProdutosC_CLA_FIS.AsString = '' then
    begin
      aviso('CODIGO NCM/CLASSIFICAÇÃO FISCAL NÃO PREENCHIDA!!!'#13'O código fiscal do produto não foi preenchido.');
      result := false;
    end;
  end;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         ações da consulta do produto
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFlocalizaProduto.ConfiguraPermissaoUsuario;
begin
  if not((puAdministrador in varia.PermissoesUsuario) or (puPLCompleto in varia.PermissoesUsuario)or
         (puESCompleto in varia.PermissoesUsuario) or (puFACompleto in varia.PermissoesUsuario))then
  begin
    AlterarVisibleDet([BCadastrar,BAlterar],false);
    GProdutos.Columns[8].Visible := false;
    if (puVerPrecoVendaProduto in varia.PermissoesUsuario) then
    begin
      GProdutos.Columns[8].Visible := true;
    end;
    if (puManutencaoProdutos in varia.PermissoesUsuario) then
      AlterarVisibleDet([BCadastrar,BAlterar],true);
  end;
end;



{****************** atualiza a consulta dos produtos **************************}
procedure TFlocalizaProduto.AtualizaConsulta(VpaPosicionar : Boolean = false);
Var
  VpfPosicao : TBookmark;
begin
  if ETabelaPreco.AInteiro = 0 then
    ETabelaPreco.AInteiro := varia.TabelaPreco;
  VpfPosicao := CadProdutos.GetBookmark;
  CadProdutos.close;
  CadProdutos.sql.clear;
  CadProdutos.sql.add('Select C_Cod_Pro, '+
                     ' Pro.I_SEQ_PRO,  Pro.C_COD_UNI,  Pro.C_NOM_PRO, ' +
                     ' Pro.C_ATI_PRO, Pro.C_KIT_PRO, Pro.L_DES_TEC, PRO.C_CLA_FIS, PRO.I_ORI_PRO,  ' +
                     ' PRO.I_PRI_ATI, PRO.C_IND_GEN, PRO.C_IND_CRA, PRO.C_PAT_FOT, PRO.C_REG_MSM, PRO.N_PER_COM, '+
                     ' Pro.N_PER_KIT, PRO.N_PES_LIQ, PRO.N_PES_BRU, PRO.N_PER_IPI, PRO.N_RED_ICM, PRO.C_IND_RET,' +
                     ' PRO.C_COD_CTB, C_CIL_NOV, C_CHI_NOV, C_CAR_TEX, C_IND_ORI, PRO.C_PRA_PRO, '+
                     ' PRO.I_QTD_PAG, PRO.I_ALT_PRO, PRO.I_IND_COV, PRO.I_MES_GAR, PRO.N_DEN_VOL, N_ESP_ACO, PRO.C_SUB_TRI, '+
                     ' PRO.C_REC_PRE, PRO.N_PER_ICM, PRO.N_PER_MAX, PRO.N_PER_SUT, '+
                     ' CLA.C_COD_CLA, CLA.C_NOM_CLA, CLA.N_PER_COM PERCOMISSAOCLASSIFICACAO, '+
                     ' CLA.N_PER_PER, CLA.N_PER_MAX DESCONTOMAXIMOCLASSIFICACAO,'+
                     ' Qtd.C_Cod_Bar, ' +
                     ' Qtd.N_QTD_MIN, QTD.N_QTD_PRO, QTD.N_QTD_PED, QTD.N_QTD_ARE, ' +
                     '  QTD.N_QTD_RES, ' +
                     ' (QTD.N_QTD_PRO - QTD.N_QTD_RES) QdadeReal, ' +
                     ' (PRE.N_VLR_VEN * MOE.N_Vlr_Dia) N_VLR_VEN, QTD.N_QTD_RES, ' +
                     ' (PRE.N_VLR_REV * MOE.N_Vlr_Dia) N_VLR_REV, PRE.N_PER_MAX DESCONTOMAXIMOTABELAPRECO,'+
                     ' Moe.C_Nom_Moe, '+
                     ' QTD.I_COD_COR, QTD.N_QTD_FIS, QTD.N_VLR_CUS, QTD.N_VLR_COM, '+
                     ' QTD.I_COD_TAM, '+
                     ' COR.NOM_COR, ' +
                     ' TAM.NOMTAMANHO '+
                     ' from CADPRODUTOS pro, MOVQDADEPRODUTO Qtd, COR,  TAMANHO TAM,  MOVTABELAPRECO PRE,' +
                     ' CADMOEDAS MOE, CADCLASSIFICACAO CLA');
  AdicionaFiltrosProduto(Cadprodutos.Sql);
  CadProdutos.sql.add(' and Qtd.I_Seq_Pro = Pro.I_Seq_Pro '+
                      ' and CLA.C_TIP_CLA = ''P'''+
                      ' and CLA.I_COD_EMP = PRO.I_COD_EMP '+
                      ' AND CLA.C_COD_CLA = PRO.C_COD_CLA ' +
                      ' and Pre.I_Cod_Emp = Pro.I_Cod_Emp '+
                      ' and Pre.I_Seq_Pro = Pro.I_Seq_Pro '+
                      ' and Moe.I_Cod_Moe = Pro.I_Cod_Moe '+
                      ' and PRE.I_COD_COR = QTD.I_COD_cOR '+
                      ' and Pre.I_Cod_Tab = ' + IntToStr(ETabelaPreco.AInteiro) +
                      ' and PRE.I_COD_EMP = '+IntToStr(Varia.codigoEmpresa)+
                      ' AND '+SQLTextoRightJoin('QTD.I_COD_COR','COR.COD_COR')+
                      ' AND '+SQLTextoRightJoin('QTD.I_COD_TAM','TAM.CODTAMANHO'));
  //estava bem lento para localizar os protutos quando dava o f3 na cotacao
  //foi colocado essa condicao para deixar mais rapido
  if Varia.CNPJFilial = CNPJ_HORNBURG then
     AdicionaSQLTabela(CadProdutos,' AND PRE.I_COD_TAM = 0 ' +
                                   ' AND QTD.I_COD_TAM = 0')
  else
     AdicionaSQLTabela(CadProdutos,' AND PRE.I_COD_TAM = QTD.I_COD_TAM');

  if (puESSomenteSolicitacaodeComprasdeInsumos in Varia.PermissoesUsuario)  and
     VprIndSolicitacaoCompra then
      AdicionaSQLTabela(CadProdutos,'and CLA.C_IND_INS = ''S''');

  CadProdutos.sql.add(' order by PRO.C_NOM_PRO, QTD.I_COD_COR, QTD.I_COD_TAM');
  GravaEstatisticaConsulta(nil,CadProdutos,varia.CodigoUsuario,Self.name,NomeModulo,config.UtilizarPercentualConsulta);
 // CadProdutos.SQL.SaveToFile('c:\produtos.sql');
  CadProdutos.Open;
  if VpaPosicionar then
  try
    CadProdutos.GotoBookmark(VpfPosicao);
  except
    CadProdutos.last;
    CadProdutos.GotoBookmark(VpfPosicao);
  end;
  GProdutos.ALinhaSQLOrderBy := CadProdutos.SQL.Count - 1;
  VprCodClassificacao := EClassificacaoProduto.Text;
  VprCodProduto := ECodigo.Text;
  VprNomProduto := ENomeProduto.Text;
  VprSumula := ESumula.Text;
  VprSeqProduto := ESeqProduto.Text;
end;

{******************* adiciona os filtros da consulta **************************}
procedure TFlocalizaProduto.AdicionaFiltrosProduto(VpaSelect : TStrings);
begin
  VpaSelect.add('Where Qtd.I_Emp_Fil = ' + inttostr(Varia.CodigoEmpFil));
  if varia.CodClassificacaoProdutoGrupo <> '' then
    VpaSelect.Add('and PRO.C_COD_CLA LIKE '''+Varia.CodClassificacaoProdutoGrupo+'%''');

  if VprFornecedor then
  begin
    VpaSelect.add(' and PRE.I_COD_CLI = 0');
    if ECliente.AInteiro <> 0 then
      VpaSelect.add('and exists(Select PFO.SEQPRODUTO from PRODUTOFORNECEDOR PFO '+
                    ' Where PRO.I_SEQ_PRO = PFO.SEQPRODUTO '+
                    ' AND PFO.CODCLIENTE = '+IntToStr(ECliente.AInteiro)+')');
  end
  else
    VpaSelect.add(' and PRE.I_COD_CLI = '+ IntToStr(ECliente.AInteiro));
  if ENomeProduto.text <> '' Then
    VpaSelect.Add('and Pro.C_Nom_Pro like '''+ENomeProduto.text +'%''');
  if ESuperPesquisa.text <> '' Then
    VpaSelect.Add('and Pro.C_REN_Pro like '''+ESuperPesquisa.text +'%''');
  if EClassificacaoProduto.text <> ''Then
    VpaSelect.add(' and Pro.C_Cod_Cla like '''+ EClassificacaoProduto.text+ '%''');
  if CProAti.Checked then
    VpaSelect.add(' and Pro.C_Ati_Pro = ''S''');
  if ECodigo.Text <> '' then
    VpaSelect.Add(' and PRO.C_COD_PRO like '''+ECodigo.Text+'''');
  if ESumula.Text <> '' then
    VpaSelect.Add(' and PRO.I_COD_SUM = ' +ESumula.Text);
  if EPrateleira.Text <> '' then
    VpaSelect.add(' and PRO.C_PRA_PRO = '''+EPrateleira.Text+'''');
  if ECodigoReduzido.Text <> '' then
    VpaSelect.add(' and PRO.C_COD_CTB = '''+ECodigoReduzido.Text+'''');
  if CChipNovo.Checked then
    VpaSelect.add(' and PRO.C_CHI_NOV = ''S''');
  if CCilindroNovo.Checked then
    VpaSelect.add(' and PRO.C_CIL_NOV = ''S''');
  if CCartuchoTexto.Checked then
    VpaSelect.add(' and PRO.C_CAR_TEX = ''S''');
  if CProdutoOriginal.Checked then
    VpaSelect.add(' and PRO.C_IND_ORI = ''S''');
  if ESeqProduto.AInteiro <> 0 then
    VpaSelect.add(' and PRO.I_SEQ_PRO = '+ESeqProduto.Text);
  if (puSomenteProdutos in varia.PermissoesUsuario) and (Varia.CodClassificacaoProdutos <> '') then
    CadProdutos.Sql.Add('AND CLA.C_COD_CLA like '''+Varia.CodClassificacaoProdutos+'%''')
  else
    if (puSomenteMateriaPrima in varia.PermissoesUsuario) and (Varia.CodClassificacaoMateriaPrima <> '') then
      CadProdutos.Sql.Add('AND CLA.C_COD_CLA like '''+Varia.CodClassificacaoMateriaPrima+'%''');

  VpaSelect.add(' and Pro.c_ven_avu = ''S''');
  if VprSeqImpressora <> 0 then
    VpaSelect.add(' and  exists (Select IMP.SEQPRODUTO FROM PRODUTOIMPRESSORA IMP '+
                  ' Where IMP.SEQPRODUTO = PRO.I_SEQ_PRO '+
                  ' and IMP.SEQIMPRESSORA = ' + IntToStr(VprSeqImpressora)+
                  ')');
  if ERefCliente.Text <> '' then
    VpaSelect.add(' and  exists (Select REF.SEQ_PRODUTO FROM PRODUTO_REFERENCIA REF '+
                  ' Where REF.SEQ_PRODUTO = PRO.I_SEQ_PRO '+
                  ' and REF.DES_REFERENCIA = ''' + ERefCliente.Text+''')');

end;

{******************************************************************************}
procedure TFlocalizaProduto.configuraTela;
begin
  GProdutos.Columns[1].Width :=Varia.LarguraColunaProdutoConsulta;
  GProdutos.Columns[2].Width :=Varia.LarguraColunaCorConsulta;
  if not config.EstoquePorCor then
  begin
    GProdutos.Columns[2].Visible := false;
  end;

  if not config.EstoquePorTamanho then
  begin
    GProdutos.Columns[3].Visible := false;
  end;
  PCartuchos.Visible := config.ManutencaoImpressoras;
  PReferenciaCliente.Visible := not Config.NumeroSerieProduto;
  PanelColor1.Height := PanelColor5.Height;
  if config.ManutencaoImpressoras then
    PanelColor1.Height := PanelColor1.Height + PCartuchos.Height;
  if not config.NumeroSerieProduto then
    PanelColor1.Height := PanelColor1.Height + PReferenciaCliente.Height;
end;

{******************************************************************************}
function TFlocalizaProduto.LocalizaClassificacao : Boolean;
var
  VpfCodcla, VpfNomeCla : string;
begin
  result := true;
  FLocalizaClassificacao := TFLocalizaClassificacao.CriarSDI(application,'', true);
  if FLocalizaClassificacao.LocalizaClassificacao(VpfCodcla,VpfNomeCla, 'P') then
  begin
    EClassificacaoProduto.text := VpfCodcla;
    label1.Caption := Vpfnomecla;
  end
  else
    result := false;
end;

{ ******************* chama o formulario para visualizar kit **************** }
procedure TFlocalizaProduto.BKitClick(Sender: TObject);
begin
   FProdutosKit := TFProdutosKit.CriarSDI(Application,'',FPrincipal.VerificaPermisao('FProdutosKit'));
   FProdutosKit.MostraKit(CadProdutosI_Seq_Pro.Asstring,Varia.CodigoEmpFil);
end;



{ ****************** Na criação do Formulário ******************************** }
procedure TFlocalizaProduto.FormCreate(Sender: TObject);
begin
  if config.RepetirNomeProdutonaConsulta then
    ENomeProduto.Text := Varia.ProdutoFiltro;
  VprIndSolicitacaoCompra := false;
  VprSeqImpressora :=0;
  VprFornecedor := false;
  ConfiguraPermissaoUsuario;
  FunClassificacao := TFuncoesClassificacao.criar(self,FPrincipal.BaseDados);
  GProdutos.Columns[0].FieldName := varia.CodigoProduto;
  CadProdutosN_VLR_REV.EditFormat := Varia.MascaraValor;
  CadProdutosN_VLR_VEN.EditFormat := Varia.MascaraValor;
  CadProdutosN_VLR_REV.DisplayFormat := Varia.MascaraValor;
  CadProdutosN_VLR_VEN.DisplayFormat := Varia.MascaraValor;
  Cadastrou := false;
  configuraTela;
end;

{******************************************************************************}
procedure TFlocalizaProduto.GProdutosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if (State <> [gdSelected]) then
  begin
    if CadProdutosC_REC_PRE.AsString = 'S' then
    begin
      GProdutos.Canvas.Font.Color:= clred;
      GProdutos.DefaultDrawDataCell(Rect, GProdutos.columns[datacol].field, State);
    end;
  end;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFlocalizaProduto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FunClassificacao.free;
  Action := CaFree;
end;

{ ********************** chamada externa da localizacao de produtos ********** }
function TFlocalizaProduto.LocalizaProduto( var Cadastrou : Boolean; var seqPRoduto : integer; var codProduro : string; Var EstoqueAtual : Double;VpaCodCliente : Integer) : boolean;
begin
  BCadastrar.Visible  := Cadastrou;

  ECliente.AInteiro := VpaCodCliente;
  ECliente.Atualiza;
  AtualizaConsulta;
  if CadProdutos.Eof then
  begin
    ECliente.AInteiro :=0;
    ECliente.Atualiza;
    AtualizaConsulta;
  end;
  self.ShowModal;
  result := VprAcao;
  Cadastrou := Self.Cadastrou;

  if CadProdutos.IsEmpty then
    result := false;

  if VprAcao then
  begin
    seqPRoduto := CadProdutosI_SEQ_PRO.AsInteger;
    codProduro := CadProdutos.fieldbyname(varia.CodigoProduto).AsString;
    EstoqueAtual := CadProdutosQdadeReal.AsFloat;
  end;
  CadProdutos.close;
end;

{************************** localiza o produto ********************************}
function TFlocalizaProduto.LocalizaProduto( var cadastrou : Boolean; var seqPRoduto : integer; var codProduro, VpaNomProduto : string ) : boolean;
begin
  BCadastrar.Visible  := Cadastrou;
  AtualizaConsulta;
  self.ShowModal;
  result := VprAcao;
  Cadastrou := Self.Cadastrou;

  if CadProdutos.IsEmpty then
    result := false;

  if VprAcao then
  begin
    seqPRoduto := CadProdutosI_SEQ_PRO.AsInteger;
    codProduro := CadProdutos.fieldbyname(varia.CodigoProduto).AsString;
    VpaNomProduto := CadProdutosC_NOM_PRO.AsString;
  end;
  CadProdutos.close;
end;

{************************** localiza o produto ********************************}
function TFlocalizaProduto.LocalizaProduto( var Cadastrou : Boolean; var seqPRoduto : integer; var codProduro, CodUnidade : string; Var ValorVenda, QtdEstoque, QtdPedido, QtdMinima : Double) : boolean;
begin
  AtualizaConsulta;
  self.ShowModal;
  result := VprAcao;

  if CadProdutos.IsEmpty then  // se a tabela estiver vazia, entao nao encontrou
    result := false;

  if VprAcao then  // se achou carrega os dados das variaveis do parametro
  begin
    seqPRoduto := CadProdutosI_SEQ_PRO.AsInteger;
    codProduro := CadProdutos.fieldbyname(varia.CodigoProduto).AsString;
    CodUnidade := CadProdutosC_COD_UNI.AsString;
    ValorVenda := CadProdutosN_VLR_VEN.AsFloat;
    QtdEstoque := CadProdutosQdadeReal.AsFloat;
    QtdMinima  := CadProdutosN_QTD_MIN.AsFloat;
    QtdPedido  := CadProdutosN_QTD_PED.AsFloat;
  end;
  CadProdutos.close;
end;

{******************************************************************************}
function TFlocalizaProduto.LocalizaProduto( var seqPRoduto : integer; var codProduro, NomProduto, CodUnidade : string; Var ValorVenda, QtdEstoque, QtdPedido, QtdMinima  : Double;VpaCodCliente : Integer) : boolean;
begin
  ECliente.Ainteiro := VpaCodCliente;
  ECliente.Atualiza;
  AtualizaConsulta;
  if CadProdutos.Eof then
  begin
    ECliente.AInteiro :=0;
    ECliente.Atualiza;
    AtualizaConsulta;
  end;

  self.ShowModal;
  result := VprAcao;

  if CadProdutos.IsEmpty then  // se a tabela estiver vazia, entao nao encontrou
    result := false;

  if VprAcao then  // se achou carrega os dados das variaveis do parametro
  begin
    seqPRoduto := CadProdutosI_SEQ_PRO.AsInteger;
    codProduro := CadProdutos.fieldbyname(varia.CodigoProduto).AsString;
    NomProduto := CadProdutosC_NOM_PRO.AsString;
    CodUnidade := CadProdutosC_COD_UNI.AsString;
    ValorVenda := CadProdutosN_VLR_VEN.AsFloat;
    QtdEstoque := CadProdutosQdadeReal.AsFloat;
    QtdMinima  := CadProdutosN_QTD_MIN.AsFloat;
    QtdPedido  := CadProdutosN_QTD_PED.AsFloat;
  end;
  CadProdutos.close;
end;

{******************************************************************************}
function TFlocalizaProduto.LocalizaProduto( var VpaSeqPRoduto : integer; var VpacodProduro, VpaNomProduto, VpaCodUnidade, VpaClaFiscal : string) : boolean;
begin
  AtualizaConsulta;
  self.ShowModal;
  result := VprAcao;

  if CadProdutos.IsEmpty then  // se a tabela estiver vazia, entao nao encontrou
    result := false;

  if VprAcao then  // se achou carrega os dados das variaveis do parametro
  begin
    VpaseqPRoduto := CadProdutosI_SEQ_PRO.AsInteger;
    VpacodProduro := CadProdutos.fieldbyname(varia.CodigoProduto).AsString;
    VpaNomProduto := CadProdutosC_NOM_PRO.AsString;
    VpaCodUnidade := CadProdutosC_COD_UNI.AsString;
    VpaClaFiscal := CadProdutosC_CLA_FIS.AsString;
  end;
  CadProdutos.close;
end;

{******************************************************************************}
function TFlocalizaProduto.LocalizaProduto(VpaDCotacao : TRBDORcamento; VpaDProCotacao : TRBDOrcProduto;VpaCodCliente, VpaCodTabelaPreco : Integer): Boolean;
begin
  ECliente.Ainteiro := VpaCodCliente;
  ECliente.Atualiza;
  ETabelaPreco.AInteiro := VpaCodTabelaPreco;
  AtualizaConsulta;
  if CadProdutos.Eof then
  begin
    ECliente.AInteiro :=0;
    ECliente.Atualiza;
    AtualizaConsulta;
  end;

  self.ShowModal;
  result := VprAcao;

  if CadProdutos.IsEmpty then  // se a tabela estiver vazia, entao nao encontrou
    result := false;
  if result then
    if CadProdutosC_ATI_PRO.AsString <> 'S' then
    begin
      aviso('PRODUTO INATIVO!!!'#13'O produto selecinado não pode ser utilizado pois está INATIVO...');
      result := false;
    end;

  if VprAcao and result then  // se achou carrega os dados das variaveis do parametro
  begin
    VpaDProCotacao.seqPRoduto := CadProdutosI_SEQ_PRO.AsInteger;
    VpaDProCotacao.CodProduto := CadProdutos.fieldbyname(varia.CodigoProduto).AsString;
    VpaDProCotacao.CodClassificacao := CadProdutosC_COD_CLA.AsString;
    VpaDProCotacao.NomProduto := CadProdutosC_NOM_PRO.AsString;
    VpaDProCotacao.UMOriginal := CadProdutosC_COD_UNI.AsString;
    VpaDProCotacao.UM := CadProdutosC_COD_UNI.AsString;
    VpaDProCotacao.UMAnterior := CadProdutosC_COD_UNI.AsString;

    VpaDProCotacao.ValUnitarioOriginal := CadProdutosN_VLR_VEN.AsFloat;
    if VpaDCotacao.IndRevenda then
      VpaDProCotacao.ValUnitario := VpaDProCotacao.ValRevenda
    else
      VpaDProCotacao.ValUnitario := VpaDProCotacao.ValUnitarioOriginal;
    if ECliente.AInteiro = 0 then
      VpaDProCotacao.ValTabelaPreco := VpaDProCotacao.ValUnitarioOriginal
    else
      FunProdutos.CarValVendaeRevendaProduto(ETabelaPreco.AInteiro,CadProdutosI_SEQ_PRO.AsInteger,CadProdutosI_COD_COR.AsInteger,CadProdutosI_COD_TAM.AsInteger,ECliente.AInteiro,VpaDProCotacao.ValUnitario,VpaDProCotacao.ValRevenda,VpaDProCotacao.ValTabelaPreco,VpaDProCotacao.PerDescontoMaximoPermitido);

    VpaDProCotacao.ValCustoUnitario := CadProdutosN_VLR_CUS.AsFloat;
    if (VpaDProCotacao.CodCor <> 0) or
       (VpaDProCotacao.CodTamanho <> 0)  then
      VpaDProCotacao.ValCustoUnitario := FunProdutos.RValorCusto(VpaDCotacao.CodEmpFil,VpaDProCotacao.SeqProduto,VpaDProCotacao.CodCor,VpaDProCotacao.CodTamanho);

    VpaDProCotacao.ValRevenda := CadProdutosN_VLR_REV.AsFloat;
    VpaDProCotacao.QtdEstoque := CadProdutosQdadeReal.AsFloat;
    VpaDProCotacao.QtdMinima  := CadProdutosN_QTD_MIN.AsFloat;
    VpaDProCotacao.QtdPedido  := CadProdutosN_QTD_PED.AsFloat;
    VpaDProCotacao.QtdFiscal := CadProdutosN_QTD_FIS.AsFloat;
    VpaDProCotacao.QtdKit := CadProdutosI_IND_COV.AsInteger;
    VpaDProCotacao.QtdBaixadoNota := 0;
    VpaDProCotacao.QtdBaixadoEstoque := 0;
    VpaDProCotacao.PesLiquido := CadProdutosN_PES_LIQ.AsFloat;
    VpaDProCotacao.PesBruto := CadProdutosN_PES_BRU.AsFloat;
    VpaDProCotacao.PerDesconto := CadProdutosN_PER_KIT.AsFloat;
    VpaDProCotacao.IndFaturar := (VpaDProCotacao.QtdFiscal > (VpaDProCotacao.QtdPedido *2));
    VpaDProCotacao.IndRetornavel := (CadProdutosC_IND_RET.AsString = 'S');
    VpaDProCotacao.IndCracha := (CadProdutosC_IND_CRA.AsString = 'S');
    VpaDProCotacao.IndSubstituicaoTributaria := (CadProdutosC_SUB_TRI.AsString = 'S');
    VpaDProCotacao.IndBrinde := false;
    VpaDProCotacao.CodPrincipioAtivo := CadProdutosI_PRI_ATI.AsInteger;
    VpaDProCotacao.DesRegistroMSM := CadProdutosC_REG_MSM.AsString;
    VpaDProCotacao.DesPrateleira := CadProdutosC_PRA_PRO.AsString;
    VpaDProCotacao.PerComissao := CadProdutosN_PER_COM.AsFloat;
    VpaDProCotacao.PerICMS:= CadProdutosN_PER_ICM.AsFloat;
    VpaDProCotacao.PerComissaoClassificacao := CadProdutosPERCOMISSAOCLASSIFICACAO.AsFloat;
    VpaDProCotacao.PathFoto := CadProdutosC_PAT_FOT.AsString;
    if config.EstoquePorCor then
      VpaDProCotacao.CodCor := CadProdutosI_COD_COR.AsInteger;
    if config.EstoquePorTamanho then
      VpaDProCotacao.CodTamanho := CadProdutosI_COD_TAM.AsInteger;
    if CadProdutosDESCONTOMAXIMOTABELAPRECO.AsFloat > 0 then
      VpaDProCotacao.PerDescontoMaximoPermitido := CadProdutosDESCONTOMAXIMOTABELAPRECO.AsFloat
    else
      if CadProdutosN_PER_MAX.AsFloat > 0 then
        VpaDProCotacao.PerDescontoMaximoPermitido := CadProdutosN_PER_MAX.AsFloat
      else
        if CadProdutosDESCONTOMAXIMOCLASSIFICACAO.AsFloat > 0 then
          VpaDProCotacao.PerDescontoMaximoPermitido := CadProdutosDESCONTOMAXIMOCLASSIFICACAO.AsFloat
        else
          VpaDProCotacao.PerDescontoMaximoPermitido := varia.DescontoMaximoNota;
  end;
  CadProdutos.close;
end;

{******************************************************************************}
function TFlocalizaProduto.LocalizaProduto(VpaDProdutoNota : TRBDNotaFiscalProduto;VpaCodCliente : Integer): Boolean;
begin
  ECliente.Ainteiro := VpaCodCliente;
  ECliente.Atualiza;
  AtualizaConsulta;
  if CadProdutos.Eof then
  begin
    ECliente.AInteiro :=0;
    ECliente.Atualiza;
    AtualizaConsulta;
  end;

  self.ShowModal;
  result := VprAcao;

  if CadProdutos.IsEmpty then  // se a tabela estiver vazia, entao nao encontrou
    result := false;

  if (VprAcao) and result then  // se achou carrega os dados das variaveis do parametro
  begin
    VpaDProdutoNota.seqPRoduto := CadProdutosI_SEQ_PRO.AsInteger;
    VpaDProdutoNota.CodProduto := CadProdutos.fieldbyname(varia.CodigoProduto).AsString;
    VpaDProdutoNota.CodClassificacaoProduto := CadProdutosC_COD_CLA.AsString;
    VpaDProdutoNota.NomProduto := CadProdutosC_NOM_PRO.AsString;
    VpaDProdutoNota.UMOriginal := CadProdutosC_COD_UNI.AsString;
    VpaDProdutoNota.UM := CadProdutosC_COD_UNI.AsString;
    VpaDProdutoNota.UMAnterior := VpaDProdutoNota.UM;
    VpaDProdutoNota.ValUnitarioOriginal := CadProdutosN_VLR_VEN.AsFloat;
    VpaDProdutoNota.ValUnitario := VpaDProdutoNota.ValUnitarioOriginal;
    VpaDProdutoNota.QtdEstoque := CadProdutosQdadeReal.AsFloat;
    VpaDProdutoNota.QtdMinima  := CadProdutosN_QTD_MIN.AsFloat;
    VpaDProdutoNota.QtdPedido  := CadProdutosN_QTD_PED.AsFloat;
    VpaDProdutoNota.QtdProduto  := 1;
    VpaDProdutoNota.PesLiquido := CadProdutosN_PES_LIQ.AsFloat;
    VpaDProdutoNota.PesBruto := CadProdutosN_PES_BRU.AsFloat;
    VpaDProdutoNota.NumOrigemProduto := CadProdutosI_ORI_PRO.AsInteger;
    if config.UtilizarClassificacaoFiscalnosProdutos then
      VpaDProdutoNota.CodClassificacaoFiscal := CadProdutosC_CLA_FIS.AsString;
    VpaDProdutoNota.PerIPI := 0;
    if (CadProdutosN_PER_IPI.AsFloat <> 0) and not (config.SimplesFederal) then
      VpaDProdutoNota.PerIPI := CadProdutosN_PER_IPI.AsFloat;
    if CadProdutosN_RED_ICM.AsFloat <> 0 then
    begin
      VpaDProdutoNota.PerReducaoICMSProduto := CadProdutosN_RED_ICM.AsFloat;
      VpaDProdutoNota.IndReducaoICMS := true;
    end
    else
      VpaDProdutoNota.IndReducaoICMS := false;
    VpaDProdutoNota.PerComissaoProduto := CadProdutosN_PER_COM.AsFloat;
    VpaDProdutoNota.PerComissaoClassificacao := CadProdutosPERCOMISSAOCLASSIFICACAO.AsFloat;
    VpaDProdutoNota.QtdMesesGarantia  := CadProdutosI_MES_GAR.AsInteger;
  end;
  CadProdutos.close;
end;

{******************************************************************************}
function TFlocalizaProduto.LocalizaProduto(VpaDProNotaFor : TRBDNotaFiscalForItem) : Boolean;
begin
  AtualizaConsulta;

  self.ShowModal;
  result := VprAcao;

  if CadProdutos.IsEmpty then  // se a tabela estiver vazia, entao nao encontrou
    result := false;

  if (VprAcao) and result then  // se achou carrega os dados das variaveis do parametro
  begin
    with VpaDProNotaFor do
    begin
      SeqProduto := CadProdutosI_SEQ_PRO.AsInteger;
      CodProduto := CadProdutos.fieldbyname(varia.CodigoProduto).AsString;
      NomProduto := CadProdutosC_NOM_PRO.AsString;
      UMOriginal := CadProdutosC_COD_UNI.AsString;
      UM := CadProdutosC_COD_UNI.AsString;
      UMAnterior := CadProdutosC_COD_UNI.AsString;
      CodClassificacaoFiscal := CadProdutosC_CLA_FIS.AsString;
      CodClassificacaoFiscalOriginal := CadProdutosC_CLA_FIS.AsString;
      ValVenda := FunProdutos.ValorDeVenda(SeqProduto,Varia.TabelaPreco,CadProdutosI_COD_TAM.AsInteger);
      ValNovoVenda := ValVenda;
      ValRevenda := CadProdutosN_VLR_REV.AsFloat;
      CodPrincipioAtivo := CadProdutosI_PRI_ATI.AsInteger;
      DesRegistroMSM := CadProdutosC_REG_MSM.AsString;
      DensidadeVolumetricaAco := CadProdutosN_DEN_VOL.AsFloat;
      EspessuraAco := CadProdutosN_ESP_ACO.AsFloat;
      IndProdutoAtivo := CadProdutosC_ATI_PRO.AsString = 'S';
      PerMVA := CadProdutosN_PER_SUT.AsFloat;
      PerMVAAnterior := PerMVA;
      NumOrigemProduto := CadProdutosI_ORI_PRO.AsInteger;
      PerICMSCadatroProduto := CadProdutosN_PER_ICM.AsFloat;
      if config.EstoquePorCor then
      begin
        VpaDProNotaFor.CodCor := CadProdutosI_COD_COR.AsInteger;
      end;
      if config.EstoquePorTamanho then
      begin
        VpaDProNotaFor.CodTamanho := CadProdutosI_COD_TAM.AsInteger;
      end;
    end;
  end;
  CadProdutos.close;
end;

{******************************************************************************}
function TFlocalizaProduto.LocalizaProduto(VpaDProProposta : TRBDPropostaProduto;VpaCodTabelaPreco : Integer): Boolean;
begin
  ETabelaPreco.AInteiro := VpaCodTabelaPreco;
  AtualizaConsulta;

  self.ShowModal;
  result := VprAcao;

  if CadProdutos.IsEmpty then  // se a tabela estiver vazia, entao nao encontrou
    result := false;

  if VprAcao and result then  // se achou carrega os dados das variaveis do parametro
  begin
    VpaDProProposta.seqPRoduto := CadProdutosI_SEQ_PRO.AsInteger;
    VpaDProProposta.CodProduto := CadProdutos.fieldbyname(varia.CodigoProduto).AsString;
    VpaDProProposta.NomProduto := CadProdutosC_NOM_PRO.AsString;
    VpaDProProposta.UMOriginal := CadProdutosC_COD_UNI.AsString;
    VpaDProProposta.PathFoto := CadProdutosC_PAT_FOT.AsString;
    VpaDProProposta.DesTecnica := CadProdutosL_DES_TEC.AsString;
    VpaDProProposta.UM := CadProdutosC_COD_UNI.AsString;
    VpaDProProposta.ValUnitarioOriginal := CadProdutosN_VLR_VEN.AsFloat;
    VpaDProProposta.ValUnitario := VpaDProProposta.ValUnitarioOriginal;
  end;
  CadProdutos.close;
end;

{******************************************************************************}
function TFlocalizaProduto.LocalizaProduto: Boolean;
begin
  AtualizaConsulta;
  ShowModal;
  result := VprAcao;
  CadProdutos.close;
end;

{******************************************************************************}
function TFlocalizaProduto.LocalizaProduto(
  VpaDMaterialAcabamento: TRBDPropostaMaterialAcabamento): Boolean;
begin
  AtualizaConsulta;
  ShowModal;
  Result:= VprAcao;
  if CadProdutos.IsEmpty then
    Result:= False;
  if VprAcao and Result then
  begin
    VpaDMaterialAcabamento.SeqProduto:= CadProdutosI_SEQ_PRO.AsInteger;
    VpaDMaterialAcabamento.CodProduto:= CadProdutosC_COD_PRO.AsString;
    VpaDMaterialAcabamento.NomProduto:= CadProdutosC_NOM_PRO.AsString;
    VpaDMaterialAcabamento.UM:= CadProdutosC_COD_UNI.AsString;
    VpaDMaterialAcabamento.Quantidade:= CadProdutosN_QTD_PRO.AsInteger;
  end;
  CadProdutos.close;
end;

{******************************************************************************}
function TFlocalizaProduto.LocalizaProduto(VpaDChamado: TRBDChamado;
  VpaDProdutoaProduzir: TRBDChamadoProdutoaProduzir): Boolean;
begin
  ECliente.Ainteiro := VpaDChamado.CodCliente;
  ECliente.Atualiza;
  AtualizaConsulta;
  if CadProdutos.Eof then
  begin
    ECliente.AInteiro :=0;
    ECliente.Atualiza;
    AtualizaConsulta;
  end;

  self.ShowModal;
  result := VprAcao;

  if CadProdutos.IsEmpty then  // se a tabela estiver vazia, entao nao encontrou
    result := false;

  if VprAcao and result then  // se achou carrega os dados das variaveis do parametro
  begin
    VpaDProdutoaProduzir.SeqProduto:= CadProdutosI_SEQ_PRO.AsInteger;
    VpaDProdutoaProduzir.CodProduto := CadProdutos.fieldbyname(varia.CodigoProduto).AsString;
    VpaDProdutoaProduzir.NomProduto := CadProdutosC_NOM_PRO.AsString;
    VpaDProdutoaProduzir.DesUM := CadProdutosC_COD_UNI.AsString;
    VpaDProdutoaProduzir.ValUnitario := CadProdutosN_VLR_VEN.AsFloat;
    VpaDProdutoaProduzir.Quantidade:= 1;
  end;
  CadProdutos.close;
end;

{******************************************************************************}
function TFlocalizaProduto.LocalizaProduto(var VpaseqPRoduto: integer; var vpacodProduro, VpaNomProduto: string; var VpaDensidadeVolumetrica, VpaEspessuraAco: Double): boolean;
begin
  AtualizaConsulta;
  self.ShowModal;
  result := VprAcao;

  if CadProdutos.IsEmpty then  // se a tabela estiver vazia, entao nao encontrou
    result := false;

  if VprAcao then  // se achou carrega os dados das variaveis do parametro
  begin
    VpaseqPRoduto := CadProdutosI_SEQ_PRO.AsInteger;
    VpacodProduro := CadProdutos.fieldbyname(varia.CodigoProduto).AsString;
    VpaNomProduto := CadProdutosC_NOM_PRO.AsString;
    VpaDensidadeVolumetrica := CadProdutosN_DEN_VOL.AsFloat;
    VpaEspessuraAco := CadProdutosN_ESP_ACO.AsFloat;
  end;
  CadProdutos.close;
end;

{******************************************************************************}
function TFlocalizaProduto.LocalizaProduto(VpaDItemEspecial: TRBDItensEspeciaisAmostra): boolean;
begin
  AtualizaConsulta;
  ShowModal;
  Result:= VprAcao;
  if CadProdutos.IsEmpty then
    Result:= False;
  if VprAcao and Result then
  begin
    VpaDItemEspecial.SeqProduto:= CadProdutosI_SEQ_PRO.AsInteger;
    VpaDItemEspecial.CodProduto:= CadProdutosC_COD_PRO.AsString;
    VpaDItemEspecial.NomProduto := CadProdutosC_NOM_PRO.AsString;
    VpaDItemEspecial.ValProduto := CadProdutosN_VLR_CUS.AsFloat;
  end;
  CadProdutos.close;
end;

{******************************************************************************}
function TFlocalizaProduto.LocalizaProduto(var VpaSeqPRoduto: integer): boolean;
begin
  AtualizaConsulta;
  self.ShowModal;
  result := VprAcao;

  if CadProdutos.IsEmpty then  // se a tabela estiver vazia, entao nao encontrou
    result := false;

  if VprAcao then  // se achou carrega os dados das variaveis do parametro
  begin
    VpaseqPRoduto := CadProdutosI_SEQ_PRO.AsInteger;
  end;
  CadProdutos.close;
end;

{******************************************************************************}
function TFlocalizaProduto.LocalizaEntretela(VpaDProConsumo : TRBDConsumoMP):boolean;
begin
  AtualizaConsulta;
  Self.ShowModal;
  Result:= VprAcao;
  if CadProdutos.IsEmpty then
    Result:= False;

  if VprAcao and Result then
  begin
    VpaDProConsumo.SeqProdutoEntretela := CadProdutosI_SEQ_PRO.AsInteger;
    VpaDProConsumo.CodProdutoEntretela:= CadProdutosC_COD_PRO.AsString;
    VpaDProConsumo.NomProdutoEntretela:= CadProdutosC_NOM_PRO.AsString;
  end;
  CadProdutos.close;
end;

{******************************************************************************}
function TFlocalizaProduto.LocalizaTermoColante(VpaDProConsumo : TRBDConsumoMP):boolean;
begin
  AtualizaConsulta;
  Self.ShowModal;
  Result:= VprAcao;
  if CadProdutos.IsEmpty then
    Result:= False;

  if VprAcao and Result then
  begin
    VpaDProConsumo.SeqProdutoTermoColante := CadProdutosI_SEQ_PRO.AsInteger;
    VpaDProConsumo.CodProdutoTermoColante:= CadProdutosC_COD_PRO.AsString;
    VpaDProConsumo.NomProdutoTermoColante:= CadProdutosC_NOM_PRO.AsString;
  end;
  CadProdutos.close;
end;

{******************************************************************************}
function TFlocalizaProduto.LocalizaProduto(VpaDProConsumo : TRBDConsumoMP):boolean;
begin
  AtualizaConsulta;
  Self.ShowModal;
  Result:= VprAcao;
  if CadProdutos.IsEmpty then
    Result:= False;

  if VprAcao and Result then
  begin
    VpaDProConsumo.SeqProduto := CadProdutosI_SEQ_PRO.AsInteger;
    VpaDProConsumo.CodProduto:= CadProdutosC_COD_PRO.AsString;
    VpaDProConsumo.AltProduto := CadProdutosI_ALT_PRO.AsInteger;
    VpaDProConsumo.NomProduto:= CadProdutosC_NOM_PRO.AsString;
    VpaDProConsumo.UM:= CadProdutosC_COD_UNI.AsString;
    VpaDProConsumo.UMOriginal:= CadProdutosC_COD_UNI.AsString;
    VpaDProConsumo.ValorUnitario:= CadProdutosN_VLR_CUS.AsCurrency;
    VpaDProConsumo.QtdProduto := 1;
  end;
  CadProdutos.close;
end;

{******************************************************************************}
function TFlocalizaProduto.LocalizaProduto(VpaDProAmostra: TRBDConsumoAmostra): Boolean;
begin
  GProdutos.Columns[RIndiceColuna(GProdutos,'N_VLR_CUS')].Visible := True;
  GProdutos.Columns[RIndiceColuna(GProdutos,'N_VLR_VEN')].Visible := false;
  AtualizaConsulta;
  Self.ShowModal;
  Result:= VprAcao;
  if CadProdutos.IsEmpty then
    Result:= False;

  if VprAcao and Result then
  begin
    VpaDProAmostra.SeqProduto := CadProdutosI_SEQ_PRO.AsInteger;
    VpaDProAmostra.CodProduto:= CadProdutosC_COD_PRO.AsString;
    VpaDProAmostra.AltProduto := CadProdutosI_ALT_PRO.AsInteger;
    VpaDProAmostra.NomProduto:= CadProdutosC_NOM_PRO.AsString;
    VpaDProAmostra.DesUM:= CadProdutosC_COD_UNI.AsString;
    VpaDProAmostra.UMAnterior := VpaDProAmostra.DesUM;
    VpaDProAmostra.ValUnitario:= CadProdutosN_VLR_CUS.AsCurrency;
    VpaDProamostra.PerAcrescimoPerda := CadProdutosN_PER_PER.AsFloat;
  end;
  CadProdutos.close;
end;

{******************************************************************************}
function TFlocalizaProduto.LocalizaProduto(VpaDProdutoPedido: TRBDProdutoPedidoCompra;VpaCodFornecedor : Integer): Boolean;
begin
  VprFornecedor := true;
  LCliente.Caption := 'Fornecedor : ';
  ECliente.Ainteiro := VpaCodFornecedor;
  ECliente.Atualiza;
  AtualizaConsulta;
  if CadProdutos.Eof then
  begin
    ECliente.AInteiro :=0;
    ECliente.Atualiza;
    AtualizaConsulta;
  end;
  AtualizaConsulta;
  ShowModal;
  Result:= VprAcao;
  if CadProdutos.IsEmpty then
    Result:= False;

  if VprAcao and Result then
  begin
    VpaDProdutoPedido.SeqProduto:= CadProdutosI_SEQ_PRO.AsInteger;
    VpaDProdutoPedido.CodProduto:= CadProdutosC_COD_PRO.AsString;
    VpaDProdutoPedido.NomProduto:= CadProdutosC_NOM_PRO.AsString;
    VpaDProdutoPedido.DesTecnica := CadProdutosL_DES_TEC.AsString;
    VpaDProdutoPedido.DesUM:= CadProdutosC_COD_UNI.AsString;
    VpaDProdutoPedido.ValUnitario:= CadProdutosN_VLR_COM.AsFloat;
    VpaDProdutoPedido.PerIPI := CadProdutosN_PER_IPI.AsFloat;
    VpaDProdutoPedido.DensidadeVolumetricaAco := CadProdutosN_DEN_VOL.AsFloat;
    VpaDProdutoPedido.EspessuraAco := CadProdutosN_ESP_ACO.AsFloat;
    VpaDProdutoPedido.CodClassificacaoFiscal := CadProdutosC_CLA_FIS.AsString;

    VpaDProdutoPedido.UnidadesParentes.Free;
    VpaDProdutoPedido.UnidadesParentes:= FunProdutos.RUnidadesParentes(VpaDProdutoPedido.DesUM);
    VpaDProdutoPedido.QtdProduto:= 1;
    if config.EstoquePorCor then
    begin
      VpaDProdutoPedido.CodCor:= CadProdutosI_COD_COR.AsInteger;
      VpaDProdutoPedido.NomCor := CadProdutosNOM_COR.AsString;
    end;
    if config.EstoquePorTamanho then
    begin
      VpaDProdutoPedido.CodTamanho := CadProdutosI_COD_TAM.AsInteger;
      VpaDProdutoPedido.NomTamanho := CadProdutosNOMTAMANHO.AsString;
    end;
  end;
  CadProdutos.close;
end;

{******************************************************************************}
function TFlocalizaProduto.LocalizaProduto(VpaDProdutoOrcamento: TRBDOrcamentoCompraProduto): Boolean;
begin
  VprFornecedor := true;
  LCliente.Caption := 'Fornecedor : ';
  AtualizaConsulta;
  ShowModal;
  Result:= VprAcao;
  if CadProdutos.IsEmpty then
    Result:= False;

  if VprAcao and Result then
  begin
    VpaDProdutoOrcamento.SeqProduto:= CadProdutosI_SEQ_PRO.AsInteger;
    VpaDProdutoOrcamento.CodProduto:= CadProdutosC_COD_PRO.AsString;
    VpaDProdutoOrcamento.NomProduto:= CadProdutosC_NOM_PRO.AsString;
    VpaDProdutoOrcamento.DesTecnica := CadProdutosL_DES_TEC.AsString;
    VpaDProdutoOrcamento.DesUM:= CadProdutosC_COD_UNI.AsString;
    VpaDProdutoOrcamento.ValUnitario:= CadProdutosN_VLR_COM.AsFloat;
    VpaDProdutoOrcamento.PerIPI := CadProdutosN_PER_IPI.AsFloat;
    VpaDProdutoOrcamento.DensidadeVolumetricaAco := CadProdutosN_DEN_VOL.AsFloat;
    VpaDProdutoOrcamento.EspessuraAco := CadProdutosN_ESP_ACO.AsFloat;

    VpaDProdutoOrcamento.UnidadesParentes.Free;
    VpaDProdutoOrcamento.UnidadesParentes:= FunProdutos.RUnidadesParentes(VpaDProdutoOrcamento.DesUM);
    VpaDProdutoOrcamento.QtdProduto:= 1;
    VpaDProdutoOrcamento.CodCor:= 0;
  end;
  CadProdutos.close;
end;

{******************************************************************************}
function TFlocalizaProduto.LocalizaProduto(VpaDOrcamentoItens: TRBDSolicitacaoCompraItem): Boolean;
begin
  VprIndSolicitacaoCompra := true;
  VprFornecedor := true;
  LCliente.Caption := 'Fornecedor : ';
  AtualizaConsulta;
  ShowModal;
  Result:= VprAcao;
  if CadProdutos.IsEmpty then
    Result:= False;

  if VprAcao and Result then
  begin
    VpaDOrcamentoItens.SeqProduto:= CadProdutosI_SEQ_PRO.AsInteger;
    VpaDOrcamentoItens.CodProduto:= CadProdutosC_COD_PRO.AsString;
    VpaDOrcamentoItens.NomProduto:= CadProdutosC_NOM_PRO.AsString;
    VpaDOrcamentoItens.DesUM:= CadProdutosC_COD_UNI.AsString;
    VpaDOrcamentoItens.UMOriginal:= CadProdutosC_COD_UNI.AsString;
    VpaDOrcamentoItens.CodClassificacao := CadProdutosC_COD_CLA.AsString;
    VpaDOrcamentoItens.DensidadeVolumetricaAco := CadProdutosN_DEN_VOL.AsFloat;
    VpaDOrcamentoItens.EspessuraAco := CadProdutosN_ESP_ACO.AsFloat;

    VpaDOrcamentoItens.UnidadesParentes.Free;
    VpaDOrcamentoItens.UnidadesParentes:= FunProdutos.RUnidadesParentes(VpaDOrcamentoItens.DesUM);
    VpaDOrcamentoItens.QtdProduto:= 1;
    VpaDOrcamentoItens.CodCor:= 0;
  end;
  CadProdutos.close;
end;

{******************************************************************************}
function TFlocalizaProduto.LocalizaProduto(VpaDPropostaLocacao: TRBDPropostaLocacaoCorpo): Boolean;
begin
  AtualizaConsulta;
  ShowModal;
  Result:= VprAcao;
  if CadProdutos.IsEmpty then
    Result:= False;
  if VprAcao and Result then
  begin
    VpaDPropostaLocacao.SeqProduto:= CadProdutosI_SEQ_PRO.AsInteger;
    VpaDPropostaLocacao.CodProduto:= CadProdutosC_COD_PRO.AsString;
    VpaDPropostaLocacao.NomProduto:= CadProdutosC_NOM_PRO.AsString;
    VpaDPropostaLocacao.DesEmail:= CadProdutosL_DES_TEC.AsString;
  end;
  CadProdutos.close;
end;

{******************************************************************************}
function TFlocalizaProduto.LocalizaProduto(VpaDProdutoRotulado : TRBDPropostaProdutoASerRotulado):Boolean;
begin
  EClassificacaoProduto.Text := Varia.CodClassificacaoProdutoRotulado;
  AtualizaConsulta;
  ShowModal;
  Result:= VprAcao;
  if CadProdutos.IsEmpty then
    Result:= False;
  if VprAcao and Result then
  begin
    VpaDProdutoRotulado.SeqProduto:= CadProdutosI_SEQ_PRO.AsInteger;
    VpaDProdutoRotulado.CodProduto:= CadProdutosC_COD_PRO.AsString;
    VpaDProdutoRotulado.NomProduto:= CadProdutosC_NOM_PRO.AsString;
  end;
  CadProdutos.close;
end;

{******************************************************************************}
function TFlocalizaProduto.LocalizaProduto(VpaDChamado : TRBDChamado; VpaDProdutoOrcado : TRBDChamadoProdutoOrcado):Boolean;
begin
  ECliente.Ainteiro := VpaDChamado.CodCliente;
  ECliente.Atualiza;
  AtualizaConsulta;
  if CadProdutos.Eof then
  begin
    ECliente.AInteiro :=0;
    ECliente.Atualiza;
    AtualizaConsulta;
  end;

  self.ShowModal;
  result := VprAcao;

  if CadProdutos.IsEmpty then  // se a tabela estiver vazia, entao nao encontrou
    result := false;

  if VprAcao and result then  // se achou carrega os dados das variaveis do parametro
  begin
    VpaDProdutoOrcado.SeqProduto:= CadProdutosI_SEQ_PRO.AsInteger;
    VpaDProdutoOrcado.CodProduto := CadProdutos.fieldbyname(varia.CodigoProduto).AsString;
    VpaDProdutoOrcado.NomProduto := CadProdutosC_NOM_PRO.AsString;
    VpaDProdutoOrcado.DesUM := CadProdutosC_COD_UNI.AsString;
    VpaDProdutoOrcado.ValUnitario := CadProdutosN_VLR_VEN.AsFloat;
    VpaDProdutoOrcado.Quantidade:= 1;
  end;
  CadProdutos.close;
end;

{******************************************************************************}
function TFlocalizaProduto.LocalizaProduto(VpaDProdutoAdicional : TRBDPropostaVendaAdicional):boolean;
begin
  AtualizaConsulta;
  ShowModal;
  Result:= VprAcao;
  if CadProdutos.IsEmpty then
    Result:= False;
  if VprAcao and Result then
  begin
    VpaDProdutoAdicional.SeqProduto:= CadProdutosI_SEQ_PRO.AsInteger;
    VpaDProdutoAdicional.CodProduto:= CadProdutosC_COD_PRO.AsString;
    VpaDProdutoAdicional.NomProduto:= CadProdutosC_NOM_PRO.AsString;
    VpaDProdutoAdicional.UMOriginal := CadProdutosC_COD_UNI.AsString;
    VpaDProdutoAdicional.DesUM := CadProdutosC_COD_UNI.AsString;
    VpaDProdutoAdicional.UMAnterior := VpaDProdutoAdicional.DesUM;
    VpaDProdutoAdicional.ValUnitarioOriginal := CadProdutosN_VLR_VEN.AsFloat;
    VpaDProdutoAdicional.ValUnitario := CadProdutosN_VLR_VEN.AsFloat;
    VpaDProdutoAdicional.QtdProduto := 1;
  end;
  CadProdutos.close;
end;

{******************************************************************************}
procedure TFlocalizaProduto.BFecharClick(Sender: TObject);
begin
  Varia.ProdutoFiltro := ENomeProduto.Text;
  VprAcao := DadosProdutosValidos;
  if VprAcao then
    self.close;
end;

{******************************************************************************}
procedure TFlocalizaProduto.BitBtn1Click(Sender: TObject);
begin
  VprAcao := false;
  self.close;
end;

{******************************************************************************}
procedure TFlocalizaProduto.CadProdutosAfterScroll(DataSet: TDataSet);
begin
  if CadProdutosC_KIT_PRO.AsString = 'K' then
    bkit.Enabled := true
  else
    bkit.Enabled := false;
end;

{******************************************************************************}
procedure TFlocalizaProduto.BCadastrarClick(Sender: TObject);
begin
  FNovoProdutoPro := TFNovoProdutoPro.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoProdutoPro'));
  FNovoProdutoPro.NovoProduto('');
  FNovoProdutoPro.free;
end;

procedure TFlocalizaProduto.EClassificacaoProdutoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    40 :
      begin
        GProdutos.setfocus;
        CadProdutos.next;
      end;
    Vk_Up :
      begin
        GProdutos.setfocus;
        CadProdutos.Prior;
      end;
    14 :
         if TComponent(Sender).Name = 'EClassificacaoProduto' then
           LocalizaClassificacao;
  end;
  if Key = 13 then
     AtualizaConsulta;
end;

procedure TFlocalizaProduto.ENomeProdutoEnter(Sender: TObject);
begin
  BFechar.Default := false;
  VprNomProduto := ENomeProduto.Text;
  VprSumula :=ESumula.text;
end;

{******************************************************************************}
procedure TFlocalizaProduto.BBAjudaClick(Sender: TObject);
begin
end;

{******************************************************************************}
procedure TFlocalizaProduto.EClienteFimConsulta(Sender: TObject);
begin
  if Visible then
    AtualizaConsulta;
end;

{******************************************************************************}
procedure TFlocalizaProduto.CadProdutosCalcFields(DataSet: TDataSet);
begin
  if config.Farmacia then
  begin
    if CadProdutosC_IND_GEN.AsString = 'T' then
      CadProdutosGenerico.AsString := 'GENÉRICO'
    else
      CadProdutosGenerico.Clear;
    CadProdutosPrincipioAtivo.AsString := FunProdutos.RNomePrincipioAtivo(CadProdutosI_PRI_ATI.AsInteger);
  end;
end;

{******************************************************************************}
procedure TFlocalizaProduto.EClassificacaoProdutoExit(Sender: TObject);
var
 VpfNomeCla : string;
begin
  if VprCodClassificacao <> EClassificacaoProduto.Text then
  begin
    if not FunClassificacao.ValidaClassificacao(EClassificacaoProduto.text, VpfNomeCla, 'P') then
    begin
       if not LocalizaClassificacao then
         EClassificacaoProduto.SetFocus;
    end
    else
    begin
      label1.Caption := Vpfnomecla;
    end;
    AtualizaConsulta;
  end;
end;

{******************************************************************************}
procedure TFlocalizaProduto.SpeedButton1Click(Sender: TObject);
begin
  LocalizaClassificacao;
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFlocalizaProduto.BConsultarClick(Sender: TObject);
begin
  FNovoProdutoPro := TFNovoProdutoPro.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoProdutoPro'));
  FNovoProdutoPro.ConsultarProduto(varia.codigoEmpresa,varia.CodigoEmpFil,CadProdutosI_SEQ_PRO.AsInteger);
  FNovoProdutoPro.free;

end;

{******************************************************************************}
procedure TFlocalizaProduto.EClassificacaoProdutoEnter(Sender: TObject);
begin
  VprCodClassificacao := EClassificacaoProduto.Text;
end;

{******************************************************************************}
procedure TFlocalizaProduto.ENomeProdutoExit(Sender: TObject);
begin
  if ENomeProduto.Text <> VprNomProduto then
  begin
    AtualizaConsulta;
  end;
  BFechar.Default := true;
end;

procedure TFlocalizaProduto.ERefClienteExit(Sender: TObject);
begin
  AtualizaConsulta;
  BFechar.Default := true;
end;

{******************************************************************************}
procedure TFlocalizaProduto.ECodigoEnter(Sender: TObject);
begin
  BFechar.Default := false;
  VprCodProduto := ECodigo.Text;
end;

{******************************************************************************}
procedure TFlocalizaProduto.ECodigoExit(Sender: TObject);
begin
  if ECodigo.Text <> VprCodProduto then
    AtualizaConsulta;
  BFechar.Default := true;
end;

{******************************************************************************}
procedure TFlocalizaProduto.ESumulaExit(Sender: TObject);
begin
  if ESumula.Text <> VprSumula then
    AtualizaConsulta;
  BFechar.Default := true;
end;

{******************************************************************************}
procedure TFlocalizaProduto.ETabelaPrecoSelect(Sender: TObject);
begin
  ETabelaPreco.ASelectValida.Text := 'Select * from CADTABELAPRECO '+
                                     ' Where I_COD_EMP = '+InttoStr(varia.CodigoEmpresa)+
                                     ' and I_COD_TAB = @';
  ETabelaPreco.ASelectLocaliza.Text := 'Select * from CADTABELAPRECO '+
                                     ' Where I_COD_EMP = '+InttoStr(varia.CodigoEmpresa)+
                                     ' and C_NOM_TAB Like ''@%''';
end;

{******************************************************************************}
procedure TFlocalizaProduto.BAlterarClick(Sender: TObject);
begin
  FNovoProdutoPro := TFNovoProdutoPro.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoProdutoPro'));
  if FNovoProdutoPro.AlterarProduto(varia.codigoEmpresa,varia.CodigoEmpFil,CadProdutosI_SEQ_PRO.AsInteger) <> nil then
    AtualizaConsulta(true);
  FNovoProdutoPro.free;
end;

{******************************************************************************}
procedure TFlocalizaProduto.EImpressoraRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
    VprSeqImpressora := StrToInt(Retorno1)
  else
    VprSeqImpressora := 0;
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFlocalizaProduto.EImpressoraExit(Sender: TObject);
begin
  AtualizaConsulta;
  BFechar.Default := true;
end;

{******************************************************************************}
procedure TFlocalizaProduto.EImpressoraEnter(Sender: TObject);
begin
  BFechar.Default := false;
end;

{******************************************************************************}
procedure TFlocalizaProduto.ECodigoReduzidoExit(Sender: TObject);
begin
  AtualizaConsulta;
  BFechar.Default := true;
end;

{******************************************************************************}
procedure TFlocalizaProduto.SpeedButton6Click(Sender: TObject);
begin
  if VprSeqImpressora <> 0 then
  begin
    FNovoProdutoPro := TFNovoProdutoPro.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoProdutoPro'));
    FNovoProdutoPro.ConsultarProduto(varia.codigoEmpresa,varia.CodigoEmpFil,VprSeqImpressora);
    FNovoProdutoPro.free;
  end;
end;


procedure TFlocalizaProduto.ESeqProdutoEnter(Sender: TObject);
begin
  BFechar.Default := false;
  VprSeqProduto := ESeqProduto.Text;
end;

procedure TFlocalizaProduto.ESeqProdutoExit(Sender: TObject);
begin
  if ESeqProduto.Text <> VprSeqProduto then
    AtualizaConsulta;
  BFechar.Default := true;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFlocalizaProduto]);
end.



