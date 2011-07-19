unit ASelecionarFornecedorMapaCompras;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios, StdCtrls, Buttons,
  Componentes1, ExtCtrls, PainelGradiente, UnDadosProduto;

type
  TFSelecionaFornecedorMapaCompras = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    EFornecedor: TComboBoxColor;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BGravarClick(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
  private
    { Private declarations }
    VprAcao : Boolean;
    procedure CarFornecedoreComboBox(VpaOrcamentoCompra : TRBDOrcamentoCompraCorpo);
  public
    { Public declarations }
    function SelecionarFornecedor(VpaDOrcamentoCompra : TRBDOrcamentoCompraCorpo):Integer;
  end;

var
  FSelecionaFornecedorMapaCompras: TFSelecionaFornecedorMapaCompras;

implementation

uses APrincipal;

{$R *.DFM}


{ **************************************************************************** }
procedure TFSelecionaFornecedorMapaCompras.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao := false;
end;

{******************************************************************************}
function TFSelecionaFornecedorMapaCompras.SelecionarFornecedor(VpaDOrcamentoCompra: TRBDOrcamentoCompraCorpo): Integer;
begin
  result := 0;
  CarFornecedoreComboBox(VpaDOrcamentoCompra);
  Showmodal;
  if VprAcao and (EFornecedor.ItemIndex >= 0)  then
  begin
    result := TRBDOrcamentoCompraFornecedor(VpaDOrcamentoCompra.Fornecedores.Items[EFornecedor.ItemIndex]).CodFornecedor;
  end;
end;

{ *************************************************************************** }
procedure TFSelecionaFornecedorMapaCompras.BCancelarClick(Sender: TObject);
begin
  VprAcao := false;
  Close;
end;

procedure TFSelecionaFornecedorMapaCompras.BGravarClick(Sender: TObject);
begin
  vprAcao := true;
  close;
end;

{******************************************************************************}
procedure TFSelecionaFornecedorMapaCompras.CarFornecedoreComboBox(VpaOrcamentoCompra: TRBDOrcamentoCompraCorpo);
var
  VpfLaco : Integer;
  VpfDFornecedor : TRBDOrcamentoCompraFornecedor;
begin
  EFornecedor.Items.Clear;
  for VpfLaco := 0 to VpaOrcamentoCompra.Fornecedores.Count - 1 do
  begin
    VpfDFornecedor := TRBDOrcamentoCompraFornecedor(VpaOrcamentoCompra.Fornecedores.Items[VpfLaco]);
    EFornecedor.Items.Add(IntTostr(VpfDFornecedor.CodFornecedor)+'-'+VpfDFornecedor.NomFornecedor);
  end;
end;

{******************************************************************************}
procedure TFSelecionaFornecedorMapaCompras.FormClose(Sender: TObject; var Action: TCloseAction);
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
 RegisterClasses([TFSelecionaFornecedorMapaCompras]);
end.
