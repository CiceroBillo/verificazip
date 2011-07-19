unit AMostraParPagarOO;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, DBGrids, Tabela, StdCtrls,
  Grids, CGrades, UnDados, Buttons, Constantes, Mask, numericos, UnContasAReceber,
  DBCtrls, Localizacao, DBKeyViolation, UnDadosCR;

Const
  CT_DATAVENCIMENTOINVALIDA = 'DATA VENCIMENTO INVÁLIDA!!!'#13'A data de vencimento digitada não é uma data válida.';
  CT_DATVENCIMENTOCHEQUEINVALIDO = 'DATA VENCIMENTO CHEQUE INVÁLIDA!!!'#13'A data de vencimento do cheque tem que ser preenchida.';
  CT_VALORINVALIDO = 'VALOR INVÁLIDO!!!'#13'O valor digitado não é um valor válido.';
  CT_NUMCHEQUEINVALIDO = 'NUMERO DO CHEQUE VAZIO!!!'#13'É necessário preencher o número do cheque.';
  CT_VALCHEQUEINVALIDO = 'VALOR DO CHEQUE VAZIO!!!'#13'É necessário preencher o valor do cheque.';
  CT_CONTAINVALIDA = 'CONTA DO BOLETO BANCARIO VAZIA!!!'#13'É necessário preencher o valor da conta do boleto bancário.';
  CT_CONTACHEQUEINVALIDA = 'CONTA BANCÁRIA DO CHEQUE VAZIA!!!'#13'É necessário preencher a conta bancária do cheque.';
  CT_BANCOINVALIDO = 'BANCO VAZIO!!!'#13'É necessário preencher o numero do banco.';

