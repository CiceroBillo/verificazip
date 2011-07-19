unit ANovaAgendaProspect;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  PainelGradiente, ExtCtrls, Componentes1, BotaoCadastro, StdCtrls, Buttons,
  DBKeyViolation, Db, DBTables, Localizacao, Mask, DBCtrls, Tabela,
  ComCtrls, UnDados, Constantes, FunData, ConstMsg, FunSql, FunString, UnProspect,
  DBClient;

type
  TFNovaAgendaProspect = class(TFormularioPermissao)
    PanelColor1: TPanelColor;
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    BFechar: TBitBtn;
    ValidaGravacao1: TValidaGravacao;
    Label1: TLabel;
    Label2: TLabel;
    VisitaProspect: TSQL;
    VisitaProspectCODPROSPECT: TFMTBCDField;
    VisitaProspectSEQVISITA: TFMTBCDField;
    VisitaProspectDATCADASTRO: TSQLTimeStampField;
    VisitaProspectDATVISITA: TSQLTimeStampField;
    VisitaProspectDATFIMVISITA: TSQLTimeStampField;
    VisitaProspectINDREALIZADO: TWideStringField;
    VisitaProspectCODTIPOAGENDAMENTO: TFMTBCDField;
    VisitaProspectDESAGENDA: TWideStringField;
    VisitaProspectDESREALIZADO: TWideStringField;
    VisitaProspectCODUSUARIO: TFMTBCDField;
    VisitaProspectCODVENDEDOR: TFMTBCDField;
    DataVisitaProspect: TDataSource;
    Localiza: TConsultaPadrao;
    SpeedButton1: TSpeedButton;
    Label3: TLabel;
    Label4: TLabel;
    SpeedButton2: TSpeedButton;
    Label5: TLabel;
    Label6: TLabel;
    SpeedButton3: TSpeedButton;
    Label7: TLabel;
    CARealizar: TRadioButton;
    CRealizado: TRadioButton;
    Label8: TLabel;
    EInicioVisita: TMaskEditColor;
    Label9: TLabel;
    EFimVisita: TMaskEditColor;
    Label10: TLabel;
    EDatVisita: TCalendario;
    Label11: TLabel;
    SpeedButton4: TSpeedButton;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    EDatAgenda: TEditColor;
    ECodUsuario: TEditLocaliza;
    ECodProspect: TEditLocaliza;
    ECodVendedor: TEditLocaliza;
    ECodTipoAgendamento: TEditLocaliza;
    EDesAgenda: TMemoColor;
    EDesVisita: TMemoColor;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure AtualizaEditsLocaliza(Sender: TObject);
    procedure BotaoCancelar1Click(Sender: TObject);
    procedure EInicioVisitaExit(Sender: TObject);
    procedure BotaoGravar1Click(Sender: TObject);
    procedure ValidaGravacao(Sender: TObject);
    procedure ValidaSaidaHorario(Sender: TObject);
  private
    VprAcao: Boolean;
    VprDAgendaProspect: TRBDAgendaProspect;
    VprOperacao: TRBDOperacaoCadastro;
    procedure InicializaClasse;
    procedure CarDTela;
    function CarDClasse: Boolean;
  public
    function NovaAgendaProspect: Boolean; overload;
    function NovaAgendaProspect(VpaCodProspect: Integer): Boolean; overload;
    function AlteraAgendamento(VpaDAgendaProspect: TRBDAgendaProspect): Boolean;
    function ConsultaAgendamento(VpaDAgendaProspect: TRBDAgendaProspect): Boolean;
  end;

var
  FNovaAgendaProspect: TFNovaAgendaProspect;

implementation
uses  APrincipal, FunObjeto;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFNovaAgendaProspect.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprDAgendaProspect:= TRBDAgendaProspect.Cria;
  VisitaProspect.Open;
  VprAcao:= False;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovaAgendaProspect.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  VisitaProspect.Close;
  VprDAgendaProspect.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFNovaAgendaProspect.BFecharClick(Sender: TObject);
