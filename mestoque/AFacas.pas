unit AFacas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, StdCtrls, Mask, DBCtrls, Tabela, DBKeyViolation, Db,
  BotaoCadastro, Buttons, DBTables, CBancoDados, Componentes1,
  PainelGradiente, Grids, DBGrids, Localizacao, DBClient, numericos, ComCtrls;

type
  TFFacas = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Faca: TRBSQL;
    MoveBasico1: TMoveBasico;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    Fechar: TBitBtn;
    FacaCODFACA: TFMTBCDField;
    FacaNOMFACA: TWideStringField;
    FacaALTFACA: TFMTBCDField;
    FacaLARFACA: TFMTBCDField;
    FacaQTDPROVA: TFMTBCDField;
    Label1: TLabel;
    DataFaca: TDataSource;
    ECodigo: TDBKeyViolation;
    DBEditColor1: TDBEditColor;
    Label2: TLabel;
    Bevel1: TBevel;
    Label5: TLabel;
    EConsulta: TLocalizaEdit;
    GridIndice1: TGridIndice;
    FacaALTPROVA: TFMTBCDField;
    FacaLARPROVA: TFMTBCDField;
    Paginas: TPageControl;
    PGeral: TTabSheet;
    PanelColor3: TPanelColor;
    Label7: TLabel;
    LMedida1: TLabel;
    DBEditColor2: TDBEditColor;
    LMedida2: TLabel;
    DBEditColor6: TDBEditColor;
    Label3: TLabel;
    Label6: TLabel;
    DBEditColor4: TDBEditColor;
    Label8: TLabel;
    DBEditColor5: TDBEditColor;
    LMedida3: TLabel;
    LMedida4: TLabel;
    DBEditColor3: TDBEditColor;
    Label4: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    PEmbalagemPvc: TTabSheet;
    PanelColor4: TPanelColor;
    Label11: TLabel;
    DBEditColor7: TDBEditColor;
    Label12: TLabel;
    DBEditColor8: TDBEditColor;
    Label13: TLabel;
    DBEditColor9: TDBEditColor;
    Label14: TLabel;
    DBEditColor10: TDBEditColor;
    DBEditColor11: TDBEditColor;
    Label15: TLabel;
    Label16: TLabel;
    DBEditColor12: TDBEditColor;
    FacaABAFACA: TFMTBCDField;
    FacaFUNFACA: TFMTBCDField;
    FacaTOTFACA: TFMTBCDField;
    FacaPENFACA: TFMTBCDField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PanelColor1Click(Sender: TObject);
    procedure FecharClick(Sender: TObject);
    procedure FacaAfterInsert(DataSet: TDataSet);
    procedure FacaAfterEdit(DataSet: TDataSet);
    procedure FacaAfterPost(DataSet: TDataSet);
    procedure FacaBeforePost(DataSet: TDataSet);
    procedure GridIndice1Ordem(Ordem: String);
    procedure PaginasChange(Sender: TObject);
    procedure BotaoCadastrar1AntesAtividade(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FFacas: TFFacas;

implementation

uses APrincipal,constantes, FunObjeto;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFFacas.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EConsulta.AtualizaConsulta;
  if config.ConverterMTeCMparaMM then
    AlteraCaption([LMedida1,LMedida2,LMedida3,LMedida4],'mm');
    Paginas.ActivePage:= PGeral;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFFacas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Faca.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


procedure TFFacas.PaginasChange(Sender: TObject);
begin
  if (Paginas.ActivePage = PEmbalagemPvc) and (config.CadastroEmbalagemPvc) then
  begin
    DBEditColor2.Text:= '0';
    DBEditColor5.Text:= '0';
    DBEditColor4.Text:= '0';
  end;
end;

procedure TFFacas.PanelColor1Click(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFFacas.FecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFFacas.FacaAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := false;
  Ecodigo.ProximoCodigo;
end;

{******************************************************************************}
procedure TFFacas.BotaoCadastrar1AntesAtividade(Sender: TObject);
begin
  Paginas.ActivePage:= PGeral;
end;

procedure TFFacas.FacaAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
end;

{******************************************************************************}
procedure TFFacas.FacaAfterPost(DataSet: TDataSet);
begin
  EConsulta.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFFacas.FacaBeforePost(DataSet: TDataSet);
begin
  if Faca.state = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
end;

procedure TFFacas.GridIndice1Ordem(Ordem: String);
begin
  EConsulta.AOrdem := Ordem;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFFacas]);
end.
