unit AAlterarSenha;
{          Autor: Sergio Luiz Censi
    Data Criação: 01/04/1999;
          Função: Altera a senha do usuário
  Data Alteração: 01/04/1999;
    Alterado por: Rafael Budag
Motivo alteração: - Adicionado os comentários e o blocos nas rotinas, e realizado
                    um teste - 01/04/199 / rafael Budag
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Db, DBTables, constMsg,
  constantes, formularios, FunValida, LabelCorMove, Componentes1,
  PainelGradiente, DBClient, Tabela;

type
  TFAlteraSenha = class(TFormularioPermissao)
    Usuarios: TSQL;
    UsuariosI_COD_USU: TFMTBCDField;
    UsuariosC_NOM_USU: TWideStringField;
    UsuariosC_NOM_LOG: TWideStringField;
    UsuariosC_SEN_USU: TWideStringField;
    UsuariosC_USU_ATI: TWideStringField;
    PainelGradiente1: TPainelGradiente;
    UsuariosI_EMP_FIL: TFMTBCDField;
    PanelColor1: TPanelColor;
    Label2: TLabel;
    SenhaAtual: TEditColor;
    Label1: TLabel;
    NovaSenha: TEditColor;
    Label3: TLabel;
    ConfSenha: TEditColor;
    AbeCancela: TBitBtn;
    OK: TBitBtn;
    UsuariosD_DAT_MOV: TSQLTimeStampField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SenhaAtualExit(Sender: TObject);
    procedure AbeCancelaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FAlteraSenha: TFAlteraSenha;

implementation

uses APrincipal, funSql;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFAlteraSenha.FormCreate(Sender: TObject);
begin
  Usuarios.open;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFAlteraSenha.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Usuarios.close;
 Action := cafree;
end;

{ ****************** Altera a Senha do Usuário ******************************* }
procedure TFAlteraSenha.OKClick(Sender: TObject);
begin
if (varia.Senha = Criptografa(SenhaAtual.text)) then
begin
   if NovaSenha.Text <> ConfSenha.Text Then
      Messagedlg(CT_ConfirmaSenha,mtWarning,[mbok],0)
   else
     if NovaSenha.Text = '' then
       aviso('NOVA SENHA EM BRANCO!!!'#13'É necessário digitar uma nova senha')
     else
       if NovaSenha.text <> ConfSenha.Text then
         aviso('CONFIRMAÇÃO DA SENHA INVÁLIDA!!!'#13'A confirmação da senha é diferente da nova senha. Digite novamente.')
       else
       begin
         AdicionaSqlAbreTabela(Usuarios,'Select * from CADUSUARIOS '+
                           ' Where I_COD_USU = '+inttoStr(varia.CodigoUsuario));
         Usuarios.Edit;
         UsuariosC_SEN_USU.Value := Criptografa(NovaSenha.text);
         Usuarios.Post;
         beep;
         Messagedlg(CT_SenhaAlterada,mtConfirmation,[mbok],0);
         FAlteraSenha.Close;
     end;
end
else
begin
  beep;
  Messagedlg(CT_SenhaInvalida,mtWarning,[mbok],0);
  SenhaAtual.SetFocus;
end;
end;

{ ******** Habilita Ok quando todas os edit estiverem diferente de vazio ***** }
procedure TFAlteraSenha.SenhaAtualExit(Sender: TObject);
begin
end;


{ *************** fecha o formulário ***************************************** }
procedure TFAlteraSenha.AbeCancelaClick(Sender: TObject);
begin
FAlteraSenha.Close;
end;


{ *************** Registra a classe para evitar duplicidade ****************** }
procedure TFAlteraSenha.FormShow(Sender: TObject);
begin
self.Color := FPrincipal.CorForm.ACorPainel;
end;



Initialization
 RegisterClasses([TFAlteraSenha]);
end.

