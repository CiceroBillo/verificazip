unit AConsultaParcelasCRFluxoCaixa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Grids, CGrades, Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Buttons,
  UnDadosCR, Menus, UnContasaReceber;

type
  TFConsultaParcelasCRFluxoCaixa = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Grade: TRBStringGridColor;
    BFechar: TBitBtn;
    PopupMenu1: TPopupMenu;
    AlterarCliente1: TMenuItem;
    N1: TMenuItem;
    MOcultarNoFluxo: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure AlterarCliente1Click(Sender: TObject);
    procedure MOcultarNoFluxoClick(Sender: TObject);
  private
    { Private declarations }
    VprDParcelaBaixaCR: TRBDParcelaBaixaCR;
    VprDParcelaCP : TRBDParcelaCP;
    VprDiaFluxo : TRBDFluxoCaixaDia;
    procedure CarTitulosGrade;
    procedure CarParcelaContasaReceber(VpaLinha : Integer);
    procedure CarParcelaContasaPagar(VpaLinha : Integer);
  public
    { Public declarations }
    procedure ConsultaParcelasFluxo(VpaDia : TRBDFluxoCaixaDia);overload;
    procedure ConsultaParcelasFluxo(VpaParcelas : Tlist);overload;
  end;

var
  FConsultaParcelasCRFluxoCaixa: TFConsultaParcelasCRFluxoCaixa;

implementation

uses APrincipal, FunData, Constantes, ANovoCliente, FunSql;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFConsultaParcelasCRFluxoCaixa.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  CarTitulosGrade;
end;

{ **************************************************************************** }
procedure TFConsultaParcelasCRFluxoCaixa.GradeCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  if (TObject(Grade.ADados.Items[VpaLinha-1]) is TRBDParcelaBaixaCR) then
    CarParcelaContasaReceber(VpaLinha)
  else
    if (TObject(Grade.ADados.Items[VpaLinha-1]) is TRBDParcelaCP) then
      CarParcelaContasaPagar(VpaLinha)
end;

{ **************************************************************************** }
procedure TFConsultaParcelasCRFluxoCaixa.GradeMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if Grade.ADados.Count > 0 then
  begin
    VprDParcelaBaixaCR:= TRBDParcelaBaixaCR(Grade.ADados.Items[VpaLinhaAtual-1]);
  end;
end;

{******************************************************************************}
procedure TFConsultaParcelasCRFluxoCaixa.MOcultarNoFluxoClick(Sender: TObject);
begin
  if (TObject(Grade.ADados.Items[Grade.ALinha -1]) is TRBDParcelaBaixaCR) then
  begin
    FunContasAReceber.SetaOcultarrnoFluxo(VprDParcelaBaixaCR.CodFilial,VprDParcelaBaixaCR.LanReceber,VprDParcelaBaixaCR.NumParcela);
  end;
end;

{ **************************************************************************** }
procedure TFConsultaParcelasCRFluxoCaixa.AlterarCliente1Click(Sender: TObject);
begin
  FNovoCliente := TFNovoCliente.CriarSDI(application,'', FPrincipal.VerificaPermisao('FNovoCliente'));
  AdicionaSQlAbreTabela(FNovoCliente.CadClientes,'Select * from CadClientes '+
                                                 ' Where I_COD_CLI = '+IntToStr(VprDParcelaBaixaCR.CodCliente));
  FNovoCliente.CadClientes.Edit;
  FNovoCliente.ShowModal;
  FNovoCliente.Free;
end;

{ **************************************************************************** }
procedure TFConsultaParcelasCRFluxoCaixa.BFecharClick(Sender: TObject);
begin
  close;
end;

{ **************************************************************************** }
procedure TFConsultaParcelasCRFluxoCaixa.CarParcelaContasaPagar(VpaLinha: Integer);
begin

  VprDParcelaCP:= TRBDParcelaCP(Grade.ADados.Items[VpaLinha-1]);
  Grade.Cells[1,VpaLinha]:= VprDParcelaCP.NomCliente;
  if VprDParcelaCP.NumNotaFiscal <> 0 then
    Grade.Cells[2,VpaLinha]:= IntToStr(VprDParcelaCP.NumNotaFiscal)
  else
    Grade.Cells[2,VpaLinha]:= '';
  Grade.Cells[3,VpaLinha]:= VprDParcelaCP.NumDuplicata;
  Grade.Cells[4,VpaLinha]:= IntToStr(VprDParcelaCP.NumParcela);
  Grade.Cells[5,VpaLinha]:= '';
  if VprDParcelaCP.DatVencimento > MontaData(1,1,1900) then
    Grade.Cells[6,VpaLinha]:= FormatDateTime('DD/MM/YYYY',VprDParcelaCP.DatVencimento)
  else
    Grade.Cells[6,VpaLinha]:= '';
  if VprDParcelaCP.DatEmissao > MontaData(1,1,1900) then
    Grade.Cells[7,VpaLinha]:= FormatDateTime('DD/MM/YYYY',VprDParcelaCP.DatEmissao)
  else
    Grade.Cells[7,VpaLinha]:= '';
  Grade.Cells[8,VpaLinha]:= IntToStr(VprDParcelaCP.NumDiasAtraso);
  Grade.Cells[9,VpaLinha]:= FormatFloat('#,###,###,##0.00',VprDParcelaCP.ValParcela);
  Grade.Cells[10,VpaLinha]:= FormatFloat('#,###,###,##0.00',VprDParcelaCP.ValAcrescimo);
  Grade.Cells[11,VpaLinha]:= FormatFloat('#,###,###,##0.00',VprDParcelaCP.ValDesconto);
  Grade.Cells[12,VpaLinha]:= VprDParcelaCP.NomFormaPagamento;
