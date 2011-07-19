unit AEstoqueProdutos;
{          Autor: Sergio Luiz Censi
    Data Cria��o: 06/04/1999;
          Fun��o: Cadastrar um novo
  Data Altera��o: 06/04/1999;
    Alterado por: Rafael Budag
Motivo altera��o: - Adicionado os coment�rios e o blocos nas rotinas, e realizado
                    um teste - 06/04/199 / Rafael Budag
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls, DBTables, Db, DBCtrls, Grids, DBGrids,
  Buttons, Menus, formularios, PainelGradiente,
  Tabela, Componentes1, LabelCorMove, Localizacao, Mask,
  numericos, DBKeyViolation,  ImgList, Spin, DBClient;

type
  TFEstoqueProdutos = class(TFormularioPermissao)
    CadClassificacao: TSQL;
    Imagens: TImageList;
    CadProdutos: TSQL;
    PainelGradiente1: TPainelGradiente;
    PanelColor4: TPanelColor;
    BitBtn1: TBitBtn;
    Localiza: TConsultaPadrao;
    BFechar: TBitBtn;
    Aux: TSQL;
    HistoricoProdutoVenda: TSQL;
    DataHistoricoProdutoVenda: TDataSource;
    MovEstoqueAtual: TSQL;
    DataMovEstoqueAtual: TDataSource;
    VendasMes: TSQL;
    DataVendasMes: TDataSource;
    BKit: TBitBtn;
    HistoricoProdutoCompra: TSQL;
    DataHistoricoProdutoCompra: TDataSource;
    CompraMes: TSQL;
    DataCompraMes: TDataSource;
    VendaCompra: TSQL;
    DataVendaCompra: TDataSource;
    PanelColor3: TPanelColor;
    PanelColor2: TPanelColor;
    Arvore: TTreeView;
    PanelColor1: TPanelColor;
    Empresa: TTreeView;
    Splitter1: TSplitter;
    PanelColor5: TPanelColor;
    PanelColor6: TPanelColor;
    CFilialSelecionada: TCheckBox;
    AtiPro: TCheckBox;
    Paginas: TPageControl;
    PHistoricoProduto: TTabSheet;
    Label23: TLabel;
    Label24: TLabel;
    Label27: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label35: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label28: TLabel;
    Label31: TLabel;
    Label34: TLabel;
    Label36: TLabel;
    DBEditColor18: TDBEditColor;
    DBEditColor19: TDBEditColor;
    DBEditColor21: TDBEditColor;
    DBEditColor25: TDBEditColor;
    DBEditColor28: TDBEditColor;
    DBEditColor29: TDBEditColor;
    DBEditColor16: TDBEditColor;
    DBEditColor17: TDBEditColor;
    DBEditColor22: TDBEditColor;
    DBEditColor26: TDBEditColor;
    DBEditColor27: TDBEditColor;
    DBEditColor31: TDBEditColor;
    PestoqueAtual: TTabSheet;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    DBEditColor1: TDBEditColor;
    DBEditColor2: TDBEditColor;
    DBEditColor3: TDBEditColor;
    DBEditColor4: TDBEditColor;
    DBEditColor5: TDBEditColor;
    DBEditColor6: TDBEditColor;
    DBEditColor7: TDBEditColor;
    DBEditColor8: TDBEditColor;
    PVendaMes: TTabSheet;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Shape1: TShape;
    Label8: TLabel;
    Label9: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    DBEditColor15: TDBEditColor;
    DBEditColor20: TDBEditColor;
    DBEditColor23: TDBEditColor;
    DBEditColor24: TDBEditColor;
    DBEditColor30: TDBEditColor;
    DBEditColor32: TDBEditColor;
    SVendaMes: TSpinEditColor;
    SVendaAno: TSpinEditColor;
    DBEditColor33: TDBEditColor;
    DBEditColor34: TDBEditColor;
    numerico1: Tnumerico;
    numerico2: Tnumerico;
    numerico3: Tnumerico;
    numerico4: Tnumerico;
    BitBtn2: TBitBtn;
    PCompraMes: TTabSheet;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Shape2: TShape;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    DBEditColor9: TDBEditColor;
    DBEditColor10: TDBEditColor;
    DBEditColor11: TDBEditColor;
    DBEditColor12: TDBEditColor;
    DBEditColor13: TDBEditColor;
    DBEditColor14: TDBEditColor;
    SCompraMes: TSpinEditColor;
    SCompraAno: TSpinEditColor;
    DBEditColor35: TDBEditColor;
    DBEditColor36: TDBEditColor;
    numerico5: Tnumerico;
    numerico6: Tnumerico;
    numerico7: Tnumerico;
    numerico8: Tnumerico;
    BitBtn3: TBitBtn;
    PVendaCompra: TTabSheet;
    DBGridColor1: TDBGridColor;
    PanelColor7: TPanelColor;
    Label10: TLabel;
    Label51: TLabel;
    SInicioMes: TSpinEditColor;
    SInicioAno: TSpinEditColor;
    SFimMes: TSpinEditColor;
    SFimAno: TSpinEditColor;
    PanelColor8: TPanelColor;
    PanelColor9: TPanelColor;
    PanelColor10: TPanelColor;
    PanelColor11: TPanelColor;
    procedure FormCreate(Sender: TObject);
    procedure ArvoreExpanded(Sender: TObject; Node: TTreeNode);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ArvoreChange(Sender: TObject; Node: TTreeNode);
    procedure ArvoreCollapsed(Sender: TObject; Node: TTreeNode);
    procedure BitBtn1Click(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure ArvoreKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ArvoreKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure AtiProClick(Sender: TObject);
    procedure EmpresaChange(Sender: TObject; Node: TTreeNode);
    procedure FormShow(Sender: TObject);
    procedure BKitClick(Sender: TObject);
    procedure PaginasChange(Sender: TObject);
    procedure SInicioMesClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    VprListar, VprFormAtivado : boolean;
    VprQdadeNiveis : Byte;
    VprVetorMascara : array [1..6] of byte;
    VprVetorNo : array [0..6] of TTreeNode;
    procedure CarregaEmpresa;
    function RNomCor(VpaCodCor : String):String;
    function DesmontaMascara(var Vetor : array of byte; mascara:string):byte;
    procedure CarregaClassificacao(VetorInfo : array of byte);
    procedure CarregaProduto(VetorInfo : array of byte; nivel : byte; Codigo : string; NoSelecao : TTreeNode);
    procedure CarregaCor(VpaSeqProduto : string; NoSelecao : TTreeNode);
    procedure RecarregaListaProdutos;
    function EmpresaFilial( codigoFilial, alias : string ) : string;
    function atividade( alias : string ) : string;
    procedure CarregaHistoricoProduto( SeqProduto, CodigoFilial, TipoItem : string );
    procedure EstoqueProduto( CodigoProduto, CodigoFilial,VpaCodCor, TipoItem : string );
    procedure VendaProdutos( CodigoProduto, CodigoFilial, TipoItem : string );
    procedure CompraProdutos( CodigoProduto, CodigoFilial, TipoItem : string );
    procedure VendaCompraProdutos( CodigoProduto, CodigoFilial, TipoItem : string );
    Procedure FiltraPaginaAtiva;
    procedure alinha( Tabela : TSQL;  campos : array of integer; Pos : char );
    procedure MascaraMoeda( Tabela : TSQL;  campos : array of string; Mascara : string );
  public
    { Public declarations }
  end;

type
  TClassificacao = class
    Codigo    : string;
    CodigoRed : string;
    Tipo : string;
    Situacao : boolean;
    Sequencial : string;
    Kit : Boolean;
end;

type TEmpresa = class
  CodigoFilial : integer;
end;

var
  FEstoqueProdutos: TFEstoqueProdutos;

implementation

uses APrincipal, fundata, constantes, funObjeto, constMsg, funstring, funsql,
  AProdutosKit, ADetalhesEstoque;


{$R *.DFM}

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         Formulario
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{***********************No fechamento do Formulario****************************}
procedure TFEstoqueProdutos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   FechaTabela(CadProdutos);
   FechaTabela(CadClassificacao);
   FechaTabela(HistoricoProdutoVenda);
   FechaTabela(MovEstoqueAtual);
   FechaTabela(Aux);
   Action := CaFree;
end;

{************************Quanto criado novo formulario*************************}
procedure TFEstoqueProdutos.FormCreate(Sender: TObject);
begin
  VprFormAtivado := false;
  SVendaMes.Value := mes(date);
  SVendaAno.Value := Ano(date);
  SCompraMes.Value := SVendaMes.Value;
  SCompraAno.Value := SVendaAno.Value;
  SFimMes.Value := SVendaMes.Value;
  SFimAno.Value := SVendaAno.Value;
  SInicioMes.Value := mes(DecMes(date,6));
  SInicioAno.Value := ano(DecMes(date,6));

  FillChar(VprVetorMascara, SizeOf(VprVetorMascara), 0);
  VprListar := true;

  CadProdutos.open;

  VprQdadeNiveis := DesmontaMascara(VprVetorMascara, varia.mascaraCLA);  // busca em constantes

  CarregaClassificacao(VprVetorMascara);
  CarregaEmpresa;
end;

{****************** quando inicia o formulario set a arvore ****************** }
procedure TFEstoqueProdutos.FormShow(Sender: TObject);
begin
  VprFormAtivado := true;
  arvore.Selected := arvore.TopItem;
  arvore.SetFocus;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                   Monta a arvore de Empresa/Filial
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{***************** carrega empresa filial *********************************** }
procedure  TFEstoqueProdutos.CarregaEmpresa;
var
  no : TTreeNode;
  NoInicial : TTreeNode;
  NoFilial : TTreeNode;
  filial : integer;
  dado : TEmpresa;
begin
  empresa.Items.Clear;
  Dado:= TEmpresa.create;
  dado.CodigoFilial := Varia.CodigoEmpresa;
  no := empresa.Items.AddObject(empresa.Selected, varia.NomeEmpresa, Dado);
  NoInicial := no;
  no.ImageIndex:=4;
  no.SelectedIndex:=4;
  empresa.Update;

  AdicionaSQLAbreTabela(aux, ' select * from cadfiliais where i_cod_emp = ' + IntToStr(varia.CodigoEmpresa));

  while not(Aux.EOF) do
  begin

    dado := TEmpresa.Create;
    Dado.CodigoFilial := Aux.FieldByName('I_EMP_FIL').AsInteger;

    no := empresa.Items.AddChildObject( noInicial, IntToStr(Dado.CodigoFilial) + ' - ' +
                                       Aux.FieldByName('C_NOM_FIL').AsString, Dado);
    no.ImageIndex:=5;
    no.SelectedIndex:=5;

    if Aux.FieldByName('I_EMP_FIL').AsInteger = varia.CodigoEmpFil then
       NoFilial := no;
    aux.Next;
  end;

   empresa.FullExpand;
   empresa.Selected := noFilial;
end;

{******************************************************************************}
function TFEstoqueProdutos.RNomCor(VpaCodCor : String):String;
begin
  result := 'Cor Padr�o';
  if (VpaCodCor <> '0') and (VpaCodCor <> '') then
  begin
    AdicionaSQLAbreTabela(Aux,'Select * from COR '+
                              'Where COD_COR = '+VpaCodCor);
    result := Aux.FieldByName('NOM_COR').AsString;
    Aux.Close;
  end;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                   Monta a arvore de classificacao e produtos
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******Desmonata a mascara pard�o para a configura��o das classifica��es*******}
function TFEstoqueProdutos.DesmontaMascara(var Vetor : array of byte; mascara:string):byte;
var x:byte;
    posicao:byte;
begin
  posicao:=0;
  x:=0;
  while Pos('.', mascara) > 0 do
  begin
    vetor[x]:=(Pos('.', mascara)-posicao)-1;
    inc(x);
    posicao:=Pos('.', mascara);
    mascara[Pos('.', mascara)] := '*';
  end;
  vetor[x]:=length(mascara)-posicao;
  vetor[x+1] := 1;
  DesmontaMascara:=x+1;
end;

{************************carrega Classificacao*********************************}
procedure TFEstoqueProdutos.CarregaClassificacao(VetorInfo : array of byte);
var
  no : TTreeNode;
  dado : TClassificacao;
  tamanho, nivel : word;
  codigo :string;
begin
  Arvore.Items.Clear;
  Dado:= TClassificacao.Create;
  Dado.codigo:='';
  Dado.CodigoRed:='';
  Dado.Tipo := 'CL';
  dado.Sequencial := '';
  no := arvore.Items.AddObject(arvore.Selected, 'Produtos', Dado);
  VprVetorNo[0]:=no;
  no.ImageIndex:=0;
  no.SelectedIndex:=0;
  Arvore.Update;

  CadClassificacao.SQL.Clear;
  CadClassificacao.SQL.Add('SELECT * FROM CADCLASSIFICACAO WHERE I_COD_EMP = ' + IntToStr(varia.CodigoEmpresa) +
                           ' and c_tip_cla = ''P''' +
                           ' ORDER BY C_COD_CLA ');
  CadClassificacao.Open;

  while not(CadClassificacao.EOF) do
  begin
    tamanho := VetorInfo[0];
    nivel := 0;
    while length(CadClassificacao.FieldByName('C_COD_CLA').AsString)<>tamanho do
    begin
      inc(nivel);
      tamanho:=tamanho+VetorInfo[nivel];
    end;

    codigo :=CadClassificacao.FieldByName('C_COD_CLA').AsString;
    codigo:=copy(codigo, (length(codigo)-VetorInfo[nivel])+1, VetorInfo[nivel]);

    dado:= TClassificacao.Create;
    Dado.codigo:= CadClassificacao.FieldByName('C_COD_CLA').AsString;
    Dado.CodigoRed := codigo;
    Dado.tipo := 'CL';
    Dado.Situacao := true;
    Dado.Sequencial := CadClassificacao.FieldByName('C_COD_CLA').AsString;

    no:=Arvore.Items.AddChildObject(VprVetorNo[nivel], codigo+ ' - '+
                                                        CadClassificacao.FieldByName('C_NOM_CLA').AsString, Dado);
    VprVetorNo[nivel+1]:=no;

    CadClassificacao.Next;
  end;
end;

{********carregaProduto : serve para carregar o TreeView com as informa��es
                    da base que est�o na tabela Produtos.**********************}
procedure TFEstoqueProdutos.CarregaProduto(VetorInfo : array of byte; nivel : byte; Codigo : string; NoSelecao : TTreeNode );
var
  no : TTreeNode;
  dado : TClassificacao;
begin
  if TClassificacao(TTreeNode(NoSelecao).Data).Situacao then
  begin
       CadProdutos.Close;
       CadProdutos.sql.Clear;
       CadProdutos.sql.add(' Select ' +
                           ' pro.i_seq_pro, pro.c_cod_cla, pro.c_ati_pro, ' +
                           ' pro.c_cod_pro, pro.c_pat_fot, pro.c_nom_pro, moe.c_cif_moe, ' +
                           ' pro.c_kit_pro ' +
                           ' from CadProdutos pro '  );

       if CFilialSelecionada.Checked then
          CadProdutos.sql.add(' ,MovQdadeProduto  mov ' );

       CadProdutos.sql.add(' , CadMoedas moe ' +
                           ' where PRO.I_COD_EMP = ' + IntToStr(varia.CodigoEmpresa) +
                           ' and PRO.C_COD_CLA = ''' + codigo + '''');

       if CFilialSelecionada.Checked then
          CadProdutos.sql.add(' and MOV.I_COD_COR = 0 ' );

       if AtiPro.Checked then
          CadProdutos.sql.add(' and PRO.C_ATI_PRO = ''S''' );

       CadProdutos.sql.add(' and pro.i_cod_moe = moe.i_cod_moe' );

       if CFilialSelecionada.Checked then
         CadProdutos.sql.add(' and pro.I_seq_pro = mov.i_seq_pro ' +
                             ' and mov.i_emp_fil = ' + IntTostr(TEmpresa(Empresa.Selected.Data).CodigoFilial) );

       CadProdutos.sql.add('  Order by C_COD_PRO');

       CadProdutos.open;
       CadProdutos.First;

       while not CadProdutos.EOF do
       begin
         dado:= TClassificacao.Create;
         Dado.codigo := CadProdutos.FieldByName('C_COD_PRO').AsString;
         Dado.CodigoRed := '';
         Dado.Situacao := true;
         Dado.tipo := 'PA';
         Dado.Sequencial := CadProdutos.FieldByName('I_SEQ_PRO').AsString;

         codigo := CadProdutos.FieldByName('C_COD_PRO').AsString;

         if config.VerCodigoProdutos then  // configura se mostra ou naum o codigo do produto..
            no := Arvore.Items.AddChildObject(NoSelecao, codigo + ' - ' +
                                              CadProdutos.FieldByName('C_NOM_PRO').AsString, Dado)
         else
            no := Arvore.Items.AddChildObject(NoSelecao,
                                          CadProdutos.FieldByName('C_NOM_PRO').AsString, Dado);

         VprVetorNo[nivel+1] := no;
         if CadProdutos.FieldByName('C_KIT_PRO').AsString = 'P' then
         begin
            no.ImageIndex := 2;
            no.SelectedIndex := 2;
            TClassificacao(no.Data).Kit := false;
         end
         else
         begin
            no.ImageIndex := 3;
            no.SelectedIndex := 3;
            TClassificacao(no.Data).Kit := true;
         end;
         CadProdutos.Next;
       end;
    TClassificacao(TTreeNode(NoSelecao).Data).Situacao := false;
  end;
end;

{******************************************************************************}
procedure TFEstoqueProdutos.CarregaCor(VpaSeqProduto : string; NoSelecao : TTreeNode);
var
  no : TTreeNode;
  dado : TClassificacao;
begin
  if TClassificacao(TTreeNode(NoSelecao).Data).Situacao then
  begin
       CadProdutos.sql.Clear;
       CadProdutos.sql.add(' Select pro.i_seq_pro, MOV.I_COD_COR ' +
                           ' from CadProdutos PRO ,MovQdadeProduto MOV ' );
       CadProdutos.sql.add(' Where pro.I_seq_pro = mov.i_seq_pro ' +
                           ' and mov.i_emp_fil = ' + IntTostr(TEmpresa(Empresa.Selected.Data).CodigoFilial)+
                           ' AND PRO.I_SEQ_PRO = '+VpaSeqProduto +
                           '  Order by I_COD_COR');
       Cadprodutos.Sql.SaveTofile('c:\Consulta.sql');
       CadProdutos.open;
       CadProdutos.First;

       while not CadProdutos.EOF do
       begin
         dado:= TClassificacao.Create;
         Dado.codigo := CadProdutos.FieldByName('I_COD_COR').AsString;
         Dado.CodigoRed := '';
         Dado.Situacao := true;
         Dado.tipo := 'CR';
         Dado.Sequencial := CadProdutos.FieldByName('I_SEQ_PRO').AsString;

         no := Arvore.Items.AddChildObject(NoSelecao, Dado.codigo + ' - ' +
                                              RNomCor(Dado.Codigo), Dado);

         no.ImageIndex := 6;
         no.SelectedIndex := 6;
         CadProdutos.Next;
       end;
    TClassificacao(TTreeNode(NoSelecao).Data).Situacao := false;
  end;
end;

{*****cada deslocamento no TreeView causa uma mudan�a na lista da direita******}
procedure TFEstoqueProdutos.ArvoreChange(Sender: TObject; Node: TTreeNode);
begin
  if VprListar then
  begin
    if TClassificacao(TTreeNode(node).Data).tipo = 'CL' then
    begin
      carregaProduto(VprVetorMascara,node.Level,TClassificacao(TTreeNode(node).Data).Codigo,node);
      arvore.Update;
    end;

    if (TClassificacao(TTreeNode(node).Data).tipo = 'PA') and (config.EstoquePorCor) then
    begin
      carregaCor(TClassificacao(TTreeNode(node).Data).Sequencial,node);
      arvore.Update;
    end;

    if TClassificacao(TTreeNode(node).Data).Kit then
      BKit.Enabled := true
    else
      BKit.Enabled := false;

    FiltraPaginaAtiva;
   end;
end;

{ *******************Cada vez que expandir um no*******************************}
procedure TFEstoqueProdutos.ArvoreExpanded(Sender: TObject; Node: TTreeNode);
begin
   carregaProduto(VprVetorMascara,node.Level,TClassificacao(TTreeNode(node).Data).Codigo,node);
   if TClassificacao(TTreeNode(node).Data).tipo = 'CL' then
   begin
      node.SelectedIndex:=1;
      node.ImageIndex:=1;
   end;
end;

{********************Cada vez que voltar a expan��o de um no*******************}
procedure TFEstoqueProdutos.ArvoreCollapsed(Sender: TObject; Node: TTreeNode);
begin
   if TClassificacao(TTreeNode(node).Data).tipo = 'CL' then
   begin
     node.SelectedIndex:=0;
     node.ImageIndex:=0;
   end;
end;

{ **************** se presionar a setas naum atualiza movimentos ************ }
procedure TFEstoqueProdutos.ArvoreKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key in[37..40]  then
   VprListar := false;
end;

{ ************ apos soltar setas atualiza movimentos ************************ }
procedure TFEstoqueProdutos.ArvoreKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  VprListar := true;
  ArvoreChange(sender,arvore.Selected);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                 Filtro de produto / empresa / filial
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{****************** localiza Produto **************************************** }
procedure TFEstoqueProdutos.BitBtn1Click(Sender: TObject);
var
  codigo, select : string;
  somaNivel,nivelSelecao, laco : integer;
begin
  select :=' Select * from cadProdutos  pro ' +
           ' ,MovQdadeProduto  mov ' +
           ' where c_nom_pro like ''@%''';

   if AtiPro.Checked then
      select := select + ' and C_ATI_PRO = ''S''';

   select := select + ' and pro.I_seq_pro = mov.i_seq_pro ' ;

   if (CFilialSelecionada.Checked) and (TEmpresa(Empresa.Selected.Data).CodigoFilial <> varia.CodigoEmpresa) then
     select := select + ' and mov.i_emp_fil = ' + IntTostr(TEmpresa(Empresa.Selected.Data).CodigoFilial)  ;

   select := select + ' order by c_nom_pro asc';

   Localiza.info.DataBase := Fprincipal.BaseDados;
   Localiza.info.ComandoSQL := select;
   Localiza.info.caracterProcura := '@';
   Localiza.info.ValorInicializacao := '';
   Localiza.info.CamposMostrados[0] := 'C_cod_pro';
   Localiza.info.CamposMostrados[1] := 'c_nom_pro';
   Localiza.info.CamposMostrados[2] := '';
   Localiza.info.DescricaoCampos[0] := 'codigo';
   Localiza.info.DescricaoCampos[1] := 'nome';
   Localiza.info.DescricaoCampos[2] := '';
   Localiza.info.TamanhoCampos[0] := 8;
   Localiza.info.TamanhoCampos[1] := 40;
   Localiza.info.TamanhoCampos[2] := 0;
   Localiza.info.CamposRetorno[0] := 'I_SEQ_PRO';
   Localiza.info.CamposRetorno[1] := 'C_cod_cla';
   Localiza.info.SomenteNumeros := false;
   Localiza.info.CorFoco := FPrincipal.CorFoco;
   Localiza.info.CorForm := FPrincipal.CorForm;
   Localiza.info.CorPainelGra := FPrincipal.CorPainelGra;
   Localiza.info.TituloForm := 'Localizar Produtos';

   if Localiza.execute then
   if localiza.retorno[0] <> '' Then
   begin
       SomaNivel := 1;
       NivelSelecao := 1;
       VprListar := false;
       arvore.Selected := Arvore.Items.GetFirstNode;
       arvore.Selected.Collapse(true);

       while SomaNivel <= Length(localiza.retorno[1]) do
       begin
          codigo := copy(localiza.retorno[1], SomaNivel, VprVetorMascara[nivelSelecao]);
          SomaNivel := SomaNivel + VprVetorMascara[nivelSelecao];

          arvore.Selected := arvore.Selected.GetNext;
          while TClassificacao(arvore.Selected.Data).CodigoRed <> Codigo  do
            arvore.Selected := arvore.Selected.GetNextChild(arvore.selected);
          inc(NivelSelecao);
       end;

       carregaProduto(VprVetorMascara,arvore.selected.Level,TClassificacao(arvore.selected.Data).Codigo,arvore.selected);

       for laco := 0 to arvore.Selected.Count - 1 do
        if TClassificacao(arvore.Selected.Item[laco].Data).Sequencial = localiza.retorno[0] then
        begin
          arvore.Selected := arvore.Selected.Item[laco];
          break;
        end;
   end;

   VprListar := true;
   ArvoreChange(sender,arvore.Selected);
   self.ActiveControl := arvore;
end;

{************************** Recarrega lista ********************************* }
procedure TFEstoqueProdutos.RecarregaListaProdutos;
begin
  VprListar := false;
  arvore.Selected := Arvore.Items.GetFirstNode;
  arvore.Selected.Collapse(true);
  arvore.Items.Clear;
  CarregaClassificacao(VprVetorMascara);
  VprListar := true;
  arvore.Selected := arvore.TopItem;
end;

{ ***************** altera a mostra entre produtos em atividades ou naum ******}
procedure TFEstoqueProdutos.AtiProClick(Sender: TObject);
begin
  RecarregaListaProdutos;
end;

{ ***************** altera o estilo da janela Produto e Empresa ************** }
procedure TFEstoqueProdutos.EmpresaChange(Sender: TObject;
  Node: TTreeNode);
begin
  if VprFormAtivado then
    if CFilialSelecionada.Checked then
      RecarregaListaProdutos
    else
      FiltraPaginaAtiva;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              A��es Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{****************************Fecha o Formulario corrente***********************}
procedure TFEstoqueProdutos.BFecharClick(Sender: TObject);
begin
  close;
end;


{***************** efetua o filtro conforme pagina ativa ******************** }
Procedure TFEstoqueProdutos.FiltraPaginaAtiva;
var
  VpfDado : TClassificacao;
begin
try
    if (Arvore.Selected.Data <> nil) and (Empresa.Selected.Data <> nil) then
    begin
      VpfDado := TClassificacao(arvore.Selected.Data);
      if Paginas.ActivePage = PHistoricoProduto then
          CarregaHistoricoProduto(VpfDado.Sequencial,IntTostr(TEmpresa(Empresa.Selected.Data).CodigoFilial),TClassificacao(Arvore.Selected.Data).Tipo)
      else
        if Paginas.ActivePage = PestoqueAtual then
           EstoqueProduto(VpfDado.Sequencial,IntTostr(TEmpresa(Empresa.Selected.Data).CodigoFilial),VpfDado.Codigo,TClassificacao(Arvore.Selected.Data).Tipo)
        else
          if Paginas.ActivePage = PVendaMes then
             VendaProdutos(VpfDado.Sequencial,IntTostr(TEmpresa(Empresa.Selected.Data).CodigoFilial),TClassificacao(Arvore.Selected.Data).Tipo)
          else
            if Paginas.ActivePage = PCompraMes then
              CompraProdutos(VpfDado.Sequencial,IntTostr(TEmpresa(Empresa.Selected.Data).CodigoFilial),TClassificacao(Arvore.Selected.Data).Tipo)
            else
              VendaCompraProdutos(VpfDado.Sequencial,IntTostr(TEmpresa(Empresa.Selected.Data).CodigoFilial),TClassificacao(Arvore.Selected.Data).Tipo);
    end;
  except
  end;
end;

{******************************************************************************}
procedure TFEstoqueProdutos.alinha( Tabela : TSQL;  campos : array of integer; Pos : char );
var
  laco : Integer;
begin
  for laco := low(campos) to high(campos) do
    case pos of
      'D' : tabela.fields[campos[laco]].Alignment := taRightJustify;
      'C' : tabela.fields[campos[laco]].Alignment := taCenter;
      'E' : tabela.fields[campos[laco]].Alignment := taLeftJustify
    end;
end;

procedure TFEstoqueProdutos.MascaraMoeda( Tabela : TSQL;  campos : array of string; Mascara : string );
var
  laco, laco1 : Integer;

begin
  for laco1 := low(campos) to high(campos) do
  begin
    for laco := 0 to tabela.FieldCount - 1 do
     if Tabela.Fields[laco].FieldName = campos[laco1] then
     begin
      (tabela.fields[laco] as TFloatField).DisplayFormat := Mascara;
       break;
     end;
  end;
end;


function TFEstoqueProdutos.EmpresaFilial( codigoFilial, alias : string ) : string;
begin
  result := '';
  if not (CodigoFilial = IntTostr(Varia.CodigoEmpresa)) then
    if alias <> '' then
      result := ' and ' + alias + '.i_emp_fil = ' + CodigoFilial
    else
      result := ' and i_emp_fil = ' + CodigoFilial ;

end;

function TFEstoqueProdutos.atividade( alias : string ) : string;
begin
  result := '';
  if AtiPro.Checked then
    result := ' and ' + Alias + '.C_ATI_PRO = ''S'''

end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      Historico Produto
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************** Carrega Historico ************************* }
procedure TFEstoqueProdutos.CarregaHistoricoProduto( SeqProduto, CodigoFilial, TipoItem : string );

    // classificacao ou produto
  function ClassificacaoProduto( VencCompra : string ) : string;
  begin
    if (TipoItem = 'PA') then
      result :=  ' suma.i_seq_pro = ' +  SeqProduto +
                 ' and suma.i_mes_fec = ' + InttoStr(mes(Date)) +
                 ' and suma.i_ano_fec = ' +  InttoStr(ano(Date))
    else
      result :=  ' suma.i_cod_fec =  ( select max(i_cod_fec) from   ' +
                 ' movsumarizaestoque suma2, ' +
                 ' cadprodutos as pro2 where ' + VencCompra + ' = ' +
                 '           (  select max(' + VencCompra + ')  from '+
                 '            movsumarizaestoque as suma1, '+
                 '            cadprodutos as pro1 ' +
                 '            where pro1.c_cod_cla  like ''' + SeqProduto + '%'' ' +
                 '            and suma1.i_seq_pro = pro1.i_seq_pro ' +
                 '            and pro1.i_cod_emp = ' + IntToStr(varia.CodigoEmpresa)  +
                              atividade('pro1') +  ')' +
                 ' and suma2.i_seq_pro = pro2.i_seq_pro ' +
                 ' and pro2.c_cod_cla  like ''' + SeqProduto + '%'' ' +
                 atividade('pro2') + ' )';
   end;


