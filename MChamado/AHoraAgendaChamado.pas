unit AHoraAgendaChamado;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente, Localizacao,
  ComCtrls, Mask, UnDados, DBKeyViolation, UnChamado;

type
  TFHoraAgendaChamado = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    Label4: TLabel;
    SpeedButton2: TSpeedButton;
    SpeedButton4: TSpeedButton;
    ECliente: TEditLocaliza;
    Label3: TLabel;
    ENumChamado: TEditColor;
    ESolicitante: TEditColor;
    Label7: TLabel;
    Label12: TLabel;
    SpeedButton3: TSpeedButton;
    Label13: TLabel;
    ETecnico: TEditLocaliza;
    Label1: TLabel;
    Bevel1: TBevel;
    EData: TCalendario;
    Label2: TLabel;
    EHora: TMaskEditColor;
    Label5: TLabel;
    ECalendario: TMonthCalendar;
    Localiza: TConsultaPadrao;
    ValidaGravacao1: TValidaGravacao;
    ECidade: TEditColor;
    Label6: TLabel;
    SpeedButton1: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure EDataChange(Sender: TObject);
    procedure ECalendarioClick(Sender: TObject);
    procedure ETecnicoChange(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure EClienteRetorno(Retorno1, Retorno2: String);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
    VprAcao : Boolean;
    VprDChamado : TRBDChamado;
    FunChamado : TRBFuncoesChamado;
    procedure CarDTela(VpaDChamado : TRBDChamado);
    function DadosValidos : string;
  public
    { Public declarations }
    function AlteraAgenda(VpaDChamado : TRBDChamado):Boolean;
  end;

var
  FHoraAgendaChamado: TFHoraAgendaChamado;

implementation

uses APrincipal,FunString, ConstMsg, funDAta, ANovoCliente,
  ANovoChamadoTecnico, Constantes;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFHoraAgendaChamado.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunChamado := TRBFuncoesChamado.cria(FPrincipal.BaseDados);
  if ((varia.CNPJFilial = CNPJ_COPYLINE) or
     (varia.CNPJFilial = CNPJ_Impox)) then
  begin
   SpeedButton1.Visible := false;
   SpeedButton4.Visible := false;
  end;

end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFHoraAgendaChamado.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Funchamado.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFHoraAgendaChamado.CarDTela(VpaDChamado : TRBDChamado);
begin
  ENumChamado.AInteiro := VpaDChamado.NumChamado;
  ECliente.AInteiro := VpaDChamado.CodCliente;
  ESolicitante.Text := VpaDChamado.NomSolicitante;
  ECliente.Atualiza;
  ETecnico.AInteiro := VpaDChamado.CodTecnico;
  ETecnico.Atualiza;
  EHora.Text := FormatDateTime('HH:MM',VpaDChamado.DatPrevisao);
  EData.DateTime := VpaDChamado.DatPrevisao;
  ECalendario.Date := VpaDChamado.DatPrevisao;
end;

{******************************************************************************}
function TFHoraAgendaChamado.DadosValidos : string;
begin
  result := '';
{  if DeletaChars(DeletaChars(EHora.Text,'0'),':') = '' then
    result := 'HORA NÃO PREENCHIDA!!!'#13'É necessário preencher a hora do agendamento.';}
  if result = '' then
  begin
    try
      StrToTime(EHora.Text)
    except
      result := 'HORA INVÁLIDA!!!'#13'A hora digitada não está em um formato válido.';
    end;
 end;
end;

{******************************************************************************}
procedure TFHoraAgendaChamado.BCancelarClick(Sender: TObject);
begin
  vpracao := false;
  CLOSE;
end;

{******************************************************************************}
procedure TFHoraAgendaChamado.BGravarClick(Sender: TObject);
var
  VpfResultado : String;
begin
  VpfResultado := DadosValidos;
  if VpfResultado = '' then
    FunChamado.AlteraAgendaTecnico(VprDChamado.CodFilial,VprDChamado.NumChamado,ETecnico.AInteiro,MontaData(dia(EData.Date),mes(EData.Date),ano(EData.Date))+StrToTime(EHora.text));
  if Vpfresultado = '' then
  begin
    VprAcao := true;
    VprDChamado.CodTecnico := ETecnico.AInteiro;
    close;
  end
  else
    aviso(VpfREsultado);
end;

{******************************************************************************}
function TFHoraAgendaChamado.AlteraAgenda(VpaDChamado : TRBDChamado):Boolean;
begin
  VprDChamado := VpaDChamado;
  CarDTela(VpaDChamado);
  ShowModal;
  result := Vpracao;
end;

{******************************************************************************}
procedure TFHoraAgendaChamado.EDataChange(Sender: TObject);
begin
  ECalendario.Date := EData.DateTime;
end;

{******************************************************************************}
procedure TFHoraAgendaChamado.ECalendarioClick(Sender: TObject);
begin
  EData.DateTime := ECalendario.Date;
end;

{******************************************************************************}
procedure TFHoraAgendaChamado.ETecnicoChange(Sender: TObject);
begin
  ValidaGravacao1.execute;
end;

procedure TFHoraAgendaChamado.SpeedButton4Click(Sender: TObject);
begin
  if ECliente.AInteiro <> 0 then
  begin
    FNovoCliente := TFNovoCliente.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoCliente'));
    FNovoCliente.ConsultaCliente(ECliente.AInteiro);
    FNovoCliente.free;
  end;
end;

{******************************************************************************}
procedure TFHoraAgendaChamado.EClienteRetorno(Retorno1, Retorno2: String);
begin
  ECidade.Text := Retorno1;
end;

{******************************************************************************}
procedure TFHoraAgendaChamado.SpeedButton1Click(Sender: TObject);
begin
  FNovoChamado := TFNovoChamado.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoChamado'));
  FNovoChamado.ConsultaChamado(VprDChamado.CodFilial,VprDChamado.NumChamado);
  FNovoChamado.free;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFHoraAgendaChamado]);
end.
