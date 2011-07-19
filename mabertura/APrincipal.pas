unit APrincipal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, LabelCorMove, PainelGradiente, ExtCtrls, Icones, Menus, Buttons, Shellapi,
  DBTables, Componentes1, IniFiles, Registry, Db, UnSistema, WideStrings,
  DBXOracle, SqlExpr, FMTBcd, unPrincipal;

const
  NomeModulo = 'Siscorp';

type
  TFPrincipal = class(TForm)
    IconeBarraStatus1: TIconeBarraStatus;
    PopupMenu1: TPopupMenu;
    MFinanceiro: TMenuItem;
    MPontodeLoja: TMenuItem;
    MFaturamento: TMenuItem;
    MEstoque: TMenuItem;
    ConfiguraesSistema1: TMenuItem;
    N1: TMenuItem;
    Ocultar1: TMenuItem;
    Sair1: TMenuItem;
    Panel1: TPanel;
    Financeiro: TBitBtn;
    BPontoLoja: TBitBtn;
    BFaturamento: TBitBtn;
    BEstoqueCusto: TBitBtn;
    BSistema: TBitBtn;
    BSuporteRemoto: TBitBtn;
    BLogado: TSpeedButton;
    MChamado: TMenuItem;
    BarraLateral: TPainelGradiente;
    LUsuario: TLabel;
    CorFoco: TCorFoco;
    MSempreVisivel: TMenuItem;
    MMostraTexto: TMenuItem;
    CorPainelGra: TCorPainelGra;
    Alinhamento1: TMenuItem;
    MDireita: TMenuItem;
    Mesquerda: TMenuItem;
    MSuperior: TMenuItem;
    MInferior: TMenuItem;
    N2: TMenuItem;
    RestauraBackup1: TMenuItem;
    N3: TMenuItem;
    OpenDialog1: TOpenDialog;
    Aux: TSQLQuery;
    BChamadoTecnico: TBitBtn;
    BCRM: TBitBtn;
    MCRM: TMenuItem;
    BCaixa: TBitBtn;
    MCaixa: TMenuItem;
    BASEDADOS: TSQLConnection;
    BPDV: TBitBtn;
    CorForm: TCorForm;
    BSair: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure Ocultar1Click(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MenuClick(Sender: TObject);
    procedure BLogadoClick(Sender: TObject);
    procedure MSempreVisivelClick(Sender: TObject);
    procedure IconeBarraStatus1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure MMostraTextoClick(Sender: TObject);
    procedure MesquerdaClick(Sender: TObject);
    procedure RestauraBackup1Click(Sender: TObject);
    procedure BSuporteRemotoClick(Sender: TObject);
  private
    VprUsuarioLogado,
    VprAtualizarSistema : Boolean;
    VprNomeModulos : TStringList;
    UnPri : TFuncoesPrincipal;
    VprAlinhamento : integer; // 0 direita, 1 esquerda, 2 top, 3 base
    VprTopo,VprAlturaBotao, VprLarguraBotao, VprLeft, VprMaiorLargura : Integer;
    VprDiretorioCorrente : String;
    function UsuarioOk : boolean;
    procedure EscondeTexto(mostrar : Boolean );
    procedure AlinhaBotao( Botao : TBitBtn);
    procedure OrganizaBarra;
    procedure GravaIni;
    procedure LeIni;
    procedure ConfiguraTela;
    procedure CarregaNomeModulos;
    function HandleSistema(VpaNomeModulo : String) : THandle;
    procedure FechaAplicativos;
    procedure RestauraBackup(VpaNomArquivo : String);
    procedure ApagaBancoRestaurado;
    function RAtualizarSistema : Boolean;
    procedure CopiaNovaVersao;
    procedure BaixaVersao;
  public
    { Public declarations }
    VplParametroBaseDados: String;
    Function ProgramaEmExecucao(VpaNomePrograma : String):Boolean;
    function AbreBaseDados( VpaAlias : string ) : Boolean;
    procedure CarregaNomeUsuario;
    procedure MostraMenssagemDemostracao;
    procedure ResetaIni;
    Function  VerificaPermisao( nome : string ) : Boolean;
  end;

var
  VglParametroOficial : String;
  FPrincipal: TFPrincipal;
  CampoFormModulos : String;
  CampoPermissaoModulo : string;

implementation

Uses FunString, Constantes, FunObjeto, Abertura, FunValida,ConstMsg, FunArquivos, funSql,
  AMenssagemAtualizando, FunSistema;
{$R *.DFM}

{****************** quando o formulario é criado ******************************}
procedure TFPrincipal.FormCreate(Sender: TObject);
begin
  VprNomeModulos := TStringList.Create;
  UnPri := TFuncoesPrincipal.criar(self, BaseDados, NomeModulo);
  VprDiretorioCorrente := RetornaDiretorioCorrente;
  Sistema := TRBFuncoesSistema.Cria(baseDados);
  IconeBarraStatus1.AAtiva := true;
  IconeBarraStatus1.AVisible := true;
  VprUsuarioLogado := false;
  CarregaNomeModulos;
  CampoPermissaoModulo := 'SISCORP';

  Varia := TVariaveis.Cria(BaseDados);   // classe das variaveis principais
  Config := TConfig.Create;     // Classe das variaveis Booleanas
  ConfigModulos := TConfigModulo.create; // classe das variaveis de configuracao do modulo.

  LeIni;
  ConfiguraTela;
  Ocultar1.Checked := false; // nunca inicia oculto
end;

{******************** quando o formulario é mostrado **************************}
procedure TFPrincipal.FormShow(Sender: TObject);
var
  H : HWnd;
begin
 // configuracoes do usuario
  UnPri.ConfigUsu(varia.CodigoUsuario, CorFoco, CorForm, CorPainelGra, Self );
  Sistema.VerificaArquivosAuxiliares;
  //esconte o botão da barra de tarefas quando o programa estiver executando
  H := FindWindow(Nil,'SisCorp');
  if H <> 0 then
    ShowWindow(H,SW_HIDE);
end;

{****************** quando o formulario e fechado *****************************}
procedure TFPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  BaseDados.Close;
  FechaAplicativos;
  UnPri.Free;
  ApagaBancoRestaurado;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                             eventos do menu suspensos
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{***************** oculata a tela com os botões *******************************}
procedure TFPrincipal.Ocultar1Click(Sender: TObject);
begin
  Ocultar1.Checked := not Ocultar1.Checked;
  Visible := not Ocultar1.Checked;
end;

{******************** deixa a janela sempre visivel ***************************}
procedure TFPrincipal.MSempreVisivelClick(Sender: TObject);
begin
  MSempreVisivel.Checked := not MSempreVisivel.Checked;
  if MSempreVisivel.Checked then
    FormStyle := fsStayOnTop
  else
    FormStyle := fsNormal;
  GravaIni;
end;

{****************** mostra ou naum os texto da barra ************************ }
procedure TFPrincipal.MMostraTextoClick(Sender: TObject);
begin
  MMostraTexto.Checked := not MMostraTexto.Checked;
  EscondeTexto(MMostraTexto.Checked);
  ConfiguraTela;
  GravaIni;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                             eventos do usuario
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************** abre base de dados **************************************}
function TFPrincipal.AbreBaseDados( VpaAlias : string ) : Boolean;
Var
  VpfAliasOracle : string;
