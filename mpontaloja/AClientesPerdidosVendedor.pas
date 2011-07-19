unit AClientesPerdidosVendedor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ComCtrls, Componentes1, StdCtrls, Grids, DBGrids, Tabela, DBKeyViolation,
  ExtCtrls, PainelGradiente, Db, DBTables, Buttons, DBClient;

type
  TFClientesPerdidosVenedor = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    GridIndice1: TGridIndice;
    Label1: TLabel;
    Label2: TLabel;
    EDatInicial: TCalendario;
    EDatFinal: TCalendario;
    ClientePerdido: TSQL;
    DataClientePerdido: TDataSource;
    ClientePerdidoSEQPERDIDO: TFMTBCDField;
    ClientePerdidoDATPERDIDO: TSQLTimeStampField;
    ClientePerdidoQTDDIA: TFMTBCDField;
    ClientePerdidoC_NOM_USU: TWideStringField;
    ClientePerdidoC_NOM_VEN: TWideStringField;
    BCadastrar: TBitBtn;
    BFechar: TBitBtn;
    BImpVendedores: TBitBtn;
    BImpClientes: TBitBtn;
    ClientePerdidoQTDDIASSEMTELEMARKETING: TFMTBCDField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BCadastrarClick(Sender: TObject);
    procedure EDatInicialCloseUp(Sender: TObject);
    procedure BImpVendedoresClick(Sender: TObject);
    procedure BImpClientesClick(Sender: TObject);
  private
    { Private declarations }
    VprOrdem : string;
    procedure InicializaTela;
    procedure AtualizaConsulta;
    procedure AdicionaFiltros(VpaSelect : TStrings);
  public
    { Public declarations }
  end;

var
  FClientesPerdidosVenedor: TFClientesPerdidosVenedor;

implementation

uses APrincipal, FunData, AnovoClientePerdidoVendedor, FunSql, unCrystal, Constantes, dmRave;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFClientesPerdidosVenedor.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprOrdem := 'order by PER.SEQPERDIDO';
  InicializaTela;
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFClientesPerdidosVenedor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  ClientePerdido.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFClientesPerdidosVenedor.InicializaTela;
begin
  EDatInicial.DateTime := PrimeiroDiaMes(date);
  EDatFinal.DateTime := UltimoDiaMes(date);
end;

{******************************************************************************}
procedure TFClientesPerdidosVenedor.AtualizaConsulta;
begin
  ClientePerdido.close;
  ClientePerdido.sql.clear;
  ClientePerdido.sql.add('Select PER.SEQPERDIDO,  PER.DATPERDIDO, PER.QTDDIA, '+
                         '  PER.QTDDIASSEMTELEMARKETING, ' +
                         ' USU.C_NOM_USU, '+
                         ' VEN.C_NOM_VEN '+
                         ' FROM CLIENTEPERDIDOVENDEDOR PER, CADUSUARIOS USU, '+
                         ' CADVENDEDORES VEN '+
                         ' Where USU.I_COD_USU = PER.CODUSUARIO '+
                         ' and VEN.I_COD_VEN = PER.CODVENDEDORDESTINO ');
  AdicionaFiltros(ClientePerdido.SQL);
  ClientePerdido.SQL.Add(VprOrdem);
  ClientePerdido.open;
end;

{******************************************************************************}
procedure TFClientesPerdidosVenedor.AdicionaFiltros(VpaSelect : TStrings);
begin
  SQLTextoDataEntreAAAAMMDD('PER.DATPERDIDO',EDatInicial.DateTime,IncDia(EDatFinal.DateTime,1),true);
end;

{******************************************************************************}
procedure TFClientesPerdidosVenedor.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFClientesPerdidosVenedor.BCadastrarClick(Sender: TObject);
begin
  FNovoClientePerdidoVendedor := TFNovoClientePerdidoVendedor.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoClientePerdidoVendedor'));
  if FNovoClientePerdidoVendedor.NovoClientePerdidoVendedor then
    AtualizaConsulta;
  FNovoClientePerdidoVendedor.free;
end;

{******************************************************************************}
procedure TFClientesPerdidosVenedor.EDatInicialCloseUp(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFClientesPerdidosVenedor.BImpVendedoresClick(Sender: TObject);
begin
  if ClientePerdidoSEQPERDIDO.AsInteger <> 0 then
  begin
    dtRave := TdtRave.Create(self);
    dtRave.ImprimeClientesPerdidosPorVendedor(ClientePerdidoSEQPERDIDO.AsInteger);
    dtRave.Free;
  end;
end;

{******************************************************************************}
procedure TFClientesPerdidosVenedor.BImpClientesClick(Sender: TObject);
begin
  if ClientePerdidoSEQPERDIDO.AsInteger <> 0 then
  begin
    dtRave := TdtRave.Create(self);
    dtRave.ImprimeClientesPerdidosClientes(ClientePerdidoSEQPERDIDO.AsInteger);
    dtRave.Free;
  end;

end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFClientesPerdidosVenedor]);
end.
