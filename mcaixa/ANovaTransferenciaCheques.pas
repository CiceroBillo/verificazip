unit ANovaTransferenciaCheques;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Grids, CGrades, Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Buttons, UnDadosCR, FunData, UnCaixa;

type
  TRBDColunaGrade =(clMarcar,clNumCheque,clNomEmitente,clValCheque,clDatVencimento);
  TFNovaTransferenciaCheques = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    Grade: TRBStringGridColor;
    BOk: TBitBtn;
    BFechar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure BCancelarClick(Sender: TObject);
    procedure GradeCellClick(Button: TMouseButton; Shift: TShiftState;
      VpaColuna, VpaLinha: Integer);
    procedure BOkClick(Sender: TObject);
    procedure GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure BFecharClick(Sender: TObject);
  private
     VprDTransferenciaCheques : TRBDTransferenciaExternaCheques;
     VprDFormaPagamento : TRBDTransferenciaExternaFormaPagamento;
     function RColunaGrade(VpaColuna : TRBDColunaGrade):Integer;
     procedure CarTitulosGrade;
  public
    { Public declarations }
    procedure ConsultaCheques(VpaDFormaPagamento : TRBDTransferenciaExternaFormaPagamento);
  end;

var
  FNovaTransferenciaCheques: TFNovaTransferenciaCheques;

implementation

uses APrincipal;

{$R *.DFM}


{ **************************************************************************** }
procedure TFNovaTransferenciaCheques.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  CarTitulosGrade;
end;

{******************************************************************************}
procedure TFNovaTransferenciaCheques.GradeCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDTransferenciaCheques := TRBDTransferenciaExternaCheques(VprDFormaPagamento.Cheques.Items[VpaLinha-1]);
  if VprDTransferenciaCheques.IndMarcado then
    Grade.Cells[RColunaGrade(clMarcar),VpaLinha] := '1'
  else
    Grade.Cells[RColunaGrade(clMarcar),VpaLinha] := '0';
  Grade.Cells[RColunaGrade(clNumCheque),VpaLinha] := IntToStr(VprDTransferenciaCheques.NumCheque);
  Grade.Cells[RColunaGrade(clNomEmitente),VpaLinha] := VprDTransferenciaCheques.NomEmitente;
  Grade.Cells[RColunaGrade(clValCheque),VpaLinha] := FormatFloat('#,###,###,###,##0.00',VprDTransferenciaCheques.ValCheque);
  If VprDTransferenciaCheques.DatVencimento > MontaData(1,1,1990) then
    Grade.Cells[RColunaGrade(clDatVencimento),VpaLinha] := FormatDateTime('DD/MM/YYYY',VprDTransferenciaCheques.DatVencimento)
  else
    Grade.Cells[RColunaGrade(clDatVencimento),VpaLinha] := '';
end;

{******************************************************************************}
procedure TFNovaTransferenciaCheques.GradeCellClick(Button: TMouseButton;
  Shift: TShiftState; VpaColuna, VpaLinha: Integer);
begin
  if (VpaLinha >= 1) and (VpaColuna = 1) then
  begin
    if Grade.Cells[RColunaGrade(clMarcar),VpaLinha] = '0' then
    begin
      Grade.Cells[RColunaGrade(clMarcar),VpaLinha] := '1';
      VprDTransferenciaCheques.IndMarcado:= true;
    end
    else
    begin
      Grade.Cells[RColunaGrade(clMarcar),VpaLinha] := '0';
      VprDTransferenciaCheques.IndMarcado:= False;
    end;
    FunCaixa.CalculaValorTotalCheques(VprDFormaPagamento);
  end;
end;

{******************************************************************************}
procedure TFNovaTransferenciaCheques.GradeMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
   if VprDFormaPagamento.Cheques.Count > 0 then
  begin
    VprDTransferenciaCheques := TRBDTransferenciaExternaCheques(VprDFormaPagamento.Cheques.Items[VpaLinhaAtual -1]);
  end;
end;

{******************************************************************************}
function TFNovaTransferenciaCheques.RColunaGrade(
  VpaColuna: TRBDColunaGrade): Integer;
begin
  case VpaColuna of
    clMarcar: result := 1;
    clNumCheque: result := 2 ;
    clNomEmitente: result := 3;
    clValCheque: result := 4;
    clDatVencimento: result := 5;
  end;
end;

{ *************************************************************************** }
procedure TFNovaTransferenciaCheques.BCancelarClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFNovaTransferenciaCheques.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFNovaTransferenciaCheques.BOkClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFNovaTransferenciaCheques.CarTitulosGrade;
begin
  Grade.Cells[RColunaGrade(clNumCheque),0] := 'Numero Cheque';
  Grade.Cells[RColunaGrade(clNomEmitente),0] := 'Emitente';
  Grade.Cells[RColunaGrade(clValCheque),0] := 'Valor Cheque';
  Grade.Cells[RColunaGrade(clDatVencimento),0] := 'Vencimento';
end;

{******************************************************************************}
procedure TFNovaTransferenciaCheques.ConsultaCheques(VpaDFormaPagamento: TRBDTransferenciaExternaFormaPagamento);
begin
  VprDFormaPagamento:= VpaDFormaPagamento;
  Grade.ADados := VpaDFormaPagamento.Cheques;
  Grade.CarregaGrade;
  ShowModal;
end;

{******************************************************************************}
procedure TFNovaTransferenciaCheques.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovaTransferenciaCheques]);
end.
