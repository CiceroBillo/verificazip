unit AMenuFiscalECF;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios, UnECF, StdCtrls, Buttons,
  Componentes1, ExtCtrls, PainelGradiente, ComCtrls, UnDados, Variants, ConstMsg, UnSpedfiscal;

type
  TFMenuFiscalECF = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BFechar: TBitBtn;
    BLX: TBitBtn;
    BarraStatus: TStatusBar;
    BLMFC: TBitBtn;
    BLMFS: TBitBtn;
    BEspelhoMFD: TBitBtn;
    BMovimentoPorECF: TBitBtn;
    BTabelaProdutos: TBitBtn;
    BEstoque: TBitBtn;
    BMeiosPagamento: TBitBtn;
    BDAVEmitidos: TBitBtn;
    BIdentificacaoPAFECF: TBitBtn;
    BTabelaIndiceProducao: TBitBtn;
    BVendasPeriodo: TBitBtn;
    BArquivoMFD: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BLXClick(Sender: TObject);
    procedure BLMFCClick(Sender: TObject);
    procedure BLMFSClick(Sender: TObject);
    procedure BMovimentoPorECFClick(Sender: TObject);
    procedure BEspelhoMFDClick(Sender: TObject);
    procedure BArquivoMFDClick(Sender: TObject);
    procedure FPrincipalMProdutosExecute(Sender: TObject);
    procedure BTabelaProdutosClick(Sender: TObject);
    procedure BEstoqueClick(Sender: TObject);
    procedure BIdentificacaoPAFECFClick(Sender: TObject);
    procedure BDAVEmitidosClick(Sender: TObject);
    procedure BTabelaIndiceProducaoClick(Sender: TObject);
    procedure BMeiosPagamentoClick(Sender: TObject);
    procedure BVendasPeriodoClick(Sender: TObject);
  private
    { Private declarations }
    VprDFiltroECF : TRBDFiltroMenuFiscalECF;
    FunECF : TRBFuncoesECF;
    FunSped : TRBFuncoesSpedFiscal;
    procedure GeraArquivoSped(VpaDFiltro : TRBDFiltroMenuFiscalECF);
  public

  end;

//function Bematech_FI_EspelhoMFD( cNomeArquivoDestino: AnsiString; cDadoInicial: AnsiString; cDadoFinal: AnsiString; cTipoDownload: AnsiString; cUsuario: AnsiString; cChavePublica: AnsiString; cChavePrivada: AnsiString ): Integer; StdCall; External 'BEMAFI32.DLL';

var
  FMenuFiscalECF: TFMenuFiscalECF;

implementation

uses APrincipal, AComandoFiscalFiltro, constantes;





{$R *.DFM}


{ **************************************************************************** }
procedure TFMenuFiscalECF.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunECF := TRBFuncoesECF.cria(BarraStatus,FPrincipal.BaseDados);
  FunSped := TRBFuncoesSpedFiscal.cria(FPrincipal.BaseDados);
end;

