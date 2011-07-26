unit ARelPedido;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, PainelGradiente, Componentes1, Formularios, StdCtrls, Buttons,
  Localizacao, ComCtrls, Mask, numericos, Db, DBTables, UnProdutos,
  Grids, CGrades, UnClassificacao, Spin, UnCotacao, UnRave;

type
  TFRelPedido = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    ScrollBox1: TScrollBox;
    BFechar: TBitBtn;
    PFilial: TPanelColor;
    Localiza: TConsultaPadrao;
    Label24: TLabel;
    EFilial: TEditLocaliza;
    SpeedButton5: TSpeedButton;
    LFilial: TLabel;
    PCliente: TPanelColor;
    LTextoCliente: TLabel;
    SpeedButton1: TSpeedButton;
    LCliente: TLabel;
    PCidade: TPanelColor;
    Label2: TLabel;
    SpeedButton2: TSpeedButton;
    LCidade: TLabel;
    ECidade: TEditLocaliza;
    PEstado: TPanelColor;
    Label4: TLabel;
    SpeedButton3: TSpeedButton;
    Label5: TLabel;
    EEstado: TEditLocaliza;
    PCondPgto: TPanelColor;
    Label6: TLabel;
    SpeedButton4: TSpeedButton;
    LCondPgto: TLabel;
    ECondPgto: TEditLocaliza;
    PPeriodo: TPanelColor;
    CDataIni: TCalendario;
    CDataFim: TCalendario;
    Label9: TLabel;
    PTipoCotacao: TPanelColor;
    Label3: TLabel;
    ETipoCotacao: TEditLocaliza;
    SpeedButton6: TSpeedButton;
    LTipoCotacao: TLabel;
    PVendedor: TPanelColor;
    Label11: TLabel;
    EVendedor: TEditLocaliza;
    SpeedButton7: TSpeedButton;
    LVendedor: TLabel;
    PSituacao: TPanelColor;
    Label7: TLabel;
    RFlagSituacao: TRadioGroup;
    PDataFinal: TPanelColor;
    LDataFinal: TLabel;
    CDataFinal: TCalendario;
    PSitCliente: TPanelColor;
    Label8: TLabel;
    SpeedButton8: TSpeedButton;
    LSituacaoCliente: TLabel;
    ESituacaoCliente: TEditLocaliza;
    Aux: TQuery;
    PEmpresa: TPanelColor;
    Label10: TLabel;
    SpeedButton9: TSpeedButton;
    LEmpresa: TLabel;
    ECodEmpresa: TEditLocaliza;
    PTabelaPreco: TPanelColor;
    Label13: TLabel;
    SpeedButton10: TSpeedButton;
    LNomTabelaPreco: TLabel;
    ECodTabelaPreco: TEditLocaliza;
    PProduto: TPanelColor;
    Label14: TLabel;
    EProduto: TEditLocaliza;
    SpeedButton11: TSpeedButton;
    LProduto: TLabel;
    PBanco: TPanelColor;
    Label15: TLabel;
    EBanco: TEditLocaliza;
    SpeedButton12: TSpeedButton;
    LBanco: TLabel;
    PUsuario: TPanelColor;
    Label16: TLabel;
    SpeedButton13: TSpeedButton;
    LNomUsuario: TLabel;
    ECodUsuario: TEditLocaliza;
    PFormaPagamento: TPanelColor;
    Label17: TLabel;
    SpeedButton14: TSpeedButton;
    LFormaPagamento: TLabel;
    EFormaPagamento: TEditLocaliza;
    BMostrarConta: TSpeedButton;
    PClassificacaoProduto: TPanelColor;
    Label12: TLabel;
    SpeedButton15: TSpeedButton;
    LNomClassificacao: TLabel;
    ECodClassifcacao: TEditColor;
    PQtdVias: TPanelColor;
    Label18: TLabel;
    EQtdVias: TSpinEditColor;
    PEstagio: TPanelColor;
    Label19: TLabel;
    SpeedButton16: TSpeedButton;
    LEstagio: TLabel;
    ECodEstagio: TEditLocaliza;
    PTransportadora: TPanelColor;
    Label20: TLabel;
    SpeedButton17: TSpeedButton;
    LTransportadora: TLabel;
    ETransportadora: TEditLocaliza;
    PFundoPerdido: TPanelColor;
    CFundoPerdido: TCheckBox;
    PTipoContrato: TPanelColor;
    Label21: TLabel;
    SpeedButton18: TSpeedButton;
    LNomTipoContrato: TLabel;
    ECodTipoContrato: TEditLocaliza;
    PPreposto: TPanelColor;
    Label22: TLabel;
    SpeedButton19: TSpeedButton;
    LPreposto: TLabel;
    EPreposto: TEditLocaliza;
    PTecnico: TPanelColor;
    LTituloTecnico: TLabel;
    ETecnico: TEditLocaliza;
    SpeedButton20: TSpeedButton;
    LTecnico: TLabel;
    POperacaoEstoque: TPanelColor;
    Label25: TLabel;
    SpeedButton21: TSpeedButton;
    LOperacaoEstoque: TLabel;
    EOperacaoEstoque: TEditLocaliza;
    PCor: TPanelColor;
    Label27: TLabel;
    SpeedButton22: TSpeedButton;
    LCor: TLabel;
    ECodCor: TEditLocaliza;
    PCotacaoCancelada: TPanelColor;
    Label26: TLabel;
    ESituacaoCotacao: TComboBoxColor;
    PClienteMaster: TPanelColor;
    Label28: TLabel;
    SpeedButton23: TSpeedButton;
    LClienteMaster: TLabel;
    PCentroCusto: TPanelColor;
    Label29: TLabel;
    SpeedButton24: TSpeedButton;
    LCentroCusto: TLabel;
    ECentroCusto: TRBEditLocaliza;
    PNumerico1: TPanelColor;
    LNumerico1: TLabel;
    ENumerico1: Tnumerico;
    BImprimir: TBitBtn;
    PTipoPeriodo: TPanelColor;
    Label1: TLabel;
    ETipoPeriodo: TComboBoxColor;
    PProjeto: TPanelColor;
    Label23: TLabel;
    SpeedButton25: TSpeedButton;
    LProjeto: TLabel;
    EProjeto: TRBEditLocaliza;
    PCheckBox1: TPanelColor;
    CheckBox1: TCheckBox;
    BitBtn1: TBitBtn;
    SaveDialog: TSaveDialog;
    PRamoAtividade: TPanelColor;
    Label30: TLabel;
    SpeedButton26: TSpeedButton;
    LRamoAtividade: TLabel;
    ERamoAtividade: TRBEditLocaliza;
    PDesenvolvedor: TPanelColor;
    Label31: TLabel;
    SpeedButton27: TSpeedButton;
    LDesenvolvedor: TLabel;
    EDesenvolvedor: TRBEditLocaliza;
    POrdemRelatorio: TPanelColor;
    Label32: TLabel;
    EOrdemRelatorio: TComboBoxColor;
    PFaccionista: TPanelColor;
    Label33: TLabel;
    SpeedButton28: TSpeedButton;
    LFaccionista: TLabel;
    EFaccionista: TRBEditLocaliza;
    PRepresentada: TPanelColor;
    Label34: TLabel;
    SpeedButton29: TSpeedButton;
    LRepresentada: TLabel;
    ERepresentada: TRBEditLocaliza;
    PSituacaoAgenda: TPanelColor;
    Label35: TLabel;
    ESituacaoAgenda: TComboBoxColor;
    ECliente: TRBEditLocaliza;
    EClienteMaster: TRBEditLocaliza;
    PTipoCadastroCliente: TPanelColor;
    CCliente: TCheckBox;
    CProspect: TCheckBox;
    CFornecedor: TCheckBox;
    CHotel: TCheckBox;
    PDistribuicaoFaccionista: TPanelColor;
    CEmpresaLeva: TRadioButton;
    CBuscaNaEmpresa: TRadioButton;
    CTodosDistribuicao: TRadioButton;
    PFuncionarios: TPanelColor;
    CFuncionarios: TRadioButton;
    CNaoFuncionarios: TRadioButton;
    CFuncionarioTodos: TRadioButton;
    PClienteAtivo: TPanelColor;
    CSomenteClienteAtivo: TCheckBox;
    CPeriodo: TCheckBox;
    PMeioDivulgacao: TPanelColor;
    Label36: TLabel;
    SpeedButton30: TSpeedButton;
    LMeioDivulgacao: TLabel;
    EMeioDivulgacao: TRBEditLocaliza;
    SaveDialogRTF: TSaveDialog;
    PSetor: TPanelColor;
    Label37: TLabel;
    SpeedButton31: TSpeedButton;
    LSetor: TLabel;
    ESetor: TRBEditLocaliza;
    PFaixa: TPanelColor;
    LFaixaInicial: TLabel;
    EFaixaInicial: Tnumerico;
    EFaixaFinal: Tnumerico;
    LFaixaFinal: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ECodTabelaPrecoSelect(Sender: TObject);
    procedure EProdutoSelect(Sender: TObject);
    procedure EProdutoRetorno(Retorno1, Retorno2: String);
    procedure BMostrarContaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton15Click(Sender: TObject);
    procedure ECodClassifcacaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ECodClassifcacaoExit(Sender: TObject);
  private
    { Private declarations }
    VprArquivo, VprCaminhoRelatorio, VprNomRelatorio: string;
    VprSeqProduto : Integer;
    VprPressionadoR : Boolean;
    FunClassificacao : TFuncoesClassificacao;
    FunRave : TRBFunRave;
    procedure SetarVisibleFalsePanels;
    procedure RedimensionarFormulario;
    procedure RotinasRelatoriosEspeciais;
    function LocalizaClassificacao : boolean;
    procedure MostraFiltrosRelatorio(VpaNomRelatorio : String);
  public
    { Public declarations }
    procedure CarregarRelatorio(VpaArquivo, VpaNomeRel: string);
  end;

var
  FRelPedido: TFRelPedido;

implementation

{$R *.DFM}

uses APrincipal, ConstMsg, FunData, FunSql, Constantes, FunObjeto,
  ALocalizaClassificacao, dmRave, funString, funarquivos;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                   FORMULÁRIO
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFRelPedido.FormCreate(Sender: TObject);
begin
  SaveDialog.InitialDir := Varia.DiretorioSistema;
  ScrollBox1.BorderStyle := bsNone;
  CDataIni.DateTime := PrimeiroDiaMes(Now);
  CDataFim.DateTime := UltimoDiaMes(Now);
  CDataFinal.DateTime := Now;
  EFilial.AInteiro := varia.CodigoEmpFil;
  EFilial.Atualiza;
  ECodTabelaPreco.AInteiro := varia.TabelaPreco;
  EOrdemRelatorio.ItemIndex := 0;
  ESituacaoCotacao.ItemIndex := 0;
  VprPressionadoR := false;
  FunClassificacao := TFuncoesClassificacao.criar(self,FPrincipal.BaseDados);
  FunRave := TRBFunRave.cria(FPrincipal.BaseDados);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                   SUBROTINAS
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFRelPedido.SetarVisibleFalsePanels;
var
  Laco: integer;