begin
  if VpaAlias = '' then
    VpaAlias := 'SisCorp';
  if ExisteLetraString('/',VpaAlias)  then
  begin
    VpfAliasOracle := DeleteAteChar(VpaAlias,'/');
    VpaAlias := CopiaAteChar(VpaAlias,'/');
  end
  else
    if UpperCase(VpaAlias) = 'EFICACIA' then
      VpfAliasOracle := 'Eficacia'
    else
      VpfAliasOracle := 'SisCorp';

  Result := true;
  BaseDados.close;
  BaseDados.Params.clear;
  BaseDados.Params.add('drivername=Oracle');
  BaseDados.Params.add('Database='+VpfAliasOracle);
  BaseDados.Params.add('decimal separator=,');
  BaseDados.Params.add('Password=1298');
  if UpperCase(VpaAlias) = 'SISCORP' then
    BaseDados.Params.add('User_Name=system')
  else
    BaseDados.Params.add('User_Name='+VpaAlias);
  BaseDados.Open;
end;

{******************** carrega o nome do usuario *******************************}
procedure TFPrincipal.CarregaNomeUsuario;
var
  VpfLaco : Integer;
begin
  LUsuario.Caption :='';
  for VpfLaco := 1 to length(Varia.usuario) do
    LUsuario.Caption := LUsuario.Caption + Varia.Usuario[VpfLaco]+ ' ';
  ConfiguraTela;
  VprUsuarioLogado := true;
