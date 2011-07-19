unit ASolicitacaoCompras;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, Componentes1, PainelGradiente, StdCtrls, Buttons, BotaoCadastro,
  Grids, DBGrids, Tabela, DBKeyViolation, Db, DBTables, ComCtrls, Menus, UnSolicitacaoCompra,
  Mask, numericos, Constantes, Localizacao, FMTBcd, SqlExpr, DBClient;

type
  TFSolicitacaoCompra = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    SOLICITACAOCOMPRACORPO: TSQL;
    DataSOLICITACAOCOMPRACORPO: TDataSource;
    SOLICITACAOCOMPRACORPOSEQSOLICITACAO: TFMTBCDField;
    SOLICITACAOCOMPRACORPODATEMISSAO: TSQLTimeStampField;
    SOLICITACAOCOMPRACORPODATFIM: TSQLTimeStampField;
    SOLICITACAOCOMPRACORPODATPREVISTA: TSQLTimeStampField;
    SOLICITACAOCOMPRACORPOVALTOTAL: TFMTBCDField;
    SOLICITACAOCOMPRACORPOUSUARIO: TWideStringField;
    SOLICITACAOCOMPRACORPODATAPROVACAO: TSQLTimeStampField;
    SOLICITACAOCOMPRACORPOC_NOM_USU: TWideStringField;
    SOLICITACAOCOMPRACORPOCODFILIAL: TFMTBCDField;
    SOLICITACAOCOMPRAITEM: TSQL;
    DataSOLICITACAOCOMPRAITEM: TDataSource;
    SOLICITACAOCOMPRAITEMCODFILIAL: TFMTBCDField;
    SOLICITACAOCOMPRAITEMSEQSOLICITACAO: TFMTBCDField;
    SOLICITACAOCOMPRAITEMSEQITEM: TFMTBCDField;
    SOLICITACAOCOMPRAITEMSEQPRODUTO: TFMTBCDField;
    SOLICITACAOCOMPRAITEMCODCOR: TFMTBCDField;
    SOLICITACAOCOMPRAITEMDESUM: TWideStringField;
    SOLICITACAOCOMPRAITEMQTDPRODUTO: TFMTBCDField;
    SOLICITACAOCOMPRAITEMC_COD_PRO: TWideStringField;
    SOLICITACAOCOMPRAITEMC_NOM_PRO: TWideStringField;
    SOLICITACAOCOMPRAITEMNOM_COR: TWideStringField;
    Popup: TPopupMenu;
    AprovarOramento1: TMenuItem;
    Aux: TSQL;
    N1: TMenuItem;
    AlteraEstgio1: TMenuItem;
    SOLICITACAOCOMPRACORPONOMEST: TWideStringField;
    Localiza: TConsultaPadrao;
    SOLICITACAOCOMPRACORPONOMCOMPRADOR: TWideStringField;
    Paginas: TPageControl;
    POrcamento: TTabSheet;
    PanelColor1: TPanelColor;
    Label4: TLabel;
    Label1: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    BEstagio: TSpeedButton;
    Label9: TLabel;
    Label13: TLabel;
    SpeedButton4: TSpeedButton;
    Label11: TLabel;
    DataInicial: TCalendario;
    DataFinal: TCalendario;
    ETipoPeriodo: TComboBoxColor;
    ESituacao: TComboBoxColor;
    EEstagio: TEditLocaliza;
    EComprador: TEditLocaliza;
    PanelColor3: TPanelColor;
    BFechar: TBitBtn;
    BCadastrar: TBitBtn;
    BAlterar: TBitBtn;
    BExcluir: TBitBtn;
    BConsultar: TBitBtn;
    BImprimir: TBitBtn;
    PanelColor2: TPanelColor;
    Splitter1: TSplitter;
    GItens: TGridIndice;
    GOrcamentos: TGridIndice;
    PanelColor4: TPanelColor;
    Label2: TLabel;
    Label5: TLabel;
    CAtualiza: TCheckBox;
    EQuantidade: Tnumerico;
    EValor: Tnumerico;
    PRODUTOSPENDENTES: TSQL;
    DataPRODUTOSPENDENTES: TDataSource;
    PRODUTOSPENDENTESI_SEQ_PRO: TFMTBCDField;
    PRODUTOSPENDENTESC_COD_PRO: TWideStringField;
    PRODUTOSPENDENTESC_NOM_PRO: TWideStringField;
    PRODUTOSPENDENTESCOD_COR: TFMTBCDField;
    PRODUTOSPENDENTESNOM_COR: TWideStringField;
    PRODUTOSPENDENTESC_COD_UNI: TWideStringField;
    PRODUTOSPENDENTESQTDPRODUTO: TFMTBCDField;
    Label15: TLabel;
    EProduto: TEditColor;
    SpeedButton3: TSpeedButton;
    Label16: TLabel;
    BProdutosPendentes: TBitBtn;
    N2: TMenuItem;
    PedidosdeCompra1: TMenuItem;
    SOLICITACAOCOMPRAITEMQTDAPROVADO: TFMTBCDField;
    Label12: TLabel;
    SpeedButton2: TSpeedButton;
    Label14: TLabel;
    Label17: TLabel;
    SpeedButton6: TSpeedButton;
    Label18: TLabel;
    Label19: TLabel;
    SpeedButton7: TSpeedButton;
    Label20: TLabel;
    EFilialOP: TEditLocaliza;
    EOrdemProducao: TEditLocaliza;
    EFracao: TEditLocaliza;
    BFiltros: TBitBtn;
    CPeriodo: TCheckBox;
    Label3: TLabel;
    SpeedButton1: TSpeedButton;
    Label6: TLabel;
    EFilial: TEditLocaliza;
    EProposta: Tnumerico;
    Label10: TLabel;
    N3: TMenuItem;
    ConsultaPropostasVendas1: TMenuItem;
    SOLICITACAOCOMPRAITEMQTDCOMPRADA: TFMTBCDField;
    ESolicitacao: Tnumerico;
    Label21: TLabel;
    EPedidoCompra: Tnumerico;
    Label22: TLabel;
    PopupMenu1: TPopupMenu;
    AdicionaraoFiltro1: TMenuItem;
    PainelTempo1: TPainelTempo;
    SOLICITACAOCOMPRAITEMQTDCHAPA: TFMTBCDField;
    SOLICITACAOCOMPRAITEMLARCHAPA: TFMTBCDField;
    SOLICITACAOCOMPRAITEMCOMCHAPA: TFMTBCDField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure GItensOrdem(Ordem: String);
    procedure DataInicialCloseUp(Sender: TObject);
    procedure BCadastrarClick(Sender: TObject);
    procedure BExcluirClick(Sender: TObject);
    procedure BConsultarClick(Sender: TObject);
    procedure BAlterarClick(Sender: TObject);
    procedure SOLICITACAOCOMPRACORPOAfterScroll(DataSet: TDataSet);
    procedure GOrcamentosOrdem(Ordem: String);
    procedure AprovarOramento1Click(Sender: TObject);
    procedure CAtualizaClick(Sender: TObject);
    procedure AlteraEstgio1Click(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure PaginasChange(Sender: TObject);
    procedure EProdutoExit(Sender: TObject);
    procedure EProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton3Click(Sender: TObject);
    procedure BProdutosPendentesClick(Sender: TObject);
    procedure PedidosdeCompra1Click(Sender: TObject);
    procedure EOrdemProducaoSelect(Sender: TObject);
    procedure EFracaoSelect(Sender: TObject);
    procedure BFiltrosClick(Sender: TObject);
    procedure ConsultaPropostasVendas1Click(Sender: TObject);
    procedure ESolicitacaoExit(Sender: TObject);
    procedure ESolicitacaoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure AdicionaraoFiltro1Click(Sender: TObject);
  private
    VprSeqProduto: Integer;
    VprOrdem,
    VprOrdemItens: String;
    FunOrcamentoCompra: TRBFunSolicitacaoCompra;
    procedure AtualizaConsulta(VpaPosicionar : Boolean);
    procedure AdicionaFiltros(VpaSelect: TStrings);
    procedure PosItensSolicitacao;
    procedure InicializaTela;
    procedure AtualizaTotais;
    function ExisteProduto: Boolean;
    function LocalizaProduto: Boolean;
    procedure ConfiguraPermissaoUsuario;
  public
    procedure ConsultaOP(VpaCodFilial,VpaSeqOrdem : Integer);
    procedure ConsultaProposta(VpaCodFilial, VpaSeqProposta : Integer);
    procedure ConsultaPedidoCompa(VpaCodfilial,VpaSeqPedido : Integer);
    procedure ConsultaProdutoOP(VpaCodFilial,VpaSeqOrdem, VpaSeqProduto : Integer;VpaCodProduto, VpaNomProduto : String);
  end;

var
  FSolicitacaoCompra: TFSolicitacaoCompra;

implementation
uses
  APrincipal, UnProdutos, FunSQL, FunData, ConstMsg, ANovaSolicitacaoCompra, FunObjeto,
  ANovoPedidoCompra, AAlteraEstagioOrcamento, UnCrystal, UnDados,
  ALocalizaProdutos, ASolicitacaoCompraProdutosPendentes, APedidoCompra,
  APropostasCliente, dmRave;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFSolicitacaoCompra.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunOrcamentoCompra:= TRBFunSolicitacaoCompra.Cria(FPrincipal.BaseDados);
  ConfiguraPermissaoUsuario;
  InicializaTela;
  VprOrdem:= ' ORDER BY SEQSOLICITACAO';
  VprOrdemItens:= ' ORDER BY SEQITEM';
  AtualizaConsulta(false);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFSolicitacaoCompra.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunOrcamentoCompra.Free;
  SOLICITACAOCOMPRACORPO.close;
  SOLICITACAOCOMPRAITEM.close;
  Aux.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFSolicitacaoCompra.ConfiguraPermissaoUsuario;
begin
  GItens.Columns[3].Visible := Config.ControlarEstoquedeChapas;
  GItens.Columns[4].Visible := Config.ControlarEstoquedeChapas;
  GItens.Columns[5].Visible := Config.ControlarEstoquedeChapas;
  GItens.Columns[2].Visible := Config.EstoquePorCor;
  if not((puAdministrador in varia.PermissoesUsuario) or (puPLCompleto in varia.PermissoesUsuario)) then
  begin
    AlterarVisibleDet([BCadastrar],false);
    if (puESCadastrarSolicitacaoCompra in varia.PermissoesUsuario) then
      AlterarVisibleDet([BCadastrar],true);
  end;

end;

{******************************************************************************}
procedure TFSolicitacaoCompra.ConsultaOP(VpaCodFilial,VpaSeqOrdem : Integer);
begin
  EFilialOP.AInteiro := VpaCodFilial;
  EOrdemProducao.AInteiro := VpaSeqOrdem;
  CPeriodo.Checked := false;
  AtualizaConsulta(false);
  ShowModal;
end;

{******************************************************************************}
procedure TFSolicitacaoCompra.ConsultaProdutoOP(VpaCodFilial, VpaSeqOrdem, VpaSeqProduto: Integer;VpaCodProduto, VpaNomProduto : String);
begin
  EFilialOP.AInteiro := VpaCodFilial;
  EOrdemProducao.AInteiro := VpaSeqOrdem;
  EProduto.Text := VpaCodProduto;
  VprSeqProduto := VpaSeqProduto;
  Label16.Caption := VpaNomProduto;
  CPeriodo.Checked := false;
  AtualizaConsulta(false);
  ShowModal;
end;

{******************************************************************************}
procedure TFSolicitacaoCompra.ConsultaProposta(VpaCodFilial, VpaSeqProposta : Integer);
begin
  EFilial.AInteiro := VpaCodFilial;
  EProposta.AsInteger := VpaSeqProposta;
  CPeriodo.Checked := false;
  AtualizaConsulta(false);
  ShowModal;
end;

{******************************************************************************}
procedure TFSolicitacaoCompra.ConsultaPedidoCompa(VpaCodfilial,VpaSeqPedido : Integer);
begin
  EFilial.AInteiro := VpaCodFilial;
  EPedidoCompra.AsInteger := VpaSeqPedido;
  CPeriodo.Checked := false;
  AtualizaConsulta(false);
  ShowModal;
end;

{******************************************************************************}
procedure TFSolicitacaoCompra.BFecharClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFSolicitacaoCompra.AtualizaConsulta(VpaPosicionar : Boolean);
var
  VpfPosicao : TBookmark;
begin
  VpfPosicao := SOLICITACAOCOMPRACORPO.GetBookmark;
  SOLICITACAOCOMPRAITEM.Close;
  SOLICITACAOCOMPRACORPO.close;
  SOLICITACAOCOMPRACORPO.SQL.Clear;
  SOLICITACAOCOMPRACORPO.SQL.Add('SELECT'+
                                 ' SCC.SEQSOLICITACAO, SCC.CODFILIAL,'+
                                 ' SCC.DATEMISSAO, SCC.DATFIM,'+
                                 ' SCC.DATPREVISTA, SCC.VALTOTAL,'+
                                 ' ESP.NOMEST,'+
                                 ' USU.C_NOM_USU USUARIO, SCC.DATAPROVACAO, USUA.C_NOM_USU,'+
                                 ' COM.NOMCOMPRADOR'+
                                 ' FROM'+
                                 ' SOLICITACAOCOMPRACORPO SCC,'+
                                 ' CADUSUARIOS USU,'+
                                 ' CADUSUARIOS USUA,'+
                                 ' ESTAGIOPRODUCAO ESP,'+
                                 ' COMPRADOR COM'+
                                 ' WHERE'+
                                 ' USU.I_COD_USU = SCC.CODUSUARIO'+
                                 ' AND '+SQLTextoRightJoin('SCC.CODUSUARIOAPROVACAO','USUA.I_COD_USU')+
                                 ' AND '+SQLTextoRightJoin('SCC.CODESTAGIO','ESP.CODEST')+
                                 ' AND '+SQLTextoRightJoin('SCC.CODCOMPRADOR','COM.CODCOMPRADOR'));
  AdicionaFiltros(SOLICITACAOCOMPRACORPO.SQL);
  SOLICITACAOCOMPRACORPO.SQL.Add(VprOrdem);
  GOrcamentos.ALinhaSQLOrderBy:= SOLICITACAOCOMPRACORPO.SQL.Count-1;
  SOLICITACAOCOMPRACORPO.Open;
  if SOLICITACAOCOMPRACORPO.Eof then
    SOLICITACAOCOMPRAITEM.Close;
  if VpaPosicionar  then
  begin
    try
      SOLICITACAOCOMPRACORPO.GotoBookmark(VpfPosicao);
    except
      SOLICITACAOCOMPRACORPO.Last;
      try
        SOLICITACAOCOMPRACORPO.GotoBookmark(VpfPosicao);
      except
      end;
    end;
  end;
  SOLICITACAOCOMPRACORPO.FreeBookmark(VpfPosicao);
end;

{******************************************************************************}
procedure TFSolicitacaoCompra.AdicionaFiltros(VpaSelect: TStrings);
begin
  if ESolicitacao.AsInteger <> 0 then
    VpaSelect.Add('and SCC.SEQSOLICITACAO = '+ESolicitacao.Text)
  else
  begin
    if CPeriodo.Checked then
    begin
      case ETipoPeriodo.ItemIndex of
        0: VpaSelect.Add(SQLTextoDataEntreAAAAMMDD('SCC.DATEMISSAO',DataInicial.DateTime,DataFinal.DateTime,True));
        1: VpaSelect.Add(SQLTextoDataEntreAAAAMMDD('SCC.DATPREVISTA',DataInicial.DateTime,DataFinal.DateTime,True));
      end;
    end;
    case ESituacao.ItemIndex of
      1: VpaSelect.Add(' AND SCC.DATAPROVACAO IS NOT NULL');
      2: VpaSelect.Add(' AND SCC.DATAPROVACAO IS NULL');
    end;
    if EEstagio.Text <> '' then
      VpaSelect.Add(' AND SCC.CODESTAGIO = '+EEstagio.Text);
    if EFilial.Text <> '' then
      VpaSelect.Add(' AND SCC.CODFILIAL = '+EFilial.Text);
    if EComprador.Text <> '' then
      VpaSelect.Add(' AND SCC.CODCOMPRADOR = '+EComprador.Text);
    if EProduto.Text <> '' then
      VpaSelect.Add(' AND EXISTS (SELECT SCI.SEQSOLICITACAO'+
                    '             FROM SOLICITACAOCOMPRAITEM SCI'+
                    '             WHERE SCI.SEQPRODUTO = '+IntToStr(VprSeqProduto)+
                    '             AND SCC.CODFILIAL = SCI.CODFILIAL'+
                    '             AND SCC.SEQSOLICITACAO = SCI.SEQSOLICITACAO)');
    if (EOrdemProducao.AInteiro <> 0) or (EFracao.AInteiro <> 0) then
    begin
      VpaSelect.Add('AND EXISTS '+
                    '( SELECT * FROM SOLICITACAOCOMPRAFRACAOOP FRA '+
                    ' Where FRA.CODFILIALFRACAO = '+IntToStr(EFilialOP.AInteiro));
      if EOrdemProducao.AInteiro <> 0 then
        VpaSelect.add(' and FRA.SEQORDEM = '+IntToStr(EOrdemProducao.AInteiro));
      if EFracao.AInteiro <> 0 then
        VpaSelect.add(' AND FRA.SEQFRACAO = '+IntToStr(EFracao.AInteiro));
      VpaSelect.add('AND FRA.CODFILIAL = SCC.CODFILIAL '+
                    ' AND FRA.SEQSOLICITACAO = SCC.SEQSOLICITACAO )');
    end;
    if (EPedidoCompra.AsInteger <> 0) then
      VpaSelect.Add(' AND EXISTS('+
                    ' SELECT *'+
                    ' FROM PEDIDOSOLICITACAOCOMPRA PSC'+
                    ' WHERE PSC.CODFILIAL = SCC.CODFILIAL'+
                    ' AND PSC.SEQPEDIDO = '+EPedidoCompra.Text+
                    ' AND PSC.SEQSOLICITACAO = SCC.SEQSOLICITACAO)');


    if (EProposta.AsInteger <> 0) then
    begin
      VpaSelect.Add('AND EXISTS '+
                    '( SELECT * FROM PROPOSTASOLICITACAOCOMPRA PRT '+
                    ' Where PRT.SEQPROPOSTA = '+IntToStr(EProposta.AsInteger));
      if EFilial.AInteiro <> 0 then
        VpaSelect.add(' and PRT.CODFILIAL = '+IntToStr(EFilial.AInteiro));
      VpaSelect.add('AND PRT.CODFILIAL = SCC.CODFILIAL '+
                    ' AND PRT.SEQSOLICITACAO = SCC.SEQSOLICITACAO )');
    end;
  end;
end;

{******************************************************************************}
procedure TFSolicitacaoCompra.GItensOrdem(Ordem: String);
begin
  VprOrdemItens:= Ordem;
end;

{******************************************************************************}
procedure TFSolicitacaoCompra.InicializaTela;
begin
  Paginas.ActivePage:= POrcamento;
  DataInicial.DateTime:= PrimeiroDiaMes(Date);
  DataFinal.DateTime:= UltimoDiaMes(Date);
  ETipoPeriodo.ItemIndex:= 0;
  ESituacao.ItemIndex:= 0;
  EFilial.AInteiro:= Varia.CodigoEmpFil;
  EFilial.Atualiza;
  EComprador.AInteiro:= Varia.CodComprador;
  EComprador.Atualiza;
end;

{******************************************************************************}
procedure TFSolicitacaoCompra.DataInicialCloseUp(Sender: TObject);
begin
  AtualizaConsulta(false);
end;

{******************************************************************************}
procedure TFSolicitacaoCompra.BCadastrarClick(Sender: TObject);
begin
  FNovaSolicitacaoCompras:= TFNovaSolicitacaoCompras.CriarSDI(Application,'',True);
  if FNovaSolicitacaoCompras.NovoOrcamento then
    AtualizaConsulta(false);
  FNovaSolicitacaoCompras.Free;
end;

{******************************************************************************}
procedure TFSolicitacaoCompra.BExcluirClick(Sender: TObject);
begin
  if SOLICITACAOCOMPRACORPOSEQSOLICITACAO.AsInteger <> 0 then
  begin
    FNovaSolicitacaoCompras:= TFNovaSolicitacaoCompras.CriarSDI(Application,'',True);
    if FNovaSolicitacaoCompras.Apagar(SOLICITACAOCOMPRACORPOCODFILIAL.AsInteger,SOLICITACAOCOMPRACORPOSEQSOLICITACAO.AsInteger) then
      AtualizaConsulta(true);
    FNovaSolicitacaoCompras.Free;
  end;
end;

{******************************************************************************}
procedure TFSolicitacaoCompra.BConsultarClick(Sender: TObject);
begin
  if SOLICITACAOCOMPRACORPOSEQSOLICITACAO.AsInteger <> 0 then
  begin
    FNovaSolicitacaoCompras:= TFNovaSolicitacaoCompras.CriarSDI(Application,'',True);
    if FNovaSolicitacaoCompras.Consultar(SOLICITACAOCOMPRACORPOCODFILIAL.AsInteger,SOLICITACAOCOMPRACORPOSEQSOLICITACAO.AsInteger) then
      AtualizaConsulta(true);
    FNovaSolicitacaoCompras.Free;
  end;
end;

{******************************************************************************}
procedure TFSolicitacaoCompra.BAlterarClick(Sender: TObject);
begin
  if SOLICITACAOCOMPRACORPOSEQSOLICITACAO.AsInteger <> 0 then
  begin
    FNovaSolicitacaoCompras:= TFNovaSolicitacaoCompras.CriarSDI(Application,'',True);
    if FNovaSolicitacaoCompras.Alterar(SOLICITACAOCOMPRACORPOCODFILIAL.AsInteger,SOLICITACAOCOMPRACORPOSEQSOLICITACAO.AsInteger) then
      AtualizaConsulta(true);
    FNovaSolicitacaoCompras.Free;
  end;
end;

{******************************************************************************}
procedure TFSolicitacaoCompra.SOLICITACAOCOMPRACORPOAfterScroll(DataSet: TDataSet);
begin
  BAlterar.Enabled := SOLICITACAOCOMPRACORPODATAPROVACAO.IsNull;
//  BExcluir.Enabled := SOLICITACAOCOMPRACORPODATAPROVACAO.IsNull;
  PosItensSolicitacao;
  if (puAdministrador in varia.PermissoesUsuario) then
  begin
    BAlterar.Enabled := true;
    BExcluir.Enabled := True;
  end;
end;

{******************************************************************************}
procedure TFSolicitacaoCompra.PosItensSolicitacao;
begin
  if SOLICITACAOCOMPRACORPOSEQSOLICITACAO.AsInteger <> 0 then
  begin
    SOLICITACAOCOMPRAITEM.close;
    SOLICITACAOCOMPRAITEM.SQL.Clear;
    SOLICITACAOCOMPRAITEM.SQL.Add('SELECT SCI.CODFILIAL, SCI.SEQSOLICITACAO, SCI.SEQITEM, SCI.SEQPRODUTO, SCI.DESUM, '+
                                  ' SCI.QTDPRODUTO, SCI.QTDAPROVADO, PRO.C_COD_PRO, SCI.QTDCOMPRADA, '+
                                  ' SCI.QTDCHAPA, SCI.LARCHAPA, SCI.COMCHAPA, ' +
                                  ' PRO.C_NOM_PRO, SCI.CODCOR, COR.NOM_COR '+
                                  ' FROM SOLICITACAOCOMPRAITEM SCI, CADPRODUTOS PRO, COR COR'+
                                  ' WHERE SCI.CODFILIAL = '+SOLICITACAOCOMPRACORPOCODFILIAL.AsString+
                                  ' AND SCI.SEQSOLICITACAO = '+SOLICITACAOCOMPRACORPOSEQSOLICITACAO.AsString+
                                  ' AND PRO.I_SEQ_PRO = SCI.SEQPRODUTO'+
                                  ' AND '+SQLTextoRightJoin('SCI.CODCOR','COR.COD_COR'));
    SOLICITACAOCOMPRAITEM.SQL.Add(VprOrdemItens);
    GItens.ALinhaSQLOrderBy:= SOLICITACAOCOMPRAITEM.SQL.Count-1;
    SOLICITACAOCOMPRAITEM.Open;
  end
  else
    SOLICITACAOCOMPRACORPO.Close;
end;

{******************************************************************************}
procedure TFSolicitacaoCompra.GOrcamentosOrdem(Ordem: String);
begin
  VprOrdem:= Ordem;
end;

{******************************************************************************}
procedure TFSolicitacaoCompra.AprovarOramento1Click(Sender: TObject);
var
  VpfResultado: String;
begin
  if SOLICITACAOCOMPRACORPODATAPROVACAO.IsNull then
  begin
    if Confirmacao('Tem certeza que deseja aprovar o orçamento número '+IntToStr(SOLICITACAOCOMPRACORPOSEQSOLICITACAO.AsInteger)+'?') then
    begin
    //verificar usar o estagio da solicitacao de compra
      VpfResultado:= FunOrcamentoCompra.AprovarOrcamento(SOLICITACAOCOMPRACORPOCODFILIAL.AsInteger,SOLICITACAOCOMPRACORPOSEQSOLICITACAO.AsInteger);
      if VpfResultado <> '' then
        aviso(VpfResultado)
      else
      begin
        VpfResultado:= FunOrcamentoCompra.AlteraEstagioOrcamento(SOLICITACAOCOMPRACORPOCODFILIAL.AsInteger,SOLICITACAOCOMPRACORPOSEQSOLICITACAO.AsInteger,varia.EstagioOrcamentoCompraAprovado,'Aprovação');
        AtualizaConsulta(true);
      end;
    end
  end
  else
    aviso('Este orçamento já foi aprovado!');
end;

{******************************************************************************}
procedure TFSolicitacaoCompra.CAtualizaClick(Sender: TObject);
begin
  AtualizaTotais;
end;

{******************************************************************************}
procedure TFSolicitacaoCompra.AtualizaTotais;
begin
  EQuantidade.AValor:= 0;
  EValor.AValor:= 0;
  if CAtualiza.Checked then
  begin
    Aux.SQL.Clear;
    Aux.SQL.Add('SELECT COUNT(SEQSOLICITACAO) QTD, SUM(VALTOTAL) VALOR'+
                ' FROM SOLICITACAOCOMPRACORPO'+
                ' WHERE SEQSOLICITACAO = SEQSOLICITACAO');
    AdicionaFiltros(Aux.SQL);
    Aux.Open;
    EQuantidade.AValor:= Aux.FieldByName('QTD').AsInteger;
    EValor.AValor:= Aux.FieldByName('VALOR').AsFloat;
  end;
end;

{******************************************************************************}
procedure TFSolicitacaoCompra.AdicionaraoFiltro1Click(Sender: TObject);
begin
  EProduto.Text := SOLICITACAOCOMPRAITEMC_COD_PRO.AsString;
  VprSeqProduto := SOLICITACAOCOMPRAITEMSEQPRODUTO.AsInteger;
  DataInicial.Date := DecMes(date,3);
  AtualizaConsulta(false);
end;

procedure TFSolicitacaoCompra.AlteraEstgio1Click(Sender: TObject);
begin
  if SOLICITACAOCOMPRACORPOCODFILIAL.AsInteger <> 0 then
  begin
    FAlteraEstagioOrcamentoCompra:= TFAlteraEstagioOrcamentoCompra.CriarSDI(Application,'',True);
    if FAlteraEstagioOrcamentoCompra.AlteraEstagioOrcamento(SOLICITACAOCOMPRACORPOCODFILIAL.AsInteger,SOLICITACAOCOMPRACORPOSEQSOLICITACAO.AsInteger) then
      AtualizaConsulta(true);
    FAlteraEstagioOrcamentoCompra.Free;
  end;
end;

{******************************************************************************}
procedure TFSolicitacaoCompra.BImprimirClick(Sender: TObject);
begin
  if SOLICITACAOCOMPRACORPOCODFILIAL.AsInteger <> 0 then
  begin
    dtRave := TdtRave.create(self);
    dtRave.ImprimeSolicitacaoCompra(SOLICITACAOCOMPRACORPOCODFILIAL.AsInteger ,SOLICITACAOCOMPRACORPOSEQSOLICITACAO.AsInteger,true);
    dtRave.free;
  end;
end;

{******************************************************************************}
procedure TFSolicitacaoCompra.PaginasChange(Sender: TObject);
begin
  if Paginas.ActivePage = POrcamento then
    AtualizaConsulta(false);
end;

{******************************************************************************}
procedure TFSolicitacaoCompra.EProdutoExit(Sender: TObject);
begin
  ExisteProduto;
  AtualizaConsulta(false);
end;

{******************************************************************************}
function TFSolicitacaoCompra.ExisteProduto: Boolean;
var
  VpfUM,
  VpfNomProduto: String;
begin
  Result:= FunProdutos.ExisteProduto(EProduto.Text,VprSeqProduto,VpfNomProduto,VpfUM);
  if Result then
    Label16.Caption:= VpfNomProduto
  else
    Label16.Caption:= '';
end;

{******************************************************************************}
function TFSolicitacaoCompra.LocalizaProduto: Boolean;
var
  VpfCodProduto,
  VpfNomProduto,
  VpfDesUM,
  VpfClaFiscal: String;
begin
  FlocalizaProduto := TFlocalizaProduto.criarSDI(Application,'',FPrincipal.VerificaPermisao('FlocalizaProduto'));
  Result:= FlocalizaProduto.LocalizaProduto(VprSeqProduto,VpfCodProduto,VpfNomProduto,VpfDesUM,VpfClaFiscal);
  FlocalizaProduto.free;
  if Result then
  begin
    EProduto.Text:= VpfCodProduto;
    Label16.Caption:= VpfNomProduto;
  end
  else
  begin
    EProduto.Text:= '';
    Label16.Caption:= '';
  end;
end;

{******************************************************************************}
procedure TFSolicitacaoCompra.EProdutoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    13: begin
          if ExisteProduto then
            AtualizaConsulta(false)
          else
            if LocalizaProduto then
              AtualizaConsulta(false);
        end;
    114: if LocalizaProduto then
           AtualizaConsulta(false);
  end;
end;

procedure TFSolicitacaoCompra.ESolicitacaoExit(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFSolicitacaoCompra.ESolicitacaoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = 13 then
    AtualizaConsulta(false);
end;

{******************************************************************************}
procedure TFSolicitacaoCompra.SpeedButton3Click(Sender: TObject);
begin
  if LocalizaProduto then
    AtualizaConsulta(false);
end;

{******************************************************************************}
procedure TFSolicitacaoCompra.BProdutosPendentesClick(Sender: TObject);
begin
  PainelTempo1.execute('Aguarde. Carregando os produtos...');
  FSolicitacaoCompraProdutosPendentes:= TFSolicitacaoCompraProdutosPendentes.CriarSDI(Application,'', True);
  if FSolicitacaoCompraProdutosPendentes.CarregarProdutosPendentes then
    AtualizaConsulta(true);
  FSolicitacaoCompraProdutosPendentes.Free;
  PainelTempo1.fecha;
end;

{******************************************************************************}
procedure TFSolicitacaoCompra.PedidosdeCompra1Click(Sender: TObject);
begin
  FPedidoCompra:= TFPedidoCompra.CriarSDI(Application,'',True);
  FPedidoCompra.ConsultaPedidosSolicitacao(SOLICITACAOCOMPRACORPOSEQSOLICITACAO.AsInteger);
  FPedidoCompra.Free;
end;

{******************************************************************************}
procedure TFSolicitacaoCompra.EOrdemProducaoSelect(Sender: TObject);
begin
  EOrdemProducao.ASelectLocaliza.Text := 'Select ORD.SEQORD, ORD.DATEMI, CLI.C_NOM_CLI from ORDEMPRODUCAOCORPO ORD, CADCLIENTES CLI '+
                                         ' Where ORD.EMPFIL = '+ IntToStr(EFilial.AInteiro)+
                                         ' and ORD.CODCLI = CLI.I_COD_CLI '+
                                         ' AND CLI.C_NOM_CLI like ''@%''';
  EOrdemProducao.ASelectValida.Text := 'Select ORD.SEQORD, ORD.DATEMI, CLI.C_NOM_CLI From ORDEMPRODUCAOCORPO ORD, CADCLIENTES CLI '+
                                         ' Where ORD.EMPFIL = '+ IntToStr(EFilial.AInteiro)+
                                         ' and ORD.CODCLI = CLI.I_COD_CLI '+
                                         ' AND ORD.SEQORD = @';
end;

{******************************************************************************}
procedure TFSolicitacaoCompra.EFracaoSelect(Sender: TObject);
begin
  EFracao.ASelectLocaliza.Text := 'SELECT FRA.SEQFRACAO, FRA.DATENTREGA, FRA.QTDPRODUTO, FRA.CODESTAGIO from FRACAOOP FRA '+
                                  ' Where FRA.SEQFRACAO LIKE ''@%'''+
                                  ' AND FRA.CODFILIAL = '+IntToStr(EFilial.AInteiro)+
                                  ' and FRA.SEQORDEM = '+IntToStr(EOrdemProducao.AInteiro);
  EFracao.ASelectValida.Text := 'SELECT FRA.SEQFRACAO, FRA.DATENTREGA, FRA.QTDPRODUTO, FRA.CODESTAGIO from FRACAOOP FRA '+
                                  ' Where FRA.SEQFRACAO = @ '+
                                  ' AND FRA.CODFILIAL = '+IntToStr(EFilial.AInteiro)+
                                  ' and FRA.SEQORDEM = '+IntToStr(EOrdemProducao.AInteiro);
end;

{******************************************************************************}
procedure TFSolicitacaoCompra.BFiltrosClick(Sender: TObject);
begin
  if BFiltros.Caption = '>>' then
  begin
    if screen.Height = 768 then
      PanelColor1.Height := 260
    else
      PanelColor1.Height := 211;
    BFiltros.Caption := '<<';
  end
  else
  begin
    if screen.Height = 768 then
      PanelColor1.Height := 67
    else
      PanelColor1.Height := 52;
    BFiltros.Caption := '>>';
  end;
end;

procedure TFSolicitacaoCompra.ConsultaPropostasVendas1Click(Sender: TObject);
begin
  if SOLICITACAOCOMPRACORPOCODFILIAL.AsInteger <> 0 then
  begin
    FPropostasCliente := TFPropostasCliente.CriarSDI(self,'',FPrincipal.VerificaPermisao('FPropostasCliente'));
    FPropostasCliente.ConsultaOrcamentoCompra(SOLICITACAOCOMPRACORPOCODFILIAL.AsInteger,SOLICITACAOCOMPRACORPOSEQSOLICITACAO.AsInteger);
    FPropostasCliente.free;

  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFSolicitacaoCompra]);
end.


