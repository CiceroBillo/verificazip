unit AServicos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls, DBTables, Db, DBCtrls, Grids, DBGrids,
  Buttons, Menus, formularios, PainelGradiente,
  Tabela, Componentes1, LabelCorMove, Localizacao, Mask,
  EditorImagem, ImgList, numericos, UnClassificacao, FMTBcd, SqlExpr, DBClient;

type
  TFServicos = class(TFormularioPermissao)
    Splitter1: TSplitter;
    CadClassificacao: TSQL;
    Imagens: TImageList;
    CadServicos: TSQL;
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    Arvore: TTreeView;
    PanelColor4: TPanelColor;
    BAlterar: TBitBtn;
    BExcluir: TBitBtn;
    BServicos: TBitBtn;
    BitBtn1: TBitBtn;
    Localiza: TConsultaPadrao;
    BClasssificao: TBitBtn;
    BFechar: TBitBtn;
    BConsulta: TBitBtn;
    PopupMenu1: TPopupMenu;
    NovaClassificao1: TMenuItem;
    NovoProduto1: TMenuItem;
    N1: TMenuItem;
    Alterar1: TMenuItem;
    Excluir1: TMenuItem;
    Consultar1: TMenuItem;
    Localizar1: TMenuItem;
    N2: TMenuItem;
    ImageList1: TImageList;
    Aux: TSQLQuery;
    EditColor1: TEditColor;
    CAtiPro: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure ArvoreExpanded(Sender: TObject; Node: TTreeNode);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ArvoreChange(Sender: TObject; Node: TTreeNode);
    procedure ArvoreCollapsed(Sender: TObject; Node: TTreeNode);
    Procedure Excluir(Sender : TObject);
    procedure BAlterarClick(Sender: TObject);
    procedure BExcluirClick(Sender: TObject);
    procedure BClasssificaoClick(Sender: TObject);
    procedure BServicosClick(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure BConsultaClick(Sender: TObject);
    procedure ArvoreDblClick(Sender: TObject);
    procedure ArvoreKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ArvoreKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure AtiProClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    VprListar: Boolean;
    VprQtdNiveis: Byte;
    VprVetorMascara: array [1..6] of byte;
    VprVetorNode: array [0..6] of TTreeNode;
    VprPrimeiroNode: TTreeNode;
    function DesmontaMascara(var VpaVetor: array of byte; VpaMascara: String): byte;
    procedure CadastraClassificacao;
    function LimpaArvore: TTreeNode;
    procedure CarregaClassificacao(VpaVetorInfo : array of byte);
    procedure CarregaServico(VpaNivel: Byte; VpaCodClassificacao: String; VpaNodeSelecao: TTreeNode);
    procedure RecarregaLista;
    procedure CadatraServico;
    procedure Alterar(Sender: TObject;Alterar : Boolean);
  public
  end;

var
  FServicos: TFServicos;

implementation
uses
  APrincipal, Fundata, constantes, funObjeto, FunSql, constMsg, funstring,
  ANovaClassificacao, ANovoServico;

{$R *.DFM}
{***********************No fechamento do Formulario****************************}
procedure TFServicos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CadServicos.Close;
  CadClassificacao.Close;
  Action:= CaFree;
end;

{************************Quanto criado novo formulario*************************}
procedure TFServicos.FormCreate(Sender: TObject);
begin
  FillChar(VprVetorMascara, SizeOf(VprVetorMascara), 0);
  VprListar:= True;
  CadServicos.Open;
  VprQtdNiveis:= DesmontaMascara(VprVetorMascara, varia.MascaraClaSer);  // busca em constantes
  CarregaClassificacao(VprVetorMascara);
  Arvore.Color:= EditColor1.Color;
  Arvore.Font:= EditColor1.Font;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                           Chamadas diversas dos Tree
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{*****cada deslocamento no TreeView causa uma mudança na lista da direita******}
procedure TFServicos.ArvoreChange(Sender: TObject; Node: TTreeNode);
begin
  if VprListar then
  begin
    if TClassificacao(TTreeNode(node).Data).tipo = 'CL' then
      CarregaServico(node.Level,TClassificacao(TTreeNode(node).Data).CodClassificacao, node);
    Arvore.Update;
  end;
end;

{ *******************Cada vez que expandir um no*******************************}
procedure TFServicos.ArvoreExpanded(Sender: TObject; Node: TTreeNode);
begin
  CarregaServico(node.Level,TClassificacao(TTreeNode(node).Data).CodClassificacao,node);
  if TClassificacao(TTreeNode(node).Data).tipo = 'CL' then
  begin
    Node.SelectedIndex:= 1;
    Node.ImageIndex:= 1;
  end;
end;

{********************Cada vez que voltar a expanção de um no*******************}
procedure TFServicos.ArvoreCollapsed(Sender: TObject; Node: TTreeNode);
begin
  if TClassificacao(TTreeNode(node).Data).tipo = 'CL' then
  begin
    Node.SelectedIndex:=0;
    Node.ImageIndex:=0;
  end;
end;

{ **************** se presionar a setas naum atualiza movimentos ************ }
procedure TFServicos.ArvoreKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key in[37..40]  then
    VprListar := False;
end;

{ ************ apos soltar setas atualiza movimentos ************************ }
procedure TFServicos.ArvoreKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  VprListar := true;
  ArvoreChange(sender,arvore.Selected);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações de localizacao do servico
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{************************ localiza o servico **********************************}
procedure TFServicos.BitBtn1Click(Sender: TObject);
var
  Vpfcodigo, VpfSelect : string;
  VpfSomaNivel, VpfNivelSelecao: Integer;
begin
  VpfSelect:= ' Select * from cadservico '   +
              ' where c_nom_ser like ''@%''' +
              ' order by c_nom_ser ';
  Localiza.info.DataBase := Fprincipal.BaseDados;
  Localiza.info.ComandoSQL := VpfSelect;
  Localiza.info.caracterProcura := '@';
  Localiza.info.ValorInicializacao := '';
  Localiza.info.CamposMostrados[0] := 'I_cod_SER';
  Localiza.info.CamposMostrados[1] := 'c_nom_SER';
  Localiza.info.CamposMostrados[2] := '';
  Localiza.info.DescricaoCampos[0] := 'Código';
  Localiza.info.DescricaoCampos[1] := 'Nome Serviço';
  Localiza.info.DescricaoCampos[2] := '';
  Localiza.info.TamanhoCampos[0] := 8;
  Localiza.info.TamanhoCampos[1] := 40;
  Localiza.info.TamanhoCampos[2] := 0;
  Localiza.info.CamposRetorno[0] := 'I_cod_ser';
  Localiza.info.CamposRetorno[1] := 'C_cod_cla';
  Localiza.info.SomenteNumeros := false;
  Localiza.info.CorFoco := FPrincipal.CorFoco;
  Localiza.info.CorForm := FPrincipal.CorForm;
  Localiza.info.CorPainelGra := FPrincipal.CorPainelGra;
  Localiza.info.TituloForm := '  Localizar Serviços  ';
  if (Localiza.execute) and (localiza.retorno[0] <> '') Then
  begin
    VpfSomaNivel := 1;
    VpfNivelSelecao := 1;
    Vprlistar := false;
    arvore.Selected := VprPrimeiroNode;

    while VpfSomaNivel <= Length(localiza.retorno[1]) do
    begin
      Vpfcodigo:= copy(localiza.retorno[1], VpfSomaNivel, VprVetorMascara[VpfNivelSelecao]);
      VpfSomaNivel := VpfSomaNivel + VprVetorMascara[VpfNivelSelecao];
      arvore.Selected := arvore.Selected.GetNext;
      while TClassificacao(arvore.Selected.Data).CodClassificacoReduzido <> VpfCodigo  do
        arvore.Selected := arvore.Selected.GetNextChild(arvore.selected);
      inc(VpfNivelSelecao);
    end;
    CarregaServico(arvore.selected.Level,TClassificacao(arvore.selected.Data).CodClassificacao,arvore.selected);
    arvore.Selected := arvore.Selected.GetNext;

    while TClassificacao(arvore.Selected.Data).CodProduto <> localiza.retorno[0]  do
      arvore.Selected:= arvore.Selected.GetNextChild(arvore.selected);

  end;

  Vprlistar := true;
  ArvoreChange(sender,arvore.Selected);
  self.ActiveControl := arvore;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                             eventos da classificacao
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******Desmonata a mascara pardão para a configuração das classificações*******}
function TFServicos.DesmontaMascara(var VpaVetor: array of byte; VpaMascara: String): Byte;
var
  VpfX, VpfPosicao: Byte;
