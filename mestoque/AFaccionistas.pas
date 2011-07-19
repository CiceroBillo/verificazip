unit AFaccionistas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Grids, DBGrids, Tabela, DBKeyViolation, Componentes1, ExtCtrls,
  PainelGradiente, Db, DBTables, BotaoCadastro, StdCtrls, Buttons, DBClient;

type
  TFFaccionistas = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Faccionista: TSQL;
    FaccionistaCODFACCIONISTA: TFMTBCDField;
    FaccionistaNOMFACCIONISTA: TWideStringField;
    FaccionistaNOMRESPONSAVEL: TWideStringField;
    FaccionistaDESCIDADE: TWideStringField;
    FaccionistaDESTELEFONE1: TWideStringField;
    FaccionistaDESCELULAR: TWideStringField;
    DataFaccionista: TDataSource;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoConsultar1: TBotaoConsultar;
    BotaoExcluir1: TBotaoExcluir;
    BFechar: TBitBtn;
    BitBtn1: TBitBtn;
    Label2: TLabel;
    ECodigo: TEditColor;
    Label1: TLabel;
    ENome: TEditColor;
    Aux: TSQL;
    PanelColor4: TPanelColor;
    GridIndice1: TGridIndice;
    PanelColor3: TPanelColor;
    Label3: TLabel;
    CTotal: TCheckBox;
    ETotal: TEditColor;
    ESituacao: TComboBoxColor;
    Label4: TLabel;
    Label5: TLabel;
    EStatus: TComboBoxColor;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BotaoCadastrar1AntesAtividade(Sender: TObject);
    procedure BotaoCadastrar1DepoisAtividade(Sender: TObject);
    procedure BotaoAlterar1Atividade(Sender: TObject);
    procedure BotaoExcluir1DepoisAtividade(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure BotaoExcluir1DestroiFormulario(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure ECodigoExit(Sender: TObject);
    procedure ECodigoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CTotalClick(Sender: TObject);
  private
    { Private declarations }
    procedure AtualizaConsulta;
    procedure AdicionaFiltros(VpaSelect : TStrings);
    procedure AtualizaTotal;
  public
    { Public declarations }
  end;

var
  FFaccionistas: TFFaccionistas;

implementation

uses APrincipal, ANovaFaccionista, uncrystal,Constantes;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFFaccionistas.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  ESituacao.ItemIndex := 0;
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFFaccionistas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Faccionista.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFFaccionistas.AtualizaConsulta;
begin
  Faccionista.Close;
  Faccionista.sql.clear;
  Faccionista.sql.add('Select CODFACCIONISTA, NOMFACCIONISTA, NOMRESPONSAVEL, ' +
                      ' DESCIDADE, DESTELEFONE1, DESCELULAR '+
                      ' FROM FACCIONISTA FAC '+
                      ' Where CODFACCIONISTA = CODFACCIONISTA ');
  AdicionaFiltros(Faccionista.SQL);
  Faccionista.sql.savetofile('c:\consulta.sql');
  if CTotal.Checked then
    AtualizaTotal
  else
    ETotal.clear;
  Faccionista.open;
end;

{******************************************************************************}
procedure TFFaccionistas.AdicionaFiltros(VpaSelect : TStrings);
begin
  if ECodigo.AInteiro <> 0 then
    VpaSelect.Add('and CODFACCIONISTA = ' +ECodigo.Text)
  else
  begin
    if ENome.Text <> '' then
      VpaSelect.Add('and NOMFACCIONISTA LIKE '''+ENome.Text+'%''');
    case EStatus.ItemIndex of
      1 : VpaSelect.add(' and not exists(Select FRA.CODFACCIONISTA FROM FRACAOOPFACCIONISTA FRA '+
                     '  Where FRA.CODFACCIONISTA = FAC.CODFACCIONISTA '+
                     '  AND FRA.DATFINALIZACAO IS NULL )');
      2 : VpaSelect.add(' and not exists(Select FRA.CODFACCIONISTA FROM FRACAOOPFACCIONISTA FRA '+
                     '  Where FRA.CODFACCIONISTA = FAC.CODFACCIONISTA )');
    end;
    case ESituacao.ItemIndex of
      1 : VpaSelect.add('and INDATIVA = ''S''');
      2 : VpaSelect.add('and INDATIVA = ''N''');
    end;
  end;
end;

{******************************************************************************}
procedure TFFaccionistas.AtualizaTotal;
begin
  Aux.sql.clear;
  Aux.sql.add('Select count(CODFACCIONISTA) QTD ' +
                      ' FROM FACCIONISTA FAC'+
                      ' Where CODFACCIONISTA = CODFACCIONISTA ');
  AdicionaFiltros(Aux.sql);
  Aux.open;
  ETotal.AInteiro := Aux.FieldByname('QTD').AsInteger;
  Aux.close;
end;

{******************************************************************************}
procedure TFFaccionistas.BotaoCadastrar1AntesAtividade(Sender: TObject);
begin
  FNovaFaccionista := TFNovaFaccionista.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaFaccionista'));
end;

{******************************************************************************}
procedure TFFaccionistas.BotaoCadastrar1DepoisAtividade(Sender: TObject);
begin
  FNovaFaccionista.ShowModal;
  AtualizaConsulta;
end;

procedure TFFaccionistas.BotaoAlterar1Atividade(Sender: TObject);
begin
  FNovaFaccionista.LocalizaFaccionista(FaccionistaCODFACCIONISTA.AsInteger);
end;

{******************************************************************************}
procedure TFFaccionistas.BotaoExcluir1DepoisAtividade(Sender: TObject);
begin
  FNovaFaccionista.Show;
end;

{******************************************************************************}
procedure TFFaccionistas.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFFaccionistas.BotaoExcluir1DestroiFormulario(Sender: TObject);
begin
  FNovaFaccionista.Close;
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFFaccionistas.BitBtn1Click(Sender: TObject);
begin
  if FaccionistaCODFACCIONISTA.AsInteger <> 0 then
    FunCrystal.ImprimeRelatorio(varia.PathRelatorios+'\Faccionistas\XX_TermoResponsabilidade.rpt',[FaccionistaCODFACCIONISTA.AsString]);
end;

procedure TFFaccionistas.ECodigoExit(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFFaccionistas.ECodigoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 13 then
    AtualizaConsulta;
end;

{******************************************************************************}
procedure TFFaccionistas.CTotalClick(Sender: TObject);
begin
  AtualizaConsulta;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFFaccionistas]);
end.
