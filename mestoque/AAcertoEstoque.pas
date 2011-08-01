unit AAcertoEstoque;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, ComCtrls, StdCtrls, Buttons,
  ConvUnidade, CONSTANTES, Mask, DBCtrls, Tabela, Db, DBTables,
  BotaoCadastro, Localizacao, DBKeyViolation, UnProdutos, numericos, FMTBcd,
  SqlExpr, UnZebra, UnArgox, UnDadosProduto, UnDadosLocaliza, DBClient;

Const
  CT_DATAMENORULTIMOFECHAMENTO='DATA NÃO PODE SER MENOR QUE A DO ULTIMO FECHAMENTO!!!A data de digitação do produto não ser menor que a data do ultimo fechamento...';
type
  TFAcertoEstoque = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    Localiza: TConsultaPadrao;
    CadProduto: TSQLQuery;
    PanelColor3: TPanelColor;
    BotaoCadastrar2: TBitBtn;
    BotaoGravar2: TBitBtn;
    BotaoCancelar2: TBitBtn;
    BotaoFechar2: TBitBtn;
    CAutoCadastrar: TCheckBox;
    ValidaGravacao1: TValidaGravacao;
    PanelColor5: TPanelColor;
    PanelColor1: TPanelColor;
    Label12: TLabel;
    SpeedButton4: TSpeedButton;
    LNomProduto: TLabel;
    Label14: TLabel;
    SpeedButton2: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label15: TLabel;
    Label5: TLabel;
    SpeedButton1: TSpeedButton;
    LFilial: TLabel;
    EProduto: TEditLocaliza;
    ECodOperacao: TEditLocaliza;
    ETipOperacao: TEditColor;
    EFilial: TEditColor;
    EData: TCalendario;
    PCor: TPanelColor;
    SpeedButton3: TSpeedButton;
    LNomCor: TLabel;
    Label7: TLabel;
    ECor: TEditLocaliza;
    PanelColor4: TPanelColor;
    Label20: TLabel;
    Label3: TLabel;
    Label16: TLabel;
    Label4: TLabel;
    Label19: TLabel;
    Label8: TLabel;
    EUnidade: TComboBoxColor;
    EQtdProduto: Tnumerico;
    EValUnitario: Tnumerico;
    EValTotal: Tnumerico;
    ENumSerie: TEditColor;
    LQtdEstoque: TLabel;
    EQtdEstoque: Tnumerico;
    POrdemProducao: TPanelColor;
    SpeedButton6: TSpeedButton;
    Label11: TLabel;
    Label13: TLabel;
    EOrdemProducao: TEditLocaliza;
    PTecnico: TPanelColor;
    Label23: TLabel;
    SpeedButton9: TSpeedButton;
    Label24: TLabel;
    ETecnico: TRBEditLocaliza;
    CDefeito: TCheckBox;
    EDefeito: TEditColor;
    Label9: TLabel;
    PTamanho: TPanelColor;
    SpeedButton5: TSpeedButton;
    Label10: TLabel;
    Label17: TLabel;
    ETamanho: TRBEditLocaliza;
    EQtdLote: Tnumerico;
    Label18: TLabel;
    BImprimir: TBitBtn;
    PCodBarrasCor: TPanelColor;
    Label21: TLabel;
    ECodBarras: TEditColor;
    EEmbalagem: TRBEditLocaliza;
    Label6: TLabel;
    SpeedButton7: TSpeedButton;
    Label22: TLabel;
    Label25: TLabel;
    EComposicao: TRBEditLocaliza;
    SpeedButton8: TSpeedButton;
    Label26: TLabel;
    Label27: TLabel;
    EPrateleira: TEditColor;
    CImprimeEtiqueta: TCheckBox;
    Label28: TLabel;
    Label29: TLabel;
    EQtdReservada: Tnumerico;
    Aux: TSQL;
    CLeitorSemFio: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBEditLocaliza2Select(Sender: TObject);
    procedure DBEditLocaliza2Retorno(Retorno1, Retorno2: String);
    procedure DBEditLocaliza1Cadastrar(Sender: TObject);
    procedure DBEditLocaliza1Retorno(Retorno1, Retorno2: String);
    procedure DBComboBoxColor1Exit(Sender: TObject);
    procedure DBEditNumerico2Exit(Sender: TObject);
    procedure BotaoFechar2Click(Sender: TObject);
    procedure BotaoCadastrar2Click(Sender: TObject);
    procedure BotaoGravar2Click(Sender: TObject);
    procedure BotaoCancelar2Click(Sender: TObject);
    procedure ECodOperacaoChange(Sender: TObject);
    procedure EValUnitarioChange(Sender: TObject);
    procedure EValTotalExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EDataExit(Sender: TObject);
    procedure ECorFimConsulta(Sender: TObject);
    procedure ECorCadastrar(Sender: TObject);
    procedure EProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EOrdemProducaoSelect(Sender: TObject);
    procedure EOrdemProducaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EUsuarioDestinoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PanelColor4DblClick(Sender: TObject);
    procedure CDefeitoClick(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure ECodBarrasExit(Sender: TObject);
    procedure EEmbalagemRetorno(VpaColunas: TRBColunasLocaliza);
    procedure EComposicaoRetorno(VpaColunas: TRBColunasLocaliza);
    procedure ETamanhoExit(Sender: TObject);
    procedure ECorExit(Sender: TObject);
    procedure EPrateleiraExit(Sender: TObject);
  private
    VprResevaEstoque : Boolean;
    VprUnidadePadrao : string;
    VprSeqProduto :Integer;
    VprOperacao : TRBDOperacaoCadastro;
    FunZebra : TRBFuncoesZebra;
    VprEtiquetas : TList;
    FunArgox : TRBFuncoesArgox;
    procedure InicializaTela;
    procedure AlteraEstadoBotao(VpaEstado : Boolean);
    function AdicionaEstoque : string;
    function DadosValidos : Boolean;
    procedure PosProduto(VpaSeqProduto : Integer);
    procedure CarEtiqueta;
    procedure CarEtiquetamodelo33X57;
    procedure AjustaTamanhoTela;
    function RQtdEstoqueReservada(VpaSeqProduto, VpaCodCor, VpaCodTamanho: integer): double;
  public
    procedure ReservaEstoque;
    { Public declarations }
  end;

  var
    FAcertoEstoque : TFAcertoEstoque;

implementation

uses APrincipal, AOperacoesEstoques, constMsg, funNumeros, funsql, ACores, funObjeto;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFAcertoEstoque.FormCreate(Sender: TObject);
begin
  VprResevaEstoque := false;
   EFilial.Text := IntToStr(Varia.CodigoEmpFil);
   LFilial.Caption := Varia.NomeFilial;
   EData.DateTime := date;
   VprEtiquetas := TList.Create;
// EUnidade.Color := FPrincipal.CorFoco.ACorObrigatorio;
   EProduto.AInfo.CampoCodigo := Varia.CodigoProduto;  // caso codigo pro ou codigo de barras
   VprSeqProduto := 0;
   EQtdProduto.ADecimal := varia.DecimaisQtd;
   EQtdProduto.AMascara :=','+varia.MascaraQtd+';-,'+varia.MascaraQtd;
   PCor.Visible := config.EstoquePorCor;
   PTamanho.Visible := config.EstoquePorTamanho;
   POrdemProducao.Visible := (ConfigModulos.OrdemProducao and Config.MostrarOrdemProducaoNoAcertoEstoque);
   PCodBarrasCor.Visible := config.MostrarCodBarrasCorNoAcertoEstoque;
   CLeitorSemFio.Checked := Config.LeitorSemFioNoAcertodeEstoque;
   PTecnico.Visible := config.MostrarTecnicoNoAcertodeEstoque;
   EPrateleira.ACampoObrigatorio:= Config.PrateleiraCampoObrigatorioAcertoEstoque;
   AjustaTamanhoTela;
   BotaoCadastrar2.Click;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFAcertoEstoque.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeTObjectsList(VprEtiquetas);
  VprEtiquetas.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações dos localizas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFAcertoEstoque.ReservaEstoque;
begin
  VprResevaEstoque := true;
  PTecnico.Visible := false;
  PTamanho.Visible := false;
  PCodBarrasCor.Visible := false;
  Caption := '  Reserva Estoque ';
  PainelGradiente1.Caption := '   Reserva Estoque  ';
  AjustaTamanhoTela;
  PanelColor1.Color := clSkyBlue;
  ShowModal;
end;

{******************************************************************************}
function TFAcertoEstoque.RQtdEstoqueReservada(VpaSeqProduto, VpaCodCor,
  VpaCodTamanho: integer): double;
begin
  AdicionaSQLAbreTabela(AUX,'Select N_QTD_RES from MOVQDADEPRODUTO '+
                            ' Where I_SEQ_PRO = '+ IntToStr(VpaSeqProduto) +
                            ' and I_COD_COR = '+ IntToStr(VpaCodCor) +
                            ' and I_COD_TAM = '+ IntToStr(VpaCodTamanho));
  Result := AUX.FieldByname('N_QTD_RES').AsFloat;
  AUX.close;
end;

{*******************Inicializa as select do localiza***************************}
procedure TFAcertoEstoque.DBEditLocaliza2Select(Sender: TObject);
begin
  EProduto.ASelectValida.add(  ' Select Pro.C_Cod_Pro, pro.C_Nom_Pro, pro.C_Cod_Uni, ' +
                                    ' pro.I_SEQ_PRO, mov.C_COD_BAR, ' +
                                    ' (tab.n_vlr_ven * moe.n_vlr_dia) n_vlr_ven ' +
                                    ' From cadprodutos pro, ' +
                                    ' MovQdadeProduto mov, MovTabelaPreco Tab, CadMoedas Moe ' +
                                    ' Where pro.I_Cod_Emp = ' + IntToStr(varia.CodigoEmpresa) +
                                    ' and ' + varia.CodigoProduto + ' = ''@''' +
                                    ' and pro.C_ATI_PRO = ''S''' +
                                    ' and pro.I_seq_pro = Mov.I_seq_pro ' +
                                    ' and mov.I_Emp_Fil = ' + IntTostr(varia.CodigoEmpFil) +
                                    ' and mov.I_COD_COR = 0 ' +
                                    ' and TAB.I_COD_CLI = 0 ' +
                                    ' and tab.i_cod_tab = ' + IntTostr(varia.TabelaPreco) +
                                    ' and tab.i_cod_emp = ' + IntTostr(varia.CodigoEmpresa) +
                                    ' and pro.i_seq_pro = tab.i_seq_pro ' +
                                    ' and tab.i_cod_moe = moe.i_cod_moe' );

  EProduto.ASelectLocaliza.add(' Select pro.C_Cod_Pro, pro.C_Nom_Pro, pro.C_Cod_Uni, ' +
                                    ' (tab.n_vlr_ven * moe.n_vlr_dia) n_vlr_ven, ' +
                                    ' pro.I_SEQ_PRO, mov.C_COD_BAR ' +
                                    ' from cadprodutos  pro, ' +
                                    ' MovQdadeProduto mov, MovTabelaPreco Tab, CadMoedas  Moe ' +
                                    ' Where pro.I_Cod_Emp = ' + IntToStr(varia.CodigoEmpresa) +
                                    ' and pro.c_nom_pro like ''@%''' +
                                    ' and pro.I_seq_pro = Mov.I_seq_pro ' +
                                    ' and pro.C_ATI_PRO = ''S''' +
                                    ' and mov.I_Emp_Fil = ' + IntTostr(varia.CodigoEmpFil) +
                                    ' and mov.I_COD_COR = 0' +
                                    ' and tab.i_cod_tab = ' + IntTostr(varia.TabelaPreco) +
                                    ' and TAB.I_COD_CLI = 0 ' +
                                    ' and tab.i_cod_emp = ' + IntTostr(varia.CodigoEmpresa) +
                                    ' and pro.i_seq_pro = tab.i_seq_pro ' +
                                    ' and tab.i_cod_moe = moe.i_cod_moe' +
                                    ' order by c_nom_pro asc');
end;

{**********************Retorna o codigo da unidade*****************************}
procedure TFAcertoEstoque.DBEditLocaliza2Retorno(Retorno1,
  Retorno2: String);
begin
  if Retorno1 <> '' then
  begin
    VprSeqProduto := StrToInt(Retorno1);
    PosProduto(VprSeqProduto);
  end
  else
    VprSeqProduto := 0;
end;

{*****************Cadastra uma nova operação de estoque************************}
procedure TFAcertoEstoque.DBEditLocaliza1Cadastrar(Sender: TObject);
begin
   FOperacoesEstoques := TFOperacoesEstoques.CriarSDI(Application,'',FPrincipal.VerificaPermisao('FOperacoesEstoques'));
   FOperacoesEstoques.CadOperacoesEstoques.Insert;
   FOperacoesEstoques.ShowModal;
   Localiza.AtualizaConsulta;
end;

{ ************** retorno da operaco estoque ********************************** }
procedure TFAcertoEstoque.DBEditLocaliza1Retorno(Retorno1,
  Retorno2: String);
begin
  ETipOperacao.Text := Retorno1;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************Chama a rotina para validar a gravacao**********************}