begin
  VpfPosicao:= 0;
  VpfX:= 0;
  while Pos('.', VpaMascara) > 0 do
  begin
    VpaVetor[VpfX]:= (Pos('.', VpaMascara)-VpfPosicao)-1;
    inc(VpfX);
    VpfPosicao:= Pos('.', VpaMascara);
    VpaMascara[Pos('.', VpaMascara)]:= '*';
  end;
  VpaVetor[VpfX]:= length(VpaMascara)-VpfPosicao;
  VpaVetor[VpfX+1]:= 1;
  DesmontaMascara:= VpfX+1;
end;

{********************* cadastra uma nova classificacao ************************}
procedure TFServicos.CadastraClassificacao;
var
  VpfDClassificacao: TClassificacao;
begin
  if (VprQtdNiveis <= Arvore.Selected.Level) then  //acabou os niveis para incluir a nova classificacao
  begin
    Erro(CT_FimInclusaoClassificacao);
    Exit;
  end;

  VpfDClassificacao:= TClassificacao.Cria;
  VpfDClassificacao.CodClassificacao:= TClassificacao(TTreeNode(arvore.Selected).Data).CodClassificacao; // envia o codigo pai para insercao;
  FNovaClassificacao:= TFNovaClassificacao.CriarSDI(application,'', Fprincipal.VerificaPermisao('FNovaClassificacao'));

  if FNovaClassificacao.Inseri(VpfDClassificacao, VprVetorMascara[arvore.Selected.Level+1],'S') then
  begin
    VpfDClassificacao.tipo := 'CL';
    VpfDClassificacao.DesPathFoto := '';
    Arvore.Items.AddChildObject(TTreeNode(arvore.Selected),VpfDClassificacao.CodClassificacoReduzido+' - '+
                                                           VpfDClassificacao.NomClassificacao, VpfDClassificacao);
    arvore.OnChange(self,arvore.selected);
    Arvore.Update;
  end
  else
    VpfDClassificacao.free;
