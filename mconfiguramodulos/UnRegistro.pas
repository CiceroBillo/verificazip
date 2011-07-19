unit UnRegistro;
{Verificado
-.edit;
}
interface

uses sysUtils, Menus, classes, buttons;

const
  CT_Bancario = 'BANCARIO';
  CT_Comissao = 'COMISSAO';
  CT_Caixa = 'CAIXA';
  CT_ContaPagar = 'CONTAPAGAR';
  CT_ContaReceber = 'CONTARECEBER';
  CT_Fluxo = 'FLUXO';
  CT_Faturamento = 'FATURAMENTO';
  CT_PRODUTO = 'PRODUTO';
  CT_CUSTO = 'CUSTO';
  CT_ESTOQUE = 'ESTOQUE';

  CT_SERVICO = 'SERVICO';
  CT_NOTAFISCAL = 'NOTAFISCAL';
  CT_CODIGOBARRA = 'CODIGOBARRA';
  CT_GAVETA = 'GAVETA';
  CT_IMPDOCUMENTOS = 'IMPDOCUMENTOS';
  CT_ORCAMENTOVENDA = 'ORCAMENTOVENDA';
  CT_IMPORTACAOEXPORTACAO = 'IMPORTAREXPORTAR';
  CT_SENHAGRUPO = 'SENHAGRUPO';
  CT_MALACLIENTE = 'MALACLIENTE';
  CT_AGENDACLIENTE = 'AGENDACLIENTE';
  CT_PEDIDOVENDA = 'PEDIDOVENDA';
  CT_ORDEMSERVICO = 'ORDEMSERVICO';
  CT_TELEMARKETING = 'TELEMARKETING';
  CT_FACCIONISTA = 'FACCIONISTA';
  CT_AMOSTRA = 'AMOSTRA';

type
 TRegistro = class
   private
     function ValidaSerie( serie : String) : Boolean;
   public
     function GeraRegistro( qdadeMeses : Integer; NumeroHD : string; Versao : string) : string;
     function GeraChaveLimpaRegistro : string;
     function ValidaRegistro(registro : string) : Boolean;
     function MontaDataRegistro( registro : string) : TDateTime;
     function MontaSerieRegistro( registro : string) : String;
     function MontaVersaoRegistro( registro : string) : string;
     function TextoVersao( versao : string ) : string;
     procedure GravaRegistro( registro : String );
     function LeRegistro( var serie, versao : string; var DataReg, Data : TdateTime ) : Boolean;
     function VersaoMaquina : Integer;
     procedure LeRegistroTexto( var Registro, versao, DataReg, Data : string );
     function LimpaRegistro( chave : string ) : Boolean;
     function ValidaRegistroMaquina( var tipo_prg : string ) : Boolean;
     function VerificaTipoBase : Boolean;
     function ValidaModulo( var tipo_prg : string;  ItensEnabled : array of TComponent ) : boolean;
     procedure CriptografaLista( lista : TStringList );
     procedure DesCriptografaLista( lista : TStringList );
     function GeraSerieLista( HD : string ): string;
     function ValidaSerieLista( serie : string) : Boolean;

     /// configuracoes dos modulos do sistema
     function ConfiguraModuloConfigSistema( MFinanceiro, MCaixa, MProdutos, MFaturamento
                                           : array of Tcomponent ) : boolean;
     function ConfiguraModuloFinanceiro( MenuBancario, MenuComissao, MenuCP,
                                         MenuCR, MenuFluxo : TMenuItem;
                                         BotaoBancario,BotaoComissao, BotaoCP,
                                         BotaoCR, BotaoFluxo : TSpeedButton ) : boolean;
     function ConfiguraModuloCaixa( MenuCaixa : TMenuItem;
                                    BotaoCaixa : TSpeedButton ) : boolean;
     function ConfiguraModuloProdutoCusto( MenuProduto, MenuCusto, MenuEstoque : TMenuItem;
                                           BotaoProduto, BotaoCusto, BotaoEstoque : TSpeedButton ) : boolean;
    procedure ConfiguraModulo( Modulo : string; comp : array of TComponent );
  end;

