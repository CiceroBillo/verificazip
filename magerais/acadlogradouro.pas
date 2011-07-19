unit ACadLogradouro;

{          Autor: Douglas Thomas Jacobsen
    Data Cria��o: 19/10/1999;
          Fun��o: Cadastrar um novo Caixa
  Data Altera��o:
    Alterado por:
Motivo altera��o:
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, BotaoCadastro, Constantes,
  StdCtrls, Buttons, Db, DBTables, Tabela, Mask, DBCtrls, Grids, DBGrids,
  DBKeyViolation, Localizacao, DBClient;

type
  TFCadLogradouros = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    MoveBasico1: TMoveBasico;
    BotaoCadastrar1: TBotaoCadastrar;
    BAlterar: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    DataCadCaixa: TDataSource;
    Label2: TLabel;
    Bevel1: TBevel;
    Label1: TLabel;
    EConsulta: TLocalizaEdit;
    CadLogradouro: TSQL;
    BFechar: TBitBtn;
    GGrid: TGridIndice;
    ValidaGravacao: TValidaGravacao;
    Localiza: TConsultaPadrao;
    ECodigoLogradouro: TDBEditColor;
    CadLogradouroCOD_LOGRADOURO: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CadLogradouroAfterInsert(DataSet: TDataSet);
    procedure CadLogradouroAfterPost(DataSet: TDataSet);
    procedure CadLogradouroAfterEdit(DataSet: TDataSet);
    procedure BFecharClick(Sender: TObject);
    procedure CadLogradouroAfterCancel(DataSet: TDataSet);
    procedure GGridOrdem(Ordem: String);
    procedure KCodigoLogradouroChange(Sender: TObject);
  private
    procedure ConfiguraConsulta( acao : Boolean);
  public
    { Public declarations }
  end;

var
  FCadLogradouros: TFCadLogradouros;

implementation

uses APrincipal;

{$R *.DFM}

{ ****************** Na cria��o do Formul�rio ******************************** }
procedure TFCadLogradouros.FormCreate(Sender: TObject);
begin
   CadLogradouro.open;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFCadLogradouros.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CadLogradouro.close; { fecha tabelas }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              A��es da Tabela
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{***********************Gera o proximo codigo dispon�vel***********************}
procedure TFCadLogradouros.CadLogradouroAfterInsert(DataSet: TDataSet);
begin
   ECodigoLogradouro.ReadOnly := False;
   ConfiguraConsulta(False);
end;

{******************************Atualiza a tabela*******************************}
procedure TFCadLogradouros.CadLogradouroAfterPost(DataSet: TDataSet);
begin
  EConsulta.AtualizaTabela;
  ConfiguraConsulta(True);
end;

{*********************Coloca o campo chave em read-only************************}
procedure TFCadLogradouros.CadLogradouroAfterEdit(DataSet: TDataSet);
begin
   ECodigoLogradouro.ReadOnly := true;
   ConfiguraConsulta(False);
end;

{ ********************* quando cancela a operacao *************************** }
procedure TFCadLogradouros.CadLogradouroAfterCancel(DataSet: TDataSet);
begin
  ConfiguraConsulta(True);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              A��es Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{****************************Fecha o Formulario corrente***********************}
procedure TFCadLogradouros.BFecharClick(Sender: TObject);
begin
  Close;
end;

{****** configura a consulta, caso edit ou insert enabled = false *********** }
procedure TFCadLogradouros.ConfiguraConsulta( acao : Boolean);
begin
   Label1.Enabled := acao;
   EConsulta.Enabled := acao;
   GGrid.Enabled := acao;
end;

procedure TFCadLogradouros.GGridOrdem(Ordem: String);
begin
  EConsulta.AOrdem := ordem;
end;

procedure TFCadLogradouros.KCodigoLogradouroChange(Sender: TObject);
begin
  if (CadLogradouro.State in [dsInsert, dsEdit]) then
  ValidaGravacao.Execute;
end;

Initialization
 RegisterClasses([TFCadLogradouros]);
end.
