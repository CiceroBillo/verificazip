unit AMapaCompras;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios, Componentes1, Grids, CGrades,
  ExtCtrls, PainelGradiente, StdCtrls, Buttons, UnDadosProduto, UnOrcamentoCompra;

Const
  QTDColunasFixas = 6;

type
  TFMapaCompras = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    GMapa: TRBStringGridColor;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Label1: TLabel;
    CFrete: TCheckBox;
    CIPI: TCheckBox;
    CICMS: TCheckBox;
    BFechar: TBitBtn;
    BGerarPedido: TBitBtn;
    PanelColor3: TPanelColor;
    ESituacao: TComboBoxColor;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure GMapaCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure CFreteClick(Sender: TObject);
    procedure GMapaCellClick(Button: TMouseButton; Shift: TShiftState; VpaColuna, VpaLinha: Integer);
    procedure BGerarPedidoClick(Sender: TObject);
    procedure GMapaDblClick(Sender: TObject);
    procedure GMapaMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure ESituacaoClick(Sender: TObject);
  private
    { Private declarations }
    VprX,
    VprY,
    VprCodFilial,
    VprSeqOrcamento: Integer;
    VprDMapa : TRBDOrcamentoCompraCorpo;
    VprDProdutoOrc : TRBDOrcamentoCompraProduto;
    FunOrcamentoCompra : TRBFuncoesOrcamentoCompra;
    procedure CarTitulosGrade;
    procedure ConfiguraTela;
    procedure SelecionaTodasAsLinhas(VpaSelecionar : Boolean);
    function GeraPedidoCompra(VpaCodFornecedor :Integer) : string;
    procedure AtualizaConsulta;
  public
    { Public declarations }
    function MostraMapaCompras(VpaCodFilial,VpaSeqOrcamento : Integer):boolean;
  end;

var
  FMapaCompras: TFMapaCompras;

implementation

uses APrincipal,Constantes, ASelecionarFornecedorMapaCompras, ConstMsg, ANovoPedidoCompra;

{$R *.DFM}


{ **************************************************************************** }
procedure TFMapaCompras.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunOrcamentoCompra := TRBFuncoesOrcamentoCompra.cria(FPrincipal.BaseDados);
  VprDMapa := TRBDOrcamentoCompraCorpo.cria;
  ESituacao.ItemIndex := 0;
  ConfiguraTela;
  CarTitulosGrade;
end;

{******************************************************************************}
function TFMapaCompras.GeraPedidoCompra(VpaCodFornecedor: Integer): string;
var
  VpfProdutosPedido : TList;
  VpfDOrcamentoFornecedor : TRBDOrcamentoCompraFornecedor;
begin
  result := '';
  VpfProdutosPedido:= TList.Create;

  FunOrcamentoCompra.CarProdutoSelecionados(VpfProdutosPedido,VprDMapa,VpaCodFornecedor);

  if VpfProdutosPedido.Count > 0 then
  begin
    VpfDOrcamentoFornecedor := FunOrcamentoCompra.ROrcamentoFornecedor(VpaCodFornecedor,VprDMapa);
    FNovoPedidoCompra:= TFNovoPedidoCompra.criarSDI(Application,'',True);
    if FNovoPedidoCompra.NovoPedidoMapaCompras(VpfDOrcamentoFornecedor,VpfProdutosPedido,VprDMapa) then
    begin
      AtualizaConsulta;
    end;
    FNovoPedidoCompra.Free;
  end;
  VpfProdutosPedido.Free;
end;

{******************************************************************************}
procedure TFMapaCompras.GMapaCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
var
  VpfLaco, VpfColuna : Integer;
  VpfDFornecedor : TRBDOrcamentoCompraFornecedor;
  VpfDProFornecedor : TRBDOrcamentoCompraProduto;
  VpfValLiquido : Double;
