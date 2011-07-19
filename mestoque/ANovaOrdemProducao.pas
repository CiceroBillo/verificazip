unit ANovaOrdemProducao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Buttons, numericos,
  Mask, Localizacao,UnDados, ComCtrls, UnordemProducao,UnProdutos,
  DBKeyViolation, EditorImagem, Grids, CGrades, Db, DBTables, DBCtrls,
  Tabela, DBGrids, UnDadosProduto, DBClient, UnRave;

type
  TRBStatusCadastro = (scInserindo,scAlterando,scConsultando);

  TFNovaOrdemProducao = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    BFechar: TBitBtn;
    Localiza: TConsultaPadrao;
    EditorImagem1: TEditorImagem;
    BImpOP: TBitBtn;
    BCadastrar: TBitBtn;
    CadProdutos: TSQL;
    PageControl1: TPageControl;
    PCadastro: TTabSheet;
    PColetas: TTabSheet;
    ScrollBox1: TScrollBox;
    PanelColor1: TPanelColor;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    SpeedButton3: TSpeedButton;
    Label8: TLabel;
    Label11: TLabel;
    SpeedButton5: TSpeedButton;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    SpeedButton6: TSpeedButton;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    SpeedButton7: TSpeedButton;
    Label27: TLabel;
    SpeedButton8: TSpeedButton;
    Label28: TLabel;
    Label17: TLabel;
    Label19: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label29: TLabel;
    Label18: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    EMaquina: TEditLocaliza;
    EPedido: Tnumerico;
    EProduto: TEditLocaliza;
    ETipoPedido: TComboBoxColor;
    ECliente: TEditLocaliza;
    ELargura: Tnumerico;
    EComprimento: Tnumerico;
    EFigura: Tnumerico;
    EDatEmissao: TCalendario;
    EDatEntrega: TCalendario;
    EPrateleira: TEditColor;
    EQtdFitas: Tnumerico;
    ENumFios: TEditColor;
    EBatidas: TEditColor;
    ETipoEmenda: TEditLocaliza;
    ECalandragem: TEditColor;
    EEngomagem: TEditColor;
    ETipoFundo: TEditLocaliza;
    GCombinacoes: TRBStringGridColor;
    ETotalMetros: Tnumerico;
    EMetrosFita: Tnumerico;
    EHorasProducao: TMaskEditColor;
    EValUnitario: Tnumerico;
    ENroOPCliente: Tnumerico;
    EPerAcrescimo: Tnumerico;
    EUMPedido: TComboBoxColor;
    EObservacoes: TMemoColor;
    ETipoTear: TComboBoxColor;
    PanelColor3: TPanelColor;
    GColeta: TRBStringGridColor;
    Label33: TLabel;
    GridIndice1: TGridIndice;
    Label34: TLabel;
    Coleta: TSQL;
    ColetaDATCOL: TSQLTimeStampField;
    ColetaINDFIN: TWideStringField;
    ColetaC_NOM_USU: TWideStringField;
    ColetaCODCOM: TFMTBCDField;
    ColetaNROFIT: TFMTBCDField;
    ColetaMETAPR: TFMTBCDField;
    ColetaMETCOL: TFMTBCDField;
    ColetaMETFAL: TFMTBCDField;
    DataColeta: TDataSource;
    EPente: TEditColor;
    Label35: TLabel;
    ColetaCODMAN: TWideStringField;
    EMotivoReprogramacao: TEditLocaliza;
    Label36: TLabel;
    SpeedButton4: TSpeedButton;
    Label37: TLabel;
    ValidaGravacao1: TValidaGravacao;
    EBatidasTear: TEditColor;
    Label38: TLabel;
    EProdutoNovo: TEditColor;
    Label39: TLabel;
    ETipoCorte: TEditLocaliza;
    Label40: TLabel;
    SpeedButton9: TSpeedButton;
    Label41: TLabel;
    PRevisaoExterna: TTabSheet;
    PanelColor4: TPanelColor;
    ColetaOPCorpo: TSQL;
    ColetaOPCorpoEMPFIL: TFMTBCDField;
    ColetaOPCorpoSEQORD: TFMTBCDField;
    ColetaOPCorpoSEQCOL: TFMTBCDField;
    ColetaOPCorpoDATCOL: TSQLTimeStampField;
    ColetaOPCorpoINDFIN: TWideStringField;
    ColetaOPCorpoINDREP: TWideStringField;
    ColetaOPCorpoC_NOM_PRO: TWideStringField;
    ColetaOPCorpoUNMPED: TWideStringField;
    ColetaOPCorpoC_NOM_USU: TWideStringField;
    ColetaOPCorpoDATREV: TSQLTimeStampField;
    ColetaOPCorpoCODUSU: TFMTBCDField;
    DataColetaOpCorpo: TDataSource;
    GridIndice2: TGridIndice;
    DataColetaOpItem: TDataSource;
    ColetaOpItem: TSQL;
    ColetaOpItemCODCOM: TFMTBCDField;
    ColetaOpItemCODMAN: TWideStringField;
    ColetaOpItemNROFIT: TFMTBCDField;
    ColetaOpItemMETCOL: TFMTBCDField;
    GridIndice3: TGridIndice;
    PMetroFaturado: TTabSheet;
    GradeMetrosFaturados: TGridIndice;
    MetroFaturado: TSQL;
    DataMetroFaturado: TDataSource;
    MetroFaturadoI_NRO_NOT: TFMTBCDField;
    MetroFaturadoD_DAT_EMI: TSQLTimeStampField;
    MetroFaturadoT_HOR_SAI: TSQLTimeStampField;
    MetroFaturadoCODCOM: TFMTBCDField;
    MetroFaturadoCODMAN: TWideStringField;
    MetroFaturadoMETCOL: TFMTBCDField;
    ColetaOPCorpoCODPRO: TWideStringField;
    Label44: TLabel;
    Label42: TLabel;
    SpeedButton10: TSpeedButton;
    Label43: TLabel;
    EProgramador: TRBEditLocaliza;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EProdutoSelect(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure EProdutoRetorno(Retorno1, Retorno2: String);
    procedure EProdutoCadastrar(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure EProdutoChange(Sender: TObject);
    procedure EMaquinaCadastrar(Sender: TObject);
    procedure EClienteCadastrar(Sender: TObject);
    procedure ETotalMetrosChange(Sender: TObject);
    procedure EMaquinaRetorno(Retorno1, Retorno2: String);
    procedure EQtdFitasExit(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure GCombinacoesCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GCombinacoesDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GCombinacoesGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GCombinacoesMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GCombinacoesNovaLinha(Sender: TObject);
    procedure BImpOPClick(Sender: TObject);
    procedure BCadastrarClick(Sender: TObject);
    procedure GCombinacoesSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure GCombinacoesKeyPress(Sender: TObject; var Key: Char);
    procedure GCombinacoesDepoisExclusao(Sender: TObject);
    procedure EUMPedidoExit(Sender: TObject);
    procedure GCombinacoesEnter(Sender: TObject);
    procedure ETipoTearExit(Sender: TObject);
    procedure GColetaCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure EMotivoReprogramacaoCadastrar(Sender: TObject);
    procedure EProdutoNovoKeyPress(Sender: TObject; var Key: Char);
    procedure ColetaOPCorpoAfterScroll(DataSet: TDataSet);
    procedure PageControl1Change(Sender: TObject);
    procedure GradeMetrosFaturadosOrdem(Ordem: String);
    procedure GCombinacoesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    VprStatusCadastro: TRBStatusCadastro;
    VprDOrdem : TRBDOrdemProducaoEtiqueta;
    VprDOrdemItem : TRBDOrdemProducaoItem;
    VprDProduto : TRBDProduto;
    VprSeqProdutoAnterior,
    VprTearAnterior : Integer;
    VprUMPedidoAnterior, VprOrdemMetroFaturado : String;
    FunOrdemProducao : TRBFuncoesOrdemProducao;
    FunProduto : TFuncoesProduto;
    FunRave : TRBFunRave;
    function RetornaCodPro(SeqPro: integer): string;
    procedure PosHistoricoColeta(VpaEmpFil, VpaSeqOrdem : String);
    procedure PosRevisaoExterna(VpaEmpFil, VpaSeqOrdem : String);
    procedure PosRevisaoExternaItem(VpaEmpFil,VpaSeqOrdem,VpaSeqColeta : String);
    procedure PosMetrosFaturados(VpaEmpfil,VpaSeqOrdem : String);
    procedure CarTituloGrade;
    procedure CarDClasse;
    procedure CarDOrdemItem;
    procedure CarDTela;
    procedure carProdutoTela(VpaDProduto : TRBDProduto);
    procedure LimpaDadosTela;
    procedure AtualizaEnableBotoes;
    procedure Cadastrar;
    procedure CalculaMetrosFitaCombinacao;
    procedure CalculaPecasFitaCombinacao;
    procedure CalculaHorasProducao;
    procedure VerificaEstoque;
  public
    { Public declarations }
    procedure NovaOrdem;
    procedure ConsultaOrdem(VpaEmpFil, VpaSeqOrdem : Integer);
    procedure AlteraOrdem(VpaCodFilial, VpaSeqOrdem : Integer);
  end;

var
  FNovaOrdemProducao: TFNovaOrdemProducao;

implementation

uses APrincipal,Constantes, FunData, ConstMsg, AMaquinas,
  ANovoCliente,FunObjeto, FunNumeros, FunSql, FunString,
  AMotivoReprogramacao, ATipoCorte, AMostraEstoqueProdutoCor,
  ANovoProdutoPro;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovaOrdemProducao.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunRave := TRBFunRave.cria(FPrincipal.BaseDados);
  VprOrdemMetroFaturado := 'order by NOTA.I_NRO_NOT';
  PageControl1.ActivePageIndex := 0;
  VprSeqProdutoAnterior := -1;
  VprTearAnterior := -1;
  VprDOrdem := TRBDOrdemProducaoEtiqueta.cria;
  GCombinacoes.ADados := VprDOrdem.Items;
  GCombinacoes.CarregaGrade;
  GColeta.ADados := VprDOrdem.Items;
  FunOrdemProducao := TRBFuncoesOrdemProducao.cria(FPrincipal.BaseDados);
  FunProduto := TFuncoesProduto.criar(nil,FPrincipal.BaseDados);
  VprDProduto := TRBDProduto.Cria;
  VprDProduto.CodEmpresa := varia.CodigoEmpresa;
  VprDProduto.CodEmpFil := varia.CodigoEmpFil;
  CarTituloGrade;

  if Varia.EstagioOrdemProducao = 0 then
  begin
    aviso('ESTÁGIO INICIAL DA ORDEM DE PRODUÇÃO INVÁLIDO!!!'#13'Para alterar o estágio inicial da ordem de produção é necessário entrar no módulo de configurações do sistema --> Configurações Produtos...');
    close;
  end;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovaOrdemProducao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunRave.Free;
  VprDOrdem.free;
  VprDProduto.free;
  FunOrdemProducao.free;
  FunProduto.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

function TFNovaOrdemProducao.RetornaCodPro(SeqPro: integer): string;
begin
  AdicionaSQLAbreTabela(CadProdutos,
  ' Select * ' +
  ' from CADPRODUTOS ' +
  ' Where I_SEQ_PRO = ' + IntToStr(SeqPro) +
  ' and C_ATI_PRO = ''S''');

  Result := CadProdutos.FieldByName(Varia.CodigoProduto).AsString;
  FechaTabela(CadProdutos);
end;

{******************************************************************************}
procedure TFNovaOrdemProducao.AtualizaEnableBotoes;
begin
  BImpOP.Enabled     := (VprStatusCadastro in [scConsultando]) and (VprDOrdem.SeqOrdem > 0);
  BCadastrar.Enabled := VprStatusCadastro in [scConsultando];
  BGravar.Enabled    := (VprStatusCadastro in [scInserindo,scAlterando]);
  BCancelar.Enabled  := VprStatusCadastro in [scInserindo,scAlterando];
end;

{******************************************************************************}
procedure TFNovaOrdemProducao.EProdutoSelect(Sender: TObject);
begin
  EProduto.ASelectValida.Text := 'Select * from CADPRODUTOS Where '+Varia.CodigoProduto + ' = ''@'' and C_ATI_PRO = ''S''';
  EPRoduto.ASelectLocaliza.Text := 'Select * from CADPRODUTOS Where C_NOM_PRO like  ''@%'' and C_ATI_PRO = ''S''';
end;

{******************************************************************************}
procedure TFNovaOrdemProducao.CarTituloGrade;
begin
  if VprDOrdem.TipTear = 0 then //tear convencial
    FunOrdemProducao.ConfigGradeTearConvencional(VprDOrdem,GCombinacoes)
  else
    FunOrdemProducao.ConfigGradeTearH(VprDOrdem,GCombinacoes);

  if VprDOrdem.TipTear = 0 then //tear convencial
    FunOrdemProducao.ConfigGradeTearConvencional(VprDOrdem,GColeta)
  else
    FunOrdemProducao.ConfigGradeTearH(VprDOrdem,GColeta);
  GColeta.Cells[6,0] := 'Qtd Produzido';
  GColeta.Cells[7,0] := 'Saldo Produzir';
end;

{******************************************************************************}
procedure TFNovaOrdemProducao.PosHistoricoColeta(VpaEmpFil, VpaSeqOrdem : String);
begin
  Coleta.Sql.Clear;
  Coleta.Sql.Add('select COP.DATCOL, COP.INDFIN, USU.C_NOM_USU , '+
                               ' COI.CODCOM, COI.CODMAN, COI.NROFIT, COI.METAPR, COI.METCOL,  COI.METFAL ' +
                               ' from COLETAOPCORPO COP , COLETAOPITEM COI, CADUSUARIOS USU '+
                               ' WHERE COP.EMPFIL = COI.EMPFIL '  +
                               ' AND COP.SEQORD = COI.SEQORD ' +
                               ' AND COP.SEQCOL = COI.SEQCOL ' +
                               ' AND COP.CODUSU = USU.I_COD_USU ' +
                               ' and COP.EMPFIL = ' + VpaEmpFil +
                               ' AND COP.SEQORD = ' + VpaSeqOrdem+' '#13);
  Coleta.Sql.Add(' order by COP.DATCOL');
  Coleta.Open;
end;

{******************************************************************************}
procedure TFNovaOrdemProducao.PosRevisaoExterna(VpaEmpFil, VpaSeqOrdem : String);
begin
  ColetaOPCorpo.Sql.Clear;
  ColetaOPCorpo.Sql.Add('select OPC.EMPFIL, OPC.SEQORD, OPC.SEQCOL, OPC.DATCOL,'+
                        ' OPC.INDFIN, OPC.INDREP, ' +
                        ' PRO.C_NOM_PRO, '+
                        ' OP.UNMPED, OP.CODPRO, USU.C_NOM_USU, OPE.DATREV, OPE.CODUSU '+
                        ' from coletaopcorpo opc, ORDEMPRODUCAOCORPO OP, '+
                        ' CADPRODUTOS PRO, REVISAOOPEXTERNA OPE, CADUSUARIOS USU'+
                        ' Where OPC.EMPFIL = '+VpaEmpFil+
                        ' and OPC.SEQORD = '+ VpaSeqOrdem +
                        ' AND OPC.EMPFIL = OP.EMPFIL'+
                        ' AND OPC.SEQORD = OP.SEQORD'+
                        ' AND OP.SEQPRO = PRO.I_SEQ_PRO'+
                        ' AND OPE.EMPFIL = OPC.EMPFIL '+
                        ' AND OPE.SEQORD = OPC.SEQORD '+
                        ' AND OPE.SEQCOL = OPC.SEQCOL '+
                        ' AND USU.I_COD_USU = OPE.CODUSU');
  ColetaOPCorpo.Sql.Add('Order by DATCOL');
  ColetaOpCorpo.Open;
end;

{******************************************************************************}
procedure TFNovaOrdemProducao.PosRevisaoExternaItem(VpaEmpFil,VpaSeqOrdem,VpaSeqColeta : String);
begin
  if VpaEmpFil <> '' then
  begin
    ColetaOPItem.Sql.Clear;
    ColetaOpItem.Sql.Add('select OPI.CODCOM,OPI.CODMAN, OPI.NROFIT, OPI.METCOL'+
                           ' from COLETAOPITEM OPI '+
                           ' Where EMPFIL = '+ VpaEmpFil+
                           ' and SEQORD = '+VpaSeqOrdem+
                           ' and SEQCOL = ' + VpaSeqColeta);
    ColetaOpItem.Open;
  end;
end;

{******************************************************************************}
procedure TFNovaOrdemProducao.PosMetrosFaturados(VpaEmpfil,VpaSeqOrdem : String);
begin
  if VpaEmpFil <> '' then
  begin
    MetroFaturado.Sql.clear;
    MetroFaturado.Sql.add('select NOTA.I_NRO_NOT, NOTA.D_DAT_EMI, NOTA.T_HOR_SAI, COL.CODCOM, COL.CODMAN, COL.METCOL '+
                          ' FROM METROFATURADOITEM FAT, ROMANEIOITEM ROM, COLETAOPITEM COL, CADNOTAFISCAIS NOTA ' +
                          ' WHERE ROM.EMPFIL = FAT.EMPFIL '+
                          ' AND ROM.SEQROM = FAT.SEQROM '+
                          ' AND COL.EMPFIL = ROM.EMPFIL '+
                          ' AND COL.SEQORD = ROM.SEQORD '+
                          ' AND COL.SEQCOL= ROM.SEQCOL ' +
                          ' AND COL.EMPFIL = '+VpaEmpfil+
                          ' AND COL.SEQORD = ' + VpaSeqOrdem+
                          ' AND FAT.FILNOT = NOTA.I_EMP_FIL '+
                          ' AND FAT.SEQNOT = NOTA.I_SEQ_NOT ');
    MetroFaturado.Sql.Add(VprOrdemMetroFaturado);
    MetroFaturado.Open;
  end;
end;

{******************************************************************************}
procedure TFNovaOrdemProducao.CarDClasse;
begin
  with VprDOrdem do
  begin
    DatEmissao :=EDatEmissao.DateTime;
    DatEntrega := EDatEntrega.Datetime;
    DatEntregaPrevista := EDatEntrega.DateTime;
    NumPedido := EPedido.AsInteger;
    NroOPCliente := ENroOPCliente.AsInteger;
    TipPedido := ETipoPedido.ItemIndex;
    TipTear := ETipoTear.ItemIndex;
    CodCliente := ECliente.AInteiro;
    CodProduto := EProduto.Text;
    CodMotivoReprogramacao := EMotivoReprogramacao.AInteiro;
    CodMaquina := EMaquina.AInteiro;
    SeqProduto := VprDProduto.SeqProduto;
    TotMetros := ETotalMetros.AsInteger;
    PerAcrescimo := EPerAcrescimo.AsInteger;
    MetFita := EMetrosFita.AValor;
    ValUnitario := EValUnitario.AValor;
    HorProducao := EHorasProducao.Text;
    UMPedido := EUMPedido.Text;
    DesObservacoes := EObservacoes.Lines.Text;
    IndProdutoNovo := EProdutoNovo.Text;
    CodTipoCorte := ETipoCorte.AInteiro;
    CodProgramador := EProgramador.AInteiro;
  end;
end;

{******************************************************************************}
procedure TFNovaOrdemProducao.CarDOrdemItem;
begin
  VprDOrdemItem.CodCombinacao := StrToInt(GCombinacoes.Cells[1,GCombinacoes.Alinha]);
  if GCombinacoes.Cells[2,GCombinacoes.Alinha] <> '' then
    VprDOrdemItem.CodManequim := GCombinacoes.Cells[2,GCombinacoes.Alinha]
  else
    VprDOrdemItem.CodManequim := '';
  VprDOrdemItem.QtdEtiquetas := StrToInt(GCombinacoes.Cells[3,GCombinacoes.Alinha]);
  VprDOrdemItem.QtdFitas := StrToInt(GCombinacoes.Cells[4,GCombinacoes.Alinha]);
  VprDOrdemItem.MetrosFita := StrToFloat(GCombinacoes.Cells[5,GCombinacoes.Alinha]);

  if VprDOrdem.TipTear = 0 then
    CalculaMetrosFitaCombinacao
  else
    CalculaPecasFitaCombinacao;

  FunOrdemProducao.CalculaTotaisMetros(VprDOrdem,VprDProduto);
  ETotalMetros.AValor := VprDOrdem.TotMetros;
  if VprDOrdem.TipTear = 0 then //tear convencional
    EMetrosFita.AValor := VprDOrdem.MetFita
  else
    EMetrosFita.AValor := 0;
  CalculaHorasProducao;
end;

{******************************************************************************}
procedure TFNovaOrdemProducao.CarDTela;
begin
  with VprDOrdem do
  begin
    EDatEmissao.DateTime := DatEmissao;
    EDatEntrega.Datetime := DatEntregaPrevista;
    EPedido.AsInteger := NumPedido;
    ENroOPCliente.AsInteger := NroOPCliente;
    ETipoPedido.ItemIndex := TipPedido;
    ETipoTear.ItemIndex := TipTear;
    ECliente.AInteiro := CodCliente;
    ECliente.Atualiza;
    EProduto.Text := RetornaCodPro(SeqProduto);
    EProgramador.AInteiro := CodProgramador;
    EProgramador.Atualiza;

    EMotivoReprogramacao.AInteiro := CodMotivoReprogramacao;
    EMotivoReprogramacao.Atualiza;
    EProduto.Atualiza;
    ETipoCorte.AInteiro := CodTipoCorte;
    EMaquina.AInteiro := CodMaquina;
    EMaquina.Atualiza;
    ETotalMetros.AValor := TotMetros;
    EPerAcrescimo.AsInteger := PerAcrescimo;
    EMetrosFita.Avalor := MetFita;
    EQtdFitas.AsInteger := QtdFita;
    EHorasProducao.Text := HorProducao;
    EValUnitario.AValor := ValUnitario;
    EUMPedido.ItemIndex := EUMPedido.Items.IndexOf(UMPedido);
    EObservacoes.Lines.Text := DesObservacoes;
    EProdutoNovo.Text := IndProdutoNovo;
    VprUMPedidoAnterior := UMPedido;
    VprTearAnterior := TipTear;
  end;
  GCombinacoes.CarregaGrade;
end;

{******************************************************************************}
procedure TFNovaOrdemProducao.carProdutoTela(VpaDProduto : TRBDProduto);
begin
  ELargura.AsInteger := VpaDProduto.LarProduto;
  EComprimento.AsInteger := VpaDProduto.CmpProduto;
  EFigura.AsInteger := VpaDProduto.CmpFigura;
  EPrateleira.Text := VpaDProduto.PraProduto;
  ENumFios.Text := VpaDProduto.NumFios;
  EPente.Text := VpaDProduto.Pente;
  EBatidas.Text := VpaDProduto.BatProduto;
  EBatidasTear.Text := VpaDProduto.NumBatidasTear;
  ETipoEmenda.AInteiro := VpaDProduto.CodTipoEmenda;
  ETipoEmenda.Atualiza;
  ECalandragem.Text := VpaDProduto.IndCalandragem;
  EEngomagem.Text := VpaDProduto.IndEngomagem;
  ETipoFundo.AInteiro := VpaDProduto.CodTipoFundo;
  ETipoFundo.Atualiza;
  EObservacoes.Lines.Text := VpaDProduto.DesObservacao;
  if VprDOrdem.CodTipoCorte = 0 then
    ETipoCorte.AInteiro := VpaDProduto.CodTipoCorte;
  ETipoCorte.Atualiza;
  if VpaDProduto.CodTipoCorte = 22 then
    EUMPedido.ItemIndex := 1
  else
    EUMPedido.ItemIndex := 0;
  EUMPedidoExit(eumPedido);
end;

{******************************************************************************}
procedure TFNovaOrdemProducao.LimpaDadosTela;
begin
  ScrollBox1.HorzScrollBar.Position := 0;
  EDatEmissao.DateTime := now;
  EDatEntrega.DateTime :=now;
  EMotivoReprogramacao.AInteiro := 0;
  EProduto.Text        := '';
  EProduto.Atualiza;
  EPerAcrescimo.AValor := 5;
  EUMPedido.ItemIndex := 0;
  ELargura.Clear;
  EComprimento.Clear;
  EFigura.Clear;
  EPrateleira.Clear;
  ENumFios.Clear;
  EPente.Clear;
  EBatidas.Clear;
  EBatidasTear.Clear;
  ETipoEmenda.Clear;
  ETipoEmenda.Atualiza;
  ECalandragem.Clear;
  EEngomagem.Clear;
  ETipoFundo.Clear;
  ETipoFundo.Atualiza;
  EObservacoes.Clear;

  VprSeqProdutoAnterior := 0;
  VprDOrdem.SeqOrdem := 0;
  VprDOrdem.CodEstagio := Varia.EstagioOrdemProducao;
  if config.EstoqueCentralizado then
    VprDOrdem.CodEmpresafilial := varia.CodFilialControladoraEstoque
  else
    VprDOrdem.CodEmpresafilial := Varia.CodigoEmpFil;

  with VprDOrdem do
  begin
    DatEmissao := now;
    DatEntregaPrevista := date;
    EProgramador.AInteiro := varia.CodigoUsuario;
    EProgramador.Atualiza;
    NumPedido := 0;
    NroOPCliente := 0;
    TipPedido := 1;
    TipTear := 0;
    CodCliente := 11024;
    CodProduto := '';
    CodMaquina := 0;
    CodTipoCorte := 0;
    CodMotivoReprogramacao := 0;
    SeqProduto := 0;
    TotMetros := 0;
    PerAcrescimo := 5;
    MetFita := 0;
    ValUnitario := 0;
    HorProducao := '';
    UMPedido := 'PC';
    VprUMPedidoAnterior := 'PC';
    DesObservacoes := '';
    IndProdutoNovo := 'N';
    FreeTObjectsList(Items);
    VprDOrdemItem := nil;
    GCombinacoes.CarregaGrade;
    CarTituloGrade;
  end;
  GCombinacoes.Col := 1;
  CarDTela;
end;

procedure TFNovaOrdemProducao.Cadastrar;
begin
  ScrollBox1.VertScrollBar.Position := 0;
  VprStatusCadastro := scInserindo;
  EMaquina.ACampoObrigatorio := false;
  AtualizaEnableBotoes;
  LimpaDadosTela;
end;

{******************************************************************************}
procedure TFNovaOrdemProducao.CalculaMetrosFitaCombinacao;
begin
  if (VprDOrdemItem.QtdFitas > 0) and (VprDOrdemItem.QtdEtiquetas > 0) then
  begin
    if UpperCase(VprDOrdem.UMPedido) = 'PC' then
      VprDOrdemItem.MetrosFita := (((VprDOrdemItem.QtdEtiquetas * VprDProduto.CmpProduto)/1000)/VprDOrdemItem.QtdFitas)
    else
      VprDOrdemItem.MetrosFita := (VprDOrdemItem.QtdEtiquetas / VprDOrdemItem.QtdFitas);
    VprDOrdemItem.MetrosFita :=   FunOrdemProducao.ArredondaMetroFita(VprDOrdemItem.MetrosFita + ((VprDOrdemItem.MetrosFita * EPerAcrescimo.AValor)/100));
  end
  else
    VprDOrdemItem.MetrosFita := 0;
  GCombinacoes.Cells[5,GCombinacoes.ALinha] := FormatFloat('0.0',VprDOrdemItem.MetrosFita);
end;

{******************************************************************************}
procedure TFNovaOrdemProducao.CalculaPecasFitaCombinacao;
begin
  if (VprDOrdemItem.QtdFitas > 0) and (VprDOrdemItem.QtdEtiquetas > 0) then
  begin
    if UpperCase(VprDOrdem.UMPedido) = 'PC' then
      VprDOrdemItem.MetrosFita := (VprDOrdemItem.QtdEtiquetas / VprDOrdemItem.QtdFitas)
    else
      VprDOrdemItem.MetrosFita := (((VprDOrdemItem.QtdEtiquetas / VprDProduto.CmpProduto)*1000)/VprDOrdemItem.QtdFitas);
    VprDOrdemItem.MetrosFita :=   FunOrdemProducao.ArredondaMetroFita(VprDOrdemItem.MetrosFita + ((VprDOrdemItem.MetrosFita * EPerAcrescimo.AValor)/100));
  end
  else
    VprDOrdemItem.MetrosFita := 0;
  VprDOrdemItem.MetrosFita := trunc(VprDOrdemItem.MetrosFita);
  GCombinacoes.Cells[5,GCombinacoes.ALinha] := FormatFloat('0',VprDOrdemItem.MetrosFita);
end;

{******************************************************************************}
procedure TFNovaOrdemProducao.CalculaHorasProducao;
begin
  EHorasProducao.text := FunOrdemProducao.RQtdHoras(VprDOrdem,VprDProduto);
end;

{******************************************************************************}
procedure TFNovaOrdemProducao.VerificaEstoque;
begin
  if FunOrdemProducao.ExisteEstoqueCombinacao(VprDProduto.SeqProduto) then
  begin
    FMostraEstoqueProdutoCor := TFMostraEstoqueProdutoCor.CriarSDI(application,'', FPrincipal.VerificaPermisao('FMostraEstoqueProdutoCor'));
    FMostraEstoqueProdutoCor.MostraEstoque(VprDProduto.SeqProduto);
    FMostraEstoqueProdutoCor.free;
  end;
end;

{******************************************************************************}
procedure TFNovaOrdemProducao.NovaOrdem;
begin
  Cadastrar;
  PColetas.TabVisible := false;
  Self.ShowModal;
end;

{******************************************************************************}
procedure TFNovaOrdemProducao.ConsultaOrdem(VpaEmpFil, VpaSeqOrdem : Integer);
begin
  VprStatusCadastro := scConsultando;
  AtualizaEnableBotoes;
  VprDOrdem.CodEmpresafilial := VpaEmpFil;
  VprDOrdem.SeqOrdem := VpaSeqOrdem;
  FunOrdemProducao.CarDOrdemProducao(VprDOrdem);
  VprDProduto.SeqProduto := VprDOrdem.SeqProduto;
  FunProduto.CarDProduto(VprDProduto);
  CarDTela;
  carProdutoTela(VprDProduto);
  AlterarEnabledDet([BGravar,BCancelar],false);
  AtualizaLocalizas([ECliente,EProduto,EMaquina,ETipoCorte]);
  GCombinacoes.ADados := VprDOrdem.Items;
  GCombinacoes.CarregaGrade;
  GColeta.ADados := VprDOrdem.Items;
  GColeta.CarregaGrade;
  CarTituloGrade;
  PosHistoricoColeta(IntToStr(VpaEmpFil),IntToStr(VpaSeqOrdem));
  Showmodal;
end;

{******************************************************************************}
procedure TFNovaOrdemProducao.AlteraOrdem(VpaCodFilial, VpaSeqOrdem : Integer);
begin
  VprStatusCadastro := scConsultando;
  VprDOrdem.CodEmpresafilial := VpaCodFilial;
  VprDOrdem.SeqOrdem := VpaSeqOrdem;
  FunOrdemProducao.CarDOrdemProducao(VprDOrdem);
  VprDProduto.SeqProduto := VprDOrdem.SeqProduto;
  FunProduto.CarDProduto(VprDProduto);
  CarDTela;
  carProdutoTela(VprDProduto);
  AtualizaLocalizas([ECliente,EProduto,EMaquina,ETipoCorte]);
  GCombinacoes.ADados := VprDOrdem.Items;
  GCombinacoes.CarregaGrade;
  GColeta.ADados := VprDOrdem.Items;
  GColeta.CarregaGrade;
  CarTituloGrade;
  PosHistoricoColeta(IntToStr(VpaCodfilial),IntToStr(VpaSeqOrdem));
  VprStatusCadastro := scAlterando;
  AtualizaEnableBotoes;
  Showmodal;
end;

{******************************************************************************}
procedure TFNovaOrdemProducao.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFNovaOrdemProducao.BGravarClick(Sender: TObject);
var
  VpfResultado : String;
begin
  CarDClasse;
  if VprStatusCadastro = scAlterando then
    VerificaEstoque;
  VpfResultado := FunOrdemProducao.GravaOrdemProducao(VprDOrdem);
  if Vpfresultado = '' then
  begin
    VprStatusCadastro := scConsultando;
    AtualizaEnableBotoes;
  end
  else
    aviso(VpfResultado);
end;

{******************************************************************************}
procedure TFNovaOrdemProducao.BCancelarClick(Sender: TObject);
begin
  if confirmacao('Tem certeza que deseja cancelar essa operação?') then
  begin
    LimpaDadosTela;
    VprStatusCadastro := scConsultando;
    AtualizaEnableBotoes;
  end;
end;

{******************************************************************************}
procedure TFNovaOrdemProducao.EProdutoRetorno(Retorno1, Retorno2: String);
begin
  if VprStatusCadastro in [scinserindo,scAlterando] then
  begin
    if Retorno1 <> '' then
    begin
      if VprSeqProdutoAnterior <> StrtoInt(Retorno1) then
      begin
        VprSeqProdutoAnterior := StrtoInt(Retorno1);
        VprDProduto.SeqProduto := StrtoInt(Retorno1);
        FunProduto.CarDProduto(VprDProduto);
        carProdutoTela(VprDProduto);
        FreeTObjectsList(VprDOrdem.Items);
        GCombinacoes.CarregaGrade;
        CalculaHorasProducao;
        VerificaEstoque;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaOrdemProducao.EProdutoCadastrar(Sender: TObject);
begin
  FNovoProdutoPro := TFNovoProdutoPro.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoProdutoPro'));
  FNovoProdutoPro.NovoProduto('');
  FNovoProdutoPro.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovaOrdemProducao.SpeedButton2Click(Sender: TObject);
begin
  FNovoProdutoPro := TFNovoProdutoPro.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoProdutoPro'));
  FNovoProdutoPro.AlterarProduto(varia.codigoEmpresa,varia.CodigoEmpFil,VprDProduto.SeqProduto);
  FNovoProdutoPro.free;
  FunProduto.CarDProduto(VprDProduto);
  carProdutoTela(VprDProduto);
end;

procedure TFNovaOrdemProducao.EProdutoChange(Sender: TObject);
begin
  if VprStatusCadastro in [scInserindo,scAlterando] then
    ValidaGravacao1.execute;
end;

{******************************************************************************}
procedure TFNovaOrdemProducao.EMaquinaCadastrar(Sender: TObject);
begin
  FTipoCorte := TFTipoCorte.CriarSDI(application , '', FPrincipal.VerificaPermisao('FTipoCorte'));
  FTipoCorte.BotaoCadastrar1.Click;
  FTipoCorte.showmodal;
  FTipoCorte.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovaOrdemProducao.EClienteCadastrar(Sender: TObject);
begin
  FNovoCliente := tFNovoCliente.criarSDI(Application,'',FPrincipal.verificaPermisao('FNovoCliente'));
  FNovoCliente.CadClientes.Insert;
  FNovoCliente.ShowModal;
  FNovoCliente.Free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovaOrdemProducao.ETotalMetrosChange(Sender: TObject);
begin
  if (ETotalMetros.AValor <> 0) and (VprDOrdem.QtdFita <> 0) then
    EMetrosFita.AValor := ArredondaDecimais(((ETotalMetros.AValor + (ETotalMetros.AValor * (EPerAcrescimo.AValor /100)))  / VprDOrdem.QtdFita),2)
  else
    EMetrosFita.AValor := 0;
  CalculaHorasProducao;    
end;

{******************************************************************************}
procedure TFNovaOrdemProducao.EMaquinaRetorno(Retorno1, Retorno2: String);
begin
  if retorno1 <> '' then
    VprDOrdem.QtdFita := StrToInt(retorno1)
  else
    VprDOrdem.QtdFita := 0;
  EQtdFitas.AValor := VprDOrdem.QtdFita;

  if Retorno2 <> '' then
    VprDOrdem.QtdRPMMaquina := StrtoInt(Retorno2)
  else
    VprDOrdem.QtdRPMMaquina := 0;
  CalculaHorasProducao;
end;

{******************************************************************************}
procedure TFNovaOrdemProducao.EQtdFitasExit(Sender: TObject);
begin
  if EQtdFitas.AsInteger <> VprDOrdem.QtdFita then
  begin
    VprDOrdem.QtdFita := EQtdFitas.AsInteger;
    ETotalMetrosChange(EQtdFitas);
  end;
end;

{******************************************************************************}
procedure TFNovaOrdemProducao.SpeedButton7Click(Sender: TObject);
begin
  editorImagem1.execute(varia.DriveFoto + VprDProduto.PatFoto);
end;

{******************************************************************************}
procedure TFNovaOrdemProducao.GCombinacoesCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDOrdemItem := TRBDOrdemProducaoItem(VprDOrdem.Items[VpaLinha-1]);
  if VprDOrdemItem.CodCombinacao <> 0 then
    GCombinacoes.Cells[1,VpaLinha] := IntToStr(VprDOrdemItem.CodCombinacao)
  else
    GCombinacoes.Cells[1,VpaLinha] := '';
  GCombinacoes.Cells[2,VpaLinha] := VprDOrdemItem.CodManequim;
  if VprDOrdemItem.QtdEtiquetas <> 0 then
    GCombinacoes.Cells[3,VpaLinha] := IntToStr(VprDOrdemItem.QtdEtiquetas)
  else
    GCombinacoes.Cells[3,VpaLinha] := '';
  if VprDOrdemItem.QtdFitas <> 0 then
    GCombinacoes.Cells[4,VpaLinha] := IntToStr(VprDOrdemItem.QtdFitas)
  else
    GCombinacoes.Cells[4,VpaLinha] := '';
  if VprDOrdemItem.MetrosFita <> 0 then
    GCombinacoes.Cells[5,VpaLinha] := FormatFloat('0.0',VprDOrdemItem.MetrosFita)
  else
    GCombinacoes.Cells[5,VpaLinha] := '';
end;

{******************************************************************************}
procedure TFNovaOrdemProducao.GCombinacoesDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
var
  VpfTextoEstoque : String;
begin
  vpaValidos := false;
  if GCombinacoes.Cells[1,GCombinacoes.ALinha] = '' then
  begin
    Aviso('COMBINAÇÃO NÃO PREENCHIDA!!!'#13'Não foi preenchido o código da combinação.');
    GCombinacoes.Col := 1;
  end
  else
    if GCombinacoes.Cells[3,GCombinacoes.ALinha] = '' then
    begin
      Aviso('QUANTIDADE DE ETIQUETAS NÃO PREENCHIDA!!!'#13'Não foi preenchido a quantidade da combinação.');
      GCombinacoes.Col := 3;
    end
    else
      if GCombinacoes.Cells[4,GCombinacoes.ALinha] = '' then
      begin
        Aviso('QUANTIDADE FITAS NÃO PREENCHIDA!!!'#13'Não foi preenchido a quantidade de fitas do tear');
        GCombinacoes.Col := 4;
      end
      else
        if GCombinacoes.Cells[5,GCombinacoes.ALinha] = '' then
        begin
          Aviso('METROS POR FITA PREENCHIDO!!!'#13'Não foi preenchido a quantidade de metros por fitas');
          GCombinacoes.Col := 4;
        end
        else
          VpaValidos := true;
  if VpaValidos then
  begin
    CarDOrdemItem;
    if  VprDOrdemItem.CodCombinacao = 0 then
    begin
      Aviso('COMBINAÇÃO NÃO PREENCHIDA!!!'#13'Não foi preenchido o código da combinação.');
      GCombinacoes.Col := 1;
      VpaValidos := false;
    end
    else
      if  VprDOrdemItem.QtdEtiquetas = 0 then
      begin
        Aviso('QUANTIDADE DE ETIQUETAS NÃO PREENCHIDA!!!'#13'Não foi preenchido a quantidade da combinação.');
        GCombinacoes.Col := 3;
        VpaValidos := false;
      end
      else
        If  VprDOrdemItem.QtdFitas = 0 then
        begin
          Aviso('QUANTIDADE FITAS NÃO PREENCHIDA!!!'#13'Não foi preenchido a quantidade de fitas do tear');
          GCombinacoes.Col := 3;
          VpaValidos := false;
        end
        else
          If  VprDOrdemItem.MetrosFita = 0 then
          begin
            Aviso('METROS POR FITA PREENCHIDO!!!'#13'Não foi preenchido a quantidade de metros por fitas');
            GCombinacoes.Col := 3;
            VpaValidos := false;
          end;
    if VpaValidos then
    begin
      VpaValidos := FunProduto.ExisteCombinacao(VprDProduto.SeqProduto,VprDOrdemItem.CodCombinacao);
      if not VpaValidos then
      begin
        Aviso('COMBINAÇÃO INVÁLIDA!!!'#13'Combinação "'+IntToStr(VprDOrdemItem.CodCombinacao)+'" não cadastrada.');
        GCombinacoes.Col := 1;
      end;
      if VpaValidos then
      begin
        VpfTextoEstoque :=  FunProduto.ExisteEstoqueCor(VprDProduto.SeqProduto,VprDOrdemItem.CodCombinacao);
        if VpfTextoEstoque <> '' then
          aviso(VpfTextoEstoque); 

        if FunOrdemProducao.CombinacaoManequimDuplicado(VprDOrdem) then
        begin
          VpaValidos := false;
          Aviso('COMBINAÇÃO MANEQUIM DUPLICADO!!!'#13'Já existe cadastrado esse manequim e combinação para essa ordem de produção.');
          GCombinacoes.Col := 1;
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaOrdemProducao.GCombinacoesGetEditMask(Sender: TObject;
  ACol, ARow: Integer; var Value: String);
begin
  case ACol of
    1 :  Value := '000;0; ';
    3 :  Value := '0000000;0; ';
    4 :  Value := '0000000;0; ';
  end;
end;

{******************************************************************************}
procedure TFNovaOrdemProducao.GCombinacoesMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDOrdem.Items.Count >0 then
  begin
    VprDOrdemItem := TRBDOrdemProducaoItem(VprDOrdem.Items[VpaLinhaAtual-1]);
  end;

end;

{******************************************************************************}
procedure TFNovaOrdemProducao.GCombinacoesNovaLinha(Sender: TObject);
begin
  VprDOrdemItem := VprDOrdem.AddItems;
  VprDOrdemItem.QtdFitas := VprDOrdem.QtdFita;
end;

{******************************************************************************}
procedure TFNovaOrdemProducao.BImpOPClick(Sender: TObject);
begin
  FunRave.ImprimeOrdemProducaoEtikArt(VprDOrdem,true);
end;

{******************************************************************************}
procedure TFNovaOrdemProducao.BCadastrarClick(Sender: TObject);
begin
  Cadastrar;
end;

{******************************************************************************}
procedure TFNovaOrdemProducao.GCombinacoesSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if GCombinacoes.AEstadoGrade in [egInsercao,EgEdicao] then
    if GCombinacoes.AColuna <> ACol then
    begin
      case GCombinacoes.AColuna of
        3,4 :
             begin
               if GCombinacoes.Cells[3,GCombinacoes.ALinha] <> '' then
                 VprDOrdemItem.QtdEtiquetas := StrToInt(GCombinacoes.Cells[3,GCombinacoes.ALinha])
               else
                 VprDOrdemItem.QtdEtiquetas := 0;
               if GCombinacoes.Cells[4,GCombinacoes.ALinha] <> '' then
                 VprDOrdemItem.QtdFitas :=  StrToInt(GCombinacoes.Cells[4,GCombinacoes.ALinha])
               else
                 VprDOrdemItem.QtdFitas := 0;
               if VprDOrdem.TipTear = 0 then
                 CalculaMetrosFitaCombinacao
               else
                 CalculaPecasFitaCombinacao;
             end;
      end;
    end;

end;

procedure TFNovaOrdemProducao.GCombinacoesKeyPress(Sender: TObject;
  var Key: Char);
begin
  if GCombinacoes.Col = 2 then
    key := UpCase(key)
  else
    if (key = '.') then
      key := ',';
end;

{******************************************************************************}
procedure TFNovaOrdemProducao.GCombinacoesDepoisExclusao(Sender: TObject);
begin
  FunOrdemProducao.CalculaTotaisMetros(VprDOrdem,VprDProduto);
  ETotalMetros.AValor := VprDOrdem.TotMetros;
  if VprDOrdem.TipTear = 0 then //tear convencional
    EMetrosFita.AValor := VprDOrdem.MetFita
  else
    if VprDOrdem.TipTear = 1 then //tear H
      EMetrosFita.AValor := VprDOrdem.MetFita
    else
      EMetrosFita.AValor := 0;
end;

{******************************************************************************}
procedure TFNovaOrdemProducao.EUMPedidoExit(Sender: TObject);
begin
  if VprStatusCadastro in [scinserindo,scAlterando] then
  begin
    if VprUMPedidoAnterior <> EUMPedido.Text then
    begin
      VprUMPedidoAnterior := EUMPedido.Text;
      VprDOrdem.UMPedido := EUMPedido.Text;
      CarTituloGrade;
      FreeTObjectsList(VprDOrdem.Items);
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaOrdemProducao.GCombinacoesEnter(Sender: TObject);
begin
  CarTituloGrade;
end;

procedure TFNovaOrdemProducao.ETipoTearExit(Sender: TObject);
begin
  if VprStatusCadastro in [scinserindo,scAlterando] then
  begin
    if VprTearAnterior <> ETipoTear.ItemIndex then
    begin
      VprTearAnterior := ETipoTear.ItemIndex;
      VprDOrdem.TipTear := ETipoTear.ItemIndex;
      CarTituloGrade;
      FreeTObjectsList(VprDOrdem.Items);
    end;
  end;

end;

procedure TFNovaOrdemProducao.GColetaCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDOrdemItem := TRBDOrdemProducaoItem(VprDOrdem.Items[VpaLinha-1]);
  GColeta.Cells[1,VpaLinha] := IntToStr(VprDOrdemItem.CodCombinacao);
  GColeta.Cells[2,VpaLinha] := VprDOrdemItem.CodManequim;
  GColeta.Cells[3,VpaLinha] := IntToStr(VprDOrdemItem.QtdEtiquetas);
  GColeta.Cells[4,VpaLinha] := IntToStr(VprDOrdemItem.QtdFitas);
  GColeta.Cells[5,VpaLinha] := FormatFloat('0.0',VprDOrdemItem.MetrosFita);
  GColeta.Cells[6,VpaLinha] := FormatFloat('0.0',VprDOrdemItem.QtdProduzido);
  GColeta.Cells[7,VpaLinha] := FormatFloat('0.0',VprDOrdemItem.QtdFaltante);
end;

{******************************************************************************}
procedure TFNovaOrdemProducao.EMotivoReprogramacaoCadastrar(
  Sender: TObject);
begin
  FMotivoReprogramacao := TFMotivoReprogramacao.CriarSDI(application , '', FPrincipal.VerificaPermisao('FMotivoReprogramacao'));
  FMotivoReprogramacao.BotaoCadastrar1.Click;
  FMotivoReprogramacao.Showmodal;
  FMotivoReprogramacao.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovaOrdemProducao.EProdutoNovoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (key <> 'S')and (key <> 'N') and (key <> 's') and (key <> 'n') then
    key := #0;
end;

{******************************************************************************}
procedure TFNovaOrdemProducao.ColetaOPCorpoAfterScroll(DataSet: TDataSet);
begin
  if ColetaOPCorpoEMPFIL.AsInteger <> 0 then
    PosRevisaoExternaItem(ColetaOPCorpoEMPFIL.AsString,ColetaOPCorpoSEQORD.AsString,ColetaOPCorpoSEQCOL.AsString);
end;

procedure TFNovaOrdemProducao.PageControl1Change(Sender: TObject);
begin
  if PageControl1.ActivePage = PRevisaoExterna then
    PosRevisaoExterna(IntToStr(VprDOrdem.CodEmpresafilial),IntToStr(VprDOrdem.SeqOrdem))
  else
    if PageControl1.ActivePage = PMetroFaturado then
      PosMetrosFaturados(IntToStr(VprDOrdem.CodEmpresafilial),IntToStr(VprDOrdem.SeqOrdem));
end;

{******************************************************************************}
procedure TFNovaOrdemProducao.GradeMetrosFaturadosOrdem(Ordem: String);
begin
  VprOrdemMetroFaturado := Ordem;
end;


{******************************************************************************}
procedure TFNovaOrdemProducao.GCombinacoesKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then
    ActiveControl:= EValUnitario;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovaOrdemProducao]);
end.
