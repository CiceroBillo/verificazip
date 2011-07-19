unit AConhecimentoTransporte;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Localizacao, ComCtrls, Componentes1, StdCtrls, Buttons, ExtCtrls,
  PainelGradiente, Mask, numericos, UnDados, UnNotasFiscaisFor, ConstMsg, FunData, FunString;

type
  TFConhecimentoTransporte = class(TFormularioPermissao)
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
    procedure ConsultarConhecimento(VpaCodTransportadora, VpaCodFilial, VpaSeqNota: Integer);
  end;

var
  FConhecimentoTransporte: TFConhecimentoTransporte;

implementation

uses APrincipal;

{$R *.DFM}


{ **************************************************************************** }
procedure TFConhecimentoTransporte.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunNotaFor := TFuncoesNFFor.criar(self,FPrincipal.BaseDados);
  VprDConhecimentoTransporte:= TRBDConhecimentoTransporte.Cria;
end;

{ *************************************************************************** }
procedure TFConhecimentoTransporte.BCancelaClick(Sender: TObject);
begin
  close;
end;

{ **************************************************************************** }
procedure TFConhecimentoTransporte.BFecharClick(Sender: TObject);
begin
  close;
end;

{ **************************************************************************** }
procedure TFConhecimentoTransporte.BGravarClick(Sender: TObject);
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
procedure TFConhecimentoTransporte.CarDClasse;
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
procedure TFConhecimentoTransporte.CarDTela;
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
procedure TFConhecimentoTransporte.ConsultarConhecimento(VpaCodTransportadora, VpaCodFilial, VpaSeqNota: Integer);
begin
  FunNotaFor.CarDConhecimentoTransporte(VpaSeqNota,VpaCodFilial,VprDConhecimentoTransporte);
  VprDConhecimentoTransporte.CodTransportadora:= VpaCodTransportadora;
  VprDConhecimentoTransporte.CodFilial:= VpaCodFilial;
  VprDConhecimentoTransporte.SeqNotaEntrada:= VpaSeqNota;
  CarDTela;
  ShowModal;
end;

{ **************************************************************************** }
procedure TFConhecimentoTransporte.FormClose(Sender: TObject; var Action: TCloseAction);
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
 RegisterClasses([TFConhecimentoTransporte]);
end.
