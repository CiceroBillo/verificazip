unit AInventario;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Db, DBTables, Grids, DBGrids,
  Tabela, DBKeyViolation, UnInventario, StdCtrls, Localizacao, ComCtrls, UnNotasFiscaisFor,
  Buttons, unProdutos, Undados, UnDadosProduto, sqlexpr, DBClient;

Const
  CT_QTDINVALIDA = 'QUANTIDADE INVÁLIDA!!!'#13'Quantidade digitada inválida ou vazia...';

type
  TFInventario = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    GInv: TGridIndice;
    InventarioCorpo: TSQL;
    DataInventario: TDataSource;
    InventarioCorpoCOD_FILIAL: TFMTBCDField;
    InventarioCorpoSEQ_INVENTARIO: TFMTBCDField;
    InventarioCorpoCOD_USUARIO: TFMTBCDField;
    InventarioCorpoDAT_INICIO: TSQLTimeStampField;
    InventarioCorpoDAT_FIM: TSQLTimeStampField;
    InventarioCorpoC_NOM_USU: TWideStringField;
    BCadastrar: TBitBtn;
    BAdicionarProdutos: TBitBtn;
    BFecharInventario: TBitBtn;
    BFechar: TBitBtn;
    BAlterar: TBitBtn;
    PainelTempo1: TPainelTempo;
    BImprimir: TBitBtn;
    InventarioCorpoC_NOM_CLA: TWideStringField;
    BExcluir: TBitBtn;
    Bduplicar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BCadastrarClick(Sender: TObject);
    procedure BAdicionarProdutosClick(Sender: TObject);
    procedure BAlterarClick(Sender: TObject);
    procedure BFecharInventarioClick(Sender: TObject);
    procedure InventarioCorpoAfterScroll(DataSet: TDataSet);
    procedure BImprimirClick(Sender: TObject);
    procedure BExcluirClick(Sender: TObject);
    procedure BduplicarClick(Sender: TObject);
  private
    { Private declarations }
    VprOrdem : String;
    FunInventario : TRBFuncoesInventario;
    VprDInventario : TRBDInventarioCorpo;
    procedure Atualizaconsulta;
  public
    { Public declarations }
  end;

var
  FInventario: TFInventario;

implementation

uses APrincipal, Constantes, ConstMsg, UnSistema, FunSql, ANovoInventario, FunObjeto,
  AInicializaNovoInventario, dmRave;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFInventario.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprOrdem := 'order by INV.SEQ_INVENTARIO';
  FunInventario := TRBFuncoesInventario.cria(FPrincipal.BaseDados);
  VprDInventario := TRBDInventarioCorpo.cria;
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFInventario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunInventario.free;
  VprDInventario.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFInventario.Atualizaconsulta;
var
  VpfCodFilial : String;
begin
  if config.EstoqueCentralizado then
    VpfCodfilial := IntTostr(Varia.CodFilialControladoraEstoque)
  else
    vpfCodfilial := InttoStr(Varia.CodigoEmpFil);
  InventarioCorpo.Close;
  InventarioCorpo.Sql.Clear;
  InventarioCorpo.Sql.add('Select INV.COD_FILIAL, INV.SEQ_INVENTARIO, INV.DAT_INICIO, '+
                                        ' INV.DAT_FIM, INV.COD_USUARIO, USU.C_NOM_USU, CLA.C_NOM_CLA '+
                                        ' from INVENTARIOCORPO INV, CADUSUARIOS USU, CADCLASSIFICACAO CLA '+
                                        ' WHERE INV.COD_USUARIO = USU.I_COD_USU '+
                                        ' AND INV.COD_FILIAL = '+ VpfCodFilial+
                                        '  AND '+SQLTextoRightJoin('INV.CODCLASSIFICACAO','CLA.C_COD_CLA'));
  InventarioCorpo.SQL.add(VprOrdem);
  InventarioCorpo.open;
end;

{******************************************************************************}
procedure TFInventario.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFInventario.BCadastrarClick(Sender: TObject);
begin
  FInicializaNovoInventario := TFInicializaNovoInventario.CriarSDI(self,'',FPrincipal.VerificaPermisao('FInicializaNovoInventario'));
  if FInicializaNovoInventario.NovoInventario then
    Atualizaconsulta;
  FInicializaNovoInventario.free;
end;

