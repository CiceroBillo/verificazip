unit AOrcamentoCompras;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Db, DBTables, Grids, DBGrids,
  Tabela, DBKeyViolation, StdCtrls, Buttons, Mask, numericos, Localizacao,
  ComCtrls, DBClient, Menus;

type
  TFOrcamentoCompras = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    OrcamentoCompra: TSQL;
    OrcamentoCompraCODFILIAL: TFMTBCDField;
    OrcamentoCompraSEQORCAMENTO: TFMTBCDField;
    OrcamentoCompraDATEMISSAO: TSQLTimeStampField;
    OrcamentoCompraDATFIM: TSQLTimeStampField;
    OrcamentoCompraNOMCOMPRADOR: TWideStringField;
    OrcamentoCompraC_NOM_USU: TWideStringField;
    OrcamentoCompraNOMEST: TWideStringField;
    DataOrcamentoCompra: TDataSource;
    GridIndice1: TGridIndice;
    BCadastrar: TBitBtn;
    BAlterar: TBitBtn;
    BConsultar: TBitBtn;
    BFechar: TBitBtn;
    Label4: TLabel;
    Label13: TLabel;
    SpeedButton4: TSpeedButton;
    Label11: TLabel;
    Label19: TLabel;
    DataFinal: TCalendario;
    DataInicial: TCalendario;
    EComprador: TEditLocaliza;
    CPeriodo: TCheckBox;
    EOrcamentoCompra: Tnumerico;
    BFiltros: TBitBtn;
    ETipoPeriodo: TComboBoxColor;
    Label1: TLabel;
    Label6: TLabel;
    BFornecedor: TSpeedButton;
    LFornecedor: TLabel;
    Label8: TLabel;
    BEstagio: TSpeedButton;
    Label9: TLabel;
    EEstagio: TEditLocaliza;
    EFornecedor: TRBEditLocaliza;
    Localiza: TConsultaPadrao;
    Label20: TLabel;
    SpeedButton2: TSpeedButton;
    Label21: TLabel;
    EProduto: TEditColor;
    GPedidoItem: TGridIndice;
    Splitter1: TSplitter;
    ITENS: TSQL;
    DataITENS: TDataSource;
    ITENSDESUM: TWideStringField;
    ITENSQTDPRODUTO: TFMTBCDField;
    ITENSPERIPI: TFMTBCDField;
    ITENSC_COD_PRO: TWideStringField;
    ITENSC_NOM_PRO: TWideStringField;
    ITENSCOD_COR: TFMTBCDField;
    ITENSNOM_COR: TWideStringField;
    PanelColor3: TPanelColor;
    ITENSLARCHAPA: TFMTBCDField;
    ITENSCOMCHAPA: TFMTBCDField;
    ITENSQTDCHAPA: TFMTBCDField;
    BMapaCompras: TBitBtn;
    MenuGrade: TPopupMenu;
    ConsultaPedidosCompra1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCadastrarClick(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure BAlterarClick(Sender: TObject);
    procedure BConsultarClick(Sender: TObject);
    procedure DataInicialExit(Sender: TObject);
    procedure BFiltrosClick(Sender: TObject);
    procedure EOrcamentoCompraKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GridIndice1Ordem(Ordem: String);
    procedure BExcluirClick(Sender: TObject);
    procedure EProdutoExit(Sender: TObject);
    procedure EProdutoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SpeedButton2Click(Sender: TObject);
    procedure OrcamentoCompraAfterScroll(DataSet: TDataSet);
    procedure BImprimirClick(Sender: TObject);
    procedure BMapaComprasClick(Sender: TObject);
    procedure ConsultaPedidosCompra1Click(Sender: TObject);
  private
    { Private declarations }
    VprOrdem : string;
    VprSeqProduto,
    VprCodFilialPedido,
    VprSeqPedido : Integer;
    procedure InicializaTela;
    procedure AtualizaConsulta;
    procedure AdicionaFiltros(VpaSelect : TStrings);
    function ExisteProduto: Boolean;
    function LocalizaProduto: Boolean;
    procedure PosItensORCAMENTO;
    procedure ConfiguraPermissaoUsuario;
  public
    { Public declarations }
    procedure ConsultaOrcamentosPedido(VpaCodFilial, VpaSeqPedido : Integer);
  end;

var
  FOrcamentoCompras: TFOrcamentoCompras;

implementation

uses APrincipal, ANovoOrcamentoCompra, Fundata, FunSql, Constantes, ALocalizaProdutos,
     unProdutos , AMapaCompras, APedidoCompra;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFOrcamentoCompras.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprCodFilialPedido := 0;
  VprOrdem := 'order by ORC.CODFILIAL, ORC.SEQORCAMENTO';
  ConfiguraPermissaoUsuario;
  InicializaTela;
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFOrcamentoCompras.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFOrcamentoCompras.InicializaTela;
begin
  CPeriodo.Checked:= True;
  ETipoPeriodo.ItemIndex:= 0;
  EComprador.AInteiro:= Varia.CodComprador;
  EComprador.Atualiza;
  DataInicial.DateTime:= PrimeiroDiaMes(Date);
  DataFinal.DateTime:= UltimoDiaMes(Date);
  EFornecedor.Clear;
end;

function TFOrcamentoCompras.LocalizaProduto: Boolean;
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
    Label21.Caption:= VpfNomProduto;
  end
  else
  begin
    EProduto.Text:= '';
    Label21.Caption:= '';
  end;
end;

{******************************************************************************}
procedure TFOrcamentoCompras.ConsultaOrcamentosPedido(VpaCodFilial, VpaSeqPedido: Integer);
begin
  VprCodFilialPedido := VpaCodFilial;
  VprSeqPedido := VpaSeqPedido;
  AtualizaConsulta;
  showmodal;
end;

{******************************************************************************}
procedure TFOrcamentoCompras.ConsultaPedidosCompra1Click(Sender: TObject);
begin
  if OrcamentoCompraCODFILIAL.AsInteger <> 0 then
  begin
    FPedidoCompra := TFPedidoCompra.criarSDI(Application,'',FPrincipal.VerificaPermisao('FPedidoCompra'));
    FPedidoCompra.ConsultaPedidosOrcamentoCompra(OrcamentoCompraCODFILIAL.AsInteger,OrcamentoCompraSEQORCAMENTO.AsInteger);
    FPedidoCompra.free;
  end;
end;

{******************************************************************************}
procedure TFOrcamentoCompras.OrcamentoCompraAfterScroll(DataSet: TDataSet);
begin
  PosItensORCAMENTO;
end;

{******************************************************************************}
procedure TFOrcamentoCompras.PosItensORCAMENTO;
begin
  ITENS.Close;
  Itens.sql.clear;
  Itens.sql.add('select OCI.DESUM, OCI.QTDPRODUTO, OCI.PERIPI,  OCI.LARCHAPA, '+
                              ' OCI.COMCHAPA, OCI.QTDCHAPA, '+
                              ' PRO.C_COD_PRO, PRO.C_NOM_PRO,'+
                              ' COR.COD_COR, COR.NOM_COR '+
                              ' from ORCAMENTOCOMPRAITEM OCI, CADPRODUTOS PRO, COR '+
                              ' Where OCI.SEQPRODUTO = PRO.I_SEQ_PRO '+
                              ' and OCI.CODFILIAL = '+IntToStr(OrcamentoCompraCODFILIAL.AsInteger)+
                              ' AND OCI.SEQORCAMENTO = '+IntToStr(OrcamentoCompraSEQORCAMENTO.AsInteger)+
                              ' AND'+SQLTextoRightJoin('OCI.CODCOR','COR.COD_COR'));
  if VprSeqProduto <> 0 then
    ITENS.SQL.ADD('and OCI.SEQPRODUTO = '+IntToStr(VprSeqProduto));
  Itens.sql.add('ORDER BY OCI.SEQITEM ');
  Itens.open;
end;

{******************************************************************************}
procedure TFOrcamentoCompras.SpeedButton2Click(Sender: TObject);
begin
  LocalizaProduto;
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFOrcamentoCompras.AtualizaConsulta;
begin
  ITENS.Close;
  OrcamentoCompra.Close;
  OrcamentoCompra.sql.clear;
  OrcamentoCompra.sql.add('select ORC.CODFILIAL, ORC.SEQORCAMENTO, ORC.DATEMISSAO, ORC.DATFIM, '+
                          ' COM.NOMCOMPRADOR, USU.C_NOM_USU, '+
                          ' EST.NOMEST '+
                          ' from ORCAMENTOCOMPRACORPO ORC, COMPRADOR COM, CADUSUARIOS USU, ESTAGIOPRODUCAO EST '+
                          ' Where ORC.CODUSUARIO = USU.I_COD_USU '+
                          ' AND ORC.CODCOMPRADOR = COM.CODCOMPRADOR '+
                          ' AND ORC.CODESTAGIO = EST.CODEST ');
  AdicionaFiltros(OrcamentoCompra.SQL);
  OrcamentoCompra.Sql.add(VprOrdem);
  GridIndice1.ALinhaSQLOrderBy := OrcamentoCompra.SQL.count - 1;
  OrcamentoCompra.open;
end;

{******************************************************************************}
procedure TFOrcamentoCompras.AdicionaFiltros(VpaSelect : TStrings);
begin
  if EOrcamentoCompra.AsInteger <> 0 then
    VpaSelect.Add('and ORC.SEQORCAMENTO = ' +EOrcamentoCompra.Text)
  else
  begin
    if CPeriodo.Checked then
      case ETipoPeriodo.ItemIndex of
        0: VpaSelect.Add(SQLTextoDataEntreAAAAMMDD('ORC.DATEMISSAO',DataInicial.DateTime,DataFinal.DateTime,True));
        1: VpaSelect.Add(SQLTextoDataEntreAAAAMMDD('ORC.DATPREVISAOFIM',DataInicial.DateTime,DataFinal.DateTime,True));
      end;
    if EFornecedor.AInteiro <> 0 then
      VpaSelect.Add(' AND EXISTS (SELECT * FROM ORCAMENTOCOMPRAFORNECEDORCORPO OCF '+
                    ' WHERE OCF.CODFILIAL = ORC.CODFILIAL '+
                    ' AND OCF.SEQORCAMENTO = ORC.SEQORCAMENTO '+
                    ' AND OCF.CODCLIENTE = '+EFornecedor.Text+' )');
    if EEstagio.Text <> '' then
      VpaSelect.Add(' AND ORC.CODESTAGIO = '+EEstagio.Text);
    if EComprador.Text <> '' then
      VpaSelect.Add(' AND ORC.CODCOMPRADOR = '+EComprador.Text);
    if VprSeqProduto <> 0 then
      VpaSelect.Add('and exists (Select * FROM ORCAMENTOCOMPRAITEM ITE ' +
                    ' Where ORC.CODFILIAL = ITE.CODFILIAL ' +
                    ' AND ORC.SEQORCAMENTO = ITE.SEQORCAMENTO' +
                    ' AND ITE.SEQPRODUTO = '+IntToStr(VprSeqProduto)+')');
    if VprCodFilialPedido <> 0 then
      vpaselect.Add(' and exists( Select 1 from ORCAMENTOPEDIDOCOMPRA OPC ' +
                    ' Where OPC.CODFILIAL = ORC.CODFILIAL ' +
                    ' AND OPC.SEQORCAMENTO = ORC.SEQORCAMENTO ' +
                    ' AND OPC.CODFILIAL = ' +IntToStr(VprCodFilialPedido)+
                    ' AND OPC.SEQPEDIDO = ' +IntToStr(VprSeqPedido)+')');
  end;
end;

{******************************************************************************}
procedure TFOrcamentoCompras.BCadastrarClick(Sender: TObject);
begin
  FNovoOrcamentoCompra := TFNovoOrcamentoCompra.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoOrcamentoCompra'));
  if FNovoOrcamentoCompra.NovoOrcamento then
    AtualizaConsulta;
  FNovoOrcamentoCompra.free;
end;

{******************************************************************************}
procedure TFOrcamentoCompras.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFOrcamentoCompras.BAlterarClick(Sender: TObject);
begin
  if OrcamentoCompraCODFILIAL.AsInteger <> 0 then
  begin
    FNovoOrcamentoCompra := TFNovoOrcamentoCompra.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoOrcamentoCompra'));
    if FNovoOrcamentoCompra.Alterar(OrcamentoCompraCODFILIAL.AsInteger,OrcamentoCompraSEQORCAMENTO.AsInteger) then
      AtualizaConsulta;
    FNovoOrcamentoCompra.free;
  end;
end;

procedure TFOrcamentoCompras.BConsultarClick(Sender: TObject);
begin
  if OrcamentoCompraCODFILIAL.AsInteger <> 0 then
  begin
    FNovoOrcamentoCompra := TFNovoOrcamentoCompra.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoOrcamentoCompra'));
    FNovoOrcamentoCompra.Consultar(OrcamentoCompraCODFILIAL.AsInteger,OrcamentoCompraSEQORCAMENTO.AsInteger);
    FNovoOrcamentoCompra.free;
  end;
end;

procedure TFOrcamentoCompras.BExcluirClick(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFOrcamentoCompras.DataInicialExit(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFOrcamentoCompras.BFiltrosClick(Sender: TObject);
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

procedure TFOrcamentoCompras.BImprimirClick(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFOrcamentoCompras.BMapaComprasClick(Sender: TObject);
begin
  if (OrcamentoCompraCODFILIAL.AsInteger <> 0) then
  begin
    FMapaCompras := TFMapaCompras.criarSDI(Application,'',FPrincipal.VerificaPermisao('FMapaCompras'));
    FMapaCompras.MostraMapaCompras(OrcamentoCompraCODFILIAL.AsInteger,OrcamentoCompraSEQORCAMENTO.AsInteger);
    FMapaCompras.free;
  end;
end;

{******************************************************************************}
procedure TFOrcamentoCompras.ConfiguraPermissaoUsuario;
begin
  GPedidoItem.Columns[4].Visible := Config.ControlarEstoquedeChapas;
  GPedidoItem.Columns[5].Visible := Config.ControlarEstoquedeChapas;
  GPedidoItem.Columns[6].Visible := Config.ControlarEstoquedeChapas;
  GPedidoItem.Columns[2].Visible := Config.EstoquePorCor;
  GPedidoItem.Columns[3].Visible := Config.EstoquePorCor;
end;

{******************************************************************************}
procedure TFOrcamentoCompras.EOrcamentoCompraKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 13 then
    AtualizaConsulta;
end;

{******************************************************************************}
procedure TFOrcamentoCompras.EProdutoExit(Sender: TObject);
begin
  ExisteProduto;
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFOrcamentoCompras.EProdutoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    13: begin
          if ExisteProduto then
            AtualizaConsulta
          else
            if LocalizaProduto then
              AtualizaConsulta;
        end;
    114: if LocalizaProduto then
           AtualizaConsulta;
  end;
end;

{******************************************************************************}
function TFOrcamentoCompras.ExisteProduto: Boolean;
var
  VpfUM,
  VpfNomProduto: String;
begin
  Result:= FunProdutos.ExisteProduto(EProduto.Text,VprSeqProduto,VpfNomProduto,VpfUM);
  if Result then
    Label21.Caption:= VpfNomProduto
  else
    Label21.Caption:= '';
end;

{******************************************************************************}
procedure TFOrcamentoCompras.GridIndice1Ordem(Ordem: String);
begin
  VprOrdem := Ordem;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFOrcamentoCompras]);
end.
