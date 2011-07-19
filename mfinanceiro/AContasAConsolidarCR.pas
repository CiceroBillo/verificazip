unit AContasAConsolidarCR;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Grids, CGrades, DBGrids, Tabela, DBKeyViolation, StdCtrls, Buttons,
  Componentes1, ExtCtrls, PainelGradiente, UnDados, ComCtrls, Localizacao,
  Db, DBTables, Mask, numericos, UnContasAReceber, DBClient;

type
  TFContasAConsolidarCR = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BOk: TBitBtn;
    GParcelas: TGridIndice;
    GContas: TRBStringGridColor;
    BAdicionar: TBitBtn;
    BRemover: TBitBtn;
    Label18: TLabel;
    ECliente: TEditLocaliza;
    SpeedButton4: TSpeedButton;
    Label20: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    EDatInicial: TCalendario;
    EDatFinal: TCalendario;
    MovCR: TSQL;
    DataMovCR: TDataSource;
    MovCRI_LAN_REC: TFMTBCDField;
    MovCRI_COD_CLI: TFMTBCDField;
    MovCRI_NRO_NOT: TFMTBCDField;
    MovCRD_DAT_EMI: TSQLTimeStampField;
    MovCRI_NRO_PAR: TFMTBCDField;
    MovCRD_DAT_VEN: TSQLTimeStampField;
    MovCRN_VLR_PAR: TFMTBCDField;
    MovCRC_NOM_CLI: TWideStringField;
    ENumNota: Tnumerico;
    Label1: TLabel;
    MovCRI_EMP_FIL: TFMTBCDField;
    MovCRI_COD_PAG: TFMTBCDField;
    MovCRC_CLA_PLA: TWideStringField;
    MovCRI_COD_FRM: TFMTBCDField;
    MovCRI_COD_MOE: TFMTBCDField;
    ConsultaPadrao1: TConsultaPadrao;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EClienteFimConsulta(Sender: TObject);
    procedure ENumNotaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GContasCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure BAdicionarClick(Sender: TObject);
    procedure BRemoverClick(Sender: TObject);
    procedure BOkClick(Sender: TObject);
  private
    { Private declarations }
    VprDContas : TRBDContasConsolidadasCR;
    VprDItemConta : TRBDItemContasConsolidadasCR;
    VprOrdem : String;
    procedure CarTitulosGrade;
    procedure AtualizaConsulta;
  public
    { Public declarations }
    procedure AdicionarContas(VpaDContas : TRBDContasConsolidadasCR);
  end;

var
  FContasAConsolidarCR: TFContasAConsolidarCR;

implementation

uses APrincipal, FunData, FunSql,Constantes, ConstMsg;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFContasAConsolidarCR.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EDatInicial.DateTime := PrimeiroDiaMes(Date);
  EDatFinal.DateTime := UltimoDiaMes(Date);
  VprOrdem := 'Order by MCR.D_DAT_VEN';
  CarTitulosGrade;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFContasAConsolidarCR.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFContasAConsolidarCR.CarTitulosGrade;
begin
  GContas.Cells[1,0] := 'Nro Nota';
  GContas.Cells[2,0] := 'Nro Parcela';
  GContas.Cells[3,0] := 'Data Emissão';
  GContas.Cells[4,0] := 'Cliente';
  GContas.Cells[5,0] := 'Vencimento';
  GContas.Cells[6,0] := 'Valor';
end;

{******************************************************************************}
procedure TFContasAConsolidarCR.AtualizaConsulta;
begin
  MovCR.Close;
  MovCR.Sql.Clear;
  MovCR.Sql.Add('Select CR.I_EMP_FIL, CR.I_LAN_REC, CR.I_COD_CLI, CR.I_NRO_NOT, CR.D_DAT_EMI,'+
                           'CR.I_COD_PAG, CR.C_CLA_PLA, MCR.I_NRO_PAR, ' +
                           ' MCR.D_DAT_VEN, (MCR.N_VLR_PAR * MOE.N_VLR_DIA) as N_VLR_PAR, ' +
                           ' MCR.I_COD_FRM, MCR.I_COD_MOE, '+
                           ' C.C_NOM_CLI');
  MovCR.Sql.Add('from  MovContasaReceber MCR, ' +
                ' CadContasaReceber CR, ' +
                ' CadClientes C, '+
                ' CadMoedas MOE '+
                           ' where (CR.I_EMP_FIL = MCR.I_EMP_FIL ' +
                           ' and CR.I_LAN_REC = MCR.I_LAN_REC ' +
                           ' and CR.I_COD_CLI = C.I_COD_CLI ' +
                           ' and MCR.I_COD_MOE = MOE.I_COD_MOE )' +
                           ' and CR.I_EMP_FIL = '+IntToStr(varia.CodigoEmpFil));
   // filtro cliente
  if ECliente.Text <> '' then
    MovCR.Sql.Add(' and CR.I_COD_CLI = ' + ECliente.Text );
  if ENumNota.AValor = 0 then
    MovCR.Sql.Add(SQLTextoDataEntreAAAAMMDD('MCR.D_DAT_VEN',
                   EDatInicial.Date,EDatFinal.Date, true));
  if ENumNota.AValor <> 0 then
    MovCR.Sql.Add(' and CR.I_NRO_NOT = '+ENumNota.Text);

  MovCR.Sql.Add(VprOrdem);
  GParcelas.ALinhaSQLOrderBy := MovCR.Sql.count - 1;
  MovCR.open;
