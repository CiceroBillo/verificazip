unit AClientes;
{          Autor: Rafael Budag
    Data Criação: 25/03/1999;
          Função: Cadastrar uma nova transportadora
  Data Alteração: 25/03/1999;
    Alterado por:
Motivo alteração:
}


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Db, DBTables, Componentes1, ExtCtrls, PainelGradiente, Localizacao,
  BotaoCadastro, StdCtrls, Buttons, DBKeyViolation, Grids, DBGrids, Tabela,
  Mask, Menus, UnSistema, UnContrato, DBCtrls, UnDadosLocaliza, DBClient, UnDados, UnClientes;

type
  TFClientes = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    DataCadCliente: TDataSource;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoConsultar1: TBotaoConsultar;
    BFechar: TBitBtn;
    GClientes: TGridIndice;
    PanelColor3: TPanelColor;
    Label1: TLabel;
    BContratos: TBitBtn;
    ENomCliente: TEditColor;
    ECodCliente: TEditColor;
    Label2: TLabel;
    ENomFantasia: TEditColor;
    Label3: TLabel;
    BitBtn2: TBitBtn;
    ETelefone: TMaskEditColor;
    Label13: TLabel;
    BCotacoes: TBitBtn;
    BCobrancas: TBitBtn;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    NovaCotao1: TMenuItem;
    MTeleMarketing: TMenuItem;
    BBrindes: TBitBtn;
    BProdutos: TBitBtn;
    ECNPJ: TMaskEditColor;
    N2: TMenuItem;
    MChamado: TMenuItem;
    Label5: TLabel;
    ECidade: TEditColor;
    Label6: TLabel;
    EBairro: TEditColor;
    BChamados: TBitBtn;
    N3: TMenuItem;
    MProcessarFaturamentoPosterior: TMenuItem;
    BContatos: TBitBtn;
    BMenuFiscal: TBitBtn;
    CCliente: TCheckBox;
    CFornecedor: TCheckBox;
    CProspect: TCheckBox;
    N4: TMenuItem;
    MNovaProposta: TMenuItem;
    N5: TMenuItem;
    MVisitas: TMenuItem;
    LVendedor: TLabel;
    EVendedor: TEditLocaliza;
    BVendedor: TSpeedButton;
    LNomVendedor: TLabel;
    Localiza: TConsultaPadrao;
    N6: TMenuItem;
    MCreditoCliente: TMenuItem;
    MFilhos: TMenuItem;
    N7: TMenuItem;
    BPropostas: TBitBtn;
    EUF: TRBEditLocaliza;
    SpeedButton1: TSpeedButton;
    Label7: TLabel;
    N8: TMenuItem;
    ImprimirEnvelope1: TMenuItem;
    ImprimirEnvelopeCobrana1: TMenuItem;
    ImprimirEnvelopeEntrega1: TMenuItem;
    N9: TMenuItem;
    MExcluirRamoAtividade: TMenuItem;
    SpeedButton2: TSpeedButton;
    Label8: TLabel;
    ERamoAtividade: TRBEditLocaliza;
    Label9: TLabel;
    CSomenteNaoExportados: TCheckBox;
    ImprimeEnvelope1: TMenuItem;
    CHotel: TCheckBox;
    CAtivo: TCheckBox;
    N10: TMenuItem;
    MProdutoReserva: TMenuItem;
    CTransportadora: TCheckBox;
    ESiglaUF: TComboBoxColor;
    CadClientes: TSQL;
    CadClientesI_COD_CLI: TFMTBCDField;
    CadClientesC_NOM_CLI: TWideStringField;
    CadClientesC_CID_CLI: TWideStringField;
    CadClientesC_TIP_CAD: TWideStringField;
    CadClientesC_FO1_CLI: TWideStringField;
    CadClientesC_FON_FAX: TWideStringField;
    CadClientesC_NOM_FAN: TWideStringField;
    CadClientesI_COD_RAM: TFMTBCDField;
    CadClientesC_FLA_EXP: TWideStringField;
    CadClientesC_IND_BLO: TWideStringField;
    CadClientesC_IND_ATI: TWideStringField;
    CadClientesC_END_ELE: TWideStringField;
    CCNPJ: TRadioButton;
    CCPF: TRadioButton;
    ECPF: TMaskEditColor;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BotaoAlterar1Atividade(Sender: TObject);
    procedure BotaoCadastrar1AntesAtividade(Sender: TObject);
    procedure BotaoCadastrar1DepoisAtividade(Sender: TObject);
    procedure BotaoExcluir1DepoisAtividade(Sender: TObject);
    procedure BotaoExcluir1DestroiFormulario(Sender: TObject);
    procedure cliClick(Sender: TObject);
    procedure GClientesOrdem(Ordem: String);
    procedure BBAjudaClick(Sender: TObject);
    procedure BotaoConsultar1AntesAtividade(Sender: TObject);
    procedure ENomClienteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn2Click(Sender: TObject);
    procedure GClientesDblClick(Sender: TObject);
    procedure BCotacoesClick(Sender: TObject);
    procedure BCobrancasClick(Sender: TObject);
    procedure BContratosClick(Sender: TObject);
    procedure NovaCotao1Click(Sender: TObject);
    procedure MTeleMarketingClick(Sender: TObject);
    procedure BBrindesClick(Sender: TObject);
    procedure BProdutosClick(Sender: TObject);
    procedure ENomClienteExit(Sender: TObject);
    procedure ENomFantasiaExit(Sender: TObject);
    procedure ECNPJExit(Sender: TObject);
    procedure MChamadoClick(Sender: TObject);
    procedure BChamadosClick(Sender: TObject);
    procedure MProcessarFaturamentoPosteriorClick(Sender: TObject);
    procedure BContatosClick(Sender: TObject);
    procedure BMenuFiscalClick(Sender: TObject);
    procedure MNovaPropostaClick(Sender: TObject);
    procedure MVisitasClick(Sender: TObject);
    procedure ECidadeExit(Sender: TObject);
    procedure MCreditoClienteClick(Sender: TObject);
    procedure MFilhosClick(Sender: TObject);
    procedure BPropostasClick(Sender: TObject);
    procedure ImprimirEnvelope1Click(Sender: TObject);
    procedure ImprimirEnvelopeCobrana1Click(Sender: TObject);
    procedure ImprimirEnvelopeEntrega1Click(Sender: TObject);
    procedure CadClientesAfterScroll(DataSet: TDataSet);
    procedure MExcluirRamoAtividadeClick(Sender: TObject);
    procedure PanelColor3Click(Sender: TObject);
    procedure ImprimeEnvelope1Click(Sender: TObject);
    procedure ERegiaoVendaFimConsulta(Sender: TObject);
    procedure MProdutoReservaClick(Sender: TObject);
    procedure GClientesDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure ESiglaUFClick(Sender: TObject);
    procedure ESiglaUFKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PanelColor2DblClick(Sender: TObject);
    procedure CCPFClick(Sender: TObject);
  private
    VprOrdem,
    VprNomCliente,
    VprNomFantasia : string;
    VprDCliente : TRBDCliente;
    FunContratos : TRBFuncoesContrato;
    procedure AtualizaConsulta(VpaPosicionar : Boolean = false);
    procedure Adicionafiltros(VpaSelect : Tstrings);
    procedure ConfiguraPermissaoUsuario;
  public
  end;

