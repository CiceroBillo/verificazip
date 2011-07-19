unit ATelemarketingFaccionista;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, DBCtrls, Tabela, Grids, DBGrids, DBKeyViolation, Componentes1,
  ExtCtrls, PainelGradiente, Buttons, Db, DBTables, ComCtrls, Localizacao,
  DBClient;

type
  TFTelemarketingFaccionista = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    PanelColor3: TPanelColor;
    GridIndice1: TGridIndice;
    GridIndice2: TGridIndice;
    DBMemoColor1: TDBMemoColor;
    BFechar: TBitBtn;
    Telemarketing: TSQL;
    TelemarketingCODFACCIONISTA: TFMTBCDField;
    TelemarketingSEQTELE: TFMTBCDField;
    TelemarketingDATLIGACAO: TSQLTimeStampField;
    TelemarketingDESFALADOCOM: TWideStringField;
    TelemarketingDATPROMETIDO: TSQLTimeStampField;
    TelemarketingDESOBSERVACAO: TWideStringField;
    TelemarketingQTDSEGUNDOSLIGACAO: TFMTBCDField;
    TelemarketingNOMFACCIONISTA: TWideStringField;
    TelemarketingC_NOM_USU: TWideStringField;
    TelemarketingDESHISTORICO: TWideStringField;
    DataTelemarketing: TDataSource;
    Localiza: TConsultaPadrao;
    Label9: TLabel;
    SpeedButton5: TSpeedButton;
    Label10: TLabel;
    Label2: TLabel;
    Label7: TLabel;
    SpeedButton4: TSpeedButton;
    Label6: TLabel;
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
    CPeriodo: TCheckBox;
    EIDEstagio: TEditLocaliza;
    EFilial: TEditLocaliza;
    EOrdemProducao: TEditLocaliza;
    EFracao: TEditLocaliza;
    Item: TSQL;
    DataItem: TDataSource;
    ItemDATCADASTRO: TSQLTimeStampField;
    ItemDATRETORNO: TSQLTimeStampField;
    ItemDATRENEGOCIADO: TSQLTimeStampField;
    ItemQTDENVIADO: TFMTBCDField;
    ItemDESUM: TWideStringField;
    ItemQTDPRODUZIDO: TFMTBCDField;
    ItemVALUNITARIO: TFMTBCDField;
    ItemVALUNITARIOPOSTERIOR: TFMTBCDField;
    ItemQTDLIGACAO: TFMTBCDField;
    ItemQTDRENEGOCIACAO: TFMTBCDField;
    ItemCODFILIAL: TFMTBCDField;
    ItemSEQORDEM: TFMTBCDField;
    ItemSEQFRACAO: TFMTBCDField;
    ItemSEQESTAGIO: TFMTBCDField;
    ItemSEQITEM: TFMTBCDField;
    ItemC_NOM_PRO: TWideStringField;
    ItemNOM_COR: TWideStringField;
    Splitter1: TSplitter;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure EOrdemProducaoSelect(Sender: TObject);
    procedure EFracaoSelect(Sender: TObject);
    procedure EDatInicioCloseUp(Sender: TObject);
    procedure TelemarketingAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
    procedure AtualizaConsulta;
    procedure AdicionaFiltros(VpaConsulta : TStrings);
    procedure PosTelemarketingItem;
  public
    { Public declarations }
    procedure VisualizaLigacoesFracaoFaccionista(VpaCodFaccionista, VpaCodFilial, VpaSeqOrdem, VpaSeqFracao, VpaSeqEstagio : Integer);
  end;

var
  FTelemarketingFaccionista: TFTelemarketingFaccionista;

implementation

uses APrincipal, funData,Funsql;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFTelemarketingFaccionista.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EDatInicio.DateTime := date;
  EDatFim.DateTime := date;
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFTelemarketingFaccionista.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFTelemarketingFaccionista.VisualizaLigacoesFracaoFaccionista(VpaCodFaccionista, VpaCodFilial, VpaSeqOrdem, VpaSeqFracao, VpaSeqEstagio : Integer);
begin
  EFaccionista.AInteiro := VpaCodFaccionista;
  EFilial.AInteiro := VpaCodFilial;
  EOrdemProducao.AInteiro := VpaSeqOrdem;
  EFracao.AInteiro := VpaSeqFracao;
  EIDEstagio.AInteiro := VpaSeqEstagio;
  AtualizaConsulta;
  ShowModal;
end;

