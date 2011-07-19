unit ARelOrdemSerra;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Buttons, Mask,
  numericos, Localizacao, UnDadosProduto;

type
  TFRelOrdemSerra = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BImprimir: TBitBtn;
    BFechar: TBitBtn;
    Localiza: TConsultaPadrao;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    Label3: TLabel;
    Label1: TLabel;
    SpeedButton2: TSpeedButton;
    Label4: TLabel;
    Label5: TLabel;
    SpeedButton3: TSpeedButton;
    Label6: TLabel;
    EFilial: TEditLocaliza;
    EOrdemProducao: TEditLocaliza;
    EFracao: TEditLocaliza;
    Label7: TLabel;
    EOrdemInicial: Tnumerico;
    EOrdemFinal: Tnumerico;
    Label8: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure EOrdemProducaoSelect(Sender: TObject);
    procedure EFracaoSelect(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
  private
    { Private declarations }
    VprDOrdemProducao : TRBDordemProducao;
  public
    { Public declarations }
    procedure ImprimeOrdemSErra(VpaCodFilial,VpaSeqOrdem, VpaSeqFracao : Integer);
  end;

var
  FRelOrdemSerra: TFRelOrdemSerra;

implementation

uses APrincipal, unOrdemProducao;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFRelOrdemSerra.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFRelOrdemSerra.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFRelOrdemSerra.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFRelOrdemSerra.EOrdemProducaoSelect(Sender: TObject);
begin
  EOrdemProducao.ASelectLocaliza.Text := 'Select ORD.SEQORD, ORD.DATEMI, CLI.C_NOM_CLI from ORDEMPRODUCAOCORPO ORD, CADCLIENTES CLI '+
                                         ' Where ORD.EMPFIL = '+ IntToStr(EFilial.AInteiro)+
                                         ' and ORD.CODCLI = CLI.I_COD_CLI '+
                                         ' AND CLI.C_NOM_CLI like ''@%''';
  EOrdemProducao.ASelectValida.Text := 'Select ORD.SEQORD, ORD.DATEMI, CLI.C_NOM_CLI From ORDEMPRODUCAOCORPO ORD, CADCLIENTES CLI '+
                                         ' Where ORD.EMPFIL = '+ IntToStr(EFilial.AInteiro)+
                                         ' and ORD.CODCLI = CLI.I_COD_CLI '+
                                         ' AND ORD.SEQORD = @';
end;

{******************************************************************************}
procedure TFRelOrdemSerra.EFracaoSelect(Sender: TObject);
begin
  EFracao.ASelectLocaliza.Text := 'SELECT FRA.SEQFRACAO, FRA.DATENTREGA, FRA.QTDPRODUTO, FRA.CODESTAGIO from FRACAOOP FRA '+
                                  ' Where FRA.SEQFRACAO LIKE ''@%'''+
                                  ' AND FRA.CODFILIAL = '+IntToStr(EFilial.AInteiro)+
                                  ' and FRA.SEQORDEM = '+IntToStr(EOrdemProducao.AInteiro);
  EFracao.ASelectValida.Text := 'SELECT FRA.SEQFRACAO, FRA.DATENTREGA, FRA.QTDPRODUTO, FRA.CODESTAGIO from FRACAOOP FRA '+
                                  ' Where FRA.SEQFRACAO = @ '+
                                  ' AND FRA.CODFILIAL = '+IntToStr(EFilial.AInteiro)+
                                  ' and FRA.SEQORDEM = '+IntToStr(EOrdemProducao.AInteiro);
end;

{******************************************************************************}
procedure TFRelOrdemSerra.ImprimeOrdemSErra(VpaCodFilial,VpaSeqOrdem, VpaSeqFracao : Integer);
begin
  EFilial.AInteiro := VpaCodFilial;
  EFilial.Atualiza;
  EOrdemProducao.AInteiro := VpaSeqOrdem;
  EOrdemProducao.atualiza;
  EFracao.AInteiro := VpaSeqFracao;
  EFracao.Atualiza;
  Showmodal;
end;

{******************************************************************************}
procedure TFRelOrdemSerra.BImprimirClick(Sender: TObject);
begin
    VprDOrdemProducao.free;
    VprDOrdemProducao := TRBDOrdemProducao.cria;
    VprDOrdemProducao.CodEmpresafilial := EFilial.AInteiro;
    VprDOrdemProducao.SeqOrdem := EOrdemProducao.AInteiro;
    VprDOrdemProducao.DatEmissao := date;
    FunOrdemProducao.CarDOrdemSerra(VprDOrdemProducao,EOrdemInicial.AsInteger,EOrdemFinal.AsInteger) ;
    FunOrdemProducao.ImprimeEtiquetaOrdemSerra(VprDOrdemProducao);
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFRelOrdemSerra]);
end.
