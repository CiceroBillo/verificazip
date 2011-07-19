unit APedidosCompraAberto;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Buttons, Grids, unDados,
  DBGrids, Tabela, DBKeyViolation, Db, DBTables, Mask, numericos, UnSolicitacaoCompra,
  UnPedidoCompra, DBClient;

type
  TFPedidosCompraAberto = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BFechar: TBitBtn;
    PanelColor3: TPanelColor;
    BUtilizarSaldo: TBitBtn;
    BAlterarPedido: TBitBtn;
    Grade: TGridIndice;
    PEDIDOCOMPRACORPO: TSQL;
    DataPEDIDOCOMPRACORPO: TDataSource;
    Label1: TLabel;
    EProduto: TEditColor;
    SpeedButton1: TSpeedButton;
    LNomProduto: TLabel;
    Label2: TLabel;
    EQuantidade: Tnumerico;
    Label3: TLabel;
    ECor: TEditColor;
    SpeedButton2: TSpeedButton;
    LNomCor: TLabel;
    LDesUM: TLabel;
    PEDIDOCOMPRACORPOQTDSALDO: TFMTBCDField;
    PEDIDOCOMPRACORPODESUM: TWideStringField;
    PEDIDOCOMPRACORPOQTDSOLICITADA: TFMTBCDField;
    PEDIDOCOMPRACORPOQTDPRODUTO: TFMTBCDField;
    PEDIDOCOMPRACORPOCODFILIAL: TFMTBCDField;
    PEDIDOCOMPRACORPOSEQPEDIDO: TFMTBCDField;
    PEDIDOCOMPRACORPODATPEDIDO: TSQLTimeStampField;
    PEDIDOCOMPRACORPODATPREVISTA: TSQLTimeStampField;
    PEDIDOCOMPRACORPOC_NOM_CLI: TWideStringField;
    PEDIDOCOMPRACORPOSEQPRODUTO: TFMTBCDField;
    PEDIDOCOMPRACORPOCODCOR: TFMTBCDField;
    PEDIDOCOMPRACORPOSEQITEM: TFMTBCDField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GradeOrdem(Ordem: String);
    procedure BFecharClick(Sender: TObject);
    procedure BUtilizarSaldoClick(Sender: TObject);
    procedure BAlterarPedidoClick(Sender: TObject);
  private
    VprOrdem: String;
    VprProdutosFinalizados: TList;
    VprDProdutoPendente: TRBDProdutoPendenteCompra;
    FunPedidoCompra: TRBFunPedidoCompra;
    FunOrcamento: TRBFunSolicitacaoCompra;
    procedure InicializaTela;
    procedure CarDTela(VpaDProdutoPendente: TRBDProdutoPendenteCompra);
    procedure AtualizaConsulta;
    procedure AdicionaFiltros(VpaSelect: TStrings);
    function UtilizarSaldo: String;
  public
    procedure AtualizaPedidoCompraAberto(VpaDProdutoPendente: TRBDProdutoPendenteCompra);
  end;

var
  FPedidosCompraAberto: TFPedidosCompraAberto;

implementation
uses
  APrincipal, Constantes, ConstMsg, FunObjeto, ANovoPedidoCompra;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFPedidosCompraAberto.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprOrdem:= '';
  FunOrcamento:= TRBFunSolicitacaoCompra.Cria(FPrincipal.BaseDados);
  FunPedidoCompra:= TRBFunPedidoCompra.Cria(FPrincipal.BaseDados);
  VprProdutosFinalizados:= TList.Create;
  InicializaTela;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFPedidosCompraAberto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunOrcamento.Free;
  FunPedidoCompra.Free;
  FreeTObjectsList(VprProdutosFinalizados);
  VprProdutosFinalizados.Free;
  PEDIDOCOMPRACORPO.Close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFPedidosCompraAberto.BFecharClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFPedidosCompraAberto.InicializaTela;
begin
  EProduto.Text:= '';
  ECor.Text:= '';
  EQuantidade.Text:= '';
  LNomProduto.Caption:= '';
  LNomCor.Caption:= '';
  LDesUM.Caption:= '';
end;

{******************************************************************************}
procedure TFPedidosCompraAberto.CarDTela(VpaDProdutoPendente: TRBDProdutoPendenteCompra);
begin
  EProduto.Text:= VpaDProdutoPendente.CodProduto;
  LNomProduto.Caption:= VpaDProdutoPendente.NomProduto;
  ECor.AInteiro:= VpaDProdutoPendente.CodCor;
  LNomCor.Caption:= VpaDProdutoPendente.NomCor;
  EQuantidade.AValor:= VpaDProdutoPendente.QtdAprovada;
  LDesUM.Caption:= VpaDProdutoPendente.DesUM;
end;

