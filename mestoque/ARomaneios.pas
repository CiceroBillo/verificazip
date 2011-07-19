unit ARomaneios;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Db, DBTables, Grids, DBGrids, Tabela, DBKeyViolation, Componentes1,
  ExtCtrls, PainelGradiente, StdCtrls, ComCtrls, Buttons, UnOrdemProducao,
  Mask, numericos, DBClient, UnRave;

type
  TFRomaneios = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    RomaneioCorpo: TSQL;
    DataRomaneioCorpo: TDataSource;
    RomaneioCorpoEMPFIL: TFMTBCDField;
    RomaneioCorpoSEQROM: TFMTBCDField;
    RomaneioCorpoDATINI: TSQLTimeStampField;
    RomaneioCorpoDATFIM: TSQLTimeStampField;
    RomaneioCorpoNOTGER: TWideStringField;
    RomaneioCorpoINDIMP: TWideStringField;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    ESituacaoNota: TComboBoxColor;
    ESituacaoImpressao: TComboBoxColor;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    BCadastrar: TBitBtn;
    BExcluirColeta: TBitBtn;
    BGerarNota: TBitBtn;
    BImprimir: TBitBtn;
    BFechar: TBitBtn;
    RomaneioItem: TSQL;
    DataRomaneioItem: TDataSource;
    RomaneioItemC_NOM_PRO: TWideStringField;
    RomaneioItemNUMPED: TFMTBCDField;
    RomaneioItemVALUNI: TFMTBCDField;
    RomaneioItemCODCOM: TFMTBCDField;
    RomaneioItemCODMAN: TWideStringField;
    RomaneioItemNROFIT: TFMTBCDField;
    RomaneioItemMETCOL: TFMTBCDField;
    RomaneioItemTOTALKM: TFMTBCDField;
    PanelColor3: TPanelColor;
    GridIndice2: TGridIndice;
    GridIndice1: TGridIndice;
    BFinaliza: TBitBtn;
    RomaneioItemSEQORD: TFMTBCDField;
    RomaneioItemSEQCOL: TFMTBCDField;
    RomaneioItemSEQROM: TFMTBCDField;
    Aux: TSQL;
    RomaneioCorpoNRONOT: TFMTBCDField;
    ESeqRomaneio: Tnumerico;
    Label5: TLabel;
    RomaneioItemCODPRO: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RomaneioCorpoAfterScroll(DataSet: TDataSet);
    procedure BFecharClick(Sender: TObject);
    procedure EDatInicioExit(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure BFinalizaClick(Sender: TObject);
    procedure BGerarNotaClick(Sender: TObject);
    procedure BExcluirColetaClick(Sender: TObject);
  private
    { Private declarations }
    FunOrdemProducao : TRBFuncoesOrdemProducao;
    FunRave : TRBFunRave;
    procedure AtualizaConsulta;
    procedure AtualizaConsultaItem;
  public
    { Public declarations }
  end;

var
  FRomaneios: TFRomaneios;

implementation

uses APrincipal, FunSql,FunData, ConstMsg,
  ANovaNotaFiscalNota;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFRomaneios.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunRave := TRBFunRave.cria(FPrincipal.BaseDados);
  ESituacaoNota.ItemIndex := 0;
  ESituacaoImpressao.ItemIndex := 2;
  EDatInicio.DateTime := DATE;
  EDatFim.DateTime := incdia(date,1);
  AtualizaConsulta;
  FunOrdemProducao := TRBFuncoesOrdemProducao.cria(FPrincipal.BaseDados);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFRomaneios.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunRave.free;
  FunOrdemProducao.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFRomaneios.AtualizaConsulta;
var
  VpfPosicao : TBookMark;
begin
  VpfPosicao := RomaneioCorpo.GetBookmark;
  RomaneioCorpo.Close;
  RomaneioCorpo.Sql.Clear;
  RomaneioCorpo.Sql.Add('Select * from ROMANEIOCORPO ');
  if ESeqRomaneio.AsInteger <>  0 then
    RomaneioCorpo.Sql.Add(' Where SEQROM = '+ ESeqRomaneio.Text)
  else
  begin
    RomaneioCorpo.Sql.Add(' Where DATINI >= ' +SQLTextoDataAAAAMMMDD(EDatInicio.DateTime)+
                          ' and DATINI < ' + SQLTextoDataAAAAMMMDD(IncDia(EDatFim.DateTime,1)));

    case ESituacaoNota.ItemIndex of
      0 : RomaneioCorpo.Sql.Add('and NOTGER = ''N''');
      1 : RomaneioCorpo.Sql.Add('and NOTGER = ''S''');
    end;

    case ESituacaoImpressao.ItemIndex of
      0 : RomaneioCorpo.Sql.Add('and INDIMP = ''N''');
      1 : RomaneioCorpo.Sql.Add('and INDIMP = ''S''');
    end;
  end;
  RomaneioCorpo.Sql.SavetoFile('c:\consulta.sql');
  romaneioCorpo.Open;
  try
    RomaneioCorpo.GotoBookMark(VpfPosicao);
    RomaneioCorpo.FreebookMark(VpfPosicao);
  except
  end;
end;

{******************************************************************************}
procedure TFRomaneios.AtualizaConsultaItem;
begin
  if RomaneioCorpoEMPFIL.AsInteger <> 0 then
  begin
    AdicionaSQLAbreTabela(RomaneioItem,'select  RIT.SEQORD, RIT.SEQCOL, RIT.SEQROM, '+
                                       ' PRO.C_NOM_PRO, ' +
                                       ' OP.NUMPED, OP.CODPRO, OP.VALUNI, '+
                                       ' OPI.CODCOM, OPI.CODMAN, OPI.NROFIT, OPI.METCOL, (OPI.METCOL * OPI.NROFIT) / 1000 TOTALKM '+
                                       ' from ORDEMPRODUCAOCORPO OP, COLETAOPITEM opi, CADPRODUTOS PRO, ROMANEIOITEM RIT '+
                                       ' WHERE OPI.EMPFIL = OP.EMPFIL '+
                                       ' AND OPI.SEQORD = OP.SEQORD '+
                                       ' AND OP.SEQPRO = PRO.I_SEQ_PRO '+
                                       ' AND RIT.EMPFIL = OPI.EMPFIL '+
                                       ' AND RIT.SEQORD = OPI.SEQORD '+
                                       ' AND RIT.SEQCOL = OPI.SEQCOL '+
                                       ' AND RIT.EMPFIL = '+RomaneioCorpoEMPFIL.AsString+
                                       ' and rit.SEQROM = '+RomaneioCorpoSEQROM.Asstring);
  end;
end;

{******************************************************************************}
procedure TFRomaneios.RomaneioCorpoAfterScroll(DataSet: TDataSet);
begin
  AtualizaConsultaItem;
end;

procedure TFRomaneios.BFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFRomaneios.EDatInicioExit(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFRomaneios.BImprimirClick(Sender: TObject);
begin
  FunRave.ImprimeRomaneioEtikArt(RomaneioCorpoEMPFIL.AsInteger,RomaneioCorpoSEQROM.AsInteger,true);

{  FImpOrdemProducao := TFImpOrdemProducao.create(self);
  FImpOrdemProducao.ImprimeRomaneioFaturamento(RomaneioCorpoDATINI.AsDateTime,RomaneioCorpoEMPFIL.AsString,RomaneioCorpoSEQROM.AsString);
  FImpOrdemProducao.free;}
  FunOrdemProducao.SetaRomaneioImpresso(RomaneioCorpoEMPFIL.AsString,RomaneioCorpoSEQROM.AsString);
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFRomaneios.BFinalizaClick(Sender: TObject);
begin
  if RomaneioCorpoEMPFIL.AsInteger <> 0 then
  begin
    FunOrdemProducao.FinalizarRomaneio(RomaneioCorpoEMPFIL.AsString,RomaneioCorpoSEQROM.AsString);
    AtualizaConsulta;
  end;
end;

{******************************************************************************}
procedure TFRomaneios.BGerarNotaClick(Sender: TObject);
Var
  VpfREsultado : String;
begin
  if RomaneioCorpoEMPFIL.AsInteger <> 0 then
  begin
    FNovaNotaFiscalNota := TFNovaNotaFiscalNota.CriarSDI(application , '', FPrincipal.VerificaPermisao('FNovaNotaFiscalNota'));
    if FNovaNotaFiscalNota.GeraNotaRomaneio(RomaneioCorpoEMPFIL.AsString,RomaneioCorpoSEQROM.AsString) then
    begin
      FunOrdemProducao.SetaRomaneioGeradoNota(RomaneioCorpoEMPFIL.AsString,RomaneioCorpoSEQROM.AsString);
      VpfResultado := FunOrdemProducao.BaixaEstoqueRomaneio(RomaneioCorpoEMPFIL.AsInteger,RomaneioCorpoSEQROM.AsInteger,false);
      if VpfResultado <> '' then
        aviso(VpfResultado);
    end;
    FNovaNotaFiscalNota.free;
    AtualizaConsulta;
  end;
end;

{******************************************************************************}
procedure TFRomaneios.BExcluirColetaClick(Sender: TObject);
begin
  if Confirmacao(CT_DeletarItem) then
  begin
    if RomaneioItemSEQCOL.AsInteger <> 0 then
    begin
      ExecutaComandoSql(Aux,'Delete from ROMANEIOITEM '+
                            ' Where EMPFIL = '+ RomaneioCorpoEMPFIL.AsString+
                            ' AND SEQROM = '+ RomaneioCorpoSEQROM.AsString+
                            ' AND SEQORD = '+RomaneioItemSEQORD.AsString+
                            ' AND SEQCOL = '+RomaneioItemSEQCOL.AsString);
      AtualizaConsultaItem;
    end;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFRomaneios]);
end.
