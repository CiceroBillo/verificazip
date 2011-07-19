unit ANovaFracaoFaccionista;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Mask, numericos, ComCtrls,
  StdCtrls, Localizacao, Buttons, DBKeyViolation, Constantes, UnDadosProduto, UnOrdemProducao;

type
  TRBTipoTela = (ttNovaFracao,ttRetornoFracao, ttDevolucao,ttRevisao);
  TFNovaFracaoFaccionista = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    Localiza: TConsultaPadrao;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    ValidaGravacao1: TValidaGravacao;
    BCadastrar: TBitBtn;
    BFechar: TBitBtn;
    PanelColor3: TPanelColor;
    PanelColor1: TPanelColor;
    Label2: TLabel;
    SFilial: TSpeedButton;
    Label3: TLabel;
    Label1: TLabel;
    SOP: TSpeedButton;
    Label4: TLabel;
    Label5: TLabel;
    SFracao: TSpeedButton;
    Label6: TLabel;
    Label12: TLabel;
    SpeedButton6: TSpeedButton;
    Label13: TLabel;
    Label7: TLabel;
    SIdEstagio: TSpeedButton;
    Label8: TLabel;
    Label11: TLabel;
    LQtdEnviado: TLabel;
    LUMProducaoHora: TLabel;
    Label9: TLabel;
    SFaccionista: TSpeedButton;
    Label10: TLabel;
    Bevel1: TBevel;
    LValUnitario: TLabel;
    EFilial: TEditLocaliza;
    EOrdemProducao: TEditLocaliza;
    EFracao: TEditLocaliza;
    EUsuario: TEditLocaliza;
    EIDEstagio: TEditLocaliza;
    EQtdEnviado: Tnumerico;
    EFaccionista: TEditLocaliza;
    EData: TEditColor;
    EValUnitario: Tnumerico;
    PDevolucao: TPanelColor;
    CTipoMotivo: TRadioGroup;
    PFracaoFaccionista: TPanelColor;
    Label16: TLabel;
    Label14: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    ETaxEntrega: Tnumerico;
    EDatRetorno: TCalendario;
    EUM: TComboBoxColor;
    EValUnitarioPosterior: Tnumerico;
    PRetornoFracao: TPanelColor;
    Bevel2: TBevel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    CFinalizar: TCheckBox;
    EDataNegociado: TCalendario;
    EValUniPosteriorRetorno: Tnumerico;
    EValUniREtorno: Tnumerico;
    EDesMotivo: TMemoColor;
    Label22: TLabel;
    CDefeito: TCheckBox;
    Label15: TLabel;
    EProduto: TEditLocaliza;
    SpeedButton1: TSpeedButton;
    LNomProduto: TLabel;
    BTerceiros: TBitBtn;
    EEstagio: TRBEditLocaliza;
    SEstagio: TSpeedButton;
    LSaldo: TLabel;
    ESaldo: Tnumerico;
    EQtdDevolucao: Tnumerico;
    LQtdDevolucao: TLabel;
    EDatEnvio: TCalendario;
    LDatEnvio: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EFilialChange(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure EOrdemProducaoSelect(Sender: TObject);
    procedure EOrdemProducaoRetorno(Retorno1, Retorno2: String);
    procedure EFracaoSelect(Sender: TObject);
    procedure EIDEstagioSelect(Sender: TObject);
    procedure EFaccionistaCadastrar(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure BCadastrarClick(Sender: TObject);
    procedure EFaccionistaExit(Sender: TObject);
    procedure EQtdEnviadoExit(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure EFaccionistaSelect(Sender: TObject);
    procedure EFracaoRetorno(Retorno1, Retorno2: String);
    procedure EFilialKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BTerceirosClick(Sender: TObject);
    procedure EEstagioFimConsulta(Sender: TObject);
  private
    { Private declarations }
    VprAcao : Boolean;
    VprOperacao : TRBDOperacaoCadastro;
    VprDFracaoFaccionista : TRBDFracaoFaccionista;
    VprDRetornoFracao : TRBDRetornoFracaoFaccionista;
    VprDDevolucaoFracao : TRBDDevolucaoFracaoFaccionista;
    VprDRevisaoFracao : TRBDRevisaoFracaoFaccionista;
    VprDOrdemProducao : TRBDordemProducao;
    VprDFracaoOP : TRBDFracaoOrdemProducao;
    VprTipoTela : TRBTipoTela;
    FunOrdemProducao : TRBFuncoesOrdemProducao;
    VprDatEnvio : TDateTime;
    procedure InicializaTela;
    procedure InicializaTelaRetorno;
    procedure InicializaTelaDevolucao;
    procedure InicializaTelaREvisao;
    procedure CarDClasse;
    function CarDClasseRetorno : string;
    function CarDClasseDevolucao : String;
    function CarDClasseRevisao : String;
    function CarSeqItemFaccionista : String;
    procedure EstadoBotoes(VpaEstado : Boolean);
    procedure ConfiguraTelaRetornoFaccionista;
    procedure ConfiguraTamanhoTela;
    function GravaDFracaoFaccionista : String;
    function GravaDRetornoFaccionista : string;
    function GravaDDevolucaoFaccionista : string;
    function GravaDRevisaoFaccionista : String;
    procedure PreencheCodBarras;
    procedure ConfiguraTela;
  public
    { Public declarations }
    function NovaFracaoFaccionista : Boolean;
    function RetornoFracaoFaccionista : Boolean;
    function DevolucaoFracaoFaccionista : Boolean;
    function RevisaoFracaoFaccionista(VpaDRevisaoFracao : TRBDRevisaoFracaoFaccionista) : boolean;
  end;

var
  FNovaFracaoFaccionista: TFNovaFracaoFaccionista;

implementation

uses APrincipal,FunData, FunObjeto, ConstMsg, UnProdutos, ATerceiroFaccionista,
  ANovaFaccionista;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovaFracaoFaccionista.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunOrdemProducao := TRBFuncoesOrdemProducao.cria(FPrincipal.BaseDados);
  VprDRetornoFracao := TRBDRetornoFracaoFaccionista.cria;
  VprAcao := false;
  VprDOrdemProducao := TRBDOrdemProducao.cria;
  VprDFracaoOP := TRBDFracaoOrdemProducao.cria;
  VprDFracaoFaccionista := TRBDFracaoFaccionista.cria;
  VprDDevolucaoFracao := TRBDDevolucaoFracaoFaccionista.cria;
  VprDatEnvio := now;
  ConfiguraTela;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovaFracaoFaccionista.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  VprDFracaoOP.free;
  VprDOrdemProducao.free;
  VprDFracaoFaccionista.free;
  VprDRetornoFracao.free;
  VprDDevolucaoFracao.free;
  FunOrdemProducao.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFNovaFracaoFaccionista.EFilialChange(Sender: TObject);
begin
  if VprOperacao in [ocInsercao] then
    ValidaGravacao1.execute;
end;

{******************************************************************************}
procedure TFNovaFracaoFaccionista.InicializaTela;
begin
  EstadoBotoes(true);
  VprOperacao :=ocInsercao;
  PanelColor1.Enabled := TRUE;
  VprDFracaoFaccionista.free;
  VprDFracaoFaccionista := TRBDFracaoFaccionista.Cria;
  VprDFracaoFaccionista.CodUsuario := varia.CodigoUsuario;
  VprDFracaoFaccionista.DatDigitacao := now;
  VprDFracaoFaccionista.DatRetorno := incdia(date,1);
  VprDFracaoFaccionista.ValEstagio := 0;
  LimpaComponentes(PanelColor3,0);
  EDatEnvio.Date := VprDatEnvio;
  EUsuario.AInteiro := VprDFracaoFaccionista.CodUsuario;
  EUsuario.Atualiza;
  EData.Text := FormatDateTime('DD/MM/YYYY HH:MM:SS',VprDFracaoFaccionista.DatDigitacao);
  EQtdEnviado.ReadOnly := false;
  EValUnitario.ReadOnly := false;
  EDatRetorno.DateTime := VprDFracaoFaccionista.DatRetorno;
  ActiveControl := EFilial;
  ConfiguraTamanhoTela;
end;

{******************************************************************************}
procedure TFNovaFracaoFaccionista.InicializaTelaRetorno;
begin
  VprOperacao :=ocConsulta;
  LimpaComponentes(PanelColor3,0);
  EstadoBotoes(true);
  VprOperacao :=ocInsercao;
  PanelColor1.Enabled := TRUE;
  VprDRetornoFracao.Free;
  VprDRetornoFracao := TRBDRetornoFracaoFaccionista.Cria;
  VprDRetornoFracao.CodUsuario := varia.CodigoUsuario;
  VprDRetornoFracao.DatDigitacao := now;
  EUsuario.AInteiro := VprDRetornoFracao.CodUsuario;
  EUsuario.Atualiza;
  EData.Text := FormatDateTime('DD/MM/YYYY HH:MM:SS',VprDRetornoFracao.DatDigitacao);
  EDataNegociado.DateTime := montadata(1,1,2000);
  EDatEnvio.Date := VprDatEnvio;
  ActiveControl := EFilial;
end;

{******************************************************************************}
procedure TFNovaFracaoFaccionista.InicializaTelaDevolucao;
begin
  VprOperacao :=ocConsulta;
  LimpaComponentes(PanelColor3,0);
  EstadoBotoes(true);
  VprOperacao :=ocInsercao;
  PanelColor1.Enabled := TRUE;
  VprDDevolucaoFracao.Free;
  VprDDevolucaoFracao := TRBDDevolucaoFracaoFaccionista.Cria;
  VprDDevolucaoFracao.CodUsuario := varia.CodigoUsuario;
  VprDDevolucaoFracao.DatCadastro := now;
  EUsuario.AInteiro := VprDDevolucaoFracao.CodUsuario;
  EUsuario.Atualiza;
  EData.Text := FormatDateTime('DD/MM/YYYY HH:MM:SS',VprDDevolucaoFracao.DatCadastro);
  CTipoMotivo.ItemIndex := 0;
  ActiveControl := EFilial;
end;

{******************************************************************************}
procedure TFNovaFracaoFaccionista.InicializaTelaREvisao;
begin
  VprOperacao := ocConsulta;
  LimpaComponentes(PanelColor3,0);
  EstadoBotoes(true);
  VprOperacao :=ocInsercao;
  PanelColor1.Enabled := TRUE;
  VprDRevisaoFracao.CodUsuario := varia.CodigoUsuario;
  VprDRevisaoFracao.DatRevisao := now;
  EUsuario.AInteiro := VprDRevisaoFracao.CodUsuario;
  EUsuario.Atualiza;
  EData.Text := FormatDateTime('DD/MM/YYYY HH:MM:SS',VprDRevisaoFracao.DatRevisao);
  EFilial.AInteiro := VprDRevisaoFracao.CodFilial;
  EFilial.Atualiza;
  EOrdemProducao.AInteiro := VprDRevisaoFracao.SeqOrdem;
  EOrdemProducao.Atualiza;
  EFracao.AInteiro := VprDRevisaoFracao.SeqFracao;
  EFracao.Atualiza;
  if config.EnviarFracaoFaccionistaPeloEstagio then
  begin
    EEstagio.AInteiro := VprDRevisaoFracao.SeqEstagio;
    EEstagio.Atualiza;
  end
  else
  begin
    EIDEstagio.AInteiro := VprDRevisaoFracao.SeqEstagio;
    EIDEstagio.Atualiza;
  end;
  EFaccionista.AInteiro := VprDRevisaoFracao.CodFaccionista;
  EFaccionista.Atualiza;
  EProduto.Text := VprDRevisaoFracao.CodProduto;
  LNomProduto.caption := VprDRevisaoFracao.NomProduto;
  AlterarEnabledDet([EFilial,EOrdemProducao,EFracao,EIDEstagio,EEstagio,EFaccionista,SFilial,SOP,SFracao,SIdEstagio,SFaccionista],false);

  ActiveControl := EQtdEnviado;;
end;

{******************************************************************************}
function TFNovaFracaoFaccionista.NovaFracaoFaccionista : Boolean;
begin
  PRetornoFracao.Visible := false;
  VprTipoTela := ttNovaFracao;
  InicializaTela;
  Showmodal;
  result := VprAcao;
end;

{******************************************************************************}
function TFNovaFracaoFaccionista.RetornoFracaoFaccionista : Boolean;
begin
  Caption := 'Retorno Fração Faccionista';
  PainelGradiente1.Caption := '   Retorno Fração Faccionista   ';
  LQtdEnviado.Caption := 'Qtd Produzido :';
  VprTipoTela := ttRetornoFracao;
  InicializaTelaRetorno;
  ConfiguraTelaRetornoFaccionista;
  showmodal;
  Result := VprAcao;
end;

{******************************************************************************}
function TFNovaFracaoFaccionista.DevolucaoFracaoFaccionista : Boolean;
begin
  Caption := 'Devolução Fração Faccionista';
  PainelGradiente1.Caption := '   Devolução Fração Faccionista   ';
  LQtdEnviado.Caption := 'Qtd Devolvido :';
  VprTipoTela := ttDevolucao;
  InicializaTelaDevolucao;
  ConfiguraTelaRetornoFaccionista;
  showmodal;
  Result := VprAcao;
end;

{******************************************************************************}
function TFNovaFracaoFaccionista.RevisaoFracaoFaccionista(VpaDRevisaoFracao : TRBDRevisaoFracaoFaccionista) : boolean;
begin
  Caption := 'Revisão Fração Faccionista';
  PainelGradiente1.Caption := '  Revisão Fração Faccionista   ';
  LQtdEnviado.Caption := 'Qtd Revisado : ';
  LValUnitario.Caption := 'Qtd Defeitos : ';
  VprTipoTela := ttRevisao;
  VprDRevisaoFracao := VpaDRevisaoFracao;
  InicializaTelaREvisao;
  ConfiguraTelaRetornoFaccionista;
  ShowModal;
  result := VprAcao;
end;

{******************************************************************************}
procedure TFNovaFracaoFaccionista.CarDClasse;
begin
  with VprDFracaoFaccionista do
  begin
    CodFilial := EFilial.AInteiro;
    SeqOrdem := EOrdemProducao.AInteiro;
    SeqFracao := EFracao.AInteiro;
    if config.EnviarFracaoFaccionistaPeloEstagio then
      SeqIDEstagio := EEstagio.AInteiro
    else
      SeqIDEstagio := EIDEstagio.AInteiro;
    CodUsuario := EUsuario.AInteiro;
    DatCadastro := EDatEnvio.DateTime;
    DatRetorno := EDatRetorno.DateTime;
    CodFaccionista := EFaccionista.AInteiro;
    QtdEnviado := EQtdEnviado.AValor;
    IndDefeito := CDefeito.Checked;
    DesUM := EUM.Text;
    ValUnitario := EValUnitario.AValor;
    ValUnitarioPosterior := EValUnitarioPosterior.AValor;
    ValTaxaEntrega := ETaxEntrega.AValor;
  end;
end;

{******************************************************************************}
function TFNovaFracaoFaccionista.CarDClasseRetorno : String;
begin
  result := CarSeqItemFaccionista;
  if result = '' then
  begin
    with VprDRetornoFracao do
    begin
      CodFilial := EFilial.AInteiro;
      SeqOrdem := EOrdemProducao.AInteiro;
      SeqFracao := EFracao.AInteiro;
      if config.EnviarFracaoFaccionistaPeloEstagio then
        SeqIDEstagio := EEstagio.AInteiro
      else
        SeqIDEstagio := EIDEstagio.AInteiro;
      CodFaccionista := EFaccionista.AInteiro;
      QtdRetorno := EQtdEnviado.AValor;
      ValUnitario := EValUnitario.AValor;
      DatCadastro := EDatEnvio.Date;
      IndFinalizar := CFinalizar.Checked;
      IndDefeito := CDefeito.Checked;

      IndValorMenor := false;
      if (MontaData(dia(VprDRetornoFracao.DatCadastro),mes(VprDRetornoFracao.DatCadastro),ano(VprDRetornoFracao.DatCadastro)) > VprDRetornoFracao.DatNegociado) and
         (VprDRetornoFracao.ValUnitario <> VprDRetornoFracao.ValUnitarioPosteriorEnviado) then
        IndValorMenor := true;
    end;
  end;
end;

{******************************************************************************}
function TFNovaFracaoFaccionista.CarDClasseDevolucao : String;
begin
  result := CarSeqItemFaccionista;
  if result = '' then
  begin
    with VprDDevolucaoFracao do
    begin
      CodUsuario := varia.CodigoUsuario;
      DatCadastro := now;
      CodFilial := EFilial.AInteiro;
      SeqOrdem := EOrdemProducao.AInteiro;
      SeqFracao := EFracao.AInteiro;
      CodFaccionista := EFaccionista.AInteiro;
      QtdDevolvido := EQtdEnviado.AValor;
      DesMotivo := EDesMotivo.Lines.Text;
      CodMotivo := CTipoMotivo.ItemIndex;
      if config.EnviarFracaoFaccionistaPeloEstagio then
        SeqIDEstagio := EEstagio.AInteiro
      else
        SeqIDEstagio := EIDEstagio.AInteiro;
    end;
  end;
end;

{******************************************************************************}
function TFNovaFracaoFaccionista.CarDClasseRevisao : String;
begin
  Result := '';
  if EQtdEnviado.AValor = 0 then
    result := 'QUANTIDADE REVISADO INVÁLIDO!!!'#13'É necessário preencher a quantidade que foi revisado.';
  if result = '' then
  begin
    VprDRevisaoFracao.QtdRevisado := EQtdEnviado.AValor;
    VprDRevisaoFracao.QtdDefeito := EValUnitario.AValor;
  end;
end;

{******************************************************************************}
function TFNovaFracaoFaccionista.CarSeqItemFaccionista : String;
var
  vpfEstagio : Integer;
begin
  result := '';
  if Config.EnviarFracaoFaccionistaPeloEstagio then
    vpfEstagio := EEstagio.AInteiro
  else
    vpfEstagio := EIDEstagio.AInteiro;
  FunOrdemProducao.CarValoreSeqItemFaccionista(EFilial.Ainteiro,EOrdemProducao.AInteiro,EFracao.AInteiro,
                                                                    vpfEstagio,EFaccionista.AInteiro,CDefeito.Checked,VprDRetornoFracao);
  ESaldo.AValor := VprDRetornoFracao.QtdFaltante;
  if VprDRetornoFracao.SeqItem = 0 then
    result := 'FRAÇÃO NÃO ENVIADA PARA ESSE FACCIONISTA!!!'#13'A fração digitada não foi enviada para esse faccionista';
  if result = '' then
  begin
    if VprDRetornoFracao.DatFinalizacaoFracao > MontaData(1,1,1990) then
    begin
      if not confirmacao('FRAÇÃO JÁ SE ENCONTRA FINALIZADA NO DIA '+FormatDateTime('DD/MM/YYYY',VprDRetornoFracao.DatFinalizacaoFracao)+
                     '!!!'#13'Tem certeza que deseja continuar ?') then
        result := 'FRAÇÃO JÁ SE ENCONTRA FINALIZADA!!!';
    end;
    EDataNegociado.DateTime := VprDRetornoFracao.DatNegociado;
    EValUniREtorno.AValor := VprDRetornoFracao.ValUnitarioEnviado;
    EValUniPosteriorRetorno.AValor := VprDRetornoFracao.ValUnitarioPosteriorEnviado;

    VprDDevolucaoFracao.SeqItem := VprDRetornoFracao.SeqItem;
  end;
end;

{******************************************************************************}
procedure TFNovaFracaoFaccionista.EstadoBotoes(VpaEstado : Boolean);
begin
  BGravar.Enabled := VpaEstado;
  BCancelar.Enabled:= VpaEstado;
  BCadastrar.Enabled := not VpaEstado;
  BFechar.Enabled := not VpaEstado;
end;

{******************************************************************************}
procedure TFNovaFracaoFaccionista.ConfiguraTela;
begin
  EEstagio.Visible := Config.EnviarFracaoFaccionistaPeloEstagio;
  SEstagio.Visible:= Config.EnviarFracaoFaccionistaPeloEstagio;
  EIDEstagio.Visible := not Config.EnviarFracaoFaccionistaPeloEstagio;
  SIdEstagio.Visible := not Config.EnviarFracaoFaccionistaPeloEstagio;
end;

{******************************************************************************}
procedure TFNovaFracaoFaccionista.ConfiguraTelaRetornoFaccionista;
begin
  if VprTipoTela = ttRetornoFracao then
  begin
    PFracaoFaccionista.Visible := false;
    FNovaFracaoFaccionista.Height := FNovaFracaoFaccionista.Height - PFracaoFaccionista.Height+PRetornoFracao.Height ;
    LDatEnvio.Caption := 'Data Retorno :';
  end
  else
    if VprTipoTela = ttDevolucao then
    begin
      PFracaoFaccionista.Visible := false;
      PRetornoFracao.Visible := false;
      PDevolucao.Visible := true;
      EValUnitario.Visible := false;
      LValUnitario.Visible := false;
    end
    else
      if VprTipoTela = ttRevisao then
      begin
        PFracaoFaccionista.Visible := false;
        PRetornoFracao.Visible := false;
        PDevolucao.Visible := false;
//        PRevisao.visible := true;
        BCadastrar.Visible := false;
        BTerceiros.Visible := true;
      end;
  ConfiguraTamanhoTela;
end;

{******************************************************************************}
procedure TFNovaFracaoFaccionista.ConfiguraTamanhoTela;
var
  vpfLaco : Integer;
  VpfTamanho : Integer;
begin
  AlterarVisibleDet([LSaldo,ESaldo,LQtdDevolucao,EQtdDevolucao],VprTipoTela = ttRetornoFracao);
  AlterarVisibleDet([LDatEnvio,EDatEnvio],VprTipoTela in[ttNovaFracao,ttRetornoFracao]);
  VpfTamanho :=0;
  if PanelColor1.Visible then
    VpfTamanho := VpfTamanho + PanelColor1.Height;
  if PFracaoFaccionista.Visible then
    VpfTamanho := VpfTamanho + PFracaoFaccionista.Height;
  if PRetornoFracao.Visible then
    VpfTamanho := VpfTamanho + PRetornoFracao.Height;
  if PDevolucao.Visible then
    VpfTamanho := VpfTamanho + PDevolucao.Height - 35;
//  if PRevisao.Visible then
//    VpfTamanho := VpfTamanho +PRevisao.Height;
  VpfTamanho := VpfTamanho + 35;
  Height := VpfTamanho +PainelGradiente1.Height +PanelColor2.Height;
end;

{******************************************************************************}
function TFNovaFracaoFaccionista.GravaDFracaoFaccionista : String;
begin
  CarDClasse;
  if not config.PermitirEnviarFracaoMaisde1VezparaoMesmoFaccionista then
    if not VprDFracaoFaccionista.IndDefeito then
      if FunOrdemProducao.ExisteFracaoFaccionista(VprDFracaoFaccionista) then
        result := 'FRAÇÃO FACCIONISTA DUPLICADO!!!'#13'Não é possível enviar a mesma fração mais de uma vez para o mesmo faccionista.';
  if result = '' then
    result := FunOrdemProducao.GravaDFracaoFaccionista(VprDFracaoFaccionista);
end;

{******************************************************************************}
function TFNovaFracaoFaccionista.GravaDRetornoFaccionista : string;
begin
  result := CarDClasseRetorno;
  if result = '' then
  begin
    result := FunOrdemProducao.GravaDRetornoFracaoFaccionista(VprDRetornoFracao);
    if EQtdDevolucao.AValor > 0  then
    begin
      result := CarDClasseDevolucao;
      if result = '' then
      begin
        VprDDevolucaoFracao.QtdDevolvido := EQtdDevolucao.AValor;
        result := FunOrdemProducao.GravaDDevolucaoFracaoFaccionista(VprDDevolucaoFracao);
      end;
    end;
  end;
end;

{******************************************************************************}
function TFNovaFracaoFaccionista.GravaDDevolucaoFaccionista : string;
begin
  result := CarDClasseDevolucao;
  if result = '' then
  begin
    result := FunOrdemProducao.GravaDDevolucaoFracaoFaccionista(VprDDevolucaoFracao);
  end;
end;

{******************************************************************************}
function TFNovaFracaoFaccionista.GravaDRevisaoFaccionista : String;
begin
  result := CarDClasseRevisao;
  if result = '' then
    result := FunOrdemProducao.GravaDRevisaoFracaoFaccionista(VprDRevisaoFracao);
end;

{******************************************************************************}
procedure TFNovaFracaoFaccionista.PreencheCodBarras;
begin
  if Length(EFilial.Text) = 12 then
  begin
    EOrdemProducao.AInteiro := StrtoInt(copy(EFilial.Text,3,6));
    EFracao.AInteiro := StrToInt(copy(EFilial.Text,9,4));
    EFilial.AInteiro := StrToInt(copy(EFilial.Text,1,2));
    EFilial.Atualiza;
    EOrdemProducao.Atualiza;
    EFracao.Atualiza;
    ActiveControl := EIDEstagio;
  end;
end;

{******************************************************************************}
procedure TFNovaFracaoFaccionista.BGravarClick(Sender: TObject);
var
  VpfResultado : String;
begin
  VpfResultado := '';
  if VprTipoTela = ttNovaFracao then
    VpfResultado := GravaDFracaoFaccionista
  else
    if VprTipoTela = ttRetornoFracao then
      VpfResultado := GravaDRetornoFaccionista
    else
      if VprTipoTela = ttDevolucao then
        VpfResultado := GravaDDevolucaoFaccionista
      else
        if VprTipoTela = ttRevisao then
          VpfResultado := GravaDRevisaoFaccionista;

  if VpfResultado = '' then
  begin
    VprDatEnvio := EDatEnvio.Date;
    VprAcao := true;
    EstadoBotoes(false);
    PanelColor1.Enabled := false;
    if VprTipoTela = ttRevisao then
      close
    else
      VprOperacao := ocConsulta;
  end
  else
    Aviso(VpfResultado);
end;

{******************************************************************************}
procedure TFNovaFracaoFaccionista.EOrdemProducaoSelect(Sender: TObject);
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
procedure TFNovaFracaoFaccionista.EOrdemProducaoRetorno(Retorno1,
  Retorno2: String);
begin
end;

{******************************************************************************}
procedure TFNovaFracaoFaccionista.EFracaoSelect(Sender: TObject);
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
procedure TFNovaFracaoFaccionista.EIDEstagioSelect(Sender: TObject);
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
procedure TFNovaFracaoFaccionista.EEstagioFimConsulta(Sender: TObject);
begin
  if (VprTipoTela = ttNovaFracao) then
  begin
    VprDFracaoFaccionista.ValEstagio := FunOrdemProducao.RValorEstagio(EEstagio.AInteiro);
    if VprDFracaoFaccionista.ValEstagio <> 0 then
    begin
      EValUnitario.AValor := VprDFracaoFaccionista.ValEstagio;
      EValUnitarioPosterior.AValor := VprDFracaoFaccionista.ValEstagio;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaFracaoFaccionista.EFaccionistaCadastrar(Sender: TObject);
begin
  FNovaFaccionista := TFNovaFaccionista.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaFaccionista'));
  FNovaFaccionista.Faccionistas.Insert;
  FNovaFaccionista.ShowModal;
  FNovaFaccionista.free;
end;

{******************************************************************************}
procedure TFNovaFracaoFaccionista.BCancelarClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFNovaFracaoFaccionista.BCadastrarClick(Sender: TObject);
begin
  if (VprTipoTela = ttNovaFracao) then
    InicializaTela
  else
    if VprTipoTela = ttRetornoFracao then
      InicializaTelaRetorno
    else
      if VprTipoTela = ttdevolucao then
        InicializaTelaDevolucao;
end;

{******************************************************************************}
procedure TFNovaFracaoFaccionista.EFaccionistaExit(Sender: TObject);
var
  VpfResultado : String;
begin
  if (VprOperacao = ocInsercao) and (VprTipoTela in [ttRetornoFracao,ttDevolucao] ) then
  begin
    VpfResultado := CarSeqItemFaccionista;
    if VpfResultado <> '' then
      aviso(VpfREsultado)
    else
      EValUnitario.AValor := VprDRetornoFracao.ValUnitario;
  end;
end;

{******************************************************************************}
procedure TFNovaFracaoFaccionista.EQtdEnviadoExit(Sender: TObject);
begin
  if VprTipoTela = ttRetornoFracao then
  begin
    if (VprOperacao = ocInsercao) and (VprDRetornoFracao.SeqItem <> 0 )  then
      if not Config.PermitirEnviarFracaoMaisde1VezparaoMesmoFaccionista then
        CFinalizar.Checked := ((VprDRetornoFracao.QtdFaltante - EQtdEnviado.AValor) <=0);
  end;
end;

{******************************************************************************}
procedure TFNovaFracaoFaccionista.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFNovaFracaoFaccionista.EFaccionistaSelect(Sender: TObject);
begin
  EFaccionista.ASelectValida.Text := 'Select * from FACCIONISTA ' +
                                     ' Where CODFACCIONISTA = @ ';
  EFaccionista.ASelectLocaliza.text := 'Select * from FACCIONISTA '+
                                       ' Where NOMFACCIONISTA LIKE ''@%''';
  if VprTipoTela = ttNovaFracao then
  begin
    EFaccionista.ASelectValida.Text := EFaccionista.ASelectValida.Text +' and INDATIVA = ''S''';
    EFaccionista.ASelectLocaliza.text := EFaccionista.ASelectLocaliza.text + ' and INDATIVA = ''S''';
  end;
  EFaccionista.ASelectLocaliza.text := EFaccionista.ASelectLocaliza.text + ' order by NOMFACCIONISTA ';
end;

{******************************************************************************}
procedure TFNovaFracaoFaccionista.EFracaoRetorno(Retorno1,
  Retorno2: String);
var
  VpfDProduto : TRBDProduto;
begin
  if (EFilial.AInteiro <> 0) and (EOrdemProducao.AInteiro <> 0) then
  begin
    if ( ttRetornoFracao = VprTipoTela) or
       (ttNovaFracao = VprTipoTela) then
    begin
      VprDOrdemProducao.free;
      VprDOrdemProducao := TRBDOrdemProducao.cria;
      FunOrdemProducao.CarDOrdemProducaoBasica(EFilial.AInteiro,EOrdemProducao.AInteiro,VprDOrdemProducao);

      if (ttNovaFracao = VprTipoTela) then
      begin
        VpfDProduto := TRBDProduto.Cria;
        FunProdutos.CarDProduto(VpfDProduto,Varia.CodigoEmpresa,Varia.CodigoEmpFil,VprDOrdemProducao.SeqProduto);
        EValUnitario.AValor := VpfDProduto.ValPrecoFaccionista;
        EValUnitarioPosterior.AValor := VpfDProduto.ValPrecoFaccionista;
        VpfDProduto.Free;
      end;

      if varia.TipoOrdemProducao = toAgrupada then
      begin

      end
      else
      begin
        EUM.Items.Clear;
        EUM.Items.Assign(FunProdutos.RUnidadesParentes(VprDOrdemProducao.UMPedido));
        EProduto.Text := VprDOrdemProducao.CodProduto;
        LNomProduto.Caption :=  VprDOrdemProducao.NomProduto;
      end;
    end;
  end;

end;

procedure TFNovaFracaoFaccionista.EFilialKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 13 then
    PreencheCodBarras;
end;

procedure TFNovaFracaoFaccionista.BTerceirosClick(Sender: TObject);
begin
  FTerceiroFaccionista := TFTerceiroFaccionista.criarSDI(Application,'',FPrincipal.VerificaPermisao('FTerceiroFaccionista'));
  if FTerceiroFaccionista.CadastraTerceiros(VprDRevisaoFracao) then
  begin
    EQtdEnviado.ReadOnly := true;
    EValUnitario.ReadOnly := true;
    EQtdEnviado.AValor := VprDRevisaoFracao.QtdRevisado;
    EValUnitario.AValor := VprDRevisaoFracao.QtdDefeito;
  end;
  FTerceiroFaccionista.free;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovaFracaoFaccionista]);
end.


