unit AConsultaCodigoRepresentante;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Grids, DBGrids, Tabela, Componentes1, ExtCtrls,
  PainelGradiente, DB, DBClient, ConstMsg;

type
  TFConsultaCodigoRepresentante = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Label1: TLabel;
    Label2: TLabel;
    GClientes: TDBGridColor;
    GPedidos: TDBGridColor;
    BExcluirCliente: TBitBtn;
    BExcluirPedido: TBitBtn;
    BFechar: TBitBtn;
    dsCadClientes: TDataSource;
    dsCadOrcamentos: TDataSource;
    CADCLIENTES: TSQL;
    CADORCAMENTOS: TSQL;
    CADORCAMENTOSCODFILIAL: TFMTBCDField;
    CADORCAMENTOSNUMPEDIDO: TFMTBCDField;
    CADCLIENTESCODCLIENTE: TFMTBCDField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BExcluirPedidoClick(Sender: TObject);
    procedure BExcluirClienteClick(Sender: TObject);
  private
    { Private declarations }
    procedure AbreTabela;
    procedure ExcluiCliente;
    procedure ExcluiPedido;
  public
    { Public declarations }
  end;

var
  FConsultaCodigoRepresentante: TFConsultaCodigoRepresentante;

implementation

uses APrincipal;

{$R *.DFM}


{ **************************************************************************** }
procedure TFConsultaCodigoRepresentante.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  AbreTabela;
end;

{ *************************************************************************** }
procedure TFConsultaCodigoRepresentante.AbreTabela;
begin
  CADORCAMENTOS.Open;
  CADCLIENTES.Open;
  BExcluirCliente.Enabled := not CADCLIENTES.Eof;
  BExcluirPedido.Enabled  := not CADORCAMENTOS.Eof;
end;

{ *************************************************************************** }
procedure TFConsultaCodigoRepresentante.BExcluirClienteClick(Sender: TObject);
begin
  ExcluiCliente;
end;

{ *************************************************************************** }
procedure TFConsultaCodigoRepresentante.BExcluirPedidoClick(Sender: TObject);
begin
  ExcluiPedido;
end;

{ *************************************************************************** }
procedure TFConsultaCodigoRepresentante.BFecharClick(Sender: TObject);
begin
  close;
end;

{ *************************************************************************** }
procedure TFConsultaCodigoRepresentante.ExcluiCliente;
begin
  CADCLIENTES.Delete;
end;

{ *************************************************************************** }
procedure TFConsultaCodigoRepresentante.ExcluiPedido;
begin
  CADORCAMENTOS.Delete;
end;

{ *************************************************************************** }
procedure TFConsultaCodigoRepresentante.FormClose(Sender: TObject; var Action: TCloseAction);
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
 RegisterClasses([TFConsultaCodigoRepresentante]);
end.
