unit AMostraParReceberOO;

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
  TFMostraParReceberOO = class(TFormularioPermissao)
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
    Lbanco: TLabel;
    Label20: TLabel;
    SpeedButton2: TSpeedButton;
    Label4: TLabel;
    EBanco: TEditLocaliza;
    ValidaGravacao1: TValidaGravacao;
    LConta: TLabel;
    SpeedButton1: TSpeedButton;
    Label3: TLabel;
    EConta: TEditLocaliza;
    EAgencia: TEditColor;
    LAgencia: TLabel;
    EObservacoes: TMemoColor;
    Label1: TLabel;
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
    procedure EContaRetorno(Retorno1, Retorno2: String);
    procedure EBancoCadastrar(Sender: TObject);
    procedure EContaSelect(Sender: TObject);
    procedure GParcelasGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure GParcelasClick(Sender: TObject);
  private
    { Private declarations }
    VprAcao,
    VprCarregandoTela,
    VprPermiteAlterarValor : Boolean;
    VprValorTotalInicial : Double;
    VprDNovaCR : TRBDContasCR;
    VprDParcela : TRBDMovContasCR;
    VprFormasPagamento : TList;
    procedure CarTitulosGrade;
    procedure SomaTotalParcelasCR(VpaDNovaCR : TRBDContasCR);
    procedure CarDParcela;
    function VerificaValores : Boolean;
    procedure CarFormasPagamento;
    procedure CarDFormaPagamentoTela;
    procedure CarDFormaPagamento;
    procedure ConfiguraComponentes(VpaFlatipo :TRBDTipoFormaPagamento);
    procedure CopiaFormasPagamento;
  public
    { Public declarations }
    function MostraParcelas(VpaDNovaCR : TRBDContasCR):Boolean;
    function AlteraFormaPagamento(VpaDNovaCR : TRBDContasCR):Boolean;
  end;

var
  FMostraParReceberOO: TFMostraParReceberOO;

implementation

uses APrincipal,ConstMsg, FunString, FunObjeto, FunData, AContas, ABancos, FunNumeros;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFMostraParReceberOO.FormCreate(Sender: TObject);
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
procedure TFMostraParReceberOO.FormClose(Sender: TObject; var Action: TCloseAction);
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
procedure TFMostraParReceberOO.CarTitulosGrade;
begin
  GParcelas.Cells[1,0] := 'Nro Parcela';
  GParcelas.Cells[2,0] := 'Nro Duplicata';
  GParcelas.Cells[3,0] := 'Vencimento';
  GParcelas.Cells[4,0] := 'Valor';
  GParcelas.Cells[5,0] := 'Multa';
  GParcelas.Cells[6,0] := 'Mora';
  GParcelas.Cells[7,0] := 'Juros';
  GParcelas.Cells[8,0] := 'Desconto';
  GParcelas.Cells[9,0] := 'Desc.Venc.';
  GParcelas.Cells[10,0] := 'Observação Parcela';
end;

{******************************************************************************}
procedure TFMostraParReceberOO.SomaTotalParcelasCR(VpaDNovaCR : TRBDContasCR);
var
  VpfLaco : Integer;
begin
  VpaDNovaCR.ValTotal := 0;
  for VpfLaco := 0 to VpaDNovaCR.Parcelas.Count - 1 do
  begin
    VpaDNovaCR.ValTotal := VpaDNovaCR.ValTotal + TRBDMovContasCR(VpaDNovaCR.Parcelas.Items[VpfLaco]).Valor;
  end;
  EValTotal.AValor := VprDNovaCR.ValTotal;
end;


{******************************************************************************}
procedure TFMostraParReceberOO.CarDParcela;
begin
  if VprDParcela.ValSinal > 0 then
    exit;
  VprDParcela.NroDuplicata := GParcelas.Cells[2,GParcelas.ALinha];
  VprDParcela.DatVencimento := StrToDate(GParcelas.Cells[3,GParcelas.ALinha]);
  if VprPermiteAlterarValor then
    VprDParcela.Valor := StrToFloat(DeletaChars(GParcelas.cells[4,GParcelas.Alinha],'.'));
  VprDParcela.PerMulta := StrToFloat(DeletaChars(DeletaChars(GParcelas.cells[5,GParcelas.Alinha],'.'),'%'));
  VprDParcela.PerMora := StrToFloat(DeletaChars(DeletaChars(GParcelas.cells[6,GParcelas.Alinha],'.'),'%'));
  VprDParcela.PerJuros := StrToFloat(DeletaChars(DeletaChars(GParcelas.cells[7,GParcelas.Alinha],'.'),'%'));
  VprDParcela.PerDesconto := StrToFloat(DeletaChars(DeletaChars(GParcelas.cells[8,GParcelas.Alinha],'.'),'%')) * -1;
  VprDParcela.PerDescontoVencimento := StrToFloat(DeletaChars(DeletaChars(GParcelas.cells[9,GParcelas.Alinha],'.'),'%'));
  VprDParcela.DesObservacoes := GParcelas.Cells[10,GParcelas.ALinha];