begin
  Self.Close;
end;

{******************************************************************************}
procedure TFNovaAgendaProspect.InicializaClasse;
begin
  VprDAgendaProspect.CodProspect:= 0;
  VprDAgendaProspect.SeqVisita:= 0;
  VprDAgendaProspect.CodTipoAgendamento:= 0;
  VprDAgendaProspect.CodUsuario:= Varia.CodigoUsuario;
  VprDAgendaProspect.CodVendedor:= 0;
  VprDAgendaProspect.DatCadastro:= Now;
  VprDAgendaProspect.DatVisita:= IncHora(Now,0);
  VprDAgendaProspect.DatFimVisita:= VprDAgendaProspect.DatVisita;
  VprDAgendaProspect.IndRealizado:= 'A';
  VprDAgendaProspect.DesAgenda:= '';
  VprDAgendaProspect.DesRealizado:= '';
end;

{******************************************************************************}
procedure TFNovaAgendaProspect.CarDTela;
begin
  EDatAgenda.Text:= FormatDateTime('DD/MM/YYY HH:MM',VprDAgendaProspect.DatCadastro);
  ECodUsuario.Ainteiro := Varia.CodigoUsuario;
  ECodProspect.AInteiro:= VprDAgendaProspect.CodProspect;
  ECodVendedor.AInteiro := VprDAgendaProspect.CodVendedor;
  ECodTipoAgendamento.AInteiro:= VprDAgendaProspect.CodTipoAgendamento;
  CARealizar.Checked:= False;
  CRealizado.Checked:= False;
  case VprDAgendaProspect.IndRealizado of
    'A': CARealizar.Checked:= True;
    'R': CRealizado.Checked:= True;
  end;
  EDatVisita.DateTime:= VprDAgendaProspect.DatVisita;
  EInicioVisita.Text:= FormatDateTime('HH:MM',VprDAgendaProspect.DatVisita);
  EFimVisita.Text:= FormatDateTime('HH:MM',VprDAgendaProspect.DatFimVisita);
  EDesAgenda.Text:= VprDAgendaProspect.DesAgenda;
  EDesVisita.Text:= VprDAgendaProspect.DesRealizado;
  AtualizaLocalizas(PanelColor2);
end;

{******************************************************************************}
procedure TFNovaAgendaProspect.AtualizaEditsLocaliza(Sender: TObject);
begin
  if TEditLocaliza(Sender).Text <> '' then
    TEditLocaliza(Sender).Atualiza;                                  
end;

