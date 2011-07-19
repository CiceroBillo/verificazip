unit ANovaColetaFracaoOP;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, numericos, Mask,
  ComCtrls, DBKeyViolation, Localizacao, Buttons, UnOrdemproducao, UnDadosProduto,
  Db, DBTables, Constantes;

type
  TFNovaColetaFracaoOP = class(TFormularioPermissao)
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
    Label7: TLabel;
    SpeedButton4: TSpeedButton;
    Label8: TLabel;
    EIDEstagio: TEditLocaliza;
    Localiza: TConsultaPadrao;
    ValidaGravacao1: TValidaGravacao;
    Label9: TLabel;
    SpeedButton5: TSpeedButton;
    Label10: TLabel;
    ECelulaTrabalho: TEditLocaliza;
    EData: TCalendario;
    Label11: TLabel;
    EHoraInicio: TMaskEditColor;
    EHoraFim: TMaskEditColor;
    Label14: TLabel;
    Label15: TLabel;
    EQtdColeta: Tnumerico;
    Label16: TLabel;
    EUM: TComboBoxColor;
    Label17: TLabel;
    EQtdIdeal: Tnumerico;
    Label18: TLabel;
    BCadastrar: TBitBtn;
    BFechar: TBitBtn;
    Aux: TQuery;
    EQtdHora: Tnumerico;
    Label19: TLabel;
    LUMProducaoHora: TLabel;
    LUMQtdIdeal: TLabel;
    EProdutividade: Tnumerico;
    Label20: TLabel;
    Label21: TLabel;
    EQtdFracao: Tnumerico;
    EQtdRestanteFracao: Tnumerico;
    Label22: TLabel;
    EQtdDefeito: Tnumerico;
    Label23: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
    procedure EUsuarioChange(Sender: TObject);
    procedure EOrdemProducaoSelect(Sender: TObject);
    procedure EFracaoSelect(Sender: TObject);
    procedure EIDEstagioSelect(Sender: TObject);
    procedure BCadastrarClick(Sender: TObject);
    procedure ECelulaTrabalhoCadastrar(Sender: TObject);
    procedure EOrdemProducaoRetorno(Retorno1, Retorno2: String);
    procedure EIDEstagioRetorno(Retorno1, Retorno2: String);
    procedure EHoraFimExit(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure EFracaoRetorno(Retorno1, Retorno2: String);
  private
    { Private declarations }
    VprQtdProduzido : double;
    VprOperacao : TRBDOperacaoCadastro;
    VprDColetaFracao : TRBDColetaFracaoOp;
    VprDOrdemProducao : TRBDordemProducao;
    FunOrdemProducao : TRBFuncoesOrdemProducao;
    procedure InicializaTela;
    procedure CarQtdIdeal;
    procedure EstadoBotoes(VpaEstado : Boolean);
    procedure CarDClasse;
  public
    { Public declarations }
    procedure NovaColeta;
  end;

var
  FNovaColetaFracaoOP: TFNovaColetaFracaoOP;

implementation

uses APrincipal, FunObjeto, ACelulaTrabalho, UnProdutos, funSql, FunData, FunString,
     ConstMsg; 

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovaColetaFracaoOP.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunOrdemProducao := TRBFuncoesOrdemProducao.cria(FPrincipal.BaseDados);
  VprDOrdemProducao := TRBDOrdemProducao.cria;
  VprDColetaFracao := TRBDColetaFracaoOp.Create;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovaColetaFracaoOP.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunOrdemProducao.free;
  VprDColetaFracao.free;
  VprDOrdemProducao.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFNovaColetaFracaoOP.BCancelarClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFNovaColetaFracaoOP.EUsuarioChange(Sender: TObject);
begin
  ValidaGravacao1.Execute;
end;

{******************************************************************************}
procedure TFNovaColetaFracaoOP.EOrdemProducaoSelect(Sender: TObject);
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
procedure TFNovaColetaFracaoOP.EFracaoSelect(Sender: TObject);
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

{******************************************************************************}
procedure TFNovaColetaFracaoOP.EIDEstagioSelect(Sender: TObject);
begin
  EIDEstagio.ASelectValida.Text := 'Select FRA.SEQESTAGIO, PRO.DESESTAGIO, PRO.QTDPRODUCAOHORA, FRA.QTDPRODUZIDO '+
                                  ' from FRACAOOPESTAGIO FRA, PRODUTOESTAGIO PRO '+
                                  ' Where FRA.CODFILIAL = '+IntToStr(EFilial.AInteiro)+
                                  ' and FRA.SEQORDEM = '+IntToStr(EOrdemProducao.AInteiro)+
                                  ' AND FRA.SEQFRACAO = '+ IntToStr(EFracao.AInteiro)+
                                  ' AND FRA.SEQESTAGIO = @'+
                                  ' AND PRO.SEQPRODUTO = FRA.SEQPRODUTO '+
                                  ' AND PRO.SEQESTAGIO = FRA.SEQESTAGIO';
  EIDEstagio.ASelectLocaliza.Text := 'Select FRA.SEQESTAGIO, PRO.DESESTAGIO, PRO.QTDPRODUCAOHORA, FRA.QTDPRODUZIDO '+
                                  ' from FRACAOOPESTAGIO FRA, PRODUTOESTAGIO PRO '+
                                  ' Where FRA.CODFILIAL = '+IntToStr(EFilial.AInteiro)+
                                  ' and FRA.SEQORDEM = '+IntToStr(EOrdemProducao.AInteiro)+
                                  ' AND FRA.SEQFRACAO = '+ IntToStr(EFracao.AInteiro)+
                                  ' AND PRO.DESESTAGIO LIKE ''@%'''+
                                  ' AND PRO.SEQPRODUTO = FRA.SEQPRODUTO '+
                                  ' AND PRO.SEQESTAGIO = FRA.SEQESTAGIO';
end;

{******************************************************************************}
procedure TFNovaColetaFracaoOP.InicializaTela;
begin
  LimpaComponentes(PanelColor1,0);
  VprQtdProduzido := 0;
  EUsuario.AInteiro := varia.CodigoUsuario;
  EUsuario.Atualiza;

  EstadoBotoes(true);
end;

{******************************************************************************}
procedure TFNovaColetaFracaoOP.CarQtdIdeal;
begin
  EQtdIdeal.AValor := 0;
  if (DeletaChars(DeletaChars(EHoraInicio.Text,' '),':') <> '') and (DeletaChars(DeletaChars(EHoraFim.Text,' '),':') <> '') then
  begin
    if StrToTime(EHoraInicio.Text) > StrToTime(EHoraFim.Text) then
    begin
      aviso('HORA DE INICIO MAIOR QUE HORA FINAL!!!'#13'A hora de inicio não pode ser maior que a hora final...');
      EHoraFim.Clear;
      exit;
    end;
    VprDColetaFracao.QtdMinutos := DiferencaMinutos(StrToTime(EHoraInicio.Text),StrToTime(EHoraFim.Text));
    EQtdIdeal.AValor := (VprDColetaFracao.QtdMinutos * EQtdHora.Avalor)/60;

    EProdutividade.AValor := (EQtdColeta.AValor * 100)/EQtdIdeal.AValor;
    EQtdRestanteFracao.AValor := EQtdFracao.AValor - (EQtdColeta.AValor+VprQtdProduzido);
    if (EQtdRestanteFracao.AValor > 20) and (EQtdFracao.AValor > 40) then
      EQtdRestanteFracao.AValor := EQtdRestanteFracao.AValor + 20;
  end;
end;

{******************************************************************************}
procedure TFNovaColetaFracaoOP.EstadoBotoes(VpaEstado : Boolean);
begin
  BGravar.Enabled := VpaEstado;
  BCancelar.Enabled := VpaEstado;
  BCadastrar.Enabled := not VpaEstado;
  BFechar.Enabled := not VpaEstado;
end;

{******************************************************************************}
procedure TFNovaColetaFracaoOP.CarDClasse;
begin
  with VprDColetaFracao do
  begin
    CodUsuario := EUsuario.AInteiro;
    CodFilial := EFilial.AInteiro;
    NumOrdemProducao := EOrdemProducao.AInteiro;
    SeqFracao := EFracao.AInteiro;
    SeqEstagio := EIDEstagio.AInteiro;
    CodCelula := ECelulaTrabalho.AInteiro;
    DesUM := EUM.text;
    QtdColetado := EQtdColeta.avalor;
    QtdDefeito := EQtdDefeito.Avalor;
    QtdProducaoHora := EQtdHora.AValor;
    QtdProducaoIdeal := EQtdIdeal.Avalor;
    PerProdutividade := EProdutividade.Asinteger;
    DatInicio := StrToDate(DateToStr(EData.Date)) +StrToTime(EHoraInicio.Text);
    DatFim := StrToDate(DateToStr(EData.Date)) +StrToTime(EHoraFim.Text);
  end;
  CarQtdIdeal;
end;

{******************************************************************************}
procedure TFNovaColetaFracaoOP.NovaColeta;
begin
  VprOperacao := ocInsercao;
  InicializaTela;
  showmodal;
end;

{******************************************************************************}
procedure TFNovaColetaFracaoOP.BCadastrarClick(Sender: TObject);
begin
  InicializaTela;
  ActiveControl := EFilial;
end;

{******************************************************************************}
procedure TFNovaColetaFracaoOP.ECelulaTrabalhoCadastrar(Sender: TObject);
begin
  FCelulaTrabalho := tFCelulaTrabalho.CriarSDI(self,'',FPrincipal.VerificaPermisao(''));
  FCelulaTrabalho.BotaoCadastrar1.Click;
  FCelulaTrabalho.Showmodal;
  FCelulaTrabalho.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovaColetaFracaoOP.EOrdemProducaoRetorno(Retorno1,
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
procedure TFNovaColetaFracaoOP.EIDEstagioRetorno(Retorno1,
  Retorno2: String);
begin
  LUMProducaoHora.Caption := VprDOrdemProducao.DProduto.CodUnidade;
  LUMQtdIdeal.Caption := LUMProducaoHora.Caption;
  EQtdHora.AValor := 0;
  if Retorno1 <> '' then
    EQtdHora.AValor := StrToFloat(retorno1);
  if retorno2<> '' then
    VprQtdProduzido := StrToFloat(Retorno2)
  else
    VprQtdProduzido := 0;
end;

{******************************************************************************}
procedure TFNovaColetaFracaoOP.EHoraFimExit(Sender: TObject);
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
  Begin
    CarQtdIdeal;
    ValidaGravacao1.Execute;
  end;
end;

{******************************************************************************}
procedure TFNovaColetaFracaoOP.BGravarClick(Sender: TObject);
var
  VpfResultado : String;
begin
  CarDClasse;
  VpfResultado := '';
  if (hora(Now) >= 7) and (hora(now) < 8 ) then
    if VprDColetaFracao.DatInicio > date then
      if not Confirmacao('DATA DIFERENTE!!!'#13'A data da coleta é maior que a data atual. Deseja continuar?') then
        VpfResultado := 'DATA INVÁLIDA!!!';
  if VpfResultado = '' then
  begin
    VpfResultado := FunOrdemProducao.GravaDColetaFracaoOP(VprDColetaFracao);
    if VpfResultado = '' then
    begin
      EstadoBotoes(false);
      BCadastrar.Click;
    end
    else
      aviso(VpfResultado);
  end;
end;

{******************************************************************************}
procedure TFNovaColetaFracaoOP.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFNovaColetaFracaoOP.EFracaoRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
    EQtdFracao.AValor := strToFloat(Retorno1)
  else
    EQtdFracao.AValor := 0;

end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovaColetaFracaoOP]);
end.
