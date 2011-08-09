unit AOrdemProducaoGenerica;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Grids, DBGrids, Tabela, DBKeyViolation, Componentes1,
  ExtCtrls, PainelGradiente, Db, DBTables, Localizacao, Mask, numericos,
  ComCtrls, UnOrdemProducao, UnClientes, UnDadosProduto, Menus, ImgList, UnSolicitacaoCompra, UnProdutos,
  CGrades, DBClient, UnRave, UnDados, UnZebra, SqlExpr;

type
  TFOrdemProducaoGenerica = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BCadastrar: TBitBtn;
    BAlterar: TBitBtn;
    BConsultar: TBitBtn;
    BExcluir: TBitBtn;
    BImprimir: TBitBtn;
    BFichaConsumo: TBitBtn;
    BFechar: TBitBtn;
    OrdemProducao: TSQL;
    OrdemProducaoEMPFIL: TFMTBCDField;
    OrdemProducaoSEQORD: TFMTBCDField;
    OrdemProducaoDATEMI: TSQLTimeStampField;
    OrdemProducaoDATENP: TSQLTimeStampField;
    OrdemProducaoDATENT: TSQLTimeStampField;
    OrdemProducaoNUMPED: TFMTBCDField;
    OrdemProducaoC_NOM_CLI: TWideStringField;
    OrdemProducaoNOM_COR: TWideStringField;
    OrdemProducaoNOMEST: TWideStringField;
    DataOrdemProducao: TDataSource;
    CPeriodo: TCheckBox;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    ENumeroOp: Tnumerico;
    Label7: TLabel;
    Label2: TLabel;
    EEstagio: TEditLocaliza;
    SpeedButton1: TSpeedButton;
    Label3: TLabel;
    Label4: TLabel;
    EPeriodoPor: TComboBoxColor;
    EPedido: Tnumerico;
    Label5: TLabel;
    EProduto: TEditLocaliza;
    Label8: TLabel;
    SpeedButton2: TSpeedButton;
    Label9: TLabel;
    Localiza: TConsultaPadrao;
    OrdemProducaoC_NOM_USU: TWideStringField;
    OrdemProducaoSEQFRACAO: TFMTBCDField;
    OrdemProducaoDATIMPRESSAOFICHA: TSQLTimeStampField;
    CFichaConsumo: TCheckBox;
    ECliente: TEditLocaliza;
    Label1: TLabel;
    SpeedButton3: TSpeedButton;
    Label6: TLabel;
    OrdemProducaoQTDPRODUTO: TFMTBCDField;
    CFracaoFinalizada: TCheckBox;
    OrdemProducaoDATENTREGA: TSQLTimeStampField;
    PopupMenu1: TPopupMenu;
    AlterarEstgiosProduto1: TMenuItem;
    OrdemProducaoI_SEQ_PRO: TFMTBCDField;
    OrdemProducaoPRODUTO: TWideStringField;
    OrdemProducaoQTDAFATURAR: TFMTBCDField;
    OrdemProducaoQTDREVISADO: TFMTBCDField;
    Label15: TLabel;
    SpeedButton6: TSpeedButton;
    Label16: TLabel;
    EFilial: TEditLocaliza;
    EFracao: Tnumerico;
    Label10: TLabel;
    BExcluiFracao: TBitBtn;
    N1: TMenuItem;
    ConsultarSolicitaoCompras1: TMenuItem;
    BImprimeOrdemCorte: TBitBtn;
    N2: TMenuItem;
    GeraOrdemCorte1: TMenuItem;
    N3: TMenuItem;
    ProdutosPendentes1: TMenuItem;
    BitBtn2: TBitBtn;
    N4: TMenuItem;
    MGerarConsumo: TMenuItem;
    Aux: TSQL;
    N5: TMenuItem;
    ConsultarOramentoCompra1: TMenuItem;
    PanelColor3: TPanelColor;
    PageControl1: TPageControl;
    PFracionada: TTabSheet;
    GridIndice1: TGridIndice;
    PSubMontagem: TTabSheet;
    Arvore: TTreeView;
    ImageList1: TImageList;
    FracaoOpSubMontagem: TSQL;
    BImprimeOrdemSerra: TBitBtn;
    PopupMenu2: TPopupMenu;
    EtiquetasOrdemSerra1: TMenuItem;
    N6: TMenuItem;
    GerarSolicitaoCompras1: TMenuItem;
    MArvore: TPopupMenu;
    AlterarDataEntrega1: TMenuItem;
    PLegenda: TPanelColor;
    Image1: TImage;
    Label11: TLabel;
    Image2: TImage;
    Label12: TLabel;
    Image3: TImage;
    Label13: TLabel;
    Label14: TLabel;
    Image4: TImage;
    Label17: TLabel;
    Image5: TImage;
    Image6: TImage;
    Label18: TLabel;
    Image7: TImage;
    Label19: TLabel;
    N7: TMenuItem;
    MLegenda: TMenuItem;
    N8: TMenuItem;
    PedidosdeCompra1: TMenuItem;
    N9: TMenuItem;
    ConsultarFrao1: TMenuItem;
    Label20: TLabel;
    EEstagioNaoProcesado: TEditLocaliza;
    SpeedButton4: TSpeedButton;
    Label21: TLabel;
    Label22: TLabel;
    SpeedButton5: TSpeedButton;
    Label23: TLabel;
    EMateriaPrima: TEditLocaliza;
    BFiltros: TBitBtn;
    AlterarEstagio1: TMenuItem;
    ConcluirFrao1: TMenuItem;
    Label24: TLabel;
    SpeedButton7: TSpeedButton;
    Label25: TLabel;
    ETipoEstagio: TEditLocaliza;
    PImpressao: TTabSheet;
    GImpressao: TRBStringGridColor;
    PanelColor4: TPanelColor;
    PopupMenu3: TPopupMenu;
    NumeroOP1: TMenuItem;
    N10: TMenuItem;
    AlterarCliente1: TMenuItem;
    EAlteraCliente: TRBEditLocaliza;
    N11: TMenuItem;
    ImprimirConsumo1: TMenuItem;
    PopupMenu4: TPopupMenu;
    SemQuebraPgina1: TMenuItem;
    ConsultaLogSeparao1: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    SomenteConsumoaReservar1: TMenuItem;
    N15: TMenuItem;
    MReimportarProjeto: TMenuItem;
    N16: TMenuItem;
    ReimportarFrao1: TMenuItem;
    N12: TMenuItem;
    ListaProdutosaExcluir1: TMenuItem;
    PainelTempo1: TPainelTempo;
    BImprimirEtiquetas: TBitBtn;
    BSolicitacaoCompras: TBitBtn;
    OrdemProducaoCODCOR: TFMTBCDField;
    OrdemProducaoC_COD_PRO: TWideStringField;
    OrdemProducaoC_NOM_PRO: TWideStringField;
    OrdemProducaoDESUM: TWideStringField;
    OrdemProducaoUMORIGINAL: TWideStringField;
    PImpressaoProduto: TTabSheet;
    GImpressaoProduto: TRBStringGridColor;
    PanelColor5: TPanelColor;
    N17: TMenuItem;
    AdicionarSubmontagememOPExistente1: TMenuItem;
    EProjeto: TRBEditLocaliza;
    SpeedButton8: TSpeedButton;
    Label26: TLabel;
    Label27: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure EProdutoRetorno(Retorno1, Retorno2: String);
    procedure EPedidoExit(Sender: TObject);
    procedure EEstagioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BFichaConsumoClick(Sender: TObject);
    procedure BConsultarClick(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure BExcluirClick(Sender: TObject);
    procedure BCadastrarClick(Sender: TObject);
    procedure BAlterarClick(Sender: TObject);
    procedure AlterarEstgiosProduto1Click(Sender: TObject);
    procedure BExcluiFracaoClick(Sender: TObject);
    procedure BImprimeOrdemCorteClick(Sender: TObject);
    procedure GeraOrdemCorte1Click(Sender: TObject);
    procedure ProdutosPendentes1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure MGerarConsumoClick(Sender: TObject);
    procedure ConsultarOramentoCompra1Click(Sender: TObject);
    procedure ConsultarSolicitaoCompras1Click(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure BImprimeOrdemSerraClick(Sender: TObject);
    procedure EtiquetasOrdemSerra1Click(Sender: TObject);
    procedure GerarSolicitaoCompras1Click(Sender: TObject);
    procedure ArvoreExpanded(Sender: TObject; Node: TTreeNode);
    procedure AlterarDataEntrega1Click(Sender: TObject);
    procedure TextoMove1Click(Sender: TObject);
    procedure PLegendaClick(Sender: TObject);
    procedure MLegendaClick(Sender: TObject);
    procedure ArvoreMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PedidosdeCompra1Click(Sender: TObject);
    procedure ConsultarFrao1Click(Sender: TObject);
    procedure BFiltrosClick(Sender: TObject);
    procedure EMateriaPrimaRetorno(Retorno1, Retorno2: String);
    procedure AlterarEstagio1Click(Sender: TObject);
    procedure ConcluirFrao1Click(Sender: TObject);
    procedure GridIndice1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GImpressaoCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GImpressaoMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure PanelColor4Click(Sender: TObject);
    procedure EProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure NumeroOP1Click(Sender: TObject);
    procedure AlterarCliente1Click(Sender: TObject);
    procedure MRegerarProjetoClick(Sender: TObject);
    procedure ImprimirConsumo1Click(Sender: TObject);
    procedure SemQuebraPgina1Click(Sender: TObject);
    procedure ConsultaLogSeparao1Click(Sender: TObject);
    procedure ReimportarFrao1Click(Sender: TObject);
    procedure ArvoreDblClick(Sender: TObject);
    procedure GridIndice1Ordem(Ordem: string);
    procedure ListaProdutosaExcluir1Click(Sender: TObject);
    procedure BImprimirEtiquetasClick(Sender: TObject);
    procedure BSolicitacaoComprasClick(Sender: TObject);
    procedure GImpressaoProdutoCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure PanelColor5Click(Sender: TObject);
    procedure AdicionarSubmontagememOPExistente1Click(Sender: TObject);
  private
    { Private declarations }
    VprOrdem : String;
    VprSeqProduto,
    VprSeqMateriaPrima,
    VprFilialPedido,
    VprNumPedido : Integer;
    VprDOrdemProducao : TRBDOrdemProducao;
    VprDFracaoOp :TRBDFracaoOrdemProducao;
    VprDEtiquetaProduto : TRBDEtiquetaProdutoOP;
    VprListaImpressao,
    VprListaImpressaoProduto : TList;
    FunOrdemProducao : TRBFuncoesOrdemProducao;
    FunOrcamentoCompras : TRBFunSolicitacaoCompra;
    FunRave : TRBFunRave;
    procedure CarTitulosGrade;
    procedure ConfiguraPermissaoUsuario;
    procedure AtualizaConsulta(VpaPosicionar : Boolean);
    procedure AtualizaConsultaFracionada(VpaPosicionar : Boolean);
    procedure AtualizaConsultaSubMontagem;
    procedure AdicionaFiltros(VpaSelect : TStrings);
    procedure ConsultaFracao(VpaCodFilial,VpaSeqOrdem, VpaSeqFracao : Integer);
    procedure AdicionaFracaoImpressao;
    procedure AdicionaProdutoImpressao;
    procedure AdicionaEtiquetaProdutoImpressao;
    procedure AdicionaFracoesOrcamentoCompras(VpaProdutos : TList);
  public
    { Public declarations }
    procedure ConsultaOPsPedido(VpaCodFilial, VpaNumPedido : Integer);
    procedure ConsultaOps(VpaCodFilial, VpaSeqOrdem, VpaSeqFracao : Integer);
  end;

var
  FOrdemProducaoGenerica: TFOrdemProducaoGenerica;

implementation

uses APrincipal, FunSql, funData, UnCrystal, Constantes, FunObjeto,
  ANovaOrdemProducaoGenerica, ConstMsg, ANovoProdutoPro,
  ABaixaConsumoProduto, ASolicitacaoCompras, APedidoCompra, ARelOrdemSerra,
  AGerarFracaoOPMaquinasCorte, AAlteraEstagioFracaoOP,
  AConsultaLogSeparacaoConsumo, dmRave, ANovaSolicitacaoCompra,
  AOrdemProdutoEstoque;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFOrdemProducaoGenerica.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  CarTitulosGrade;
  VprListaImpressao := TList.create;
  GImpressao.ADados := VprListaImpressao;
  GImpressao.CarregaGrade;
  VprListaImpressaoProduto := TList.Create;
  GImpressaoProduto.ADados := VprListaImpressaoProduto;
  GImpressaoProduto.CarregaGrade;
  FunOrdemProducao := TRBFuncoesOrdemProducao.cria(FPrincipal.baseDados);
  FunOrcamentoCompras := TRBFunSolicitacaoCompra.Cria(FPrincipal.BaseDados);
  FunRave := TRBFunRave.cria(FPrincipal.BaseDados);
  VprDOrdemProducao := TRBDOrdemProducao.cria;
  VprDFracaoOp := TRBDFracaoOrdemProducao.Cria;
  PageControl1.ActivePageIndex := 0;
  ConfiguraPermissaoUsuario;
  VprSeqProduto := 0;
  VprNumPedido := 0;
  EDatInicio.DateTime := PrimeiroDiaMes(date);
  EDatFim.DateTime := UltimoDiaMes(date);
  EPeriodoPor.ItemIndex := 1;
  PageControl1.ActivePage := PFracionada;
  VprOrdem := 'order by FRA.CODFILIAL, FRA.SEQORDEM, FRA.SEQFRACAO ';
//  VprOrdem := 'order by ORD.SEQORD';
  AtualizaConsulta(false);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFOrdemProducaoGenerica.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  VprDOrdemProducao.free;
  FunOrcamentoCompras.free;
  FunOrdemProducao.free;
  VprListaImpressao.Free;
  VprListaImpressaoProduto.Free;
  FunRave.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFOrdemProducaoGenerica.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.CarTitulosGrade;
begin
  GImpressao.Cells[1,0] := 'Fl';
  GImpressao.Cells[2,0] := 'OP';
  GImpressao.Cells[3,0] := 'Fração';
  GImpressao.Cells[4,0] := 'Produto';

  GImpressaoProduto.Cells[1,0] := 'Fl';
  GImpressaoProduto.Cells[2,0] := 'OP';
  GImpressaoProduto.Cells[3,0] := 'Quantidade';
  GImpressaoProduto.Cells[4,0] := 'Código';
  GImpressaoProduto.Cells[5,0] := 'Produto';
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.ConfiguraPermissaoUsuario;
begin
  if not((puAdministrador in varia.PermissoesUsuario) or (puESCompleto in varia.PermissoesUsuario)) then
  begin
    AlterarVisibleDet([BAlterar,BExcluir,BExcluiFracao,BConsultar,N8],false);
    if (puConsultarOP in Varia.PermissoesUsuario) then
      BConsultar.Visible := true;
    if (puESAlterarOP in varia.PermissoesUsuario) then
      BAlterar.Visible := true;
    if (puESExcluirOP in varia.PermissoesUsuario) then
    begin
      BExcluir.Visible := true;
      BExcluiFracao.Visible := true;
    end;
    if (puESRegerarProjeto in varia.PermissoesUsuario) then
    begin
      MReimportarProjeto.Visible := true;
      N8.Visible := true;
    end;

  end;
  PSubMontagem.TabVisible := (varia.TipoOrdemProducao = toSubMontagem);
  MReimportarProjeto.Visible := (varia.TipoOrdemProducao = toSubMontagem);
  BImprimeOrdemCorte.Visible := (varia.TipoOrdemProducao = toFracionada);
  BImprimeOrdemSerra.Visible := (Varia.TipoOrdemProducao = toSubMontagem);
  if (varia.TipoOrdemProducao = toSubMontagem) then
    AlterarVisibleDet([BAlterar,BImprimir,MGerarConsumo],false);

end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.AtualizaConsulta(VpaPosicionar : Boolean);
begin
  if PageControl1.ActivePage = PFracionada then
    AtualizaConsultaFracionada(VpaPosicionar)
  else
    if PageControl1.ActivePage = PSubMontagem then
      AtualizaConsultaSubMontagem;
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.AtualizaConsultaFracionada(VpaPosicionar : Boolean);
begin
  OrdemProducao.close;
  OrdemProducao.sql.clear;
  OrdemProducao.Sql.Add('select ORD.EMPFIL, ORD.SEQORD, ORD.DATEMI,  ORD.DATENP, ORD.DATENT,  ORD.NUMPED, '+
                        ' FRA.SEQFRACAO, FRA.DATIMPRESSAOFICHA, FRA.QTDPRODUTO, FRA.DATENTREGA,' +
                        ' FRA.QTDAFATURAR, FRA.QTDREVISADO,  FRA.CODCOR, FRA.DESUM, '+
                        ' CLI.C_NOM_CLI, ' +
                        ' PRO.C_COD_PRO ||''-''|| PRO.C_NOM_PRO PRODUTO, '+
                        ' COR.NOM_COR, '+
                        ' EST.NOMEST, '+
                        ' USU.C_NOM_USU, '+
                        ' PRO.I_SEQ_PRO, PRO.C_COD_PRO, PRO.C_NOM_PRO, PRO.C_COD_UNI UMORIGINAL '+
                        ' from ORDEMPRODUCAOCORPO ORD, CADCLIENTES CLI, CADPRODUTOS PRO, COR, ESTAGIOPRODUCAO EST, '+
                        ' CADUSUARIOS USU, FRACAOOP FRA '+
                        ' Where ORD.CODCLI = CLI.I_COD_CLI '+
                        ' and '+SQLTextoRightJoin('ORD.CODCOM','COR.COD_COR')+
                        ' AND FRA.CODESTAGIO = EST.CODEST '+
                        ' AND ORD.CODUSU = USU.I_COD_USU'+
                        ' AND ORD.EMPFIL = FRA.CODFILIAL '+
                        ' AND ORD.SEQORD = FRA.SEQORDEM ');
  if (Varia.TipoOrdemProducao = toSubMontagem) then
    OrdemProducao.sql.add('AND '+SQLTextoRightJoin('FRA.SEQPRODUTO','PRO.I_SEQ_PRO'))
  else
    OrdemProducao.sql.add(' and ORD.SEQPRO = PRO.I_SEQ_PRO ');

  AdicionaFiltros(OrdemProducao.sql);
  OrdemProducao.sql.add(VprOrdem);
  GridIndice1.ALinhaSQLOrderBy := OrdemProducao.Sql.count - 1;
  OrdemProducao.open;
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.AtualizaConsultaSubMontagem;
begin
  FracaoOpSubMontagem.close;
  FracaoOpSubMontagem.sql.clear;
  FracaoOpSubMontagem.Sql.Add('select FRA.CODFILIAL, FRA.SEQORDEM, FRA.SEQFRACAO, '+
                        ' FRA.CODESTAGIO, FRA.DATENTREGA, FRA.DATFINALIZACAO, ' +
                        ' PRO.C_COD_PRO, PRO.C_NOM_PRO '+
                        ' from ORDEMPRODUCAOCORPO ORD, CADPRODUTOS PRO, FRACAOOP FRA '+
                        ' Where  ORD.EMPFIL = FRA.CODFILIAL '+
                        ' AND ORD.SEQORD = FRA.SEQORDEM '+
                        ' AND ' +SQLTextoRightJoin('FRA.SEQPRODUTO','PRO.I_SEQ_PRO'));

  AdicionaFiltros(FracaoOpSubMontagem.sql);
  if (VprSeqProduto = 0) and (EFracao.AsInteger = 0) then
    FracaoOpSubMontagem.sql.add(' and FRA.SEQFRACAOPAI IS NULL' );
  FracaoOpSubMontagem.sql.add('ORDER BY ORD.EMPFIL, ORD.SEQORD');

  FracaoOpSubMontagem.open;
  FunOrdemProducao.CarregaArvoreSubMontagem(FracaoOpSubMontagem,Arvore);
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.AdicionaEtiquetaProdutoImpressao;
begin
  if varia.TipoOrdemProducao = toSubMontagem then
  begin
    VprDEtiquetaProduto := TRBDEtiquetaProdutoOP.cria;
    VprListaImpressaoProduto.Add(VprDEtiquetaProduto);
    VprDEtiquetaProduto.SeqProduto := OrdemProducaoI_SEQ_PRO.AsInteger;
    VprDEtiquetaProduto.CodFilial := OrdemProducaoEMPFIL.AsInteger;
    VprDEtiquetaProduto.SeqOrdemProducao := OrdemProducaoSEQORD.AsInteger;
    VprDEtiquetaProduto.QtdProdutos := FunOrdemProducao.RQtdProdutosOP(OrdemProducaoEMPFIL.AsInteger,OrdemProducaoSEQORD.AsInteger,OrdemProducaoI_SEQ_PRO.AsInteger);
    VprDEtiquetaProduto.CodProduto := OrdemProducaoC_COD_PRO.AsString;
    VprDEtiquetaProduto.NomProduto := OrdemProducaoC_NOM_PRO.AsString;
    PImpressaoProduto.TabVisible := true;
    PImpressaoProduto.Caption := 'Impressão Produtos ('+IntToStr(VprListaImpressaoProduto.Count)+')'
  end;;
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.AdicionaFiltros(VpaSelect : TStrings);
begin
  if EFilial.AInteiro <> 0 then
    VpaSelect.Add(' and FRA.CODFILIAL = '+EFilial.Text);
  if CFichaConsumo.Checked then
    VpaSelect.Add(' and FRA.DATIMPRESSAOFICHA is null')
  else
  begin
    if EFracao.AsInteger <> 0 then
      VpaSelect.Add(' and FRA.SEQFRACAO = '+ EFracao.Text);
    if ENumeroOp.AsInteger <> 0 then
      VpaSelect.add(' and FRA.SEQORDEM = '+ENumeroOp.text)
    else
    begin
      if CPeriodo.Checked then
      begin
        case EPeriodoPor.ItemIndex of
          0 : VpaSelect.Add(SQLTextoDataEntreAAAAMMDD('trunc(FRA.DATENTREGA)',EDatInicio.DateTime,EDatFim.Datetime,true));
          1 : VpaSelect.Add(SQLTextoDataEntreAAAAMMDD('TRUNC(ORD.DATEMI)',EDatInicio.DateTime,EDatFim.Datetime,true));
          2 : VpaSelect.Add(SQLTextoDataEntreAAAAMMDD('trunc(FRA.DATFINALIZACAO)',EDatInicio.DateTime,EDatFim.Datetime,true));
          3 : VpaSelect.Add('and exists(Select FER.CODFILIAL FROM FRACAOOPESTAGIOREAL FER Where FRA.CODFILIAL = FER.CODFILIAL '+
                            ' AND FRA.SEQORDEM = FER.SEQORDEM AND FRA.SEQFRACAO = FER.SEQFRACAO '+
                            ' AND FRA.CODESTAGIO = FER.CODESTAGIO '+
                            SQLTextoDataEntreAAAAMMDD('FER.DATFIM',EDatInicio.DateTime,EDatFim.Datetime,true)+')');
        end;
      end;
    end;
    if EEstagio.AInteiro <> 0 then
      VpaSelect.Add('and FRA.CODESTAGIO = '+EEstagio.text);
    if EProjeto.AInteiro <> 0 then
      VpaSelect.Add('and ORD.CODPRJ = '+EProjeto.Text);
    if EPedido.AsInteger <> 0 then
      VpaSelect.Add('and ORD.NUMPED = '+EPedido.Text);
    if VprSeqProduto <> 0 then
    begin
      if (Varia.TipoOrdemProducao = toSubMontagem) then
        VpaSelect.add(' and FRA.SEQPRODUTO = '+IntToStr(VprSeqProduto))
      else
        VpaSelect.add(' and PRO.I_SEQ_PRO = '+IntToStr(VprSeqProduto));
    end;
    if VprNumPedido <> 0 then
      VpaSelect.add(' AND ORD.EMPFIL = '+IntToStr(VprFilialPedido)+
                    ' and ORD.LANORC = '+ IntToStr(VprNumPedido));
    if ECliente.AInteiro <> 0 then
      VpaSelect.Add(' AND ORD.CODCLI = '+ECliente.Text);
    if CFracaoFinalizada.Checked then
      VpaSelect.Add(' AND FRA.DATFINALIZACAO IS NULL');
    if EEstagioNaoProcesado.AInteiro <> 0 then
      VpaSelect.Add('and EXISTS(SELECT * FROM FRACAOOPESTAGIO FRE '+
                   ' WHERE FRA.CODFILIAL = FRE.CODFILIAL '+
                   ' AND FRA.SEQORDEM = FRE.SEQORDEM '+
                   ' AND FRA.SEQFRACAO = FRE.SEQFRACAO '+
                   ' AND FRE.CODESTAGIO = '+EEstagioNaoProcesado.Text+
                   ' AND FRE.INDFINALIZADO = ''N'')');
    if ETipoEstagio.AInteiro <> 0 then
      VpaSelect.Add('and EXISTS(SELECT * FROM FRACAOOPESTAGIO FRE, ESTAGIOPRODUCAO EST, TIPOESTAGIOPRODUCAO TEP '+
                   ' WHERE FRA.CODFILIAL = FRE.CODFILIAL '+
                   ' AND FRA.SEQORDEM = FRE.SEQORDEM '+
                   ' AND FRA.SEQFRACAO = FRE.SEQFRACAO '+
                   ' AND FRE.CODESTAGIO = EST.CODEST '+
                   ' AND EST.CODTIP = TEP.CODTIP '+
                   ' AND TEP.CODTIP = '+ETipoEstagio.Text+
                   ' AND FRE.INDFINALIZADO = ''N'')');
    if VprSeqMateriaPrima <> 0 then
      VpaSelect.add('and EXISTS(SELECT * FROM FRACAOOPCONSUMO FRC '+
                    ' WHERE FRA.CODFILIAL = FRC.CODFILIAL '+
                    ' AND FRA.SEQORDEM = FRC.SEQORDEM '+
                    ' AND FRA.SEQFRACAO = FRC.SEQFRACAO '+
                    ' AND FRC.SEQPRODUTO ='+IntToStr(VprSeqMateriaPrima)+')');
  end;
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.ConsultaFracao(VpaCodFilial,VpaSeqOrdem, VpaSeqFracao : Integer);
begin
  FunOrdemProducao.CarDOrdemProducaoBasica(VpaCodFilial,VpaSeqOrdem,VprDOrdemProducao);
  if varia.TipoOrdemProducao = toSubMontagem then
    VprDFracaoOp := FunOrdemProducao.CarDFracaoOP(nil,VpaCodFilial,VpaSeqOrdem,VpaSeqFracao)
  else
    VprDFracaoOp := FunOrdemProducao.RFracaoOP(VprDOrdemProducao,VpaSeqFracao);
  FNovaOrdemProducaoGenerica := TFNovaOrdemProducaoGenerica.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaOrdemProducaoGenerica'));
  FNovaOrdemProducaoGenerica.ConsultaOrdemProduca(VprDOrdemProducao,VprDFracaoOp);
  FNovaOrdemProducaoGenerica.free;
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.AdicionaFracaoImpressao;
var
  VpfDFracao : TRBDFracaoOrdemProducao;
begin
  if OrdemProducaoEMPFIL.AsInteger <> 0 then
  begin
    VpfDFracao := FunOrdemProducao.CarDFracaoOp(nil,OrdemProducaoEMPFIL.AsInteger,OrdemProducaoSEQORD.AsInteger,OrdemProducaoSEQFRACAO.AsInteger);
    FunOrdemProducao.CarDFracaoOPEstagio(VpfDFracao,VpfDFracao.CodFilial,VpfDFracao.SeqOrdemProducao);
    VprListaImpressao.add(VpfDFracao);
    GImpressao.CarregaGrade;
    PImpressao.Caption := 'Impressão ('+IntToStr(VprListaImpressao.Count)+')';
    PImpressao.TabVisible := true;
  end;
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.AdicionaFracoesOrcamentoCompras(VpaProdutos : TList);
var
  VpfPosicao : TBookmark;
  VpfDProdutoOrcamento : TRBDSolicitacaoCompraItem ;
begin
  VpfPosicao := OrdemProducao.GetBookmark;
  OrdemProducao.First;
  while not OrdemProducao.Eof do
  begin
    VpfDProdutoOrcamento := TRBDSolicitacaoCompraItem.Cria;
    VpaProdutos.add(VpfDProdutoOrcamento);
    VpfDProdutoOrcamento.SeqProduto := OrdemProducaoI_SEQ_PRO.AsInteger;
    VpfDProdutoOrcamento.CodCor := OrdemProducaoCODCOR.AsInteger;
    VpfDProdutoOrcamento.CodProduto := OrdemProducaoC_COD_PRO.AsString;
    VpfDProdutoOrcamento.NomProduto := OrdemProducaoC_NOM_PRO.AsString;
    VpfDProdutoOrcamento.NomCor := OrdemProducaoNOM_COR.AsString;
    VpfDProdutoOrcamento.DesUM := OrdemProducaoDESUM.AsString;
    VpfDProdutoOrcamento.UMOriginal := OrdemProducaoUMORIGINAL.AsString ;
    VpfDProdutoOrcamento.IndComprado := false;
    VpfDProdutoOrcamento.UnidadesParentes := FunProdutos.RUnidadesParentes(VpfDProdutoOrcamento.DesUM);
    VpfDProdutoOrcamento.QtdProduto := OrdemProducaoQTDPRODUTO.AsFloat;
    VpfDProdutoOrcamento.QtdAprovado :=OrdemProducaoQTDPRODUTO.AsFloat;
    OrdemProducao.Next
  end;
  OrdemProducao.GotoBookmark(VpfPosicao);
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.AdicionaProdutoImpressao;
begin
  EProduto.Atualiza;
  AtualizaConsulta(false);
  while not OrdemProducao.Eof do
  begin
    AdicionaFracaoImpressao;
    OrdemProducao.Next;
  end;
end;

procedure TFOrdemProducaoGenerica.AdicionarSubmontagememOPExistente1Click(Sender: TObject);
begin
  if OrdemProducaoEMPFIL.AsInteger > 0 then
  begin
    FNovaOrdemProducaoGenerica := TFNovaOrdemProducaoGenerica.criarSDI(Application,'',FPrincipal.VerificaPermisao('FNovaOrdemProducaoGenerica'));
    if FNovaOrdemProducaoGenerica.AdicionaFracaoOPExistente(OrdemProducaoEMPFIL.AsInteger,OrdemProducaoSEQORD.AsInteger) then
      AtualizaConsulta(true);
    FNovaOrdemProducaoGenerica.free;
  end;
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.EProdutoRetorno(Retorno1,
  Retorno2: String);
begin
  if Retorno1 <> '' then
    VprSeqProduto := StrToInt(Retorno1)
  else
    VprSeqProduto := 0;
  AtualizaConsulta(false) ;
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.EPedidoExit(Sender: TObject);
begin
  AtualizaConsulta(False);
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.EEstagioKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 13 then
    atualizaconsulta(false);
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.ConsultaOPsPedido(VpaCodFilial, VpaNumPedido : Integer);
begin
  VprFilialPedido := VpaCodFilial;
  VprNumPedido := VpaNumPedido;
  CPeriodo.Checked := false;
  AtualizaConsulta(false);
  showmodal;
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.ConsultaOps(VpaCodFilial, VpaSeqOrdem, VpaSeqFracao : Integer);
begin
  EFilial.AInteiro := VpaCodFilial;
  EFilial.Atualiza;
  ENumeroOp.AsInteger := VpaSeqOrdem;
  EFracao.AsInteger := VpaSeqFracao;
  AtualizaConsulta(false);
  ShowModal;
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.BFichaConsumoClick(Sender: TObject);
var
  VpfDFracao : TRBDFracaoOrdemProducao;
  VpfSomenteASeparar : Boolean;
begin
  if TWinControl(Sender).Tag = 1 then
    VpfSomenteASeparar := false
  else
    VpfSomenteASeparar := true;
  if PageControl1.ActivePage = PFracionada then
  begin
    if (varia.TipoOrdemProducao = toSubMontagem) then
    begin
      FunOrdemProducao.GeraImpressaoConsumoFracao(OrdemProducaoEMPFIL.AsInteger,OrdemProducaoSEQORD.AsInteger,OrdemProducaoSEQFRACAO.AsInteger,false);
      dtRave := TdtRave.create(self);
      dtRave.ImprimeConsumoSubmontagem(OrdemProducaoEMPFIL.AsInteger,OrdemProducaoSEQORD.AsInteger,OrdemProducaoSEQFRACAO.AsInteger,VpfSomenteASeparar,false);
      dtRave.free;
    end
    else
      if (varia.TipoOrdemProducao = toFracionada) then
      begin
        FunOrdemProducao.GeraImpressaoConsumoFracao(OrdemProducaoEMPFIL.AsInteger,OrdemProducaoSEQORD.AsInteger,0,false);
        dtRave := TdtRave.create(self);
        dtRave.ImprimeConsumoFracionada(OrdemProducaoEMPFIL.AsInteger,OrdemProducaoSEQORD.AsInteger,VpfSomenteASeparar);
        dtRave.free;
      end;
  end
  else
  begin
    if (TObject(Arvore.Selected.Data) is TRBDFracaoOrdemProducao) then
    begin
      VpfDFracao := TRBDFracaoOrdemProducao(Arvore.Selected.Data);
      FunOrdemProducao.GeraImpressaoConsumoFracao(VpfDFracao.CodFilial,VpfDFracao.SeqOrdemProducao,VpfDFracao.SeqFracao,false);
      dtRave := TdtRave.create(self);
      dtRave.ImprimeConsumoSubmontagem(VpfDFracao.CodFilial,VpfDFracao.SeqOrdemProducao,VpfDFracao.SeqFracao,VpfSomenteASeparar,false);
      dtRave.free;
    end;
  end;
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.BConsultarClick(Sender: TObject);
var
  VpfDFracao : TRBDFracaoOrdemProducao;
begin
  if PageControl1.ActivePage = PFracionada then
  begin
    if OrdemProducaoSEQORD.AsInteger <> 0 then
    begin
      ConsultaFracao(OrdemProducaoEMPFIL.AsInteger,OrdemProducaoSEQORD.AsInteger,OrdemProducaoSEQFRACAO.AsInteger);
    end;
  end
  else
  begin
    if (tobject(Arvore.Selected.Data) is TRBDFracaoOrdemProducao) then
    begin
      VpfDFracao := TRBDFracaoOrdemProducao(Arvore.Selected.data);
      ConsultaFracao(VpfDFracao.CodFilial,VpfDFracao.SeqOrdemProducao,VpfDFracao.SeqFracao);
    end;
  end;

end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.BImprimirClick(Sender: TObject);
begin
  if OrdemProducaoSEQORD.AsInteger <> 0 then
  begin
    if config.FabricadeCadarcosdeFitas then
    begin
      funrave.ImprimeOPFabricaCardarcodeFita(OrdemProducaoEMPFIL.AsInteger,OrdemProducaoSEQORD.AsInteger,OrdemProducaoSEQFRACAO.AsInteger,true);
    end
    else
    begin
      dtRave := TdtRave.create(self);
      dtRave.ImprimeFracaoOP(OrdemProducaoEMPFIL.AsInteger,OrdemProducaoSEQORD.AsInteger,OrdemProducaoSEQFRACAO.AsInteger,true);
      dtRave.free;
    end;
  end;
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.BImprimirEtiquetasClick(Sender: TObject);
var
  VpfDOrdemProducao : TRBDOrdemProducao;
begin
  if OrdemProducaoSEQORD.AsInteger <> 0 then
  begin
    VpfDOrdemProducao := TRBDOrdemProducao.cria;
    FunOrdemProducao.CarDOrdemProducaoBasica(OrdemProducaoEMPFIL.AsInteger,OrdemProducaoSEQORD.AsInteger,VpfDOrdemProducao);
    FunOrdemProducao.CarDOrdemCorte(VpfDOrdemProducao);
    FunOrdemProducao.ImprimeEtiquetasOrdemProducao(VpfDOrdemProducao);
    VpfDOrdemProducao.Free;
  end;
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.BExcluirClick(Sender: TObject);
begin
  IF OrdemProducaoEMPFIL.AsInteger <> 0 then
  begin
    if confirmacao('EXLUIR ORDEM DE PRODUÇÃO!!!'#13'Tem certeza que deseja excluir a ordem de produção?') then
    begin
      FunOrdemProducao.ExcluiOrdemProducao(OrdemProducaoEMPFIL.AsInteger,OrdemProducaoSEQORD.AsInteger);
      AtualizaConsulta(false);
    end;
  end;
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.BCadastrarClick(Sender: TObject);
begin
  FNovaOrdemProducaoGenerica := TFNovaOrdemProducaoGenerica.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaOrdemProducaoGenerica'));
  if FNovaOrdemProducaoGenerica.NovaOrdemProducao then
    AtualizaConsulta(false);
  FNovaOrdemProducaoGenerica.free;
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.BAlterarClick(Sender: TObject);
begin
  if OrdemProducaoSEQORD.AsInteger <> 0 then
  begin
    FunOrdemProducao.CarDOrdemProducaoBasica(OrdemProducaoEMPFIL.AsInteger,OrdemProducaoSEQORD.AsInteger,VprDOrdemProducao);
    FNovaOrdemProducaoGenerica := TFNovaOrdemProducaoGenerica.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaOrdemProducaoGenerica'));
    FNovaOrdemProducaoGenerica.AlterarOrdemProducao(VprDOrdemProducao);
    FNovaOrdemProducaoGenerica.free;
  end;
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.AlterarEstgiosProduto1Click(
  Sender: TObject);
begin
  FNovoProdutoPro := TFNovoProdutoPro.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoProdutoPro'));
  if FNovoProdutoPro.AlteraEstagioProdutos(varia.codigoEmpresa,varia.CodigoEmpFil,OrdemProducaoI_SEQ_PRO.AsInteger) then
    FunOrdemProducao.RegeraFracaoOPEstagio(OrdemProducaoI_SEQ_PRO.AsInteger);
  FNovoProdutoPro.free;
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.BExcluiFracaoClick(Sender: TObject);
var
  VpfDFracao : TRBDFracaoOrdemProducao;
begin
  if confirmacao('EXLUIR FRACAO DE PRODUÇÃO!!!'#13'Tem certeza que deseja excluir a fração da ordem de produção?') then
  begin
    if PageControl1.ActivePage = PFracionada then
    begin
      if OrdemProducaoSEQORD.AsInteger <> 0 then
        if FunOrdemProducao.ExisteFracaoFilha(OrdemProducaoEMPFIL.AsInteger,OrdemProducaoSEQORD.AsInteger,OrdemProducaoSEQFRACAO.AsInteger)  then
          aviso('ERRO NA EXCLUSÃO DA FRAÇÃO!!!'#13'Não foi possível excluir a fração pois existem frações filhas, é necessário antes excluir as frações filhas.')
        else
        begin
          FunOrdemProducao.ExcluiFracaoOP(OrdemProducaoEMPFIL.AsInteger,OrdemProducaoSEQORD.AsInteger,OrdemProducaoSEQFRACAO.AsInteger);
          AtualizaConsulta(false);
        end;
    end
    else
    begin
      if Arvore.Selected.HasChildren  then
        aviso('ERRO NA EXCLUSÃO DA FRAÇÃO!!!'#13'Não foi possível excluir a fração pois existem frações filhas, é necessário antes excluir as frações filhas.')
      else
        if (tobject(Arvore.Selected.Data) is TRBDFracaoOrdemProducao) then
        begin
          VpfDFracao := TRBDFracaoOrdemProducao(Arvore.Selected.data);
          FunOrdemProducao.ExcluiFracaoOP(VpfDFracao.CodFilial,VpfDFracao.SeqOrdemProducao,VpfDFracao.SeqFracao);
          Arvore.Selected.Delete;
        end;
    end;
  end;
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.BImprimeOrdemCorteClick(Sender: TObject);
begin
  if OrdemProducaoSEQORD.AsInteger <> 0 then
  begin
    dtRave := TdtRave.create(self);
    dtRave.ImprimeOrdemCorteOP(OrdemProducaoEMPFIL.AsInteger,OrdemProducaoSEQORD.AsInteger,true);
    dtRave.free;
  end;
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.GeraOrdemCorte1Click(Sender: TObject);
begin
  FunOrdemProducao.CarDOrdemProducaoBasica(OrdemProducaoEMPFIL.AsInteger,OrdemProducaoSEQORD.AsInteger,VprDOrdemProducao);
  FunOrdemProducao.GeraOrdemCorte(VprDOrdemProducao);
  FGerarFracaoOPMaquinasCorte := TFGerarFracaoOPMaquinasCorte.CriarSDI(self,'',FPrincipal.VerificaPermisao('FGerarFracaoOPMaquinasCorte'));
  FGerarFracaoOPMaquinasCorte.GeraOrdemCorte(VprDOrdemProducao);
  FGerarFracaoOPMaquinasCorte.free;
  VprDOrdemProducao.OrdemCorte.CodFilial := VprDOrdemProducao.CodEmpresafilial;
  VprDOrdemProducao.OrdemCorte.SeqOrdemProducao := VprDOrdemProducao.SeqOrdem;
  FunOrdemProducao.GravaDOrdemCorte(VprDOrdemProducao.OrdemCorte);
  aviso('Ordem de Corte Gerada com sucesso!!!');
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.ProdutosPendentes1Click(Sender: TObject);
begin
  FunCrystal.ImprimeRelatorio(Varia.PathRelatorios+'\Ordem Produção\xx_MateriaPrimaPendente.rpt',[]);
end;

procedure TFOrdemProducaoGenerica.ReimportarFrao1Click(Sender: TObject);
Var
  VpfResultado : String;
  VpfDFracao : TRBDFracaoOrdemProducao;
  VpfTransacao :TTransactionDesc;
begin
  if Confirmacao('Tem certeza que deseja reimportar o projeto? ') then
  begin
   VpfTransacao.IsolationLevel :=xilDIRTYREAD;
   FPrincipal.BaseDados.StartTransaction(vpfTransacao);
    PainelTempo1.execute('Reimportando as submontagens. Aguarde...');
    VpfResultado := '';
    if PageControl1.ActivePage = PFracionada then
    begin
      if OrdemProducaoSEQORD.AsInteger <> 0 then
      begin
        VpfResultado := FunOrdemProducao.ReImportaProjeto(OrdemProducaoEMPFIL.AsInteger,OrdemProducaoSEQORD.AsInteger,OrdemProducaoSEQFRACAO.AsInteger);
        AtualizaConsulta(true);
      end;
    end
    else
    begin
      if (tobject(Arvore.Selected.Data) is TRBDFracaoOrdemProducao) then
      begin
        VpfDFracao := TRBDFracaoOrdemProducao(Arvore.Selected.data);
        VpfResultado := FunOrdemProducao.ReImportaProjeto(VpfDFracao.CodFilial,VpfDFracao.SeqOrdemProducao,VpfDFracao.SeqFracao);
        Arvore.Selected.DeleteChildren;
        VpfDFracao.IndEstagiosCarregados := false;
        FunOrdemProducao.AdicionaNoFracao(VpfDFracao.CodFilial,VpfDFracao.SeqOrdemProducao,VpfDFracao.SeqFracao,Arvore.Selected ,Arvore);
      end;
    end;
    if VpfResultado <> '' then
    begin
      FPrincipal.BaseDados.Rollback(VpfTransacao);
      aviso(VpfResultado);
    end
    else
      FPrincipal.BaseDados.Commit(VpfTransacao);

    PainelTempo1.fecha;
  end;
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.BitBtn2Click(Sender: TObject);
var
  VpfDFracao : TRBDFracaoOrdemProducao;
begin
  if PageControl1.ActivePage = PFracionada then
  begin
    if OrdemProducaoSEQORD.AsInteger <> 0 then
    begin
      FBaixaConsumoProduto := TFBaixaConsumoProduto.CriarSDI(self,'',FPrincipal.VerificaPermisao('FBaixaConsumoProduto'));
      FBaixaConsumoProduto.BaixaConsumoProduto(OrdemProducaoEMPFIL.AsInteger,OrdemProducaoSEQORD.AsInteger,OrdemProducaoSEQFRACAO.AsInteger);
      FBaixaConsumoProduto.free;
    end;
  end
  else
  begin
    if (tobject(Arvore.Selected.Data) is TRBDFracaoOrdemProducao) then
    begin
      VpfDFracao := TRBDFracaoOrdemProducao(Arvore.Selected.data);
      FBaixaConsumoProduto := TFBaixaConsumoProduto.CriarSDI(self,'',FPrincipal.VerificaPermisao('FBaixaConsumoProduto'));
      FBaixaConsumoProduto.BaixaConsumoProduto(VpfDFracao.CodFilial,VpfDFracao.SeqOrdemProducao,VpfDFracao.SeqFracao);
      FBaixaConsumoProduto.free;
    end;
  end;
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.MGerarConsumoClick(Sender: TObject);
Var
  VpfResultado : String;
begin
  ExecutaComandoSql(aux,'Delete from FRACAOOPCONSUMO '+
                       ' Where CODFILIAL = '+IntToStr(OrdemProducaoEMPFIL.AsInteger)+
                       ' and SEQORDEM = '+IntToStr(OrdemProducaoSEQORD.AsInteger));
  FunOrdemProducao.CarDOrdemProducaoBasica(OrdemProducaoEMPFIL.AsInteger,OrdemProducaoSEQORD.AsInteger,VprDOrdemProducao);
  FunOrdemProducao.CarDOrdemCorte(VprDOrdemProducao);

  FunOrdemProducao.GeraConsumoOP(VprDOrdemProducao);
  VpfResultado := FunOrdemProducao.GravaConsumoOP(VprDOrdemProducao);
  if VpfResultado <> '' then
    aviso(VpfResultado)
  else
    aviso('Consumo gerado com sucesso!!!');
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.ConsultarOramentoCompra1Click(
  Sender: TObject);
begin
  if OrdemProducaoEMPFIL.AsInteger <> 0 then
  begin
    FSolicitacaoCompra := TFSolicitacaoCompra.CriarSDI(self,'',FPrincipal.VerificaPermisao('FOrcamentoCompra'));
    FSolicitacaoCompra.ConsultaOP(OrdemProducaoEMPFIL.AsInteger,OrdemProducaoSEQORD.AsInteger);
    FSolicitacaoCompra.free;
  end;
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.ConsultarSolicitaoCompras1Click(
  Sender: TObject);
begin
  FPedidoCompra := TFPedidoCompra.CriarSDI(self,'',FPrincipal.VerificaPermisao('FPedidoCompra'));
  FPedidoCompra.ConsultaPedidosOrdemProducao(OrdemProducaoEMPFIL.AsInteger,OrdemProducaoSEQORD.AsInteger,OrdemProducaoSEQFRACAO.AsInteger);
  FPedidoCompra.free;
end;

procedure TFOrdemProducaoGenerica.PageControl1Change(Sender: TObject);
begin
  if PageControl1.ActivePage = PFracionada then
  begin
    AtualizaConsulta(false);
    BExcluir.Height := BExcluiFracao.Height;
  end
  else
    if PageControl1.ActivePage = PSubMontagem then
    begin
      AtualizaConsultaSubMontagem;
      BExcluir.Height := -1;
    end;
end;

procedure TFOrdemProducaoGenerica.BImprimeOrdemSerraClick(Sender: TObject);
begin
  if OrdemProducaoSEQORD.AsInteger <> 0 then
  begin
    dtRave := TdtRave.create(self);
    dtRave.ImprimeOrdemSerra(OrdemProducaoEMPFIL.AsInteger,OrdemProducaoSEQORD.AsInteger);
    dtRave.free;
  end;
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.BSolicitacaoComprasClick(Sender: TObject);
var
  VpfProdutosOrcamento : TList;
begin
  VpfProdutosOrcamento := TList.create;
  AdicionaFracoesOrcamentoCompras(VpfProdutosOrcamento);
  {FOrdemProdutoEstoque := TFOrdemProdutoEstoque.CriarSDI(self,'',FPrincipal.VerificaPermisao('FOrdemProdutoEstoque'));
  FOrdemProdutoEstoque.CarListaProdutoEstoque(VpfProdutosOrcamento, VprDFracaoOp);
  FOrdemProdutoEstoque.free;}
  FNovaSolicitacaoCompras := TFNovaSolicitacaoCompras.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoOrcamentoCompras'));
  FNovaSolicitacaoCompras.NovoOrcamentoConsumo(EFilial.AInteiro,OrdemProducaoSEQORD.AsInteger,OrdemProducaoSEQFRACAO.AsInteger,VpfProdutosOrcamento);
  FNovaSolicitacaoCompras.free;
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.EtiquetasOrdemSerra1Click(
  Sender: TObject);
begin
  if OrdemProducaoSEQORD.AsInteger <> 0 then
  begin
    FRelOrdemSerra := TFRelOrdemSerra.CriarSDI(self,'',FPrincipal.VerificaPermisao('FRelOrdemSerra'));
    FRelOrdemSerra.ImprimeOrdemSErra(OrdemProducaoEMPFIL.AsInteger,OrdemProducaoSEQORD.AsInteger,0);
    FRelOrdemSerra.free;
  end;
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.GerarSolicitaoCompras1Click(
  Sender: TObject);
begin
  if OrdemProducaoEMPFIL.AsInteger <> 0 then
  begin
    if Confirmacao('Tem certeza que deseja gerar a solicitação de compras?') then
      FunOrcamentoCompras.GeraOrcamentoCompraOrdemProducao(OrdemProducaoEMPFIL.AsInteger,OrdemProducaoSEQORD.AsInteger);
  end;
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.ArvoreDblClick(Sender: TObject);
begin
  if not Arvore.Selected.HasChildren then
    BConsultarClick(sender);
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.ArvoreExpanded(Sender: TObject;
  Node: TTreeNode);
var
  VpfDFracao : TRBDFracaoOrdemProducao;
  VpfLaco : Integer;
begin
  if not TRBDFracaoOrdemProducao(node.Data).IndEstagiosCarregados then
  begin
    for VpfLaco := 0 to  Node.Count - 1 do
    begin
      VpfDFracao := TRBDFracaoOrdemProducao(node.Item[VpfLaco].Data);
      FunOrdemProducao.AdicionaNoFracao(VpfDFracao.CodFilial,VpfDFracao.SeqOrdemProducao,VpfDFracao.SeqFracao,node.Item[VpfLaco],Arvore);
    end;
    VpfDFracao := TRBDFracaoOrdemProducao(node.Data);
    VpfDFracao.IndEstagiosCarregados := true;
  end;
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.AlterarDataEntrega1Click(
  Sender: TObject);
var
  VpfDFracao : TRBDFracaoOrdemProducao;
  VpfResultado : String;
begin
  if (tobject(Arvore.Selected.Data) is TRBDFracaoOrdemProducao) then
  begin
    VpfDFracao := TRBDFracaoOrdemProducao(Arvore.Selected.data);
    if EntraData('Data Entrega Fração','Digite a nova data de Entrega : ',vpfdFracao.DatEntrega) then
    begin
      VpfResultado := FunOrdemProducao.AtteraDataEntregaFracao(VpfDFracao);
      if VpfResultado <> '' then
        aviso(VpfResultado)
      else
        FunOrdemProducao.CarIconeNoFracao(Arvore.Selected,VpfDFracao);
    end;
  end;
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.TextoMove1Click(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.PLegendaClick(Sender: TObject);
begin
  PLegenda.Visible := false;
end;

procedure TFOrdemProducaoGenerica.MLegendaClick(Sender: TObject);
begin
  MLegenda.Checked := not MLegenda.Checked;
  PLegenda.Visible := MLegenda.Checked;
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.ArvoreMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  VpfNo : TTreeNode;
  VpfDFracao : TRBDFracaoOrdemProducao;
begin
  VpfNo := Arvore.GetNodeAt(x,y);
  if VpfNo <> NIL THEN
  BEGIN
    if (TObject(VpfNo.Data) is TRBDFracaoOrdemProducao) then
    begin
      VpfDFracao := TRBDFracaoOrdemProducao(VpfNo.Data);
      Arvore.Hint := FormatDateTime('DD/MM/YYYY',VpfDFracao.DatEntrega)+' - '+VpfDFracao.NomEstagio;
    end;
  END;
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.PedidosdeCompra1Click(Sender: TObject);
var
  VpfDFracao : TRBDFracaoOrdemProducao;
begin
  if (TObject(Arvore.Selected.Data) is TRBDFracaoOrdemProducao) then
  begin
    VpfDFracao := TRBDFracaoOrdemProducao(Arvore.Selected.Data);
    FPedidoCompra := TFPedidoCompra.CriarSDI(self,'',FPrincipal.VerificaPermisao('FPedidoCompra'));
    FPedidoCompra.ConsultaPedidosOrdemProducao(VpfDFracao.CodFilial,VpfDFracao.SeqOrdemProducao,VpfDFracao.SeqFracao);
    FPedidoCompra.free;
  end;
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.ConsultarFrao1Click(Sender: TObject);
var
  VpfDFracao : TRBDFracaoOrdemProducao;
begin
  if (TObject(Arvore.Selected.Data) is TRBDFracaoOrdemProducao) then
  begin
    VpfDFracao := TRBDFracaoOrdemProducao(Arvore.Selected.Data);
    ConsultaFracao(VpfDFracao.CodFilial,VpfDFracao.SeqOrdemProducao,VpfDFracao.SeqFracao);
  end;
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.BFiltrosClick(Sender: TObject);
begin
  if BFiltros.Caption = '>>' then
  begin
    PanelColor1.Height := EMateriaPrima.Top + EMateriaPrima.Height + 5;
    BFiltros.Caption := '<<';
  end
  else
  begin
    PanelColor1.Height := ENumeroOp.Top + ENumeroOp.Height + 5;
    BFiltros.Caption := '>>';
  end;
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.EMateriaPrimaRetorno(Retorno1,
  Retorno2: String);
begin
  if Retorno1 <> '' then
    VprSeqMateriaPrima := StrToInt(Retorno1)
  else
    VprSeqMateriaPrima := 0;
  AtualizaConsulta(false) ;
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.AlterarEstagio1Click(Sender: TObject);
var
  VpfDFracao : TRBDFracaoOrdemProducao;
begin
  if (TObject(Arvore.Selected.Data) is TRBDFracaoOrdemProducao) then
  begin
    VpfDFracao := TRBDFracaoOrdemProducao(Arvore.Selected.Data);
    FAlteraEstagioFracaoOP := TFAlteraEstagioFracaoOP.CriarSDI(self,'',FPrincipal.VerificaPermisao('FAlteraEstagioFracaoOP'));
    if FAlteraEstagioFracaoOP.alteraEstagioFracao(VpfDFracao.CodFilial,VpfDFracao.SeqOrdemProducao,VpfDFracao.SeqFracao) then
    begin
      VpfDFracao := FunOrdemProducao.CarDFracaoOP(nil,VpfDFracao.CodFilial,VpfDFracao.SeqOrdemProducao,VpfDFracao.SeqFracao);
      FunOrdemProducao.CarIconeNoFracao(Arvore.Selected,VpfDFracao);
    end;
    FAlteraEstagioFracaoOP.free;
  end;
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.ConcluirFrao1Click(Sender: TObject);
var
  VpfDFracao : TRBDFracaoOrdemProducao;
begin
  if confirmacao('Tem certeza que deseja concluir a fração?') then
  begin
    if (TObject(Arvore.Selected.Data) is TRBDFracaoOrdemProducao) then
    begin
      VpfDFracao := TRBDFracaoOrdemProducao(Arvore.Selected.Data);
      FunOrdemProducao.AlteraEstagioFracaoOP(VpfDFracao.CodFilial,VpfDFracao.SeqOrdemProducao,VpfDFracao.SeqFracao,varia.EstagioFinalOrdemProducao);
      FAlteraEstagioFracaoOP := TFAlteraEstagioFracaoOP.CriarSDI(self,'',FPrincipal.VerificaPermisao('FAlteraEstagioFracaoOP'));
      VpfDFracao := FunOrdemProducao.CarDFracaoOP(nil,VpfDFracao.CodFilial,VpfDFracao.SeqOrdemProducao,VpfDFracao.SeqFracao);
      FunOrdemProducao.CarIconeNoFracao(Arvore.Selected,VpfDFracao);
    end;
  end;
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.GridIndice1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 107 then
    AdicionaFracaoImpressao
  else
    if key = 80 then
      AdicionaEtiquetaProdutoImpressao;
end;

procedure TFOrdemProducaoGenerica.GridIndice1Ordem(Ordem: string);
begin
  VprOrdem := Ordem;
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.GImpressaoCarregaItemGrade(
  Sender: TObject; VpaLinha: Integer);
begin
  VprDFracaoOp := TRBDFracaoOrdemProducao(VprListaImpressao.Items[VpaLinha -1]);
  GImpressao.Cells[1,VpaLinha]:= IntToStr(VprDFracaoOp.CodFilial);
  GImpressao.Cells[2,VpaLinha]:= IntToStr(VprDFracaoOp.SeqOrdemProducao);
  GImpressao.Cells[3,VpaLinha]:= IntToStr(VprDFracaoOp.SeqFracao);
  GImpressao.Cells[4,VpaLinha]:= VprDFracaoOp.CodProduto +'-'+VprDFracaoOp.NomProduto;
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.GImpressaoMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprListaImpressao.Count > 0 then
    VprDFracaoOp := TRBDFracaoOrdemProducao(VprListaImpressao.Items[VpaLinhaAtual-1]);
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.GImpressaoProdutoCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
begin
  VprDEtiquetaProduto := TRBDEtiquetaProdutoOP(VprListaImpressaoProduto.Items[VpaLinha -1]);
  GImpressaoProduto.Cells[1,VpaLinha]:= IntToStr(VprDEtiquetaProduto.CodFilial);
  GImpressaoProduto.Cells[2,VpaLinha]:= IntToStr(VprDEtiquetaProduto.SeqOrdemProducao);
  GImpressaoProduto.Cells[3,VpaLinha]:= IntToStr(VprDEtiquetaProduto.QtdProdutos);
  GImpressaoProduto.Cells[4,VpaLinha]:= VprDEtiquetaProduto.CodProduto;
  GImpressaoProduto.Cells[5,VpaLinha]:= VprDEtiquetaProduto.NomProduto;
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.PanelColor4Click(Sender: TObject);
begin
  VprDOrdemProducao.Fracoes := VprListaImpressao;
  FunOrdemProducao.ImprimeEtiquetaFracao(VprDOrdemProducao);
  VprDOrdemProducao.Free;
  VprDOrdemProducao := TRBDOrdemProducao.cria;
  VprListaImpressao := TList.Create;
  GImpressao.ADados := VprListaImpressao;
  PageControl1.ActivePage := PFracionada;
  PImpressao.TabVisible := false;
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.PanelColor5Click(Sender: TObject);
var
  VpfFunZebra : TRBFuncoesZebra;
begin
  VpfFunZebra := TRBFuncoesZebra.cria(varia.PortaComunicacaoImpTermica,176,lzEPL);
  VpfFunZebra.ImprimeEtiquetaProdutoOP33x22(VprListaImpressaoProduto);
  FreeTObjectsList(VprListaImpressaoProduto);
  PageControl1.ActivePage := PFracionada;
  PImpressaoProduto.TabVisible := false;
  VpfFunZebra.Free;
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.EProdutoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 113 then
    AtualizaConsulta(false);
  if key = 107 then
  begin
    AdicionaProdutoImpressao;
    Key := 0;
    EProduto.Clear;
  end;
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.NumeroOP1Click(Sender: TObject);
begin
  FunOrdemProducao.ImprimeEtiquetaNroOP(OrdemProducaoSEQORD.AsInteger,OrdemProducaoC_NOM_CLI.AsString);
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.AlterarCliente1Click(Sender: TObject);
var
  VpfResultado : String;
begin
  if OrdemProducaoEMPFIL.AsInteger <> 0 then
  begin
    if EAlteraCliente.AAbreLocalizacao then
    begin
      VpfResultado := FunOrdemProducao.AlteraCliente(OrdemProducaoEMPFIL.AsInteger,OrdemProducaoSEQORD.AsInteger,EAlteraCliente.AInteiro);
      if VpfResultado <> '' then
        aviso(VpfResultado)
      else
        AtualizaConsulta(true);
    end;
  end;
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.MRegerarProjetoClick(Sender: TObject);
begin
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.ImprimirConsumo1Click(Sender: TObject);
var
  VpfDFracao : TRBDFracaoOrdemProducao;
begin
  if (TObject(Arvore.Selected.Data) is TRBDFracaoOrdemProducao) then
  begin
    VpfDFracao := TRBDFracaoOrdemProducao(Arvore.Selected.Data);
    FunOrdemProducao.GeraImpressaoConsumoFracao(VpfDFracao.CodFilial,VpfDFracao.SeqOrdemProducao,VpfDFracao.SeqFracao,false);
    FunCrystal.ImprimeRelatorio(varia.PathRelatorios+'\Ordem Produção\XX_ConsumoOPSubmontagem.rpt',[IntToStr(VpfDFracao.CodFilial)]);
  end;
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.ListaProdutosaExcluir1Click(Sender: TObject);
var
  VpfDFracao : TRBDFracaoOrdemProducao;
begin
  if (varia.TipoOrdemProducao = toSubMontagem) then
  begin
    if PageControl1.ActivePage = PFracionada then
    begin
      FunOrdemProducao.GeraImpressaoConsumoFracao(OrdemProducaoEMPFIL.AsInteger,OrdemProducaoSEQORD.AsInteger,OrdemProducaoSEQFRACAO.AsInteger,true);
      dtRave := TdtRave.create(self);
      dtRave.ImprimeConsumoSubmontagem(OrdemProducaoEMPFIL.AsInteger,OrdemProducaoSEQORD.AsInteger,OrdemProducaoSEQFRACAO.AsInteger,false,true);
      dtRave.free;
    end
    else
    begin
      if (TObject(Arvore.Selected.Data) is TRBDFracaoOrdemProducao) then
      begin
        VpfDFracao := TRBDFracaoOrdemProducao(Arvore.Selected.Data);
        FunOrdemProducao.GeraImpressaoConsumoFracao(VpfDFracao.CodFilial,VpfDFracao.SeqOrdemProducao,VpfDFracao.SeqFracao,true);
        dtRave := TdtRave.create(self);
        dtRave.ImprimeConsumoSubmontagem(VpfDFracao.CodFilial,VpfDFracao.SeqOrdemProducao,VpfDFracao.SeqFracao,false,true);
        dtRave.free;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.SemQuebraPgina1Click(Sender: TObject);
begin
  BFichaConsumoClick(Self);
end;

{******************************************************************************}
procedure TFOrdemProducaoGenerica.ConsultaLogSeparao1Click(
  Sender: TObject);
begin
  if OrdemProducaoSEQFRACAO.AsInteger <> 0 then
  begin
    FConsultaLogSeparacaoConsumo := TFConsultaLogSeparacaoConsumo.criarSDI(Application,'',FPrincipal.VerificaPermisao('FConsultaLogSeparacaoConsumo'));
    FConsultaLogSeparacaoConsumo.ConsultaLogSeparacaoFracao(OrdemProducaoEMPFIL.AsInteger,OrdemProducaoSEQORD.AsInteger,OrdemProducaoSEQFRACAO.AsInteger);
    FConsultaLogSeparacaoConsumo.free;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFOrdemProducaoGenerica]);
end.