begin

// venda de produtos
  LimpaSQLTabela(HistoricoProdutoVenda);
  AdicionaSQLTabela( HistoricoProdutoVenda,
                     ' select ' +
                     ' suma.d_ult_ven, suma.n_vlr_ven n_vlr_ult_ven, suma.n_vlr_cmv, suma.n_qtd_ven, ' +
                     ' tab.n_vlr_ven, tab.c_cif_moe ' +
                     ' from movsumarizaestoque as suma, ' +
                     '      cadprodutos as pro, ' +
                     '      movqdadeproduto as movpro, ' +
                     '      movtabelapreco as tab ' +
                     ' where ' +
                     ClassificacaoProduto('D_ULT_VEN') +
                     ' and suma.d_ult_ven is not null ' +
                     EmpresaFilial(CodigoFilial,'suma') +
                     ' and pro.i_seq_pro  = suma.i_seq_pro ' +
                     ' and pro.i_cod_emp = ' + IntToStr(varia.CodigoEmpresa) +
                     Atividade('pro') +

                     ' and movpro.i_seq_pro = suma.i_seq_pro ' +
                     ' and movpro.i_emp_fil = suma.i_emp_fil ' +
                     EmpresaFilial(CodigoFilial,'movpro') +
                     ' and tab.i_seq_pro = pro.i_seq_pro ' +
                     ' and tab.i_cod_tab = ' + IntToStr(varia.TabelaPreco) +
                     ' and tab.i_cod_emp = ' + IntToStr(varia.CodigoEmpresa) );
  AbreTabela(HistoricoProdutoVenda);
  alinha(HistoricoProdutoVenda, [ 0, 5 ], 'D' );
  MascaraMoeda(HistoricoProdutoVenda, ['n_vlr_ult_ven', 'n_vlr_ven', 'n_vlr_cmv'], varia.MascaraMoeda );