var
  FClientes: TFClientes;

implementation

uses APrincipal, ANovoCliente, constantes, Funsql,
  FunString, ACotacao, ANovaCobranca, FunObjeto,
  AContratosCliente, ANovaCotacao, ANovoTeleMarketing, ABrindesCliente,
  AProdutosCliente, AParentesCliente, ANovoChamadoTecnico,
  AChamadosTecnicos, fundata, Constmsg, AContatosCliente, AProdutosReserva,
  ANovaProposta, ANovoAgendamento, ACreditoCliente, APropostasCliente, dmRave, AMenuFiscalECF;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFClientes.FormCreate(Sender: TObject);
begin
  FunContratos := TRBFuncoesContrato.cria(FPrincipal.BaseDados);
  VprDCliente := TRBDCliente.cria;
  ConfiguraPermissaoUsuario;
  VprNomCliente := '';
  VprNomFantasia := '';
  Vprordem := 'order by i_cod_cli';
  ESiglaUF.Visible := (VARIA.CNPJFilial = CNPJ_INFORMARE) OR (VARIA.CNPJFilial = CNPJ_INFORWAP);
  if (ESiglaUF.Visible) then
  begin
    carregacombo(ESiglaUF, CT_UF);
    ActiveControl := ESiglaUF;
  end;
  CCliente.OnClick(self);
  if not ConfigModulos.TeleMarketing then
    MTeleMarketing.Visible := false;
  if not ConfigModulos.OrdemServico then
    BChamados.Visible := false;
  if not config.ControlarBrinde then
    BBrindes.Visible := false;