type
  TFMostraParPagarOO = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    GParcelas: TRBStringGridColor;
    BOk: TBitBtn;
    BCancelar: TBitBtn;
    EValTotal: Tnumerico;
    Label6: TLabel;
    Localiza: TConsultaPadrao;
    EFormaPagamento: TComboBoxColor;
    Label20: TLabel;
    ValidaGravacao1: TValidaGravacao;
    LConta: TLabel;
    SpeedButton1: TSpeedButton;
    Label3: TLabel;
    EConta: TEditLocaliza;
    EObservacoes: TMemoColor;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BOkClick(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure GParcelasCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure GParcelasDadosValidos(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GParcelasMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GParcelasGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GParcelasKeyPress(Sender: TObject; var Key: Char);
    procedure EFormaPagamentoChange(Sender: TObject);
    procedure GParcelasDadosValidosForaGrade(Sender: TObject;
      var VpaValidos: Boolean);
    procedure EDatChequeChange(Sender: TObject);
    procedure EContaCadastrar(Sender: TObject);
    procedure EBancoCadastrar(Sender: TObject);
    procedure EContaSelect(Sender: TObject);
    procedure GParcelasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    VprAcao,
    VprCarregandoTela,
    VprPermiteAlterarValor : Boolean;
    VprValorTotalInicial : Double;
    VprDContasAPagar : TRBDContasaPagar;
    VprDParcela : TRBDParcelaCP;
    VprFormasPagamento : TList;
    procedure CarTitulosGrade;
    procedure CarDParcela;
    function VerificaValores : Boolean;
    procedure CarFormasPagamento;
    procedure CarDFormaPagamentoTela;
    procedure CarDFormaPagamento;
    procedure CopiaFormasPagamento;
    procedure InterpretaCodBarras;
  public
    { Public declarations }
    function MostraParcelas(VpaDContasaPagar : TRBDContasaPagar):Boolean;
    function AlteraFormaPagamento(VpaDContasaPagar : TRBDContasaPagar):Boolean;
  end;

var
  FMostraParPagarOO: TFMostraParPagarOO;

implementation

uses APrincipal,ConstMsg, FunString, FunObjeto, FunData, AContas, ABancos, FunNumeros, UnContasaPagar;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFMostraParPagarOO.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprCarregandoTela := false;
  CarTitulosGrade;
  VprFormasPagamento := TList.Create;
  FunContasAReceber.CarFormasPagamento(VprFormasPagamento);
  CarFormasPagamento;
  VprPermiteAlterarValor := true;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFMostraParPagarOO.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FreeTObjectsList(VprFormasPagamento);
  VprFormasPagamento.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
procedure TFMostraParPagarOO.CarTitulosGrade;
begin
  GParcelas.Cells[1,0] := 'Nro Parcela';
  GParcelas.Cells[2,0] := 'Nro Duplicata';
  GParcelas.Cells[3,0] := 'Vencimento';
  GParcelas.Cells[4,0] := 'Valor';
  GParcelas.Cells[5,0] := 'Multa';
  GParcelas.Cells[6,0] := 'Mora';
  GParcelas.Cells[7,0] := 'Juros';
  GParcelas.Cells[8,0] := 'Código Barras';
end;


{******************************************************************************}
procedure TFMostraParPagarOO.CarDParcela;
begin
  VprDParcela.NumDuplicata := GParcelas.Cells[2,GParcelas.ALinha];
  VprDParcela.DatVencimento := StrToDate(GParcelas.Cells[3,GParcelas.ALinha]);
  if VprPermiteAlterarValor then
    VprDParcela.ValParcela := StrToFloat(DeletaChars(GParcelas.cells[4,GParcelas.Alinha],'.'));
  VprDParcela.PerMulta := StrToFloat(DeletaChars(DeletaChars(GParcelas.cells[5,GParcelas.Alinha],'.'),'%'));
  VprDParcela.PerMora := StrToFloat(DeletaChars(DeletaChars(GParcelas.cells[6,GParcelas.Alinha],'.'),'%'));
  VprDParcela.PerJuros := StrToFloat(DeletaChars(DeletaChars(GParcelas.cells[7,GParcelas.Alinha],'.'),'%'));
  VprDParcela.CodBarras := GParcelas.cells[8,GParcelas.Alinha];
  CarDFormaPagamento;
end;

{******************************************************************************}
function TFMostraParPagarOO.VerificaValores : Boolean;
var
  VpfLaco : Integer;
begin
  result := false;
  if ArredondaDecimais(VprValorTotalInicial,2) <> ArredondaDecimais(VprDContasAPagar.ValTotal,2) then
  begin
    if not Confirmacao(CT_ValorDiferente + ' Nota = ' + FormatFloat(varia.MascaraMoeda,VprValorTotalInicial) +
                           ' -> parcelas = ' + FormatFloat(varia.MascaraMoeda,VprDContasAPagar.ValTotal) + '. Você deseja corrigir ?' ) then
    begin
      result := true;
    end;
  end
  else
    result := true;
  for Vpflaco := 0 to GParcelas.ADados.Count - 1 do
  begin
    GParcelas.row := VpfLaco +1;
  end;
end;

{******************************************************************************}
procedure TFMostraParPagarOO.CarFormasPagamento;
var
  VpfLaco : Integer;
begin
  EFormaPagamento.Items.Clear;
  for VpfLaco := 0 to VprFormasPagamento.Count - 1 do
  begin
    EFormaPagamento.Items.Add(TRBDFormaPagamento(VprFormasPagamento.Items[VpfLaco]).NomForma);
  end;
end;

{******************************************************************************}
procedure TFMostraParPagarOO.CarDFormaPagamentoTela;
var
  VpfLaco : Integer;
begin
  EObservacoes.Lines.text := VprDParcela.DesObservacoes;
  EFormaPagamento.ItemIndex := -1;
  for Vpflaco := 0 to VprFormasPagamento.Count - 1 do
  begin
    if TRBDFormaPagamento(VprFormasPagamento.Items[VpfLaco]).CodForma = VprDParcela.CodFormaPagamento then
    begin
      EFormaPagamento.ItemIndex := VpfLaco;
      EFormaPagamentoChange(EFormaPagamento);
      break;
    end;
  end;
  EConta.Clear;
  if EConta.Enabled then
  begin
    EConta.Text := VprDParcela.NumContaCorrente;
  end;
  EConta.Atualiza;
end;

{******************************************************************************}
procedure TFMostraParPagarOO.CarDFormaPagamento;
var
  VpfAlterouForma : Boolean;
begin
  VprDParcela.DesObservacoes := EObservacoes.Lines.text;
  VpfAlterouForma := False;
  if EFormaPagamento.ItemIndex > -1 then
  begin
    if VprDParcela.CodFormaPagamento <> TRBDFormaPagamento(VprFormasPagamento.Items[EFormaPagamento.ItemIndex]).CodForma then
      VpfAlterouForma := true;
    VprDParcela.CodFormaPagamento := TRBDFormaPagamento(VprFormasPagamento.Items[EFormaPagamento.ItemIndex]).CodForma;
  end
  else
    VprDParcela.CodFormaPagamento := 0;
  if (EConta.Visible) then
    VprDParcela.NumContaCorrente := EConta.text;
  if VpfAlterouForma and (GParcelas.ALinha = 1) then
    CopiaFormasPagamento;
end;

{******************************************************************************}
procedure TFMostraParPagarOO.CopiaFormasPagamento;
var
  VpfLaco : integer;
  VpfDParcelaOriginal, VpfDParcelaCorrente : TRBDMovContasCR;
begin
  VpfDParcelaOriginal := TRBDMovContasCR(VprDContasAPagar.Parcelas.Items[0]);
  for VpfLaco := 1 to VprDContasAPagar.Parcelas.Count -1 do
  begin
    VpfDParcelaCorrente := TRBDMovContasCR(VprDContasAPagar.Parcelas.Items[VpfLaco]);
    VpfDParcelaCorrente.CodFormaPagamento := VpfDParcelaOriginal.CodFormaPagamento;
    VpfDParcelaCorrente.IndBaixarConta := VpfDParcelaOriginal.IndBaixarConta;
    VpfDParcelaCorrente.NroContaBoleto := VpfDParcelaOriginal.NroContaBoleto;
    VpfDParcelaCorrente.NroAgencia := VpfDParcelaOriginal.NroAgencia;
    VpfDParcelaCorrente.CodBanco := VpfDParcelaOriginal.CodBanco;
  end;
end;

{******************************************************************************}
procedure TFMostraParPagarOO.InterpretaCodBarras;
begin
  FunContasAPagar.InterpretaCodigoBarras(VprDContasAPagar,VprDParcela.CodBarras);
  VprDParcela.DatVencimento := IncDia(MontaData(7,10,1997),VprDContasaPagar.FatorVencimento);
  GParcelas.Cells[3,GParcelas.ALinha] := FormatDateTime('DD/MM/YYYY',VprDParcela.DatVencimento);
  GParcelas.Cells[4,GParcelas.ALinha] := FormatFloat('###,###,###,##0.00',VprDContasAPagar.ValBoleto);
end;

{******************************************************************************}
function TFMostraParPagarOO.MostraParcelas(VpaDContasaPagar : TRBDContasaPagar) : boolean;
begin
  VprDContasAPagar := VpaDContasAPagar;
  GParcelas.ADados := VprDContasAPagar.Parcelas;
  VprDParcela := TRBDParcelaCP(VprDContasAPagar.Parcelas.Items[0]);
  GParcelas.CarregaGrade;
  VprCarregandoTela := true;
  GParcelas.row := 1;
  GParcelas.ALinha := 1;
  VprCarregandoTela := false;
  EValTotal.AValor := FunContasAPagar.SomaTotalParcelas(VprDContasAPagar);
  VprValorTotalInicial := VprDContasAPagar.ValTotal;
  EValTotal.AValor := VprDContasAPagar.ValTotal;
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
function TFMostraParPagarOO.AlteraFormaPagamento(VpaDContasaPagar : TRBDContasaPagar):Boolean;
begin
  VprPermiteAlterarValor := varia.GrupoUsuario = Varia.GrupoUsuarioMaster;
  result := MostraParcelas(VpaDContasAPagar);
end;

{******************************************************************************}
procedure TFMostraParPagarOO.BOkClick(Sender: TObject);
begin
  if GParcelas.DadosForaGradeValidos then
    if VerificaValores then
    begin
      VprAcao := true;
      close;
    end;
end;

{******************************************************************************}
procedure TFMostraParPagarOO.BCancelarClick(Sender: TObject);
begin
  VprAcao := false;
  close;
end;

procedure TFMostraParPagarOO.BitBtn1Click(Sender: TObject);
var
  VpfLaco : Integer;
  VpfDParcela : TRBDParcelaCP;
begin
  CarDFormaPagamento;
  VpfDParcela := TRBDParcelaCP(VprDContasAPagar.Parcelas.Items[0]);
  for VpfLaco := 1 to VprDContasAPagar.Parcelas.Count - 1 do
    TRBDParcelaCP(VprDContasAPagar.Parcelas.Items[Vpflaco]).DesObservacoes := VpfDParcela.DesObservacoes;
end;

{******************************************************************************}
procedure TFMostraParPagarOO.GParcelasCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDParcela := TRBDParcelaCP(VprDContasAPagar.Parcelas.Items[VpaLinha-1]);
  GParcelas.Cells[1,VpaLinha] := IntToStr(VpaLinha);
  GParcelas.Cells[2,VpaLinha] := VprDParcela.NumDuplicata;
  GParcelas.Cells[3,VpaLinha] := FormatDateTime('DD/MM/YYYY',VprDParcela.DatVencimento);
  GParcelas.Cells[4,VpaLinha] := FormatFloat('###,###,###,##0.00',VprDParcela.ValParcela);
  GParcelas.Cells[5,VpaLinha] := FormatFloat('###,###,###,##0.00%',VprDParcela.PerMulta);
  GParcelas.Cells[6,VpaLinha] := FormatFloat('###,###,###,##0.00%',VprDParcela.PerMora);
  GParcelas.Cells[7,VpaLinha] := FormatFloat('###,###,###,##0.00%',VprDParcela.PerJuros);
  GParcelas.Cells[8,VpaLinha] := VprDParcela.CodBarras;
  CarDFormaPagamentoTela;
end;

{******************************************************************************}
procedure TFMostraParPagarOO.GParcelasDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := true;
{  if GParcelas.Cells[2,GParcelas.ALinha] = '' then
  begin
    aviso('NUMERO DUPLICATA INVÁLIDO!!!'#13'É necessário digitar um número para a duplicata.');
    VpaValidos := false;
  end
  else}
    if DeletaChars(DeletaChars(GParcelas.Cells[3,GParcelas.ALinha],'/'),' ') = '' then
    begin
      aviso('DATA DE VENCIMENTO INVÁLIDA!!!'#13'É necessário digitar uma data de vencimento.');
      VpaValidos := false;
    end
    else
      if DeletaChars(DeletaChars(GParcelas.Cells[4,GParcelas.ALinha],','),' ') = '' then
      begin
        aviso('VALOR INVÁLIDO!!!'#13'É necessário digitar o valor da parcela.');
        VpaValidos := false;
      end
      else
      begin
        try
          StrToDate(GParcelas.Cells[3,GParcelas.ALinha]);
        except
          VpaValidos := false;
          aviso('DATA DE VENCIMENTO INVÁLIDA!!!'#13'Foi preenchida um valor inválido para a data de vencimento.');
        end;
      end;
  if VpaValidos then
  begin
    CarDParcela;
    EValTotal.AValor := FunContasAPagar.SomaTotalParcelas(VprDContasAPagar);
    if (VprValorTotalInicial <> VprDContasAPagar.ValTotal) and
       (GParcelas.ALinha < VprDContasAPagar.Parcelas.Count)  then
    begin
      FunContasAPagar.AjustaValorUltimaParcela(VprDContasAPagar,VprValorTotalInicial);
      GParcelasCarregaItemGrade(Gparcelas,VprDContasAPagar.Parcelas.Count);
      EValTotal.AValor := FunContasAPagar.SomaTotalParcelas(VprDContasAPagar);
    end;
  end;
end;

{******************************************************************************}
procedure TFMostraParPagarOO.GParcelasMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDContasAPagar.Parcelas.Count >0 then
  begin
    VprDParcela := TRBDParcelaCP(VprDContasAPagar.Parcelas.Items[VpaLinhaAtual-1]);
    CarDFormaPagamentoTela;
  end;
end;

{******************************************************************************}
procedure TFMostraParPagarOO.GParcelasGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    3 :  Value := '!99/00/0000;1;_';
  end;
end;

procedure TFMostraParPagarOO.GParcelasKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = '.' then
    key := ',';
  if (GParcelas.col = 4) and not(VprPermiteAlterarValor) then
    key := #0;
end;

{******************************************************************************}
procedure TFMostraParPagarOO.EFormaPagamentoChange(Sender: TObject);
begin
  ValidaGravacao1.execute;
end;

{******************************************************************************}
procedure TFMostraParPagarOO.GParcelasDadosValidosForaGrade(
  Sender: TObject; var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if VprCarregandoTela then
    exit;
  if VpaValidos then
    CarDFormaPagamento;
end;

{******************************************************************************}
procedure TFMostraParPagarOO.EDatChequeChange(Sender: TObject);
begin
  ValidaGravacao1.execute;
end;

{******************************************************************************}
procedure TFMostraParPagarOO.EContaCadastrar(Sender: TObject);
begin
  FContas := TFContas.CriarSDI(application, '', true);
  FContas.ShowModal;
  localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFMostraParPagarOO.EBancoCadastrar(Sender: TObject);
begin
  FBancos := TFBancos.CriarSDI(application, '', true);
  FBancos.ShowModal;
  localiza.AtualizaConsulta;
end;

procedure TFMostraParPagarOO.EContaSelect(Sender: TObject);
begin
  EConta.ASelectLocaliza.Text := 'Select BAN.C_NOM_BAN, CO.C_NRO_CON, CO.C_NRO_AGE, '+
                                 ' CO.C_NOM_CRR, BAN.I_COD_BAN '+
                                 ' from cadbancos  Ban, CadContas  Co '+
                                 ' where  Ban.I_COD_BAN = Co.I_COD_BAN '+
                                 ' and CO.I_EMP_FIL = '+IntToStr(Varia.CodigoEmpFil)+
                                 ' and Co.C_NRO_CON LIKE ''@%'''+
                                 ' and CO.C_IND_ATI = ''T''';
  EConta.ASelectValida.Text := 'Select BAN.C_NOM_BAN, CO.C_NRO_CON, CO.C_NRO_AGE, '+
                                 ' CO.C_NOM_CRR, BAN.I_COD_BAN '+
                                 ' from cadbancos  Ban, CadContas  Co '+
                                 ' where  Ban.I_COD_BAN = Co.I_COD_BAN '+
                                 ' and CO.I_EMP_FIL = '+IntToStr(Varia.CodigoEmpFil)+
                                 ' and Co.C_NRO_CON = ''@''';
end;

procedure TFMostraParPagarOO.GParcelasKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (key = 13) and (GParcelas.AColuna = 8) then
    InterpretaCodBarras; 
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFMostraParPagarOO]);
end.