// compra do produto
  LimpaSQLTabela(HistoricoProdutoCompra);
  AdicionaSQLTabela( HistoricoProdutoCompra,
                     ' select ' +
                     ' suma.d_ult_com, suma.n_vlr_com n_vlr_ult_com, suma.n_vlr_cmc, suma.n_qtd_com, ' +
                     ' movpro.n_vlr_com, pro.c_cif_moe ' +
                     ' from movsumarizaestoque as suma, ' +
                     '      cadprodutos as pro, ' +
                     '      movqdadeproduto as movpro ' +
                     ' where ' +
                     ClassificacaoProduto('D_ULT_COM') +
                     ' and suma.d_ult_ven is not null ' +
                     EmpresaFilial(CodigoFilial,'suma') +
                     ' and pro.i_seq_pro  = suma.i_seq_pro ' +
                     ' and pro.i_cod_emp = ' + IntToStr(varia.CodigoEmpresa) +
                     Atividade('pro') +
                     ' and movpro.i_seq_pro = suma.i_seq_pro ' +
                     ' and movpro.i_emp_fil = suma.i_emp_fil ' +
                     EmpresaFilial(CodigoFilial,'movpro') );
  AbreTabela( HistoricoProdutoCompra );
  alinha(HistoricoProdutoCompra, [ 0, 5 ], 'D');
  MascaraMoeda(HistoricoProdutoCompra, ['n_vlr_ult_com','n_vlr_cmc', 'n_vlr_com'], varia.MascaraMoeda );
