unit ABaixaContasAReceberOO;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  formularios, Componentes1, ExtCtrls, PainelGradiente, StdCtrls, DBCtrls,
  Tabela, Grids, DBGrids, DBKeyViolation, Buttons, Mask, numericos, ComCtrls,
  Localizacao, Db, DBTables, CGrades, UnDadoscr, UnContasAReceber, UnSistema,
  Menus, UnClassesImprimir,UnImpressao, sqlexpr;

type
  TFBaixaContasaReceberOO = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BOk: TBitBtn;
    BCancelar: TBitBtn;
    PanelColor3: TPanelColor;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    EDatPagamento: TCalendario;
    EValAcrescimo: Tnumerico;
    EValDesconto: Tnumerico;
    Label4: TLabel;
    SpeedButton1: TSpeedButton;
    Label5: TLabel;
    Localiza: TConsultaPadrao;
    Label6: TLabel;
    SpeedButton2: TSpeedButton;
    Label7: TLabel;
    Label8: TLabel;
    EValPago: Tnumerico;
    EContaCaixa: TEditLocaliza;
    Grade: TRBStringGridColor;
    EObservacoes: TMemoColor;
    EFormaPagamento: TEditLocaliza;
    BOpcoes: TBitBtn;
    PopupMenu1: TPopupMenu;
    DescontarDuplicatas1: TMenuItem;
    N1: TMenuItem;
    FundoPerdido1: TMenuItem;
    N2: TMenuItem;
    CobranaExterna1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
    procedure EFormaPagamentoCadastrar(Sender: TObject);
    procedure GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure BOkClick(Sender: TObject);
    procedure GradeDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure EDatPagamentoExit(Sender: TObject);
    procedure EValAcrescimoExit(Sender: TObject);
    procedure EFormaPagamentoRetorno(Retorno1, Retorno2: String);
    procedure EValPagoExit(Sender: TObject);
    procedure GradeGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure GradeDadosValidosForaGrade(Sender: TObject;
      var VpaValidos: Boolean);
    procedure DescontarDuplicatas1Click(Sender: TObject);
    procedure FundoPerdido1Click(Sender: TObject);
    procedure CobranaExterna1Click(Sender: TObject);
    procedure EObservacoesExit(Sender: TObject);
  private
    VprAcao: Boolean;
    VprDBaixaCR: TRBDBaixaCR;
    VprDParcelaBaixaCR: TRBDParcelaBaixaCR;
    FunImpressao : TFuncoesImpressao;
    procedure CarTitulosGrade;
    procedure InicializaTela;
    function DadosValidos: String;
    procedure CarDClasse;
    function DigitaCheques : String;
    function AdicionaCartaDebitoCredito : string;
    function GravarParcelas: String;
    procedure CarDClasseParcela;
    procedure CarDRecibo(VpaDRecibo : TDadosRecibo);
    procedure AtualizaValorTotal;
    procedure AtualizaValoresTela;
    procedure CalculaAcrescimoDesconto;
    procedure DescontaDuplicatas;
    procedure FundoPerdido;
    procedure CobrancaExterna;
    procedure AssociaPerDescontoFormaPagamento(VpaCodFormaPagamento : Integer);
  public
    VpfTransacao : TTransactionDesc;

    function BaixarContasAReceber(VpaDBaixaCR: TRBDBaixaCR): Boolean;
    procedure ConsultaParcelasBaixa(VpaParcelas : TList);
  end;

var
  FBaixaContasaReceberOO: TFBaixaContasaReceberOO;

implementation
uses
  APrincipal, AFormasPagamento, FunObjeto, Constantes, FunData, ConstMsg, FunString,
  AChequesOO, funNumeros, UnCaixa, UnClientes;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFBaixaContasaReceberOO.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunImpressao := TFuncoesImpressao.Criar(self,FPrincipal.BaseDados);
  VprAcao:= False;
  CarTitulosGrade;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFBaixaContasaReceberOO.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunImpressao.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFBaixaContasaReceberOO.BCancelarClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFBaixaContasaReceberOO.EFormaPagamentoCadastrar(Sender: TObject);
begin
  FFormasPagamento:= TFFormasPagamento.criarSDI(Application,'',True);
  FFormasPagamento.BotaoCadastrar1.click;
  FFormasPagamento.Showmodal;
