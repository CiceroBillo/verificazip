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


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovoFaturamentoMensal.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  if varia.TipoCotacaoPedido = 0 then
  begin
    aviso('TIPO COTAÇÃO PEDIDO NÃO PREENCHIDO!!!'#13'É necessário preencher o tipo de pedido para a cotação nas configurações do produto.');
  end;
  FunContrato := TRBFuncoesContrato.cria(FPrincipal.BaseDados);
  EDatInicio.DateTime := PrimeiroDiaMesAnterior;
  EDatFim.DateTime := UltimoDiaMesAnterior;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovoFaturamentoMensal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunContrato.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
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
