unit AConfigImpNotaFiscal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, PainelGradiente, ComCtrls, StdCtrls, Buttons, Componentes1,
  Mask, numericos, Grids, DBGrids, Tabela, Db, DBTables, DBKeyViolation,
  DBCtrls, BotaoCadastro, UnImpressao, Geradores, SQLExpr,
  Localizacao, DBClient;

type
  TFConfigImpNotaFiscal = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    DocPage: TPageControl;
    CAD_DOC: TSQL;
    DATA_CAD_DOC: TDataSource;
    DATA_MOV_DOC: TDataSource;
    Label35: TLabel;
    PanelColor4: TPanelColor;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    GMov: TGridIndice;
    ERodDoc: TDBEditColor;
    ECabPag: TDBEditColor;
    GDoc: TGridIndice;
    PanelColor2: TPanelColor;
    BFechar: TBitBtn;
    BCadastrar: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    BExemplo: TBitBtn;
    BitBtn5: TBitBtn;
    CPadrao: TDBLookupComboBoxColor;
    DBRadioGroup1: TDBRadioGroup;
    DATACAD_DRIVER_AUX: TDataSource;
    Label5: TLabel;
    DBEditColor2: TDBEditColor;
    Label7: TLabel;
    DBEditColor3: TDBEditColor;
    BitBtn2: TBitBtn;
    PTempo: TPainelTempo;
    Label4: TLabel;
    DBEditColor4: TDBEditColor;
    RNota: TRadioButton;
    RServ: TRadioButton;
    Label6: TLabel;
    DBEditColor1: TDBEditColor;
    Label8: TLabel;
    DBEditColor5: TDBEditColor;
    ETeste: TEditColor;
    Label9: TLabel;
    Label10: TLabel;
    DBEditColor6: TDBEditColor;
    MOV_DOC: TSQL;
    MOV_DOCI_NRO_DOC: TFMTBCDField;
    MOV_DOCI_MOV_SEQ: TFMTBCDField;
    MOV_DOCN_POS_HOR: TFMTBCDField;
    MOV_DOCN_POS_VER: TFMTBCDField;
    MOV_DOCC_FLA_IMP: TWideStringField;
    MOV_DOCC_DES_CAM: TWideStringField;
    MOV_DOCC_DIR_ESQ: TWideStringField;
    MOV_DOCI_TAM_CAM: TFMTBCDField;
    MOV_DOCC_FLA_NEG: TWideStringField;
    MOV_DOCC_FLA_ITA: TWideStringField;
    MOV_DOCC_FLA_CND: TWideStringField;
    MOV_DOCC_FLA_RED: TWideStringField;
    MOV_DOCD_ULT_ALT: TSQLTimeStampField;
    CAD_DRIVER_AUX: TSQL;
    Aux: TSQL;
    CAD_DOCI_NRO_DOC: TFMTBCDField;
    CAD_DOCC_NOM_DOC: TWideStringField;
    CAD_DOCC_TIP_DOC: TWideStringField;
    CAD_DOCD_DAT_DOC: TSQLTimeStampField;
    CAD_DOCC_FLA_EXT: TWideStringField;
    CAD_DOCN_CAB_PAG: TFMTBCDField;
    CAD_DOCN_ROD_DOC: TFMTBCDField;
    CAD_DOCI_QTD_PAG: TFMTBCDField;
    CAD_DOCC_CHR_DIR: TWideStringField;
    CAD_DOCC_CHR_ESQ: TWideStringField;
    CAD_DOCC_FLA_MAT: TWideStringField;
    CAD_DOCN_MRG_ESQ: TFMTBCDField;
    CAD_DOCI_SEQ_IMP: TFMTBCDField;
    CAD_DOCC_FLA_LIN: TWideStringField;
    CAD_DOCC_FLA_PAP: TWideStringField;
    CAD_DOCC_FLA_COP: TWideStringField;
    CAD_DOCI_QTD_LIN: TFMTBCDField;
    CAD_DOCI_QTD_FAT: TFMTBCDField;
    CAD_DOCI_QTD_COL: TFMTBCDField;
    CAD_DOCI_QTD_ADI: TFMTBCDField;
    CAD_DOCI_QTD_SER: TFMTBCDField;
    CAD_DOCN_ALT_ETI: TFMTBCDField;
    CAD_DOCN_COM_ETI: TFMTBCDField;
    CAD_DOCN_ESP_VER: TFMTBCDField;
    CAD_DOCN_ESP_HOR: TFMTBCDField;
    CAD_DOCN_MAR_ESQ: TFMTBCDField;
    CAD_DOCN_MAR_SUP: TFMTBCDField;
    CAD_DOCN_MAR_INF: TFMTBCDField;
    CAD_DOCN_LIN_ETI: TFMTBCDField;
    CAD_DOCN_COL_ETI: TFMTBCDField;
    CAD_DOCI_TAM_BAR: TFMTBCDField;
    CAD_DOCI_ALT_BAR: TFMTBCDField;
    CAD_DOCI_COD_BAR: TFMTBCDField;
    CAD_DOCN_MAR_DIR: TFMTBCDField;
    CAD_DOCC_IMP_COD: TWideStringField;
    CAD_DOCN_DIV_CUS: TFMTBCDField;
    CAD_DOCC_CRI_DAT: TWideStringField;
    CAD_DOCI_MAX_ITE: TFMTBCDField;
    CAD_DOCC_FLA_FOR: TWideStringField;
    CAD_DOCI_QTD_OBS: TFMTBCDField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure CAD_DOCAfterInsert(DataSet: TDataSet);
    procedure CAD_DOCBeforePost(DataSet: TDataSet);
    procedure CAD_DOCAfterPost(DataSet: TDataSet);
    procedure CAD_DOCAfterScroll(DataSet: TDataSet);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BCadastrarClick(Sender: TObject);
    procedure CAD_DOCBeforeEdit(DataSet: TDataSet);
    procedure SetText_SN(Sender: TField; const Text: String);
    procedure MOV_DOCBeforeInsert(DataSet: TDataSet);
    procedure MOV_DOCBeforeDelete(DataSet: TDataSet);
    procedure SetText_DE(Sender: TField; const Text: String);
    procedure Negativo_keyPress(Sender: TObject; var Key: Char);
    procedure MOV_DOCBeforePost(DataSet: TDataSet);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure RNotaClick(Sender: TObject);
    procedure DBEditColor2Exit(Sender: TObject);
  private
    { Private declarations }
    IMP : TFuncoesImpressao;
    VprTransacao : TTransactionDesc;
    procedure InicializaItens(NroDoc: Integer);
    procedure MudaEstado( acao : Boolean );
  public
    { Public declarations }
  end;

