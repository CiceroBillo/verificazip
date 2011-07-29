unit ALeiturasLocacao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Buttons, Grids,
  DBGrids, Tabela, DBKeyViolation, Db, DBTables, UnDados, UnContrato, UnCrystal,
  ComCtrls, Localizacao, Mask, numericos, Graficos, FMTBcd, SqlExpr, DBClient, Menus;

type
  TFLeiturasLocacao = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    GridIndice1: TGridIndice;
    Locacao: TSQL;
    DataLocacao: TDataSource;
    LocacaoSEQLEITURA: TFMTBCDField;
    LocacaoDATDIGITACAO: TSQLTimeStampField;
    LocacaoMESLOCACAO: TFMTBCDField;
    LocacaoANOLOCACAO: TFMTBCDField;
    LocacaoDATLEITURA: TSQLTimeStampField;
    LocacaoQTDCOPIA: TFMTBCDField;
    LocacaoQTDEXCEDENTE: TFMTBCDField;
    LocacaoVALTOTAL: TFMTBCDField;
    LocacaoDATPROCESSAMENTO: TSQLTimeStampField;
    LocacaoC_NOM_CLI: TWideStringField;
    LocacaoCODFILIAL: TFMTBCDField;
    LocacaoLANORCAMENTO: TFMTBCDField;
    EDataInicial: TCalendario;
    EDataFinal: TCalendario;
    Label4: TLabel;
    CPeriodo: TCheckBox;
    ESituacao: TComboBoxColor;
    Label1: TLabel;
    ECodCliente: TEditLocaliza;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    Label3: TLabel;
    Localiza: TConsultaPadrao;
    LocacaoVALTOTALDESCONTO: TFMTBCDField;
    PanelColor3: TPanelColor;
    PanelColor2: TPanelColor;
    BCadastrar: TBitBtn;
    BAlterar: TBitBtn;
    BConsultar: TBitBtn;
    BExcluir: TBitBtn;
    BProcessar: TBitBtn;
    BFechar: TBitBtn;
    BImprimir: TBitBtn;
    PTotais: TPanelColor;
    CTotais: TCheckBox;
    EQtd: Tnumerico;
    EValTotal: Tnumerico;
    Label5: TLabel;
    Label6: TLabel;
    Aux: TSQL;
    BGraficos: TBitBtn;
    PGraficos: TCorPainelGra;
    BitBtn4: TBitBtn;
    PanelColor5: TPanelColor;
    Label17: TLabel;
    Label18: TLabel;
    BClientes: TBitBtn;
    BFechaGrafico: TBitBtn;
    BVendedor: TBitBtn;
    CTipoGrafico: TRadioGroup;
    EQtdCopias: Tnumerico;
    Label8: TLabel;
    GraficosTrio: TGraficosTrio;
    Label7: TLabel;
    ETecnico: TEditLocaliza;
    SpeedButton2: TSpeedButton;
    Label9: TLabel;
    BarraStatus: TStatusBar;
    PopupMenu1: TPopupMenu;
    MarcaContratocomoProcessado1: TMenuItem;
    BEnviarEmailCliente: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BCadastrarClick(Sender: TObject);
    procedure BProcessarClick(Sender: TObject);
    procedure LocacaoAfterScroll(DataSet: TDataSet);
    procedure EDataInicialExit(Sender: TObject);
    procedure BAlterarClick(Sender: TObject);
    procedure BConsultarClick(Sender: TObject);
    procedure BExcluirClick(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure CTotaisClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BGraficosClick(Sender: TObject);
    procedure BFechaGraficoClick(Sender: TObject);
    procedure BVendedorClick(Sender: TObject);
    procedure BClientesClick(Sender: TObject);
    procedure MarcaContratocomoProcessado1Click(Sender: TObject);
    procedure BEnviarEmailClienteClick(Sender: TObject);
  private
    { Private declarations }
    VprPressionadoR : Boolean;
    VprDLeitura : TRBDLeituraLocacaoCorpo;
    FunContratos : TRBFuncoesContrato;
    procedure ConfiguraPermissaoUsuario;
    procedure GraficoMes;
    procedure GraficoCliente;
    procedure AtualizaConsulta(VpaPosicionar : Boolean);
    procedure AdicionaFiltros(VpaSql : TStrings);
    procedure CarValorTotal;
    procedure ProcessaContratoFrio;
  public
    { Public declarations }
  end;

var
  FLeiturasLocacao: TFLeiturasLocacao;

implementation

uses APrincipal, ANovaLeituraLocacao, Constantes, Funobjeto, FunData, FunSql,ConstMsg,
  dmRave;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFLeiturasLocacao.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprDLeitura := TRBDLeituraLocacaoCorpo.cria;
  FunContratos := TRBFuncoesContrato.cria(FPrincipal.BaseDados);
  if dia(date) <= 20 then
  begin
    EDataInicial.DateTime := Decdia(PrimeiroDiaMes(date),10);
    EDataFinal.DateTime := UltimoDiaMes(date);
  end
  else
  begin
    EDataInicial.DateTime := incdia(PrimeiroDiaMes(date),20);
    EDataFinal.DateTime := UltimoDiaMes(incmes(date,1));
  end;
  ESituacao.ItemIndex := 0;
  AtualizaConsulta(false);
  ConfiguraPermissaoUsuario;
  ActiveControl:= EDataInicial;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFLeiturasLocacao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Locacao.close;
  Aux.close;
  FunContratos.free;
  VprDLeitura.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFLeiturasLocacao.ConfiguraPermissaoUsuario;
begin
  if not((puAdministrador in varia.PermissoesUsuario) or (puPLCompleto in varia.PermissoesUsuario)) then
  begin
    AlterarVisibleDet([BExcluir,PTotais],false);
  end;
end;

{******************************************************************************}
procedure TFLeiturasLocacao.GraficoMes;
var
  VpfTitulo : String;
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfTitulo := 'Gráfico Locações ';
  case CTipoGrafico.ItemIndex of
    0 : begin
          VpfComandoSql.add('select SUM('+SQLTextoIsNULL('QTDCOPIA','0')+')+SUM('+SQLTextoIsNULL('QTDCOPIACOLOR','0')+') QTD, (ANOLOCACAO *100)+ MESLOCACAO DATA1, MESLOCACAO ||''/''|| ANOLOCACAO DATA '+
                           ' from LEITURALOCACAOCORPO LOC '+
                           ' Where LOC.CODFILIAL = LOC.CODFILIAL' ) ;
          graficostrio.info.CampoValor := 'Qtd';
          graficostrio.info.TituloY := 'Quantidade';
        end;
    1 : begin
          VpfComandoSql.add('select SUM(VALTOTAL) Valor,(ANOLOCACAO *100)+ MESLOCACAO DATA1, MESLOCACAO||''/''|| ANOLOCACAO DATA '+
                           ' from LEITURALOCACAOCORPO LOC'+
                           ' Where LOC.CODFILIAL = LOC.CODFILIAL' ) ;
          graficostrio.info.CampoValor := 'Valor';
          graficostrio.info.TituloY := 'Valor';
        end;
  end;
  AdicionaFiltros(VpfComandosql);
  VpfComandosql.add(' group by (ANOLOCACAO *100)+ MESLOCACAO, MESLOCACAO ||''/''|| ANOLOCACAO order by 2');
  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'Data';
  graficostrio.info.TituloGrafico := 'Gráficos por Mes - ' + Varia.NomeFilial;
  graficostrio.info.RodapeGrafico := VpfTitulo;
  graficostrio.info.TituloFormulario := 'Gráfico de locações';
  graficostrio.info.TituloX := 'Mes';
  graficostrio.execute;
end;

{******************************************************************************}
procedure TFLeiturasLocacao.GraficoCliente;
var
  VpfTitulo : String;
  VpfComandoSql : TStringList;
begin
  VpfComandoSql := TStringList.Create;
  VpfTitulo := 'Gráfico Locações ';
  case CTipoGrafico.ItemIndex of
    0 : begin
          VpfComandoSql.add('select SUM('+SQLTextoIsNull('QTDCOPIA','0')+')+SUM('+SqlTextoISNULL('QTDCOPIACOLOR','0')+') QTD,  CLI.C_NOM_CLI CLIENTE '+
                           ' from LEITURALOCACAOCORPO LOC, CADCLIENTES CLI'+
                           ' Where LOC.CODCLIENTE = CLI.I_COD_CLI' ) ;

          graficostrio.info.CampoValor := 'Qtd';
          graficostrio.info.TituloY := 'Quantidade';
        end;
    1 : begin
          VpfComandoSql.add('select SUM(VALTOTAL) Valor,  CLI.C_NOM_CLI CLIENTE '+
                           ' from LEITURALOCACAOCORPO LOC, CADCLIENTES CLI'+
                           ' Where LOC.CODCLIENTE = CLI.I_COD_CLI' ) ;
          graficostrio.info.CampoValor := 'Valor';
          graficostrio.info.TituloY := 'Valor';
        end;
  end;
  AdicionaFiltros(VpfComandosql);
  VpfComandosql.add(' GROUP BY CLI.C_NOM_CLI');

  graficostrio.info.ComandoSQL :=  VpfComandoSql.text;
  graficostrio.info.CampoRotulo := 'Cliente';
  graficostrio.info.TituloGrafico := 'Gráficos por Clientes - ' + Varia.NomeFilial;
  graficostrio.info.RodapeGrafico := VpfTitulo;
  graficostrio.info.TituloFormulario := 'Gráfico de locações';
  graficostrio.info.TituloX := 'Cliente';
  graficostrio.execute;
end;

{******************************************************************************}
procedure TFLeiturasLocacao.AtualizaConsulta(VpaPosicionar : Boolean);
var
  VpfPosicao : TBookmark;
begin
  if VpaPosicionar then
    VpfPosicao := Locacao.GetBookmark;
  Locacao.close;
  Locacao.Sql.Clear;
  Locacao.Sql.add('SELECT LOC.CODFILIAL,LOC.SEQLEITURA, LOC.DATDIGITACAO,LOC.MESLOCACAO, LOC.ANOLOCACAO, LOC.DATLEITURA, '+
                  ' LOC.QTDCOPIA, LOC.QTDEXCEDENTE, LOC.VALTOTAL,LOC.VALTOTALDESCONTO, LOC.DATPROCESSAMENTO, LOC.LANORCAMENTO, '+
                  ' CLI.C_NOM_CLI '+
                  ' FROM LEITURALOCACAOCORPO LOC, CADCLIENTES CLI '+
                  ' Where LOC.CODCLIENTE = CLI.I_COD_CLI');
  AdicionaFiltros(Locacao.Sql);
  Locacao.sql.add('order by LOC.SEQLEITURA');
  Locacao.open;
  if CTotais.Checked then
    CarValorTotal;
  if VpaPosicionar and not Locacao.eof then
  begin
    try
      Locacao.GotoBookmark(VpfPosicao);
    except
      Locacao.Last;
      Locacao.GotoBookmark(VpfPosicao);
    end;
    Locacao.FreeBookmark(VpfPosicao);
  end;
end;

{******************************************************************************}
procedure TFLeiturasLocacao.AdicionaFiltros(VpaSql : TStrings);
begin
  VpaSql.Add(' and LOC.CODFILIAL = '+InttoStr(varia.CodigoEmpfil));
  if CPeriodo.Checked then
    VpaSql.add(SQLTextoDataEntreAAAAMMDD('DATDIGITACAO',EDataInicial.DateTime,incdia(EDataFinal.DateTime,1),true));
  case ESituacao.ItemIndex of
    1 : VpaSql.add('and DATPROCESSAMENTO IS NULL');
    2 : VpaSql.add('and DATPROCESSAMENTO IS NOT NULL');
  end;
  if  ECodCliente.AInteiro <> 0 then
    VpaSql.add('and CODCLIENTE = '+ECodCliente.Text);
  if ETecnico.AInteiro <> 0 then
    VpaSql.Add(' AND CODTECNICOLEITURA = '+ETecnico.Text);
end;

{******************************************************************************}
procedure TFLeiturasLocacao.CarValorTotal;
begin
  Aux.Sql.Clear;
  Aux.Sql.add('SELECT SUM(LOC.VALTOTAL) VALOR, COUNT(LOC.CODFILIAL) QTD, '+
                  ' SUM(QTDCOPIA) + SUM('+SQLTextoIsNull('QTDCOPIACOLOR','0')+') QTDCOPIA '+
                  ' FROM LEITURALOCACAOCORPO LOC '+
                  ' Where LOC.CODFILIAL = LOC.CODFILIAL');
  AdicionaFiltros(Aux.Sql);
  Aux.open;
  EQtd.AValor := Aux.FieldByName('QTD').AsInteger;
  EQtdCopias.AValor := Aux.FieldByName('QTDCOPIA').AsInteger;
  EValTotal.AValor := Aux.FieldByName('VALOR').AsFloat;
  Aux.close;
end;

{******************************************************************************}
procedure TFLeiturasLocacao.ProcessaContratoFrio;
begin
  if BProcessar.Enabled then
  begin
    VprDLeitura.free;
    VprDLeitura := TRBDLeituraLocacaoCorpo.cria;
    if LocacaoSEQLEITURA.AsInteger <> 0 then
    begin
      FunContratos.CarDLeituraLocacao(VprDLeitura,LocacaoCODFILIAL.AsInteger,LocacaoSEQLEITURA.AsInteger);
      VprDLeitura.IndProcessamentoFrio := true;
      FunContratos.ProcessaContratoLocacao(VprDLeitura,BarraStatus);
      dtRave := TdtRave.create(self);
      dtRave.ImprimeExtratoLocacao(LocacaoCODFILIAL.AsInteger,LocacaoSEQLEITURA.AsInteger,false);
      dtRave.free;
      AtualizaConsulta(true);
    end;
  end
  else
    aviso('CONTRATO JA PROCESSADO!!!'#13'O contrato selecionado já fo processado.');
end;

{******************************************************************************}
procedure TFLeiturasLocacao.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFLeiturasLocacao.BCadastrarClick(Sender: TObject);
begin
  FNovaLeituraLocacao := tFNovaLeituraLocacao.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaLeituraLocacao'));
  if FNovaLeituraLocacao.NovaLeitura then
    AtualizaConsulta(false);
  FNovaLeituraLocacao.free;
end;

{******************************************************************************}
procedure TFLeiturasLocacao.BProcessarClick(Sender: TObject);
begin
  VprDLeitura.free;
  VprDLeitura := TRBDLeituraLocacaoCorpo.cria;
  if LocacaoSEQLEITURA.AsInteger <> 0 then
  begin
    FunContratos.CarDLeituraLocacao(VprDLeitura,LocacaoCODFILIAL.AsInteger,LocacaoSEQLEITURA.AsInteger);
    FunContratos.ProcessaContratoLocacao(VprDLeitura,BarraStatus);
    if not config.EnviarEmailAutomaticoQuandoProcessarLeitura then
    begin
      dtRave := TdtRave.create(self);
      dtRave.ImprimeExtratoLocacao(LocacaoCODFILIAL.AsInteger,LocacaoSEQLEITURA.AsInteger,false);
      dtRave.free;
    end
    else
      FunContratos.EnviaLeituraLocacaoProcessadaEmail(VprDLeitura.CodFilial, VprDLeitura.SeqLeitura);
    AtualizaConsulta(true);
  end;
end;

{******************************************************************************}
procedure TFLeiturasLocacao.LocacaoAfterScroll(DataSet: TDataSet);
begin
  AlterarEnabledDet([BAlterar,BProcessar,BExcluir],LocacaoDATPROCESSAMENTO.isnull);
  BExcluir.Enabled := varia.GrupoUsuario = varia.GrupoUsuarioMaster;
end;

{******************************************************************************}
procedure TFLeiturasLocacao.MarcaContratocomoProcessado1Click(Sender: TObject);
begin
  VprDLeitura.free;
  VprDLeitura := TRBDLeituraLocacaoCorpo.cria;
  if LocacaoSEQLEITURA.AsInteger <> 0 then
  begin
    FunContratos.CarDLeituraLocacao(VprDLeitura,LocacaoCODFILIAL.AsInteger,LocacaoSEQLEITURA.AsInteger);
    FunContratos.MarcaContratoComoProcessado(VprDLeitura,BarraStatus);
    AtualizaConsulta(true);
  end;
end;

{******************************************************************************}
procedure TFLeiturasLocacao.EDataInicialExit(Sender: TObject);
begin
  Atualizaconsulta(false);
end;

{******************************************************************************}
procedure TFLeiturasLocacao.BAlterarClick(Sender: TObject);
begin
  VprDLeitura.free;
  VprDLeitura := TRBDLeituraLocacaoCorpo.cria;
  if LocacaoSEQLEITURA.AsInteger <> 0 then
  begin
    FunContratos.CarDLeituraLocacao(VprDLeitura,LocacaoCODFILIAL.AsInteger,LocacaoSEQLEITURA.AsInteger);
    FNovaLeituraLocacao := TFNovaLeituraLocacao.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaLeituraLocacao'));
    if FNovaLeituraLocacao.AlteraLeitura(VprDLeitura) then
      AtualizaConsulta(true);
    FNovaLeituraLocacao.free;
  end;
end;

{******************************************************************************}
procedure TFLeiturasLocacao.BConsultarClick(Sender: TObject);
begin
  VprDLeitura.free;
  VprDLeitura := TRBDLeituraLocacaoCorpo.cria;
  if LocacaoSEQLEITURA.AsInteger <> 0 then
  begin
    FunContratos.CarDLeituraLocacao(VprDLeitura,LocacaoCODFILIAL.AsInteger,LocacaoSEQLEITURA.AsInteger);
    FNovaLeituraLocacao := TFNovaLeituraLocacao.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaLeituraLocacao'));
    FNovaLeituraLocacao.ConsultaLeitura(VprDLeitura);
    FNovaLeituraLocacao.free;
  end;
end;

{******************************************************************************}
procedure TFLeiturasLocacao.BEnviarEmailClienteClick(Sender: TObject);
var
  VpfResultado : String;
begin
  VpfResultado := FunContratos.EnviaLeituraLocacaoProcessadaEmail(LocacaoCODFILIAL.AsInteger,LocacaoSEQLEITURA.AsInteger);
  if VpfREsultado <> '' then
    aviso(VpfREsultado);
end;

{******************************************************************************}
procedure TFLeiturasLocacao.BExcluirClick(Sender: TObject);
begin
  if confirmacao(CT_DeletaRegistro) then
  begin
    FunContratos.ExcluiLeituraLocacao(LocacaoCODFILIAL.AsInteger,LocacaoSEQLEITURA.AsInteger);
    AtualizaConsulta(true);
  end;
end;

{******************************************************************************}
procedure TFLeiturasLocacao.BImprimirClick(Sender: TObject);
begin
  if LocacaoSEQLEITURA.AsInteger <> 0 then
  begin
    dtRave := TdtRave.create(self);
    dtRave.ImprimeExtratoLocacao(LocacaoCODFILIAL.AsInteger,LocacaoSEQLEITURA.AsInteger,true);
    dtRave.free;
  end;
end;

{******************************************************************************}
procedure TFLeiturasLocacao.CTotaisClick(Sender: TObject);
begin
  AtualizaConsulta(false);
end;

{******************************************************************************}
procedure TFLeiturasLocacao.FormKeyDown(Sender: TObject; var Key: Word;
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
          ProcessaContratoFrio;
          VprPressionadoR := false;
        end
        else
          VprPressionadoR := false;
  end;
end;

{******************************************************************************}
procedure TFLeiturasLocacao.BGraficosClick(Sender: TObject);
begin
  PGraficos.Visible := true;
end;

{******************************************************************************}
procedure TFLeiturasLocacao.BFechaGraficoClick(Sender: TObject);
begin
  PGraficos.visible := false;
end;

{******************************************************************************}
procedure TFLeiturasLocacao.BVendedorClick(Sender: TObject);
begin
  GraficoCliente;
end;

{******************************************************************************}
procedure TFLeiturasLocacao.BClientesClick(Sender: TObject);
begin
  GraficoMes;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFLeiturasLocacao]);
end.
