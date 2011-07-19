unit APontoPedido;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Grids, DBGrids, Tabela, BotaoCadastro, StdCtrls, Buttons, Componentes1,
  ExtCtrls, PainelGradiente, Localizacao, Db, DBTables, ComCtrls,
  DBKeyViolation, unProdutos, UnDadosProduto, DBClient, UnDados, UnSolicitacaoCompra;

type
  TFPontoPedido = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BFechar: TBitBtn;
    Localiza: TConsultaPadrao;
    PanelColor3: TPanelColor;
    Grade: TGridIndice;
    Produtos: TSQL;
    DataProdutos: TDataSource;
    RPontoPedido: TRadioButton;
    RQdadeMinima: TRadioButton;
    CAtividade: TCheckBox;
    CNulo: TCheckBox;
    Label8: TLabel;
    EClassificacao: TEditLocaliza;
    SpeedButton1: TSpeedButton;
    Label4: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Aux: TSQL;
    RMostrarTodos: TRadioButton;
    Label3: TLabel;
    Label5: TLabel;
    SpeedButton2: TSpeedButton;
    Label6: TLabel;
    EFornecedor: TEditLocaliza;
    ProdutosN_QTD_PRO: TFMTBCDField;
    ProdutosN_QTD_MIN: TFMTBCDField;
    ProdutosN_QTD_PED: TFMTBCDField;
    ProdutosC_NOM_PRO: TWideStringField;
    ProdutosC_COD_UNI: TWideStringField;
    ProdutosI_SEQ_PRO: TFMTBCDField;
    ProdutosC_COD_BAR: TWideStringField;
    ProdutosC_COD_PRO: TWideStringField;
    ProdutosNOM_COR: TWideStringField;
    ProdutosCOD_COR: TFMTBCDField;
    BGeraSolicitacaoCompra: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure EClassificacaoSelect(Sender: TObject);
    procedure GradeOrdem(Ordem: String);
    procedure CAtividadeClick(Sender: TObject);
    procedure EClassificacaoRetorno(Retorno1, Retorno2: String);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BGeraSolicitacaoCompraClick(Sender: TObject);
  private
    VprOrdem : string;
    VprDOrcamentoItens: TRBDSolicitacaoCompraItem;
    procedure AtualizaConsulta;
    procedure AdicionaFiltros(VpaSElect : TStrings);
    procedure AlteraQtdMinima;
    procedure AlteraQtdPedido;
    procedure AlteraQtdEstoque;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPontoPedido: TFPontoPedido;

implementation

uses APrincipal, Constantes, FunSql, ConstMsg, ANovoCliente, fundata,
  funSistema, FunString, ANovoPedidoCompra, ANovaSolicitacaoCompra;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFPontoPedido.FormCreate(Sender: TObject);
begin
  Grade.Columns[0].FieldName := varia.CodigoProduto;
  VprOrdem := ' order by pro.C_COD_PRO ';
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFPontoPedido.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Produtos.close;
   Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações do Localiza
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{*************Carrega a Select para localizar e Validar o produto**************}
procedure TFPontoPedido.EClassificacaoSelect(Sender: TObject);
begin
   EClassificacao.ASelectValida.clear;
   EClassificacao.ASelectValida.add( 'Select * from CadClassificacao'+
                                    ' where I_Cod_Emp = ' + IntToStr(varia.CodigoEmpresa) +
                                    ' and c_Cod_Cla = ''@''' +
                                    ' and c_tip_cla = ''P''' +
                                    ' and c_Con_cla = ''S'' ' );
   EClassificacao.ASelectLocaliza.Clear;
   EClassificacao.ASelectLocaliza.add( 'Select * from cadClassificacao'+
                                      ' where I_Cod_Emp = ' + IntToStr(varia.CodigoEmpresa) +
                                      ' and c_nom_Cla like ''@%'' ' +
                                      ' and c_tip_cla = ''P''' +
                                      ' and c_Con_cla = ''S'' ' +
                                      ' order by c_cod_Cla asc');
end;