end;

{ ****************** Na criação do Formulário ******************************** }
procedure TFClientes.ImprimeEnvelope1Click(Sender: TObject);
begin
  CadClientes.First;
  While not CadClientes.eof do
  begin
    VprDCliente.free;
    VprDCliente := TRBDCliente.cria;
    VprDCliente.CodCliente := CadClientesI_cod_CLI.AsInteger;
    FunClientes.CarDCliente(VprDCliente);
    dtRave := TdtRave.create(self);
    dtRave.ImprimeEnvelope(VprDCliente);
    dtRave.free;
    CadClientes.Next;
  end;
end;

{ ****************** Na criação do Formulário ******************************** }
procedure TFClientes.ImprimirEnvelope1Click(Sender: TObject);
begin
  if CadClientesI_cod_CLI.AsInteger <> 0 then
  begin
    VprDCliente.free;
    VprDCliente := TRBDCliente.cria;
    VprDCliente.CodCliente := CadClientesI_cod_CLI.AsInteger;
    FunClientes.CarDCliente(VprDCliente);
    if VprDCliente.DesEnderecoEntrega <> '' then
      if not confirmacao('Esse cliente possui endereço de ENTREGA. Deseja realmente imprimir o endereço padrão?') then
        exit;
    if VprDCliente.DesEnderecoCobranca <> '' then
      if not confirmacao('Esse cliente possui endereço de COBRANÇA. Deseja realmente imprimir o endereço padrão?') then
        exit;
    dtRave := TdtRave.create(self);
    dtRave.ImprimeEnvelope(VprDCliente);
    dtRave.free;
  end;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFClientes.ImprimirEnvelopeCobrana1Click(Sender: TObject);
begin
  if CadClientesI_cod_CLI.AsInteger <> 0 then
  begin
    VprDCliente.free;
    VprDCliente := TRBDCliente.cria;
    VprDCliente.CodCliente := CadClientesI_cod_CLI.AsInteger;
    FunClientes.CarDCliente(VprDCliente);
    dtRave := TdtRave.create(self);
    dtRave.ImprimeEnvelopeCobranca(VprDCliente);
    dtRave.free;
  end;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFClientes.ImprimirEnvelopeEntrega1Click(Sender: TObject);
begin
  if CadClientesI_cod_CLI.AsInteger <> 0 then
  begin
    VprDCliente.free;
    VprDCliente := TRBDCliente.cria;
    VprDCliente.CodCliente := CadClientesI_cod_CLI.AsInteger;
    FunClientes.CarDCliente(VprDCliente);
    dtRave := TdtRave.create(self);
    dtRave.ImprimeEnvelopeEntrega(VprDCliente);
    dtRave.free;
  end;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFClientes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   CadClientes.close;
   FunContratos.free;
   VprDCliente.free;
   Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações dos Botões
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{*************************Fecha o formulario conrrente*************************}
procedure TFClientes.BFecharClick(Sender: TObject);
begin
   Close;
end;

{*****************************Procura o cliente********************************}
procedure TFClientes.BotaoAlterar1Atividade(Sender: TObject);
begin
  AdicionaSQlAbreTabela(FNovoCliente.CadClientes,'Select * from CadClientes '+
                                                 ' Where I_COD_CLI = '+CadClientesI_COD_CLI.AsString);
   
end;

