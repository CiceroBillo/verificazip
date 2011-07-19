unit UnPrincipal;
{Verificado
-.edit;
}
interface

uses
    Db, classes, sysUtils, extctrls, Componentes1, PainelGradiente, IniFiles,
    FunIni, Graphics, FormulariosFundo, Menus, Buttons, ComCtrls, forms, controls, labelCorMove, UnVersoes,
    SQLExpr, tabela  ;

// funcoes
type
  TFuncoesPrincipal = class
  private
      Tabela : TSQLQuery;
      VprBaseDados : TSqlConnection;
      Parente : TComponent;
      imagem : TImage;
      Label3D1 : TLabel3D;
      Label3D2 : TLabel3D;
      VprNomeModulo,
      VprNomeArquivoIni,
      VprDiretorioIni : String;
      procedure CriaPropaganda;
      procedure ColocaProgramaEmUso(VpaNomeArquivo, VpaNomeModulo : String);
      procedure TiraProgramaDeUso(VpaNomeArquivo, VpaNomeModulo : String);
  public
    constructor criar( aowner : TComponent; VpaBaseDados : TSQLConnection;VpaNomeModulo : String );
    destructor Destroy; override;
    function LocalizaUsuarios(Tabela : TDataSet; CodUsuario : Integer ) : boolean;
    // config usuario
    procedure ConfigUsu( CodUsuario : Integer;  CorFoco : TCorFoco; CorForm : TCorForm; CorPainelGra : TCorPainelGra; FPrincipal : TForm );
    // permissao usuario
    procedure SalvaFormularioEspecial( NomeFormulario, HintFormulario, Modulo, Menu : String );
    Function VerificaPermisao( nome : string ) : Boolean;
    // caption
    procedure AlteraNomeEmpresa( FPrincipal : TForm; Barra : TStatusBar; NomeMOdulo, TipoSistemaVersao  : String  );
    procedure ConfiguraMenus(QdadeForm : Integer; MenuCascata_Lado, MenuTrue_Sair : array of TComponent; Mjanela : TMenuItem  );
    procedure OrganizaBotoes(Inicio : Integer; botoes : array of TSpeedButton);
end;


implementation

  uses funsql, constMsg, funArquivos, funstring, constantes, funObjeto, Windows, ShellApi, Registry;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              funcoes Principal
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

function TFuncoesPrincipal.LocalizaUsuarios(Tabela : TDataSet; CodUsuario : Integer ) : boolean;
begin
AdicionaSQLAbreTabela(Tabela, ' Select * from cadUsuarios '  +
                              ' where i_emp_fil = ' + Inttostr(varia.CodigoEmpFil) +
                              ' and i_cod_usu = ' + IntToStr(codUsuario));
end;