end;

{************** mostra a menssagem que é versao demonstração ******************}
procedure TFPrincipal.MostraMenssagemDemostracao;
begin
  aviso('VERSÃO DEMONSTRAÇÃO!!!'+ Char(13)+ Char(13)+ 'Esta verão do sistema é de demonstração, para poder utilizar os sistemas utlize o Usuário = 99 e Senha = 99');

end;

{***************** verifica se o usuario esta ok ******************************}
function TFPrincipal.UsuarioOk : boolean;
var
  VpfAcao : Boolean;
begin
  result := false;
  if VprUsuarioLogado Then
    Result := true
  else
  begin
    VpfAcao := true;
    if not BaseDados.Connected Then
      VpfAcao :=  AbreBaseDados(VplParametroBaseDados);
    if VpfAcao Then
    begin
      FAbertura := TFAbertura.Create(Application);
      FAbertura.ShowModal;
      FAbertura.free;
      if Varia.StatusAbertura = 'OK' then
      begin
        VprUsuarioLogado := True;
        result := true;
        CarregaNomeUsuario;
        BLogado.Down := true;
      end
    end;
  end;
  if result then
    VprAtualizarSistema := RAtualizarSistema;
end;

function TFPrincipal.VerificaPermisao(nome: string): Boolean;
begin
  result := true;
end;

{***************** organiza sempre a barra na esquerda ***********************}
procedure TFPrincipal.OrganizaBarra;
begin
  case VprAlinhamento of
    0 :  begin
          self.Top := 0;
          self.left := (Screen.Width - self.Width);
          BarraLateral.Align := alRight;
          CorPainelGra.AEfeitosDeFundos := bdTopo;
          BarraLateral.AConfiguracoes := CorPainelGra;
         end;
    1 :  begin
          self.Top := 0;
          BarraLateral.Align := alLeft;
          self.left := 0;
          CorPainelGra.AEfeitosDeFundos := bdTopo;
          BarraLateral.AConfiguracoes := CorPainelGra;
        end;
    2 :  begin
          self.Top := 0;
          self.left := 0;
          BarraLateral.Align := alTop;
          LUsuario.WordWrap := false;
          CorPainelGra.AEfeitosDeFundos := bdEsquerda;
          BarraLateral.AConfiguracoes := CorPainelGra;
        end;
    3 :  begin
          self.Top := Screen.Height - self.Height - 28;
          self.left := 0;
          BarraLateral.Align := alTop;
          CorPainelGra.AEfeitosDeFundos := bdEsquerda;
          BarraLateral.AConfiguracoes := CorPainelGra;
        end;

  end;
end;

{************* grava configuracoes no regedit ******************************* }
procedure TFPrincipal.GravaIni;
var
 Ini : TRegIniFile;
begin
  Ini := TRegIniFile.Create('Software\Eficacia\Sistema');
  Ini.WriteBool('BARRA_SISCORP','SEMPREVISIVEL', MSempreVisivel.Checked);
  Ini.WriteBool('BARRA_SISCORP','MOSTRATEXTO', MMostraTexto.Checked);
  Ini.WriteInteger('BARRA_SISCORP','ALINHAMENTO', VprAlinhamento);
end;

{************* le configuracoes no regedit *88****************************** }
procedure TFPrincipal.LeIni;
var
 Ini : TRegIniFile;
