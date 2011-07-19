unit APropostasCliente;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Grids, DBGrids, Tabela, DBKeyViolation, Componentes1, ExtCtrls,
  PainelGradiente, ComCtrls, StdCtrls, Db, DBTables, Buttons, UnDados, UnProposta,
  UnProspect, Localizacao, Graficos, Mask, numericos, Menus, UnClientes,
  DBClient, UnClassificacao;

type
  TFPropostasCliente = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    GPropostas: TGridIndice;
    PanelColor2: TPanelColor;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    Label4: TLabel;
    Proposta: TSQL;
    DataProposta: TDataSource;
    BCadastrar: TBitBtn;
    BAlterar: TBitBtn;
    BConsultar: TBitBtn;
    BImprimir: TBitBtn;
    BEmail: TBitBtn;
    BFechar: TBitBtn;
    PGraficos: TCorPainelGra;
    BitBtn4: TBitBtn;
    PanelColor5: TPanelColor;
    Label17: TLabel;
    Label18: TLabel;
    BMeioDivulgacao: TBitBtn;
    BFechaGrafico: TBitBtn;
    BVendedor: TBitBtn;
    BProduto: TBitBtn;
    BData: TBitBtn;
    BFlag: TBitBtn;
    BCondicao: TBitBtn;
    BEstado: TBitBtn;
    GraficosTrio: TGraficosTrio;
    Label11: TLabel;
    SpeedButton4: TSpeedButton;
    LNomVendedor: TLabel;
    EVendedor: TEditLocaliza;
    BGraficos: TBitBtn;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    EEstagio: TEditLocaliza;
    ConsultaPadrao1: TConsultaPadrao;
    BGraEstagio: TBitBtn;
    Label7: TLabel;
    EProposta: Tnumerico;
    PopupMenu1: TPopupMenu;
    TelemarketingReceptivo1: TMenuItem;
    N1: TMenuItem;
    MAlterarEstagio: TMenuItem;
    N2: TMenuItem;
    MGerarCotao: TMenuItem;
    Label8: TLabel;
    SpeedButton3: TSpeedButton;
    Label9: TLabel;
    ESetor: TEditLocaliza;
    ECliente: TEditLocaliza;
    Label35: TLabel;
    SpeedButton11: TSpeedButton;
    Label34: TLabel;
    PropostaCODFILIAL: TFMTBCDField;
    PropostaSEQPROPOSTA: TFMTBCDField;
    PropostaDATPROPOSTA: TSQLTimeStampField;
    PropostaDATPREVISAOCOMPRA: TSQLTimeStampField;
    PropostaINDCOMPROU: TWideStringField;
    PropostaINDCOMPROUCONCORRENTE: TWideStringField;
    PropostaVALTOTAL: TFMTBCDField;
    PropostaI_COD_CLI: TFMTBCDField;
    PropostaC_NOM_PAG: TWideStringField;
    PropostaC_NOM_CLI: TWideStringField;
    PropostaNOMEST: TWideStringField;
    PropostaNOMSETOR: TWideStringField;
    N3: TMenuItem;
    MGerarFichaImplantao: TMenuItem;
    N4: TMenuItem;
    GerarPedidoCompra1: TMenuItem;
    N5: TMenuItem;
    ConsultaPedidoCompras1: TMenuItem;
    Aux: TSQL;
    Label5: TLabel;
    SpeedButton2: TSpeedButton;
    Label6: TLabel;
    EFilial: TEditLocaliza;
    EOrcamentoCompra: Tnumerico;
    BFiltros: TBitBtn;
    Label10: TLabel;
    CPeriodo: TCheckBox;
    PropostaDESMODELORELATORIO: TWideStringField;
    PropostaCODESTAGIO: TFMTBCDField;
    N6: TMenuItem;
    ConsultaChamados1: TMenuItem;
    ConsultaCotaes1: TMenuItem;
    PropostaINDFIN: TWideStringField;
    BExcluir: TBitBtn;
    N7: TMenuItem;
    Duplicar1: TMenuItem;
    ECidade: TRBEditLocaliza;
    Label3: TLabel;
    SpeedButton5: TSpeedButton;
    Label12: TLabel;
    EUF: TRBEditLocaliza;
    SpeedButton6: TSpeedButton;
    Label13: TLabel;
    PropostaC_CID_CLI: TWideStringField;
    Label14: TLabel;
    SpeedButton15: TSpeedButton;
    LNomClassificacao: TLabel;
    ECodClassifcacao: TEditColor;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EDatInicioExit(Sender: TObject);
    procedure BEmailClick(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure BConsultarClick(Sender: TObject);
    procedure BCadastrarClick(Sender: TObject);
    procedure BAlterarClick(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure BMeioDivulgacaoClick(Sender: TObject);
    procedure BGraficosClick(Sender: TObject);
    procedure BFechaGraficoClick(Sender: TObject);
    procedure BVendedorClick(Sender: TObject);
    procedure BProdutoClick(Sender: TObject);
    procedure BDataClick(Sender: TObject);
    procedure BFlagClick(Sender: TObject);
    procedure BCondicaoClick(Sender: TObject);
    procedure BEstadoClick(Sender: TObject);
    procedure BGraEstagioClick(Sender: TObject);
    procedure EPropostaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TelemarketingReceptivo1Click(Sender: TObject);
    procedure MAlterarEstagioClick(Sender: TObject);
    procedure MGerarCotaoClick(Sender: TObject);
    procedure MGerarFichaImplantaoClick(Sender: TObject);
    procedure GerarPedidoCompra1Click(Sender: TObject);
    procedure ConsultaPedidoCompras1Click(Sender: TObject);
    procedure BFiltrosClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure ConsultaChamados1Click(Sender: TObject);
    procedure ConsultaCotaes1Click(Sender: TObject);
    procedure PropostaAfterScroll(DataSet: TDataSet);
    procedure BduplicarClick(Sender: TObject);
    procedure Duplicar1Click(Sender: TObject);
    procedure BExcluirClick(Sender: TObject);
    procedure GPropostasOrdem(Ordem: string);
    procedure SpeedButton15Click(Sender: TObject);
    procedure ECodClassifcacaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ECodClassifcacaoExit(Sender: TObject);
  private
    { Private declarations }
    VprCodFilial,
    VprNumChamado,
    VprLanOrcamento : Integer;
    VprOrdem : String;
    VprDProposta : TRBDPropostaCorpo;
    VprDProspect : TRBDProspect;
    VprDCliente: TRBDCliente;
    FunProposta : TRBFuncoesProposta;
    VprPropostas : TList;
    FunClassificacao : TFuncoesClassificacao;
    function CarListaPropostasSelecionadas(VpaLista : TList): String;
    function ValidaDadosPropostaparaaCotacao(VpaLista : TList) : string;
    procedure AtualizaConsulta;
    procedure AdicionaFiltros(VpaSelect : TStrings);
    function RRodapeGrafico : String;
    procedure GraficoMeioDivulgacao;
    procedure GraficoVendedor;
    procedure GraficoCidade;
    procedure GraficoRamoAtividade;
    procedure GraficoProfissao;
    procedure GraficoData;
    procedure GraficoUF;
    procedure GraficoEstagio;
    procedure ConsultaOrcamentoCompras;
    procedure CarregaConfigPopup;
    function LocalizaClassificacao : boolean;
  public
    { Public declarations }
    procedure ConsultaPropostas(VpaCodCliente: Integer);
    Procedure ConsultaOrcamentoCompra(VpaCodFilial,VpaSeqSolicitacao : Integer);
    procedure ConsultaPropostasChamado(VpaCodFilial,VpaNumChamado : Integer);
    procedure ConsultaPropostasCotacao(VpaCodFilial,VpaLanOrcamento : Integer);
  end;

var
  FPropostasCliente: TFPropostasCliente;

implementation

uses APrincipal, funSql, funData, Constmsg, ANovaProposta, constantes,
  ANovoTelemarketingProspect, AAlteraEstagioProposta, ANovaCotacao,
  ANovoTeleMarketing, ANovoChamadoTecnico, ANovaSolicitacaoCompra,
  ASolicitacaoCompras, dmRave, FunObjeto, AChamadosTecnicos, ACotacao,
  ALocalizaClassificacao;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFPropostasCliente.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunProposta := TRBFuncoesProposta.cria(FPrincipal.BaseDados);
  FunClassificacao := TFuncoesClassificacao.criar(self,FPrincipal.BaseDados);
  VprDProposta := TRBDPropostaCorpo.cria;
  VprDProspect := TRBDProspect.cria;
  VprDCliente:= TRBDCliente.cria;
  VprPropostas := TList.Create;
  VprNumChamado := 0;
  VprLanOrcamento := 0;
  EDatInicio.Datetime := PrimeiroDiaMes(date);
  EDatFim.DAtetime := UltimoDiaMes(date);
  VprOrdem := ' order by PRO.DATPROPOSTA';
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFPropostasCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunProposta.Free;
  VprDProposta.free;
  VprDProspect.free;
  VprDCliente.Free;
  VprPropostas.Free;
  Proposta.close;
  FunClassificacao.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFPropostasCliente.AtualizaConsulta;
var
  VpfPosicao : TBookmark;
begin
  VpfPosicao := Proposta.GetBookmark;
  Proposta.close;

  Proposta.sql.clear;
  Proposta.Sql.add('select PRO.CODFILIAL, PRO.SEQPROPOSTA, PRO.DATPROPOSTA, PRO.DATPREVISAOCOMPRA,'+
                   ' PRO.INDCOMPROU, PRO.INDCOMPROUCONCORRENTE, PRO.VALTOTAL,PRO.CODESTAGIO,'+
                   ' CLI.I_COD_CLI,'+
                   ' CON.C_NOM_PAG,'+
                   ' CLI.C_NOM_CLI,CLI.C_CID_CLI,'+
                   ' EST.NOMEST, EST.INDFIN, '+
                   ' STR.NOMSETOR, STR.DESMODELORELATORIO'+
                   ' from PROPOSTA PRO, CADCONDICOESPAGTO CON, CADCLIENTES CLI, ESTAGIOPRODUCAO EST, SETOR STR'+
                   ' Where PRO.CODCONDICAOPAGAMENTO = CON.I_COD_PAG'+
                   ' AND PRO.CODCLIENTE = CLI.I_COD_CLI'+
                   ' AND PRO.CODESTAGIO = EST.CODEST'+
                   ' AND PRO.CODSETOR = STR.CODSETOR');
  AdicionaFiltros(Proposta.sql);
  Proposta.sql.add(VprOrdem);
  Proposta.open;
  GPropostas.ALinhaSQLOrderBy := Proposta.SQL.Count -1;
  try
    Proposta.GotoBookmark(VpfPosicao);
  except
  end;
  Proposta.FreeBookmark(VpfPosicao);
end;

{******************************************************************************}
procedure TFPropostasCliente.AdicionaFiltros(VpaSelect : TStrings);
begin
  if EProposta.AsInteger <> 0 then
    VpaSelect.Add(' AND SEQPROPOSTA = ' +EProposta.Text)
  else
  begin
    if CPeriodo.Checked then
      VpaSelect.add(SQLTextoDataEntreAAAAMMDD('DATPROPOSTA',EDatInicio.DateTime,IncDia(EDatFim.DateTime,1),true));
    if EVendedor.Ainteiro <> 0 then
      VpaSelect.Add('AND PRO.CODVENDEDOR = ' +EVendedor.Text);
    if ECliente.AInteiro <> 0 then
      VpaSelect.Add('AND PRO.CODCLIENTE = '+ECliente.Text);
    if EEstagio.AInteiro <> 0 then
      VpaSelect.Add('AND PRO.CODESTAGIO = '+EEstagio.Text);
    if ESetor.AInteiro <> 0 then
      VpaSelect.Add('AND PRO.CODSETOR = '+ESetor.Text);
    if ECidade.Text <> '' then
      VpaSelect.Add('AND CLI.C_CID_CLI = '''+ECidade.Text+'''');
    if EUF.Text <> '' then
      VpaSelect.Add('AND CLI.C_EST_CLI = '''+EUF.Text+'''');
    if (EOrcamentoCompra.AsInteger <> 0) then
    begin
      VpaSelect.Add('AND EXISTS '+
                    '( SELECT * FROM PROPOSTASOLICITACAOCOMPRA PRT '+
                    ' Where PRT.SEQSOLICITACAO = '+IntToStr(EOrcamentoCompra.AsInteger));
      if EFilial.AInteiro <> 0 then
        VpaSelect.add(' and PRT.CODFILIAL = '+IntToStr(EFilial.AInteiro));
      VpaSelect.add('AND PRT.CODFILIAL = PRO.CODFILIAL '+
                    ' AND PRT.SEQPROPOSTA = PRO.SEQPROPOSTA )');
    end;
    if ECodClassifcacao.Text <> '' then
      VpaSelect.Add('and EXISTS (Select 1 from PROPOSTAPRODUTO PRP, CADPRODUTOS CPR ' +
                    ' Where PRP.CODFILIAL = PRO.CODFILIAL ' +
                    ' AND PRP.SEQPROPOSTA = PRO.SEQPROPOSTA ' +
                    ' AND PRP.SEQPRODUTO = CPR.I_SEQ_PRO ' +
                    ' AND CPR.C_COD_CLA LIKE '''+ECodClassifcacao.Text+'%'''+
                    ' AND CPR.I_COD_EMP = '+IntToStr(Varia.CodigoEmpresa)+
                    ' AND CPR.C_TIP_CLA = ''P'')');
    if (VprNumChamado <> 0) then
    begin
      VpaSelect.Add('and EXISTS (Select 1 from CHAMADOPROPOSTA CHP '+
                           ' Where PRO.CODFILIAL = CHP.CODFILIAL '+
                           ' AND PRO.SEQPROPOSTA = CHP.SEQPROPOSTA '+
                           ' AND CHP.NUMCHAMADO = '+IntToStr(VprNumChamado)+
                           ' AND CHP.CODFILIAL = '+IntToStr(VprCodFilial)+ ')');
    end;
    if (VprLanOrcamento <> 0) then
    begin
      VpaSelect.Add('and EXISTS (Select 1 from PROPOSTACOTACAO POT '+
                           ' Where PRO.CODFILIAL = POT.CODFILIALPROPOSTA '+
                           ' AND PRO.SEQPROPOSTA = POT.SEQPROPOSTA '+
                           ' AND POT.LANORCAMENTO = '+IntToStr(VprLanOrcamento)+
                           ' AND POT.CODFILIALORCAMENTO = '+IntToStr(VprCodFilial)+ ')');
    end;
  end;
end;

{******************************************************************************}
function TFPropostasCliente.RRodapeGrafico : String;
begin
  result := 'Período de :'+ FormatDateTime('DD/MM/YYYY',EDatInicio.DateTime)+ ' até : '+FormatDateTime('DD/MM/YYYY',EDatFim.DateTime);
  if EVendedor.AInteiro <> 0 then
    result := result + ' - Vendedor : '+ LNomVendedor.Caption;
end;

procedure TFPropostasCliente.SpeedButton15Click(Sender: TObject);
begin
  LocalizaClassificacao;
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFPropostasCliente.GraficoMeioDivulgacao;
var
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfComandoSql.add('Select count(*) Qtd, MEI.DESMEIODIVULGACAO MEIO '+
                    ' from PROPOSTA PRO, CADCLIENTES CLI, MEIODIVULGACAO MEI '+
                    ' Where CLI.I_PRC_MDV = MEI.CODMEIODIVULGACAO'+
                    ' AND PRO.CODCLIENTE = CLI.I_COD_CLI');
  graficostrio.info.CampoValor := 'Qtd';
  graficostrio.info.TituloY := 'Quantidade';

  AdicionaFiltros(VpfComandosql);
  VpfComandosql.add(' GROUP BY MEIO');

  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'MEIO';
  graficostrio.info.TituloGrafico := 'Gráfico Propostas - Meio Divulgação';
  graficostrio.info.RodapeGrafico := RRodapeGrafico;
  graficostrio.info.TituloFormulario := 'Gráfico das Propostas';
  graficostrio.info.TituloX := 'Meio Divulgação';
  graficostrio.execute;
end;

{******************************************************************************}
procedure TFPropostasCliente.GraficoVendedor;
var
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfComandoSql.add('Select count(*) Qtd, VEN.C_NOM_VEN VENDEDOR '+
                    ' from PROPOSTA PRO, CADVENDEDORES VEN '+
                    ' Where PRO.CODVENDEDOR = VEN.I_COD_VEN');
  graficostrio.info.CampoValor := 'Qtd';
  graficostrio.info.TituloY := 'Quantidade';

  AdicionaFiltros(VpfComandosql);
  VpfComandosql.add(' GROUP BY VENDEDOR');

  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'VENDEDOR';
  graficostrio.info.TituloGrafico := 'Gráfico Propostas - Vendedores';
  graficostrio.info.RodapeGrafico := RRodapeGrafico;
  graficostrio.info.TituloFormulario := 'Gráfico de Propostas';
  graficostrio.info.TituloX := 'Vendedor';
  graficostrio.execute;
end;

{******************************************************************************}
function TFPropostasCliente.LocalizaClassificacao : boolean;
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
procedure TFPropostasCliente.PopupMenu1Popup(Sender: TObject);
begin
  CarregaConfigPopup;
end;

{******************************************************************************}
procedure TFPropostasCliente.PropostaAfterScroll(DataSet: TDataSet);
begin
  AlterarEnabledDet([BAlterar,MAlterarEstagio],true);
  if not((puAdministrador in varia.PermissoesUsuario) or (puCRCompleto in varia.PermissoesUsuario)) then
  begin
    if not(puCRAlterarPropostasFinalizadas in varia.PermissoesUsuario) and (PropostaINDFIN.AsString = 'S') then
    begin
      BAlterar.Enabled := false;
      MAlterarEstagio.Enabled := false;
    end;
  end;
end;

{******************************************************************************}
procedure TFPropostasCliente.GraficoCidade;
var
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfComandoSql.add('Select count(*) Qtd, CLI.C_CID_CLI CIDADE '+
                    ' from PROPOSTA PRO, CADCLIENTES CLI'+
                    ' Where PRO.CODCLIENTE = CLI.I_COD_CLI');
  graficostrio.info.CampoValor := 'Qtd';
  graficostrio.info.TituloY := 'Quantidade';

  AdicionaFiltros(VpfComandosql);
  VpfComandosql.add(' GROUP BY CIDADE order by 1 desc');

  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'CIDADE';
  graficostrio.info.TituloGrafico := 'Gráfico Propostas - Cidades';
  graficostrio.info.RodapeGrafico := RRodapeGrafico;
  graficostrio.info.TituloFormulario := 'Gráfico de Propostas';
  graficostrio.info.TituloX := 'CIDADE';
  graficostrio.execute;
end;

{******************************************************************************}
procedure TFPropostasCliente.GraficoRamoAtividade;
var
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfComandoSql.add('Select count(*) Qtd, RAM.NOM_RAMO_ATIVIDADE AS CAMPO '+
                    ' from PROPOSTA PRO, CADCLIENTES CLI, RAMO_ATIVIDADE RAM '+
                    ' Where CLI.I_COD_RAM *= RAM.COD_RAMO_ATIVIDADE '+
                    ' AND PRO.CODCLIENTE = CLI.I_COD_CLI');
  graficostrio.info.CampoValor := 'Qtd';
  graficostrio.info.TituloY := 'Quantidade';

  AdicionaFiltros(VpfComandosql);
  VpfComandosql.add(' GROUP BY CAMPO ORDER BY 2');

  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'CAMPO';
  graficostrio.info.TituloGrafico := 'Gráfico Propostas - Ramo Atividades';
  graficostrio.info.RodapeGrafico := RRodapeGrafico;
  graficostrio.info.TituloFormulario := 'Gráfico de Propostas';
  graficostrio.info.TituloX := 'Ramo Atividade';
  graficostrio.execute;
end;

{******************************************************************************}
procedure TFPropostasCliente.GraficoProfissao;
var
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfComandoSql.add('Select count(*) Qtd, PRF.C_NOM_PRF CAMPO '+
                    ' from PROPOSTA PRO, CADCLIENTES CLI, CADPROFISSOES PRF '+
                    ' Where CLI.I_PRC_PRF *= PRF.I_COD_PRF '+
                    '  AND PRO.CODCLIENTE = CLI.I_COD_CLI');
  graficostrio.info.CampoValor := 'Qtd';
  graficostrio.info.TituloY := 'Quantidade';

  AdicionaFiltros(VpfComandosql);
  VpfComandosql.add(' GROUP BY CAMPO');

  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'CAMPO';
  graficostrio.info.TituloGrafico := 'Gráfico Propostas - Profissão Contato';
  graficostrio.info.RodapeGrafico := RRodapeGrafico;
  graficostrio.info.TituloFormulario := 'Gráfico de Propostas';
  graficostrio.info.TituloX := 'Profissão Contato';
  graficostrio.execute;
end;

{******************************************************************************}
procedure TFPropostasCliente.GraficoData;
var
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfComandoSql.add('Select count(*) Qtd, dateformat(PRO.DATPROPOSTA,''DD/MM/YYYY'') CAMPO '+
                    ' from PROPOSTA PRO '+
                    ' Where PRO.SEQPROPOSTA = PRO.SEQPROPOSTA ');
  graficostrio.info.CampoValor := 'Qtd';
  graficostrio.info.TituloY := 'Quantidade';

  AdicionaFiltros(VpfComandosql);
  VpfComandosql.add(' GROUP BY CAMPO');

  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'CAMPO';
  graficostrio.info.TituloGrafico := 'Gráfico Proposta - Data';
  graficostrio.info.RodapeGrafico := RRodapeGrafico;
  graficostrio.info.TituloFormulario := 'Gráfico de Propostas';
  graficostrio.info.TituloX := 'Data';
  graficostrio.execute;
end;

{******************************************************************************}
procedure TFPropostasCliente.GraficoUF;
var
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfComandoSql.add('Select count(*) Qtd, C_EST_CLI CAMPO '+
                    ' from PROPOSTA PRO, CADCLIENTES CLI'+
                    ' Where PRO.CODCLIENTE = CLI.I_COD_CLI');
  graficostrio.info.CampoValor := 'Qtd';
  graficostrio.info.TituloY := 'Quantidade';

  AdicionaFiltros(VpfComandosql);
  VpfComandosql.add(' GROUP BY CAMPO');

  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'CAMPO';
  graficostrio.info.TituloGrafico := 'Gráfico Propostas - UF';
  graficostrio.info.RodapeGrafico := RRodapeGrafico;
  graficostrio.info.TituloFormulario := 'Gráfico de Propostas';
  graficostrio.info.TituloX := 'UF';
  graficostrio.execute;
end;

{******************************************************************************}
procedure TFPropostasCliente.GraficoEstagio;
var
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfComandoSql.add('Select count(*) Qtd, EST.NOMEST CAMPO '+
                    ' from PROPOSTA PRO, ESTAGIOPRODUCAO EST '+
                    ' Where  PRO.CODESTAGIO = EST.CODEST' );
  graficostrio.info.CampoValor := 'Qtd';
  graficostrio.info.TituloY := 'Quantidade';

  AdicionaFiltros(VpfComandosql);
  VpfComandosql.add(' GROUP BY CAMPO');

  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'CAMPO';
  graficostrio.info.TituloGrafico := 'Gráfico Propostas - Estagios';
  graficostrio.info.RodapeGrafico := RRodapeGrafico;
  graficostrio.info.TituloFormulario := 'Gráfico de Propostas';
  graficostrio.info.TituloX := 'Estagio Proposta';
  graficostrio.execute;
end;

{******************************************************************************}
procedure TFPropostasCliente.ConsultaOrcamentoCompras;
begin
  FSolicitacaoCompra := TFSolicitacaoCompra.CriarSDI(self,'',FPrincipal.VerificaPermisao('FOrcamentoCompra'));
  FSolicitacaoCompra.ConsultaProposta(PropostaCODFILIAL.AsInteger,PropostaSEQPROPOSTA.AsInteger);
  FSolicitacaoCompra.free;
end;

{******************************************************************************}
procedure TFPropostasCliente.ConsultaPropostas(VpaCodCliente: Integer);
begin
  ECliente.AInteiro:= VpaCodCliente;
  EDatInicio.DateTime:= DecMes(PrimeiroDiaMes(date),3);
  AtualizaConsulta;
  ShowModal;
end;

{******************************************************************************}
procedure TFPropostasCliente.ConsultaChamados1Click(Sender: TObject);
begin
  if PropostaCODFILIAL.AsInteger <> 0 then
  begin
    FChamadoTecnico := TFChamadoTecnico.CriarSDI(self,'',true);
    FChamadoTecnico.ConsultaChamadosProposta(PropostaCODFILIAL.AsInteger,PropostaSEQPROPOSTA.AsInteger);
    FChamadoTecnico.free;
  end;
end;

{******************************************************************************}
procedure TFPropostasCliente.ConsultaCotaes1Click(Sender: TObject);
begin
  if PropostaCODFILIAL.AsInteger <> 0 then
  begin
    FCotacao := TFCotacao.criarSDI(Application,'',FPrincipal.VerificaPermisao('FCotacao'));
    FCotacao.ConsultaCotacoesProposta(PropostaCODFILIAL.AsInteger,PropostaSEQPROPOSTA.AsInteger);
    FCotacao.free;
  end;
end;

{******************************************************************************}
Procedure TFPropostasCliente.ConsultaOrcamentoCompra(VpaCodFilial,VpaSeqSolicitacao : Integer);
begin
  EFilial.AInteiro:= VpaCodFilial;
  EFilial.Atualiza;
  CPeriodo.Checked := false;
  EOrcamentoCompra.AsInteger := VpaSeqSolicitacao;
  AtualizaConsulta;
  ShowModal;
end;

{******************************************************************************}
procedure TFPropostasCliente.ConsultaPropostasChamado(VpaCodFilial,VpaNumChamado : Integer);
begin
  VprCodFilial := VpaCodFilial;
  VprNumChamado := VpaNumChamado;
  CPeriodo.Checked := false;
  AtualizaConsulta;
  ShowModal;
end;

{******************************************************************************}
procedure TFPropostasCliente.ConsultaPropostasCotacao(VpaCodFilial, VpaLanOrcamento: Integer);
begin
  VprCodFilial := VpaCodFilial;
  VprLanOrcamento := VpaLanOrcamento;
  CPeriodo.Checked := false;
  AtualizaConsulta;
  ShowModal;
end;

{******************************************************************************}
procedure TFPropostasCliente.Duplicar1Click(Sender: TObject);
begin
  if PropostaSEQPROPOSTA.AsInteger <> 0 then
  begin
    FNovaProposta:= TFNovaProposta.CriarSDI(Application,'',True);
    if FNovaProposta.Duplicar(PropostaCODFILIAL.AsInteger,PropostaSEQPROPOSTA.AsInteger) then
      AtualizaConsulta();
    FNovaProposta.Free;
  end;
end;

{******************************************************************************}
procedure TFPropostasCliente.ECodClassifcacaoExit(Sender: TObject);
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
  AtualizaConsulta;
end;

procedure TFPropostasCliente.ECodClassifcacaoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 114 then
    LocalizaClassificacao;
end;

{******************************************************************************}
procedure TFPropostasCliente.EDatInicioExit(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFPropostasCliente.BEmailClick(Sender: TObject);
var
  VpfResultado : String;
  VpfListaProposta: TList;
begin
  if PropostaSEQPROPOSTA.AsInteger <> 0 then
  begin
    if VprDProposta <> nil then
      VprDProposta.free;
    VpfListaProposta := TList.Create;

    VpfResultado := CarListaPropostasSelecionadas(VpfListaProposta);

    if  (vpfresultado = '') and (VpfListaProposta.Count > 0) then
    begin
      VprDCliente.CodCliente:= VprDProposta.CodCliente;
      FunClientes.CarDCliente(VprdCliente);
      VpfResultado:= FunProposta.EnviaEmailCliente(VpfListaProposta,VprDCliente);
    end;
    if  vpfresultado <> '' then
      aviso(VpfResultado);
    VpfListaProposta.Free;
  end;
end;

{******************************************************************************}
procedure TFPropostasCliente.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFPropostasCliente.BConsultarClick(Sender: TObject);
begin
  if PropostaSEQPROPOSTA.AsInteger <> 0 then
  begin
    FNovaProposta := TFNovaProposta.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaProposta'));
    FNovaProposta.ConsultaProposta(PropostaCODFILIAL.AsInteger,PropostaSEQPROPOSTA.AsInteger);
    FNovaProposta.free;
  end;
end;

{******************************************************************************}
procedure TFPropostasCliente.BCadastrarClick(Sender: TObject);
begin
  FNovaProposta := tFNovaProposta.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaProposta'));
  if FNovaProposta.NovaProposta then
    AtualizaConsulta;
  FNovaProposta.free;
end;

{******************************************************************************}
procedure TFPropostasCliente.BAlterarClick(Sender: TObject);
begin
  if PropostaSEQPROPOSTA.AsInteger <> 0 then
  begin
    FNovaProposta := TFNovaProposta.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaProposta'));
    if  FNovaProposta.AlteraProposta(PropostaCODFILIAL.AsInteger,PropostaSEQPROPOSTA.AsInteger) then
      AtualizaConsulta;
    FNovaProposta.free;
  end;
end;

{******************************************************************************}
procedure TFPropostasCliente.BImprimirClick(Sender: TObject);
begin
  if PropostaCODFILIAL.AsInteger <> 0 then
  begin
    try
      dtRave := TdtRave.Create(self);
      dtRave.ImprimeProposta(PropostaCODFILIAL.AsInteger,PropostaSEQPROPOSTA.AsInteger,true);
    finally
      dtRave.Free;
    end;
  end;
end;

{******************************************************************************}
procedure TFPropostasCliente.BMeioDivulgacaoClick(Sender: TObject);
begin
  GraficoMeioDivulgacao;
end;

{******************************************************************************}
procedure TFPropostasCliente.BGraficosClick(Sender: TObject);
begin
  PanelColor1.Enabled := false;
  PanelColor2.Enabled := false;
  GPropostas.Enabled := false;
  PGraficos.Top := 50;
  PGraficos.Visible := true;
end;

{******************************************************************************}
procedure TFPropostasCliente.BFechaGraficoClick(Sender: TObject);
begin
  PanelColor1.Enabled := true;
  PanelColor2.Enabled := true;
  GPropostas.Enabled := true;
  PGraficos.Visible := false;
end;

{******************************************************************************}
procedure TFPropostasCliente.BVendedorClick(Sender: TObject);
begin
  GraficoVendedor;
end;

procedure TFPropostasCliente.BProdutoClick(Sender: TObject);
begin
  GraficoCidade;
end;

{******************************************************************************}
procedure TFPropostasCliente.BDataClick(Sender: TObject);
begin
  GraficoRamoAtividade;
end;

procedure TFPropostasCliente.BduplicarClick(Sender: TObject);
begin
end;

{******************************************************************************}
procedure TFPropostasCliente.BFlagClick(Sender: TObject);
begin
  GraficoProfissao;
end;

{******************************************************************************}
procedure TFPropostasCliente.BCondicaoClick(Sender: TObject);
begin
  GraficoData;
end;

{******************************************************************************}
procedure TFPropostasCliente.BEstadoClick(Sender: TObject);
begin
  GraficoUF;
end;

procedure TFPropostasCliente.BExcluirClick(Sender: TObject);
begin
  if PropostaSEQPROPOSTA.AsInteger <> 0 then
  begin
    if confirmacao(CT_DeletaRegistro) then
    begin
      FunProposta.ExcluiProposta(PropostaCODFILIAL.AsInteger,PropostaSEQPROPOSTA.AsInteger,true);
      AtualizaConsulta;
    end;
  end;
end;

{******************************************************************************}
procedure TFPropostasCliente.BGraEstagioClick(Sender: TObject);
begin
  GraficoEstagio;
end;

{******************************************************************************}
procedure TFPropostasCliente.EPropostaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  IF key = 13 then
    AtualizaConsulta;
end;

{******************************************************************************}
procedure TFPropostasCliente.TelemarketingReceptivo1Click(Sender: TObject);
begin
  if not Proposta.Eof then
  begin
    FNovoTeleMarketing:= TFNovoTeleMarketing.CriarSDI(Application,'',True);
    FNovoTeleMarketing.TeleMarketingCliente(PropostaI_COD_CLI.AsInteger);
    FNovoTeleMarketing.Free;
  end;
end;

{******************************************************************************}
function TFPropostasCliente.ValidaDadosPropostaparaaCotacao(VpaLista: TList): string;
var
  VpfLaco : Integer;
  VpfDProposta, VpfDPrimeiraProposta : TRBDPropostaCorpo;
begin
  result := '';
  if VpaLista.Count > 0 then
  begin
    VpfDPrimeiraProposta := TRBDPropostaCorpo(VpaLista.Items[0]);
    for VpfLaco := 1 to VpfLaco - 1 do
    begin
      VpfDProposta := TRBDPropostaCorpo(VpaLista.Items[VpfLaco]);
      if VpfDProposta.CodCliente <> VpfDPrimeiraProposta.CodCliente then
        result := 'CLIENTE INVÁLIDO!!!'+#13+'Para gerar cotação de varias propostas é necessário que todas possuam o mesmo cliente.'
      else
        if VpfDProposta.CodVendedor <> VpfDPrimeiraProposta.CodVendedor then
          result := 'VENDEDOR INVÁLIDO!!!'+#13+'Para gerar cotação de varias propostas é necessário que todas possuam o mesmo vendedor.'
        else
          if VpfDProposta.PerDesconto <> 0 then
            result := 'PERCENTUAL DESCONTO/ACRESCIMO INVÁLIDO!!!'+#13+'Para gerar cotação de varias propostas não é permtido preencher o percentual de DESCONTO/ACRESCIMO, converta o ACRESCIMO/DESCONTO para valor.';
      if result <> '' then
        break;
    end;
  end;
end;

{******************************************************************************}
function TFPropostasCliente.CarListaPropostasSelecionadas(VpaLista: TList): String;
var
  VpfLaco : Integer;
  VpfBookMark : TBookmark;
  VpfUltimoCodCli: Integer;
begin
  result := '';
  FreeTObjectsList(VpaLista);
  if GPropostas.SelectedRows.Count = 0  then
  begin
    VprDProposta := TRBDPropostaCorpo.cria;
    FunProposta.CarDProposta(VprDProposta,PropostaCODFILIAL.AsInteger,PropostaSEQPROPOSTA.AsInteger);
    VpaLista.add(VprDProposta);
  end
  else
  begin
    VpfUltimoCodCli := -1;
    for VpfLaco:= 0 to GPropostas.SelectedRows.Count-1 do
    begin
      VpfBookmark:= TBookmark(GPropostas.SelectedRows.Items[VpfLaco]);
      Proposta.GotoBookmark(VpfBookMark);
      VprDProposta := TRBDPropostaCorpo.cria;
      FunProposta.CarDProposta(VprDProposta,PropostaCODFILIAL.AsInteger,PropostaSEQPROPOSTA.AsInteger);
      if (VpfUltimoCodCli <> -1) and (VprDProposta.CodCliente <> VpfUltimoCodCli) then
        Result := 'SELECIONADO CLIENTES DIFERENTES!!! Para enviar e-mail da proposta é necessário que sejam todas do mesmo cliente.'
      else
        VpfUltimoCodCli := VprDProposta.CodCliente;
      if result = '' then
        VpaLista.add(VprDProposta)
      else
        break;
    end;
  end;
  if result <> '' then
    FreeTObjectsList(VpaLista);
end;

{******************************************************************************}
procedure TFPropostasCliente.CarregaConfigPopup;
begin
  if config.GeraFichaNoEstagioAguardandoFichaImplantacao then
    MGerarFichaImplantao.Enabled := Varia.EstagioAguardandoFichaImplantacao = PropostaCODESTAGIO.AsInteger;
  if config.GeraCotacaoNoAguardandoFaturamento then
    MGerarCotao.Enabled := Varia.EstagioAguardandoFaturamento = PropostaCODESTAGIO.AsInteger;

  if (puCRAlterarEstagioPropostasFinalizadaseCanceladas in varia.PermissoesUsuario) then
  begin
    if ((PropostaCODESTAGIO.AsInteger = varia.EstagioPropostaConcluida) or (PropostaCODESTAGIO.AsInteger = varia.EstagioPropostaCancelada)) then
      MAlterarEstagio.Visible:= False;
  end;
end;

{******************************************************************************}
procedure TFPropostasCliente.MAlterarEstagioClick(Sender: TObject);
var
  VpfDProposta : TRBDPropostaCorpo;
begin
  if PropostaSEQPROPOSTA.AsInteger <> 0 then
  begin
    VpfDProposta := TRBDPropostaCorpo.cria;
    FunProposta.CarDProposta(VpfDProposta,PropostaCODFILIAL.AsInteger,PropostaSEQPROPOSTA.AsInteger);
    FAlteraEstagioProposta:= TFAlteraEstagioProposta.CriarSDI(Application,'',True);
    if FAlteraEstagioProposta.AlteraEstagioPropostaCliente(VpfDProposta) then
      AtualizaConsulta;
    FAlteraEstagioProposta.Free;
    VpfDProposta.Free;
  end;
end;

{******************************************************************************}
procedure TFPropostasCliente.MGerarCotaoClick(Sender: TObject);
var
  VpfResultado : string;
begin
  if Confirmacao('Deseja gerar uma nova cotação à partir desta proposta?') then
  begin
    VpfResultado := CarListaPropostasSelecionadas(VprPropostas);
    if VpfResultado = '' then
    begin
      VpfResultado := ValidaDadosPropostaparaaCotacao(VprPropostas);
      if VpfResultado = '' then
      begin
        FNovaCotacao:= TFNovaCotacao.CriarSDI(Application,'',True);
        FunProposta.CarDProposta(VprDProposta,PropostaCODFILIAL.AsInteger,PropostaSEQPROPOSTA.AsInteger);
        if FNovaCotacao.NovaCotacaoProposta(VprPropostas) then
          AtualizaConsulta;
        FNovaCotacao.Free;
      end;
    end;
    if VpfResultado <> '' then
      aviso(VpfResultado);
  end;
end;

{******************************************************************************}
procedure TFPropostasCliente.MGerarFichaImplantaoClick(Sender: TObject);
begin
  if PropostaCODFILIAL.AsInteger <> 0 then
  begin
    if confirmacao('Deseja gerar uma ficha de implantação à partir desta proposta?') then
    begin
      FunProposta.CarDProposta(VprDProposta,PropostaCODFILIAL.AsInteger,PropostaSEQPROPOSTA.AsInteger);
      FNovoChamado := TFNovoChamado.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoChamado'));
      FNovoChamado.NovoChamadoProposta(VprDProposta);
      FNovoChamado.free;
    end;
  end;
end;

{******************************************************************************}
procedure TFPropostasCliente.GerarPedidoCompra1Click(Sender: TObject);
begin
  if PropostaSEQPROPOSTA.AsInteger <> 0 then
  begin
    VprDProposta.free;
    VprDProposta := TRBDPropostaCorpo.cria;
    FunProposta.CarDProposta(VprDProposta,PropostaCODFILIAL.AsInteger,PropostaSEQPROPOSTA.AsInteger);
    FNovaSolicitacaoCompras := TFNovaSolicitacaoCompras.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoOrcamentoCompras'));
    FNovaSolicitacaoCompras.NovoOrcamentoProposta(VprDProposta);
    FNovaSolicitacaoCompras.free;
  end;
end;

procedure TFPropostasCliente.GPropostasOrdem(Ordem: string);
begin
  VprOrdem := Ordem;
end;

{******************************************************************************}
procedure TFPropostasCliente.ConsultaPedidoCompras1Click(Sender: TObject);
begin
  if PropostaCODFILIAL.AsInteger <> 0 then
    ConsultaOrcamentoCompras;
end;

procedure TFPropostasCliente.BFiltrosClick(Sender: TObject);
begin
  if BFiltros.Caption = '>>' then
  begin
    PanelColor1.Height := ECodClassifcacao.Top + ECodClassifcacao.Height + 5;
    BFiltros.Caption := '<<';
  end
  else
  begin
    PanelColor1.Height := EProposta.Top +EProposta.Height + 3;
    BFiltros.Caption := '>>';
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFPropostasCliente]);
end.
