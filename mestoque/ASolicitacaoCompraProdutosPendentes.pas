unit ASolicitacaoCompraProdutosPendentes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  UnSolicitacaoCompra, Menus, PainelGradiente, StdCtrls, Buttons, Grids, CGrades, Componentes1, ExtCtrls, UnDados, UnProdutos,
  Constmsg, DB, DBClient, Tabela, CBancoDados, DBGrids, DBKeyViolation;

type
  TFSolicitacaoCompraProdutosPendentes = class(TFormularioPermissao)
    PanelColor1: TPanelColor;
    PainelGradiente1: TPainelGradiente;
    BFechar: TBitBtn;
    BGerarPedido: TBitBtn;
    PopupMenu1: TPopupMenu;
    ConsultaOrcamentoCompra1: TMenuItem;
    BGeraOrcamentoCompra: TBitBtn;
    PanelColor2: TPanelColor;
    N1: TMenuItem;
    MOrdenaPorClassificacao: TMenuItem;
    N2: TMenuItem;
    ConsultaFornecedores1: TMenuItem;
    N3: TMenuItem;
    ConsultaHistoricodeCompras1: TMenuItem;
    Grade: TRBStringGridColor;
    EDescricaoTecnica: TMemoColor;
    GItens: TGridIndice;
    SelectCompras: TRBSQL;
    DataSelectCompras: TDataSource;
    SelectComprasCODFILIAL: TFMTBCDField;
    SelectComprasSEQPEDIDO: TFMTBCDField;
    SelectComprasDATPEDIDO: TSQLTimeStampField;
    SelectComprasI_COD_CLI: TFMTBCDField;
    SelectComprasC_NOM_CLI: TWideStringField;
    SelectComprasQTDPRODUTO: TFMTBCDField;
    SelectComprasVALUNITARIO: TFMTBCDField;
    SelectComprasPERIPI: TFMTBCDField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure GradeCellClick(Button: TMouseButton; Shift: TShiftState;
      VpaColuna, VpaLinha: Integer);
    procedure GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure BGerarPedidoClick(Sender: TObject);
    procedure ConsultaOrcamentoCompra1Click(Sender: TObject);
    procedure BGeraOrcamentoCompraClick(Sender: TObject);
    procedure MOrdenaPorClassificacaoClick(Sender: TObject);
    procedure GradeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ConsultaFornecedores1Click(Sender: TObject);
    procedure ConsultaHistoricodeCompras1Click(Sender: TObject);
  private
    VprAcao: Boolean;
    VprListaOrcamentos: TList;
    VprProdutosPendentes: TList;
    VprProdutosFinalizados: TList;
    VprDProdutoPendente: TRBDProdutoPendenteCompra;
    FunSolicitacao: TRBFunSolicitacaoCompra;
    procedure ConfiguraPermissaoUsuario;
    procedure CarTitulosGrade;
    procedure ConsultaOrcamentos;
    procedure AtualizaConsultaItens(VpaSeqProduto: integer);
  public
    function CarregarProdutosPendentes: Boolean;
  end;

var
  FSolicitacaoCompraProdutosPendentes: TFSolicitacaoCompraProdutosPendentes;

implementation

uses
  Constantes, FunObjeto, APrincipal, ANovoPedidoCompra, FunNumeros,
  APedidosCompraAberto, ANovaSolicitacaoCompra, ANovoOrcamentoCompra, ALocalizaProdutos, ANovoProdutoPro, APedidoCompra;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFSolicitacaoCompraProdutosPendentes.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao:= False;
  VprListaOrcamentos:= TList.Create;
  VprProdutosPendentes:= TList.Create;
  VprProdutosFinalizados:= TList.Create;
  FunSolicitacao := TRBFunSolicitacaoCompra.Cria(FPrincipal.BaseDados);
  ConfiguraPermissaoUsuario;

  CarTitulosGrade;
end;

procedure TFSolicitacaoCompraProdutosPendentes.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
Var
  VpfSeqProduto : Integer;
  VpfLaco : Integer;
begin
  if Key = 114 then
  begin
    FlocalizaProduto := TFlocalizaProduto.CriarSDI(self,'',true);
    if FlocalizaProduto.LocalizaProduto(VpfSeqProduto) then
    begin
      for vpflaco := 0 to VprProdutosPendentes.Count - 1 do
      begin
        if VpfSeqProduto = TRBDProdutoPendenteCompra(VprProdutosPendentes.Items[VpfLaco]).SeqProduto then
        begin
          Grade.Row := VpfLaco +1;
          break;
        end;
      end;
    end;
    FlocalizaProduto.free;
  end;