begin
  if VpaLinha > 1 then
  begin
    VprDProdutoOrc := TRBDOrcamentoCompraProduto(VprDMapa.Produtos.Items[VpaLinha-2]);
    if VprDProdutoOrc.IndMarcado then
      GMapa.Cells[1,GMapa.ALinha]:= '1'
    else
      GMapa.Cells[1,GMapa.ALinha]:= '0';
    GMapa.Cells[2,GMapa.ALinha]:= VprDProdutoOrc.CodProduto;
    GMapa.Cells[3,GMapa.ALinha]:= VprDProdutoOrc.NomProduto;
    if VprDProdutoOrc.CodCor <> 0 then
      GMapa.Cells[4,GMapa.ALinha]:= IntToStr(VprDProdutoOrc.CodCor)
    else
      GMapa.Cells[4,GMapa.ALinha]:= '';
    GMapa.Cells[5,GMapa.ALinha]:= VprDProdutoOrc.NomCor;
    if VprDProdutoOrc.QtdProduto <> 0 then
      GMapa.Cells[6,GMapa.ALinha]:= FormatFloat(Varia.MascaraQtd,VprDProdutoOrc.QtdProduto)
    else
      GMapa.Cells[6,GMapa.ALinha]:= '';
    for VpfLaco := 0 to VprDMapa.Fornecedores.Count - 1 do
    begin
      VpfDFornecedor := TRBDOrcamentoCompraFornecedor(VprDMapa.Fornecedores.Items[VpfLaco]);
      VpfColuna := QTDColunasFixas+1+(vpflaco *2);
      VpfDProFornecedor := FunOrcamentoCompra.RProdutoOrcamentoFornecedor(VpfDFornecedor,VprDProdutoOrc.SeqProduto,VprDProdutoOrc.CodCor,VprDProdutoOrc.LarChapa,VprDProdutoOrc.ComChapa);
      if VpfDProFornecedor <> nil then
      begin
        if VpfDProFornecedor.QtdProduto < VprDProdutoOrc.QtdProduto then
          GMapa.FormataCelula(VpfColuna,VpfColuna,GMapa.ALinha,GMapa.ALinha,GMapa.Font.Size,FPrincipal.CorFoco.AFonteTituloGrid.Name,clRed,false,
                        False,GMapa.Color,taLeftJustify,vaCenter,bcComBorda,clblack);
        if VpfDProFornecedor.QtdProduto <> 0 then
          GMapa.Cells[vpfColuna,GMapa.ALinha]:= FormatFloat(Varia.MascaraQtd,VpfDProFornecedor.QtdProduto)
        else
          GMapa.Cells[VpfColuna,GMapa.ALinha]:= '';
        VpfValLiquido := VpfDProFornecedor.ValUnitario;
        if CIPI.Checked  then
          VpfValLiquido := VpfValLiquido + (VpfDProFornecedor.ValUnitario *(VpfDProFornecedor.PerIPI/100));
        if CICMS.Checked then
          VpfValLiquido := VpfValLiquido - (VpfDProFornecedor.ValUnitario *(VpfDProFornecedor.PerICMS/100));

        if VpfDProFornecedor.IndMenorPreco then
          GMapa.FormataCelula(VpfColuna+1,VpfColuna+1,GMapa.ALinha,GMapa.ALinha,GMapa.Font.Size,FPrincipal.CorFoco.AFonteTituloGrid.Name,clGreen,false,
                        False,GMapa.Color,taLeftJustify,vaCenter,bcComBorda,clblack);
        if VpfValLiquido <> 0 then
          GMapa.Cells[vpfColuna+1,GMapa.ALinha]:= FormatFloat(Varia.MascaraValorUnitario,VpfValLiquido)
        else
          GMapa.Cells[vpfColuna+1,GMapa.ALinha]:= '';
      end;

    end;
  end;
end;

{******************************************************************************}
procedure TFMapaCompras.GMapaCellClick(Button: TMouseButton; Shift: TShiftState; VpaColuna, VpaLinha: Integer);
begin
  if (VpaLinha = 1) and (VpaColuna = 1) then //seleciona ou desseleciona todas as linhas
  begin
    if (GMapa.Cells[1,VpaLinha] = '0') or (GMapa.Cells[1,VpaLinha] = '') then
    begin
      GMapa.Cells[1,VpaLinha] := '1';
      SelecionaTodasAsLinhas(true)
    end
    else
    begin
      SelecionaTodasAsLinhas(false);
      GMapa.Cells[1,VpaLinha] := '0';
    end;
  end
  else
  if (VpaLinha > 1) and (VprDMapa.Produtos.Count > 0) then
  begin
    if GMapa.Cells[1,VpaLinha] = '0' then
    begin
      GMapa.Cells[1,VpaLinha]:= '1';
      TRBDOrcamentoCompraProduto(VprDMapa.Produtos.Items[VpaLinha-2]).IndMarcado := true;
    end
    else
    begin
      TRBDOrcamentoCompraProduto(VprDMapa.Produtos.Items[VpaLinha-2]).IndMarcado := false;
      GMapa.Cells[1,VpaLinha]:= '0';
    end;
  end;
end;

{******************************************************************************}
procedure TFMapaCompras.GMapaDblClick(Sender: TObject);
var
  VpfIndiceFornecedor,VpfColuna,VpfLinha : Integer;
  VpfCellCoord : TGridCoord;
begin
  GMapa.MouseToCell(VprX,VprY,VpfColuna,VpfLinha);
  if (VpfLinha = 0) and (VpfColuna > 6 ) then
  begin
    VpfIndiceFornecedor := VpfColuna - 6;
    if (VpfIndiceFornecedor mod 2) > 0 then
      inc(VpfIndiceFornecedor);
    VpfIndiceFornecedor := (VpfIndiceFornecedor div 2) - 1;
    GeraPedidoCompra(TRBDOrcamentoCompraFornecedor(VprDMapa.Fornecedores.Items[VpfIndiceFornecedor]).CodFornecedor);
  end;
end;

{******************************************************************************}
procedure TFMapaCompras.GMapaMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  VprX := X;
  VprY := Y;