end;

{******************************************************************************}
procedure TFConsultaParcelasCRFluxoCaixa.CarParcelaContasaReceber(VpaLinha: Integer);
begin
  VprDParcelaBaixaCR:= TRBDParcelaBaixaCR(Grade.ADados.Items[VpaLinha-1]);
  Grade.Cells[1,VpaLinha]:= VprDParcelaBaixaCR.NomCliente;
  if VprDParcelaBaixaCR.NumNotaFiscal <> 0 then
    Grade.Cells[2,VpaLinha]:= IntToStr(VprDParcelaBaixaCR.NumNotaFiscal)
  else
    Grade.Cells[2,VpaLinha]:= '';
  Grade.Cells[3,VpaLinha]:= VprDParcelaBaixaCR.NumDuplicata;
  Grade.Cells[4,VpaLinha]:= IntToStr(VprDParcelaBaixaCR.NumParcela);
  if VprDParcelaBaixaCR.DatPromessaPagamento > MontaData(1,1,1900) then
    Grade.Cells[5,VpaLinha]:= FormatDateTime('DD/MM/YYYY',VprDParcelaBaixaCR.DatPromessaPagamento)
  else
    Grade.Cells[5,VpaLinha]:= '';
  if VprDParcelaBaixaCR.DatEmissao > MontaData(1,1,1900) then
    Grade.Cells[6,VpaLinha]:= FormatDateTime('DD/MM/YYYY',VprDParcelaBaixaCR.DatEmissao)
  else
    Grade.Cells[6,VpaLinha]:= '';
  if VprDParcelaBaixaCR.DatVencimento > MontaData(1,1,1900) then
    Grade.Cells[7,VpaLinha]:= FormatDateTime('DD/MM/YYYY',VprDParcelaBaixaCR.DatVencimento)
  else
    Grade.Cells[7,VpaLinha]:= '';
  Grade.Cells[8,VpaLinha]:= IntToStr(VprDParcelaBaixaCR.NumDiasAtraso);
  Grade.Cells[9,VpaLinha]:= FormatFloat('#,###,###,##0.00',VprDParcelaBaixaCR.ValParcela);
  Grade.Cells[10,VpaLinha]:= FormatFloat('#,###,###,##0.00',VprDParcelaBaixaCR.ValAcrescimo);
  Grade.Cells[11,VpaLinha]:= FormatFloat('#,###,###,##0.00',VprDParcelaBaixaCR.ValDesconto);
  Grade.Cells[12,VpaLinha]:= VprDParcelaBaixaCR.NomFormaPagamento;
end;

{******************************************************************************}
procedure TFConsultaParcelasCRFluxoCaixa.CarTitulosGrade;
begin
  Grade.Cells[1,0]:= 'Cliente';
  Grade.Cells[2,0]:= 'N.F.';
  Grade.Cells[3,0]:= 'Dupl.';
  Grade.Cells[4,0]:= 'Parcela';
  Grade.Cells[5,0]:= 'Promessa Pgto';
  Grade.Cells[6,0]:= 'Emissão';
  Grade.Cells[7,0]:= 'Vencimento';
  Grade.Cells[8,0]:= 'Atraso';
  Grade.Cells[9,0]:= 'Valor Parcela';
  Grade.Cells[10,0]:= 'Acréscimo';
  Grade.Cells[11,0]:= 'Desconto';
  Grade.Cells[12,0]:= 'Forma Pagamento';
end;

{ **************************************************************************** }
procedure TFConsultaParcelasCRFluxoCaixa.ConsultaParcelasFluxo(VpaParcelas: Tlist);
begin
  Grade.ADados := VpaParcelas;
  Grade.CarregaGrade;
  ShowModal;
end;

{ **************************************************************************** }
procedure TFConsultaParcelasCRFluxoCaixa.ConsultaParcelasFluxo(VpaDia: TRBDFluxoCaixaDia);
begin
  VprDiaFluxo := VpaDia;
  Grade.ADados := VprDiaFluxo.ParcelasCR;
  Grade.CarregaGrade;
  ShowModal;
end;

{ **************************************************************************** }
procedure TFConsultaParcelasCRFluxoCaixa.FormClose(Sender: TObject; var Action: TCloseAction);
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
 RegisterClasses([TFConsultaParcelasCRFluxoCaixa]);
end.
