unit AAlteraClassificacaoProduto;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente, ComCtrls,
  ImgList, Db, DBTables, UnClassificacao, UnProdutos, FMTBcd, SqlExpr;

type
  TFAlteraClassificacaoProduto = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BFechar: TBitBtn;
    AOrigem: TTreeView;
    ADestino: TTreeView;
    Label1: TLabel;
    Label2: TLabel;
    EditColor1: TEditColor;
    Imagens: TImageList;
    CadClassificacao: TSQLQUERY;
    BAdicionar: TBitBtn;
    CadProdutos: TSQLQUERY;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure AOrigemChange(Sender: TObject; Node: TTreeNode);
    procedure BAdicionarClick(Sender: TObject);
    procedure ADestinoDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ADestinoDragDrop(Sender, Source: TObject; X, Y: Integer);
  private
    { Private declarations }
    VetorMascara : array [1..6] of byte;
    VetorNo: array [0..6] of TTreeNode;
    VetorNoDestino : array [0..6] of TTreeNode;
    function DesmontaMascara(var Vetor : array of byte; mascara:string):byte;
    procedure CarregaProduto(VpaArvore : TTreeView; VpaNoSelecao : TTreeNode);
    procedure CarregaClassificacao(VetorInfo : array of byte);
    function AlteraClassificacao(VpaNoOrigem, VpaNoDestino : TTreeNode):Boolean;
  public
    { Public declarations }
  end;

var
  FAlteraClassificacaoProduto: TFAlteraClassificacaoProduto;

implementation

uses APrincipal, FunSql, Constantes, ConstMsg;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFAlteraClassificacaoProduto.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  AOrigem.Color := EditColor1.Color;
  ADestino.Color := Editcolor1.Color;
  DesmontaMascara(VetorMascara, varia.mascaraCLA);  // busca em constantes

  CarregaClassificacao(VetorMascara);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFAlteraClassificacaoProduto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFAlteraClassificacaoProduto.BFecharClick(Sender: TObject);
begin
  close;
end;

{******Desmonata a mascara pardão para a configuração das classificações*******}
function TFAlteraClassificacaoProduto.DesmontaMascara(var Vetor : array of byte; mascara:string):byte;
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

{******************************************************************************}
procedure TFAlteraClassificacaoProduto.CarregaProduto(VpaArvore : TTreeView; VpaNoSelecao : TTreeNode );
var
  VpfNo : TTreeNode;
  VpfDClassificacao : TClassificacao;
begin
  if not TClassificacao(TTreeNode(VpaNoSelecao).Data).ProdutosCarregados then
  begin
     VpfDClassificacao := TClassificacao(TTreeNode(VpaNoSelecao).Data);
     CadProdutos.Close;
     CadProdutos.sql.Clear;
     CadProdutos.sql.add(' Select ' +
                         ' pro.i_seq_pro, pro.c_cod_cla, pro.c_ati_pro, ' +
                         ' pro.c_cod_pro, pro.c_pat_fot, pro.c_nom_pro, moe.c_cif_moe, ' +
                         ' pro.c_kit_pro ' +
                         ' from CADPRODUTOS PRO, '  +
                         ' MOVQDADEPRODUTO MOV, CADMOEDAS MOE ' +
                         ' where PRO.I_COD_EMP = ' + IntToStr(varia.CodigoEmpresa) +
                         ' and PRO.C_COD_CLA = ''' + VpfDClassificacao.CodClassificacao + ''''+
                         ' and PRO.C_ATI_PRO = ''S''');

      CadProdutos.sql.add(' and pro.I_seq_pro = mov.i_seq_pro ' +
                          ' and mov.i_emp_fil = ' + IntTostr(varia.CodigoEmpFil) +
                          ' and mov.I_COD_COR = 0 '+
                          ' and pro.i_cod_moe = moe.i_cod_moe' );

     CadProdutos.sql.add('  Order by C_NOM_PRO');

     CadProdutos.open;
     CadProdutos.First;

     while not CadProdutos.EOF do
     begin
       VpfDClassificacao := TClassificacao.Create;
       VpfDClassificacao.CodProduto := CadProdutos.FieldByName('C_COD_PRO').AsString;
       VpfDClassificacao.tipo := 'PA';
       VpfDClassificacao.DesPathFoto := CadProdutos.FieldByName('C_PAT_FOT').AsString;
       VpfDClassificacao.SeqProduto := CadProdutos.FieldByName('I_SEQ_PRO').AsInteger;

       if config.VerCodigoProdutos then  // configura se mostra ou naum o codigo do produto..
          Vpfno := VpaArvore.Items.AddChildObject(VpaNoSelecao, VpfDClassificacao.CodProduto + ' - ' +
                                            CadProdutos.FieldByName('C_NOM_PRO').AsString, VpfDClassificacao)
       else
          Vpfno := VpaArvore.Items.AddChildObject(VpaNoSelecao,
                                        CadProdutos.FieldByName('C_NOM_PRO').AsString,VpfDClassificacao);

        Vpfno.ImageIndex := 2;
        Vpfno.SelectedIndex := 2;
       CadProdutos.Next;
     end;
    TClassificacao(TTreeNode(VpaNoSelecao).Data).ProdutosCarregados := true;
  end;
  CadProdutos.Close;
end;