end;

{****************** limpa a arvore e cria o no inicial ************************}
function TFServicos.LimpaArvore : TTreeNode;
var
  VpfDClassificacao: TClassificacao;
begin
  Arvore.Items.Clear;
  VpfDClassificacao:= TClassificacao.Cria;
  VpfDClassificacao.CodClassificacao:= '';
  VpfDClassificacao.CodClassificacoReduzido:= '';
  VpfDClassificacao.Tipo:= 'CL';
  Result:= Arvore.Items.AddObject(Arvore.Selected, 'Serviços', VpfDClassificacao);
  Result.ImageIndex:= 0;
  Result.SelectedIndex:= 0;
end;

{************************carrega Classificacao*********************************}
procedure TFServicos.CarregaClassificacao(VpaVetorInfo : array of byte);
var
  VpfNode: TTreeNode;
  VpfDClassificacao: TClassificacao;
  VpfTamanho, VpfNivel: word;
  VpfCodigo: String;
begin
  VpfNode:= LimpaArvore;  // limpa a arvore e retorna o nó inicial;
  VprPrimeiroNode := VpfNode;
  VprVetorNode[0]:= VpfNode;
  Arvore.Update;
  AdicionaSQLAbreTabela(CadClassificacao,'SELECT * FROM CADCLASSIFICACAO'+
                                         ' WHERE I_COD_EMP = '+IntToStr(varia.CodigoEmpresa)+
                                         ' AND C_TIP_CLA = ''S''' +
                                         ' ORDER BY C_COD_CLA ');
  while not(CadClassificacao.EOF) do
  begin
    VpfTamanho:= VpaVetorInfo[0];
    VpfNivel:= 0;
    while Length(CadClassificacao.FieldByName('C_COD_CLA').AsString)<>VpfTamanho do
    begin
      inc(VpfNivel);
      Vpftamanho:= VpfTamanho+VpaVetorInfo[VpfNivel];
    end;

    Vpfcodigo:= CadClassificacao.FieldByName('C_COD_CLA').AsString;

    VpfDClassificacao:= TClassificacao.Cria;
    VpfDClassificacao.CodClassificacao:= CadClassificacao.FieldByName('C_COD_CLA').AsString;
    VpfDClassificacao.CodClassificacoReduzido:= copy(Vpfcodigo, (length(Vpfcodigo)-VpaVetorInfo[VpfNivel])+1, VpaVetorInfo[VpfNivel]);
    VpfDClassificacao.Tipo:= 'CL';
    VpfDClassificacao.ProdutosCarregados:= True;

    VpfNode:= Arvore.Items.AddChildObject(VprVetorNode[VpfNivel],VpfDClassificacao.CodClassificacoReduzido+' - '+
                                          CadClassificacao.FieldByName('C_NOM_CLA').AsString,VpfDClassificacao);
    VprVetorNode[VpfNivel+1]:= VpfNode;

    CadClassificacao.Next;
  end;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         eventos dos servicos
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************* cadastra um novo servico *******************************}
procedure TFServicos.CadatraServico;
var
  VpfDClassificacao: TClassificacao;
  VpfNo: TTreeNode;
  VpfDescricao, VpfCodServico, VpfCodClassificacao : string;
