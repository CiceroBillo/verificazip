unit AOrdemCortePendente;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios, Componentes1, ExtCtrls, PainelGradiente, Grids, DBGrids,
  Tabela, DBKeyViolation, StdCtrls, Buttons, DB, DBClient, Menus;

type
  TFOrdemCortePendente = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    BFechar: TBitBtn;
    GridIndice1: TGridIndice;
    CortePendente: TSQL;
    DataCortePendente: TDataSource;
    CortePendenteCODFILIAL: TFMTBCDField;
    CortePendenteSEQORDEM: TFMTBCDField;
    CortePendenteSEQFRACAO: TFMTBCDField;
    CortePendenteQTDPRODUTO: TFMTBCDField;
    CortePendenteDATEMI: TSQLTimeStampField;
    CortePendenteI_COD_CLI: TFMTBCDField;
    CortePendenteC_NOM_CLI: TWideStringField;
    CortePendenteC_NOM_PRO: TWideStringField;
    CortePendenteC_COD_PRO: TWideStringField;
    CortePendenteQTDDIAS: TIntegerField;
    BImprimir: TBitBtn;
    CortePendenteDATENTREGA: TSQLTimeStampField;
    PopupMenu1: TPopupMenu;
    Baixar1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure CortePendenteCalcFields(DataSet: TDataSet);
    procedure BImprimirClick(Sender: TObject);
    procedure Baixar1Click(Sender: TObject);
  private
    { Private declarations }
    procedure AtualizaConsulta;
  public
    { Public declarations }
  end;

var
  FOrdemCortePendente: TFOrdemCortePendente;

implementation

uses APrincipal, FunSQL, FunData, dmRave, UnOrdemProducao, constmsg;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFOrdemCortePendente.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  AtualizaConsulta;
end;

{ **************************************************************************** }
procedure TFOrdemCortePendente.AtualizaConsulta;
begin
  AdicionaSQLAbreTabela(CortePendente,'select FRA.CODFILIAL, FRA.SEQORDEM, FRA.SEQFRACAO, FRA.QTDPRODUTO, FRA.DATENTREGA, '+
                                      ' OP.DATEMI, '+
                                      ' CLI.I_COD_CLI, CLI.C_NOM_CLI, '+
                                      ' PRO.C_COD_PRO, PRO.C_NOM_PRO '+
                                      ' from FRACAOOP FRA, ORDEMPRODUCAOCORPO OP, CADCLIENTES CLI, CADPRODUTOS PRO, ORDEMCORTECORPO OCP '+
                                      ' where FRA.DATCORTE IS NULL '+
                                      ' AND OP.EMPFIL = FRA.CODFILIAL '+
                                      ' AND OP.SEQORD = FRA.SEQORDEM '+
                                      ' AND OP.CODCLI = CLI.I_COD_CLI '+
                                      ' AND OP.SEQPRO = PRO.I_SEQ_PRO '+
                                      ' AND OP.EMPFIL = OCP.CODFILIAL ' +
                                      ' AND OP.SEQORD = OCP.SEQORDEMPRODUCAO '+
                                      ' ORDER BY FRA.DATENTREGA, FRA.CODFILIAL, FRA.SEQORDEM, FRA.SEQFRACAO ');
end;

{ **************************************************************************** }
procedure TFOrdemCortePendente.Baixar1Click(Sender: TObject);
var
  VpfResultado : String;
begin
  VpfResultado := FunOrdemProducao.BaixaOrdemCorte(CortePendenteCODFILIAL.AsInteger,CortePendenteSEQORDEM.AsInteger,CortePendenteSEQFRACAO.AsInteger);
  if VpfResultado <> '' then
    aviso(VpfResultado)
  else
    AtualizaConsulta;
end;

procedure TFOrdemCortePendente.BFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFOrdemCortePendente.BImprimirClick(Sender: TObject);
begin
  dtRave := TdtRave.Create(self);
  dtRave.ImprimeCortePendente;
  dtRave.Free;
end;

{ **************************************************************************** }
procedure TFOrdemCortePendente.CortePendenteCalcFields(DataSet: TDataSet);
begin
  CortePendenteQTDDIAS.AsInteger := DiasPorPeriodo(CortePendenteDATEMI.AsDateTime,date);
end;

{ **************************************************************************** }
procedure TFOrdemCortePendente.FormClose(Sender: TObject; var Action: TCloseAction);
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
 RegisterClasses([TFOrdemCortePendente]);
end.
