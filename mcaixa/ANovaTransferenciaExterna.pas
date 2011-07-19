unit ANovaTransferenciaExterna;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Grids, CGrades, StdCtrls, Buttons, UnDadosCR, UnCaixa, ConstMsg, DmRave;

type
  TRBDColunaGrade =(clMarcar,clValAtual,clValInicial,clCodFormaPagamento,clNomFormaPagamento);
  TFNovaTransferenciaExterna = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    Grade: TRBStringGridColor;
    BOk: TBitBtn;
    BCancelar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure BCancelarClick(Sender: TObject);
    procedure GradeCellClick(Button: TMouseButton; Shift: TShiftState;
      VpaColuna, VpaLinha: Integer);
    procedure GradeDblClick(Sender: TObject);
    procedure GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GradeClick(Sender: TObject);
    procedure BOkClick(Sender: TObject);
    procedure GradeDadosValidos(Sender: TObject; var VpaValidos: Boolean);
  private
    { Private declarations }
    VprAcao : Boolean;
    VprSeqCaixa: Integer;
    VprDTransferencia : TRBDTransferenciaExterna;
    VprDFormaPagamentoTransferencia : TRBDTransferenciaExternaFormaPagamento;
    procedure CarTitulosGrade;
    function RColunaGrade(VpaColuna : TRBDColunaGrade):Integer;
  public
    { Public declarations }
    function NovaTransferencia(VpaSeqCaixa : Integer) : Boolean;
  end;

var
  FNovaTransferenciaExterna: TFNovaTransferenciaExterna;

implementation

uses APrincipal, ANovaTransferenciaCheques, FunString;

{$R *.DFM}


{ **************************************************************************** }
procedure TFNovaTransferenciaExterna.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprDTransferencia := TRBDTransferenciaExterna.cria;
  VprAcao := false;
  CarTitulosGrade;
end;

{******************************************************************************}
procedure TFNovaTransferenciaExterna.GradeCarregaItemGrade(Sender: TObject;VpaLinha: Integer);
begin
  VprDFormaPagamentoTransferencia := TRBDTransferenciaExternaFormaPagamento(VprDTransferencia.FormasPagamento.Items[VpaLinha-1]);
  if VprDFormaPagamentoTransferencia.IndMarcado then
    Grade.Cells[RColunaGrade(clMarcar),VpaLinha] := '1'
  else
    Grade.Cells[RColunaGrade(clMarcar),VpaLinha] := '0';
  Grade.Cells[RColunaGrade(clValAtual),VpaLinha] := FormatFloat('#,###,###,###,##0.00',VprDFormaPagamentoTransferencia.ValFinal);
  Grade.Cells[RColunaGrade(clValInicial),VpaLinha] := FormatFloat('#,###,###,###,##0.00',VprDFormaPagamentoTransferencia.ValInicial);
  Grade.Cells[RColunaGrade(clCodFormaPagamento),VpaLinha] := IntToStr(VprDFormaPagamentoTransferencia.CodFormaPagamento);
  Grade.Cells[RColunaGrade(clNomFormaPagamento),VpaLinha] := VprDFormaPagamentoTransferencia.NomFormaPagamento;
end;

{******************************************************************************}
procedure TFNovaTransferenciaExterna.GradeCellClick(Button: TMouseButton;
  Shift: TShiftState; VpaColuna, VpaLinha: Integer);
