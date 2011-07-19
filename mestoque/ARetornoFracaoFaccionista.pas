unit ARetornoFracaoFaccionista;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Grids, DBGrids, Tabela, DBKeyViolation, StdCtrls, Buttons, Componentes1, UnDadosProduto,
  ExtCtrls, PainelGradiente, Db, DBTables, ComCtrls, Localizacao, UnOrdemProducao,
  DBClient, RpCon, RpConDS, RpBase, RpSystem, RpDefine, RpRave;

type
  TFRetornoFracaoFaccionista = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BCadastrar: TBitBtn;
    BExcluir: TBitBtn;
    BFechar: TBitBtn;
    GridIndice1: TGridIndice;
    RetornoFracao: TSQL;
    DataRetornoFracao: TDataSource;
    Localiza: TConsultaPadrao;
    Label9: TLabel;
    SpeedButton5: TSpeedButton;
    Label10: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label8: TLabel;
    SpeedButton2: TSpeedButton;
    Label5: TLabel;
    Label7: TLabel;
    SpeedButton4: TSpeedButton;
    Label6: TLabel;
    Label1: TLabel;
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
    EFaccionista: TEditLocaliza;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    ETipoPeriodo: TComboBoxColor;
    CPeriodo: TCheckBox;
    EProduto: TEditLocaliza;
    EIDEstagio: TEditLocaliza;
    ECombinacao: TEditLocaliza;
    EFilial: TEditLocaliza;
    EOrdemProducao: TEditLocaliza;
    EFracao: TEditLocaliza;
    RetornoFracaoSEQRETORNO: TFMTBCDField;
    RetornoFracaoDATREAL: TSQLTimeStampField;
    RetornoFracaoQTDRETORNO: TFMTBCDField;
    ccc: TSQLTimeStampField;
    RetornoFracaoVALUNITARIO: TFMTBCDField;
    RetornoFracaoINDREVISADO: TWideStringField;
    RetornoFracaoINDFINALIZARFRACAO: TWideStringField;
    RetornoFracaoDATREVISADO: TSQLTimeStampField;
    RetornoFracaoCODUSUARIOREVISAO: TFMTBCDField;
    RetornoFracaoQTDREVISADO: TFMTBCDField;
    RetornoFracaoQTDDEFEITO: TFMTBCDField;
    RetornoFracaoDATCADASTRO: TSQLTimeStampField;
    RetornoFracaoCODFILIAL: TFMTBCDField;
    RetornoFracaoSEQORDEM: TFMTBCDField;
    RetornoFracaoSEQFRACAO: TFMTBCDField;
    RetornoFracaoSEQESTAGIO: TFMTBCDField;
    RetornoFracaoQTDENVIADO: TFMTBCDField;
    RetornoFracaoDESUM: TWideStringField;
    RetornoFracaoCODFACCIONISTA: TFMTBCDField;
    RetornoFracaoSEQITEM: TFMTBCDField;
    RetornoFracaoNOMFACCIONISTA: TWideStringField;
    RetornoFracaoC_NOM_PRO: TWideStringField;
    RetornoFracaoNOM_COR: TWideStringField;
    RetornoFracaoDiasProducao: TFMTBCDField;
    CNaoRevisados: TCheckBox;
    BRevisao: TBitBtn;
    RetornoFracaoC_COD_PRO: TWideStringField;
    RetornoFracaoINDDEFEITO: TWideStringField;
    RetornoFracaoDEFEITO: TWideStringField;
    BEstornarRevisao: TBitBtn;
    BImprimir: TBitBtn;
    Rave: TRvProject;
    RvSystem1: TRvSystem;
    RvFaccionista: TRvDataSetConnection;
    RetornoFracaoCOD_COR: TFMTBCDField;
    RetornoFracaoDATDIGITACAO: TSQLTimeStampField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCadastrarClick(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure RetornoFracaoCalcFields(DataSet: TDataSet);
    procedure EDatInicioCloseUp(Sender: TObject);
    procedure EProdutoRetorno(Retorno1, Retorno2: String);
    procedure EOrdemProducaoSelect(Sender: TObject);
    procedure EFracaoSelect(Sender: TObject);
    procedure BExcluirClick(Sender: TObject);
    procedure BRevisaoClick(Sender: TObject);
    procedure BEstornarRevisaoClick(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
  private
    { Private declarations }
    VprSeqProduto : Integer;
    FunOrdemProducao : TRBFuncoesOrdemProducao;
    procedure ConfiguraPermissaoUsuario;
    procedure AtualizaConsulta;
    procedure AdicionaFiltro(VpaConsulta : TStrings);
  public
    { Public declarations }
    procedure ConsultaRetornosFracaoFaccionista(VpaCodFilial, VpaSeqOrdem, VpaSeqFracao, VpaSeqEstagio, VpaCodFaccionista : Integer);
  end;

var
  FRetornoFracaoFaccionista: TFRetornoFracaoFaccionista;

implementation

uses APrincipal, ANovaFracaoFaccionista, FunData, FunSql, Constmsg,Constantes, FunObjeto;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFRetornoFracaoFaccionista.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  ConfiguraPermissaoUsuario;
  FunOrdemProducao := TRBFuncoesOrdemProducao.cria(FPrincipal.BaseDados);
  VprSeqProduto := 0;
  EDatInicio.DateTime := date;
  EDatFim.DateTime := date;
  ETipoPeriodo.ItemIndex := 0;
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFRetornoFracaoFaccionista.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  RetornoFracao.close;
  FunOrdemProducao.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFRetornoFracaoFaccionista.ConsultaRetornosFracaoFaccionista(VpaCodFilial, VpaSeqOrdem, VpaSeqFracao, VpaSeqEstagio, VpaCodFaccionista : Integer);
begin
  CPeriodo.Checked := false;
  EFilial.AInteiro := VpaCodFilial;
  EOrdemProducao.AInteiro := VpaSeqOrdem;
  EFracao.AInteiro := VpaSeqFracao;
  EFaccionista.AInteiro := VpaCodFaccionista;
  EIDEstagio.AInteiro := VpaSeqEstagio;
  atualizaconsulta;
  showmodal;
end;

{******************************************************************************}
procedure TFRetornoFracaoFaccionista.BCadastrarClick(Sender: TObject);
begin
  FNovaFracaoFaccionista := TFNovaFracaoFaccionista.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaFracaoFaccionista'));
  if FNovaFracaoFaccionista.RetornoFracaoFaccionista then
    AtualizaConsulta;
  FNovaFracaoFaccionista.free;
end;

{******************************************************************************}
procedure TFRetornoFracaoFaccionista.ConfiguraPermissaoUsuario;
begin
  if not((puAdministrador in varia.PermissoesUsuario) or (puESCompleto in varia.PermissoesUsuario)) then
  begin
    AlterarVisibleDet([BCadastrar,BExcluir,BEstornarRevisao],false);
    if (puESAdicionarRetornoFracaoFaccionista in Varia.PermissoesUsuario) then
      BCadastrar.Visible := true;
    if (puESExcluirRetornoFracaoFaccionista in varia.PermissoesUsuario) then
      BExcluir.Visible := true;
    if (puESEstornarRevisaoFaccionista in varia.PermissoesUsuario) then
      BEstornarRevisao.Visible := true;
  end;
end;

{******************************************************************************}
procedure TFRetornoFracaoFaccionista.AtualizaConsulta;
begin
  RetornoFracao.Close;
  RetornoFracao.sql.clear;
  RetornoFracao.sql.add('select RFF.SEQRETORNO, RFF.DATCADASTRO DATREAL, RFF.QTDRETORNO,  FRF.DATRETORNO,RFF.VALUNITARIO, '+
                        ' RFF.INDREVISADO, RFF.INDFINALIZARFRACAO, RFF.DATREVISADO, RFF.CODUSUARIOREVISAO, RFF.QTDREVISADO, RFF.QTDDEFEITO, '+
                        ' RFF.DATDIGITACAO, '+
                        ' FRF.DATCADASTRO, FRF.CODFILIAL, FRF.SEQORDEM,FRF.SEQFRACAO, FRF.SEQESTAGIO, FRF.QTDENVIADO, '+
                        ' FRF.DESUM, FRF.CODFACCIONISTA, FRF.SEQITEM, FRF.INDDEFEITO, '+
                        ' FAC.NOMFACCIONISTA, '+
                        ' PRO.C_NOM_PRO, PRO.C_COD_PRO, COR.COD_COR, '+
                        ' COR.NOM_COR '+
                        ' from RETORNOFRACAOOPFACCIONISTA RFF, FRACAOOPFACCIONISTA FRF, FACCIONISTA FAC, ORDEMPRODUCAOCORPO ORD, '+
                        ' CADPRODUTOS PRO, COR '+
                        ' Where RFF.CODFACCIONISTA = FRF.CODFACCIONISTA '+
                        ' AND RFF.SEQITEM = FRF.SEQITEM ' +
                        ' AND FRF.CODFACCIONISTA = FAC.CODFACCIONISTA '+
                        ' AND FRF.CODFILIAL = ORD.EMPFIL '+
                        ' AND FRF.SEQORDEM = ORD.SEQORD '+
                        ' AND ORD.SEQPRO = PRO.I_SEQ_PRO '+
                        ' AND '+SQLTextoRightJoin('ORD.CODCOM','COR.COD_COR'));
  AdicionaFiltro(RetornoFracao.SQl);
  RetornoFracao.open;
end;

{******************************************************************************}
procedure TFRetornoFracaoFaccionista.AdicionaFiltro(VpaConsulta : TStrings);
begin
  if EFaccionista.AInteiro <> 0 then
    VpaConsulta.Add(' and FRF.CODFACCIONISTA = ' +EFaccionista.Text);
  if CPeriodo.Checked and not CNaoRevisados.Checked then
  begin
    case ETipoPeriodo.ItemIndex of
      0 : VpaConsulta.add(SQLTextoDataEntreAAAAMMDD('RFF.DATCADASTRO',EDatInicio.DateTime,EDatFim.DateTime+1,true));
      1 : VpaConsulta.add(SQLTextoDataEntreAAAAMMDD('RFF.DATREVISADO',EDatInicio.DateTime,EDatFim.DateTime+1,true));
    end;
  end;
  if CNaoRevisados.Checked then
    VpaConsulta.add(' and RFF.INDREVISADO = ''N''');
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
procedure TFRetornoFracaoFaccionista.BFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFRetornoFracaoFaccionista.BImprimirClick(Sender: TObject);
begin
  Rave.close;
  Rave.ProjectFile := varia.PathRelatorios+'\Faccionista\XX_Retorno Fracoes Faccionista.rav';
  if CPeriodo.Checked then
    Rave.SetParam('PERIODO',FormatDateTime('DD/MM/YY',EDatINicio.DateTime)+' - '+FormatDateTime('DD/MM/YY',EDatFim.DateTime));
  Rave.SetParam('FACCIONISTA',Label10.Caption);
  Rave.execute;
end;

{******************************************************************************}
procedure TFRetornoFracaoFaccionista.RetornoFracaoCalcFields(
  DataSet: TDataSet);
begin
  RetornoFracaoDiasProducao.AsInteger := DiasPorPeriodo(RetornoFracaoDATCADASTRO.AsDateTime,RetornoFracaoDATREAL.AsDateTime);
end;

{******************************************************************************}
procedure TFRetornoFracaoFaccionista.EDatInicioCloseUp(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFRetornoFracaoFaccionista.EProdutoRetorno(Retorno1,
  Retorno2: String);
begin
  if Retorno1 <> '' then
    VprSeqProduto := StrToInt(Retorno1)
  else
    VprSeqProduto := 0;
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFRetornoFracaoFaccionista.EOrdemProducaoSelect(Sender: TObject);
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

procedure TFRetornoFracaoFaccionista.EFracaoSelect(Sender: TObject);
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
procedure TFRetornoFracaoFaccionista.BEstornarRevisaoClick(Sender: TObject);
var
  VpfResultado : string;
begin
  if confirmacao('Tem certeza que deseja estornar a revisão') then
  begin
    VpfResultado := FunOrdemProducao.EstornaRevisaoRetornoFracao(RetornoFracaoCODFACCIONISTA.AsInteger,RetornoFracaoSEQRETORNO.AsInteger,RetornoFracaoSEQITEM.AsInteger);
    if  VpfResultado <> '' then
      aviso(VpfResultado)
    else
      AtualizaConsulta;
  end;

end;

{******************************************************************************}
procedure TFRetornoFracaoFaccionista.BExcluirClick(Sender: TObject);
begin
  if RetornoFracaoCODFILIAL.AsInteger <> 0 then
  begin
    if confirmacao(CT_DeletarItem) then
    begin
      FunOrdemProducao.ExcluiRetornoFracaoFaccionista(RetornoFracaoCODFACCIONISTA.AsInteger,RetornoFracaoSEQITEM.AsInteger,RetornoFracaoSEQRETORNO.AsInteger);
      AtualizaConsulta;
    end;
  end;
end;

{******************************************************************************}
procedure TFRetornoFracaoFaccionista.BRevisaoClick(Sender: TObject);
var
  VpfDRevisao : TRBDRevisaoFracaoFaccionista;
begin
  if RetornoFracaoCODFILIAL.AsInteger <> 0 then
  begin
    VpfDRevisao := TRBDRevisaoFracaoFaccionista.cria;
    VpfDRevisao.CodFaccionista := RetornoFracaoCODFACCIONISTA.AsInteger;
    VpfDRevisao.SeqItem := RetornoFracaoSEQITEM.AsInteger;
    VpfDRevisao.SEqRetorno := RetornoFracaoSEQRETORNO.AsInteger;
    VpfDRevisao.CodFilial := RetornoFracaoCODFILIAL.AsInteger;
    VpfDRevisao.SeqOrdem := RetornoFracaoSEQORDEM.AsInteger;
    VpfDRevisao.SeqFracao := RetornoFracaoSEQFRACAO.AsInteger;
    VpfDRevisao.SeqEstagio := RetornoFracaoSEQESTAGIO.AsInteger;
    VpfDRevisao.CodProduto := RetornoFracaoC_COD_PRO.AsString;
    VpfDRevisao.NomProduto := RetornoFracaoC_NOM_PRO.AsString;

    FNovaFracaoFaccionista := TFNovaFracaoFaccionista.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaFracaoFaccionista'));
    if FNovaFracaoFaccionista.RevisaoFracaoFaccionista(VpfDRevisao)  then
      AtualizaConsulta;
    FNovaFracaoFaccionista.free;
    VpfDRevisao.free;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFRetornoFracaoFaccionista]);
end.