{******************************************************************************}
procedure TFMenuFiscalECF.FPrincipalMProdutosExecute(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFMenuFiscalECF.GeraArquivoSped(VpaDFiltro: TRBDFiltroMenuFiscalECF);
var
  VpfDSped : TRBDSpedFiscal;
  VpfNomArquivo : String;
begin
  VpfDSped := TRBDSpedFiscal.cria;
  VpfDSped.Codfilial := Varia.CodigoEmpFil;
  VpfDSped.DatInicio := VpaDFiltro.DatInicio;
  VpfDSped.DatFinal := VpaDFiltro.DatFim;
  VpfDSped.CodFinalidade := cfRemessaOriginal;
  VpfDSped.IndEntradas := true;
  VpfDSped.IndSaidas := true;
  VpfDSped.IndConsistirDados := true;
  FunSped.GeraSpedfiscal(VpfDSped,BarraStatus);
  if (VpfDSped.Incosistencias.Count > 0) then
  begin
    VpfDSped.Incosistencias.SaveToFile('c:\InconsistenciasSped.txt');
    BarraStatus.Panels[0].Text := 'Foram gerados '+IntToStr(VpfDSped.Incosistencias.Count)+' inconsistencias no arquivo "c:\Inconsistencias.txt"';
  end
  else
  begin
    VpfNomArquivo := Varia.DiretorioSistema+CT_PASTAPAF+FunECF.RNumLaudo+FormatDateTime('DDMMYYYYHHMMSS',now)+'.txt';
    VpfDSped.Arquivo.SaveToFile(VpfNomArquivo);
    FunECF.AssinaArquivo(VpfNomArquivo);
    BarraStatus.Panels[0].Text := 'Arquivo "'+VpfNomArquivo+'" gerado com sucesso';
  end;
  VpfDSped.free;

end;

{ *************************************************************************** }
procedure TFMenuFiscalECF.BDAVEmitidosClick(Sender: TObject);
begin
  VprDFiltroECF :=  TRBDFiltroMenuFiscalECF.cria;
  VprDFiltroECF.IndMostrarPeriodo := true;
  VprDFiltroECF.IndMostrarGerarArquivo := true;
  FComandoFiscalFiltro := TFComandoFiscalFiltro.CriarSDI(self,'',true);
  if FComandoFiscalFiltro.FiltraMenuFiscal(VprDFiltroECF) then
    FunECF.DAVEmitidos(VprDFiltroECF);
  VprDFiltroECF.Free;
end;

procedure TFMenuFiscalECF.BEstoqueClick(Sender: TObject);
begin
  FunECF.Estoque;
end;

{******************************************************************************}
procedure TFMenuFiscalECF.BFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFMenuFiscalECF.BIdentificacaoPAFECFClick(Sender: TObject);
begin
  FunECF.IdentificacaoPAFECF;
end;

{******************************************************************************}
procedure TFMenuFiscalECF.BLMFSClick(Sender: TObject);
begin
  VprDFiltroECF :=  TRBDFiltroMenuFiscalECF.cria;
  FComandoFiscalFiltro := TFComandoFiscalFiltro.CriarSDI(self,'',true);
  VprDFiltroECF.IndMostrarPeriodo := true;
  VprDFiltroECF.IndMostrarCRZ := true;
  VprDFiltroECF.IndMostrarGerarArquivo := true;
  if FComandoFiscalFiltro.FiltraMenuFiscal(VprDFiltroECF) then
    FunECF.LeituraLMF(VprDFiltroECF,true);
  VprDFiltroECF.Free;
end;

{******************************************************************************}
procedure TFMenuFiscalECF.BArquivoMFDClick(Sender: TObject);
begin
  BarraStatus.Panels[0].Text:= 'Aguarde gerando o arquivo!!';
  VprDFiltroECF :=  TRBDFiltroMenuFiscalECF.cria;
  VprDFiltroECF.IndMostrarPeriodo := true;
  VprDFiltroECF.IndMostrarCOO := true;
  VprDFiltroECF.IndMostrarGerarArquivo := true;
  FComandoFiscalFiltro := TFComandoFiscalFiltro.CriarSDI(self,'',true);
  if FComandoFiscalFiltro.FiltraMenuFiscal(VprDFiltroECF) then
    FunECF.ArquivoMFD(VprDFiltroECF);
  VprDFiltroECF.Free;
  BarraStatus.Panels[0].Text:= 'Arquivo gerado com sucesso!!';
end;

{******************************************************************************}
procedure TFMenuFiscalECF.BTabelaIndiceProducaoClick(Sender: TObject);
begin
  FunECF.IndiceTecnicoProducao;
end;

{******************************************************************************}
procedure TFMenuFiscalECF.BEspelhoMFDClick(Sender: TObject);
var
 cArquivo,cDataInicial,cDataFinal,cTipo,cUsuario : AnsiString;
  iRetorno : Integer;
begin
{cArquivo      := 'C:\TESTE.TXT';
cDataInicial  := '000226';
cDataFinal    := '000229';
cTipo         := 'C';
cUsuario      := '1';

//iRetorno := Bematech_FI_EspelhoMFD( pAnsichar( cArquivo ), pAnsichar( cDataInicial ), pansichar( cDataFinal ), pAnsichar( cTipo ), pAnsichar( cUsuario ), pansichar( CT_CHAVEPUBLICA ), pAnsichar( CT_CHAVEPRIVADA ) );
aviso(IntToStr(iRetorno));}

  BarraStatus.Panels[0].Text:= 'Aguarde gerando o arquivo!!';
  VprDFiltroECF :=  TRBDFiltroMenuFiscalECF.cria;
  VprDFiltroECF.IndMostrarPeriodo := true;
  VprDFiltroECF.IndMostrarCOO := true;
  VprDFiltroECF.IndMostrarGerarArquivo := true;
  FComandoFiscalFiltro := TFComandoFiscalFiltro.CriarSDI(self,'',true);
  if FComandoFiscalFiltro.FiltraMenuFiscal(VprDFiltroECF) then
    FunECF.EspelhoMFD(VprDFiltroECF);
  VprDFiltroECF.Free;
  BarraStatus.Panels[0].Text:= 'Arquivo gerado com sucesso!!';
end;

procedure TFMenuFiscalECF.BLMFCClick(Sender: TObject);
begin
  BarraStatus.Panels[0].Text:= 'Aguarde gerando o arquivo!!';
  VprDFiltroECF :=  TRBDFiltroMenuFiscalECF.cria;
  VprDFiltroECF.IndMostrarPeriodo := true;
  VprDFiltroECF.IndMostrarCRZ := true;
  VprDFiltroECF.IndMostrarGerarArquivo := true;
  FComandoFiscalFiltro := TFComandoFiscalFiltro.CriarSDI(self,'',true);
  if FComandoFiscalFiltro.FiltraMenuFiscal(VprDFiltroECF) then
    FunECF.LeituraLMF(VprDFiltroECF,false);
  VprDFiltroECF.Free;
  BarraStatus.Panels[0].Text:= 'Arquivo gerado com sucesso!!';

end;

{******************************************************************************}
procedure TFMenuFiscalECF.BLXClick(Sender: TObject);
begin
  FunECF.LeituraX;
end;

{******************************************************************************}
procedure TFMenuFiscalECF.BMeiosPagamentoClick(Sender: TObject);
begin
  VprDFiltroECF :=  TRBDFiltroMenuFiscalECF.cria;
  VprDFiltroECF.IndMostrarPeriodo := true;
  FComandoFiscalFiltro := TFComandoFiscalFiltro.CriarSDI(self,'',true);
  if FComandoFiscalFiltro.FiltraMenuFiscal(VprDFiltroECF) then
    FunECF.MeiosPagamento(VprDFiltroECF);
  VprDFiltroECF.Free;
end;

{******************************************************************************}
procedure TFMenuFiscalECF.BMovimentoPorECFClick(Sender: TObject);
begin
  VprDFiltroECF :=  TRBDFiltroMenuFiscalECF.cria;
  VprDFiltroECF.IndMostrarNumECF := true;
  VprDFiltroECF.IndMostrarPeriodo := true;
  FComandoFiscalFiltro := TFComandoFiscalFiltro.CriarSDI(self,'',true);
  if FComandoFiscalFiltro.FiltraMenuFiscal(VprDFiltroECF) then
    FunECF.MovimentoporECF(VprDFiltroECF);
  VprDFiltroECF.Free;
  BarraStatus.Panels[0].Text:= 'Arquivo gerado com sucesso!!';
end;

{******************************************************************************}
procedure TFMenuFiscalECF.BTabelaProdutosClick(Sender: TObject);
begin
  FunECF.TabelaProdutos;
end;

{******************************************************************************}
procedure TFMenuFiscalECF.BVendasPeriodoClick(Sender: TObject);
begin
  VprDFiltroECF :=  TRBDFiltroMenuFiscalECF.cria;
  VprDFiltroECF.IndMostrarPeriodo := true;
  VprDFiltroECF.IndMostrarFormatoArquivo := true;
  FComandoFiscalFiltro := TFComandoFiscalFiltro.CriarSDI(self,'',true);
  if FComandoFiscalFiltro.FiltraMenuFiscal(VprDFiltroECF) then
  begin
    case VprDFiltroECF.TipFormatoArquivo of
    faSintegra: FunECF.VendasPorPeriodoSintegra(VprDFiltroECF);
    faSped: GeraArquivoSped(VprDFiltroECF) ;
    end;
  end;
  VprDFiltroECF.Free;
end;

{******************************************************************************}
procedure TFMenuFiscalECF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunECF.Free;
  FunSped.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFMenuFiscalECF]);
end.