begin
  Ini := TRegIniFile.Create('Software\Eficacia\Sistema');
  MSempreVisivel.Checked := Ini.ReadBool('BARRA_SISCORP','SEMPREVISIVEL', false);
  MMostraTexto.Checked := Ini.ReadBool('BARRA_SISCORP','MOSTRATEXTO', true );
  VprAlinhamento := Ini.ReadInteger('BARRA_SISCORP','ALINHAMENTO', 0);

  case VprAlinhamento of
    0 : MDireita.Checked := true;
    1 : MEsquerda.Checked := true;
    2 : MSuperior.Checked := true;
    3 : MInferior.Checked := true;
  end;
  if MSempreVisivel.Checked then
    FormStyle := fsStayOnTop
  else
    FormStyle := fsNormal;
  EscondeTexto(MMostraTexto.Checked);
end;

{*********** esconde todos os textos dos botoes *****************************}
procedure TFPrincipal.EscondeTexto(mostrar : Boolean );
var
  laco : integer;
begin
  for laco := 0 to self.ComponentCount - 1 do
  begin
    if (self.Components[laco] is TbitBtn) then
    begin
      if not mostrar then
      begin
        (self.Components[laco] as TbitBtn).Caption := '';
        (self.Components[laco] as TbitBtn).Width := 45;
        BLogado.Width := 45;
        self.Width := 78;
      end
      else
      begin
        (self.Components[laco] as TbitBtn).Caption := (self.Components[laco] as TbitBtn).hint;
        (self.Components[laco] as TbitBtn).Width := 140;
        BLogado.Width := 140;
        self.Width := 175;
      end;
    end;
  end;
end;


{******************** alinha o botao ****************************************}
procedure  TFPrincipal.AlinhaBotao( Botao : TBitBtn);
begin
    if Botao.Visible then
    begin
      case VprAlinhamento of
        0, 1 : begin
                 Botao.Top := VprTopo;
                 Botao.Left := VprLeft;
                 VprTopo := VprTopo + Botao.Height-1;
             end;
        2,3 : begin
                botao.Top := VprTopo;
                botao.Left := VprLeft;
                Vprleft := Vprleft + VprLarguraBotao;
                // caso seja maior que a tela
                if (VprLeft + VprLarguraBotao) > screen.Width then
                begin
                  VprLeft := 4;
                  VprTopo := VprTopo + VprAlturaBotao;
                end;
               if VprLeft > VprMaiorLargura then
                 VprMaiorLargura := VprLeft;
           end;
      end;
    end;
end;

{************  configura a tela conforme os modulos disponiveis ***************}
procedure TFPrincipal.ConfiguraTela;
begin
  try
    if VglParametroOficial <> '0' then
    begin
      // le arquivo de configuracoes

      // configura botoes visiveis
      Financeiro.Visible := CONFIG.ModuloFinanceiro;
      BPontoLoja.Visible := Config.ModuloPontoVenda;
      BChamadoTecnico.Visible := Config.ModuloChamado;
      BFaturamento.Visible := Config.ModuloFaturamento;
      BEstoqueCusto.Visible := Config.ModuloEstoque;
      BCRM.Visible := Config.ModuloCRM;
      BCaixa.Visible := Config.ModuloCaixa;
      BPDV.Visible := Config.ModuloPDV;
      BSistema.Visible := Config.ModuloConfiguracoesSistema;
    end;

    // configura menu
    MFinanceiro.Visible := Financeiro.Visible;
    MPontodeLoja.Visible := BPontoLoja.Visible;
    MFaturamento.Visible := BFaturamento.Visible;
    MEstoque.Visible := BEstoqueCusto.Visible;
    MChamado.Visible := BChamadoTecnico.Visible;
    MCRM.Visible := BCRM.Visible;
    MCaixa.visible := BCaixa.visible;

    // muda posicao
    VprAlturaBotao := 41;
    VprLarguraBotao := BFaturamento.Width;
    VprMaiorLargura := VprLarguraBotao;
    VprTopo := 3;
    VprLeft := 4;

    if Financeiro.Visible then
      AlinhaBotao(Financeiro);
    if BPontoLoja.Visible then
      AlinhaBotao(BPontoLoja);
    if BPDV.Visible then
      AlinhaBotao(BPDV);
    if BFaturamento.Visible then
      AlinhaBotao(BFaturamento);
    if BEstoqueCusto.Visible then
      AlinhaBotao(BEstoqueCusto);
    if BChamadoTecnico.Visible then
      AlinhaBotao(BChamadoTecnico);
    if BCRM.Visible then
      AlinhaBotao(BCRM);
    if BCaixa.Visible then
      AlinhaBotao(BCaixa);

    AlinhaBotao(BSistema);
    AlinhaBotao(BSuporteRemoto);
    AlinhaBotao(BSair);

    if VprAlinhamento in [0,1] then
    begin
      BLogado.Top := VprTopo;
      BLogado.Left := VprLeft;
      VprTopo := VprTopo + VprAlturaBotao;
      // formualrio
      self.Height := VprTopo + VprAlturaBotao - 12;
      self.Width := 35 + VprLarguraBotao;
    end
    else
    begin
      BLogado.Left := Vprleft;
      BLogado.Top := VprTopo;
      VprLeft := Vprleft + VprLarguraBotao;
      // formulario
      self.Width := VprMaiorLargura + VprLarguraBotao + 9;
      self.Height := VprTopo + VprAlturaBotao + 103;
    end;

    OrganizaBarra;

  except
  end;
