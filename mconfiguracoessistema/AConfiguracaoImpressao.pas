unit AConfiguracaoImpressao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, PainelGradiente, ComCtrls, StdCtrls, Buttons, Componentes1,
  Mask, numericos, Grids, DBGrids, Tabela, Db, DBTables, DBKeyViolation,
  DBCtrls, BotaoCadastro, UnImpressao, Geradores,
  Localizacao, DBClient, SQLExpr;

type
  TFConfiguraImpressao = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    DocPage: TPageControl;
    DocTab: TTabSheet;
    CAD_DOC: TSQL;
    DATA_CAD_DOC: TDataSource;
    CAD_DOCI_NRO_DOC: TFMTBCDField;
    CAD_DOCC_NOM_DOC: TWideStringField;
    CAD_DOCC_TIP_DOC: TWideStringField;
    CAD_DOCD_DAT_DOC: TSQLTimeStampField;
    CAD_DOCN_ROD_DOC: TFMTBCDField;
    MOV_DOC: TSQL;
    DATA_MOV_DOC: TDataSource;
    MOV_DOCI_NRO_DOC: TFMTBCDField;
    MOV_DOCI_MOV_SEQ: TFMTBCDField;
    MOV_DOCN_POS_HOR: TFMTBCDField;
    MOV_DOCN_POS_VER: TFMTBCDField;
    MOV_DOCC_FLA_IMP: TWideStringField;
    MOV_DOCC_DES_CAM: TWideStringField;
    PanelColor4: TPanelColor;
    GMov: TGridIndice;
    EQtdDoc: TDBEditColor;
    Label5: TLabel;
    ERodDoc: TDBEditColor;
    Label3: TLabel;
    Label2: TLabel;
    ECabPag: TDBEditColor;
    GDoc: TGridIndice;
    MOV_DOCC_DIR_ESQ: TWideStringField;
    CAD_DOCC_CHR_DIR: TWideStringField;
    CAD_DOCC_CHR_ESQ: TWideStringField;
    CAD_DOCN_CAB_PAG: TFMTBCDField;
    CAD_DOCI_QTD_PAG: TFMTBCDField;
    MOV_DOCI_TAM_CAM: TFMTBCDField;
    Label7: TLabel;
    DBEditColor3: TDBEditColor;
    DBEditColor4: TDBEditColor;
    Label8: TLabel;
    RTipoDocumento: TRadioGroup;
    Label1: TLabel;
    PanelColor2: TPanelColor;
    BFechar: TBitBtn;
    BCadastrar: TBitBtn;
    BExcluir: TBitBtn;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    BExemplo: TBitBtn;
    CAD_DOCI_SEQ_IMP: TFMTBCDField;
    CAD_DOCC_FLA_EXT: TWideStringField;
    CAD_DRIVER_AUX: TSQL;
    DATACAD_DRIVER_AUX: TDataSource;
    CPadrao: TDBLookupComboBoxColor;
    MOV_DOCC_FLA_NEG: TWideStringField;
    MOV_DOCC_FLA_ITA: TWideStringField;
    MOV_DOCC_FLA_CND: TWideStringField;
    MOV_DOCC_FLA_RED: TWideStringField;
    DBRadioGroup1: TDBRadioGroup;
    CAD_DOCC_FLA_LIN: TWideStringField;
    CAD_DOCC_FLA_PAP: TWideStringField;
    DBRadioGroup2: TDBRadioGroup;
    DMes: TDBRadioGroup;
    ETeste: TEditColor;
    Label4: TLabel;
    CAD_DOCC_FLA_COP: TWideStringField;
    Copia: TDBRadioGroup;
    Label35: TLabel;
    BAlterar: TBitBtn;
    AUX: TQuery;
    PTempo: TPainelTempo;
    BModelo: TBitBtn;
    CAD_DOCI_MAX_ITE: TFMTBCDField;
    Label6: TLabel;
    DBEditColor1: TDBEditColor;
    DBRadioGroup3: TDBRadioGroup;
    CAD_DOCC_FLA_FOR: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure DocPageChange(Sender: TObject);
    procedure CAD_DOCAfterInsert(DataSet: TDataSet);
    procedure CAD_DOCBeforePost(DataSet: TDataSet);
    procedure CAD_DOCAfterPost(DataSet: TDataSet);
    procedure CAD_DOCAfterScroll(DataSet: TDataSet);
    procedure BGravarClick(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure BExcluirClick(Sender: TObject);
    procedure BCadastrarClick(Sender: TObject);
    procedure CAD_DOCBeforeEdit(DataSet: TDataSet);
    procedure SetText_SN(Sender: TField; const Text: String);
    procedure MOV_DOCBeforeInsert(DataSet: TDataSet);
    procedure MOV_DOCBeforeDelete(DataSet: TDataSet);
    procedure BExemploClick(Sender: TObject);
    procedure SetText_DE(Sender: TField; const Text: String);
    procedure Negativo_keyPress(Sender: TObject; var Key: Char);
    procedure RTipoDocumentoClick(Sender: TObject);
    procedure MOV_DOCBeforePost(DataSet: TDataSet);
    procedure BBAjudaClick(Sender: TObject);
    procedure BAlterarClick(Sender: TObject);
    procedure BModeloClick(Sender: TObject);
  private
    { Private declarations }
    IMP : TFuncoesImpressao;
    TestoImp : string;
    VprTransacao : TTransactionDesc;
    procedure InicializaItens(NroDoc: Integer);
    procedure MudaEstado( acao : Boolean );
  public
    { Public declarations }
  end;

var
  FConfiguraImpressao: TFConfiguraImpressao;

implementation

uses APrincipal, Constantes, FunSql, ConstMsg, FunString, UnClassesImprimir;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFConfiguraImpressao.FormCreate(Sender: TObject);
begin
  IMP := TFuncoesImpressao.Criar(self,FPrincipal.BaseDados);
  DocPage.ActivePage := DocTab;
  DocPageChange(Self);
  IMP.LocalizaTipoDocumento(CAD_DOC, 'NOT');

  Label6.Visible       := RTipoDocumento.ItemIndex = 7;
  DBEditColor1.Visible := RTipoDocumento.ItemIndex = 7;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFConfiguraImpressao.FormClose(Sender: TObject; var Action: TCloseAction);
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


{**************** fecha formulario ****************************************** }
procedure TFConfiguraImpressao.BFecharClick(Sender: TObject);
begin
  Close;
end;


procedure TFConfiguraImpressao.DocPageChange(Sender: TObject);
var
  VpfTipo: string;
begin
  case DocPage.ActivePage.PageIndex of
    00 : begin
           AdicionaSQLAbreTabela(CAD_DRIVER_AUX,
             ' SELECT * FROM CAD_DRIVER ' +
             ' WHERE I_COD_DRV IS NULL '); // Somente Impresoras.
           case RTipoDocumento.ItemIndex of
             00 : VpfTipo := 'NOT';
             01 : VpfTipo := 'CHE';
             02 : VpfTipo := 'BOL';
             03 : VpfTipo := 'REC';
             04 : VpfTipo := 'DUP';
             06 : VpfTipo := 'ENV';
           end;
           IMP.LocalizaTipoDocumento(CAD_DOC, VpfTipo);
         end;
  end;
  if FPrincipal.BaseDados.InTransaction then
  begin
    if Confirmacao('Deseja gravar as alterações efetuadas ?') then
      FPrincipal.BaseDados.Commit(VprTransacao)
    else
      FPrincipal.BaseDados.Rollback(VprTransacao);
  end;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Funcoes das tabelas
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{************** depois do insert de um novo documento ************************ }
procedure TFConfiguraImpressao.CAD_DOCAfterInsert(DataSet: TDataSet);
begin
  CAD_DOCI_NRO_DOC.Asinteger := Imp.RNroDocDisponivel;
  CAD_DOCC_CHR_ESQ.AsString := '('; // Caracter Direita.
  CAD_DOCC_CHR_DIR.AsString := ')'; // Caracter Esquerda.
  CAD_DOCC_FLA_LIN.AsString := 'N'; // Normal.
  CAD_DOCC_FLA_PAP.AsString := 'S'; // Normal.
  CAD_DOCC_FLA_EXT.AsString := 'S'; // Mês Extenso.
  CAD_DOCC_FLA_COP.AsString := 'N'; // Documento original.
  CAD_DOCD_DAT_DOC.AsDateTime := Date;
  CAD_DOCN_CAB_PAG.AsFloat := 0;
  CAD_DOCN_ROD_DOC.AsFloat := 5;
  CAD_DOCI_QTD_PAG.AsInteger := 1;
end;

{**************** Antes do post da tabela ********************************** }
procedure TFConfiguraImpressao.CAD_DOCBeforePost(DataSet: TDataSet);
begin
  if (CPadrao.Text = '') then
  begin
    Aviso('Informe a Impressora Padrão.');
    CPadrao.SetFocus;
    Abort;
  end;
end;

{****************** Depois do Post do cad documentos ************************* }
procedure TFConfiguraImpressao.CAD_DOCAfterPost(DataSet: TDataSet);
begin
  AtualizaSQLTabela(CAD_DOC);
  CAD_DOC.Last;
  IMP.LocalizaItems(MOV_DOC, CAD_DOCI_NRO_DOC.AsInteger);
end;

{*************** pocisiona o mov doc donforme o cad doc ********************** }
procedure TFConfiguraImpressao.CAD_DOCAfterScroll(DataSet: TDataSet);
begin
  BExemplo.Enabled := not CAD_DOC.EOF;
  IMP.LocalizaItems(MOV_DOC, CAD_DOCI_NRO_DOC.AsInteger);
end;

{****************** antes da edicao do cad doc ****************************** }
procedure TFConfiguraImpressao.CAD_DOCBeforeEdit(DataSet: TDataSet);
begin
  if not FPrincipal.BaseDados.InTransaction then
  begin
    VprTransacao.IsolationLevel := xilREADCOMMITTED;
    FPrincipal.BaseDados.StartTransaction(VprTransacao);
  end;
end;

{************** Garante que o texto digitado ser S ou s ou N ou n ********** }
procedure TFConfiguraImpressao.SetText_SN(Sender: TField;
  const Text: String);
begin
  if (text = 's') or (text =  'S' ) then
    sender.Value := 'S';
  if (text = 'n') or (text =  'N' ) then
    sender.Value := 'N';
end;

{***************** antes do Insert ***************************************** }
procedure TFConfiguraImpressao.MOV_DOCBeforeInsert(DataSet: TDataSet);
begin
  Abort;
end;

{********************* antes do Delete ************************************* }
procedure TFConfiguraImpressao.MOV_DOCBeforeDelete(DataSet: TDataSet);
begin
  Abort;
end;

{************** Garante que o texto digitado ser D ou d ou E ou e ********** }
procedure TFConfiguraImpressao.SetText_DE(Sender: TField;
  const Text: String);
begin
  if (text = 'd') or (text =  'D' ) then
    sender.Value := 'D';
  if (text = 'e') or (text =  'E' ) then
    sender.Value := 'E';
end;

{****************** antes do post do mov doc ********************************* }
procedure TFConfiguraImpressao.MOV_DOCBeforePost(DataSet: TDataSet);
begin
  // Se for condensado não pode ser negrito.
  if ((MOV_DOCC_FLA_CND.AsString = 'S') and (MOV_DOCC_FLA_NEG.AsString = 'S')) then
  begin
    MOV_DOCC_FLA_NEG.AsString := 'N';
    Aviso('O Campo não pode ser NEGRITO  e CONDENSADO ao mesmo tempo.');
  end;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Novo Documento
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{ *********************** Inicializa itens do mov documentos **************** }
procedure TFConfiguraImpressao.InicializaItens(NroDoc: Integer);
begin
  case RTipoDocumento.ItemIndex of
    00 : begin // Nota Promissória.
           // VALORES CONFIGURADOS DEFAULT;
                                            //  H   V   T  .
           IMP.InsereMovDoc( NroDoc, 1,     41,  2,  50, 'S', 'Dia de Vencimento', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc,  2,     48,  2,  50, 'S', 'Mês de Vencimento', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc,  3,     69,  2,  50, 'S', 'Ano de Vencimento', 'D', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc,  4,     12,  4,  50, 'S', 'Número do Documento', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc,  5,     68,  4,  50, 'S', 'Valor  do Documento', 'D', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc,  6,      8,  6,  50, 'S', 'Descrição da Duplicata - Linha 1.', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc,  7,      8,  6,  50, 'S', 'Descrição da Duplicata - Linha 2.', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc,  8,      6,  9,  50, 'S', 'Pessoa da Duplicata', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc,  9,     51,  9,  50, 'S', 'Número do CGC ou CPF', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 10,     15, 11,  50, 'S', 'Descrição do Valor - Linha 1. ', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 11,      5, 13,  50, 'S', 'Descrição do Valor - Linha 2. ', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 12,     10, 15,  50, 'S', 'Descrição de Pagamento', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 13,      5, 17,  50, 'S', 'Emitente', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 14,     10, 18,  50, 'S', 'Número do CGC/CPF do emitente', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 15,     6,  20,  50, 'S', 'Descrição do endereço do emitente', 'E', 'N', 'N' );
           AtualizaSQLTabela(MOV_DOC);
         end;
    01 : begin // CHEQUE.
           // VALORES CONFIGURADOS DEFAULT;  V   T  .
           IMP.InsereMovDoc(NroDoc,  1,     62,  2,  50, 'S', 'Valor do Cheque', 'D', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc,  2,     10,  4,  20, 'S', 'Descrição do Valor - Linha 1. ', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc,  3,      1,  5,  20, 'S', 'Descrição do Valor - Linha 2. ', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc,  4,      2,  7,  30, 'S', 'Descrição Nominal. ', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc,  5,     31,  8,  30, 'S', 'Cidade Emitido', 'E', 'N', 'N' );
           IMP.InsereMovDoc( NroDoc, 6,     43,  8,  30, 'S', 'Dia de Depósito', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc,  7,     46,  8,  40, 'S', 'Mês de Depósito', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc,  8,     63,  8,  50, 'S', 'Ano de Depósito', 'D', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc,  9,     1,  9,  50, 'S', 'Traço Separátorio - Cópia', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 10,     1, 10,  50, 'S', 'Número do Cheque - Cópia', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 11,     1, 11,  50, 'S', 'Agência do Cheque - Cópia', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 12,     1, 12,  50, 'S', 'Banco do Cheque - Cópia', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 13,     1, 13,  50, 'S', 'Número da Conta - Cópia', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 14,     1, 13,  50, 'S', 'Observação - Cópia', 'E', 'N', 'N' );
           AtualizaSQLTabela(MOV_DOC);
         end;
    02 : begin // BOLETO.
           // VALORES CONFIGURADOS DEFAULT;  V   T  .
           IMP.InsereMovDoc(NroDoc,  1,     62,  2,  50, 'S', 'Local de Pagamento', 'D', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc,  2,     10,  4,  20, 'S', 'Cedente', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc,  3,      0,  5,  20, 'S', 'Data do Documento', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc,  4,      0,  7,  22, 'S', 'Numero do Documento', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc,  5,     31,  8,  30, 'S', 'Espécie do Documento', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc,  6,     43,  8,  30, 'S', 'Aceite', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc,  7,     46,  8,  40, 'S', 'Data de Processamento', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc,  8,     63,  8,  50, 'S', 'Carteira', 'D', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc,  9,     31,  8,  30, 'S', 'Espécie', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 10,     43,  8,  30, 'S', 'Quantidade', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 11,     46,  8,  40, 'S', 'Valor', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 12,     63,  8,  50, 'S', 'Vencimento', 'D', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 13,     31,  8,  30, 'S', 'Agência/Código Cedente', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 14,     43,  8,  30, 'S', 'Nosso Número', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 15,     46,  8,  40, 'S', 'Valor do Documento', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 16,     46,  8,  40, 'S', 'Descontos ', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 17,     46,  8,  40, 'S', 'Abatimentos', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 18,     46,  8,  40, 'S', 'Mora / Multa', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 19,     46,  8,  40, 'S', 'Outros Acrescimos', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 20,     46,  8,  40, 'S', 'Valor Cobrado', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 21,     63,  8,  50, 'S', 'Instruções - TEXTO ', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 22,     63,  8,  50, 'S', 'Sacado - TEXTO', 'E', 'N', 'N' );
           AtualizaSQLTabela(MOV_DOC);
         end;
    03 : begin // Carnê de Pagamento.
           // VALORES CONFIGURADOS DEFAULT;
           // TAMANHO DE LINHA NORMAL.
           // RODAPÉ - 3.
           // SALTO DE PÁGINA - 0.
           // DOC. POR PÁGINA - 4.
           IMP.InsereMovDoc(NroDoc, 01, 002, 06, 12, 'S', 'Código do Cliente - CLIENTE', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 02, 020, 06, 56, 'S', 'Nome do Cliente - CLIENTE', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 03, 002, 09, 03, 'S', 'Parcela - CLIENTE', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 04, 012, 09, 12, 'S', 'Data de Vencimento - CLIENTE', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 05, 030, 09, 18, 'S', 'Número do Documento - CLIENTE', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 06, 076, 09, 22, 'S', 'Valor da Parcela - CLIENTE', 'D', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 07, 002, 12, 47, 'S', 'Observações - CLIENTE', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 08, 076, 12, 22, 'S', 'Acréscimo / Desconto - CLIENTE', 'D', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 09, 002, 15, 46, 'S', 'Autentificação - CLIENTE', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 10, 076, 15, 22, 'S', 'Valor Total - CLIENTE', 'D', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 11, 085, 06, 12, 'S', 'Código do Cliente - LOJA', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 12, 103, 06, 53, 'S', 'Nome do Cliente - LOJA', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 13, 085, 09, 03, 'S', 'Parcela - LOJA', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 14, 095, 09, 12, 'S', 'Data de Vencimento - LOJA', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 15, 113, 09, 18, 'S', 'Número do Documento - LOJA', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 16, 159, 09, 22, 'S', 'Valor da Parcela - LOJA', 'D', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 17, 085, 12, 47, 'S', 'Observações - LOJA', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 18, 159, 12, 22, 'S', 'Acréscimo / Desconto - LOJA', 'D', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 19, 085, 15, 46, 'S', 'Autentificação - LOJA', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 20, 159, 15, 22, 'S', 'Valor Total - LOJA', 'D', 'N', 'N' );
           AtualizaSQLTabela(MOV_DOC);
         end;
    04 : begin // Recibo.     h    v   t
           IMP.InsereMovDoc(NroDoc, 01, 005, 06, 20, 'S', 'Número do Recibo', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 02, 025, 06, 20, 'S', 'Valor do Recibo ', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 03, 005, 08, 40, 'S', 'Pessoa do Recibo', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 04, 010, 09, 60, 'S', 'Descrição Valor Linha 1', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 05, 005, 10, 70, 'S', 'Descrição Valor Linha 2', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 06, 010, 11, 60, 'S', 'Descrição referência Linha 1', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 07, 005, 12, 70, 'S', 'Descrição referência Linha 2', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 08, 020, 15, 20, 'S', 'Cidade', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 09, 055, 15, 02, 'S', 'Dia', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 10, 060, 15, 15, 'S', 'Mês', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 11, 075, 15, 09, 'S', 'Ano', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 12, 005, 18, 40, 'S', 'Emitente', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 13, 005, 19, 40, 'S', 'CGC, CPF ou RG do Emitente ', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 14, 005, 20, 40, 'S', 'Endereço do Emitente', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 15, 005, 1, 40, 'S', 'Nome Filial', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 16, 005, 2, 30, 'S', 'Endereço Filial', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 17, 040, 2, 20, 'S', 'Bairro Filial', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 18, 045, 3, 15, 'S', 'Cep Filial', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 19, 005, 3, 30, 'S', 'Cidade Filial', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 20, 045, 4, 35, 'S', 'E-mail Filial', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 21, 045, 5, 30, 'S', 'Site Filial', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 22, 005, 4, 40, 'S', 'Fone Filial', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 23, 005, 13, 40, 'S', 'Texto Maior Clareza firmo', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 24, 001, 14, 80, 'S', 'Linha Pontilhada', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 25, 030, 5, 80, 'S', 'Texto Recibo', 'E', 'N', 'N' );
           AtualizaSQLTabela(MOV_DOC);
         end;
    05 : begin // Duplicata.             h    v   t
           IMP.InsereMovDoc(NroDoc, 01, 050, 08, 10, 'S', 'Data de Emissão', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 02, 002, 12, 10, 'S', 'Número da Fatura ', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 03, 015, 12, 10, 'S', 'Valor da Fatura', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 04, 030, 12, 10, 'S', 'Número de Ordem', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 05, 045, 12, 12, 'S', 'Vencimento', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 06, 010, 15, 10, 'S', 'Desconto', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 07, 060, 15, 12, 'S', 'Data Limite de Pagamento', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 08, 010, 16, 30, 'S', 'Condições Especiais', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 09, 020, 19, 30, 'S', 'Nome do Sacado', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 10, 020, 20, 30, 'S', 'Endereço do Sacado', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 11, 020, 22, 30, 'S', 'Município', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 12, 070, 22, 02, 'S', 'Estado', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 13, 020, 23, 20, 'S', 'Inscrição CGC', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 14, 070, 23, 20, 'S', 'Inscrição Estadual', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 15, 020, 24, 30, 'S', 'Praça de Pagamento', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 16, 020, 28, 40, 'S', 'Descrição Valor Linha 1', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 17, 020, 29, 40, 'S', 'Descrição Valor Linha 1', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 18, 020, 31, 20, 'S', 'Valor Total da Duplicata', 'D', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 19, 070, 32, 20, 'S', 'Representante', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 20, 020, 33, 30, 'S', 'Código do Representante', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 21, 020, 34, 40, 'S', 'CEP', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 22, 020, 35, 40, 'S', 'Código do Sacado', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 23, 020, 21, 30, 'S', 'Bairro do ', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 24, 020, 22, 30, 'S', 'Nome Filial', 'E', 'N', 'N' );
           AtualizaSQLTabela(MOV_DOC);
         end;
    06 : begin // Envelope              h    v   t
           // frente
           IMP.InsereMovDoc(NroDoc, 01, 10, 05, 60, 'S', 'Nome Destinatário', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 02, 10, 06, 100, 'S', 'Rua Destinatário', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 03, 10, 07, 50, 'S', 'Bairro Destinatário', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 04, 10, 08, 50, 'S', 'Cidade/Estado Destinatário', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 05, 10, 09, 10, 'S', 'CEP Destinatário', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 06, 10, 10, 50, 'S', 'A/C Destinatário', 'E', 'N', 'N' );
           // verso
           IMP.InsereMovDoc(NroDoc, 07, 10, 15, 60, 'S', 'Nome Remetente', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 08, 10, 16, 100, 'S', 'Rua Remetente', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 09, 10, 17, 50, 'S', 'Bairro Remetente', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 10, 10, 18, 50, 'S', 'Cidade/Estado Remetente', 'E', 'N', 'N' );
           IMP.InsereMovDoc(NroDoc, 11, 10, 19, 10, 'S', 'CEP Remetente', 'E', 'N', 'N' );
           AtualizaSQLTabela(MOV_DOC);
         end;

    07 :begin // Pedido
          // dados nota
                     //             N col   lin   tam
          IMP.InsereMovDoc(NroDoc, 01, 75,  001,  08, 'S', 'Número do Pedido', 'E', 'N', 'S' );
          IMP.InsereMovDoc(NroDoc, 02, 05,  013,  60, 'S', 'Nome / Razão Social', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 03, 107, 013,  20, 'S', 'CGC / CPF', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 04, 147, 013,  10, 'S', 'Data de Emissão do Pedido', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 05, 05,  015,  50, 'S', 'Endereço', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 06, 85,  015,  30, 'S', 'Bairro / Distrito', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 07, 125, 015,  10, 'S', 'CEP', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 08, 147, 015,  10, 'S', 'Data da Saída / Entrada', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 09, 05,  018,  30, 'S', 'Município', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 10, 75,  018,  22, 'S', 'Fone / FAX', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 11, 101, 018,  02, 'S', 'UF', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 12, 115, 018,  15, 'S', 'Inscrição Estadual', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 13, 149, 018,  05, 'S', 'Hora Previsao Entrega', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 14, 155, 061,  15, 'S', 'Valor Total dos Produtos', 'D', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 15, 158, 063,  15, 'S', 'Valor Total do Pedido', 'D', 'S', 'S');
          // transportadora
          IMP.InsereMovDoc(NroDoc, 16, 05,  047,  50, 'S', 'Nome da Transportadora', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 17, 103, 047,  10, 'S', 'Placa do Veículo da Transportadora', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 18, 122, 047,  02, 'S', 'UF da Placa do Veículo da Transportadora', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 19, 130, 047,  15, 'S', 'CGC/ CPF da Transportadora', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 20, 05,  050,  30, 'S', 'Endereço da Transportadora', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 21, 85,  050,  30, 'S', 'Município da Transportadora', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 22, 122, 050,  02, 'S', 'UF do Endereço da Transportadora', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 23, 130, 050,  15, 'S', 'Inscrição Estadual da Transportadora', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 24, 05,  053,  15, 'S', 'Quantidade de Produtos', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 25, 30,  053,  15, 'S', 'Espécie', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 26, 60,  053,  15, 'S', 'Marca', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 27, 85,  053,  15, 'S', 'Número', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 28, 125, 053,  15, 'S', 'Peso Bruto', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 29, 145, 053,  15, 'S', 'Peso Líquido', 'E', 'S', 'S');
          // itens
          IMP.InsereMovDoc(NroDoc, 30, 04,  029,  10, 'S', 'items - Código', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 31, 17,  029,  40, 'S', 'items - Descrição do Produto', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 32, 60, 029,  03, 'S', 'items - Unidade de Medida do Produto', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 33, 65, 029,  10, 'S', 'items - Quantidade do Produto', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 34, 80, 029,  15, 'S', 'items - Valor Unitário do Produto', 'D', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 35, 100, 029,  15, 'S', 'items - Valor Total do Produto', 'D', 'S', 'S');
          // obs. pedido
          IMP.InsereMovDoc(NroDoc, 36, 005, 39, 150, 'S', 'Observacoes', 'E', 'S', 'S');
          //dados da filial
          IMP.InsereMovDoc(NroDoc, 37, 005, 001, 50, 'S', 'Filial', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 38, 005, 002, 50, 'S', 'Endereco Filial', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 39, 060, 002, 30, 'S', 'Bairro Filial', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 40, 005, 003, 10, 'S', 'Cep Filial ', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 41, 020, 003, 40, 'S', 'Cidade Filial', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 42, 005, 004, 50, 'S', 'E-mail Filial', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 43, 060, 004, 50, 'S', 'Site Filial ', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 44, 005, 005, 50, 'S', 'Fone / Fax Filial', 'E', 'S', 'S');
          //ITENS
          IMP.InsereMovDoc(NroDoc, 45, 120, 029,  6, 'S', 'items - Percentual Desconto', 'D', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 46, 005, 054, 40, 'S', 'Vendedor', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 47, 050, 054, 30, 'S', 'Condição Pagamento', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 48, 005, 055, 30, 'S', 'Desconto / Acrescimo', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 49, 005, 005, 30, 'S', 'Data Previsão Entrega', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 50, 005, 056, 50, 'S', 'Parcelas ', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 51, 005, 040, 20, 'S', 'Hora Prevista Entrega ', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 52, 005, 041, 30, 'S', 'Texto Validade Cotação', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 53, 005, 037, 70, 'S', 'Texto Validade Desconto', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 54, 005, 039, 70, 'S', 'Texto Juros / Multa', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 55, 005, 041, 70, 'S', 'Nome Assinatura Cleinte', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 56, 005, 040, 70, 'S', 'Pontilhado Assinatura Cliente', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 57, 005, 042, 70, 'S', 'Texto Observacao Fixa', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 58, 005, 006, 50, 'S', 'Tipo Cotacao', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 59, 005, 006, 50, 'S', 'Vendedor Preposto', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 60, 120, 029,  6, 'S', 'items - Referencia Cliente', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 61, 120, 029,  80, 'S', 'items - Observacao', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 62, 120, 029,  30, 'S', 'Ordem de Compra', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 63, 40, 029,  30, 'S', 'Items - Codigo da cor', 'E', 'S', 'S');
          IMP.InsereMovDoc(NroDoc, 64, 40, 029,  30, 'S', 'Items - Embalagem', 'E', 'S', 'S');
          AtualizaSQLTabela(MOV_DOC);
        end;
  end;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                       Funcoes do botoes inferiores
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{********************* grava documento ************************************** }
procedure TFConfiguraImpressao.BGravarClick(Sender: TObject);
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

{******************* Cancela documento ************************************* }
procedure TFConfiguraImpressao.BCancelarClick(Sender: TObject);
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

{***************** Excluir documento **************************************** }
procedure TFConfiguraImpressao.BExcluirClick(Sender: TObject);
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

{**************** cadastrar documento ************************************** }
procedure TFConfiguraImpressao.BCadastrarClick(Sender: TObject);
var
  VpfTipo,
  VpfNovo,
  VpfMsg : string;
begin
  if not FPrincipal.BaseDados.InTransaction  then
  begin
    VprTransacao.IsolationLevel := xilREADCOMMITTED;
    FPrincipal.BaseDados.StartTransaction(VprTransacao);
  end;
  MudaEstado(false);
  try
    case RTipoDocumento.ItemIndex of
      00 : begin
             VpfMsg := 'de NOTA PROMISSÓRIA';
             VpfTipo := 'NOT';
           end;
      01 : begin
             VpfMsg := 'de CHEQUE';
             VpfTipo := 'CHE';
           end;
      02 : begin
             VpfMsg := 'de BOLETO BANCÁRIO';
             VpfTipo := 'BOL';
           end;
      03 : begin
             VpfMsg := 'de CARNÊ DE PAGAMENTO';
             VpfTipo := 'CAR';
           end;
      04 : begin
             VpfMsg := 'de RECIBO';
             VpfTipo := 'REC';
           end;
      05 : begin
             VpfMsg := 'de DUPLICATA';
             VpfTipo := 'DUP';
           end;
      06 : begin
             VpfMsg := 'de ENVELOPE';
             VpfTipo := 'ENV';
           end;
      07 : begin
             VpfMsg := 'de PEDIDO';
             VpfTipo := 'PED';
           end;
    end;
    if MOV_DOC.State in [dsInsert, dsEdit] then
      MOV_DOC.Post;
    if CAD_DOC.State in [dsInsert, dsEdit] then
      CAD_DOC.Post;
    if Entrada('Novo Documento',
               'Digite o nome do novo modelo ' + VpfMsg + ' a incluir: ',
               VpfNovo, False, clWhite, clBtnFace) then
    begin
      if (VpfNovo <> '') then
      begin
        if not FPrincipal.BaseDados.InTransaction then
        begin
          VprTransacao.IsolationLevel := xilREADCOMMITTED;
          FPrincipal.BaseDados.StartTransaction(VprTransacao);
        end;
        CAD_DOC.Insert;
        CAD_DOCC_NOM_DOC.AsString := VpfNovo;
        CAD_DOCC_TIP_DOC.AsString := VpfTipo;
        CAD_DOCC_FLA_FOR.AsString := 'P';
        if VpfTipo = 'PED' then
          CAD_DOCI_MAX_ITE.AsInteger := 20;
        CAD_DOCI_SEQ_IMP.AsInteger := CAD_DRIVER_AUX.FieldByName('I_SEQ_IMP').AsInteger;
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
  except
   if FPrincipal.BaseDados.InTransaction  then
    FPrincipal.BaseDados.Rollback(VprTransacao);
  end;

  if FPrincipal.BaseDados.InTransaction  then
    FPrincipal.BaseDados.Commit(VprTransacao);
end;

{***************** cria um exemplo do documento selecionado ***************** }
procedure TFConfiguraImpressao.BExemploClick(Sender: TObject);
var
  I,
  Qtd: Integer;
  Preenche :string;
  TI,
  TS: TStringList;
  DadosPromissoria: TDadosPromissoria;
  DadosBoleto: TDadosBoleto;
  DadosCheque: TDadosCheque;
  DadosCarne: TDadosCarne;
  DadosRecibo: TDadosRecibo;
  DadosDuplicata: TDadosDuplicata;
  DadosEnvelope : TDadosEnvelope;
  Preeenche : string;
  laco: integer;
begin
  Preeenche :='';
  if ETeste.Text <> '' then
    Preeenche := AdicionaCharD(ETeste.Text[1], Preeenche, 200);
  if MOV_DOC.State in [dsInsert, dsEdit] then
    MOV_DOC.Post;
  if CAD_DOC.State in [dsInsert, dsEdit] then
    CAD_DOC.Post;
  Preenche:= '';
  if ETeste.Text <> '' then
    Preenche:=AdicionaCharD(ETeste.Text[1], Preenche, 200);
  IMP.InicializaImpressao(CAD_DOCI_NRO_DOC.AsInteger, CAD_DOCI_SEQ_IMP.AsInteger);
  if IMP.CabecalhoDOC.QuantidadePorPagina = 1 then
    Qtd := 1 // Imprime somente este.
  else
    Qtd := (IMP.CabecalhoDOC.QuantidadePorPagina * 2); // Imprime duas páginas.
  for I := 1  to Qtd do
  begin
    case RTipoDocumento.ItemIndex of
      00: begin
             // Carrega e Imprime os dados do cheque.
             DadosPromissoria := TDadosPromissoria.Create;
             with DadosPromissoria do
             begin
               DiaVencimento:='25' + Preenche;
               MesVencimento:='06';
               AnoVencimento:='2000' + Preenche;
               NumeroDocumento:=Preenche + '12345678';
               ValorDocumento:=5000;
               DescricaoDuplicata1:='111111 - NOTA EXEMPLO PARA IMPRIMIR.' + Preenche;
               DescricaoDuplicata2:='222222 - NOTA EXEMPLO PARA IMPRIMIR.' + Preenche;
               PessoaDuplicata:='PESSOA DO DOCUMENTO.' + Preenche;
               NumeroCGCCPF:='123.456.789.101-88' + Preenche;
               DescricaoValor1:='1 - CENTO E DOZE MIL TREZENTOS E QUARENTA E CINCO REAIS ' + Preenche;
               DescricaoValor2:='2 - E NOVENTA E NOVE CENTAVOS. ' + Preenche;
               DescricaoPagamento:='PAGAMENTO EM DINHEIRO.' + Preenche;
               Emitente:='MARIO DA SILVA.' + Preenche;
               CPFCGCEmitente:= Preenche + '123.456.789.000.555-22';
               EnderecoEmitente:='EXEMPLO DE LOCAL PARA DOCUMENTOS.' + Preenche;
             end;
             IMP.ImprimePromissoria(DadosPromissoria);
           end;
      01: begin
             DadosCheque := TDadosCheque.Create;
             with DadosCheque do
             begin
              // Carrega e Imprime os dados do cheque.
               ValorCheque := 1234567.78;
               DescValor1 := 'CENTO E DOZE MIL TREZENTOS E QUARENTA E ' + Preenche;
               DescValor2 := 'CINCO REAIS E NOVENTA E NOVE CENTAVOS. ' + Preenche;
               DescNominal := 'EXEMPLO INF. LTDA. - ME.' + Preenche;
               CidadeEmitido := 'BLUMENAU' + Preenche;
               DiaDeposito := '05' + Preenche;
               MesDeposito := '02';
               AnodeDeposito := '2000' + Preenche;
               Numero := Preenche + '12344444';
               Conta :=  Preenche + '222.666-7';
               Agencia := Preenche + '555';
               Banco := 'BANCO EXEMPLO' + Preenche;
               Observ := 'OBS.' + Preenche;
               Traco := '-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'
             end;
             IMP.ImprimeCheque(DadosCheque);
          end;
      02 : begin
             DadosBoleto := TDadosBoleto.Create;
             TI := TStringList.Create;
             TS := TStringList.Create;
             with DadosBoleto do
             begin
               LocalPagamento := 'QUALQUER BANCO ATE O VENCIMENTO.' + Preenche;
               Cedente := 'BANCO EXEMPLO LTDA. ' + Preenche;
               DataDocumento := Date;
               NumeroDocumento := '123456789012' + Preenche;
               EspecieDocumento := 'AP.' + Preenche;
               Aceite := 'N.' + Preenche;
               DataProcessamento := Date;
               Carteira := 'DIREITA' + Preenche;
               Especie := 'R$' + Preenche;
               Quantidade := Preenche + '50,00';
               Valor := 1000;
               Vencimento := Date;
               Agencia := '003-92342/303-6' + Preenche;
               NossoNumero := '4444444444' + Preenche;
               ValorDocumento := 5000;
               Desconto := 2;
               Outras := 3;
               MoraMulta := 5;
               Acrescimos := 4;
               ValoCobrado := 5010;
               TI.Add('1 - Instruções');
               TI.Add('2 - Instruções');
               TI.Add('3 - Instruções');
               TI.Add('4 - Instruções');
               TI.Add('5 - Instruções');
               TI.Add('6 - Instruções');
               TI.Add('7 - Instruções');
               Instrucoes := TI;
               // Máximo 3 linhas.
               TS.Add('1 - Sacado.');
               TS.Add('2 - Sacado.');
               TS.Add('3 - Sacado.');
               Sacado := TS;
             end;
             IMP.ImprimeBoleto(DadosBoleto);
             TI.Destroy;
             TS.Destroy;
           end;
      03: begin
             // Carrega e Imprime os dados do Carne de Pagamento.
             DadosCarne := TDadosCarne.Create;
             with DadosCarne do
             begin
               CodigoClienteC:='1234567890' + Preenche;
               NomeClienteC:='RODRIGO EXEMPLO DE OLIVEIRA SANTOS DA SILVA' + Preenche;
               ParcelaC:='10' + Preenche;
               VencimentoC:=Date;
               NumeroDocumentoC:='333333' + Preenche;
               ValorParcelaC:=12345;
               ObservacoesC:='DEMO DE CARNE DE PAGAMENTO.' + Preenche;
               AcrDescC:=123;
               AutentificacaoC:='/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/' + Preenche;
               ValorTotalC:=8888888.88;
               CodigoClienteL:=CodigoClienteC;
               NomeClienteL:=NomeClienteC;
               ParcelaL:=ParcelaC;
               VencimentoL:=VencimentoC;
               NumeroDocumentoL:=NumeroDocumentoC;
               ValorParcelaL:=ValorParcelaC;
               ObservacoesL:=ObservacoesC;
               AcrDescL:=AcrDescC;
               AutentificacaoL:=AutentificacaoC;
               ValorTotalL:=ValorTotalC;
             end;
             IMP.ImprimeCarnePagamento(DadosCarne);
           end;
      04: begin
            // Carrega e Imprime os dados do Carne de Pagamento.
            DadosRecibo := TDadosRecibo.Create;
            with DadosRecibo do
            begin
              Numero := '1234567890' + Preenche;
              Valor := 123456.88;
              Pessoa := 'PESSOA EXEMPLO.' + Preenche;
              DescValor1 := 'CENTO E VINTE E CINCO MIL REAIS' + Preenche;
              DescValor2 := 'E TRINTA E DOIS CENTAVOS'  + Preenche;
              DescReferente1 := 'COMPRA DE EQUIPAMENTO, OU SEJA, DE'  + Preenche;
              DescReferente2 := 'UM COMPUTADOR MARCA EXEMPLO.'  + Preenche;
              Cidade := 'CIDADE EXEMPLO'  + Preenche;
              Dia := '01' + Preenche;
              Mes := 'JANEIRO' + Preenche;
              Ano := '2000' + Preenche;
              Emitente := 'EMITENTE EXEMPLO'  + Preenche;
              CGCCPFGREmitente := '2423.4234.234.234'  + Preenche;
              EnderecoEmitente := 'ENDERECO EXEMPLO.' + Preenche;
            end;
            IMP.ImprimeRecibo(DadosRecibo);
          end;
      05: begin
            // Carrega e Imprime os dados do Carne de Pagamento.
            DadosDuplicata := TDadosDuplicata.Create;
            with DadosDuplicata do
            begin
              DataEmissao := Date;
              Numero := '1234567890' + Preenche;
              Valor :=1234.80;
              NroOrdem := '1234567890' + Preenche;
              DataVencimento := Date;
              DescontoDe := 12.05;
              DataPagtoAte := Date;
              CondEspeciais := 'EXEMPLO DE CONDICOES ESPECIAIS' + Preenche;
              NomeSacado := 'EXEMPLO NOME SACADO' + Preenche;
              EnderecoSacado := 'ENDERECO EXEMPLO' + Preenche;
              CidadeSacado := 'CIDADE EXEMPLO' + Preenche;
              EstadoSacado := 'SC' + Preenche;
              InscricaoCGC := '1234564567890' + Preenche;
              InscricaoEstadual := '123467867567890' + Preenche;
              PracaPagto := 'PRACA EXEMPLO' + Preenche;
              DescValor1 := 'TREZENTOS E OITENTA E CINCO REAIS E ' + Preenche;
              DescValor2 := 'SETENTA CENTAVOS' + Preenche;
              ValorTotal := 12345678.50;
              Representante := 'REPRESENTANTE' + Preenche;
              Cod_Representante := '8228' + Preenche;
              CEP := '89802-240' + Preenche;
              Cod_Sacado := '12345678' + Preenche;
            end;
            IMP.ImprimeDuplicata(DadosDuplicata);
          end;
      06: begin
            // Carrega e Imprime os dados do envelope
            DadosEnvelope := TDadosEnvelope.Create;
            with DadosEnvelope do
            begin
              // frente
              nomeDes := 'XXYZ Comercio Ltda' + Preenche;
              ruaDes := 'Rua Paraiba, 1233' + Preenche;
              bairroDes := 'Bairro : Velha' + Preenche;
              cidade_estadoDes := 'Blumenau - Santa Catarina' + Preenche;
              cepDes := '88959-000' + Preenche;
              ContatoDes := 'A/C : Marcelo' + Preenche;
              // verso
              nomeRem := 'Indata Sistema Ltda' + Preenche;
              ruaRem := 'Rua João Pessoa, 740' + Preenche;
              bairroRem := 'Bairro : Velha' + Preenche;
              cidade_estadoRem := 'Blumenau - Santa Catarina' + Preenche;
              cepRem := '89036-000' + Preenche;
           end;
           IMP.ImprimeEnvelope(DadosEnvelope);
         end;
    end;
  end;
  IMP.FechaImpressao(Config.ImpPorta, 'C:\IMP.TXT');
end;

{******************* altera um documento ************************************* }
procedure TFConfiguraImpressao.BAlterarClick(Sender: TObject);
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

{***************** cria um novo documento apartir do modelo ****************** }
procedure TFConfiguraImpressao.BModeloClick(Sender: TObject);
var
  VpfProximoCodigo,
  I: Integer;
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
      VpfProximoCodigo :=  Imp.RNroDocDisponivel;
      AUX.Insert;
      // Tabela pai.
      for I:=0 to (CAD_DOC.FieldCount - 1) do
        AUX.FieldByName(CAD_DOC.Fields[I].FieldName).Value := CAD_DOC.Fields[I].Value;
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

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                       funcoes diversas
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{********* evita a digitacao de numeros negativos ************************** }
procedure TFConfiguraImpressao.Negativo_keyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = '-' then
   Key := '#';
end;

{********** no click de um tipo de documento configura o cad doc *************}
procedure TFConfiguraImpressao.RTipoDocumentoClick(Sender: TObject);
var
  VpfTipo: string;
begin
  Label6.Visible       := RTipoDocumento.ItemIndex = 7;
  DBEditColor1.Visible := RTipoDocumento.ItemIndex = 7;

  if not (CAD_DOC.State in [dsInsert, dsEdit]) then
  begin
    DMes.Visible := RTipoDocumento.ItemIndex < 2;
    Copia.Visible := RTipoDocumento.ItemIndex = 1;
    case RTipoDocumento.ItemIndex of
      00 : VpfTipo := 'NOT';
      01 : VpfTipo := 'CHE';
      02 : VpfTipo := 'BOL';
      03 : VpfTipo := 'CAR';
      04 : VpfTipo := 'REC';
      05 : VpfTipo := 'DUP';
      06 : VpfTipo := 'ENV';
      07 : VpfTipo := 'PED';
    end;
    IMP.LocalizaTipoDocumento(CAD_DOC, VpfTipo);
  end;
end;

{*************************** help ******************************************** }
procedure TFConfiguraImpressao.BBAjudaClick(Sender: TObject);
begin
end;

{ ****************** Muda os estados dos Botoes **************************** }
procedure TFConfiguraImpressao.MudaEstado( acao : Boolean );
begin
  BCadastrar.Enabled := acao;
  BAlterar.Enabled := acao;
  BExcluir.Enabled := acao;
  BGravar.Enabled := not acao;
  BCancelar.Enabled := not  acao;
  BExemplo.Enabled := acao;
  BFechar.Enabled := acao;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

Initialization
  RegisterClasses([TFConfiguraImpressao]);
end.


