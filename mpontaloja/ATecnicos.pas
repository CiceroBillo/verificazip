unit ATecnicos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Grids, DBGrids, Tabela, DBKeyViolation, Componentes1, ExtCtrls,
  PainelGradiente, StdCtrls, Localizacao, Db, DBTables, BotaoCadastro, UnZebra,
  Buttons, Menus, DBClient;

type
  TFTecnicos = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Grade: TGridIndice;
    Tecnico: TSQL;
    DataTecnico: TDataSource;
    TecnicoCODTECNICO: TFMTBCDField;
    TecnicoNOMTECNICO: TWideStringField;
    TecnicoDESTELEFONE: TWideStringField;
    ELocaliza: TLocalizaEdit;
    Label1: TLabel;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoConsultar1: TBotaoConsultar;
    BotaoExcluir1: TBotaoExcluir;
    BFechar: TBitBtn;
    PopupMenu1: TPopupMenu;
    ImprimirCodigoBarras1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BotaoCadastrar1AntesAtividade(Sender: TObject);
    procedure BotaoCadastrar1DepoisAtividade(Sender: TObject);
    procedure BotaoAlterar1Atividade(Sender: TObject);
    procedure BotaoExcluir1DepoisAtividade(Sender: TObject);
    procedure BotaoExcluir1DestroiFormulario(Sender: TObject);
    procedure ImprimirCodigoBarras1Click(Sender: TObject);
    procedure BotaoAlterar1Click(Sender: TObject);
    procedure GradeOrdem(Ordem: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FTecnicos: TFTecnicos;

implementation

uses APrincipal, ANovoTecnico, FunSql, Constantes, FunString;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFTecnicos.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  ELocaliza.AtualizaConsulta;
end;

procedure TFTecnicos.GradeOrdem(Ordem: string);
begin
  ELocaliza.AOrdem := Ordem;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFTecnicos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Tecnico.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFTecnicos.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFTecnicos.BotaoCadastrar1AntesAtividade(Sender: TObject);
begin
  FNovoTecnico := TFNovoTecnico.CriarSDI(application,'', FPrincipal.VerificaPermisao('FNovoTecnico'));
end;

{******************************************************************************}
procedure TFTecnicos.BotaoCadastrar1DepoisAtividade(Sender: TObject);
begin
  FNovoTecnico.showmodal;
  ELocaliza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFTecnicos.BotaoAlterar1Atividade(Sender: TObject);
begin
  AdicionaSQLAbreTabela(FNovoTecnico.Tecnico,'Select * from TECNICO '+
                           ' Where CODTECNICO = '+ TecnicoCODTECNICO.AsString);
end;

procedure TFTecnicos.BotaoAlterar1Click(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFTecnicos.BotaoExcluir1DepoisAtividade(Sender: TObject);
begin
  FNovoTecnico.show;
end;

{******************************************************************************}
procedure TFTecnicos.BotaoExcluir1DestroiFormulario(Sender: TObject);
begin
  FNovoTecnico.close;
  ELocaliza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFTecnicos.ImprimirCodigoBarras1Click(Sender: TObject);
Var
  VpfFunZebra : TRBFuncoesZebra;
begin
  if varia.ModeloEtiquetaNotaEntrada in [6] then
    VpfFunZebra := TRBFuncoesZebra.cria(varia.PortaComunicacaoImpTermica,176,lzEPL);
  VpfFunZebra.ImprimeCodigoBarras(90,10,0,'2',2,5,60,false,AdicionaCharE('0',FloatToStr(TecnicoCODTECNICO.AsInteger),5));
  VpfFunZebra.ImprimeTexto(20,95,0,1,2,3,false,copy(TecnicoNOMTECNICO.AsString,1,13));
  if Length(TecnicoNOMTECNICO.AsString) > 15 then
    VpfFunZebra.ImprimeTexto(20,135,0,1,2,3,false,copy(TecnicoNOMTECNICO.AsString,14,13));
  VpfFunZebra.FechaImpressao;
  VpfFunZebra.free;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFTecnicos]);
end.