begin
  if  (arvore.Selected.Level = 0) then  // se estiver no no inicial nao cadastra
  begin
     erro(CT_ClassificacacaoServicoInvalida);
     abort;
  end;
  if TClassificacao(TTreeNode(arvore.Selected).Data).Tipo = 'SE' then  // se estiver selecionado um servico nao cadastra pois nao pode cadastrar um servico dentro de outro
  begin
    erro(CT_ErroInclusaoServico);
    abort;
  end;

  VpfDClassificacao:= TClassificacao.Cria;
  VpfCodClassificacao:= TClassificacao(TTreeNode(Arvore.selected).data).CodClassificacao;
  FNovoServico := TFNovoServico.CriarSDI(application,'',FPrincipal.VerificaPermisao('FNovoServico'));

  if FNovoServico.InsereNovoServico(VpfCodClassificacao, VpfCodServico,VpfDescricao, False) then
  begin
     VpfDClassificacao.CodClassificacao:= VpfCodClassificacao;
     VpfDClassificacao.Tipo:= 'SE';
     VpfDClassificacao.ProdutosCarregados := true;
     VpfDClassificacao.CodProduto:= VpfCodServico;
     Vpfno:= Arvore.Items.AddChildObject(TTreeNode(Arvore.Selected),VpfDClassificacao.CodProduto+' - '+
                                         VpfDescricao, VpfDClassificacao);
     Vpfno.ImageIndex := 2;
     Vpfno.SelectedIndex := 2;
     Arvore.OnChange(Self,arvore.selected);
     Arvore.Update;
  end;
end;


{**************alteração de Classificação ou o servico*************************}
procedure TFServicos.Alterar(Sender: TObject; Alterar : Boolean);
var
  Vpfcodigo, VpfDescricao : string;
  VpfDClassificacao: TClassificacao;
begin
  if (arvore.Selected.Level=0) then // não é possível alterar o primeiro item
    abort;

  VpfDClassificacao:= TClassificacao(TTreeNode(arvore.Selected).Data);
  if VpfDClassificacao.Tipo = 'CL' then
  begin
    FNovaClassificacao := TFNovaClassificacao.CriarSDI(application,'',FPrincipal.VerificaPermisao('FNovaClassificacao'));
    if FNovaClassificacao.Alterar(VpfDClassificacao,'S',Alterar) then
    begin
      VpfCodigo:= VpfDClassificacao.CodClassificacoReduzido;
      Arvore.Selected.Text:= VpfCodigo + ' - ' + VpfDClassificacao.NomClassificacao;
      Arvore.OnChange(Sender,Arvore.Selected);
      Arvore.Update;
    end;
  end
  else
    if VpfDClassificacao.Tipo = 'SE' then
    begin
      Vpfcodigo:= VpfDClassificacao.CodProduto;
      VpfDescricao:= '';
      FNovoServico:= TFNovoServico.CriarSDI(application, '',FPrincipal.VerificaPermisao('FNovoServico'));
      if FNovoServico.AlteraServico(VpfDClassificacao.CodClassificacao, VpfCodigo,VpfDescricao, Alterar) then
        Arvore.Selected.Text:= VpfCodigo + ' - ' + VpfDescricao;
    end;
end;

{****************** carrega os servicos na arvore *****************************}
procedure TFServicos.CarregaServico(VpaNivel: Byte; VpaCodClassificacao: String; VpaNodeSelecao : TTreeNode);
var
  VpfNode: TTreeNode;
  VpfDClassificacao: TClassificacao;
  VpfAtividade : String;
