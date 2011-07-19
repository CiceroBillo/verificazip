unit FEditor;

interface

uses
  WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Menus,
  StdCtrls, Messages, Dialogs, SysUtils, MDIEdit,
  ExtCtrls, Buttons;

type
  TMainForm = class(TForm)
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
    BSalvar: TSpeedButton;
    BImprimir: TSpeedButton;
    BVoltar: TSpeedButton;
    BRecortar: TSpeedButton;
    BCopiar: TSpeedButton;
    BColar: TSpeedButton;
    Bevel1: TBevel;
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
    procedure ConfiguraPagina;
  end;

var
  MainForm: TMainForm;

implementation
//uses FTypForm;


{$R *.DFM}

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          Inicializacao
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************* Cria Formulario ************************************** }
procedure TMainForm.FormCreate(Sender: TObject);
begin
  HabilitaBotoes(false); // Initialize visible speedbuttons
end;


{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Diversos
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{***************** habilita/ Desabilita os botoes *************************** }
procedure TMainForm.HabilitaBotoes( acao : Boolean);
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
  if (ActiveMDIChild is TEditForm) and acao then
    TEditForm(ActiveMDIChild).ConfiguraBotoes
end;


{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Servico e funcoes
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************** nova pagina ****************************************** }
procedure TMainForm.MNovoClick(Sender: TObject);
begin
  EditForm := TEditForm.Create(self);
end;

{********************* abrir uma existente ********************************* }
procedure TMainForm.MAbrirClick(Sender: TObject);
var
  Ext: string[4];
begin
  if Abrir.Execute then
  begin
    EditForm := TEditForm.Create(self);
    EditForm.AbrirArquivo(Abrir.FileName);
  end;
end;

{************** fechar editor ************************************************ }
procedure TMainForm.MSairClick(Sender: TObject);
begin
  self.Close;
end;

{*************** imprimir documento ****************************************** }
procedure TMainForm.BImprimirClick(Sender: TObject);
begin
  if ActiveMDIChild is TEditForm then
    TEditForm(ActiveMDIChild).Bold1Click(Sender)
end;

{************** desfazer **************************************************** }
procedure TMainForm.BVoltarClick(Sender: TObject);
begin
  if ActiveMDIChild is TEditForm then
    TEditForm(ActiveMDIChild).Undo1Click(Sender)
end;

{******************* recortar *********************************************** }
procedure TMainForm.BRecortarClick(Sender: TObject);
begin
  if ActiveMDIChild is TEditForm then
    TEditForm(ActiveMDIChild).Cut1Click(Sender)
end;

{******************** copiar *********************************************** }
procedure TMainForm.BCopiarClick(Sender: TObject);
begin
  if ActiveMDIChild is TEditForm then
    TEditForm(ActiveMDIChild).Copy1Click(Sender)
end;

{************************ Colar ********************************************* }
procedure TMainForm.BColarClick(Sender: TObject);
begin
  if ActiveMDIChild is TEditForm then
    TEditForm(ActiveMDIChild).Paste1Click(Sender)
end;

{********************** Lado a lado ****************************************** }
procedure TMainForm.MladoaladoClick(Sender: TObject);
begin
  Tile;
end;

{******************* cascata ************************************************* }
procedure TMainForm.McascataClick(Sender: TObject);
begin
  Cascade;
end;

{********************* fecha todas as janelas do editor ********************** }
procedure TMainForm.MFechaTudoClick(Sender: TObject);
var
  i: integer;
begin
  for i := MdiChildCount - 1 downto 0  do
    MDIChildren[i].Close;
end;

{*********************** Negrito *********************************************}
procedure TMainForm.BNegritoClick(Sender: TObject);
begin
  if ActiveMDIChild is TEditForm then
    TEditForm(ActiveMDIChild).Bold1Click(Sender)
end;

{**************** Italico *************************************************** }
procedure TMainForm.BItalicoClick(Sender: TObject);
begin
  if ActiveMDIChild is TEditForm then
    TEditForm(ActiveMDIChild).Italic1Click(Sender)
end;

{******************* Sublinado *********************************************** }
procedure TMainForm.BSublinhadoClick(Sender: TObject);
begin
  if ActiveMDIChild is TEditForm then
    TEditForm(ActiveMDIChild).Underline1Click(Sender)
end;

{*************** Alinhamento do texto **************************************** }
procedure TMainForm.Alinhamento(Sender: TObject);
begin
  if ActiveMDIChild is TEditForm then
    TEditForm(ActiveMDIChild).CharAlignClick(Sender)
end;

{************** quando e cria uma nova pagina ******************************** }
procedure TMainForm.ConfiguraPagina;
begin
  if ActiveMDIChild <> nil then begin
    if (ActiveMDIChild is TEditForm) then
      HabilitaBotoes(true)
  end
  else
    HabilitaBotoes(false);
end;

end.
