unit ANovaNatureza;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Db, BotaoCadastro, StdCtrls, Buttons, DBTables, Tabela,
  Componentes1, ExtCtrls, PainelGradiente, DBKeyViolation, Grids, DBGrids,
  Mask, DBCtrls, Localizacao, ComCtrls, DBClient, unSistema;

type
  TFNovaNatureza = class(TFormularioPermissao)
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    Label1: TLabel;
    DataNatureza: TDataSource;
    Label2: TLabel;
    DBEditColor2: TDBEditColor;
    DBKeyViolation1: TDBKeyViolation;
    CadNaturezas: TSQL;
    BFechar: TBitBtn;
    Localiza: TConsultaPadrao;
    ValidaGravacao1: TValidaGravacao;
    CadNaturezasC_COD_NAT: TWideStringField;
    CadNaturezasC_NOM_NAT: TWideStringField;
    PainelGradiente1: TPainelGradiente;
    DBGridColor1: TDBGridColor;
    BitBtn1: TBitBtn;
    MovNaturezas: TSQL;
    MovNaturezasC_COD_NAT: TWideStringField;
    MovNaturezasI_SEQ_MOV: TFMTBCDField;
    MovNaturezasC_NOM_MOV: TWideStringField;
    DataMovNatureza: TDataSource;
    CadNaturezasD_ULT_ALT: TSQLTimeStampField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CadNaturezasAfterInsert(DataSet: TDataSet);
    procedure BFecharClick(Sender: TObject);
    procedure CadNaturezasAfterEdit(DataSet: TDataSet);
    procedure DBKeyViolation1Change(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure CadNaturezasBeforePost(DataSet: TDataSet);
    procedure DBKeyViolation1KeyPress(Sender: TObject; var Key: Char);
    procedure CadNaturezasBeforeDelete(DataSet: TDataSet);
  private
  public
    procedure PosicionaNatureza(Query : TSQL;Codigo : String);
  end;

var
  FNovaNatureza: TFNovaNatureza;

implementation

uses APrincipal, ANaturezas, FunSql,AOperacoesEstoques, APlanoConta, constantes,
  AMovNatureza;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovaNatureza.FormCreate(Sender: TObject);
begin
   CadNaturezas.open;  {  abre tabelas }
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovaNatureza.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   CadNaturezas.close; { fecha tabelas }
   Action := CaFree;
end;

{***********************Gera o proximo codigo disponível***********************}
procedure TFNovaNatureza.CadNaturezasAfterInsert(DataSet: TDataSet);
begin
   DBKeyViolation1.ReadOnly := False;
end;

{*********************Coloca o campo chave em read-only************************}
procedure TFNovaNatureza.CadNaturezasAfterEdit(DataSet: TDataSet);
begin
   DBKeyViolation1.ReadOnly := true;
end;

{************Posiciona a tabela passada conforme o codigo passado**************}
procedure TFNovaNatureza.PosicionaNatureza(Query : TSQL; Codigo : String);
begin
   AdicionaSQLAbreTabela(Query,'Select * from CadNatureza ' +
                               ' Where C_Cod_Nat = ''' + Codigo + '''');
  AdicionaSQLAbreTabela(MovNaturezas,' Select * from MovNatureza ' +
                                     ' Where C_Cod_Nat = ''' + Codigo + '''');

end;

{****************************Fecha o Formulario corrente***********************}
procedure TFNovaNatureza.BFecharClick(Sender: TObject);
begin
   close;
end;

procedure TFNovaNatureza.DBKeyViolation1Change(Sender: TObject);
begin
  if CadNaturezas.State in [ dsEdit, dsInsert ] then
    ValidaGravacao1.execute;
end;

procedure TFNovaNatureza.DBKeyViolation1KeyPress(Sender: TObject; var Key: Char);
begin
  if not(key in ['0'..'9','/',#8]) then
    key := #0;

end;

procedure TFNovaNatureza.BitBtn1Click(Sender: TObject);
begin
  if CadNaturezas.State in [dsedit,dsinsert] then
    CadNaturezas.post;

  FMovNatureza :=  TFMovNatureza.CriarSDI(application, '', true);
  FMovNatureza.PosicionaNatureza(CadNaturezasC_COD_NAT.AsString,CadNaturezasC_NOM_NAT.AsString);
  AtualizaSQLTabela(MovNaturezas);
  close;
end;

{******************* antes de gravar o registro *******************************}
procedure TFNovaNatureza.CadNaturezasBeforeDelete(DataSet: TDataSet);
begin
  ExecutaComandoSql(MovNaturezas,'Delete from MOVNATUREZA ' +
                                 ' WHERE C_COD_NAT = '''+CadNaturezasC_COD_NAT.AsString+'''');
end;

procedure TFNovaNatureza.CadNaturezasBeforePost(DataSet: TDataSet);
begin
  //atualiza a data de alteracao para poder exportar
  CadNaturezasD_ULT_ALT.AsDateTime := Sistema.RDataServidor;
  Sistema.MarcaTabelaParaImportar('CADNATUREZA');
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovaNatureza]);
end.
