unit ANovoEstagio;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios, StdCtrls, ExtCtrls, DBCtrls,
  Localizacao, Mask, Tabela, DBKeyViolation, Buttons, BotaoCadastro, Componentes1, PainelGradiente, DB, DBClient,
  CBancoDados;

type
  TFNovoEstagio = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    SpeedButton1: TSpeedButton;
    Label4: TLabel;
    Label17: TLabel;
    BPlano: TSpeedButton;
    LPlano: TLabel;
    Label6: TLabel;
    ECodigo: TDBKeyViolation;
    DBEditColor1: TDBEditColor;
    ETipoEstagio: TDBEditLocaliza;
    EPlanoContas: TDBEditLocaliza;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBEditColor2: TDBEditColor;
    DBRadioGroup1: TDBRadioGroup;
    Label5: TLabel;
    DBEditColor3: TDBEditColor;
    EstagioProducao: TRBSQL;
    EstagioProducaoCODEST: TFMTBCDField;
    EstagioProducaoNOMEST: TWideStringField;
    EstagioProducaoCODTIP: TFMTBCDField;
    EstagioProducaoINDFIN: TWideStringField;
    EstagioProducaoCODPLA: TWideStringField;
    EstagioProducaoCODEMP: TFMTBCDField;
    EstagioProducaoINDOBS: TWideStringField;
    EstagioProducaoMAXDIA: TFMTBCDField;
    EstagioProducaoTIPEST: TWideStringField;
    EstagioProducaoDATALT: TSQLTimeStampField;
    DataEstagioProducao: TDataSource;
    ValidaGravacao1: TValidaGravacao;
    Localiza: TConsultaPadrao;
    EstagioProducaoVALHOR: TFMTBCDField;
    DBCheckBox3: TDBCheckBox;
    EstagioProducaoINDEMAIL: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EstagioProducaoAfterInsert(DataSet: TDataSet);
    procedure EstagioProducaoAfterEdit(DataSet: TDataSet);
    procedure EstagioProducaoAfterScroll(DataSet: TDataSet);
    procedure ECodigoChange(Sender: TObject);
    procedure ETipoEstagioCadastrar(Sender: TObject);
    procedure EPlanoContasRetorno(Retorno1, Retorno2: string);
    procedure EstagioProducaoAfterPost(DataSet: TDataSet);
    procedure BFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FNovoEstagio: TFNovoEstagio;

implementation

uses APrincipal, AEstagioProducao, ATipoEstagioProducao, unSistema, FunObjeto;

{$R *.DFM}


{ **************************************************************************** }
procedure TFNovoEstagio.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EstagioProducao.Open;
  InicializaVerdadeiroeFalsoCheckBox(PanelColor1,'S','N');
end;

{ *************************************************************************** }
procedure TFNovoEstagio.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFNovoEstagio.ECodigoChange(Sender: TObject);
begin
  if (EstagioProducao.State in [dsedit,dsinsert]) then
    ValidaGravacao1.Execute;
end;

{******************************************************************************}
procedure TFNovoEstagio.EPlanoContasRetorno(Retorno1, Retorno2: string);
begin
  if Retorno1 <> '' then
    EstagioProducaoCODEMP.AsString := Retorno1
  else
    EstagioProducaoCODEMP.Clear;
end;

{******************************************************************************}
procedure TFNovoEstagio.EstagioProducaoAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
end;

{******************************************************************************}
procedure TFNovoEstagio.EstagioProducaoAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := false;
  ECodigo.ProximoCodigo;
  EstagioProducaoINDFIN.AsString := 'N';
  EstagioProducaoINDOBS.AsString := 'N';
  EstagioProducaoTIPEST.AsString := 'P';
end;

procedure TFNovoEstagio.EstagioProducaoAfterPost(DataSet: TDataSet);
begin
  Sistema.MarcaTabelaParaImportar('ESTAGIOPRODUCAO');
end;

{******************************************************************************}
procedure TFNovoEstagio.EstagioProducaoAfterScroll(DataSet: TDataSet);
begin
  ETipoEstagio.Atualiza;
  EPlanoContas.Atualiza;
end;

{******************************************************************************}
procedure TFNovoEstagio.ETipoEstagioCadastrar(Sender: TObject);
begin
  FTipoEstagioProducao := TFTipoEstagioProducao.criarSDI(Application,'',FPrincipal.verificaPermisao('FTipoEstagioProducao'));
  FTipoEstagioProducao.BotaoCadastrar1.Click;
  FTipoEstagioProducao.Showmodal;
  FTipoEstagioProducao.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovoEstagio.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  EstagioProducao.Close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovoEstagio]);
end.