end;

{******************************************************************************}
function TFMapaCompras.MostraMapaCompras(VpaCodFilial, VpaSeqOrcamento: Integer): boolean;
begin
  VprCodFilial := VpaCodFilial;
  VprSeqOrcamento := VpaSeqOrcamento;
  AtualizaConsulta;
  showmodal;
end;

{******************************************************************************}
procedure TFMapaCompras.SelecionaTodasAsLinhas(VpaSelecionar : Boolean);
var
  VpfLaco : Integer;
begin
  for VpfLaco := 0 to VprDMapa.Produtos.Count - 1 do
    TRBDOrcamentoCompraProduto(VprDMapa.Produtos.Items[VpfLaco]).IndMarcado := VpaSelecionar;
  GMapa.CarregaGrade;
end;

{ *************************************************************************** }
procedure TFMapaCompras.AtualizaConsulta;
begin
  VprDMapa.Free;
  VprDMapa := TRBDOrcamentoCompraCorpo.cria;
  FunOrcamentoCompra.CarDOrcamento(VprCodFilial,VprSeqOrcamento,VprDMapa);
  FunOrcamentoCompra.AtualizaMenorPreco(VprDMapa,CFrete.Checked,CIPI.Checked,CICMS.Checked);
  if ESituacao.ItemIndex = 0 then
    FunOrcamentoCompra.ApagaProdutosComprados(VprDMapa);
  GMapa.ADados := VprDMapa.Produtos;
  GMapa.CarregaGrade;
  CarTitulosGrade;
end;

{******************************************************************************}
procedure TFMapaCompras.BFecharClick(Sender: TObject);
begin
  VprDMapa.Free;
  close;
end;

{******************************************************************************}
procedure TFMapaCompras.BGerarPedidoClick(Sender: TObject);
var
  VpfCodFornecedor : Integer;
begin
  FSelecionaFornecedorMapaCompras := TFSelecionaFornecedorMapaCompras.criarSDI(Application,'',FPrincipal.VerificaPermisao('FSelecionaFornecedorMapaCompras'));
  VpfCodFornecedor := FSelecionaFornecedorMapaCompras.SelecionarFornecedor(VprDMapa);
  FSelecionaFornecedorMapaCompras.free;
  if VpfCodFornecedor <> 0 then
    GeraPedidoCompra(VpfCodFornecedor);
end;

{******************************************************************************}
procedure TFMapaCompras.CarTitulosGrade;
var
  vpflaco, VpfColuna : Integer;
  VpfDFornecedorOrc : TRBDOrcamentoCompraFornecedor;
  VpfCorfonte : TColor;
begin
  GMapa.Cells[2,1] := 'Código';
  GMapa.Cells[3,1] := 'Produto';
  GMapa.Cells[4,1] := 'Código';
  GMapa.Cells[5,1] := 'Cor';
  GMapa.Cells[6,1] := 'Quantidade Orçada';
  GMapa.ColCount := QTDColunasFixas+1+ (VprDMapa.Fornecedores.Count *2);
  for VpfLaco := 0 to VprDMapa.Fornecedores.Count - 1 do
  begin
    VpfDFornecedorOrc := TRBDOrcamentoCompraFornecedor(VprDMapa.Fornecedores.Items[Vpflaco]);
    if (vpflaco mod 2 ) = 0 then
      VpfCorfonte := clblue
    else
      VpfCorfonte := clblack;
    VpfColuna := QTDColunasFixas+1+(vpflaco *2);

    GMapa.FormataCelula(VpfColuna,VpfColuna+1,0,0,FPrincipal.CorFoco.AFonteTituloGrid.Size,
                        FPrincipal.CorFoco.AFonteTituloGrid.Name,VpfCorFonte,false,
                        False,GMapa.FixedColor,taLeftJustify,vaCenter,bcComBorda,clblack);
    GMapa.ColWidths[vpfcoluna] := 60;
    GMapa.ColWidths[vpfcoluna+1] := 80;
    GMapa.MesclarCelulas(VpfColuna,VpfColuna+1,0,0);
    GMapa.Cells[VpfColuna,0] := VpfDFornecedorOrc.NomFornecedor;
  end;
end;

{******************************************************************************}
procedure TFMapaCompras.CFreteClick(Sender: TObject);
begin
  FunOrcamentoCompra.AtualizaMenorPreco(VprDMapa,CFrete.Checked,CIPI.Checked,CICMS.Checked);
  GMapa.CarregaGrade;
end;

{******************************************************************************}
procedure TFMapaCompras.ConfiguraTela;
begin
 if not Config.EstoquePorCor then
  begin
    GMapa.ColWidths[4] := -1;
    GMapa.ColWidths[5] := -1;
    GMapa.TabStops[4] := false;
    GMapa.TabStops[5] := false;
  end;
end;

procedure TFMapaCompras.ESituacaoClick(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFMapaCompras.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunOrcamentoCompra.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFMapaCompras]);
end.
