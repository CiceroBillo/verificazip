unit ATipoMateriaPrima;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios, Componentes1, ExtCtrls, PainelGradiente, BotaoCadastro,
  StdCtrls, Buttons, Grids, DBGrids, Tabela, DBKeyViolation, Localizacao, Mask, DBCtrls, DB, DBClient, CBancoDados;

type
  TFTipoMateriaPrima = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    TipoMateriaPrima: TRBSQL;
    TipoMateriaPrimaCODTIPOMATERIAPRIMA: TFMTBCDField;
    TipoMateriaPrimaNOMTIPOMATERIAPRIMA: TWideStringField;
    Label1: TLabel;
    DataTipoMateriaPrima: TDataSource;
    ECodigo: TDBKeyViolation;
    Label2: TLabel;
    DBEditColor1: TDBEditColor;
    Bevel1: TBevel;
    Label3: TLabel;
    EConsulta: TLocalizaEdit;
    GridIndice1: TGridIndice;
    MoveBasico1: TMoveBasico;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure GridIndice1Ordem(Ordem: string);
    procedure TipoMateriaPrimaAfterInsert(DataSet: TDataSet);
    procedure TipoMateriaPrimaAfterPost(DataSet: TDataSet);
    procedure TipoMateriaPrimaAfterEdit(DataSet: TDataSet);
    procedure TipoMateriaPrimaBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FTipoMateriaPrima: TFTipoMateriaPrima;

implementation

uses APrincipal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFTipoMateriaPrima.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

{ **************************************************************************** }
procedure TFTipoMateriaPrima.GridIndice1Ordem(Ordem: string);
begin
  EConsulta.AOrdem := Ordem;
end;

{ **************************************************************************** }
procedure TFTipoMateriaPrima.TipoMateriaPrimaAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
end;

procedure TFTipoMateriaPrima.TipoMateriaPrimaAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ProximoCodigo;
  ECodigo.ReadOnly := false;
end;

{ **************************************************************************** }
procedure TFTipoMateriaPrima.TipoMateriaPrimaAfterPost(DataSet: TDataSet);
begin
  EConsulta.AtualizaConsulta;
end;

{ **************************************************************************** }
procedure TFTipoMateriaPrima.TipoMateriaPrimaBeforePost(DataSet: TDataSet);
begin
  if TipoMateriaPrima.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFTipoMateriaPrima.BFecharClick(Sender: TObject);
begin
  close;
end;

{ **************************************************************************** }
procedure TFTipoMateriaPrima.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFTipoMateriaPrima]);
end.
