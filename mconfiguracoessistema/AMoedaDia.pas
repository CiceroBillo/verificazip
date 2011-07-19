unit AMoedaDia;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Grids, DBGrids, Tabela, Db, DBTables, Componentes1, ExtCtrls,
  PainelGradiente, StdCtrls, Localizacao, Buttons, FMTBcd, SqlExpr, DBClient,
  UnSistema;

type
  TFMoedaDia = class(TFormularioPermissao)
    FMoedaDia: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    CadMoedas: TSQL;
    DataCadMoedas: TDataSource;
    DBGridColor1: TDBGridColor;
    MovMoedas: TSQLQuery;
    CadMoedasI_COD_MOE: TFMTBCDField;
    CadMoedasC_NOM_MOE: TWideStringField;
    CadMoedasN_VLR_DIA: TFMTBCDField;
    CadMoedasC_CIF_MOE: TWideStringField;
    localiza: TConsultaPadrao;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    cfg: TSQL;
    CadMoedasD_ULT_ALT: TSQLTimeStampField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function LocalizaIndice( CodigoMoeda : Integer ) : Double;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    procedure CarregaMoedasVazias;
  public
    procedure CarregaMoedaDia( CodigoMoedaAtual : Integer; CifraoAtual : string );
  end;

var
  FMoedaDia: TFMoedaDia;

implementation

uses APrincipal, fundata, constMsg, funstring, constantes, funSql;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFMoedaDia.FormCreate(Sender: TObject);
begin
   CadMoedas.open;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFMoedaDia.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := CaFree;
end;

{********* localiza o indice da moeda **************************************** }
function TFMoedaDia.LocalizaIndice( CodigoMoeda : Integer ) : Double;
begin
MovMoedas.close;
MovMoedas.sql.clear;
MovMoedas.sql.Add('select * from MovMoedas where i_cod_moe = ' + IntToStr(CodigoMoeda) +
                  'and D_DAT_ATU = '+SQLTextoDataAAAAMMMDD(Montadata(1,mes(date), ano(date))));
MovMoedas.Open;
result := MovMoedas.fieldByName('N_VLR_D' + AdicionaCharE('0',IntToStr(Dia(date)),2)).AsFloat;
end;


{*******************  carrega as moeda sem indice *************************** }
procedure TFMoedaDia.CarregaMoedasVazias;
begin
cadmoedas.DisableControls;
varia.MoedasVazias := '';
cadMoedas.close;
cadMoedas.sql.Clear;
CadMoedas.Sql.add('select * from CadMoedas where N_VLR_DIA = 0' );
cadMoedas.open;
while not CadMoedas.Eof do
begin
  if CadMoedasI_COD_MOE.AsInteger <> Varia.MoedaBase then // ignora a moeda base, sempre vale, caso naum seja a atual sempre sofre uma divisao
     varia.MoedasVazias := varia.MoedasVazias + CadMoedasC_NOM_MOE.AsString + '  ';
  CadMoedas.Next;
end;
cadMoedas.close;
cadMoedas.sql.Clear;
CadMoedas.Sql.add('select * from CadMoedas' );
cadMoedas.open;
CadMoedas.EnableControls;
end;

{*************** atualiza as moedas do dia ********************************** }
procedure TFMoedaDia.CarregaMoedaDia( CodigoMoedaAtual : Integer; CifraoAtual : string );
begin
  cadMoedas.First;
  while not CadMoedas.Eof do
  begin
    CadMoedas.edit;
      if CadMoedasI_COD_MOE.AsInteger = Varia.MoedaBase then  // a moeda base sempre vale 1
        CadMoedasN_VLR_DIA.AsFloat  := 1  // valor da moeda base..
      else
        CadMoedasN_VLR_DIA.AsFloat  := LocalizaIndice(CadMoedasI_COD_MOE.AsInteger);
    CadMoedasD_ULT_ALT.AsDateTime := Sistema.RDataServidor;
    CadMoedas.Post;
    cadMoedas.Next;
  end;
  Sistema.MarcaTabelaParaImportar('CADMOEDAS');
  cfg.open;
  Varia.DataDaMoeda := date;
  CarregaMoedasVazias;   // carrega a variavel global..varia.moedasVazias.
  cfg.Edit;
  cfg.fieldByName('C_MOE_VAZ').AsString := varia.MoedasVazias;
  cfg.fieldByName('D_DAT_MOE').AsDateTime := date;
  cfg.fieldByName('D_ULT_ALT').AsDateTime := Sistema.RDataServidor;
  cfg.Post;
  cfg.close;
  Sistema.MarcaTabelaParaImportar('CFG_GERAL');
  if varia.MoedasVazias <> '' then
    avisoFormato(CT_MoedasVazias, [ varia.MoedasVazias]);
  FPrincipal.AlteraNomeEmpresa;
end;


{******* fecha o formulario *********************************************** }
procedure TFMoedaDia.BitBtn2Click(Sender: TObject);
begin
close;
end;

{************** atualiza as moedas ****************************************** }
procedure TFMoedaDia.BitBtn1Click(Sender: TObject);
begin
  CarregaMoedaDia(varia.MoedaBase,CurrencyString);
end;

Initialization
 RegisterClasses([TFMoedaDia]);
end.