var
  FConfigImpNotaFiscal: TFConfigImpNotaFiscal;

implementation

uses APrincipal, Constantes, FunSql, ConstMsg, FunString, UnClassesImprimir;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFConfigImpNotaFiscal.FormCreate(Sender: TObject);
begin
  IMP := TFuncoesImpressao.Criar(self,FPrincipal.BaseDados);
  IMP.LocalizaTipoDocumento(CAD_DOC, 'NFP');
  AdicionaSQLAbreTabela(CAD_DRIVER_AUX, ' SELECT * FROM CAD_DRIVER ' + ' WHERE I_COD_DRV IS NULL '); // Somente Impresoras.
  CPadrao.KeyValue := CAD_DRIVER_AUX.FieldByName('I_SEQ_IMP').AsInteger;
  RServ.Enabled := ConfigModulos.Servico;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFConfigImpNotaFiscal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if FPrincipal.BaseDados.InTransaction then
  begin
    if Confirmacao('Deseja gravar as alterações efetuadas ?') then
      FPrincipal.BaseDados.Commit(VprTransacao)
    else
      FPrincipal.BaseDados.Rollback(VprTransacao);
  end;
  IMP.Destroy;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                            Codigo de Barra
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

procedure TFConfigImpNotaFiscal.BFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFConfigImpNotaFiscal.CAD_DOCAfterInsert(DataSet: TDataSet);
begin
  CAD_DOCI_NRO_DOC.Asinteger := Imp.RNroDocDisponivel;
  CAD_DOCC_CHR_ESQ.AsString := '('; // Caracter Direita.
  CAD_DOCC_CHR_DIR.AsString := ')'; // Caracter Esquerda.
  CAD_DOCC_FLA_PAP.AsString := 'S'; // Detecção de papel ativada.
  CAD_DOCC_FLA_LIN.AsString := 'S'; // linha reduzida.
  CAD_DOCC_FLA_PAP.AsString := 'N'; // Normal.
  CAD_DOCC_FLA_EXT.AsString := 'N'; // Mês Extenso.
  CAD_DOCC_FLA_COP.AsString := 'N'; // Documento original.
  CAD_DOCD_DAT_DOC.AsDateTime := Date;
  CAD_DOCN_CAB_PAG.AsFloat := 0;
  CAD_DOCN_ROD_DOC.AsFloat := 0;
  CAD_DOCI_QTD_PAG.AsInteger := 1;
  CAD_DOCI_QTD_LIN.AsInteger := 15;
  CAD_DOCI_QTD_COL.AsInteger := 2;
  CAD_DOCI_QTD_FAT.AsInteger := 3;
  CAD_DOCI_QTD_ADI.AsInteger := 5;
  CAD_DOCI_QTD_SER.AsInteger := 3;