end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFSolicitacaoCompraProdutosPendentes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }

  FunSolicitacao.Free;

  FreeTObjectsList(VprProdutosPendentes);
  VprProdutosPendentes.Free;

  FreeTObjectsList(VprListaOrcamentos);
  VprListaOrcamentos.Free;

  FreeTObjectsList(VprProdutosFinalizados);
  VprProdutosFinalizados.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
function TFSolicitacaoCompraProdutosPendentes.CarregarProdutosPendentes: Boolean;
begin
  FunSolicitacao.CarregarListaOrcamentos(Varia.CodigoEmpFil, Varia.EstagioOrcamentoCompraAprovado,VprListaOrcamentos);
  FunSolicitacao.AgruparProdutosPendentes(VprListaOrcamentos,VprProdutosPendentes);

  Grade.ADados:= VprProdutosPendentes;
  Grade.CarregaGrade;

  ShowModal;
  Result:= VprAcao;
end;

{******************************************************************************}
procedure TFSolicitacaoCompraProdutosPendentes.ConfiguraPermissaoUsuario;
begin
  if not config.EstoquePorCor then
  begin
    Grade.ColWidths[4] := -1;
    Grade.ColWidths[5] := -1;
    Grade.ColWidths[3] := RetornaInteiro(Grade.ColWidths[3] *1.9);
  end;
  if not config.ControlarEstoquedeChapas then
  begin
    Grade.ColWidths[10] := -1;
    Grade.ColWidths[11] := -1;
    Grade.ColWidths[12] := -1;
  end;
end;

{******************************************************************************}
procedure TFSolicitacaoCompraProdutosPendentes.CarTitulosGrade;
begin
  Grade.Cells[2,0]:= 'Código';
  Grade.Cells[3,0]:= 'Produto';
  Grade.Cells[4,0]:= 'Código';
  Grade.Cells[5,0]:= 'Cor';
  Grade.Cells[6,0]:= 'Qtd Utilizada';
  Grade.Cells[7,0]:= 'Qtd Aprovada';
  Grade.Cells[8,0]:= 'UM';
  Grade.Cells[9,0]:= 'Data Aprovação';
  Grade.Cells[10,0]:= 'Qtd Chapa';
  Grade.Cells[11,0]:= 'Largura';
  Grade.Cells[12,0]:= 'Comprimento';
  Grade.Cells[13,0]:= 'Qtd Estoque';

  if Config.SomenteCampoQtdAprovadaSolicitacaoCompra then
    Grade.ColWidths[6]:= -1;
end;

{******************************************************************************}
procedure TFSolicitacaoCompraProdutosPendentes.AtualizaConsultaItens(VpaSeqProduto: integer);
begin
  SelectCompras.close;
  SelectCompras.sql.clear;
  SelectCompras.sql.add('SELECT PED.CODFILIAL, PED.SEQPEDIDO, PED.DATPEDIDO, ' +
                        ' CLI.I_COD_CLI, CLI.C_NOM_CLI, ' +
                        ' ITE.QTDPRODUTO, ITE.VALUNITARIO, ITE.PERIPI ' +
                        ' FROM PEDIDOCOMPRACORPO PED, PEDIDOCOMPRAITEM ITE, CADCLIENTES CLI ' +
                        ' WHERE PED.CODCLIENTE = CLI.I_COD_CLI ' +
                        ' AND PED.CODFILIAL = ITE.CODFILIAL ' +
                        ' AND PED.SEQPEDIDO = ITE.SEQPEDIDO ' +
                        ' AND ITE.SEQPRODUTO = ' + IntToStr(VpaSeqProduto) +
                        ' ORDER BY DATPEDIDO DESC ');
  SelectCompras.open;
end;

{******************************************************************************}
procedure TFSolicitacaoCompraProdutosPendentes.BFecharClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFSolicitacaoCompraProdutosPendentes.GradeCellClick(
  Button: TMouseButton; Shift: TShiftState; VpaColuna, VpaLinha: Integer);
begin
  if (VpaLinha >= 1) and (VprProdutosPendentes.Count > 0) then
  begin
    if Grade.Cells[1,VpaLinha] = '0' then
    begin
      Grade.Cells[1,VpaLinha]:= '1';
      TRBDProdutoPendenteCompra(VprProdutosPendentes.Items[VpaLinha - 1]).IndMarcado:= True;
    end
    else
    begin
      TRBDProdutoPendenteCompra(VprProdutosPendentes.Items[VpaLinha - 1]).IndMarcado:= False;
      Grade.Cells[1,VpaLinha]:= '0';
    end;
  end;