begin
  Laco := 0;
  while Laco < ScrollBox1.ControlCount do
  begin
    if ScrollBox1.Controls[Laco] is TPanelColor then
    begin
      if (TPanelColor(ScrollBox1.Controls[Laco]).Name[1] = 'X') and
        (TPanelColor(ScrollBox1.Controls[Laco]).Name[2] = 'X') then
        TPanelColor(ScrollBox1.Controls[Laco]).Free
      else
        begin
          TPanelColor(ScrollBox1.Controls[Laco]).Hide;// := false;
          inc(Laco);
        end;
    end;
  end;
end;

{******************************************************************************}
procedure TFRelPedido.RedimensionarFormulario;
var
  Laco, TotPanels: integer;
begin
  TotPanels := 0;
  for Laco := 0 to ScrollBox1.ControlCount -1 do
    if ScrollBox1.Controls[Laco] is TPanelColor then
      if TPanelColor(ScrollBox1.Controls[Laco]).Visible then
        inc(TotPanels);

  Self.Height := PainelGradiente1.Height + PanelColor2.Height +
    (TotPanels * PFilial.Height) + 40;

  if Self.Height > 525 then
    Self.Height := 525;
end;

{******************************************************************************}
procedure TFRelPedido.CarregarRelatorio(VpaArquivo, VpaNomeRel: string);
var
  VpfLaco: integer;