{******************************************************************************}
procedure TFInventario.BduplicarClick(Sender: TObject);
begin
  if InventarioCorpoSEQ_INVENTARIO.AsInteger <> 0 then
  begin
    FInicializaNovoInventario := TFInicializaNovoInventario.CriarSDI(self,'',FPrincipal.VerificaPermisao('FInicializaNovoInventario'));
    if FInicializaNovoInventario.Duplicar(VprDInventario) then
      Atualizaconsulta;
    FInicializaNovoInventario.free;
  end;
end;

{******************************************************************************}
procedure TFInventario.BAdicionarProdutosClick(Sender: TObject);
begin
  VprDInventario.CodFilial := InventarioCorpoCOD_FILIAL.AsInteger;
  VprDInventario.SeqInventario := InventarioCorpoSEQ_INVENTARIO.AsInteger;
  FreeTObjectsList(VprDInventario.ItemsInventario);
  FNovoInventario := TFNovoInventario.CriarSDI(application , '', FPrincipal.VerificaPermisao('FNovoInventario'));
  FNovoInventario.AdicionaProdutos(VprDInventario);
  FNovoInventario.free;
end;

{******************************************************************************}
procedure TFInventario.BAlterarClick(Sender: TObject);
begin
  FunInventario.CarDInventario(VprDInventario,InventarioCorpoCOD_FILIAL.AsInteger,InventarioCorpoSEQ_INVENTARIO.AsInteger);
  FNovoInventario := TFNovoInventario.CriarSDI(application , '', FPrincipal.VerificaPermisao('FNovoInventario'));
  FNovoInventario.AlteraProdutos(VprDInventario);
  FNovoInventario.Free;
end;

{******************************************************************************}
procedure TFInventario.BFecharInventarioClick(Sender: TObject);
var
  VpfResultado : String;
  VpfTransacao : TTransactionDesc;
begin
  if Confirmacao('Tem certeza que deseja finalizar o Inventário?') then
  begin
    PainelTempo1.execute('Fechando Inventário. Favor Aguardar.');
    FunInventario.CarDInventario(VprDInventario,InventarioCorpoCOD_FILIAL.AsInteger,InventarioCorpoSEQ_INVENTARIO.AsInteger);
    VpfTransacao.IsolationLevel := xilREADCOMMITTED;
    FPrincipal.BaseDados.StartTransaction(VpfTransacao);
    VpfResultado := FunInventario.FechaInventario( VprDInventario);
    if VpfResultado <> '' then
    begin
      aviso(VpfResultado);
      FPrincipal.BaseDados.Rollback(VpfTransacao);
    end
    else
    begin
      FPrincipal.BaseDados.Commit(VpfTransacao);
      Atualizaconsulta;
    end;
    PainelTempo1.fecha;
  end;
end;

{******************************************************************************}
procedure TFInventario.InventarioCorpoAfterScroll(DataSet: TDataSet);
begin
  BFecharInventario.Enabled := InventarioCorpoDAT_FIM.IsNull;
  BAlterar.Enabled := BFecharInventario.Enabled;
  BAdicionarProdutos.Enabled := BFecharInventario.Enabled;
end;

{******************************************************************************}
procedure TFInventario.BImprimirClick(Sender: TObject);
Var
  VpfDFilial : TRBDFilial;
begin
  if InventarioCorpoSEQ_INVENTARIO.AsInteger <> 0 then
  begin
    VpfDFilial := TRBDFilial.cria;
    Sistema.CarDFilial(VpfDFilial,InventarioCorpoCOD_FILIAL.AsInteger);
    dtRave := TdtRave.create(self);
    dtRave.ImprimeInventarioProduto(InventarioCorpoCOD_FILIAL.AsInteger,InventarioCorpoSEQ_INVENTARIO.AsInteger,'',VpfDFilial.NomFilial);
    dtRave.free;
    VpfDFilial.Free;
  end;
end;

{******************************************************************************}
procedure TFInventario.BExcluirClick(Sender: TObject);
begin
  if InventarioCorpoDAT_FIM.IsNull then
  begin
    if confirmacao('Tem certeza que deseja excluir o inventário?') then
    begin
      FunInventario.DeletaInventario(InventarioCorpoCOD_FILIAL.AsInteger,InventarioCorpoSEQ_INVENTARIO.AsInteger);
      Atualizaconsulta;
    end;
  end
  else
    aviso('ERRO EXCLUSÃO!!!'+#13+'Não é possível excluir um inventário que já foi fechado!!!');
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFInventario]);
end.
