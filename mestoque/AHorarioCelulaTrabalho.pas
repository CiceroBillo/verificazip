unit AHorarioCelulaTrabalho;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Grids, CGrades, StdCtrls, Buttons, Componentes1, ExtCtrls, UnDadosProduto, UnOrdemProducao,
  PainelGradiente, Localizacao;

type
  TFHorarioCelulaTrabalho = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    Grade: TRBStringGridColor;
    ConsultaPadrao1: TConsultaPadrao;
    EHorario: TEditLocaliza;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure GradeCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GradeDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure GradeGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GradeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GradeNovaLinha(Sender: TObject);
    procedure GradeSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure EHorarioRetorno(Retorno1, Retorno2: String);
    procedure EHorarioCadastrar(Sender: TObject);
  private
    { Private declarations }
    VprAcao : Boolean;
    VprDCelula : TRBDCelulaTrabalho;
    VprDHorario : TRBDHorarioCelula;
    FunOrdemProducao : TRBFuncoesOrdemProducao;
    procedure CarTitulosGrade;
    function ExisteHorarioTrabalho : Boolean;
  public
    { Public declarations }
    function HorarioTrabalhoCelula(VpaDCelula : TRBDCelulaTrabalho):Boolean;
  end;

var
  FHorarioCelulaTrabalho: TFHorarioCelulaTrabalho;

implementation

uses APrincipal, ConstMsg, AHorarioTrabalho;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFHorarioCelulaTrabalho.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunOrdemProducao := TRBFuncoesOrdemProducao.cria(FPrincipal.BaseDados);
  CarTitulosGrade;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFHorarioCelulaTrabalho.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunordemProducao.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFHorarioCelulaTrabalho.BCancelarClick(Sender: TObject);
begin
  VprAcao := false;
  close;
end;

{******************************************************************************}
procedure TFHorarioCelulaTrabalho.BGravarClick(Sender: TObject);
Var
  VpfResultado : String;
begin
  VpfResultado := FunOrdemProducao.GravaDHorarioCelulaTrabalho(VprDCelula);
  if VpfResultado = '' then
  begin
    VprAcao := true;
    Close;
  end
  else
    aviso(VpfResultado);
end;

{******************************************************************************}
function TFHorarioCelulaTrabalho.HorarioTrabalhoCelula(VpaDCelula : TRBDCelulaTrabalho):Boolean;
begin
  VprDCelula := VpaDCelula;
  Grade.ADados := VpaDCelula.Horarios;
  Grade.CarregaGrade;
  Showmodal;
  result := VprAcao;
end;

{******************************************************************************}
procedure TFHorarioCelulaTrabalho.CarTitulosGrade;
begin
  Grade.Cells[1,0] := 'Código';
  Grade.Cells[2,0] := 'Hora Inicio';
  Grade.Cells[3,0] := 'Hora Fim';
end;

{******************************************************************************}
function TFHorarioCelulaTrabalho.ExisteHorarioTrabalho : Boolean;
var
  VpfDesHoraInicio, VpfDesHoraFim : String;
begin
  result := FunOrdemProducao.ExisteHorarioTrabalho(Grade.Cells[1,Grade.ALinha],VpfDesHoraInicio,VpfDesHoraFim);
  if result then
  begin
    Grade.Cells[2,Grade.ALinha] := VpfDesHoraInicio;
    Grade.Cells[3,Grade.ALinha] := VpfDesHoraFim;
  end;
end;

{******************************************************************************}
procedure TFHorarioCelulaTrabalho.GradeCarregaItemGrade(
  Sender: TObject; VpaLinha: Integer);
begin
  VprDHorario := TRBDHorarioCelula(VprDCelula.Horarios.Items[VpaLinha-1]);
  if VprDHorario.CodHorario <> 0 then
    Grade.Cells[1,VpaLinha] := IntTostr(VprDHorario.CodHorario)
  else
    Grade.Cells[1,VpaLinha] := '';
  Grade.Cells[2,VpaLinha] := VprDHorario.DesHoraInicio;
  Grade.Cells[3,VpaLinha] := VprDHorario.DesHoraFim;
end;

{******************************************************************************}
procedure TFHorarioCelulaTrabalho.GradeDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if not ExisteHorarioTrabalho then
  begin
    VpaValidos := false;
    aviso('HORARIO DE TRABALHO NÃO PREENCHIDO!!!'#13'É necessário preencher o horário de trabalho.');
    Grade.Col := 1;
  end;
  if VpaValidos then
  begin
    VprDHorario.CodHorario := StrtoInt(grade.Cells[1,Grade.ALinha]);
    VprDHorario.DesHoraInicio := Grade.Cells[2,Grade.ALinha];
    VprdHorario.DesHoraFim := Grade.Cells[3,Grade.ALinha];
    if FunOrdemProducao.ExisteHorarioCelulaDuplicado(VprDCelula) then
    begin
      VpaValidos := false;
      aviso('HORÁRIO TRABALHO DUPLICADO!!!'#13'O horário de trabalho digitado está duplicado.');
      Grade.Col := 1;
    end;
  end;
end;

{******************************************************************************}
procedure TFHorarioCelulaTrabalho.GradeGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  if ACol = 1 then
    Value := '000000;0; ';
end;

{******************************************************************************}
procedure TFHorarioCelulaTrabalho.GradeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 114 then
    EHorario.AAbreLocalizacao;
end;

{******************************************************************************}
procedure TFHorarioCelulaTrabalho.GradeMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDCelula.Horarios.Count > 0 then
    VprDHorario := TRBDHorarioCelula(VprDCelula.Horarios.Items[VpaLinhaAtual -1]);
end;

procedure TFHorarioCelulaTrabalho.GradeNovaLinha(Sender: TObject);
begin
  VprDHorario := VprDCelula.addHorario;
end;

procedure TFHorarioCelulaTrabalho.GradeSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if Grade.AEstadoGrade in [egInsercao,EgEdicao] then
    if Grade.AColuna <> ACol then
    begin
      case Grade.AColuna of
        1 : if Grade.Cells[1,Grade.Alinha] <> '' then
            begin
              if not ExisteHorarioTrabalho then
              begin
                if not EHorario.AAbreLocalizacao then
                begin
                  Aviso('HORÁRIO DE TRABALHO INVÁLIDO!!!'#13'O horario de trabalho não existe cadastrado.');
                  Grade.Col := 1;
                  abort;
                end;
              end;
            end
            else
              EHorario.AAbreLocalizacao;
      end;
    end;
end;

{******************************************************************************}
procedure TFHorarioCelulaTrabalho.EHorarioRetorno(Retorno1,
  Retorno2: String);
begin
  if Retorno1 <> '' then
  begin
    Grade.Cells[1,Grade.ALinha] := EHorario.Text;
    Grade.Cells[2,grade.ALinha] := Retorno1;
    Grade.Cells[3,Grade.ALinha] := Retorno2;
  end;

end;

{******************************************************************************}
procedure TFHorarioCelulaTrabalho.EHorarioCadastrar(Sender: TObject);
begin
  FHorarioTrabalho := tFHorarioTrabalho.CriarSDI(application,'', FPrincipal.VerificaPermisao('FHorarioTrabalho'));
  FHorarioTrabalho.BotaoCadastrar1.Click;
  FHorarioTrabalho.showmodal;
  FHorarioTrabalho.free;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFHorarioCelulaTrabalho]);
end.
