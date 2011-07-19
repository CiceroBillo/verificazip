unit ANovoContasaPagar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, PainelGradiente, Componentes1, Db, DBTables, Tabela, StdCtrls,
  DBCtrls, BotaoCadastro, Buttons, Localizacao, UnDados,
  Grids, DBGrids, constantes, Mask, DBKeyViolation, LabelCorMove,
  Spin, EditorImagem, numericos, unContasaPagar, UnDespesas, UnDadosCR, UnClientes,
  FMTBcd, SqlExpr, ComCtrls, CGrades, UnDadosLocaliza;

type
  TFNovoContasAPagar = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    Localiza: TConsultaPadrao;
    Imagem: TEditorImagem;
    ValidaGravacao: TValidaGravacao;
    Aux: TSQLQuery;
    PanelColor2: TPanelColor;
    BFechar: TBitBtn;
    BotaoGravar1: TBitBtn;
    BNovo: TBitBtn;
    BotaoCancelar1: TBitBtn;
    PanelColor1: TPanelColor;
    Paginas: TPageControl;
    PGeral: TTabSheet;
    PanelColor3: TPanelColor;
    PCabecalho: TPanelColor;
    Label1: TLabel;
    Label3: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    LNomFornecedor: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Label2: TLabel;
    Label6: TLabel;
    LPlano: TLabel;
    BPlano: TSpeedButton;
    Label11: TLabel;
    SpeedButton2: TSpeedButton;
    Label17: TLabel;
    Label12: TLabel;
    Label10: TLabel;
    LParcelas: TLabel;
    EFilial: TEditColor;
    ELanPagar: TEditColor;
    EFornecedor: TEditLocaliza;
    EMoeda: TEditLocaliza;
    ENota: Tnumerico;
    Tempo: TPainelTempo;
    EPlano: TEditColor;
    ECentroCusto: TEditLocaliza;
    ECodBarras: TEditColor;
    EValorparcelas: Tnumerico;
    EValorTotal: Tnumerico;
    PRodape: TPanelColor;
    Label5: TLabel;
    LFoto: TLabel;
    Label20: TLabel;
    SpeedButton4: TSpeedButton;
    Label7: TLabel;
    Label4: TLabel;
    SpeedButton5: TSpeedButton;
    Label9: TLabel;
    EDataEmissao: TMaskEditColor;
    EdcFormaPgto: TEditLocaliza;
    BFoto: TBitBtn;
    EContaCaixa: TEditLocaliza;
    CBaixarConta: TCheckBox;
    PProjeto: TPanelColor;
    Label16: TLabel;
    SpeedButton6: TSpeedButton;
    LNomProjeto: TLabel;
    EProjeto: TRBEditLocaliza;
    PaginaProjeto: TTabSheet;
    GProjetos: TRBStringGridColor;
    BAutorizacaoPagamento: TBitBtn;
    EConsultaProjeto: TRBEditLocaliza;
    ECondicaoPagamento: TRBEditLocaliza;
    Label18: TLabel;
    SpeedButton7: TSpeedButton;
    Label8: TLabel;
    CDespesaPrevista: TCheckBox;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBEditButton4Exit(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure BNovoClick(Sender: TObject);
    procedure EFornecedorCadastrar(Sender: TObject);
    procedure DBEditColor20Exit(Sender: TObject);
    procedure EValorparcelasExit(Sender: TObject);
    procedure EFilialChange(Sender: TObject);
    procedure EdcFormaPgtoCadastrar(Sender: TObject);
    procedure EPlanoExit(Sender: TObject);
    procedure EPlanoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BotaoGravar1Click(Sender: TObject);
    procedure BotaoCancelar1Click(Sender: TObject);
    procedure EFornecedorAlterar(Sender: TObject);
    procedure ECentroCustoCadastrar(Sender: TObject);
    procedure BFotoClick(Sender: TObject);
    procedure EdcFormaPgtoRetorno(Retorno1, Retorno2: String);
    procedure CBaixarContaClick(Sender: TObject);
    procedure ECodBarrasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EFornecedorRetorno(Retorno1, Retorno2: String);
    procedure EDataEmissaoExit(Sender: TObject);
    procedure EProjetoCadastrar(Sender: TObject);
    procedure BAutorizacaoPagamentoClick(Sender: TObject);
    procedure GProjetosCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GProjetosDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure GProjetosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GProjetosKeyPress(Sender: TObject; var Key: Char);
    procedure GProjetosMudouLinha(Sender: TObject; VpaLinhaAtual, VpaLinhaAnterior: Integer);
    procedure GProjetosNovaLinha(Sender: TObject);
    procedure GProjetosSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure EConsultaProjetoRetorno(VpaColunas: TRBColunasLocaliza);
    procedure EProjetoFimConsulta(Sender: TObject);
    procedure PaginasChange(Sender: TObject);
    procedure ECondicaoPagamentoCadastrar(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    VprDContasAPagar : TRBDContasaPagar;
    VprDatEmissao :TDAteTime;
    VprAcao : Boolean;
    VprPressionadoR,
    VprEsconderParcela : Boolean;
    VprContaCaixa : String;
    VprDCliente : TRBDCliente;
    VprDDespesaProjeto : TRBDContasaPagarProjeto;
    VprTransacao : TTransactionDesc;
    procedure CarDClasse;
    function DadosValidos : string;
    procedure InicializaTela;
    procedure AlteraEstadoBotoes(VpaEstado : Boolean);
    procedure InterpretaCodigoBarras;
    procedure ConfiguraTela;
    procedure AdicionaDespesaProjeto;
    procedure CarTitulosGrade;
    procedure CarDProjetoClasse;
    procedure CarValoresGrade;
    procedure CalculaValorDespesaPeloPercentual;
    procedure CalculaPercentualDespesaPeloValor;
  public
    function NovoContasaPagar(VpaCodFornecedor : Integer) : Boolean;
  end;

var
  FNovoContasAPagar: TFNovoContasAPagar;

implementation

uses ConstMsg,  FunData, APrincipal, funString,
  ANovoCliente, funObjeto, funsql, AFormasPagamento, FunNumeros,
  ADespesas, APlanoConta,  UnClassesImprimir, ACentroCusto, AProjetos, dmRave, UnSistema,
  ACondicaoPagamento, ANovaCondicaoPagamento, AContasAReceber;

{$R *.DFM}

{**************************Na criação do Formulário****************************}
procedure TFNovoContasAPagar.FormCreate(Sender: TObject);
begin
  VprPressionadoR := false;
  VprEsconderParcela := false;
  VprDCliente := TRBDCliente.cria;
  VprDContasAPagar := TRBDContasaPagar.cria;
  VprAcao := false;
  VprDatEmissao := date;

  EDataEmissao.EditMask := FPrincipal.CorFoco.AMascaraData;
  ConfiguraTela;
  CarTitulosGrade;
end;

{**********************Quando o formulario e fechado***************************}
procedure TFNovoContasAPagar.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if FPrincipal.BaseDados.InTransaction then
    FPrincipal.BaseDados.Rollback(VprTransacao);
  VprDContasAPagar.free;
  VprDCliente.free;
  Action := CaFree;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                             Ações de Inicialização
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFNovoContasAPagar.CarDClasse;
begin
  VprDContasAPagar.CodFilial := Varia.CodigoEmpFil;
  VprDContasAPagar.NumNota := ENota.AsInteger;
  VprDContasAPagar.SeqNota := 0;
  VprDContasAPagar.CodFornecedor := EFornecedor.AInteiro;
  VprDContasAPagar.CodBarras := ECodBarras.Text;
  VprDContasAPagar.NomFornecedor := LNomFornecedor.Caption;
  VprDContasAPagar.CodCentroCusto := ECentroCusto.AInteiro;
  VprDContasAPagar.CodFormaPagamento :=  EdcFormaPgto.AInteiro;
  VprDContasAPagar.CodMoeda := EMoeda.AInteiro;
  VprDContasAPagar.CodUsuario := varia.CodigoUsuario;
  VprDContasAPagar.DatEmissao := StrToDate(EDataEmissao.Text);
  VprDContasAPagar.CodPlanoConta := EPlano.text;
  VprDContasAPagar.NumContaCaixa := EContaCaixa.Text;
  VprDContasAPagar.DesPathFoto := LFoto.Caption;
  VprDContasAPagar.CodCondicaoPagamento := ECondicaoPagamento.AInteiro;
  if EValorparcelas.AValor = 0 then
  begin
    VprDContasAPagar.ValParcela :=ArredondaDecimais(EValorTotal.AValor / sistema.RQtdParcelasCondicaoPagamento(ECondicaoPagamento.AInteiro),2);
    VprDContasAPagar.ValTotal := EValorTotal.AValor;
  end
  else
  begin
    VprDContasAPagar.ValParcela := EValorparcelas.AValor;
    VprDContasAPagar.ValTotal := EValorparcelas.AValor * sistema.RQtdParcelasCondicaoPagamento(ECondicaoPagamento.AInteiro);
  end;
  VprDContasAPagar.PerDescontoAcrescimo := 0;
  VprDContasAPagar.IndMostrarParcelas :=  true;
  VprDContasAPagar.IndEsconderConta := VprEsconderParcela;
  VprDContasAPagar.IndBaixarConta := CBaixarConta.Checked;
  VprDContasAPagar.IndDespesaPrevista := CDespesaPrevista.Checked;
  VprContaCaixa := EContaCaixa.Text;

end;

{******************************************************************************}
procedure TFNovoContasAPagar.CarDProjetoClasse;
begin
  if VprDDespesaProjeto.PerDespesa <> StrToFloat(DeletaChars(DeletaChars(GProjetos.Cells[3,GProjetos.ALinha],'.'),'%')) then
  begin
    CalculaValorDespesaPeloPercentual;
  end
  else
    if VprDDespesaProjeto.ValDespesa <> StrToFloat(DeletaChars(GProjetos.Cells[4,GProjetos.ALinha],'.')) then
    begin
      CalculaPercentualDespesaPeloValor;
    end;
  CarValoresGrade;
end;

{******************************************************************************}
function TFNovoContasAPagar.DadosValidos : string;
begin
  result := '';
  if EValorTotal.avalor = 0 then
    EValorTotal.AValor := EValorParcelas.AValor * Sistema.RQtdParcelasCondicaoPagamento(ECondicaoPagamento.AInteiro);
  if EValorTotal.AValor = 0 then
  begin
    result := 'VALOR DO TÍTULO NÃO PREENCHIDO!!!'#13'É necessário informar um valor para o título.';
    EValorTotal.SetFocus;
  end;
  if result = '' then
  begin
    if CBaixarConta.Checked and (EContaCaixa.Text = '') then
    begin
      Result := 'CONTA CAIXA NÃO PREENCHIDO!!!'#13'É necessário preencher a conta caixa na baixa automatica.';
    end;
  end;
  if config.ControlarProjeto then
  begin
    if VprDContasAPagar.DespesaProjeto.Count > 0  then
      result  := FunContasAPagar.ValorProjetosMaiorQueContasaPagar(VprDContasAPagar,EValorTotal.avalor);
  end;

end;

{*******************permite atualizar os campos relacionados*******************}
procedure TFNovoContasAPagar.InicializaTela;
begin
  VprDContasAPagar.free;
  VprDContasAPagar := TRBDContasaPagar.cria;
  GProjetos.ADados := VprDContasAPagar.DespesaProjeto;
  GProjetos.CarregaGrade;
  VprDCliente.Free;
  VprDCliente := TRBDCliente.cria;
  PanelColor3.Enabled := true;
  LimpaComponentes(PanelColor3,0);
  LPlano.Caption := '';
  EMoeda.Text := IntTostr(Varia.MoedaBase);
  EMoeda.Atualiza;
  ECentroCusto.AInteiro := varia.CentroCustoPadrao;
  ECentroCusto.Atualiza;
  EContaCaixa.Text := VprContaCaixa;
  EContaCaixa.Atualiza;
  EFilial.Text := IntTostr(Varia.CodigoEmpFil);  // adiciona o codigo da filial
  EDataEmissao.Text := dateTostr(VprDatEmissao);      // valida campo data
  AlteraEstadoBotoes(true);
  ValidaGravacao.execute;
  Paginas.ActivePage := PGeral;
  ActiveControl := ECodBarras;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Chamadas para telas de Cadastros
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************Cadastro na Consulta do campo Fornecedores******************}
procedure TFNovoContasAPagar.EFornecedorCadastrar(Sender: TObject);
begin
  FNovoCliente := TFNovoCliente.CriarSDI(application,'',true);
  FNovoCliente.CadClientes.Insert;
  FNovoCliente.CadClientesC_IND_FOR.AsString := 'S';
  FNovoCliente.CadClientesC_IND_CLI.AsString := 'N';
  FNovoCliente.ShowModal;
  Localiza.AtualizaConsulta;
end;

{*****************Cadastra uma nova forma de Pagamento*************************}
procedure TFNovoContasAPagar.EdcFormaPgtoCadastrar(Sender: TObject);
begin
  FFormasPagamento := TFFormasPagamento.CriarSDI(Application,'',FPrincipal.VerificaPermisao('FFormasPagamento'));
  FFormasPagamento.BotaoCadastrar1.Click;
  FFormasPagamento.ShowModal;
  Localiza.AtualizaConsulta;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      Validação dos campos relacionados
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{*************************valida o numero da nota fiscal***********************}
procedure TFNovoContasAPagar.DBEditButton4Exit(Sender: TObject);
begin
   aux.close;
   if (ENota.Text <> '') and (Efornecedor.Text <> '' ) then  // verifica se exixte o nro da not, forn, e filial ja cadastrado no CP.
   begin
     AdicionaSQLAbreTabela(aux, 'select I_NRO_NOT from CADCONTASAPAGAR '+
                                ' where I_EMP_FIL = ' + IntToStr(varia.CodigoEmpFil) +
                                ' and I_NRO_NOT = ' + ENota.Text +
                                ' and I_COD_CLI = ' + EFornecedor.Text);
     if not (aux.EOF) then
       if confirmacao(' Já existe uma Nota Fiscal Cadastrada no Contas a Pagar com o Nº ' +  ENota.Text + ' do Fornecedor  "' +
                     LNomFornecedor.Caption  + '". Deseja cancelar  o cadastro ? ' ) then
         BotaoCancelar1.Click
   end;
   aux.close;
end;


{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                       Validação dos campos Gerais
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{*****************caso o valor total > 0 zera o valor das parcelas*************}
procedure TFNovoContasAPagar.DBEditColor20Exit(Sender: TObject);
begin
  if (EValorTotal.avalor > 0) then
    EValorParcelas.AValor := 0;
end;

{******************caso o valor da parcela > 0 zera o valor total**************}
procedure TFNovoContasAPagar.EValorparcelasExit(Sender: TObject);
begin
if (EValorParcelas.AValor > 0) then
   EValorTotal.AValor := 0;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
              Botoes de Atividade, novo, alterar, parcelas, etc
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{****Qunado fechar o formulario verifica o capa de lote e o CadContasaPagar****}
procedure TFNovoContasAPagar.BFecharClick(Sender: TObject);
begin
  close;
end;

{***************************adiciona uma nova conta****************************}
procedure TFNovoContasAPagar.BNovoClick(Sender: TObject);
begin
  InicializaTela;
  if Self.Visible then
    ECodBarras.SetFocus;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
function TFNovoContasAPagar.NovoContasaPagar(VpaCodFornecedor : Integer) : Boolean;
begin
  InicializaTela;
  EFornecedor.AInteiro := VpaCodFornecedor;
  EFornecedor.Atualiza;
  if VpaCodFornecedor <> 0 then
    ActiveControl := ENota;
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
procedure TFNovoContasAPagar.PaginasChange(Sender: TObject);
begin
  if Paginas.ActivePage = PaginaProjeto then
    GProjetos.CarregaGrade;
end;

{******************************************************************************}
procedure TFNovoContasAPagar.AlteraEstadoBotoes(VpaEstado : Boolean);
begin
  BNovo.Enabled := not VpaEstado;
  BFechar.Enabled := not VpaEstado;
  BotaoCancelar1.Enabled := VpaEstado;
  BotaoGravar1.Enabled := VpaEstado;
  BAutorizacaoPagamento.Enabled := not VpaEstado;
end;

{******************************************************************************}
procedure TFNovoContasAPagar.InterpretaCodigoBarras;
begin
  if length(ECodBarras.Text)>=20 then
  begin
    FunContasAPagar.InterpretaCodigoBarras(VprDContasAPagar,ECodBarras.Text);
    EValorTotal.AValor := VprDContasAPagar.ValBoleto;
    EdcFormaPgto.AInteiro := VprDContasAPagar.CodFormaPagamento;
    EdcFormaPgto.Atualiza;
    EFornecedor.AInteiro := VprDContasAPagar.CodFornecedor;
    EFornecedor.Atualiza;
  end;
  if EFornecedor.AInteiro = 0 then
    ActiveControl := EFornecedor
  else
    ActiveControl := ENota;
end;

{ ***************** valida a gravacao dos registros *********************** }
procedure TFNovoContasAPagar.ConfiguraTela;
begin
  PaginaProjeto.TabVisible := Config.ControlarProjeto;
  PProjeto.Visible := Config.ControlarProjeto;
  if not config.ControlarProjeto then
    self.Height := self.Height -24 ;
end;

{ ***************** valida a gravacao dos registros *********************** }
procedure TFNovoContasAPagar.AdicionaDespesaProjeto;
var
  VpfDDespesaProjeto : TRBDContasaPagarProjeto;
begin
  if config.ControlarProjeto then
  begin
    if EProjeto.AInteiro = 0 then
    begin
      if VprDContasAPagar.DespesaProjeto.Count = 1 then
      begin
        if TRBDContasaPagarProjeto(VprDContasAPagar.DespesaProjeto.Items[0]).CodProjeto = VprDContasAPagar.CodProjeto then
          FreeTObjectsList(VprDContasAPagar.DespesaProjeto);
      end;
    end
    else
    begin
      FreeTObjectsList(VprDContasAPagar.DespesaProjeto);
      VpfDDespesaProjeto := VprDContasAPagar.addDespesaProjeto;
      VpfDDespesaProjeto.CodProjeto := EProjeto.AInteiro;
      VpfDDespesaProjeto.NomProjeto := LNomProjeto.Caption;
      VpfDDespesaProjeto.PerDespesa := 100;
      if EValorparcelas.AValor <> 0 then
        VpfDDespesaProjeto.ValDespesa := EValorparcelas.AValor * Sistema.RQtdParcelasCondicaoPagamento(ECondicaoPagamento.AInteiro)
      else
        VpfDDespesaProjeto.ValDespesa := EValorTotal.AValor;
    end;
    VprDContasAPagar.CodProjeto := EProjeto.AInteiro;
  end;
end;

{***************************************************************************}
procedure TFNovoContasAPagar.CarTitulosGrade;
begin
  GProjetos.Cells[1,0] := 'Código';
  GProjetos.Cells[2,0] := 'Projeto';
  GProjetos.Cells[3,0] := 'Percentual';
  GProjetos.Cells[4,0] := 'Valor';
end;

{******************************************************************************}
procedure TFNovoContasAPagar.CarValoresGrade;
begin
  GProjetos.Cells[3,GProjetos.ALinha]:= FormatFloat('0.00 %',VprDDespesaProjeto.PerDespesa);
  GProjetos.Cells[4,GProjetos.ALinha]:= FormatFloat('#,###,###,##0.00',VprDDespesaProjeto.ValDespesa);
end;

{******************************************************************************}
procedure TFNovoContasAPagar.CalculaPercentualDespesaPeloValor;
var
  VpfValContasAPagar : Double;
begin
  if EValorTotal.AValor <> 0  then
    VpfValContasAPagar := EValorTotal.AValor
  else
    VpfValContasAPagar := EValorparcelas.AValor * Sistema.RQtdParcelasCondicaoPagamento(ECondicaoPagamento.AInteiro);
  if VpfValContasAPagar > 0  then
  begin
    VprDDespesaProjeto.ValDespesa := StrToFloat(DeletaChars(GProjetos.Cells[4,GProjetos.ALinha],'.'));
    VprDDespesaProjeto.PerDespesa :=  (VprDDespesaProjeto.ValDespesa *100)/VpfValContasAPagar;
  end;
end;

{******************************************************************************}
procedure TFNovoContasAPagar.CalculaValorDespesaPeloPercentual;
var
  VpfValContasAPagar : Double;
begin
  if EValorTotal.AValor <> 0  then
    VpfValContasAPagar := EValorTotal.AValor
  else
    VpfValContasAPagar := EValorparcelas.AValor * Sistema.RQtdParcelasCondicaoPagamento(ECondicaoPagamento.AInteiro);
  if VpfValContasAPagar > 0  then
  begin
    VprDDespesaProjeto.PerDespesa := StrToFloat(DeletaChars(DeletaChars(GProjetos.Cells[3,GProjetos.ALinha],'.'),'%'));
    VprDDespesaProjeto.ValDespesa := VpfValContasAPagar * (VprDDespesaProjeto.PerDespesa / 100);
  end;
end;

{ ***************** valida a gravacao dos registros *********************** }
procedure TFNovoContasAPagar.EFilialChange(Sender: TObject);
begin
  if BotaoGravar1 <> nil then
  begin
     ValidaGravacao.execute;
  end;
end;

{******************************************************************************}
procedure TFNovoContasAPagar.EPlanoExit(Sender: TObject);
var
  VpfCodigo : string;
begin
  FPlanoConta := TFPlanoConta.criarSDI(Self, '', True);
  VpfCodigo := EPlano.Text;
  if not FPlanoConta.verificaCodigo(VpfCodigo, 'D', LPlano, False, (Sender is TSpeedButton)) then
    EPlano.SetFocus;
  EPlano.text := VpfCodigo;
end;

{******************************************************************************}
procedure TFNovoContasAPagar.EPlanoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 114 then
    BPlano.Click;
end;

{************************************************************************************}
procedure TFNovoContasAPagar.EProjetoCadastrar(Sender: TObject);
begin
  FProjetos := tFProjetos.CriarSDI(self,'',true);
  FProjetos.BotaoCadastrar1.Click;
  FProjetos.ShowModal;
  FProjetos.free;
end;

{************************************************************************************}
procedure TFNovoContasAPagar.EProjetoFimConsulta(Sender: TObject);
begin
  if EProjeto.AInteiro <> VprDContasAPagar.CodProjeto then
  begin
    AdicionaDespesaProjeto;
  end;
end;

{************************************************************************************}
procedure TFNovoContasAPagar.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift = [ssCtrl,ssAlt])  then
  begin
    if (key = 82) then
      VprPressionadoR := true
    else
      if VprPressionadoR then
        if (key = 87) then
        begin
          if BotaoGravar1.Enabled then
          begin
            VprEsconderParcela := true;
            BotaoGravar1.Click;
            VprEsconderParcela := false;
            VprPressionadoR := false;
          end;
        end
        else
          VprPressionadoR := false;
  end;

end;

{******************************************************************************}
procedure TFNovoContasAPagar.GProjetosCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
begin
  VprDDespesaProjeto := TRBDContasaPagarProjeto(VprDContasAPagar.DespesaProjeto.Items[VpaLinha-1]);
  if VprDDespesaProjeto.CodProjeto <> 0 then
    GProjetos.Cells[1,VpaLinha]:= InttoStr(VprDDespesaProjeto.CodProjeto)
  else
    GProjetos.Cells[1,VpaLinha]:= '';
  GProjetos.Cells[2,VpaLinha]:= VprDDespesaProjeto.NomProjeto;
  CarValoresGrade;
end;

{******************************************************************************}
procedure TFNovoContasAPagar.GProjetosDadosValidos(Sender: TObject; var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if not EConsultaProjeto.AExisteCodigo(GProjetos.Cells[1,GProjetos.ALinha]) then
  begin
    VpaValidos := false;
    aviso('PROJETO NÃO CADASTRADO!!!'#13'O projeto digitado não existe cadastrado.');
    GProjetos.Col := 1;
  end
  else
    if (DeletaChars(DeletaChars(DeletaChars(GProjetos.Cells[3,GProjetos.ALinha],'%'),'0'),' ') = '') then
    begin
      VpaValidos := false;
      aviso('PERCENTUAL NÃO PREENCHIDO!!!'#13'É necessário digitar o percentual da despesa no projeto.');
      GProjetos.Col := 3;
    end
    else
      if (DeletaChars(DeletaChars(GProjetos.Cells[4,GProjetos.ALinha],'0'),' ') = '') then
      begin
        VpaValidos := false;
        aviso('VALOR NÃO PREENCHIDO!!!'#13'É necessário digitar o valor da despesa no projeto.');
        GProjetos.Col := 4;
      end;
  if VpaValidos then
  begin
    CarDProjetoClasse;
    if VprDDespesaProjeto.PerDespesa = 0  then
    begin
      VpaValidos := false;
      aviso('PERCENTUAL NÃO PREENCHIDO!!!'#13'É necessário digitar o percentual da despesa no projeto.');
      GProjetos.Col := 3;
    end
    else
      if VprDDespesaProjeto.ValDespesa = 0  then
      begin
        VpaValidos := false;
        aviso('VALOR NÃO PREENCHIDO!!!'#13'É necessário digitar o valor da despesa no projeto.');
        GProjetos.Col := 4;
      end;
  end;
  if Vpavalidos then
  begin
    if FunContasAPagar.ProjetoDuplicado(VprDContasAPagar) then
    begin
      vpaValidos := false;
      aviso('PROJETO DUPLICADO!!!'#13'Esse projeto já foi digitado.');
      GProjetos.Col := 1;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoContasAPagar.GProjetosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case key of
    114 :
    begin
      case GProjetos.AColuna of
        1: EConsultaProjeto.AAbreLocalizacao;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoContasAPagar.GProjetosKeyPress(Sender: TObject; var Key: Char);
begin
  if (key = '.') and  not(GProjetos.col in [3,4]) then
    key := DecimalSeparator;
end;

procedure TFNovoContasAPagar.GProjetosMudouLinha(Sender: TObject; VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDContasAPagar.DespesaProjeto.Count >0 then
    VprDDespesaProjeto := TRBDContasaPagarProjeto(VprDContasAPagar.DespesaProjeto.Items[VpaLinhaAtual-1]);
end;

procedure TFNovoContasAPagar.GProjetosNovaLinha(Sender: TObject);
begin
  VprDDespesaProjeto := VprDContasAPagar.addDespesaProjeto;
  VprDDespesaProjeto.PerDespesa := FunContasAPagar.RPercentualProjetoFaltante(VprDContasAPagar);
  CarValoresGrade;
  CalculaValorDespesaPeloPercentual;
  CarValoresGrade;
end;

procedure TFNovoContasAPagar.GProjetosSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
begin
  if GProjetos.AEstadoGrade in [egInsercao,EgEdicao] then
  begin
    if GProjetos.AColuna <> ACol then
    begin
      case GProjetos.AColuna of
        1 :if not EConsultaProjeto.AExisteCodigo(GProjetos.Cells[1,GProjetos.ALinha]) then
           begin
             if not EConsultaProjeto.AAbreLocalizacao then
             begin
               GProjetos.Cells[1,GProjetos.ALinha] := '';
               abort;
             end;
           end;
        3 : if VprDDespesaProjeto.PerDespesa <> StrToFloat(DeletaChars(DeletaChars(GProjetos.Cells[3,GProjetos.ALinha],'.'),'%')) then
            begin
              CalculaValorDespesaPeloPercentual;
              CarValoresGrade;
            end;
        4 : if VprDDespesaProjeto.ValDespesa <> StrToFloat(DeletaChars(GProjetos.Cells[4,GProjetos.ALinha],'.')) then
            begin
              CalculaPercentualDespesaPeloValor;
              CarValoresGrade;
            end;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoContasAPagar.BotaoGravar1Click(Sender: TObject);
var
  vpfResultado : String;
begin
  vpfResultado := DadosValidos;
  Tempo.execute('Criando as Parcelas...');
  if vpfResultado = '' then
  begin
    CarDClasse;
    if not FPrincipal.BaseDados.InTransaction then
    begin
//      VprTransacao.IsolationLevel := xilREADCOMMITTED;
//      FPrincipal.Basedados.StartTransaction(VprTransacao);
    end;
    vpfResultado := FunContasAPagar.CriaContaPagar(VprDContasAPagar,VprDCliente);
    if vpfResultado = '' then
    begin
      ELanPagar.AInteiro := VprDContasAPagar.LanPagar;
      EValorTotal.AValor := VprDContasAPagar.ValTotal;
    end;
  end;
  Tempo.Fecha;

  if vpfResultado = '' then
  begin
    if FPrincipal.BaseDados.InTransaction then
      FPrincipal.BaseDados.Commit(VprTransacao);
    AlteraEstadoBotoes(false);
    VprAcao := true;
  end
  else
  begin
    if FPrincipal.BaseDados.InTransaction then
      FPrincipal.BaseDados.Rollback(VprTransacao);
    aviso(vpfResultado);
  end;
end;

{******************************************************************************}
procedure TFNovoContasAPagar.BotaoCancelar1Click(Sender: TObject);
begin
  if confirmacao('Tem certeza que deseja cancelar a digitação do Contas a Pagar?') then
  begin
    AlteraEstadoBotoes(false);
    PanelColor3.Enabled := false;
  end;
end;

{******************************************************************************}
procedure TFNovoContasAPagar.EFornecedorAlterar(Sender: TObject);
begin
  if EFornecedor.ALocaliza.Loca.Tabela.FieldByName(EFornecedor.AInfo.CampoCodigo).AsInteger <> 0 then
  begin
    FNovoCliente := TFNovoCliente.CriarSDI(application,'', FPrincipal.VerificaPermisao('FNovoCliente'));
    AdicionaSQlAbreTabela(FNovoCliente.CadClientes,'Select * from CadClientes '+
                                                   ' Where I_COD_CLI = '+EFornecedor.ALocaliza.Loca.Tabela.FieldByName(EFornecedor.AInfo.CampoCodigo).asString);
    FNovoCliente.CadClientes.Edit;
    FNovoCliente.ShowModal;
    FNovoCliente.Free;
  end;
end;

{******************************************************************************}
procedure TFNovoContasAPagar.ECentroCustoCadastrar(Sender: TObject);
begin
  FCentroCusto := TFCentroCusto.CriarSDI(self,'',FPrincipal.VerificaPermisao('FCentroCusto'));
  FCentroCusto.BotaoCadastrar1.Click;
  FCentroCusto.Showmodal;
  FCentroCusto.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovoContasAPagar.BFotoClick(Sender: TObject);
begin
  if Imagem.execute(varia.DriveFoto) then
    LFoto.Caption := Imagem.PathImagem;
end;

procedure TFNovoContasAPagar.BitBtn1Click(Sender: TObject);
begin
  FContasaReceber := TFContasaReceber.criarSDI(Application,'',FPrincipal.VerificaPermisao('FContasaReceber'));
  FContasaReceber.showmodal;
  FContasaReceber.free;
end;

{******************************************************************************}
procedure TFNovoContasAPagar.BAutorizacaoPagamentoClick(Sender: TObject);
begin
  dtRave := TdtRave.Create(self);
  dtRave.ImprimeAutorizacaoPagamento(VprDContasAPagar.CodFilial,VprDContasAPagar.LanPagar,0,Date,date);
  dtRave.free;
end;

{******************************************************************************}
procedure TFNovoContasAPagar.EdcFormaPgtoRetorno(Retorno1,
  Retorno2: String);
begin
  CBaixarConta.Enabled := Retorno2 = 'S';
  if not CBaixarConta.Enabled then
    CBaixarConta.Checked := false;
end;

{******************************************************************************}
procedure TFNovoContasAPagar.CBaixarContaClick(Sender: TObject);
begin
  EContaCaixa.ACampoObrigatorio := CBaixarConta.Checked;
  ValidaGravacao.execute;
end;

{******************************************************************************}
procedure TFNovoContasAPagar.ECodBarrasKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 13 then
    InterpretaCodigoBarras;
end;

{***************************************************************************** }
procedure TFNovoContasAPagar.ECondicaoPagamentoCadastrar(Sender: TObject);
begin
  FNovaCondicaoPagamento := TFNovaCondicaoPagamento.CriarSDI(self,'',true);
  FNovaCondicaoPagamento.NovaCondicaoPagamento;
  FNovaCondicaoPagamento.free;
end;

{***************************************************************************** }
procedure TFNovoContasAPagar.EConsultaProjetoRetorno(VpaColunas: TRBColunasLocaliza);
begin
  if VpaColunas.items[0].AValorRetorno <> '' then
  begin
    VprDDespesaProjeto.CodProjeto := StrToINt(VpaColunas.items[0].AValorRetorno);
    VprDDespesaProjeto.NomProjeto := VpaColunas.items[1].AValorRetorno;
    GProjetos.Cells[1,GProjetos.ALinha] := VpaColunas.items[0].AValorRetorno;
    GProjetos.Cells[2,GProjetos.ALinha] := VpaColunas.items[1].AValorRetorno;
  end
  else
  begin
    VprDDespesaProjeto.CodProjeto := 0;
    VprDDespesaProjeto.NomProjeto := '';
  end;
end;

{******************************************************************************}
procedure TFNovoContasAPagar.EFornecedorRetorno(Retorno1,
  Retorno2: String);
begin
  if EFornecedor.AInteiro <> 0 then
  begin
    if EFornecedor.AInteiro <> VprDCliente.CodCliente then
    begin
      VprDCliente.CodCliente := EFornecedor.AInteiro;
      FunClientes.CarDCliente(VprDCliente,true);
      IF VprDCliente.CodPlanoContas <> '' then
      begin
        EPlano.Text := VprDCliente.CodPlanoContas;
        EPlanoExit(EPlano);
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoContasAPagar.EDataEmissaoExit(Sender: TObject);
begin
  VprDatEmissao := StrToDate(EDataEmissao.Text);
end;

Initialization
 RegisterClasses([TFNovoContasAPagar]);
end.

