unit AInicializaNovoInventario;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, StdCtrls, Componentes1, Localizacao, Buttons, PainelGradiente, UnClassificacao,
  UnDadosProduto, UnInventario;

type
  TFInicializaNovoInventario = class(TFormularioPermissao)
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    PainelGradiente1: TPainelGradiente;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    Label3: TLabel;
    Label12: TLabel;
    SpeedButton6: TSpeedButton;
    Label13: TLabel;
    EFilial: TEditLocaliza;
    EUsuario: TEditLocaliza;
    Bevel1: TBevel;
    Localiza: TConsultaPadrao;
    Label1: TLabel;
    EClassificacao: TEditColor;
    SpeedButton9: TSpeedButton;
    LNomClassificacao: TLabel;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton9Click(Sender: TObject);
    procedure EClassificacaoExit(Sender: TObject);
    procedure EClassificacaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BGravarClick(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
  private
    { Private declarations }
    VprAcao : Boolean;
    VprDInventario : TRBDInventarioCorpo;
    FunClassificacao : TFuncoesClassificacao;
    FunInventario : TRBFuncoesInventario;
    procedure InicializaTela;
    function LocalizaClassificacao: Boolean;
    procedure CarDClasse;
  public
    { Public declarations }
    function NovoInventario : Boolean;
    function Duplicar(VpaDInventario : TRBDInventarioCorpo): Boolean;
  end;

var
  FInicializaNovoInventario: TFInicializaNovoInventario;

implementation

uses APrincipal, Constantes, ALocalizaClassificacao, ConstMsg;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFInicializaNovoInventario.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao := false;
  FunClassificacao := TFuncoesClassificacao.criar(self,FPrincipal.BaseDados);
  FunInventario := TRBFuncoesInventario.cria(fpRINCIPAL.bASEdaDOS);
  VprDInventario := TRBDInventarioCorpo.cria;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFInicializaNovoInventario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunInventario.free;
  VprDInventario.free;
  FunClassificacao.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFInicializaNovoInventario.InicializaTela;
begin
  EUsuario.AInteiro := varia.CodigoUsuario;
  EUsuario.Atualiza;
  EFilial.AInteiro := Varia.CodigoEmpFil;
  EFilial.Atualiza;
end;

{******************************************************************************}
function TFInicializaNovoInventario.LocalizaClassificacao : Boolean;
var
  VpfCodClassificacao, VpfNomClassificacao : string;
begin
  Result:= True;
  FLocalizaClassificacao:= TFLocalizaClassificacao.CriarSDI(application,'', true);
  if FLocalizaClassificacao.LocalizaClassificacao(VpfCodClassificacao,VpfNomClassificacao, 'P') then
  begin
    EClassificacao.Text:= VpfCodClassificacao;
    LNomClassificacao.Caption:= VpfNomClassificacao;
  end
  else
    Result:= False;
end;

{******************************************************************************}
procedure TFInicializaNovoInventario.CarDClasse;
begin
  VprDInventario.CodUsuario := EUsuario.AInteiro;
  VprDInventario.SeqInventario := 0;
  VprDInventario.CodFilial := EFilial.AInteiro;
  VprDInventario.CodClassificacao := EClassificacao.Text;
end;

{******************************************************************************}
function TFInicializaNovoInventario.Duplicar(VpaDInventario : TRBDInventarioCorpo): Boolean;
begin
  FunInventario.CarDInventario(VpaDInventario, VpaDInventario.CodFilial, VpaDInventario.SeqInventario);
  EFilial.AInteiro:= VpaDInventario.CodFilial;
  EFilial.Atualiza;
  EUsuario.AInteiro:= VpaDInventario.CodUsuario;
  EUsuario.Atualiza;
  EClassificacao.Text:= VpaDInventario.CodClassificacao;
  ShowModal;
  result := VprAcao;
end;

{******************************************************************************}
function TFInicializaNovoInventario.NovoInventario : Boolean;
begin
  InicializaTela;
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
procedure TFInicializaNovoInventario.SpeedButton9Click(Sender: TObject);
begin
  LocalizaClassificacao;
end;

{******************************************************************************}
procedure TFInicializaNovoInventario.EClassificacaoExit(Sender: TObject);
var
  VpfNomClassificacao : String;
begin
  if EClassificacao.Text <> '' then
  begin
    if not FunClassificacao.ValidaClassificacao(EClassificacao.Text,VpfNomClassificacao, 'P') then
    begin
      if not LocalizaClassificacao then
        EClassificacao.SetFocus;
    end
    else
    begin
      LNomClassificacao.Caption:= VpfNomClassificacao;
    end;
  end
  else
    LNomClassificacao.Caption:= '';
end;

{******************************************************************************}
procedure TFInicializaNovoInventario.EClassificacaoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = 114 then
    LocalizaClassificacao;
end;

{******************************************************************************}
procedure TFInicializaNovoInventario.BGravarClick(Sender: TObject);
var
  VpfResultado : String;
begin
  CarDClasse;
  VpfResultado := FunInventario.GravaDInventario(VprDInventario);
  if VpfResultado <> '' then
    aviso(VpfResultado)
  else
  begin
    VprAcao := true;
    close;
  end;
end;

{******************************************************************************}
procedure TFInicializaNovoInventario.BCancelarClick(Sender: TObject);
begin
  close;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFInicializaNovoInventario]);
end.