{******************************************************************************}
function TFNovaAgendaProspect.CarDClasse: Boolean;
begin
  Result:= True;
  VprDAgendaProspect.CodProspect:= StrToInt(ECodProspect.Text);
  VprDAgendaProspect.CodVendedor:= StrToInt(ECodVendedor.Text);
  VprDAgendaProspect.CodTipoAgendamento:= StrToInt(ECodTipoAgendamento.Text);
  VprDAgendaProspect.DesAgenda := EDesAgenda.Lines.Text;
  VprDAgendaProspect.DesRealizado := EDesVisita.Lines.Text;
  if CARealizar.Checked then
    VprDAgendaProspect.IndRealizado:= 'A'
  else
    VprDAgendaProspect.IndRealizado:= 'R';
  VprDAgendaProspect.DatVisita:= MontaData(dia(EDatVisita.Date),
                                              mes(EDatVisita.Date),
                                              ano(EDatVisita.Date))+  StrToTime(EInicioVisita.Text);
  VprDAgendaProspect.DatFimVisita:= MontaData(dia(EDatVisita.Date),
                                              mes(EDatVisita.Date),
                                              ano(EDatVisita.Date)) +
                                              StrToTime(EFimVisita.Text);
  if VprDAgendaProspect.DatVisita > VprDAgendaProspect.DatFimVisita then
  begin
    Result:= False;
    aviso('HORA FINAL INVÁLIDA!!!!'#13'A hora final não pode ser menor que a hora inicial.');
    ActiveControl:= EFimVisita;
  end;
end;

{******************************************************************************}
procedure TFNovaAgendaProspect.BotaoCancelar1Click(Sender: TObject);
begin
  VprAcao:= True;
  BFechar.Click;
end;

{******************************************************************************}
function TFNovaAgendaProspect.NovaAgendaProspect: Boolean;
begin
  InicializaClasse;
  VprOperacao:= ocInsercao;
  ECodProspect.ReadOnly:= false;
  EcodProspect.Enabled:= True;
  SpeedButton2.Enabled:= True;
  CarDTela;
  Activecontrol := ECodProspect;
  ShowModal;
  Result:= VprAcao;
end;

{******************************************************************************}
function TFNovaAgendaProspect.NovaAgendaProspect(VpaCodProspect: Integer): Boolean;
begin
  InicializaClasse;
  VprOperacao:= ocInsercao;
  VprDAgendaProspect.CodProspect:= VpaCodProspect;
  CarDTela;
  ShowModal;
  Result:= VprAcao;
end;

{******************************************************************************}
function TFNovaAgendaProspect.AlteraAgendamento(VpaDAgendaProspect: TRBDAgendaProspect): Boolean;
begin
  VprDAgendaProspect.free;
  VprDAgendaProspect:= VpaDAgendaProspect;
  CarDTela;
  VprOperacao:= ocEdicao;
  ActiveControl:= ECodVendedor;
  ShowModal;
  Result:= VprAcao;
end;

{******************************************************************************}
function TFNovaAgendaProspect.ConsultaAgendamento(VpaDAgendaProspect: TRBDAgendaProspect): Boolean;
begin
  VprDAgendaProspect.free;
  VprDAgendaProspect:= VpaDAgendaProspect;
  CarDTela;
  VprOperacao:= ocConsulta;
  ActiveControl:= BFechar;
  PanelColor2.Enabled:= False;
  BGravar.Enabled:= False;
  BCancelar.Enabled:= False;
  ShowModal;
end;

{******************************************************************************}
procedure TFNovaAgendaProspect.EInicioVisitaExit(Sender: TObject);
begin
  VprDAgendaProspect.DatVisita:= MontaData(dia(EDatVisita.Date),
                                           mes(EDatVisita.Date),
                                           ano(EDatVisita.Date)) +
                                           StrToTime(EInicioVisita.Text);
  VprDAgendaProspect.DatFimVisita:= IncMinuto(VprDAgendaProspect.DatVisita,5);
  EFimVisita.Text:= FormatDateTime('HH:MM',VprDAgendaProspect.DatFimVisita);
end;

{******************************************************************************}
procedure TFNovaAgendaProspect.BotaoGravar1Click(Sender: TObject);
var
  VpfResultado: String;
begin
  if CarDClasse then
    VpfResultado:= FunProspect.GravaDAgendaProspect(VprDAgendaProspect)
  else
    Exit;
  if VpfResultado <> '' then
    aviso(VpfResultado)
  else
  begin
    VprAcao := true;
    Self.Close;
  end;
end;

{******************************************************************************}
procedure TFNovaAgendaProspect.ValidaGravacao(Sender: TObject);
begin
  if (VprOperacao in [ocInsercao,ocEdicao]) then
    ValidaGravacao1.execute;
end;

{******************************************************************************}
procedure TFNovaAgendaProspect.ValidaSaidaHorario(Sender: TObject);
begin
  try
    if DeletaEspaco(DeletaChars(TMaskEditColor(Sender).Text,':')) <> '' then
      StrToTime(TMaskEditColor(Sender).Text);
  except
    aviso('HORÁRIO INVÁLIDO!!!'#13'Informe um horário válido.');
    ActiveControl:= TMaskEditColor(Sender);
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
  RegisterClasses([TFNovaAgendaProspect]);
end.