end;

{******************************************************************************}
procedure TFConfigImpNotaFiscal.InicializaItens(NroDoc: Integer);
var
  diminui : Integer;
begin
   if RServ.Checked then
     diminui := 0
   else
    diminui :=  0; // diminui :=  7;
            //             N  col   lin  tam
  IMP.InsereMovDoc(NroDoc, 01, 76,  001,  08, 'S', 'Número da Nota Fiscal', 'E', 'N', 'S' );
  IMP.InsereMovDoc(NroDoc, 02, 64,  001,  01, 'S', 'X do Campo de Entrada', 'E', 'N', 'N' );
  IMP.InsereMovDoc(NroDoc, 03, 58,  001,  01, 'S', 'X do Campo de Saída', 'E', 'N', 'N' );
  IMP.InsereMovDoc(NroDoc, 04, 04,  007,  40, 'S', 'Natureza da Operação', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 05, 55,  007,  05, 'S', 'CFOP', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 06, 70,  100,  20, 'N', 'Inscrição Estadual do Subst. Tributário', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 07, 04,  011,  60, 'S', 'Nome / Razão Social', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 08, 107, 011,  20, 'S', 'CGC / CPF', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 09, 147, 011,  10, 'S', 'Data de Emissão da Nota Fiscal', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 10, 05,  013,  50, 'S', 'Endereço', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 11, 87,  013,  30, 'S', 'Bairro / Distrito', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 12, 125, 013,  10, 'S', 'CEP', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 13, 147, 013,  10, 'S', 'Data da Saída / Entrada', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 14, 05,  016,  30, 'S', 'Município', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 15, 75,  016,  22, 'S', 'Fone / FAX', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 16, 101, 016,  02, 'S', 'UF', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 17, 115, 016,  15, 'S', 'Inscrição Estadual', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 18, 149, 016,  05, 'S', 'Hora de Saída', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 19, 13,  052 - diminui ,  15, 'S', 'Base de Cálculo do ICMS', 'D', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 20, 45,  052 - diminui ,  15, 'S', 'Valor do ICMS', 'D', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 21, 87,  052 - diminui ,  15, 'N', 'Base de Cálculo do ICMS Substituição', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 22, 105, 052 - diminui ,  15, 'N', 'Valor ICMS Substituição', 'D', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 23, 140, 052 - diminui ,  15, 'S', 'Valor Total dos Produtos', 'D', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 24, 13,  054 - diminui ,  15, 'S', 'Valor do Frete', 'D', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 25, 45,  054 - diminui ,  15, 'S', 'Valor do Seguro', 'D', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 26, 87,  054 - diminui ,  15, 'S', 'Outras Despesas Acessórias', 'D', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 27, 105,  054 - diminui ,  15, 'N', 'Valor Total do IPI', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 28, 140, 054 - diminui ,  15, 'S', 'Valor Total da Nota Fiscal', 'D', 'S', 'S');

  If RServ.Checked then
  begin
    IMP.InsereMovDoc(NroDoc, 29, 150, 055,  15, 'S', 'Nota com Serviços - Valor do ISSQN', 'E', 'S', 'S');
    IMP.InsereMovDoc(NroDoc, 30, 155, 057,   15, 'S', 'Nota com Serviços - Valor Total dos Serviços', 'E', 'S', 'S');
    IMP.InsereMovDoc(NroDoc, 75, 005, 054, 100, 'S', 'Serviços - Descrição dos serviços da Nota Fiscal.', 'E', 'S', 'S');
  end
  else
  begin
    IMP.InsereMovDoc(NroDoc, 29, 00, 100, 00, 'N', 'Valor do ISSQN', 'E', 'S', 'S');
    IMP.InsereMovDoc(NroDoc, 30, 00, 100, 00, 'N', 'Valor Total dos Serviços', 'E', 'S', 'S');
    IMP.InsereMovDoc(NroDoc, 75, 00, 100, 00, 'N', 'Serviços - Descrição dos serviços da Nota Fiscal.', 'E', 'S', 'S');
  end;

  IMP.InsereMovDoc(NroDoc, 31, 05,  059 - diminui ,  50, 'S', 'Nome da Transportadora', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 32, 97,  059 - diminui ,  01, 'S', 'Frete por Conta 1/2', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 33, 103, 059 - diminui ,  10, 'S', 'Placa do Veículo da Transportadora', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 34, 122, 059 - diminui ,  02, 'S', 'UF da Trasportadora', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 35, 130, 059 - diminui ,  15, 'S', 'CGC/ CPF da Transportadora', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 36, 05,  061 - diminui ,  30, 'S', 'Endereço da Transportadora', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 37, 85,  061 - diminui ,  30, 'S', 'Município da Transportadora', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 38, 122, 061 - diminui ,  02, 'S', 'UF do Endereço da Transportadora', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 39, 130, 061 - diminui ,  15, 'S', 'Inscrição Estadual da Transportadora', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 40, 05,  064 - diminui ,  15, 'S', 'Quantidade de Produtos', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 41, 25,  064 - diminui ,  15, 'S', 'Espécie', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 42, 68,  064 - diminui ,  15, 'S', 'Marca', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 43, 97,  064 - diminui ,  15, 'S', 'Número', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 44, 125, 064 - diminui ,  15, 'S', 'Peso Bruto', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 45, 145, 064 - diminui ,  15, 'S', 'Peso Líquido', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 46, 10,  068 - diminui ,  30, 'S', 'Condição de Pagamento', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 47, 51,  068 - diminui ,  30, 'S', 'Nome do Vendedor', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 48, 10,  069 - diminui ,  30, 'S', 'Classificação Fiscal', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 49, 02,  028,  10, 'S', 'Coluna - Código', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 50, 17,  028,  50, 'S', 'Coluna - Descrição do Produto', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 51, 77,  028,  03, 'S', 'Coluna - Classificação Fiscal do Produto', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 52, 75,  028,  03, 'S', 'Coluna - Situação Tributaria do Produto', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 53, 82, 028,  03, 'S', 'Coluna - Unidade de Medida do Produto', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 54, 90, 028,  10, 'S', 'Coluna - Quantidade do Produto', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 55, 104, 028,  15, 'S', 'Coluna - Valor Unitário do Produto', 'D', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 56, 126, 028,  15, 'S', 'Coluna - Valor Total do Produto', 'D', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 57, 147, 028,  02, 'S', 'Coluna - Perdentual de ICMS do Produto', 'D', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 58, 151, 028,  02, 'S', 'Coluna - Percentual de IPI do Produto', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 59, 155, 028,  10, 'S', 'Coluna - Produto_Valor_IPI', 'D', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 60, 05,  071 - diminui ,  70, 'S', 'Dados Adicionais', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 61, 04,  021,  15, 'S', 'Fatura 1 - Número da Fatura', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 62, 38,  021,  10, 'S', 'Fatura 1 - Vencimento da Fatura', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 63, 58,  021,  20, 'S', 'Fatura 1 - Valor da Fatura', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 64, 89,  021,  15, 'S', 'Fatura 2 - Número da Fatura', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 65, 122, 021,  10, 'S', 'Fatura 2 - Vencimento da Fatura,', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 66, 143, 021,  20, 'S', 'Fatura 2 - Valor da Fatura', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 67, 113,  022,  15, 'S', 'Fatura 3 - Número da Fatura', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 68, 151, 022,  10, 'S', 'Fatura 3 - Vencimento da Fatura,', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 69, 129, 022,  20, 'S', 'Fatura 3 - Valor da Fatura', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 70, 140, 100,  15, 'N', 'Fatura 4 - Número da Fatura', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 71, 150, 100,  10, 'N', 'Fatura 4 - Vencimento da Fatura,', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 72, 160, 100,  20, 'N', 'Fatura 4 - Valor da Fatura', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 73, 144, 080 - diminui ,  08, 'S', 'Número  do Rodapé da Nota Fiscal', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 74, 005, 044, 150, 'S', 'Observações dos Itens da Nota Fiscal.', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 76, 65, 080, 60, 'S', 'Nome Destinatario Canhoto', 'E', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 77, 05, 043, 40, 'S', 'Ordem de Compra', 'E', 'S', 'S');
  Imp.InsereMovDoc(NroDoc, 78, 05, 042, 40, 'S', 'Desconto / Acrescimo', 'E', 'S', 'S');
  Imp.InsereMovDoc(NroDoc, 79, 05, 049, 80, 'S', 'Dados Adicionais Nota Fiscal', 'E', 'S', 'S');
  Imp.InsereMovDoc(NroDoc, 80, 05, 044, 15, 'S', 'Valor Servicos ', 'D', 'S', 'S');
  Imp.InsereMovDoc(NroDoc, 81, 05, 100, 15, 'S', 'Numero cotacao Canhoto', 'E', 'S', 'S');
  Imp.InsereMovDoc(NroDoc, 82, 75, 30, 8, 'N', 'Percentual de ISSQN', 'E', 'S', 'S');
  Imp.InsereMovDoc(NroDoc, 83, 75, 100, 8, 'N', 'Endereço Filial', 'E', 'S', 'N');
  Imp.InsereMovDoc(NroDoc, 84, 75, 100, 8, 'N', 'Cep Filial', 'E', 'S', 'N');
  Imp.InsereMovDoc(NroDoc, 85, 75, 100, 8, 'N', 'Cidade Filial', 'E', 'S', 'N');
  Imp.InsereMovDoc(NroDoc, 86, 75, 100, 8, 'N', 'UF Filial', 'E', 'S', 'N');
  Imp.InsereMovDoc(NroDoc, 87, 75, 100, 8, 'N', 'Fone Filial', 'E', 'S', 'N');
  Imp.InsereMovDoc(NroDoc, 88, 75, 100, 8, 'N', 'CNPJ Filial', 'E', 'S', 'N');
  IMP.InsereMovDoc(NroDoc, 89, 100,29 ,  10, 'S', 'Servico - Qtd servico', 'D', 'S', 'S');
  IMP.InsereMovDoc(NroDoc, 90, 115,29 ,  10, 'S', 'Servico - Valor Total Item ', 'D', 'S', 'S');
  Imp.InsereMovDoc(NroDoc, 91, 75, 1, 11, 'N', 'Numero da Folha', 'E', 'N', 'N');
  AtualizaSQLTabela(MOV_DOC);
