unit ANovoOrcamentoCompra;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Localizacao, Mask, StdCtrls,
  Buttons, ComCtrls, Grids, CGrades, UnDadosProduto, Constantes, UnDados, UnOrcamentoCompra,
  DBKeyViolation, numericos, APedidoCompra, UnPedidoCompra;

type
  TFNovoOrcamentoCompra = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Paginas: TPageControl;
    PGeral: TTabSheet;
    PAdiciona: TTabSheet;
    PanelColor3: TPanelColor;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    LFilial: TLabel;
    BCondicoesPgto: TSpeedButton;
    LCondicoesPagto: TLabel;
    BFormaPagto: TSpeedButton;
    LFormaPagamento: TLabel;
    Label3: TLabel;
    LUsuario: TLabel;
    Bevel1: TBevel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Label14: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    SpeedButton3: TSpeedButton;
    LDataRenegociado: TLabel;
    ENumero: TEditColor;
    EData: TMaskEditColor;
    ECondicoesPagto: TEditLocaliza;
    EFormaPagto: TEditLocaliza;
    EHora: TMaskEditColor;
    EFilial: TEditLocaliza;
    EUsuario: TEditLocaliza;
    EFilialFaturamento: TEditLocaliza;
    EDatPrevista: TMaskEditColor;
    PanelColor4: TPanelColor;
    Label6: TLabel;
    BFornecedor: TSpeedButton;
    LFornecedor: TLabel;
    Label7: TLabel;
    Label15: TLabel;
    Label21: TLabel;
    EFornecedor: TEditLocaliza;
    EContato: TEditColor;
    EEmailComprador: TEditColor;
    ETelefone: TEditColor;
    Grade: TRBStringGridColor;
    PanelColor5: TPanelColor;
    BCadastrar: TBitBtn;
    BImprimir: TBitBtn;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    BFechar: TBitBtn;
    Label19: TLabel;
    SpeedButton4: TSpeedButton;
    Label20: TLabel;
    EComprador: TEditLocaliza;
    PanelColor6: TPanelColor;
    PanelColor7: TPanelColor;
    GNaoAdicionados: TRBStringGridColor;
    PanelColor8: TPanelColor;
    PanelColor9: TPanelColor;
    GAdicionados: TRBStringGridColor;
    PanelColor10: TPanelColor;
    Label10: TLabel;
    Adicionar: TBitBtn;
    BRemover: TBitBtn;
    Label11: TLabel;
    ECliente: TEditLocaliza;
    Localiza: TConsultaPadrao;
    BTodos: TBitBtn;
    ValidaGravacao1: TValidaGravacao;
    ECor: TEditLocaliza;
    BEnviar: TBitBtn;
    BExcluir: TBitBtn;
    EvalFrete: Tnumerico;
    Label12: TLabel;
    CEnviarArquivoProjeto: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rcam(Sender: TObject; VpaLinha: Integer);
    procedure PaginasChange(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure ECompradorChange(Sender: TObject);
    procedure GradeDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure GradeGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GradeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ECorRetorno(Retorno1, Retorno2: String);
    procedure GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GradeNovaLinha(Sender: TObject);
    procedure GradeSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure GAdicionadosCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure BEnviarClick(Sender: TObject);
    procedure BExcluirClick(Sender: TObject);
    procedure BRemoverClick(Sender: TObject);
    procedure GNaoAdicionadosCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure AdicionarClick(Sender: TObject);
    procedure GradeDepoisExclusao(Sender: TObject);
    procedure GAdicionadosDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure PanelColor4Click(Sender: TObject);
    procedure BTodosClick(Sender: TObject);
    procedure rbdtCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
  private
    { Private declarations }
    VprAcao,
    VprIndSolicitacaoCompra : Boolean;
    VprProdutoAnterior,
    VprCorAnterior : string;
    VprDOrcamento : TRBDOrcamentoCompraCorpo;
    VprDProdutoOrcamento,
    VprDProFornecedorOrc,
    VprDProNaoAdicionadoFornecedorOrc : TRBDOrcamentoCompraProduto;
    VprDFornecedorOrcamento : TRBDOrcamentoCompraFornecedor;
    VprProdutosPendentes,
    VprProdutosFinalizados : TList;
    VprOperacao : TRBDOperacaoCadastro;
    FunOrcamentoCompra : TRBFuncoesOrcamentoCompra;
    FunPedidoCompra : TRBFunPedidoCompra;
    procedure ConfiguraPermissaoUsuario;
    procedure CarTitulosGrade;
    procedure CarTituloGradeProduto(VpaGrade :TRBStringGridColor);
    procedure InicializaTela;
    procedure CarDClasse;
    procedure CarDClasseProdutos;
    procedure CarDTela;
    procedure CarDFornecedoresTela;
    procedure CarDFornecedoresClasse;
    function ExisteProduto: Boolean;
    function LocalizaProduto: Boolean;
    function ExisteCor : Boolean;
    function ExisteFornedorDuplicado(VpaCodFornecedor : Integer):Boolean;
    procedure EstadoBotoes(VpaSituacao : Boolean);
    procedure CarDProdutoSolicitacaoTela(VpaProdutos: TList);
    procedure CarDFracoesOrcamento(VpaFracoes : Tlist);
    procedure AdicionaFornecedor;
    procedure BloquearTela;
    procedure CalculaKilosChapa;
    procedure CarDChapaClasse;
    procedure DadosValidosProduto(Sender:TObject;Var VpaValidos :Boolean);
  public
    { Public declarations }
    function NovoOrcamento:Boolean;
    function NovoOrcamentoProdutosPendentes(VpaProdutos, VpaFracoesOP, VpaProdutosPendentes, VpaProdutosFinalizados: TList): Boolean;
    function Alterar(VpaCodFilial, VpaSeqOrcamento: Integer): Boolean;
    procedure Consultar(VpaCodFilial, VpaSeqOrcamento: Integer);
  end;

var
  FNovoOrcamentoCompra: TFNovoOrcamentoCompra;

implementation

uses APrincipal, unProdutos, FunObjeto, UnClientes, FunData, ConstMsg, FunString, FunNumeros,
  ALocalizaProdutos, UnCrystal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovoOrcamentoCompra.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunOrcamentoCompra := TRBFuncoesOrcamentoCompra.cria(FPrincipal.BaseDados);
  FunPedidoCompra:= TRBFunPedidoCompra.Cria(FPrincipal.BaseDados);
  ConfiguraPermissaoUsuario;
  Paginas.ActivePage := PGeral;
  VprIndSolicitacaoCompra := false;
  VprAcao := false;
  CarTitulosGrade;
  VprDOrcamento := TRBDOrcamentoCompraCorpo.cria;
  Grade.ADados := VprDOrcamento.Produtos;
  Grade.CarregaGrade;
  CEnviarArquivoProjeto.Checked:= Config.PedidoCompraAnexarArquivoProjetoAutomaticamente;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovoOrcamentoCompra.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunOrcamentoCompra.free;
  FunPedidoCompra.Free;
  VprDOrcamento.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFNovoOrcamentoCompra.ConfiguraPermissaoUsuario;
begin
  if not config.EstoquePorCor then
  begin
    Grade.ColWidths[3] := -1;
    Grade.ColWidths[4] := -1;
    Grade.ColWidths[2] := RetornaInteiro(Grade.ColWidths[2] *1.9);
  end;
  if not config.ControlarEstoquedeChapas then
  begin
    Grade.ColWidths[5] := -1;
    Grade.ColWidths[6] := -1;
    Grade.ColWidths[7] := -1;
  end;
end;

{******************************************************************************}
procedure TFNovoOrcamentoCompra.CarTitulosGrade;
begin
  Grade.cells[1,0] := 'Código';
  Grade.cells[2,0] := 'Produto';
  Grade.cells[3,0] := 'Código';
  Grade.cells[4,0] := 'Cor';
  Grade.cells[5,0] := 'Qtd Chapa';
  Grade.cells[6,0] := 'Largura';
  Grade.cells[7,0] := 'Comprimento';
  Grade.cells[8,0] := 'UM';
  Grade.cells[9,0] := 'Qtd Solicitada';
  Grade.cells[10,0] := 'Qtd Orçamento';
  Grade.cells[11,0] := 'Arquivo Projeto';
  if not Config.PedidoCompraAnexarArquivoProjetoAutomaticamente then
    Grade.ColWidths[11]:=0;
end;

{******************************************************************************}
procedure TFNovoOrcamentoCompra.CarTituloGradeProduto(VpaGrade :TRBStringGridColor);
begin
  VpaGrade.Cells[1,0] := 'Código';
  VpaGrade.cells[2,0] := 'Produto';
  VpaGrade.cells[3,0] := 'Código';
  VpaGrade.cells[4,0] := 'Cor';
  VpaGrade.cells[5,0] := 'Qtd Chapa';
  VpaGrade.cells[6,0] := 'Largura';
  VpaGrade.cells[7,0] := 'Comprimento';
  VpaGrade.cells[8,0] := 'UM';
  VpaGrade.cells[9,0] := 'Qtd Orçado';
  VpaGrade.cells[10,0] := 'Val Unitario';
  VpaGrade.cells[11,0] := '%ICMS';
  VpaGrade.cells[12,0] := '%IPI';
  VpaGrade.cells[13,0] := 'Val Total';
  if not config.EstoquePorCor then
  begin
    VpaGrade.ColWidths[3] := -1;
    VpaGrade.ColWidths[4] := -1;
  end;
  if not config.ControlarEstoquedeChapas then
  begin
    VpaGrade.ColWidths[5] := -1;
    VpaGrade.ColWidths[6] := -1;
    VpaGrade.ColWidths[7] := -1;
  end;
end;

{******************************************************************************}
procedure TFNovoOrcamentoCompra.InicializaTela;
begin
  VprDOrcamento.free;
  VprDOrcamento := TRBDOrcamentoCompraCorpo.cria;
  Grade.ADados := VprDOrcamento.Produtos;
  Grade.CarregaGrade;
  VprDOrcamento.CodFilialFaturamento := varia.CodFilialFaturamentoCompras;
  VprDOrcamento.CodUsuario := Varia.CodigoUsuario;
  VprDOrcamento.CodFilial := varia.CodigoEmpFil;
  VprDOrcamento.CodEstagio := varia.EstagioInicialOrcamentoCompra;
  VprDOrcamento.CodComprador := varia.CodComprador;
  VprDOrcamento.DatOrcamento := date;
  VprDOrcamento.HorOrcamento := now;
  VprDOrcamento.DatPrevista := incdia(date,1);
  CEnviarArquivoProjeto.Checked:= Config.PedidoCompraAnexarArquivoProjetoAutomaticamente;
  CarDTela;
end;

{******************************************************************************}
procedure TFNovoOrcamentoCompra.CalculaKilosChapa;
begin
  if (Grade.Cells[5,Grade.ALinha] <> '') and
     (Grade.Cells[6,Grade.ALinha] <> '') and
     (Grade.Cells[7,Grade.ALinha] <> '') then
  begin
    CarDChapaClasse;
    VprDprodutoOrcamento.QtdProduto := FunProdutos.RQuilosChapa(VprDprodutoOrcamento.EspessuraAco,VprDprodutoOrcamento.LarChapa,VprDprodutoOrcamento.ComChapa,
                                                          VprDprodutoOrcamento.QtdChapa,VprDprodutoOrcamento.DensidadeVolumetricaAco );
    VprDprodutoOrcamento.QtdSolicitada := VprDProdutoOrcamento.QtdProduto;
    if VprDprodutoOrcamento.QtdProduto <> 0 then
      Grade.Cells[9,Grade.ALinha]:= FormatFloat(Varia.MascaraQtd,VprDprodutoOrcamento.QtdProduto)
    else
      Grade.Cells[9,Grade.ALinha]:= '';
    if VprDprodutoOrcamento.QtdSolicitada <> 0 then
      Grade.Cells[10,Grade.ALinha]:= FormatFloat(Varia.MascaraQtd,VprDprodutoOrcamento.QtdSolicitada)
    else
      Grade.Cells[10,Grade.ALinha]:= '';
  end;
end;

{******************************************************************************}
procedure TFNovoOrcamentoCompra.CarDChapaClasse;
begin
  if Grade.Cells[5,Grade.ALinha] <> '' then
    VprDProdutoOrcamento.QtdChapa := StrToFloat(DeletaChars(Grade.Cells[5,Grade.ALinha],'.'))
  else
    VprDprodutoOrcamento.QtdChapa:= 0;
  if Grade.Cells[6,Grade.ALinha] <> '' then
    VprDprodutoOrcamento.LarChapa := StrToFloat(DeletaChars(Grade.Cells[6,Grade.ALinha],'.'))
  else
    VprDprodutoOrcamento.LarChapa:= 0;
  if Grade.Cells[7,Grade.ALinha] <> '' then
    VprDprodutoOrcamento.ComChapa := StrToFloat(DeletaChars(Grade.Cells[7,Grade.ALinha],'.'))
  else
    VprDprodutoOrcamento.ComChapa:= 0;
end;

{******************************************************************************}
procedure TFNovoOrcamentoCompra.CarDClasse;
begin
  VprDOrcamento.CodFilialFaturamento := EFilialFaturamento.AInteiro;
  VprDOrcamento.DatPrevista := StrToDate(EDatPrevista.Text);
  VprDOrcamento.CodCondicaoPagto := ECondicoesPagto.AInteiro;
  VprDOrcamento.CodFormaPagto := EFormaPagto.AInteiro;
  VprDOrcamento.CodComprador := EComprador.AInteiro;
end;

{******************************************************************************}
procedure TFNovoOrcamentoCompra.CarDTela;
begin
  EFilial.AInteiro := VprDOrcamento.CodFilial;
  EFilial.Atualiza;
  EUsuario.AInteiro := VprDOrcamento.CodUsuario;
  EUsuario.Atualiza;
  ENumero.AInteiro := VprDOrcamento.SeqOrcamento;
  EData.text := FormatDateTime('DD/MM/YYYY',VprDOrcamento.DatOrcamento);
  EHora.Text := FormatDateTime('HH:MM',VprDOrcamento.HorOrcamento);
  EFilialFaturamento.AInteiro := VprDOrcamento.CodFilialFaturamento;
  EFilial.Atualiza;
  EDatPrevista.Text := FormatDateTime('DD/MM/YYYY',VprDOrcamento.DatPrevista);
  ECondicoesPagto.AInteiro := VprDOrcamento.CodCondicaoPagto;
  ECondicoesPagto.Atualiza;
  EFormaPagto.AInteiro := VprDOrcamento.CodFormaPagto;
  EFormaPagto.Atualiza;
  EComprador.AInteiro := VprDOrcamento.CodComprador;


  Grade.ADados := VprDOrcamento.Produtos;
  Grade.CarregaGrade;
  CarDFornecedoresTela;
end;

{******************************************************************************}
procedure TFNovoOrcamentoCompra.CarDFornecedoresTela;
var
  VpfLaco : Integer;
  VpfPagina : TTabSheet;
  VpfDCliente : TRBDCliente;
  VpfGrade : TRBStringGridColor;
begin
  for VpfLaco := Paginas.PageCount - 2 downto 1 do
  begin
    Paginas.Pages[VpfLaco].Destroy;
  end;

  for vpflaco :=0 to VprDOrcamento.Fornecedores.Count - 1 do
  begin
    VprDFornecedorOrcamento := TRBDOrcamentoCompraFornecedor(VprDOrcamento.Fornecedores.Items[VpfLaco]);
    VpfPagina := TTabSheet.Create(Paginas);
    Paginas.InsertControl(VpfPagina);
    VpfPagina.PageControl := Paginas;
    Paginas.ActivePage:= VpfPagina;
    PAdiciona.PageIndex := Paginas.PageCount - 1;

    CopiaComponente(PAdiciona,VpfPagina);
    TEditLocaliza(LocalizaComponente(VpfPagina,10)).AInteiro := VprDFornecedorOrcamento.CodFornecedor;
    TEditLocaliza(LocalizaComponente(VpfPagina,10)).Atualiza;
    TEditColor(LocalizaComponente(VpfPagina,11)).Text := VprDFornecedorOrcamento.NomContato;
    TEditColor(LocalizaComponente(VpfPagina,13)).Text := VprDFornecedorOrcamento.DesEmailFornecedor;
    Tnumerico(LocalizaComponente(VpfPagina,17)).AValor := VprDFornecedorOrcamento.ValFrete;

    VpfDCliente := TRBDCliente.cria;
    VpfDCliente.CodCliente := VprDFornecedorOrcamento.CodFornecedor;
    FunClientes.CarDCliente(VpfDCliente);
    TEditColor(LocalizaComponente(VpfPagina,12)).Text := VpfDCliente.DesFone1;
    VpfPagina.Caption := copy(VpfDCliente.NomCliente,1,10);

    VpfGrade := TRBStringGridColor(LocalizaComponente(VpfPagina,14));
    VpfGrade.OnCarregaItemGrade :=  GAdicionadosCarregaItemGrade;
    VpfGrade.OnDadosValidos := GAdicionadosDadosValidos;
    VpfGrade.ADados := VprDFornecedorOrcamento.ProdutosAdicionados;
    VpfGrade.CarregaGrade;
    CarTituloGradeProduto(VpfGrade);

    VpfGrade := TRBStringGridColor(LocalizaComponente(VpfPagina,15));
    VpfGrade.ADados := VprDFornecedorOrcamento.ProdutosNaoAdicionados;
    VpfGrade.OnCarregaItemGrade :=  GNaoAdicionadosCarregaItemGrade;
    VpfGrade.CarregaGrade;
    CarTituloGradeProduto(VpfGrade);

    VpfDCliente.Free;
  end;
  Paginas.ActivePageIndex := 0;
end;

{******************************************************************************}
procedure TFNovoOrcamentoCompra.CarDFracoesOrcamento(VpaFracoes: Tlist);
var
  VpfLaco : Integer;
  VpfDFracaoSolicitacao : TRBDSolicitacaoCompraFracaoOP;
  VpfDFracaoOrcamento : TRBDOrcamentoCompraFracaoOP;
begin
  for VpfLaco := 0 to VpaFracoes.Count - 1 do
  begin
    VpfDFracaoSolicitacao := TRBDSolicitacaoCompraFracaoOP(VpaFracoes.Items[VpfLaco]);
    VpfDFracaoOrcamento := VprDOrcamento.AddFracao;
    VpfDFracaoOrcamento.CodFilialFracao := VpfDFracaoSolicitacao.CodFilialFracao;
    VpfDFracaoOrcamento.SeqOrdem := VpfDFracaoSolicitacao.SeqOrdem;
    VpfDFracaoOrcamento.SeqFracao := VpfDFracaoSolicitacao.SeqFracao;
    VpfDFracaoOrcamento.NomCliente := VpfDFracaoSolicitacao.NomCliente;
  end;
end;

{******************************************************************************}
procedure TFNovoOrcamentoCompra.CarDFornecedoresClasse;
var
  VpfLaco : Integer;
  VpfPaginaAtual : TTabSheet;
begin
  for VpfLaco := 1 to Paginas.PageCount - 2 do
  begin
    VpfPaginaAtual := Paginas.Pages[VpfLaco];
    VprDFornecedorOrcamento := TRBDOrcamentoCompraFornecedor(VprDOrcamento.Fornecedores.Items[VpfLaco-1]);
    VprDFornecedorOrcamento.NomContato := TEditColor(LocalizaComponente(VpfPaginaAtual,11)).Text;
    VprDFornecedorOrcamento.DesEmailFornecedor := TEditColor(LocalizaComponente(VpfPaginaAtual,13)).Text;
    VprDFornecedorOrcamento.CodFornecedor := TEditLocaliza(LocalizaComponente(VpfPaginaAtual,10)).AInteiro;
    VprDFornecedorOrcamento.ValFrete := Tnumerico(LocalizaComponente(VpfPaginaAtual,17)).AValor;
  end;
end;

{******************************************************************************}
procedure TFNovoOrcamentoCompra.CarDClasseProdutos;
begin
  VprDProdutoOrcamento.SeqItem:= 0;
  if Grade.Cells[3,Grade.ALinha] <> '' then
    VprDProdutoOrcamento.CodCor:= StrToInt(Grade.Cells[3,Grade.ALinha])
  else
    VprDProdutoOrcamento.CodCor:= 0;
  VprDProdutoOrcamento.DesUM:= Grade.Cells[8,Grade.ALinha];
  if Grade.Cells[9,Grade.ALinha] <> '' then
    VprDProdutoOrcamento.QtdSolicitada:= StrToFloat(DeletaChars(Grade.Cells[9,Grade.ALinha],'.'))
  else
    VprDProdutoOrcamento.QtdSolicitada:= 0;
  if Grade.Cells[10,Grade.ALinha] <> '' then
    VprDProdutoOrcamento.QtdProduto:= StrToFloat(DeletaChars(Grade.Cells[10,Grade.ALinha],'.'))
  else
    VprDProdutoOrcamento.QtdProduto:= 0;
   if Grade.Cells[11,Grade.ALinha] <> '' then
    VprDProdutoOrcamento.DesArquivoProjeto:= Grade.Cells[11,Grade.ALinha];
end;

{******************************************************************************}
function TFNovoOrcamentoCompra.ExisteProduto: Boolean;
begin
  Result:= False;
  if Grade.Cells[1,Grade.ALinha] <> '' then
  begin
    if Grade.Cells[1,Grade.ALinha] = VprProdutoAnterior then
      Result:= True
    else
    begin
      Result:= FunProdutos.ExisteProduto(Grade.Cells[1,Grade.ALinha],VprDProdutoOrcamento);
      if Result then
      begin
        VprProdutoAnterior:= VprDProdutoOrcamento.CodProduto;
        VprCorAnterior:= '';

        Grade.Cells[2,Grade.ALinha]:= VprDProdutoOrcamento.NomProduto;
        Grade.Cells[8,Grade.ALinha]:= VprDProdutoOrcamento.DesUM;
        Grade.Cells[9,Grade.ALinha]:= FormatFloat(Varia.MascaraQtd,VprDProdutoOrcamento.Qtdproduto);
        Grade.Cells[10,Grade.ALinha]:= FormatFloat(Varia.MascaraValor,VprDProdutoOrcamento.ValUnitario);
        Grade.Cells[11,Grade.ALinha]:= FunPedidoCompra.RArquivoProjeto(VprDProdutoOrcamento.CodProduto);
        if Grade.Cells[11,Grade.ALinha] <> '' then
         VprDProdutoOrcamento.IndArquivoProjetoLocalizado:= true;
      end;
    end;
  end
end;

{******************************************************************************}
function TFNovoOrcamentoCompra.LocalizaProduto: Boolean;
begin
  FLocalizaProduto:= TFLocalizaProduto.CriarSDI(Application,'',True);
  Result:= FLocalizaProduto.LocalizaProduto(VprDProdutoOrcamento);
  FLocalizaProduto.Free;
  if Result then
  begin
    VprProdutoAnterior := VprDProdutoOrcamento.CodProduto;
    VprCorAnterior:= '';

    Grade.Cells[1,Grade.ALinha]:= VprDProdutoOrcamento.CodProduto;
    Grade.Cells[2,Grade.ALinha]:= VprDProdutoOrcamento.NomProduto;
    Grade.Cells[8,Grade.ALinha]:= VprDProdutoOrcamento.DesUM;
    Grade.Cells[9,Grade.ALinha]:= FormatFloat(Varia.MascaraQtd,VprDProdutoOrcamento.QtdSolicitada);
    Grade.Cells[10,Grade.ALinha]:= FormatFloat(Varia.MascaraQtd,VprDProdutoOrcamento.Qtdproduto);
    Grade.Cells[11,Grade.ALinha]:= VprDProdutoOrcamento.DesArquivoProjeto;

    Grade.Col:= 3;
    if Grade.AEstadoGrade = egNavegacao then
      Grade.AEstadoGrade :=egEdicao;
  end;
end;

{******************************************************************************}
function TFNovoOrcamentoCompra.ExisteCor : Boolean;
begin
  Result:= True;
  if Grade.Cells[3,Grade.ALinha] <> '' then
  begin
    if (Grade.Cells[3,Grade.ALinha] = VprCorAnterior) then
      Result:= True
    else
    begin
      Result:= FunProdutos.ExisteCor(Grade.Cells[3,Grade.ALinha],VprDProdutoOrcamento.NomCor);
      if Result then
      begin
        Grade.Cells[4,Grade.ALinha]:= VprDProdutoOrcamento.NomCor;

        VprCorAnterior:= Grade.Cells[3,Grade.ALinha];

        VprDProdutoOrcamento.CodCor:= StrToInt(Grade.Cells[3,Grade.ALinha]);
      end;
    end;
  end;
end;

{******************************************************************************}
function TFNovoOrcamentoCompra.ExisteFornedorDuplicado(VpaCodFornecedor : Integer):Boolean;
var
  VpfLaco : Integer;
begin
  result := false;
  for VpfLaco := 0 to VprDOrcamento.Fornecedores.Count - 1 do
  begin
    if TRBDOrcamentoCompraFornecedor(VprDOrcamento.Fornecedores.Items[VpfLaco]).CodFornecedor = VpaCodFornecedor then
    begin
      result := true;
      break;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoOrcamentoCompra.EstadoBotoes(VpaSituacao : Boolean);
begin
  BCadastrar.Enabled := not VpaSituacao;
  BGravar.Enabled := VpaSituacao;
  BCancelar.Enabled := VpaSituacao;
  BImprimir.Enabled := not VpaSituacao;
  BEnviar.Enabled := Not VpaSituacao;
  BFechar.Enabled := not VpaSituacao;
end;

{******************************************************************************}
procedure TFNovoOrcamentoCompra.CarDProdutoSolicitacaoTela(VpaProdutos: TList);
var
  VpfLaco: Integer;
  VpfDProdutoOrcamentoCompra,
  VpfDProdutoOrcamentoCompraAux: TRBDOrcamentoCompraProduto;
begin
  for VpfLaco:= 0 to VpaProdutos.Count-1 do
  begin
    VpfDProdutoOrcamentoCompraAux:= TRBDOrcamentoCompraProduto(VpaProdutos.Items[VpfLaco]);
    // fazer a importação dos produtos para a lista do pedido aqui, pois será
    // necessário fazer um controle externo na lista de produtos mais tarde.
    VpfDProdutoOrcamentoCompra:= VprDorcamento.AddProduto;
    VpfDProdutoOrcamentoCompra.SeqProduto:= VpfDProdutoOrcamentoCompraAux.SeqProduto;
    VpfDProdutoOrcamentoCompra.CodCor:= VpfDProdutoOrcamentoCompraAux.CodCor;
    VpfDProdutoOrcamentoCompra.CodProduto:= VpfDProdutoOrcamentoCompraAux.CodProduto;
  end;
  Grade.CarregaGrade;
  Grade.Col:= 1;

  for VpfLaco:= 1 to Grade.RowCount-1 do
  begin
    VpfDProdutoOrcamentoCompraAux:= TRBDOrcamentoCompraProduto(VpaProdutos.Items[VpfLaco-1]);
    VprProdutoAnterior:= '';
    VprCorAnterior:= '';
    Grade.ALinha:= VpfLaco;
    VprDProdutoOrcamento:= TRBDOrcamentoCompraProduto(VprDOrcamento.Produtos.Items[VpfLaco-1]);
    ExisteProduto;
    ExisteCor;
    VprDProdutoOrcamento.QtdSolicitada:= VpfDProdutoOrcamentoCompraAux.QtdSolicitada;
    VprDProdutoOrcamento.QtdProduto:= VpfDProdutoOrcamentoCompraAux.QtdProduto;
    VprDProdutoOrcamento.QtdChapa := VpfDProdutoOrcamentoCompraAux.QtdChapa;
    VprDProdutoOrcamento.LarChapa := VpfDProdutoOrcamentoCompraAux.LarChapa;
    VprDProdutoOrcamento.ComChapa := VpfDProdutoOrcamentoCompraAux.ComChapa;
    // carregar corretamente a quantidade do produto, já que ela é redefinida
    // para 1 dentro do ExisteProduto
    Grade.Cells[9,Grade.ALinha]:= FormatFloat(Varia.MascaraQtd,VpfDProdutoOrcamentoCompraAux.QtdSolicitada);
    Grade.Cells[10,Grade.ALinha]:= FormatFloat(Varia.MascaraQtd,VpfDProdutoOrcamentoCompraAux.QtdProduto);
    CarDClasseProdutos;
  end;
  Grade.CarregaGrade;
  Grade.Col:= 1;
end;

{******************************************************************************}
procedure TFNovoOrcamentoCompra.AdicionaFornecedor;
var
  VpfPagina : TTabSheet;
  VpfEditFornecedor : TEditLocaliza;
  VpfDCliente :TRBDCliente;
  VpfGrade : TRBStringGridColor;
begin
  if VprOperacao in [ocEdicao,ocinsercao] then
  begin
    if ECliente.AAbreLocalizacao then
    begin
      if not ExisteFornedorDuplicado(ECliente.ainteiro) then
      begin
        VpfPagina := TTabSheet.Create(Paginas);
        Paginas.InsertControl(VpfPagina);
        VpfPagina.PageControl := Paginas;
        Paginas.ActivePage:= VpfPagina;
        PAdiciona.PageIndex := Paginas.PageCount - 1;

        CopiaComponente(PAdiciona,VpfPagina);
        TPanelColor(LocalizaComponente(VpfPagina,16)).Color := clred;

        VpfEditFornecedor := TEditLocaliza(LocalizaComponente(VpfPagina,10));
        VpfEditFornecedor.AInteiro := ECliente.AInteiro;
        VpfEditFornecedor.Atualiza;

        VpfDCliente := TRBDCliente.cria;
        VpfDCliente.CodCliente := ECliente.AInteiro;
        FunClientes.CarDCliente(VpfDCliente);
        TEditColor(LocalizaComponente(VpfPagina,11)).Text := VpfDCliente.NomContatoFornecedor;
        TEditColor(LocalizaComponente(VpfPagina,12)).Text := VpfDCliente.DesFone1;
        TEditColor(LocalizaComponente(VpfPagina,13)).Text := VpfDCliente.DesEmailFornecedor;
        VpfPagina.Caption := copy(VpfDCliente.NomCliente,1,10);

        VprDFornecedorOrcamento := VprDOrcamento.addFornecedor;
        VprDFornecedorOrcamento.CodFornecedor := VpfDCliente.CodCliente;
        VprDFornecedorOrcamento.NomContato := VpfDCliente.NomContatoFornecedor;
        VprDFornecedorOrcamento.DesEmailFornecedor := VpfDCliente.DesEmailFornecedor;

        FunOrcamentoCompra.AdicionaProdutosFornecedor(VprDOrcamento,VprDFornecedorOrcamento);
        VpfGrade := TRBStringGridColor(LocalizaComponente(VpfPagina,14));
        VpfGrade.OnCarregaItemGrade :=  GAdicionadosCarregaItemGrade;
        VpfGrade.OnDadosValidos := GAdicionadosDadosValidos;
        VpfGrade.ADados := VprDFornecedorOrcamento.ProdutosAdicionados;
        VpfGrade.CarregaGrade;
        CarTituloGradeProduto(VpfGrade);

        VpfGrade := TRBStringGridColor(LocalizaComponente(VpfPagina,15));
        VpfGrade.ADados := VprDFornecedorOrcamento.ProdutosNaoAdicionados;
        VpfGrade.OnCarregaItemGrade :=  GNaoAdicionadosCarregaItemGrade;
        VpfGrade.CarregaGrade;
        CarTituloGradeProduto(VpfGrade);

        VpfDCliente.Free;
      end
      else
      begin
        aviso('FORNECEDOR DUPLICADO!!!'#13'Esse fornecedor já foi adicionado no orçamento.');
        Paginas.ActivePage := PGeral;
      end;
    end
    else
      Paginas.ActivePage := PGeral;
  end
  else
  begin
    Paginas.ActivePage := PGeral;
    aviso('ORÇAMENTO DE COMPRA JÁ GRAVADO!!!'#13'Antes de adicionar um novo fornecedor é necessário alterar o orçamento.');
  end;
end;

{******************************************************************************}
procedure TFNovoOrcamentoCompra.BloquearTela;
begin
  AlteraReadOnlyDet(Paginas,0,true);

  Grade.APermiteExcluir:= False;
  Grade.APermiteInserir:= False;

  EstadoBotoes(false);
end;

{******************************************************************************}
function TFNovoOrcamentoCompra.NovoOrcamento:Boolean;
begin
  VprOperacao:= ocInsercao;
  EstadoBotoes(true);

  InicializaTela;

  ValidaGravacao1.execute;
  ShowModal;
  Result:= VprAcao;
end;

{******************************************************************************}
function TFNovoOrcamentoCompra.NovoOrcamentoProdutosPendentes(VpaProdutos, VpaFracoesOP, VpaProdutosPendentes, VpaProdutosFinalizados: TList): Boolean;
begin
  VprIndSolicitacaoCompra := true;
  VprProdutosPendentes := VpaProdutosPendentes;
  VprProdutosFinalizados := VpaProdutosFinalizados;
  VprOperacao:= ocInsercao;
  EstadoBotoes(true);

  InicializaTela;

  CarDProdutoSolicitacaoTela(VpaProdutos);
  CarDFracoesOrcamento(VpaFracoesOP);
  FunOrcamentoCompra.AdicionaFornecedoresOrcamentoCompra(VprDOrcamento);
  FunOrcamentoCompra.AdicionaProdutosNaoAdicionadosFornecedor(VprDOrcamento);
  FunOrcamentoCompra.AdicionaSolicitacoesOrcamentoCompra(VprDOrcamento,VpaProdutosPendentes);
  CarDFornecedoresTela;
  ValidaGravacao1.execute;
  ShowModal;
  Result:= VprAcao;

end;

{******************************************************************************}
function TFNovoOrcamentoCompra.Alterar(VpaCodFilial, VpaSeqOrcamento: Integer): Boolean;
begin
  VprOperacao:= ocConsulta;
  FunOrcamentoCompra.CarDOrcamento(VpaCodFilial,VpaSeqOrcamento,VprDOrcamento);
  CarDTela;
  EstadoBotoes(true);
  VprOperacao:= ocEdicao;
  ShowModal;
  result := VprAcao;
end;

{******************************************************************************}
procedure TFNovoOrcamentoCompra.Consultar(VpaCodFilial, VpaSeqOrcamento: Integer);
begin
  VprOperacao:= ocConsulta;
  FunOrcamentoCompra.CarDOrcamento(VpaCodFilial,VpaSeqOrcamento,VprDOrcamento);
  CarDTela;
  BloquearTela;

  ShowModal;
end;

{******************************************************************************}
procedure TFNovoOrcamentoCompra.DadosValidosProduto(Sender: TObject; var VpaValidos: Boolean);
begin
  aviso('oi');
end;

{******************************************************************************}
procedure TFNovoOrcamentoCompra.rcam(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDProdutoOrcamento:= TRBDOrcamentoCompraProduto(VprDOrcamento.Produtos.Items[VpaLinha-1]);
  Grade.Cells[1,Grade.ALinha]:= VprDProdutoOrcamento.CodProduto;
  Grade.Cells[2,Grade.ALinha]:= VprDProdutoOrcamento.NomProduto;
  if VprDProdutoOrcamento.CodCor <> 0 then
    Grade.Cells[3,Grade.ALinha]:= IntToStr(VprDProdutoOrcamento.CodCor)
  else
    Grade.Cells[3,Grade.ALinha]:= '';
  Grade.Cells[4,Grade.ALinha]:= VprDProdutoOrcamento.NomCor;
  if VprDProdutoOrcamento.QtdChapa <> 0 then
    Grade.Cells[5,Grade.ALinha]:= FormatFloat('#,###,###0',VprDProdutoOrcamento.QtdChapa)
  else
    Grade.Cells[5,Grade.ALinha]:= '';
  if VprDProdutoOrcamento.LarChapa <> 0 then
    Grade.Cells[6,Grade.ALinha]:= FormatFloat('#,###,###0',VprDProdutoOrcamento.LarChapa)
  else
    Grade.Cells[6,Grade.ALinha]:= '';
  if VprDProdutoOrcamento.ComChapa <> 0 then
    Grade.Cells[7,Grade.ALinha]:= FormatFloat('#,###,###0',VprDProdutoOrcamento.ComChapa)
  else
    Grade.Cells[7,Grade.ALinha]:= '';
  Grade.Cells[8,Grade.ALinha]:= VprDProdutoOrcamento.DesUM;
  if VprDProdutoOrcamento.QtdSolicitada <> 0 then
    Grade.Cells[9,Grade.ALinha]:= FormatFloat(Varia.MascaraQtd,VprDProdutoOrcamento.QtdSolicitada)
  else
    Grade.Cells[9,Grade.ALinha]:= '';
  if VprDProdutoOrcamento.QtdProduto <> 0 then
    Grade.Cells[10,Grade.ALinha]:= FormatFloat(Varia.MascaraQtd,VprDProdutoOrcamento.QtdProduto)
  else
    Grade.Cells[10,Grade.ALinha]:= '';

  Grade.Cells[11,Grade.ALinha]:= VprDProdutoOrcamento.DesArquivoProjeto;
end;

{******************************************************************************}
procedure TFNovoOrcamentoCompra.PaginasChange(Sender: TObject);
begin
  if Paginas.ActivePage = PAdiciona then
    AdicionaFornecedor
  else
  begin
    if Paginas.ActivePageIndex > 0  then
    begin
      VprDFornecedorOrcamento := TRBDOrcamentoCompraFornecedor(VprDOrcamento.Fornecedores.Items[Paginas.ActivePageIndex-1]);
      TRBStringGridColor(LocalizaComponente(Paginas.ActivePage,14)).CarregaGrade;
      TRBStringGridColor(LocalizaComponente(Paginas.ActivePage,15)).CarregaGrade;
    end;
  end;

end;

procedure TFNovoOrcamentoCompra.PanelColor4Click(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFNovoOrcamentoCompra.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFNovoOrcamentoCompra.BCancelarClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFNovoOrcamentoCompra.BGravarClick(Sender: TObject);
var
  VpfResultado : String;
begin
  CarDClasse;
  CarDFornecedoresClasse;
  VpfResultado := FunOrcamentoCompra.GravaDOrcamento(VprDOrcamento);
  if VpfResultado = '' then
  begin
    VprAcao := true;
    EstadoBotoes(false);
    VprOperacao := ocConsulta;
  end
  else
    aviso(VpfResultado);
end;

{******************************************************************************}
procedure TFNovoOrcamentoCompra.ECompradorChange(Sender: TObject);
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
    ValidaGravacao1.execute;
end;

{******************************************************************************}
procedure TFNovoOrcamentoCompra.GradeDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos:= True;
  if not ExisteProduto then
  begin
    VpaValidos:= False;
    aviso('CÓDIGO DO PRODUTO NÃO PREENCHIDO!!!'#13'É necessário informar o código do produto.');
    Grade.Col:= 1;
  end
  else
    if not ExisteCor then
    begin
      VpaValidos:= False;
      aviso('COR NÃO CADASTRADA!!!'#13'Informe uma cor que esteja cadastrada.');
      Grade.Col:= 3;
    end
    else
      if VprDProdutoOrcamento.UnidadesParentes.IndexOf(Grade.Cells[8,Grade.ALinha]) < 0 then
      begin
        VpaValidos:= False;
        aviso(CT_UNIDADEVAZIA);
        Grade.Col:= 8;
      end
      else
        if Grade.Cells[9,Grade.ALinha] = '' then
        begin
          VpaValidos:= False;
          aviso('QUANTIDADE SOLICITADA NÃO PREENCHIDA!!!'#13'É necessário preencer a quantidade solicitada do produto.');
          Grade.Col:= 9;
        end
        else
          if Grade.Cells[10,Grade.ALinha] = '' then
          begin
            VpaValidos:= False;
            aviso('QUANTIDADE  NÃO PREENCHIDA!!!'#13'É necessário preencer a quantidade  do produto.');
            Grade.Col:= 10;
          end;

  if VpaValidos then
  begin
    CarDClasseProdutos;
    if VprDProdutoOrcamento.QtdSolicitada = 0 then
    begin
      VpaValidos:= False;
      aviso('QUANTIDADE SOLICITADA NÃO PREENCHIDA!!!'#13'É necessário preencher a quantidade solicitada.');
      Grade.Col:= 9;
    end
    else
      if VprDProdutoOrcamento.QtdProduto = 0 then
      begin
        VpaValidos:= False;
        aviso('QUANTIDADE NÃO PREENCHIDA!!!'#13'É necessário preencher a quantidade do produto');
        Grade.Col:= 10;
      end;
  end;
  if VpaValidos then
  begin
    FunOrcamentoCompra.ExcluiProdutoNosFornecedores(VprDOrcamento);
    FunOrcamentoCompra.AdicionaProdutoNosFornecedores(VprDOrcamento);
  end;
end;

{******************************************************************************}
procedure TFNovoOrcamentoCompra.GradeDepoisExclusao(Sender: TObject);
begin
  FunOrcamentoCompra.ExcluiProdutoNosFornecedores(VprDOrcamento);
end;

{******************************************************************************}
procedure TFNovoOrcamentoCompra.rbdtCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
var
  VpfDItem : TRBDOrcamentoCompraProduto;
begin
  if (ARow > 0) and (Acol = 11) then
  begin
    if VprDOrcamento.Produtos.Count >0 then
    begin
      VpfDItem := TRBDOrcamentoCompraProduto(VprDOrcamento.Produtos.Items[arow-1]);
      if (VpfDItem.SeqProduto <> 0) and (CEnviarArquivoProjeto.Checked)  then
      begin
        if (VpfDItem.IndArquivoProjetoLocalizado) then
          AFont.Color := clGreen
        else
          AFont.Color := clRed; //$0080FF80
      end;
      if (VpfDItem.SeqProduto <> 0) and (CEnviarArquivoProjeto.Checked)  then
      begin
        if (Grade.Cells[11,Grade.ALinha]<> '') then
          AFont.Color := clGreen
        else
          AFont.Color := clRed; //$0080FF80
      end;
    end;
  end;
end;

procedure TFNovoOrcamentoCompra.GradeGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    3,5,6,7: Value:= '0000000;0; ';
  end;
end;

{******************************************************************************}
procedure TFNovoOrcamentoCompra.GradeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = 114 then
    case Grade.Col of
      1: LocalizaProduto;
      3: ECor.AAbreLocalizacao;
    end;
end;

{******************************************************************************}
procedure TFNovoOrcamentoCompra.ECorRetorno(Retorno1, Retorno2: String);
begin
  Grade.Cells[3,Grade.ALinha]:= Retorno1;
  Grade.Cells[4,Grade.ALinha]:= Retorno2;
end;

procedure TFNovoOrcamentoCompra.GradeMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDOrcamento.Produtos.Count > 0 then
  begin
    VprDProdutoOrcamento:= TRBDOrcamentoCompraProduto(VprDOrcamento.Produtos.Items[VpaLinhaAtual-1]);
    VprProdutoAnterior:= VprDProdutoOrcamento.CodProduto;
    VprCorAnterior:= IntToStr(VprDProdutoOrcamento.CodCor);
  end;
end;

procedure TFNovoOrcamentoCompra.GradeNovaLinha(Sender: TObject);
begin
  VprDProdutoOrcamento := VprDOrcamento.addProduto;
end;

procedure TFNovoOrcamentoCompra.GradeSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if Grade.AEstadoGrade in [egEdicao,egInsercao] then
  begin
    if Grade.AColuna <> ACol then
    begin
      case Grade.AColuna of
        1: if not ExisteProduto then
             if not LocalizaProduto then
             begin
               Grade.Cells[1,Grade.ALinha]:= '';
               Grade.Cells[2,Grade.ALinha]:= '';
               Abort;
             end;
        3: if not ExisteCor then
           begin
             Grade.Cells[3,Grade.ALinha]:= '';
             Grade.Cells[4,Grade.ALinha]:= '';
             Abort;
           end;
         5,6,7 : CalculaKilosChapa;
      end;
    end;
  end;
end;


{******************************************************************************}
procedure TFNovoOrcamentoCompra.GAdicionadosCarregaItemGrade(
  Sender: TObject; VpaLinha: Integer);
var
  VpfGrade : TRBStringGridColor;
begin
  VpfGrade := TRBStringGridColor(Sender);
  VprDProFornecedorOrc := TRBDOrcamentoCompraProduto(VprDFornecedorOrcamento.ProdutosAdicionados.Items[VpaLinha-1]);
  VpfGrade.Cells[1,VpfGrade.ALinha]:= VprDProFornecedorOrc.CodProduto;
  VpfGrade.Cells[2,VpfGrade.ALinha]:= VprDProFornecedorOrc.NomProduto;
  if VprDProFornecedorOrc.CodCor <> 0 then
    VpfGrade.Cells[3,VpfGrade.ALinha]:= IntToStr(VprDProFornecedorOrc.CodCor)
  else
    VpfGrade.Cells[3,VpfGrade.ALinha]:= '';
  VpfGrade.Cells[4,VpfGrade.ALinha]:= VprDProFornecedorOrc.NomCor;
  if VprDProFornecedorOrc.QtdChapa <> 0 then
    VpfGrade.Cells[5,VpfGrade.ALinha]:= FormatFloat('#,###,##0',VprDProFornecedorOrc.QtdChapa)
  else
    VpfGrade.Cells[5,VpfGrade.ALinha]:= '';
  if VprDProFornecedorOrc.LarChapa <> 0 then
    VpfGrade.Cells[6,VpfGrade.ALinha]:= FormatFloat('#,###,##0',VprDProFornecedorOrc.LarChapa)
  else
    VpfGrade.Cells[6,VpfGrade.ALinha]:= '';
  if VprDProFornecedorOrc.ComChapa <> 0 then
    VpfGrade.Cells[7,VpfGrade.ALinha]:= FormatFloat('#,###,##0',VprDProFornecedorOrc.ComChapa)
  else
    VpfGrade.Cells[7,VpfGrade.ALinha]:= '';
  VpfGrade.Cells[8,VpfGrade.ALinha]:= VprDProFornecedorOrc.DesUM;
  if VprDProFornecedorOrc.QtdProduto <> 0 then
    VpfGrade.Cells[9,VpfGrade.ALinha]:= FormatFloat(Varia.MascaraQtd,VprDProFornecedorOrc.QtdProduto)
  else
    VpfGrade.Cells[9,VpfGrade.ALinha]:= '';
  if VprDProFornecedorOrc.ValUnitario <> 0 then
    VpfGrade.Cells[10,VpfGrade.ALinha]:= FormatFloat(Varia.MascaraValorUnitario,VprDProFornecedorOrc.ValUnitario)
  else
    VpfGrade.Cells[10,VpfGrade.ALinha]:= '';
  if VprDProFornecedorOrc.PerICMS <> 0 then
    VpfGrade.Cells[11,VpfGrade.ALinha]:= FormatFloat('0.00%',VprDProFornecedorOrc.PerICMS)
  else
    VpfGrade.Cells[11,VpfGrade.ALinha]:= '';

  if VprDProFornecedorOrc.PerIPI <> 0 then
    VpfGrade.Cells[12,VpfGrade.ALinha]:= FormatFloat('0.00%',VprDProFornecedorOrc.PerIPI)
  else
    VpfGrade.Cells[12,VpfGrade.ALinha]:= '';
  if VprDProFornecedorOrc.ValTotal <> 0 then
    VpfGrade.Cells[13,VpfGrade.ALinha]:= FormatFloat('#,###,###,##0.00',VprDProFornecedorOrc.ValTotal)
  else
    VpfGrade.Cells[13,VpfGrade.ALinha]:= '';
end;

{******************************************************************************}
procedure TFNovoOrcamentoCompra.GAdicionadosDadosValidos(Sender: TObject; var VpaValidos: Boolean);
var
  VpfGrade : TRBStringGridColor;
begin
  VpfGrade := TRBStringGridColor(Sender);
  VprDProFornecedorOrc := TRBDOrcamentoCompraProduto(VprDFornecedorOrcamento.ProdutosAdicionados.Items[VpfGrade.Row-1]);
  if VpfGrade.Cells[9,VpfGrade.ALinha] <> '' then
    VprDProFornecedorOrc.QtdProduto := StrToFloat(DeletaChars(VpfGrade.Cells[9,VpfGrade.ALinha],'.'))
  else
    VprDProFornecedorOrc.QtdProduto:= 0;
  if VpfGrade.Cells[10,VpfGrade.ALinha] <> '' then
    VprDProFornecedorOrc.ValUnitario := StrToFloat(DeletaChars(VpfGrade.Cells[10,VpfGrade.ALinha],'.'))
  else
    VprDProFornecedorOrc.ValUnitario:= 0;
  if VpfGrade.Cells[11,VpfGrade.ALinha] <> '' then
    VprDProFornecedorOrc.PerICMS := StrToFloat(DeletaChars(DeletaChars(DeletaChars(VpfGrade.Cells[11,VpfGrade.ALinha],'.'),'%'),' '))
  else
    VprDProFornecedorOrc.PerICMS:= 0;
  if VpfGrade.Cells[12,VpfGrade.ALinha] <> '' then
    VprDProFornecedorOrc.PerIPI := StrToFloat(DeletaChars(DeletaChars(DeletaChars(VpfGrade.Cells[12,VpfGrade.ALinha],'.'),'%'),' '))
  else
    VprDProFornecedorOrc.PerIPI:= 0;
  VprDProFornecedorOrc.ValTotal := VprDProFornecedorOrc.QtdProduto * VprDProFornecedorOrc.ValUnitario;
end;

{******************************************************************************}
procedure TFNovoOrcamentoCompra.BEnviarClick(Sender: TObject);
var
  VpfResultado : String;
begin
  VpfResultado :=  FunOrcamentoCompra.EnviaEmailFornecedor(VprDOrcamento);
  if VpfResultado <> '' then
    aviso(VpfResultado);
end;

{******************************************************************************}
procedure TFNovoOrcamentoCompra.BExcluirClick(Sender: TObject);
var
  VpfIndice : Integer;
begin
  VpfIndice := Paginas.ActivePageIndex;
  Paginas.Pages[VpfIndice].free;
  Paginas.ActivePage := Paginas.Pages[VpfIndice-1];
  TRBDOrcamentoCompraFornecedor(VprDOrcamento.Fornecedores.Items[VpfIndice-1]).Free;
  VprDOrcamento.Fornecedores.Delete(VpfIndice-1);
end;

{******************************************************************************}
procedure TFNovoOrcamentoCompra.BRemoverClick(Sender: TObject);
Var
  VpfGrade : TRBStringGridColor;
begin
  if VprDFornecedorOrcamento.ProdutosAdicionados.Count > 0 then
  begin
    VpfGrade := TRBStringGridColor(LocalizaComponente(Paginas.ActivePage,14));
    VprDFornecedorOrcamento.ProdutosNaoAdicionados.Add(VprDFornecedorOrcamento.ProdutosAdicionados.Items[VpfGrade.ALinha-1]);
    VprDFornecedorOrcamento.ProdutosAdicionados.Delete(VpfGrade.ALinha-1);
    VpfGrade.CarregaGrade;

    VpfGrade := TRBStringGridColor(LocalizaComponente(Paginas.ActivePage,15));
    VpfGrade.CarregaGrade;
  end
  else
    aviso('GRADE VAZIA!!!'#13'Não existem produtos a serem excluídos na grade');
end;

{******************************************************************************}
procedure TFNovoOrcamentoCompra.BTodosClick(Sender: TObject);
Var
  VpfGrade : TRBStringGridColor;
  VpfLaco : Integer;
begin
  if VprDFornecedorOrcamento.ProdutosNaoAdicionados.Count > 0 then
  begin
    VpfGrade := TRBStringGridColor(LocalizaComponente(Paginas.ActivePage,15));
    for VpfLaco := VprDFornecedorOrcamento.ProdutosNaoAdicionados.Count - 1 downto 0  do
    begin
      VprDFornecedorOrcamento.ProdutosAdicionados.Add(VprDFornecedorOrcamento.ProdutosNaoAdicionados.Items[VpfLaco]);
      VprDFornecedorOrcamento.ProdutosNaoAdicionados.Delete(VpfLaco);
    end;

    VpfGrade.CarregaGrade;

    VpfGrade := TRBStringGridColor(LocalizaComponente(Paginas.ActivePage,14));
    VpfGrade.CarregaGrade;
  end
  else
    aviso('GRADE VAZIA!!!'#13'Não existem produtos a serem excluídos na grade');
end;

{******************************************************************************}
procedure TFNovoOrcamentoCompra.GNaoAdicionadosCarregaItemGrade(
  Sender: TObject; VpaLinha: Integer);
var
  VpfGrade : TRBStringGridColor;
begin
  VpfGrade := TRBStringGridColor(Sender);
//  VprDProNaoAdicionadoFornecedorOrc := TRBDOrcamentoCompraProduto(VprDFornecedorOrcamento.ProdutosNaoAdicionados.Items[VpaLinha-1]);
  VprDProNaoAdicionadoFornecedorOrc := TRBDOrcamentoCompraProduto(VpfGrade.ADados.Items[VpaLinha-1]);
  VpfGrade.Cells[1,VpfGrade.ALinha]:= VprDProNaoAdicionadoFornecedorOrc.CodProduto;
  VpfGrade.Cells[2,VpfGrade.ALinha]:= VprDProNaoAdicionadoFornecedorOrc.NomProduto;
  if VprDProNaoAdicionadoFornecedorOrc.CodCor <> 0 then
    VpfGrade.Cells[3,VpfGrade.ALinha]:= IntToStr(VprDProNaoAdicionadoFornecedorOrc.CodCor)
  else
    VpfGrade.Cells[3,VpfGrade.ALinha]:= '';
  VpfGrade.Cells[4,VpfGrade.ALinha]:= VprDProNaoAdicionadoFornecedorOrc.NomCor;
  if VprDProNaoAdicionadoFornecedorOrc.QtdChapa <> 0 then
    VpfGrade.Cells[5,VpfGrade.ALinha]:= FormatFloat('#,###,###,##0',VprDProNaoAdicionadoFornecedorOrc.QtdChapa)
  else
    VpfGrade.Cells[5,VpfGrade.ALinha]:= '';
  if VprDProNaoAdicionadoFornecedorOrc.LarChapa <> 0 then
    VpfGrade.Cells[6,VpfGrade.ALinha]:= FormatFloat('#,###,###,##0',VprDProNaoAdicionadoFornecedorOrc.LarChapa)
  else
    VpfGrade.Cells[6,VpfGrade.ALinha]:= '';
  if VprDProNaoAdicionadoFornecedorOrc.ComChapa <> 0 then
    VpfGrade.Cells[7,VpfGrade.ALinha]:= FormatFloat('#,###,###,##0',VprDProNaoAdicionadoFornecedorOrc.ComChapa)
  else
    VpfGrade.Cells[7,VpfGrade.ALinha]:= '';
  VpfGrade.Cells[8,VpfGrade.ALinha]:= VprDProNaoAdicionadoFornecedorOrc.DesUM;
  if VprDProNaoAdicionadoFornecedorOrc.QtdSolicitada <> 0 then
    VpfGrade.Cells[9,VpfGrade.ALinha]:= FormatFloat(Varia.MascaraQtd,VprDProNaoAdicionadoFornecedorOrc.QtdSolicitada)
  else
    VpfGrade.Cells[9,VpfGrade.ALinha]:= '';
  if VprDProNaoAdicionadoFornecedorOrc.QtdProduto <> 0 then
    VpfGrade.Cells[10,Grade.ALinha]:= FormatFloat(Varia.MascaraQtd,VprDProNaoAdicionadoFornecedorOrc.QtdProduto)
  else
    VpfGrade.Cells[10,VpfGrade.ALinha]:= '';
end;

{******************************************************************************}
procedure TFNovoOrcamentoCompra.AdicionarClick(Sender: TObject);
Var
  VpfGrade : TRBStringGridColor;
begin
  if VprDFornecedorOrcamento.ProdutosNaoAdicionados.Count > 0 then
  begin
    VpfGrade := TRBStringGridColor(LocalizaComponente(Paginas.ActivePage,15));
    VprDFornecedorOrcamento.ProdutosAdicionados.Add(VprDFornecedorOrcamento.ProdutosNaoAdicionados.Items[VpfGrade.ALinha-1]);
    VprDFornecedorOrcamento.ProdutosNaoAdicionados.Delete(VpfGrade.ALinha-1);
    VpfGrade.CarregaGrade;

    VpfGrade := TRBStringGridColor(LocalizaComponente(Paginas.ActivePage,14));
    VpfGrade.CarregaGrade;
  end
  else
    aviso('GRADE VAZIA!!!'#13'Não existem produtos a serem excluídos na grade');
end;

initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovoOrcamentoCompra]);
end.
