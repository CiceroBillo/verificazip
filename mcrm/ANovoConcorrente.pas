unit ANovoConcorrente;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  PainelGradiente, Db, DBTables, Tabela, Localizacao, DBKeyViolation,
  BotaoCadastro, StdCtrls, Buttons, ExtCtrls, Componentes1, DBCtrls, Mask,
  DBClient;

type
  TFNovoConcorrente = class(TFormularioPermissao)
    PanelColor1: TPanelColor;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    ValidaGravacao1: TValidaGravacao;
    Localiza: TConsultaPadrao;
    DataConcorrentes: TDataSource;
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    BRua: TSpeedButton;
    Label1: TLabel;
    Label16: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    BCidade: TSpeedButton;
    Label4: TLabel;
    ENome: TDBEditColor;
    EEndereco: TDBEditColor;
    ENum: TDBEditColor;
    ECidade: TDBEditLocaliza;
    Label5: TLabel;
    ETelefone: TDBEditPos2;
    Label6: TLabel;
    ENomProprietario: TDBEditColor;
    EQtdFuncionarios: TDBEditColor;
    Label7: TLabel;
    Label8: TLabel;
    EQtdTecnicos: TDBEditColor;
    Label9: TLabel;
    EQtdVendedores: TDBEditColor;
    Label10: TLabel;
    EFaturamento: TDBEditColor;
    Label18: TLabel;
    EMemo: TDBMemoColor;
    EUf: TDBEditUF;
    BUF: TSpeedButton;
    EBairro: TDBEditColor;
    ECep: TDBEditColor;
    Concorrente: TSQL;
    ConcorrenteCODCONCORRENTE: TFMTBCDField;
    ConcorrenteNOMCONCORRENTE: TWideStringField;
    ConcorrenteDESENDERECO: TWideStringField;
    ConcorrenteNUMENDERECO: TFMTBCDField;
    ConcorrenteDESBAIRRO: TWideStringField;
    ConcorrenteNUMCEP: TWideStringField;
    ConcorrenteDESCIDADE: TWideStringField;
    ConcorrenteDESUF: TWideStringField;
    ConcorrenteDESFONE1: TWideStringField;
    ConcorrenteNOMPROPRIETARIO: TWideStringField;
    ConcorrenteQTDFUNCIONARIO: TFMTBCDField;
    ConcorrenteQTDTECNICO: TFMTBCDField;
    ConcorrenteQTDVENDEDOR: TFMTBCDField;
    ConcorrenteVALFATURAMENTOMENSAL: TFMTBCDField;
    ConcorrenteDESOBSERVACAO: TWideStringField;
    ECodigo: TDBKeyViolation;
    ConcorrenteDATULTIMAALTERACAO: TSQLTimeStampField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BRuaClick(Sender: TObject);
    procedure ECidadeCadastrar(Sender: TObject);
    procedure ConcorrenteBeforePost(DataSet: TDataSet);
    procedure ConcorrenteAfterInsert(DataSet: TDataSet);
    procedure ConcorrenteAfterEdit(DataSet: TDataSet);
    procedure ECidadeRetorno(Retorno1, Retorno2: String);
    procedure ECodigoChange(Sender: TObject);
    procedure ConcorrenteAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FNovoConcorrente: TFNovoConcorrente;

implementation
uses
  APrincipal, AConsultaRuas, FunString, ACadCidades, AConcorrentes, UnSistema;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovoConcorrente.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  Concorrente.Open;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovoConcorrente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Concorrente.Close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
procedure TFNovoConcorrente.BFecharClick(Sender: TObject);
begin
  Self.Close;
end;


{******************************************************************************}
procedure TFNovoConcorrente.BRuaClick(Sender: TObject);
var
  VpfCodCidade,
  VpfCEP,
  VpfRua,
  VpfBairro,
  VpfDesCidade: string;
begin
  if Concorrente.State in [dsedit, dsInsert] then
  begin
    VpfCEP := SubstituiStr(VpfCEP,'-','');
    FConsultaRuas := TFConsultaRuas.CriarSDI(Application, '', FPrincipal.VerificaPermisao('FConsultaRuas'));
    if FConsultaRuas.BuscaEndereco(VpfCodCidade, VpfCEP,
        VpfRua, VpfBairro, VpfDesCidade)
    then
    begin
      ConcorrenteNUMCEP.AsString:= VpfCEP;
      ConcorrenteDESCIDADE.AsString:= VpfDesCidade;
      ConcorrenteDESBAIRRO.AsString:= VpfBairro;
      ECidade.Atualiza;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoConcorrente.ECidadeCadastrar(Sender: TObject);
begin
  FCidades := TFCidades.CriarSDI(Application, '', FPrincipal.VerificaPermisao('FCidades'));
  FCidades.ShowModal;
end;

{******************************************************************************}
procedure TFNovoConcorrente.ConcorrenteBeforePost(DataSet: TDataSet);
begin
  if Concorrente.State = dsInsert then
    ECodigo.VerificaCodigoUtilizado;
  ConcorrenteDATULTIMAALTERACAO.AsDateTime := Sistema.RDataServidor;
end;

{******************************************************************************}
procedure TFNovoConcorrente.ConcorrenteAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ProximoCodigo;
  ECodigo.ReadOnly:= False;
end;

procedure TFNovoConcorrente.ConcorrenteAfterPost(DataSet: TDataSet);
begin
  Sistema.MarcaTabelaParaImportar('CONCORRENTE');
end;

{******************************************************************************}
procedure TFNovoConcorrente.ConcorrenteAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly:= True;
end;

{******************************************************************************}
procedure TFNovoConcorrente.ECidadeRetorno(Retorno1, Retorno2: String);
begin
  if Concorrente.State in [dsinsert,dsedit] then
    ConcorrenteDESUF.AsString := retorno2;
end;

procedure TFNovoConcorrente.ECodigoChange(Sender: TObject);
begin
  if Concorrente.state in [dsinsert,dsedit] then
    ValidaGravacao1.execute;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovoConcorrente]);
end.