procedure TFAcertoEstoque.DBComboBoxColor1Exit(Sender: TObject);
begin
 if VprUnidadePadrao <> '' then
   if VprUnidadePadrao <> EUnidade.text then
    if not FunProdutos.ValidaUnidade.ValidaUnidade(EUnidade.text, VprUnidadePadrao) then
      EUnidade.text := VprUnidadePadrao;

  if VprOperacao = ocInsercao then
    ValidaGravacao1.execute ;
end;

{********************** Verifica a qdade de estoque conforme config geral *****}
procedure TFAcertoEstoque.DBEditNumerico2Exit(Sender: TObject);
begin
  if ( EProduto.text <> '' ) and (ETipOperacao.Text = 'S') then
    if not FunProdutos.VerificaEstoque( EUnidade.Text,VprUnidadePadrao,
                                    EQtdProduto.avalor,
                                    CadProduto.fieldbyName('I_SEQ_PRO').AsInteger,
                                    ECor.AInteiro,
                                    ETamanho.AInteiro) then
    EQtdProduto.Setfocus;
  if VprOperacao = ocInsercao then
    ValidaGravacao1.execute ;
end;

{************* fecha o formulario ******************************************* }
procedure TFAcertoEstoque.BotaoFechar2Click(Sender: TObject);
begin
  self.close;
