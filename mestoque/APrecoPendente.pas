unit APrecoPendente;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Db, DBTables, Grids, DBGrids, Tabela, DBKeyViolation, Componentes1,
  ExtCtrls, PainelGradiente, StdCtrls, Buttons, Mask, numericos, DBClient;

type
  TFPrecoPendente = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    GridIndice1: TGridIndice;
    Amostras: TSQL;
    DataAmostras: TDataSource;
    AmostrasDATACLIENTE: TSQLTimeStampField;
    AmostrasCODAMOSTRA: TFMTBCDField;
    AmostrasNOMAMOSTRA: TWideStringField;
    AmostrasDATAMOSTRA: TSQLTimeStampField;
    AmostrasDATENTREGA: TSQLTimeStampField;
    AmostrasC_NOM_CLI: TWideStringField;
    BFechar: TBitBtn;
    EQtd: Tnumerico;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
  private
    { Private declarations }
    procedure AtualizaConsulta;
  public
    { Public declarations }
  end;

var
  FPrecoPendente: TFPrecoPendente;

implementation

uses APrincipal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFPrecoPendente.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFPrecoPendente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Amostras.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFPrecoPendente.AtualizaConsulta;
begin
  Amostras.sql.clear;
  Amostras.sql.add('select AMI.DATAMOSTRA DATACLIENTE, '+
                   ' AMO.CODAMOSTRA, AMO.NOMAMOSTRA, AMO.DATAMOSTRA, AMO.DATENTREGA, '+
                   ' CLI.C_NOM_CLI ' +
                   ' from AMOSTRA AMO, CADCLIENTES CLI, AMOSTRA AMI '+
                   ' Where AMO.CODCLIENTE = CLI.I_COD_CLI '+
                   ' AND AMO.CODAMOSTRAINDEFINIDA = AMI.CODAMOSTRA '+
                   ' AND AMO.DATFICHAAMOSTRA IS NOT NULL '+
                   ' AND AMO.DATPRECO IS NULL '+
                   ' AND AMO.TIPAMOSTRA = ''D'''+
                   ' ORDER BY AMI.DATAMOSTRA, AMO.DATAMOSTRA, AMO.DATENTREGA');
  Amostras.Open;
  EQtd.AValor := Amostras.RecordCount;
end;

{******************************************************************************}
procedure TFPrecoPendente.BFecharClick(Sender: TObject);
begin
  close;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFPrecoPendente]);
end.
