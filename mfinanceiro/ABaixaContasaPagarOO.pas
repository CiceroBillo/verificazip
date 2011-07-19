unit ABaixaContasaPagarOO;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Componentes1, Localizacao, Mask, numericos, ComCtrls,
  ExtCtrls, Grids, CGrades, PainelGradiente, UnDadosCR, UnContasaPagar, UnCaixa;

type
  TFBaixaContasaPagarOO = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    PanelColor3: TPanelColor;
    PanelColor1: TPanelColor;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    SpeedButton1: TSpeedButton;
    Label5: TLabel;
    Label6: TLabel;
    SpeedButton2: TSpeedButton;
    Label7: TLabel;
    Label8: TLabel;
    EDatPagamento: TCalendario;
    EValAcrescimo: Tnumerico;
    EValDesconto: Tnumerico;
    EValPago: Tnumerico;
    EContaCaixa: TEditLocaliza;
    EFormaPagamento: TEditLocaliza;
    EObservacoes: TMemoColor;
    BOk: TBitBtn;
    BCancelar: TBitBtn;
    Grade: TRBStringGridColor;
    Localiza: TConsultaPadrao;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GradeDadosValidosForaGrade(Sender: TObject;
      var VpaValidos: Boolean);
    procedure GradeGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure BOkClick(Sender: TObject);
    procedure EValAcrescimoExit(Sender: TObject);
    procedure EFormaPagamentoRetorno(Retorno1, Retorno2: String);
    procedure EFormaPagamentoCadastrar(Sender: TObject);
    procedure EValPagoExit(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure EObservacoesExit(Sender: TObject);
  private
    { Private declarations }
    VprAcao : boolean;
    VprDBaixaCP : TRBDBaixaCP;
    VprDParcelaBaixaCP : TRBDParcelaCP;
    procedure CarTitulosGrade;
    function DadosValidos: String;
    procedure CarDClasse;
    procedure InicializaTela;
    procedure AtualizaValorTotal;
    procedure AtualizaValoresTela;
    function GravarParcelas: String;
    function DigitaCheques : String;
  public
    { Public declarations }
    function BaixarContasAPagar(VpaDBaixaCP: TRBDBaixaCP): Boolean;
    procedure ConsultaParcelasBaixa(VpaParcelas : TList);
  end;

var
  FBaixaContasaPagarOO: TFBaixaContasaPagarOO;

implementation

uses APrincipal,Constantes, FunData, ConstMsg, AChequesCP, AFormasPagamento, AConsultacheques;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFBaixaContasaPagarOO.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao := false;
  CarTitulosGrade;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFBaixaContasaPagarOO.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFBaixaContasaPagarOO.CarTitulosGrade;
begin
  Grade.Cells[1,0]:= 'Fornecedor';
  Grade.Cells[2,0]:= 'N.F.';
  Grade.Cells[3,0]:= 'Dupl.';
  Grade.Cells[4,0]:= 'Parcela';
  Grade.Cells[5,0]:= 'Emissão';
  Grade.Cells[6,0]:= 'Vencimento';
  Grade.Cells[7,0]:= 'Atraso';
  Grade.Cells[8,0]:= 'Valor Parcela';
  Grade.Cells[9,0]:= 'Acréscimo';
  Grade.Cells[10,0]:= 'Desconto';
  Grade.Cells[11,0]:= 'Forma Pagamento';
end;

{******************************************************************************}
function TFBaixaContasaPagarOO.DadosValidos: String;
begin
  Result:= '';
  if EFormaPagamento.AInteiro = 0 then
  begin
    Result:= 'FORMA DE PAGAMENTO NÃO PREENCHIDA!!!'#13+
             'É necessário preencher a forma de pagamento.';
    ActiveControl:= EFormaPagamento;
  end
  else
    if EContaCaixa.Text = '' then
    begin
      Result:= 'CONTA CAIXA NÃO PREENCHIDA!!!'#13+
               'É necessário preencher a conta caixa.';
      ActiveControl:= EContaCaixa;
    end
    else
      if EValPago.AValor = 0 then
      begin
        Result:= 'VALOR PAGO NÃO PREENCHIDO!!!'#13+
                 'É necessário preencher o valor do pagamento';
        ActiveControl:= EValPago;
      end;
  if result = '' then
  begin
    Result := FunContasAPagar.VerificaSeValorPagoQuitaTodasDuplicatas(VprDBaixaCP,EValPago.AValor);
    if result = '' then
    begin
      if not FunCaixa.ContaCaixaAberta(EContaCaixa.Text) then
        result := 'CONTA CAIXA FECHADO!!!'#13'É necessário abrir a conta caixa.';
    end;
  end;
end;

{******************************************************************************}
procedure TFBaixaContasaPagarOO.CarDClasse;
begin
  VprDBaixaCP.DatPagamento:= EDatPagamento.DateTime;
  VprDBaixaCP.ValorAcrescimo:= EValAcrescimo.AValor;
  VprDBaixaCP.ValorDesconto:= EValDesconto.AValor;
  VprDBaixaCP.CodFormaPagamento:= EFormaPagamento.AInteiro;
  VprDBaixaCP.NumContaCaixa:= EContaCaixa.Text;
  VprDBaixaCP.ValorPago:= EValPago.AValor;
end;

{******************************************************************************}
procedure TFBaixaContasaPagarOO.InicializaTela;
var
  VpfDParcela : TRBDParcelaCP;
begin
  EDatPagamento.DateTime := date;

  EValAcrescimo.AValor:= 0;
  EValDesconto.AValor:= 0;
  EValPago.AValor:= 0;
  EFormaPagamento.AInteiro:= 0;
  EContaCaixa.Text:= '';
  EObservacoes.Text:= '';
  if VprDBaixaCP.Parcelas.Count > 0 then
  begin
    VpfDParcela := TRBDParcelaCP(VprDBaixaCP.Parcelas.Items[0]);
    EContaCaixa.Text := VpfDParcela.NumContaCorrente;
    EFormaPagamento.AInteiro := VpfDParcela.CodFormaPagamento;
  end;

  EFormaPagamento.Atualiza;
  EContaCaixa.Atualiza;
  AtualizaValorTotal;
end;

{******************************************************************************}
procedure TFBaixaContasaPagarOO.AtualizaValorTotal;
begin
  FunContasAPagar.CalculaValorTotalBaixa(VprDBaixaCP);
  AtualizaValoresTela;
end;

{******************************************************************************}
procedure TFBaixaContasaPagarOO.AtualizaValoresTela;
begin
  EValAcrescimo.AValor := VprDBaixaCP.ValorAcrescimo;
  EValDesconto.AValor := VprDBaixaCP.ValorDesconto;
  EValPago.AValor := VprDBaixaCP.ValorPago;
end;

{******************************************************************************}
function TFBaixaContasaPagarOO.GravarParcelas: String;
begin
  Result := DigitaCheques;
  if result = '' then
  begin
    result := FunContasAPagar.VerificaSeGeraParcial(VprDBaixaCP,EValPago.AValor, true);
    if result = '' then
      Result:= FunContasAPagar.BaixaContasAPagar(VprDBaixaCP);
  end;
end;

{******************************************************************************}
function TFBaixaContasaPagarOO.DigitaCheques : String;
begin
  result := '';
  if (VprDBaixaCP.TipFormaPagamento = 'C') or (VprDBaixaCP.TipFormaPagamento = 'R') or
     (VprDBaixaCP.TipFormaPagamento = 'A') then // cheque, cheque terceiros, carteira
  begin
    FChequesCP := TFChequesCP.CriarSDI(nil,'',true);
    if not FChequesCP.CadastraCheques(VprDBaixaCP) then
      result := 'DIGITAÇÃO DOS CHEQUES CANCELADA!!!'#13'Foi cancelado a digitação dos cheques';
    FChequesCP.free;

    if result = '' then
    begin
      if VprDBaixaCP.Cheques.Count > 0 then
      begin
        VprDBaixaCP.ValorPago := FunContasAPagar.RValTotalCheques(VprDBaixaCP);
        EValPago.AValor := VprDBaixaCP.ValorPago;
        if EValPago.AValor <>  FunContasAPagar.RValTotalParcelasBaixa(VprDBaixaCP) then
        begin
          result := FunContasAPagar.VerificaSeValorPagoQuitaTodasDuplicatas(VprDBaixaCP,EValPago.AValor);
          Grade.CarregaGrade;
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFBaixaContasaPagarOO.BaixarContasAPagar(VpaDBaixaCP: TRBDBaixaCP): Boolean;
begin
  VprDBaixaCP:= VpaDBaixaCP;
  InicializaTela;
  Grade.ADados:= VprDBaixaCP.Parcelas;
  Grade.CarregaGrade;
  ShowModal;
  Result:= VprAcao;
end;

{******************************************************************************}
procedure TFBaixaContasaPagarOO.ConsultaParcelasBaixa(VpaParcelas : TList);
begin
  VprDBaixaCP:= TRBDBaixaCP.Cria;
  VprDBaixaCP.Parcelas := VpaParcelas;
  Grade.ADados:= VprDBaixaCP.Parcelas;
  Grade.CarregaGrade;
  Show;
end;

{******************************************************************************}
procedure TFBaixaContasaPagarOO.GradeCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDParcelaBaixaCP:= TRBDParcelaCP(VprDBaixaCP.Parcelas.Items[VpaLinha-1]);

  Grade.Cells[1,VpaLinha]:= VprDParcelaBaixaCP.NomCliente;
  if VprDParcelaBaixaCP.NumNotaFiscal <> 0 then
    Grade.Cells[2,VpaLinha]:= IntToStr(VprDParcelaBaixaCP.NumNotaFiscal)
  else
    Grade.Cells[2,VpaLinha]:= '';
  Grade.Cells[3,VpaLinha]:= VprDParcelaBaixaCP.NumDuplicata;
  Grade.Cells[4,VpaLinha]:= IntToStr(VprDParcelaBaixaCP.NumParcela);
  if VprDParcelaBaixaCP.DatEmissao > MontaData(1,1,1900) then
    Grade.Cells[5,VpaLinha]:= FormatDateTime('DD/MM/YYYY',VprDParcelaBaixaCP.DatEmissao)
  else
    Grade.Cells[5,VpaLinha]:= '';
  if VprDParcelaBaixaCP.DatVencimento > MontaData(1,1,1900) then
    Grade.Cells[6,VpaLinha]:= FormatDateTime('DD/MM/YYYY',VprDParcelaBaixaCP.DatVencimento)
  else
    Grade.Cells[6,VpaLinha]:= '';
  Grade.Cells[7,VpaLinha]:= IntToStr(VprDParcelaBaixaCP.NumDiasAtraso);
  Grade.Cells[8,VpaLinha]:= FormatFloat(Varia.MascaraValor,VprDParcelaBaixaCP.ValParcela);
  Grade.Cells[9,VpaLinha]:= FormatFloat(Varia.MascaraValor,VprDParcelaBaixaCP.ValAcrescimo);
  Grade.Cells[10,VpaLinha]:= FormatFloat(Varia.MascaraValor,VprDParcelaBaixaCP.ValDesconto);
  Grade.Cells[11,VpaLinha]:= VprDParcelaBaixaCP.NomFormaPagamento;
end;

{******************************************************************************}
procedure TFBaixaContasaPagarOO.GradeDadosValidosForaGrade(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VprDParcelaBaixaCP.DesObservacoes := EObservacoes.Lines.text;
end;

{******************************************************************************}
procedure TFBaixaContasaPagarOO.GradeGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
var
  VpfDParcela : TRBDParcelaCP;
begin
  if (ACol > 0) and (ARow > 0) and (VprDBaixaCP <> nil) then
  begin
    if VprDBaixaCP.Parcelas.Count > 0  then
    begin
      VpfDParcela := TRBDParcelaCP(VprDBaixaCP.Parcelas.Items[Arow-1]);
      if not VpfDParcela.IndValorQuitaEssaParcela then
      begin
        ABrush.Color := clRed;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFBaixaContasaPagarOO.GradeMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  EObservacoes.Clear;
  if VprDBaixaCP.Parcelas.Count > 0 then
  begin
    VprDParcelaBaixaCP:= TRBDParcelaCP(VprDBaixaCP.Parcelas.Items[VpaLinhaAtual-1]);
    EObservacoes.Text:= VprDParcelaBaixaCP.DesObservacoes;
  end;
end;

{******************************************************************************}
procedure TFBaixaContasaPagarOO.BOkClick(Sender: TObject);
var
  VpfResultado: String;
begin
  VpfResultado:= DadosValidos;
  if VpfResultado = '' then
  begin
    CarDClasse;
    if VpfResultado = '' then
    begin
      VpfResultado:= GravarParcelas;
      if VpfResultado = '' then
      begin
        if Config.PossuiImpressoraCheque then
        begin
          if FunContasAPagar.PossuiChequeDigitado(VprDBaixaCP) then
          begin
            FConsultaCheques := TFConsultaCheques.criarSDI(Application,'',FPrincipal.VerificaPermisao('FConsultaCheques'));
            FConsultaCheques.ConsultaChequesContasPagar(VprDParcelaBaixaCP.CodFilial,VprDParcelaBaixaCP.LanPagar,VprDParcelaBaixaCP.NumParcela);
            FConsultaCheques.free;
          end;
        end;
      end;
    end;
  end;
  if VpfResultado = '' then
  begin
    VprAcao:= True;
    Close;
  end
  else
    aviso(VpfResultado);
end;

{******************************************************************************}
procedure TFBaixaContasaPagarOO.EValAcrescimoExit(Sender: TObject);
begin
  if (VprDBaixaCP.ValorAcrescimo <> EValAcrescimo.AValor) or
     (VprDBaixaCP.ValorDesconto <> EValDesconto.AValor) then
  begin
    VprDBaixaCP.ValorAcrescimo := EValAcrescimo.AValor;
    VprDBaixaCP.ValorDesconto := EValDesconto.AValor;
    FunContasAPagar.DistribuiValAcrescimoDescontoNasParcelas(VprDBaixaCP);
    AtualizaValorTotal;
    Grade.CarregaGrade;
  end;
end;

{******************************************************************************}
procedure TFBaixaContasaPagarOO.EFormaPagamentoRetorno(Retorno1,
  Retorno2: String);
begin
  VprDBaixaCP.TipFormaPagamento := Retorno1;
end;

{******************************************************************************}
procedure TFBaixaContasaPagarOO.EFormaPagamentoCadastrar(Sender: TObject);
begin
  FFormasPagamento:= TFFormasPagamento.criarSDI(Application,'',True);
  FFormasPagamento.BotaoCadastrar1.click;
  FFormasPagamento.Showmodal;
end;

{******************************************************************************}
procedure TFBaixaContasaPagarOO.EValPagoExit(Sender: TObject);
var
  VpfResultado : string;
begin
  VpfResultado := FunContasAPagar.VerificaSeValorPagoQuitaTodasDuplicatas(VprDBaixaCP,EValPago.AValor);
  Grade.CarregaGrade;
  if VpfResultado <> '' then
    aviso(VpfREsultado);
end;

{******************************************************************************}
procedure TFBaixaContasaPagarOO.BCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFBaixaContasaPagarOO.EObservacoesExit(Sender: TObject);
var
  VpfValido : Boolean;
begin
  GradeDadosValidosForaGrade(Grade,VpfValido);
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFBaixaContasaPagarOO]);
end.
