unit AFechamentoCaixa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Grids, CGrades, Mask, numericos, StdCtrls, Componentes1, Localizacao,
  Buttons, ExtCtrls, PainelGradiente, UnCaixa, unDadosCR;

type
  TFFechamentoCaixa = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Localiza: TConsultaPadrao;
    Label3: TLabel;
    Label4: TLabel;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    Label2: TLabel;
    Label5: TLabel;
    SpeedButton2: TSpeedButton;
    Label6: TLabel;
    EContaCaixa: TEditLocaliza;
    ESeqCaixa: Tnumerico;
    EDatAbertura: TEditColor;
    EUsuario: TEditLocaliza;
    Label7: TLabel;
    EValInicial: Tnumerico;
    EValAtual: Tnumerico;
    Label8: TLabel;
    EValFinal: Tnumerico;
    Label9: TLabel;
    PanelColor3: TPanelColor;
    PanelColor5: TPanelColor;
    PanelColor4: TPanelColor;
    Label10: TLabel;
    Grade: TRBStringGridColor;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure BCancelarClick(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
  private
    { Private declarations }
    VprAcao : Boolean;
    VprDCaixa : TRBDCaixa;
    VprDFormaPagamento : TRBDCaixaFormaPagamento;
    FunCaixa : TRBFuncoesCaixa;
    procedure CarTituloGrade;
    procedure CarDTela;
    procedure CarDClasse;
  public
    { Public declarations }
    function FechaCaixa(VpaSeqCaixa : Integer):boolean;
  end;

var
  FFechamentoCaixa: TFFechamentoCaixa;

implementation

uses APrincipal, Constantes, ConstMsg;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFFechamentoCaixa.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  CarTituloGrade;
  VprAcao := false;
  FunCaixa := TRBFuncoesCaixa.cria(FPrincipal.BaseDados);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFFechamentoCaixa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFFechamentoCaixa.CarTituloGrade;
begin
  Grade.Cells[1,0] := 'Código';
  Grade.Cells[2,0] := 'Forma Pagamento';
  Grade.Cells[3,0] := 'Valor Inicial';
  Grade.Cells[4,0] := 'Valor Final';
end;

{******************************************************************************}
procedure TFFechamentoCaixa.CarDTela;
begin
  EContaCaixa.Text := VprDCaixa.NumConta;
  EContaCaixa.Atualiza;
  ESeqCaixa.AsInteger := VprDCaixa.SeqCaixa;
  EDatAbertura.Text := FormatDateTime('DD/MM/YYYY HH:MM',VprDCaixa.DatAbertura);
  EUsuario.AInteiro := VprDCaixa.CodUsuarioAbertura;
  EUsuario.Atualiza;
  EValInicial.AValor := VprDCaixa.ValInicial;
  EValAtual.AValor := VprDCaixa.ValAtual;
  EValFinal.AValor := VprDCaixa.ValFinal;
  Grade.ADados := VprDCaixa.FormasPagamento;
  Grade.CarregaGrade;
end;

{******************************************************************************}
procedure TFFechamentoCaixa.CarDClasse;
begin
  VprDCaixa.DatFechamento := now;
  VprDCaixa.CodUsuarioFechamento := varia.CodigoUsuario;
end;

{******************************************************************************}
function TFFechamentoCaixa.FechaCaixa(VpaSeqCaixa : Integer):boolean;
begin
  VprDCaixa := TRBDCaixa.cria;
  FunCaixa.CarDCaixa(VprDCaixa,VpaSeqCaixa);
  CarDTela;
  showmodal;
  result := VprAcao;
  FunCaixa.free;
end;

{******************************************************************************}
procedure TFFechamentoCaixa.GradeCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDFormaPagamento := TRBDCaixaFormaPagamento(VprDCaixa.FormasPagamento.Items[VpaLinha-1]);
  if VprDFormaPagamento.CodFormaPagamento <> 0 then
    Grade.Cells[1,VpaLinha] := IntToStr(VprDFormaPagamento.CodFormaPagamento)
  else
    Grade.Cells[1,VpaLinha] := '';
  Grade.Cells[2,VpaLinha] := VprDFormaPagamento.NomFormaPagamento;
  Grade.Cells[3,VpaLinha] := FormatFloat(varia.MascaraValor,VprDFormaPagamento.ValInicial);
  Grade.Cells[4,VpaLinha] := FormatFloat(varia.MascaraValor,VprDFormaPagamento.ValAtual)
end;

{******************************************************************************}
procedure TFFechamentoCaixa.GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
  VpaLinhaAnterior: Integer);
begin
  if VprDCaixa.FormasPagamento.Count > 0 then
  begin
    VprDFormaPagamento := TRBDCaixaFormaPagamento(VprDCaixa.FormasPagamento.Items[VpaLinhaAtual -1]);
  end;
end;

{******************************************************************************}
procedure TFFechamentoCaixa.BCancelarClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFFechamentoCaixa.BGravarClick(Sender: TObject);
var
  VpfResultado : String;
begin
  CarDClasse;
  VpfResultado := FunCaixa.FechaCaixa(VprDCaixa);
  if VpfResultado = '' then
  begin
    VprAcao := true;
    close;
  end
  else
    Aviso(VpfResultado);
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFFechamentoCaixa]);
end.
