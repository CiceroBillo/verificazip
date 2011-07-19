unit ANovoContasaReceber;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, PainelGradiente, Componentes1, Db, DBTables, DBCtrls, Buttons, Localizacao,
  Grids, DBGrids,  constantes, Spin, UnContasAReceber, DBKeyViolation,
  StdCtrls, Mask, numericos, BotaoCadastro, UnDados, UnDadosCR, FMTBcd, SqlExpr;

type
  TFNovoContasAReceber = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    Label1: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Emissao: TMaskEditColor;
    Label10: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    EFilial: TEditColor;
    ENumeroRecebimento: TEditColor;
    Evalor: TNumerico;
    Panel1: TPanel;
    BotaoGravar1: TBitBtn;
    BotaoCancelar1: TBitBtn;
    Label8: TLabel;
    Localiza: TConsultaPadrao;
    Bevel2: TBevel;
    Tempo: TPainelTempo;
    BFechar: TBitBtn;
    BNovo: TBitBtn;
    Label9: TLabel;
    BVerifica: TBitBtn;
    VerificaCapaLote: TCheckBox;
    Label11: TLabel;
    Label16: TLabel;
    ECliente: TEditLocaliza;
    SpeedButton1: TSpeedButton;
    Numerico1: TNumerico;
    Label21: TLabel;
    EPagamento: TEditLocaliza;
    SpeedButton4: TSpeedButton;
    Label22: TLabel;
    Label18: TLabel;
    ValorCalcular: Tnumerico;
    EMoedas: TEditLocaliza;
    SpeedButton3: TSpeedButton;
    Label2: TLabel;
    Label6: TLabel;
    EQuantidadeParcelas: TNumerico;
    ENota: TNumerico;
    ValidaGravacao1: TValidaGravacao;
    LPlano: TLabel;
    BPlano: TSpeedButton;
    EPlano: TEditColor;
    GeraComissao: TComboBoxColor;
    Label23: TLabel;
    PComissao: TCorPainelGra;
    PSituacao1: TPanelColor;
    BitBtn7: TBitBtn;
    Label7: TLabel;
    EVendedor: TEditLocaliza;
    SpeedButton5: TSpeedButton;
    Label12: TLabel;
    EValorCalcularComissao: Tnumerico;
    EPercComissaoVen: Tnumerico;
    Label25: TLabel;
    Label26: TLabel;
    SpeedButton2: TSpeedButton;
    Label4: TLabel;
    Label27: TLabel;
    EdcFormaPgto: TEditLocaliza;
    SpeedButton6: TSpeedButton;
    Label28: TLabel;
    Aux: TSQLQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BNovoClick(Sender: TObject);
    procedure BVerificaClick(Sender: TObject);
    procedure EditColor4Change(Sender: TObject);
    procedure VerificaCapaLoteClick(Sender: TObject);
    procedure EClienteCadastrar(Sender: TObject);
    procedure EPagamentoSelect(Sender: TObject);
    procedure EMoedasRetorno(Retorno1, Retorno2: String);
    procedure EPagamentoRetorno(Retorno1, Retorno2: String);
    procedure EFilialChange(Sender: TObject);
    procedure EPagamentoCadastrar(Sender: TObject);
    procedure EPlanoExit(Sender: TObject);
    procedure GeraComissaoChange(Sender: TObject);
    procedure EPlanoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BBAjudaClick(Sender: TObject);
    procedure EVendedorRetorno(Retorno1, Retorno2: String);
    procedure BitBtn7Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure BotaoGravar1Click(Sender: TObject);
    procedure BotaoCancelar1Click(Sender: TObject);
    procedure EdcFormaPgtoRetorno(Retorno1, Retorno2: String);
    procedure ENotaExit(Sender: TObject);
    procedure EdcFormaPgtoCadastrar(Sender: TObject);
  private
    capaLote : Double;
    fecharform : boolean;
    TipoFrmPagamento : String;
    VprTransacao : TTransactionDesc;
    procedure LimpaCampos;
    procedure InicializaTela;
    procedure EstadoBotoes(VpaEstado : Boolean);
    function CriaParcelasReceber( var ValorTotal : Double ) : Integer;
  public
    SiglaMonetaria : String;
    procedure atualizaMascaraValor(Sigla : String);
    procedure NovoContasAReceber(VpaCodCliente : Integer);
  end;

