unit AItensGerarNotaParcial;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, CheckLst, Buttons, Componentes1, ExtCtrls, PainelGradiente, Db,
  DBTables, Mask, numericos;

Type
  TDadoLista = class
    SeqPro : Integer;
    ValorTotalPro : Double;
  end;

type
  TFItensGeraNotaParcial = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BitBtn3: TBitBtn;
    Lista: TCheckListBox;
    Itens: TQuery;
    EValorDevolver: Tnumerico;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ListaClickCheck(Sender: TObject);
    procedure ListaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ListaMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
  public
     procedure CarregaItens( seqNotaFiscal : Integer ) ;
  end;

var
  FItensGeraNotaParcial: TFItensGeraNotaParcial;

implementation

uses APrincipal, funsql, constantes, funstring;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFItensGeraNotaParcial.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFItensGeraNotaParcial.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 { fecha tabelas }
 { chamar a rotina de atualização de menus }
 Action := CaFree;
end;

procedure TFItensGeraNotaParcial.CarregaItens( seqNotaFiscal : Integer ) ;
var
  Dado : TDadoLista;
begin
  AdicionaSQLAbreTabela(Itens, ' Select mov.i_seq_pro, pro.c_nom_pro, mov.c_cod_pro, mov.n_tot_pro, ' +
                               ' mov.n_qtd_pro, mov.c_cod_uni, mov.n_vlr_pro ' +
                               ' from MovNotasFiscais as mov, cadprodutos as pro ' +
                               ' where mov.i_seq_not = '  + InttoStr(seqNotaFiscal) +
                               ' and mov.I_EMP_FIL = ' + IntToStr(varia.CodigoEmpFil) +
                               ' and mov.i_seq_pro = pro.i_seq_pro ' +
                               ' and pro.i_cod_emp = ' + IntToStr(varia.CodigoEmpresa) );
 lista.Clear;
lista.Items.Add( AdicionaBrancoD('Nome/Código do Produto', 40) +

                           AdicionaBrancoD('Un', 2) +

                           AdicionaBrancoE('QTd', 10) +

                           AdicionaBrancoE('QTd Dev', 10) +

                           AdicionaBrancoE('Unitário', 15) +

                           AdicionaBrancoE('Total', 15));

 lista.Items.Add('------------------------------------------------------------------------------------------------------------------------');


  while not Itens.Eof do
  begin
    Dado := TDadoLista.Create;
    Dado.SeqPro := Itens.fieldByName('i_seq_pro').AsInteger;
    Dado.ValorTotalPro := Itens.fieldByName('n_tot_pro').AsCurrency;
    lista.Items.AddObject( AdicionaBrancoD(CortaString(Itens.FieldByName('c_cod_pro').AsString + ' - ' +
                           Itens.FieldByName('c_nom_pro').AsString, 40),40) +

                           AdicionaBrancoD(CortaString(Itens.FieldByName('c_cod_uni').AsString, 2),2) +

                           AdicionaBrancoE(CortaString(FormatFloat(varia.MascaraValor, Itens.FieldByName('n_qtd_pro').AsFloat), 10),10) +

                           AdicionaBrancoE(CortaString(FormatFloat(varia.MascaraValor, Itens.FieldByName('n_qtd_pro').AsFloat), 10),10) +

                           AdicionaBrancoE(CortaString(FormatFloat(varia.MascaraMoeda,Itens.FieldByName('n_vlr_pro').AsFloat), 15),15) +

                           AdicionaBrancoE(CortaString(FormatFloat(varia.MascaraMoeda,Itens.FieldByName('n_tot_pro').AsFloat), 15),15)

                          , dado);
    lista.State[0] := cbGrayed;
    Itens.Next;
  end;
end;




procedure TFItensGeraNotaParcial.ListaClickCheck(Sender: TObject);
var
 laco : Integer;
begin
  EValorDevolver.AValor := 0;
  for laco := 2 to Lista.Items.Count - 1 do
  begin
    if lista.Checked[laco] then
      EValorDevolver.AValor := EValorDevolver.AValor + TDadoLista(lista.Items.Objects[laco]).ValorTotalPro;
  end;

end;

procedure TFItensGeraNotaParcial.ListaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Lista.State[Lista.ItemIndex] = cbGrayed then
    key := 0;
end;

procedure TFItensGeraNotaParcial.ListaMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Lista.State[Lista.ItemIndex] = cbGrayed then
    abort;
end;

Initialization
 RegisterClasses([TFItensGeraNotaParcial]);
end.