end;


{******************************************************************************}
procedure  TFEstoqueProdutos.EstoqueProduto( CodigoProduto, CodigoFilial,VpaCodCor, TipoItem : string );
var
  VpfCampos, vpfFiltro : string;
begin

  FechaTabela(MovEstoqueAtual);

// filtros

  if ((TipoItem = 'PA') and not(config.EstoquePorCor)) or
     (TipoItem = 'CR') then
  begin
    VpfCampos := ' movpro.n_qtd_min, movpro.n_qtd_ped, pro.c_cod_uni, movpro.n_qtd_pro, ' +
                 ' ( tab.n_vlr_ven * Moe2.n_vlr_dia) n_vlr_ven, ' +
                 ' ( movpro.n_vlr_com * Moe1.n_vlr_dia) n_vlr_com, ' +
                 ' ( movpro.n_qtd_pro * (tab.n_vlr_ven * Moe2.n_vlr_dia))  valorvenda, ' +
                 ' ( movpro.n_qtd_pro * ( movpro.n_vlr_com * Moe1.n_vlr_dia)) valorcompra ';
    vpfFiltro := ' pro.i_seq_pro  =  ' + CodigoProduto ;
    if (TipoItem = 'CR') then
      vpfFiltro := vpfFiltro + ' and MOVPRO.I_COD_COR = '+ VpaCodCor;
    DBEditColor3.DataField := 'n_qtd_min';
    DBEditColor4.DataField := 'n_qtd_ped';
    DBEditColor5.DataField := 'n_vlr_com';
    DBEditColor6.DataField := 'n_vlr_ven';
    DBEditColor2.DataField := 'c_cod_uni';
    DBEditColor1.DataField := 'n_qtd_pro';
    DBEditColor7.DataField := 'valorcompra';
    DBEditColor8.DataField := 'valorvenda';
  end
  else
  begin
    VpfCampos := ' sum( '+SQLTextoIsNull('movpro.n_qtd_pro','0')+') somaproduto, ' +
                 ' sum( movpro.n_qtd_pro * ' +SQLTextoIsNull('tab.n_vlr_ven * Moe1.n_vlr_dia','0')+') ' +
                 ' valorvenda, sum( movpro.n_qtd_pro * '+SQLTextoIsNull('movpro.n_vlr_com * Moe2.n_vlr_dia','0')+') valorcompra ';
    if TipoItem = 'PA' then
      vpfFiltro := ' PRO.I_SEQ_PRO = '+ CodigoProduto
    else
      vpfFiltro := ' pro.c_cod_cla like ''' + CodigoProduto + '%'' ';
    DBEditColor3.DataField := '';
    DBEditColor4.DataField := '';
    DBEditColor5.DataField := '';
    DBEditColor6.DataField := '';
    DBEditColor2.DataField := '';
    DBEditColor1.DataField := 'somaproduto';
    DBEditColor7.DataField := 'valorcompra';
    DBEditColor8.DataField := 'valorvenda';
  end;


  MovEstoqueAtual.Sql.Clear;
  MovEstoqueAtual.Sql.Add(' select ' +
                     VpfCampos +
                     ' from  cadprodutos pro, ' +
                     ' movqdadeproduto movpro, ' +
                     ' MovTabelapreco tab, ' +
                     ' cadMoedas Moe1, ' +
                     ' cadMoedas Moe2  ' +
                     ' where ' +
                     vpfFiltro +
                     Atividade('Pro') +
                     ' and pro.i_cod_emp =  ' + IntToStr(varia.CodigoEmpresa) +
                     ' and movpro.i_seq_pro = pro.i_seq_pro ' +
                     EmpresaFilial(CodigoFilial, 'movpro') +
                     ' and tab.i_seq_pro = pro.i_seq_pro ' +
                     ' and tab.i_cod_tab = ' +  IntTostr(varia.TabelaPreco) +
                     ' and tab.i_cod_emp = ' + IntToStr(varia.CodigoEmpresa) +
                     ' and Moe1.i_cod_moe = tab.i_cod_moe ' +
                     ' and Moe2.i_cod_moe = pro.i_cod_moe  '+
                     ' and tab.i_cod_cli = 0');
  MovEstoqueAtual.Sql.SaveToFile('c:\Consulta.sql');
  MovEstoqueAtual.open;

  if ((TipoItem = 'PA') and not(config.EstoquePorCor)) or
     (TipoItem = 'CR') then
  begin
    alinha(MovEstoqueAtual, [ 2 ], 'D');
    MascaraMoeda(MovEstoqueAtual, ['valorvenda', 'valorcompra', 'n_vlr_ven', 'n_vlr_com'] , varia.MascaraMoeda);
  end
  else
    MascaraMoeda(MovEstoqueAtual, ['valorvenda', 'valorcompra'], varia.MascaraMoeda );