end;

procedure TFSolicitacaoCompraProdutosPendentes.GradeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
end;

{******************************************************************************}
procedure TFSolicitacaoCompraProdutosPendentes.GradeCarregaItemGrade(
  Sender: TObject; VpaLinha: Integer);
begin
  VprDProdutoPendente:= TRBDProdutoPendenteCompra(VprProdutosPendentes.Items[VpaLinha-1]);
  if VprDProdutoPendente.IndMarcado then
    Grade.Cells[1,VpaLinha]:= '1'
  else
    Grade.Cells[1,VpaLinha]:= '0';
  Grade.Cells[2,VpaLinha]:= VprDProdutoPendente.CodProduto;
  Grade.Cells[3,VpaLinha]:= VprDProdutoPendente.NomProduto;
  if VprDProdutoPendente.CodCor <> 0 then
    Grade.Cells[4,VpaLinha]:= IntToStr(VprDProdutoPendente.CodCor)
  else
    Grade.Cells[4,VpaLinha]:= '';
  Grade.Cells[5,VpaLinha]:= VprDProdutoPendente.NomCor;
  if VprDProdutoPendente.QtdUtilizada <> 0 then
    Grade.Cells[6,VpaLinha]:= FormatFloat(Varia.MascaraQtd,VprDProdutoPendente.QtdUtilizada - VprDProdutoPendente.QtdComprada )
  else
    Grade.Cells[6,VpaLinha]:= '';
  if VprDProdutoPendente.QtdAprovada <> 0 then
    Grade.Cells[7,VpaLinha]:= FormatFloat(Varia.MascaraQtd,VprDProdutoPendente.QtdAprovada - VprDProdutoPendente.QtdComprada)
  else
    Grade.Cells[7,VpaLinha]:= '';
  Grade.Cells[8,VpaLinha]:= VprDProdutoPendente.DesUM;
  Grade.Cells[9,VpaLinha] := FormatDateTime('DD/MM/YYYY',VprDProdutoPendente.DatAprovacao);
  if VprDProdutoPendente.QtdChapa <> 0 then
    Grade.Cells[10,VpaLinha]:= FormatFloat('#,###,##0',VprDProdutoPendente.QtdChapa)
  else
    Grade.Cells[10,VpaLinha]:= '';
  if VprDProdutoPendente.LarChapa <> 0 then
    Grade.Cells[11,VpaLinha]:= FormatFloat('#,###,##0',VprDProdutoPendente.LarChapa)
  else
    Grade.Cells[11,VpaLinha]:= '';
  if VprDProdutoPendente.ComChapa <> 0 then
    Grade.Cells[12,VpaLinha]:= FormatFloat('#,###,##0',VprDProdutoPendente.ComChapa)
  else
    Grade.Cells[12,VpaLinha]:= '';
  if VprDProdutoPendente.QtdEstoque <> 0 then
    Grade.Cells[13,VpaLinha]:= FormatFloat('#,###,##0',VprDProdutoPendente.QtdEstoque)
  else
    Grade.Cells[13,VpaLinha]:= '';
end;

