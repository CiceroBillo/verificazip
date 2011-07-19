unit ANovaSolicitacaoCompra;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, PainelGradiente, Componentes1, ComCtrls, StdCtrls, Buttons, UnDados,
  UnSolicitacaoCompra, Constantes, DBKeyViolation, Localizacao, Mask, Grids,
  CGrades, numericos, DBGrids, Tabela, UnPedidoCompra, Db, DBTables, UnDadosProduto,
  UnOrdemProducao, DBClient, Menus;

type
  TFNovaSolicitacaoCompras = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    BFechar: TBitBtn;
    ValidaGravacao: TValidaGravacao;
    PanelColor2: TPanelColor;
    Paginas: TPageControl;
    POrcamento: TTabSheet;
    ScrollBox1: TScrollBox;
    PEstagios: TTabSheet;
    PCabecalhoInicial: TPanelColor;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    LFilial: TLabel;
    Label3: TLabel;
    LUsuario: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Label14: TLabel;
    ENumero: TEditColor;
    EData: TMaskEditColor;
    EHora: TMaskEditColor;
    EFilial: TEditLocaliza;
    EUsuario: TEditLocaliza;
    PanelColor3: TPanelColor;
    Label6: TLabel;
    EPrazo: TMaskEditColor;
    PanelColor4: TPanelColor;
    PaginasOrcamento: TPageControl;
    PProdutos: TTabSheet;
    PFracaoOP: TTabSheet;
    GProdutos: TRBStringGridColor;
    GFracaoOP: TRBStringGridColor;
    PanelColor5: TPanelColor;
    Label12: TLabel;
    EObservacoes: TMemoColor;
    ECor: TEditLocaliza;
    Localiza: TConsultaPadrao;
    GEstagios: TGridIndice;
    BCadastrar: TBitBtn;
    Label16: TLabel;
    ESTAGIOS: TSQL;
    DataESTAGIOS: TDataSource;
    ESTAGIOSDATESTAGIO: TSQLTimeStampField;
    ESTAGIOSDESMOTIVO: TWideStringField;
    ESTAGIOSNOMEST: TWideStringField;
    ESTAGIOSC_NOM_USU: TWideStringField;
    Label5: TLabel;
    EDataFim: TMaskEditColor;
    Label7: TLabel;
    BImprimir: TBitBtn;
    Label13: TLabel;
    Label8: TLabel;
    SpeedButton4: TSpeedButton;
    EComprador: TEditLocaliza;
    SaveDialog: TSaveDialog;
    MImprimir: TPopupMenu;
    ExportarPDF1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure GProdutosCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GProdutosDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GProdutosGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure GProdutosMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GProdutosNovaLinha(Sender: TObject);
    procedure GProdutosSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure GProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ECorRetorno(Retorno1, Retorno2: String);
    procedure EPrazoExit(Sender: TObject);
    procedure GFracaoOPCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GFracaoOPDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GFracaoOPGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GFracaoOPMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GFracaoOPNovaLinha(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure BCadastrarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PaginasChange(Sender: TObject);
    procedure GFracaoOPSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure BImprimirClick(Sender: TObject);
    procedure ECompradorChange(Sender: TObject);
    procedure ECompradorCadastrar(Sender: TObject);
    procedure ECorCadastrar(Sender: TObject);
    procedure ExportarPDF1Click(Sender: TObject);
  private
    VprAcao,
    VprProposta : Boolean;
    VprOperacao: TRBDOperacaoCadastro;
    VprProdutoAnterior: String;
    VprDOrcamentoCorpo: TRBDSolicitacaoCompraCorpo;
    VprDOrcamentoItens: TRBDSolicitacaoCompraItem;
    VprDOrcamentoFracoes: TRBDSolicitacaoCompraFracaoOP;
    VprDProposta : TRBDPropostaCorpo;
    VprDChamado: TRBDChamado;
    FunOrcamentoCompra: TRBFunSolicitacaoCompra;
    FunPedidoCompra: TRBFunPedidoCompra;
    procedure ConfiguraPermissaoUsuario;
    procedure EstadoBotoes(VpaEstado: Boolean);
    procedure CarTitulosGrade;
    procedure InicializaGrade;
    procedure CriaClasses;
    procedure FinalizaClasses;
    procedure InicializaTela;
    procedure BloquearTela(VpaEstado: Boolean);
    procedure FocoInicial;
    procedure InicializaDadosPadrao;
    procedure CarDPadraoTela;
    procedure CarDClasseProdutos;
    procedure CarDChapaClasse;
    procedure CarDClasseOP;
    procedure CarDClasseCorpo;
    function ExisteProduto: Boolean;
    function LocalizaProduto: Boolean;
    function ExisteCor: Boolean;
    function ExisteFracao: Boolean;
    function ExisteClienteFracaoOP: Boolean;
    function FracaoOPJaUsada: Boolean;
    procedure CarDTela;
    procedure PosEstagios;
    procedure CarregaProdutosBaixa(VpaCodFilial,VpaSeqOrdem, VpaSeqFracao : Integer;VpaProdutos : TList);
    procedure CarregaProdutosPorposta(VpaDProposta : TRBDPropostaCorpo);
    procedure CarregaProdutosChamado(VpaDChamado : TRBDChamado);
    procedure CarregaProdutosPontoPedido(VpaSelect : TSql);
    procedure CarregaProdutosOrdemProducao(VpaCodFilial,VpaSeqOrdem : Integer);
    procedure AdicionaProdutosConsumoFracao(VpaDFracao : TRBDFracaoOrdemProducao);
    procedure CalculaKilosChapa;
  public
    function NovoOrcamento: Boolean;
    function NovoOrcamentoConsumo(VpaCodFilial,VpaSeqOrdem, VpaSeqFracao : Integer;VpaProdutos : TList):Boolean;
    function NovoOrcamentoProposta(VpaDProposta : TRBDPropostaCorpo):Boolean;
    function NovoOrcamentoChamado(VpaDChamado : TRBDChamado): Boolean;
    function NovoOrcamendoPontoPedido(VpaSql : TSql) : Boolean;
    function NovoOrcamentoOrdemProducao(VpaCodFilial,VpaSeqOrdem : Integer) : Boolean;
    function Alterar(VpaCodFilial, VpaSeqSolicitacao: Integer): Boolean;
    function Apagar(VpaCodFilial, VpaSeqSolicitacao: Integer): Boolean;
    function Consultar(VpaCodFilial, VpaSeqSolicitacao: Integer): Boolean;
    function RetornaNomeArquivoProjeto(VpaDOrcamentoItem : TRBDOrcamentoCompraProduto): string;
  end;

var
  FNovaSolicitacaoCompras: TFNovaSolicitacaoCompras;

implementation
uses
  FunString, FunSQL, FunData, FunObjeto, UnProdutos, ConstMsg, FunNumeros,
  APrincipal, ALocalizaProdutos, UnCrystal, ACompradores, ANovoProdutoPro,
  ACores, dmRave;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovaSolicitacaoCompras.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  //verificar trocar para o novo varia
  ConfiguraPermissaoUsuario;
  if Varia.EstagioInicialOrcamentoCompra = 0 then
    aviso('ESTAGIO INICIAL COMPRAS NÃO PREENCHIDO!!!'#13'É necessário preencher nas configurações gerais o estagio inicial do pedido de compra.');
  VprAcao:= False;
  CriaClasses;
  CarTitulosGrade;
  InicializaGrade;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovaSolicitacaoCompras.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FinalizaClasses;
  ESTAGIOS.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.BFecharClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
function TFNovaSolicitacaoCompras.NovoOrcamendoPontoPedido(VpaSql: TSql): Boolean;
begin
  VprOperacao := ocInsercao;
  InicializaTela;
  CarregaProdutosPontoPedido(VpaSql);
  GProdutos.CarregaGrade;
  ValidaGravacao.execute;
  ShowModal;
  result := VprAcao;
end;

{******************************************************************************}
function TFNovaSolicitacaoCompras.NovoOrcamento: Boolean;
begin
  VprOperacao:= ocInsercao;
  InicializaTela;
  ValidaGravacao.execute;
  ShowModal;
  Result:= VprAcao;
end;

{******************************************************************************}
function TFNovaSolicitacaoCompras.NovoOrcamentoChamado(VpaDChamado: TRBDChamado): Boolean;
begin
  VprOperacao := ocInsercao;
  VprDChamado := VpaDChamado;
  InicializaTela;
  CarregaProdutosChamado(VpaDChamado);
  GProdutos.CarregaGrade;
  ValidaGravacao.execute;
  ShowModal;
  result := VprAcao;
end;

{******************************************************************************}
function TFNovaSolicitacaoCompras.NovoOrcamentoConsumo(VpaCodFilial,VpaSeqOrdem, VpaSeqFracao : Integer;VpaProdutos : TList):Boolean;
begin
  VprOperacao := ocInsercao;
  InicializaTela;
  CarregaProdutosBaixa(VpaCodFilial,VpaSeqOrdem,VpaSeqFracao,VpaProdutos);
  ValidaGravacao.execute;
  ShowModal;
  result := VprAcao;
end;

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.EstadoBotoes(VpaEstado: Boolean);
begin
  BCadastrar.Enabled:= VpaEstado;
  BGravar.Enabled:= not VpaEstado;
  BCancelar.Enabled:= not VpaEstado;
  BFechar.Enabled:= VpaEstado;
end;

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.ConfiguraPermissaoUsuario;
begin
  if not config.EstoquePorCor then
  begin
    GProdutos.ColWidths[3] := -1;
    GProdutos.ColWidths[4] := -1;
    GProdutos.TabStops[3] := false;
    GProdutos.TabStops[4] := false;
    GProdutos.ColWidths[2] := RetornaInteiro(GProdutos.ColWidths[2] *1.9);
  end;
  if not config.ControlarEstoquedeChapas then
  begin
    GProdutos.ColWidths[5] := -1;
    GProdutos.ColWidths[6] := -1;
    GProdutos.ColWidths[7] := -1;
    GProdutos.TabStops[5] := false;
    GProdutos.TabStops[6] := false;
    GProdutos.TabStops[7] := false;
  end;
end;

{******************************************************************************}
function TFNovaSolicitacaoCompras.NovoOrcamentoProposta(VpaDProposta : TRBDPropostaCorpo):Boolean;
begin
  VprOperacao := ocInsercao;
  VprDProposta := VpaDProposta;
  VprProposta := true;
  InicializaTela;
  if VprProposta and Config.MostraObsComprasProposta then
    EObservacoes.Lines.Append(VprDProposta.DesObservacaoComercial);
  CarregaProdutosPorposta(VpaDProposta);
  GProdutos.CarregaGrade;
  ValidaGravacao.execute;
  ShowModal;
  result := VprAcao;
end;

{******************************************************************************}
function TFNovaSolicitacaoCompras.NovoOrcamentoOrdemProducao(VpaCodFilial,VpaSeqOrdem : Integer) : Boolean;
begin
  VprOperacao := ocInsercao;
  InicializaTela;
  CarregaProdutosOrdemProducao(VpaCodFilial,VpaSeqOrdem);
  GProdutos.CarregaGrade;
  ValidaGravacao.execute;
  ShowModal;
  result := VprAcao;
end;

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.CarTitulosGrade;
begin
  GProdutos.Cells[1,0]:= 'Código';
  GProdutos.Cells[2,0]:= 'Produto';
  GProdutos.Cells[3,0]:= 'Código';
  GProdutos.Cells[4,0]:= 'Cor';
  GProdutos.Cells[5,0]:= 'Qtd Chapas';
  GProdutos.Cells[6,0]:= 'Largura';
  GProdutos.Cells[7,0]:= 'Comprimento';
  GProdutos.Cells[8,0]:= 'UM';
  GProdutos.Cells[9,0]:= 'Qtd Utilizada';
  GProdutos.Cells[10,0]:= 'Qtd Aprovada';

  GFracaoOP.Cells[1,0]:= 'Filial';
  GFracaoOP.Cells[2,0]:= 'Ordem Produção';
  GFracaoOP.Cells[3,0]:= 'Fração';
end;

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.InicializaGrade;
begin
  GProdutos.ADados:= VprDOrcamentoCorpo.Produtos;
  GFracaoOP.ADados:= VprDOrcamentoCorpo.Fracoes;
  GProdutos.CarregaGrade;
  GFracaoOP.CarregaGrade;
end;

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.CriaClasses;
begin
  VprDOrcamentoCorpo:= TRBDSolicitacaoCompraCorpo.Cria;
  FunOrcamentoCompra:= TRBFunSolicitacaoCompra.Cria(FPrincipal.BaseDados);
  FunPedidoCompra:= TRBFunPedidoCompra.Cria(FPrincipal.BaseDados);
end;

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.FinalizaClasses;
begin
  VprDOrcamentoCorpo.Free;
  FunOrcamentoCompra.Free;
  FunPedidoCompra.Free;
end;

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.InicializaTela;
begin
  FocoInicial;
  FinalizaClasses;
  CriaClasses;
  InicializaGrade;
  InicializaDadosPadrao;
  CarDPadraoTela;
  BloquearTela(False);
  GProdutos.ColWidths[10] := -1;
  GProdutos.TabStops[10] := false;
end;

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.FocoInicial;
begin
  PaginasOrcamento.ActivePage:= PProdutos;
  Paginas.ActivePage:= POrcamento;
  if EComprador.AInteiro = 0 then
    ActiveControl:= EComprador
  else
    ActiveControl:= EPrazo;
end;

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.InicializaDadosPadrao;
begin
  VprDOrcamentoCorpo.CodFilial:= Varia.CodigoEmpFil;
  VprDOrcamentoCorpo.CodUsuario:= Varia.CodigoUsuario;
  VprDOrcamentoCorpo.CodEstagio:= Varia.EstagioInicialOrcamentoCompra;
  VprDOrcamentoCorpo.CodComprador:= Varia.CodComprador;
  VprDOrcamentoCorpo.DesSituacao:= 'A';
  VprDOrcamentoCorpo.IndCancelado:= 'N';
  VprDOrcamentoCorpo.DatEmissao:= Date;
  VprDOrcamentoCorpo.HorEmissao:= Time;
end;

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.CarDPadraoTela;
begin
  ENumero.AInteiro:= 0;
  EFilial.AInteiro:= VprDOrcamentoCorpo.CodFilial;
  EUsuario.AInteiro:= VprDOrcamentoCorpo.CodUsuario;
  EComprador.AInteiro:= VprDOrcamentoCorpo.CodComprador;
  ECor.AInteiro:= 0;
  EData.Text:= FormatDateTime('DD/MM/YYYY',VprDOrcamentoCorpo.DatEmissao);
  EHora.Text:= FormatDateTime('HH:MM',VprDOrcamentoCorpo.HorEmissao);
  EPrazo.Clear;
  EDataFim.Clear;
  EObservacoes.Clear;
  AtualizaLocalizas(PanelColor2);
  FocoInicial;
end;

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.GProdutosCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDOrcamentoItens:= TRBDSolicitacaoCompraItem(VprDOrcamentoCorpo.Produtos[VpaLinha-1]);
  GProdutos.Cells[1,GProdutos.ALinha]:= VprDOrcamentoItens.CodProduto;
  GProdutos.Cells[2,GProdutos.ALinha]:= VprDOrcamentoItens.NomProduto;
  if VprDOrcamentoItens.CodCor <> 0 then
    GProdutos.Cells[3,GProdutos.ALinha]:= IntToStr(VprDOrcamentoItens.CodCor)
  else
    GProdutos.Cells[3,GProdutos.ALinha]:= '';
  GProdutos.Cells[4,GProdutos.ALinha]:= VprDOrcamentoItens.NomCor;
  GProdutos.Cells[8,GProdutos.ALinha]:= VprDOrcamentoItens.DesUM;
  if VprDOrcamentoItens.QtdChapa <> 0 then
    GProdutos.Cells[5,GProdutos.ALinha]:= FormatFloat('#,###,###0',VprDOrcamentoItens.QtdChapa)
  else
    GProdutos.Cells[5,GProdutos.ALinha]:= '';
  if VprDOrcamentoItens.LarChapa <> 0 then
    GProdutos.Cells[6,GProdutos.ALinha]:= FormatFloat('#,###,###0',VprDOrcamentoItens.LarChapa)
  else
    GProdutos.Cells[6,GProdutos.ALinha]:= '';
  if VprDOrcamentoItens.ComChapa <> 0 then
    GProdutos.Cells[7,GProdutos.ALinha]:= FormatFloat('#,###,###0',VprDOrcamentoItens.ComChapa)
  else
    GProdutos.Cells[7,GProdutos.ALinha]:= '';
  if VprDOrcamentoItens.QtdProduto <> 0 then
    GProdutos.Cells[9,GProdutos.ALinha]:= FormatFloat(Varia.MascaraQtd,VprDOrcamentoItens.QtdProduto)
  else
    GProdutos.Cells[9,GProdutos.ALinha]:= '';
  if VprDOrcamentoItens.QtdAprovado <> 0 then
    GProdutos.Cells[10,GProdutos.ALinha]:= FormatFloat(Varia.MascaraQtd,VprDOrcamentoItens.QtdAprovado)
  else
    GProdutos.Cells[10,GProdutos.ALinha]:= '';
end;

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.GProdutosDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos:= True;
  if VprOperacao <> ocConsulta then
  begin
    if not ExisteProduto then
    begin
      VpaValidos:= False;
      aviso('CÓDIGO DO PRODUTO NÃO PREENCHIDO!!!'#13'É necessário informar o código do produto.');
      GProdutos.Col:= 1;
    end
    else
      if not ExisteCor then
      begin
        VpaValidos:= False;
        aviso('COR NÃO CADASTRADA!!!'#13'Informe uma cor que esteja cadastrada.');
        GProdutos.Col:= 3;
      end
      else
        if VprDOrcamentoItens.UnidadesParentes.IndexOf(GProdutos.Cells[8,GProdutos.ALinha]) < 0 then
        begin
          VpaValidos:= False;
          aviso(CT_UNIDADEVAZIA);
          GProdutos.Col:= 8;
        end
        else
          if GProdutos.Cells[9,GProdutos.ALinha] = '' then
          begin
            VpaValidos:= False;
            aviso('QUANTIDADE NÃO PREENCHIDA!!!'#13'É necessário preencer a quantidade do produto.');
            GProdutos.Col:= 9;
          end;

    if VpaValidos then
      CarDClasseProdutos;
  end;
end;

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.CarDClasseProdutos;
begin
  VprDOrcamentoItens.SeqItem:= 0;
  if GProdutos.Cells[3,GProdutos.ALinha] <> '' then
    VprDOrcamentoItens.CodCor:= StrToInt(GProdutos.Cells[3,GProdutos.ALinha])
  else
    VprDOrcamentoItens.CodCor:= 0;
  VprDOrcamentoItens.DesUM:= GProdutos.Cells[8,GProdutos.ALinha];
  CarDChapaClasse;
  if GProdutos.Cells[9,GProdutos.ALinha] <> '' then
    VprDOrcamentoItens.QtdProduto:= StrToFloat(DeletaChars(GProdutos.Cells[9,GProdutos.ALinha],'.'))
  else
    VprDOrcamentoItens.QtdProduto:= 0;
  if VprOperacao = ocInsercao then
    VprDOrcamentoItens.QtdAprovado := VprDOrcamentoItens.QtdProduto
  else
  begin
    if GProdutos.Cells[10,GProdutos.ALinha] <> '' then
      VprDOrcamentoItens.QtdAprovado:= StrToFloat(DeletaChars(GProdutos.Cells[10,GProdutos.ALinha],'.'))
    else
      VprDOrcamentoItens.QtdAprovado:= VprDOrcamentoItens.QtdProduto;
  end;
end;

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.GProdutosGetEditMask(Sender: TObject;
  ACol, ARow: Integer; var Value: String);
begin
  case ACol of
    3,5,6,7: Value:= '0000000;0; ';
  end;
end;

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.GProdutosKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key = '.') and (GProdutos.col <> 1) then
    Key:= DecimalSeparator;
end;

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.GProdutosMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDOrcamentoCorpo.Produtos.Count > 0 then
  begin
    VprDOrcamentoItens:= TRBDSolicitacaoCompraItem(VprDOrcamentoCorpo.Produtos[VpaLinhaAtual-1]);
    VprProdutoAnterior:= VprDOrcamentoItens.CodProduto;
  end;
end;

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.GProdutosNovaLinha(Sender: TObject);
begin
  VprDOrcamentoItens:= VprDOrcamentoCorpo.AddProduto;
end;

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.GProdutosSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if GProdutos.AEstadoGrade in [egEdicao,egInsercao] then
  begin
    if GProdutos.AColuna <> ACol then
    begin
      case GProdutos.AColuna of
        1: if not ExisteProduto then
             if not LocalizaProduto then
             begin
               GProdutos.Cells[1,GProdutos.ALinha]:= '';
               GProdutos.Cells[2,GProdutos.ALinha]:= '';
               Abort;
             end;
        3: if not ExisteCor then
             if not ECor.AAbreLocalizacao then
             begin
               GProdutos.Cells[3,GProdutos.ALinha]:= '';
               GProdutos.Cells[4,GProdutos.ALinha]:= '';
               Abort;
             end;
         5,6,7 : CalculaKilosChapa;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFNovaSolicitacaoCompras.ExisteProduto: Boolean;
begin
  Result:= False;
  if GProdutos.Cells[1,GProdutos.ALinha] <> '' then
  begin
    if GProdutos.Cells[1,GProdutos.ALinha] = VprProdutoAnterior then
      Result:= True
    else
    begin
      Result:= FunProdutos.ExisteProduto(GProdutos.Cells[1,GProdutos.ALinha],VprDOrcamentoItens);
      if Result then
      begin
        VprProdutoAnterior:= VprDOrcamentoItens.CodProduto;

        GProdutos.Cells[1,GProdutos.ALinha]:= VprDOrcamentoItens.CodProduto;
        GProdutos.Cells[2,GProdutos.ALinha]:= VprDOrcamentoItens.NomProduto;
        GProdutos.Cells[8,GProdutos.ALinha]:= VprDOrcamentoItens.DesUM;
        GProdutos.Cells[9,GProdutos.ALinha]:= FormatFloat(Varia.MascaraQtd,VprDOrcamentoItens.Qtdproduto);
      end;
    end;
  end
end;

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.ExportarPDF1Click(Sender: TObject);
begin
  SaveDialog.FileName := 'Solicitacao Compra '+IntToStr(VprDOrcamentoCorpo.SeqSolicitacao);
  if SaveDialog.Execute then
  begin
    dtRave := TdtRave.Create(self);
    dtRave.VplArquivoPDF := SaveDialog.FileName;
    dtRave.ImprimeSolicitacaoCompra(VprDOrcamentoCorpo.CodFilial,VprDOrcamentoCorpo.SeqSolicitacao,false);
    dtRave.free;
  end;

end;

{******************************************************************************}
function TFNovaSolicitacaoCompras.LocalizaProduto: Boolean;
begin
  FLocalizaProduto:= TFLocalizaProduto.CriarSDI(Application,'',True);
  Result:= FLocalizaProduto.LocalizaProduto(VprDOrcamentoItens);
  FLocalizaProduto.Free;
  if Result then
  begin
    VprProdutoAnterior:= VprDOrcamentoItens.CodProduto;

    GProdutos.Cells[1,GProdutos.ALinha]:= VprDOrcamentoItens.CodProduto;
    GProdutos.Cells[2,GProdutos.ALinha]:= VprDOrcamentoItens.NomProduto;
    GProdutos.Cells[8,GProdutos.ALinha]:= VprDOrcamentoItens.DesUM;
    GProdutos.Cells[9,GProdutos.ALinha]:= FormatFloat(Varia.MascaraQtd,VprDOrcamentoItens.Qtdproduto);
    GProdutos.Col:= 3;
  end;
end;

{******************************************************************************}
function TFNovaSolicitacaoCompras.ExisteCor: Boolean;
begin
  Result:= True;
  if GProdutos.Cells[3,GProdutos.ALinha] <> '' then
  begin
    Result:= FunProdutos.ExisteCor(GProdutos.Cells[3,GProdutos.ALinha],VprDOrcamentoItens.NomCor);
    if Result then
    begin
      VprDOrcamentoItens.CodCor:= StrToInt(GProdutos.Cells[3,GProdutos.ALinha]);
      GProdutos.Cells[4,GProdutos.ALinha]:= VprDOrcamentoItens.NomCor;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.GProdutosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = 114 then
    case GProdutos.AColuna of
      1: LocalizaProduto;
      3: ECor.AAbreLocalizacao;
    end;
end;

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.ECorRetorno(Retorno1, Retorno2: String);
begin
  if GProdutos.ALinha > 0 then
  begin
    GProdutos.Cells[3,GProdutos.ALinha]:= Retorno1;
    GProdutos.Cells[4,GProdutos.ALinha]:= Retorno2;
  end;
end;

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.EPrazoExit(Sender: TObject);
var
  Edit: TEdit;
begin
  Edit:= TEdit(Sender);
  try
    if DeletaEspaco(DeletaChars(Edit.Text,'/')) <> '' then
      StrToDate(Edit.Text);
  except
    aviso('DATA INVÁLIDA!!!'#13'Informe uma data corretamente');
    Edit.Clear;
    ActiveControl:= Edit;
  end;
end;

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.GFracaoOPCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDOrcamentoFracoes:= TRBDSolicitacaoCompraFracaoOP(VprDOrcamentoCorpo.Fracoes.Items[VpaLinha-1]);

  if VprDOrcamentoFracoes.CodFilialFracao <> 0 then
    GFracaoOP.Cells[1,GFracaoOP.ALinha]:= IntToStr(VprDOrcamentoFracoes.CodFilialFracao)
  else
    GFracaoOP.Cells[1,GFracaoOP.ALinha]:= '';
  if VprDOrcamentoFracoes.SeqOrdem <> 0 then
    GFracaoOP.Cells[2,GFracaoOP.ALinha]:= IntToStr(VprDOrcamentoFracoes.SeqOrdem)
  else
    GFracaoOP.Cells[2,GFracaoOP.ALinha]:= '';
  if VprDOrcamentoFracoes.SeqFracao <> 0 then
    GFracaoOP.Cells[3,GFracaoOP.ALinha]:= IntToStr(VprDOrcamentoFracoes.SeqFracao)
  else
    GFracaoOP.Cells[3,GFracaoOP.ALinha]:= '';
  GFracaoOP.Cells[4,GFracaoOP.ALinha]:= VprDOrcamentoFracoes.NomCliente;
end;

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.GFracaoOPDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos:= True;
  if GFracaoOP.Cells[1,GFracaoOP.ALinha] = '' then
  begin
    aviso('FILIAL NÃO PREENCHIDA!!!'#13'É necessário digitar a filial.');
    VpaValidos:= False;
    GFracaoOP.Col:= 1;
  end
  else
    if GFracaoOP.Cells[2,GFracaoOP.ALinha] = '' then
    begin
      aviso('ORDEM DE PRODUÇÃO NÃO PREENCHIDA!!!'#13'É necessário digitar a ordem de produção.');
      VpaValidos:= False;
      GFracaoOP.Col:= 2;
    end;
  if VpaValidos then
  begin
    if GFracaoOP.Cells[3,GFracaoOP.ALinha] <> '' then
    // verificar se é diferente de '' para não dar erro na conversão
      if StrToInt(GFracaoOP.Cells[3,GFracaoOP.ALinha]) = 0 then
      // checar aqui para ele não fazer a rotina ExisteFracao, pesquizando SEQFRACAO com 0
      begin
        GFracaoOP.Cells[3,GFracaoOP.ALinha]:= '';
        GFracaoOP.Col:= 3;
      end;

    if not ExisteFracao then
    begin
      aviso('FRAÇÃO NÃO CADASTRADA!!!'#13'Informe uma fração que esteja cadastrada.');
      VpaValidos:= False;
      GFracaoOP.Col:= 1;
    end;
  end;
  if VpaValidos then
  begin
    CarDClasseOP;
    if FracaoOPJaUsada then
    begin
      aviso('FRACAO OP JÁ UTILIZADA!!!'#13'Informe uma fração op que ainda não esteja em uso.');
      VpaValidos:= False;
      GFracaoOP.Col:= 1;
    end;

    if StrToInt(GFracaoOP.Cells[1,GFracaoOP.ALinha]) = 0 then
    begin
      GFracaoOP.Cells[1,GFracaoOP.ALinha]:= '';
      GFracaoOP.Col:= 1;
    end
    else
      if StrToInt(GFracaoOP.Cells[2,GFracaoOP.ALinha]) = 0 then
      begin
        GFracaoOP.Cells[2,GFracaoOP.ALinha]:= '';
        GFracaoOP.Col:= 2;
      end;
  end;
end;

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.CarDClasseOP;
begin
  if GFracaoOP.Cells[1,GFracaoOP.ALinha] <> '' then
    VprDOrcamentoFracoes.CodFilialFracao:= StrToInt(GFracaoOP.Cells[1,GFracaoOP.ALinha])
  else
    VprDOrcamentoFracoes.CodFilialFracao:= 0;
  if GFracaoOP.Cells[2,GFracaoOP.ALinha] <> '' then
    VprDOrcamentoFracoes.SeqOrdem:= StrToInt(GFracaoOP.Cells[2,GFracaoOP.ALinha])
  else
    VprDOrcamentoFracoes.SeqOrdem:= 0;
  if GFracaoOP.Cells[3,GFracaoOP.ALinha] <> '' then
    VprDOrcamentoFracoes.SeqFracao:= StrToInt(GFracaoOP.Cells[3,GFracaoOP.ALinha])
  else
    VprDOrcamentoFracoes.SeqFracao:= 0;
end;

{******************************************************************************}
function TFNovaSolicitacaoCompras.ExisteFracao: Boolean;
begin
  Result:= False;
  if (GFracaoOP.Cells[1,GFracaoOP.ALinha] <> '') and
     (GFracaoOP.Cells[2,GFracaoOP.ALinha] <> '') and
     (GFracaoOP.Cells[3,GFracaoOP.ALinha] <> '') then
    Result:= FunPedidoCompra.ExisteFracaoOP(StrToInt(GFracaoOP.Cells[1,GFracaoOP.ALinha]),
                                            StrToInt(GFracaoOP.Cells[2,GFracaoOP.ALinha]),
                                            StrToInt(GFracaoOP.Cells[3,GFracaoOP.ALinha]))
  else {para verificar apenas pela op}
    if (GFracaoOP.Cells[1,GFracaoOP.ALinha] <> '') and
       (GFracaoOP.Cells[2,GFracaoOP.ALinha] <> '') then
      Result:= FunPedidoCompra.ExisteOP(StrToInt(GFracaoOP.Cells[1,GFracaoOP.ALinha]),
                                        StrToInt(GFracaoOP.Cells[2,GFracaoOP.ALinha]));
end;

{******************************************************************************}
function TFNovaSolicitacaoCompras.FracaoOPJaUsada: Boolean;
var
  VpfLaco: Integer;
  VpfOrcamentoFracaoOP: TRBDSolicitacaoCompraFracaoOP;
begin
  Result:= False;
  for VpfLaco:= 0 to VprDOrcamentoCorpo.Fracoes.Count - 1 do
  begin
    if VpfLaco+1 <> GFracaoOP.ALinha then // diferente da linha que estou modificando
    begin
      VpfOrcamentoFracaoOP:= TRBDSolicitacaoCompraFracaoOP(VprDOrcamentoCorpo.Fracoes[VpfLaco]);
      if (VpfOrcamentoFracaoOP.CodFilialFracao = VprDOrcamentoFracoes.CodFilialFracao) and
         (VpfOrcamentoFracaoOP.SeqOrdem = VprDOrcamentoFracoes.SeqOrdem) and
         (VpfOrcamentoFracaoOP.SeqFracao = VprDOrcamentoFracoes.SeqFracao) then
      begin
        Result:= True;
        Break;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.GFracaoOPGetEditMask(Sender: TObject;
  ACol, ARow: Integer; var Value: String);
begin
  case ACol of
    1,2,3: Value:= '000000;0; ';
  end;
end;

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.GFracaoOPMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDOrcamentoCorpo.Fracoes.Count > 0 then
    VprDOrcamentoFracoes:= TRBDSolicitacaoCompraFracaoOP(VprDOrcamentoCorpo.Fracoes.Items[VpaLinhaAtual-1]);
end;

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.GFracaoOPNovaLinha(Sender: TObject);
begin
  VprDOrcamentoFracoes:= VprDOrcamentoCorpo.AddFracaoOP;
end;

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.BGravarClick(Sender: TObject);
var
  VpfResultado: String;
begin
  CarDClasseCorpo;
  VpfResultado:= FunOrcamentoCompra.GravaDOrcamentoCompra(VprDOrcamentoCorpo);
  if VpfResultado <> '' then
    aviso(VpfResultado)
  else
  begin
    ENumero.AInteiro:= VprDOrcamentoCorpo.SeqSolicitacao;
    BloquearTela(True);
    VprAcao:= True;
    if VprProposta then
    begin
      VpfResultado := FunOrcamentoCompra.AssociaOrcamentoCompraProposta(VprDProposta,VprDOrcamentoCorpo);
      if VpfResultado <> '' then
        aviso(VpfResultado)
      else
        close;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.CalculaKilosChapa;
begin
  if (GProdutos.Cells[5,GProdutos.ALinha] <> '') and
     (GProdutos.Cells[6,GProdutos.ALinha] <> '') and
     (GProdutos.Cells[7,GProdutos.ALinha] <> '') then
  begin
    CarDChapaClasse;
    VprDOrcamentoItens.QtdProduto := FunProdutos.RQuilosChapa(VprDOrcamentoItens.EspessuraAco,VprDOrcamentoItens.LarChapa,VprDOrcamentoItens.ComChapa,
                                                          VprDOrcamentoItens.QtdChapa,VprDOrcamentoItens.DensidadeVolumetricaAco );
    if VprDOrcamentoItens.QtdProduto <> 0 then
      GProdutos.Cells[9,GProdutos.ALinha]:= FormatFloat(Varia.MascaraQtd,VprDOrcamentoItens.QtdProduto)
    else
      GProdutos.Cells[9,GProdutos.ALinha]:= '';
  end;

end;

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.CarDChapaClasse;
begin
  if GProdutos.Cells[5,GProdutos.ALinha] <> '' then
    VprDOrcamentoItens.QtdChapa := StrToFloat(DeletaChars(GProdutos.Cells[5,GProdutos.ALinha],'.'))
  else
    VprDOrcamentoItens.QtdChapa:= 0;
  if GProdutos.Cells[6,GProdutos.ALinha] <> '' then
    VprDOrcamentoItens.LarChapa := StrToFloat(DeletaChars(GProdutos.Cells[6,GProdutos.ALinha],'.'))
  else
    VprDOrcamentoItens.LarChapa:= 0;
  if GProdutos.Cells[7,GProdutos.ALinha] <> '' then
    VprDOrcamentoItens.ComChapa := StrToFloat(DeletaChars(GProdutos.Cells[7,GProdutos.ALinha],'.'))
  else
    VprDOrcamentoItens.ComChapa:= 0;
end;

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.CarDClasseCorpo;
begin
  VprDOrcamentoCorpo.CodFilial:= EFilial.AInteiro;
  VprDOrcamentoCorpo.CodUsuario:= EUsuario.AInteiro;
  VprDOrcamentoCorpo.CodComprador:= EComprador.AInteiro;
  VprDOrcamentoCorpo.DesObservacao:= EObservacoes.Text;
  VprDOrcamentoCorpo.DatEmissao:= StrToDate(EData.Text);
  VprDOrcamentoCorpo.HorEmissao:= StrToTime(EHora.Text);
  try
    if DeletaEspaco(DeletaChars(EPrazo.Text,'/')) = '' then
      VprDOrcamentoCorpo.DatPrevista:= montaData(1,1,1900)
    else
      VprDOrcamentoCorpo.DatPrevista:= StrToDate(EPrazo.Text);
  except
    aviso('PRAZO DE ENTREGA INVÁLIDA!!!'#13'Informe o prazo de entrega corretamente.');
    ActiveControl:= EPrazo;
    Abort;
  end;
  try
    if DeletaEspaco(DeletaChars(EDataFim.Text,'/')) = '' then
      VprDOrcamentoCorpo.DatFim:= MontaData(1,1,1900)
    else
      VprDOrcamentoCorpo.DatFim:= StrToDate(EDataFim.Text);
  except
    aviso('DATA FINAL INVÁLIDA!!!'#13'Informe a data final corretamente.');
    ActiveControl:= EPrazo;
    Abort;
  end;
end;

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.BCadastrarClick(Sender: TObject);
begin
  VprOperacao:= ocInsercao;
  InicializaTela;
  ValidaGravacao.execute;
end;

{******************************************************************************}
function TFNovaSolicitacaoCompras.Apagar(VpaCodFilial,VpaSeqSolicitacao: Integer): Boolean;
begin
  Result:= False;
  VprOperacao:= ocConsulta;
  FunOrcamentoCompra.CarDOrcamentoCompra(VpaCodFilial,VpaSeqSolicitacao,VprDOrcamentoCorpo);
  CarDTela;

  Show;
  if Confirmacao('Deseja excluir o orcamento de compra número '+IntToStr(VprDOrcamentoCorpo.SeqSolicitacao)+'?') then
  begin
    FunOrcamentoCompra.ApagaOrcamento(VprDOrcamentoCorpo);
    Result:= True;
  end;
end;

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.CarDTela;
begin
  ENumero.AInteiro:= VprDOrcamentoCorpo.SeqSolicitacao;
  EData.Text:= FormatDateTime('DD/MM/YYYY',VprDOrcamentoCorpo.DatEmissao);
  EHora.Text:= FormatDateTime('HH:MM',VprDOrcamentoCorpo.HorEmissao);
  EFilial.AInteiro:= VprDOrcamentoCorpo.CodFilial;
  EUsuario.AInteiro:= VprDOrcamentoCorpo.CodUsuario;
  EComprador.AInteiro:= VprDOrcamentoCorpo.CodComprador;
  if VprDOrcamentoCorpo.DatPrevista > MontaData(1,1,1900) then
    EPrazo.Text:= FormatDateTime('DD/MM/YYYY',VprDOrcamentoCorpo.DatPrevista)
  else
    EPrazo.Clear;
  if VprDOrcamentoCorpo.DatFim > MontaData(1,1,1900) then
    EDataFim.Text:= FormatDateTime('DD/MM/YYYY',VprDOrcamentoCorpo.DatFim)
  else
    EDataFim.Clear;

  EObservacoes.Text:= VprDOrcamentoCorpo.DesObservacao;

  InicializaGrade;

  AtualizaLocalizas(ScrollBox1);
end;

{******************************************************************************}
function TFNovaSolicitacaoCompras.Consultar(VpaCodFilial, VpaSeqSolicitacao: Integer): Boolean;
begin
  VprOperacao:= ocConsulta;
  FunOrcamentoCompra.CarDOrcamentoCompra(VpaCodFilial,VpaSeqSolicitacao,VprDOrcamentoCorpo);
  CarDTela;
  BloquearTela(True);
  ShowModal;
  Result:= VprAcao;
end;

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.BloquearTela(VpaEstado: Boolean);
begin
  AlteraReadOnlyDet(ScrollBox1,0,VpaEstado);

  GProdutos.APermiteExcluir:= not VpaEstado;
  GProdutos.APermiteInserir:= not VpaEstado;
  GFracaoOP.APermiteExcluir:= not VpaEstado;
  GFracaoOP.APermiteInserir:= not VpaEstado;

  EstadoBotoes(VpaEstado);
end;

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  VpfSeqProduto, VpfCodProduto, VpfNomProduto, VpfPath, VpfKit, VpfCifrao: String;
begin
  if Key = VK_F4 then
    if (ActiveControl = GProdutos) or (ActiveControl = GFracaoOP) then
      ActiveControl:= EObservacoes;
  if Key = VK_F6 then
  begin
    if ExisteProduto then
    begin
      FNovoProdutoPro := TFNovoProdutoPro.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoProdutoPro'));
      if FNovoProdutoPro.AlterarProduto(varia.codigoEmpresa,varia.CodigoEmpFil,VprDOrcamentoItens.SeqProduto) <> nil then
      begin
        VprProdutoAnterior:= '';
        ExisteProduto;
      end;
      FNovoProdutoPro.free;
    end
    else
    begin
      aviso('PRODUTO NÃO PRENCHIDO!!!'#13'Informe um produto para alterar.');
      ActiveControl:= GProdutos;
    end;
  end;
end;

{******************************************************************************}
function TFNovaSolicitacaoCompras.Alterar(VpaCodFilial, VpaSeqSolicitacao: Integer): Boolean;
begin
  VprOperacao:= ocEdicao;
  FunOrcamentoCompra.CarDOrcamentoCompra(VpaCodFilial,VpaSeqSolicitacao,VprDOrcamentoCorpo);
  CarDTela;

  GProdutos.ColWidths[10] := 110;
  GProdutos.TabStops[10] := true;

  EstadoBotoes(False);
  AtualizaLocalizas(PCabecalhoInicial);
  ShowModal;
  Result:= VprAcao;
end;

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.PosEstagios;
begin
  if ENumero.AInteiro <> 0 then
    AdicionaSQLAbreTabela(ESTAGIOS,
                          'SELECT ESC.DATESTAGIO, ESC.DESMOTIVO, EST.NOMEST, USU.C_NOM_USU'+
                          ' FROM ESTAGIOSOLICITACAOCOMPRA ESC, ESTAGIOPRODUCAO EST, CADUSUARIOS USU'+
                          ' WHERE EST.CODEST = ESC.CODESTAGIO'+
                          ' AND USU.I_COD_USU = ESC.CODUSUARIO'+
                          ' AND ESC.SEQSOLICITACAO = '+ENumero.Text+
                          ' ORDER BY ESC.SEQESTAGIO');
end;

{******************************************************************************}
function TFNovaSolicitacaoCompras.RetornaNomeArquivoProjeto(
  VpaDOrcamentoItem: TRBDOrcamentoCompraProduto): string;
begin

end;

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.CarregaProdutosBaixa(VpaCodFilial,VpaSeqOrdem, VpaSeqFracao : Integer;VpaProdutos : TList);
begin
  VprDOrcamentoCorpo.Produtos := VpaProdutos;
  GProdutos.ADados := VpaProdutos;
  GProdutos.CarregaGrade;


  VprDOrcamentoFracoes := VprDOrcamentoCorpo.AddFracaoOP;
  VprDOrcamentoFracoes.CodFilialFracao := VpaCodFilial;
  VprDOrcamentoFracoes.SeqOrdem := VpaSeqOrdem;
  VprDOrcamentoFracoes.SeqFracao := VpaSeqFracao;

  GFracaoOP.CarregaGrade;
end;

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.CarregaProdutosChamado(VpaDChamado: TRBDChamado);
var
  VpfLacoExterno, VpfLacoInterno : Integer;
  VpfDProdutoChamado : TRBDChamadoProduto;
  VpfDProdutoOrcadoChamado : TRBDChamadoProdutoOrcado;
begin
  for VpfLacoExterno := 0 to VpaDChamado.Produtos.Count - 1 do
  begin
    VpfDProdutoChamado := TRBDChamadoProduto(VpaDChamado.Produtos.Items[VpfLacoExterno]);
    for VpfLacoInterno := 0 to VpfDProdutoChamado.ProdutosOrcados.Count - 1 do
    begin
      VpfDProdutoOrcadoChamado:= TRBDChamadoProdutoOrcado(VpfDProdutoChamado.ProdutosOrcados.Items[VpfLacoInterno]);
      VprDOrcamentoItens := VprDOrcamentoCorpo.AddProduto;
      FunProdutos.ExisteProduto(VpfDProdutoOrcadoChamado.CodProduto,VprDOrcamentoItens);
      VprDOrcamentoItens.SeqProduto := VpfDProdutoOrcadoChamado.SeqProduto;
      VprDOrcamentoItens.CodProduto := VpfDProdutoOrcadoChamado.CodProduto;
      VprDOrcamentoItens.desum := VpfDProdutoOrcadoChamado.DesUM;
      VprDOrcamentoItens.IndComprado := false;
      VprDOrcamentoItens.QtdProduto := VpfDProdutoOrcadoChamado.Quantidade;
      VprDOrcamentoItens.QtdAprovado := VpfDProdutoOrcadoChamado.Quantidade;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.CarregaProdutosPontoPedido(VpaSelect: TSql);
var
  VpfLacoExterno, VpfLacoInterno : Integer;
  VpfDProdutoChamado : TRBDChamadoProduto;
  VpfDProdutoOrcadoChamado : TRBDChamadoProdutoOrcado;
begin
  VpaSelect.First;
  while not VpaSelect.Eof do
  begin
    VprDOrcamentoItens := VprDOrcamentoCorpo.AddProduto;
    FunProdutos.ExisteProduto(VpaSelect.FieldByName('C_COD_PRO').AsString,VprDOrcamentoItens);
    VprDOrcamentoItens.SeqProduto := VpaSelect.FieldByName('I_SEQ_PRO').AsInteger;
    VprDOrcamentoItens.CodProduto := VpaSelect.FieldByName('C_COD_PRO').AsString;
    VprDOrcamentoItens.desum := VpaSelect.FieldByName('C_COD_UNI').AsString;
    VprDOrcamentoItens.IndComprado := false;
    VprDOrcamentoItens.QtdProduto := VpaSelect.FieldByName('N_QTD_PED').AsFloat - VpaSelect.FieldByName('N_QTD_PRO').AsFloat;
    VprDOrcamentoItens.QtdAprovado := VpaSelect.FieldByName('N_QTD_PED').AsFloat - VpaSelect.FieldByName('N_QTD_PRO').AsFloat;
    VprDOrcamentoItens.CodCor:= VpaSelect.FieldByName('COD_COR').AsInteger;
    VprDOrcamentoItens.NomCor:= VpaSelect.FieldByName('NOM_COR').AsString;
    VpaSelect.Next;
  end;
end;

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.CarregaProdutosPorposta(VpaDProposta : TRBDPropostaCorpo);
var
  VpfLaco : Integer;
  VpfDProdutoProposta : TRBDPropostaProduto;
begin
  for VpfLaco := 0 to VpaDProposta.Produtos.Count - 1 do
  begin
    VpfDProdutoProposta := TRBDPropostaProduto(VpaDProposta.Produtos.Items[VpfLaco]);
    VprDOrcamentoItens := VprDOrcamentoCorpo.AddProduto;
    VprDOrcamentoItens.SeqProduto := VpfDProdutoProposta.SeqProduto;
    VprDOrcamentoItens.CodCor := VpfDProdutoProposta.CodCor;
    VprDOrcamentoItens.CodProduto := VpfDProdutoProposta.CodProduto;
    VprDOrcamentoItens.NomProduto := VpfDProdutoProposta.NomProduto;
    VprDOrcamentoItens.NomCor := VpfDProdutoProposta.DesCor;
    VprDOrcamentoItens.DesUM := VpfDProdutoProposta.UM;
    VprDOrcamentoItens.UMOriginal := VpfDProdutoProposta.UM;
    VprDOrcamentoItens.IndComprado := false;
    VprDOrcamentoItens.UnidadesParentes := FunProdutos.RUnidadesParentes(VpfDProdutoProposta.UM);
    VprDOrcamentoItens.QtdProduto := VpfDProdutoProposta.QtdProduto;
    VprDOrcamentoItens.QtdAprovado := VpfDProdutoProposta.QtdProduto;
  end;
end;

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.CarregaProdutosOrdemProducao(VpaCodFilial,VpaSeqOrdem : Integer);
var
  VpfDOrdemProducao : TRBDordemProducao;
  VpfLaco : Integer;
  VpfDFracao : TRBDFracaoOrdemProducao;
begin
  VpfDOrdemProducao := TRBDOrdemProducao.cria;
  VpfDOrdemProducao.CodEmpresafilial := VpaCodFilial;
  VpfDOrdemProducao.SeqOrdem := VpaSeqOrdem;
  FunOrdemProducao.CarDFracaoOp(VpfDOrdemProducao,VpaCodFilial,VpaSeqOrdem,0);
  for VpfLaco := 0 to VpfDOrdemProducao.Fracoes.Count - 1 do
  begin
    VpfDFracao := TRBDFracaoOrdemProducao(VpfDOrdemProducao.Fracoes.Items[VpfLaco]);
    if not VpfDFracao.IndConsumoBaixado then
    begin
      FunProdutos.CarDBaixaConsumoProduto(VpaCodFilial,VpaSeqOrdem,VpfDFracao.SeqFracao,true,VpfDFracao.Consumo);
      AdicionaProdutosConsumoFracao(VpfDFracao);
      FunProdutos.CarDBaixaConsumoProduto(VpaCodFilial,VpaSeqOrdem,VpfDFracao.SeqFracao,false,VpfDFracao.Consumo);
      AdicionaProdutosConsumoFracao(VpfDFracao);
    end;
  end;

  VpfDOrdemProducao.free;
end;

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.AdicionaProdutosConsumoFracao(VpaDFracao : TRBDFracaoOrdemProducao);
var
  VpfLaco : Integer;
  VpfDConsumo : TRBDConsumoFracaoOP;
begin
  for VpfLaco := 0 to VpaDFracao.Consumo.Count - 1 do
  begin
    VpfDConsumo := TRBDConsumoFracaoOP(VpaDFracao.Consumo.Items[VpfLaco]);
    if not VpfDConsumo.IndOrigemCorte and not VpfDConsumo.IndBaixado then
    begin
      if ((VpfDConsumo.QtdProduto - VpfDConsumo.QtdBaixado)> VpfDConsumo.QtdReservado) then
      begin
        VprDOrcamentoItens := VprDOrcamentoCorpo.AddProduto;
{        VprDOrcamentoItens.SeqProduto := VpfDProdutoProposta.SeqProduto;
        VprDOrcamentoItens.CodCor := VpfDProdutoProposta.CodCor;
        VprDOrcamentoItens.CodProduto := VpfDProdutoProposta.CodProduto;
        VprDOrcamentoItens.NomProduto := VpfDProdutoProposta.NomProduto;
        VprDOrcamentoItens.NomCor := VpfDProdutoProposta.DesCor;
        VprDOrcamentoItens.DesUM := VpfDProdutoProposta.UM;
        VprDOrcamentoItens.UMOriginal := VpfDProdutoProposta.UM;
        VprDOrcamentoItens.IndComprado := false;
        VprDOrcamentoItens.UnidadesParentes := FunProdutos.RUnidadesParentes(VpfDProdutoProposta.UM);
        VprDOrcamentoItens.QtdProduto := VpfDProdutoProposta.QtdProduto;
        VprDOrcamentoItens.QtdAprovado := VpfDProdutoProposta.QtdProduto;}
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.PaginasChange(Sender: TObject);
begin
  if Paginas.ActivePage = PEstagios then
    PosEstagios;
end;

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.GFracaoOPSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if GFracaoOP.AEstadoGrade in [egInsercao, egEdicao] then
  begin
    case GFracaoOP.AColuna of
      2: begin
           if ExisteClienteFracaoOP then
           begin
             GFracaoOP.Cells[4,GFracaoOP.ALinha]:= VprDOrcamentoFracoes.NomCliente;
           end;
         end;
    end;
  end;
end;

{******************************************************************************}
function TFNovaSolicitacaoCompras.ExisteClienteFracaoOP: Boolean;
begin
  Result:= False;
  if GFracaoOP.Cells[1,GFracaoOP.ALinha] <> '' then
    VprDOrcamentoFracoes.CodFilialFracao:= StrToInt(GFracaoOP.Cells[1,GFracaoOP.ALinha])
  else
    VprDOrcamentoFracoes.CodFilialFracao:= 0;
  if GFracaoOP.Cells[2,GFracaoOP.ALinha] <> '' then
    VprDOrcamentoFracoes.SeqOrdem:= StrToInt(GFracaoOP.Cells[2,GFracaoOP.ALinha])
  else
    VprDOrcamentoFracoes.SeqOrdem:= 0;
  Result:= FunOrcamentoCompra.ExisteClienteFracaoOP(VprDOrcamentoFracoes);
end;

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.BImprimirClick(Sender: TObject);
begin
  if VprDOrcamentoCorpo.CodFilial <> 0 then
  begin
    dtRave := TdtRave.create(self);
    dtRave.ImprimeSolicitacaoCompra(VprDOrcamentoCorpo.CodFilial,VprDOrcamentoCorpo.SeqSolicitacao,false);
    dtRave.free;
  end;
end;

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.ECompradorChange(Sender: TObject);
begin
  if VprOperacao in [ocInsercao, ocEdicao] then
    ValidaGravacao.execute;
end;

{******************************************************************************}
procedure TFNovaSolicitacaoCompras.ECompradorCadastrar(Sender: TObject);
begin
  FCompradores:= TFCompradores.CriarSDI(Application,'',True);
  FCompradores.ShowModal;
  FCompradores.Free;
  Localiza.AtualizaConsulta;
end;

procedure TFNovaSolicitacaoCompras.ECorCadastrar(Sender: TObject);
begin
  FCores := TFCores.CriarSDI(self,'',FPrincipal.VerificaPermisao('FCores'));
  FCores.BotaoCadastrar1.click;
  FCores.showmodal;
  FCores.free;
  Localiza.AtualizaConsulta;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
  RegisterClasses([TFNovaSolicitacaoCompras]);
end.