begin
  VprArquivo := VpaArquivo;
  VprNomRelatorio := Uppercase(VpaNomeRel);
  VprCaminhoRelatorio := RetornaDiretorioArquivo(VpaArquivo);
  VprCaminhoRelatorio := NomeModulo+'  Relatorios'+SubstituiStr(Copy(VprCaminhoRelatorio,length(varia.PathRelatorios)+1,length(VprCaminhoRelatorio)-length(varia.PathRelatorios)), '\','->')+VpaNomeRel;
  PainelGradiente1.Caption := '   ' + VpaNomeRel + '   ';
  MostraFiltrosRelatorio(VprNomRelatorio);

  RedimensionarFormulario;
  Self.ShowModal;
end;


{******************************************************************************}
procedure TFRelPedido.RotinasRelatoriosEspeciais;
begin
  if (UpperCase(VprNomRelatorio) = 'CLIENTES SEM PEDIDO')or (UpperCase(VprNomRelatorio) = 'CLIENTES COM PEDIDO') then
  begin
    ExecutaComandoSql(Aux,'Update CFG_GERAL SET D_CLI_PED = ' + SQLTextoDataAAAAMMMDD(CDataFinal.DateTime));
  end
  else
    if (UpperCase(VprNomRelatorio) = 'PRODUTOS FATURADOS POR MES E ESTADO') then
    begin
      FunProdutos.CarProdutoFaturadosnoMes(CDataIni.DateTime,CDataFim.DateTime,EFilial.AInteiro);
    end
    else
      if (UpperCase(VprNomRelatorio) = 'ENTRADA METROS DIARIOS') then
        FunCotacao.AtualizaEntradaMetrosDiario(CDataIni.DateTime,CDataFim.DateTime);
end;


{******************************************************************************}
function TFRelPedido.LocalizaClassificacao : Boolean;
var
  VpfCodClassificacao, VpfNomClassificacao : string;
begin
  result := true;
  FLocalizaClassificacao := TFLocalizaClassificacao.CriarSDI(application,'', true);
  if FLocalizaClassificacao.LocalizaClassificacao(VpfCodClassificacao,VpfNomClassificacao, 'P') then
  begin
    ECodClassifcacao.Text := VpfCodClassificacao;
    LNomClassificacao.Caption := VpfNomClassificacao;
  end
  else
    result := false;
end;

{******************************************************************************}
procedure TFRelPedido.MostraFiltrosRelatorio(VpaNomRelatorio : String);
begin
  SetarVisibleFalsePanels;
  if (VPANOMRELATORIO = 'NOTAS FISCAIS EMITIDAS') OR
     (VPANOMRELATORIO = 'NOTAS FISCAIS EMITIDAS POR NATUREZA OPERACAO') then
    AlterarVisibleDet([PVendedor,PFilial,PCliente,PClienteMaster, PPeriodo,PCotacaoCancelada],true)
  else
    if (VPANOMRELATORIO = 'PEDIDOS POR DIA') or
       (VPANOMRELATORIO = 'PEDIDOS POR CLIENTE') then
    begin
      AlterarVisibleDet([PVendedor,PPreposto, PFilial,PCliente,PPeriodo, PTipoCotacao,PCondPgto,PSituacao,PClassificacaoProduto,PEstado],true);
      if (VPANOMRELATORIO = 'PEDIDOS POR DIA') then
        AlterarVisibleDet([PProduto,PRepresentada], True);
    end
    else
      if (VPANOMRELATORIO = 'PRODUTOS VENDIDOS POR CLASSIFICACAO') or
         (VPANOMRELATORIO = 'PRODUTOS VENDIDOS POR CLASSIFICACAO E ESTADO') or
         (VPANOMRELATORIO = 'PRODUTOS VENDIDOS EM KILO POR CLASSIFICACAO') then
        AlterarVisibleDet([PVendedor,PFilial,PCliente,PPeriodo,PTipoCotacao,PClienteMaster],true)
      else
        if (VPANOMRELATORIO = 'CLIENTES SEM PEDIDO') then
        begin
          AlterarVisibleDet([PVendedor,PSitCliente,PTipoCotacao,PDataFinal,PPreposto, PClienteAtivo,PRepresentada,PPeriodo],true);
          CPeriodo.Checked := false;
          LDataFinal.Caption := 'Desde : ';
          CPeriodo.Caption := 'Cadatrados : '
        end
        else
          if (VPANOMRELATORIO = 'LEITURA DOS CONTRATOS') then
          begin
            AlterarVisibleDet([PTecnico,PCliente,PTipoContrato,PNumerico1],true);
            LTituloTecnico.Caption := 'Resp. Leitura :';
            LNumerico1.Caption := 'Dia Leitura : ';
          end
          else
            if (VPANOMRELATORIO = 'ESTOQUE PRODUTOS')or
               (VPANOMRELATORIO = 'ESTOQUE PRODUTOS RESERVADOS') then
            begin
              AlterarVisibleDet([PClassificacaoProduto,PFilial,PFundoPerdido,PCheckBox1,POrdemRelatorio, PProduto],true);
              CFundoPerdido.Caption := 'Somente Produtos Monitorados';
              CFundoPerdido.Checked := false;
              Checkbox1.Caption := 'Somente Produtos que Possuem Qtd em Estoque';
            end
            else
              if (VPANOMRELATORIO = 'VENDA ANALITICO') then
                AlterarVisibleDet([PCliente,PFilial,PTipoCotacao,PCondPgto,PVendedor,PPreposto,PPeriodo,PCidade,PEstado,PRepresentada],true)
              else
                if (VPANOMRELATORIO = 'CONSISTENCIA DE ESTOQUE') then
                begin
                  AlterarVisibleDet([PFilial,PPeriodo,PProduto,PFundoPerdido],true);
                  cFundoPerdido.Caption := 'Somente Produtos Monitorados';
                  cFundoPerdido.Checked := false;
                end
                else
                  if (VPANOMRELATORIO = 'ESTOQUE MINIMO') then
                  begin
                    AlterarVisibleDet([PClassificacaoProduto,PFilial,PCliente],true);
                    LTextoCliente.Caption := 'Fornecedor : ';
                  end
                  else
                    if (VPANOMRELATORIO = 'ANALISE FATURAMENTO ANUAL') then
                      AlterarVisibleDet([PFilial,PPeriodo,PCliente,PVendedor,PPreposto],true)
                    else
                    if (VPANOMRELATORIO = 'ANALISE PEDIDO ANUAL') then
                      AlterarVisibleDet([PFilial,PPeriodo,PCliente,PVendedor,PPreposto,PTipoCotacao],true)
                    else
                      if (VPANOMRELATORIO = 'DEVOLUCOES PENDENTES') then
                      begin
                        AlterarVisibleDet([PFilial,PDataFinal,PCliente,PEstagio,PTransportadora,PVendedor,PProduto],true);
                        LDataFinal.Caption := 'Desde : ';
                      end
                      else
                        if (VPANOMRELATORIO = 'ESTOQUE FISCAL') then
                          AlterarVisibleDet([PProduto,PFilial],true)
                        else
                          if (VPANOMRELATORIO = 'ESTOQUE POR GRUPOS E PRODUTOS') then
                          begin
                            AlterarVisibleDet([PFilial,PDataFinal,PFundoPerdido],true);
                            LDataFinal.Caption := 'Mes/Ano : ';
                            CFundoPerdido.Caption := 'Somente Produtos com Venda';
                          end
                          else
                            if (VPANOMRELATORIO = 'COTACOES EM ABERTO POR ESTAGIO') then
                              AlterarVisibleDet([PEstagio,PTransportadora,PPeriodo],true)
                            else
                              if (VPANOMRELATORIO = 'POR PLANO DE CONTAS ANALITICO') then
                                AlterarVisibleDet([PFilial,PPeriodo,PTipoPeriodo],true)
                              else
                                if (VPANOMRELATORIO = 'PRODUTIVIDADE PRODUCAO') then
                                begin
                                  AlterarVisibleDet([PDataFinal],true);
                                  LDataFinal.Caption := 'Mês : ';
                                end
                                else
                                  if (VPANOMRELATORIO = 'TOTAL CLIENTES ATENDIDOS E PRODUTOS VENDIDOS POR VENDEDOR')or
                                     (VPANOMRELATORIO = 'TOTAL CLIENTES ATENDIDOS E PRODUTOS VENDIDOS')  then
                                    AlterarVisibleDet([PPeriodo,PClienteMaster],true)
                                  else
                                    if (VPANOMRELATORIO = 'CUSTO PROJETO') then
                                      AlterarVisibleDet([PProjeto],true)
                                    else
                                      if (VPANOMRELATORIO = 'ESTOQUE DE PRODUTOS POR TECNICO') then
                                        AlterarVisibleDet([PTecnico],true)
                                      else
                                        if (VPANOMRELATORIO = 'PRODUTOS RETORNADOS COM DEFEITO') then
                                          AlterarVisibleDet([PTecnico,PPeriodo],true)
                                        else
                                          if (VPANOMRELATORIO = 'CONSISTENCIA RESERVA ESTOQUE') then
                                            AlterarVisibleDet([PProduto,PPeriodo],true)
                                          else
                                            if (VPANOMRELATORIO = 'FILA CHAMADOS POR TECNICO') then
                                              AlterarVisibleDet([PEstagio,PTecnico,PPeriodo],true)
                                            else
                                              if (VPANOMRELATORIO = 'VENDAS POR ESTADO E CIDADE') or
                                                 (VPANOMRELATORIO = 'TOTAL VENDAS POR ESTADO E CIDADE') then
                                                AlterarVisibleDet([PPeriodo,PTipoCotacao,PCliente,PCidade,PEstado,PCondPgto, PTransportadora],true)
                                              else
                                                if (VPANOMRELATORIO = 'CLIENTES POR VENDEDOR') then
                                                  AlterarVisibleDet([PVendedor,PSitCliente,PCidade,PEstado,PPreposto, PClienteMaster,PTipoCadastroCliente],true)
                                                else
                                                  if (VPANOMRELATORIO = 'TOTAL VENDAS POR CLIENTE') or
                                                     (VPANOMRELATORIO = 'TOTAL VENDAS POR CLIENTE(CURVA ABC)')then
                                                    AlterarVisibleDet([PFilial,PVendedor,PSitCliente,PPeriodo,PCondPgto,PTipoCotacao,PCidade,PEstado,PClienteAtivo,PRepresentada],true)
                                                  else
                                                    if (VPANOMRELATORIO = 'CONTAS A RECEBER POR EMISSAO') or
                                                      (VPANOMRELATORIO = 'CONTAS A RECEBER POR EMISSAO FATURADO') then
                                                      AlterarVisibleDet([PFilial,PPeriodo,PVendedor],true)
                                                    else
                                                      if (VPANOMRELATORIO = 'TOTAL AMOSTRAS POR VENDEDOR') then
                                                        AlterarVisibleDet([PVendedor,PPeriodo],true)
                                                      else
                                                        if (VPANOMRELATORIO = 'POR PLANO DE CONTAS SINTETICO') or
                                                           (VPANOMRELATORIO = 'POR PLANO DE CONTAS SINTETICO POR MES') then
                                                          AlterarVisibleDet([PFilial, PPeriodo,PTipoPeriodo],true)
                                                      else
                                                        if (VPANOMRELATORIO = 'PROSPECTS POR CEP') then
                                                        begin
                                                          AlterarVisibleDet([PCheckBox1],true);
                                                          CheckBox1.Caption := 'Somente prospects não visitados';
                                                        end
  else
    if (VPANOMRELATORIO = 'EM ABERTO POR VENDEDOR') then
    begin
      AlterarVisibleDet([PFilial,PVendedor,PDataFinal,PFundoPerdido],true);
      LDataFinal.Caption := 'Vencimento até :';
    end
    else
      if (VPANOMRELATORIO = 'PRODUTOS VENDIDOS E TROCADOS') then
        AlterarVisibleDet([PFilial,PVendedor,PCliente,PClienteMaster,PTipoCotacao,PPeriodo],true)
      else
        if (VPANOMRELATORIO = 'TABELA PRECO PRODUTOS') then
        begin
          AlterarVisibleDet([PTabelaPreco,PCliente,PClassificacaoProduto,PCheckBox1,POrdemRelatorio],true);
          CheckBox1.Caption := 'Agrupar por Classificação';
          CheckBox1.Checked := true;
        end
        else
          if (VPANOMRELATORIO = 'VENDAS POR VENDEDOR') then
            AlterarVisibleDet([PFilial,PPeriodo,PCliente,PVendedor,PTipoCotacao],true)
          else
          if (VPANOMRELATORIO = 'VENDEDORES') then
            AlterarVisibleDet([PVendedor,PCidade,PEstado],true)
            else
            if (VPANOMRELATORIO = 'VENDAS POR TIPO COTACAO X CUSTO') then
              AlterarVisibleDet([PFilial,PPeriodo,PCliente,PVendedor,PTipoCotacao],true)
            else
              if (VPANOMRELATORIO = 'DIAS ORDEM DE CORTE') then
                AlterarVisibleDet([PPeriodo],true)
            else
              if (VPANOMRELATORIO = 'PRODUTOS VENDIDOS COM DEFEITO') then
                AlterarVisibleDet([PFilial,PVendedor,PCliente,PPeriodo,PClassificacaoProduto],true)
            else
              if (VPANOMRELATORIO = 'PROSPECTS CADASTRADOS POR VENDEDOR') then
                AlterarVisibleDet([PVendedor,PPeriodo,PRamoAtividade,PCidade,PMeioDivulgacao],true)
            else
              if (VPANOMRELATORIO = 'AGENDA USUARIO') then
              begin
                AlterarVisibleDet([PUsuario,PPeriodo,PSituacaoAgenda],true);
                ESituacaoAgenda.ItemIndex := 2;
              end
            else
              if (VPANOMRELATORIO = 'VENCIMENTO DOS CONTRATOS') then
              begin
                AlterarVisibleDet([PPeriodo,PVendedor,PCheckBox1],true);
                CheckBox1.Caption := 'Somente contratos não cancelados';
                CheckBox1.Checked := false;
              end
            else
              if (VPANOMRELATORIO = 'ANALISE CONTRATOS ANALITICO') or
                 (VPANOMRELATORIO = 'ANALISE CONTRATOS SINTETICO') then
              begin
                AlterarVisibleDet([PPeriodo,PTipoContrato,PCliente,PVendedor,PFundoPerdido],true);
                CFundoPerdido.Caption := 'Somente contratos não cancelados';
                CFundoPerdido.Checked := true;
              end
            else
              if (VPANOMRELATORIO = 'AMOSTRAS POR DESENVOLVEDOR') then
                AlterarVisibleDet([PPeriodo,PDesenvolvedor],true)
            else
              if (VPANOMRELATORIO = 'CLIENTES POR SITUACAO ANALITICO') or
                 (VPANOMRELATORIO = 'CLIENTES POR SITUACAO SINTETICO') then
                AlterarVisibleDet([PVendedor,PCidade],true)
            else
              if (VPANOMRELATORIO = 'CONTATO CLIENTE') or
                 (VPANOMRELATORIO = 'CLIENTES POR CIDADE E ESTADO ANALITICO') or
                 (VPANOMRELATORIO = 'CLIENTES POR CIDADE E ESTADO SINTETICO') then
                AlterarVisibleDet([PVendedor,PCidade,PEstado,PSitCliente,PRamoAtividade],true)
            else
              if (VPRNOMRELATORIO = 'CARTUCHO PESADO POR CELULA') or
                 (VPRNOMRELATORIO = 'ANALISE DE CARTUCHOS PESADOS') then
                AlterarVisibleDet([PPeriodo, PFilial],true)
            else
              if (VPRNOMRELATORIO = 'ANALISE PEDIDO REPRESENTADA ANUAL')then
                AlterarVisibleDet([PPeriodo,PCliente,PVendedor,PPreposto, PTipoCotacao,PRepresentada],true)
            else
              if (VPRNOMRELATORIO = 'CONTRATOS CLIENTES') then
                AlterarVisibleDet([PFilial,PTipoContrato,PCliente,PCidade],true)
              else
                if (VPRNOMRELATORIO = 'NUMEROS PENDENTES') then
                  AlterarVisibleDet([PFilial],true)
                else
                if (VPRNOMRELATORIO = 'ESTOQUE CHAPA') then
                  AlterarVisibleDet([PProduto],true)
                else
                if (VprNomRelatorio = 'TABELA CARTUCHOS PESADOS POR CELULA') then
                begin
                  AlterarVisibleDet([PProduto,PDataFinal],true);
                  LDataFinal.Caption := 'Mês : ';
                end
                else
                if (VPRNOMRELATORIO = 'REQUISICAO AMOSTRA FALTAM FINALIZAR') then
                  AlterarVisibleDet([PVendedor,PCliente],true)
                else
                if (VPRNOMRELATORIO = 'PAGAMENTO FACCIONISTA') then
                  AlterarVisibleDet([PPeriodo,PFaccionista,PDistribuicaoFaccionista,PFuncionarios],true)
                else
                if (VPRNOMRELATORIO = 'TABELA AMOSTRAS POR DESENVOLVEDOR') then
                begin
                  LDataFinal.Caption := 'Mês : ';
                  AlterarVisibledet([PDataFinal,PDesenvolvedor], true);
                end
                else
                if (VPRNOMRELATORIO = 'TOTAL AMOSTRAS POR CLIENTES VENDEDOR') then
                  AlterarVisibledet([PVendedor,PCliente,PPeriodo], true)
                else
                if (VPRNOMRELATORIO = 'PRODUTOS RESERVAS POR CLIENTE') then
                  AlterarVisibledet([PCliente], true)
                else
                if (VPRNOMRELATORIO = 'RESULTADO FINANCEIRO ORCADO') then
                begin
                  AlterarVisibledet([PFilial,PDataFinal,PTipoPeriodo], true);
                  LDataFinal.Caption := 'Mês :';
                end
                else
                if (VPRNOMRELATORIO = 'AMOSTRAS POR VENDEDOR') then
                  AlterarVisibledet([PPeriodo,PVendedor,PCliente], true)
                else
                if (VPRNOMRELATORIO = 'RELACAO COBRANCA POR BAIRRO') then
                  AlterarVisibledet([PSitCliente,PVendedor,PRamoAtividade], true)
                else
                if (VPRNOMRELATORIO = 'SERVICOS VENDIDOS POR CLASSIFICACAO') then
                  AlterarVisibleDet([PVendedor,PFilial,PCliente,PPeriodo,PTipoCotacao,PClienteMaster],true)
                else
                if (VPRNOMRELATORIO = 'CLIENTES POR REGIAO SINTETICO') then
                  AlterarVisibleDet([PSitCliente],true)
                else
                if (VPRNOMRELATORIO = 'CLIENTES COMPLETOS') then
                  AlterarVisibleDet([PCliente,PVendedor,PCidade, PEstado, PSitCliente,PRamoAtividade],true)
                else
                if (VPRNOMRELATORIO = 'NOTAS X ORDEM COMPRAS SINTETICO') then
                  AlterarVisibleDet([PPeriodo, PFilial, PCliente],true)
                else
                if (VPRNOMRELATORIO = 'DESTINO PRODUTO') then
                  AlterarVisibleDet([PPeriodo, PFilial, PCliente, PProduto,PClassificacaoProduto],true)
                else
                if (VPANOMRELATORIO = 'CLIENTES SEM HISTORICO TELEMARKETING') then
                  AlterarVisibleDet([PVendedor,PSitCliente,PPeriodo,PPreposto],true)
                else
                if (VPANOMRELATORIO = 'ENTREGA PRODUTOS SINTETICO') then
                begin
                  AlterarVisibleDet([PVendedor,PCliente,PPeriodo, PFilial,POrdemRelatorio],true);
                  EOrdemRelatorio.Clear;
                  EOrdemRelatorio.Items.Add('Dias');
                  EOrdemRelatorio.Items.Add('Quantidade Pedido');
                  EOrdemRelatorio.ItemIndex:=0;
                end
                else
                if (VPANOMRELATORIO = 'PRAZO ENTREGA REAL PRODUTOS') then
                begin
                  AlterarVisibleDet([PVendedor,PCliente,PPeriodo, PFilial,POrdemRelatorio],true);
                  EOrdemRelatorio.Clear;
                  EOrdemRelatorio.Items.Add('Dias');
                  EOrdemRelatorio.Items.Add('Quantidade Pedido');
                  EOrdemRelatorio.ItemIndex:=0;
                end
                else
                if (VPANOMRELATORIO = 'CONTROLE FRETE') then
                begin
                  AlterarVisibleDet([PTransportadora,PPeriodo,PFilial,PCliente],true);
                end
                else
                if (VPANOMRELATORIO = 'FATURAMENTO PRODUTOS') then
                begin
                  AlterarVisibleDet([PProduto,PCliente,PPeriodo,PFilial],true);
                end
                else
                if (VPANOMRELATORIO = 'PEDIDO COMPRA') then
                begin
                  AlterarVisibleDet([PPeriodo,PFilial],true);
                end
                else
                if (VPANOMRELATORIO = 'CONTROLE ENTREGA DE AMOSTRAS') or
                   (VPANOMRELATORIO = 'CONTROLE ENTREGA DE AMOSTRAS ANALITICO') then
                begin
                  AlterarVisibleDet([PPeriodo, PFilial,POrdemRelatorio],true);
                  EOrdemRelatorio.Clear;
                  EOrdemRelatorio.Items.Add('Dias');
                  EOrdemRelatorio.Items.Add('Quantidade Pedido');
                  EOrdemRelatorio.ItemIndex:=0;
                end
                else
                if (VPANOMRELATORIO = 'ANALISE PEDIDO ANUAL POR CLASSIFICACAO PRODUTO') then
                begin
                  AlterarVisibleDet([PPeriodo,PFilial,PTipoCotacao,PCliente,PClassificacaoProduto,PCheckBox1],true);
                  CheckBox1.Caption := 'Imprimir Classificação';
                end
                else
                if (VPANOMRELATORIO = 'CLIENTES CADASTRADOS') then
                  AlterarVisibleDet([PTipoCadastroCliente,PVendedor,PRamoAtividade,PCidade,PPeriodo],true)
                else
                if (VPANOMRELATORIO = 'CLIENTES POR MEIO DIVULGACAO SINTETICO') then
                  AlterarVisibleDet([PTipoCadastroCliente,PVendedor,PPeriodo,PCidade,PEstado],true)
                else
                if (VPANOMRELATORIO = 'PEDIDOS POR ESTAGIO') then
                  AlterarVisibleDet([PFilial,PPeriodo,PEstagio,PCliente,PVendedor],true)
                else
                if (VPANOMRELATORIO = 'LIVRO DE REGISTRO DE SAIDAS') or
                   (VPANOMRELATORIO = 'LIVRO DE REGISTRO DE ENTRADAS') then
                  AlterarVisibleDet([PFilial,PPeriodo,PCliente],true)
                else
                if (VPANOMRELATORIO = 'PEDIDOS PRODUTOS POR PERIODO') then
                  AlterarVisibleDet([PFilial,PPeriodo,PCliente],true)
                else
                if (VPANOMRELATORIO = 'PRODUTOS FORNECEDOR') then
                  AlterarVisibleDet([PCliente],true)
                else
                if (VPANOMRELATORIO = 'AMOSTRAS ENTREGUES E NAO APROVADAS') then
                  AlterarVisibleDet([PPeriodo,PCliente],true)
                else
                if (VPANOMRELATORIO = 'PRODUTOS FATURADOS ST COM TRIBUTACAO') or
                   (VPANOMRELATORIO = 'PRODUTOS FATURADOS ST COM TRIBUTACAO POR REGIAO') then
                  AlterarVisibleDet([PPeriodo,PFilial],true)
                else
                if (VPANOMRELATORIO = 'PRODUTOS FATURADOS POR PERIODO') then
                  AlterarVisibleDet([PPeriodo,PFilial,Pcliente,Pvendedor],true)
                else
                if (VPANOMRELATORIO = 'LIMITE DE CREDITO') then
                begin
                  AlterarVisibleDet([Pcliente,PFaixa],true);
                  LFaixaInicial.Caption := 'Limite Inicial :';
                  LFaixaFinal.Caption := 'Limite Final : ';
                end
                else
                if (VPANOMRELATORIO = 'RESULTADO FINANCEIRO ORCADO CONSOLIDADO') or
                   (VPANOMRELATORIO = 'RESULTADO FINANCEIRO ORCADO CONSOLIDADO POR CENTRO DE CUSTO') then
                  AlterarVisibleDet([PFilial,PPeriodo,PTipoPeriodo],true)
                else
                if (VPANOMRELATORIO = 'ANALISE RENOVACAO CONTRATOS')  then
                begin
                  AlterarVisibleDet([PPeriodo,PVendedor],true);
                  CPeriodo.Caption := 'Fim Vigencia :';
                end
                else
                if (VPANOMRELATORIO = 'RECIBOS EMITIDOS')  then
                  AlterarVisibleDet([PPeriodo,PFilial,PCliente],true)
                else
                if (VPANOMRELATORIO = 'PROPOSTAS ANALITICO') then
                  AlterarVisibleDet([PCliente,PFilial,PVendedor,PPeriodo,PCidade,PEstado,PSetor,PClassificacaoProduto],true)
                else
                if (VpaNomRelatorio = 'MOTIVO ATRASO AMOSTRA POR PERIODO') then
                  AlterarVisibleDet([PPeriodo], true)
                else
                if (VpaNomRelatorio = 'NOTAS DE ENTRADA') then
                  AlterarVisibleDet([PFilial,Pcliente,PPeriodo],true)
                else
                if (VpaNomRelatorio = 'CONHECIMENTO DE TRANSPORTE ENTRADA') then
                  AlterarVisibleDet([PFilial,PTransportadora,PPeriodo],true)
                else
                if (VpaNomRelatorio = 'CONHECIMENTO DE TRANSPORTE SAIDA') then
                  AlterarVisibleDet([PFilial,PTransportadora,PPeriodo],true)
                else
                if (VpaNomRelatorio = 'HISTORICO CONSUMO PRODUTO PRODUCAO') then
                  AlterarVisibleDet([PProduto,PClassificacaoProduto,PPeriodo],true)
                else
                if (VpaNomRelatorio = 'CONSUMO PRODUTO PRODUCAO') then
                begin
                  AlterarVisibleDet([PPeriodo,PClassificacaoProduto,PFilial,PFundoPerdido,PCheckBox1,POrdemRelatorio, PProduto],true);
                  CFundoPerdido.Caption := 'Somente Produtos com Consumo';
                  CFundoPerdido.Checked := true;
                  Checkbox1.Caption := 'Somente Produtos que Possuem Qtd em Estoque';
                  CheckBox1.Checked := false;
                end;
end;


{******************************************************************************}
procedure TFRelPedido.BImprimirClick(Sender: TObject);
Var
  VpfNomCampo : String;
  VpfPdf, VpfRTF : Boolean;
begin
  VpfPdf := (TBitBtn(sender).Tag = 20);
  if VpfPdf then
    if not SaveDialog.Execute then
      exit;
  VpfRTF := (TBitBtn(sender).Tag = 30);
  if VpfRTF then
    if not SaveDialogRTF.Execute then
      exit;

  dtRave := TdtRave.create(self);
  dtRave.VplArquivoPDF := '';
  FunRave.VplArquivoPDF := '';
  if VpfPdf then
  begin
    dtRave.VplArquivoPDF := SaveDialog.FileName;
    FunRave.VplArquivoPDF := SaveDialog.FileName;
  end;

  if VpfRTF then
  begin
    dtRave.VplArquivoRTF := SaveDialogRTF.FileName;
    FunRave.VplArquivoRTF := SaveDialogRTF.FileName;
  end;

  if (VPRNOMRELATORIO = 'NOTAS FISCAIS EMITIDAS') then
    dtRave.ImprimeNotasFiscaisEmitidas(CDataIni.Date,CdataFim.Date,EFilial.AInteiro,ECliente.AInteiro,EClienteMaster.AInteiro, EVendedor.Ainteiro,VprCaminhoRelatorio,LFilial.Caption,LCliente.caption,lVendedor.caption,ESituacaoCotacao.itemindex)
  else
    if (VPRNOMRELATORIO = 'PEDIDOS POR DIA') then
      dtRave.ImprimePedidosPorDia(CDataIni.Date,CdataFim.Date,EFilial.AInteiro,ECliente.AInteiro,EVendedor.Ainteiro,ETipoCotacao.Ainteiro,RFlagSituacao.Itemindex,ECondPgto.AInteiro, VprSeqProduto , ERepresentada.AInteiro, EPreposto.AInteiro, VprCaminhoRelatorio,LFilial.Caption,LCliente.caption,lVendedor.caption,LTipoCotacao.Caption,RFlagSituacao.Items.Strings[RFlagSituacao.Itemindex],LCondPgto.Caption, LProduto.Caption,LRepresentada.Caption,LPreposto.Caption,ECodClassifcacao.Text,LNomClassificacao.Caption,EEstado.Text)
    else
      if (VPRNOMRELATORIO = 'PRODUTOS VENDIDOS POR CLASSIFICACAO') then
        FunRave.ImprimeProdutoVendidosPorClassificacao(EFilial.AInteiro,ECliente.AInteiro,EVendedor.Ainteiro,ETipoCotacao.Ainteiro,EClienteMaster.AInteiro,CDataIni.Date,CdataFim.Date,VprCaminhoRelatorio,LFilial.Caption,LCliente.caption,lVendedor.caption,LTipoCotacao.Caption,LClienteMaster.Caption, false,false,TBitBtn(Sender).Tag = 20 )
      else
        if (VPRNOMRELATORIO = 'CLIENTES SEM PEDIDO') then
          dtRave.ImprimeClientesSemPedido(EVendedor.AInteiro,EPreposto.AInteiro, ESituacaoCliente.AInteiro,ETipoCotacao.AInteiro,ERepresentada.AInteiro,CDataFinal.Date,CDataIni.Date,CDataFim.Date,LVendedor.Caption,LPreposto.Caption,LSituacaoCliente.Caption,LTipoCotacao.Caption,LRepresentada.Caption,VprCaminhoRelatorio, CSomenteClienteAtivo.Checked,CPeriodo.Checked)
        else
          if (VPRNOMRELATORIO = 'LEITURA DOS CONTRATOS') then
            dtRave.ImprimeLeituraContratos(ECliente.Ainteiro,ETecnico.AInteiro,ECodTipoContrato.AInteiro, ENumerico1.AsInteger,0,0, VprCaminhoRelatorio,
                                           LCliente.caption,LTecnico.Caption,LNomTipoContrato.Caption)
          else
            if (VPRNOMRELATORIO = 'ESTOQUE PRODUTOS') then
              FunRave.ImprimeEstoqueProdutos(EFilial.AInteiro,VprCaminhoRelatorio,ECodClassifcacao.Text,'TOTAL',LFilial.caption,LNomClassificacao.Caption,CFundoPerdido.Checked,CheckBox1.Checked,EOrdemRelatorio.ItemIndex, VprSeqProduto)
            else
              if (VPRNOMRELATORIO = 'VENDA ANALITICO') then
                dtRave.ImprimeVendasAnalitico(EFilial.AInteiro,ECliente.Ainteiro,ECondPgto.AInteiro,ETipoCotacao.AInteiro,EVendedor.AInteiro,EPreposto.AInteiro,ERepresentada.AInteiro,
                                         CDataIni.DateTime,CDataFim.Date,VprCaminhoRelatorio,LCidade.Caption,EEstado.Text,LCliente.Caption,LCondPgto.Caption,
                                         LTipoCotacao.Caption,LVendedor.Caption,LFilial.Caption,LPreposto.Caption,LRepresentada.Caption)
            else
              if (VPRNOMRELATORIO = 'CONSISTENCIA DE ESTOQUE') then
                dtRave.ImprimeConsistenciadeEstoque(EFilial.AInteiro,VprSeqProduto,CDataIni.DateTime,CDataFim.Date,VprCaminhoRelatorio,
                                         LFilial.Caption,LProduto.Caption,CFundoPerdido.Checked)
              else
                if (VPRNOMRELATORIO = 'ESTOQUE MINIMO') then
                  FunRave.ImprimeQtdMinimasEstoque(EFilial.AInteiro,ECliente.AInteiro,VprCaminhoRelatorio,
                                           ECodClassifcacao.Text, LFilial.Caption,LNomClassificacao.Caption,LCliente.Caption)
                else
                  if (VPRNOMRELATORIO = 'ANALISE FATURAMENTO ANUAL') then
                    FunRave.ImprimeAnaliseFaturamentoMensal(EFilial.AInteiro,ECliente.AInteiro,EVendedor.AInteiro, EPreposto.AInteiro, ETipoCotacao.AInteiro,VprCaminhoRelatorio,
                                             LFilial.Caption,LCliente.Caption,LVendedor.Caption,LPreposto.Caption,LTipoCotacao.Caption, CDataIni.DateTime, CDataFim.Date,true)
                  else
                    if (VPRNOMRELATORIO = 'DEVOLUCOES PENDENTES') then
                      dtRave.ImprimeDevolucoesPendente(EFilial.AInteiro,ECliente.AInteiro,ETransportadora.AInteiro,ECodEstagio.AInteiro,EVendedor.AInteiro,VprSeqProduto,CDataFinal.Date,VprCaminhoRelatorio,
                                               LFilial.Caption,LCliente.Caption,LTransportadora.Caption,LEstagio.Caption,LVendedor.Caption, LProduto.Caption)
                  else
                    if (VPRNOMRELATORIO = 'ESTOQUE FISCAL') then
                      dtRave.ImprimeEstoqueFiscal(EFilial.AInteiro,VprSeqProduto,VprCaminhoRelatorio,
                                               LFilial.Caption,LProduto.Caption)
                    else
                      if (VPRNOMRELATORIO = 'ESTOQUE POR GRUPOS E PRODUTOS') then
                        FunRave.ImprimeFechamentoMes(EFilial.AInteiro,VprCaminhoRelatorio,LFilial.Caption,CDataFinal.Date,not CFundoPerdido.Checked)
                      else
                        if (VPRNOMRELATORIO = 'COTACOES EM ABERTO POR ESTAGIO') then
                          dtRave.ImprimePedidosEmAbertoPorEstagio(ECodEstagio.AInteiro,ETransportadora.AInteiro, VprCaminhoRelatorio,LEstagio.Caption,CDataIni.Date,CDataFim.Date)
                        else
                          if (VPRNOMRELATORIO = 'POR PLANO DE CONTAS ANALITICO') then
                          begin
                            FunRave.ImprimeContasAPagarPorPlanodeContas(EFilial.AInteiro,CDataIni.DateTime,CDataFim.DateTime,VprCaminhoRelatorio,LFilial.Caption,ETipoPeriodo.ItemIndex);
                          end
                          else
                            if (VPRNOMRELATORIO = 'PRODUTOS VENDIDOS POR CLASSIFICACAO E ESTADO') then
                              FunRave.ImprimeProdutoVendidosPorClassificacao(EFilial.AInteiro,ECliente.AInteiro,EVendedor.Ainteiro,ETipoCotacao.Ainteiro, EClienteMaster.AInteiro,CDataIni.Date,CdataFim.Date,VprCaminhoRelatorio,LFilial.Caption,LCliente.caption,lVendedor.caption,LTipoCotacao.Caption,LClienteMaster.Caption, true,false,TBitBtn(Sender).Tag = 20)
                            else
                              if (VPRNOMRELATORIO = 'PRODUTIVIDADE PRODUCAO') then
                                FunRave.ImprimeExtratoProdutividade(VprCaminhoRelatorio,CDataFinal.Date)
                              else
                                if (VPRNOMRELATORIO = 'TOTAL CLIENTES ATENDIDOS E PRODUTOS VENDIDOS POR VENDEDOR') then
                                  dtRave.ImprimeTotalClientesAtendidoseProdutosVendidosporVendedor(EClienteMaster.AInteiro,VprCaminhoRelatorio,LClienteMaster.Caption,CDataIni.Date,CDataFim.Date)
                                else
                                  if (VPRNOMRELATORIO = 'CUSTO PROJETO') then
                                    FunRave.ImprimeCustoProjeto(EProjeto.AInteiro,VprCaminhoRelatorio,LProjeto.Caption)
                                  else
                                    if (VPRNOMRELATORIO = 'ESTOQUE DE PRODUTOS POR TECNICO') then
                                      dtRave.ImprimeEstoqueProdutoporTecnico(ETecnico.AInteiro,VprCaminhoRelatorio,LTecnico.Caption)
                                    else
                                      if (VPRNOMRELATORIO = 'PRODUTOS RETORNADOS COM DEFEITO') then
                                        dtRave.ImprimeProdutosRetornadosComDefeito(ETecnico.AInteiro,VprCaminhoRelatorio,LTecnico.Caption,CDataIni.Date,CDataFim.Date)
                                      else
                                        if (VPRNOMRELATORIO = 'CONSISTENCIA RESERVA ESTOQUE') then
                                          dtRave.ImprimeConsistenciaReservaEstoque(VprSeqProduto,VprCaminhoRelatorio,LProduto.Caption,CDataIni.Date,CDataFim.Date)
                                        else
                                          if (VPRNOMRELATORIO = 'FILA CHAMADOS POR TECNICO') then
                                            dtRave.ImprimeFilaChamadosPorTecnico(ECodEstagio.AInteiro,ETecnico.AInteiro,VprCaminhoRelatorio,LEstagio.Caption,LTecnico.Caption,CDataIni.Date,CDataFim.Date)
                                          else
                                            if (VPRNOMRELATORIO = 'VENDAS POR ESTADO E CIDADE') then
                                              dtRave.ImprimeVendasPorEstadoeCidade(ECliente.AInteiro,ECondPgto.AInteiro,ETipoCotacao.AInteiro,ETransportadora.AInteiro, VprCaminhoRelatorio,LCliente.Caption,LCondPgto.Caption,LTipoCotacao.Caption,LCidade.CAPTION,EEstado.text, LTransportadora.Caption, CDataIni.Date,CDataFim.Date)
                                            else
                                              if (VPRNOMRELATORIO = 'TOTAL VENDAS POR ESTADO E CIDADE') then
                                                dtRave.ImprimeTotalVendasPorEstadoeCidade(ECliente.AInteiro,ECondPgto.AInteiro,ETipoCotacao.AInteiro,ETransportadora.AInteiro, VprCaminhoRelatorio,LCliente.Caption,LCondPgto.Caption,LTipoCotacao.Caption,LCidade.CAPTION,EEstado.text,LTransportadora.Caption, CDataIni.Date,CDataFim.Date)
                                              else
                                                if (VPRNOMRELATORIO = 'CLIENTES POR VENDEDOR') then
                                                  dtRave.ImprimeClientesPorVendedor(EVendedor.AInteiro,EPreposto.AInteiro, ESituacaoCliente.AInteiro, EClienteMaster.AInteiro,vprCaminhoRelatorio,LVendedor.Caption,LPreposto.Caption, LSituacaoCliente.Caption,LCidade.CAPTION,EEstado.text,CCliente.Checked,CFornecedor.Checked,CProspect.Checked,CHotel.Checked)
                                                else
                                                  if (VPRNOMRELATORIO = 'TOTAL VENDAS POR CLIENTE') then
                                                    dtRave.ImprimeTotalVendasCliente(EVendedor.AInteiro,ECondPgto.AInteiro,ETipoCotacao.AInteiro,EFilial.AInteiro,ESituacaoCliente.AInteiro,ERepresentada.AInteiro,vprCaminhoRelatorio,LVendedor.Caption,LCondPgto.Caption,LTipoCotacao.Caption,LFilial.Caption, LCidade.CAPTION,EEstado.text,LSituacaoCliente.Caption,LRepresentada.Caption, CDataIni.Date,CDataFim.Date,false,CSomenteClienteAtivo.Checked)
                                                  else
                                                    if (VPRNOMRELATORIO = 'TOTAL VENDAS POR CLIENTE(CURVA ABC)') then
                                                      dtRave.ImprimeTotalVendasCliente(EVendedor.AInteiro,ECondPgto.AInteiro,ETipoCotacao.AInteiro,EFilial.AInteiro,ESituacaoCliente.AInteiro,ERepresentada.AInteiro, vprCaminhoRelatorio,LVendedor.Caption,LCondPgto.Caption,LTipoCotacao.Caption,LFilial.Caption, LCidade.CAPTION,EEstado.text,LSituacaoCliente.Caption,LRepresentada.Caption,CDataIni.Date,CDataFim.Date,true,CSomenteClienteAtivo.Checked)
                                                  else
                                                    if (VPRNOMRELATORIO = 'ESTOQUE PRODUTOS RESERVADOS') then
                                                      FunRave.ImprimeEstoqueProdutosReservados(EFilial.AInteiro,VprCaminhoRelatorio,ECodClassifcacao.Text,'TOTAL',LFilial.caption,LNomClassificacao.Caption,CFundoPerdido.Checked)
                                                    else
                                                      if (VPRNOMRELATORIO = 'CONTAS A RECEBER POR EMISSAO') then
                                                        dtRave.ImprimeContasaReceberPorEmissao(EFilial.AInteiro,EVendedor.AInteiro, CDataIni.Date,CDataFim.Date, VprCaminhoRelatorio,LFilial.caption,LVendedor.Caption, BMostrarConta.Visible,false)
                                                      else
                                                        if (VPRNOMRELATORIO = 'TOTAL AMOSTRAS POR VENDEDOR') then
                                                          FunRave.ImprimeTotaAmostrasPorVendedor(EVendedor.AInteiro,VprCaminhoRelatorio,LVendedor.caption,CDataIni.Date,CDataFim.Date)
                                                        else
                                                          if (VPRNOMRELATORIO = 'POR PLANO DE CONTAS SINTETICO')then
                                                            FunRave.ImprimeContasAPagarPorPlanoContasSintetico(CDataIni.Date,CDataFim.Date,VprCaminhoRelatorio)
                                                          else
                                                            if (VPRNOMRELATORIO = 'TOTAL PROSPECTS POR RAMO ATIVIDADE') then
                                                              dtRave.ImprimeTotalProspectPorRamoAtividade(VprCaminhoRelatorio)
                                                            else
                                                              if (VPRNOMRELATORIO = 'PROSPECTS POR CEP') then
                                                                dtRave.ImprimeProspectPorCeP(CheckBox1.Checked,VprCaminhoRelatorio)
                                                              else
                                                                if (VPRNOMRELATORIO = 'NOTAS FISCAIS EMITIDAS POR NATUREZA OPERACAO') then
                                                                  dtRave.ImprimeNotasFiscaisEmitidasPorNaturezaOperacao(CDataIni.Date,CdataFim.Date,EFilial.AInteiro,ECliente.AInteiro,EClienteMaster.AInteiro, EVendedor.Ainteiro,VprCaminhoRelatorio,LFilial.Caption,LCliente.caption,lVendedor.caption,ESituacaoCotacao.itemindex)
                                                                else
                                                                  if (VPRNOMRELATORIO = 'EM ABERTO POR VENDEDOR') then
                                                                    dtRave.ImprimeContasAReceberEmAbertoPorVendedor(CDataFinal.Date,EVendedor.AInteiro,EFilial.AInteiro,VprCaminhoRelatorio,LFilial.Caption,lVendedor.caption,CFundoPerdido.Checked,BMostrarConta.Visible)
                                                                  else
                                                                    if (VPRNOMRELATORIO = 'PRODUTOS VENDIDOS E TROCADOS') then
                                                                      FunRave.ImprimeProdutosVendidoseTrocacos(EFilial.AInteiro,ETipoCotacao.AInteiro,ECliente.AInteiro,EVendedor.AInteiro,EClienteMaster.AInteiro,
                                                                                                               VprCaminhoRelatorio,LFilial.Caption,LVendedor.Caption,LTipoCotacao.Caption,LCliente.Caption,LClienteMaster.Caption,CDataIni.DateTime,CDataFim.DateTime)
  else
    if (VPRNOMRELATORIO = 'TABELA PRECO PRODUTOS') then
      FunRave.ImprimeTabelaPreco(ECliente.AInteiro,ECodTabelaPreco.AInteiro,VprCaminhoRelatorio,LCliente.Caption,LNomTabelaPreco.Caption,ECodClassifcacao.Text,LNomClassificacao.Caption,CheckBox1.Checked,EOrdemRelatorio.ItemIndex)
    else
      if (VPRNOMRELATORIO = 'VENDAS POR VENDEDOR') then
        dtRave.ImprimeVendasporVendedor(CDataIni.Date,CDataFim.Date,EFilial.AInteiro,ECliente.AInteiro, EVendedor.AInteiro,ETipoCotacao.AInteiro,VprCaminhoRelatorio,LFilial.Caption,LCliente.Caption,lVendedor.caption,LTipoCotacao.Caption)
      else
      if (VPRNOMRELATORIO = 'VENDEDORES') then
        dtRave.ImprimeRelacaoDeRepresentantes(EVendedor.AInteiro,VprCaminhoRelatorio,LVendedor.Caption,LCidade.Caption,EEstado.Text)
        else
        if (VPRNOMRELATORIO = 'POR PLANO DE CONTAS SINTETICO POR MES')then
          FunRave.ImprimeContasAPagarPorPlanoContasSinteticoMES(ETipoPeriodo.ItemIndex, EFilial.AInteiro , CDataIni.Date,CDataFim.Date,VprCaminhoRelatorio, LFilial.Caption)
        else
          if (VPRNOMRELATORIO = 'VENDAS POR TIPO COTACAO X CUSTO')then
            FunRave.ImprimeTotalTipoCotacaoXCusto(EFilial.AInteiro,ECliente.AInteiro,EVendedor.AInteiro,ETipoCotacao.AInteiro,VprCaminhoRelatorio,LFilial.Caption,LCliente.Caption,LVendedor.Caption,LTipoCotacao.Caption,CDataIni.DateTime,CDataFim.DateTime)
          else
            if (VPRNOMRELATORIO = 'TOTAL CLIENTES ATENDIDOS E PRODUTOS VENDIDOS') then
              dtRave.ImprimeTotalClientesAtendidoseProdutosVendidos(EClienteMaster.AInteiro,VprCaminhoRelatorio,LClienteMaster.Caption,CDataIni.Date,CDataFim.Date)
          else
            if (VPRNOMRELATORIO = 'DIAS ORDEM DE CORTE') then
              dtRave.ImprimeDiasCorte(CDataIni.Date,CDataFim.Date,VprCaminhoRelatorio)
          else
            if (VPRNOMRELATORIO = 'PEDIDOS POR CLIENTE') then
              dtRave.ImprimePedidosPorCliente(CDataIni.Date,CdataFim.Date,EFilial.AInteiro,ECliente.AInteiro,EVendedor.Ainteiro,ETipoCotacao.Ainteiro,RFlagSituacao.Itemindex,ECondPgto.AInteiro, VprCaminhoRelatorio,LFilial.Caption,LCliente.caption,lVendedor.caption,LTipoCotacao.Caption,RFlagSituacao.Items.Strings[RFlagSituacao.Itemindex],LCondPgto.Caption)
          else
            if (VPRNOMRELATORIO = 'PRODUTOS VENDIDOS COM DEFEITO')then
              FunRave.ImprimeProdutosVendidosComDefeito(EFilial.AInteiro,ECliente.AInteiro,EVendedor.AInteiro,CDataIni.Date,CDataFiM.Date,VprCaminhoRelatorio,LFilial.Caption,LCliente.Caption,LVendedor.Caption,ECodClassifcacao.Text,LNomClassificacao.Caption,VpfPdf)
          else
            if (VPRNOMRELATORIO = 'PROSPECTS CADASTRADOS POR VENDEDOR') then
              dtRave.ImprimeProspectCadastradosporVendedor(CDataIni.Date,CdataFim.Date,EVendedor.AInteiro,ERamoAtividade.AInteiro, EMeioDivulgacao.AInteiro, VprCaminhoRelatorio, lVendedor.caption,LRamoAtividade.Caption,DeletaEspacoDE(LCidade.Caption),LMeioDivulgacao.Caption)
          else
            if (VPRNOMRELATORIO = 'AGENDA USUARIO') then
              dtRave.ImprimeAgenda(ECodUsuario.AInteiro,ESituacaoAgenda.ItemIndex, VprCaminhoRelatorio,LNomUsuario.caption, ESituacaoAgenda.Text, CDataIni.Date,CdataFim.Date)
          else
            if (VPRNOMRELATORIO = 'VENCIMENTO DOS CONTRATOS') then
              dtRave.ImprimeVencimentoContratos(CDataIni.Date,CdataFim.Date,VprCaminhoRelatorio,EVendedor.AInteiro,LVendedor.Caption,CSomenteClienteAtivo.Checked,CPeriodo.Checked)
          else
            if (VPRNOMRELATORIO = 'RESUMO CAIXAS')then
              FunRave.ImprimeResumosCaixas(VprCaminhoRelatorio,VpfPdf)
          else
            if (VPRNOMRELATORIO = 'ANALISE CONTRATOS ANALITICO')then
              FunRave.ImprimeAnaliseContratosLocacao(ETipoCotacao.AInteiro,ECliente.AInteiro,EVendedor.AInteiro,VprCaminhoRelatorio,LNomTipoContrato.Caption,LVendedor.Caption,LCliente.Caption,CDataIni.Date,CDataFim.Date,CFundoPerdido.Checked,true)
          else
            if (VPRNOMRELATORIO = 'ANALISE CONTRATOS SINTETICO')then
              FunRave.ImprimeAnaliseContratosLocacao(ETipoCotacao.AInteiro,ECliente.AInteiro,EVendedor.AInteiro,VprCaminhoRelatorio,LNomTipoContrato.Caption,LVendedor.Caption,LCliente.Caption,CDataIni.Date,CDataFim.Date,CFundoPerdido.Checked,false)
            else
              if (VPRNOMRELATORIO = 'ANALISE PEDIDO ANUAL') then
                FunRave.ImprimeAnaliseFaturamentoMensal(EFilial.AInteiro,ECliente.AInteiro,EVendedor.AInteiro, EPreposto.AInteiro, ETipoCotacao.AInteiro, VprCaminhoRelatorio,
                                         LFilial.Caption,LCliente.Caption,LVendedor.Caption,LPreposto.Caption, LTipoCotacao.Caption, CDataIni.DateTime, CDataFim.Date,false)
            else
              if (VPRNOMRELATORIO = 'AMOSTRAS FALTAM FINALIZAR') then
                dtRave.ImprimeAmostrasqueFaltamFinalizar
            else
              if (VPRNOMRELATORIO = 'AMOSTRAS POR DESENVOLVEDOR') then
                dtRave.ImprimeQtdAmostrasPorDesenvolvedor(EDesenvolvedor.AInteiro,VprCaminhoRelatorio,LDesenvolvedor.Caption,CDataIni.Date,CDataFim.Date)
            else
              if (VPRNOMRELATORIO = 'CLIENTES POR SITUACAO ANALITICO') then
                dtRave.ImprimeClientesPorSituacaoAnalitico(EVendedor.AInteiro, VprCaminhoRelatorio, LCidade.Caption, LVendedor.Caption)
            else
              if (VPRNOMRELATORIO = 'CLIENTES POR SITUACAO SINTETICO') then
                dtRave.ImprimeClientesPorSituacaoSintetico(EVendedor.AInteiro, VprCaminhoRelatorio, LCidade.Caption, LVendedor.Caption)
            else
              if (VPRNOMRELATORIO = 'CONTATO CLIENTE') then
                dtRave.ImprimeContatoCliente(EVendedor.AInteiro, ESituacaoCliente.AInteiro, VprCaminhoRelatorio, LCidade.Caption, EEstado.Text, LVendedor.Caption, LSituacaoCliente.Caption)
            else
              if (VPRNOMRELATORIO = 'CLIENTES POR CIDADE E ESTADO ANALITICO') then
                dtRave.ImprimeClientesPorCidadeEEstadoAnalitico(EVendedor.AInteiro, ESituacaoCliente.AInteiro,ERamoAtividade.AInteiro,VprCaminhoRelatorio, LCidade.Caption, EEstado.Text, LVendedor.Caption, LRamoAtividade.Caption, LSituacaoCliente.Caption)
            else
              if (VPRNOMRELATORIO = 'CLIENTES POR CIDADE E ESTADO SINTETICO') then
                dtRave.ImprimeClientesPorCidadeEEstadoSintetico(EVendedor.AInteiro, ESituacaoCliente.AInteiro, VprCaminhoRelatorio, LCidade.Caption, EEstado.Text, LVendedor.Caption, LSituacaoCliente.Caption)
            else
              if (VPRNOMRELATORIO = 'CARTUCHO PESADO POR CELULA') then
                dtRave.ImprimeCartuchoPesadoPorCelula(EFilial.AInteiro, CDataIni.Date, CDataFim.Date, LFilial.Caption,VprCaminhoRelatorio)
            else
              if (VPRNOMRELATORIO = 'ANALISE PEDIDO REPRESENTADA ANUAL') then
                FunRave.ImprimeAnalisePedidosMensal(EFilial.AInteiro,ECliente.AInteiro,EVendedor.AInteiro, EPreposto.AInteiro, ETipoCotacao.AInteiro,ERepresentada.AInteiro, VprCaminhoRelatorio,
                                             LFilial.Caption,LCliente.Caption,LVendedor.Caption,LPreposto.Caption,LTipoCotacao.Caption,LRepresentada.Caption, CDataIni.DateTime, CDataFim.Date)
            else
              if (VPRNOMRELATORIO = 'NUMEROS PENDENTES') then
                dtRave.ImprimeNumerosPendentes(EFilial.AInteiro,VprCaminhoRelatorio, LFilial.Caption)
            else
              if (VPRNOMRELATORIO = 'CONTRATOS CLIENTES') then
                dtRave.ImprimeContratosClientes(EFilial.AInteiro, ECliente.AInteiro, ECodTipoContrato.AInteiro, VprCaminhoRelatorio, LFilial.Caption, LCidade.Caption,
                                         LCliente.Caption, LNomTipoContrato.Caption)
            else
              if (VPRNOMRELATORIO = 'ESTOQUE CHAPA') then
                dtRave.ImprimeEstoqueChapa(VprSeqProduto,VprCaminhoRelatorio, EProduto.Text,LProduto.Caption)
            else
              if (VprNomRelatorio = 'TABELA CARTUCHOS PESADOS POR CELULA') then
                FunRave.ImprimeCartuchosPesadosPorCelulaTrabalho(0,VprSeqProduto, VprCaminhoRelatorio, '', EProduto.Text, LProduto.Caption, CDataFinal.DateTime)
            else
              if (VPRNOMRELATORIO = 'REQUISICAO AMOSTRA FALTAM FINALIZAR') then
                dtRave.ImprimeRequisicaoAmostrasqueFaltamFinalizar(ECliente.AInteiro,EVendedor.AInteiro,VprCaminhoRelatorio, LCliente.Caption ,LVendedor.Caption)
            else
              if (VPRNOMRELATORIO = 'PAGAMENTO FACCIONISTA') then
                FunRave.ImprimePagamentoFaccionista(EFaccionista.AInteiro,VprCaminhoRelatorio,LFaccionista.Caption,CDataIni.Date,CDataFim.Date,CBuscaNaEmpresa.Checked,CEmpresaLeva.Checked,CTodosDistribuicao.Checked,CFuncionarios.Checked,CNaoFuncionarios.Checked)
            else
              if (VPRNOMRELATORIO = 'TABELA AMOSTRAS POR DESENVOLVEDOR') then
                FunRave.ImprimeAmostrasPorDesenvolverdor(EDesenvolvedor.AInteiro, VprCaminhoRelatorio, LDesenvolvedor.Caption, CDataFinal.DateTime)
            else
              if (VPRNOMRELATORIO = 'TOTAL AMOSTRAS POR CLIENTES VENDEDOR') then
                FunRave.ImprimeTotalAmostrasPorClienteVendedor(EVendedor.AInteiro,ECliente.AInteiro, VprCaminhoRelatorio,LVendedor.caption,LCliente.Caption, CDataIni.Date,CDataFim.Date)
            else
              if (VPRNOMRELATORIO = 'PRODUTOS RESERVAS POR CLIENTE') then
                dtRave.ImprimeProdutosReservasPorCliente(ECliente.AInteiro, VprCaminhoRelatorio, LCliente.Caption)
            else
              if (VPRNOMRELATORIO = 'RESULTADO FINANCEIRO ORCADO') then
                FunRave.ImprimeResultadoFinanceiroOrcado(ETipoPeriodo.ItemIndex, EFilial.AInteiro,CDataFinal.DateTime,VprCaminhoRelatorio,LFilial.Caption )
            else
              if (VPRNOMRELATORIO = 'AMOSTRAS POR VENDEDOR') then
                dtRave.ImprimeAmostrasPorVendedor(ECliente.AInteiro,EVendedor.AInteiro, VprCaminhoRelatorio, LCliente.Caption,LVendedor.Caption,CDataIni.Date,CDataFim.Date)
            else
              if (VPRNOMRELATORIO = 'RELACAO COBRANCA POR BAIRRO') then
                FunRave.ImprimeRelatorioClientesXCobrancaporBairro(EVendedor.AInteiro,ESituacaoCliente.AInteiro, ERamoAtividade.AInteiro, VprCaminhoRelatorio, LVendedor.Caption,LSituacaoCliente.Caption, LRamoAtividade.Caption)
            else
              if (VPRNOMRELATORIO = 'CONTAS A RECEBER POR EMISSAO FATURADO') then
                dtRave.ImprimeContasaReceberPorEmissao(EFilial.AInteiro,EVendedor.AInteiro, CDataIni.Date,CDataFim.Date, VprCaminhoRelatorio,LFilial.caption,LVendedor.Caption, BMostrarConta.Visible,true)
              else
              if (VPRNOMRELATORIO = 'SERVICOS VENDIDOS POR CLASSIFICACAO') then
                FunRave.ImprimeServicosVendidosPorClassificacao(EFilial.AInteiro,ECliente.AInteiro,EVendedor.Ainteiro,ETipoCotacao.Ainteiro,EClienteMaster.AInteiro,CDataIni.Date,CdataFim.Date,VprCaminhoRelatorio,LFilial.Caption,LCliente.caption,lVendedor.caption,LTipoCotacao.Caption,LClienteMaster.Caption, TBitBtn(Sender).Tag = 20 )
            else
              if (VPRNOMRELATORIO = 'CLIENTES POR REGIAO SINTETICO') then
                dtRave.ImprimeClientesPorRegiaoSintetico(ESituacaoCliente.AInteiro,VprCaminhoRelatorio,LSituacaoCliente.Caption)
            else
              if (VPRNOMRELATORIO = 'CLIENTES COMPLETOS') then
                dtRave.ImprimeClientesCompletos(EVendedor.AInteiro, ESituacaoCliente.AInteiro,ERamoAtividade.AInteiro , VprCaminhoRelatorio, LCidade.Caption, Label5.Caption, EVendedor.Text, LCliente.Caption, LSituacaoCliente.Caption,LRamoAtividade.Caption)
            else
              if (VPRNOMRELATORIO = 'NOTAS X ORDEM COMPRAS SINTETICO') then
                dtRave.ImprimeNotasXOrdemCompra(EFilial.AInteiro, ECliente.AInteiro, CDataIni.Date, CDataFim.Date, VprCaminhoRelatorio)
            else
              if (VPRNOMRELATORIO = 'DESTINO PRODUTO') then
                dtRave.ImprimeDestinoProduto(EFilial.AInteiro, ECliente.AInteiro, EProduto.AInteiro,VprSeqProduto,CDataIni.Date, CDataFim.Date, VprCaminhoRelatorio, LProduto.Caption, LCliente.Caption,ECodClassifcacao.Text,LNomClassificacao.Caption)
            else
              if (VPRNOMRELATORIO = 'CLIENTES SEM HISTORICO TELEMARKETING') then
                dtRave.ImprimeClientesSemHistorico(EVendedor.AInteiro, EPreposto.AInteiro, ESituacaoCliente.AInteiro,CDataIni.Date,CDataFim.Date, LVendedor.Caption, LPreposto.Caption, LSituacaoCliente.Caption, LTipoCotacao.Caption,VprCaminhoRelatorio)
            else
              if (VPRNOMRELATORIO = 'ENTREGA PRODUTOS SINTETICO') then
                FunRave.ImprimePedidosAtrasados(EVendedor.AInteiro, ECliente.AInteiro,EFilial.AInteiro, EOrdemRelatorio.ItemIndex, LVendedor.Caption, LCliente.Caption, VprCaminhoRelatorio,LFilial.Caption,CDataIni.Date, CDataFim.Date)
            else
              if (VPRNOMRELATORIO = 'PRAZO ENTREGA REAL PRODUTOS') then
                FunRave.ImprimePrazoRealPedidos(EVendedor.AInteiro, ECliente.AInteiro,EFilial.AInteiro, EOrdemRelatorio.ItemIndex, LVendedor.Caption, LCliente.Caption, VprCaminhoRelatorio,LFilial.Caption,CDataIni.Date, CDataFim.Date)
            else
              if (VPRNOMRELATORIO = 'CONTROLE FRETE') then
                dtRave.ImprimeControleFrete(ETransportadora.AInteiro,ECliente.AInteiro,EFilial.AInteiro,CDataIni.Date,CDataFim.Date, LTransportadora.Caption, LCliente.Caption,LFilial.Caption ,VprCaminhoRelatorio)
            else
              if (VPRNOMRELATORIO = 'FATURAMENTO PRODUTOS') then
                dtRave.ImprimeFaturamentoProdutos(VprSeqProduto,ECliente.AInteiro,EFilial.AInteiro,CDataIni.Date,CDataFim.Date, LProduto.Caption, LCliente.Caption,LFilial.Caption ,VprCaminhoRelatorio)
            else
              if (VPRNOMRELATORIO = 'PEDIDO COMPRA') then
                dtRave.ImprimeRelatorioPedidoCompra(CDataIni.Date,CDataFim.Date,EFilial.AInteiro,LFilial.Caption ,VprCaminhoRelatorio)
            else
              if (VPRNOMRELATORIO = 'CONTROLE ENTREGA DE AMOSTRAS') then
                FunRave.ImprimeConsumoEntregaAmostra(EOrdemRelatorio.ItemIndex,VprCaminhoRelatorio,CDataIni.Date, CDataFim.Date,false)
            else
              if (VPRNOMRELATORIO = 'CONTROLE ENTREGA DE AMOSTRAS ANALITICO') then
                FunRave.ImprimeConsumoEntregaAmostra(EOrdemRelatorio.ItemIndex,VprCaminhoRelatorio,CDataIni.Date, CDataFim.Date,true)
            else
              if (VPRNOMRELATORIO = 'ANALISE PEDIDO ANUAL POR CLASSIFICACAO PRODUTO') then
                FunRave.ImprimeAnalisePedidoporClassificacao(EFilial.AInteiro,ECliente.AInteiro,EVendedor.AInteiro,EPreposto.AInteiro,ETipoCotacao.AInteiro,VprCaminhoRelatorio,ECodClassifcacao.Text,LNomClassificacao.Caption, LFilial.Caption,LCliente.Caption,LVendedor.Caption,LPreposto.Caption,LTipoCotacao.Caption,CDataIni.Date,CDataFim.Date,CheckBox1.Checked)
            else
              if (VPRNOMRELATORIO = 'CLIENTES CADASTRADOS') then
                dtRave.ImprimeClientesCadastrados(EVendedor.AInteiro,ERamoAtividade.AInteiro,VprCaminhoRelatorio,LVendedor.Caption,LRamoAtividade.Caption,ECidade.Text,CPeriodo.Checked,CCliente.Checked,CProspect.Checked,CFornecedor.Checked,CHotel.Checked,CDataIni.DateTime,CDataFim.Date)
            else
              if (VPRNOMRELATORIO = 'CLIENTES POR MEIO DIVULGACAO SINTETICO') then
                dtRave.ImprimeClientesPorMeioDivulgacao(EVendedor.AInteiro,VprCaminhoRelatorio,LVendedor.Caption,LCidade.Caption,EEstado.Text,CCliente.Checked,CProspect.Checked,CPeriodo.Checked,CDataIni.Date,CDataFim.Date)
            else
              if (VPRNOMRELATORIO = 'PEDIDOS POR ESTAGIO') then
                dtRave.ImprimePedidosPorEstagio(CDataIni.Date, CDataFim.Date,EFilial.AInteiro,ECliente.AInteiro,EVendedor.AInteiro,ECodEstagio.AInteiro,VprCaminhoRelatorio,LFilial.Caption, LCliente.Caption, LVendedor.Caption)
            else
              if (VPRNOMRELATORIO = 'LIVRO DE REGISTRO DE SAIDAS') then
                FunRave.ImprimeLivroRegistroSaidas(EFilial.AInteiro,ECliente.AInteiro,LFilial.Caption,LCliente.Caption,VprCaminhoRelatorio,CDataIni.DateTime,CDataFim.Date,false)
            else
              if (VPRNOMRELATORIO = 'LIVRO DE REGISTRO DE ENTRADAS') then
                FunRave.ImprimeLivroRegistroSaidas(EFilial.AInteiro,ECliente.AInteiro,LFilial.Caption,LCliente.Caption,VprCaminhoRelatorio,CDataIni.DateTime,CDataFim.Date,true)
            else
              if (VPRNOMRELATORIO = 'PRODUTOS VENDIDOS EM KILO POR CLASSIFICACAO') then
                FunRave.ImprimeProdutoVendidosPorClassificacao(EFilial.AInteiro,ECliente.AInteiro,EVendedor.Ainteiro,ETipoCotacao.Ainteiro, EClienteMaster.AInteiro,CDataIni.Date,CdataFim.Date,VprCaminhoRelatorio,LFilial.Caption,LCliente.caption,lVendedor.caption,LTipoCotacao.Caption,LClienteMaster.Caption, false,true,TBitBtn(Sender).Tag = 20)
            else
               if (VPRNOMRELATORIO = 'PRODUTOS FORNECEDOR') then
                dtRave.ImprimeProdutoFornecedor(ECliente.AInteiro, VprCaminhoRelatorio,LCliente.caption)
            else
               if (VPRNOMRELATORIO = 'AMOSTRAS ENTREGUES E NAO APROVADAS') then
                dtRave.ImprimeAmostrasEntregueseNaoAprovadas(CDataIni.Date, CDataFim.Date,ECliente.AInteiro, VprCaminhoRelatorio,LCliente.caption)
            else
              if (VPRNOMRELATORIO = 'PRODUTOS FATURADOS ST COM TRIBUTACAO POR REGIAO') then
                FunRave.ImprimeProdutosFaturadosSTcomTributacaoPorNota(EFilial.AInteiro,CDataIni.Date, CDataFim.Date,LFilial.Caption,VprCaminhoRelatorio,true)
           else
              if (VPRNOMRELATORIO = 'PRODUTOS FATURADOS POR PERIODO') then
                FunRave.ImprimeProdutosFaturadosPorPeriodo(EFilial.AInteiro,ECliente.AInteiro,EVendedor.AInteiro, CDataIni.Date,CdataFim.Date,VprCaminhoRelatorio,LFilial.Caption,LCliente.caption,LVendedor.Caption,false)
           else
              if (VPRNOMRELATORIO = 'LIMITE DE CREDITO') then
                dtrave.ImprimeLimiteCredito(ECliente.AInteiro,VprCaminhoRelatorio,LCliente.caption,EFaixaInicial.AValor,EFaixaFinal.AValor ,true)
           else
              if (VPRNOMRELATORIO = 'RESULTADO FINANCEIRO ORCADO CONSOLIDADO') then
                FunRave.ImprimeResultadoFinanceiroOrcadoConsolidado(ETipoPeriodo.ItemIndex,EFilial.AInteiro,CDataIni.Date,CDataFim.Date,VprCaminhoRelatorio,LFilial.caption)
           else
              if (VPRNOMRELATORIO = 'RESULTADO FINANCEIRO ORCADO CONSOLIDADO POR CENTRO DE CUSTO') then
                FunRave.ImprimeResultadoFinanceiroOrcadoConsolidadoPorCentroCusto(ETipoPeriodo.ItemIndex,EFilial.AInteiro,CDataIni.Date,CDataFim.Date,VprCaminhoRelatorio,LFilial.caption)
           else
              if (VPRNOMRELATORIO = 'ANALISE RENOVACAO CONTRATOS') then
                FunRave.ImprimeAnaliseRenovacaoContrato(EVendedor.AInteiro,CDataIni.Date,CDataFim.Date,LVendedor.Caption, VprCaminhoRelatorio)
            else
              if (VPRNOMRELATORIO = 'PRODUTOS FATURADOS ST COM TRIBUTACAO') then
                FunRave.ImprimeProdutosFaturadosSTcomTributacaoPorNota(EFilial.AInteiro,CDataIni.Date, CDataFim.Date,LFilial.Caption,VprCaminhoRelatorio,false)
            else
              if (VPRNOMRELATORIO = 'CREDITO CLIENTE') then
                FunRave.ImprimeCreditoCliente(VprCaminhoRelatorio)
            else
              if (VprNomRelatorio = 'RECIBOS EMITIDOS') then
                dtRave.ImprimeRecibosEmitidos(CDataIni.Date,CdataFim.Date,EFilial.AInteiro,ECliente.AInteiro, VprCaminhoRelatorio,LFilial.Caption,LCliente.caption)
            else
              if (VPRNOMRELATORIO = 'PROPOSTAS ANALITICO') then
                dtRave.ImprimePropostaAnalitico(EFilial.AInteiro,ECliente.Ainteiro,ECondPgto.AInteiro,EVendedor.AInteiro,ESetor.AInteiro,CDataIni.DateTime,CDataFim.Date,VprCaminhoRelatorio,LCidade.Caption,EEstado.Text,LCliente.Caption,LCondPgto.Caption,LVendedor.Caption,LFilial.Caption,LSetor.Caption,ECodClassifcacao.Text,LNomClassificacao.Caption)
            else
              if (VprNomRelatorio = 'MOTIVO ATRASO AMOSTRA POR PERIODO') then
                dtRave.ImprimeMotivoAtrasoAmostra(CDataIni.DateTime,CDataFim.Date, VprCaminhoRelatorio)
            else
              if (VprNomRelatorio = 'NOTAS DE ENTRADA') then
                dtRave.ImprimeNotasFiscaisdeEntrada(CDataIni.Date,CdataFim.Date,EFilial.AInteiro,ECliente.AInteiro,VprCaminhoRelatorio,LFilial.Caption,LCliente.caption)
            else
              if (VprNomRelatorio = 'CONHECIMENTO DE TRANSPORTE ENTRADA') then
                dtRave.ImprimeConhecimentoTransporteEntrada(CDataIni.Date,CdataFim.Date,EFilial.AInteiro,ETransportadora.AInteiro,VprCaminhoRelatorio,LFilial.Caption,LCliente.caption)
            else
              if (VprNomRelatorio = 'CONHECIMENTO DE TRANSPORTE SAIDA') then
                dtRave.ImprimeConhecimentoTransporteSaida(CDataIni.Date,CdataFim.Date,EFilial.AInteiro,ETransportadora.AInteiro,VprCaminhoRelatorio,LFilial.Caption,LCliente.caption)
            else
              if (VprNomRelatorio = 'HISTORICO CONSUMO PRODUTO PRODUCAO') then
                FunRave.ImprimeHistoricoConsumoProdutoProducao(VprSeqProduto,EProduto.Text,LProduto.Caption, ECodClassifcacao.Text, LNomClassificacao.Caption, VprCaminhoRelatorio,CDataIni.Date,CdataFim.Date)
            else
              if (VprNomRelatorio = 'CONSUMO PRODUTO PRODUCAO') then
                FunRave.ImprimeConsumoProdutoProducao(EFilial.AInteiro,VprSeqProduto,EProduto.Text,LProduto.Caption, ECodClassifcacao.Text, LNomClassificacao.Caption,LFilial.Caption, VprCaminhoRelatorio,CDataIni.Date,CdataFim.Date,CheckBox1.Checked,EOrdemRelatorio.ItemIndex,CFundoPerdido.Checked);

  dtRave.free;
end;

{******************************************************************************}
procedure TFRelPedido.BFecharClick(Sender: TObject);
begin
  Self.Close;
end;

{******************************************************************************}
procedure TFRelPedido.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FunClassificacao.Free;
  FunRave.free;
  Action := caFree;
end;

{******************************************************************************}
procedure TFRelPedido.ECodTabelaPrecoSelect(Sender: TObject);
begin
  ECodTabelaPreco.ASelectValida.text := 'Select * from CADTABELAPRECO Where I_COD_TAB = @ ';
  ECodTabelaPreco.ASelectLocaliza.Text := 'Select * from CADTABELAPRECO Where C_NOM_TAB like ''@%''';
  if ECodempresa.Ainteiro <> 0 then
  begin
    ECodTabelaPreco.ASelectValida.text := ECodTabelaPreco.ASelectValida.text + ' and I_COD_EMP = '+ECodEmpresa.Text;
    ECodTabelaPreco.ASelectLocaliza.text := ECodTabelaPreco.ASelectLocaliza.text + ' and I_COD_EMP = '+ECodEmpresa.Text;
  end;
end;

{******************************************************************************}
procedure TFRelPedido.EProdutoSelect(Sender: TObject);
begin
  EProduto.ASelectValida.Text := 'Select '+Varia.CodigoProduto+',CAD.C_NOM_PRO, CAD.I_SEQ_PRO from CADPRODUTOS CAD, MOVQDADEPRODUTO MOV '+
                                 ' Where '+Varia.CodigoProduto + ' = ''@'' and CAD.C_ATI_PRO = ''S'''+
                                 ' AND MOV.I_SEQ_PRO = CAD.I_SEQ_PRO AND MOV.I_EMP_FIL = '+IntToStr(EFilial.AInteiro);
  EPRoduto.ASelectLocaliza.Text := 'Select '+Varia.CodigoProduto+',CAD.C_NOM_PRO, CAD.I_SEQ_PRO  from CADPRODUTOS CAD, MOVQDADEPRODUTO MOV '+
                                   ' Where CAD.C_NOM_PRO like  ''@%'' and C_ATI_PRO = ''S'''+
                                   ' AND MOV.I_SEQ_PRO = CAD.I_SEQ_PRO AND MOV.I_EMP_FIL = '+IntToStr(EFilial.AInteiro);

end;

{******************************************************************************}
procedure TFRelPedido.EProdutoRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
    VprSeqProduto := StrtoInt(Retorno1)
  else
    VprSeqProduto := 0;
end;

{******************************************************************************}
procedure TFRelPedido.BMostrarContaClick(Sender: TObject);
begin
  BMostrarConta.visible := false;
end;

procedure TFRelPedido.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift = [ssCtrl,ssAlt])  then
  begin
    if (key = 82) then
      VprPressionadoR := true
    else
      if VprPressionadoR then
      begin
        if (key = 77) then
          BMostrarConta.Visible := true;
        VprPressionadoR := false;
      end;
  end;

end;

{******************************************************************************}
procedure TFRelPedido.SpeedButton15Click(Sender: TObject);
begin
  LocalizaClassificacao;
end;

{******************************************************************************}
procedure TFRelPedido.ECodClassifcacaoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 114 then
    LocalizaClassificacao;

end;

{******************************************************************************}
procedure TFRelPedido.ECodClassifcacaoExit(Sender: TObject);
var
  VpfNomClassificacao : String;
begin
  if ECodClassifcacao.Text <> '' then
  begin
    if not FunClassificacao.ValidaClassificacao(ECodClassifcacao.Text,VpfNomClassificacao, 'P') then
    begin
       if not LocalizaClassificacao then
         ECodClassifcacao.SetFocus;
    end
    else
    begin
      LNomClassificacao.Caption := VpfNomClassificacao;
    end;
  end
  else
    LNomClassificacao.Caption := '';
end;

end.
