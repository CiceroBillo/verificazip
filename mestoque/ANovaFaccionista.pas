unit ANovaFaccionista;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Db, StdCtrls, Mask, DBCtrls,
  ComCtrls, DBTables, Tabela, CBancoDados, Localizacao, Buttons,
  DBKeyViolation, BotaoCadastro, numericos, DBClient;

type
  TFNovaFaccionista = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Faccionistas: TRBSQL;
    FaccionistasCODFACCIONISTA: TFMTBCDField;
    FaccionistasNOMFACCIONISTA: TWideStringField;
    FaccionistasNOMRESPONSAVEL: TWideStringField;
    FaccionistasTIPPESSOA: TWideStringField;
    FaccionistasDESCPF: TWideStringField;
    FaccionistasDESRG: TWideStringField;
    FaccionistasDESCNPJ: TWideStringField;
    FaccionistasDESINSCRICAOESTADUAL: TWideStringField;
    FaccionistasDESENDERECO: TWideStringField;
    FaccionistasNUMENDERECO: TFMTBCDField;
    FaccionistasDESCOMPLEMENTOENDERECO: TWideStringField;
    FaccionistasDESBAIRRO: TWideStringField;
    FaccionistasDESCEP: TWideStringField;
    FaccionistasDESCIDADE: TWideStringField;
    FaccionistasDESUF: TWideStringField;
    FaccionistasDESTELEFONE1: TWideStringField;
    FaccionistasDESTELEFONE2: TWideStringField;
    FaccionistasDESFAX: TWideStringField;
    FaccionistasDESCELULAR: TWideStringField;
    FaccionistasQTDPESSOAS: TFMTBCDField;
    FaccionistasCODTRANSPORTADORA: TFMTBCDField;
    FaccionistasCODCONDICAOPAGAMENTO: TFMTBCDField;
    FaccionistasCODFORMAPAGAMENTO: TFMTBCDField;
    FaccionistasDESEMAIL: TWideStringField;
    FaccionistasDESOBSERVACOES: TWideStringField;
    FaccionistasQTDENTREGASNOPRAZO: TFMTBCDField;
    FaccionistasQTDENTREGAATRASADO: TFMTBCDField;
    FaccionistasQTDDEVOLUCOES: TFMTBCDField;
    PageControl1: TPageControl;
    PBasico: TTabSheet;
    Label1: TLabel;
    DataFaccionistas: TDataSource;
    Label2: TLabel;
    DBEdit2: TDBEditColor;
    Label3: TLabel;
    DBEdit3: TDBEditColor;
    Label9: TLabel;
    DBEdit9: TDBEditColor;
    Label10: TLabel;
    DBEdit10: TDBEditColor;
    Label11: TLabel;
    DBEdit11: TDBEditColor;
    Label12: TLabel;
    DBEdit12: TDBEditColor;
    Label13: TLabel;
    DBEdit13: TDBEditColor;
    Label14: TLabel;
    Label16: TLabel;
    Label19: TLabel;
    ECodigo: TDBKeyViolation;
    Pessoa: TDBRadioGroup;
    PCGC: TPanelColor;
    DBEditCGC1: TDBEditCGC;
    Label7: TLabel;
    DBEditColor7: TDBEditInsEstadual;
    Label8: TLabel;
    PRG: TPanelColor;
    DBEditColor5: TDBEditColor;
    Label4: TLabel;
    DBEditCPF1: TDBEditCPF;
    Label20: TLabel;
    Label5: TLabel;
    Localiza: TConsultaPadrao;
    ECidade: TDBEditLocaliza;
    BCidade: TSpeedButton;
    DBEditUF1: TDBEditUF;
    SpeedButton11: TSpeedButton;
    Label6: TLabel;
    DBEditPos21: TDBEditPos2;
    DBEditPos22: TDBEditPos2;
    DBEditPos23: TDBEditPos2;
    Label15: TLabel;
    Label17: TLabel;
    DBEditPos24: TDBEditPos2;
    PAdicionais: TTabSheet;
    Label18: TLabel;
    Label21: TLabel;
    Label25: TLabel;
    DBEditColor1: TDBEditColor;
    DBEditColor2: TDBEditColor;
    Label29: TLabel;
    DBEditLocaliza7: TDBEditLocaliza;
    SpeedButton18: TSpeedButton;
    Label118: TLabel;
    Label89: TLabel;
    EFormaPagamento: TDBEditLocaliza;
    SpeedButton14: TSpeedButton;
    Label90: TLabel;
    ECondicaoPagamento: TDBEditLocaliza;
    Label87: TLabel;
    SpeedButton13: TSpeedButton;
    Label88: TLabel;
    DBMemoColor1: TDBMemoColor;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    FaccionistasDATNASCIMENTO: TSQLTimeStampField;
    DBEditColor3: TDBEditColor;
    FaccionistasTIPRESIDENCIA: TWideStringField;
    Label22: TLabel;
    DBComboBoxColor1: TDBComboBoxColor;
    FaccionistasQTDKM: TFMTBCDField;
    DBEditColor4: TDBEditColor;
    Label23: TLabel;
    Label24: TLabel;
    PAvaliacao: TTabSheet;
    FaccionistasQTDPRODUTODEVOLVIDO: TFMTBCDField;
    FaccionistasQTDRENEGOCIACAO: TFMTBCDField;
    FaccionistasQTDLIGACAO: TFMTBCDField;
    FaccionistasQTDPRODUTO: TFMTBCDField;
    FaccionistasQTDFRACAO: TFMTBCDField;
    Label26: TLabel;
    DBEditColor6: TDBEditColor;
    DBEditColor8: TDBEditColor;
    Label27: TLabel;
    DBEditColor9: TDBEditColor;
    Label28: TLabel;
    DBEditColor10: TDBEditColor;
    Label30: TLabel;
    DBEditColor11: TDBEditColor;
    Label31: TLabel;
    Label32: TLabel;
    DBEditColor12: TDBEditColor;
    DBEditColor13: TDBEditColor;
    Label33: TLabel;
    Label34: TLabel;
    DBEditColor14: TDBEditColor;
    Label35: TLabel;
    EPerQtdDevolvida: Tnumerico;
    EPerProdutoDevolvido: Tnumerico;
    Label36: TLabel;
    FaccionistasDATCADASTRO: TSQLTimeStampField;
    FaccionistasINDATIVA: TWideStringField;
    FaccionistasDESINATIVO: TWideStringField;
    Label37: TLabel;
    DBMemoColor2: TDBMemoColor;
    DBEditColor15: TDBEditColor;
    Label38: TLabel;
    DBCheckBox1: TDBCheckBox;
    FaccionistasINDCADASTROINTERNO: TWideStringField;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    FaccionistasINDFUNCIONARIO: TWideStringField;
    PanelColor3: TPanelColor;
    PanelColor4: TPanelColor;
    PanelColor5: TPanelColor;
    DBRadioGroup1: TDBRadioGroup;
    FaccionistasTIPDISTRIBUICAO: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FaccionistasAfterInsert(DataSet: TDataSet);
    procedure BFecharClick(Sender: TObject);
    procedure FaccionistasAfterEdit(DataSet: TDataSet);
    procedure FaccionistasBeforePost(DataSet: TDataSet);
    procedure PessoaChange(Sender: TObject);
    procedure ECidadeRetorno(Retorno1, Retorno2: String);
    procedure FaccionistasAfterScroll(DataSet: TDataSet);
    procedure PageControl1Change(Sender: TObject);
  private
    { Private declarations }
    procedure AtualizaPercentuais;
  public
    { Public declarations }
    procedure LocalizaFaccionista(VpaCodFaccionista : Integer);
  end;