end;

{******************************************************************************}
procedure TFAcertoEstoque.InicializaTela;
begin
  VprUnidadePadrao := '';
  VprSeqProduto := 0;
  LimpaComponentes(PanelColor5,10);
  AlteraEstadoBotao(true);
  ValidaGravacao1.execute;
end;

{******************************************************************************}
procedure TFAcertoEstoque.AlteraEstadoBotao(VpaEstado : Boolean);
begin
  BotaoCadastrar2.Enabled := not VpaEstado;
  BotaoGravar2.Enabled := VpaEstado;
  BotaoCancelar2.Enabled := VpaEstado;
  BotaoFechar2.Enabled := not VpaEstado;
  AlterarEnabledDet(PanelColor5,0,VpaEstado);
  EQtdEstoque.Enabled := false;
  LQtdEstoque.Enabled := false;
end;

{************** adiciona o movimento de estoque ****************************** }
function TFAcertoEstoque.AdicionaEstoque : string;
var
  VpfSeqEstoqueBarra : Integer;
  VpfDProduto : TRBDProduto;
begin
  result := '';
  if VprResevaEstoque then
  begin
     Result := FunProdutos.ReservaEstoqueProduto(VARIA.CodigoEmpFil,
                                      CadProduto.fieldByName('I_SEQ_PRO').AsInteger,
                                      ECor.Ainteiro,
                                      ETamanho.AInteiro,
                                      EOrdemProducao.AInteiro,
                                      EQtdProduto.AValor,
                                      EUnidade.Text,
                                      VprUnidadePadrao,
                                      ETipOperacao.Text);

  end
  else
  begin
    VpfDProduto := TRBDProduto.Cria;
    FunProdutos.CarDProduto(VpfDProduto,0,varia.CodigoEmpFil,CadProduto.fieldByName('I_SEQ_PRO').AsInteger);
    FunProdutos.BaixaProdutoEstoque(VpfDProduto, varia.CodigoEmpFil,
                                   ECodOperacao.AInteiro,
                                   0,0,0,
                                   varia.MoedaBase, ECor.Ainteiro,ETamanho.AInteiro,
                                   EData.DateTime,
                                   EQtdProduto.AValor, EValTotal.AValor,
                                   EUnidade.text, ENumSerie.Text, true,VpfSeqEstoqueBarra,true,ETecnico.AInteiro,EOrdemProducao.AInteiro);
    VpfDProduto.free;
    if CDefeito.Checked then
      result := FunProdutos.BaixaEstoqueDefeito(CadProduto.FieldByName('I_SEQ_PRO').AsInteger,ETecnico.AInteiro,EQtdProduto.AValor,EUnidade.Text,
                                                ETipOperacao.Text,EDefeito.Text);
  end;
