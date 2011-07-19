unit ACelulaTrabalho;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  BotaoCadastro, StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente,
  Grids, DBGrids, Tabela, DBKeyViolation, Localizacao, Mask, DBCtrls, Db, UnDadosProduto,
  DBTables, CBancoDados, UnOrdemProducao, DBClient;

type
  TFCelulaTrabalho = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    BEstagios: TBitBtn;
    BHorarios: TBitBtn;
    BCalendario: TBitBtn;
    BExcecoes: TBitBtn;
    CelulaTrabalho: TRBSQL;
    CelulaTrabalhoCODCELULA: TFMTBCDField;
    CelulaTrabalhoNOMCELULA: TWideStringField;
    CelulaTrabalhoINDATIVA: TWideStringField;
    Label1: TLabel;
    DataCelulaTrabalho: TDataSource;
    Label2: TLabel;
    ECodigo: TDBKeyViolation;
    DBEditColor1: TDBEditColor;
    Bevel1: TBevel;
    Label4: TLabel;
    EConsulta: TLocalizaEdit;
    GridIndice1: TGridIndice;
    CAtiva: TDBCheckBox;
    CelulaTrabalhoINDTROCASERVICOFACIL: TWideStringField;
    DBCheckBox1: TDBCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CelulaTrabalhoAfterPost(DataSet: TDataSet);
    procedure BFecharClick(Sender: TObject);
    procedure CelulaTrabalhoAfterEdit(DataSet: TDataSet);
    procedure CelulaTrabalhoAfterInsert(DataSet: TDataSet);
    procedure CelulaTrabalhoBeforePost(DataSet: TDataSet);
    procedure BEstagiosClick(Sender: TObject);
    procedure BHorariosClick(Sender: TObject);
    procedure BCalendarioClick(Sender: TObject);
  private
    { Private declarations }
    VprDCelula : TRBDCelulaTrabalho;
    FunOrdemProducao : TRBFuncoesOrdemProducao;
  public
    { Public declarations }
  end;

var
  FCelulaTrabalho: TFCelulaTrabalho;

implementation

uses APrincipal, AEstagioCelulaTrabalho, AHorarioCelulaTrabalho,
  ACalendarioCelulaTrabalho, Funobjeto;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFCelulaTrabalho.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EConsulta.AtualizaConsulta;
  VprDCelula := TRBDCelulaTrabalho.cria;
  FunOrdemProducao := TRBFuncoesOrdemProducao.cria(FPrincipal.BaseDados);
  InicializaVerdadeiroeFalsoCheckBox(PanelColor1,'S','N');
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFCelulaTrabalho.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  CelulaTrabalho.Close;
  VprDCelula.free;
  FunOrdemProducao.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFCelulaTrabalho.CelulaTrabalhoAfterPost(DataSet: TDataSet);
begin
  EConsulta.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFCelulaTrabalho.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFCelulaTrabalho.CelulaTrabalhoAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
end;

{******************************************************************************}
procedure TFCelulaTrabalho.CelulaTrabalhoAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := false;
  ECodigo.ProximoCodigo;
  CelulaTrabalhoINDATIVA.AsString := 'S';
  CelulaTrabalhoINDTROCASERVICOFACIL.AsString := 'N';
end;

{******************************************************************************}
procedure TFCelulaTrabalho.CelulaTrabalhoBeforePost(DataSet: TDataSet);
begin
  if CelulaTrabalho.state = dsinsert then
    Ecodigo.VerificaCodigoUtilizado;
end;

{******************************************************************************}
procedure TFCelulaTrabalho.BEstagiosClick(Sender: TObject);
begin
  if CelulaTrabalhoCODCELULA.AsInteger <> 0 then
  begin
    VprDCelula.CodCelula := CelulaTrabalhoCODCELULA.AsInteger;
    FunOrdemProducao.CarDCelulaTrabalho(VprDCelula);
    FEstagioCelulaTrabalho := TFEstagioCelulaTrabalho.CriarSDI(application,'', FPrincipal.VerificaPermisao('FEstagioCelulaTrabalho'));
    FEstagioCelulaTrabalho.EstagiosCelula(VprDCelula);
    FEstagioCelulaTrabalho.free;
  end;
end;

{******************************************************************************}
procedure TFCelulaTrabalho.BHorariosClick(Sender: TObject);
begin
  if CelulaTrabalhoCODCELULA.AsInteger <> 0 then
  begin
    VprDCelula.CodCelula := CelulaTrabalhoCODCELULA.AsInteger;
    FunOrdemProducao.CarDCelulaTrabalho(VprDCelula);
    FHorarioCelulaTrabalho := tFHorarioCelulaTrabalho.CriarSDI(application,'', FPrincipal.VerificaPermisao('FHorarioCelulaTrabalho'));
    FHorarioCelulaTrabalho.HorarioTrabalhoCelula(VprDCelula);
    FHorarioCelulaTrabalho.free;
  end;
end;

{******************************************************************************}
procedure TFCelulaTrabalho.BCalendarioClick(Sender: TObject);
begin
  if CelulaTrabalhoCODCELULA.AsInteger <> 0 then
  begin
    FCalendarioCelulaTrabalho := TFCalendarioCelulaTrabalho.CriarSDI(application,'', FPrincipal.VerificaPermisao('FCalendarioCelulaTrabalho'));
    FCalendarioCelulaTrabalho.CalendarioCelulaTrabalho(CelulaTrabalhoCODCELULA.AsInteger);
    FCalendarioCelulaTrabalho.free;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFCelulaTrabalho]);
end.
