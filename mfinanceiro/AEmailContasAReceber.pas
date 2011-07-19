unit AEmailContasAReceber;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  PainelGradiente, ExtCtrls, Componentes1, StdCtrls, Buttons, ComCtrls, Db,
  DBTables, Grids, DBGrids, Tabela, DBKeyViolation, DBClient;

type
  TFEmailContasaReceber = class(TFormularioPermissao)
    PanelColor1: TPanelColor;
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    BEnviar: TBitBtn;
    BImprimir: TBitBtn;
    BFechar: TBitBtn;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    Label1: TLabel;
    Label2: TLabel;
    ECobranca: TSQL;
    ECobrancaSEQEMAIL: TFMTBCDField;
    ECobrancaDATENVIO: TSQLTimeStampField;
    ECobrancaQTDENVIADOS: TFMTBCDField;
    ECobrancaQTDERROS: TFMTBCDField;
    ECobrancaC_NOM_USU: TWideStringField;
    DataECobranca: TDataSource;
    ECobrancaItem: TSQL;
    ECobrancaItemSEQITEM: TFMTBCDField;
    ECobrancaItemCODFILIAL: TFMTBCDField;
    ECobrancaItemLANRECEBER: TFMTBCDField;
    ECobrancaItemNUMPARCELA: TFMTBCDField;
    ECobrancaItemNOMFINANCEIRO: TWideStringField;
    ECobrancaItemDESEMAIL: TWideStringField;
    ECobrancaItemDESSTATUS: TWideStringField;
    ECobrancaItemINDENVIADO: TWideStringField;
    ECobrancaItemC_NOM_CLI: TWideStringField;
    ECobrancaItemI_NRO_NOT: TFMTBCDField;
    DataSource1: TDataSource;
    PanelColor3: TPanelColor;
    GridIndice2: TGridIndice;
    GridIndice1: TGridIndice;
    Splitter1: TSplitter;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BEnviarClick(Sender: TObject);
    procedure EDatInicioCloseUp(Sender: TObject);
    procedure ECobrancaAfterScroll(DataSet: TDataSet);
    procedure BImprimirClick(Sender: TObject);
  private
    { Private declarations }
    procedure AtualizaConsulta;
    procedure AdicionaFiltros(VpaSelect : TStrings);
    procedure PosECobrancaItem;
  public
    { Public declarations }
  end;

var
  FEmailContasaReceber: TFEmailContasaReceber;

implementation

uses APrincipal, ANovoEmailContasAReceber, FunData, Funsql, UnCrystal,Constantes, dmRave;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFEmailContasaReceber.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EDatInicio.DateTime := date;
  EDatFim.DateTime := date;
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFEmailContasaReceber.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFEmailContasaReceber.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFEmailContasaReceber.BEnviarClick(Sender: TObject);
begin
  FNovoEmailContasAReceber := TFNovoEmailContasAReceber.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoEmailContasAReceber'));
  FNovoEmailContasAReceber.ShowModal;
  FNovoEmailContasAReceber.free;
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFEmailContasaReceber.AtualizaConsulta;
begin
  ECobranca.Close;
  ECobranca.sql.Clear;
  ECobranca.sql.add('select ECO.SEQEMAIL, ECO.DATENVIO, ECO.QTDENVIADOS, ECO.QTDERROS, '+
                    ' USU.C_NOM_USU '+
                    ' from ECOBRANCACORPO ECO, CADUSUARIOS USU '+
                    ' WHERE ECO.CODUSUARIO = USU.I_COD_USU ');
  AdicionaFiltros(ECobranca.sql);
  ECobranca.open;
end;

{******************************************************************************}
procedure TFEmailContasaReceber.AdicionaFiltros(VpaSelect : TStrings);
begin
  VpaSelect.Add(SQLTextoDataEntreAAAAMMDD('ECO.DATENVIO',EDatInicio.DateTime,IncDia(EDatFim.Datetime,1),true));
end;

{******************************************************************************}
procedure TFEmailContasaReceber.PosECobrancaItem;
begin
  IF ECobrancaSEQEMAIL.AsInteger <> 0 then
  begin
    AdicionaSQLAbreTabela(ECobrancaItem,'select ITE.SEQITEM, ITE.CODFILIAL,ITE.LANRECEBER,ITE.NUMPARCELA, ITE.NOMFINANCEIRO, ITE.DESEMAIL, '+
                          'ITE.DESSTATUS, ITE.INDENVIADO, ' +
                          ' CLI.C_NOM_CLI, CAD.I_NRO_NOT ' +
                          ' from ECOBRANCAITEM ITE, CADCONTASARECEBER CAD, CADCLIENTES CLI '+
                          ' Where ITE.CODFILIAL = CAD.I_EMP_FIL '+
                          ' AND ITE.LANRECEBER = CAD.I_LAN_REC '+
                          ' AND CAD.I_COD_CLI = CLI.I_COD_CLI '+
                          ' AND ITE.SEQEMAIL = '+ECobrancaSEQEMAIL.AsString+
                          ' ORDER BY ITE.INDENVIADO');
  end
  else
    ECobrancaItem.close;
end;

{******************************************************************************}
procedure TFEmailContasaReceber.EDatInicioCloseUp(Sender: TObject);
begin
  AtualizaConsulta;
end;

procedure TFEmailContasaReceber.ECobrancaAfterScroll(DataSet: TDataSet);
begin
  PosECobrancaItem;
end;

procedure TFEmailContasaReceber.BImprimirClick(Sender: TObject);
begin
  if ECobrancaSEQEMAIL.AsInteger <> 0 then
  begin
    dtRave := tdtRave.Create(self);
    dtRave.ImprimeHistoricoECobranca(ECobrancaSEQEMAIL.asInteger);
    dtRave.free;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFEmailContasaReceber]);
end.
