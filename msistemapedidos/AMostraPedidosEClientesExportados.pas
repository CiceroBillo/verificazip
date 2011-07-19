unit AMostraPedidosEClientesExportados;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, PainelGradiente, StdCtrls, Buttons, Componentes1, UnDados;

type
  TFMostraPedidosEClientesExportados = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BitBtn1: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    MClientes: TMemoColor;
    MPedidos: TMemoColor;
    MNotaFiscal: TMemoColor;
    Label3: TLabel;
    MContasAReceber: TMemoColor;
    Label4: TLabel;
    Label5: TLabel;
    MComissao: TMemoColor;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure MostraPedidoEClienteExportado(VpaDExportacao: TRBDExportacaoDados);
  end;

var
  FMostraPedidosEClientesExportados: TFMostraPedidosEClientesExportados;

implementation

uses APrincipal;

{$R *.DFM}


{ **************************************************************************** }
procedure TFMostraPedidosEClientesExportados.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

{ *************************************************************************** }
procedure TFMostraPedidosEClientesExportados.MostraPedidoEClienteExportado(VpaDExportacao: TRBDExportacaoDados);
begin
  MClientes.Lines.Text := VpaDExportacao.ClientesExportados.Text;
  MPedidos.Lines.Text  := VpaDExportacao.PedidosExportados.Text;
  MNotaFiscal.Lines.Text := VpaDExportacao.NotasExportadas.Text;
  MContasAReceber.Lines.Text := VpaDExportacao.ContasaReceberExportados.Text;
  MComissao.Lines.Text := VpaDExportacao.ComissaoExportada.Text;
  ShowModal;
end;

{ *************************************************************************** }
procedure TFMostraPedidosEClientesExportados.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

{ *************************************************************************** }
procedure TFMostraPedidosEClientesExportados.FormClose(Sender: TObject; var Action: TCloseAction);
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
 RegisterClasses([TFMostraPedidosEClientesExportados]);
end.