var
  FNovoContasAReceber: TFNovoContasAReceber;
implementation

uses ABancos,  ConstMsg,  FunData,   APrincipal, funString, ANovoCliente,
   funsql, APlanoConta, FunObjeto,
  AFormasPagamento, ACondicaoPagamento;

{$R *.DFM}

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      Inicializacao do Formulario e destruição
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{ ****************** Na criação do Formulário ******************************** }
procedure TFNovoContasAReceber.FormCreate(Sender: TObject);
begin
  capaLote := 0;
  FecharForm := false;
  VerificaCapaLote.Checked := config.CapaLote;
  SiglaMonetaria := CurrencyString;
  if not ConfigModulos.Comissao then // caso naum use comissao
  begin
    EVendedor.ACampoObrigatorio := false;
    label23.Visible := false;
    GeraComissao.Visible := false;
    Label7.Visible := false;
    EVendedor.Visible := false;
    SpeedButton5.Visible := false;
    label12.Visible := false;
  end;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovoContasAReceber.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if  FPrincipal.BaseDados.InTransaction then
    FPrincipal.BaseDados.Rollback(VprTransacao);
  CurrencyString := SiglaMonetaria;
  Action := CaFree;
end;

{******************* na inicializacao do formulario ************************* }
procedure TFNovoContasAReceber.FormShow(Sender: TObject);
begin
    if EMoedas.Enabled then
    EMoedas.SetFocus
  else
    if ECliente.Enabled then
      ECliente.SetFocus
    else
      if ENota.Enabled then
        ENota.SetFocus
      else
        if EPlano.Enabled then
          EPlano.SetFocus
end;

{*******************permite atualizar os campos relacionados*******************}
procedure TFNovoContasAReceber.LimpaCampos;
begin
  ECliente.Text := '';
  ECliente.Atualiza;
  EPagamento.Text := '';
  EPagamento.Atualiza;
  EMoedas.Text := '';
  ENota.Text := '';
  EQuantidadeParcelas.text := '';
  emoedas.Atualiza;
  EdcFormaPgto.Text := '';
  EdcFormaPgto.Atualiza;
  EPlano.Text := '';
  LPlano.Caption := '';
  ENumeroRecebimento.Text := '';
  ValorCalcular.AValor := 0;
  GeraComissao.ItemIndex := 0;
  EVendedor.Clear;
  EPercComissaoVen.AValor := 0;
  atualizaMascaraValor(SiglaMonetaria);
  EstadoBotoes(false);
  ValidaGravacao1.execute;
end;

{******************************************************************************}
procedure TFNovoContasAReceber.InicializaTela;
begin
  LimpaCampos;
  EFilial.Text := IntToStr(varia.CodigoEmpFil);
  EMoedas.Text := IntToStr(varia.MoedaBase);
  EMoedas.Atualiza;
  EPlano.Text := Varia.PlanoContasPadraoContasaReceber;
  EPlanoExit(EPlano);
  EPagamento.AInteiro := Varia.CondicaoPagamentoPadrao;
  EPagamento.Atualiza;
  EdcFormaPgto.AInteiro := VARIA.FormaPagamentoPadrao;
  EdcFormaPgto.Atualiza;
  Emissao.Text := DateToStr(date);
  if self.Visible then
    ENota.SetFocus;
end;

{************* verifica campos obrigatorios ********************************** }
procedure TFNovoContasAReceber.EstadoBotoes(VpaEstado : Boolean);
begin
  BNovo.Enabled := VpaEstado;
  BotaoGravar1.Enabled := not VpaEstado;
  BotaoCancelar1.Enabled := not VpaEstado;
  BFechar.enabled := VpaEstado;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      Validação dos campos relacionados
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{************* verifica campos obrigatorios ********************************** }
procedure TFNovoContasAReceber.EFilialChange(Sender: TObject);
begin
  ValidaGravacao1.execute;
end;

