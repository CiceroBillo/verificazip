unit ALocalizaProdutoContrato;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  UnDados, Localizacao, Buttons, StdCtrls, Componentes1, Grids, DBGrids,
  Tabela, DBKeyViolation, ExtCtrls, PainelGradiente, Db, DBTables, ComCtrls,
  DBCtrls, UnProdutos, DBClient;

type
  TFLocalizaProdutoContrato = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    PanelColor1: TPanelColor;
    BProdutosSemContrato: TBitBtn;
    BOk: TBitBtn;
    BCancelar: TBitBtn;
    ECliente: TEditLocaliza;
    Label4: TLabel;
    SpeedButton2: TSpeedButton;
    Label5: TLabel;
    Localiza: TConsultaPadrao;
    Produtos: TSQL;
    DataProdutos: TDataSource;
    ProdutosCODFILIAL: TFMTBCDField;
    ProdutosSEQCONTRATO: TFMTBCDField;
    ProdutosNUMCONTRATO: TWideStringField;
    ProdutosNUMSERIE: TWideStringField;
    ProdutosQTDULTIMALEITURA: TFMTBCDField;
    ProdutosDESSETOR: TWideStringField;
    ProdutosNUMSERIEINTERNO: TWideStringField;
    ProdutosC_COD_PRO: TWideStringField;
    ProdutosC_NOM_PRO: TWideStringField;
    ProdutosNOMTIPOCONTRATO: TWideStringField;
    ProdutosI_SEQ_PRO: TFMTBCDField;
    ProdutosSEQITEM: TFMTBCDField;
    PanelColor3: TPanelColor;
    Paginas: TPageControl;
    PProdutosComContrato: TTabSheet;
    Grade: TGridIndice;
    PProdutosdoCliente: TTabSheet;
    GridIndice1: TGridIndice;
    ProdutosdoCliente: TSQL;
    DataProdutosdoCliente: TDataSource;
    ProdutosdoClienteDESSETOR: TWideStringField;
    ProdutosdoClienteNUMSERIE: TWideStringField;
    ProdutosdoClienteNUMSERIEINTERNO: TWideStringField;
    ProdutosdoClienteQTDPRODUTO: TFMTBCDField;
    ProdutosdoClienteDESUM: TWideStringField;
    ProdutosdoClienteDATGARANTIA: TSQLTimeStampField;
    ProdutosdoClienteVALCONCORRENTE: TFMTBCDField;
    ProdutosdoClienteQTDCOPIAS: TFMTBCDField;
    ProdutosdoClienteDESOBSERVACAO: TWideStringField;
    ProdutosdoClienteC_COD_PRO: TWideStringField;
    ProdutosdoClienteC_NOM_PRO: TWideStringField;
    ProdutosdoClienteNOMDONO: TWideStringField;
    DBMemoColor1: TDBMemoColor;
    Splitter1: TSplitter;
    ProdutosdoClienteI_SEQ_PRO: TFMTBCDField;
    ProdutosC_COD_UNI: TWideStringField;
    ProdutosdoClienteSEQITEM: TFMTBCDField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
    procedure BOkClick(Sender: TObject);
    procedure GradeDblClick(Sender: TObject);
    procedure GradeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BProdutosSemContratoClick(Sender: TObject);
    procedure PaginasChange(Sender: TObject);
  private
    { Private declarations }
    VprAcao : Boolean;
    VprCodCliente : Integer;
    VprDProdutoChamado : TRBDChamadoProduto;
    procedure AtualizaConsulta;
    procedure PosProdutosCliente;
    procedure CarDClasse;
    function DadosValidos : String;
  public
    { Public declarations }
    function LocalizaProdutoChamado(VpaCodCliente : Integer;VpaDProdutoChamado : TRBDChamadoProduto) :Boolean;
  end;

var
  FLocalizaProdutoContrato: TFLocalizaProdutoContrato;

implementation

uses APrincipal, Constantes, Constmsg, ALocalizaProdutos, FunSql, UnClientes;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFLocalizaProdutoContrato.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao := false;
  Paginas.ActivePage := PProdutosComContrato;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFLocalizaProdutoContrato.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFLocalizaProdutoContrato.AtualizaConsulta;
