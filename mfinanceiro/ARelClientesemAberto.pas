unit ARelClientesemAberto;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Buttons, StdCtrls, Componentes1, Localizacao, ExtCtrls, PainelGradiente,
  ComCtrls, UnImpressao;

type
  TFRelClienteEmAberto = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    EFilial: TEditLocaliza;
    Label24: TLabel;
    SpeedButton5: TSpeedButton;
    Label25: TLabel;
    ECliente: TEditLocaliza;
    SpeedButton4: TSpeedButton;
    Label20: TLabel;
    Label18: TLabel;
    Localiza: TConsultaPadrao;
    Label8: TLabel;
    EDatFim: TCalendario;
    BImprimir: TBitBtn;
    BFechar: TBitBtn;
    CVisualizar: TCheckBox;
    BMostrarConta: TSpeedButton;
    EFundoPerdido: TComboBoxColor;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EFilialSelect(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure BMostrarContaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    VprPressionadoR : Boolean;
    VprTipoRelatorio : Integer;
    FunImpressao : TFuncoesImpressao;
    procedure ConfiguraTela;
  public
    { Public declarations }
    procedure ContasEmAberto;
  end;

var
  FRelClienteEmAberto: TFRelClienteEmAberto;

implementation

uses APrincipal, FunData, Constantes;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFRelClienteEmAberto.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EDatFim.DateTime := PrimeiroDiaMes(date);
  VprPressionadoR := false;
  FunImpressao := TFuncoesImpressao.Criar(self,FPrincipal.BaseDados);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFRelClienteEmAberto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunImpressao.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFRelClienteEmAberto.ConfiguraTela;
begin
  case VprTipoRelatorio of
    2 :begin
         caption := 'Contas em Aberto (Matricial)';
         PainelGradiente1.Caption := '  Contas em Aberto   ';
         EDatFim.DateTime := date;
       end;
  end;
end;


{******************************************************************************}
procedure TFRelClienteEmAberto.ContasEmAberto;
begin
  VprTipoRelatorio := 2;
  ConfiguraTela;
  showmodal;
end;

{********************** carrega a select da filial ****************************}
procedure TFRelClienteEmAberto.EFilialSelect(Sender: TObject);
begin
   EFilial.ASelectLocaliza.Text := ' Select * from CadFiliais fil ' +
                                         ' where c_nom_fan like ''@%'' ' +
                                         ' and i_cod_emp = ' + IntTostr(varia.CodigoEmpresa);
   EFilial.ASelectValida.Text := ' Select * from CadFiliais where I_EMP_FIL = @% ' +
                                       ' and i_cod_emp = ' + IntTostr(varia.CodigoEmpresa);
end;

{*********************** fecha o formulario ***********************************}
procedure TFRelClienteEmAberto.BFecharClick(Sender: TObject);
begin
  close;
end;

{****************** imprime os clientes em aberto *****************************}
procedure TFRelClienteEmAberto.BImprimirClick(Sender: TObject);
begin
  case VprTipoRelatorio of
    2 : begin
          FunImpressao.ImprimeClientesEmAberto(EFilial.AInteiro,ECliente.AInteiro,EDatFim.DateTime,EFundoPerdido.ItemIndex,CVisualizar.Checked);
        end;
  end;
end;

{******************************************************************************}
procedure TFRelClienteEmAberto.BMostrarContaClick(Sender: TObject);
begin
  BMostrarConta.visible := false;
end;

{******************************************************************************}
procedure TFRelClienteEmAberto.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift = [ssCtrl,ssAlt])  then
  begin
    if (key = 82) then
      VprPressionadoR := true
    else
      if VprPressionadoR then
      begin
        if (key = 77) then
          BMostrarConta.Visible := true;
        VprPressionadoR := false;
      end;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFRelClienteEmAberto]);
end.