{******************Cadastro na Consulta do campo Fornecedores******************}
procedure TFNovoContasAReceber.EClienteCadastrar(Sender: TObject);
begin
  FNovoCliente := TFNovoCliente.CriarSDI(application,'',true);
  FNovoCliente.CadClientes.Insert;
  FNovoCliente.ShowModal;
  Localiza.AtualizaConsulta;
end;

{*************************** Campos de dados da comissao ******************* }
procedure TFNovoContasAReceber.GeraComissaoChange(Sender: TObject);
begin
  if GeraComissao.ItemIndex = 1 then // Sim.
  begin
    EVendedor.ACampoObrigatorio := True;
    EVendedor.Enabled  := True;
    EValorCalcularComissao.AValor := ValorCalcular.AValor;
    PComissao.Visible := true;
    EValorCalcularComissao.SetFocus;
  end
  else
  begin
    EVendedor.ACampoObrigatorio := False;
    EVendedor.Enabled := False;
    EVendedor.Clear;
    PComissao.Visible := false;
  end;
  EFilialChange(Sender);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
              Botoes de Atividade, novo, alterar, parcelas, etc
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{***Quando fechar o formulario verifica o capa de lote e o CadContasaReceber***}
procedure TFNovoContasAReceber.BFecharClick(Sender: TObject);
begin
  if capaLote <> 0 then
    Aviso(CT_VerificaCapaLote)
  else
    Close;
end;

{**************************adiciona uma nova conta*****************************}
procedure TFNovoContasAReceber.BNovoClick(Sender: TObject);
begin
  InicializaTela;
end;

{**********************Cria as parcelas do contas a receber********************}
function TFNovoContasAReceber.CriaParcelasReceber( var ValorTotal : Double ): Integer;
var
  VpfDContasAReceber : TRBDContasCR;
  VpfResultado : String;
begin
  VpfDContasAReceber := TRBDContasCR.Cria;
  VpfDContasAReceber.CodEmpFil := Varia.CodigoEmpFil;
  VpfDContasAReceber.NroNota := ENota.AsInteger;
  VpfDContasAReceber.SeqNota := 0;
  VpfDContasAReceber.SeqParcialCotacao := 0;
  VpfDContasAReceber.CodCondicaoPgto := EPagamento.AInteiro;
  VpfDContasAReceber.CodCliente := ECliente.AInteiro;
  VpfDContasAReceber.CodFrmPagto := EdcFormaPgto.Ainteiro;
  VpfDContasAReceber.CodMoeda :=  EMoedas.AInteiro;
  VpfDContasAReceber.CodUsuario := varia.CodigoUsuario;
  VpfDContasAReceber.DatMov := date;
  VpfDContasAReceber.DatEmissao := StrToDate(Emissao.Text);
  VpfDContasAReceber.PlanoConta := EPlano.text;
  VpfDContasAReceber.ValTotal := ValorCalcular.AValor;
  VpfDContasAReceber.PercentualDesAcr := 0;
  VpfDContasAReceber.MostrarParcelas := true;
  VpfDContasAReceber.IndGerarComissao := true;
  VpfDContasAReceber.CodVendedor := EVendedor.AInteiro;
  if VpfDContasAReceber.CodVendedor <> 0 then
  begin
    VpfDContasAReceber.PerComissao := EPercComissaoVen.AValor;
    VpfDContasAReceber.ValComissao := (EValorCalcularComissao.AValor * VpfDContasAReceber.PerComissao)/100 ;
  end;
  VpfDContasAReceber.TipComissao := 0; // somente direta
  VpfDContasAReceber.EsconderConta := false;

  FunContasAReceber.CriacontasAReceber( VpfDContasAReceber,VpfResultado,true );
  if VpfResultado = '' then
  begin
    Result := VpfDContasAReceber.LanReceber;
    ValorTotal := VpfDContasAReceber.ValTotal;
  end
  else
  begin
    aviso(Vpfresultado);
    result := 0;
  end;
  VpfDContasAReceber.free;
end;

{******************* gravar registro **************************************** }
procedure TFNovoContasAReceber.BotaoGravar1Click(Sender: TObject);
var
  LancamentoCR : integer;
  ValorTotal : Double;
