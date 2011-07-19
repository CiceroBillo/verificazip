unit AFechamentoEstoque;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Buttons, UnSumarizaEstoque,
  Grids, DBGrids, Tabela, Db, DBTables, ComCtrls, Spin, Mask, DBCtrls,
  Gauges;

type
  TFFechamentoEstoque = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BFechar: TBitBtn;
    PainelTempo: TPainelTempo;
    PanelColor3: TPanelColor;
    Smes: TSpinEditColor;
    SAno: TSpinEditColor;
    Label1: TLabel;
    Label2: TLabel;
    BFechamento: TBitBtn;
    BConsistencia: TBitBtn;
    Label3: TLabel;
    SAno1: TSpinEditColor;
    Smes1: TSpinEditColor;
    Barra: TProgressBar;
    Label4: TLabel;
    BReprocessar: TBitBtn;
    EMesFechamento: TEditColor;
    EAnoFechamento: TEditColor;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BFechamentoClick(Sender: TObject);
    procedure BConsistenciaClick(Sender: TObject);
    procedure BBAjudaClick(Sender: TObject);
    procedure BReprocessarClick(Sender: TObject);
    procedure PanelColor1Click(Sender: TObject);
  private
    UnSum : UnSumarizaEstoque.TFuncoesSumarizaEstoque;
  public
    { Public declarations }
  end;

var
  FFechamentoEstoque: TFFechamentoEstoque;

implementation

uses APrincipal, fundata, AQdadeProdutosInconsistente, constmsg, Constantes;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFFechamentoEstoque.FormCreate(Sender: TObject);
begin
  UnSum := UnSumarizaEstoque.TFuncoesSumarizaEstoque.criar(self,FPrincipal.BaseDados);
  EAnoFechamento.AInteiro := varia.UltimoAnoEstoque;
  EMesFechamento.AInteiro := varia.UltimoMesEstoque;
  SMes.Value := mes(date);
  SAno.Value := ano(date);
  SMes1.Value := mes(date);
  SAno1.Value := ano(date);
end;

procedure TFFechamentoEstoque.PanelColor1Click(Sender: TObject);
begin

end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFFechamentoEstoque.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  UnSum.Free;
  Action := CaFree;
end;

{******************* fecha o formulario ************************************* }
procedure TFFechamentoEstoque.BFecharClick(Sender: TObject);
begin
  self.close;
end;

{******************************************************************************}
procedure TFFechamentoEstoque.BFechamentoClick(Sender: TObject);
var
  VpfExecutaFechamento : Boolean;
  VpfDataFim, VpfDataUltFechamento : TdateTime;
begin
  VpfExecutaFechamento := true;
  VpfDataUltFechamento := MontaData(01, Varia.UltimoMesEstoque,varia.UltimoAnoEstoque );
  VpfDataUltFechamento := MontaData(Dia(UltimoDiaMes(VpfDataUltFechamento)),varia.UltimoMesEstoque, Varia.UltimoAnoEstoque);
  VpfDataFim := MontaData(01,Smes1.Value, SAno1.Value);
  VpfDataFim := MontaData(Dia(UltimoDiaMes(VpfDataFim)), Smes1.Value, SAno1.Value);

  //não permite fechar novamente
  if (VpfDataFim < VpfDataUltFechamento)  and VpfExecutaFechamento then
  begin
    VpfExecutaFechamento := false;
    aviso(CT_DataMenorFechamento);
  end;

  if (MontaData(15,Smes.Value, SAno.Value) < PrimeiroDiaMes(UnSum.PrimeiroMovEstoque)) and VpfExecutaFechamento then
  begin
    VpfExecutaFechamento := false;
    AvisoFormato(CT_MesSemMovimento, [ datetostr(unSum.PrimeiroMovEstoque)] );
  end;

 if VpfExecutaFechamento  then
 begin
   if not UnSum.VerificaSumaVazio then
     UnSum.FechaMesGeral(Smes.Value, SAno.Value, Smes1.Value, SAno1.Value, Barra)
   else
     UnSum.FechaMesGeral(Mes(UnSum.PrimeiroMovEstoque), Ano(UnSum.PrimeiroMovEstoque), Smes1.Value, SAno1.Value, Barra)
 end;
  aviso('Fechamento efetuado com sucesso.');
end;

{******************************************************************************}
procedure TFFechamentoEstoque.BConsistenciaClick(Sender: TObject);
begin
  FQdadeProdutosInconsistente := TFQdadeProdutosInconsistente.CriarSDI(application, '', FPrincipal.VerificaPermisao('FQdadeProdutosInconsistente'));
  FQdadeProdutosInconsistente.ShowModal;
  FQdadeProdutosInconsistente.free;
end;

{******************************************************************************}
procedure TFFechamentoEstoque.BBAjudaClick(Sender: TObject);
begin
end;

{******************************************************************************}
procedure TFFechamentoEstoque.BReprocessarClick(Sender: TObject);
begin
  UnSum.ReprocessaMes(Smes.Value,SAno.Value,Smes1.Value,SAno1.Value);
end;

Initialization
 RegisterClasses([TFFechamentoEstoque]);
end.
