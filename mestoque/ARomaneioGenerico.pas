unit ARomaneioGenerico;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, Grids, DBGrids, Tabela, DBKeyViolation, Componentes1,
  PainelGradiente, StdCtrls, Buttons, Db, DBTables, Localizacao, ComCtrls, UnOrdemProducao;

type
  TFRomaneioGenerico = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BExcluir: TBitBtn;
    BGerarNota: TBitBtn;
    BImprimir: TBitBtn;
    BFechar: TBitBtn;
    RomaneioCorpo: TQuery;
    RomaneioCorpoEMPFIL: TIntegerField;
    RomaneioCorpoSEQROM: TIntegerField;
    RomaneioCorpoDATINI: TDateTimeField;
    RomaneioCorpoDATFIM: TDateTimeField;
    RomaneioCorpoNOTGER: TStringField;
    RomaneioCorpoINDIMP: TStringField;
    RomaneioCorpoNRONOT: TIntegerField;
    RomaneioCorpoVALTOT: TFloatField;
    RomaneioCorpoC_NOM_CLI: TStringField;
    DataRomaneioCorpo: TDataSource;
    CPeriodo: TCheckBox;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    ESituacaoNota: TComboBoxColor;
    Label3: TLabel;
    Localiza: TConsultaPadrao;
    Label1: TLabel;
    SpeedButton3: TSpeedButton;
    Label6: TLabel;
    ECliente: TEditLocaliza;
    PanelColor3: TPanelColor;
    GridIndice1: TGridIndice;
    GridIndice2: TGridIndice;
    Splitter1: TSplitter;
    RomaneioProdutoItem: TQuery;
    RomaneioProdutoItemSEQORDEM: TIntegerField;
    RomaneioProdutoItemSEQFRACAO: TIntegerField;
    RomaneioProdutoItemSEQCOLETA: TIntegerField;
    RomaneioProdutoItemDATCOLETA: TDateTimeField;
    RomaneioProdutoItemQTDCOLETADO: TFloatField;
    RomaneioProdutoItemDESUM: TStringField;
    RomaneioProdutoItemNUMPED: TIntegerField;
    RomaneioProdutoItemORDCLI: TStringField;
    RomaneioProdutoItemPRODUTO: TStringField;
    RomaneioProdutoItemNOM_COR: TStringField;
    RomaneioProdutoItemC_NOM_USU: TStringField;
    DataRomaneioProdutoItem: TDataSource;
    RomaneioCorpoI_COD_CLI: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EClienteFimConsulta(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure RomaneioCorpoAfterScroll(DataSet: TDataSet);
    procedure BExcluirClick(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure BGerarNotaClick(Sender: TObject);
  private
    { Private declarations }
    FunOrdemProducao : TRBFuncoesOrdemProducao;
    procedure AtualizaConsulta;
    procedure AdicionaFiltros(VpaSelect : TStrings);
    procedure PosRomaneioProdutoItem;
  public
    { Public declarations }
  end;

var
  FRomaneioGenerico: TFRomaneioGenerico;

implementation

uses APrincipal, FunSql,FunData, ConstMsg, UnCrystal, Constantes,
  ANovaNotaFiscalNota;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFRomaneioGenerico.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunOrdemProducao := TRBFuncoesOrdemProducao.cria(FPrincipal.BaseDados);
  EDatInicio.DateTime := DecDia(date,7);
  EDatFim.DateTime := incDia(Date,7);
  ESituacaoNota.ItemIndex := 0;
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFRomaneioGenerico.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  RomaneioCorpo.close;
  RomaneioProdutoItem.close;
  FunOrdemProducao.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFRomaneioGenerico.AtualizaConsulta;
begin
  RomaneioCorpo.sql.clear;
  RomaneioCorpo.sql.add('select  ROM.EMPFIL, ROM.SEQROM, ROM.DATINI, ROM.DATFIM, ROM.NOTGER, ROM.INDIMP, '+
                        ' ROM.NRONOT, ROM.VALTOT, '+
                        ' CLI.I_COD_CLI, CLI.C_NOM_CLI '+
                        ' from ROMANEIOCORPO ROM, CADCLIENTES CLI ' +
                        ' Where ROM.CODCLI = CLI.I_COD_CLI ');
  AdicionaFiltros(RomaneioCorpo.Sql);

  RomaneioCorpo.sql.SaveToFile('c:\consulta.sql');
  RomaneioCorpo.open;
  if RomaneioCorpo.Eof then
    PosRomaneioProdutoItem;
end;

{******************************************************************************}
procedure TFRomaneioGenerico.AdicionaFiltros(VpaSelect : TStrings);
begin
  if ECliente.AInteiro <> 0 then
    VpaSelect.add('CLI.I_COD_CLI = ' + ECliente.Text);
  if CPeriodo.Checked then
    VpaSelect.add(SQLTextoDataEntreAAAAMMDD('DATINI',EDatInicio.DateTime,incDia(EDatFim.DateTime,1),true));
  case ESituacaoNota.ItemIndex of
    0 : VpaSelect.add('and NOTGER = ''N''');
    1 : VpaSelect.add('and NOTGER = ''S''');
  end;
end;

{******************************************************************************}
procedure TFRomaneioGenerico.PosRomaneioProdutoItem;
begin
  if RomaneioCorpoEMPFIL.AsInteger = 0 then
    RomaneioProdutoItem.Close
  else
  begin
    RomaneioProdutoItem.Sql.Clear;
    RomaneioProdutoItem.sql.add('select IRO.SEQORDEM, IRO.SEQFRACAO, IRO.SEQCOLETA,'+
                                ' COP.DATCOLETA, COP.QTDCOLETADO, COP.DESUM, '+
                                ' OP.NUMPED, OP.ORDCLI, ' +
                                ' PRO.C_COD_PRO ||''-''|| PRO.C_NOM_PRO PRODUTO, '+
                                ' COR.NOM_COR, ' +
                                ' USU.C_NOM_USU '+
                                ' from ROMANEIOPRODUTOITEM IRO, COLETAROMANEIOOP COP, CADUSUARIOS USU, ORDEMPRODUCAOCORPO OP, '+
                                ' CADPRODUTOS PRO, COR '+
                                ' WHERE IRO.CODFILIAL = COP.CODFILIAL ' +
                                ' AND IRO.SEQORDEM = COP.SEQORDEM '+
                                ' AND IRO.SEQFRACAO = COP.SEQFRACAO ' +
                                ' AND IRO.SEQCOLETA = COP.SEQCOLETA '+
                                ' AND COP.CODUSUARIO = USU.I_COD_USU ' +
                                ' AND IRO.CODFILIAL = OP.EMPFIL '+
                                ' AND IRO.SEQORDEM = OP.SEQORD ' +
                                ' AND OP.SEQPRO = PRO.I_SEQ_PRO ' +
                                ' AND OP.CODCOM = COR.COD_COR '+
                                ' and IRO.CODFILIAL = '+RomaneioCorpoEMPFIL.AsString+
                                ' and IRO.SEQROMANEIO = '+RomaneioCorpoSEQROM.AsString +
                                ' ORDER BY COP.DATCOLETA');
    RomaneioProdutoItem.Sql.SaveToFile('c:\consulta.sql');
    RomaneioProdutoItem.open;
  end;
end;

{******************************************************************************}
procedure TFRomaneioGenerico.EClienteFimConsulta(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFRomaneioGenerico.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFRomaneioGenerico.RomaneioCorpoAfterScroll(DataSet: TDataSet);
begin
  PosRomaneioProdutoItem;
  BGerarNota.Enabled := RomaneioCorpoEMPFIL.AsInteger = Varia.CodigoEmpfil;
end;

{******************************************************************************}
procedure TFRomaneioGenerico.BExcluirClick(Sender: TObject);
var
  VpfResultado : String;
begin
  if Confirmacao(CT_DeletaRegistro) then
  begin
    VpfResultado := FunOrdemProducao.ExcluiColetaRomaneioOP(RomaneioCorpoEMPFIL.AsInteger,RomaneioCorpoSEQROM.AsInteger,RomaneioProdutoItemSEQORDEM.AsInteger,
                                            RomaneioProdutoItemSEQFRACAO.AsInteger,RomaneioProdutoItemSEQCOLETA.AsInteger);
    if VpfResultado = '' then
      AtualizaConsulta
    else
      aviso(VpfResultado);
  end;
end;

{******************************************************************************}
procedure TFRomaneioGenerico.BImprimirClick(Sender: TObject);
begin
  if RomaneioCorpoSEQROM.AsInteger <> 0 then
  begin
    FunCrystal.ImprimeRelatorio(Varia.PathRelatorios+ '\Ordem Produção\2500ESPL_Romaneio.rpt',[RomaneioCorpoEMPFIL.AsString,RomaneioCorpoSEQROM.AsString]);
  end;

end;

{******************************************************************************}
procedure TFRomaneioGenerico.BGerarNotaClick(Sender: TObject);
begin
  if RomaneioCorpoEMPFIL.AsINTEGER <> 0 then
  begin
    FNovaNotaFiscalNota := TFNovaNotaFiscalNota.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaNotaFiscalNota'));
    IF FNovaNotaFiscalNota.GeraNotaRomaneioGenerico(RomaneioCorpoEMPFIL.AsINTEGER,RomaneioCorpoSEQROM.AsInteger,RomaneioCorpoI_COD_CLI.AsInteger) then
      AtualizaConsulta;
    FNovaNotaFiscalNota.free;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFRomaneioGenerico]);
end.