begin
  if ValorCalcular.AValor = 0 then
  begin
    Aviso('Informe um valor para este título.');
    ValorCalcular.SetFocus;
    Abort;
  end;

  if  FPrincipal.BaseDados.InTransaction then
    FPrincipal.BaseDados.Rollback(VprTransacao);

  VprTransacao.IsolationLevel := xilREADCOMMITTED;
  FPrincipal.BaseDados.StartTransaction(VprTransacao);

  Tempo.Execute('Criando as Parcelas...');
  try
    // cria a conta, parcela, comissao
    LancamentoCR := CriaParcelasReceber( ValorTotal );
    ENumeroRecebimento.Text := IntTostr(LancamentoCR);

    FPrincipal.BaseDados.commit(VprTransacao);

    tempo.fecha;
    Estadobotoes(true);
    // capa de lote
    if VerificaCapaLote.Checked then
      Numerico1.AValor := Numerico1.AValor +  ValorTotal;

  except
    FPrincipal.BaseDados.Rollback(VprTransacao);
    aviso('Erro Criando as Parcelas');
    tempo.fecha;
 end;
end;

{***************** cancelar regisdtro **************************************** }
procedure TFNovoContasAReceber.BotaoCancelar1Click(Sender: TObject);
begin
  LimpaCampos;
  EstadoBotoes(TRUE);
end;

{************************ Help *********************************************** }
procedure TFNovoContasAReceber.BBAjudaClick(Sender: TObject);
begin
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          Capa de Lote
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{***********Quando precionado o botao do capa de lote, zerando o mesmo*********}
procedure TFNovoContasAReceber.BVerificaClick(Sender: TObject);
begin
  CapaLote := 0;
  Numerico1.Avalor := CapaLote;
  BVerifica.Kind := bkOk;
  BVerifica.Default := false;
  BVerifica.ModalResult := mrNone;
  BVerifica.Caption := 'Ok';
  BVerifica.Cancel := false;
end;

{*****quando adicionado algo a caixa capa de lote o mesmo muda de situacao*****}
procedure TFNovoContasAReceber.EditColor4Change(Sender: TObject);
begin
  BVerifica.Kind := bkNo;
  BVerifica.ModalResult := mrNone;
  BVerifica.Caption := '&Verificar';
  BVerifica.Cancel := false;
end;

{******************CheckBox que habilita ou não o capa de lote*****************}
procedure TFNovoContasAReceber.VerificaCapaLoteClick(Sender: TObject);
begin
  if VerificaCapaLote.Checked then
  begin
    BVerifica.Enabled := true;
    label9.Enabled := true;
    Numerico1.Enabled := true;
  end
  else
  begin
    BVerifica.Enabled := false;
    label9.Enabled := false;
    Numerico1.Enabled := false;
  end;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                             Ações dos localizas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{****************Carrega a select das condicoes de pagamento*******************}
procedure TFNovoContasAReceber.EPagamentoSelect(Sender: TObject);
begin
   EPagamento.ASelectValida.Add(' select I_Cod_Pag, C_Nom_Pag, I_Qtd_Par From CadCondicoesPagto ' +
                                ' where I_Cod_Pag = @ ');

   EPagamento.ASelectLocaliza.add(' select I_Cod_Pag, C_Nom_Pag, I_Qtd_Par From CadCondicoesPagto ' +
                                  ' where c_Nom_Pag like ''@%'''+
                                  ' order by c_Nom_Pag asc');
end;

{********************* retorno da moeda ************************************ }
procedure TFNovoContasAReceber.EMoedasRetorno(Retorno1,
  Retorno2: String);
begin
   if Retorno1 <> '' then
   begin
      atualizaMascaraValor(retorno1);
   end;
end;

{ ************* retorno da condicao de pagamento **************************** }
procedure TFNovoContasAReceber.EPagamentoRetorno(Retorno1,
  Retorno2: String);
begin
  if retorno1 <> '' then
    EQuantidadeParcelas.AValor := StrToInt(retorno1);
end;