{******************************************************************************}
procedure TFTelemarketingFaccionista.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFTelemarketingFaccionista.AtualizaConsulta;
begin
  Telemarketing.Sql.clear;
  Telemarketing.sql.add('SELECT TEC.CODFACCIONISTA, TEC.SEQTELE, TEC.DATLIGACAO, TEC.DESFALADOCOM, TEC.DATPROMETIDO, '+
                        ' TEC.DESOBSERVACAO, TEC.QTDSEGUNDOSLIGACAO, '+
                        ' FAC.NOMFACCIONISTA, '+
                        ' USU.C_NOM_USU, '+
                        ' HIS.DESHISTORICO '+
                        ' FROM TELEMARKETINGFACCIONISTACORPO TEC, FACCIONISTA FAC,  CADUSUARIOS USU, HISTORICOLIGACAO HIS '+
                        ' Where FAC.CODFACCIONISTA = TEC.CODFACCIONISTA '+
                        ' AND TEC.CODUSUARIO = USU.I_COD_USU '+
                        ' AND TEC.CODHISTORICO = HIS.CODHISTORICO');
  AdicionaFiltros(Telemarketing.sql);
  Telemarketing.sql.SaveToFile('c:\consulta.sql');
  Telemarketing.open;
end;

{******************************************************************************}
procedure TFTelemarketingFaccionista.AdicionaFiltros(VpaConsulta : TStrings);
begin
  if EFaccionista.AInteiro <> 0 then
    VpaConsulta.Add(' and TEC.CODFACCIONISTA = ' +EFaccionista.Text);
  if CPeriodo.Checked then
    VpaConsulta.add(SQLTextoDataEntreAAAAMMDD('TEC.DATLIGACAO',EDatInicio.DateTime,EDatFim.DateTime+1,true));
  if (EFilial.AInteiro <> 0) or (EIDEstagio.AInteiro <> 0) or
      (EOrdemProducao.AInteiro <> 0) or (EFracao.AInteiro <> 0) then
  begin
    VpaConsulta.add(' AND EXISTS (SELECT FRF.CODFACCIONISTA FROM FRACAOOPFACCIONISTA FRF, TELEMARKETINGFACCIONISTAITEM ITE '+
                    ' Where ITE.CODFACCIONISTA = TEC.CODFACCIONISTA '+
                    ' AND ITE.SEQTELE = TEC.SEQTELE '+
                    ' AND FRF.CODFACCIONISTA = ITE.CODFACCIONISTA '+
                    ' AND FRF.SEQITEM = ITE.SEQITEM ');
    if EIDEstagio.AInteiro <> 0 then
      VpaConsulta.add('and FRF.SEQESTAGIO = ' +EIDEstagio.Text);
    if EFilial.AInteiro <> 0 then
      VpaConsulta.Add('and FRF.CODFILIAL = '+EFilial.Text);
    if EOrdemProducao.AInteiro <> 0 then
      VpaConsulta.add('and FRF.SEQORDEM = '+EOrdemProducao.text);
    if EFracao.AInteiro <> 0 then
      VpaConsulta.add('and FRF.SEQFRACAO = '+EFracao.Text);
    VpaConsulta.ADD(')');
  end;
end;

{******************************************************************************}
procedure TFTelemarketingFaccionista.PosTelemarketingItem;
begin
  if TelemarketingCODFACCIONISTA.AsInteger <> 0 then
  begin
    AdicionaSQLAbreTabela(Item,'SELECT FRF.DATCADASTRO, FRF.DATRETORNO, FRF.DATRENEGOCIADO, FRF.QTDENVIADO, '+
                  ' FRF.DESUM, FRF.QTDPRODUZIDO, FRF.VALUNITARIO, FRF.VALUNITARIOPOSTERIOR, '+
                  ' FRF.QTDLIGACAO, FRF.QTDRENEGOCIACAO, FRF.CODFILIAL, '+
                  ' FRF.SEQORDEM, FRF.SEQFRACAO, FRF.SEQESTAGIO, FRF.SEQITEM,'+
                  ' PRO.C_NOM_PRO, COR.NOM_COR '+
                  ' FROM FRACAOOPFACCIONISTA FRF, ORDEMPRODUCAOCORPO ORD, COR, TELEMARKETINGFACCIONISTAITEM ITE, '+
                  ' CADPRODUTOS PRO '+
                  ' Where FRF.CODFILIAL = ORD.EMPFIL '+
                  ' and FRF.SEQORDEM  = ORD.SEQORD '+
                  ' and ORD.SEQPRO = PRO.I_SEQ_PRO '+
                  ' and ORD.CODCOM = COR.COD_COR '+
                  ' and FRF.CODFACCIONISTA = ITE.CODFACCIONISTA '+
                  ' and FRF.SEQITEM = ITE.SEQITEM ' +
                  ' and ITE.CODFACCIONISTA = ' +TelemarketingCODFACCIONISTA.AsString+
                  ' and ITE.SEQTELE = ' +TelemarketingSEQTELE.AsString);
  end;
end;

procedure TFTelemarketingFaccionista.EOrdemProducaoSelect(Sender: TObject);
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

procedure TFTelemarketingFaccionista.EFracaoSelect(Sender: TObject);
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
procedure TFTelemarketingFaccionista.EDatInicioCloseUp(Sender: TObject);
begin
  AtualizaConsulta;
end;

procedure TFTelemarketingFaccionista.TelemarketingAfterScroll(
  DataSet: TDataSet);
begin
  PosTelemarketingItem;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFTelemarketingFaccionista]);
end.
