unit ANovaOrdemProducaoGenerica;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente, ComCtrls, Db,
  DBTables, Grids, DBGrids, Tabela, DBKeyViolation, DBCtrls, UnDadosProduto,
  Localizacao, Mask, numericos, Constantes, EditorImagem, DBClient, UnOrdemProducao;

type
  TFNovaOrdemProducaoGenerica = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BCadastrar: TBitBtn;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    BFechar: TBitBtn;
    Paginas: TPageControl;
    POrdemProducao: TTabSheet;
    PEstagios: TTabSheet;
    DBMemoColor1: TDBMemoColor;
    GridIndice1: TGridIndice;
    Splitter1: TSplitter;
    FracaoOpEstagio: TSQL;
    DataEstagioReal: TDataSource;
    ScrollBox1: TScrollBox;
    PanelColor3: TPanelColor;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    Label3: TLabel;
    EFilial: TEditLocaliza;
    Label1: TLabel;
    SpeedButton3: TSpeedButton;
    Label6: TLabel;
    ECliente: TEditLocaliza;
    EPedido: Tnumerico;
    Label4: TLabel;
    Label5: TLabel;
    EOrdemCompra: TEditColor;
    Label7: TLabel;
    EDatEmissao: TCalendario;
    EEntregaPrevista: TCalendario;
    Label8: TLabel;
    Label12: TLabel;
    SpeedButton6: TSpeedButton;
    Label13: TLabel;
    EUsuario: TEditLocaliza;
    EObservacoes: TMemoColor;
    Label9: TLabel;
    Label10: TLabel;
    SpeedButton2: TSpeedButton;
    SpeedButton4: TSpeedButton;
    LProduto: TLabel;
    SpeedButton7: TSpeedButton;
    EProduto: TEditLocaliza;
    EditorImagem1: TEditorImagem;
    Localiza: TConsultaPadrao;
    Label14: TLabel;
    SpeedButton5: TSpeedButton;
    Label15: TLabel;
    ECor: TEditLocaliza;
    EUMPedido: TComboBoxColor;
    Label30: TLabel;
    EReferenciaCliente: TEditColor;
    Label16: TLabel;
    Label17: TLabel;
    EQtd: Tnumerico;
    EOP: Tnumerico;
    Label11: TLabel;
    ValidaGravacao1: TValidaGravacao;
    PFracaoestagio: TTabSheet;
    GridIndice2: TGridIndice;
    EstagioReal: TSQL;
    DateField1: TSQLTimeStampField;
    DateTimeField1: TSQLTimeStampField;
    StringField1: TWideStringField;
    StringField2: TWideStringField;
    StringField3: TWideStringField;
    StringField4: TWideStringField;
    FracaoOpEstagioSEQESTAGIO: TFMTBCDField;
    FracaoOpEstagioQTDCELULA: TFMTBCDField;
    FracaoOpEstagioDESHORAS: TWideStringField;
    FracaoOpEstagioINDPRODUCAO: TWideStringField;
    FracaoOpEstagioQTDPRODUZIDO: TFMTBCDField;
    FracaoOpEstagioCODEST: TFMTBCDField;
    FracaoOpEstagioNOMEST: TWideStringField;
    FracaoOpEstagioQTDPRODUTO: TFMTBCDField;
    DataFracaoOpEstagio: TDataSource;
    FracaoOpEstagioDESESTAGIO: TWideStringField;
    FracaoOpEstagioINDFINALIZADO: TWideStringField;
    EFracao: Tnumerico;
    LFracao: TLabel;
    LEstagio: TLabel;
    BEstagio: TSpeedButton;
    Label20: TLabel;
    EEstagio: TEditLocaliza;
    BarraStatus: TStatusBar;
    LProjeto: TLabel;
    EProjeto: TRBEditLocaliza;
    BProjeto: TSpeedButton;
    LNomProjeto: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure PaginasChange(Sender: TObject);
    procedure EProdutoCadastrar(Sender: TObject);
    procedure EProdutoSelect(Sender: TObject);
    procedure EProdutoRetorno(Retorno1, Retorno2: String);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure EProdutoChange(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure GridIndice2DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    VprAcao : Boolean;
    VprSeqProdutoAnterior : Integer;
    VprOperacao : TRBDOperacaoCadastro;
    VprDOrdemProducao : TRBDOrdemProducao;
    VprDFracaoOP : TRBDFracaoOrdemProducao;
    procedure CarDTela;
    procedure CarDClasse;
    procedure InicializaTela;
    procedure PosEstagiosRealizados;
    procedure PosFracaoOPEstagios;
    procedure EstadoBotoes(VpaEstado :Boolean);
    procedure ConfiguraTela;
    procedure GeraFracoesOPSubmontagens;
  public
    { Public declarations }
    function NovaOrdemProducao : Boolean;
    function AdicionaFracaoOPExistente(VpaCodFilial, VpaSeqOrdem : Integer):boolean;
    function AlterarOrdemProducao(VpaDOrdemProducao : TRBDOrdemProducao):boolean;
    procedure ConsultaOrdemProduca(VpaDOrdemProducao : TRBDOrdemProducao;VpaDFracao : TRBDFracaoOrdemProducao);
  end;

var
  FNovaOrdemProducaoGenerica: TFNovaOrdemProducaoGenerica;

implementation

uses APrincipal, FunSql, UnProdutos, AGeraFracaoOP, ANovoProdutoPro, FunObjeto, AGeraFracaoOPProdutos, FunNumeros;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovaOrdemProducaoGenerica.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprSeqProdutoAnterior := -1;
  VprAcao := false;
  Paginas.ActivePageIndex := 0;
  ConfiguraTela;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovaOrdemProducaoGenerica.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFNovaOrdemProducaoGenerica.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFNovaOrdemProducaoGenerica.CarDTela;
begin
  EFilial.AInteiro := VprDOrdemProducao.CodEmpresafilial;
  EFilial.Atualiza;
  EOP.AsInteger := VprDOrdemProducao.SeqOrdem;
  EUsuario.AInteiro := VprDOrdemProducao.CodProgramador;
  EUsuario.Atualiza;
  ECliente.AInteiro := VprDOrdemProducao.CodCliente;
  ECliente.Atualiza;
  EProjeto.AInteiro := VprDOrdemProducao.CodProjeto;
  EProjeto.Atualiza;
  EPedido.AsInteger := VprDOrdemProducao.NumPedido;
  EDatEmissao.DateTime := VprDOrdemProducao.DatEmissao;
  EReferenciaCliente.Text := VprDOrdemProducao.DesReferenciaCliente;
  EOrdemCompra.Text := VprDOrdemProducao.DesOrdemCompra;
  if (varia.TipoOrdemProducao = toSubMontagem) and (VprOperacao in [ocEdicao,ocConsulta]) then
  begin
    EEntregaPrevista.DateTime := VprDFracaoOP.DatEntrega;
    EProduto.Text := VprDFracaoOP.CodProduto;
    EFracao.AsInteger := VprDFracaoOP.SeqFracao;
    LProduto.Caption := VprDFracaoOP.NomProduto;
    VprSeqProdutoAnterior := VprDFracaoOP.SeqProduto;
    EQtd.AValor := VprDFracaoOP.QtdProduto;
    EObservacoes.Lines.Text := VprDFracaoOP.DesObservacao;
    EEstagio.AInteiro := VprDFracaoOP.CodEstagio;
    EEstagio.Atualiza;
    EUMPedido.Items.clear;
    EUMPedido.Items.AddStrings(FunProdutos.RUnidadesParentes(VprDFracaoOP.UM));
    EUMPedido.ItemIndex := EUMPedido.Items.IndexOf(VprDFracaoOP.UM);
  end
  else
  begin
    EEntregaPrevista.DateTime := VprDOrdemProducao.DatEntregaPrevista;
    EProduto.Text := VprDOrdemProducao.CodProduto;
    LProduto.Caption := VprDOrdemProducao.DProduto.NomProduto;
    EUMPedido.Items.clear;
    EUMPedido.Items.AddStrings(FunProdutos.RUnidadesParentes(VprDOrdemProducao.DProduto.CodUnidade));
    VprSeqProdutoAnterior := VprDOrdemProducao.SeqProduto;
    ECor.AInteiro := VprDOrdemProducao.CodCor;
    ECor.Atualiza;
    EUMPedido.ItemIndex := EUMPedido.Items.IndexOf(VprDOrdemProducao.UMPedido);
    EQtd.AValor := VprDOrdemProducao.QtdProduto;
    EObservacoes.Lines.Text := VprDOrdemProducao.DesObservacoes;
  end;
end;

{******************************************************************************}
procedure TFNovaOrdemProducaoGenerica.CarDClasse;
begin
  VprDOrdemProducao.CodCliente := ECliente.AInteiro;
  VprDOrdemProducao.NumPedido := EPedido.AsInteger;
  VprDOrdemProducao.DatEntregaPrevista := EEntregaPrevista.DateTime;
  VprDOrdemProducao.DatEntrega := VprDOrdemProducao.DatEntregaPrevista;
  VprDOrdemProducao.UMPedido := EUMPedido.Text;
  VprDOrdemProducao.CodCor := ECor.AInteiro;
  VprDOrdemProducao.DesReferenciaCliente := EReferenciaCliente.Text;
  VprDOrdemProducao.QtdProduto := EQtd.AValor;
  VprDOrdemProducao.DesObservacoes := EObservacoes.Lines.Text;
  VprDOrdemProducao.SeqProduto := VprDOrdemProducao.DProduto.SeqProduto;
  VprDOrdemProducao.CodProduto := EProduto.Text;
  VprDOrdemProducao.CodProjeto := EProjeto.AInteiro;
  VprDOrdemProducao.NomProduto := VprDOrdemProducao.DProduto.NomProduto;
  VprDOrdemProducao.DesOrdemCompra := EOrdemCompra.Text;
end;

{******************************************************************************}
procedure TFNovaOrdemProducaoGenerica.InicializaTela;
begin
  EstadoBotoes(true);
  VprDOrdemProducao.free;
  VprDOrdemProducao := TRBDOrdemProducao.cria;
  VprDOrdemProducao.CodEmpresafilial := varia.CodigoEmpFil;
  VprDOrdemProducao.CodProgramador := varia.CodigoUsuario;
  VprDOrdemProducao.DatEmissao := now;
  VprDOrdemProducao.DatEntregaPrevista := date;
  VprDOrdemProducao.CodEstagio := varia.EstagioOrdemProducao;
  CarDTela;
  VprSeqProdutoAnterior := -1;
  ActiveControl := ECliente;
end;

{******************************************************************************}
procedure TFNovaOrdemProducaoGenerica.PosEstagiosRealizados;
begin
  if VprDFracaoOP <> nil then
  begin
    AdicionaSQLAbreTabela(EstagioReal,'select FRA.DATFIM, FRA.DATCADASTRO, FRA.DESOBSERVACAO, '+
                                    ' EST.NOMEST, '+
                                    ' USU.C_NOM_USU, '+
                                    ' USULOG.C_NOM_USU USUARIOLOGADO '+
                                    ' from FRACAOOPESTAGIOREAL FRA, ESTAGIOPRODUCAO EST, CADUSUARIOS USU, '+
                                    ' CADUSUARIOS USULOG '+
                                    ' Where FRA.CODUSUARIO = USU.I_COD_USU '+
                                    ' and FRA.CODUSUARIOLOGADO = USULOG.I_COD_USU '+
                                    ' AND FRA.CODESTAGIO = EST.CODEST '+
                                    ' and FRA.CODFILIAL = '+IntToStr(VprDOrdemProducao.CodEmpresafilial)+
                                    ' and FRA.SEQORDEM = '+IntToStr(VprDOrdemProducao.SeqOrdem)+
                                    ' and FRA.SEQFRACAO = '+IntToStr(VprDFracaoOP.SeqFracao)+
                                    ' order by FRA.DATCADASTRO');
  end;
end;

{******************************************************************************}
procedure TFNovaOrdemProducaoGenerica.PosFracaoOPEstagios;
begin
  if VprDFracaoOP <> nil then
  begin
    AdicionaSQLAbreTabela(FracaoOpEstagio,'select FRE.SEQESTAGIO,  FRE.QTDCELULA, FRE.DESHORAS,'+
                                      ' FRE.INDPRODUCAO, FRE.QTDPRODUZIDO, FRE.INDFINALIZADO,  ' +
                                      ' PRE.DESESTAGIO, ' +
                                      ' EST.CODEST, EST.NOMEST, '+
                                      ' FRA.QTDPRODUTO ' +
                                      ' from FRACAOOPESTAGIO FRE, PRODUTOESTAGIO PRE, ESTAGIOPRODUCAO EST, FRACAOOP FRA ' +
                                      ' where FRE.CODFILIAL = '+IntToStr(VprDOrdemProducao.CodEmpresafilial)+
                                      ' and FRE.SEQORDEM = '+IntToStr(VprDOrdemProducao.SeqOrdem)+
                                      ' and FRE.SEQFRACAO = '+IntToStr(VprDFracaoOP.SeqFracao)+
                                      ' AND FRE.CODFILIAL = FRA.CODFILIAL '+
                                      ' AND FRE.SEQORDEM = FRA.SEQORDEM '+
                                      ' AND FRE.SEQFRACAO = FRA.SEQFRACAO '+
                                      ' AND FRE.SEQPRODUTO = PRE.SEQPRODUTO '+
                                      ' AND FRE.SEQESTAGIO = PRE.SEQESTAGIO '+
                                      ' AND PRE.CODESTAGIO = EST.CODEST '+
                                      ' order by PRE.SEQESTAGIO');
  end;
end;

{******************************************************************************}
procedure TFNovaOrdemProducaoGenerica.EstadoBotoes(VpaEstado :Boolean);
begin
  BCancelar.Enabled := VpaEstado;
  BGravar.Enabled := VpaEstado;
  BFechar.Enabled := not VpaEstado;
  BCadastrar.Enabled := not VpaEstado;
end;

{******************************************************************************}
procedure TFNovaOrdemProducaoGenerica.ConfiguraTela;
begin
  if (Varia.TipoOrdemProducao = toSubMontagem) then
  begin
    AlterarVisibleDet([LFracao,EFracao,LEstagio,EEstagio,BEstagio],true);
  end;
  ECor.ACampoObrigatorio := config.ConsumodoProdutoporCombinacao;
  AlterarVisibleDet([EProjeto,LProjeto,BProjeto],Config.ControlarProjeto);
end;

{******************************************************************************}
procedure TFNovaOrdemProducaoGenerica.GeraFracoesOPSubmontagens;
var
  VpfDFracaoSerie, VpfDFracao : TRBDFracaoOrdemProducao;
  VpfLaco : Integer;
begin
  if EQtd.AValor > 1 then
  begin
    VpfDFracaoSerie := VprDOrdemProducao.AddFracao;
    if VprDOrdemProducao.SeqOrdemaAdicionar <> 0 then
      VpfDFracaoSerie.SeqFracaoPai := 1;
    VpfDFracaoSerie.QtdProduto :=  1;
    VpfDFracaoSerie.DatEntrega := VprDOrdemProducao.DatEntrega;
    VpfDFracaoSerie.CodEstagio := Varia.EstagioOrdemProducao;
    VpfDFracaoSerie.IndEstagioGerado := true;
    VpfDFracaoSerie.IndEstagiosCarregados := true;
    VpfDFracaoSerie.IndProducaoemSerie := true;
  end;
  for VpfLaco := 1 to RetornaInteiro(EQtd.AValor) do
  begin
    VpfDFracao := VprDOrdemProducao.AddFracao;
    if VprDOrdemProducao.SeqOrdemaAdicionar <> 0 then
      VpfDFracao.SeqFracaoPai := 1;
    if EQtd.AValor > 1 then
      VpfDFracao.SeqFracaoPai := VpfDFracaoSerie.SeqFracao;
    VpfDFracao.SeqProduto := VprDOrdemProducao.SeqProduto;
    VpfDFracao.CodCor := VprDOrdemProducao.CodCor;
    VpfDFracao.CodProduto := VprDOrdemProducao.CodProduto;
    VpfDFracao.NomProduto := VprDOrdemProducao.NomProduto;
    VpfDFracao.DesObservacao := VprDOrdemProducao.DesObservacoes;
    VpfDFracao.NomCor := VprDOrdemProducao.NomCor;
    VpfDFracao.UM := VprDOrdemProducao.UMPedido;
    VpfDFracao.UMOriginal := VprDOrdemProducao.DProduto.CodUnidade;
    VpfDFracao.QtdUtilizada :=  1;
    VpfDFracao.QtdProduto :=  1;
    VpfDFracao.DatEntrega := VprDOrdemProducao.DatEntrega;
    VpfDFracao.CodEstagio := Varia.EstagioOrdemProducao;
    VpfDFracao.IndEstagioGerado := true;
    VpfDFracao.IndEstagiosCarregados := true;
    FunOrdemProducao.VplQtdFracoes := 0;
    FunOrdemProducao.AdicionaProdutosSubMontagem(VprDOrdemProducao,VpfDFracao,BarraStatus);
  end;
end;

{******************************************************************************}
procedure TFNovaOrdemProducaoGenerica.ConsultaOrdemProduca(VpaDOrdemProducao : TRBDOrdemProducao;VpaDFracao : TRBDFracaoOrdemProducao);
begin
  VprOperacao := ocConsulta;
  VprDOrdemProducao := VpaDOrdemProducao;
  VprDFracaoOP := VpaDFracao;
  CarDTela;
  EstadoBotoes(false);
  PanelColor3.Enabled := false;
  ShowModal;
end;

{******************************************************************************}
function TFNovaOrdemProducaoGenerica.NovaOrdemProducao : Boolean;
begin
  VprOperacao := ocInsercao;
  InicializaTela;
  showmodal;
  result := vprAcao;
end;

{******************************************************************************}
function TFNovaOrdemProducaoGenerica.AdicionaFracaoOPExistente(VpaCodFilial, VpaSeqOrdem: Integer): boolean;
begin
  VprOperacao := ocInsercao;
  InicializaTela;
  VprDOrdemProducao.CodEmpresafilial := VpaCodFilial;
  VprDOrdemProducao.SeqOrdem := VpaSeqOrdem;
  VprDOrdemProducao.SeqOrdemaAdicionar := VpaSeqOrdem;
  VprDOrdemProducao.SeqUltimaFracao := FunOrdemProducao.RSeqFracaoDisponivel(VpaCodFilial,VpaSeqOrdem)-1;
  FunOrdemProducao.CarDOrdemSerra(VprDOrdemProducao,0,0);
  EOP.AsInteger := VpaSeqOrdem;
  ECliente.AInteiro := FunOrdemProducao.RCodClienteOP(VpaCodFilial,VpaSeqOrdem);
  ECliente.Atualiza;
  EProjeto.AInteiro := FunOrdemProducao.RCodProjetoOP(VpaCodFilial,VpaSeqOrdem);
  ActiveControl := EProduto;
  showmodal;
  result := vprAcao;
end;

{******************************************************************************}
function TFNovaOrdemProducaoGenerica.AlterarOrdemProducao(VpaDOrdemProducao : TRBDOrdemProducao):boolean;
begin
  VprOperacao := ocConsulta;
  VprDOrdemProducao := VpaDOrdemProducao;
  CarDTela;
  VprOperacao := ocEdicao;
  EstadoBotoes(true);
  ShowModal;
end;

{******************************************************************************}
procedure TFNovaOrdemProducaoGenerica.PaginasChange(Sender: TObject);
begin
  if Paginas.ActivePage = PEstagios then
    PosEstagiosRealizados
  else
    if Paginas.ActivePage = PFracaoestagio then
      PosFracaoOPEstagios;
end;

{******************************************************************************}
procedure TFNovaOrdemProducaoGenerica.EProdutoCadastrar(Sender: TObject);
begin
  FNovoProdutoPro := TFNovoProdutoPro.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoProdutoPro'));
  FNovoProdutoPro.NovoProduto('');
  FNovoProdutoPro.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovaOrdemProducaoGenerica.EProdutoSelect(Sender: TObject);
begin
  EProduto.ASelectValida.Text := 'Select * from CADPRODUTOS Where '+Varia.CodigoProduto + ' = ''@'' and C_ATI_PRO = ''S''';
  EPRoduto.ASelectLocaliza.Text := 'Select * from CADPRODUTOS Where C_NOM_PRO like  ''@%'' and C_ATI_PRO = ''S''';
end;

{******************************************************************************}
procedure TFNovaOrdemProducaoGenerica.EProdutoRetorno(Retorno1,
  Retorno2: String);
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
  begin
    if Retorno1 <> '' then
    begin
      if VprSeqProdutoAnterior <> StrtoInt(Retorno1) then
      begin
        VprSeqProdutoAnterior := StrtoInt(Retorno1);
        VprDOrdemProducao.DProduto.CodEmpresa := varia.CodigoEmpresa;
        VprDOrdemProducao.DProduto.CodEmpFil := varia.CodigoEmpFil;
        VprDOrdemProducao.DProduto.SeqProduto := StrtoInt(Retorno1);
        FunProdutos.CarDProduto(VprDOrdemProducao.DProduto);
        EUMPedido.Clear;
        EUMPedido.Items.AddStrings(FunProdutos.RUnidadesParentes(VprDOrdemProducao.DProduto.CodUnidade));
      end;
    end;
  end;

end;

{******************************************************************************}
procedure TFNovaOrdemProducaoGenerica.SpeedButton4Click(Sender: TObject);
begin
  FNovoProdutoPro := TFNovoProdutoPro.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoProdutoPro'));
  FNovoProdutoPro.AlterarProduto(varia.codigoEmpresa,varia.CodigoEmpFil,VprDOrdemProducao.DProduto.SeqProduto);
  FNovoProdutoPro.free;
  FunProdutos.CarDProduto(VprDOrdemProducao.DProduto);
end;

{******************************************************************************}
procedure TFNovaOrdemProducaoGenerica.SpeedButton7Click(Sender: TObject);
begin
  editorImagem1.execute(varia.DriveFoto + VprDOrdemProducao.DProduto.PatFoto);
end;

{******************************************************************************}
procedure TFNovaOrdemProducaoGenerica.BCancelarClick(Sender: TObject);
begin
  VprAcao := false;
  close;
end;

{******************************************************************************}
procedure TFNovaOrdemProducaoGenerica.EProdutoChange(Sender: TObject);
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
    ValidaGravacao1.execute;
end;

{******************************************************************************}
procedure TFNovaOrdemProducaoGenerica.BGravarClick(Sender: TObject);
var
  VpfResultado : String;
begin
  CarDClasse;
  if varia.TipoOrdemProducao = toSubMontagem then
  begin
    GeraFracoesOPSubmontagens;
    FGeraFracaoOPProdutos := TFGeraFracaoOPProdutos.CriarSDI(self,'',true);
    if  FGeraFracaoOPProdutos.GeraOP(VprDOrdemProducao) then
    begin
      VprAcao := true;
      close;
    end;
    FGeraFracaoOPProdutos.free;
  end
  else
  begin
    FGeraFracaoOP := TFGeraFracaoOP.CriarSDI(self,'',FPrincipal.VerificaPermisao('FGeraFracaoOP'));
    if  FGeraFracaoOP.GeraFracaoOP(VprDOrdemProducao) then
    begin
      VprAcao := true;
      close;
    end;
    FGeraFracaoOP.free;
  end;
end;

{******************************************************************************}
procedure TFNovaOrdemProducaoGenerica.GridIndice2DrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if FracaoOpEstagioINDFINALIZADO.AsString = 'S' then
  begin
    GridIndice2.Canvas.brush.Color:= clGreen; // coloque aqui a cor desejada
    GridIndice2.Canvas.Font.Color:= clWhite;
    GridIndice2.DefaultDrawDataCell(Rect, GridIndice2.columns[datacol].field, State);
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovaOrdemProducaoGenerica]);
end.

