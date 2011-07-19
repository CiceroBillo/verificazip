unit AObservacoesNota;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Db, Grids, DBGrids, Tabela, DBTables, ComCtrls, Componentes1, ExtCtrls,
  PainelGradiente, StdCtrls, BotaoCadastro, Buttons, DBKeyViolation, dbctrls, UnDadosProduto;

const
TamanhoLinha = 80;  //

type
  TFObservacoesNota = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    PanelColor3: TPanelColor;
    BitBtn1: TBitBtn;
    Label4: TLabel;
    PanelColor1: TPanelColor;
    MObs: TMemoColor;
    MNovoObs: TMemoColorLimite;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MNovoObsEnter(Sender: TObject);
    procedure MNovoObsExit(Sender: TObject);
    procedure MObsEnter(Sender: TObject);
    procedure MObsExit(Sender: TObject);
  private
  public
    procedure ObservacoesNota(TextoFiscal : String; Observacoes : TStringList; QtdCaracter : Integer);
    procedure ObservacaodaNota(VpaTextoFiscal : String; VpaDNota : TRBDNotaFiscal; VpaQtdLinhas : Integer);
  end;

var
  FObservacoesNota: TFObservacoesNota;

implementation

uses APrincipal, Constantes;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFObservacoesNota.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFObservacoesNota.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 { fecha tabelas }
 { chamar a rotina de atualização de menus }
 Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Eventos Diversos
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{**************Carrega a observação e a mostra deixando alterar****************}
procedure TFObservacoesNota.ObservacoesNota(TextoFiscal : String; Observacoes : TStringList; QtdCaracter : Integer);
begin
   MObs.clear;
   if TextoFiscal <> '' then
     MObs.Lines.Add(TextoFiscal);
   MNovoObs.AQdadeLinha := 15;
   MNovoObs.AQdadeCaracter := QtdCaracter;
   MNovoObs.Lines := Observacoes;
   canvas.Font := MObs.Font;
   MObs.Height := canvas.TextHeight('A') * MObs.Lines.Count;
   ShowModal;
   Observacoes.text := MNovoObs.Lines.Text;
end;

{******************************************************************************}
procedure TFObservacoesNota.ObservacaodaNota(VpaTextoFiscal : String; VpaDNota : TRBDNotaFiscal; VpaQtdLinhas : Integer);
begin
   MObs.clear;
   if VpaTextoFiscal <> '' then
     MObs.Lines.Add(VpaTextoFiscal);
   MNovoObs.AQdadeLinha := VpaQtdLinhas;
   MNovoObs.Lines.Text := VpaDNota.DesObservacao.text;
   canvas.Font := MObs.Font;
   MObs.Height := canvas.TextHeight('A') * MObs.Lines.Count;
   ShowModal;
   VpaDNota.DesObservacao.text := MNovoObs.Lines.Text;
end;

{**********************Fecha o formulario corrente*****************************}
procedure TFObservacoesNota.BitBtn1Click(Sender: TObject);
begin
  close;
end;

procedure TFObservacoesNota.FormShow(Sender: TObject);
begin
  MNovoObs.SetFocus;
end;

procedure TFObservacoesNota.MNovoObsEnter(Sender: TObject);
begin
  MObs.Color := MNovoObs.ACorFoco.ACorFundoFoco;
end;

procedure TFObservacoesNota.MNovoObsExit(Sender: TObject);
begin
  MObs.Color := MNovoObs.ACorFoco.AFundoComponentes;
end;

procedure TFObservacoesNota.MObsEnter(Sender: TObject);
begin
  MNovoObs.Color := MObs.ACorFoco.ACorFundoFoco;
end;

procedure TFObservacoesNota.MObsExit(Sender: TObject);
begin
  MNovoObs.Color := MObs.ACorFoco.AFundoComponentes;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFObservacoesNota]);
end.
