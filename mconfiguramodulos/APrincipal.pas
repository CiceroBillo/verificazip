unit APrincipal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, DBTables, ComCtrls, ExtCtrls, StdCtrls, Buttons,  formulariosFundo, Formularios,
  ToolWin, ExtDlgs, Inifiles, constMsg, FunObjeto, Db, DBCtrls, Grids,
  DBGrids, Componentes1, PainelGradiente, Tabela, Localizacao,Mask;

Const
  NOMEMODULO = 'MODULOS';

type
  TFPrincipal = class(TFormularioFundo)
    Menu: TMainMenu;
    MArquivo: TMenuItem;
    MSair: TMenuItem;
    CorFoco: TCorFoco;
    CorForm: TCorForm;
    CorPainelGra: TCorPainelGra;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    BCascata: TSpeedButton;
    BLadoaLado: TSpeedButton;
    BNormal: TSpeedButton;
    ToolButton1: TToolButton;
    Modulo1: TMenuItem;
    ConfiguraesModulos1: TMenuItem;
    Registro1: TMenuItem;
    GeraRegistro1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure MenuClick(Sender: TObject);
  private
  public
     ImagemPrincipal : integer;
     procedure erro(Sender: TObject; E: Exception);
  end;


var
  FPrincipal: TFPrincipal;
  Ini : TInifile;

implementation

uses FunIni, AconfiguraModulos, AGeraNumero, AConfigRelatorios;


{$R *.DFM}


// ------------------ Na criação do Formulário -------------------------------- }
procedure TFPrincipal.FormCreate(Sender: TObject);
begin
 Application.HintColor := $00EDEB9E;        // cor padrão dos hints
 Application.Title := 'Sistema Gerencial';  // nome a ser mostrado na barra de tarefa do Windows
 Application.OnException := Erro;
end;

procedure TFPrincipal.erro(Sender: TObject; E: Exception);
begin
  Aviso(E.Message);
end;

// ------------------- Quando o formulario e fechado -------------------------- }
procedure TFPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := CaFree;
end;

// -------------------- Quando o Formulario é Iniciado ------------------------ }
procedure TFPrincipal.FormShow(Sender: TObject);
begin
 FPrincipal.WindowState := wsMaximized;  // coloca a janela maximizada;
end;

{************************  M E N U   D O   S I S T E M A  ********************* }
procedure TFPrincipal.MenuClick(Sender: TObject);
begin
  if Sender is TComponent  then
  case ((Sender as TComponent).Tag) of
             // ----- Formulario de Empresas ----- //
    1400 : Close;
    2100 : begin
             FConfiguracoesModulos := TFConfiguracoesModulos.criarSDI(self, '', true);
             FConfiguracoesModulos.ShowModal;
           end;
    3100 : begin
             FgeraNumero := TFgeraNumero.Create(self);
             FGeraNumero.showModal;
           end;  
  end;
end;


end.
