unit ARetornos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Grids, DBGrids, Tabela, DBKeyViolation, Componentes1,
  ExtCtrls, PainelGradiente, Unretorno, ComCtrls, Db, DBTables, DBClient,
  FMTBcd, Provider, SqlExpr;

type
  TFRetornos = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    GridIndice1: TGridIndice;
    BImportar: TBitBtn;
    BImprimir: TBitBtn;
    BFechar: TBitBtn;
    OpenDialog1: TOpenDialog;
    BarraStatus: TStatusBar;
    RetornoCorpo: TSQL;
    DataRetornoCorpo: TDataSource;
    RetornoCorpoSEQRETORNO: TFMTBCDField;
    RetornoCorpoNUMCONTA: TWideStringField;
    RetornoCorpoC_NOM_BAN: TWideStringField;
    RetornoCorpoSEQARQUIVO: TFMTBCDField;
    RetornoCorpoDATRETORNO: TSQLTimeStampField;
    RetornoCorpoDATGERACAO: TSQLTimeStampField;
    RetornoCorpoDATCREDITO: TSQLTimeStampField;
    RetornoCorpoC_NOM_USU: TWideStringField;
    RetornoCorpoCODFILIAL: TFMTBCDField;
    Label1: TLabel;
    ESituacao: TComboBoxColor;
    Label8: TLabel;
    EDataInicio: TCalendario;
    EDataFim: TCalendario;
    Label10: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BImportarClick(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure ESituacaoChange(Sender: TObject);
  private
    { Private declarations }
    FunRetorno : TRBDFuncoesRetorno;
    procedure AtualizaConsulta(VpaPosicionar :Boolean = false);
  public
    { Public declarations }
  end;

var
  FRetornos: TFRetornos;

implementation

uses APrincipal,ConstMsg, Constantes, UnCrystal,FunSql,FunData, dmRave;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFRetornos.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunRetorno := TRBDFuncoesRetorno.cria(Fprincipal.BaseDados);
  EDataInicio.datetime := PrimeiroDiaMes(date);
  EDataFim.DateTime := UltimoDiaMes(date);  
  ESituacao.ItemIndex := 0;
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFRetornos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Funretorno.free;
  RetornoCorpo.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFRetornos.AtualizaConsulta(VpaPosicionar :Boolean = false);
var
  VpfPosicao : TBookmark;
begin
  VpfPosicao := RetornoCorpo.GetBookmark;
  RetornoCorpo.Close;
  RetornoCorpo.Sql.Clear;
  RetornoCorpo.Sql.add('select RET.CODFILIAL,RET.SEQRETORNO, RET.NUMCONTA, '+
                       ' BAN.C_NOM_BAN, RET.SEQARQUIVO, RET.DATRETORNO, RET.DATGERACAO, RET.DATCREDITO, '+
                       ' USU.C_NOM_USU '+
                       ' from RETORNOCORPO RET, CADCONTAS CON, CADUSUARIOS USU, CADBANCOS BAN '+
                       ' Where RET.NUMCONTA = CON.C_NRO_CON '+
                       ' AND RET.CODUSUARIO = USU.I_COD_USU '+
                       ' AND CON.I_COD_BAN = BAN.I_COD_BAN '+
                       ' AND RET.CODFILIAL = '+IntToStr(varia.codigoEmpFil)+
                        SQLTextoDataEntreAAAAMMDD('RET.DATRETORNO',EDataInicio.Datetime,incdia(EDataFim.Datetime,1),true));
  case ESituacao.ItemIndex of
    0 : RetornoCorpo.SQL.add(' and RET.INDIMPRESSO = ''N''');
    1 : Retornocorpo.Sql.add(' and RET.INDIMPRESSO = ''S''');
  end;
  RetornoCorpo.sql.add('order by RET.SEQRETORNO');
  RetornoCorpo.Open;
  try
    if VpaPosicionar then
      RetornoCorpo.GotoBookmark(VpfPosicao);
    RetornoCorpo.FreeBookmark(VpfPosicao);
  except
  end;
end;

{******************************************************************************}
procedure TFRetornos.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFRetornos.BImportarClick(Sender: TObject);
var
  VpfResultado : String;
begin
  if OpenDialog1.Execute then
    VpfResultado := FunRetorno.processaRetorno(OpenDialog1.FileName,BarraStatus);
  if VpfResultado <> '' then
    aviso(VpfResultado)
  else
  Begin
    AtualizaConsulta;
  end;

end;

{******************************************************************************}
procedure TFRetornos.BImprimirClick(Sender: TObject);
begin
  if RetornoCorpoSEQRETORNO.AsInteger <> 0 then
  begin
    dtRave := TdtRave.create(self);
    dtRave.ImprimeRetorno(RetornoCorpoCODFILIAL.AsInteger,RetornoCorpoSEQRETORNO.AsInteger);
    dtRave.free;
    FunRetorno.MarcaRetornoImpresso(RetornoCorpoCODFILIAL.AsInteger,RetornoCorpoSEQRETORNO.AsInteger);
    Atualizaconsulta(False);
  end;
end;

{******************************************************************************}
procedure TFRetornos.ESituacaoChange(Sender: TObject);
begin
  AtualizaConsulta;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFRetornos]);
end.
