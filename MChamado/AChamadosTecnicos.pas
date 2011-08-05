unit AChamadosTecnicos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Grids, DBGrids, Tabela, DBKeyViolation, Componentes1, ExtCtrls,
  PainelGradiente, Db, DBTables, StdCtrls, Buttons, Mask, numericos,
  ComCtrls, Localizacao, UnChamado, UnDados, DBCtrls, Menus, Graficos, DBClient, UnSistema;

type
  TFChamadoTecnico = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    Grade: TGridIndice;
    ChamadoTecnico: TSQL;
    DataChamadoTecnico: TDataSource;
    ChamadoTecnicoCODFILIAL: TFMTBCDField;
    ChamadoTecnicoNUMCHAMADO: TFMTBCDField;
    ChamadoTecnicoDATCHAMADO: TSQLTimeStampField;
    ChamadoTecnicoDATPREVISAO: TSQLTimeStampField;
    ChamadoTecnicoNOMSOLICITANTE: TWideStringField;
    ChamadoTecnicoVALCHAMADO: TFMTBCDField;
    ChamadoTecnicoVALDESLOCAMENTO: TFMTBCDField;
    ChamadoTecnicoC_NOM_CLI: TWideStringField;
    ChamadoTecnicoNOMTECNICO: TWideStringField;
    ChamadoTecnicoC_NOM_USU: TWideStringField;
    Label1: TLabel;
    Label2: TLabel;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    EChamado: Tnumerico;
    Label3: TLabel;
    ECliente: TEditLocaliza;
    Label4: TLabel;
    SpeedButton1: TSpeedButton;
    LNomCliente: TLabel;
    Localiza: TConsultaPadrao;
    ChamadoTecnicoNOMEST: TWideStringField;
    Label6: TLabel;
    ETecnico: TEditLocaliza;
    Label8: TLabel;
    SpeedButton3: TSpeedButton;
    LNomTecnico: TLabel;
    ETipoPeriodo: TComboBoxColor;
    Label10: TLabel;
    ChamadoTecnicoCODESTAGIO: TFMTBCDField;
    ChamadoTecnicoCODTECNICO: TFMTBCDField;
    ChamadoProduto: TSQL;
    DataChamadoProduto: TDataSource;
    ChamadoProdutoSEQITEM: TFMTBCDField;
    ChamadoProdutoSEQPRODUTO: TFMTBCDField;
    ChamadoProdutoNUMCONTADOR: TFMTBCDField;
    ChamadoProdutoNUMSERIE: TWideStringField;
    ChamadoProdutoNUMSERIEINTERNO: TWideStringField;
    ChamadoProdutoDESSETOR: TWideStringField;
    ChamadoProdutoDATGARANTIA: TSQLTimeStampField;
    ChamadoProdutoC_NOM_PRO: TWideStringField;
    ChamadoProdutoSEQCONTRATO: TFMTBCDField;
    ChamadoProdutoCODTIPOCONTRATO: TFMTBCDField;
    PanelColor3: TPanelColor;
    Splitter1: TSplitter;
    GridIndice1: TGridIndice;
    ChamadoProdutoTIPOCONTRATO: TWideStringField;
    DBMemoColor1: TDBMemoColor;
    ChamadoProdutoDESPROBLEMA: TWideStringField;
    ChamadoProdutoCODFILIALCONTRATO: TFMTBCDField;
    PanelColor2: TPanelColor;
    BCadastrar: TBitBtn;
    BAlterar: TBitBtn;
    BConsultar: TBitBtn;
    BExcluir: TBitBtn;
    BImprimir: TBitBtn;
    BFechar: TBitBtn;
    BGerarCotacao: TBitBtn;
    BAgenda: TBitBtn;
    ChamadoTecnicoNOMTIPOCHAMADO: TWideStringField;
    ETipoChamado: TEditLocaliza;
    Label11: TLabel;
    SpeedButton5: TSpeedButton;
    LTipoChamado: TLabel;
    PopupMenu1: TPopupMenu;
    EfetuarPesquisaSatisfao1: TMenuItem;
    MAlterarEstagio : TMenuItem;
    CPesquisa: TCheckBox;
    BImplantacao: TBitBtn;
    BGraficos: TBitBtn;
    PGraficos: TCorPainelGra;
    BitBtn4: TBitBtn;
    PanelColor5: TPanelColor;
    Label17: TLabel;
    Label12: TLabel;
    BMeioDivulgacao: TBitBtn;
    BFechaGrafico: TBitBtn;
    BVendedor: TBitBtn;
    BProduto: TBitBtn;
    BData: TBitBtn;
    BEstado: TBitBtn;
    GraficosTrio: TGraficosTrio;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    ChamadoTecnicoLANORCAMENTO: TFMTBCDField;
    ChamadoProdutoDESUM: TWideStringField;
    ChamadoProdutoQTDPRODUTO: TFMTBCDField;
    N1: TMenuItem;
    GerarProposta1: TMenuItem;
    ChamadoProdutoQTDBAIXADO: TFMTBCDField;
    N3: TMenuItem;
    SeparaoProdutos1: TMenuItem;
    ConsultaSeparaoProdutos1: TMenuItem;
    N4: TMenuItem;
    RetornoProdutos1: TMenuItem;
    ConsultaRetornoProdutos1: TMenuItem;
    GerarPropostaProdutosExtras1: TMenuItem;
    ConsultaPropostas1: TMenuItem;
    ECodEstagio: TEditLocaliza;
    LNomEstagio: TLabel;
    SpeedButton2: TSpeedButton;
    CEstagio: TComboBoxColor;
    Label5: TLabel;
    MImprimir: TPopupMenu;
    Chamadoc1: TMenuItem;
    Label7: TLabel;
    EFilial: TEditLocaliza;
    SpeedButton4: TSpeedButton;
    LFilial: TLabel;
    ChamadoTecnicoINDFIN: TWideStringField;
    N7: TMenuItem;
    GeraSolicitaodeCompras1: TMenuItem;
    ConsultarSolicitao1: TMenuItem;
    ImprimirSolicitacaoProducao1: TMenuItem;
    N5: TMenuItem;
    ImprimeProdutosPendentesaProduzir1: TMenuItem;
    ChamadoTecnicoI_COD_CLI: TFMTBCDField;
    N6: TMenuItem;
    EnviarEmailBoleto1: TMenuItem;
    AlteraCliente1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCadastrarClick(Sender: TObject);
    procedure BAlterarClick(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure BConsultarClick(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure EChamadoExit(Sender: TObject);
    procedure ECodEstagioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BExcluirClick(Sender: TObject);
    procedure GradeOrdem(Ordem: String);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BGerarCotacaoClick(Sender: TObject);
    procedure ChamadoTecnicoAfterScroll(DataSet: TDataSet);
    procedure BAgendaClick(Sender: TObject);
    procedure ChamadoProdutoCalcFields(DataSet: TDataSet);
    procedure EfetuarPesquisaSatisfao1Click(Sender: TObject);
    procedure BImplantacaoClick(Sender: TObject);
    procedure BMeioDivulgacaoClick(Sender: TObject);
    procedure BGraficosClick(Sender: TObject);
    procedure BFechaGraficoClick(Sender: TObject);
    procedure BVendedorClick(Sender: TObject);
    procedure BProdutoClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BDataClick(Sender: TObject);
    procedure BEstadoClick(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure GerarProposta1Click(Sender: TObject);
    procedure MAlterarEstagioClick(Sender: TObject);
    procedure SeparaoProdutos1Click(Sender: TObject);
    procedure ConsultaSeparaoProdutos1Click(Sender: TObject);
    procedure RetornoProdutos1Click(Sender: TObject);
    procedure ConsultaRetornoProdutos1Click(Sender: TObject);
    procedure GerarPropostaProdutosExtras1Click(Sender: TObject);
    procedure ConsultaPropostas1Click(Sender: TObject);
    procedure ETipoChamadoChange(Sender: TObject);
    procedure BInformacoesClick(Sender: TObject);
    procedure Chamadoc1Click(Sender: TObject);
    procedure GradeDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure GeraSolicitaodeCompras1Click(Sender: TObject);
    procedure ConsultarSolicitao1Click(Sender: TObject);
    procedure ImprimirSolicitacaoProducao1Click(Sender: TObject);
    procedure ImprimeProdutosPendentesaProduzir1Click(Sender: TObject);
    procedure BEnviarEmailClienteClick(Sender: TObject);
    procedure EnviarEmailBoleto1Click(Sender: TObject);
    procedure AlteraCliente1Click(Sender: TObject);
  private
    { Private declarations }
    VprOrdem : String;
    VprCodFilialProposta,
    VprSeqProposta : Integer;
    FunChamado : TRBFuncoesChamado;
    procedure ConfiguraPermissaoUsuario;
    procedure AtualizaConsulta(VpaPosicionar : Boolean);
    procedure AdicionaFiltros(VpaSelect : TSTrings);
    procedure PosicionaProdutos;
    procedure AlteraEstagio;
    procedure GraficoTecnico;
    procedure GraficoTipoChamado;
    procedure GraficoData;
    procedure GraficoPrevisaoAtendimento;
    procedure GraficoDiaSemanaDataChamado;
    procedure GraficoDiaSemanaDataPrevisao;
    procedure GraficoEstagio;
    procedure GraficoCidade;
    procedure GraficoProduto;
    procedure GraficoHora;
    procedure ConsultaSolicitacaoCompras;
    function RRodapeGrafico :string;
  public
    { Public declarations }
    procedure ConsultaChamadosProposta(VpaCodFilial, VpaSeqProposta : Integer);
    procedure ConsultaChamadosCliente(VpaCodCliente : Integer);
  end;

var
  FChamadoTecnico: TFChamadoTecnico;

implementation

uses APrincipal, Constantes, FunData, FunSql, ANovoChamadoTecnico, UnCrystal, ConstMSG,
  AAlteraEstagioChamado, ANovaCotacao, UnCotacao, funObjeto, UnProposta,
  AAgendaChamados, AEfetuarPesquisaSatisfacao, ANovaProposta,
  ABaixaProdutosChamado, AConsultaChamadoParcial, APropostasCliente, dmRave,
  ANovaSolicitacaoCompra, ASolicitacaoCompras, UnClientes, ANovoCliente;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFChamadoTecnico.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  ConfiguraPermissaoUsuario;
  VprCodFilialProposta := 0;
  FunChamado := TRBFuncoesChamado.cria(FPrincipal.BaseDados);
  EDatInicio.DateTime := PrimeiroDiaMes(date);
  EDatFim.DateTime := UltimoDiaMes(date);
  if (varia.CNPJFilial = CNPJ_COPYLINE) or
     (varia.CNPJFilial = CNPJ_IMPOX) or
     (varia.CNPJFilial = CNPJ_INFRASOLUCOES) then
  begin
    ETipoPeriodo.ItemIndex := 0;
    VprOrdem := 'order by CHA.DATCHAMADO';
    Grade.AindiceInicial := 1;
  end
  else
  begin
    Grade.AindiceInicial := 2;
    ETipoPeriodo.ItemIndex := 1;
    VprOrdem := 'order by CHA.DATPREVISAO';
  end;
  Atualizaconsulta(false);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFChamadoTecnico.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  ChamadoTecnico.close;
  ChamadoProduto.close;
  FunChamado.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFChamadoTecnico.ConsultaChamadosCliente(VpaCodCliente : Integer);
begin
  EDatInicio.DateTime := PrimeiroDiaMes(DecMes(date,6));
  ECliente.AInteiro := VpaCodCliente;
  ECliente.Atualiza;
  AtualizaConsulta(false);
  showmodal;
end;

{******************************************************************************}
procedure TFChamadoTecnico.ConsultaChamadosProposta(VpaCodFilial, VpaSeqProposta: Integer);
begin
  VprCodFilialProposta := VpaCodFilial;
  VprSeqProposta := VpaSeqProposta;
  atualizaconsulta(false);
  showmodal;
end;

{******************************************************************************}
procedure TFChamadoTecnico.ConfiguraPermissaoUsuario;
begin
  if not((puAdministrador in varia.PermissoesUsuario) or (puCHCompleto in varia.PermissoesUsuario)) then
  begin
    AlterarVisibleDet([BGerarCotacao],false);
    if (puCHGerarCotacao in Varia.PermissoesUsuario) then
      BGerarCotacao.Visible := true;
  end;
  BExcluir.Visible := puCHExcluirChamado in Varia.PermissoesUsuario;

  if (puCHAlterarEstagioChamadoFinalizadoeCancelado in varia.PermissoesUsuario) then
  begin
    if ((ChamadoTecnicoCODESTAGIO.AsInteger = varia.EstagioChamadoFinalizado) or (ChamadoTecnicoCODESTAGIO.AsInteger = varia.EstagioChamadoCancelado)) then
      MAlterarEstagio.Visible:= False;
  end;


end;


{******************************************************************************}
procedure TFChamadoTecnico.AtualizaConsulta(VpaPosicionar : Boolean);
begin
  ChamadoTecnico.close;
  ChamadoTecnico.Sql.clear;
  ChamadoTecnico.Sql.add('select  CHA.CODFILIAL, CHA.NUMCHAMADO, CHA.DATCHAMADO, CHA.DATPREVISAO, CHA.NOMSOLICITANTE, '+
                         ' CHA.VALCHAMADO, CHA.VALDESLOCAMENTO, CHA.CODESTAGIO, CHA.LANORCAMENTO, CHA.CODTECNICO, '+
                         ' CLI.C_NOM_CLI, CLI.I_COD_CLI, '+
                         ' TEC.NOMTECNICO, '+
                         ' USU.C_NOM_USU, '+
                         ' EST.NOMEST, EST.INDFIN,  '+
                         ' TIC.NOMTIPOCHAMADO '+
                         ' from CHAMADOCORPO CHA, CADCLIENTES CLI, TECNICO TEC, CADUSUARIOS USU, ESTAGIOPRODUCAO EST, '+
                         ' TIPOCHAMADO TIC '+
                         ' Where CHA.CODCLIENTE = CLI.I_COD_CLI '+
                         ' AND CHA.CODTECNICO = TEC.CODTECNICO '+
                         ' AND CHA.CODUSUARIO = USU.I_COD_USU'+
                         ' AND CHA.CODESTAGIO = EST.CODEST '+
                         ' AND TIC.CODTIPOCHAMADO = CHA.CODTIPOCHAMADO '+
                         '  and CHA.CODFILIAL = '+ IntToStr(Varia.CodigoEmpFil));//se for tirar o filtro filial tem que rever a rotina alteraestagio pois lá envia somente o numero do chamado sem o codigo da filial.
  AdicionaFiltros(ChamadoTecnico.sql);
  ChamadoTecnico.sql.add(VprOrdem);
  Grade.ALinhaSQLOrderBy := ChamadoTecnico.SQL.count - 1;
  ChamadoTecnico.open;
end;

{******************************************************************************}
procedure TFChamadoTecnico.AdicionaFiltros(VpaSelect : TSTrings);
begin
  if EChamado.AValor <> 0 then
    VpaSelect.add('and CHA.NUMCHAMADO = '+Echamado.Text)
  else
    if VprCodFilialProposta <> 0 then
    begin
      VpaSelect.Add('and exists (Select 1 from CHAMADOPROPOSTA CHP ' +
                    ' Where CHA.CODFILIAL = CHP.CODFILIAL ' +
                    ' AND CHA.NUMCHAMADO = CHP.NUMCHAMADO ' +
                    ' AND CHP.CODFILIAL = '+IntToStr(VprCodFilialProposta)+
                    ' AND CHP.SEQPROPOSTA = '+IntToStr(VprSeqProposta) +')');
    end
    else
    begin
      case ETipoPeriodo.ItemIndex of
        0 : VpaSelect.add(SQLTextoDataEntreAAAAMMDD('CHA.DATCHAMADO',EDatInicio.Datetime,incdia(EDatFim.Datetime,1),true));
        1 : VpaSelect.add(SQLTextoDataEntreAAAAMMDD('CHA.DATPREVISAO',EDatInicio.Datetime,incdia(EDatFim.Datetime,1),true));
      end;
      case CEstagio.ItemIndex of
        1 : VpaSelect.add(' AND EST.INDFIN <> ''S''');
        2 : VpaSelect.add(' AND EST.INDFIN = ''S''');
      end;

      if ECliente.Ainteiro <> 0 then
        VpaSelect.add('and CHA.CODCLIENTE = '+ECliente.Text);
      if ECodEstagio.AInteiro <> 0 then
        VpaSelect.Add('and CHA.CODESTAGIO = ' + ECodEstagio.text);
      if ETecnico.AInteiro <> 0 then
        VpaSelect.Add('and CHA.CODTECNICO = ' + ETecnico.text);
      if ETipoChamado.AInteiro <> 0 then
        VpaSelect.add('and CHA.CODTIPOCHAMADO = '+ETipoChamado.Text);
      if CPesquisa.Checked then
        VpaSelect.add('and CHA.INDPESQUISASATISFACAO = ''N''');
      if EFilial.AInteiro <> 0 then
        VpaSelect.add('and CHA.CODFILIAL = '+EFilial.Text);
    end;
end;

{******************************************************************************}
procedure TFChamadoTecnico.PosicionaProdutos;
begin
  IF ChamadoTecnicoCODFILIAL.AsInteger <> 0 then
  begin
    AdicionaSQLAbreTabela(ChamadoProduto,'select CHP.SEQITEM, CHP.SEQPRODUTO,  CHP.NUMCONTADOR, CHP.NUMSERIE, CHP.NUMSERIEINTERNO, CHP.DESSETOR, CHP.DATGARANTIA, '+
                                       ' CHP.DESPROBLEMA, CHP.CODFILIALCONTRATO, CHP.DESUM, CHP.QTDPRODUTO, CHP.QTDBAIXADO, '+
                                       ' PRO.C_NOM_PRO, '+
                                       ' COC.SEQCONTRATO, COC.CODTIPOCONTRATO '+
                                       ' from CHAMADOPRODUTO CHP, CADPRODUTOS PRO, CONTRATOCORPO COC '+
                                       ' Where CHP.SEQPRODUTO = PRO.I_SEQ_PRO '+
                                       ' AND '+SQLTextoRightJoin('CHP.SEQCONTRATO','COC.SEQCONTRATO')+
                                       ' AND '+SQLTextoRightJoin('CHP.CODFILIALCONTRATO','COC.CODFILIAL')+
                                       ' AND CHP.CODFILIAL = '+ChamadoTecnicoCODFILIAL.AsString+
                                       ' AND CHP.NUMCHAMADO = '+ChamadoTecnicoNUMCHAMADO.AsString);
  end;
end;

{******************************************************************************}
procedure TFChamadoTecnico.AlteraCliente1Click(Sender: TObject);
begin
  if ChamadotecnicoI_COD_CLI.AsInteger <> 0 then
  begin
    FNovoCliente := TFNovoCliente.CriarSDI(application,'', FPrincipal.VerificaPermisao('FNovoCliente'));
    AdicionaSqlAbreTabela(FNovoCliente.CadClientes,'Select * from CadClientes '+
                                                   ' Where I_COD_CLI = '+ChamadotecnicoI_COD_CLI.AsString);
    FNovoCliente.CadClientes.Edit;
    FNovoCliente.ShowModal;
    FNovoCliente.Free;
  end;
end;

{******************************************************************************}
procedure TFChamadoTecnico.AlteraEstagio;
var
  VpfPosicao : TBookmark;
  VpfChamados : String;
begin
  VpfChamados := '';
  VpfPosicao := ChamadoTecnico.GetBookmark;
  ChamadoTecnico.First;
  While not ChamadoTecnico.Eof do
  begin
    if Grade.SelectedRows.CurrentRowSelected then
    begin
      VpfChamados := VpfChamados +ChamadoTecnicoNUMCHAMADO.AsString + ',';
    end;
    ChamadoTecnico.next;
  end;
  if VpfChamados <> '' then
  begin
    VpfChamados := copy(VpfChamados,1,Length(VpfChamados)-1);
    FAlteraEstagioChamado := TFAlteraEstagioChamado.CriarSDI(self,'',FPrincipal.VerificaPermisao(''));
    if FAlteraEstagioChamado.AlteraEstagioChamados(VpfChamados) then
      AtualizaConsulta(false);
    FAlteraEstagioChamado.free;
  end
  else
    Aviso('FALTA SELECIONAR CHAMADO!!!'#13'É necessário selecionar os chamados que se deseja alterar');

  try
    ChamadoTecnico.GotoBookmark(vpfPosicao);
  except
  end;
  ChamadoTEcnico.FreeBookmark(VpfPosicao);
end;

{******************************************************************************}
procedure TFChamadoTecnico.GraficoTecnico;
var
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfComandoSql.add('Select count(*) Qtd, TEC.NOMTECNICO CAMPO '+
                    ' from CHAMADOCORPO CHA, TECNICO TEC '+
                    ' Where CHA.CODTECNICO = TEC.CODTECNICO');
  graficostrio.info.CampoValor := 'Qtd';
  graficostrio.info.TituloY := 'Quantidade';

  AdicionaFiltros(VpfComandosql);
  VpfComandosql.add(' GROUP BY TEC.NOMTECNICO');

  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'CAMPO';
  graficostrio.info.TituloGrafico := 'Gráfico Chamado Técnico - Técnicos';
  graficostrio.info.RodapeGrafico := RRodapeGrafico;
  graficostrio.info.TituloFormulario := 'Gráfico dos Chamados Técnicos';
  graficostrio.info.TituloX := 'Técnico';
  graficostrio.execute;
end;

{******************************************************************************}
procedure TFChamadoTecnico.GraficoTipoChamado;
var
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfComandoSql.add('Select count(*) Qtd, TIP.NOMTIPOCHAMADO CAMPO '+
                    ' from CHAMADOCORPO CHA, TIPOCHAMADO TIP '+
                    ' Where CHA.CODTIPOCHAMADO = TIP.CODTIPOCHAMADO');
  graficostrio.info.CampoValor := 'Qtd';
  graficostrio.info.TituloY := 'Quantidade';

  AdicionaFiltros(VpfComandosql);
  VpfComandosql.add(' GROUP BY TIP.NOMTIPOCHAMADO');

  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'CAMPO';
  graficostrio.info.TituloGrafico := 'Gráfico Chamado Técnico - Tipo Chamado';
  graficostrio.info.RodapeGrafico := RRodapeGrafico;
  graficostrio.info.TituloFormulario := 'Gráfico dos Chamados Técnicos';
  graficostrio.info.TituloX := 'Tipo Chamado';
  graficostrio.execute;
end;

{******************************************************************************}
procedure TFChamadoTecnico.ImprimeProdutosPendentesaProduzir1Click(
  Sender: TObject);
begin
  dtRave := TdtRave.create(self);
  dtRave.ImprimeProdutosPendenteaProduzir(varia.CodigoEmpFil,EDatInicio.DateTime,EDatFim.DateTime);
  dtRave.free;

end;

{******************************************************************************}
procedure TFChamadoTecnico.ImprimirSolicitacaoProducao1Click(Sender: TObject);
begin
  if ChamadoTecnicoCODFILIAL.AsInteger <> 0 then
  begin
    dtRave := TdtRave.create(self);
    dtRave.ImprimeChamadoProducao(ChamadoTecnicoCODFILIAL.AsInteger,ChamadoTecnicoNUMCHAMADO.AsInteger,true);
    dtRave.free;
  end;
end;

{******************************************************************************}
procedure TFChamadoTecnico.GraficoData;
var
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfComandoSql.add('Select count(*) Qtd, CHA.DATCHAMADO CAMPO '+
                    ' from CHAMADOCORPO CHA '+
                    ' Where CHA.CODFILIAL = CHA.CODFILIAL');
  graficostrio.info.CampoValor := 'Qtd';
  graficostrio.info.TituloY := 'Quantidade';

  AdicionaFiltros(VpfComandosql);
  VpfComandosql.add(' GROUP BY CHA.DATCHAMADO ORDER BY CHA.DATCHAMADO ');

  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'CAMPO';
  graficostrio.info.TituloGrafico := 'Gráfico Chamado Técnico - Data';
  graficostrio.info.RodapeGrafico := RRodapeGrafico;
  graficostrio.info.TituloFormulario := 'Gráfico dos Chamados Técnicos';
  graficostrio.info.TituloX := 'Data';
  graficostrio.execute;
end;

{******************************************************************************}
procedure TFChamadoTecnico.GraficoPrevisaoAtendimento;
var
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfComandoSql.add('Select count(*) Qtd, dateformat(CHA.DATPREVISAO,''DD/MM/YYYY'') CAMPO '+
                    ' from CHAMADOCORPO CHA '+
                    ' Where CHA.CODFILIAL = CHA.CODFILIAL');
  graficostrio.info.CampoValor := 'Qtd';
  graficostrio.info.TituloY := 'Quantidade';

  AdicionaFiltros(VpfComandosql);
  VpfComandosql.add(' GROUP BY CAMPO ORDER BY 2');

  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'CAMPO';
  graficostrio.info.TituloGrafico := 'Gráfico Chamado Técnico - Previsão Atendimento';
  graficostrio.info.RodapeGrafico := RRodapeGrafico;
  graficostrio.info.TituloFormulario := 'Gráfico dos Chamados Técnicos';
  graficostrio.info.TituloX := 'Previsão Atendimento';
  graficostrio.execute;
end;

{******************************************************************************}
procedure TFChamadoTecnico.GraficoDiaSemanaDataChamado;
var
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfComandoSql.add('Select count(*) Qtd, DAYNAME(CHA.DATCHAMADO) CAMPO, DOW(CHA.DATCHAMADO) CAMPO2 '+
                    ' from CHAMADOCORPO CHA '+
                    ' Where CHA.CODFILIAL = CHA.CODFILIAL');
  graficostrio.info.CampoValor := 'Qtd';
  graficostrio.info.TituloY := 'Quantidade';

  AdicionaFiltros(VpfComandosql);
  VpfComandosql.add(' GROUP BY CAMPO, CAMPO2 ORDER BY 3');

  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'CAMPO';
  graficostrio.info.TituloGrafico := 'Gráfico Chamado Técnico - Dia Semana Abertura Chamado';
  graficostrio.info.RodapeGrafico := RRodapeGrafico;
  graficostrio.info.TituloFormulario := 'Gráfico dos Chamados Técnicos';
  graficostrio.info.TituloX := 'Dia Semana';
  graficostrio.execute;
end;

{******************************************************************************}
procedure TFChamadoTecnico.GraficoDiaSemanaDataPrevisao;
var
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfComandoSql.add('Select count(*) Qtd, DAYNAME(CHA.DATPREVISAO) CAMPO, DOW(CHA.DATPREVISAO) CAMPO2 '+
                    ' from CHAMADOCORPO CHA '+
                    ' Where CHA.CODFILIAL = CHA.CODFILIAL');
  graficostrio.info.CampoValor := 'Qtd';
  graficostrio.info.TituloY := 'Quantidade';

  AdicionaFiltros(VpfComandosql);
  VpfComandosql.add(' GROUP BY CAMPO, CAMPO2 ORDER BY 3');

  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'CAMPO';
  graficostrio.info.TituloGrafico := 'Gráfico Chamado Técnico - Dia Semana Previsão Atendimento';
  graficostrio.info.RodapeGrafico := RRodapeGrafico;
  graficostrio.info.TituloFormulario := 'Gráfico dos Chamados Técnicos';
  graficostrio.info.TituloX := 'Dia Semana';
  graficostrio.execute;
end;

{******************************************************************************}
procedure TFChamadoTecnico.GraficoEstagio;
var
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfComandoSql.add('Select count(*) Qtd, EST.NOMEST CAMPO '+
                    ' from CHAMADOCORPO CHA, ESTAGIOPRODUCAO EST '+
                    ' Where CHA.CODESTAGIO = EST.CODEST');
  graficostrio.info.CampoValor := 'Qtd';
  graficostrio.info.TituloY := 'Quantidade';

  AdicionaFiltros(VpfComandosql);
  VpfComandosql.add(' GROUP BY EST.NOMEST');

  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'CAMPO';
  graficostrio.info.TituloGrafico := 'Gráfico Chamado Técnico - Estágio';
  graficostrio.info.RodapeGrafico := RRodapeGrafico;
  graficostrio.info.TituloFormulario := 'Gráfico dos Chamados Técnicos';
  graficostrio.info.TituloX := 'Estágio';
  graficostrio.execute;
end;

{******************************************************************************}
procedure TFChamadoTecnico.GraficoCidade;
var
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfComandoSql.add('Select count(*) Qtd, CLI.C_CID_CLI CAMPO '+
                    ' from CHAMADOCORPO CHA, CADCLIENTES CLI '+
                    ' Where CHA.CODCLIENTE = CLI.I_COD_CLI');
  graficostrio.info.CampoValor := 'Qtd';
  graficostrio.info.TituloY := 'Quantidade';

  AdicionaFiltros(VpfComandosql);
  VpfComandosql.add(' GROUP BY CLI.C_CID_CLI ');

  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'CAMPO';
  graficostrio.info.TituloGrafico := 'Gráfico Chamado Técnico - Cidade';
  graficostrio.info.RodapeGrafico := RRodapeGrafico;
  graficostrio.info.TituloFormulario := 'Gráfico dos Chamados Técnicos';
  graficostrio.info.TituloX := 'Cidade';
  graficostrio.execute;
end;

{******************************************************************************}
procedure TFChamadoTecnico.GraficoProduto;
var
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfComandoSql.add('Select count(*) Qtd, PRO.C_NOM_PRO CAMPO '+
                    ' from CHAMADOCORPO CHA, CHAMADOPRODUTO CHP, CADPRODUTOS PRO '+
                    ' Where CHA.CODFILIAL = CHP.CODFILIAL '+
                    ' AND CHA.NUMCHAMADO = CHP.NUMCHAMADO '+
                    ' AND CHP.SEQPRODUTO = PRO.I_SEQ_PRO');
  graficostrio.info.CampoValor := 'Qtd';
  graficostrio.info.TituloY := 'Quantidade';

  AdicionaFiltros(VpfComandosql);
  VpfComandosql.add(' GROUP BY PRO.C_NOM_PRO ');

  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'CAMPO';
  graficostrio.info.TituloGrafico := 'Gráfico Chamado Técnico - Produto';
  graficostrio.info.RodapeGrafico := RRodapeGrafico;
  graficostrio.info.TituloFormulario := 'Gráfico dos Chamados Técnicos';
  graficostrio.info.TituloX := 'Cidade';
  graficostrio.execute;
end;

{******************************************************************************}
procedure TFChamadoTecnico.GraficoHora;
var
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfComandoSql.add('Select count(*) Qtd, hour(CHA.DATCHAMADO) CAMPO '+
                    ' from CHAMADOCORPO CHA '+
                    ' Where CHA.CODFILIAL = CHA.CODFILIAL');
  graficostrio.info.CampoValor := 'Qtd';
  graficostrio.info.TituloY := 'Quantidade';

  AdicionaFiltros(VpfComandosql);
  VpfComandosql.add(' GROUP BY CAMPO ORDER BY 2');

  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'CAMPO';
  graficostrio.info.TituloGrafico := 'Gráfico Chamado Técnico - Horário';
  graficostrio.info.RodapeGrafico := RRodapeGrafico;
  graficostrio.info.TituloFormulario := 'Gráfico dos Chamados Técnicos';
  graficostrio.info.TituloX := 'Horário';
  graficostrio.execute;
end;

{******************************************************************************}
function TFChamadoTecnico.RRodapeGrafico :string;
begin
  result := '';
  case ETipoPeriodo.ItemIndex of
    0 : result := 'Por Data do Chamado de '+FormatDateTime('DD/MM/YYYY',EDatInicio.DateTime)+ ' até '+FormatDateTime('DD/MM/YYYY',EDatFim.DateTime);
    1 : result := 'Por Previsão Atend.'+FormatDateTime('DD/MM/YYYY',EDatInicio.DateTime)+ ' até '+FormatDateTime('DD/MM/YYYY',EDatFim.DateTime);
  end;
  if ECliente.AInteiro <> 0 then
    Result := result + ' - Cliente : '+ LNomCliente.Caption;
  if ETecnico.AInteiro <> 0 then
    result := result + ' - Técnico : '+LNomTecnico.Caption;
  if ECodEstagio.AInteiro <> 0 then
    result := result + ' - Estágio : '+LNomEstagio.Caption;
  if ETipoChamado.AInteiro <> 0 then
    result := result + ' - Tipo Chamado : '+LTipoChamado.Caption;
end;

{******************************************************************************}
procedure TFChamadoTecnico.BCadastrarClick(Sender: TObject);
begin
  FNovoChamado := TFNovoChamado.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoChamado'));
  if FNovoChamado.NovoChamado then
    AtualizaConsulta(false);
  FNovoChamado.free;
end;

{******************************************************************************}
procedure TFChamadoTecnico.BAlterarClick(Sender: TObject);
begin
  if ChamadoTecnicoCODFILIAL.AsInteger <> 0 then
  begin
    FNovoChamado := TFNovoChamado.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoChamado'));
    if FNovoChamado.AlteraChamado(ChamadoTecnicoCODFILIAL.AsInteger,ChamadoTecnicoNUMCHAMADO.AsInteger) then
      AtualizaConsulta(true);
    FNovoChamado.free;
  end;
end;

{******************************************************************************}
procedure TFChamadoTecnico.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFChamadoTecnico.BConsultarClick(Sender: TObject);
begin
  if ChamadoTecnicoCODFILIAL.AsInteger <> 0 then
  begin
    FNovoChamado := TFNovoChamado.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoChamado'));
    FNovoChamado.ConsultaChamado(ChamadoTecnicoCODFILIAL.AsInteger,ChamadoTecnicoNUMCHAMADO.AsInteger);
    FNovoChamado.free;
  end;
end;

{******************************************************************************}
procedure TFChamadoTecnico.BImprimirClick(Sender: TObject);
begin
  if ChamadoTecnicoCODFILIAL.AsInteger <> 0 then
  begin
    dtRave := TdtRave.create(self);
    dtRave.ImprimeChamado(ChamadoTecnicoCODFILIAL.AsInteger,ChamadoTecnicoNUMCHAMADO.AsInteger,true);
    dtRave.free;
  end;
end;

{******************************************************************************}
procedure TFChamadoTecnico.BInformacoesClick(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFChamadoTecnico.EChamadoExit(Sender: TObject);
begin
  AtualizaConsulta(false);
end;

procedure TFChamadoTecnico.ECodEstagioKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 13 then
    AtualizaConsulta(false);
end;

{******************************************************************************}
procedure TFChamadoTecnico.BExcluirClick(Sender: TObject);
var
  VpfResultado : String;
begin
  if ChamadoTecnicoCODFILIAL.AsInteger <> 0 then
    if confirmacao('EXCLUIR REGISTRO!!!'#13'Tem certeza que deseja excluir o registro?') then
    begin
      VpfResultado := FunChamado.ExcluiChamado(ChamadoTecnicoCODFILIAL.AsInteger,ChamadoTecnicoNUMCHAMADO.AsInteger);
      if VpfResultado = '' then
        AtualizaConsulta(false)
      else
        aviso(VpfREsultado);
    end;
end;

{******************************************************************************}
procedure TFChamadoTecnico.GradeDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if (ChamadoTecnicoCODESTAGIO.AsInteger = varia.EstagioChamadoCancelado)then
  begin
    Grade.Canvas.Font.Color:= clRed;
    Grade.DefaultDrawDataCell(Rect, Grade.columns[datacol].field, State);
  end;
end;

{******************************************************************************}
procedure TFChamadoTecnico.GradeOrdem(Ordem: String);
begin
  VprOrdem := Ordem;
end;

{******************************************************************************}
procedure TFChamadoTecnico.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 119 then
  begin
    AlteraEstagio;
  end;
end;

{******************************************************************************}
procedure TFChamadoTecnico.BGerarCotacaoClick(Sender: TObject);
var
  VpfDChamado : TRBDChamado;
  VpfLanOrcamento : Integer;
begin
  if ChamadoTecnicoCODFILIAL.AsInteger <> 0 then
  begin
    VpfDChamado := TRBDChamado.cria;
    FunChamado.CarDChamado(ChamadoTecnicoCODFILIAL.AsInteger,ChamadoTecnicoNUMCHAMADO.AsInteger,VpfDChamado);
    FNovaCotacao := TFNovaCotacao.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaCotacao'));
    VpfLanOrcamento := FNovaCotacao.NovaCotacaoChamado(VpfDChamado);
    if VpfLanOrcamento <> 0 then
    begin
      if FunCotacao.RTipoOrcamento(varia.CodigoEmpFil,VpfLanOrcamento) = varia.TipoCotacao then
      begin
        FunChamado.AlteraEstagioChamado(VpfDChamado.CodFilial,VpfDChamado.NumChamado,varia.codigoUsuario,varia.EstagioChamadoFaturado,'');
        AtualizaConsulta(false);
      end;
    end;
    FNovaCotacao.free;
    VpfDChamado.free;
  end;
end;

{******************************************************************************}
procedure TFChamadoTecnico.ChamadoTecnicoAfterScroll(DataSet: TDataSet);
begin
  AlterarEnabledDet([BGerarCotacao,BAlterar,MAlterarEstagio],true);
  BGerarCotacao.Enabled := (ChamadoTecnicoCODESTAGIO.AsInteger >= Varia.EstagioChamadoFinalizado);
  if not((puAdministrador in varia.PermissoesUsuario) or (puCHCompleto in varia.PermissoesUsuario)) then
  begin
    if not(puCHAlterarChamadosFinalizados in varia.PermissoesUsuario) and (ChamadoTecnicoINDFIN.AsString = 'S') then
    begin
      BAlterar.Enabled := false;
      MAlterarEstagio.Enabled := false;
    end;
    if not(puCHAlterarChamadoTodosTecnicos in varia.PermissoesUsuario) and (ChamadoTecnicoCODTECNICO.AsinTeger <> varia.codtecnico) then
      BAlterar.Enabled := false;
  end;
  BExcluir.Enabled := BAlterar.Enabled;
  PosicionaProdutos;
end;

{******************************************************************************}
procedure TFChamadoTecnico.BAgendaClick(Sender: TObject);
begin
  FAgendaChamados := TFAgendaChamados.CriarSDI(self,'',FPrincipal.VerificaPermisao('FAgendaChamados'));
  FAgendaChamados.AgendaChamados;
  FAgendaChamados.free;
end;

{******************************************************************************}
procedure TFChamadoTecnico.Chamadoc1Click(Sender: TObject);
begin
  if ChamadoTecnicoCODFILIAL.AsInteger <> 0then
  begin
    dtRave := TdtRave.Create(self);
    dtRave.ImprimeObservacoesChamado(ChamadoTecnicoCODFILIAL.AsInteger,ChamadoTecnicoNUMCHAMADO.AsInteger,true);
    dtRave.Free;
  end;
end;

procedure TFChamadoTecnico.ChamadoProdutoCalcFields(DataSet: TDataSet);
begin
  if ChamadoProdutoSEQCONTRATO.AsInteger <> 0 Then
    ChamadoProdutoTIPOCONTRATO.AsString := FunChamado.RNomeTipoContrato(ChamadoProdutoCODTIPOCONTRATO.AsInteger);
end;

procedure TFChamadoTecnico.EfetuarPesquisaSatisfao1Click(Sender: TObject);
var
  VpfDChamado : TRBDChamado;
begin
  if ChamadoTecnicoNUMCHAMADO.AsInteger <> 0 then
  begin
    VpfDChamado := TRBDChamado.cria;
    FunChamado.CarDChamado(ChamadoTecnicoCODFILIAL.AsInteger,ChamadoTecnicoNUMCHAMADO.AsInteger,VpfDChamado);
    FEfetuarPesquisaSatisfacao := TFEfetuarPesquisaSatisfacao.CriarSDI(self,'',FPrincipal.VerificaPermisao('FEfetuarPesquisaSatisfacao'));
    if FEfetuarPesquisaSatisfacao.EfetuarPesquisaChamado(VpfDChamado) then
    begin
      AtualizaConsulta(false);
    end;
    FEfetuarPesquisaSatisfacao.free;
    VpfDChamado.free;
  end;
end;

{******************************************************************************}
procedure TFChamadoTecnico.EnviarEmailBoleto1Click(Sender: TObject);
var
  VpfResultado : String;
  VpfDChamado: TRBDChamado;
begin
  VpfDChamado:= TRBDChamado.cria;
  FunChamado.CarDChamado(ChamadoTecnicoCODFILIAL.AsInteger, ChamadoTecnicoNUMCHAMADO.AsInteger, VpfDChamado);
  VpfResultado := FunChamado.EnviaEmailChamadoCliente(VpfDChamado, nil);
  if VpfREsultado <> '' then
    aviso(VpfREsultado);
end;

{******************************************************************************}
procedure TFChamadoTecnico.ETipoChamadoChange(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFChamadoTecnico.BImplantacaoClick(Sender: TObject);
begin
  if ChamadoTecnicoCODFILIAL.AsInteger <> 0 then
  begin
    dtRave := TdtRave.create(self);
    dtRave.ImprimeTermoImplantacao(ChamadoTecnicoCODFILIAL.AsInteger,ChamadoTecnicoNUMCHAMADO.AsInteger,true);
    dtRave.free;
  end;
end;

{******************************************************************************}
procedure TFChamadoTecnico.BMeioDivulgacaoClick(Sender: TObject);
begin
  GraficoTecnico;
end;

{******************************************************************************}
procedure TFChamadoTecnico.BGraficosClick(Sender: TObject);
begin
  PanelColor1.Enabled := false;
  PanelColor2.Enabled := false;
  Grade.Enabled := false;
  GridIndice1 .Enabled := false;
  PGraficos.Top := 50;
  PGraficos.Visible := true;
end;

{******************************************************************************}
procedure TFChamadoTecnico.BFechaGraficoClick(Sender: TObject);
begin
  PanelColor1.Enabled := true;
  PanelColor2.Enabled := true;
  Grade.Enabled := true;
  GridIndice1 .Enabled := true;
  PGraficos.Visible := false;
end;

{******************************************************************************}
procedure TFChamadoTecnico.BVendedorClick(Sender: TObject);
begin
  GraficoTipoChamado;
end;

{******************************************************************************}
procedure TFChamadoTecnico.BProdutoClick(Sender: TObject);
begin
  GraficoData;
end;

{******************************************************************************}
procedure TFChamadoTecnico.BitBtn1Click(Sender: TObject);
begin
  GraficoPrevisaoAtendimento;
end;

{******************************************************************************}
procedure TFChamadoTecnico.BitBtn2Click(Sender: TObject);
begin
  GraficoDiaSemanaDataChamado;
end;

{******************************************************************************}
procedure TFChamadoTecnico.BitBtn3Click(Sender: TObject);
begin
  GraficoDiaSemanaDataPrevisao;
end;

{******************************************************************************}
procedure TFChamadoTecnico.BDataClick(Sender: TObject);
begin
  GraficoEstagio;
end;

{******************************************************************************}
procedure TFChamadoTecnico.BEnviarEmailClienteClick(Sender: TObject);
begin
end;

{******************************************************************************}
procedure TFChamadoTecnico.BEstadoClick(Sender: TObject);
begin
  GraficoCidade;
end;

{******************************************************************************}
procedure TFChamadoTecnico.BitBtn5Click(Sender: TObject);
begin
  GraficoProduto
end;

{******************************************************************************}
procedure TFChamadoTecnico.BitBtn6Click(Sender: TObject);
begin
  GraficoHora;
end;

{******************************************************************************}
procedure TFChamadoTecnico.GerarProposta1Click(Sender: TObject);
var
  VpfDChamado : TRBDChamado;
begin
  if ChamadoTecnicoNUMCHAMADO.AsInteger <> 0 then
  begin
    VpfDChamado := TRBDChamado.cria;
    FunChamado.CarDChamado(ChamadoTecnicoCODFILIAL.AsInteger,ChamadoTecnicoNUMCHAMADO.AsInteger,VpfDChamado);
    FNovaProposta := TFNovaProposta.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaProposta'));
    if FNovaProposta.NovaPropostaChamado(VpfDChamado) then
    begin
      if Varia.EstagioAguardandoAprovacaoChamado <> 0 then
      begin
        FunChamado.AlteraEstagioChamado(ChamadoTecnicoCODFILIAL.AsInteger,ChamadoTecnicoNUMCHAMADO.AsInteger,
                                      varia.CodigoUsuario,varia.EstagioAguardandoAprovacaoChamado,'');
        AtualizaConsulta(false);
      end;
    end;
    VpfDChamado.free;
  end;
end;

{******************************************************************************}
procedure TFChamadoTecnico.MAlterarEstagioClick(Sender: TObject);
begin
  if ChamadoTecnicoNUMCHAMADO.AsInteger <> 0 then
  begin
    FAlteraEstagioChamado := TFAlteraEstagioChamado.CriarSDI(self,'',FPrincipal.VerificaPermisao('FAlteraEstagioChamado'));
    if FAlteraEstagioChamado.AlteraEstagio(ChamadoTecnicoNUMCHAMADO.AsInteger) then
      AtualizaConsulta(false);
    FAlteraEstagioChamado.free;
  end;
end;

{******************************************************************************}
procedure TFChamadoTecnico.SeparaoProdutos1Click(Sender: TObject);
var
  VpfDChamado : TRBDChamado;
begin
  if ChamadoTecnicoNUMCHAMADO.AsInteger <> 0 then
  begin
    VpfDChamado := TRBDChamado.cria;
    FunChamado.CarDChamado(ChamadoTecnicoCODFILIAL.AsInteger,ChamadoTecnicoNUMCHAMADO.AsInteger,VpfDChamado);
    FBaixaProdutosChamado := TFBaixaProdutosChamado.CriarSDI(self,'',FPrincipal.VerificaPermisao('FBaixaProdutosChamado'));
    FBaixaProdutosChamado.BaixaProdutoChamado(VpfDChamado);
    FBaixaProdutosChamado.free;
    VpfDChamado.free;
  end;
end;

{******************************************************************************}
procedure TFChamadoTecnico.ConsultaSeparaoProdutos1Click(Sender: TObject);
begin
  if ChamadoTecnicoNUMCHAMADO.AsInteger <> 0 then
  begin
    FConsultaChamadoParcial := TFConsultaChamadoParcial.CriarSDI(self,'',FPrincipal.VerificaPermisao('FConsultaChamadoParcial'));
    FConsultaChamadoParcial.ConsultaParciais(ChamadoTecnicoCODFILIAL.AsInteger,ChamadoTecnicoNUMCHAMADO.AsInteger);
    FConsultaChamadoParcial.free;
  end;
end;

{******************************************************************************}
procedure TFChamadoTecnico.ConsultaSolicitacaoCompras;
begin
  FSolicitacaoCompra := TFSolicitacaoCompra.CriarSDI(self,'',FPrincipal.VerificaPermisao('FOrcamentoCompra'));
  FSolicitacaoCompra.ConsultaProposta(ChamadoTecnicoCODFILIAL.AsInteger,ChamadoTecnicoNUMCHAMADO.AsInteger);
  FSolicitacaoCompra.free;
end;

{******************************************************************************}
procedure TFChamadoTecnico.RetornoProdutos1Click(Sender: TObject);
var
  VpfDChamado : TRBDChamado;
begin
  if ChamadoTecnicoNUMCHAMADO.AsInteger <> 0 then
  begin
    VpfDChamado := TRBDChamado.cria;
    FunChamado.CarDChamado(ChamadoTecnicoCODFILIAL.AsInteger,ChamadoTecnicoNUMCHAMADO.AsInteger,VpfDChamado);
    FBaixaProdutosChamado := TFBaixaProdutosChamado.CriarSDI(self,'',FPrincipal.VerificaPermisao('FBaixaProdutosChamado'));
    FBaixaProdutosChamado.RetornoProdutos(VpfDChamado);
    FBaixaProdutosChamado.free;
    VpfDChamado.free;
  end;
end;

{******************************************************************************}
procedure TFChamadoTecnico.ConsultaRetornoProdutos1Click(Sender: TObject);
begin
  if ChamadoTecnicoNUMCHAMADO.AsInteger <> 0 then
  begin
    FConsultaChamadoParcial := TFConsultaChamadoParcial.CriarSDI(self,'',FPrincipal.VerificaPermisao('FConsultaChamadoParcial'));
    FConsultaChamadoParcial.ConsultaRetornos(ChamadoTecnicoCODFILIAL.AsInteger,ChamadoTecnicoNUMCHAMADO.AsInteger);
    FConsultaChamadoParcial.free;
  end;
end;

{******************************************************************************}
procedure TFChamadoTecnico.ConsultarSolicitao1Click(Sender: TObject);
begin
  if ChamadoTecnicoNUMCHAMADO.AsInteger <> 0 then
    ConsultaSolicitacaoCompras;
end;

{******************************************************************************}
procedure TFChamadoTecnico.GerarPropostaProdutosExtras1Click(
  Sender: TObject);
var
  VpfDChamado : TRBDChamado;
begin
  if ChamadoTecnicoNUMCHAMADO.AsInteger <> 0 then
  begin
    VpfDChamado := TRBDChamado.cria;
    FunChamado.CarDChamado(ChamadoTecnicoCODFILIAL.AsInteger,ChamadoTecnicoNUMCHAMADO.AsInteger,VpfDChamado);
    FNovaProposta := TFNovaProposta.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaProposta'));
    if FNovaProposta.NovaPropostaChamadoProdutoExtra(VpfDChamado) then
      FunChamado.MarcaProdutosExtraFaturado(ChamadoTecnicoCODFILIAL.AsInteger,ChamadoTecnicoNUMCHAMADO.AsInteger);
    VpfDChamado.free;
  end;
end;

procedure TFChamadoTecnico.GeraSolicitaodeCompras1Click(Sender: TObject);
var
  VpfDChamado : TRBDChamado;
begin
  if ChamadoTecnicoNUMCHAMADO.AsInteger <> 0 then
  begin
    VpfDChamado.free;
    VpfDChamado := TRBDChamado.cria;
    FunChamado.CarDChamado(ChamadoTecnicoCODFILIAL.AsInteger,ChamadoTecnicoNUMCHAMADO.AsInteger,VpfDChamado);
    FNovaSolicitacaoCompras := TFNovaSolicitacaoCompras.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoOrcamentoCompras'));
    FNovaSolicitacaoCompras.NovoOrcamentoChamado(VpfDChamado);
    FNovaSolicitacaoCompras.free;
  end;
end;

{******************************************************************************}
procedure TFChamadoTecnico.ConsultaPropostas1Click(Sender: TObject);
begin
  if ChamadoTecnicoNUMCHAMADO.AsInteger <> 0 then
  begin
    FPropostasCliente := TFPropostasCliente.CriarSDI(self,'',FPrincipal.VerificaPermisao('FPropostasCliente'));
    FPropostasCliente.ConsultaPropostasChamado(ChamadoTecnicoCODFILIAL.AsInteger,ChamadoTecnicoNUMCHAMADO.AsInteger);
    FPropostasCliente.free;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFChamadoTecnico]);
end.