begin
  Produtos.Close;
  Produtos.sql.clear;
  Produtos.Sql.add('select COC.CODFILIAL, COC.SEQCONTRATO, COC.NUMCONTRATO, '+
                   ' COI.SEQITEM, COI.NUMSERIE, COI.QTDULTIMALEITURA, COI.DESSETOR, COI.NUMSERIEINTERNO, '+
                   ' PRO.I_SEQ_PRO, PRO.C_COD_PRO, PRO.C_NOM_PRO, PRO.C_COD_UNI, '+
                   ' TIC.NOMTIPOCONTRATO ' +
                   ' from CONTRATOCORPO COC, CONTRATOITEM COI, CADPRODUTOS PRO, TIPOCONTRATO TIC '+
                   ' Where COC.CODFILIAL = COI.CODFILIAL ' +
                   ' AND COC.SEQCONTRATO = COI.SEQCONTRATO '+
                   ' AND COI.SEQPRODUTO = PRO.I_SEQ_PRO ' +
                   ' AND COC.CODTIPOCONTRATO = TIC.CODTIPOCONTRATO '+
                   ' AND COC.CODCLIENTE = ' +IntTostr(vprcodCliente)+
                   ' AND COC.DATCANCELAMENTO IS NULL '+
                   ' AND COI.DATDESATIVACAO IS NULL '+
                   ' order by PRO.I_SEQ_PRO');
  Produtos.Open;
end;

{******************************************************************************}
procedure TFLocalizaProdutoContrato.PosProdutosCliente;
begin
  AdicionaSQLAbreTabela(ProdutosdoCliente,'select  PRC.DESSETOR, PRC.NUMSERIE, PRC.NUMSERIEINTERNO, '+
                     ' PRC.QTDPRODUTO, PRC.DESUM, PRC.DATGARANTIA, PRC.VALCONCORRENTE, PRC.QTDCOPIAS, PRC.DESOBSERVACAO, '+
                     ' PRC.SEQITEM, '+
                     ' PRO.C_COD_PRO, PRO.C_NOM_PRO, PRO.I_SEQ_PRO,  '+
                     ' DON.NOMDONO ' +
                     ' from PRODUTOCLIENTE PRC, CADPRODUTOS PRO, DONOPRODUTO DON ' +
                     ' Where PRC.SEQPRODUTO = PRO.I_SEQ_PRO ' +
                     ' and '+SQLTextoRightJoin('PRC.CODDONO','DON.CODDONO')+
                     ' AND PRC.CODCLIENTE = '+IntToStr(VprCodCliente));
end;

{******************************************************************************}
procedure TFLocalizaProdutoContrato.CarDClasse;
begin
  if Paginas.ActivePage = PProdutosComContrato then
  begin
    with VprDProdutoChamado do
    begin
      CodFilialChamado := ProdutosCODFILIAL.AsInteger;
      SeqContrato := ProdutosSEQCONTRATO.AsInteger;
      SeqItemContrato := ProdutosSEQITEM.AsInteger;
      SeqProduto := ProdutosI_SEQ_PRO.AsInteger;
      CodProduto := ProdutosC_COD_PRO.AsString;
      NomProduto := ProdutosC_NOM_PRO.AsString;
      DesContrato := ProdutosNOMTIPOCONTRATO.AsString;
      NumSerie := ProdutosNUMSERIE.AsString;
      NumSerieInterno := ProdutosNUMSERIEINTERNO.AsString;
      DesSetor := ProdutosDESSETOR.AsString;
      NumContador := ProdutosQTDULTIMALEITURA.AsInteger;
      QtdProduto := 1;
      DesUM := ProdutosC_COD_UNI.AsString;
      UnidadeParentes.free;
      UnidadeParentes := FunProdutos.RUnidadesParentes(DesUM);
    end;
  end
  else
    if Paginas.ActivePage = PProdutosdoCliente then
    begin
      with VprDProdutoChamado do
      begin
        SeqContrato := 0;
        SeqItemContrato := 0;
        SeqItemProdutoCliente := ProdutosdoClienteSEQITEM.AsInteger;
        SeqProduto := ProdutosdoClienteI_SEQ_PRO.AsInteger;
        CodProduto := ProdutosdoClienteC_COD_PRO.AsString;
        NomProduto := ProdutosdoClienteC_NOM_PRO.AsString;
        DesContrato := '';
        NumSerie := ProdutosdoClienteNUMSERIE.AsString;
        NumSerieInterno := ProdutosdoClienteNUMSERIEINTERNO.AsString;
        DesSetor := ProdutosdoClienteDESSETOR.AsString;
        DatGarantia := ProdutosdoClienteDATGARANTIA.AsDateTime;
        QtdProduto := 1;
        DesUM := ProdutosdoClienteDESUM.AsString;
        UnidadeParentes.free;
        UnidadeParentes := FunProdutos.RUnidadesParentes(DesUM);
      end;
    end;
