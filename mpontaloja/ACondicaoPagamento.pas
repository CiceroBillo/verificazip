unit ACondicaoPagamento;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  DB, BotaoCadastro, StdCtrls, Buttons, Componentes1, Grids, DBGrids, Tabela,
  DBKeyViolation, DBClient, ExtCtrls, PainelGradiente, UnContasAReceber;

type
  TFCondicaoPagamento = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    CadCondicoesPagto: TSQL;
    Grade: TGridIndice;
    PanelColor2: TPanelColor;
    EDescricao: TEditColor;
    Label1: TLabel;
    BFechar: TBitBtn;
    CadCondicoesPagtoI_COD_PAG: TFMTBCDField;
    CadCondicoesPagtoC_NOM_PAG: TWideStringField;
    CadCondicoesPagtoI_QTD_PAR: TFMTBCDField;
    CadCondicoesPagtoI_DIA_CAR: TFMTBCDField;
    CadCondicoesPagtoC_NOM_USU: TWideStringField;
    DataCadCondicoesPagto: TDataSource;
    BitBtn1: TBitBtn;
    BExcluir: TBitBtn;
    MovCondicao: TSQL;
    MovCondicaoI_COD_PAG: TFMTBCDField;
    MovCondicaoI_NRO_PAR: TFMTBCDField;
    MovCondicaoI_NUM_DIA: TFMTBCDField;
    MovCondicaoI_DIA_FIX: TFMTBCDField;
    MovCondicaoD_DAT_FIX: TSQLTimeStampField;
    MovCondicaoN_PER_PAG: TFMTBCDField;
    MovCondicaoN_PER_COM: TFMTBCDField;
    DataMovCondicao: TDataSource;
    GridIndice1: TGridIndice;
    PanelColor3: TPanelColor;
    BAlterar: TBitBtn;
    CadCondicoesPagtoD_ULT_ALT: TSQLTimeStampField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure GradeOrdem(Ordem: string);
    procedure EDescricaoExit(Sender: TObject);
    procedure EDescricaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn1Click(Sender: TObject);
    procedure BExcluirClick(Sender: TObject);
    procedure CadCondicoesPagtoAfterScroll(DataSet: TDataSet);
    procedure BAlterarClick(Sender: TObject);
    procedure CadCondicoesPagtoAfterPost(DataSet: TDataSet);
    procedure CadCondicoesPagtoBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
    VprOrdem : String;
    procedure AtualizaConsulta;
    procedure AdicionaFiltros(VpaSelect : TStrings);
  public
    { Public declarations }
  end;

var
  FCondicaoPagamento: TFCondicaoPagamento;

implementation

uses APrincipal, FunSql, ANovaCondicaoPagamento, Constmsg, UnSistema;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFCondicaoPagamento.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  Vprordem := 'order by PAG.I_COD_PAG';
  Atualizaconsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFCondicaoPagamento.GradeOrdem(Ordem: string);
begin
  VprOrdem := Ordem;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFCondicaoPagamento.BAlterarClick(Sender: TObject);
begin
  if CadCondicoesPagtoI_COD_PAG.AsInteger <> 0 then
  begin
    FNovaCondicaoPagamento := TFNovaCondicaoPagamento.CriarSDI(self,'',true);
    if FNovaCondicaoPagamento.AlteraCondicaoPagamento(CadCondicoesPagtoI_COD_PAG.AsInteger) then
      AtualizaConsulta;
    FNovaCondicaoPagamento.Free;
  end;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFCondicaoPagamento.BExcluirClick(Sender: TObject);
begin
  if CadCondicoesPagtoI_COD_PAG.AsInteger <> 0 then
  begin
    if  Confirmacao(CT_DeletaRegistro) then
    begin
      FunContasAReceber.ExcluiCondicaoPagamento(CadCondicoesPagtoI_COD_PAG.AsInteger);
      AtualizaConsulta;
    end;
  end;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFCondicaoPagamento.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFCondicaoPagamento.BitBtn1Click(Sender: TObject);
begin
  FNovaCondicaoPagamento := TFNovaCondicaoPagamento.CriarSDI(self,'',true);
  if FNovaCondicaoPagamento.NovaCondicaoPagamento then
    AtualizaConsulta;
  FNovaCondicaoPagamento.free;
end;

{******************************************************************************}
procedure TFCondicaoPagamento.CadCondicoesPagtoAfterPost(DataSet: TDataSet);
begin
  Sistema.MarcaTabelaParaImportar('CADCONDICOESPAGTO');
end;

procedure TFCondicaoPagamento.CadCondicoesPagtoAfterScroll(DataSet: TDataSet);
begin
  AdicionaSQLAbreTabela(MovCondicao,'select I_COD_PAG, I_NRO_PAR, I_NUM_DIA, I_DIA_FIX, D_DAT_FIX, N_PER_PAG, N_PER_COM '+
                                    ' from MOVCONDICAOPAGTO '+
                                    ' Where I_COD_PAG = '+IntToStr(CadCondicoesPagtoI_COD_PAG.AsInteger)+
                                    ' order by I_NRO_PAR');
end;

procedure TFCondicaoPagamento.CadCondicoesPagtoBeforePost(DataSet: TDataSet);
begin
  CadCondicoesPagtoD_ULT_ALT.AsDateTime := Sistema.RDataServidor;
end;

{******************************************************************************}
procedure TFCondicaoPagamento.EDescricaoExit(Sender: TObject);
begin
  AtualizaConsulta;
end;

procedure TFCondicaoPagamento.EDescricaoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 13 then
    Atualizaconsulta;
end;

procedure TFCondicaoPagamento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFCondicaoPagamento.AtualizaConsulta;
begin
  MovCondicao.Close;
  CadCondicoesPagto.close;
  CadCondicoesPagto.sql.clear;
  AdicionaSqlTabela(CadCondicoesPagto,'select PAG.I_COD_PAG, PAG.C_NOM_PAG, PAG.I_QTD_PAR, PAG.I_DIA_CAR, '+
                                      ' USU.C_NOM_USU, PAG.D_ULT_ALT '+
                                      ' from CADCONDICOESPAGTO PAG, CADUSUARIOS USU '+
                                      ' Where '+SQLTextoRightJoin('PAG.I_COD_USU','USU.I_COD_USU'));
  AdicionaFiltros(CadCondicoesPagto.sql);
  AdicionaSQLTabela(CadCondicoesPagto,VprOrdem);
  CadCondicoesPagto.open;
  Grade.ALinhaSQLOrderBy := CadCondicoesPagto.sql.count-1;
end;

{******************************************************************************}
procedure TFCondicaoPagamento.AdicionaFiltros(VpaSelect : TStrings);
begin
  if EDescricao.text <> '' then
    VpaSelect.add('and C_NOM_PAG like '''+EDescricao.text+'%''');
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFCondicaoPagamento]);
end.
