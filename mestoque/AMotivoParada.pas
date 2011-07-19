unit AMotivoParada;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios, BotaoCadastro, StdCtrls, Buttons, Componentes1,
  ExtCtrls, PainelGradiente, Grids, DBGrids, Tabela, DBKeyViolation, Localizacao, DB, Mask, DBCtrls, DBClient, CBancoDados;

type
  TFMotivoParada = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    MoveBasico1: TMoveBasico;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    MotivoParada: TRBSQL;
    MotivoParadaCODMOTIVOPARADA: TFMTBCDField;
    MotivoParadaNOMMOTIVOPARADA: TWideStringField;
    ECodigo: TDBKeyViolation;
    DataMotivoParada: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    DBEditColor1: TDBEditColor;
    Bevel1: TBevel;
    Label3: TLabel;
    EConsulta: TLocalizaEdit;
    GridIndice1: TGridIndice;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure GridIndice1Ordem(Ordem: string);
    procedure MotivoParadaAfterInsert(DataSet: TDataSet);
    procedure MotivoParadaAfterEdit(DataSet: TDataSet);
    procedure MotivoParadaAfterPost(DataSet: TDataSet);
    procedure MotivoParadaBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMotivoParada: TFMotivoParada;

implementation

uses APrincipal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFMotivoParada.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EConsulta.AtualizaConsulta;
end;

{*******************************************************************************}
procedure TFMotivoParada.GridIndice1Ordem(Ordem: string);
begin
  EConsulta.AOrdem := Ordem;
end;

{*******************************************************************************}
procedure TFMotivoParada.MotivoParadaAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
end;

{*******************************************************************************}
procedure TFMotivoParada.MotivoParadaAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := False;
  ECodigo.ProximoCodigo;
end;

{*******************************************************************************}
procedure TFMotivoParada.MotivoParadaAfterPost(DataSet: TDataSet);
begin
  EConsulta.AtualizaConsulta;
end;

procedure TFMotivoParada.MotivoParadaBeforePost(DataSet: TDataSet);
begin
  if MotivoParada.State = dsinsert  then
    ECodigo.VerificaCodigoUtilizado;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFMotivoParada.BFecharClick(Sender: TObject);
begin
  close;
end;

{*******************************************************************************}
procedure TFMotivoParada.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  MotivoParada.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFMotivoParada]);
end.
