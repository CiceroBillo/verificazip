unit ATabelaComissao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, PainelGradiente, BotaoCadastro, StdCtrls, Buttons, Componentes1,
  Localizacao, Grids, DBGrids, Tabela, DBKeyViolation, Mask, DBCtrls, DB,
  DBClient, CBancoDados;

type
  TFTabelaComissao = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    tdb: TPanelColor;
    Bevel1: TBevel;
    PanelColor2: TPanelColor;
    MoveBasico1: TMoveBasico;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    Label1: TLabel;
    ECodigo: TDBKeyViolation;
    LCaptionComissao: TLabel;
    LDescontoAcrescimo: TLabel;
    DBEditColor1: TDBEditColor;
    DBEditColor2: TDBEditColor;
    BFechar: TBitBtn;
    DataTABELAPERCOMISSAO: TDataSource;
    TABELAPERCOMISSAO: TRBSQL;
    TABELAPERCOMISSAOCODACRESDESC: TFMTBCDField;
    TABELAPERCOMISSAOPERCOMISSAO: TFMTBCDField;
    TABELAPERCOMISSAOPERDESCONTO: TFMTBCDField;
    TABELAPERCOMISSAOINDACRESDESC: TWideStringField;
    GridIndice1: TGridIndice;
    Label4: TLabel;
    EConsulta: TLocalizaEdit;
    CDesconto: TRadioButton;
    CAcrescimo: TRadioButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure TABELAPERCOMISSAOAfterEdit(DataSet: TDataSet);
    procedure TABELAPERCOMISSAOAfterInsert(DataSet: TDataSet);
    procedure TABELAPERCOMISSAOBeforePost(DataSet: TDataSet);
    procedure TABELAPERCOMISSAOAfterPost(DataSet: TDataSet);
    procedure CDescontoClick(Sender: TObject);
    procedure TABELAPERCOMISSAOAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
    procedure CarCaptionDescontoacrescimo;
  public
    { Public declarations }
  end;

var
  FTabelaComissao: TFTabelaComissao;

implementation

uses APrincipal, FunObjeto;

{$R *.DFM}


{ **************************************************************************** }
procedure TFTabelaComissao.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
   TABELAPERCOMISSAO.open;
end;

{******************************************************************************}
procedure TFTabelaComissao.TABELAPERCOMISSAOAfterEdit(DataSet: TDataSet);
begin
    ECodigo.ReadOnly := True;
end;

{******************************************************************************}
procedure TFTabelaComissao.TABELAPERCOMISSAOAfterInsert(DataSet: TDataSet);
begin
   ECodigo.ProximoCodigo;
   ECodigo.ReadOnly := False;
   CDesconto.Checked := true;
end;

{******************************************************************************}
procedure TFTabelaComissao.TABELAPERCOMISSAOAfterPost(DataSet: TDataSet);
begin
//  EConsulta.AtualizaTabela;
end;

procedure TFTabelaComissao.TABELAPERCOMISSAOAfterScroll(DataSet: TDataSet);
begin
  if TABELAPERCOMISSAOINDACRESDESC.AsString = 'A' then
    CAcrescimo.Checked := true
  else
    CDesconto.Checked := true;
  CarCaptionDescontoacrescimo;
end;

{******************************************************************************}
procedure TFTabelaComissao.TABELAPERCOMISSAOBeforePost(DataSet: TDataSet);
begin
  if CDesconto.Checked then
    TABELAPERCOMISSAOINDACRESDESC.AsString := 'D'
  else
    TABELAPERCOMISSAOINDACRESDESC.AsString := 'A';
  if TABELAPERCOMISSAO.State = dsinsert then
      ECodigo.VerificaCodigoUtilizado;
end;

{ *************************************************************************** }
procedure TFTabelaComissao.BFecharClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFTabelaComissao.CarCaptionDescontoacrescimo;
begin
  if CDesconto.Checked then
  begin
    LDescontoAcrescimo.Caption := 'Desconto :';
    LCaptionComissao.Caption := '% Desconto Comissão :';
  end
  else
  begin
    LDescontoAcrescimo.Caption := 'Acrescimo :';
    LCaptionComissao.Caption := '% Acrescimo Comissão :';
  end;

end;

{******************************************************************************}
procedure TFTabelaComissao.CDescontoClick(Sender: TObject);
begin
  CarCaptionDescontoacrescimo;
end;


{******************************************************************************}
procedure TFTabelaComissao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  TABELAPERCOMISSAO.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFTabelaComissao]);
end.
