unit AMostraLocacoesALer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, PainelGradiente, Grids, DBGrids, Tabela, DBKeyViolation,
  Componentes1, StdCtrls, Buttons, Db, DBTables, DBClient;

type
  TFMostraLocacoesALer = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    GridIndice1: TGridIndice;
    Contratos: TSQL;
    ContratosCODFILIAL: TFMTBCDField;
    ContratosSEQCONTRATO: TFMTBCDField;
    ContratosNUMDIALEITURA: TFMTBCDField;
    ContratosDATULTIMAEXECUCAO: TSQLTimeStampField;
    ContratosC_NOM_CLI: TWideStringField;
    DataContratos: TDataSource;
    BFechar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
  private
    { Private declarations }
    function RNumDiasLeitura : string;
    procedure PosContratos;
  public
    { Public declarations }
    function MostraLeiturasPendentes : Boolean;
  end;

var
  FMostraLocacoesALer: TFMostraLocacoesALer;

implementation

uses APrincipal, Fundata, Constantes, FunSql, Funarquivos;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFMostraLocacoesALer.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFMostraLocacoesALer.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
function TFMostraLocacoesALer.RNumDiasLeitura : string;
Var
  VpfLaco : Integer;
  VpfDiaInicio : Integer;
begin
  result := '';
  if Dia(Varia.DatUltimaLeituraLocacao) > dia(date) then
  begin
    for VpfLaco := Dia(varia.DatUltimaLeituraLocacao)+1 to 31 do
      result := result + IntToStr(VpfLaco)+',';
    VpfDiaInicio := 1;
  end
  else
    VpfDiaInicio := Dia(varia.DatUltimaLeituraLocacao)+1;
  for VpfLaco := VpfDiaInicio to Dia(date) do
    result := result + IntToStr(VpfLaco)+',';
 result := copy(result,1,length(result)-1);
end;

{******************************************************************************}
procedure TFMostraLocacoesALer.PosContratos;
begin
  Contratos.close;
  if Varia.DatUltimaLeituraLocacao < date then
  begin
    Contratos.sql.clear;
    Contratos.sql.add('select CON.CODFILIAL, CON.SEQCONTRATO, CON.NUMDIALEITURA, CON.DATULTIMAEXECUCAO, CLI.C_NOM_CLI '+
                      ' from CONTRATOCORPO CON, CADCLIENTES CLI '+
                      ' Where CON.CODCLIENTE = CLI.I_COD_CLI '+
                      ' AND CON.DATCANCELAMENTO IS NULL '+
                      ' AND CON.NUMDIALEITURA IN ('+RNumDiasLeitura+')'+
                      ' AND CON.DATULTIMAEXECUCAO < '+SQLTextoDataAAAAMMMDD(date));
    Contratos.open;
  end;
end;

{******************************************************************************}
function TFMostraLocacoesALer.MostraLeiturasPendentes : Boolean;
begin
  PosContratos;
  if not Contratos.eof then
  begin
    showmodal;
    result := true;
  end;
end;

{******************************************************************************}
procedure TFMostraLocacoesALer.BFecharClick(Sender: TObject);
begin
  Close;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFMostraLocacoesALer]);
end.