end;

procedure TFConfigImpNotaFiscal.CAD_DOCBeforePost(DataSet: TDataSet);
begin
  if (CPadrao.Text = '') then
  begin
    Aviso('Informe a Impressora Padrão.');
    CPadrao.SetFocus;
    Abort;
  end;
end;

procedure TFConfigImpNotaFiscal.CAD_DOCAfterPost(DataSet: TDataSet);
begin
  AtualizaSQLTabela(CAD_DOC);
  CAD_DOC.Last;
  IMP.LocalizaItems(MOV_DOC, CAD_DOCI_NRO_DOC.AsInteger);
end;

procedure TFConfigImpNotaFiscal.CAD_DOCAfterScroll(DataSet: TDataSet);
begin
  BExemplo.Enabled := not CAD_DOC.EOF;
  if CAD_DOC.EOF then
    FechaTabela(MOV_DOC)
  else
    IMP.LocalizaItems(MOV_DOC, CAD_DOCI_NRO_DOC.AsInteger);
end;  

procedure TFConfigImpNotaFiscal.BitBtn1Click(Sender: TObject);
begin
  try
    if MOV_DOC.State in [dsInsert, dsEdit] then
      MOV_DOC.Post;
    if CAD_DOC.State in [dsInsert, dsEdit] then
      CAD_DOC.Post;
  except
   if FPrincipal.BaseDados.InTransaction then
    FPrincipal.BaseDados.Rollback(VprTransacao);
  end;
  if FPrincipal.BaseDados.InTransaction then
  begin
    FPrincipal.BaseDados.Commit(VprTransacao);
    AtualizaSQLTabela(CAD_DOC);
  end;
  MudaEstado(true);
  DATA_CAD_DOC.AutoEdit := false;
  DATA_MOV_DOC.AutoEdit := false;
