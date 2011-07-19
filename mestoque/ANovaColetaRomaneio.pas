unit ANovaColetaRomaneio;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, numericos, Mask,
  ComCtrls, DBKeyViolation, Localizacao, Buttons, UnOrdemproducao, UnDadosProduto,
  Db, DBTables, Constantes;

type
  TFNovaColetaRomaneio = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    Label3: TLabel;
    Label1: TLabel;
    SpeedButton2: TSpeedButton;
    Label4: TLabel;
    Label5: TLabel;
    SpeedButton3: TSpeedButton;
    Label6: TLabel;
    Label12: TLabel;
    SpeedButton6: TSpeedButton;
    Label13: TLabel;
    EFilial: TEditLocaliza;
    EOrdemProducao: TEditLocaliza;
    EFracao: TEditLocaliza;
    EUsuario: TEditLocaliza;
    Localiza: TConsultaPadrao;
    ValidaGravacao1: TValidaGravacao;
    EQtdColeta: Tnumerico;
    Label16: TLabel;
    EUM: TComboBoxColor;
    Label17: TLabel;
    BCadastrar: TBitBtn;
    BFechar: TBitBtn;
    Aux: TQuery;
    Label21: TLabel;
    EQtdFracao: Tnumerico;
    EQtdRestanteFracao: Tnumerico;
    Label22: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
    procedure EUsuarioChange(Sender: TObject);
    procedure EOrdemProducaoSelect(Sender: TObject);
    procedure EFracaoSelect(Sender: TObject);
    procedure BCadastrarClick(Sender: TObject);
    procedure EOrdemProducaoRetorno(Retorno1, Retorno2: String);
    procedure EHoraFimExit(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure EFracaoRetorno(Retorno1, Retorno2: String);
  private
    { Private declarations }
    VprQtdProduzido : double;
    VprOperacao : TRBDOperacaoCadastro;
    VprDColetaRomaneio : TRBDColetaRomaneioOp;
    VprDOrdemProducao : TRBDordemProducao;
    FunOrdemProducao : TRBFuncoesOrdemProducao;
    procedure InicializaTela;
    procedure EstadoBotoes(VpaEstado : Boolean);
    procedure CarDClasse;
    procedure AtualizaQtdRestante;
  public
    { Public declarations }
    procedure NovaColeta;
  end;

var
  FNovaColetaRomaneio: TFNovaColetaRomaneio;

implementation

uses APrincipal, FunObjeto, ACelulaTrabalho, UnProdutos, funSql, FunData, FunString,
     ConstMsg; 

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovaColetaRomaneio.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunOrdemProducao := TRBFuncoesOrdemProducao.cria(FPrincipal.BaseDados);
  VprDOrdemProducao := TRBDOrdemProducao.cria;
  VprDColetaRomaneio := TRBDColetaRomaneioOp.Create;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovaColetaRomaneio.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunOrdemProducao.free;
  VprDColetaRomaneio.free;
  VprDOrdemProducao.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFNovaColetaRomaneio.BCancelarClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFNovaColetaRomaneio.EUsuarioChange(Sender: TObject);
begin
  ValidaGravacao1.Execute;
end;

{******************************************************************************}
procedure TFNovaColetaRomaneio.EOrdemProducaoSelect(Sender: TObject);
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

{******************************************************************************}
procedure TFNovaColetaRomaneio.EFracaoSelect(Sender: TObject);
begin
  EFracao.ASelectLocaliza.Text := 'SELECT FRA.SEQFRACAO, FRA.DATENTREGA, FRA.QTDPRODUTO, FRA.CODESTAGIO, FRA.QTDREVISADO from FRACAOOP FRA '+
                                  ' Where FRA.SEQFRACAO LIKE ''@%'''+
                                  ' AND FRA.CODFILIAL = '+IntToStr(EFilial.AInteiro)+
                                  ' and FRA.SEQORDEM = '+IntToStr(EOrdemProducao.AInteiro);
  EFracao.ASelectValida.Text := 'SELECT FRA.SEQFRACAO, FRA.DATENTREGA, FRA.QTDPRODUTO, FRA.CODESTAGIO, FRA.QTDREVISADO from FRACAOOP FRA '+
                                  ' Where FRA.SEQFRACAO = @ '+
                                  ' AND FRA.CODFILIAL = '+IntToStr(EFilial.AInteiro)+
                                  ' and FRA.SEQORDEM = '+IntToStr(EOrdemProducao.AInteiro);
end;

{******************************************************************************}
procedure TFNovaColetaRomaneio.InicializaTela;
begin
  LimpaComponentes(PanelColor1,0);
  VprQtdProduzido := 0;
  EUsuario.AInteiro := varia.CodigoUsuario;
  EUsuario.Atualiza;

  EstadoBotoes(true);
end;

{******************************************************************************}
procedure TFNovaColetaRomaneio.EstadoBotoes(VpaEstado : Boolean);
begin
  BGravar.Enabled := VpaEstado;
  BCancelar.Enabled := VpaEstado;
  BCadastrar.Enabled := not VpaEstado;
  BFechar.Enabled := not VpaEstado;
end;

{******************************************************************************}
procedure TFNovaColetaRomaneio.CarDClasse;
begin
  with VprDColetaRomaneio do
  begin
    CodUsuario := EUsuario.AInteiro;
    CodFilial := EFilial.AInteiro;
    NumOrdemProducao := EOrdemProducao.AInteiro;
    SeqFracao := EFracao.AInteiro;
    DesUM := EUM.text;
    QtdColetado := EQtdColeta.avalor;
    DatColeta := now;
  end;
end;

{******************************************************************************}
procedure TFNovaColetaRomaneio.AtualizaQtdRestante;
begin
  if EUM.Text <> '' then
    EQtdRestanteFracao.AValor := EQtdFracao.AValor - VprQtdProduzido - FunProdutos.CalculaQdadePadrao(EUM.Text,VprDOrdemProducao.UMPedido,EQtdColeta.AValor,IntToStr(VprDOrdemProducao.SeqProduto)) ;
end;

{******************************************************************************}
procedure TFNovaColetaRomaneio.NovaColeta;
begin
  VprOperacao := ocInsercao;
  InicializaTela;
  showmodal;
end;

{******************************************************************************}
procedure TFNovaColetaRomaneio.BCadastrarClick(Sender: TObject);
begin
  InicializaTela;
end;

{******************************************************************************}
procedure TFNovaColetaRomaneio.EOrdemProducaoRetorno(Retorno1,
  Retorno2: String);
begin
  if (EFilial.AInteiro <> 0) and (EOrdemProducao.AInteiro <> 0) then
  begin
    VprDOrdemProducao.free;
    VprDOrdemProducao := TRBDOrdemProducao.cria;
    FunOrdemProducao.CarDOrdemProducaoBasica(EFilial.AInteiro,EOrdemProducao.AInteiro,VprDOrdemProducao);
    EUM.Items.Clear;
    EUM.Items.Assign(FunProdutos.RUnidadesParentes(VprDOrdemProducao.UMPedido));
  end;
end;

{******************************************************************************}
procedure TFNovaColetaRomaneio.EHoraFimExit(Sender: TObject);
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
  Begin
    ValidaGravacao1.Execute;
    AtualizaQtdRestante;
  end;
end;

{******************************************************************************}
procedure TFNovaColetaRomaneio.BGravarClick(Sender: TObject);
var
  VpfResultado : String;
begin
  CarDClasse;
  VpfResultado := FunOrdemProducao.GravaDColetaRomaneioOP(VprDColetaRomaneio,VprDOrdemProducao);
  if VpfResultado = '' then
    EstadoBotoes(false)
  else
    aviso(VpfResultado);
end;

{******************************************************************************}
procedure TFNovaColetaRomaneio.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFNovaColetaRomaneio.EFracaoRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
    EQtdFracao.AValor := strToFloat(Retorno1)
  else
    EQtdFracao.AValor := 0;
  if Retorno2 <> '' then
    VprQtdProduzido := StrToFloat(Retorno2)
  else
    VprQtdProduzido := 0;
  AtualizaQtdRestante;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovaColetaRomaneio]);
end.