end;

{******************************************************************************}
procedure TFContasAConsolidarCR.AdicionarContas(VpaDContas : TRBDContasConsolidadasCR);
begin
  VprDContas := VpaDContas;
  GContas.ADados := VprDContas.ItemsContas;
  GContas.CarregaGrade;
  AtualizaConsulta;
  Showmodal;
end;

{******************************************************************************}
procedure TFContasAConsolidarCR.EClienteFimConsulta(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFContasAConsolidarCR.ENumNotaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key  of
    13 : AtualizaConsulta;
  end;
end;

{******************************************************************************}
procedure TFContasAConsolidarCR.GContasCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDItemConta := TRBDItemContasConsolidadasCR(VprDContas.ItemsContas.Items[Vpalinha-1]);
  GContas.cells[1,VpaLinha] := IntToStr(VprDItemConta.NroNota);
  GContas.Cells[2,VpaLinha] := Inttostr(VprDItemConta.NroParcela);
  GContas.Cells[3,VpaLinha] := FormatDateTime('DD/MM/YYYY',VprDItemConta.DatEmissao);
  GContas.Cells[4,VpaLinha] := VprDItemConta.Cliente;
  GContas.Cells[5,VpaLinha] := FormatDateTime('DD/MM/YYYY',VprDItemConta.DatVencimento);
  GContas.Cells[6,VpaLinha] := FormatFloat('R$ ###,###,###,##0.00',VprDItemConta.ValParcela);
end;

{******************************************************************************}
procedure TFContasAConsolidarCR.BAdicionarClick(Sender: TObject);
begin
  if not FunContasAReceber.JaExisteParcela(VprDContas,MovCRI_EMP_FIL.AsInteger,MovCRI_LAN_REC.AsInteger,MovCRI_NRO_PAR.AsInteger) and
     not FunContasAReceber.ContaJaConsolidada(MovCRI_EMP_FIL.AsInteger,MovCRI_LAN_REC.AsInteger,MovCRI_NRO_PAR.AsInteger) then
  begin
    if not MovCR.eof then
    begin
      VprDItemConta := VprDContas.AddItemConta;
      VprDItemConta.LanReceber := MovCRI_LAN_REC.AsInteger;
      VprDItemConta.NroParcela := MovCRI_NRO_PAR.AsInteger;
      VprDItemConta.NroNota := MovCRI_NRO_NOT.AsInteger;
      VprDItemConta.DatEmissao := MovCRD_DAT_EMI.AsDateTime;
      VprDItemConta.DatVencimento := MovCRD_DAT_VEN.AsDateTime;
      VprDItemConta.Cliente := MovCRI_COD_CLI.AsString +'-'+MovCRC_NOM_CLI.AsString;
      VprDItemConta.ValParcela := MovCRN_VLR_PAR.AsFloat;
      VprDItemConta.CodCondicaoPagamento := MovCRI_COD_PAG.AsInteger;
      VprDItemConta.CodPlanoContas := MovCRC_CLA_PLA.AsString;
      VprDItemConta.CodFormaPagamento :=  MovCRI_COD_FRM.AsInteger;
      VprDItemConta.CodMoeda := MovCRI_COD_MOE.AsInteger;
      GContas.CarregaGrade;
    end;
  end
  else
    aviso('CONTA DUPLICADA!!!'#13'Esta conta já foi consolidada...');
end;

procedure TFContasAConsolidarCR.BRemoverClick(Sender: TObject);
begin
  GContas.ExcluiItemDados(false);
end;

{******************************************************************************}
procedure TFContasAConsolidarCR.BOkClick(Sender: TObject);
begin
  VprDContas.ValConsolidacao := FunContasAReceber.RValTotalContas(VprDContas);
  VprDContas.DatVencimento := FunContasAReceber.RMaiorVencimentoContas(VprDContas);
  close;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFContasAConsolidarCR]);
end.