end;

{******************************************************************************}
procedure TFAcertoEstoque.BImprimirClick(Sender: TObject);
begin
  if varia.ModeloEtiquetaNotaEntrada in [3,7] then
  begin
    if varia.ModeloEtiquetaNotaEntrada in [7] then
      FunZebra := TRBFuncoesZebra.cria(Varia.PortaComunicacaoImpTermica,176,lzZPL)
    else
      if varia.ModeloEtiquetaNotaEntrada in [3] then
        FunArgox := TRBFuncoesArgox.cria(varia.PortaComunicacaoImpTermica);

    case varia.ModeloEtiquetaNotaEntrada of
      3 : begin
            CarEtiqueta;
            FunArgox.ImprimeEtiquetaKairosTexto(VprEtiquetas);
          end;
      7 : begin
            CarEtiquetamodelo33X57;
            FunZebra.ImprimeEtiquetaProduto33X57(VprEtiquetas);
          end;
    end;
    if varia.ModeloEtiquetaNotaEntrada in [7] then
      FunZebra.free
    else
      if varia.ModeloEtiquetaNotaEntrada in [3] then
        FunArgox.Free;

  end

  else
end;

procedure TFAcertoEstoque.BotaoCadastrar2Click(Sender: TObject);
begin
  VprOperacao := ocInsercao;
  InicializaTela;
  if ECodOperacao.AInteiro <> 0 Then
    ActiveControl := EProduto
  else
    activeControl := ECodOperacao;