end;

{******************************************************************************}
procedure TFBaixaContasaReceberOO.CarTitulosGrade;
begin
  Grade.Cells[1,0]:= 'Cliente';
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
procedure TFBaixaContasaReceberOO.InicializaTela;
var
  VpfDParcela : TRBDParcelaBaixaCR;
begin
  if config.SalvarDataUltimaBaixaCR then
    EDatPagamento.DateTime := Sistema.RDataUltimaBaixa
  else
    EDatPagamento.DateTime := date;

  EValAcrescimo.AValor:= 0;
  EValDesconto.AValor:= 0;
  EValPago.AValor:= 0;
  EFormaPagamento.AInteiro:= 0;
  EContaCaixa.Text:= '';
  EObservacoes.Text:= '';
  if VprDBaixaCR.Parcelas.Count > 0 then
  begin
    VpfDParcela := TRBDParcelaBaixaCR(VprDBaixaCR.Parcelas.Items[0]);
    EContaCaixa.Text := VpfDParcela.NumContaCorrente;
    EFormaPagamento.AInteiro := VpfDParcela.CodFormaPagamento;
  end;

  EFormaPagamento.Atualiza;
  EContaCaixa.Atualiza;
  CalculaAcrescimoDesconto;
end;

{******************************************************************************}
procedure TFBaixaContasaReceberOO.GradeCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDParcelaBaixaCR:= TRBDParcelaBaixaCR(VprDBaixaCR.Parcelas.Items[VpaLinha-1]);

  Grade.Cells[1,VpaLinha]:= VprDParcelaBaixaCR.NomCliente;
  if VprDParcelaBaixaCR.NumNotaFiscal <> 0 then
    Grade.Cells[2,VpaLinha]:= IntToStr(VprDParcelaBaixaCR.NumNotaFiscal)
  else
    Grade.Cells[2,VpaLinha]:= '';
  Grade.Cells[3,VpaLinha]:= VprDParcelaBaixaCR.NumDuplicata;
  Grade.Cells[4,VpaLinha]:= IntToStr(VprDParcelaBaixaCR.NumParcela);
  if VprDParcelaBaixaCR.DatEmissao > MontaData(1,1,1900) then
    Grade.Cells[5,VpaLinha]:= FormatDateTime('DD/MM/YYYY',VprDParcelaBaixaCR.DatEmissao)
  else
    Grade.Cells[5,VpaLinha]:= '';
  if VprDParcelaBaixaCR.DatVencimento > MontaData(1,1,1900) then
    Grade.Cells[6,VpaLinha]:= FormatDateTime('DD/MM/YYYY',VprDParcelaBaixaCR.DatVencimento)
  else
    Grade.Cells[6,VpaLinha]:= '';
  Grade.Cells[7,VpaLinha]:= IntToStr(VprDParcelaBaixaCR.NumDiasAtraso);
  Grade.Cells[8,VpaLinha]:= FormatFloat(Varia.MascaraValor,VprDParcelaBaixaCR.ValParcela);
  Grade.Cells[9,VpaLinha]:= FormatFloat(Varia.MascaraValor,VprDParcelaBaixaCR.ValAcrescimo);
  Grade.Cells[10,VpaLinha]:= FormatFloat(Varia.MascaraValor,VprDParcelaBaixaCR.ValDesconto);
  Grade.Cells[11,VpaLinha]:= VprDParcelaBaixaCR.NomFormaPagamento;
end;

{******************************************************************************}
procedure TFBaixaContasaReceberOO.GradeDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  CarDClasseParcela;
end;

{******************************************************************************}
procedure TFBaixaContasaReceberOO.CarDClasseParcela;
begin
  VprDParcelaBaixaCR.ValAcrescimo:= StrToFloat(DeletaChars(Grade.Cells[9,Grade.ALinha],'.'));
  VprDParcelaBaixaCR.ValDesconto:= StrToFloat(DeletaChars(Grade.Cells[10,Grade.ALinha],'.'));
  VprDParcelaBaixaCR.DesObservacoes:= EObservacoes.Text;
  AtualizaValorTotal;
end;

