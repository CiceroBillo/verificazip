unit AConsultaChamadoParcial;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  PainelGradiente, ExtCtrls, Componentes1, StdCtrls, Buttons, Grids,
  DBGrids, Tabela, DBKeyViolation, Db, DBTables, DBClient;

type
  TFConsultaChamadoParcial = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    GridIndice1: TGridIndice;
    o: TGridIndice;
    Splitter1: TSplitter;
    BFechar: TBitBtn;
    ChamadoParcialCorpo: TSQL;
    ChamadoParcialCorpoCODFILIAL: TFMTBCDField;
    ChamadoParcialCorpoNUMCHAMADO: TFMTBCDField;
    ChamadoParcialCorpoSEQPARCIAL: TFMTBCDField;
    ChamadoParcialCorpoDATPARCIAL: TSQLTimeStampField;
    ChamadoParcialCorpoINDFATURADO: TWideStringField;
    ChamadoParcialCorpoC_NOM_USU: TWideStringField;
    ChamadoParcialCorpoCODTECNICO: TFMTBCDField;
    DataChamadoParcialCorpo: TDataSource;
    ChamadoParcialCorpoNOMTECNICO: TWideStringField;
    PARCIALPRODUTO: TSQL;
    PARCIALPRODUTOCODFILIAL: TFMTBCDField;
    PARCIALPRODUTONUMCHAMADO: TFMTBCDField;
    PARCIALPRODUTOSEQPARCIAL: TFMTBCDField;
    PARCIALPRODUTOQTDPRODUTO: TFMTBCDField;
    PARCIALPRODUTODESUM: TWideStringField;
    PARCIALPRODUTOINDPRODUTOEXTRA: TWideStringField;
    PARCIALPRODUTOINDFATURADO: TWideStringField;
    PARCIALPRODUTOC_COD_PRO: TWideStringField;
    PARCIALPRODUTOC_NOM_PRO: TWideStringField;
    DataPARCIALPRODUTO: TDataSource;
    BSeparacao: TBitBtn;
    BRetorno: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure ChamadoParcialCorpoAfterScroll(DataSet: TDataSet);
    procedure BSeparacaoClick(Sender: TObject);
    procedure BRetornoClick(Sender: TObject);
  private
    { Private declarations }
    VprCodFilial,
    VprNumChamado : Integer;
    VprRetorno : Boolean;
    procedure AtualizaConsulta;
  public
    { Public declarations }
    procedure ConsultaParciais(VpaCodFilial, VpaNumChamado : Integer);
    procedure ConsultaRetornos(VpaCodFilial, VpaNumChamado : Integer);
  end;

var
  FConsultaChamadoParcial: TFConsultaChamadoParcial;

implementation

uses APrincipal, FunSql, dmRave;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFConsultaChamadoParcial.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprRetorno := false;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFConsultaChamadoParcial.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  ChamadoParcialCorpo.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFConsultaChamadoParcial.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFConsultaChamadoParcial.BRetornoClick(Sender: TObject);
begin
  if ChamadoParcialCorpoCODFILIAL.AsInteger <> 0 then
  begin
    dtRave := TdtRave.create(self);
    dtRave.ImprimeEntradaMateriais(ChamadoParcialCorpoCODFILIAL.AsInteger,ChamadoParcialCorpoNUMCHAMADO.AsInteger,
         ChamadoParcialCorpoSEQPARCIAL.AsInteger);
    dtRave.free;
  end;
end;

{******************************************************************************}
procedure TFConsultaChamadoParcial.BSeparacaoClick(Sender: TObject);
begin
 //SEQPARCIAL
  if ChamadoParcialCorpoCODFILIAL.AsInteger <> 0 then
  begin
    dtRave := TdtRave.create(self);
    dtRave.ImprimeSaidaMateriais(ChamadoParcialCorpoCODFILIAL.AsInteger,ChamadoParcialCorpoNUMCHAMADO.AsInteger,
         ChamadoParcialCorpoSEQPARCIAL.AsInteger);
    dtRave.free;
  end;
end;

{******************************************************************************}
procedure TFConsultaChamadoParcial.AtualizaConsulta;
begin
  ChamadoParcialCorpo.sql.clear;
  ChamadoParcialCorpo.sql.add('select CPC.CODFILIAL, CPC.NUMCHAMADO, CPC.SEQPARCIAL, CPC.DATPARCIAL, CPC.INDFATURADO, '+
                              ' USU.C_NOM_USU, '+
                              ' TEC.CODTECNICO, TEC.NOMTECNICO '+
                              ' from CHAMADOPARCIALCORPO CPC, CADUSUARIOS USU, TECNICO TEC '+
                              ' WHERE CPC.CODUSUARIO = USU.I_COD_USU '+
                              ' AND CPC.CODTECNICO = TEC.CODTECNICO '+
                              ' AND CPC.CODFILIAL = '+IntToStr(VprCodFilial)+
                              ' AND CPC.NUMCHAMADO = '+IntToStr(VprNumChamado));
  if VprRetorno then
    ChamadoParcialCorpo.sql.add('AND CPC.INDRETORNO = ''S''')
  else
    ChamadoParcialCorpo.sql.add('AND CPC.INDRETORNO = ''N''');
  ChamadoParcialCorpo.sql.add('order by SEQPARCIAL');
  ChamadoParcialCorpo.open;
end;

{******************************************************************************}
procedure TFConsultaChamadoParcial.ConsultaParciais(VpaCodFilial, VpaNumChamado : Integer);
begin
  VprCodFilial := VpaCodFilial;
  VprNumChamado := VpaNumChamado;
  AtualizaConsulta;
  ShowModal;
end;

{******************************************************************************}
procedure TFConsultaChamadoParcial.ConsultaRetornos(VpaCodFilial, VpaNumChamado : Integer);
begin
  VprCodFilial := VpaCodFilial;
  VprNumChamado := VpaNumChamado;
  VprRetorno := true;
  AtualizaConsulta;
  ShowModal;
end;

{******************************************************************************}
procedure TFConsultaChamadoParcial.ChamadoParcialCorpoAfterScroll(
  DataSet: TDataSet);
begin
  if ChamadoParcialCorpoNUMCHAMADO.AsInteger <> 0 then
    AdicionaSQLAbreTabela(PARCIALPRODUTO,'select CPP.CODFILIAL, CPP.NUMCHAMADO, CPP.SEQPARCIAL, CPP.QTDPRODUTO, ' +
                       ' CPP.DESUM, CPP.INDPRODUTOEXTRA, CPP.INDFATURADO, '+
                       ' PRO.C_COD_PRO, PRO.C_NOM_PRO '+
                       ' from CHAMADOPARCIALPRODUTO CPP, CADPRODUTOS PRO '+
                       ' Where CPP.SEQPRODUTO = PRO.I_SEQ_PRO '+
                       ' and CPP.CODFILIAL = '+ChamadoParcialCorpoCODFILIAL.AsString+
                       ' and CPP.NUMCHAMADO = '+ChamadoParcialCorpoNUMCHAMADO.AsString+
                       ' AND CPP.SEQPARCIAL = '+ChamadoParcialCorpoSEQPARCIAL.AsString)
  else
    PARCIALPRODUTO.Close;

end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFConsultaChamadoParcial]);
end.