end;

{******************** grava a baixa de estoque ********************************}
procedure TFAcertoEstoque.BotaoGravar2Click(Sender: TObject);
var
  VpfResultado : string;
  VpfDProduto: TRBDProduto;
  VpfCodTamanho, VpfCodCor: Integer;
begin
  VpfCodTamanho:= ETamanho.AInteiro;
  VpfCodCor:= ecor.AInteiro;
  if DadosValidos then
  begin
    if ETipOperacao.Text = 'S' then
      if not VprResevaEstoque then
        FunProdutos.VerificaPontoPedido( varia.CodigoEmpfil,
                                     CadProduto.fieldByname('I_SEQ_PRO').AsInteger,
                                     ECor.AInteiro,ETamanho.AInteiro,
                                     FunProdutos.CalculaQdadePadrao(EUnidade.text,
                                     VprUnidadePadrao,EQtdProduto.avalor,
                                     CadProduto.fieldByname('I_SEQ_PRO').AsString));
    VpfResultado := AdicionaEstoque;

    if CadProduto.fieldByname('C_PRA_PRO').AsString <> EPrateleira.Text then
      FunProdutos.AlteraPrateleiraProduto(CadProduto.fieldByname('I_SEQ_PRO').AsInteger, EPrateleira.Text);

    if CImprimeEtiqueta.Checked then
      BImprimir.Click;

    AlteraEstadoBotao(false);
    if CAutoCadastrar.Checked then
      BotaoCadastrar2.Click
    else
      VprOperacao := ocConsulta;

    if VpfResultado = '' then
    begin
      VpfDProduto :=  TRBDProduto.cria;
      VpfDProduto.CodEmpresa := Varia.CodigoEmpresa;
      VpfDProduto.CodEmpFil := Varia.CodigoEmpFil;
      VpfDProduto.SeqProduto:= CadProduto.fieldByname('I_SEQ_PRO').AsInteger;
      FunProdutos.CarDProduto(VpfDProduto);
      VpfResultado:= FunProdutos.AdicionaProdutoNaTabelaPreco(1101, VpfDProduto, VpfCodTamanho, VpfCodCor);
    end;

    if VpfResultado <> '' then
      aviso(VpfResultado);
  end;
end;

{******************************************************************************}
procedure TFAcertoEstoque.BotaoCancelar2Click(Sender: TObject);
begin
  AlteraEstadoBotao(false);
  LimpaComponentes(PanelColor1,10);
  VprOperacao := ocConsulta;