{******************************************************************************}
procedure TFBaixaContasaReceberOO.CarDRecibo(VpaDRecibo : TDadosRecibo);
var
  VpfLaco : Integer;
  VpfDParcela : TRBDParcelaBaixaCR;
  VpfValExtenso, VpfDuplicatas : String;
begin
  for VpfLaco := 0 to VprDBaixaCR.Parcelas.Count - 1 do
  begin
    VpfDParcela := TRBDParcelaBaixaCR(VprDBaixaCR.Parcelas.Items[VpfLaco]);
    VpaDRecibo.Numero := IntToStr(VpfDParcela.LanReceber);
    VpaDRecibo.Pessoa := VpfDParcela.NomCliente;
    if VpfDParcela.IndGeraParcial then
      VpfDuplicatas := VpfDuplicatas + 'e pagamento parcial da ' +VpfDParcela.NumDuplicata
    else
      VpfDuplicatas := VpfDuplicatas + VpfDParcela.NumDuplicata+', ';

  end;
  if (VprDBaixaCR.Parcelas.Count = 1) then
  begin
    if TRBDParcelaBaixaCR(VprDBaixaCR.Parcelas.Items[0]).IndGeraParcial then
      VpfDuplicatas := copy(VpfDuplicatas,3,length(VpfDuplicatas)-2)
    else
      VpfDuplicatas := 'pagamento total das duplicatas '+ VpfDuplicatas;
  end
  else
    VpfDuplicatas := 'pagamento total das duplicatas '+ VpfDuplicatas;

  VpaDRecibo.Valor := VprDBaixaCR.ValorPago;
  VpfValExtenso := Extenso(VpaDRecibo.Valor,'reais','real');
  VpaDRecibo.DescValor1 := copy(VpfValExtenso,1,55);
  VpaDRecibo.DescValor2 := copy(VpfValExtenso,56,100);

  VpaDRecibo.DescReferente1 := copy(VpfDuplicatas,1,55);
  VpaDRecibo.DescReferente2 := copy(VpfDuplicatas,56,100);
  VpaDRecibo.Cidade := varia.CidadeFilial;
  VpaDRecibo.Dia := InttoStr(Dia(Date));
  VpaDRecibo.Mes := TextoMes(date,false);
  VpaDRecibo.Ano := IntTostr(Ano(date));
  VpaDRecibo.Emitente := varia.NomeFilial;
end;

{******************************************************************************}
procedure TFBaixaContasaReceberOO.AtualizaValorTotal;
begin
  FunContasAReceber.CalculaValorTotalBaixa(VprDBaixaCR);
  AtualizaValoresTela;
end;

{******************************************************************************}
function TFBaixaContasaReceberOO.AdicionaCartaDebitoCredito: string;
var
  VpfDCheque : TRBDCheque;
begin
  if (VprDBaixaCR.TipFormaPagamento = fpCartaoCredito) or
     (VprDBaixaCR.TipFormaPagamento = fpCartaoDebito) then
  begin
    FreeTObjectsList(VprDBaixaCR.Cheques);
    VpfDCheque := VprDBaixaCR.AddCheque;
    VpfDCheque.CodFormaPagamento := VprDBaixaCR.CodFormaPagamento;
    VpfDCheque.CodUsuario := varia.CodigoUsuario;
    VpfDCheque.NumContaCaixa := VprDBaixaCR.NumContaCaixa;
    VpfDCheque.TipCheque := 'C';
    VpfDCheque.TipFormaPagamento := VprDBaixaCR.TipFormaPagamento;
    VpfDCheque.TipContaCaixa := FunContasAReceber.RTipoConta(VprDBaixaCR.NumContaCaixa);
    VpfDCheque.ValCheque := VprDBaixaCR.ValorPago;
    VpfDCheque.DatCadastro := date;
    VpfDCheque.DatVencimento := IncDia(date,FunContasAReceber.RDiasVencimentoFormaPagamento(VprDBaixaCR.CodFormaPagamento));
    VpfDCheque.DatEmissao := date;
  end;

end;


{******************************************************************************}
procedure TFBaixaContasaReceberOO.AssociaPerDescontoFormaPagamento(VpaCodFormaPagamento: Integer);
var
  VpfLaco : Integer;
  VpfPerDeconto : Double;
  VpfDParcela : TRBDParcelaBaixaCR;
