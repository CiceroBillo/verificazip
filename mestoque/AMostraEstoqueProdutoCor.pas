unit AMostraEstoqueProdutoCor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente, Db, DBTables,
  Grids, DBGrids, Tabela, DBKeyViolation, DBClient;

type
  TFMostraEstoqueProdutoCor = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BFechar: TBitBtn;
    Grade: TGridIndice;
    Estoque: TSQL;
    DataEstoque: TDataSource;
    EstoqueI_COD_COR: TFMTBCDField;
    EstoqueN_QTD_PRO: TFMTBCDField;
    EstoqueC_COD_UNI: TWideStringField;
    EstoqueQtdPeca: TFMTBCDField;
    EstoqueI_CMP_PRO: TFMTBCDField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure EstoqueCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    VprSeqProduto : Integer;
    procedure AtualizaConsulta;
  public
    { Public declarations }
    procedure MostraEstoque(VpaSeqProduto : Integer);
  end;

var
  FMostraEstoqueProdutoCor: TFMostraEstoqueProdutoCor;

implementation

uses APrincipal, Constantes, funNumeros;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFMostraEstoqueProdutoCor.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFMostraEstoqueProdutoCor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Estoque.Close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFMostraEstoqueProdutoCor.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFMostraEstoqueProdutoCor.MostraEstoque(VpaSeqProduto : Integer);
begin
  VprSeqProduto := VpaSeqProduto;
  AtualizaConsulta;
  Showmodal; 
end;

{******************************************************************************}
procedure TFMostraEstoqueProdutoCor.AtualizaConsulta;
begin
  Estoque.close;
  Estoque.Sql.Clear;
  Estoque.Sql.Add('select MOV.I_COD_COR, MOV.N_QTD_PRO, PRO.C_COD_UNI, PRO.I_CMP_PRO '+
                  ' from MOVQDADEPRODUTO MOV, CADPRODUTOS PRO '+
                  ' Where MOV.I_SEQ_PRO = PRO.I_SEQ_PRO '+
                  ' AND PRO.I_COD_EMP = '+IntToStr(Varia.CodigoEmpresa)+
                  ' and MOV.I_SEQ_PRO = ' + IntToStr(VprSeqProduto));
  if config.EstoqueCentralizado then
    Estoque.Sql.Add('and MOV.I_EMP_FIL = '+ IntToStr(Varia.CodFilialControladoraEstoque))
  else
    Estoque.Sql.add('and MOV.I_EMP_FIL = '+InttoStr(varia.CodigoempFil));
  Estoque.Open;
end;

{******************************************************************************}
procedure TFMostraEstoqueProdutoCor.EstoqueCalcFields(DataSet: TDataSet);
begin
  if UpperCase(EstoqueC_COD_UNI.AsString) = 'KM' then
  begin
    EstoqueQtdPeca.AsFloat := ArredondaDecimais((EstoqueN_QTD_PRO.AsFloat * 1000) / (EstoqueI_CMP_PRO.AsInteger / 1000),2);
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFMostraEstoqueProdutoCor]);
end.