end;

{***************** verifica se os dados sao validos ***************************}
function TFAcertoEstoque.DadosValidos : Boolean;
begin
  result := true;
  if EData.DateTime <= Varia.DataUltimoFechamento then
  begin
    result := false;
    aviso(CT_DATAMENORULTIMOFECHAMENTO);
  end;
  if result then
  begin
    if CDefeito.Checked then
    begin
      if ETecnico.AInteiro = 0 then
      begin
        Result := false;
        aviso('TÉCNICO NÃO PREENCHIDO!!!'#13'É necessário preencher o técnico.');
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFAcertoEstoque.PosProduto(VpaSeqProduto : Integer);
begin
  if VpaSeqProduto <> 0 then
  begin
    FunProdutos.LocalizaProdutoSequencialQdade(CadProduto, VpaSeqProduto,ECor.AInteiro,ETamanho.AInteiro);
    EProduto.Text := CadProduto.FieldByName('C_COD_PRO').AsString;
    LNomProduto.Caption := CadProduto.FieldByName('C_NOM_PRO').AsString;
    if CadProduto.Eof then
    begin
      FunProdutos.LocalizaProdutoSequencialQdade(CadProduto, VpaSeqProduto,ECor.AInteiro,0);
      EProduto.Text := CadProduto.FieldByName('C_COD_PRO').AsString;
      LNomProduto.Caption := CadProduto.FieldByName('C_NOM_PRO').AsString;
      if CadProduto.Eof then
      begin
        FunProdutos.LocalizaProdutoSequencialQdade(CadProduto, VpaSeqProduto,0,0);
        EProduto.Text := CadProduto.FieldByName('C_COD_PRO').AsString;
        LNomProduto.Caption := CadProduto.FieldByName('C_NOM_PRO').AsString;
      end;
    end;
    label3.Caption := '';
    Label3.Caption := CadProduto.fieldByName('C_COD_UNI').AsString;
    EUnidade.Items := FunProdutos.validaUnidade.UnidadesParentes(CadProduto.fieldByName('C_COD_UNI').AsString);
    EUnidade.ItemIndex := EUnidade.Items.IndexOf(CadProduto.fieldByName('C_COD_UNI').AsString);
    VprUnidadePadrao := CadProduto.fieldByName('C_COD_UNI').AsString;
    EValUnitario.AValor := CadProduto.FieldByName('N_VLR_CUS').AsFloat;
    EQtdEstoque.AValor := CadProduto.FieldByName('N_QTD_PRO').AsFloat;
    ECodBarras.Text := CadProduto.FieldByName('C_COD_BAR').AsString;
    ECodBarras.ReadOnly := CadProduto.FieldByName('C_COD_BAR').AsString <> '';
    EEmbalagem.AInteiro := CadProduto.FieldByName('I_COD_EMB').AsInteger;
    EEmbalagem.Atualiza;
    EComposicao.AInteiro := CadProduto.FieldByName('I_COD_COM').AsInteger;
    EComposicao.Atualiza;
    EPrateleira.Text:= CadProduto.FieldByName('C_PRA_PRO').AsString;

    if config.EstoquePorNumeroSerie then
      if ETipOperacao.Text = 'E' then
        ENumSerie.Text := FunProdutos.CalculaNumeroSerie(CadProduto.FieldByName('I_NUM_LOT').AsInteger+1);
  end;
end;

{******************************************************************************}
procedure TFAcertoEstoque.CarEtiqueta;
Var
  VpfDEtiqueta : TRBDEtiquetaProduto;
  VpfDProduto : TRBDProduto;
begin
  FreeTObjectsList(VprEtiquetas);
  VpfDProduto := TRBDProduto.Cria;
  FunProdutos.CarDProduto(VpfDProduto,varia.CodigoEmpresa,varia.CodigoEmpFil,VprSeqProduto);
  VpfDEtiqueta := TRBDEtiquetaProduto.cria;
  VpfDEtiqueta.Produto := VpfDProduto;
  VpfDEtiqueta.QtdEtiquetas := 3;
  VpfDEtiqueta.QtdOriginalEtiquetas := 3;
  VpfDEtiqueta.CodCor := ECor.AInteiro;
  VpfDEtiqueta.NomCor := LNomCor.caption;
  VprEtiquetas.add(VpfDEtiqueta);

end;

{******************************************************************************}
procedure TFAcertoEstoque.CarEtiquetamodelo33X57;
Var
  VpfQtdFaltante : Double;
  VpfDEtiqueta : TRBDEtiquetaProduto;
  VpfDProduto : TRBDProduto;
  VpfNomComposicao : String;
begin
  FreeTObjectsList(VprEtiquetas);
  VpfQtdFaltante := EQtdProduto.AValor;
  if EQtdLote.AValor = 0 then
    EQtdLote.AValor := EQtdProduto.AValor;
  VpfDProduto := TRBDProduto.Cria;
  FunProdutos.CarDProduto(VpfDProduto,Varia.CodigoEmpresa,Varia.CodigoEmpFil,VprSeqProduto);
  VpfNomComposicao := FunProdutos.RNomeComposicao(VpfDProduto.CodComposicao);
  FunProdutos.CarFigurasGRF(VpfDProduto.CodComposicao,VpfDProduto.FigurasComposicao);
  while VpfQtdFaltante > 0  do
  begin
    VpfDEtiqueta := TRBDEtiquetaProduto.cria;
    VprEtiquetas.Add(VpfDEtiqueta);
    VpfDEtiqueta.Produto := VpfDProduto;
    VpfDEtiqueta.CodCor := ECor.AInteiro;
    VpfDEtiqueta.QtdOriginalEtiquetas := 1;
    VpfDEtiqueta.QtdEtiquetas := 1;
    if VpfQtdFaltante > EQtdLote.AValor then
      VpfDEtiqueta.QtdProduto := EQtdLote.AsInteger
    else
      VpfDEtiqueta.QtdProduto := RetornaInteiro(VpfQtdFaltante);
    VpfDEtiqueta.NomComposicao := VpfNomComposicao;
    VpfDEtiqueta.NomCor := LNomCor.Caption;
    VpfDEtiqueta.CodBarras := ECodBarras.Text;
    VpfDEtiqueta.NumSerie := ENumSerie.Text;
    VpfQtdFaltante := VpfQtdFaltante - EQtdLote.AValor;
  end;
end;

{******************************************************************************}
procedure TFAcertoEstoque.AjustaTamanhoTela;
var
  VpfTamanhoTela : Integer;
begin
   VpfTamanhoTela := 35+ PanelColor1.Height +PanelColor4.Height;
   if PTecnico.Visible then
     VpfTamanhoTela := VpfTamanhoTela + PTecnico.Height;

   if PCor.Visible then
     VpfTamanhoTela := VpfTamanhoTela +PCor.Height;

   if PCodBarrasCor.Visible then
     VpfTamanhoTela := VpfTamanhoTela +PCodBarrasCor.Height;
   if PTamanho.Visible then
     VpfTamanhoTela := VpfTamanhoTela +PTamanho.Height;

   if POrdemProducao.Visible then
     VpfTamanhoTela := VpfTamanhoTela +POrdemProducao.Height;

   VpfTamanhoTela := VpfTamanhoTela + PainelGradiente1.Height+PanelColor3.Height;
   Height := VpfTamanhoTela;
end;

{******************************************************************************}
procedure TFAcertoEstoque.ECodBarrasExit(Sender: TObject);
var
  VpfResultado : String;
begin
  if not ECodBarras.ReadOnly  then
  begin
    if ECodBarras.Text <> '' then
      VpfResultado := FunProdutos.AtualizaCodEan(VprSeqProduto,ECor.AInteiro,ECodBarras.Text);
    if VpfResultado <> '' then
      aviso(VpfResultado);
  end;
end;

procedure TFAcertoEstoque.ECodOperacaoChange(Sender: TObject);
begin
  if VprOperacao = ocInsercao then
    ValidaGravacao1.execute ;
end;

procedure TFAcertoEstoque.EComposicaoRetorno(VpaColunas: TRBColunasLocaliza);
var
  VpfResultado : String;
begin
  if CadProduto.Active then
  BEGIN
    if EComposicao.AInteiro <> CadProduto.FieldByName('I_COD_COM').AsInteger then
    begin
      VpfResultado := FunProdutos.AtualizaComposicao(CadProduto.FieldByName('I_SEQ_PRO').AsInteger,EComposicao.AInteiro);
      if VpfResultado <> '' then
        aviso(VpfResultado);
    end;
  END;
end;

{******************************************************************************}
procedure TFAcertoEstoque.EValUnitarioChange(Sender: TObject);
begin
  if EQtdProduto.AValor <> 0 then
    EValTotal.AValor := EValUnitario.AValor * EQtdProduto.AValor;
end;

{******************************************************************************}
procedure TFAcertoEstoque.EValTotalExit(Sender: TObject);
begin
  if EValUnitario.AValor = 0 then
    EValUnitario.AValor := EValTotal.AValor / EQtdProduto.AValor;
end;

{******************************************************************************}
procedure TFAcertoEstoque.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    40: Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

{************** valida a data com a data do fechamento do mes *****************}
procedure TFAcertoEstoque.EDataExit(Sender: TObject);
begin
  if EData.DateTime <= Varia.DataUltimoFechamento then
  begin
    aviso(CT_DATAMENORULTIMOFECHAMENTO);
    EData.SetFocus;
  end;
end;

procedure TFAcertoEstoque.EEmbalagemRetorno(VpaColunas: TRBColunasLocaliza);
var
  VpfResultado : String;
begin
  EQtdLote.Text := VpaColunas.items[2].AValorRetorno;
  if CadProduto.Active then
  BEGIN
    if EEmbalagem.AInteiro <> CadProduto.FieldByName('I_COD_EMB').AsInteger then
    begin
      VpfResultado := FunProdutos.AtualizaEmbalagem(CadProduto.FieldByName('I_SEQ_PRO').AsInteger,EEmbalagem.AInteiro);
      if VpfResultado <> '' then
        aviso(VpfResultado);
    end;
  END;
end;

{******************************************************************************}
procedure TFAcertoEstoque.ECorFimConsulta(Sender: TObject);
begin
  PosProduto(VprSeqProduto);
end;

{******************************************************************************}
procedure TFAcertoEstoque.ECorCadastrar(Sender: TObject);
begin
  FCores := TFCores.CriarSDI(application,'', FPrincipal.VerificaPermisao('FCores'));
  FCores.BotaoCadastrar1.Click;
  FCores.showmodal;
  FCores.free;
end;

procedure TFAcertoEstoque.ECorExit(Sender: TObject);
begin
  EQtdReservada.AValor:= RQtdEstoqueReservada(VprSeqProduto, ECor.AInteiro, ETamanho.AInteiro);
end;

{******************************************************************************}
procedure TFAcertoEstoque.EPrateleiraExit(Sender: TObject);
begin
  if EPrateleira.ACampoObrigatorio then
    if VprOperacao = ocInsercao then
       ValidaGravacao1.execute ;
end;

{******************************************************************************}
procedure TFAcertoEstoque.EProdutoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 13 then
  begin
    if Config.AcertodeEstoquePeloSequencial then
    begin
      PosProduto(EProduto.AInteiro);
      if POrdemProducao.Visible then
        ActiveControl := EOrdemProducao;
      if CLeitorSemFio.Checked then
      begin
        EQtdProduto.AsInteger := 1;
        BotaoGravar2.Click;
        if CAutoCadastrar.Checked then
          ActiveControl := EProduto;
      end;
    end
    else
      ActiveControl := EUnidade;
  end;
end;

procedure TFAcertoEstoque.ETamanhoExit(Sender: TObject);
begin
  EQtdReservada.AValor:= RQtdEstoqueReservada(VprSeqProduto, ECor.AInteiro, ETamanho.AInteiro);
end;

{******************************************************************************}
procedure TFAcertoEstoque.EOrdemProducaoSelect(Sender: TObject);
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
procedure TFAcertoEstoque.EOrdemProducaoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 13 then
    ETecnico.SetFocus;
end;

{******************************************************************************}
procedure TFAcertoEstoque.EUsuarioDestinoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 13 then
    EQtdProduto.SetFocus;
end;

{******************************************************************************}
procedure TFAcertoEstoque.PanelColor4DblClick(Sender: TObject);
begin
  aviso(IntToStr(height));
end;

{******************************************************************************}
procedure TFAcertoEstoque.CDefeitoClick(Sender: TObject);
begin
  EDefeito.ACampoObrigatorio := CDefeito.Checked;
end;

Initialization
 RegisterClasses([TFAcertoEstoque]);
end.