begin
  VpfPerDeconto := FunContasAReceber.RPerDescontoFormaPagamento(VpaCodFormaPagamento);
  for VpfLaco := 0 to VprDBaixaCR.Parcelas.Count - 1 do
  begin
    VpfDParcela := TRBDParcelaBaixaCR(VprDBaixaCR.Parcelas.Items[Vpflaco]);
    VpfDParcela.PerDescontoFormaPagamento := VpfPerDeconto;
  end;
  CalculaAcrescimoDesconto;
end;

{******************************************************************************}
procedure TFBaixaContasaReceberOO.AtualizaValoresTela;
begin
  EValAcrescimo.AValor := VprDBaixaCR.ValorAcrescimo;
  EValDesconto.AValor := VprDBaixaCR.ValorDesconto;
  EValPago.AValor := VprDBaixaCR.ValorPago;
end;

{******************************************************************************}
procedure TFBaixaContasaReceberOO.GradeMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  EObservacoes.Clear;
  if VprDBaixaCR.Parcelas.Count > 0 then
  begin
    VprDParcelaBaixaCR:= TRBDParcelaBaixaCR(VprDBaixaCR.Parcelas.Items[VpaLinhaAtual-1]);
    EObservacoes.Text:= VprDParcelaBaixaCR.DesObservacoes;
  end;
end;

{******************************************************************************}
procedure TFBaixaContasaReceberOO.BOkClick(Sender: TObject);
var
  VpfResultado: String;
  VpfDRecibo : TDadosRecibo;
begin
  VpfResultado:= DadosValidos;
  if VpfResultado = '' then
  begin
    CarDClasse;
    if VpfResultado = '' then
      VpfResultado:= GravarParcelas;
  end;
  if VpfResultado = '' then
  begin
    Sistema.GravaDataUltimaBaixa(EDatPagamento.DateTime);
    VprAcao:= True;
    if Varia.CNPJFilial = CNPJ_FELDMANN then
    begin
      VpfDRecibo := TDadosRecibo.Create;
      CarDRecibo(VpfDRecibo);
      FunImpressao.ImprimirRecibo(VpfDRecibo);
      VpfDRecibo.free;
    end;
    Close;
  end
  else
    aviso(VpfResultado);
end;

{******************************************************************************}
function TFBaixaContasaReceberOO.DadosValidos: String;
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
    Result := FunContasAReceber.VerificaSeValorPagoQuitaTodasDuplicatas(VprDBaixaCR,EValPago.AValor);
    if result = '' then
    begin
      if not FunCaixa.ContaCaixaAberta(EContaCaixa.Text) then
        result := 'CONTA CAIXA FECHADO!!!'#13'É necessário abrir a conta caixa.';
    end;
  end;
end;

{******************************************************************************}
procedure TFBaixaContasaReceberOO.CarDClasse;
begin
  VprDBaixaCR.DatPagamento:= EDatPagamento.DateTime;
  VprDBaixaCR.ValorAcrescimo:= EValAcrescimo.AValor;
  VprDBaixaCR.ValorDesconto:= EValDesconto.AValor;
  VprDBaixaCR.CodFormaPagamento:= EFormaPagamento.AInteiro;
  VprDBaixaCR.NumContaCaixa:= EContaCaixa.Text;
  VprDBaixaCR.ValorPago:= EValPago.AValor;
end;

{******************************************************************************}
procedure TFBaixaContasaReceberOO.CalculaAcrescimoDesconto;
var
  VpfLaco : Integer;
  VpfDParcela : TRBDParcelaBaixaCR;
begin
  for VpfLaco := 0 to VprDBaixaCR.Parcelas.Count - 1 do
  begin
    VpfDParcela := TRBDParcelaBaixaCR(VprDBaixaCR.Parcelas.Items[VpfLaco]);
    FunContasAReceber.CalculaJuroseDescontoParcela(VpfDParcela,EDatPagamento.DateTime);
  end;
  AtualizaValorTotal;
end;

{******************************************************************************}
procedure TFBaixaContasaReceberOO.DescontaDuplicatas;
var
  VpfResultado : string;
