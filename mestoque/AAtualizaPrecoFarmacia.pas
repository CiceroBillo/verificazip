unit AAtualizaPrecoFarmacia;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Buttons, Gauges, Db,
  DBTables;

type
  TFAtualizaPrecoFarmacia = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BImportar: TBitBtn;
    BFechar: TBitBtn;
    Progresso: TGauge;
    Label1: TLabel;
    LNomProduto: TLabel;
    CProdutosNovos: TCheckBox;
    Cadastro: TQuery;
    TabelaDe: TQuery;
    Aux: TQuery;
    Cadastro2: TQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BImportarClick(Sender: TObject);
  private
    { Private declarations }
    function RSeqProduto(VpaCodProduto : String):Integer;
    function RSeqProdutoDisponivel : Integer;
    function RCodPrincipoDisponivel : Integer;
    function RCodClassificao(VpaNomClassificacao : String):String;
    function RCodPrincipioAtivo(VpaNomPrincipio : String):Integer;
    procedure CadastraProduto;
    procedure InseriPrecoVenda(VpaSeqProduto : Integer);
    procedure InseriPrecoCompra(VpaSeqProduto : Integer);
    procedure AtualizaPrecoCompra(VpaSeqProduto : Integer);
    procedure AtualizaPrecoVenda(VpaSeqProduto : Integer);
  public
    { Public declarations }
  end;

var
  FAtualizaPrecoFarmacia: TFAtualizaPrecoFarmacia;

implementation