end;


{*********************  produtos vendidos ************************************ }
procedure  TFEstoqueProdutos.VendaProdutos( CodigoProduto, CodigoFilial, TipoItem : string );
var
  VpaCampos : string;
begin

  VpaCampos :=  ' sum(N_QTD_VEN_MES) N_QTD_VEN_MES, sum(N_QTD_DEV_VEN) N_QTD_DEV_VEN, ' +
                ' sum(N_VLR_VEN_MES) N_VLR_VEN_MES, sum(N_VLR_DEV_VEN) N_VLR_DEV_VEN, ' +
                ' sum(N_QTD_TRA_SAI) N_QTD_TRA_SAI, sum(N_QTD_OUT_SAI) N_QTD_OUT_SAI, ' +
                ' sum(N_VLR_TRA_SAI) N_VLR_TRA_SAI, sum(N_VLR_OUT_SAI) N_VLR_OUT_SAI ' ;


  LimpaSQLTabela(VendasMes);
  if TipoItem = 'PA' then
    AdicionaSQLTabela(VendasMes,  ' select ' +
                                  VpaCampos +
                                  ' from movsumarizaestoque ' +
                                  ' where ' +
                                  ' i_seq_pro = ' + CodigoProduto +
                                  ' and i_mes_fec = ' + IntTostr(SVendaMes.Value) +
                                  ' and i_ano_fec = ' + IntTostr(SVendaAno.Value) +
                                  EmpresaFilial(CodigoFilial, '') )
  else
    AdicionaSQLTabela(VendasMes,  ' select ' +
                                   VpaCampos +
                                  ' from movsumarizaestoque mov, cadprodutos pro ' +
                                  ' where ' +
                                  ' pro.c_cod_cla like ''' + CodigoProduto + '%'' ' +
                                  ' and pro.i_cod_emp = ' + IntTostr(varia.CodigoEmpresa) +
                                  ' and pro.i_seq_pro = mov.i_seq_pro ' +
                                  ' and i_mes_fec = ' + IntTostr(SVendaMes.Value) +
                                  ' and i_ano_fec = ' + IntTostr(SVendaAno.Value) +
                                  EmpresaFilial(CodigoFilial, '') );

  AbreTabela(VendasMes);
  numerico1.AValor := VendasMes.fieldByname('N_QTD_VEN_MES').AsCurrency - VendasMes.fieldByname('N_QTD_DEV_VEN').AsCurrency;
  numerico2.AValor := VendasMes.fieldByname('N_VLR_VEN_MES').AsCurrency - VendasMes.fieldByname('N_VLR_DEV_VEN').AsCurrency;
  numerico3.AValor := VendasMes.fieldByname('N_QTD_VEN_MES').AsCurrency + VendasMes.fieldByname('N_QTD_TRA_SAI').AsCurrency + VendasMes.fieldByname('N_QTD_OUT_SAI').AsCurrency;
  numerico4.AValor := VendasMes.fieldByname('N_VLR_VEN_MES').AsCurrency + VendasMes.fieldByname('N_VLR_TRA_SAI').AsCurrency + VendasMes.fieldByname('N_VLR_OUT_SAI').AsCurrency;
  MascaraMoeda(VendasMes, ['N_VLR_VEN_MES', 'N_VLR_DEV_VEN','N_VLR_TRA_SAI', 'N_VLR_OUT_SAI'], varia.MascaraMoeda);