{***************Cria o formluario pra cadastrar novos registros****************}
procedure TFClientes.BotaoCadastrar1AntesAtividade(Sender: TObject);
begin
   FNovoCliente := TFNovoCliente.CriarSDI(Application,'',FPrincipal.VerificaPermisao('FNovoCliente'));
end;

{*************Chama a tela de novos registros e atualiza a tabela**************}
procedure TFClientes.BotaoCadastrar1DepoisAtividade(Sender: TObject);
begin
  if FNovoCliente.CadClientes.State = dsinsert then
  begin
    FNovoCliente.CProspect.Checked:= CProspect.Checked;
    FNovoCliente.CCliente.Checked:= CCliente.Checked;
    FNovoCliente.CFornecedor.Checked:= CFornecedor.Checked;
    if (puCRSomenteCadastraProspect in varia.PermissoesUsuario) then
    begin
      FNovoCliente.CCliente.Checked:= false;
      FNovoCliente.CProspect.Checked:= true;
    end;

  end;
  FNovoCliente.ShowModal;
  AtualizaConsulta(true);
end;

{*********************Mostra o registro que será excluido**********************}
procedure TFClientes.BotaoExcluir1DepoisAtividade(Sender: TObject);
begin
   FNovoCliente.show;
end;

{***********Fecha o Formulario de novos registros e atualiza a tabela**********}
procedure TFClientes.BotaoExcluir1DestroiFormulario(Sender: TObject);
begin
   FNovoCliente.Close;
   AtualizaConsulta(true);
end;

{*********** consulta clientes ********************************************** }
procedure TFClientes.BotaoConsultar1AntesAtividade(Sender: TObject);
begin
   FNovoCliente := TFNovoCliente.CriarSDI(Application,'',true);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{***********Chama a rotina para atualizar o tipo de cadastro mostrado**********}
