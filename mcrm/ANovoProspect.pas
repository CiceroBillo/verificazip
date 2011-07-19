unit ANovoProspect;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Tabela, DBKeyViolation,
  StdCtrls, DBCtrls, Mask, Db, DBTables, CBancoDados, ComCtrls, Buttons,
  Localizacao, BotaoCadastro, UnDados, DBClient;

type
  TFNovoProspect = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Paginas: TPageControl;
    PGerais: TTabSheet;
    Prospect: TRBSQL;
    ProspectCODPROSPECT: TFMTBCDField;
    ProspectNOMPROSPECT: TWideStringField;
    ProspectNOMFANTASIA: TWideStringField;
    ProspectTIPPESSOA: TWideStringField;
    ProspectDESENDERECO: TWideStringField;
    ProspectNUMENDERECO: TFMTBCDField;
    ProspectDESCOMPLEMENTO: TWideStringField;
    ProspectDESBAIRRO: TWideStringField;
    ProspectNUMCEP: TWideStringField;
    ProspectDESCIDADE: TWideStringField;
    ProspectDESUF: TWideStringField;
    ProspectDESFONE1: TWideStringField;
    ProspectDESSITE: TWideStringField;
    ProspectDESFONE2: TWideStringField;
    ProspectDESFAX: TWideStringField;
    ProspectDESCPF: TWideStringField;
    ProspectDESCNPJ: TWideStringField;
    ProspectDESRG: TWideStringField;
    ProspectDESINSCRICAO: TWideStringField;
    ProspectNOMCONTATO: TWideStringField;
    ProspectDESFONECONTATO: TWideStringField;
    ProspectDESEMAILCONTATO: TWideStringField;
    ProspectCODPROFISSAOCONTATO: TFMTBCDField;
    ProspectINDACEITASPAM: TWideStringField;
    ProspectCODCLIENTE: TFMTBCDField;
    ProspectCODRAMOATIVIDADE: TFMTBCDField;
    ProspectINDACEITATELEMARKETING: TWideStringField;
    ProspectDESOBSERVACOES: TWideStringField;
    ProspectCODUSUARIO: TFMTBCDField;
    ProspectDATCADASTRO: TSQLTimeStampField;
    ProspectCODMEIODIVULGACAO: TFMTBCDField;
    ProspectCODVENDEDOR: TFMTBCDField;
    Label1: TLabel;
    DataProspect: TDataSource;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    DBEdit5: TDBEditColor;
    Label6: TLabel;
    DBEdit6: TDBEditColor;
    Label7: TLabel;
    DBEdit7: TDBEditColor;
    Label8: TLabel;
    DBEdit8: TDBEditColor;
    Label9: TLabel;
    DBEdit9: TDBEditColor;
    Label14: TLabel;
    DBEdit14: TDBEditColor;
    Label21: TLabel;
    DBEdit21: TDBEditColor;
    Label22: TLabel;
    DBEdit22: TDBEditColor;
    Label23: TLabel;
    DBEdit23: TDBEditColor;
    Label25: TLabel;
    ECodigo: TDBKeyViolation;
    DBEditColor1: TDBEditColor;
    DBEditColor2: TDBEditColor;
    Pessoa: TDBRadioGroup;
    Label54: TLabel;
    PanelColor4: TBevel;
    PanelColor3: TBevel;
    Label44: TLabel;
    PAdicionais: TTabSheet;
    Label29: TLabel;
    Localiza: TConsultaPadrao;
    ECidade: TDBEditLocaliza;
    Label4: TLabel;
    BCidade: TSpeedButton;
    DBEditUF1: TDBEditUF;
    Label10: TLabel;
    SpeedButton11: TSpeedButton;
    Label52: TLabel;
    DBEditPos24: TDBEditPos2;
    DBEditPos21: TDBEditPos2;
    Label11: TLabel;
    DBEditPos22: TDBEditPos2;
    Bevel1: TBevel;
    Label12: TLabel;
    Label31: TLabel;
    Label15: TLabel;
    DBEditLocaliza1: TDBEditLocaliza;
    SpeedButton1: TSpeedButton;
    Label53: TLabel;
    Label32: TLabel;
    DBEditLocaliza2: TDBEditLocaliza;
    SpeedButton2: TSpeedButton;
    Label24: TLabel;
    PanelColor11: TBevel;
    Label84: TLabel;
    PainelRG: TPanelColor;
    Label17: TLabel;
    Label18: TLabel;
    Label16: TLabel;
    DBEditColor5: TDBEditColor;
    DBEditCPF1: TDBEditCPF;
    DBEditColor3: TDBEditColor;
    PainelCGC: TPanelColor;
    Label61: TLabel;
    Label19: TLabel;
    Label42: TLabel;
    DBEditCGC1: TDBEditCGC;
    DBEditColor7: TDBEditInsEstadual;
    DBEditColor22: TDBEditColor;
    ProspectDATNASCIMENTO: TSQLTimeStampField;
    CEmailPromocional: TDBCheckBox;
    DBCheckBox1: TDBCheckBox;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    Label85: TLabel;
    EVendedor: TDBEditLocaliza;
    BVendedor: TSpeedButton;
    Label86: TLabel;
    Label94: TLabel;
    DBEditLocaliza4: TDBEditLocaliza;
    SpeedButton15: TSpeedButton;
    Label95: TLabel;
    DBMemoColor1: TDBMemoColor;
    Label147: TLabel;
    EUsuario: TDBEditLocaliza;
    SpeedButton22: TSpeedButton;
    Label148: TLabel;
    DBEditColor36: TDBEditColor;
    ValidaGravacao1: TValidaGravacao;
    PControleAcesso: TTabSheet;
    ProspectQTDFUNCIONARIO: TFMTBCDField;
    DBEditColor4: TDBEditColor;
    Label26: TLabel;
    DBCheckBox2: TDBCheckBox;
    ProspectINDCONTATOVENDEDOR: TWideStringField;
    PTelemarketing: TTabSheet;
    Label28: TLabel;
    Label30: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    EDatUltimaLigacacao: TDBEditColor;
    ProspectDATULTIMALIGACAO: TSQLTimeStampField;
    ProspectQTDLIGACAOCOMPROPOSTA: TFMTBCDField;
    ProspectQTDLIGACAOSEMPROPOSTA: TFMTBCDField;
    ProspectDESOBSERVACAOTELEMARKETING: TWideStringField;
    EQtdLigacoesSemProposta: TDBEditColor;
    EQtdLigacoesComProposta: TDBEditColor;
    EObsLigacaocliente: TDBMemoColor;
    CAceitaTeleMarketing: TDBCheckBox;
    Label13: TLabel;
    SpeedButton4: TSpeedButton;
    Label35: TLabel;
    EConcorrente: TDBEditLocaliza;
    ProspectCODCONCORRENTE: TFMTBCDField;
    DBEditColor6: TDBEditColor;
    Label36: TLabel;
    ProspectINDEMAILINVALIDO: TWideStringField;
    ProspectQTDVEZESEMAILINVALIDO: TFMTBCDField;
    ProspectINDEXPORTADO: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ECidadeRetorno(Retorno1, Retorno2: String);
    procedure ECidadeCadastrar(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure ProspectAfterInsert(DataSet: TDataSet);
    procedure ProspectAfterEdit(DataSet: TDataSet);
    procedure ProspectBeforePost(DataSet: TDataSet);
    procedure PessoaChange(Sender: TObject);
    procedure DBEditLocaliza1Cadastrar(Sender: TObject);
    procedure DBEditLocaliza2Cadastrar(Sender: TObject);
    procedure DBEditLocaliza4Cadastrar(Sender: TObject);
    procedure ECodigoChange(Sender: TObject);
    procedure ProspectAfterScroll(DataSet: TDataSet);
    procedure EConcorrenteCadastrar(Sender: TObject);
    procedure DBEdit23KeyPress(Sender: TObject; var Key: Char);
  private
    VprEmail : string;
  public
    procedure LocalizaProspect(VpaCodProspect : Integer);
  end;

var
  FNovoProspect: TFNovoProspect;

implementation

uses APrincipal, ACadCidades, AProspects, FunObjeto, Constantes,
  AProfissoes, AMeioDivulgacao, ARamoAtividade, FunSql, UnClientes,
  AConcorrentes, ANovoConcorrente;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovoProspect.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  Paginas.ActivePage := PGerais;
  Prospect.open;
  InicializaVerdadeiroeFalsoCheckBox(PanelColor1,'S','N');
  PControleAcesso.TabVisible := (config.RelogioPonto or config.SoftwareHouse);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovoProspect.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Prospect.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFNovoProspect.ECidadeRetorno(Retorno1, Retorno2: String);
begin
  if (Retorno1 <> '') then
    if (Prospect.State in [dsInsert, dsEdit]) then
      ProspectDESUF.AsString:=Retorno2; // Grava o Estado;
end;

{******************************************************************************}
procedure TFNovoProspect.ECidadeCadastrar(Sender: TObject);
begin
  FCidades := TFCidades.CriarSDI(Application, '', FPrincipal.VerificaPermisao('FCidades'));
  FCidades.ShowModal;
  FCidades.Free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovoProspect.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFNovoProspect.LocalizaProspect(VpaCodProspect : Integer);
begin
  AdicionaSQLAbreTabela(Prospect,'Select * from PROSPECT '+
                                 ' Where CODPROSPECT = '+IntToStr(VpaCodProspect));
end;

{******************************************************************************}
procedure TFNovoProspect.ProspectAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ProximoCodigo;
  ECodigo.ReadOnly := false;
  ProspectCODUSUARIO.AsInteger := varia.CodigoUsuario;
  EUsuario.Atualiza;
  ProspectINDACEITASPAM.AsString := 'S';
  ProspectINDACEITATELEMARKETING.AsString := 'S';
  ProspectINDCONTATOVENDEDOR.AsString := 'N';
  ProspectDATCADASTRO.AsDateTime := now;
  ProspectTIPPESSOA.AsString := 'J';
  ProspectINDEXPORTADO.AsString := 'N';
  ProspectINDEMAILINVALIDO.asString := 'N';
end;

{******************************************************************************}
procedure TFNovoProspect.ProspectAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
  VprEmail := ProspectDESEMAILCONTATO.AsString;
end;

{******************************************************************************}
procedure TFNovoProspect.ProspectBeforePost(DataSet: TDataSet);
begin
  if Prospect.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado
  else
    if Prospect.state = dsedit then
    begin
      if ProspectDESEMAILCONTATO.AsString <> VprEmail then
        ProspectINDEXPORTADO.AsString := 'N';
    end;
end;

{******************************************************************************}
procedure TFNovoProspect.PessoaChange(Sender: TObject);
begin
  if pessoa.ItemIndex = 1 then
  begin
    PainelCGC.Visible := false;
    PainelRG.Visible := true;
  end
  else
  begin
    PainelCGC.Visible := true;
    PainelRG.Visible := false;
  end;
end;

{******************************************************************************}
procedure TFNovoProspect.DBEditLocaliza1Cadastrar(Sender: TObject);
begin
  FProfissoes := TFProfissoes.CriarSDI(self,'',FPrincipal.VerificaPermisao('FProfissoes'));
  FProfissoes.BotaoCadastrar1.Click;
  FProfissoes.showmodal;
  FProfissoes.free;
  Localiza.AtualizaConsulta;
end;

procedure TFNovoProspect.DBEditLocaliza2Cadastrar(Sender: TObject);
begin
  FMeioDivulgacao := TFMeioDivulgacao.CriarSDI(self,'',FPrincipal.VerificaPermisao('FMeioDivulgacao'));
  FMeioDivulgacao.BotaoCadastrar1.click;
  FMeioDivulgacao.showmodal;
  FMeioDivulgacao.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovoProspect.DBEditLocaliza4Cadastrar(Sender: TObject);
begin
  FRamoAtividade := TFRamoAtividade.CriarSDI(self,'',FPrincipal.VerificaPermisao('FRamoAtividade'));
  FRamoAtividade.BotaoCadastrar1.Click;
  FRamoAtividade.ShowModal;
  FRamoAtividade.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovoProspect.ECodigoChange(Sender: TObject);
begin
  if Prospect.State in [dsedit,dsinsert] then
    ValidaGravacao1.execute;
end;

{******************************************************************************}
procedure TFNovoProspect.ProspectAfterScroll(DataSet: TDataSet);
begin
  AtualizaLocalizas(PanelColor1);
end;

{******************************************************************************}
procedure TFNovoProspect.EConcorrenteCadastrar(Sender: TObject);
begin
  FNovoConcorrente:= TFNovoConcorrente.CriarSDI(Application,'',True);
  FNovoConcorrente.Concorrente.Insert;
  FNovoConcorrente.ShowModal;
  FNovoConcorrente.Free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovoProspect.DBEdit23KeyPress(Sender: TObject; var Key: Char);
begin
  if key in [' ',',','/',';','ç','\','ã',':'] then
    key := #0;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovoProspect]);
end.
