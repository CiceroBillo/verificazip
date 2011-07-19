unit AGeraArquivosFiscais;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Buttons, StdCtrls, Componentes1, Localizacao, ComCtrls, ExtCtrls,  FileCtrl,
  PainelGradiente, UnExportacaoFiscal, UnNfe, UnDados, UnDadosProduto, Tabela, UnNotaFiscal, unClientes;

type
  TTipoTela = (ttArquivosFiscais,ttArquivosNfeXML);
  TFGeraArquivosFiscais = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BGerar: TBitBtn;
    BFechar: TBitBtn;
    StatusBar1: TStatusBar;
    Label1: TLabel;
    Label2: TLabel;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    ECodFilial: TEditLocaliza;
    SpeedButton1: TSpeedButton;
    Label3: TLabel;
    Label4: TLabel;
    ConsultaPadrao1: TConsultaPadrao;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BGerarClick(Sender: TObject);
  private
    { Private declarations }
    FunExportacaoFiscal : TRBFuncoesExportacaoFiscal;
    VprTipoTela : TTipoTela;
    function ProcessaArquivosFiscais : string;
    function ProcessaArquivosXMLNfe : string;
    procedure ConfiguraTela;
  public
    { Public declarations }
    procedure GeraArquivosFiscais;
    procedure GeraArquivoNFeXML;
  end;

var
  FGeraArquivosFiscais: TFGeraArquivosFiscais;

implementation

uses APrincipal, FunData, Constantes, AMostraCriticaFiscal, ConstMsg, FunSql;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFGeraArquivosFiscais.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunExportacaoFiscal := TRBFuncoesExportacaoFiscal.cria(FPrincipal.BaseDAdos);
  EDatInicio.Datetime := PrimeiroDiaMesAnterior;
  EDatFim.DateTime := UltimodiaMesAnterior;
  ECodFilial.AInteiro := Varia.CodigoEmpFil;
  EcodFilial.Atualiza;
end;

{******************************************************************************}
procedure TFGeraArquivosFiscais.GeraArquivoNFeXML;
begin
  VprTipoTela := ttArquivosNfeXML;
  ConfiguraTela;
  showmodal;
end;

{******************************************************************************}
procedure TFGeraArquivosFiscais.GeraArquivosFiscais;
begin
  VprTipoTela := ttArquivosFiscais;
  ShowModal;
end;

{******************************************************************************}
function TFGeraArquivosFiscais.ProcessaArquivosFiscais: string;
var
  VpfDiretorio: string;
  VpfCritica : TStringList;
begin
  result := '';
  VpfDiretorio := Varia.DiretorioFiscais;
  VpfCritica := TStringList.Create;
  VpfDiretorio := VpfDiretorio + '\';
  FunExportacaoFiscal.ExportarNotasPessoas(ECodFilial.AInteiro,EDatInicio.DateTime, EDatFim.DateTime, VpfDiretorio,StatusBar1,VpfCritica);
  if VpfCritica.Count > 0 then
  begin
    FMostraCriticaFiscal := TFMostraCriticaFiscal.CriarSDI(application,'', FPrincipal.VerificaPermisao('FMostraCriticaFiscal'));
    FMostraCriticaFiscal.MostraCritica(VpfCritica);
    FMostraCriticaFiscal.free;
  end;
  VpfCritica.free;
end;

{******************************************************************************}
function TFGeraArquivosFiscais.ProcessaArquivosXMLNfe: string;
Var
  VpfDiretorio : String;
  VpfFunNFe : TRBFuncoesNFe;
  VpfDNota : TRBDNotaFiscal;
  VpfDCliente : TRBDCliente;
  VpfAux : TSQL;
  VpfConfigNFE : Boolean;
begin
  VpfConfigNFE := config.EmiteNFe;
  config.EmiteNFe := false;
  if SelectDirectory('Escolha o Diretorio','',VpfDiretorio) then
  begin
    VpfFunNFe := TRBFuncoesNFe.cria(FPrincipal.BaseDados);
    VpfFunNFe.NFe.Configuracoes.Geral.PathSalvar := VpfDiretorio;
    VpfAux := TSQL.Create(self);
    VpfAux.ASQlConnection := FPrincipal.BaseDados;
    AdicionaSQLAbreTabela(VpfAux,'Select * from CADNOTAFISCAIS '+
                              ' Where '+SQLTextoDataEntreAAAAMMDD('D_DAT_EMI',EDatInicio.DateTime,EDatFim.Date,false )+
                              ' and I_EMP_FIL = '+IntToStr(ECodFilial.AInteiro)+
                              ' and C_SER_NOT = ''1''');
    while not VpfAux.Eof do
    begin
      VpfDNota := TRBDNotaFiscal.cria;
      StatusBar1.Panels[0].Text := 'Gerando nota "'+VpfAux.FieldByName('I_NRO_NOT').AsString+'"';
      statusBar1.refresh;
      FunNotaFiscal.CarDNotaFiscal(VpfDNota,VpfAux.FieldByName('I_EMP_FIL').AsInteger,VpfAux.FieldByName('I_SEQ_NOT').AsInteger);
      VpfDCliente := TRBDCliente.cria;
      VpfDCliente.CodCliente := VpfAux.FieldByName('I_COD_CLI').AsInteger;
      FunClientes.CarDCliente(VpfDCliente);
      VpfFunNFe.EmiteNota(VpfDNota,VpfdCliente,nil);
      VpfDNota.Free;
      VpfDCliente.Free;
      VpfFunNFe.NFe.Configuracoes.Geral.PathSalvar := VpfDiretorio;
      VpfFunNFe.NFe.NotasFiscais.SaveToFile;
      VpfAux.next;
    end;
    VpfAux.Free;
  end;
  StatusBar1.Panels[0].Text := 'Notas fiscais geradas com sucesso';
  statusBar1.refresh;
  config.EmiteNFe := VpfConfigNFE;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFGeraArquivosFiscais.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunExportacaoFiscal.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


procedure TFGeraArquivosFiscais.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFGeraArquivosFiscais.BGerarClick(Sender: TObject);
var
  VpfResultado : string;
begin
  case VprTipoTela of
    ttArquivosFiscais: VpfResultado := ProcessaArquivosFiscais ;
    ttArquivosNfeXML: VpfResultado := ProcessaArquivosXMLNfe ;
  end;
  if VpfResultado <> '' then
    aviso(VpfResultado)
  else
  begin
  end;
end;

{******************************************************************************}
procedure TFGeraArquivosFiscais.ConfiguraTela;
begin
  case VprTipoTela of
    ttArquivosNfeXML:
      begin
        Self.Caption := 'Gera Arquivos XML Nfe ';
        PainelGradiente1.Caption := '   Gera Arquivos XML Nfe   ';
      end;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFGeraArquivosFiscais]);
end.
