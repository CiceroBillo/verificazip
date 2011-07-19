unit AFracaoFaccionista;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Grids, DBGrids, Tabela,
  DBKeyViolation, StdCtrls, ComCtrls, Localizacao, Buttons, Db, DBTables, UnOrdemProducao,
  Menus, DBClient, RpCon, RpConDS, RpBase, RpSystem, RpDefine, RpRave;

type
  TFFracaoFaccionista = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    GridIndice1: TGridIndice;
    Localiza: TConsultaPadrao;
    Label9: TLabel;
    SpeedButton5: TSpeedButton;
    LFaccionista: TLabel;
    EFaccionista: TEditLocaliza;
    Label2: TLabel;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    ETipoPeriodo: TComboBoxColor;
    Label4: TLabel;
    ESituacao: TComboBoxColor;
    FracaoFaccionista: TSQL;
    FracaoFaccionistaDATCADASTRO: TSQLTimeStampField;
    FracaoFaccionistaCODFILIAL: TFMTBCDField;
    FracaoFaccionistaSEQORDEM: TFMTBCDField;
    FracaoFaccionistaSEQFRACAO: TFMTBCDField;
    FracaoFaccionistaSEQESTAGIO: TFMTBCDField;
    FracaoFaccionistaQTDENVIADO: TFMTBCDField;
    FracaoFaccionistaVALUNITARIO: TFMTBCDField;
    FracaoFaccionistaQTDPRODUZIDO: TFMTBCDField;
    FracaoFaccionistaDATRETORNO: TSQLTimeStampField;
    FracaoFaccionistaQTDDEFEITO: TFMTBCDField;
    FracaoFaccionistaDATFINALIZACAO: TSQLTimeStampField;
    FracaoFaccionistaNOMFACCIONISTA: TWideStringField;
    FracaoFaccionistaDESTELEFONE1: TWideStringField;
    FracaoFaccionistaC_NOM_PRO: TWideStringField;
    FracaoFaccionistaNOM_COR: TWideStringField;
    DataFracaoFaccionista: TDataSource;
    FracaoFaccionistaDESUM: TWideStringField;
    CPeriodo: TCheckBox;
    Label3: TLabel;
    Label8: TLabel;
    EProduto: TEditLocaliza;
    SpeedButton2: TSpeedButton;
    Label5: TLabel;
    Label7: TLabel;
    SpeedButton4: TSpeedButton;
    Label6: TLabel;
    Label1: TLabel;
    ECombinacao: TEditLocaliza;
    SpeedButton1: TSpeedButton;
    Label11: TLabel;
    Label12: TLabel;
    SpeedButton3: TSpeedButton;
    Label13: TLabel;
    Label14: TLabel;
    SpeedButton6: TSpeedButton;
    Label15: TLabel;
    Label16: TLabel;
    SpeedButton7: TSpeedButton;
    Label17: TLabel;
    EFilial: TEditLocaliza;
    EOrdemProducao: TEditLocaliza;
    EFracao: TEditLocaliza;
    FracaoFaccionistaCODFACCIONISTA: TFMTBCDField;
    FracaoFaccionistaSEQITEM: TFMTBCDField;
    PopupMenu1: TPopupMenu;
    VisualizaEntregas1: TMenuItem;
    FracaoFaccionistaQTDDEVOLUCAO: TFMTBCDField;
    FracaoFaccionistaDATRENEGOCIADO: TSQLTimeStampField;
    FracaoFaccionistaDATANEGOCIADO: TWideStringField;
    N1: TMenuItem;
    MFinalizaFracao: TMenuItem;
    FracaoFaccionistaC_NOM_USU: TWideStringField;
    FracaoFaccionistaINDDEFEITO: TWideStringField;
    FracaoFaccionistaDEFEITO: TWideStringField;
    FracaoFaccionistaCOD_COR: TFMTBCDField;
    Rave: TRvProject;
    RvSystem1: TRvSystem;
    RvFaccionista: TRvDataSetConnection;
    FracaoFaccionistaC_COD_PRO: TWideStringField;
    FracaoFaccionistaDATDIGITACAO: TSQLTimeStampField;
    FracaoFaccionistaSALDO: TFloatField;
    EIDEstagio: TEditLocaliza;
    PTotal: TPanelColor;
    Label10: TLabel;
    EQtdTotalEnviado: TEditColor;
    CTotal: TCheckBox;
    Label18: TLabel;
    EQtdTotalRecebido: TEditColor;
    Aux: TSQL;
    PanelColor2: TPanelColor;
    BCadastrar: TBitBtn;
    BFechar: TBitBtn;
    BExcluir: TBitBtn;
    BImprimir: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EDatInicioCloseUp(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure BCadastrarClick(Sender: TObject);
    procedure EProdutoRetorno(Retorno1, Retorno2: String);
    procedure EIDEstagioSelect(Sender: TObject);
    procedure EOrdemProducaoSelect(Sender: TObject);
    procedure EFracaoSelect(Sender: TObject);
    procedure BExcluirClick(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure VisualizaEntregas1Click(Sender: TObject);
    procedure FracaoFaccionistaCalcFields(DataSet: TDataSet);
    procedure MFinalizaFracaoClick(Sender: TObject);
    procedure GridIndice1Ordem(Ordem: string);
    procedure EIDEstagioExit(Sender: TObject);
    procedure CTotalClick(Sender: TObject);
  private
    { Private declarations }
    VprSeqProduto,
    VprLanOrcamento : Integer;
    FunOrdemProducao : TRBFuncoesOrdemProducao;
    VprOrdem : String;
    procedure ConfiguraPermissaoUsuario;
    procedure AtualizaConsulta;
    procedure AdicionaFiltro(VpaConsulta : TStrings);
    procedure AtualizaTotal;
  public
    { Public declarations }
    procedure ConsultaFracaoPedido(VpaCodFilial, VpaNumOP : Integer);
  end;

var
  FFracaoFaccionista: TFFracaoFaccionista;

implementation

uses APrincipal, FunSql, FundAta, ANovaFracaoFaccionista, ConstMsg, constantes, FunObjeto,
     UnCrystal, ARetornoFracaoFaccionista;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFFracaoFaccionista.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprOrdem := 'order by FRF.DATCADASTRO';
  ConfiguraPermissaoUsuario;
  FunOrdemProducao := TRBFuncoesOrdemProducao.cria(FPrincipal.BaseDados);
  VprSeqProduto := 0;
  ETipoPeriodo.ItemIndex := 0;
  ESituacao.ItemIndex := 0;
  CPeriodo.Checked := true;
  EDatInicio.DateTime := PrimeiroDiaMes(date);
  EDatFim.DateTime := UltimoDiaMes(date);
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFFracaoFaccionista.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunOrdemProducao.free;
  FracaoFaccionista.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFFracaoFaccionista.AtualizaConsulta;
begin
  EQtdTotalEnviado.Text := '0';
  EQtdTotalRecebido.Text:= '0';
  FracaoFaccionista.Close;
  FracaoFaccionista.sql.clear;
  FracaoFaccionista.sql.add('select FRF.DATCADASTRO, FRF.CODFILIAL, FRF.SEQORDEM,FRF.SEQFRACAO, FRF.SEQESTAGIO, '+
            'FRF.QTDENVIADO, FRF.VALUNITARIO, FRF.QTDPRODUZIDO, FRF.QTDDEVOLUCAO, FRF.DATRETORNO, FRF.QTDDEFEITO, FRF.DATFINALIZACAO, '+
            ' FRF.DESUM, FRF.CODFACCIONISTA, FRF.SEQITEM, FRF.DATRENEGOCIADO, FRF.INDDEFEITO, FRF.DATDIGITACAO,'+
            ' FAC.NOMFACCIONISTA, FAC.DESTELEFONE1, '+
            ' PRO.C_COD_PRO, PRO.C_NOM_PRO, ' +
            ' COR.COD_COR, COR.NOM_COR, USU.C_NOM_USU ' +
            ' from FRACAOOPFACCIONISTA FRF, FACCIONISTA FAC, ORDEMPRODUCAOCORPO ORD, ' +
            ' CADPRODUTOS PRO, COR, CADUSUARIOS USU '+
            ' Where FRF.CODFACCIONISTA = FAC.CODFACCIONISTA '+
            ' AND FRF.CODFILIAL = ORD.EMPFIL '+
            ' AND FRF.SEQORDEM = ORD.SEQORD ' +
            ' AND ORD.SEQPRO = PRO.I_SEQ_PRO '+
            ' AND FRF.CODUSUARIO = USU.I_COD_USU '+
            ' AND '+SQLTextoRightJoin('ORD.CODCOM','COR.COD_COR'));
  AdicionaFiltro(FracaoFaccionista.sql);
  FracaoFaccionista.Sql.add(VprOrdem);
  FracaoFaccionista.open;
  GridIndice1.ALinhaSQLOrderBy := FracaoFaccionista.SQL.Count - 1;
  AtualizaTotal
end;

{******************************************************************************}
procedure TFFracaoFaccionista.AtualizaTotal;
begin
  Aux.Close;
  Aux.sql.Clear;
  AdicionaSQLTabela(Aux,'Select FRF.DATCADASTRO, FRF.CODFILIAL, FRF.SEQORDEM,FRF.SEQFRACAO, FRF.SEQESTAGIO, '+
                        'FRF.QTDENVIADO, FRF.VALUNITARIO, FRF.QTDPRODUZIDO, FRF.QTDDEVOLUCAO, FRF.DATRETORNO, FRF.QTDDEFEITO, FRF.DATFINALIZACAO, '+
                        ' FRF.DESUM, FRF.CODFACCIONISTA, FRF.SEQITEM, FRF.DATRENEGOCIADO, FRF.INDDEFEITO, FRF.DATDIGITACAO, ' +
                        ' Sum(QTDENVIADO) ENVIADO, SUM(QTDPRODUZIDO) PRODUZIDO '+
                        ' FROM FRACAOOPFACCIONISTA FRF ' +
                        ' WHERE CODFACCIONISTA = CODFACCIONISTA ');
  AdicionaFiltro(Aux.Sql);
  aux.SQL.Add(' group by FRF.DATCADASTRO, FRF.CODFILIAL, FRF.SEQORDEM,FRF.SEQFRACAO, FRF.SEQESTAGIO, '+
              ' FRF.QTDENVIADO, FRF.VALUNITARIO, FRF.QTDPRODUZIDO, FRF.QTDDEVOLUCAO, FRF.DATRETORNO, FRF.QTDDEFEITO, FRF.DATFINALIZACAO, '+
              ' FRF.DESUM, FRF.CODFACCIONISTA, FRF.SEQITEM, FRF.DATRENEGOCIADO, FRF.INDDEFEITO, FRF.DATDIGITACAO');
  Aux.open;
  while not aux.Eof do
  begin
     EQtdTotalEnviado.AInteiro := EQtdTotalEnviado.AInteiro + Aux.FieldByName('ENVIADO').AsInteger;
     EQtdTotalRecebido.AInteiro := EQtdTotalRecebido.AInteiro + Aux.FieldByName('PRODUZIDO').AsInteger;
     aux.Next;
  end;
end;

{******************************************************************************}
procedure TFFracaoFaccionista.AdicionaFiltro(VpaConsulta : TStrings);
begin
  if VprLanOrcamento <> 0 then
    VpaConsulta.Add('AND ORD.NUMPED = '+IntToStr(VprLanOrcamento));
  if EFaccionista.AInteiro <> 0 then
    VpaConsulta.Add(' and FRF.CODFACCIONISTA = ' +EFaccionista.Text);
  if CPeriodo.Checked then
  begin
    case ETipoPeriodo.ItemIndex of
      0 : VpaConsulta.add(SQLTextoDataEntreAAAAMMDD('FRF.DATCADASTRO',EDatInicio.DateTime,EDatFim.DateTime,true));
      1 : VpaConsulta.add(SQLTextoDataEntreAAAAMMDD('FRF.DATRETORNO',EDatInicio.DateTime,EDatFim.DateTime,true));
      2 : VpaConsulta.add(SQLTextoDataEntreAAAAMMDD('FRF.DATFINALIZACAO',EDatInicio.DateTime,EDatFim.DateTime,true));
    end;
  end;
  case ESituacao.ItemIndex of
    1 : VpaConsulta.add(' and FRF.DATFINALIZACAO IS NULL');
    2 : VpaConsulta.add(' AND FRF.DATFINALIZACAO IS NOT NULL');
  end;
  if VprSeqProduto <> 0 then
    VpaConsulta.add(' and ORD.SEQPRO = ' +IntToStr(VprSeqProduto));
  if EIDEstagio.AInteiro <> 0 then
    VpaConsulta.add('and FRF.SEQESTAGIO = ' +EIDEstagio.Text);
  if ECombinacao.AInteiro <> 0 then
    VpaConsulta.add('and ORD.CODCOM = '+ECombinacao.Text);
  if EFilial.AInteiro <> 0 then
    VpaConsulta.Add('and FRF.CODFILIAL = '+EFilial.Text);
  if EOrdemProducao.AInteiro <> 0 then
    VpaConsulta.add('and FRF.SEQORDEM = '+EOrdemProducao.text);
  if EFracao.AInteiro <> 0 then
    VpaConsulta.add('and FRF.SEQFRACAO = '+EFracao.Text);
end;

{******************************************************************************}
procedure TFFracaoFaccionista.ConfiguraPermissaoUsuario;
begin
  if not((puAdministrador in varia.PermissoesUsuario) or (puESCompleto in varia.PermissoesUsuario)) then
  begin
    AlterarVisibleDet([BCadastrar,BExcluir,MFinalizaFracao],false);
    if (puESAdicionarFracaoFaccionista in Varia.PermissoesUsuario) then
      BCadastrar.Visible := true;
    if (puESExcluirFracaoFaccionista in varia.PermissoesUsuario) then
      AlterarVisibleDet([BExcluir,MFinalizaFracao],true);
  end;
end;

{******************************************************************************}
procedure TFFracaoFaccionista.ConsultaFracaoPedido(VpaCodFilial, VpaNumOP: Integer);
begin
  EFilial.AInteiro := VpaCodFilial;
  EFilial.Atualiza;
  EOrdemProducao.AInteiro := VpaNumOP;
  EOrdemProducao.Atualiza;
  CPeriodo.Checked:= false;
  AtualizaConsulta;
  ShowModal;
end;

{******************************************************************************}
procedure TFFracaoFaccionista.CTotalClick(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFFracaoFaccionista.EDatInicioCloseUp(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFFracaoFaccionista.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFFracaoFaccionista.BCadastrarClick(Sender: TObject);
begin
  FNovaFracaoFaccionista := TFNovaFracaoFaccionista.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaFracaoFaccionista'));
  if FNovaFracaoFaccionista.NovaFracaoFaccionista then
    AtualizaConsulta;
  FNovaFracaoFaccionista.free;
end;

{******************************************************************************}
procedure TFFracaoFaccionista.EProdutoRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
    VprSeqProduto := StrToInt(Retorno1)
  else
    VprSeqProduto := 0;
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFFracaoFaccionista.EIDEstagioExit(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFFracaoFaccionista.EIDEstagioSelect(Sender: TObject);
begin
  EIDEstagio.ASelectValida.Text := 'Select ESP.SEQESTAGIO, ESP.DESESTAGIO FROM PRODUTOESTAGIO ESP '+
                                   ' Where SEQPRODUTO = '+IntToStr(VprSeqProduto)+
                                   ' AND SEQESTAGIO = @ ';
  EIDEstagio.ASelectLocaliza.Text := 'Select ESP.SEQESTAGIO, ESP.DESESTAGIO FROM PRODUTOESTAGIO ESP '+
                                   ' Where SEQPRODUTO = '+IntToStr(VprSeqProduto)+
                                   ' AND DESESTAGIO LIKE ''@%''';
end;

{******************************************************************************}
procedure TFFracaoFaccionista.EOrdemProducaoSelect(Sender: TObject);
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
procedure TFFracaoFaccionista.EFracaoSelect(Sender: TObject);
begin
  EFracao.ASelectLocaliza.Text := 'SELECT FRA.SEQFRACAO, FRA.DATENTREGA ||'' - '' || FRA.QTDPRODUTO DATENTREGA, FRA.QTDPRODUTO, FRA.CODESTAGIO from FRACAOOP FRA '+
                                  ' Where FRA.SEQFRACAO LIKE ''@%'''+
                                  ' AND FRA.CODFILIAL = '+IntToStr(EFilial.AInteiro)+
                                  ' and FRA.SEQORDEM = '+IntToStr(EOrdemProducao.AInteiro);
  EFracao.ASelectValida.Text := 'SELECT FRA.SEQFRACAO, FRA.DATENTREGA ||'' - '' || FRA.QTDPRODUTO DATENTREGA, FRA.QTDPRODUTO, FRA.CODESTAGIO from FRACAOOP FRA '+
                                  ' Where FRA.SEQFRACAO = @ '+
                                  ' AND FRA.CODFILIAL = '+IntToStr(EFilial.AInteiro)+
                                  ' and FRA.SEQORDEM = '+IntToStr(EOrdemProducao.AInteiro);
end;

{******************************************************************************}
procedure TFFracaoFaccionista.BExcluirClick(Sender: TObject);
begin
  if confirmacao(CT_DeletarItem) then
  begin
    FunOrdemProducao.ExcluiFracaoFaccionista(FracaoFaccionistaCODFACCIONISTA.AsInteger,FracaoFaccionistaSEQITEM.AsInteger);
    AtualizaConsulta;
  end;
end;

{******************************************************************************}
procedure TFFracaoFaccionista.BImprimirClick(Sender: TObject);
begin
  Rave.close;
  Rave.ProjectFile := varia.PathRelatorios+'\Faccionista\XX_Fracoes Enviadas Faccionista.rav';
  if CPeriodo.Checked then
    Rave.SetParam('PERIODO',FormatDateTime('DD/MM/YY',EDatINicio.DateTime)+' - '+FormatDateTime('DD/MM/YY',EDatFim.DateTime));
  Rave.SetParam('FACCIONISTA',LFaccionista.Caption);
  Rave.execute;
end;

{******************************************************************************}
procedure TFFracaoFaccionista.VisualizaEntregas1Click(Sender: TObject);
begin
  if FracaoFaccionistaCODFILIAL.AsInteger <> 0 then
  begin
    FRetornoFracaoFaccionista := TFRetornoFracaoFaccionista.CriarSDI(self,'',FPrincipal.VerificaPermisao('FRetornoFracaoFaccionista'));
    FRetornoFracaoFaccionista.ConsultaRetornosFracaoFaccionista(FracaoFaccionistaCODFILIAL.AsInteger,FracaoFaccionistaSEQORDEM.AsInteger,FracaoFaccionistaSEQFRACAO.AsInteger,
                                         FracaoFaccionistaSEQESTAGIO.AsInteger,FracaoFaccionistaCODFACCIONISTA.AsInteger);
    FRetornoFracaoFaccionista.free;
  end;
end;

{******************************************************************************}
procedure TFFracaoFaccionista.FracaoFaccionistaCalcFields(
  DataSet: TDataSet);
begin
  IF (FracaoFaccionistaDATRENEGOCIADO.AsDateTime = (FracaoFaccionistaDATRETORNO.AsDateTime + 1)) then
    FracaoFaccionistaDATANEGOCIADO.Clear
  else
    FracaoFaccionistaDATANEGOCIADO.AsString := FormatDateTime('DD/MM/YYYY',FracaoFaccionistaDATRENEGOCIADO.AsDateTime);
  if FracaoFaccionistaINDDEFEITO.AsString = 'S' then
    FracaoFaccionistaDEFEITO.AsString := 'DEFEITO'
  else
    FracaoFaccionistaDEFEITO.AsString := '';
  FracaoFaccionistaSALDO.AsFloat := FracaoFaccionistaQTDENVIADO.AsFloat - FracaoFaccionistaQTDPRODUZIDO.AsFloat - FracaoFaccionistaQTDDEFEITO.AsFloat - FracaoFaccionistaQTDDEVOLUCAO.AsFloat;
end;

{******************************************************************************}
procedure TFFracaoFaccionista.GridIndice1Ordem(Ordem: string);
begin
  VprOrdem := Ordem;
end;

{******************************************************************************}
procedure TFFracaoFaccionista.MFinalizaFracaoClick(Sender: TObject);
begin
  if confirmacao('Tem certeza que deseja finalizar a fração?') then
  begin
    FunOrdemProducao.FinalizaFracaoFraccionista(FracaoFaccionistaCODFACCIONISTA.AsInteger,FracaoFaccionistaSEQITEM.AsInteger);
    AtualizaConsulta;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFFracaoFaccionista]);
end.
