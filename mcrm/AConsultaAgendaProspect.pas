unit AConsultaAgendaProspect;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  APrincipal, ExtCtrls, PainelGradiente, Localizacao, StdCtrls,
  Componentes1, ComCtrls, Buttons, Grids, DBGrids, Tabela, DBKeyViolation,
  Db, DBTables, FunData, UnDados, unProspect, ConstMsg, Menus, DBClient;

type
  TFConsultaAgendaProspect = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    SpeedButton1: TSpeedButton;
    Label4: TLabel;
    Label5: TLabel;
    SpeedButton2: TSpeedButton;
    Label6: TLabel;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    EVendedor: TEditLocaliza;
    EProspect: TEditLocaliza;
    Localiza: TConsultaPadrao;
    PanelColor2: TPanelColor;
    BCadastrar: TBitBtn;
    BAlterar: TBitBtn;
    BConsultar: TBitBtn;
    BFechar: TBitBtn;
    GridIndice1: TGridIndice;
    VisitaProspect: TSQL;
    DataVisitaProspect: TDataSource;
    VisitaProspectSEQVISITA: TFMTBCDField;
    VisitaProspectDATCADASTRO: TSQLTimeStampField;
    VisitaProspectDATVISITA: TSQLTimeStampField;
    VisitaProspectDATFIMVISITA: TSQLTimeStampField;
    VisitaProspectCODPROSPECT: TFMTBCDField;
    VisitaProspectNOMPROSPECT: TWideStringField;
    VisitaProspectCODVENDEDOR: TFMTBCDField;
    VisitaProspectC_NOM_VEN: TWideStringField;
    VisitaProspectINDREALIZADO: TWideStringField;
    VisitaProspectCODTIPOAGENDAMENTO: TFMTBCDField;
    VisitaProspectNOMTIPOAGENDAMENTO: TWideStringField;
    VisitaProspectCODUSUARIO: TFMTBCDField;
    VisitaProspectC_NOM_USU: TWideStringField;
    BExcluir: TBitBtn;
    VisitaProspectHORAVISITA: TSQLTimeStampField;
    PopupMenu1: TPopupMenu;
    EfetuarTelemarketing1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure EDatInicioExit(Sender: TObject);
    procedure BConsultarClick(Sender: TObject);
    procedure BAlterarClick(Sender: TObject);
    procedure BCadastrarClick(Sender: TObject);
    procedure BExcluirClick(Sender: TObject);
    procedure EfetuarTelemarketing1Click(Sender: TObject);
  private
    VprOrdem: String;
    FunProspect : TRBFuncoesProspect;
    procedure AtualizaConsulta;
    procedure AdicionaFiltros(VpaSelect: TStrings);
  public
  end;

var
  FConsultaAgendaProspect: TFConsultaAgendaProspect;

implementation
uses
  FunSQL, ANovaAgendaProspect, ANovoTelemarketingProspect;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFConsultaAgendaProspect.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunProspect := TRBFuncoesProspect.cria(FPrincipal.BaseDados);
  EDatInicio.Datetime:= PrimeiroDiaMes(date);
  EDatFim.Datetime:= UltimoDiaMes(date);
  VprOrdem:= ' ORDER BY SEQVISITA';
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFConsultaAgendaProspect.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunProspect.free;
  VisitaProspect.Close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFConsultaAgendaProspect.BFecharClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFConsultaAgendaProspect.AtualizaConsulta;
begin
  VisitaProspect.Close;
  VisitaProspect.SQL.Clear;
  VisitaProspect.SQL.Add('SELECT'+
                         ' VPR.SEQVISITA,'+
                         ' VPR.DATCADASTRO, VPR.DATVISITA, VPR.DATFIMVISITA,'+
                         ' VPR.DATVISITA HORAVISITA, VPR.CODPROSPECT, PRO.NOMPROSPECT,'+
                         ' VPR.CODVENDEDOR, VEN.C_NOM_VEN,'+
                         ' VPR.INDREALIZADO,'+
                         ' VPR.CODTIPOAGENDAMENTO, TAG.NOMTIPOAGENDAMENTO,'+
                         ' VPR.CODUSUARIO, USU.C_NOM_USU'+
                         ' FROM'+
                         ' VISITAPROSPECT VPR, PROSPECT PRO, TIPOAGENDAMENTO TAG, CADUSUARIOS USU, CADVENDEDORES VEN'+
                         ' WHERE'+
                         ' VPR.CODPROSPECT = PRO.CODPROSPECT AND'+
                         ' VPR.CODTIPOAGENDAMENTO = TAG.CODTIPOAGENDAMENTO AND'+
                         ' VPR.CODUSUARIO = USU.I_COD_USU AND'+
                         ' VPR.CODVENDEDOR = VEN.I_COD_VEN');
  AdicionaFiltros(VisitaProspect.SQL);
  VisitaProspect.SQL.Add(VprOrdem);
  VisitaProspect.Open;