{ ****************** Na criação da classe ******************************** }
constructor TFuncoesPrincipal.criar( aowner : TComponent; VpaBaseDados : TSQLConnection;VpaNomeModulo : String );
begin
  inherited;
  if ParamCount <> 0 then  // verifica se a parametros da base de dados
    VprNomeArquivoIni := copiaateChar(ParamStr(1),'/');

  Parente := aowner;
  VprBaseDados := VpaBaseDados;
  Tabela := TSQLQuery.Create(aowner);
  Tabela.SQLConnection := VpaBaseDados;
  CriaPropaganda;
  VprNomeModulo := VpaNomeModulo;
  VprDiretorioIni := RetornaDiretorioCorrente;
  ColocaProgramaEmUso(VprDiretorioIni+'\'+VprNomeArquivoIni+'.ini',VprNomeModulo) ;
end;

{ ******************* Quando destroy a classe ****************************** }
destructor TFuncoesPrincipal.Destroy;
begin
  TiraProgramaDeUso(VprDiretorioIni+'\'+VprNomeArquivoIni+'.ini',VprNomeModulo);
  FechaTabela(tabela);
  Tabela.Destroy;
  inherited;
end;

{ ##############################################################################
                      Configuracao do usuários
############################################################################## }

// --------- Carrega as configuracoes do usuario ------------------------------ //
procedure TFuncoesPrincipal.ConfigUsu( CodUsuario : Integer; CorFoco: TCorFoco; CorForm: TCorForm;
                                       CorPainelGra: TCorPainelGra; FPrincipal : TForm );
begin
  varia.DiretorioSistema := UpperCase(ExtractFilePath(Application.ExeName));

try
  LocalizaUsuarios(tabela, CodUsuario);
  CorFoco.tag := ConfiguraSituacaoImagem(Tabela.FieldByName('C_SIS_IMA').AsString);
  if Tabela.FieldByName('C_EFO_COR').AsString <> '' then
    CorFoco.AFonteComponentes.Color := stringToColor(Tabela.FieldByName('C_EFO_COR').AsString);
  CorFoco.AFonteComponentes.Size := Tabela.FieldByName('I_EFO_TAM').AsInteger;
  CorFoco.AFonteComponentes.Name := Tabela.FieldByName('C_EFO_NOM').AsString;
  CorFoco.AFonteComponentes.Style := montaAtributosFonte(Tabela.FieldByName('C_EFO_ATR').AsString);
  if Tabela.FieldByName('C_EFU_COR').AsString <> '' then
    CorFoco.AFundoComponentes := StringToColor(Tabela.FieldByName('C_EFU_COR').AsString);
  if Tabela.FieldByName('C_EFF_COR').AsString <> '' then
    CorFoco.ACorFundoFoco := stringToColor(Tabela.FieldByName('C_EFF_COR').AsString);
  if Tabela.FieldByName('C_EFF_FCO').AsString <> '' then
    CorFoco.ACorObrigatorio := stringToColor(Tabela.FieldByName('C_EFF_FCO').AsString);
  if Tabela.FieldByName('C_EFO_FCO').AsString <> '' then
    CorFoco.ACorFonteFoco := stringToColor(Tabela.FieldByName('C_EFO_FCO').AsString);
  if Tabela.FieldByName('C_COR_NEG').AsString <> '' then
    CorFoco.AcorNegativo := stringToColor(Tabela.FieldByName('C_COR_NEG').AsString);

  if Tabela.FieldByName('C_GFO_COR').AsString <> '' then
    CorFoco.AFonteTituloGrid.Color := stringToColor(Tabela.FieldByName('C_GFO_COR').AsString);
  CorFoco.AFonteTituloGrid.Size := Tabela.FieldByName('I_GFO_TAM').AsInteger;
  CorFoco.AFonteTituloGrid.Name := Tabela.FieldByName('C_GFO_NOM').AsString;
  CorFoco.AFonteTituloGrid.Style := montaAtributosFonte(Tabela.FieldByName('C_GFO_ATR').AsString);
  if Tabela.FieldByName('C_GTI_COR').AsString <> '' then
    CorFoco.ACorTituloGrid := StringToColor(Tabela.FieldByName('C_GTI_COR').AsString);

  if Tabela.FieldByName('C_SFO_COR').AsString <> '' then
    CorForm.AFonteForm.Color := StringToColor(Tabela.FieldByName('C_SFO_COR').AsString);
  CorForm.AFonteForm.Size := Tabela.FieldByName('I_SFO_TAM').AsInteger;
  CorForm.AFonteForm.Name := Tabela.FieldByName('C_SFO_NOM').AsString;
  CorForm.AFonteForm.Style :=  MontaAtributosFonte(Tabela.FieldByName('C_SFO_ATR').AsString);
  if Tabela.FieldByName('C_SPA_COR').AsString <> '' then
    CorForm.ACorPainel := StringToColor(Tabela.FieldByName('C_SPA_COR').AsString);

  if Tabela.FieldByName('C_SIS_COR').AsString <> '' then
    FPrincipal.color := StringToColor(Tabela.FieldByName('C_SIS_COR').AsString);

  if (FPrincipal is TFormularioFundo) then
  begin
    if (FileExists(Tabela.FieldByName('C_SIS_PAP').AsString)) and (Tabela.FieldByName('C_SIS_IMA').AsString <> 'NENHUM') then
    begin
       (FPrincipal as TFormularioFundo).Image1.Picture.LoadFromFile(Tabela.FieldByName('C_SIS_PAP').AsString);
       (FPrincipal as TFormularioFundo).Desenha(Tabela.FieldByName('C_SIS_IMA').AsString);
    end
    else
      (FPrincipal as TFormularioFundo).Image1.Picture := nil;
  end;
  except
  end;
  Tabela.close;

end;


{ ##############################################################################
                      permissao ao usuários
############################################################################## }


{* cadastro os formulario, quando duplicado no menu ou naum possuir formulario * }
procedure TFuncoesPrincipal.SalvaFormularioEspecial( NomeFormulario, HintFormulario, Modulo, Menu : String );
var
  Aux : TSQL;

 function localiza( nome : string ) : boolean;
 begin
   AdicionaSQLAbreTabela(aux, 'select * from cadFormularios where c_cod_fom = ''' + nome + '''');
   result :=  aux.eof;
 end;

begin
  if config.AtualizaPermissao then
  begin
    Aux := TSQL.create(nil);
    Aux.ASQLConnection := VprBaseDados;

    if localiza(NomeFormulario) then
    begin
      InserirReg(aux);
      aux.FieldByName('c_cod_fom').AsString := NomeFormulario;
    end
    else
      EditarReg(aux);

    aux.FieldByName('c_nom_fom').AsString := HintFormulario;
    aux.FieldByName('c_nom_men').AsString := Menu;
    aux.FieldByName(Modulo).AsString := 'S';
    aux.post;
    aux.free;
  end;
end;


Function  TFuncoesPrincipal.VerificaPermisao( nome : string ) : Boolean;
begin
  result := true;
end;

{ ##############################################################################
                      caption formulario
############################################################################## }

// -------------------- Altera o Caption da Jabela Proncipal ------------------ }
procedure TFuncoesPrincipal.AlteraNomeEmpresa( FPrincipal : TForm; Barra : TStatusBar; NomeMOdulo, TipoSistemaVersao  : String );
begin
   FPrincipal.caption := NomeSistema + ' - ' + NomeModulo +' '+ varia.VersaoSistema + 'v - ' + '[ ' + TipoSistemaVersao + ' ]';
   Barra.Panels[0].Text := ' Filial : ' + Varia.RazaoSocialFilial ;
   Barra.Panels[1].Text := ' Usuário : ' + Varia.NomeUsuario;
   if NomeMOdulo = 'PDV' then
   begin
     if config.SistemaEstaOnline then
       Barra.Panels[2].Text := ' Base : Servidor'
     else
       Barra.Panels[2].Text := ' Base : Local';
   end;
end;

{************************** Configura os menus do Sistema ********************}
procedure TFuncoesPrincipal.ConfiguraMenus(QdadeForm : Integer; MenuCascata_Lado, MenuTrue_Sair : array of TComponent; Mjanela : TMenuItem );
begin
if QdadeForm = 2 then
begin
  AlterarenabledDet( MenuCascata_Lado, true);
  AlterarenabledDet(MenuTrue_Sair, false);
  Mjanela.Visible := true;
end
else
    if QdadeForm = 1 then
    begin
      AlterarenabledDet(MenuCascata_Lado, false);
      AlterarenabledDet(MenuTrue_Sair, true);
      Mjanela.visible := false;
    end;
end;

{********************** coloca o programa em uso ******************************}
procedure TFuncoesPrincipal.ColocaProgramaEmUso(VpaNomeArquivo, VpaNomeModulo : String);
var
  VpfArquivoIni : TIniFile;
begin
  try
    VpfArquivoIni := TIniFile.Create(VpaNomeArquivo);
    VpfArquivoIni.WriteString(VpaNomeModulo,'EmUso',IntToStr(Application.Handle));
    VpfArquivoIni.free;
  except
    aviso('Erro na leitura do arquivo '+VpaNomeArquivo);
  end;
end;

{********************** tira o programa de uso ********************************}
procedure TFuncoesPrincipal.TiraProgramaDeUso(VpaNomeArquivo, VpaNomeModulo : String);
var
  VpfArquivoIni : TIniFile;
begin
  try
    VpfArquivoIni := TIniFile.Create(VpaNomeArquivo);
    VpfArquivoIni.WriteString(VpaNomeModulo,'EmUso','0');
    VpfArquivoIni.free;
  except
    aviso('Erro na leitura do arquivo '+VpaNomeArquivo);
  end;
end;

{****************** cria a propaganda da indata ***************************** }
procedure TFuncoesPrincipal.CriaPropaganda;
begin
end;

{*************** organiza os botoes do menu ********************************** }
procedure  TFuncoesPrincipal.OrganizaBotoes(Inicio : Integer; botoes : array of TSpeedButton);
var
  laco : integer;
begin
  for laco := low(botoes) to high(botoes) do
   if botoes[laco] <> nil then
      if botoes[laco].Visible then
      begin
        botoes[laco].Left := inicio;
        inicio := botoes[laco].Width + botoes[laco].Left;
      end;
end;


end.
