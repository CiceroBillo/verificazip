unit AMedico;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, BotaoCadastro, StdCtrls, Buttons,
  Db, DBTables, Tabela, CBancoDados, Localizacao, Grids, DBGrids,
  DBKeyViolation, DBCtrls, Mask, DBClient;

type
  TFMedico = class(TFormularioPermissao)
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
    Medico: TRBSQL;
    MedicoCODMEDICO: TFMTBCDField;
    MedicoNOMMEDICO: TWideStringField;
    MedicoNUMREGISTRO: TWideStringField;
    MedicoDESCONSELHO: TWideStringField;
    DataMedico: TDataSource;
    ECodigo: TDBKeyViolation;
    Label1: TLabel;
    DBEditColor1: TDBEditColor;
    DBEditColor2: TDBEditColor;
    DBComboBoxColor1: TDBComboBoxColor;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Bevel1: TBevel;
    GridIndice1: TGridIndice;
    ELocaliza: TLocalizaEdit;
    Label5: TLabel;
    ValidaGravacao1: TValidaGravacao;
    MedicoDESUFCONSELHO: TWideStringField;
    DBEditColor3: TDBEditColor;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure MedicoAfterEdit(DataSet: TDataSet);
    procedure MedicoAfterInsert(DataSet: TDataSet);
    procedure MedicoBeforePost(DataSet: TDataSet);
    procedure MedicoAfterPost(DataSet: TDataSet);
    procedure ECodigoChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMedico: TFMedico;

implementation

uses APrincipal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFMedico.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  ELocaliza.AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFMedico.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Medico.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFMedico.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFMedico.MedicoAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
end;

procedure TFMedico.MedicoAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := false;
  ECodigo.ProximoCodigo;
end;

{******************************************************************************}
procedure TFMedico.MedicoBeforePost(DataSet: TDataSet);
begin
  if Medico.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
end;

{******************************************************************************}
procedure TFMedico.MedicoAfterPost(DataSet: TDataSet);
begin
  ELocaliza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFMedico.ECodigoChange(Sender: TObject);
begin
  if Medico.State in [dsedit,dsinsert] then
    ValidaGravacao1.execute;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFMedico]);
end.
