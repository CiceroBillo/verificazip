unit ANovoFaturamentoMensal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente, Gauges,
  ComCtrls, UnContrato, Localizacao;

type
  TFNovoFaturamentoMensal = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BExecutar: TBitBtn;
    BFechar: TBitBtn;
    Progresso: TProgressBar;
    LSituacao: TLabel;
    Localiza: TConsultaPadrao;
    Label21: TLabel;
    SpeedButton18: TSpeedButton;
    LNomTipoContrato: TLabel;
    ECodTipoContrato: TEditLocaliza;
    Label1: TLabel;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    Label2: TLabel;
    CNaoFaturarReajuste: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BExecutarClick(Sender: TObject);
  private
    { Private declarations }
    FunContrato : TRBFuncoesContrato;
  public
    { Public declarations }
  end;

var
  FNovoFaturamentoMensal: TFNovoFaturamentoMensal;

implementation

uses APrincipal,FunData, Constantes, ConstMsg;

{$R *.DFM}


{ ****************** Na cria��o do Formul�rio ******************************** }
procedure TFNovoFaturamentoMensal.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualiza��o de menus }
  if varia.TipoCotacaoPedido = 0 then
  begin
    aviso('TIPO COTA��O PEDIDO N�O PREENCHIDO!!!'#13'� necess�rio preencher o tipo de pedido para a cota��o nas configura��es do produto.');
  end;
  FunContrato := TRBFuncoesContrato.cria(FPrincipal.BaseDados);
  EDatInicio.DateTime := PrimeiroDiaMesAnterior;
  EDatFim.DateTime := UltimoDiaMesAnterior;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovoFaturamentoMensal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualiza��o de menus }
  FunContrato.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            A��es Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFNovoFaturamentoMensal.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFNovoFaturamentoMensal.BExecutarClick(Sender: TObject);
begin
  FunContrato.ExecutaFaturamentoMensal(Progresso,LSituacao,ECodTipoContrato.AInteiro,EDatInicio.DateTime,EDatFim.DateTime,CNaoFaturarReajuste.checked);
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovoFaturamentoMensal]);
end.
