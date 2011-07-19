unit AEmpresas;
{          Autor: Sergio Luiz Censi
    Data Criação: 01/04/1999;
          Função: Cadastrar um novo
  Data Alteração: 01/04/1999;
    Alterado por: Rafael Budag
Motivo alteração: - Adicionado os comentários e o blocos nas rotinas, e realizado
                    um teste - 01/04/199 / Rafael Budag
}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Db, DBTables, Tabela, ExtCtrls, Grids, DBGrids, BotaoCadastro, StdCtrls,
  Buttons, Componentes1, Mask, DBCtrls, constMsg, constantes,
  DBKeyViolation, PainelGradiente, Localizacao, DBClient;

type
  TFEmpresas = class(TFormularioPermissao)
    DataEmpresas: TDataSource;
    PanelColor1: TPanelColor;
    Label1: TLabel;
    CodigoEmpresa: TDBKeyViolation;
    Label2: TLabel;
    DBEditColor2: TDBEditColor;
    PanelColor2: TPanelColor;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    GridIndice1: TGridIndice;
    PainelGradiente1: TPainelGradiente;
    MoveBasico1: TMoveBasico;
    Bevel1: TBevel;
    Consulta: TLocalizaEdit;
    CadEmpresas: TSQL;
    CadEmpresasI_COD_EMP: TFMTBCDField;
    CadEmpresasC_NOM_EMP: TWideStringField;
    Label3: TLabel;
    BFechar: TBitBtn;
    ValidaGravacao1: TValidaGravacao;
    CadEmpresasC_MAS_PLA: TWideStringField;
    CadEmpresasC_PIC_CLA: TWideStringField;
    CadEmpresasC_PIC_PRO: TWideStringField;
    CadEmpresasD_ULT_ALT: TSQLTimeStampField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BotaoGravar1DepoisAtividade(Sender: TObject);
    procedure CadEmpresasBeforeInsert(DataSet: TDataSet);
    procedure CadEmpresasBeforePost(DataSet: TDataSet);
    procedure CadEmpresasAfterInsert(DataSet: TDataSet);
    procedure CadEmpresasAfterEdit(DataSet: TDataSet);
    procedure BFecharClick(Sender: TObject);
    procedure GridIndice1Ordem(Ordem: String);
    procedure CodigoEmpresaChange(Sender: TObject);
    procedure CadEmpresasAfterCancel(DataSet: TDataSet);
    procedure CadEmpresasAfterPost(DataSet: TDataSet);
  private
    procedure ConfiguraConsulta( acao : Boolean);
  public
    { Public declarations }
  end;

var
  FEmpresas: TFEmpresas;
  inseriu : boolean;
implementation

uses ANovaFilial, APrincipal, UnSistema;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFEmpresas.FormCreate(Sender: TObject);
begin
  inseriu := false;
  CadEmpresas.open;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFEmpresas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CadEmpresas.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações das Tabelas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{************************Seta o flag como inserindo****************************}
procedure TFEmpresas.CadEmpresasBeforeInsert(DataSet: TDataSet);
begin
   inseriu := true;
end;

{********Verifica se o codigo ja foi utilizado por algum usuario da rede*******}
procedure TFEmpresas.CadEmpresasBeforePost(DataSet: TDataSet);
begin
  //atualiza a data de alteracao para poder exportar
  CadEmpresasD_ULT_ALT.AsDateTime := Sistema.RDataServidor;
  if CadEmpresas.State = dsinsert then
     CodigoEmpresa.VerificaCodigoutilizado;
end;

{***********************Gera o proximo codigo disponível***********************}
procedure TFEmpresas.CadEmpresasAfterInsert(DataSet: TDataSet);
begin
   CodigoEmpresa.ProximoCodigo;
   CodigoEmpresa.ReadOnly := False;
   ConfiguraConsulta(false);
   CadEmpresasC_MAS_PLA.AsString := '0';
   CadEmpresasC_PIC_CLA.AsString := '9';
   CadEmpresasC_PIC_PRO.AsString := '9';
end;

{*********************Coloca o campo chave em read-only************************}
procedure TFEmpresas.CadEmpresasAfterEdit(DataSet: TDataSet);
begin
   CodigoEmpresa.ReadOnly := True;
   ConfiguraConsulta(false);
end;

{********************** quando cancela uma operecao na tabela **************** }
procedure TFEmpresas.CadEmpresasAfterCancel(DataSet: TDataSet);
begin
  ConfiguraConsulta(true);
end;

{************* apos efeturar o post ****************************************** }
procedure TFEmpresas.CadEmpresasAfterPost(DataSet: TDataSet);
begin
  ConfiguraConsulta(true);
  Sistema.MarcaTabelaParaImportar('CADEMPRESAS');
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{****** configura a consulta, caso edit ou insert enabled = false *********** }
procedure TFEmpresas.ConfiguraConsulta( acao : Boolean);
begin
   Consulta.Enabled := acao;
   GridIndice1.Enabled := acao;
   Label3.Enabled := acao;
end;

{************************Cadastra uma nova Filial******************************}
procedure TFEmpresas.BotaoGravar1DepoisAtividade(Sender: TObject);
begin
   if inseriu then
   begin
      FNovaFilial := TFNovaFilial.CriarSDI(application,'Cadastro da Nova Empresa',FPrincipal.VerificaPermisao('FNovaFilial'));
      FNovaFilial.EmpresaCadastro := CodigoEmpresa.Field.Value;
      FNovaFilial.CadFiliais.Insert;
      Varia.AcaoCAncela := false;
      FNovaFilial.ShowModal;
      if Varia.AcaoCancela then
      begin
       try
         CadEmpresas.delete;
       except
          erro(CT_ErroDeletaRegistroPai);
       end;
      end;
    inseriu := false;
   end;
consulta.AtualizaTabela;
end;

{****************************Fecha o Formulario corrente***********************}
procedure TFEmpresas.BFecharClick(Sender: TObject);
begin
   Close;
end;

{*********** adiciona o order by na consulta ********************************* }
procedure TFEmpresas.GridIndice1Ordem(Ordem: String);
begin
Consulta.AOrdem := ordem;
end;

{*********** valida a gravacao do formulario ******************************* }
procedure TFEmpresas.CodigoEmpresaChange(Sender: TObject);
begin
if CadEmpresas.State in [ dsInsert, dsEdit ] then
  ValidaGravacao1.execute;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFEmpresas]);
end.
