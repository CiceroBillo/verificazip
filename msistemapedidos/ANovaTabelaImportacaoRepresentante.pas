unit ANovaTabelaImportacaoRepresentante;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Localizacao, DBKeyViolation,
  BotaoCadastro, StdCtrls, Buttons, DB, DBClient, Tabela, Mask, DBCtrls, Grids,
  DBGrids;

type
  TFNovaTabelaImportacaoRepresentante = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PDireita: TPanelColor;
    MoveBasico1: TMoveBasico;
    BotaoAlterar1: TBotaoAlterar;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BFechar: TBitBtn;
    ValidaGravacao: TValidaGravacao;
    Localiza: TConsultaPadrao;
    DataTabelaImportacao: TDataSource;
    TABELAIMPORTACAO: TSQL;
    TABELAIMPORTACAOCODTABELA: TFMTBCDField;
    TABELAIMPORTACAOSEQIMPORTACAO: TFMTBCDField;
    TABELAIMPORTACAONOMTABELA: TWideStringField;
    TABELAIMPORTACAODESTABELA: TWideStringField;
    TABELAIMPORTACAODATIMPORTACAO: TSQLTimeStampField;
    TABELAIMPORTACAODESFILTROVENDEDOR: TWideStringField;
    TABELAIMPORTACAODESCAMPODATA: TWideStringField;
    TABELAIMPORTACAODATULTIMAALTERACAOMATRIZ: TSQLTimeStampField;
    Label1: TLabel;
    ECodigo: TDBKeyViolation;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    DBEditColor1: TDBEditColor;
    ETabela: TDBEditColor;
    DBEditColor3: TDBEditColor;
    DBEditColor4: TDBEditColor;
    DBEditColor5: TDBEditColor;
    DBEditColor6: TDBEditColor;
    DBEditColor7: TDBEditColor;
    Bevel1: TBevel;
    Label9: TLabel;
    EConsulta: TLocalizaEdit;
    GGrid: TGridIndice;
    TABELAIMPORTACAOINDIMPORTAR: TWideStringField;
    DBCheckBox1: TDBCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure TABELAIMPORTACAOAfterInsert(DataSet: TDataSet);
    procedure TABELAIMPORTACAOAfterPost(DataSet: TDataSet);
    procedure TABELAIMPORTACAOAfterEdit(DataSet: TDataSet);
    procedure TABELAIMPORTACAOAfterCancel(DataSet: TDataSet);
    procedure GGridOrdem(Ordem: string);
    procedure ETabelaChange(Sender: TObject);
  private
    { Private declarations }
    procedure ConfiguraConsulta(acao : Boolean);
  public
    { Public declarations }
  end;

var
  FNovaTabelaImportacaoRepresentante: TFNovaTabelaImportacaoRepresentante;

implementation

uses APrincipal;

{$R *.DFM}


{ **************************************************************************** }
procedure TFNovaTabelaImportacaoRepresentante.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EConsulta.AtualizaConsulta;
end;

{ *************************************************************************** }
procedure TFNovaTabelaImportacaoRepresentante.GGridOrdem(Ordem: string);
begin
  EConsulta.AOrdem := ordem;
end;

{ *************************************************************************** }
procedure TFNovaTabelaImportacaoRepresentante.TABELAIMPORTACAOAfterCancel(DataSet: TDataSet);
begin
  ConfiguraConsulta(True);
end;

{ *************************************************************************** }
procedure TFNovaTabelaImportacaoRepresentante.TABELAIMPORTACAOAfterEdit(
  DataSet: TDataSet);
begin
  ConfiguraConsulta(false);
end;

{ *************************************************************************** }
procedure TFNovaTabelaImportacaoRepresentante.TABELAIMPORTACAOAfterInsert(DataSet: TDataSet);
begin
end;

{ *************************************************************************** }
procedure TFNovaTabelaImportacaoRepresentante.TABELAIMPORTACAOAfterPost(DataSet: TDataSet);
begin
  EConsulta.AtualizaConsulta;
  ConfiguraConsulta(True);
end;

{ *************************************************************************** }
procedure TFNovaTabelaImportacaoRepresentante.BFecharClick(Sender: TObject);
begin
  Close;
end;

{ *************************************************************************** }
procedure TFNovaTabelaImportacaoRepresentante.ConfiguraConsulta(acao: Boolean);
begin
   Label9.Enabled := acao;
   EConsulta.Enabled := acao;
   GGrid.Enabled := acao;
end;

{ *************************************************************************** }
procedure TFNovaTabelaImportacaoRepresentante.ETabelaChange(Sender: TObject);
begin
  if (TABELAIMPORTACAO.State in [dsInsert, dsEdit]) then
    ValidaGravacao.Execute;
end;

{ *************************************************************************** }
procedure TFNovaTabelaImportacaoRepresentante.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
  TABELAIMPORTACAO.Close;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovaTabelaImportacaoRepresentante]);
end.
