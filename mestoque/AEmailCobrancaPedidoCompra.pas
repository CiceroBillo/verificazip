unit AEmailCobrancaPedidoCompra;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, ExtCtrls, Componentes1, PainelGradiente, ComCtrls,
  Grids, DBGrids, Tabela, DBKeyViolation, Db, DBTables, DBClient;

type
  TFEmailCobrancaPedidoCompra = class(TFormularioPermissao)
    PanelColor2: TPanelColor;
    BFechar: TBitBtn;
    PanelColor1: TPanelColor;
    PainelGradiente1: TPainelGradiente;
    PanelColor3: TPanelColor;
    CPeriodo: TCheckBox;
    DataInicial: TCalendario;
    Label4: TLabel;
    DataFinal: TCalendario;
    GECobrancaCompraCorpo: TGridIndice;
    GECobrancaCompraItem: TGridIndice;
    Splitter1: TSplitter;
    ECOBRANCACOMPRACORPO: TSQL;
    DataECOBRANCACOMPRACORPO: TDataSource;
    DataECOBRANCACOMPRAITEM: TDataSource;
    ECOBRANCACOMPRAITEM: TSQL;
    ECOBRANCACOMPRACORPOSEQEMAIL: TFMTBCDField;
    ECOBRANCACOMPRACORPOQTDENVIADOS: TFMTBCDField;
    ECOBRANCACOMPRACORPOQTDERRO: TFMTBCDField;
    ECOBRANCACOMPRACORPOC_NOM_USU: TWideStringField;
    BImprimir: TBitBtn;
    BEnviar: TBitBtn;
    ECOBRANCACOMPRAITEMINDENVIADO: TWideStringField;
    ECOBRANCACOMPRAITEMNOMFORNECEDOR: TWideStringField;
    ECOBRANCACOMPRAITEMSEQITEM: TFMTBCDField;
    ECOBRANCACOMPRAITEMCODFILIAL: TFMTBCDField;
    ECOBRANCACOMPRAITEMSEQPEDIDO: TFMTBCDField;
    ECOBRANCACOMPRAITEMNOMFORNECEDOR_1: TWideStringField;
    ECOBRANCACOMPRAITEMDESEMAIL: TWideStringField;
    ECOBRANCACOMPRAITEMDESSTATUS: TWideStringField;
    ECOBRANCACOMPRACORPOCODFILIAL: TFMTBCDField;
    ECOBRANCACOMPRACORPODATENVIO: TSQLTimeStampField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure DataInicialCloseUp(Sender: TObject);
    procedure ECOBRANCACOMPRACORPOAfterScroll(DataSet: TDataSet);
    procedure BEnviarClick(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure GECobrancaCompraCorpoOrdem(Ordem: String);
    procedure GECobrancaCompraItemOrdem(Ordem: String);
  private
    VprOrdemCorpo,
    VprOrdemItem: String;
    procedure InicializaTela;
    procedure AdicionaFiltros(VpaSelect: TStrings);
    procedure AtualizaConsulta;
    procedure PosDadosCobranca;
  public
  end;

var
  FEmailCobrancaPedidoCompra: TFEmailCobrancaPedidoCompra;

implementation
uses
  APrincipal, FunSQL, FunData, Constantes, AEnviaEmailCobrancaPedidoCompra;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFEmailCobrancaPedidoCompra.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  InicializaTela;
  VprOrdemCorpo:= ' ORDER BY CCC.SEQEMAIL';
  VprOrdemItem:= ' ORDER BY CCI.NOMFORNECEDOR';
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFEmailCobrancaPedidoCompra.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  ECOBRANCACOMPRACORPO.Close;
  ECOBRANCACOMPRAITEM.Close;
  Action:= CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFEmailCobrancaPedidoCompra.BFecharClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFEmailCobrancaPedidoCompra.InicializaTela;
begin
  CPeriodo.Checked:= True;
  DataInicial.DateTime:= PrimeiroDiaMes(Date);
  DataFinal.DateTime:= UltimoDiaMes(Date);
end;

{******************************************************************************}
procedure TFEmailCobrancaPedidoCompra.AtualizaConsulta;
begin
  ECOBRANCACOMPRACORPO.Close;
  ECOBRANCACOMPRACORPO.SQL.Clear;
  ECOBRANCACOMPRACORPO.SQL.Add('SELECT'+
                               ' CCC.CODFILIAL, CCC.SEQEMAIL, CCC.DATENVIO, CCC.QTDENVIADOS,'+
                               ' CCC.QTDERRO, USU.C_NOM_USU'+
                               ' FROM'+
                               ' ECOBRANCACOMPRACORPO CCC, CADUSUARIOS USU'+
                               ' WHERE'+
                               ' CCC.CODFILIAL = '+IntToStr(Varia.CodigoEmpFil)+
                               ' AND CCC.CODUSUARIO = USU.I_COD_USU');
  AdicionaFiltros(ECOBRANCACOMPRACORPO.SQL);
  ECOBRANCACOMPRACORPO.SQL.Add(VprOrdemCorpo);
  GECobrancaCompraCorpo.ALinhaSQLOrderBy:= ECOBRANCACOMPRACORPO.SQL.Count-1;
  ECOBRANCACOMPRACORPO.Open;
end;

{******************************************************************************}
procedure TFEmailCobrancaPedidoCompra.AdicionaFiltros(VpaSelect: TStrings);
begin
  if CPeriodo.Checked then
    VpaSelect.Add(SQLTextoDataEntreAAAAMMDD('CCC.DATENVIO',DataInicial.DateTime,DataFinal.DateTime,True));
end;

{******************************************************************************}
procedure TFEmailCobrancaPedidoCompra.DataInicialCloseUp(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFEmailCobrancaPedidoCompra.ECOBRANCACOMPRACORPOAfterScroll(DataSet: TDataSet);
begin
  PosDadosCobranca;
end;

{******************************************************************************}
procedure TFEmailCobrancaPedidoCompra.PosDadosCobranca;
begin
  ECOBRANCACOMPRAITEM.Close;
  ECOBRANCACOMPRAITEM.SQL.Clear;
  ECOBRANCACOMPRAITEM.SQL.Add('SELECT'+
                              ' CCI.INDENVIADO, CCI.NOMFORNECEDOR, CCI.SEQITEM,'+
                              ' CCI.CODFILIAL, CCI.SEQPEDIDO, CCI.NOMFORNECEDOR,'+
                              ' CCI.DESEMAIL, CCI.DESSTATUS'+
                              ' FROM'+
                              ' ECOBRANCACOMPRAITEM CCI'+
                              ' WHERE'+
                              ' CCI.CODFILIAL = '+ECOBRANCACOMPRACORPOCODFILIAL.AsString+
                              ' AND CCI.SEQEMAIL = '+ECOBRANCACOMPRACORPOSEQEMAIL.AsString);
  GECobrancaCompraCorpo.ALinhaSQLOrderBy:= ECOBRANCACOMPRAITEM.SQL.Count-1;
  ECOBRANCACOMPRAITEM.Open;
end;

{******************************************************************************}
procedure TFEmailCobrancaPedidoCompra.BEnviarClick(Sender: TObject);
begin
  FEnviaEmailCobrancaPedidoCompra:= TFEnviaEmailCobrancaPedidoCompra.CriarSDI(Application,'',True);
  FEnviaEmailCobrancaPedidoCompra.EnviarEmails;
  FEnviaEmailCobrancaPedidoCompra.Free;
end;

{******************************************************************************}
procedure TFEmailCobrancaPedidoCompra.BImprimirClick(Sender: TObject);
begin
  // verificar qual relatorio a ser impresso aqui.
end;

{******************************************************************************}
procedure TFEmailCobrancaPedidoCompra.GECobrancaCompraCorpoOrdem(Ordem: String);
begin
  VprOrdemCorpo:= Ordem;
end;

{******************************************************************************}
procedure TFEmailCobrancaPedidoCompra.GECobrancaCompraItemOrdem(Ordem: String);
begin
  VprOrdemItem:= Ordem;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
  RegisterClasses([TFEmailCobrancaPedidoCompra]);
end.