end;

{***************** produtos comprados **************************************** }
procedure  TFEstoqueProdutos.CompraProdutos( CodigoProduto, CodigoFilial, TipoItem : string );
var
  VpaCampos : string;
begin

  VpaCampos :=  ' sum(N_QTD_COM_MES) N_QTD_COM_MES, sum(N_QTD_DEV_COM) N_QTD_DEV_COM, ' +
                ' sum(N_VLR_COM_MES) N_VLR_COM_MES, sum(N_VLR_DEV_COM) N_VLR_DEV_COM, ' +
                ' sum(N_QTD_TRA_ENT) N_QTD_TRA_ENT, sum(N_QTD_OUT_ENT) N_QTD_OUT_ENT, ' +
                ' sum(N_VLR_TRA_ENT) N_VLR_TRA_ENT, sum(N_VLR_OUT_ENT) N_VLR_OUT_ENT ' ;



  LimpaSQLTabela(CompraMes);
  if TipoItem = 'PA' then
    AdicionaSQLTabela(CompraMes,  ' select ' +
                                   VpaCampos +
                                  ' from movsumarizaestoque ' +
                                  ' where ' +
                                  ' i_seq_pro = ' + CodigoProduto +
                                  ' and i_mes_fec = ' + IntTostr(SCompraMes.Value) +
                                  ' and i_ano_fec = ' + IntTostr(SCompraAno.Value) +
                                  EmpresaFilial(CodigoFilial, '') )
  else
    AdicionaSQLTabela(CompraMes,  ' select ' +
                                   VpaCampos +
                                  ' from movsumarizaestoque mov, cadprodutos pro ' +
                                  ' where ' +
                                  ' pro.c_cod_cla like ''' + CodigoProduto + '%'' ' +
                                  ' and pro.i_cod_emp = ' + IntTostr(varia.CodigoEmpresa) +
                                  ' and pro.i_seq_pro = mov.i_seq_pro ' +
                                  ' and i_mes_fec = ' + IntTostr(SCompraMes.Value) +
                                  ' and i_ano_fec = ' + IntTostr(SCompraAno.Value) +
                                  EmpresaFilial(CodigoFilial, '') );

  AbreTabela(CompraMes);
  numerico5.AValor := CompraMes.fieldByname('N_QTD_COM_MES').AsCurrency - CompraMes.fieldByname('N_QTD_DEV_COM').AsCurrency;
  numerico6.AValor := CompraMes.fieldByname('N_VLR_COM_MES').AsCurrency - CompraMes.fieldByname('N_VLR_DEV_COM').AsCurrency;
  numerico7.AValor := CompraMes.fieldByname('N_QTD_COM_MES').AsCurrency + CompraMes.fieldByname('N_QTD_TRA_ENT').AsCurrency + CompraMes.fieldByname('N_QTD_OUT_ENT').AsCurrency;
  numerico8.AValor := CompraMes.fieldByname('N_VLR_COM_MES').AsCurrency + CompraMes.fieldByname('N_VLR_TRA_ENT').AsCurrency + CompraMes.fieldByname('N_VLR_OUT_ENT').AsCurrency;
  MascaraMoeda(CompraMes, ['N_VLR_COM_MES', 'N_VLR_DEV_COM','N_VLR_TRA_ENT', 'N_VLR_OUT_ENT'], varia.MascaraMoeda);