//  VprDParcela.Valor := VprDParcela.ValorBruto + (VprDParcela.PerDesconto*VprDParcela.ValorBruto /100);
  CarDFormaPagamento;
end;

{******************************************************************************}
function TFMostraParReceberOO.VerificaValores : Boolean;
var
  VpfLaco : Integer;
begin
  result := false;
  if ArredondaDecimais(VprValorTotalInicial,2) <> ArredondaDecimais(VprDNovaCR.ValTotal,2) then
  begin
    if not Confirmacao(CT_ValorDiferente + ' Nota = ' + FormatFloat(varia.MascaraMoeda,VprValorTotalInicial) +
                           ' -> parcelas = ' + FormatFloat(varia.MascaraMoeda,VprDNovaCR.ValTotal) + '. Você deseja corrigir ?' ) then
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
procedure TFMostraParReceberOO.CarFormasPagamento;
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
procedure TFMostraParReceberOO.CarDFormaPagamentoTela;
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
  EAgencia.Clear;
  if EAgencia.Visible then
    EAgencia.Text := VprDParcela.NroAgencia;
  EConta.Clear;
  if EConta.Enabled then
  begin
    EConta.Text := VprDParcela.NroContaBoleto;
  end;
  EBanco.Clear;
  EConta.Atualiza;
  if EBanco.Enabled then
  begin
    if VprDParcela.CodBanco <> 0 then
    begin
      EBanco.AInteiro := VprDParcela.CodBanco;
    end;
    EBanco.Atualiza;
  end;
end;

{******************************************************************************}
procedure TFMostraParReceberOO.CarDFormaPagamento;
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
    VprDParcela.IndBaixarConta := TRBDFormaPagamento(VprFormasPagamento.Items[EFormaPagamento.ItemIndex]).IndBaixarConta;
  end
  else
    VprDParcela.CodFormaPagamento := 0;
  if (EConta.Visible) then
    VprDParcela.NroContaBoleto := EConta.text;
  if (EAgencia.visible) then
    VprDParcela.NroAgencia := EAgencia.Text;
  if (EBanco.Enabled) then
    VprDParcela.CodBanco := EBanco.AInteiro
  else
    VprDParcela.CodBanco := 0;
  VprDParcela.DiasCompensacao := FunContasAReceber.RDiasCompensacaoConta(VprDParcela.NroContaBoleto);
  VprDParcela.DatProrrogacao := incdia(VprDParcela.DatVencimento,VprDParcela.DiasCompensacao);
  if (VpfAlterouForma) and (GParcelas.ALinha = 1) Then
    CopiaFormasPagamento
  else
    if Gparcelas.ALinha = 1 then
      CopiaFormasPagamento;
end;


{******************************************************************************}
procedure TFMostraParReceberOO.ConfiguraComponentes(VpaFlatipo :TRBDTipoFormaPagamento);
begin
  EConta.clear;
  EAgencia.Clear;
  EBanco.Clear;
  AlteraCampoObrigatorioDet([EConta,EBanco,EAgencia],false);
  AlterarEnabledDet([EConta,EBanco,LConta,Lbanco,EAgencia,LAgencia],true);
  AlterarVisibleDet([SpeedButton1,Label3], true);
  EConta.Visible := true;
  case VpaFlatipo of
    fpCobrancaBancaria :
        begin // Lançamento Bancário.
          AlteraCampoObrigatorioDet([EConta,EBanco,EAgencia],true);
          EAgencia.Visible := true;
          if TRBDFormaPagamento(VprFormasPagamento.Items[EFormaPagamento.ItemIndex]).CodForma =  varia.FormaPagamentoBoleto then
            EConta.Text := Varia.ContaBancariaBoleto
          else
            EConta.Text := Varia.ContaBancaria;
          EConta.Atualiza;
{         13/05/2011 - colocado em comentario porque quando dava uma seta para baixao na alteraçao dos vencimento ficava focando o numero da conta.
          if (self.Visible) and not(GParcelas.Focused) then
            EConta.SetFocus;}
          end;
     fpChequeTerceiros : Begin // cheques de terceiros
            AlterarEnabledDet([EConta, LConta, Lbanco,LAgencia,EAgencia],false );
          end;
    else
      AlterarEnabledDet([EConta, EBanco, LConta, Lbanco, LAgencia,EAgencia],false );
  end;