{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Acoes do Fornecedor
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

procedure TFPontoPedido.AtualizaConsulta;
var
  VpaTipo, VpaAtividade, VpaClassificacao : string;
  VpfPosicao : TBookmark;
begin
  // monta select ...............
  VpfPosicao := Produtos.GetBookmark;
  Produtos.Close;
  Produtos.sql.clear;
  Produtos.sql.Add(' select ' +
                    ' nvl(mov.n_qtd_pro,0) n_qtd_pro, ' +
                    ' nvl(mov.n_qtd_min,0) n_qtd_min, ' +
                    ' nvl(mov.n_qtd_ped,0) n_qtd_ped, ' +
                    ' pro.c_nom_pro, pro.c_cod_uni, ' +
                    ' mov.i_seq_pro, mov.c_cod_bar, pro.c_cod_pro, ' +
                    ' cor.cod_cor, cor.nom_cor ' +
                    ' from MovQdadeProduto  mov, cadProdutos  pro, cor cor ' +
                    ' Where mov.i_seq_pro = pro.i_seq_pro ' +
                    ' and  mov.i_emp_fil = ' + IntTostr(varia.CodigoEmpFil)+
                    ' and '+SQLTextoRightJoin('PRO.I_COD_COR','COR.COD_COR'));
  AdicionaFiltros(Produtos.sql);
  Produtos.sql.add(VprOrdem);
  Grade.ALinhaSQLOrderBy := Produtos.sql.Count - 1;
  Produtos.open;
  try
    Produtos.GotoBookmark(VpfPosicao);
  except
  end;
  Produtos.FreeBookmark(VpfPosicao);
end;

{******************************************************************************}
procedure TFPontoPedido.AdicionaFiltros(VpaSElect : TStrings);
begin
  if RPontoPedido.Checked then  // caso ponto de pedido ou qdade minima
  begin
    if CNulo.Checked then
       VpaSElect.add('and  isnull(MOV.N_QTD_PRO,0) <= nvl(MOV.N_QTD_PED,0) ')
     else
       VpaSElect.add('and MOV.N_QTD_PRO <= MOV.N_QTD_PED ');
  end
  else
   if RQdadeMinima.Checked then
   begin
     if CNulo.Checked then    // caso valores nulo ou naum
       VpaSElect.add('and isnull(MOV.N_QTD_PRO,0) <= nvl(MOV.N_QTD_MIN,0) ')
     else
       VpaSElect.add('and MOV.N_QTD_PRO <= MOV.N_QTD_MIN ');
   end;

  if CAtividade.Checked then   // caso produto em atividade ou naum
    VpaSElect.add(' and PRO.C_ATI_PRO = ''S''');

  if EClassificacao.Text <> '' then  // filtrar com classificao ou naum
    VpaSElect.add(' and PRO.C_COD_CLA like ''' + EClassificacao.Text + '%''');
  if EFornecedor.AInteiro <> 0 then
    VpaSelect.add(' and exists (Select * from PRODUTOFORNECEDOR PFO '+
                           ' Where PFO.SEQPRODUTO = PRO.I_SEQ_PRO '+
                           ' AND PFO.CODCLIENTE = '+IntToStr(EFornecedor.AInteiro)+
                           ')');
end;


{******************************************************************************}
procedure TFPontoPedido.AlteraQtdMinima;
var
  VpfQtd : string;
begin
  if  EntradaNumero('Quantidade mínima do produto','Quantidade mínima :',VpfQtd,false,PanelColor1.Color,PanelColor1.Color,false) then
  begin
    ExecutaComandoSql(Aux,'UPDATE MOVQDADEPRODUTO '+
                          ' Set N_QTD_MIN = '+ SubstituiStr(DeletaChars(VpfQtd,'.'),',','.')+
                          ' Where I_EMP_FIL = '+inttoStr(varia.CodigoEmpFil)+
                          ' and I_SEQ_PRO = '+ ProdutosI_SEQ_PRO.AsString);
    AtualizaConsulta;
  end;
end;

{******************************************************************************}
procedure TFPontoPedido.AlteraQtdPedido;
var
  VpfQtd : String;
begin
  if  EntradaNumero('Quantidade pedido do produto','Quantidade pedido :',VpfQtd,false,PanelColor1.Color,PanelColor1.Color,false) then
  begin
    ExecutaComandoSql(Aux,'UPDATE MOVQDADEPRODUTO '+
                          ' Set N_QTD_PED = '+ SubstituiStr(DeletaChars(VpfQtd,'.'),',','.')+
                          ' Where I_EMP_FIL = '+inttoStr(varia.CodigoEmpFil)+
                          ' and I_SEQ_PRO = '+ ProdutosI_SEQ_PRO.AsString);
    AtualizaConsulta;
  end;
end;

{******************************************************************************}
procedure TFPontoPedido.AlteraQtdEstoque;
var
  VpfQtdDigitada : String;
  VpfQtd : Double;
  VpfOperacaoEstoque, VpfSeqEstoqueBarra : Integer;
  VpfDProduto : TRBDProduto;
begin
  if  EntradaNumero('Quantidade produto Estoque','Quantidade Produto :',VpfQtdDigitada,false,PanelColor1.Color,PanelColor1.Color,false) then
  begin
    VpfQtd := StrToFloat(VpfQtdDigitada);
    if ProdutosN_QTD_PRO.AsFloat >  VpfQtd then
    begin
      VpfOperacaoEstoque := Varia.OperacaoAcertoEstoqueSaida;
      VpfQtd := ProdutosN_QTD_PRO.AsFloat - VpfQtd;
    end
    else
    begin
      VpfOperacaoEstoque := Varia.OperacaoAcertoEstoqueEntrada;
      VpfQtd := VpfQtd - ProdutosN_QTD_PRO.AsFloat;
    end;
    VpfDProduto := TRBDProduto.cria;
    FunProdutos.CarDProduto(VpfDProduto,0,varia.CodigoEmpFil,ProdutosI_SEQ_PRO.AsInteger);
    FunProdutos.BaixaProdutoEstoque(VpfDProduto, varia.CodigoEmpFil,VpfOperacaoEstoque,0,
                                    0,0,VARIA.MoedaBase,0,0,date,VpfQtd,0,ProdutosC_COD_UNI.AsString,
                                    '',false,VpfSeqEstoqueBarra,true);
    VpfDProduto.free;
    AtualizaConsulta;
  end;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{****************************Fecha o Formulario corrente***********************}
procedure TFPontoPedido.BFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TFPontoPedido.BGeraSolicitacaoCompraClick(Sender: TObject);
begin
  FNovaSolicitacaoCompras := TFNovaSolicitacaoCompras.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoOrcamentoCompras'));
  FNovaSolicitacaoCompras.NovoOrcamendoPontoPedido(Produtos);
  FNovaSolicitacaoCompras.free;
end;

{******************************************************************************}
procedure TFPontoPedido.GradeOrdem(Ordem: String);
begin
  VprOrdem := Ordem;
end;

{******************************************************************************}
procedure TFPontoPedido.CAtividadeClick(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFPontoPedido.EClassificacaoRetorno(Retorno1, Retorno2: String);
begin
  AtualizaConsulta;
end;

procedure TFPontoPedido.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_F2 : AlteraQtdEstoque;
    117 : AlteraQtdMinima;
    118 : AlteraQtdPedido;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFPontoPedido]);
end.