end;


{*********** venda e compra de produtos ************************************* }
procedure TFEstoqueProdutos.VendaCompraProdutos( CodigoProduto, CodigoFilial, TipoItem : string );
var
  VpaClassificacaoProduto, VpaEstoqueAnterior : string;
begin
  LimpaSQLTabela(VendaCompra);
  if TipoItem = 'PA' then
    VpaClassificacaoProduto := ' from movsumarizaestoque mov ' +
                               ' where mov.i_seq_pro = ' +  CodigoProduto
  else
    VpaClassificacaoProduto := ' from movsumarizaestoque mov, cadprodutos pro ' +
                               ' where pro.c_cod_cla like ''' +  CodigoProduto + '%''' +
                               ' and pro.i_cod_emp = ' + IntTostr(varia.CodigoEmpresa) +
                               ' and pro.i_seq_pro = mov.i_seq_pro ' ;


  AdicionaSQLTabela(VendaCompra,' select ' +
                                ' mov.i_mes_fec || ''/'' || mov.i_ano_fec  mes, ' +
                                ' sum('+SQLTextoIsNull('n_qtd_ant','0')+') EstoqueAnterior,' +
                                ' sum('+SQLTextoIsNull('mov.n_qtd_pro','0')+') estoqueAtual, '  +
                                ' sum('+SQLTextoIsNull('mov.n_qtd_com_mes','0')+') CompraMes,' +
                                ' sum('+SQLTextoIsNull('mov.n_qtd_ven_mes','0')+') vendaMes, ' +
                                ' sum('+SQLTextoIsNull('mov.n_vlr_cmc','0')+') ValorCompra, ' +
                                ' sum('+SQLTextoIsNull('mov.n_vlr_cmv','0')+') valorvenda,' +
                                ' sum('+SQLTextoIsNull('mov.n_qtd_dev_ven','0')+') DevVenda, ' +
                                ' sum('+SQLTextoIsNull('mov.n_qtd_dev_com','0')+') DevCompra, ' +
                                ' sum('+SQLTextoIsNull('mov.n_qtd_out_sai','0')+' + '+ SQLTextoIsNull('n_qtd_tra_sai','0')+' ) OutrasSaida, ' +
                                ' sum('+SQLTextoIsNull('mov.n_qtd_out_ent','0')+' + '+SQLTextoIsNull('n_qtd_tra_ent','0')+' ) OutrasEntrada '+
                                VpaClassificacaoProduto +
                                EmpresaFilial(CodigoFilial,'') +
                                ' and  (( mov.i_mes_fec <= ' + IntToStr(SFimMes.Value) +
                                '         and mov.i_ano_fec = ' +  IntToStr(SFimAno.Value) +
                                ' and   mov.i_ano_fec <> ' + IntToStr(SInicioAno.Value) +
                                '         ) or ( mov.i_mes_fec >= ' + IntToStr(SInicioMes.Value) +
                                '         and mov.i_ano_fec  = ' + IntToStr(SInicioAno.Value) +
                                '       )) ' +
                                ' group by  mov.i_ano_fec, mov.i_mes_fec ' +
                                ' order by mov.i_ano_fec, mov.i_mes_fec ' );

  AbreTabela(VendaCompra);

  MascaraMoeda(VendaCompra,[ 'ValorCompra','valorvenda'], varia.MascaraMoeda);
  MascaraMoeda(VendaCompra,[ 'Margem'], '###,##0.00 %');
