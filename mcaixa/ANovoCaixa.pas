unit ANovoCaixa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Db, DBTables, Tabela,
  CBancoDados, StdCtrls, Buttons, Mask, DBCtrls, Localizacao,
  DBKeyViolation, BotaoCadastro, UnCaixa, Grids, CGrades, UnDadosCR, UnContasAReceber,
  numericos, Constantes;

type
  TFNovoCaixa = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    Localiza: TConsultaPadrao;
    Label3: TLabel;
    Label4: TLabel;
    ValidaGravacao1: TValidaGravacao;
    PanelColor3: TPanelColor;
    PanelColor4: TPanelColor;
    PanelColor2: TPanelColor;
    Label7: TLabel;
    Grade: TRBStringGridColor;
    EFormaPagamento: TEditLocaliza;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    Label2: TLabel;
    EContaCaixa: TEditLocaliza;
    ESeqCaixa: Tnumerico;
    EDatAbertura: TEditColor;
    Label5: TLabel;
    SpeedButton2: TSpeedButton;
    Label6: TLabel;
    EUsuario: TEditLocaliza;
    EValInicial: Tnumerico;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    EValCheques: Tnumerico;
    Label8: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EContaCaixaCadastrar(Sender: TObject);
    procedure EContaCaixaChange(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure EContaCaixaRetorno(Retorno1, Retorno2: String);
    procedure GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GradeDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure GradeGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GradeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EFormaPagamentoCadastrar(Sender: TObject);
    procedure EFormaPagamentoRetorno(Retorno1, Retorno2: String);
    procedure GradeKeyPress(Sender: TObject; var Key: Char);
    procedure GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GradeNovaLinha(Sender: TObject);
    procedure GradeSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure GradeDepoisExclusao(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
  private
    { Private declarations }
    VprAcao : Boolean;
    VprOperacao : TRBDOperacaoCadastro;
    VprCodFormaPagamentoAnterior : String;
    VprDCaixa : TRBDCaixa;
    VprDFormaPagamento : TRBDCaixaFormaPagamento;
    FunCaixa : TRBFuncoesCaixa;
    procedure CarTituloGrade;
    procedure InicializaTela;
    procedure CarDCaixaFormaPagamento;
    procedure CarDClasse;
    function ExisteFormaPagamento : Boolean;
    procedure AtualizaValTotal;
  public
    { Public declarations }
    function NovoCaixa : boolean;
  end;

var
  FNovoCaixa: TFNovoCaixa;

implementation

uses APrincipal, ANovaConta, ConstMsg, FunString,
  AFormasPagamento;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovoCaixa.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  CarTituloGrade;
  VprAcao := false;
  FunCaixa := TRBFuncoesCaixa.cria(FPrincipal.BaseDados);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovoCaixa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunCaixa.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


procedure TFNovoCaixa.EContaCaixaCadastrar(Sender: TObject);
begin
  FNovaConta := TFNovaConta.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaConta'));
  FNovaConta.CadContas.Insert;
  FNovaConta.showmodal;
  FNovaConta.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovoCaixa.EContaCaixaChange(Sender: TObject);
begin
  if VprOperacao in [ocedicao,ocinsercao] then
    ValidaGravacao1.execute;
end;

{******************************************************************************}
function TFNovoCaixa.NovoCaixa : boolean;
begin
  VprOperacao := ocinsercao;
  VprDCaixa := TRBDCaixa.cria;
  Grade.ADados := VprDCaixa.FormasPagamento;
  Grade.CarregaGrade;
  InicializaTela;
  Showmodal;
  result := VprAcao;
  VprDCaixa.free;
end;

{******************************************************************************}
procedure TFNovoCaixa.CarTituloGrade;
begin
  Grade.Cells[1,0] := 'Código';
  Grade.Cells[2,0] := 'Forma Pagamento';
  Grade.Cells[3,0] := 'Valor Inicial';
end;

{******************************************************************************}
procedure TFNovoCaixa.InicializaTela;
begin
  VprDCaixa.CodUsuarioAbertura := Varia.CodigoUsuario;
  VprDCaixa.DatAbertura := now;
  EDatAbertura.Text := FormatDateTime('DD/MM/YYYY HH:MM:SS',VprDCaixa.DatAbertura);
  EUsuario.AInteiro := varia.CodigoUsuario;
  EUsuario.Atualiza;
  ValidaGravacao1.execute;
end;

{******************************************************************************}
procedure TFNovoCaixa.CarDCaixaFormaPagamento;
begin
  VprDFormaPagamento.ValInicial := StrToFloat(DeletaChars(Grade.Cells[3,Grade.ALinha],'.'));
  AtualizaValTotal;
end;

{******************************************************************************}
procedure TFNovoCaixa.CarDClasse;
begin
  VprDCaixa.NumConta := EContaCaixa.Text;
end;

{******************************************************************************}
function TFNovoCaixa.ExisteFormaPagamento : Boolean;
begin
  result := false;
  if Grade.Cells[1,Grade.ALinha] <> '' then
  begin
    if Grade.Cells[1,Grade.ALinha] = VprCodFormaPagamentoAnterior then
      result := true
    else
    begin
      result := FunContasAReceber.ExisteFormaPagamento(StrToInt(Grade.cells[1,Grade.ALinha]),VprDFormaPagamento);
      if result then
      begin
        VprCodFormaPagamentoAnterior := Grade.Cells[1,Grade.ALinha];
        Grade.Cells[2,Grade.ALinha] := VprDFormaPagamento.NomFormaPagamento;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoCaixa.AtualizaValTotal;
begin
  VprDCaixa.ValInicial := FunCaixa.RValTotalFormaPagamento(VprDCaixa);
  EValInicial.AValor := VprDCaixa.ValInicial;
end;

{******************************************************************************}
procedure TFNovoCaixa.BGravarClick(Sender: TObject);
var
  VpfResultado : string;
begin
  CarDClasse;
  VpfResultado := FunCaixa.GravaDCaixa(VprDCaixa);
  if VpfResultado = '' then
    VpfResultado := FunCaixa.AtualizaSeqCaixaContaCaixa(VprDCaixa.NumConta,VprDCaixa.SeqCaixa);
  if VpfResultado = '' then
  begin
    ESeqCaixa.AsInteger := VprDCaixa.SeqCaixa;
    VprAcao := true;
    close;
  end
  else
    Aviso(VpfResultado);
end;

{******************************************************************************}
procedure TFNovoCaixa.EContaCaixaRetorno(Retorno1, Retorno2: String);
begin
  If retorno2 <> '' then
  begin
    EContaCaixa.SetFocus;
    aviso('CONTA CAIXA JÁ EXISTE ABERTA!!!'#13'Não é possível abrir uma conta que ainda não foi fechada.');
  end;
  if retorno1 <> '' then
  begin
    FunCaixa.InicializaValoresCaixa(VprDCaixa,StrToInt(Retorno1));
    AtualizaValTotal;
    Grade.CarregaGrade;
  end;
end;

{******************************************************************************}
procedure TFNovoCaixa.GradeCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDFormaPagamento := TRBDCaixaFormaPagamento(VprDCaixa.FormasPagamento.Items[VpaLinha-1]);
  if VprDFormaPagamento.CodFormaPagamento <> 0 then
    Grade.Cells[1,VpaLinha] := IntToStr(VprDFormaPagamento.CodFormaPagamento)
  else
    Grade.Cells[1,VpaLinha] := '';
  Grade.Cells[2,VpaLinha] := VprDFormaPagamento.NomFormaPagamento;
  if VprDFormaPagamento.ValInicial <> 0 then
    Grade.Cells[3,VpaLinha] := FormatFloat(varia.MascaraValor,VprDFormaPagamento.ValInicial)
  else
    Grade.Cells[3,VpaLinha] := '';
end;

{******************************************************************************}
procedure TFNovoCaixa.GradeDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if not ExisteFormaPagamento then
  begin
    aviso('FORMA DE PAGAMENTO NÃO CADASTRADA!!!'+#13+'A forma de pagamento digita não existe cadastrada...');
    VpaValidos := false;
    Grade.col := 1;
  end
  else
    if Grade.Cells[3,Grade.ALinha] = '' then
    begin
      aviso('VALOR INICIAL NÃO PREENCHIDO!!!'+#13+'É necessário preencher o valor inicial.');
      VpaValidos := false;
      Grade.Col := 3;
    end;
  if VpaValidos then
    CarDCaixaFormaPagamento;
  if VpaValidos then
  begin
    if VprDFormaPagamento.ValInicial = 0 then
    begin
        aviso('VALOR INICIAL NÃO PREENCHIDO!!!'+#13+'É necessário preencher o valor inicial.');
        VpaValidos := false;
        Grade.Col := 3;
    end;
    if VpaValidos then
    begin
      if FunCaixa.FormaPagamentoDuplicada(VprDCaixa) then
      begin
        aviso('FORMA DE PAGAMENTO DUPLICADO!!!'+#13+'Não é permitido duplicar a mesma forma de pagamento.');
        VpaValidos := false;
        Grade.Col := 1;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoCaixa.GradeGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    1 :  Value := '00000;0; ';
  end;
end;

{******************************************************************************}
procedure TFNovoCaixa.GradeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    114 :
    begin                           // F3
      case Grade.Col of
        1 :  EFormaPagamento.AAbreLocalizacao;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoCaixa.EFormaPagamentoCadastrar(Sender: TObject);
begin
  FFormasPagamento := TFFormasPagamento.CriarSDI(self,'',FPrincipal.VerificaPermisao('FFormasPagamento'));
  FFormasPagamento.BotaoCadastrar1.Click;
  FFormasPagamento.showmodal;
  FFormasPagamento.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovoCaixa.EFormaPagamentoRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
  begin
    Grade.Cells[1,Grade.ALinha] := EFormaPagamento.Text;
    Grade.cells[2,grade.ALinha] := Retorno1;
    VprDFormaPagamento.CodFormaPagamento := EFormaPagamento.AInteiro;
    VprDFormaPagamento.NomFormaPagamento := Retorno1;
    VprCodFormaPagamentoAnterior := EFormaPagamento.Text;
  end
  else
  begin
    Grade.Cells[1,Grade.ALinha] := '';
    Grade.Cells[2,Grade.ALinha] := '';
    VprDFormaPagamento.CodFormaPagamento :=0;
  end;
end;

{******************************************************************************}
procedure TFNovoCaixa.GradeKeyPress(Sender: TObject; var Key: Char);
begin
  case Grade.Col of
    2 : key := #0;
  end;
  if (key = '.') and  (Grade.col in [3]) then
    key := DecimalSeparator;
end;

{******************************************************************************}
procedure TFNovoCaixa.GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
  VpaLinhaAnterior: Integer);
begin
  if VprDCaixa.FormasPagamento.Count > 0 then
  begin
    VprDFormaPagamento := TRBDCaixaFormaPagamento(VprDCaixa.FormasPagamento.Items[VpaLinhaAtual -1]);
    VprCodFormaPagamentoAnterior := IntToStr(VprDFormaPagamento.CodFormaPagamento);
  end;
end;

{******************************************************************************}
procedure TFNovoCaixa.GradeNovaLinha(Sender: TObject);
begin
  VprDFormaPagamento := VprDCaixa.AddFormaPagamento;
end;

{******************************************************************************}
procedure TFNovoCaixa.GradeSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  if Grade.AEstadoGrade in [egInsercao,EgEdicao] then
    if Grade.AColuna <> ACol then
    begin
      case Grade.AColuna of
        1 :if not ExisteFormaPagamento then
           begin
             if not EFormaPagamento.AAbreLocalizacao then
             begin
               Grade.Cells[1,Grade.ALinha] := '';
               abort;
             end;
           end;
      end;
    end;
end;

{******************************************************************************}
procedure TFNovoCaixa.GradeDepoisExclusao(Sender: TObject);
begin
  AtualizaValTotal;
end;

procedure TFNovoCaixa.BCancelarClick(Sender: TObject);
begin
  VprAcao := false;
  close;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovoCaixa]);
end.