end;

{******************************************************************************}
procedure TFMostraParReceberOO.CopiaFormasPagamento;
var
  VpfLaco : integer;
  VpfDParcelaOriginal, VpfDParcelaCorrente : TRBDMovContasCR;
begin
  VpfDParcelaOriginal := TRBDMovContasCR(VprDNovaCR.Parcelas.Items[0]);
  for VpfLaco := 1 to VprDNovaCR.Parcelas.Count -1 do
  begin
    VpfDParcelaCorrente := TRBDMovContasCR(VprDNovaCR.Parcelas.Items[VpfLaco]);
    VpfDParcelaCorrente.CodFormaPagamento := VpfDParcelaOriginal.CodFormaPagamento;
    VpfDParcelaCorrente.IndBaixarConta := VpfDParcelaOriginal.IndBaixarConta;
    VpfDParcelaCorrente.NroContaBoleto := VpfDParcelaOriginal.NroContaBoleto;
    VpfDParcelaCorrente.NroAgencia := VpfDParcelaOriginal.NroAgencia;
    VpfDParcelaCorrente.CodBanco := VpfDParcelaOriginal.CodBanco;
  end;
end;

{******************************************************************************}
function TFMostraParReceberOO.MostraParcelas(VpaDNovaCR : TRBDContasCR) : boolean;
begin
  VprDNovaCR := VpaDNovaCR;
  GParcelas.ADados := VpaDNovaCR.Parcelas;
  VprDParcela := TRBDMovContasCR(VprDNovaCR.Parcelas.Items[0]);
  GParcelas.CarregaGrade;
  VprCarregandoTela := true;
  GParcelas.row := 1;
  GParcelas.ALinha := 1;
  VprCarregandoTela := false;
  SomaTotalParcelasCR(VprDNovaCR);
  VprValorTotalInicial := VpaDNovaCR.ValTotal;
  EValTotal.AValor := VprDNovaCR.ValTotal;
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
function TFMostraParReceberOO.AlteraFormaPagamento(VpaDNovaCR : TRBDContasCR):Boolean;
begin
  VprPermiteAlterarValor := varia.GrupoUsuario = Varia.GrupoUsuarioMaster;
  result := MostraParcelas(VpaDNovaCR);
end;

{******************************************************************************}
procedure TFMostraParReceberOO.BOkClick(Sender: TObject);
begin
  if GParcelas.DadosForaGradeValidos then
    if VerificaValores then
    begin
      VprAcao := true;
      close;
    end;
end;

{******************************************************************************}
procedure TFMostraParReceberOO.BCancelarClick(Sender: TObject);
begin
  VprAcao := false;
  close;
end;

{******************************************************************************}
procedure TFMostraParReceberOO.GParcelasCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDParcela := TRBDMovContasCR(VprDNovaCR.Parcelas.Items[VpaLinha-1]);
  GParcelas.Cells[1,VpaLinha] := IntToStr(VpaLinha);
  GParcelas.Cells[2,VpaLinha] := VprDParcela.NroDuplicata;
  GParcelas.Cells[3,VpaLinha] := FormatDateTime('DD/MM/YYYY',VprDParcela.DatVencimento);
  GParcelas.Cells[4,VpaLinha] := FormatFloat('###,###,###,##0.00',VprDParcela.Valor);
  GParcelas.Cells[5,VpaLinha] := FormatFloat('###,###,###,##0.00%',VprDParcela.PerMulta);
  GParcelas.Cells[6,VpaLinha] := FormatFloat('###,###,###,##0.00%',VprDParcela.PerMora);
  GParcelas.Cells[7,VpaLinha] := FormatFloat('###,###,###,##0.00%',VprDParcela.PerJuros);
  GParcelas.Cells[8,VpaLinha] := FormatFloat('###,###,###,##0.00%',VprDParcela.PerDesconto * -1);
  GParcelas.Cells[9,VpaLinha] := FormatFloat('###,###,###,##0.00%',VprDParcela.PerDescontoVencimento);
  GParcelas.Cells[10,VpaLinha] := VprDParcela.DesObservacoes;
  CarDFormaPagamentoTela;
end;