end;

procedure TFConfigImpNotaFiscal.BitBtn3Click(Sender: TObject);
begin
   if MOV_DOC.State in [dsInsert, dsEdit] then
    MOV_DOC.Cancel;
  if CAD_DOC.State in [dsInsert, dsEdit] then
    CAD_DOC.cancel;
  if FPrincipal.BaseDados.InTransaction then
  begin
    FPrincipal.BaseDados.Rollback(VprTransacao);
    AtualizaSQLTabela(CAD_DOC);
  end;
  MudaEstado(true);
  DATA_CAD_DOC.AutoEdit := false;
  DATA_MOV_DOC.AutoEdit := false;
end;

procedure TFConfigImpNotaFiscal.BitBtn4Click(Sender: TObject);
begin
  if Confirmacao('EXCLUSÃO DOCUMENTO - Deseja realmente excluir o registo "' +
    CAD_DOCC_NOM_DOC.AsString + '" ?') then
  begin
    if not FPrincipal.BaseDados.InTransaction then
    begin
      VprTransacao.IsolationLevel := xilREADCOMMITTED;
      FPrincipal.BaseDados.StartTransaction(VprTransacao);
    end;
    IMP.DeletaCabItems(CAD_DOCI_NRO_DOC.AsInteger);
    AtualizaSQLTabela(CAD_DOC);
  end;
