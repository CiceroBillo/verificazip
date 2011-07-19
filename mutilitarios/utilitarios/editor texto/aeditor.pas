unit AEditor;

interface

uses
  WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Menus,
  StdCtrls, Messages, Dialogs, SysUtils, APagina,
  ExtCtrls, Buttons;

type
  TFEditor = class(TForm)
    MainMenu1: TMainMenu;
    Abrir: TOpenDialog;
    File1: TMenuItem;
    MSair: TMenuItem;
    N3: TMenuItem;
    MAbrir: TMenuItem;
    MNovo: TMenuItem;
    MJanela: TMenuItem;
    Mcascata: TMenuItem;
    Mladoalado: TMenuItem;
    MFechaTudo: TMenuItem;
    SpeedBar: TPanel;
    BAbrir: TSpeedButton;
    BNovo: TSpeedButton;
    BImprimir: TSpeedButton;
    BVoltar: TSpeedButton;
    BRecortar: TSpeedButton;
    BCopiar: TSpeedButton;
    BColar: TSpeedButton;
    BNegrito: TSpeedButton;
    BItalico: TSpeedButton;
    BSublinhado: TSpeedButton;
    BDireita: TSpeedButton;
    BEsquerda: TSpeedButton;
    BCentralizado: TSpeedButton;

    { Initialization Event Handler }
    procedure FormCreate(Sender: TObject);

    { File Event Handlers }
    procedure MNovoClick(Sender: TObject);
    procedure MAbrirClick(Sender: TObject);
    procedure MSairClick(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);

    { Edit/Clipboard Event Handlers }
    procedure BVoltarClick(Sender: TObject);
    procedure BRecortarClick(Sender: TObject);
    procedure BCopiarClick(Sender: TObject);
    procedure BColarClick(Sender: TObject);

    { Window Event Handlers }
    procedure MladoaladoClick(Sender: TObject);
    procedure McascataClick(Sender: TObject);
    procedure MFechaTudoClick(Sender: TObject);

    { Text Event Handlers }
    procedure BNegritoClick(Sender: TObject);
    procedure BItalicoClick(Sender: TObject);
    procedure BSublinhadoClick(Sender: TObject);
    procedure Alinhamento(Sender: TObject);
  public
    { User defined methods }
    procedure HabilitaBotoes( acao : Boolean);
    procedure HabilitaBotoesFormato( acao : Boolean);
    procedure ConfiguraPagina;
  end;

var
  FEditor: TFEditor;

implementation
//uses FTypForm;


{$R *.DFM}

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          Inicializacao
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************* Cria Formulario ************************************** }
procedure TFEditor.FormCreate(Sender: TObject);
begin
  HabilitaBotoes(false); // Initialize visible speedbuttons
end;


{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Diversos
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{***************** habilita/ Desabilita os botoes *************************** }
procedure TFEditor.HabilitaBotoes( acao : Boolean);
begin
  BVoltar.Visible := acao;
  BRecortar.Visible := acao;
  BRecortar.Visible := acao;
  BColar.Visible := acao;
  BCopiar.Visible := acao;
  BNegrito.Visible := acao;
  BItalico.Visible := acao;
  BSublinhado.Visible := acao;
  BEsquerda.Visible := acao;
  BCentralizado.Visible := acao;
  BDireita.Visible := acao;
  if (ActiveMDIChild is TFPagina) and acao then
    TFPagina(ActiveMDIChild).ConfiguraBotoes
end;

procedure TFEditor.HabilitaBotoesFormato( acao : Boolean);
begin
  BNegrito.Visible := acao;
  BItalico.Visible := acao;
  BSublinhado.Visible := acao;
  BEsquerda.Visible := acao;
  BCentralizado.Visible := acao;
  BDireita.Visible := acao;
end;


{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Servico e funcoes
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************** nova pagina ****************************************** }
procedure TFEditor.MNovoClick(Sender: TObject);
begin
  FPagina := TFPagina.Create(self);
end;

{********************* abrir uma existente ********************************* }
procedure TFEditor.MAbrirClick(Sender: TObject);
var
  Ext: string[4];
begin

  if Abrir.Execute then
  begin
    FPagina := TFPagina.Create(self);
    FPagina.AbrirArquivo(Abrir.FileName);
  end;
end;

{************** fechar editor ************************************************ }
procedure TFEditor.MSairClick(Sender: TObject);
begin
  self.Close;
end;

{*************** imprimir documento ****************************************** }
procedure TFEditor.BImprimirClick(Sender: TObject);
begin
  if ActiveMDIChild is TFPagina then
    TFPagina(ActiveMDIChild).MnegritoClick(Sender)
end;

{************** desfazer **************************************************** }
procedure TFEditor.BVoltarClick(Sender: TObject);
begin
  if ActiveMDIChild is TFPagina then
    TFPagina(ActiveMDIChild).MdesfazerClick(Sender)
end;

{******************* recortar *********************************************** }
procedure TFEditor.BRecortarClick(Sender: TObject);
begin
  if ActiveMDIChild is TFPagina then
    TFPagina(ActiveMDIChild).MRecortarClick(Sender)
end;

{******************** copiar *********************************************** }
procedure TFEditor.BCopiarClick(Sender: TObject);
begin
  if ActiveMDIChild is TFPagina then
    TFPagina(ActiveMDIChild).McopiarClick(Sender)
end;

{************************ Colar ********************************************* }
procedure TFEditor.BColarClick(Sender: TObject);
begin
  if ActiveMDIChild is TFPagina then
    TFPagina(ActiveMDIChild).MColarClick(Sender)
end;

{********************** Lado a lado ****************************************** }
procedure TFEditor.MladoaladoClick(Sender: TObject);
begin
  Tile;
end;

{******************* cascata ************************************************* }
procedure TFEditor.McascataClick(Sender: TObject);
begin
  Cascade;
end;

{********************* fecha todas as janelas do editor ********************** }
procedure TFEditor.MFechaTudoClick(Sender: TObject);
var
  i: integer;
begin
  for i := MdiChildCount - 1 downto 0  do
    MDIChildren[i].Close;
end;

{*********************** Negrito *********************************************}
procedure TFEditor.BNegritoClick(Sender: TObject);
begin
  if ActiveMDIChild is TFPagina then
    TFPagina(ActiveMDIChild).MNegritoClick(Sender)
end;

{**************** Italico *************************************************** }
procedure TFEditor.BItalicoClick(Sender: TObject);
begin
  if ActiveMDIChild is TFPagina then
    TFPagina(ActiveMDIChild).MItalicoClick(Sender)
end;

{******************* Sublinado *********************************************** }
procedure TFEditor.BSublinhadoClick(Sender: TObject);
begin
  if ActiveMDIChild is TFPagina then
    TFPagina(ActiveMDIChild).MSublinhadoClick(Sender)
end;

{*************** Alinhamento do texto **************************************** }
procedure TFEditor.Alinhamento(Sender: TObject);
begin
  if ActiveMDIChild is TFPagina then
    TFPagina(ActiveMDIChild).CharAlignClick(Sender)
end;

{************** quando e cria uma nova pagina ******************************** }
procedure TFEditor.ConfiguraPagina;
begin
  if ActiveMDIChild <> nil then begin
    if (ActiveMDIChild is TFPagina) then
      HabilitaBotoes(true)
  end
  else
    HabilitaBotoes(false);
end;

end.