procedure TFClientes.cliClick(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFClientes.AtualizaConsulta(VpaPosicionar : Boolean = false);
var
  VpfPosicao : TBookmark;
begin
  if VpaPosicionar then
    VpfPosicao := CadClientes.GetBookmark;
  cadclientes.close;
  CadClientes.sql.clear;
  cadclientes.sql.add('Select * from CadClientes CLI ' +
                      'Where I_COD_CLI = I_COD_CLI ');
  adicionaFiltros(Cadclientes.sql);
  CadClientes.sql.add(VprOrdem);
  GravaEstatisticaConsulta(Nil,cADClientes,varia.CodigoUsuario,Self.name,NomeModulo,config.UtilizarPercentualConsulta);
  Cadclientes.open;
  GClientes.ALinhaSQLOrderBy := cadclientes.sql.count -1;
  if VpaPosicionar then
    try
      CadClientes.GotoBookmark(Vpfposicao);
      cadclientes.freebookmark(vpfposicao);
    except
      try
        CadClientes.Last;
        CadClientes.GotoBookmark(Vpfposicao);
        cadclientes.freebookmark(vpfposicao);
      except

      end;
    end;
  VprNomCliente :=  ENomCliente.text;
  VprNomFantasia := ENomFantasia.Text;
end;

{******************************************************************************}
procedure TFClientes.Adicionafiltros(VpaSelect : Tstrings);
var
  VpfLinha : String;
begin
  if ECodCliente.Text <> '' then
  begin
    VpaSelect.Add('and I_COD_CLI = '+ECodCliente.Text);
    if (puSomenteClientesdoVendedor in varia.PermissoesUsuario) then
      VpaSelect.Add('and I_COD_VEN in '+varia.CodigosVendedores);
  end
  else
  begin
    if ENomCliente.Text <> '' then
      VpaSelect.add(' AND C_Nom_Cli like '''+ENomCliente.text+'%''');

    if CAtivo.Checked  then
      VpaSelect.Add('AND C_IND_ATI = ''S''');

    if (puClientesInativos in varia.PermissoesUsuario) then
      VpaSelect.Add('AND C_IND_ATI = ''N''');

    if CCliente.Checked or CFornecedor.Checked  or CProspect.Checked or CTransportadora.Checked then
    begin
      VpaSelect.add(' and (');
      if CCliente.Checked then
      begin
        VpfLinha := 'or ( C_IND_CLI = ''S''';
        VpfLinha := VpfLinha + ')';
      end;
      if CFornecedor.Checked then
        VpfLinha := VpfLinha +'or C_IND_FOR = ''S''';
      if CTransportadora.Checked then
        VpfLinha := VpfLinha +'or C_IND_TRA = ''S''';
      if CProspect.Checked then
      begin
        VpfLinha := VpfLinha +'or ( C_IND_PRC = ''S''';
        VpfLinha := VpfLinha + ')';
      end;
      if CHotel.Checked then
        VpfLinha := VpfLinha + 'or C_IND_HOT = ''S''';
      vpflinha := copy(Vpflinha,3,length(Vpflinha)-2);
      VpaSelect.add(vpflinha +')');
    end;
    if (puSomenteProspectdoVendedor in varia.PermissoesUsuario) then
       VpaSelect.Add('and I_COD_VEN in '+varia.CodigosVendedores);
    if (puSomenteClientesdoVendedor in varia.PermissoesUsuario) then
      VpaSelect.Add('and I_COD_VEN in '+varia.CodigosVendedores);

    if ENomFantasia.text <> '' then
      VpaSelect.Add('and C_NOM_FAN LIKE '''+ENomFantasia.Text+'%''');
    if ECidade.Text <> '' then
      VpaSelect.Add('and C_CID_CLI LIKE '''+ECidade.Text+'%''');
    if EUF.Text <> '' then
      VpaSelect.Add('and C_EST_CLI = '''+EUF.Text+'''');
    if EBairro.Text <> '' then
      VpaSelect.Add('and C_BAI_CLI LIKE '''+EBairro.Text+'%''');

    if DeletaChars(DeletaChars(DeletaChars(DeletaChars(ECNPJ.Text,'.'),'-'),'/'),' ') <> '' then
      VpaSelect.add(' and C_CGC_CLI = '''+ECNPJ.text+'''');

    if DeletaChars(DeletaChars(DeletaChars(DeletaChars(ECPF.Text,'.'),'-'),'/'),' ') <> '' then
      VpaSelect.add(' and C_CPF_CLI = '''+ECPF.text+'''');

    if EVendedor.AInteiro <> 0 then
      VpaSelect.Add('and I_COD_VEN = '+ EVendedor.Text);


    if DeletaChars(DeletaChars(DeletaChars(DeletaChars(ETelefone.Text,'('),')'),'-'),' ') <> '' then
      VpaSelect.Add(' and( C_FO1_CLI LIKE '''+ETelefone.Text+'%''or '+
                    ' C_FO2_CLI LIKE '''+ETelefone.Text+'%''or '+
                    ' C_FO3_CLI LIKE '''+ETelefone.Text+'%''or '+
                    ' C_FON_CEL LIKE '''+ETelefone.Text+'%''or '+
                    ' C_FON_FAX LIKE '''+ETelefone.Text+'%''or ' +
                    ' exists (Select 1 FROM CLIENTETELEFONE FON ' +
                    ' WHERE FON.CODCLIENTE = CLI.I_COD_CLI ' +
                    ' AND FON.DESTELEFONE LIKE '''+ETelefone.Text+'%'')) ');
    if ERamoAtividade.AInteiro <> 0 then
      VpaSelect.Add(' and I_COD_RAM = '+ERamoAtividade.Text);
    if CSomenteNaoExportados.Checked then
      VpaSelect.Add(' and C_FLA_EXP = ''N''');
  end;
end;

{******************************************************************************}
procedure TFClientes.ConfiguraPermissaoUsuario;
begin
  if (puCRSomenteCadastraProspect in varia.PermissoesUsuario) then
  begin
    AlterarVisibleDet([BotaoAlterar1,BotaoExcluir1,BCotacoes,BCobrancas,BChamados,BContratos],false);
    AlterarEnabledDet([CFornecedor],false);
    CProspect.Checked := true;
    CCliente.Checked := false;
  end;
  if varia.TipoBancoDados = bdRepresentante then
  begin
    AlterarVisibleDet([BCobrancas,MProdutoReserva,BContatos,BBrindes,BContratos,BProdutos,BPropostas,MChamado,MProcessarFaturamentoPosterior,N4,
                       MNovaProposta,MVisitas,N6,MFilhos,MExcluirRamoAtividade,MCreditoCliente],false);
  end;
  BMenuFiscal.Visible := NomeModulo = 'PDV';
  if (puClientesInativos in varia.PermissoesUsuario) then
  begin
    CAtivo.Checked:= False;
    CAtivo.Visible:= false;
  end;
end;

{********** adiciona order by na tabela ************************************ }
procedure TFClientes.GClientesOrdem(Ordem: String);
begin
  VprOrdem := ordem;
end;

{******************************************************************************}
procedure TFClientes.BBAjudaClick(Sender: TObject);
begin
end;

{******************************************************************************}
procedure TFClientes.ENomClienteKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    13 : cliClick(CCliente);
  end;
end;

{******************************************************************************}
procedure TFClientes.BitBtn2Click(Sender: TObject);
begin
  ETelefone.Clear;
  cliClick(self);
end;

{******************************************************************************}
procedure TFClientes.GClientesDblClick(Sender: TObject);
begin
  BotaoConsultar1.Click;
end;

{******************************************************************************}
procedure TFClientes.GClientesDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if (State = [gdSelected]) then
  begin
    GClientes.Canvas.Font.Color:= clWhite;
    GClientes.DefaultDrawDataCell(Rect, GClientes.columns[datacol].field, State);
  end
  else
  begin
    if (CadClientesC_IND_BLO.AsString = 'S')then
    begin
      GClientes.Canvas.Font.Color:= clRed;
      GClientes.DefaultDrawDataCell(Rect, GClientes.columns[datacol].field, State);
    end;
    if CadClientesC_IND_ATI.AsString = 'N' then
    begin
      GClientes.Canvas.Font.Color:= clBlue;
      GClientes.DefaultDrawDataCell(Rect, GClientes.columns[datacol].field, State);
    end;
  end;
end;

procedure TFClientes.BCotacoesClick(Sender: TObject);
begin
  if CadClientesI_COD_CLI.AsInteger <> 0 then
  begin
    FCotacao := TFCotacao.CriarSDI(application,'', FPrincipal.VerificaPermisao('FCotacao'));
    FCotacao.ConsultaCotacoesCliente(CadClientesI_COD_CLI.AsInteger);
    FCotacao.free;
  end;
end;

procedure TFClientes.BCobrancasClick(Sender: TObject);
begin
  FNovaCobranca := TFNovaCobranca.CriarSDI(application,'', FPrincipal.VerificaPermisao('FNovaCobranca'));
  FNovaCobranca.CobrancaCliente(CadClientesI_COD_CLI.AsInteger);
  FNovaCobranca.free;
end;


{******************************************************************************}
procedure TFClientes.BContratosClick(Sender: TObject);
begin
  if CadClientesI_COD_CLI.AsInteger <> 0 then
  begin
    FContratosCliente := tFContratosCliente.CriarSDI(application,'', FPrincipal.VerificaPermisao('FContratosCliente'));
    FContratosCliente.ContratosCliente(CadClientesI_COD_CLI.AsInteger);
    FContratosCliente.free;
  end;
end;

{******************************************************************************}
procedure TFClientes.NovaCotao1Click(Sender: TObject);
begin
  FNovaCotacao := TFNovaCotacao.CriarSDI(application,'', FPrincipal.VerificaPermisao('FNovaCotacao'));
  FNovaCotacao.NovaCotacaoCliente(CadClientesI_COD_CLI.AsInteger);
  FNovaCotacao.free;
end;

{******************************************************************************}
procedure TFClientes.MTeleMarketingClick(Sender: TObject);
begin
  if not CadClientes.Eof then
  begin
    FNovoTeleMarketing := TFNovoTeleMarketing.CriarSDI(application,'', FPrincipal.VerificaPermisao('FNovoTeleMarketing'));
    FNovoTeleMarketing.TeleMarketingCliente(CadClientesI_COD_CLI.AsInteger);
    FNovoTeleMarketing.free;
  end;
end;

{******************************************************************************}
procedure TFClientes.BBrindesClick(Sender: TObject);
begin
  FBrindesCliente := TFBrindesCliente.CriarSDI(application,'', FPrincipal.VerificaPermisao('FBrindesCliente'));
  FBrindesCliente.BrindesCliente(CadClientesI_COD_CLI.AsInteger);
  FBrindesCliente.free;
end;

procedure TFClientes.BProdutosClick(Sender: TObject);
begin
  if CadClientesI_COD_CLI.AsInteger <> 0 then
  begin
    FProdutosCliente := TFProdutosCliente.CriarSDI(self,'',FPrincipal.VerificaPermisao('FProdutosCliente'));
    FProdutosCliente.CadastraProdutos(CadClientesI_COD_CLI.AsInteger);
    FProdutosCliente.free;
  end;
end;

{******************************************************************************}
procedure TFClientes.ENomClienteExit(Sender: TObject);
begin
  if VprNomCliente <> ENomCliente.Text then
  begin
     AtualizaConsulta;
  end;
end;

{******************************************************************************}
procedure TFClientes.ENomFantasiaExit(Sender: TObject);
begin
  if VprNomFantasia <> ENomFantasia.Text then
  begin
     AtualizaConsulta;
  end;
end;

procedure TFClientes.ERegiaoVendaFimConsulta(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFClientes.ESiglaUFClick(Sender: TObject);
begin
  if ESiglaUF.ItemIndex >= 0 then
  begin
    ECodCliente.Text := IntToStr(ESiglaUF.ItemIndex +1);
    ECodCliente.SetFocus;
    ECodCliente.SelStart := 4;
  end;
end;

{******************************************************************************}
procedure TFClientes.ESiglaUFKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
begin
  if key = 13  then
  begin
    ESiglaUFClick(ESiglaUF);
  end;
end;

{******************************************************************************}
procedure TFClientes.ECNPJExit(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFClientes.MChamadoClick(Sender: TObject);
begin
  if CadClientesI_COD_CLI.AsInteger <> 0 then
  begin
    FNovoChamado := TFNovoChamado.CriarSDI(self,'',FPrincipal.VerificaPermisao('TFNovoChamado'));
    FNovoChamado.NovoChamadoCliente(CadClientesI_COD_CLI.AsInteger);
    FNovoChamado.free;
  end;
end;

procedure TFClientes.MExcluirRamoAtividadeClick(Sender: TObject);
begin
  if confirmacao('Tem certeza que deseja excluir todos os clientes do mesmo ramo de atividade?') then
  begin
    FunClientes.ExcluiClientesRamoAtividade(CadClientesI_COD_RAM.AsInteger);
    ERamoAtividade.Clear;
    AtualizaConsulta;
  end;
end;

{******************************************************************************}
procedure TFClientes.BChamadosClick(Sender: TObject);
begin
  if CadClientesI_COD_CLI.AsInteger <> 0 then
  begin
    FChamadoTecnico := TFChamadoTecnico.CriarSDI(self,'',FPrincipal.VerificaPermisao('FChamadoTecnico'));
    FChamadoTecnico.ConsultaChamadosCliente(CadClientesI_COD_CLI.AsInteger);
    FChamadoTecnico.free;
  end;
end;

{******************************************************************************}
procedure TFClientes.PanelColor2DblClick(Sender: TObject);
begin
  CadClientes.SaveToFile('c:\clientes.xml',dfXML);
  CadClientes.LoadFromFile();
end;

procedure TFClientes.PanelColor3Click(Sender: TObject);
begin
end;

{******************************************************************************}
procedure TFClientes.MProdutoReservaClick(Sender: TObject);
begin
  if CadClientesI_COD_CLI.AsInteger <> 0 then
  begin
    FProdutosReserva:= TFProdutosReserva.CriarSDI(Application,'',True);
    FProdutosReserva.ProdutosReserva(CadClientesI_COD_CLI.AsInteger);
    FProdutosReserva.Free;
  end;
end;

{******************************************************************************}
procedure TFClientes.MProcessarFaturamentoPosteriorClick(Sender: TObject);
var
  Vpflabel : TLabel;
  VpfLanOrcamento : Integer;
  VpfResultado : String;
begin
  if CadClientesI_COD_CLI.AsInteger <> 0 then
  begin
    Vpflabel := TLabel.Create(nil);
    VpfResultado := FunContratos.ProcessaFaturamentoPosterior(nil,Vpflabel,DecMes(date,6),Date,CadClientesI_COD_CLI.AsInteger,VpfLanOrcamento,nil,false,nil);
    VpfLabel.free;
    if vpfresultado <> '' then
      aviso(vpfresultado);
  end;
end;

{******************************************************************************}
procedure TFClientes.BContatosClick(Sender: TObject);
begin
  if CadClientesI_COD_CLI.AsInteger <> 0 then
  begin
    FContatosCliente:= TFContatosCliente.CriarSDI(Application,'',True);
    FContatosCliente.CadastraContatos(CadClientesI_COD_CLI.AsInteger);
    FContatosCliente.Free;
  end;
end;

{******************************************************************************}
procedure TFClientes.BMenuFiscalClick(Sender: TObject);
begin
  FMenuFiscalECF := TFMenuFiscalECF.CriarSDI(self,'',true);
  FMenuFiscalECF.ShowModal;
  FMenuFiscalECF.Free;
end;

{******************************************************************************}
procedure TFClientes.CadClientesAfterScroll(DataSet: TDataSet);
begin
  MExcluirRamoAtividade.Enabled := CadClientesI_COD_RAM.AsInteger <> 0;
  if varia.TipoBancoDados = bdRepresentante then
  begin
    AlterarEnabledDet([BotaoAlterar1,BotaoExcluir1],CadClientesC_FLA_EXP.AsString = 'N');
  end;

end;

procedure TFClientes.CCPFClick(Sender: TObject);
begin
  ECNPJ.Visible := CCNPJ.Checked;
  ECPF.Visible := CCPF.Checked;
end;

{******************************************************************************}
procedure TFClientes.MNovaPropostaClick(Sender: TObject);
begin
  if CadClientesI_COD_CLI.AsInteger <> 0 then
  begin
    FNovaProposta := TFNovaProposta.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaProposta'));
    FNovaProposta.NovaPropostaCliente(CadClientesI_COD_CLI.asinteger);
    FNovaProposta.free;
  end;
end;

{******************************************************************************}
procedure TFClientes.MVisitasClick(Sender: TObject);
begin
  if CadClientesI_COD_CLI.AsInteger <> 0 then
  begin
    FNovoAgedamento := tFNovoAgedamento.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoAgedamento'));
    FNovoAgedamento.NovaAgendaCliente(CadClientesI_Cod_Cli.AsInteger);
    FNovoAgedamento.free;
  end;
end;

{******************************************************************************}
procedure TFClientes.ECidadeExit(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFClientes.MCreditoClienteClick(Sender: TObject);
begin
  if CadClientesI_COD_CLI.AsInteger <> 0 then
  begin
    FCreditoCliente := TFCreditoCliente.CriarSDI(self,'',FPrincipal.VerificaPermisao('FCreditoCliente'));
    FCreditoCliente.CreditoCliente(CadClientesI_COD_CLI.AsInteger);
    FCreditoCliente.free;
  end;
end;

{******************************************************************************}
procedure TFClientes.MFilhosClick(Sender: TObject);
begin
  if CadClientesI_COD_CLI.AsInteger <> 0 then
  begin
    FParentesClientes := TFParentesClientes.CriarSDI(self,'',FPrincipal.VerificaPermisao('FParentesClientes'));
    FParentesClientes.ParentesClientes(CadClientesI_COD_CLI.asInteger);
    FParentesClientes.free;
  end;
end;

procedure TFClientes.BPropostasClick(Sender: TObject);
begin
  if CadClientesI_COD_CLI.AsInteger <> 0 then
  begin
    FPropostasCliente := TFPropostasCliente.CriarSDI(self,'',FPrincipal.VerificaPermisao('FPropostasCliente'));
    FPropostasCliente.ConsultaPropostas(CadClientesI_COD_CLI.AsInteger);
    FPropostasCliente.free;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFClientes]);
end.
