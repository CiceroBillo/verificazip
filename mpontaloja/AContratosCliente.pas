unit AContratosCliente;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Db, DBTables, StdCtrls, Buttons, Grids, DBGrids, Tabela, DBKeyViolation, UnDados,
  Componentes1, ExtCtrls, PainelGradiente, Uncontrato, DBClient;

type
  TFContratosCliente = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    GridIndice1: TGridIndice;
    BCadastrar: TBitBtn;
    BAlterar: TBitBtn;
    BConsultar: TBitBtn;
    BExcluir: TBitBtn;
    BFechar: TBitBtn;
    Contratos: TSQL;
    ContratosNUMCONTRATO: TWideStringField;
    ContratosVALCONTRATO: TFMTBCDField;
    ContratosDATASSINATURA: TSQLTimeStampField;
    ContratosDATCANCELAMENTO: TSQLTimeStampField;
    ContratosQTDFRANQUIA: TFMTBCDField;
    ContratosNOMTIPOCONTRATO: TWideStringField;
    DataContratos: TDataSource;
    ContratosCODFILIAL: TFMTBCDField;
    ContratosSEQCONTRATO: TFMTBCDField;
    ContratosDATULTIMAEXECUCAO: TSQLTimeStampField;
    BReprocessar: TBitBtn;
    ContratosTIPPERIODO: TFMTBCDField;
    PanelColor3: TPanelColor;
    Label22: TLabel;
    Shape1: TShape;
    PanelColor2: TPanelColor;
    BFaturar: TBitBtn;
    ContratosDATINICIOVIGENCIA: TSQLTimeStampField;
    ContratosDATFIMVIGENCIA: TSQLTimeStampField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BCadastrarClick(Sender: TObject);
    procedure BAlterarClick(Sender: TObject);
    procedure BConsultarClick(Sender: TObject);
    procedure BExcluirClick(Sender: TObject);
    procedure BReprocessarClick(Sender: TObject);
    procedure GridIndice1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure BFaturarClick(Sender: TObject);
  private
    { Private declarations }
    VprCodCliente : Integer;
    FunContrato : TRBFuncoesContrato;
    procedure ConfiguraPermissaoUsuario;
    procedure AtualizaConsulta;
    function ContratoCancelado: Boolean;
  public
    { Public declarations }
    procedure ContratosCliente(VpaCodCliente : Integer);
  end;

var
  FContratosCliente: TFContratosCliente;

implementation

uses APrincipal, ANovoContratoCliente, ConstMsg,Constantes, FunSql,FunData,
  ANovaNotaFiscalNota;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFContratosCliente.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunContrato := TRBFuncoesContrato.cria(FPrincipal.BaseDados);
  ConfiguraPermissaoUsuario;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFContratosCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunContrato.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
procedure TFContratosCliente.ConfiguraPermissaoUsuario;
begin
  if not((puAdministrador in varia.PermissoesUsuario) or (puPLCompleto in varia.PermissoesUsuario)) then
  begin
    BAlterar.Visible:= False;
    if (puVendedorAlteraContrato in Varia.PermissoesUsuario) then
      BAlterar.Visible:= True;
  end;
end;

{******************************************************************************}
procedure TFContratosCliente.AtualizaConsulta;
begin
  Contratos.close;
  Contratos.Sql.Clear;
  Contratos.Sql.add('Select CON.CODFILIAL, CON.SEQCONTRATO, CON.TIPPERIODO, CON.DATINICIOVIGENCIA, '+
                    ' CON.DATFIMVIGENCIA,'+
                    ' CON.NUMCONTRATO, CON.VALCONTRATO, CON.DATASSINATURA,  '+
                    ' CON.DATCANCELAMENTO, QTDFRANQUIA, CON.DATULTIMAEXECUCAO, '+
                    ' TIP.NOMTIPOCONTRATO '+
                    ' from CONTRATOCORPO CON, TIPOCONTRATO TIP '+
                    ' Where CON.CODTIPOCONTRATO = TIP.CODTIPOCONTRATO '+
                    ' AND CON.CODCLIENTE = '+IntToStr(VprCodCliente));
  Contratos.open;
end;

{******************************************************************************}
procedure TFContratosCliente.ContratosCliente(VpaCodCliente : Integer);
begin
  VprCodCliente := VpaCodCliente;
  AtualizaConsulta;
  Showmodal;
end;