{********************* rcadastrar Pagamentos ********************************* }
procedure TFNovoContasAReceber.EPagamentoCadastrar(Sender: TObject);
begin
  FCondicaoPagamento := TFCondicaoPagamento.criarSDI(Application,'',FPrincipal.VerificaPermisao('FCondicaoPagamento'));
  FCondicaoPagamento.ShowModal;
  FCondicaoPagamento.free;
  Localiza.AtualizaConsulta;
end;

{**************** Plano de Contas ******************************************* }
procedure TFNovoContasAReceber.EPlanoExit(Sender: TObject);
var
  VpfCodigo : string;
begin
  FPlanoConta := TFPlanoConta.criarSDI(Self, '', True);
  VpfCodigo := EPlano.text;
  if not FPlanoConta.verificaCodigo(VpfCodigo, 'C', LPlano, False, (Sender is TSpeedButton)) then
    EPlano.SetFocus;
  EPlano.text := VpfCodigo;
end;

{****************** botao do plano de contas ******************************** }
procedure TFNovoContasAReceber.EPlanoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = 114 then
    BPlano.Click;
end;

{************** retorno do vendedor ****************************************** }
procedure TFNovoContasAReceber.EVendedorRetorno(Retorno1,
  Retorno2: String);
begin
  if Retorno1 <> '' then
    EPercComissaoVen.AValor := StrToFloat(Retorno1);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{***********************Atualiza a mascara dos valores*************************}
procedure TFNovoContasAReceber.atualizaMascaraValor(Sigla : String);
begin
  CurrencyString := sigla;
  Varia.MascaraMoeda :=  Varia.MascaraValor;
  Numerico1.AMascara :=  Varia.MascaraValor + '; -'+  ' ' + Varia.MascaraValor;
  ValorCalcular.AMascara := Varia.MascaraValor + '; -'+ ' ' + Varia.MascaraValor;
  Evalor.AMascara := Varia.MascaraValor + '; -'+ Varia.MascaraValor;
end;

{******************************************************************************}
procedure TFNovoContasAReceber.NovoContasAReceber(VpaCodCliente : Integer);
begin
  InicializaTela;
  ECliente.AInteiro := VpaCodCliente;
  ECliente.Atualiza;
  showmodal;
end;

{******************* Ok do painel do vendedor ******************************** }
procedure TFNovoContasAReceber.BitBtn7Click(Sender: TObject);
begin
 PComissao.Visible := false;
end;

{************************ F5 para cadastrar ********************************* }
procedure TFNovoContasAReceber.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if BNovo.Enabled then
   if key = 116 then
     BNovo.Click;
end;


procedure TFNovoContasAReceber.EdcFormaPgtoRetorno(Retorno1,
  Retorno2: String);
begin
  if Retorno1 <> '' then
    TipoFrmPagamento := retorno1;

  if Retorno2 = 'N' then
  begin
    if GeraComissao.Visible then
      ActiveControl := GeraComissao
    else
      ActiveControl := Emissao;
  end;
end;

{******************************************************************************}
procedure TFNovoContasAReceber.ENotaExit(Sender: TObject);
begin
   aux.close;
   if (ENota.Text <> '') then  // verifica se exixte o nro da not, forn, e filial ja cadastrado no CP.
   begin
     AdicionaSQLAbreTabela(aux, 'select * from CadContasaReceber where I_EMP_FIL = ' + IntToStr(varia.CodigoEmpFil) +
                                ' and I_NRO_NOT = ' + ENota.Text  );
   end;
   if not (aux.EOF) then
     if not confirmacao(' Já existe uma Nota Fiscal Cadastrada no Contas a Receber com o Nº ' +  ENota.Text +
                        ' Continuar cadastro ? ' ) then
       ENota.SetFocus;
   FechaTabela(aux);
end;

{******************************************************************************}
procedure TFNovoContasAReceber.EdcFormaPgtoCadastrar(Sender: TObject);
begin
  FFormasPagamento := TFFormasPagamento.CriarSDI(Application,'',FPrincipal.VerificaPermisao('FFormasPagamento'));
  FFormasPagamento.BotaoCadastrar1.Click;
  FFormasPagamento.ShowModal;
  FFormasPagamento.free;
end;

Initialization
  RegisterClasses([TFNovoContasAReceber]);
end.

