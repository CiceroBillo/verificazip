unit AExportacaoDados;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios, ComCtrls, StdCtrls, Buttons,
  Gauges, Componentes1, ExtCtrls, PainelGradiente, UnImportacaoDados, UnExportacaoDados, Undados;

type
  TFExportacaoDados = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    Label1: TLabel;
    LQtd: TLabel;
    Label2: TLabel;
    LNomTabela: TLabel;
    Label3: TLabel;
    LHoraInicio: TLabel;
    Label4: TLabel;
    LHoraFim: TLabel;
    GroupBox1: TGroupBox;
    PTabelas: TGauge;
    PRegistros: TProgressBar;
    BExportacaoTotal: TBitBtn;
    PanelColor2: TPanelColor;
    BFechar: TBitBtn;
    Animate1: TAnimate;
    Label5: TLabel;
    LProcesso: TLabel;
    BMenuFiscal: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BExportacaoTotalClick(Sender: TObject);
    procedure BMenuFiscalClick(Sender: TObject);
  private
    { Private declarations }
    VprRegistrosExportados : Integer;
    VprDExportacaoDados : TRBDExportacaoDados;
    FunImportacaoDados : TRBFuncoesImportacaoDado;
    FunExportacaoDados : TRBFuncoesExportacaoDados;
    procedure ConfiguraPermissaoUsuario;
    procedure ExportacaoTotal;
    procedure ExportaClientes;
    procedure ExportaPedidos;
    procedure ExportaNotaFiscal;
    procedure ExportaContasaReceber;
    procedure ExportaComissao;
    procedure AtualizaNomeTabelaExportar(VpaNomeTabela : string);
  public
    { Public declarations }
  end;

var
  FExportacaoDados: TFExportacaoDados;

implementation

uses APrincipal, Funstring, AMostraErrosExportacaoDados, AMostraPedidosEClientesExportados, AMenuFiscalECF, FunObjeto;

{$R *.DFM}


{ **************************************************************************** }
procedure TFExportacaoDados.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  ConfiguraPermissaoUsuario;
  FunImportacaoDados := TRBFuncoesImportacaoDado.cria(FPrincipal.BaseDados, FPrincipal.BaseDadosMatriz,LQtd,PRegistros);
  FunExportacaoDados :=TRBFuncoesExportacaoDados.cria(FPrincipal.BaseDados, FPrincipal.BaseDadosMatriz,LProcesso, LQtd,PRegistros);
  VprDExportacaoDados := TRBDExportacaoDados.cria;
end;

{ *************************************************************************** }
procedure TFExportacaoDados.AtualizaNomeTabelaExportar(VpaNomeTabela: string);
begin
  LNomTabela.Caption := AdicionaCharD(' ',VpaNomeTabela,50);
  LNomTabela.Refresh;
  PRegistros.Position := 0;
  VprRegistrosExportados := 0;
end;

{ *************************************************************************** }
procedure TFExportacaoDados.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFExportacaoDados.BMenuFiscalClick(Sender: TObject);
begin
  FMenuFiscalECF := TFMenuFiscalECF.CriarSDI(self,'',true);
  FMenuFiscalECF.ShowModal;
  FMenuFiscalECF.Free;
end;

{******************************************************************************}
procedure TFExportacaoDados.ConfiguraPermissaoUsuario;
begin
  BMenuFiscal.Visible := NomeModulo ='PDV';
end;

{******************************************************************************}
procedure TFExportacaoDados.BExportacaoTotalClick(Sender: TObject);
begin
  ExportacaoTotal;
end;

{ *************************************************************************** }
procedure TFExportacaoDados.ExportacaoTotal;
begin
  VprDExportacaoDados.Free;
  VprDExportacaoDados := TRBDExportacaoDados.cria;
  VprDExportacaoDados.DatExportacao := FunImportacaoDados.RDataServidorMatriz;

  LHoraInicio.Caption := FormatDateTime('DD/MM/YYYY HH:MM:SS',VprDExportacaoDados.DatExportacao);
  LHoraInicio.Refresh;


  PTabelas.Progress := 0;
  PTabelas.MaxValue := 5;
  ExportaClientes;
  ExportaPedidos;
  ExportaNotaFiscal;
  ExportaContasaReceber;
  ExportaComissao;

  AtualizaNomeTabelaExportar('Exportação finalizada com sucesso');
  LProcesso.Caption := '';
  LHoraFim.Caption := FormatDateTime('DD/MM/YYYY HH:MM:SS',FunImportacaoDados.RDataServidorMatriz);
  if VprDExportacaoDados.ErrosExportacao.Count > 0 then
  begin
    FMostraErrosExportacaoDados := TFMostraErrosExportacaoDados.CriarSDI(self,'',true);
    FMostraErrosExportacaoDados.MostraErro(VprDExportacaoDados);
    FMostraErrosExportacaoDados.Free;
  end;
  FMostraPedidosEClientesExportados := TFMostraPedidosEClientesExportados.criarSDI(self,'',true);
  FMostraPedidosEClientesExportados.MostraPedidoEClienteExportado(VprDExportacaoDados);
  FMostraPedidosEClientesExportados.Free;
end;

{ *************************************************************************** }
procedure TFExportacaoDados.ExportaClientes;
begin
  AtualizaNomeTabelaExportar('Clientes');
  FunExportacaoDados.ExportaCliente(VprDExportacaoDados);
  PTabelas.Progress := PTabelas.Progress + 1;
end;

{******************************************************************************}
procedure TFExportacaoDados.ExportaComissao;
begin
  AtualizaNomeTabelaExportar('Contas a Receber');
  FunExportacaoDados.ExportaComissao(VprDExportacaoDados);
  PTabelas.Progress := PTabelas.Progress + 1;
end;

{******************************************************************************}
procedure TFExportacaoDados.ExportaContasaReceber;
begin
  AtualizaNomeTabelaExportar('Contas a Receber');
  FunExportacaoDados.ExportaContasaReceber(VprDExportacaoDados);
  PTabelas.Progress := PTabelas.Progress + 1;
end;

{******************************************************************************}
procedure TFExportacaoDados.ExportaNotaFiscal;
begin
  AtualizaNomeTabelaExportar('Notas Fiscais');
  FunExportacaoDados.ExportaNotaFiscal(VprDExportacaoDados);
  PTabelas.Progress := PTabelas.Progress + 1;
end;

{ *************************************************************************** }
procedure TFExportacaoDados.ExportaPedidos;
begin
  AtualizaNomeTabelaExportar('Pedidos');
  FunExportacaoDados.ExportaPedido(VprDExportacaoDados);
  PTabelas.Progress := PTabelas.Progress + 1;
end;

{ *************************************************************************** }
procedure TFExportacaoDados.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunImportacaoDados.Free;
  FunExportacaoDados.Free;
  VprDExportacaoDados.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFExportacaoDados]);
end.