{******************************************************************************}
procedure TFContratosCliente.BFaturarClick(Sender: TObject);
var
  VpfDContrato : TRBDContratoCorpo;
begin
  if ContratosSEQCONTRATO.AsInteger <> 0 then
  begin
    VpfDContrato := TRBDContratoCorpo.cria;
    FunContrato.CarDContrato(VpfDContrato,ContratosCODFILIAL.AsInteger,ContratosSEQCONTRATO.AsInteger);
    FNovaNotaFiscalNota := TFNovaNotaFiscalNota.criarSDI(Application,'',FPrincipal.VerificaPermisao('FNovaNotaFiscalNota'));
    FNovaNotaFiscalNota.GeraNotaContratoDireto(VpfDContrato);
    FNovaNotaFiscalNota.free;
  end;
end;

{******************************************************************************}
procedure TFContratosCliente.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFContratosCliente.BCadastrarClick(Sender: TObject);
begin
  FNovoContratoCliente := TFNovoContratoCliente.CriarSDI(application,'', FPrincipal.VerificaPermisao('FNovoContratoCliente'));
  FNovoContratoCliente.NovoContrato(VprCodCliente);
  FNovoContratoCliente.free;
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFContratosCliente.BAlterarClick(Sender: TObject);
var
  VpfDContrato : TRBDContratoCorpo;
begin
  if FunContrato.ExisteContratoLocacaoEmAberto(ContratosCODFILIAL.AsInteger,ContratosSEQCONTRATO.AsInteger) then
    aviso('NÃO É POSSÍVEL ALTERAR O CONTRATO!!!'#13'Existe uma leitura de locação em aberto, é necessário processá-la ou excluí-la.')
  else
  begin
    VpfDContrato := TRBDContratoCorpo.Cria;
    FunContrato.CarDContrato(VpfDContrato,ContratosCODFILIAL.AsInteger,ContratosSEQCONTRATO.AsInteger);
    FNovoContratoCliente := TFNovoContratoCliente.CriarSDI(application,'', FPrincipal.VerificaPermisao('FNovoContratoCliente'));
    FNovoContratoCliente.AlteraContrato(VpfDContrato);
    FNovoContratoCliente.free;
    AtualizaConsulta;
  end;
end;

{******************************************************************************}
procedure TFContratosCliente.BConsultarClick(Sender: TObject);
var
  VpfDContrato : TRBDContratoCorpo;
begin
  VpfDContrato := TRBDContratoCorpo.Cria;
  FunContrato.CarDContrato(VpfDContrato,ContratosCODFILIAL.AsInteger,ContratosSEQCONTRATO.AsInteger);
  FNovoContratoCliente := TFNovoContratoCliente.CriarSDI(application,'', FPrincipal.VerificaPermisao('FNovoContratoCliente'));
  FNovoContratoCliente.ConsultaContrato(VpfDContrato);
  FNovoContratoCliente.free;
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFContratosCliente.BExcluirClick(Sender: TObject);
begin
  if Confirmacao(CT_DeletaRegistro) then
  begin
    FunContrato.ExcluiContrato(ContratosCODFILIAL.AsInteger,ContratosSEQCONTRATO.AsInteger);
    AtualizaConsulta;
  end;
end;

{******************************************************************************}
procedure TFContratosCliente.BReprocessarClick(Sender: TObject);
begin
  IF ContratosCODFILIAL.AsInteger <> 0 then
  begin
    if confirmacao('Tem certeza que deseja reprocessar o contrato ?')then
      FunContrato.SetaContratoAReprocessar(ContratosCODFILIAL.AsInteger,ContratosSEQCONTRATO.AsInteger,ContratosTIPPERIODO.AsInteger,ContratosDATULTIMAEXECUCAO.AsDateTime);
  end;
end;

{******************************************************************************}
procedure TFContratosCliente.GridIndice1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if ContratoCancelado then
  begin
    GridIndice1.Canvas.Brush.Color:= clred;
    GridIndice1.Canvas.Font.Color:= clWhite;
    GridIndice1.DefaultDrawDataCell(Rect, GridIndice1.Columns[DataCol].Field, State);
  end;
end;

{******************************************************************************}
function TFContratosCliente.ContratoCancelado: Boolean;
begin
  Result:= (ContratosDATCANCELAMENTO.AsDateTime > MontaData(1,1,1950));
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFContratosCliente]);
end.