end;

{******************************************************************************}
procedure TFConsultaAgendaProspect.AdicionaFiltros(VpaSelect: TStrings);
begin
  VpaSelect.Add(SQLTextoDataEntreAAAAMMDD('VPR.DATVISITA',EDatInicio.DateTime,IncDia(EDatFim.DateTime,1),True));

  if EVendedor.AInteiro <> 0 then
    VpaSelect.Add(' AND VPR.CODVENDEDOR = '+EVendedor.Text);
  if EProspect.AInteiro <> 0 then
    VpaSelect.Add(' AND VPR.CODPROSPECT = '+EProspect.Text);

end;

{******************************************************************************}
procedure TFConsultaAgendaProspect.EDatInicioExit(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFConsultaAgendaProspect.BConsultarClick(Sender: TObject);
var
  VpfDVisita : TRBDAgendaProspect;
begin
  if VisitaProspectSEQVISITA.AsInteger <> 0 then
  begin
    VpfDVisita := TRBDAgendaProspect.Cria;
    FunProspect.CarDVisitaProspect(VisitaProspectSEQVISITA.AsInteger,VpfDVisita);

    FNovaAgendaProspect:= TFNovaAgendaProspect.CriarSDI(Application,'',True);
    FNovaAgendaProspect.ConsultaAgendamento(VpfDVisita);
    FNovaAgendaProspect.Free;
  end;
end;

{******************************************************************************}
procedure TFConsultaAgendaProspect.BAlterarClick(Sender: TObject);
var
  VpfDVisita : TRBDAgendaProspect;
begin
  if VisitaProspectSEQVISITA.AsInteger <> 0 then
  begin
    VpfDVisita := TRBDAgendaProspect.Cria;
    FunProspect.CarDVisitaProspect(VisitaProspectSEQVISITA.AsInteger,VpfDVisita);

    FNovaAgendaProspect:= TFNovaAgendaProspect.CriarSDI(Application,'',True);
    FNovaAgendaProspect.AlteraAgendamento(VpfDVisita);
    FNovaAgendaProspect.Free;
  end;
end;

{******************************************************************************}
procedure TFConsultaAgendaProspect.BCadastrarClick(Sender: TObject);
begin
  FNovaAgendaProspect:= TFNovaAgendaProspect.CriarSDI(Application,'',True);
  if FNovaAgendaProspect.NovaAgendaProspect then
    AtualizaConsulta;
  FNovaAgendaProspect.Free;
end;

{******************************************************************************}
procedure TFConsultaAgendaProspect.BExcluirClick(Sender: TObject);
var
  VpfResultado: String;
begin
  if confirmacao('Tem certeza que deseja excluir o item?') then
  begin
    VpfResultado:= FunProspect.ApagaVisitaProspect(VisitaProspectSEQVISITA.AsInteger);
    if VpfResultado <> '' then
      aviso(VpfResultado);
    AtualizaConsulta;
  end;
end;

procedure TFConsultaAgendaProspect.EfetuarTelemarketing1Click(
  Sender: TObject);
begin
  if VisitaProspectCODPROSPECT.AsInteger <> 0 then
  begin
    FNovoTeleMarketingProspect:= TFNovoTeleMarketingProspect.CriarSDI(Application,'',True);
    FNovoTeleMarketingProspect.TeleMarketingProspect(VisitaProspectCODPROSPECT.AsInteger);
    FNovoTeleMarketingProspect.Free;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFConsultaAgendaProspect]);
end.
