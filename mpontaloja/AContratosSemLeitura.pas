unit AContratosSemLeitura;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Grids, DBGrids, Tabela,
  DBKeyViolation, ComCtrls, StdCtrls, Localizacao, Buttons, Db, DBTables,
  DBClient, UnContrato, UnDados;

type
  TFContratosSemLeitura = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    GridIndice1: TGridIndice;
    ContratosSemLeitura: TSQL;
    DataContratosSemLeitura: TDataSource;
    Localiza: TConsultaPadrao;
    Label21: TLabel;
    SpeedButton18: TSpeedButton;
    LNomTipoContrato: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    ECodTipoContrato: TEditLocaliza;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    ContratosSemLeituraCODFILIAL: TFMTBCDField;
    ContratosSemLeituraSEQCONTRATO: TFMTBCDField;
    ContratosSemLeituraVALCONTRATO: TFMTBCDField;
    ContratosSemLeituraQTDFRANQUIA: TFMTBCDField;
    ContratosSemLeituraVALEXCESSOFRANQUIA: TFMTBCDField;
    ContratosSemLeituraC_NOM_CLI: TWideStringField;
    ContratosSemLeituraNOMTIPOCONTRATO: TWideStringField;
    BFechar: TBitBtn;
    Label3: TLabel;
    EVendedor: TEditLocaliza;
    SpeedButton1: TSpeedButton;
    Label4: TLabel;
    Label5: TLabel;
    ETecnico: TEditLocaliza;
    SpeedButton2: TSpeedButton;
    Label6: TLabel;
    ContratosSemLeituraCODTECNICOLEITURA: TFMTBCDField;
    ContratosSemLeituraDATASSINATURA: TSQLTimeStampField;
    ContratosSemLeituraNUMDIALEITURA: TFMTBCDField;
    ContratosSemLeituraDATULTIMAEXECUCAO: TSQLTimeStampField;
    BEnviarSelecionado: TBitBtn;
    ECliente: TRBEditLocaliza;
    SpeedButton3: TSpeedButton;
    Label7: TLabel;
    Label8: TLabel;
    ContratosSemLeituraI_COD_CLI: TFMTBCDField;
    BEnviarTodos: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ECodTipoContratoFimConsulta(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure BEnviarSelecionadoClick(Sender: TObject);
    procedure BEnviarTodosClick(Sender: TObject);
  private
    { Private declarations }
    FunContrato : TRBFuncoesContrato;
    procedure AtualizaConsulta;
    procedure AdicionaFiltros(VpaSelect: TStrings);
  public
    { Public declarations }
  end;

var
  FContratosSemLeitura: TFContratosSemLeitura;

implementation

uses APrincipal, FunSql,FunData, Constmsg, ANovoEmailMedidores, constantes;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFContratosSemLeitura.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EDatInicio.DateTime := DecDia(date,15);
  EDatFim.DateTime := date;
  FunContrato := TRBFuncoesContrato.cria(FPrincipal.BaseDados);
  AtualizaConsulta;
  BEnviarTodos.Visible := (varia.CNPJFilial = CNPJ_CopyLine) or (varia.CNPJFilial = CNPJ_IMPOX);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFContratosSemLeitura.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  ContratosSemLeitura.close;
  FunContrato.Free;
  Action := CaFree;
end;

{******************************************************************************}
procedure TFContratosSemLeitura.AtualizaConsulta;
begin
  ContratosSemLeitura.close;
  ContratosSemLeitura.sql.clear;
  ContratosSemLeitura.SQL.add('select CON.CODFILIAL, CON.SEQCONTRATO, CON.DATASSINATURA, CON.VALCONTRATO, '+
                 ' CON.QTDFRANQUIA,CON.VALEXCESSOFRANQUIA,CON.DATULTIMAEXECUCAO, CON.NUMDIALEITURA,'+
                 'CLI.C_NOM_CLI, CLI.I_COD_CLI,TIP.NOMTIPOCONTRATO, CON.CODTECNICOLEITURA '+
                 ' from contratocorpo con, CADCLIENTES CLI, TIPOCONTRATO TIP '+
                 ' where CON.CODCLIENTE = CLI.I_COD_CLI '+
                 ' and CON.CODTIPOCONTRATO = TIP.CODTIPOCONTRATO '+
                 ' AND CON.datcancelamento is null ');
  AdicionaFiltros(ContratosSemLeitura.SQL);
  ContratosSemLeitura.open;
end;

{******************************************************************************}
procedure TFContratosSemLeitura.AdicionaFiltros(VpaSelect: TStrings);
begin
  if EVendedor.AInteiro <> 0 then
    VpaSelect.Add(' AND CON.CODVENDEDOR = '+EVendedor.Text);
  if ECliente.AInteiro <> 0 then
    VpaSelect.Add(' AND CON.CODCLIENTE = '+ECliente.Text);

  if ECodTipoContrato.AInteiro <> 0 then
    VpaSelect.add(' and CON.CODTIPOCONTRATO = '+ECodTipoContrato.Text);
  VpaSelect.add('and not exists(Select * from LEITURALOCACAOCORPO LEI '+
                ' Where LEI.CODFILIAL = CON.CODFILIAL '+
                ' AND LEI.SEQCONTRATO = CON.SEQCONTRATO '+
                ' AND LEI.CODCLIENTE = CON.CODCLIENTE '+
                SQLTextoDataEntreAAAAMMDD('LEI.DATLEITURA',EDatInicio.DateTime,EDatFim.DateTime,true)+
                ')');
  if ETecnico.AInteiro <> 0 then
    VpaSelect.Add(' AND CON.CODTECNICOLEITURA = '+ETecnico.Text);                
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


procedure TFContratosSemLeitura.ECodTipoContratoFimConsulta(
  Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFContratosSemLeitura.BEnviarSelecionadoClick(Sender: TObject);
var
  VpfResultado : String;
begin
  if ContratosSemLeituraCODFILIAL.AsInteger <> 0 then
  begin
    VpfResultado := FunContrato.EnviaMedidorEmail(ContratosSemLeituraCODFILIAL.AsInteger,ContratosSemLeituraSEQCONTRATO.AsInteger);
    if VpfResultado <> '' then
      aviso(VpfResultado);
  end;
end;

{******************************************************************************}
procedure TFContratosSemLeitura.BEnviarTodosClick(Sender: TObject);
begin
  if ContratosSemLeituraCODFILIAL.AsInteger <> 0 then
  begin
    FNovoEmailMedidores := TFNovoEmailMedidores.Create(Application);
    FNovoEmailMedidores.EnviaEmailsContratos(ContratosSemLeitura.SQL);
    FNovoEmailMedidores.Free;
  end;
end;

{******************************************************************************}
procedure TFContratosSemLeitura.BFecharClick(Sender: TObject);
begin
  close;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFContratosSemLeitura]);
end.