begin
  if (VpaLinha >= 1) and (VpaColuna = 1) then
  begin
    if Grade.Cells[RColunaGrade(clMarcar),VpaLinha] = '0' then
    begin
      Grade.Cells[RColunaGrade(clMarcar),VpaLinha] := '1';
      TRBDTransferenciaExternaFormaPagamento(VprDTransferencia.FormasPagamento[VpaLinha - 1]).IndMarcado := true;
    end
    else
    begin
      TRBDTransferenciaExternaFormaPagamento(VprDTransferencia.FormasPagamento[VpaLinha - 1]).IndMarcado := false;
      Grade.Cells[RColunaGrade(clMarcar),VpaLinha] := '0';
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaTransferenciaExterna.GradeClick(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFNovaTransferenciaExterna.GradeDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if not VprDFormaPagamentoTransferencia.IndPossuiCheques then
    VprDFormaPagamentoTransferencia.ValFinal := StrToFloat(DeletaChars(Grade.Cells[RColunaGrade(clValAtual),Grade.ALinha],'.'));
  if VprDFormaPagamentoTransferencia.ValFinal < 0 then
  begin
    aviso('VALOR INVÁLIDO!!!'#13'O valor transferido não pode ser negativo.');
    VpaValidos := false;
    Grade.Col := RColunaGrade(clValAtual);
  end;

end;

procedure TFNovaTransferenciaExterna.GradeDblClick(Sender: TObject);
begin
  if VprDFormaPagamentoTransferencia.IndPossuiCheques then
  begin
    FNovaTransferenciaCheques := TFNovaTransferenciaCheques.criarSDI(Application,'',FPrincipal.VerificaPermisao('FNovaTransferenciaCheques'));
    FNovaTransferenciaCheques.ConsultaCheques(VprDFormaPagamentoTransferencia);
    FNovaTransferenciaCheques.free;
    Grade.CarregaGrade(true);
  end;
end;

{******************************************************************************}
procedure TFNovaTransferenciaExterna.GradeMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDTransferencia.FormasPagamento.Count > 0 then
  begin
    VprDFormaPagamentoTransferencia := TRBDTransferenciaExternaFormaPagamento(VprDTransferencia.FormasPagamento.Items[VpaLinhaAtual -1]);
  end;
end;

{******************************************************************************}
function TFNovaTransferenciaExterna.NovaTransferencia(VpaSeqCaixa: Integer): Boolean;
begin
  VprDTransferencia.Free;
  VprDTransferencia := TRBDTransferenciaExterna.cria;
  VprSeqCaixa:= VpaSeqCaixa;
  FunCaixa.InicializaNovaTransferenciaExterna(VprDTransferencia,VpaSeqCaixa);
  Grade.ADados := VprDTransferencia.FormasPagamento;
  Grade.CarregaGrade;
  ShowModal;
  result := VprAcao;
end;

{******************************************************************************}
function TFNovaTransferenciaExterna.RColunaGrade(VpaColuna: TRBDColunaGrade): Integer;
begin
  case VpaColuna of
    clMarcar: result := 1;
    clValAtual:result := 2 ;
    clValInicial: result := 3;
    clCodFormaPagamento:result := 4;
    clNomFormaPagamento: result := 5;
  end;
end;

{ *************************************************************************** }
procedure TFNovaTransferenciaExterna.BCancelarClick(Sender: TObject);
begin
  VprAcao := false;
  close;
end;


{******************************************************************************}
procedure TFNovaTransferenciaExterna.BOkClick(Sender: TObject);
var
  VpfResultado: String;
begin
  VpfResultado := FunCaixa.GravaDTransferencias(VprDTransferencia);
  if VpfResultado <> '' then
    aviso(VpfResultado)
  else
  begin
    VprAcao := true;
    dtRave := TdtRave.create(self);
    dtRave.ImprimeTransferenciaExterna(VprDTransferencia.SeqTransferencia);
    dtRave.free;

    close;
  end;
end;

{******************************************************************************}
procedure TFNovaTransferenciaExterna.CarTitulosGrade;
begin
  Grade.Cells[RColunaGrade(clValAtual),0] := 'Valor Atual';
  Grade.Cells[RColunaGrade(clValInicial),0] := 'Valor Inicial';
  Grade.Cells[RColunaGrade(clCodFormaPagamento),0] := 'Código';
  Grade.Cells[RColunaGrade(clNomFormaPagamento),0] := 'Forma Pagamento';
end;

{******************************************************************************}
procedure TFNovaTransferenciaExterna.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  VprDTransferencia.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovaTransferenciaExterna]);
end.
