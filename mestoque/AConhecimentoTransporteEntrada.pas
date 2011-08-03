unit AConhecimentoTransporteEntrada;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Localizacao, ComCtrls, Componentes1, StdCtrls, Buttons, ExtCtrls,
  PainelGradiente, Mask, numericos, UnDados, UnNotasFiscaisFor, ConstMsg, FunData, FunString;

type
  TFConhecimentoTransporteEntrada = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    Panel1: TPanelColor;
    BFechar: TBitBtn;
    BGravar: TBitBtn;
    BCancela: TBitBtn;
    Label26: TLabel;
    ETipoDocumentoFiscal: TRBEditLocaliza;
    SpeedButton7: TSpeedButton;
    Label37: TLabel;
    Label1: TLabel;
    EDataConhecimento: TMaskEditColor;
    Label18: TLabel;
    EValorConhecimento: Tnumerico;
    Label2: TLabel;
    EValorBaseIcms: Tnumerico;
    EValorIcms: Tnumerico;
    Label3: TLabel;
    EValorNaoTributado: Tnumerico;
    Label4: TLabel;
    Label5: TLabel;
    EPesoFrete: Tnumerico;
    ENumeroConhecimento: TEditColor;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BCancelaClick(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
  private
    FunNotaFor : TFuncoesNFFor;
    VprDConhecimentoTransporte: TRBDConhecimentoTransporte;
    procedure CarDClasse;
    procedure CarDTela;
  public
    { Public declarations }
    procedure ConsultarConhecimento(VpaCodTransportadora, VpaCodFilial, VpaSeqNota: Integer; VpaNotaEntrada : Boolean);
  end;

var
  FConhecimentoTransporteEntrada: TFConhecimentoTransporteEntrada;

implementation

uses APrincipal;

{$R *.DFM}


{ **************************************************************************** }
procedure TFConhecimentoTransporteEntrada.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunNotaFor := TFuncoesNFFor.criar(self,FPrincipal.BaseDados);
  VprDConhecimentoTransporte:= TRBDConhecimentoTransporte.Cria;
end;

{ *************************************************************************** }
procedure TFConhecimentoTransporteEntrada.BCancelaClick(Sender: TObject);
begin
  close;
end;

{ **************************************************************************** }
procedure TFConhecimentoTransporteEntrada.BFecharClick(Sender: TObject);
begin
  close;
end;

{ **************************************************************************** }
procedure TFConhecimentoTransporteEntrada.BGravarClick(Sender: TObject);
Var
  VpfResultado: String;
begin
  CarDClasse;
  VpfResultado:= FunNotaFor.GravaDConhecimentoTransporte(VprDConhecimentoTransporte);
  if VpfResultado <> '' then
    aviso(VpfResultado)
  else
    Close;
end;

{ **************************************************************************** }
procedure TFConhecimentoTransporteEntrada.CarDClasse;
begin
  VprDConhecimentoTransporte.CodModeloDocumento:= ETipoDocumentoFiscal.Text;
  if DeletaEspaco(DeletaChars(EDataConhecimento.Text,'/')) = '' then
    VprDConhecimentoTransporte.DatConhecimento:= MontaData(1,1,1900)
  else
    VprDConhecimentoTransporte.DatConhecimento:= StrToDate(EDataConhecimento.Text);
  VprDConhecimentoTransporte.NumTipoConhecimento:= 1;
  VprDConhecimentoTransporte.ValConhecimento:= EValorConhecimento.AValor;
  VprDConhecimentoTransporte.ValorBaseIcms:= EValorBaseIcms.AValor;
  VprDConhecimentoTransporte.ValorIcms:= EValorIcms.AValor;
  VprDConhecimentoTransporte.ValorNaoTributado:= EValorNaoTributado.AValor;
  VprDConhecimentoTransporte.PesoFrete:= EPesoFrete.AValor;
  VprDConhecimentoTransporte.NumConhecimento:= ENumeroConhecimento.AInteiro;
end;

{ **************************************************************************** }
procedure TFConhecimentoTransporteEntrada.CarDTela;
begin
  ETipoDocumentoFiscal.Text:= VprDConhecimentoTransporte.CodModeloDocumento;
  ETipoDocumentoFiscal.Atualiza;
  if VprDConhecimentoTransporte.DatConhecimento > MontaData(1,1,1900) then
    EDataConhecimento.Text:= FormatDateTime('DD/MM/YYYY',VprDConhecimentoTransporte.DatConhecimento)
  else
    EDataConhecimento.clear;
  EValorConhecimento.AValor:= VprDConhecimentoTransporte.ValConhecimento;
  EValorBaseIcms.AValor:= VprDConhecimentoTransporte.ValorBaseIcms;
  EValorIcms.AValor:= VprDConhecimentoTransporte.ValorIcms;
  EValorNaoTributado.AValor:= VprDConhecimentoTransporte.ValorNaoTributado;
  EPesoFrete.AValor:= VprDConhecimentoTransporte.PesoFrete;
  ENumeroConhecimento.AInteiro:= VprDConhecimentoTransporte.NumConhecimento;
end;

{ **************************************************************************** }
procedure TFConhecimentoTransporteEntrada.ConsultarConhecimento(VpaCodTransportadora, VpaCodFilial, VpaSeqNota: Integer; VpaNotaEntrada : Boolean);
begin
  VprDConhecimentoTransporte.CodTransportadora:= VpaCodTransportadora;
  VprDConhecimentoTransporte.CodFilial:= VpaCodFilial;
  if VpaNotaEntrada then
  begin
    FunNotaFor.CarDConhecimentoTransporte(VpaSeqNota,VpaCodFilial,VprDConhecimentoTransporte, true);
    VprDConhecimentoTransporte.SeqNotaEntrada:= VpaSeqNota;
  end
  else
  begin
    FunNotaFor.CarDConhecimentoTransporte(VpaSeqNota,VpaCodFilial,VprDConhecimentoTransporte, false);
    VprDConhecimentoTransporte.SeqNotaSaida:= VpaSeqNota;
  end;
  CarDTela;
  ShowModal;
end;

{ **************************************************************************** }
procedure TFConhecimentoTransporteEntrada.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunNotaFor.Free;
  VprDConhecimentoTransporte.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFConhecimentoTransporteEntrada]);
end.
