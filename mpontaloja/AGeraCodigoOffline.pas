unit AGeraCodigoOffline;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, PainelGradiente, StdCtrls, Buttons, ComCtrls, Gauges, Componentes1;

type
  TFGeraCodigoOffline = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    Label2: TLabel;
    LNomTabela: TLabel;
    GroupBox1: TGroupBox;
    PTabelas: TGauge;
    PRegistros: TProgressBar;
    BGerarCodigos: TBitBtn;
    LGerando: TLabel;
    BFechar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BGerarCodigosClick(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FGeraCodigoOffline: TFGeraCodigoOffline;

implementation

uses UnSistema, APrincipal, ConstMsg, UnClientes;

{$R *.DFM}


{ **************************************************************************** }
procedure TFGeraCodigoOffline.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

{ *************************************************************************** }
procedure TFGeraCodigoOffline.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFGeraCodigoOffline.BGerarCodigosClick(Sender: TObject);
var
  VpfQtdFilial: integer;
begin
  VpfQtdFilial:= Sistema.RQtdFilial;
  Ptabelas.MaxValue:= ((4*VpfQtdFilial)+1);
  FunClientes.GeraCodigosClientes(PRegistros, LGerando);
  PRegistros.Position:= 0;
  PTabelas.Progress:= PTabelas.Progress + 1;
  SISTEMA.GeraNumeroPedidos(PRegistros, LGerando, PTabelas);
  Sistema.GeraSequenciasNotas(PRegistros, LGerando, PTabelas);
  Sistema.GeraSequenciaisContasaReceber(PRegistros, LGerando, PTabelas);
  Sistema.GeraSequenciaisComissao(PRegistros, LGerando, PTabelas);
  LGerando.Caption := 'Codigos gerados com sucesso';
  aviso('Codigos gerados com sucesso!!!');
end;

{******************************************************************************}
procedure TFGeraCodigoOffline.FormClose(Sender: TObject; var Action: TCloseAction);
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
 RegisterClasses([TFGeraCodigoOffline]);
end.
