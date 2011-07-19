unit AnovoClientePerdidoVendedor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Localizacao, StdCtrls, Buttons,
  Mask, numericos, UnDados, Constantes, DBKeyViolation;

type
  TFNovoClientePerdidoVendedor = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BOK: TBitBtn;
    BCancelar: TBitBtn;
    Localiza: TConsultaPadrao;
    Label11: TLabel;
    SpeedButton4: TSpeedButton;
    LNomVendedor: TLabel;
    EVendedor: TEditLocaliza;
    EQtdDias: Tnumerico;
    Label1: TLabel;
    ValidaGravacao1: TValidaGravacao;
    Label2: TLabel;
    EQtdDiasComPedido: Tnumerico;
    ERegiaoVendas: TRBEditLocaliza;
    SpeedButton1: TSpeedButton;
    Label3: TLabel;
    Label4: TLabel;
    CCliente: TCheckBox;
    CProspect: TCheckBox;
    Label5: TLabel;
    EQtdDiasSemTelemarketing: Tnumerico;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
    procedure EQtdDiasChange(Sender: TObject);
    procedure BOKClick(Sender: TObject);
  private
    { Private declarations }
    VprDClientesPerdidos : TRBDClientePerdidoVendedor;
    VprAcao : Boolean;
    VprOperacaoCadastro : TRBDOperacaoCadastro;
    procedure InicializaTela;
    procedure CarDClasse;
  public
    { Public declarations }
    Function NovoClientePerdidoVendedor : Boolean;
  end;

var
  FNovoClientePerdidoVendedor: TFNovoClientePerdidoVendedor;

implementation

uses APrincipal,  funObjeto, ConstMsg, UnClientes;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovoClientePerdidoVendedor.FormCreate(Sender: TObject);
begin
  VprAcao := false;
  VprDClientesPerdidos := TRBDClientePerdidoVendedor.cria;
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovoClientePerdidoVendedor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  VprDClientesPerdidos.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFNovoClientePerdidoVendedor.InicializaTela;
begin
  VprDClientesPerdidos.free;
  VprDClientesPerdidos := TRBDClientePerdidoVendedor.cria;
  VprDClientesPerdidos.CodUsuario := varia.CodigoUsuario;
  VprDClientesPerdidos.DatPerdido := now;
  LimpaComponentes(PanelColor1,0);
  EQtdDias.AsInteger := 90;
  CCliente.Checked := true;
  CProspect.Checked := true;
end;

{******************************************************************************}
procedure TFNovoClientePerdidoVendedor.CarDClasse;
begin
  VprDClientesPerdidos.CodVendedorDestino := EVendedor.AInteiro;
  VprDClientesPerdidos.QtdDiasSemPedido := EQtdDias.AsInteger;
  VprDClientesPerdidos.QtdDiasComPedido := EQtdDiasComPedido.AsInteger;
  VprDClientesPerdidos.QtdDiasSemTelemarketing := EQtdDiasSemTelemarketing.AsInteger;
  VprDClientesPerdidos.CodRegiaoVendas := ERegiaoVendas.AInteiro;
  VprDClientesPerdidos.QtdDiasSemTelemarketing := EQtdDiasSemTelemarketing.AsInteger;
  VprDClientesPerdidos.IndCliente := CCliente.Checked;
  VprDClientesPerdidos.IndProspect := CProspect.Checked;
end;

{******************************************************************************}
Function TFNovoClientePerdidoVendedor.NovoClientePerdidoVendedor : Boolean;
begin
  InicializaTela;
  VprOperacaoCadastro := ocInsercao;
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
procedure TFNovoClientePerdidoVendedor.BCancelarClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFNovoClientePerdidoVendedor.EQtdDiasChange(Sender: TObject);
begin
  if (VprOperacaoCadastro in [ocInsercao,ocEdicao]) then
    ValidaGravacao1.execute;
end;

procedure TFNovoClientePerdidoVendedor.BOKClick(Sender: TObject);
var
  VpfResultado : String;
begin
  CarDClasse;
  VpfResultado := FunClientes.GravaDClientePerdido(VprDClientesPerdidos);
  if VpfResultado = '' then
  begin
    VprAcao := true;
    close;
  end
  else
    aviso(VpfREsultado);
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovoClientePerdidoVendedor]);
end.
