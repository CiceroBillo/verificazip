unit AProdutosDevolvidos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Buttons, Db, DBTables,
  Grids, DBGrids, Tabela, DBKeyViolation, Localizacao;

type
  TFProdutosDevolvidos = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BFechar: TBitBtn;
    CadNotaFiscaisFor: TQuery;
    DataCadNotaFiscaisFor: TDataSource;
    Localiza: TConsultaPadrao;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    Label2: TLabel;
    ECliente: TEditLocaliza;
    MovNotasfiscaisFor: TQuery;
    MovNotasfiscaisForI_Seq_Not: TIntegerField;
    MovNotasfiscaisForC_Cod_pro: TStringField;
    MovNotasfiscaisForN_Qtd_Pro: TFloatField;
    MovNotasfiscaisForN_Vlr_Pro: TFloatField;
    MovNotasfiscaisForN_Per_Icm: TFloatField;
    MovNotasfiscaisForN_Per_IPI: TFloatField;
    MovNotasfiscaisForN_Tot_Pro: TFloatField;
    MovNotasfiscaisForC_Cod_Cst: TStringField;
    MovNotasfiscaisForI_Seq_Mov: TIntegerField;
    MovNotasfiscaisForC_Cod_Uni: TStringField;
    MovNotasfiscaisForC_Nom_pro: TStringField;
    MovNotasfiscaisForI_Emp_Fil: TIntegerField;
    DataMovNotasFiscaisFor: TDataSource;
    PanelColor3: TPanelColor;
    DBGridColor1: TDBGridColor;
    Splitter1: TSplitter;
    GridIndice1: TGridIndice;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure CadNotaFiscaisForAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
    VprOrdem : String;
    procedure AtualizaConsulta;
    procedure PosicionaMovNota(VpaCodFilial,VpaSeqNota : String);
  public
    { Public declarations }
    procedure MostraNotasCliente(VpaCodCliente : String);
  end;

var
  FProdutosDevolvidos: TFProdutosDevolvidos;

implementation

uses APrincipal, Constantes, FunSql;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFProdutosDevolvidos.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprOrdem := 'order by I_NRO_NOT';
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFProdutosDevolvidos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  CadNotaFiscaisFor.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFProdutosDevolvidos.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFProdutosDevolvidos.MostraNotasCliente(VpaCodCliente : String);
begin
  ECliente.Text := VpaCodCliente;
  ECliente.Atualiza;
  AtualizaConsulta;
  Showmodal;
end;

{******************************************************************************}
procedure TFProdutosDevolvidos.AtualizaConsulta;
begin
  CadNotaFiscaisFor.Sql.Clear;
  CadNotaFiscaisFor.Sql.add('Select Cad.I_Emp_Fil, Cad.I_Seq_Not, Cad.I_Nro_Not, Cad.C_Ser_Not, '+
                             ' Cad.D_Dat_Emi, N_Tot_Not, D_ULT_ALT, '+
                             ' Cad.I_Cod_Cli ||''-''|| Cli.C_Nom_Cli Fornecedor '+
                             ' from dba.CadnotaFiscaisFor Cad, CadClientes Cli ');


  CadNotaFiscaisFor.Sql.Add(' Where Cad.I_Cod_Cli = Cli.I_Cod_Cli'+
                             ' and cad.I_EMP_FIL = '+ IntToStr(Varia.CodigoEmpFil)+
                             ' and CAD.I_COD_CLI = ' + ECliente.Text);
  CadNotaFiscaisFor.SQL.Add(VprOrdem);
  GridIndice1.ALinhaSQLOrderBy := CadNotaFiscaisFor.SQL.Count -1;
  CadNotaFiscaisFor.open;
end;

{********************* posiciona o movnotasfiscaisfor *************************}
procedure TFProdutosDevolvidos.PosicionaMovNota(VpaCodFilial,VpaSeqNota : String);
begin
  if VpaSeqNota <> '' then
    AdicionaSQLAbreTabela(MovNotasfiscaisFor,'Select Mov.I_Emp_Fil, Mov.I_Seq_Not, Mov.C_Cod_pro, Mov.N_Qtd_Pro,' +
                         ' Mov.N_Vlr_Pro, Mov.N_Per_Icm, Mov.N_Per_IPI, ' +
                         ' Mov.N_Tot_Pro,  Mov.C_Cod_Cst, Mov.I_Seq_Mov, Mov.C_Cod_Uni, '+
                         ' Pro.C_Nom_pro '+
                         ' From dba.MovNotasFiscaisFor Mov, CadProdutos Pro '+
                         ' Where  Mov.I_Seq_pro = Pro.I_Seq_pro '+
                         ' and Mov.I_Emp_Fil = ' + VpaCodFilial+
                         ' and Mov.I_Seq_Not = '+ VpaSeqNota +
                         ' order by i_seq_Mov asc')
  else
    MovNotasfiscaisFor.close;
end;

{******************************************************************************}
procedure TFProdutosDevolvidos.CadNotaFiscaisForAfterScroll(
  DataSet: TDataSet);
begin
  PosicionaMovNota(CadNotaFiscaisFor.FieldByName('I_Emp_Fil').AsString,CadNotaFiscaisFor.FieldByName('I_SEQ_NOT').AsString);
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFProdutosDevolvidos]);
end.
