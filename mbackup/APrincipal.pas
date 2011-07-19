unit APrincipal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Componentes1, Buttons, PainelGradiente, ExtCtrls, Db, DBTables,
  ComCtrls, Gauges, UnImporta, Menus;

const
  CampoPermissaoModulo = 'c_mod_pon';
  NomeModulo = 'Backup';

type
  TFPrincipal = class(TForm)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    CorPainelGra1: TCorPainelGra;
    CorFoco1: TCorFoco;
    CorForm1: TCorForm;
    BExecutar: TBitBtn;
    BFechar: TBitBtn;
    EOrigem: TComboBoxColor;
    EDestino: TComboBoxColor;
    Label1: TLabel;
    Label2: TLabel;
    PTabela: TProgressBar;
    Posicao: TGauge;
    StatusBar1: TStatusBar;
    LNomTabela: TLabel;
    BaseOrigem: TDatabase;
    BaseDestino: TDatabase;
    PopupMenu1: TPopupMenu;
    Restaurar1: TMenuItem;
    BaseDados: TDatabase;
    procedure FormCreate(Sender: TObject);
    procedure EOrigemClick(Sender: TObject);
    procedure EDestinoClick(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure BExecutarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Restaurar1Click(Sender: TObject);
  private
    { Private declarations }
    FunImportacao : TRBFuncoesImporta;
  public
    { Public declarations }
  end;

var
  FPrincipal: TFPrincipal;

implementation

Uses FunObjeto, Constantes, ConstMsg, UnAtualizacao;

{$R *.DFM}

{******************************************************************************}
procedure TFPrincipal.FormCreate(Sender: TObject);
begin
  FunImportacao := TRBFuncoesImporta.cria;
  Session.GetAliasNames(EOrigem.Items);
  Session.GetAliasNames(EDestino.Items);
end;

{******************************************************************************}
procedure TFPrincipal.EOrigemClick(Sender: TObject);
Var
  Atualizacao : TAtualiza;
begin
  BaseOrigem.Close;
  BaseOrigem.AliasName := EOrigem.Text;
  AbreBancoDadosAlias(BaseOrigem,EOrigem.Text,CT_DIRETORIOREGEDIT);
  Atualizacao := TAtualiza.Criar(self, FPrincipal.BaseOrigem);
  Atualizacao.AtualizaBanco;
  Atualizacao.Free;
end;

{******************************************************************************}
procedure TFPrincipal.EDestinoClick(Sender: TObject);
Var
  Atualizacao : TAtualiza;
begin
  BaseDestino.Close;
  BaseDestino.AliasName := EDestino.Text;
  AbreBancoDadosAlias(BaseDestino,EDestino.Text,CT_DIRETORIOREGEDIT);
  Atualizacao := TAtualiza.Criar(self, FPrincipal.BaseDestino);
  Atualizacao.AtualizaBanco;
  Atualizacao.Free;
end;

{******************************************************************************}
procedure TFPrincipal.BFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFPrincipal.BExecutarClick(Sender: TObject);
begin
  if not BaseOrigem.Connected then
    aviso('BASE DADOS ORIGEM NÃO CONECTADO!!!'#13'A base de dados de origem não está conectado.')
  else
    if not BaseDestino.Connected then
      aviso('BASE DADOS DESTINO NÃO CONECTADO!!!'#13'A base de dados destino não está conectado.')
    else
    begin
      FunImportacao.ImportadaDados(StatusBar1,LNomTabela,PTabela,Posicao);
    end;
end;

{******************************************************************************}
procedure TFPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FunImportacao.free;
end;

procedure TFPrincipal.Restaurar1Click(Sender: TObject);
begin
  FunImportacao.ApagaInformacoes;
end;

end.