end;

{*********************** reseta o arquivo ini *********************************}
procedure TFPrincipal.ResetaIni;
var
  VpfArquivoIni : TIniFile;
  VpfLaco : Integer;
begin
  try
    VpfArquivoIni := TIniFile.Create(VprDiretorioCorrente +'\'+ varia.ParametroBase + '.ini');
    for VpfLaco := 0 to VprNomeModulos.Count -1 do
      VpfArquivoIni.WriteInteger(VprNomeModulos.Strings[Vpflaco],'EmUso',0);
    VpfArquivoIni.free;
  except
    aviso('Erro na gravação do arquivo ');
  end;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                             eventos dos botoes
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************** sai fora do formulario ********************************}
procedure TFPrincipal.Sair1Click(Sender: TObject);
begin
 close;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                             eventos diversos
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{*********** retorna se o programa esto ou nao em execução ********************}
Function TFPrincipal.ProgramaEmExecucao(VpaNomePrograma : String) : Boolean;
var
hHandle : THandle;
begin
  hHandle := FindWindow( nil,StrToPChar(VpaNomePrograma));
  if hHandle <> 0 then
   result := true
  else
   result := false;
end;

{***************** carrega os nomes dos modulos *******************************}
procedure TFPrincipal.CarregaNomeModulos;
begin
  VprNomeModulos.Clear;
  VprNomeModulos.add('Financeiro');
  VprNomeModulos.Add('Ponto de Venda');
  VprNomeModulos.Add('Faturamento');
  VprNomeModulos.Add('Estoque/Custo');
  VprNomeModulos.Add('Chamados');
  VprNomeModulos.Add('Configurações do Sistema');
  VprNomeModulos.Add('CRM');
  VprNomeModulos.Add('Caixa');
  VprNomeModulos.Add('PDV');
end;

{************* retorna se o sistema esta em uso ou nao ************************}
function TFPrincipal.HandleSistema(VpaNomeModulo : String) : THandle;
var
  VpfArquivoIni : TIniFile;