{************************carrega Classificacao*********************************}
procedure TFAlteraClassificacaoProduto.CarregaClassificacao(VetorInfo : array of byte);
var
  VpfNo, VpfNoDestino : TTreeNode;
  VpfDado : TClassificacao;
  VpfTamanho, VpfNivel : word;
  VpfCodigo :string;
begin
  AOrigem.Items.Clear;
  ADestino.Items.Clear;
  VpfDado:= TClassificacao.Create;
  VpfDado.CodClassificacao:='';
  VpfDado.CodClassificacoReduzido:='';
  VpfDado.Tipo := 'NA';//NADA
  VpfNo := AOrigem.Items.AddObject(AOrigem.Selected, 'Produtos', VpfDado);
  VpfNoDestino := ADestino.Items.AddObject(ADestino.Selected,'Produtos',VpfDado);
  VetorNo[0]:= VpfNo;
  VetorNoDestino[0] := VpfNoDestino;
  VpfNo.ImageIndex:=0;
  VpfNo.SelectedIndex:=0;
  VpfNoDestino.ImageIndex := 0;
  VpfNoDestino.SelectedIndex := 0;

  AdicionaSQLAbreTabela(CadClassificacao,'SELECT * FROM CADCLASSIFICACAO '+
                           ' WHERE I_COD_EMP = ' + IntToStr(varia.CodigoEmpresa) +
                           ' and c_tip_cla = ''P''' +
                           ' ORDER BY C_COD_CLA ');

  while not(CadClassificacao.EOF) do
  begin
    VpfTamanho := VetorInfo[0];
    VpfNivel := 0;
    while length(CadClassificacao.FieldByName('C_COD_CLA').AsString)<>VpfTamanho do
    begin
      inc(VpfNivel);
      VpfTamanho:=VpfTamanho+VetorInfo[VpfNivel];
    end;

    VpfCodigo :=CadClassificacao.FieldByName('C_COD_CLA').AsString;
    VpfCodigo:=copy(VpfCodigo, (length(VpfCodigo)-VetorInfo[VpfNivel])+1, VetorInfo[VpfNivel]);

    VpfDado:= TClassificacao.Create;
    VpfDado.CodClassificacao:= CadClassificacao.FieldByName('C_COD_CLA').AsString;
    VpfDado.CodClassificacoReduzido := VpfCodigo;
    VpfDado.tipo := 'CL';
    VpfDado.ProdutosCarregados := false;

    VpfNo:=AOrigem.Items.AddChildObject(VetorNo[VpfNivel], VpfCodigo+ ' - '+
                                                        CadClassificacao.FieldByName('C_NOM_CLA').AsString, VpfDado);

    VetorNo[VpfNivel+1]:=VpfNo;

    VpfNoDestino:=ADestino.Items.AddChildObject(VetorNoDestino[VpfNivel], VpfCodigo+ ' - '+
                                                        CadClassificacao.FieldByName('C_NOM_CLA').AsString, VpfDado);

    VetorNoDestino[VpfNivel+1]:=VpfNoDestino;

    CadClassificacao.Next;
  end;
end;

{******************************************************************************}
function TFAlteraClassificacaoProduto.AlteraClassificacao(VpaNoOrigem, VpaNoDestino : TTreeNode):Boolean;
var
VpfResultado : String;
begin
  result := false;
  if (TClassificacao(VpaNoOrigem.Data).Tipo <> 'PA') then
    aviso('PRODUTO NÃO SELECIONADO!!!'#13'Para alterar a classificação é necessário antes selecionar um produto.')
  else
  begin
    if (TClassificacao(VpaNoDestino.Data).Tipo = 'NA') then
      Aviso('CLASSIFICAÇÃO DESTINO NÃO SELECIONADA!!!'#13'Para alterar a classificação do produto é necessário escolher a classificação destino.')
    else
    begin
      VpfResultado := FunProdutos.AlteraClassificacaoProduto(TClassificacao(VpaNoOrigem.Data).SeqProduto,TClassificacao(VpaNoDestino.data).CodClassificacao);
      if VpfResultado <> '' then
      begin
        result := false;
        aviso(VpfResultado);
      end
      else
        result := true;
    end;

  end;
end;

{******************************************************************************}
procedure TFAlteraClassificacaoProduto.AOrigemChange(Sender: TObject;
  Node: TTreeNode);
begin
   if TClassificacao(TTreeNode(node).Data).tipo = 'CL' then
   begin
      carregaProduto(AOrigem,node);
   end
end;

{******************************************************************************}
procedure TFAlteraClassificacaoProduto.BAdicionarClick(Sender: TObject);
begin
  if AlteraClassificacao(AOrigem.Selected,ADestino.Selected) then
    AOrigem.Selected.Delete;
end;

{******************************************************************************}
procedure TFAlteraClassificacaoProduto.ADestinoDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept := (Source is TTreeview);
end;

{******************************************************************************}
procedure TFAlteraClassificacaoProduto.ADestinoDragDrop(Sender,
  Source: TObject; X, Y: Integer);
Var
  VpfNoDestino : TTreeNode;
  VpfResultado : String;
begin
  VpfNoDestino := ADestino.GetNodeAt(x,y);
  if VpfNoDestino <> nil then
  begin
    if TComponent(Source).Name =  'AOrigem' then
    begin
      if AlteraClassificacao(AOrigem.Selected,VpfNoDestino) then
        AOrigem.Selected.Delete;
    end;
  end;

end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFAlteraClassificacaoProduto]);
end.