procedure TFMostraParReceberOO.GParcelasClick(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFMostraParReceberOO.GParcelasDadosValidos(Sender: TObject;
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
    SomaTotalParcelasCR(VprDNovaCR);
  end;
end;

{******************************************************************************}
procedure TFMostraParReceberOO.GParcelasMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDNovaCR.Parcelas.Count >0 then
  begin
    VprDParcela := TRBDMovContasCR(VprDNovaCR.Parcelas.Items[VpaLinhaAtual-1]);
    CarDFormaPagamentoTela;
  end;
end;

{******************************************************************************}
procedure TFMostraParReceberOO.GParcelasGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
var
  VpfDItem : TRBDMovContasCR;
begin
  if (ARow > 0) and (Acol > 0) then
  begin
    if VprDNovaCR.Parcelas.Count >0 then
    begin
      VpfDItem := TRBDMovContasCR(VprDNovaCR.Parcelas.Items[Arow-1]);
      if VpfDItem.ValSinal > 0 then
      begin
        AFont.Color := $FFD700;
      end;
    end;
  end;
end;

procedure TFMostraParReceberOO.GParcelasGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    3 :  Value := '!99/00/0000;1;_'; 
  end;
end;

procedure TFMostraParReceberOO.GParcelasKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = '.' then
    key := ',';
  if (GParcelas.col = 4) and not(VprPermiteAlterarValor) then
    key := #0;
end;

{******************************************************************************}
procedure TFMostraParReceberOO.EFormaPagamentoChange(Sender: TObject);
begin
  ConfiguraComponentes(TRBDFormaPagamento(VprFormasPagamento.Items[EFormaPagamento.ItemIndex]).FlaTipo);
  ValidaGravacao1.execute;
end;

{******************************************************************************}
procedure TFMostraParReceberOO.GParcelasDadosValidosForaGrade(
  Sender: TObject; var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if VprCarregandoTela then
    exit;
  if (EConta.ACampoObrigatorio) and (EConta.Text = '') then
  begin
    aviso(CT_CONTAINVALIDA);
    VpaValidos := false;
  end
  else
    if (EBanco.ACampoObrigatorio) and (EBanco.Text = '') then
    begin
      Aviso(CT_BANCOINVALIDO);
      VpaValidos := false;
    end;
  if VpaValidos then
    CarDFormaPagamento;
end;

{******************************************************************************}
procedure TFMostraParReceberOO.EDatChequeChange(Sender: TObject);
begin
  ValidaGravacao1.execute;
end;

{******************************************************************************}
procedure TFMostraParReceberOO.EContaCadastrar(Sender: TObject);
begin
  FContas := TFContas.CriarSDI(application, '', true);
  FContas.ShowModal;
  localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFMostraParReceberOO.EContaRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
  begin
    EAgencia.Text := Retorno1;
    EBanco.text :=  retorno2;
    EBanco.Atualiza;
  end;
end;

{******************************************************************************}
procedure TFMostraParReceberOO.EBancoCadastrar(Sender: TObject);
begin
  FBancos := TFBancos.CriarSDI(application, '', true);
  FBancos.ShowModal;
  localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFMostraParReceberOO.EContaSelect(Sender: TObject);
begin
  EConta.ASelectLocaliza.Text := 'Select BAN.C_NOM_BAN, CO.C_NRO_CON, CO.C_NRO_AGE, '+
                                 ' CO.C_NOM_CRR, BAN.I_COD_BAN '+
                                 ' from cadbancos  Ban, CadContas  Co '+
                                 ' where  Ban.I_COD_BAN = Co.I_COD_BAN '+
                                 ' and Co.C_NRO_CON LIKE ''@%'''+
                                 ' and CO.C_IND_ATI = ''T''';
  EConta.ASelectValida.Text := 'Select BAN.C_NOM_BAN, CO.C_NRO_CON, CO.C_NRO_AGE, '+
                                 ' CO.C_NOM_CRR, BAN.I_COD_BAN '+
                                 ' from cadbancos  Ban, CadContas  Co '+
                                 ' where  Ban.I_COD_BAN = Co.I_COD_BAN '+
                                 ' and Co.C_NRO_CON = ''@''';
  if config.FiltrarFilialNasContasdoBoleto then
  begin
    EConta.ASelectLocaliza.Text := EConta.ASelectLocaliza.Text +
                                 ' and CO.I_EMP_FIL = '+IntToStr(Varia.CodigoEmpFil);
    EConta.ASelectValida.Text := EConta.ASelectValida.Text +
                                 ' and CO.I_EMP_FIL = '+IntToStr(Varia.CodigoEmpFil);
  end;

end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFMostraParReceberOO]);
end.