begin
  result := 0;
  try
    VpfArquivoIni := TIniFile.Create(VprDiretorioCorrente+'\'+ varia.ParametroBase+ '.ini');
    result :=  (VpfArquivoIni.ReadInteger(VpaNomeModulo,'EmUso',0));
    VpfArquivoIni.free;
  except
  end;
end;

{******************* fecha os aplicativos abertos *****************************}
// naum esta funcionando
procedure TFPrincipal.FechaAplicativos;
var
  VpfLaco : Integer;
  VpfHandleSistema : THandle;
begin
  for VpfLaco := 0 to VprNomeModulos.Count -1 do
  begin
    VpfHandleSistema := HandleSistema(VprNomeModulos.Strings[vpflaco]);
    if VpfHandleSistema <> 0 then
      DestroyWindow(VpfHandleSistema);
  end;
end;

{******************************************************************************}
procedure TFPrincipal.RestauraBackup(VpaNomArquivo : String);
begin
  CarregaDiretorios;
  if not ExisteDiretorio(varia.PathRestauracaoBackup) then
    CriaDiretorio(varia.PathRestauracaoBackup);

  DeletaArquivoDiretorio(varia.PathRestauracaoBackup,true);
  CopiaArquivo(VpaNomArquivo,varia.PathRestauracaoBackup+'\Restaurar.db');
  shellExecute( Handle,'open', StrToPChar(Varia.PathSybase+'\Dbeng6.exe'),
               StrToPChar('"' + varia.PathRestauracaoBackup+'\Restaurar.db "'),
                  nil ,SW_NORMAL );
  shellExecute( Handle,'open', StrToPChar(Varia.PathInSig+'\Siscorp.exe'),
               StrToPChar('Restaurar'),
                  nil ,SW_NORMAL );
end;

{******************************************************************************}
procedure TFPrincipal.ApagaBancoRestaurado;
begin
  if varia.PathRestauracaoBackup <> '' then
    DeletaArquivoDiretorio(varia.PathRestauracaoBackup,true);
end;

{******************************************************************************}
function TFPrincipal.RAtualizarSistema : Boolean;
var
  VpfRegistry : TIniFile;
begin
  result := false;
  AdicionaSQLAbreTabela(Aux,'Select * from CFG_GERAL');
  VpfRegistry := TIniFile.Create(VprDiretorioCorrente+'\'+ varia.ParametroBase+ '.ini');

  if UpperCase(CampoPermissaoModulo) = 'C_MOD_PON' then
    result := StrToFloat(AdicionaCharD('0',SubstituiStr(VpfRegistry.ReadString('VERSAO','PONTOLOJA','0'),'.',','),1)) < StrToFloat(SubstituiStr(Aux.FieldByName(CampoPermissaoModulo).AsString,'.',','))
  else
    if UpperCase(CampoPermissaoModulo) = 'C_CON_SIS' then
      result := StrToFloat(AdicionaCharD('0',SubstituiStr(VpfRegistry.ReadString('VERSAO','CONFIGURACAOSISTEMA','0'),'.',','),1)) < StrToFloat(SubstituiStr(Aux.FieldByName(CampoPermissaoModulo).AsString,'.',','))
    else
      if UpperCase(CampoPermissaoModulo) = 'C_MOD_FIN' then
        result := StrToFloat(AdicionaCharD('0',SubstituiStr(VpfRegistry.ReadString('VERSAO','FINANCEIRO','0'),'.',','),1)) < StrToFloat(SubstituiStr(Aux.FieldByName(CampoPermissaoModulo).AsString,'.',','))
      else
        if UpperCase(CampoPermissaoModulo) = 'C_MOD_FAT' then
          result := StrToFloat(AdicionaCharD('0',SubstituiStr(VpfRegistry.ReadString('VERSAO','FATURAMENTO','0'),'.',','),1)) < StrToFloat(SubstituiStr(Aux.FieldByName(CampoPermissaoModulo).AsString,'.',','))
        else
          if UpperCase(CampoPermissaoModulo) = 'C_MOD_EST' then
            result := StrToFloat(AdicionaCharD('0',SubstituiStr(VpfRegistry.ReadString('VERSAO','ESTOQUE','0'),'.',','),1)) < StrToFloat(SubstituiStr(Aux.FieldByName(CampoPermissaoModulo).AsString,'.',','))
          else
            if UpperCase(CampoPermissaoModulo) = 'C_MOD_CHA' then
              result := StrToFloat(AdicionaCharD('0',SubstituiStr(VpfRegistry.ReadString('VERSAO','CHAMADO','0'),'.',','),1)) < StrToFloat(SubstituiStr(Aux.FieldByName(CampoPermissaoModulo).AsString,'.',','))
            else
              if UpperCase(CampoPermissaoModulo) = 'C_MOD_CRM' then
                result := StrToFloat(AdicionaCharD('0',SubstituiStr(VpfRegistry.ReadString('VERSAO','CRM','0'),'.',','),1)) < StrToFloat(SubstituiStr(Aux.FieldByName(CampoPermissaoModulo).AsString,'.',','))
              else
                if UpperCase(CampoPermissaoModulo) = 'C_MOD_CAI' then
                  result := StrToFloat(AdicionaCharD('0',SubstituiStr(VpfRegistry.ReadString('VERSAO','CAIXA','0'),'.',','),1)) < StrToFloat(SubstituiStr(Aux.FieldByName(CampoPermissaoModulo).AsString,'.',','))
              else
                if UpperCase(CampoPermissaoModulo) = 'C_MOD_PDV' then
                  result := StrToFloat(AdicionaCharD('0',SubstituiStr(VpfRegistry.ReadString('VERSAO','PDV','0'),'.',','),1)) < StrToFloat(SubstituiStr(Aux.FieldByName(CampoPermissaoModulo).AsString,'.',','));

  VpfRegistry.free;
  Aux.Close;
end;

{******************************************************************************}
procedure TFPrincipal.CopiaNovaVersao;
var
  VpfNomArquivo : String;
begin
  if config.AtualizarVersaoAutomaticamente then
  begin
    FMensagemAtualizando := TFMensagemAtualizando.Create(self);
    FMensagemAtualizando.show;
    FMensagemAtualizando.Refresh;
    VpfNomArquivo := '';
    if UpperCase(CampoPermissaoModulo) = 'C_MOD_PON' then
      VpfNomArquivo := 'PontoLoja.exe'
    else
      if UpperCase(CampoPermissaoModulo) = 'C_CON_SIS' then
        VpfNomArquivo := 'configuracoessistema.exe'
      else
        if UpperCase(CampoPermissaoModulo) = 'C_MOD_FIN' then
          VpfNomArquivo := 'financeiro.exe'
        else
          if UpperCase(CampoPermissaoModulo) = 'C_MOD_FAT' then
            VpfNomArquivo := 'faturamento.exe'
          else
            if UpperCase(CampoPermissaoModulo) = 'C_MOD_EST' then
              VpfNomArquivo := 'EstoqueCusto.exe'
            else
              if UpperCase(CampoPermissaoModulo) = 'C_MOD_CHA' then
                VpfNomArquivo := 'ChamadoTecnico.exe'
              else
                if UpperCase(CampoPermissaoModulo) = 'C_MOD_CRM' then
                  VpfNomArquivo := 'CRM.exe'
                else
                  if UpperCase(CampoPermissaoModulo) = 'C_MOD_CAI' then
                    VpfNomArquivo := 'Caixa.exe'
                else
                  if UpperCase(CampoPermissaoModulo) = 'C_MOD_PDV' then
                    VpfNomArquivo := 'efiPDV.exe';

    if (VpfNomArquivo <> '') and (config.AtualizarVersaoAutomaticamente) then
    begin
      if UpperCase(varia.PathVersoes) <> UpperCase(Varia.PathInSig) then
      begin
        if ExisteArquivo(varia.PathVersoes+'\'+VpfNomArquivo) then
        begin
          DeletaArquivo(Varia.PathInSig+'\'+VpfNomArquivo);
          sleep(1000);
          CopiaArquivo(varia.PathVersoes+'\'+VpfNomArquivo,Varia.PathInSig+'\'+VpfNomArquivo);
        end;
      end;
    end;
    sleep(2000);
    FMensagemAtualizando.free;
  end;
end;

{************** quando é presssionada algum botao ou menu *********************}
procedure TFPrincipal.MenuClick(Sender: TObject);
var
  VpfHandleSistema : THandle;
  VpfModulo : string;
begin
  if (Sender is TComponent) then
  begin
    case TComponent(Sender).Tag of
      0 : begin
            CampoPermissaoModulo := 'c_mod_fin';
            VpfModulo := 'Financeiro.exe';
          end;
      1 : begin
            CampoPermissaoModulo := 'c_mod_pon';
            VpfModulo := 'PontoLoja.exe';
          end;
      2 : begin
            CampoPermissaoModulo := 'c_mod_fat';
            VpfModulo := 'Faturamento.exe';
          end;
      3 : begin
            CampoPermissaoModulo := 'c_mod_est';
            VpfModulo := 'EstoqueCusto.exe';
          end;
      4 : begin
            CampoPermissaoModulo := 'c_mod_cha';
            VpfModulo := 'ChamadoTecnico.exe';
          end;
      5 : begin
            CampoPermissaoModulo := 'c_con_sis';
            VpfModulo := 'ConfiguracoesSistema.exe';
          end;
      6 : begin
            CampoPermissaoModulo := 'C_MOD_CRM';
            VpfModulo := 'CRM.EXE';
          end;
      7 : begin
            CampoPermissaoModulo := 'C_MOD_CAI';
            VpfModulo := 'Caixa.EXE';
          end;
      8 : begin
            CampoPermissaoModulo := 'C_MOD_PDV';
            VpfModulo := 'efiPDV.EXE';
          end;
    end;
    CampoFormModulos := CampoPermissaoModulo;
    if UsuarioOk Then
    begin
      SetCurrentDir(Varia.PathInSig);
//      FechaAplicativoemExecucao(VpfModulo);
      VpfHandleSistema := HandleSistema(VprNomeModulos.Strings[TWinControl(sender).tag]);
      if VprAtualizarSistema then
      begin
        if VpfHandleSistema <> 0 then
          aviso('VERSÃO DESATUALIZADA!!!'#13'Existe uma nova versão do módulo selecionado, mas o programa se encontra em execução. É necessário que o programa seja fechado para que a atualização seja executada com sucesso.' )
        else
        CopiaNovaVersao;
      end;
      if VpfHandleSistema = 0 Then
      begin
        shellExecute( Handle,'open', StrToPChar(VpfModulo),
                            StrToPChar(' '+VplParametroBaseDados + ' ' + varia.usuario + ' ' + Descriptografa(Varia.Senha)+ ' '+InttoStr(Varia.CodigoEmpresa)+' '+ IntToStr(Varia.CodigoEmpFil)),
                            nil ,SW_NORMAL )
      end
     else
     begin
       if closeWindow(VpfHandleSistema) then
         ShowWindow(VpfHandleSistema,SW_NORMAL)
       else
        shellExecute( Handle,'open', StrToPChar(VpfModulo),
                            StrToPChar(' '+VplParametroBaseDados + ' ' + varia.usuario + ' ' + Descriptografa(Varia.Senha)+ ' '+InttoStr(Varia.CodigoEmpresa)+' '+ IntToStr(Varia.CodigoEmpFil)),
                            nil ,SW_NORMAL )
     end;

    end;
    BaseDados.close;
  end;
end;

{******************************************************************************}
procedure TFPrincipal.BaixaVersao;
begin

end;

{***************** desloga o usuario se ele estiver logado ********************}
procedure TFPrincipal.BLogadoClick(Sender: TObject);
begin
  if VprUsuarioLogado then
  begin
    VprUsuarioLogado := false;
    LUsuario.Caption := '';
    BLogado.Down := false;
  end;
end;

{******************************************************************************}
procedure TFPrincipal.BSuporteRemotoClick(Sender: TObject);
begin
  ExecutaArquivoEXE(varia.DiretorioSistema+'AcessoRemoto.exe',1);
end;

{********************* ativa a tela da aplicação ******************************}
procedure TFPrincipal.IconeBarraStatus1Click(Sender: TObject);
begin
  Application.BringToFront;
end;


{******************************************************************************}
procedure TFPrincipal.MesquerdaClick(Sender: TObject);
begin
  MDireita.Checked := false;
  Mesquerda.Checked := false;
  MSuperior.Checked := false;
  MInferior.Checked := false;
  if (Sender is TComponent) then
  begin
    case TComponent(Sender).Tag of
      0 : begin MDireita.Checked := true; VprAlinhamento := 0; end;
      1 : begin MEsquerda.Checked := true; VprAlinhamento := 1; end;
      2 : begin MSuperior.Checked := true; VprAlinhamento := 2; end;
      3 : begin MInferior.Checked := true; VprAlinhamento := 3; end;
    end;
    ConfiguraTela;
    GravaIni;
  end;
end;

procedure TFPrincipal.RestauraBackup1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    RestauraBackup(OpenDialog1.FileName);
  end;
end;

end.