end;

procedure TFConfigImpNotaFiscal.BCadastrarClick(Sender: TObject);
var
  VpfNomeModelo: string;
begin
  if not FPrincipal.BaseDados.InTransaction  then
  begin
    VprTransacao.IsolationLevel := xilREADCOMMITTED;
    FPrincipal.BaseDados.StartTransaction(VprTransacao);
  end;
  MudaEstado(false);
  if MOV_DOC.State in [dsInsert, dsEdit] then
    MOV_DOC.Post;
  if CAD_DOC.State in [dsInsert, dsEdit] then
    CAD_DOC.Post;
  if Entrada( 'Novo Documento',
             'Digite o nome do novo modelo de Nota Fiscal a incluir: ',
             VpfNomeModelo, False, clWhite, clBtnFace) then
  begin
    if (VpfNomeModelo <> '') then
    begin
      if not FPrincipal.BaseDados.InTransaction then
      begin
        VprTransacao.IsolationLevel := xilREADCOMMITTED;
        FPrincipal.BaseDados.StartTransaction(VprTransacao);
      end;
      CAD_DOC.Insert;
      CAD_DOCC_NOM_DOC.AsString := VpfNomeModelo;
      if RNota.Checked then
        CAD_DOCC_TIP_DOC.AsString := 'NFP'
      else
      if RServ.Checked then
        CAD_DOCC_TIP_DOC.AsString := 'NFS';
      CAD_DOCI_SEQ_IMP.ASInteger := CAD_DRIVER_AUX.FieldByName('I_SEQ_IMP').AsInteger;
      CAD_DOC.Post;
      InicializaItens(CAD_DOCI_NRO_DOC.AsInteger);
      ECabPag.SetFocus;
    end;
  end
  else
  begin
    if FPrincipal.BaseDados.InTransaction  then
     FPrincipal.BaseDados.Rollback(VprTransacao);
     MudaEstado(true);
     DATA_CAD_DOC.AutoEdit := false;
     DATA_MOV_DOC.AutoEdit := false;
  end;
  if FPrincipal.BaseDados.InTransaction  then
    FPrincipal.BaseDados.Commit(VprTransacao);