uses APrincipal,FunSql, funString;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFAtualizaPrecoFarmacia.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFAtualizaPrecoFarmacia.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
function TFAtualizaPrecoFarmacia.RSeqProduto(VpaCodProduto : String):Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select I_SEQ_PRO from CADPRODUTOS '+
                            ' Where C_COD_PRO = '''+VpaCodProduto+'''');
  result := Aux.FieldByName('I_SEQ_PRO').AsInteger;
  Aux.close;
end;

{******************************************************************************}
function TFAtualizaPrecoFarmacia.RSeqProdutoDisponivel : Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select max(I_SEQ_PRO) ULTIMO from CADPRODUTOS ');
  result := Aux.FieldByName('ULTIMO').AsInteger + 1;
  Aux.Close;
end;

{******************************************************************************}
function TFAtualizaPrecoFarmacia.RCodPrincipoDisponivel : Integer;
begin
  AdicionaSqlAbreTabela(Aux,'Select MAX(CODPRINCIPIO) ULTIMO from PRINCIPIOATIVO');
  result := Aux.FieldByName('ULTIMO').AsInteger + 1;
  Aux.Close;
end;


{******************************************************************************}
function TFAtualizaPrecoFarmacia.RCodClassificao(VpaNomClassificacao : String):String;
begin
  VpaNomClassificacao := DeletaChars(VpaNomClassificacao,'''');
  AdicionaSQLAbreTabela(Aux,'Select * from CADCLASSIFICACAO '+
                               ' Where C_NOM_CLA = '''+VpaNomClassificacao+'''');
  if Aux.eof then
    result := '09'
  else
    result := Aux.FieldByName('C_COD_CLA').AsString;
  Aux.Close;
end;

{******************************************************************************}
function TFAtualizaPrecoFarmacia.RCodPrincipioAtivo(VpaNomPrincipio : String):Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select * from PRINCIPIOATIVO '+
                               ' Where NOMPRINCIPIO = '''+VpaNomPrincipio+'''');
  if Aux.eof then
  begin
    AdicionaSQLAbreTabela(Cadastro2,'Select * from PRINCIPIOATIVO');
    Cadastro2.Insert;
    result := RCodPrincipoDisponivel;
    Cadastro2.FieldByName('CODPRINCIPIO').AsInteger := result;
    Cadastro2.FieldByName('NOMPRINCIPIO').AsString := VpaNomPrincipio;
    Cadastro2.post;
  end
  else
    result := Aux.FieldByName('CODPRINCIPIO').AsInteger;
  Aux.Close;
end;

{******************************************************************************}
procedure TFAtualizaPrecoFarmacia.CadastraProduto;
var
  VpfSeqProduto : Integer;
begin
  Cadastro.Insert;
  VpfSeqProduto := RSeqProdutoDisponivel;
  Cadastro.FieldByName('I_SEQ_PRO').AsInteger := VpfSeqProduto;
  Cadastro.FieldByName('C_COD_CLA').AsString := RCodClassificao(TabelaDE.FieldByName('LAB_NOM').AsString);
  Cadastro.FieldByName('C_ATI_PRO').AsString := 'S';
  Cadastro.FieldByName('C_COD_PRO').AsString := TabelaDE.FieldByName('MED_BARRA').AsString;
  Cadastro.FieldByName('C_NOM_PRO').AsString := TabelaDE.FieldByName('MED_DES').AsString+' '+TabelaDE.FieldByName('MED_APR').AsString;
  Cadastro.FieldByName('I_PRI_ATI').AsInteger := RCodPrincipioAtivo(TabelaDE.FieldByName('MED_PRINCI').AsString);
  if TabelaDE.FieldByName('MED_GENE').AsString = 'GEN' then
    Cadastro.FieldByName('C_IND_GEN').AsString := 'T'
  else
    Cadastro.FieldByName('C_IND_GEN').AsString := 'F';
  Cadastro.FieldByName('I_COD_EMP').AsInteger := 1;
  Cadastro.FieldByName('I_COD_MOE').AsInteger := 1101;
  Cadastro.FieldByName('D_DAT_CAD').AsDatetime := date;
  Cadastro.FieldByName('C_KIT_PRO').AsString := 'P';
  Cadastro.FieldByName('C_VEN_AVU').AsString := 'S';
  Cadastro.FieldByName('C_CIF_MOE').AsString := 'R$';
  if TabelaDE.FieldByName('MED_UNI').AsInteger <> 0 then
  begin
    Cadastro.FieldByName('C_COD_UNI').AsString := 'cx';
    Cadastro.FieldByName('I_IND_COV').AsInteger := TabelaDE.FieldByName('MED_UNI').AsInteger;
  end
  else
    Cadastro.FieldByName('C_COD_UNI').AsString := 'pc';
  Cadastro.Post;
  InseriPrecoVenda(VpfSeqProduto);
  InseriPrecoCompra(VpfSeqProduto);
end;

{******************************************************************************}
procedure TFAtualizaPrecoFarmacia.InseriPrecoVenda(VpaSeqProduto : Integer);
var
  vpfValor : Double;
begin
  if TabelaDE.FieldByName('MED_PCO17').AsFloat > 0 then
    VpfValor := TabelaDE.FieldByName('MED_PCO17').AsFloat
  else
  begin
    vpfValor := TabelaDE.FieldByName('MED_PLA17').AsFloat + ((TabelaDE.FieldByName('MED_PLA17').AsFloat*5)/100);
    VpfValor := vpfValor + ((vpfValor * 41.34)/100);
  end;

  AdicionaSQLAbreTabela(Cadastro2,'Select * from MOVTABELAPRECO ');
  Cadastro2.Insert;
  Cadastro2.FieldByName('I_COD_EMP').AsInteger := 1;
  Cadastro2.FieldByName('I_SEQ_PRO').AsInteger := VpaSeqProduto;
  Cadastro2.FieldByName('I_COD_TAB').AsInteger := 1101;
  Cadastro2.FieldByName('I_COD_MOE').AsInteger := 1101;
  Cadastro2.FieldByName('I_COD_CLI').AsInteger := 0;
  Cadastro2.FieldByName('C_CIF_MOE').AsString := 'R$';
  Cadastro2.FieldByName('N_VLR_VEN').AsFloat := VpfValor;
  Cadastro2.post;
  Cadastro2.Close;
end;

{******************************************************************************}
procedure TFAtualizaPrecoFarmacia.InseriPrecoCompra(VpaSeqProduto : Integer);
begin
  AdicionaSQLAbreTabela(Cadastro2,'Select * from MOVQDADEPRODUTO '+
                                     ' Where I_SEQ_PRO = '+IntToStr(VpaSeqProduto));
  if not Cadastro2.Eof then
    Cadastro2.edit
  else
    Cadastro2.Insert;
  Cadastro2.FieldByName('I_EMP_FIL').AsInteger := 11;
  Cadastro2.FieldByName('I_SEQ_PRO').AsInteger := VpaSeqProduto;
  Cadastro2.FieldByName('N_VLR_CUS').AsFloat := TabelaDE.FieldByName('MED_PLA17').AsFloat;
  Cadastro2.FieldByName('N_VLR_COM').AsFloat := TabelaDE.FieldByName('MED_PLA17').AsFloat;
  Cadastro2.FieldByName('I_COD_COR').AsInteger := 0;
  Cadastro2.post;
  Cadastro2.Close;
end;

{******************************************************************************}
procedure TFAtualizaPrecoFarmacia.AtualizaPrecoCompra(VpaSeqProduto : Integer);
begin
  ExecutaComandoSql(Aux,'UPDATE MOVQDADEPRODUTO '+
                        ' SET N_VLR_COM = '+SubstituiStr(FormatFloat('0.00',TabelaDE.FieldByName('MED_PLA17').AsFloat),',','.')+
                        ' Where I_SEQ_PRO = '+IntToStr(VpaSeqProduto));
end;

{******************************************************************************}
procedure TFAtualizaPrecoFarmacia.AtualizaPrecoVenda(VpaSeqProduto : Integer);
var
  vpfValor : Double;
begin
  if TabelaDE.FieldByName('MED_PCO17').AsFloat > 0 then
    VpfValor := TabelaDE.FieldByName('MED_PCO17').AsFloat
  else
  begin
    vpfValor := TabelaDE.FieldByName('MED_PLA17').AsFloat + ((TabelaDE.FieldByName('MED_PLA17').AsFloat*5)/100);
    VpfValor := vpfValor + ((vpfValor * 41.34)/100);
  end;
  ExecutaComandoSql(Aux,'UPDATE MOVTABELAPRECO '+
                        ' SET N_VLR_VEN = '+SubstituiStr(FormatFloat('0.00',VpfValor),',','.')+
                        ' Where I_SEQ_PRO = '+IntToStr(VpaSeqProduto));
end;

{******************************************************************************}
procedure TFAtualizaPrecoFarmacia.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFAtualizaPrecoFarmacia.BImportarClick(Sender: TObject);
var
  VpfSeqProduto : Integer;
begin
  Progresso.Progress := 0;
  AdicionaSQLAbreTabela(Cadastro,'Select * from cadProdutos');
  AdicionaSQLAbreTabela(TabelaDE,'Select * from TABELA');
  Progresso.MaxValue := TabelaDE.RecordCount;
  While not TabelaDe.Eof do
  begin
    LNomProduto.Caption := TabelaDE.FieldByName('MED_BARRA').AsString ;
    LNomProduto.Refresh;

    VpfSeqProduto := RSeqProduto( TabelaDE.FieldByName('MED_BARRA').AsString);

    if VpfSeqProduto = 0 then
      CadastraProduto
    else
      if not CProdutosNovos.Checked then
      begin
        AtualizaPrecoCompra(VpfSeqProduto);
        AtualizaPrecoVenda(VpfSeqProduto);
      end;

    Progresso.AddProgress(1);
    TabelaDe.Next;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFAtualizaPrecoFarmacia]);
end.
