unit AConsultaProdutoNumeroSerie;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, DB, DBClient, Tabela, Buttons,
  StdCtrls, Localizacao, Grids, DBGrids, DBKeyViolation;

type
  TFConsultaProdutoNumeroSerie = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    GridIndice1: TGridIndice;
    ECliente: TRBEditLocaliza;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ENumSerie: TEditColor;
    ENumSerieInterno: TEditColor;
    Produtos: TSQL;
    ProdutosNUMSERIE: TWideStringField;
    ProdutosNUMSERIEINTERNO: TWideStringField;
    ProdutosDESSETOR: TWideStringField;
    ProdutosQTDPRODUTO: TFMTBCDField;
    ProdutosDESUM: TWideStringField;
    ProdutosDATGARANTIA: TSQLTimeStampField;
    ProdutosDATDESATIVACAO: TSQLTimeStampField;
    ProdutosC_COD_PRO: TWideStringField;
    ProdutosC_NOM_PRO: TWideStringField;
    ProdutosI_COD_CLI: TFMTBCDField;
    ProdutosC_NOM_CLI: TWideStringField;
    DataProdutos: TDataSource;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BFechar: TBitBtn;
    ProdutosCONTRATO: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EClienteFimConsulta(Sender: TObject);
    procedure EClienteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BFecharClick(Sender: TObject);
  private
    { Private declarations }
    procedure AtualizaConsulta;
    procedure AdicionaFiltros(VpaSelect : TStrings);
  public
    { Public declarations }
  end;

var
  FConsultaProdutoNumeroSerie: TFConsultaProdutoNumeroSerie;

implementation

uses APrincipal, funSql;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFConsultaProdutoNumeroSerie.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFConsultaProdutoNumeroSerie.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFConsultaProdutoNumeroSerie.AtualizaConsulta;
begin
  Produtos.close;
  LimpaSQLTabela(Produtos);
  AdicionaSQLTabela(Produtos,'select ''SEM CONTRATO'' CONTRATO, '+
                             ' ITE.NUMSERIE, ITE.NUMSERIEINTERNO, ITE.DESSETOR, ITE.QTDPRODUTO, ITE.DESUM, ITE.DATGARANTIA,Cast('''' as Date) DATDESATIVACAO, '+
                             ' PRO.C_COD_PRO, PRO.C_NOM_PRO, '+
                             ' CLI.I_COD_CLI, CLI.C_NOM_CLI '+
                             ' from PRODUTOCLIENTE ITE, CADPRODUTOS PRO, CADCLIENTES CLI '+
                             ' Where ITE.SEQPRODUTO = PRO.I_SEQ_PRO '+
                             ' AND ITE.CODCLIENTE = CLI.I_COD_CLI ');
  AdicionaFiltros(Produtos.SQL);

  AdicionaSQLTabela(Produtos,'UNION');
  AdicionaSQLTabela(Produtos,'SELECT  TIP.NOMTIPOCONTRATO, '+
                             ' ITE.NUMSERIE, ITE.NUMSERIEINTERNO,ITE.DESSETOR,  1, ''  '', Cast('''' as Date),ITE.DATDESATIVACAO,' +
                             ' PRO.C_COD_PRO, PRO.C_NOM_PRO,'+
                             ' CLI.I_COD_CLI, CLI.C_NOM_CLI '+
                             ' FROM CONTRATOITEM ITE, CONTRATOCORPO COR, CADCLIENTES CLI, CADPRODUTOS PRO, TIPOCONTRATO TIP  '+
                             ' Where COR.CODFILIAL = ITE.CODFILIAL '+
                             ' AND COR.SEQCONTRATO = ITE.SEQCONTRATO '+
                             ' AND COR.CODCLIENTE = CLI.I_COD_CLI '+
                             ' AND ITE.SEQPRODUTO = PRO.I_SEQ_PRO '+
                             ' AND COR.CODTIPOCONTRATO = TIP.CODTIPOCONTRATO');
  AdicionaFiltros(Produtos.sql);
  produtos.open;
end;

{******************************************************************************}
procedure TFConsultaProdutoNumeroSerie.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFConsultaProdutoNumeroSerie.EClienteFimConsulta(Sender: TObject);
begin
  AtualizaConsulta;
end;

procedure TFConsultaProdutoNumeroSerie.EClienteKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 13 then
    AtualizaConsulta;
end;

{******************************************************************************}
procedure TFConsultaProdutoNumeroSerie.AdicionaFiltros(VpaSelect: TStrings);
begin
  if ECliente.ainteiro <> 0 then
    VpaSelect.Add('and CLI.I_COD_CLI = '+Ecliente.text);
  if ENumSerie.Text <> '' then
    VpaSelect.Add('and ITE.NUMSERIE LIKE '''+ENumSerie.Text+'%''');
  if ENumSerieInterno.Text <> '' then
    VpaSelect.Add('and ITE.NUMSERIEINTERNO LIKE '''+ENumSerieInterno.Text+'%''');
end;



Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFConsultaProdutoNumeroSerie]);
end.