end;

procedure TFConfigImpNotaFiscal.CAD_DOCBeforeEdit(DataSet: TDataSet);
begin
  if not FPrincipal.BaseDados.InTransaction then
  begin
    VprTransacao.IsolationLevel := xilREADCOMMITTED;
    FPrincipal.BaseDados.StartTransaction(VprTransacao);
  end;
end;

procedure TFConfigImpNotaFiscal.SetText_SN(Sender: TField;
  const Text: String);
begin
  if (text = 's') or (text =  'S' ) then
    sender.Value := 'S';
  if (text = 'n') or (text =  'N' ) then
    sender.Value := 'N';
end;

procedure TFConfigImpNotaFiscal.MOV_DOCBeforeInsert(DataSet: TDataSet);
begin
  Abort;
end;

procedure TFConfigImpNotaFiscal.MOV_DOCBeforeDelete(DataSet: TDataSet);
begin
  Abort;
end;

procedure TFConfigImpNotaFiscal.SetText_DE(Sender: TField;
  const Text: String);
begin
  if (text = 'd') or (text =  'D' ) then
    sender.Value := 'D';
  if (text = 'e') or (text =  'E' ) then
    sender.Value := 'E';
end;

procedure TFConfigImpNotaFiscal.Negativo_keyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = '-' then
   Key := '#';
end;

procedure TFConfigImpNotaFiscal.MOV_DOCBeforePost(DataSet: TDataSet);
begin
  // Se for condensado não pode ser negrito.
  if ((MOV_DOCC_FLA_CND.AsString = 'S') and (MOV_DOCC_FLA_NEG.AsString = 'S')) then
  begin
    MOV_DOCC_FLA_NEG.AsString := 'N';
    Aviso('O Campo não pode ser NEGRITO  e CONDENSADO ao mesmo tempo.');
  end;
end;

//////////////// Impressão de Comandos. //////////////////////

procedure TFConfigImpNotaFiscal.BitBtn5Click(Sender: TObject);
begin
  if not FPrincipal.BaseDados.InTransaction  then
  begin
    VprTransacao.IsolationLevel := xilREADCOMMITTED;
    FPrincipal.BaseDados.StartTransaction(VprTransacao);
  end;
  DATA_CAD_DOC.AutoEdit := true;
  DATA_MOV_DOC.AutoEdit := true;
  MudaEstado(false);
end;

{ ****************** Muda os estados dos Botoes **************************** }
procedure TFConfigImpNotaFiscal.MudaEstado( acao : Boolean );
begin
  BCadastrar.Enabled := acao;
  BitBtn5.Enabled := acao;
  BitBtn4.Enabled := acao;
  BitBtn1.Enabled := not acao;
  BitBtn3.Enabled := not  acao;
  BExemplo.Enabled := acao;
  BFechar.Enabled := acao;