end;




{*********************** Mostra os Kit de um produto ************************* }
procedure TFEstoqueProdutos.BKitClick(Sender: TObject);
begin
{  if TClassificacao(arvore.Selected.Data).kit then
  begin
    FProdutosKit := TFProdutosKit.CriarSDI(application, '', true);
    FProdutosKit.MostraKit(TClassificacao(arvore.Selected.Data).Sequencial, TEmpresa(Empresa.Selected.Data).CodigoFilial);
  end;}
end;

{********************** quando altera a pagina no formulario ***************** }
procedure TFEstoqueProdutos.PaginasChange(Sender: TObject);
begin
  FiltraPaginaAtiva;
end;

procedure TFEstoqueProdutos.SInicioMesClick(Sender: TObject);
begin
  if VprFormAtivado then
   FiltraPaginaAtiva;
end;

procedure TFEstoqueProdutos.BitBtn2Click(Sender: TObject);
begin
  FDetalhesEstoque := TFDetalhesEstoque.CriarSDI(application,'',true);
  FDetalhesEstoque.MostraDetalhes(TClassificacao(arvore.Selected.Data).Sequencial,IntTostr(TEmpresa(Empresa.Selected.Data).CodigoFilial),TClassificacao(Arvore.Selected.Data).Tipo, 'S');
end;

procedure TFEstoqueProdutos.BitBtn3Click(Sender: TObject);
begin
  FDetalhesEstoque := TFDetalhesEstoque.CriarSDI(application,'',true);
  FDetalhesEstoque.MostraDetalhes(TClassificacao(arvore.Selected.Data).Sequencial,IntTostr(TEmpresa(Empresa.Selected.Data).CodigoFilial),TClassificacao(Arvore.Selected.Data).Tipo,'E');
end;

end.
