unit ACaixas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Db, DBTables, Grids, DBGrids, Tabela, DBKeyViolation, Componentes1,
  ExtCtrls, PainelGradiente, StdCtrls, Buttons, Localizacao, ComCtrls, DBClient;

type
  TFCaixas = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    GridIndice1: TGridIndice;
    CaixaCorpo: TSQL;
    DataCaixaCorpo: TDataSource;
    CaixaCorpoSEQCAIXA: TFMTBCDField;
    CaixaCorpoNUMCONTA: TWideStringField;
    CaixaCorpoDATABERTURA: TSQLTimeStampField;
    CaixaCorpoDATFECHAMENTO: TSQLTimeStampField;
    CaixaCorpoVALINICIAL: TFMTBCDField;
    CaixaCorpoVALATUAL: TFMTBCDField;
    CaixaCorpoVALFINAL: TFMTBCDField;
    CaixaCorpoUSUABERTURA: TWideStringField;
    CaixaCorpoUSUFECHAMENTO: TWideStringField;
    BAbertura: TBitBtn;
    BFechamento: TBitBtn;
    BImprimir: TBitBtn;
    BFechar: TBitBtn;
    Localiza: TConsultaPadrao;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    Label2: TLabel;
    EContaCaixa: TEditLocaliza;
    Label4: TLabel;
    EDataFinal: TCalendario;
    EDataInicial: TCalendario;
    CPeriodo: TCheckBox;
    BTransferencia: TBitBtn;
    BAplicar: TBitBtn;
    BResgatar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GridIndice1Ordem(Ordem: String);
    procedure BFecharClick(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure BAberturaClick(Sender: TObject);
    procedure BFechamentoClick(Sender: TObject);
    procedure EContaCaixaFimConsulta(Sender: TObject);
    procedure BTransferenciaClick(Sender: TObject);
    procedure BAplicarClick(Sender: TObject);
    procedure BResgatarClick(Sender: TObject);
  private
    { Private declarations }
    VprOrdem : String;
    procedure Atualizaconsulta;
    procedure AdicionaFiltros(VpaSelect : TStrings);
  public
    { Public declarations }
  end;

var
  FCaixas: TFCaixas;

implementation

uses APrincipal, Uncrystal, Constantes, ANovoCaixa, AFechamentoCaixa, Funsql, FunData,
  ANovaTransferencia, dmRave, ATipoTransferenciaCaixa;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFCaixas.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprOrdem := 'order by CAC.SEQCAIXA';
  CPeriodo.Checked := true;
  EDataFinal.DateTime := UltimoDiaMes(date);
  EDataInicial.DateTime := PrimeiroDiaMes(date);
  Atualizaconsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFCaixas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  CaixaCorpo.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFCaixas.Atualizaconsulta;
begin
  CaixaCorpo.Close;
  CaixaCorpo.sql.clear;
  CaixaCorpo.sql.add('Select  CAC.SEQCAIXA, CAC.NUMCONTA, CAC.DATABERTURA, ' +
                     ' CAC.DATFECHAMENTO, CAC.VALINICIAL, CAC.VALATUAL, '+
                     ' CAC.VALFINAL, '+
                     ' USA.C_NOM_USU USUABERTURA, '+
                     '  USF.C_NOM_USU USUFECHAMENTO '+
                     ' FROM CAIXACORPO CAC, CADUSUARIOS USA, CADUSUARIOS USF '+
                     ' Where CAC.CODUSUARIOABERTURA = USA.I_COD_USU '+
                     ' and '+SQLTextoRightJoin('CAC.CODUSUARIOFECHAMENTO','USF.I_COD_USU'));
  AdicionaFiltros(CaixaCorpo.sql);
  CaixaCorpo.sql.add(Vprordem);
  CaixaCorpo.open;
  GridIndice1.ALinhaSQLOrderBy:= CaixaCorpo.sql.count -1;
end;

{******************************************************************************}
procedure TFCaixas.AdicionaFiltros(VpaSelect : TStrings);
begin
  IF EContaCaixa.Text <> '' then
    VpaSelect.add('AND CAC.NUMCONTA = '''+EContaCaixa.Text+'''');
  if CPeriodo.Checked then
    VpaSelect.add(SQLTextoDataEntreAAAAMMDD('DATABERTURA',EDataInicial.DateTime,INCDIA(EDataFinal.DateTime,1),true));
end;

{******************************************************************************}
procedure TFCaixas.GridIndice1Ordem(Ordem: String);
begin
  VprOrdem := Ordem;
end;

{******************************************************************************}
procedure TFCaixas.BFecharClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFCaixas.BImprimirClick(Sender: TObject);
begin
  if CaixaCorpoSEQCAIXA.AsInteger <> 0 then
  begin
    dtRave := TdtRave.create(self);
    dtRave.ImprimeCaixa(CaixaCorpoSEQCAIXA.AsInteger);
    dtRave.free;
  end;
end;

{******************************************************************************}
procedure TFCaixas.BResgatarClick(Sender: TObject);
begin
  if CaixaCorpoNUMCONTA.AsString <> '' then
  begin
    FNovaTransferencia := TFNovaTransferencia.criarSDI(Application,'',FPrincipal.VerificaPermisao('FNovaTransferencia'));
    FNovaTransferencia.ResgataDinheiro(CaixaCorpoNUMCONTA.AsString);
    FNovaTransferencia.free;
  end;
end;

{******************************************************************************}
procedure TFCaixas.BAberturaClick(Sender: TObject);
begin
  FNovoCaixa := tFNovoCaixa.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoCaixa'));
  if FNovoCaixa.NovoCaixa then
    Atualizaconsulta;
  FNovoCaixa.free;
end;

procedure TFCaixas.BAplicarClick(Sender: TObject);
begin
  if CaixaCorpoNUMCONTA.AsString <> '' then
  begin
    FNovaTransferencia := TFNovaTransferencia.criarSDI(Application,'',FPrincipal.VerificaPermisao('FNovaTransferencia'));
    FNovaTransferencia.AplicarDinheiro(CaixaCorpoNUMCONTA.AsString);
    FNovaTransferencia.free;
  end;
end;

{******************************************************************************}
procedure TFCaixas.BFechamentoClick(Sender: TObject);
begin
  if CaixaCorpoSEQCAIXA.AsInteger <> 0 then
  begin
    FFechamentoCaixa := TFFechamentoCaixa.CriarSDI(self,'',FPrincipal.VerificaPermisao('FFechamentoCaixa'));
    if FFechamentoCaixa.FechaCaixa(CaixaCorpoSEQCAIXA.AsInteger) then
      Atualizaconsulta;
    FFechamentoCaixa.free;
  end;
end;

{******************************************************************************}
procedure TFCaixas.EContaCaixaFimConsulta(Sender: TObject);
begin
  Atualizaconsulta;
end;

{******************************************************************************}
procedure TFCaixas.BTransferenciaClick(Sender: TObject);
begin
  if CaixaCorpoNUMCONTA.AsString <> '' then
  begin
    FTipoTransferenciaCaixa := TFTipoTransferenciaCaixa.criarSDI(Application,'',FPrincipal.VerificaPermisao('FTipoTransferenciaCaixa'));
    FTipoTransferenciaCaixa.TransferenciaCaixa(CaixaCorpoSEQCAIXA.AsInteger,CaixaCorpoNUMCONTA.AsString);
    FTipoTransferenciaCaixa.free;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFCaixas]);
end.