begin
  EValAcrescimoExit(EValAcrescimo);
  VpfResultado:= DadosValidos;
  if VpfResultado = '' then
  begin
    CarDClasse;
    if VpfResultado = '' then
      VpfResultado := FunContasAReceber.DescontaDuplicata(VprDBaixaCR);
  end;
  if VpfResultado = '' then
  begin
    VprAcao := true;
    close;
  end
  else
    aviso(VpfResultado);
end;

{******************************************************************************}
procedure TFBaixaContasaReceberOO.FundoPerdido;
var
  VpfLaco : Integer;
  VpfDParcela : TRBDParcelaBaixaCR;
begin
  for VpfLaco := 0 to VprDBaixaCR.Parcelas.Count - 1 do
  begin
    VpfDParcela := TRBDParcelaBaixaCR(VprDBaixaCR.Parcelas.Items[VpfLaco]);
    FunContasAReceber.SetaFundoPerdido(VpfDParcela.CodFilial,VpfDParcela.LanReceber,VpfDParcela.NumParcela,EObservacoes.Lines.text);
  end;
  VprAcao := true;
  close;
end;

{******************************************************************************}
procedure TFBaixaContasaReceberOO.CobrancaExterna;
var
  VpfLaco : Integer;
  VpfDParcela : TRBDParcelaBaixaCR;
begin
  for VpfLaco := 0 to VprDBaixaCR.Parcelas.Count - 1 do
  begin
    VpfDParcela := TRBDParcelaBaixaCR(VprDBaixaCR.Parcelas.Items[VpfLaco]);
    FunContasAReceber.SetaCobrancaExterna(VpfDParcela.CodFilial,VpfDParcela.LanReceber,VpfDParcela.NumParcela,EObservacoes.Lines.text);
  end;
  VprAcao := true;
  close;
end;

{******************************************************************************}
function TFBaixaContasaReceberOO.DigitaCheques : String;
begin
  result := '';
  VprDBaixaCR.IndContaOculta := VprDParcelaBaixaCR.IndContaOculta;

  if (VprDBaixaCR.TipFormaPagamento = fpCheque) or (VprDBaixaCR.TipFormaPagamento = fpChequeTerceiros) or
     (VprDBaixaCR.TipFormaPagamento = fpCarteira) or (VprDBaixaCR.TipFormaPagamento = fpDepositoCheque) then // cheque, cheque terceiros, carteira, Deposito Cheque
  begin
    FChequesOO := TFChequesOO.CriarSDI(nil,'',true);
    if not FChequesOO.CadastraCheques(VprDBaixaCR) then
      result := 'DIGITAÇÃO DOS CHEQUES CANCELADA!!!'#13'Foi cancelado a digitação dos cheques';
    FChequesOO.free;
    if result = '' then
    begin
      if VprDBaixaCR.Cheques.Count > 0 then
      begin
        VprDBaixaCR.ValorPago := FunContasAReceber.RValTotalCheques(VprDBaixaCR.Cheques);
        EValPago.AValor := VprDBaixaCR.ValorPago;
        if EValPago.AValor <>  FunContasAReceber.RValTotalParcelasBaixa(VprDBaixaCR) then
        begin
          result := FunContasAReceber.VerificaSeValorPagoQuitaTodasDuplicatas(VprDBaixaCR,EValPago.AValor);
          Grade.CarregaGrade;
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFBaixaContasaReceberOO.GravarParcelas: String;
begin
  Result := DigitaCheques;
  if result = '' then
  begin
    result := AdicionaCartaDebitoCredito;
    if result = '' then
    begin
      FPrincipal.BaseDados.StartTransaction(VpfTransacao);
      result := FunContasAReceber.VerificaSeGeraParcial(VprDBaixaCR,EValPago.AValor,true);
      if result = '' then
        Result:= FunContasAReceber.BaixaContasAReceber(VprDBaixaCR);

      if result = '' then
        FPrincipal.BaseDados.Commit(VpfTransacao)
      else
        FPrincipal.BaseDados.Rollback(VpfTransacao);
    end;
  end;
end;

{******************************************************************************}
function TFBaixaContasaReceberOO.BaixarContasAReceber(VpaDBaixaCR: TRBDBaixaCR): Boolean;
begin
  VprDBaixaCR:= VpaDBaixaCR;
  InicializaTela;
  Grade.ADados:= VprDBaixaCR.Parcelas;
  Grade.CarregaGrade;
  ShowModal;
  Result:= VprAcao;