end;


procedure TFConfigImpNotaFiscal.BitBtn2Click(Sender: TObject);
var
  VpfProximoCodigo, I: Integer;
  VpfNomeModelo: string;
begin
  if not FPrincipal.BaseDados.InTransaction  then
  begin
    VprTransacao.IsolationLevel := xilREADCOMMITTED;
    FPrincipal.BaseDados.StartTransaction(VprTransacao);
  end;
  if MOV_DOC.State in [dsInsert, dsEdit] then
    MOV_DOC.Post;
  if CAD_DOC.State in [dsInsert, dsEdit] then
    CAD_DOC.Post;
  VpfNomeModelo := 'MODELO - ' + CAD_DOCC_NOM_DOC.AsString;
  if Entrada( 'Novo Documento',
             'Digite o nome da nova cópia de modelo da Nota Fiscal selecionada : ',
             VpfNomeModelo, False, clWhite, clBtnFace) then
  begin
    if (VpfNomeModelo <> '') then
    begin
      PTempo.Execute('Criando Modelo ...');
      if not FPrincipal.BaseDados.InTransaction then
      begin
        VprTransacao.IsolationLevel := xilREADCOMMITTED;
        FPrincipal.BaseDados.StartTransaction(VprTransacao);
      end;
      AdicionaSQLAbreTabela(AUX, ' SELECT * FROM CAD_DOC ');
      AUX.Insert;
      // Tabela pai.
      for I:=0 to (CAD_DOC.FieldCount - 1) do
        AUX.FieldByName(CAD_DOC.Fields[I].FieldName).Value := CAD_DOC.Fields[I].Value;
      VpfProximoCodigo := imp.RNroDocDisponivel;
      AUX.FieldByName('I_NRO_DOC').AsInteger := VpfProximoCodigo;
      AUX.FieldByName('C_NOM_DOC').AsString := VpfNomeModelo;
      AUX.Post;
      // Tabela Filha;
      AdicionaSQLAbreTabela(AUX, ' SELECT * FROM MOV_DOC ');
      MOV_DOC.DisableControls;
      MOV_DOC.First;
      while not MOV_DOC.EOF do
      begin
        AUX.Insert;
        // Tabela pai.
        for I:=0 to (MOV_DOC.FieldCount - 1) do
          AUX.FieldByName(MOV_DOC.Fields[I].FieldName).Value := MOV_DOC.Fields[I].Value;
        AUX.FieldByName('I_NRO_DOC').AsInteger := VpfProximoCodigo;
        AUX.Post;
        MOV_DOC.Next;
      end;
      MOV_DOC.EnableControls;
      AtualizaSQLTabela(CAD_DOC);
      PTempo.Fecha;
    end;
  end
  else
  begin
    if FPrincipal.BaseDados.InTransaction  then
     FPrincipal.BaseDados.Rollback(VprTransacao);
  end;
  if FPrincipal.BaseDados.InTransaction  then
    FPrincipal.BaseDados.Commit(VprTransacao);
end;

procedure TFConfigImpNotaFiscal.RNotaClick(Sender: TObject);
begin
  if not (CAD_DOC.State in [dsInsert, dsEdit]) then
  begin
    if RNota.Checked then
     IMP.LocalizaTipoDocumento(CAD_DOC, 'NFP')
    else
    if RServ.Checked then
     IMP.LocalizaTipoDocumento(CAD_DOC, 'NFS');
  end;
end;

procedure TFConfigImpNotaFiscal.DBEditColor2Exit(Sender: TObject);
begin
  if (sender is TDBEditColor) then
  begin
    if (sender as TDBEditColor).Text <> '' then
    begin
      if StrToInt((sender as TDBEditColor).Text) = 0 then
        (sender as TDBEditColor).SetFocus;
    end
    else
      (sender as TDBEditColor).SetFocus;
  end;
end;


Initialization
  RegisterClasses([TFConfigImpNotaFiscal]);
end.


