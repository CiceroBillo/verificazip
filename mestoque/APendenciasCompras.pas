unit APendenciasCompras;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Grids, DBGrids, Tabela, DBKeyViolation, Componentes1,
  ExtCtrls, PainelGradiente, Db, DBTables, Menus, UnPedidoCompra, DBClient;

type
  TFPendenciasCompras = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    GridIndice1: TGridIndice;
    BFechar: TBitBtn;
    PendenciaCompra: TSQL;
    PendenciaCompraDATPEDIDO: TSQLTimeStampField;
    PendenciaCompraCODFILIAL: TFMTBCDField;
    PendenciaCompraSEQPEDIDO: TFMTBCDField;
    PendenciaCompraDATPREVISTA: TSQLTimeStampField;
    PendenciaCompraDATRENEGOCIADO: TSQLTimeStampField;
    PendenciaCompraDATPENDENCIA: TSQLTimeStampField;
    PendenciaCompraC_NOM_CLI: TWideStringField;
    PendenciaCompraNOMCOMPRADOR: TWideStringField;
    DataPendenciaCompra: TDataSource;
    PopupMenu1: TPopupMenu;
    ConcluirPendncia1: TMenuItem;
    PendenciaCompraSEQPENDENCIA: TFMTBCDField;
    N1: TMenuItem;
    ConsultaPedidoCompra1: TMenuItem;
    N2: TMenuItem;
    Agendamento1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure ConcluirPendncia1Click(Sender: TObject);
    procedure ConsultaPedidoCompra1Click(Sender: TObject);
    procedure Agendamento1Click(Sender: TObject);
  private
    { Private declarations }
    FunPedidoCompra : TRBFunPedidoCompra;
    procedure AtualizaConsulta;
  public
    { Public declarations }
  end;

var
  FPendenciasCompras: TFPendenciasCompras;

implementation

uses APrincipal,ConstMsg, ANovoPedidoCompra, ANovoAgendamento, Constantes;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFPendenciasCompras.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunPedidoCompra := TRBFunPedidoCompra.cria(FPrincipal.BaseDados);
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFPendenciasCompras.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunPedidoCompra.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFPendenciasCompras.AtualizaConsulta;
begin
  PendenciaCompra.close;
  PendenciaCompra.sql.clear;
  PendenciaCompra.sql.add('select PED.DATPEDIDO, PED.CODFILIAL, PED.SEQPEDIDO, PED.DATPREVISTA, '+
                          ' PED.DATRENEGOCIADO, '+
                          ' PEN.DATPENDENCIA, PEN.SEQPENDENCIA, '+
                          ' CLI.C_NOM_CLI, '+
                          ' COM.NOMCOMPRADOR '+
                          ' from PENDENCIACOMPRA PEN, PEDIDOCOMPRACORPO PED, CADCLIENTES CLI, COMPRADOR COM '+
                          ' WHERE PEN.CODFILIAL = PED.CODFILIAL '+
                          ' AND PEN.SEQPEDIDO = PED.SEQPEDIDO '+
                          ' AND PED.CODCLIENTE = CLI.I_COD_CLI '+
                          ' AND PED.CODCOMPRADOR = COM.CODCOMPRADOR '+
                          ' AND PEN.DATCONCLUSAO IS NULL'+
                          ' ORDER BY PEN.DATPENDENCIA');
  PendenciaCompra.Open;
end;

{******************************************************************************}
procedure TFPendenciasCompras.BFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFPendenciasCompras.ConcluirPendncia1Click(Sender: TObject);
var
  VpfResultado : string;
begin
  if PendenciaCompraCODFILIAL.AsInteger <> 0 then
  begin
    VpfResultado := FunPedidoCompra.ConcluiPendenciaCompras(PendenciaCompraCODFILIAL.AsInteger,PendenciaCompraSEQPEDIDO.AsInteger,PendenciaCompraSEQPENDENCIA.AsInteger);
    if vpfresultado <> '' then
      aviso(VpfREsultado)
    else
      AtualizaConsulta;
  end;
end;

{******************************************************************************}
procedure TFPendenciasCompras.ConsultaPedidoCompra1Click(Sender: TObject);
begin
  if PendenciaCompraSEQPEDIDO.AsInteger <> 0 then
  begin
    FNovoPedidoCompra := TFNovoPedidoCompra.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoPedidoCompra'));
    FNovoPedidoCompra.Consultar(PendenciaCompraCODFILIAL.AsInteger,PendenciaCompraSEQPEDIDO.AsInteger);
    FNovoPedidoCompra.free; 
  end;
end;

{******************************************************************************}
procedure TFPendenciasCompras.Agendamento1Click(Sender: TObject);
begin
  FNovoAgedamento := TFNovoAgedamento.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoAgedamento'));
  FNovoAgedamento.NovaAgendaPedidoCompra(varia.CodigoUsuario,PendenciaCompraCODFILIAL.AsInteger,PendenciaCompraSEQPEDIDO.AsInteger);
  FNovoAgedamento.free;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFPendenciasCompras]);
end.