end;

{******************************************************************************}
procedure TFBaixaContasaReceberOO.ConsultaParcelasBaixa(VpaParcelas : TList);
begin
  VprDBaixaCR:= TRBDBaixaCR.Cria;
  VprDBaixaCR.Parcelas := VpaParcelas;
  Grade.ADados:= VprDBaixaCR.Parcelas;
  Grade.CarregaGrade;
  Show;
end;

{******************************************************************************}
procedure TFBaixaContasaReceberOO.EDatPagamentoExit(Sender: TObject);
begin
  if VprDBaixaCR.DatPagamento <> EDatPagamento.DateTime then
  begin
    VprDBaixaCR.DatPagamento := EDatPagamento.DateTime;
    CalculaAcrescimoDesconto;
    AtualizaValorTotal;
    Grade.CarregaGrade;
  end;
end;

{******************************************************************************}
procedure TFBaixaContasaReceberOO.EValAcrescimoExit(Sender: TObject);
begin
  if (VprDBaixaCR.ValorAcrescimo <> EValAcrescimo.AValor) or
     (VprDBaixaCR.ValorDesconto <> EValDesconto.AValor) then
  begin
    VprDBaixaCR.ValorAcrescimo := EValAcrescimo.AValor;
    VprDBaixaCR.ValorDesconto := EValDesconto.AValor;
    FunContasAReceber.DistribuiValAcrescimoDescontoNasParcelas(VprDBaixaCR);
    AtualizaValorTotal;
    Grade.CarregaGrade;
  end;
end;

{******************************************************************************}
procedure TFBaixaContasaReceberOO.EFormaPagamentoRetorno(Retorno1,
  Retorno2: String);
begin
  VprDBaixaCR.TipFormaPagamento := FunContasAReceber.RTipoFormaPagamento(Retorno1);
  if VprDBaixaCR.CodFormaPagamento <> EFormaPagamento.AInteiro then
  begin
    AssociaPerDescontoFormaPagamento(EFormaPagamento.AInteiro);
  end;
end;

{******************************************************************************}
procedure TFBaixaContasaReceberOO.EValPagoExit(Sender: TObject);
var
  VpfResultado : string;
begin
  VpfResultado := FunContasAReceber.VerificaSeValorPagoQuitaTodasDuplicatas(VprDBaixaCR,EValPago.AValor);
  Grade.CarregaGrade;
  if VpfResultado <> '' then
    aviso(VpfREsultado);
end;

{******************************************************************************}
procedure TFBaixaContasaReceberOO.GradeGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
var
  VpfDParcela : TRBDParcelaBaixaCR;
begin
  if (ACol > 0) and (ARow > 0) and (VprDBaixaCR <> nil) then
  begin
    if VprDBaixaCR.Parcelas.Count > 0  then
    begin
      VpfDParcela := TRBDParcelaBaixaCR(VprDBaixaCR.Parcelas.Items[Arow-1]);
      if not VpfDParcela.IndValorQuitaEssaParcela then
      begin
        ABrush.Color := clRed;
      end;
    end;
  end;

end;

{******************************************************************************}
procedure TFBaixaContasaReceberOO.GradeDadosValidosForaGrade(
  Sender: TObject; var VpaValidos: Boolean);
begin
  VprDParcelaBaixaCR.DesObservacoes := EObservacoes.Lines.text;
end;

{******************************************************************************}
procedure TFBaixaContasaReceberOO.DescontarDuplicatas1Click(
  Sender: TObject);
begin
  DescontaDuplicatas;
end;

{******************************************************************************}
procedure TFBaixaContasaReceberOO.FundoPerdido1Click(Sender: TObject);
begin
  FundoPerdido;
end;

{******************************************************************************}
procedure TFBaixaContasaReceberOO.CobranaExterna1Click(Sender: TObject);
begin
  CobrancaExterna;
end;

{******************************************************************************}
procedure TFBaixaContasaReceberOO.EObservacoesExit(Sender: TObject);
var
  VpfValido : Boolean;
begin
  GradeDadosValidosForaGrade(Grade,VpfValido);
end;

Initialization
{***************** Registra a classe para evitar duplicidade ******************}
  RegisterClasses([TFBaixaContasaReceberOO]);
end.