implementation

uses funstring, funvalida, funHardware, constMsg, fundata, Registry,
     FunObjeto, constantes, funsql;


{ *************** gera novo registro conforme qdade mesese e hd da maquina *** }
function TRegistro.GeraRegistro( qdadeMeses : Integer; NumeroHD : string; Versao : string) : string;
var
  meses :string;
begin
Meses := AdicionaCharE('0',IntTostr(qdadeMeses),2);
result := CriptografaSerie(Versao + Meses[1] + NumeroHD + Meses[2]);
end;

{***************** chave para limpar os registros **************************** }
function TRegistro.GeraChaveLimpaRegistro : string;
begin
 result := CriptografaSerie(DateToStr(date));
end;

{**************** verifica se a serie da maq esta OK ************************ }
function TRegistro.ValidaSerie( serie : String) : Boolean;
begin
  result := true;
  if serie <> NumeroSerie('C:\') then
  begin
    aviso( 'Número de Série Invalido');
    result := false;
  end
end;

{*********** valida o registro ********************************************** }
function TRegistro.ValidaRegistro(registro : string) : Boolean;
var
  serie : string;
begin
serie := MontaSerieRegistro(registro);
result := ValidaSerie(serie);
end;

{******* extrai apenas a data valida do registro ***************************** }
function TRegistro.MontaDataRegistro( registro : string) : TDateTime;
var
  meses : string;
begin
  meses := DesCriptografaSerie(registro);
  meses := meses[2] + meses[length(meses)];
  result :=  IncMes(date, StrToInt(meses));
end;

{********** extrai apenas a serie do registro ****************************** }
function TRegistro.MontaSerieRegistro( registro : string) : string;
begin
result := DesCriptografaSerie(registro);
result := copy(result,3,length(result)-3);
end;

{********** extrai apenas a serie do registro ****************************** }
function TRegistro.MontaVersaoRegistro( registro : string) : string;
begin
result := DesCriptografaSerie(registro);
result := result[1];
end;

{************** texto da versao do sistema, demonstracao oficial ************* }
function TRegistro.TextoVersao( versao : string ) : string;
begin
  if versao = '0' then
    result := 'Demonstração'
  else
    if versao = '1' then
      result := 'Oficial'
    else
      result := 'Sem Registro';
end;

{*************** Grava serie, registro, e datas no regedit ******************* }
procedure TRegistro.GravaRegistro( registro : String);
var
 ini, iniChave : TRegIniFile;
 serie : string;
 data : string;
begin
  serie := CriptografaSerie(MontaSerieRegistro(registro));
  data :=  CriptografaSerie(datetostr(MontaDataRegistro(registro)));
  ini := TRegIniFile.Create('Software\Systec\Sistema');
  iniChave := TRegIniFile.Create('Software\Microsoft\WinExplorer'); // chave de seguranca caso exclua a reg

  if not ((ini.ReadString('REGISTRO','REGISTRO', 'VAZIO') = 'VAZIO') and
     (IniChave.ReadString('IEpos','posx', 'VAZIO') = '2000')) then
  begin
    if ini.ReadString('REGISTRO','REGISTRO', 'vazio') <> registro then
    begin
      ini.WriteString('REGISTRO','REGISTRO', registro);
      ini.WriteString('REGISTRO','SERIE', serie);
      ini.WriteString('REGISTRO','DATA', data);
      ini.WriteString('REGISTRO','DATAREG', CriptografaSerie(DateToStr(date)));
      ini.WriteString('REGISTRO','VERSAO', CriptografaSerie(MontaVersaoRegistro(registro)));
      iniChave.WriteString('IEpos','posx', '2000');
    end;
  end
  else
  begin
    aviso('Violação de Registro');
    exit;
  end;
  ini.Free;
  iniChave.Free;
end;

{****************** le a serie e datas do regEdit ************************** }
function TRegistro.LeRegistro( var serie, versao : string; var DataReg, Data : TdateTime ) : Boolean;
var
 ini, iniChave : TRegIniFile;
 DataIni : string;
begin
  result := true;
  iniChave := TRegIniFile.Create('Software\Microsoft\WinExplorer'); // chave de seguranca caso exclua a reg

  if (IniChave.ReadString('IEpos','posx', 'VAZIO') = '2000') then
  begin

    ini := TRegIniFile.Create('Software\Systec\Sistema');
    serie := ini.ReadString('REGISTRO','SERIE', 'VAZIO');

    if serie = 'VAZIO' then
    begin
      aviso('Violação de Registro');
      result := false;
      exit;
    end
    else
     serie := DesCriptografaSerie(serie);

    DataIni := DesCriptografaSerie(ini.ReadString('REGISTRO','DATA', ''));
    try
      Data := strtodate(dataIni);
    except
      aviso('Violação de Registro');
      result := false;
      exit;
    end;

    DataIni := DesCriptografaSerie(ini.ReadString('REGISTRO','DATAREG', ''));
    try
      DataReg := strtodate(dataIni);
    except
      aviso('Violação de Registro');
      result := false;
      exit;
    end;

    versao := desCriptografaSerie(ini.ReadString('REGISTRO','VERSAO','30'));

    ini.Free;
  end
  else
    result := false;
  iniChave.Free;
end;

{****************** le a serie e datas do regEdit ************************** }
procedure TRegistro.LeRegistroTexto( var Registro, versao, DataReg, Data : string );
var
 ini : TRegIniFile;
begin
  ini := TRegIniFile.Create('Software\Systec\Sistema');
  Registro := ini.ReadString('REGISTRO','REGISTRO', '');
  Data := DesCriptografaSerie(ini.ReadString('REGISTRO','DATA', ''));
  DataReg := DesCriptografaSerie(ini.ReadString('REGISTRO','DATAREG', ''));
  versao := desCriptografaSerie(ini.ReadString('REGISTRO','VERSAO','30'));
  versao := TextoVersao(versao);
  ini.Free;
end;

{************* limpa os registros do reg ************************************ }
function TRegistro.LimpaRegistro( chave : string ) : Boolean;
var
 ini : TRegIniFile;
begin
result := false;
if DesCriptografaSerie(chave) = datetostr(date) then
begin
  ini := TRegIniFile.Create('Software\Systec\Sistema');
  ini.EraseSection('REGISTRO');
  ini.free;
  ini := TRegIniFile.Create('Software\Microsoft\WinExplorer'); // chave de seguranca caso exclua a reg
  ini.DeleteKey('IEpos','posx');
  ini.Free;
  result := true;
end
else
  aviso('Chave Inválida');
end;

{**************** valida a serie da maquina ********************************* }
function TRegistro.ValidaRegistroMaquina( var tipo_prg : string ) : Boolean;
var
 serie, versao : string;
 data, dataReg : TdateTime;
begin
 result := false;
 if LeRegistro(serie,versao,datareg,data) then
   if ValidaSerie(serie) then
     if  data >= date then
     begin
       result := true;
       tipo_prg := TextoVersao(versao);
     end
     else
       aviso('A Data de Válidade do seu sistema Expirou. !');
end;

{**************** valida a serie da maquina ********************************* }
function TRegistro.VersaoMaquina : Integer;
var
 serie, versao : string;
 data, dataReg : TdateTime;
begin
 result := 2;  // sem registro
 if LeRegistro(serie,versao,datareg,data) then
 begin
   if versao = '1' then
     result := 1  // oficial
   else
     result := 0; // demosntracao
 end;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                   valida Modulos pelos numero de seire
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{*************** criptografa um stringlist ********************************* }
procedure TRegistro.CriptografaLista( lista : TStringList );
var
  laco : Integer;
  texto : string;
begin
   for laco := 0 to lista.Count - 1 do
   begin
    texto := lista.Strings[laco];
    lista.Delete(laco);
    lista.Insert(laco, CriptografaSerie(texto));
   end;
end;

{*************** descriptografa um stringlist  ******************************* }
procedure TRegistro.DesCriptografaLista( lista : TStringList );
var
  laco : Integer;
  texto : string;
begin
   for laco := 0 to lista.Count - 1 do
   begin
    texto := lista.Strings[laco];
    lista.Delete(laco);
    lista.Insert(laco, DesCriptografaSerie(texto));
   end;
end;

function TRegistro.GeraSerieLista( HD : string ): string;
begin
 result := CriptografaSerie(HD)
end;

function TRegistro.ValidaSerieLista( serie : string) : Boolean;
begin
result := false;
if ValidaSerie(DesCriptografaSerie(serie)) then
  result := true
else
  Aviso('Violação de Chave');
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                   valida Modulos no sistema
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{************** valida a base caso seja de demonstracao ******************** }
function TRegistro.VerificaTipoBase : Boolean;
begin
  result := true;
  if Varia.TipoBase = 0 then // demonstracao
  begin
    if Varia.DiaValBase <= 0 then
    begin
      aviso('Prazo esgotado da demonstração, mais informações suporte@indata.com.br ou fone 0xx47 329-2288.');
      result := false;
    end
    else
      Aviso('Está versão é de demonstração e poderá ser usada apenas ' + IntToStr(varia.DiaValBase-1) + ' veze(s). ');
  end;
end;

{************** valida o modulo *********************************************}
function TRegistro.ValidaModulo( var tipo_prg : string; ItensEnabled : array of TComponent ) : boolean;
begin
  result := true;
  tipo_prg := 'Oficial';

{  if Varia.TipoBase = 1 then     // caso base oficial
  begin
    tipo_prg := TextoVersao('2');  // inicializa sem versao, sem registro no sistema
    if not ValidaRegistroMaquina(tipo_prg) then
    begin
       AlterarEnabled(ItensEnabled);
       result := false;
    end;
  end
  else
  begin
     if result then   // valida caso a base demo tenha vencido
       if not VerificaTipoBase then
       begin
         AlterarEnabled(ItensEnabled);
         result := false;
       end;
  end;}
end;

{***** configuracoes dos modulos do sistema Configuracoes do sistema ********* }
function TRegistro.ConfiguraModuloConfigSistema( MFinanceiro, MCaixa, MProdutos, MFaturamento
                                                 : array of Tcomponent ) : boolean;
begin
  if (Not ConfigModulos.Bancario) and
     (Not ConfigModulos.ContasAPagar) and
     (Not ConfigModulos.ContasAReceber) and
     (Not ConfigModulos.Fluxo) then
      AlterarVisibleDet(MFinanceiro,false);

  if Not ConfigModulos.Caixa then
      AlterarVisibleDet(MCaixa,false);

  if Not ConfigModulos.Faturamento then
     AlterarVisibleDet(MFAturamento,false);

  if (Not ConfigModulos.Produto) and
     (Not ConfigModulos.Estoque) and
     (Not ConfigModulos.Custo) then
     AlterarVisibleDet(MProdutos,false);
end;

{********** configuracoes dos modulos do sistema Financeiro ****************** }
function TRegistro.ConfiguraModuloFinanceiro( MenuBancario, MenuComissao, MenuCP,
                                              MenuCR, MenuFluxo : TMenuItem;
                                              BotaoBancario,BotaoComissao, BotaoCP,
                                              BotaoCR, BotaoFluxo : TSpeedButton ) : boolean;
begin
if not ConfigModulos.Bancario then
 AlterarVisibleDet([ MenuBancario, BotaoBancario ], false);

if not ConfigModulos.Comissao then
 AlterarVisibleDet([ MenuComissao, BotaoComissao ], false);

if not ConfigModulos.ContasAPagar then
 AlterarVisibleDet([ MenuCP,  BotaoCP ], false);

if not ConfigModulos.ContasAReceber then
 AlterarVisibleDet([ MenuCR, BotaoCR ], false);

if not ConfigModulos.Fluxo then
 AlterarVisibleDet([ MenuFluxo, BotaoFluxo ], false);
end;

{********** configuracoes dos modulos do sistema Caixa ****************** }
function TRegistro.ConfiguraModuloCaixa( MenuCaixa : TMenuItem;
                                              BotaoCaixa : TSpeedButton ) : boolean;
begin
if not ConfigModulos.Caixa then
 AlterarVisibleDet([ MenuCaixa, BotaoCaixa ], false);
end;

{********** configuracoes dos modulos do sistema Produto/Custo *************** }
function TRegistro.ConfiguraModuloProdutoCusto( MenuProduto, MenuCusto, MenuEstoque : TMenuItem;
                                                BotaoProduto, BotaoCusto, BotaoEstoque : TSpeedButton ) : boolean;
begin
if not ConfigModulos.Produto then
  AlterarVisibleDet([ MenuProduto, BotaoProduto ], false);

if not ConfigModulos.Custo then
  AlterarVisibleDet([ MenuCusto, BotaoCusto ], false);

if not ConfigModulos.Estoque then
  AlterarVisibleDet([ MenuEstoque, BotaoEstoque ], false);
end;


{######################## valida componentes dos modulos #################### }

{**************** configura componentes conforme modulos ********************* }
procedure TRegistro.ConfiguraModulo( Modulo : string; comp : array of TComponent );
var
  laco : Integer;
  Visivel : Boolean;
begin
  if modulo = CT_BANCARIO then Visivel := ConfigModulos.Bancario else
  if modulo = CT_COMISSAO then Visivel := ConfigModulos.Comissao else
  if modulo = CT_CAIXA then Visivel := ConfigModulos.Caixa else
  if modulo = CT_CONTAPAGAR then Visivel := ConfigModulos.ContasAPagar else
  if modulo = CT_CONTARECEBER then Visivel := ConfigModulos.ContasAReceber else
  if modulo = CT_FLUXO then Visivel := ConfigModulos.Fluxo else
  if modulo = CT_FATURAMENTO then Visivel := ConfigModulos.Faturamento else
  if modulo = CT_PRODUTO then Visivel := ConfigModulos.Produto else
  if modulo = CT_CUSTO then Visivel := ConfigModulos.Custo else
  if modulo = CT_ESTOQUE then Visivel := ConfigModulos.Estoque else
  if modulo = CT_SERVICO then Visivel := ConfigModulos.Servico else
  if modulo = CT_NOTAFISCAL then Visivel := ConfigModulos.NotaFiscal else
  if modulo = CT_CODIGOBARRA  then Visivel := ConfigModulos.CodigoBarra else
  if modulo = CT_GAVETA  then Visivel := ConfigModulos.Gaveta else
  if modulo = CT_IMPDOCUMENTOS then Visivel := ConfigModulos.ImpDocumentos else
  if modulo = CT_ORCAMENTOVENDA then Visivel := ConfigModulos.OrcamentoVenda else
  if modulo = CT_IMPORTACAOEXPORTACAO then Visivel := ConfigModulos.Imp_Exp else
  if modulo = CT_SENHAGRUPO then Visivel := ConfigModulos.SenhaGrupo;
  if modulo = CT_SENHAGRUPO then Visivel := ConfigModulos.SenhaGrupo;
  if modulo = CT_TELEMARKETING then Visivel := ConfigModulos.TeleMarketing;
  if modulo = CT_FACCIONISTA then Visivel := ConfigModulos.Faccionista;
  if modulo = CT_AMOSTRA then Visivel := ConfigModulos.Amostra;

  if not Visivel then
    for laco := low(comp) to high(comp) do
    begin
      if ( comp[laco] is TMenuItem ) then
        ( comp[laco] as TMenuItem ).visible := false;
      if ( comp[laco] is TSpeedButton ) then
        if ( comp[laco] as TSpeedButton ) <> nil then
          ( comp[laco] as TSpeedButton ).free;
    end;
end;


end.