begin
  if TClassificacao(TTreeNode(VpaNodeSelecao).Data).ProdutosCarregados then
  begin
    if CAtiPro.Checked Then
      VpfAtividade:= ' AND C_ATI_SER = ''S'''
    else
      VpfAtividade:= '';
    AdicionaSQLAbreTabela(CadServicos,'Select * from CadServico'+
                                      ' Where I_COD_EMP = '+IntToStr(varia.CodigoEmpresa)+
                                      ' and C_COD_CLA = '''+VpaCodClassificacao+''''+
                                      VpfAtividade +
                                      ' Order by I_Cod_Ser');
    while not CadServicos.EOF do
    begin
      VpfDClassificacao:= TClassificacao.Cria;
      VpfDClassificacao.CodClassificacao:= VpaCodClassificacao;
      VpfDClassificacao.CodProduto:= CadServicos.FieldByName('I_COD_SER').AsString;
      VpfDClassificacao.ProdutosCarregados:= True;
      VpfDClassificacao.Tipo:= 'SE';
      VpfNode:= Arvore.Items.AddChildObject(VpaNodeSelecao, VpfDClassificacao.CodProduto + ' - ' + CadServicos.FieldByName('C_NOM_SER').AsString, VpfDClassificacao);
      VprVetorNode[VpaNivel+1]:= VpfNode;
      VpfNode.ImageIndex := 2;
      VpfNode.SelectedIndex := 2;
      CadServicos.Next;
    end;
    TClassificacao(TTreeNode(VpaNodeSelecao).Data).ProdutosCarregados:= False;
  end;
end;

{*****************Exclusão de Classificação e produtos*************************}
procedure TFServicos.Excluir(Sender : TObject);
var
  VpfNode: TTreeNode;
begin
  if (arvore.Selected.Level=0) then
      abort;
  VpfNode:= arvore.Selected;
  Vprlistar := false;
  if (Arvore.Selected.HasChildren) then// Nao permite excluir se possui filhos
  begin
    erro(CT_ErroExclusaoClassificaca);
    arvore.Selected:= VpfNode;
    VprListar:= true;
    abort;
  end;

  if confirmacao(CT_DeletarItem) then  // verifica se deseja excluir
  begin
    if TClassificacao(TTreeNode(arvore.Selected).Data).Tipo = 'CL' then
    try
      // caso seja uma classificacao
        ExecutaComandoSql(Aux,'DELETE FROM CADCLASSIFICACAO'+
                               ' WHERE I_COD_EMP = ' + IntToStr(varia.CodigoEmpresa) +
                               ' and C_COD_CLA='''+ TClassificacao(TTreeNode(arvore.Selected).Data).CodClassificacao+ ''''+
                               ' and C_Tip_CLA = ''S''');
      TClassificacao(TTreeNode(arvore.selected).Data).Free;
      Arvore.items.Delete(arvore.Selected);
    except
      Erro(CT_ErroDeletaRegistroPai);
    end;
    // caso seja um serviço
    if TClassificacao(TTreeNode(arvore.Selected).Data).Tipo = 'SE' then
    begin
      try
        ExecutaComandoSql(Aux,' DELETE FROM CADSERVICO WHERE I_COD_EMP = ' + IntToStr(varia.CodigoEmpresa) +
                              ' and I_COD_SER ='+ TClassificacao(TTreeNode(arvore.Selected).Data).CodProduto);

        TClassificacao(TTreeNode(arvore.selected).Data).Free;
        Arvore.items.Delete(arvore.Selected);
      except
        Erro(CT_ErroDeletaRegistroPai);
      end;
    end;
    VprListar:= True;
    Arvore.OnChange(sender,arvore.selected);
  end;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                             eventos dos botoes
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{***************** cadastra uma nova classificacao ****************************}
procedure TFServicos.BClasssificaoClick(Sender: TObject);
begin
  CadastraClassificacao;
end;

{ ***************** altera a mostra entre produtos em atividades ou naum ******}
procedure TFServicos.AtiProClick(Sender: TObject);
begin
  RecarregaLista;
end;

{*************Chamada de alteração de produtos ou classificações***************}
procedure TFServicos.BConsultaClick(Sender: TObject);
begin
  Alterar(sender,false); // Consulta o servico ou a classificacao
end;

{*************Chamada de alteração de produtos ou classificações***************}
procedure TFServicos.BAlterarClick(Sender: TObject);
begin
  Alterar(sender,true);  // chamada de alteração
end;

{***************Chama a rotina para cadastrar um novo produto******************}
procedure TFServicos.BServicosClick(Sender: TObject);
begin
  CadatraServico;
end;

{****************************Fecha o Formulario corrente***********************}
procedure TFServicos.BFecharClick(Sender: TObject);
begin
  Close;
end;

{************Chamada de Exclusão de produtos ou classificações*****************}
procedure TFServicos.BExcluirClick(Sender: TObject);
begin
  Excluir(sender);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                 eventos diversos
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{*********************** recarrega a lista ************************************}
procedure TFServicos.RecarregaLista;
begin
  VprListar := false;
  Arvore.Items.Clear;
  VprListar := true;
  CarregaClassificacao(VprVetorMascara);
end;

{************** quando se da um duplo clique na arvore ************************}
procedure TFServicos.ArvoreDblClick(Sender: TObject);
begin
  if TClassificacao(TTreeNode(arvore.Selected).Data).Tipo = 'SE' then
    BAlterar.Click;
end;

end.