end;

{******************************************************************************}
function TFLocalizaProdutoContrato.DadosValidos : String;
begin
  result := '';
  if Paginas.ActivePage = PProdutosComContrato then
  begin
    if ProdutosSEQCONTRATO.AsInteger =0 then
      result := 'FALTA SELECIONAR ITEM!!!'#13'É necessário selecionar um item.';
  end
  else
    if Paginas.ActivePage = PProdutosdoCliente then
    begin
      if ProdutosdoClienteI_SEQ_PRO.AsInteger = 0 then
        result := 'FALTA SELECIONAR O PRODUTO!!!!'#13'É necessário selecionar um produto.';

    end;
end;

{******************************************************************************}
function TFLocalizaProdutoContrato.LocalizaProdutoChamado(VpaCodCliente : Integer;VpaDProdutoChamado : TRBDChamadoProduto) :Boolean;
begin
  ECliente.AInteiro := VpaCodCliente;
  ECliente.Atualiza;
  VprDProdutoChamado := VpaDProdutoChamado;
  VprCodCliente := VpaCodCliente;
  AtualizaConsulta;
  Showmodal;
  result := VprAcao;
end;

{******************************************************************************}
procedure TFLocalizaProdutoContrato.BCancelarClick(Sender: TObject);
begin
  VprAcao := false;
  close;
end;

{******************************************************************************}
procedure TFLocalizaProdutoContrato.BOkClick(Sender: TObject);
var
  VpfResultado : String;
begin
  VpfResultado := DadosValidos;
  if VpfResultado = '' then
  begin
    CarDClasse;
    VprAcao := true;
    Close;
  end
  else
    aviso(VpfREsultado);
end;

{******************************************************************************}
procedure TFLocalizaProdutoContrato.GradeDblClick(Sender: TObject);
begin
  BOk.Click;
end;

procedure TFLocalizaProdutoContrato.GradeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 13 then
    BOk.click;
end;

{******************************************************************************}
procedure TFLocalizaProdutoContrato.BProdutosSemContratoClick(
  Sender: TObject);
var
  VpfSeqProduto : Integer;
  VpfCodProduto,VpfNomProduto, VpfDesUM,VpfClaFiscal : String;
  VpfResultado : string;
begin
  FlocalizaProduto := TFlocalizaProduto.CriarSDI(self,'',FPrincipal.VerificaPermisao('FlocalizaProduto'));
  if FlocalizaProduto.LocalizaProduto(VpfSeqProduto,VpfCodProduto,VpfNomProduto,VpfDesUM,VpfClaFiscal) then
  begin
    with VprDProdutoChamado do
    begin
      SeqContrato := 0;
      SeqIteMContrato := 0;
      SeqProduto := VpfSeqProduto;
      CodProduto := VpfCodProduto;
      NomProduto := VpfNomProduto;
      QtdProduto := 1;
      DesUM := VpfDesUM;
      UnidadeParentes.free;
      UnidadeParentes := FunProdutos.RUnidadesParentes(VpfDesUM); 
      DesContrato := '';
      NumSerie := '';
      NumSerieInterno := '';
      DesSetor := '';
      NumContador :=0;
    end;
    VpfResultado := FunClientes.AdicionaProdutoCliente(VprCodCliente,VpfSeqProduto,VpfCodProduto,VpfDesUM);
    if VpfResultado <> '' then
      aviso(VpfResultado)
    else
    begin
      VprAcao := true;
      close;
    end;
  end;
  FlocalizaProduto.free;
end;

{******************************************************************************}
procedure TFLocalizaProdutoContrato.PaginasChange(Sender: TObject);
begin
  IF Paginas.ActivePage = PProdutosdoCliente then
    PosProdutosCliente;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFLocalizaProdutoContrato]);
end.