{******************************************************************************}
procedure TFPedidosCompraAberto.AtualizaPedidoCompraAberto(VpaDProdutoPendente: TRBDProdutoPendenteCompra);
begin
  VprDProdutoPendente:= VpaDProdutoPendente;
  CarDTela(VpaDProdutoPendente);

  AtualizaConsulta;
  if not PEDIDOCOMPRACORPO.Eof then
    ShowModal;
end;

{******************************************************************************}
procedure TFPedidosCompraAberto.AtualizaConsulta;
begin
  PEDIDOCOMPRACORPO.Close;
  PEDIDOCOMPRACORPO.SQL.Clear;
  PEDIDOCOMPRACORPO.SQL.Add('SELECT'+
                            ' PCI.SEQITEM, PCI.SEQPRODUTO, PCI.CODCOR, (PCI.QTDPRODUTO - PCI.QTDSOLICITADA) QTDSALDO, PCI.DESUM, PCI.QTDSOLICITADA,'+
                            ' PCI.QTDPRODUTO, PCI.CODFILIAL, PCI.SEQPEDIDO, PCC.DATPEDIDO, PCC.DATPREVISTA,'+
                            ' CLI.C_NOM_CLI'+
                            ' FROM PEDIDOCOMPRAITEM PCI, PEDIDOCOMPRACORPO PCC, CADCLIENTES CLI,'+
                            ' CADPRODUTOS PRO'+
                            ' WHERE'+
                            ' PCI.CODFILIAL = '+IntToStr(Varia.CodigoEmpFil)+
                            ' AND PCC.CODESTAGIO = '+IntToStr(Varia.EstagioComprasAguardandoEntregaFornecedor)+
                            ' AND PCI.CODFILIAL = PCC.CODFILIAL'+
                            ' AND PCI.SEQPEDIDO = PCC.SEQPEDIDO'+
                            ' AND CLI.I_COD_CLI = PCC.CODCLIENTE'+
                            ' AND PCI.SEQPRODUTO = PRO.I_SEQ_PRO');
  AdicionaFiltros(PEDIDOCOMPRACORPO.SQL);
  PEDIDOCOMPRACORPO.SQL.Add(VprOrdem);
  Grade.ALinhaSQLOrderBy:= PEDIDOCOMPRACORPO.SQL.Count-1;
  PEDIDOCOMPRACORPO.Open;
end;

{******************************************************************************}
procedure TFPedidosCompraAberto.AdicionaFiltros(VpaSelect: TStrings);
begin
  VpaSelect.Add(' AND PRO.I_SEQ_PRO = '+IntToStr(VprDProdutoPendente.SeqProduto));
  if ECor.AInteiro <> 0 then
    VpaSelect.Add(' AND PCI.CODCOR = '+IntToStr(VprDProdutoPendente.CodCor));
end;

{******************************************************************************}
procedure TFPedidosCompraAberto.GradeOrdem(Ordem: String);
begin
  VprOrdem:= Ordem;
end;

{******************************************************************************}
procedure TFPedidosCompraAberto.BUtilizarSaldoClick(Sender: TObject);
var
  VpfResultado: String;
begin
  VpfResultado:= UtilizarSaldo;
  if VpfResultado <> '' then
    aviso(VpfResultado);
end;

{******************************************************************************}
function TFPedidosCompraAberto.UtilizarSaldo: String;
begin
  Result:= '';
  PEDIDOCOMPRACORPO.First;
  while not PEDIDOCOMPRACORPO.Eof do
  begin
    if PEDIDOCOMPRACORPOQTDSALDO.AsFloat > 0 then
    begin
      Result:= FunPedidoCompra.AjustarQuantidadesProdutoPedidoCompra(PEDIDOCOMPRACORPOCODFILIAL.AsInteger,
                                                                     PEDIDOCOMPRACORPOSEQPEDIDO.AsInteger,
                                                                     PEDIDOCOMPRACORPOSEQITEM.AsInteger,
                                                                     VprDProdutoPendente);

      if VprDProdutoPendente.QtdAprovada <= 0 then
        PEDIDOCOMPRACORPO.Last;
    end;
    PEDIDOCOMPRACORPO.Next;
  end;
  if VprDProdutoPendente.QtdAprovada = 0 then
    Close;
  CarDTela(VprDProdutoPendente);
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFPedidosCompraAberto.BAlterarPedidoClick(Sender: TObject);
begin
  FNovoPedidoCompra:= TFNovoPedidoCompra.CriarSDI(Application,'',True);
  if FNovoPedidoCompra.Alterar(Varia.CodigoEmpFil,PEDIDOCOMPRACORPOSEQPEDIDO.AsInteger) then
    AtualizaConsulta;
  FNovoPedidoCompra.Free;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
  RegisterClasses([TFPedidosCompraAberto]);
end.