{******************************************************************************}
procedure TFSolicitacaoCompraProdutosPendentes.GradeMudouLinha(
  Sender: TObject; VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprProdutosPendentes.Count > 0 then
  begin
    VprDProdutoPendente:= TRBDProdutoPendenteCompra(VprProdutosPendentes.Items[VpaLinhaAtual-1]);
    EDescricaoTecnica.Lines.Text := VprDProdutoPendente.DesTecnica;
    AtualizaConsultaItens(VprDProdutoPendente.SeqProduto);
  end;
end;

{******************************************************************************}
procedure TFSolicitacaoCompraProdutosPendentes.MOrdenaPorClassificacaoClick(Sender: TObject);
begin
  MOrdenaPorClassificacao.Checked := not MOrdenaPorClassificacao.Checked;
  FunSolicitacao.OrdenaProdutosPendentesPorClassificacao(VprProdutosPendentes);
  Grade.CarregaGrade;
end;

{******************************************************************************}
procedure TFSolicitacaoCompraProdutosPendentes.BGerarPedidoClick(Sender: TObject);
var
  VpfProdutosPedido, VpfFracoesOP : TList;
begin
  VpfProdutosPedido:= TList.Create;
  VpfFracoesOP :=  TList.Create;

  FunSolicitacao.CarProdutosSelecionados(VprProdutosPendentes,VpfProdutosPedido,VprProdutosFinalizados,VpfFracoesOP,false);

  if VpfProdutosPedido.Count > 0 then
  begin
    FNovoPedidoCompra:= TFNovoPedidoCompra.criarSDI(Application,'',True);
    if FNovoPedidoCompra.NovoPedidoProdutosPendentes(VpfProdutosPedido,VpfFracoesOP,VprProdutosPendentes,VprProdutosFinalizados) then
    begin
      VprAcao:= True;
      Grade.CarregaGrade;
    end;
    FNovoPedidoCompra.Free;
  end;
  FreeTObjectsList(VpfProdutosPedido);
  VpfFracoesOP.free;
  VpfProdutosPedido.Free;
end;

{******************************************************************************}
procedure TFSolicitacaoCompraProdutosPendentes.ConsultaOrcamentos;
var
  VpfLaco : Integer;
  VpfDSolicitacaoCompra : TRBDSolicitacaoCompraCorpo;
begin
  for VpfLaco := 0 to VprDProdutoPendente.SolicitacoesCompra.Count - 1 do
  begin
    VpfDSolicitacaoCompra := TRBDSolicitacaoCompraCorpo(VprDProdutoPendente.SolicitacoesCompra.Items[VpfLaco]);
    FNovaSolicitacaoCompras := TFNovaSolicitacaoCompras.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoOrcamentoCompras'));
    FNovaSolicitacaoCompras.Consultar(VpfDSolicitacaoCompra.CodFilial,VpfDSolicitacaoCompra.SeqSolicitacao);
    FNovaSolicitacaoCompras.free;
  end;
end;

{******************************************************************************}
procedure TFSolicitacaoCompraProdutosPendentes.ConsultaFornecedores1Click(Sender: TObject);
begin
  if VprProdutosPendentes.Count > 0 then
  begin
    FnovoProdutoPro := TFnovoProdutoPro.criarSDI(Application,'',FPrincipal.VerificaPermisao('FnovoProdutoPro'));
    FnovoProdutoPro.ConsultaFornecedores(varia.CodigoEmpresa,varia.CodigoEmpFil,VprDProdutoPendente.SeqProduto);
    FnovoProdutoPro.free;
  end;
end;

procedure TFSolicitacaoCompraProdutosPendentes.ConsultaHistoricodeCompras1Click(Sender: TObject);
begin
  if VprProdutosPendentes.Count > 0 then
  begin
    FPedidoCompra := TFPedidoCompra.criarSDI(Application,'',FPrincipal.VerificaPermisao('FPedidoCompra'));
    FPedidoCompra.ConsultaProduto(VprDProdutoPendente.SeqProduto);
    FPedidoCompra.free;
  end;
end;

{******************************************************************************}
procedure TFSolicitacaoCompraProdutosPendentes.ConsultaOrcamentoCompra1Click(
  Sender: TObject);
begin
  if VprProdutosPendentes.Count > 0 then
  begin
    ConsultaOrcamentos;
  end

end;

{******************************************************************************}
procedure TFSolicitacaoCompraProdutosPendentes.BGeraOrcamentoCompraClick(
  Sender: TObject);
var
  VpfProdutosPedido, VpfFracoesOP : TList;
begin
  VpfProdutosPedido:= TList.Create;
  VpfFracoesOP :=  TList.Create;

  FunSolicitacao.CarProdutosSelecionados(VprProdutosPendentes,VpfProdutosPedido,VprProdutosFinalizados,VpfFracoesOP,true);

  if VpfProdutosPedido.Count > 0 then
  begin
    FNovoOrcamentoCompra:= TFNovoOrcamentoCompra.criarSDI(Application,'',True);
    if FNovoOrcamentoCompra.NovoOrcamentoProdutosPendentes(VpfProdutosPedido,VpfFracoesOP,VprProdutosPendentes,VprProdutosFinalizados) then
    begin
      VprAcao:= True;
      Grade.CarregaGrade;
    end;
    FNovoOrcamentoCompra.Free;
  end;
  FreeTObjectsList(VpfProdutosPedido);
  VpfFracoesOP.free;
  VpfProdutosPedido.Free;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFSolicitacaoCompraProdutosPendentes]);
end.
