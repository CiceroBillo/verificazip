unit AConfiguracaoFaixasCadastro;
{          Autor: Sergio Luiz Censi
    Data Criação: 01/04/1999;
          Função: configurações das variáveis do sistema
  Data Alteração: 01/04/1999;
    Alterado por: Rafael Budag
Motivo alteração: - Adicionado os comentários e o blocos nas rotinas, e realizado
                    um teste - 01/04/199 / Rafael Budag
}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls, formularios,
  BotaoCadastro, Buttons, Componentes1, constantes,
  Registry, PainelGradiente, Tabela, DBCtrls, Db, DBTables, Mask;


type
  TFConfiguracoesFaixasCadastro = class(TFormularioPermissao)
    CFG: TTabela;
    DataCFG: TDataSource;
    PanelColor1: TPanelColor;
    PainelGradiente1: TPainelGradiente;
    BotaoAlterar1: TBotaoAlterar;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    Fechar: TBitBtn;
    kk0y: TPageControl;
    TabSheet2: TTabSheet;
    Label12: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    DBEditColor3: TDBEditColor;
    DBEditColor4: TDBEditColor;
    DBEditColor5: TDBEditColor;
    DBEditColor6: TDBEditColor;
    DBEditColor7: TDBEditColor;
    DBEditColor8: TDBEditColor;
    CFGI_VEN_MAX: TIntegerField;
    CFGI_VEN_MIN: TIntegerField;
    CFGI_TRA_MAX: TIntegerField;
    CFGI_TRA_MIN: TIntegerField;
    CFGI_CLI_MAX: TIntegerField;
    CFGI_CLI_MIN: TIntegerField;
    BBAjuda: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CFGAfterPost(DataSet: TDataSet);
    procedure FecharClick(Sender: TObject);
    procedure BBAjudaClick(Sender: TObject);
  private
  public
    { Public declarations }
  end;

var
  FConfiguracoesFaixasCadastro: TFConfiguracoesFaixasCadastro;

implementation

uses APrincipal;

{$R *.DFM}

{ (((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Modulo Básico
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{ ******************* Na Criacao do formulario ****************************** }
procedure TFConfiguracoesFaixasCadastro.FormCreate(Sender: TObject);
begin
   Self.HelpFile := Varia.PathHelp + 'MaConfSistema.HLP>janela';  // Indica o Paph e o nome do arquivo de Help
   CFG.open;
end;

{ ******************* No fechamento do formulário **************************** }
procedure TFConfiguracoesFaixasCadastro.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    CFG.close;
    action := cafree;
end;

{ *************** fecha o formulario *************************************** }
procedure TFConfiguracoesFaixasCadastro.FecharClick(Sender: TObject);
begin
close;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
              configurações de Inicialização do Sistema
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{ ******************* Apos Gravar as alterações na tabela CFG **************** }
procedure TFConfiguracoesFaixasCadastro.CFGAfterPost(DataSet: TDataSet);
begin
   CarregaCFG(FPrincipal.BaseDados);
end;



procedure TFConfiguracoesFaixasCadastro.BBAjudaClick(Sender: TObject);
begin
  Application.HelpCommand(HELP_CONTEXT,FConfiguracoesFaixasCadastro.HelpContext);
end;

Initialization
{*****************Registra a Classe para Evitar duplicidade********************}
   RegisterClasses([TFConfiguracoesFaixasCadastro]);
end.
