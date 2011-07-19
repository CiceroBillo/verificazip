unit APesarCartucho;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Mask, numericos, Componentes1, Localizacao, ExtCtrls,
  PainelGradiente, UnToledo, DBKeyViolation, UnArgox, UnDadosProduto, Menus;

type
  TFPesarCartucho = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Localiza: TConsultaPadrao;
    Label8: TLabel;
    SpeedButton2: TSpeedButton;
    LNomProduto: TLabel;
    EProduto: TEditLocaliza;
    EPeso: Tnumerico;
    Label1: TLabel;
    Label2: TLabel;
    BPesar: TBitBtn;
    BFechar: TBitBtn;
    ESequencial: Tnumerico;
    Label3: TLabel;
    Label4: TLabel;
    SpeedButton5: TSpeedButton;
    Label10: TLabel;
    ECelulaTrabalho: TEditLocaliza;
    ValidaGravacao1: TValidaGravacao;
    CCilindroNovo: TCheckBox;
    BitBtn1: TBitBtn;
    CChipNovo: TCheckBox;
    PopupMenu1: TPopupMenu;
    ReimprimirEtiqueta1: TMenuItem;
    Label5: TLabel;
    SpeedButton1: TSpeedButton;
    Label6: TLabel;
    EPo: TEditLocaliza;
    Label7: TLabel;
    SpeedButton3: TSpeedButton;
    Label9: TLabel;
    ECilindro: TEditLocaliza;
    Label11: TLabel;
    SpeedButton4: TSpeedButton;
    Label12: TLabel;
    EChip: TEditLocaliza;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BPesarClick(Sender: TObject);
    procedure ECelulaTrabalhoCadastrar(Sender: TObject);
    procedure EProdutoChange(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure EProdutoRetorno(Retorno1, Retorno2: String);
    procedure ReimprimirEtiqueta1Click(Sender: TObject);
    procedure CCilindroNovoClick(Sender: TObject);
    procedure EPoRetorno(Retorno1, Retorno2: String);
    procedure ECilindroRetorno(Retorno1, Retorno2: String);
    procedure EChipRetorno(Retorno1, Retorno2: String);
    procedure EPoSelect(Sender: TObject);
    procedure ECilindroSelect(Sender: TObject);
    procedure EChipSelect(Sender: TObject);
  private
    { Private declarations }
    VprSeqPo,
    VprSeqCilindro,
    VprSeqChip : INteger;
    FunArgox : TRBFuncoesArgox;
    FunArgox2 : TRBFuncoesArgox;
    VprDProduto : TRBDProduto;
    VprDCartucho : TRBDPesoCartucho;
    procedure InicializaTela;
    procedure CarDClasse;
    procedure ImprimeEtiqueta(VpaReimprimir : Boolean);
  public
    { Public declarations }
  end;

var
  FPesarCartucho: TFPesarCartucho;

implementation

uses APrincipal, ConstMsg, constantes, ACelulaTrabalho, Unprodutos;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFPesarCartucho.FormCreate(Sender: TObject);
var
  VpfResultado : String;
begin
  VprDCartucho := TRBDPesoCartucho.cria;
  VprDProduto := TRBDProduto.cria;
  VprDProduto.CodEmpresa := VARIA.CodigoEmpresa;
  VprDProduto.CodEmpFil := Varia.CodigoEmpFil;
  FunArgox := TRBFuncoesArgox.cria(Varia.PortaComunicacaoImpTermica);
  if AbrePorta(VARIA.PortaComunicacaoBalanca,0,1,0)= cfalha then
    aviso('ERRO NA ABERTURA DA PORTA!!!'#13'Não foi possível o programa se comunicar com a balança');
  if varia.OperacaoEstoqueImpressaoEtiqueta = 0 then
    aviso('OPERAÇÃO ESTOQUE IMPRESSAO ETIQUETA NÃO PREENCHIDO!!!'#13'É necessário preencher nas configurações do produto a operacao de estoque de impressão de etiqueta');
  InicializaTela;
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFPesarCartucho.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  VprDProduto.free;
//  VprDCartucho.free;
  FunArgox.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFPesarCartucho.InicializaTela;
begin
  VprDCartucho.free;
  VprDCartucho := TRBDPesoCartucho.cria;
  EProduto.clear;
  ECelulaTrabalho.clear;
  EPeso.clear;
  ESequencial.clear;
  ValidaGravacao1.execute;
end;

{******************************************************************************}
procedure TFPesarCartucho.CarDClasse;
begin
  VprDCartucho.free;
  VprDCartucho := TRBDPesoCartucho.cria;
  VprDCartucho.SeqCartucho := ESequencial.AsInteger;
  VprDCartucho.SeqProduto := VprDProduto.SeqProduto;
  VprDCartucho.SeqPo := VprSeqPo;
  VprDCartucho.SeqCilindro := VprSeqCilindro;
  VprDCartucho.SeqChip := VprSeqChip;
  VprDCartucho.CodUsuario := varia.CodigoUsuario;
  VprDCartucho.CodCelula := ECelulaTrabalho.AInteiro;
  VprDCartucho.DatPeso :=now;
  VprDCartucho.PesCartucho := EPeso.AsInteger;
  VprDCartucho.CodProduto := VprDProduto.CodProduto;
  VprDCartucho.NomProduto := VprDProduto.NomProduto;
  VprDCartucho.CodReduzidoCartucho := VprDProduto.CodReduzidoCartucho;
  VprDCartucho.IndCilindroNovo := CCilindroNovo.Checked;
  VprDCartucho.IndChipNovo := CChipNovo.Checked;
  VprDCartucho.DesTipoCartucho := VprDProduto.DesTipoCartucho;
  VprDCartucho.QtdMLCartucho := VprDProduto.QtdMlCartucho;
  if VprDProduto.CodCorCartucho <> 0 then
    VprDCartucho.NomCorCartucho := FunProdutos.RNomeCor(IntToStr(VprDProduto.CodCorCartucho))
  else
    VprDCartucho.NomCorCartucho := '';
end;

{******************************************************************************}
procedure TFPesarCartucho.ImprimeEtiqueta(VpaReimprimir : Boolean);
var
  VpfNomProduto : string;
  VpfResultado : String;
begin
  VpfResultado := '';
  CarDClasse;
  if not VpaReimprimir then
  begin
    VpfREsultado := FunProdutos.GravaPesoCartucho(VprDCartucho,VprDProduto );
  end;
  if VpfResultado = '' then
  begin
    if VprDProduto.CodReduzidoCartucho <> '' then
      VpfNomProduto := EProduto.Text+'-'+VprDProduto.CodReduzidoCartucho
    else
      VpfNomProduto := EProduto.Text+'-'+LNomProduto.Caption;
    FunArgox.ImprimeEtiqueta(VprDCartucho);
    FunArgox.free;
    FunArgox := TRBFuncoesArgox.cria(Varia.PortaComunicacaoImpTermica);
    VprDCartucho := TRBDPesoCartucho.cria;
  end
  else
    aviso(VpfResultado);
end;

{******************************************************************************}
procedure TFPesarCartucho.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFPesarCartucho.BPesarClick(Sender: TObject);
var
  Peso: array[0..5]of Ansichar;
begin
  if PegaPeso(1,Peso,pAnsichar('')) = cSucesso then
  begin
    EPeso.Text:=StrPas(Peso);
//    EPeso.Text:='100';

    ESequencial.AsInteger := FunProdutos.RSeqCartuchoDisponivel;
    if VprDProduto.PesCartucho <> 0 then
    begin
      if EPeso.AsInteger < (VprDProduto.PesCartucho * 0.9) then
        aviso('PESO DO CARTUCHO INFERIOR A 10%!!!!'#13'O peso ideal para esse cartucho é de '+IntToStr(VprDProduto.PesCartucho)+'g');
    end;
    ImprimeEtiqueta(false);
  end
  else
    aviso('ERRO NA LEITURA!!!'#13'Ocorreu um erro na leitura do peso.');
end;

{******************************************************************************}
procedure TFPesarCartucho.ECelulaTrabalhoCadastrar(Sender: TObject);
begin
  FCelulaTrabalho := tFCelulaTrabalho.CriarSDI(self,'',FPrincipal.VerificaPermisao('FCelulaTrabalho'));
  FCelulaTrabalho.BotaoCadastrar1.Click;
  FCelulaTrabalho.showmodal;
  FCelulaTrabalho.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFPesarCartucho.EProdutoChange(Sender: TObject);
begin
  ValidaGravacao1.execute;
end;

{******************************************************************************}
procedure TFPesarCartucho.BitBtn1Click(Sender: TObject);
begin
  FunArgox.VoltarEtiqueta;
end;

{******************************************************************************}
procedure TFPesarCartucho.EProdutoRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
  begin
    VprDProduto.SeqProduto := StrToInt(Retorno1);
    FunProdutos.CarDProduto(VprDProduto);
    CCilindroNovo.Checked := VprDProduto.IndCilindroNovo;
    CChipNovo.Checked := VprDProduto.IndChipNovo;
  end;
end;

{******************************************************************************}
procedure TFPesarCartucho.ReimprimirEtiqueta1Click(Sender: TObject);
begin
  ImprimeEtiqueta(true);
end;

{******************************************************************************}
procedure TFPesarCartucho.CCilindroNovoClick(Sender: TObject);
begin
//    CCilindroNovo.Checked := VprDProduto.IndCilindroNovo;
end;

{******************************************************************************}
procedure TFPesarCartucho.EPoRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
    VprSeqPo := StrToInt(Retorno1)
  else
    VprSeqPo := 0;
end;

{******************************************************************************}
procedure TFPesarCartucho.ECilindroRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
    VprSeqCilindro := StrToInt(Retorno1)
  else
    VprSeqCilindro := 0;
end;

{******************************************************************************}
procedure TFPesarCartucho.EChipRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
    VprSeqChip := StrToInt(Retorno1)
  else
    VprSeqChip := 0;
end;

{******************************************************************************}
procedure TFPesarCartucho.EPoSelect(Sender: TObject);
begin
  EPo.ASelectLocaliza.Text:= 'Select C_COD_PRO, C_NOM_PRO, I_SEQ_PRO from CADPRODUTOS'+
                             ' Where C_NOM_PRO like  ''@%'' '+
                             ' and C_ATI_PRO = ''S'' '+
                             ' AND C_COD_CLA LIKE '''+Varia.CodClassificacaoPoTinta+'%'' ';
  EPo.ASelectValida.Text:= 'Select * from CADPRODUTOS'+
                           ' Where C_COD_PRO = ''@'' and C_ATI_PRO = ''S'' '+
                           ' AND C_COD_CLA LIKE '''+Varia.CodClassificacaoPoTinta+'%'' ';
end;

{******************************************************************************}
procedure TFPesarCartucho.ECilindroSelect(Sender: TObject);
begin
  ECilindro.ASelectLocaliza.Text:= 'Select C_COD_PRO, C_NOM_PRO, I_SEQ_PRO from CADPRODUTOS'+
                                   ' Where C_NOM_PRO like  ''@%'' '+
                                   ' and C_ATI_PRO = ''S'' '+
                                   ' AND C_COD_CLA LIKE '''+Varia.CodClassificacaoCilindro+'%'' ';
  ECilindro.ASelectValida.Text:= 'Select * from CADPRODUTOS'+
                                 ' Where C_COD_PRO = ''@'' and C_ATI_PRO = ''S'''+
                                 ' AND C_COD_CLA LIKE '''+Varia.CodClassificacaoCilindro+'%'' ';
end;

{******************************************************************************}
procedure TFPesarCartucho.EChipSelect(Sender: TObject);
begin
  EChip.ASelectLocaliza.Text:= 'Select C_COD_PRO, C_NOM_PRO, I_SEQ_PRO from CADPRODUTOS'+
                               ' Where C_NOM_PRO like  ''@%'' '+
                               ' and C_ATI_PRO = ''S'' '+
                               ' AND C_COD_CLA LIKE '''+Varia.CodClassificacaoChip+'%'' ';
  EChip.ASelectValida.Text:= 'Select * from CADPRODUTOS'+
                             ' Where C_COD_PRO = ''@'' and C_ATI_PRO = ''S'' '+
                             ' AND C_COD_CLA LIKE '''+Varia.CodClassificacaoChip+'%'' ';
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFPesarCartucho]);
end.
