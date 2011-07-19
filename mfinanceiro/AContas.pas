unit AContas;
{          Autor: Sergio Luiz Censi
    Data Criação: 29/03/1999;
          Função: Cadastrar um novo
  Data Alteração: 29/03/1999;
    Alterado por: Rafael Budag
Motivo alteração: - adicionado os comentarios e os blocos no codigo e feita toda
                    a revisão - 29/03/1999 / Rafael Budag.
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, BotaoCadastro,
  StdCtrls, Buttons, Db, DBTables, Tabela, Mask, DBCtrls, Localizacao,
  DBKeyViolation, Grids, DBGrids, DBClient, FMTBcd, SqlExpr;

type
  TFContas = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    DataContas: TDataSource;
    CadContas: TSQL;
    BFechar: TBitBtn;
    DBGridColor1: TGridIndice;
    BotaoConsultar1: TBotaoConsultar;
    CadContasI_COD_BAN: TFMTBCDField;
    CadContasC_NRO_AGE: TWideStringField;
    CadContasC_NRO_CON: TWideStringField;
    CadContasC_NOM_GER: TWideStringField;
    CadContasC_NOM_CRR: TWideStringField;
    CadContasC_NOM_BAN: TWideStringField;
    PanelColor1: TPanelColor;
    CSomenteAtivos: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BotaoCadastrar1AntesAtividade(Sender: TObject);
    procedure BotaoCadastrar1DepoisAtividade(Sender: TObject);
    procedure BotaoAlterar1Atividade(Sender: TObject);
    procedure BotaoExcluir1DepoisAtividade(Sender: TObject);
    procedure BotaoExcluir1DestroiFormulario(Sender: TObject);
    procedure DBGridColor1DblClick(Sender: TObject);
    procedure CSomenteAtivosClick(Sender: TObject);
  private
    procedure AtualizaConsulta;
    procedure AdicionaFiltros(VpaSelect : TStrings);
  public
    { Public declarations }
  end;

var
  FContas: TFContas;

implementation

uses APrincipal, Constantes, ABancos, ANovaConta, funSql;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFContas.FormCreate(Sender: TObject);
begin
   atualizaconsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
 procedure TFContas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   CadContas.close;
   Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações das Tabelas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFContas.AdicionaFiltros(VpaSelect: TStrings);
begin

end;

{******************************************************************************}
procedure TFContas.AtualizaConsulta;
begin
  CadContas.Close;
  CadContas.sql.Clear;
  AdicionaSQLTabela(CadContas,'Select CON.I_COD_BAN, CON.C_NRO_AGE, CON.C_NRO_CON, CON.C_NOM_GER, '+
                                  ' CON.C_NOM_CRR, ' +
                                  ' BAN.C_NOM_BAN '+
                                  ' from CadContas CON, CADBANCOS BAN '+
                                  ' WHERE CON.I_COD_BAN = BAN.I_COD_BAN');
  AdicionaFiltros(CadContas.sql);
  CadContas.Open;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{***************************Fechar o Formulario corrente***********************}
procedure TFContas.BFecharClick(Sender: TObject);
begin
self.close;
end;



procedure TFContas.BotaoCadastrar1AntesAtividade(Sender: TObject);
begin
  FNovaConta := TFNovaConta.CriarSDI(application,'', FPrincipal.VerificaPermisao('FNovaConta'));
end;

{******************************************************************************}
procedure TFContas.BotaoCadastrar1DepoisAtividade(Sender: TObject);
begin
  FNovaConta.ShowModal;
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFContas.BotaoAlterar1Atividade(Sender: TObject);
begin
  AdicionaSQLAbreTabela(FNovaConta.CadContas,'Select * from CADCONTAS '+
                                             ' where C_NRO_CON = '''+CadContasC_NRO_CON.AsString+'''');
end;

{******************************************************************************}
procedure TFContas.BotaoExcluir1DepoisAtividade(Sender: TObject);
begin
  FNovaConta.show;
end;

procedure TFContas.BotaoExcluir1DestroiFormulario(Sender: TObject);
begin
  FNovaConta.close;
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFContas.CSomenteAtivosClick(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFContas.DBGridColor1DblClick(Sender: TObject);
begin
  if CadContasC_NRO_CON.AsString <> '' then
    BotaoAlterar1.Click;
end;

Initialization
{*******************Registra a classe para evitar duplicidade******************}
 RegisterClasses([TFContas]);
end.