var
  FNovaFaccionista: TFNovaFaccionista;

implementation

uses APrincipal, FunSql, AFaccionistas, FunObjeto;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovaFaccionista.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  Faccionistas.open;
  InicializaVerdadeiroeFalsoCheckBox(PanelColor1,'S','N');
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovaFaccionista.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Faccionistas.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFNovaFaccionista.FaccionistasAfterInsert(DataSet: TDataSet);
begin
  FaccionistasQTDPESSOAS.AsInteger := 1;
  FaccionistasTIPPESSOA.AsString := 'F';
  ECodigo.ProximoCodigo;
  ECodigo.Readonly := false;
  FaccionistasDATCADASTRO.AsDateTime := now;
  FaccionistasINDATIVA.AsString := 'S';
  FaccionistasINDCADASTROINTERNO.AsString := 'S';
  FaccionistasINDFUNCIONARIO.AsString := 'N';
end;

{******************************************************************************}
procedure TFNovaFaccionista.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFNovaFaccionista.FaccionistasAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
end;

{******************************************************************************}
procedure TFNovaFaccionista.FaccionistasBeforePost(DataSet: TDataSet);
begin
  if Faccionistas.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
end;

{******************************************************************************}
procedure TFNovaFaccionista.AtualizaPercentuais;
begin
  if FaccionistasQTDFRACAO.AsInteger > 0 then
  begin
    EPerQtdDevolvida.AValor := (FaccionistasQTDDEVOLUCOES.AsInteger *100)/FaccionistasQTDFRACAO.AsInteger;
    EPerProdutoDevolvido.AValor := (FaccionistasQTDPRODUTODEVOLVIDO.AsFloat * 100)/FaccionistasQTDPRODUTO.AsFloat;
  end;
end;

{******************************************************************************}
procedure TFNovaFaccionista.LocalizaFaccionista(VpaCodFaccionista : Integer);
begin
  AdicionaSQLAbreTabela(Faccionistas,'Select * from FACCIONISTA'+
                                     ' where CODFACCIONISTA = '+IntToStr(VpaCodFaccionista));
end;

{******************************************************************************}
procedure TFNovaFaccionista.PessoaChange(Sender: TObject);
begin
  if pessoa.ItemIndex = 1 then
  begin
    PCGC.Visible := false;
    PRG.Visible := true;
  end
  else
  begin
    PCGC.Visible := true;
    PRG.Visible := false;
  end;
end;

{******************************************************************************}
procedure TFNovaFaccionista.ECidadeRetorno(Retorno1, Retorno2: String);
begin
  if (Retorno1 <> '') then
    if (Faccionistas.State in [dsInsert, dsEdit]) then
    begin
      FaccionistasDESUF.AsString:=Retorno2; // Grava o Estado;
    end;
end;

{******************************************************************************}
procedure TFNovaFaccionista.FaccionistasAfterScroll(DataSet: TDataSet);
begin
  AtualizaLocalizas(PanelColor1);
end;

{******************************************************************************}
procedure TFNovaFaccionista.PageControl1Change(Sender: TObject);
begin
  if PageControl1.ActivePage = PAvaliacao then
     AtualizaPercentuais;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovaFaccionista]);
end.
