unit ABaixaOrdemCorte;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Constantes, DBKeyViolation, Localizacao, StdCtrls, Componentes1, Buttons, ExtCtrls, PainelGradiente;

type
  TFBaixaOrdemCorte = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    BFechar: TBitBtn;
    Label2: TLabel;
    SFilial: TSpeedButton;
    Label3: TLabel;
    Label1: TLabel;
    SOP: TSpeedButton;
    Label4: TLabel;
    Label5: TLabel;
    SFracao: TSpeedButton;
    Label6: TLabel;
    EFilial: TEditLocaliza;
    EOrdemProducao: TEditLocaliza;
    EFracao: TEditLocaliza;
    Localiza: TConsultaPadrao;
    ValidaGravacao1: TValidaGravacao;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EFilialChange(Sender: TObject);
    procedure EFilialKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EFracaoSelect(Sender: TObject);
    procedure EOrdemProducaoSelect(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
  private
    { Private declarations }
    VprOperacao : TRBDOperacaoCadastro;
    procedure PreencheCodBarras;
    procedure EstadoBotoes(VpaEstado : Boolean);
    procedure NovaBaixa;
  public
    { Public declarations }
    function BaixaOrdemCorte : Boolean;
  end;

var
  FBaixaOrdemCorte: TFBaixaOrdemCorte;

implementation

uses APrincipal, UnOrdemProducao, Constmsg;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFBaixaOrdemCorte.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

procedure TFBaixaOrdemCorte.NovaBaixa;
begin
  VprOperacao := ocInsercao;
  EFilial.clear;
  EFilial.atualiza;
  EOrdemProducao.Clear;
  EOrdemProducao.Atualiza;
  EFracao.clear;
  EFracao.Atualiza;
  ActiveControl := EFilial;
  EstadoBotoes(true);
  ValidaGravacao1.execute;
end;

{ **************************************************************************** }
procedure TFBaixaOrdemCorte.PreencheCodBarras;
begin
  if Length(EFilial.Text) = 12 then
  begin
    EOrdemProducao.AInteiro := StrtoInt(copy(EFilial.Text,3,6));
    EFracao.AInteiro := StrToInt(copy(EFilial.Text,9,4));
    EFilial.AInteiro := StrToInt(copy(EFilial.Text,1,2));
    EFilial.Atualiza;
    EOrdemProducao.Atualiza;
    EFracao.Atualiza;
  end;
end;

{ ******************* Quando o formulario e fechado ************************** }
function TFBaixaOrdemCorte.BaixaOrdemCorte: Boolean;
begin
  NovaBaixa;
  showmodal;
end;

procedure TFBaixaOrdemCorte.BCancelarClick(Sender: TObject);
begin
  EstadoBotoes(false);
  close;
end;

{ **************************************************************************** }
procedure TFBaixaOrdemCorte.BFecharClick(Sender: TObject);
begin
  close;
end;

{ **************************************************************************** }
procedure TFBaixaOrdemCorte.BGravarClick(Sender: TObject);
var
  VpfResultado : String;
begin
  VpfResultado := FunOrdemProducao.BaixaOrdemCorte(EFilial.AInteiro,EOrdemProducao.AInteiro,EFracao.AInteiro);
  if VpfResultado <> '' then
    aviso(VpfResultado)
  else
  begin
    NovaBaixa;
  end;
end;

{ **************************************************************************** }
procedure TFBaixaOrdemCorte.EFilialChange(Sender: TObject);
begin
  if VprOperacao in [ocInsercao] then
    ValidaGravacao1.execute;
end;

{ **************************************************************************** }
procedure TFBaixaOrdemCorte.EFilialKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = 13 then
    PreencheCodBarras;
end;

{ **************************************************************************** }
procedure TFBaixaOrdemCorte.EFracaoSelect(Sender: TObject);
begin
  EFracao.ASelectLocaliza.Text := 'SELECT FRA.SEQFRACAO, FRA.DATENTREGA, FRA.QTDPRODUTO, FRA.CODESTAGIO from FRACAOOP FRA '+
                                  ' Where FRA.SEQFRACAO LIKE ''@%'''+
                                  ' AND FRA.CODFILIAL = '+IntToStr(EFilial.AInteiro)+
                                  ' and FRA.SEQORDEM = '+IntToStr(EOrdemProducao.AInteiro);
  EFracao.ASelectValida.Text := 'SELECT FRA.SEQFRACAO, FRA.DATENTREGA, FRA.QTDPRODUTO, FRA.CODESTAGIO from FRACAOOP FRA '+
                                  ' Where FRA.SEQFRACAO = @ '+
                                  ' AND FRA.CODFILIAL = '+IntToStr(EFilial.AInteiro)+
                                  ' and FRA.SEQORDEM = '+IntToStr(EOrdemProducao.AInteiro);
end;

{ **************************************************************************** }
procedure TFBaixaOrdemCorte.EOrdemProducaoSelect(Sender: TObject);
begin
  EOrdemProducao.ASelectLocaliza.Text := 'Select ORD.SEQORD, ORD.DATEMI, CLI.C_NOM_CLI from ORDEMPRODUCAOCORPO ORD, CADCLIENTES CLI '+
                                         ' Where ORD.EMPFIL = '+ IntToStr(EFilial.AInteiro)+
                                         ' and ORD.CODCLI = CLI.I_COD_CLI '+
                                         ' AND CLI.C_NOM_CLI like ''@%''';
  EOrdemProducao.ASelectValida.Text := 'Select ORD.SEQORD, ORD.DATEMI, CLI.C_NOM_CLI From ORDEMPRODUCAOCORPO ORD, CADCLIENTES CLI '+
                                         ' Where ORD.EMPFIL = '+ IntToStr(EFilial.AInteiro)+
                                         ' and ORD.CODCLI = CLI.I_COD_CLI '+
                                         ' AND ORD.SEQORD = @';
end;

{ **************************************************************************** }
procedure TFBaixaOrdemCorte.EstadoBotoes(VpaEstado: Boolean);
begin
  BGravar.Enabled := VpaEstado;
  BCancelar.Enabled := VpaEstado;
  BFechar.Enabled := not VpaEstado;
end;

{ **************************************************************************** }
procedure TFBaixaOrdemCorte.FormClose(Sender: TObject; var Action: TCloseAction);
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
 RegisterClasses([TFBaixaOrdemCorte]);
end.
