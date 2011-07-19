unit AProdutos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls, DBTables, Db, DBCtrls, Grids, DBGrids,
  Buttons, Menus, formularios, PainelGradiente,
  Tabela, Componentes1, LabelCorMove, Localizacao, Mask, UnDadosProduto,
  EditorImagem, ImgList, numericos, UnProdutos, UnClassificacao,UnSistema,
  FMTBcd, SqlExpr,Clipbrd;

type
  TFprodutos = class(TFormularioPermissao)
    Splitter1: TSplitter;
    CadClassificacao: TSQLQuery;
    Imagens: TImageList;
    CadProdutos: TSQLQuery;
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    Arvore: TTreeView;
    PanelColor4: TPanelColor;
    BAlterar: TBitBtn;
    BExcluir: TBitBtn;
    BProdutos: TBitBtn;
    BitBtn1: TBitBtn;
    Localiza: TConsultaPadrao;
    BNovaClassificacao: TBitBtn;
    VisualizadorImagem1: TVisualizadorImagem;
    PanelColor1: TPanelColor;
    BFechar: TBitBtn;
    BitBtn4: TBitBtn;
    PopupMenu1: TPopupMenu;
    MNovaClassificacao: TMenuItem;
    MNovoProduto: TMenuItem;
    N1: TMenuItem;
    MAlterar: TMenuItem;
    MExcluir: TMenuItem;
    Consultar1: TMenuItem;
    Localizar1: TMenuItem;
    N2: TMenuItem;
    ImageList1: TImageList;
    PanelColor3: TPanelColor;
    AtiPro: TCheckBox;
    Aux: TSQLQuery;
    PanelColor6: TPanelColor;
    Shape2: TShape;
    VerFoto: TCheckBox;
    Esticar: TCheckBox;
    Panel1: TPanel;
    Foto: TImage;
    BEditarFoto: TBitBtn;
    MFichaTecnica: TMenuItem;
    N3: TMenuItem;
    StatusBar1: TStatusBar;
    BLocalizaClassificacao: TBitBtn;
    BMenuFiscal: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure ArvoreExpanded(Sender: TObject; Node: TTreeNode);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ArvoreChange(Sender: TObject; Node: TTreeNode);
    procedure ArvoreCollapsed(Sender: TObject; Node: TTreeNode);
    procedure Alterar(Sender: TObject;Alterar : Boolean);
    Procedure Excluir(Sender : TObject);
    procedure BAlterarClick(Sender: TObject);
    procedure BExcluirClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BNovaClassificacaoClick(Sender: TObject);
    procedure BProdutosClick(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure FotoDblClick(Sender: TObject);
    procedure EsticarClick(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure ArvoreDblClick(Sender: TObject);
    procedure VerFotoClick(Sender: TObject);
    procedure ArvoreKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ArvoreKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure AtiProClick(Sender: TObject);
    procedure BBAjudaClick(Sender: TObject);
    procedure MFichaTecnicaClick(Sender: TObject);
    procedure ArvoreDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ArvoreDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure BLocalizaClassificacaoClick(Sender: TObject);
    procedure BMenuFiscalClick(Sender: TObject);
  private
    UnProduto : TFuncoesProduto;
    VprListar : boolean;
    VprQtdNiveis : Byte;
    VprVetorMascara : array [1..6] of byte;
    VprVetorNo: array [0..6] of TTreeNode;
    VprPrimeiroNo : TTreeNode;
    CifraInicial : string;
    function DesmontaMascara(var Vetor : array of byte; mascara:string):byte;
    procedure CarregaClassificacao(VpaVetorInfo : array of byte);
    procedure CarregaProduto(VpaNoSelecao : TTreeNode);
    procedure CarregaConsumoProduto(VpaNoSelecao : TTreeNode);
    procedure RecarregaLista;
    procedure ConfiguraPermissaoUsuario;
  public
    { Public declarations }
  end;

var
  Fprodutos: TFprodutos;

implementation

uses APrincipal, fundata, constantes,funObjeto, constMsg, funstring,
     ANovaClassificacao, FunSql, ANovoProdutoPro, AMenuFiscalECF;

{$R *.DFM}


{***********************No fechamento do Formulario****************************}
procedure TFprodutos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   CurrencyString := CifraInicial;
   UnProduto.Destroy;
   CadProdutos.Close;
   CadClassificacao.Close;
   Action := CaFree;
end;

{************************Quanto criado novo formulario*************************}
procedure TFprodutos.FormCreate(Sender: TObject);
begin
  ConfiguraPermissaoUsuario;
  CifraInicial := CurrencyString;
  UnProduto := TFuncoesProduto.criar(self,FPrincipal.BaseDados);
  FillChar(VprVetorMascara, SizeOf(VprVetorMascara), 0);
  VprListar := true;

  if not FunProdutos.VerificaMascaraClaPro then
    PanelColor4.Enabled := false;

  VprQtdNiveis := DesmontaMascara(VprVetorMascara, varia.mascaraCLA);  // busca em constantes

  CarregaClassificacao(VprVetorMascara);
end;

{******Desmonata a mascara pardão para a configuração das classificações*******}
function TFprodutos.DesmontaMascara(var Vetor : array of byte; mascara:string):byte;
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
procedure TFprodutos.CarregaClassificacao(VpaVetorInfo : array of byte);
var
  VpfNo : TTreeNode;
  VpfDClassificacao : TClassificacao;
  VpfTamanho, VpfNivel : word;
begin
  Arvore.Items.Clear;
  VpfDClassificacao := TClassificacao.Cria;
  VpfDClassificacao.CodClassificacao:='';
  VpfDClassificacao.Tipo := 'NA'; //NADA;
  Vpfno := arvore.Items.AddObject(arvore.Selected, 'Produtos', VpfDClassificacao);
  VprPrimeiroNo := VpfNo;
  VprVetorNo[0]:= VpfNo;
  Vpfno.ImageIndex:=0;
  Vpfno.SelectedIndex:=0;
  Arvore.Update;

  CadClassificacao.SQL.Clear;
  CadClassificacao.SQL.Add('SELECT * FROM CADCLASSIFICACAO '+
                           ' WHERE I_COD_EMP = ' + IntToStr(varia.CodigoEmpresa) +
                           ' and c_tip_cla = ''P''');
  if (puSomenteProdutos in varia.PermissoesUsuario) and (Varia.CodClassificacaoProdutos <> '') then
    CadClassificacao.SQL.Add('AND C_COD_CLA like '''+Varia.CodClassificacaoProdutos+'%''')
  else
    if (puSomenteMateriaPrima in varia.PermissoesUsuario) and (Varia.CodClassificacaoMateriaPrima <> '') then
      CadClassificacao.SQL.Add('AND C_COD_CLA like '''+Varia.CodClassificacaoMateriaPrima+'%''');

  CadClassificacao.SQL.Add(' ORDER BY C_COD_CLA ');
  CadClassificacao.Open;

  while not(CadClassificacao.EOF) do
  begin
    VpfTamanho :=  VpaVetorInfo[0];
    Vpfnivel := 0;
    while length(CadClassificacao.FieldByName('C_COD_CLA').AsString) <> VpfTamanho do
    begin
      inc(VpfNivel);
      Vpftamanho:=VpfTamanho+VpaVetorInfo[Vpfnivel];
    end;

    VpfDClassificacao := TClassificacao.Create;
    VpfDClassificacao.CodClassificacao := CadClassificacao.FieldByName('C_COD_CLA').AsString;
    VpfDClassificacao.CodClassificacoReduzido := copy(VpfDClassificacao.CodClassificacao, (length(VpfDClassificacao.CodClassificacao)-VpaVetorInfo[Vpfnivel])+1, VpaVetorInfo[VpfNivel]);
    VpfDClassificacao.NomClassificacao := CadClassificacao.FieldByName('C_NOM_CLA').AsString;
    VpfDClassificacao.ProdutosCarregados := false;
    VpfDClassificacao.Tipo := 'CL';
    VpfDClassificacao.ProdutosCarregados := false;

    Vpfno:=Arvore.Items.AddChildObject(VprVetorNo[VpfNivel], VpfDClassificacao.CodClassificacoReduzido + ' - '+
                                                        CadClassificacao.FieldByName('C_NOM_CLA').AsString, VpfDClassificacao);
    VprVetorNo[Vpfnivel+1]:=Vpfno;

    CadClassificacao.Next;
  end;
  CadClassificacao.Close;
end;

{********carregaProduto : serve para carregar o TreeView com as informações
                    da base que estão na tabela Produtos.**********************}
procedure TFprodutos.CarregaProduto(VpaNoSelecao : TTreeNode );
var
  VpfNo : TTreeNode;
  VpfDClassificacao : TClassificacao;
  VpfSeqProduto : Integer;
begin
  VpfSeqProduto := -1;
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
                         ' and PRO.C_COD_CLA = ''' + VpfDClassificacao.CodClassificacao + '''');

     if AtiPro.Checked then
        CadProdutos.sql.add(' and PRO.C_ATI_PRO = ''S''');

      CadProdutos.sql.add(' and pro.I_seq_pro = mov.i_seq_pro ' +
                          ' and mov.i_emp_fil = ' + IntTostr(varia.CodigoEmpFil) +
                          ' and mov.I_COD_COR = 0 '+
                          ' and pro.i_cod_moe = moe.i_cod_moe' );

     if config.NaArvoreOrdenarProdutoPeloCodigo then
       CadProdutos.sql.add('  Order by PRO.C_COD_PRO, PRO.I_SEQ_PRO')
     else
       CadProdutos.sql.add('  Order by PRO.C_NOM_PRO, PRO.I_SEQ_PRO');

     CadProdutos.open;
     CadProdutos.First;

     while not CadProdutos.EOF do
     begin
       if VpfSeqProduto <> CadProdutos.FieldByName('I_SEQ_PRO').AsInteger Then
       begin
         VpfSeqProduto  := CadProdutos.FieldByName('I_SEQ_PRO').AsInteger;
         VpfDClassificacao := TClassificacao.Create;
         VpfDClassificacao.CodProduto := CadProdutos.FieldByName('C_COD_PRO').AsString;
         VpfDClassificacao.tipo := 'PA';
         VpfDClassificacao.DesPathFoto := CadProdutos.FieldByName('C_PAT_FOT').AsString;
         VpfDClassificacao.SeqProduto := CadProdutos.FieldByName('I_SEQ_PRO').AsInteger;

         if config.VerCodigoProdutos then  // configura se mostra ou naum o codigo do produto..
            Vpfno := Arvore.Items.AddChildObject(VpaNoSelecao, VpfDClassificacao.CodProduto + ' - ' +
                                              CadProdutos.FieldByName('C_NOM_PRO').AsString, VpfDClassificacao)
         else
            Vpfno := Arvore.Items.AddChildObject(VpaNoSelecao,
                                          CadProdutos.FieldByName('C_NOM_PRO').AsString,VpfDClassificacao);

          Vpfno.ImageIndex := 2;
          Vpfno.SelectedIndex := 2;
         end;
       CadProdutos.Next;
     end;
    TClassificacao(TTreeNode(VpaNoSelecao).Data).ProdutosCarregados := true;
  end;
  CadProdutos.Close;
end;

{******************************************************************************}
procedure TFprodutos.ConfiguraPermissaoUsuario;
begin
  BMenuFiscal.Visible := NomeModulo = 'PDV';
  if NomeModulo = 'PDV' then
  begin
    AlterarVisibleDet([BEditarFoto,BNovaClassificacao,BProdutos,BAlterar,BExcluir,MNovaClassificacao,MNovoProduto,
                       MAlterar,MExcluir],((NomeModulo = 'PDV') and Config.SistemaEstaOnline ));
  end;
end;

{******************************************************************************}
procedure TFprodutos.CarregaConsumoProduto(VpaNoSelecao : TTreeNode);
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
                         ' from CADPRODUTOS PRO, MOVKIT KIT, '  +
                         ' CADMOEDAS MOE ' +
                         ' where PRO.I_COD_EMP = ' + IntToStr(varia.CodigoEmpresa) +
                         ' and KIT.I_PRO_KIT = '+IntToStr(VpfDClassificacao.SeqProduto)+
                         ' and KIT.I_SEQ_PRO = PRO.I_SEQ_PRO');

     if AtiPro.Checked then
        CadProdutos.sql.add(' and PRO.C_ATI_PRO = ''S''');

      CadProdutos.sql.add(' and pro.i_cod_moe = moe.i_cod_moe' );

     CadProdutos.sql.add('  Order by C_COD_PRO');

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
          Vpfno := Arvore.Items.AddChildObject(VpaNoSelecao, VpfDClassificacao.CodProduto + ' - ' +
                                            CadProdutos.FieldByName('C_NOM_PRO').AsString, VpfDClassificacao)
       else
          Vpfno := Arvore.Items.AddChildObject(VpaNoSelecao,
                                        CadProdutos.FieldByName('C_NOM_PRO').AsString,VpfDClassificacao);

        if FunProdutos.ExisteConsumo(VpfDClassificacao.SeqProduto) then
        begin
          Vpfno.ImageIndex := 3;
          Vpfno.SelectedIndex := 3;
        end
        else
        begin
          Vpfno.ImageIndex := 2;
          Vpfno.SelectedIndex := 2;
        end;

       CadProdutos.Next;
     end;
    TClassificacao(TTreeNode(VpaNoSelecao).Data).ProdutosCarregados := true;
  end;
  CadProdutos.Close;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
         Efetua as atividade basica nas tebelas de Produtos e Classificacao
                    Inserção,  Alteração e Exclusão

)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************
            Inserção de Classificação e Produtos
  ListaDblClick :  um duplo clique na lista da direita causa uma inserçao
               se estiver posicionado na primeira ou segunda posição da lista
****************************************************************************** }
procedure TFprodutos.BNovaClassificacaoClick(Sender: TObject);
var
  VpfDClassificacao :TClassificacao;
  VpfResultado : String;
begin
  VpfResultado := '';
  if (VprQtdNiveis <= arvore.Selected.Level) then
    VpfResultado := CT_FimInclusaoClassificacao;

  if VpfResultado = '' then
  begin
    VpfDClassificacao := TClassificacao.Create;
    VpfDClassificacao.CodClassificacao := TClassificacao(TTreeNode(arvore.Selected).Data).CodClassificacao; // envia o codigo pai para insercao;

    FNovaClassificacao := TFNovaClassificacao.CriarSDI(application,'', Fprincipal.VerificaPermisao('FNovaClassificacao'));
    if (FNovaClassificacao.Inseri(VpfDClassificacao,VprVetorMascara[arvore.Selected.Level+1], 'P')) then
    begin

      VpfDClassificacao.tipo := 'CL';
      VpfDClassificacao.ProdutosCarregados := true;
      Arvore.Items.AddChildObject( TTreeNode(arvore.Selected),VpfDClassificacao.CodClassificacoReduzido +
                                  ' - ' + VpfDClassificacao.NomClassificacao,VpfDClassificacao);
      arvore.OnChange(sender,arvore.selected);
      Arvore.Update;
    end;
  end;
  if VpfResultado <> '' then
    aviso(VpfResultado);
end;

{***************Chama a rotina para cadastrar um novo produto******************}
procedure TFprodutos.BProdutosClick(Sender: TObject);
var
  VpfDClassificacao :TClassificacao;
  VpfDProduto : TRBDProduto;
  VpfNo : TTreeNode;
  VpfResultado : string;
begin
  VpfResultado := '';
  if  (arvore.Selected.Level = 0) then
    VpfREsultado := CT_ClassificacacaoProdutoInvalida;

  if VpfResultado = '' then
  begin
    if TClassificacao(TTreeNode(arvore.Selected).Data).Tipo = 'PA' then
      VpfResultado := CT_ErroInclusaoProduto;
    if VpfResultado = '' then
    begin
      VpfDClassificacao := TClassificacao.Create;

      FNovoProdutoPro := TFNovoProdutoPro.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoProdutoPro'));
      VpfDProduto := FNovoProdutoPro.NovoProduto(TClassificacao(TTreeNode(arvore.Selected).Data).CodClassificacao);
      if VpfDProduto <> nil then
      begin
         VpfDClassificacao.SeqProduto := VpfDProduto.SeqProduto;
         VpfDClassificacao.tipo := 'PA';
         VpfDClassificacao.ProdutosCarregados := true;
         VpfDClassificacao.DesPathFoto := VpfDProduto.PatFoto;
         VpfDClassificacao.CodProduto := VpfDProduto.CodProduto;

          if config.VerCodigoProdutos then  // configura se mostra ou naum o codigo do produto..
              VpfNo:= Arvore.Items.AddChildObject( TTreeNode(arvore.Selected),VpfDClassificacao.CodProduto + ' - ' + VpfDProduto.NomProduto, VpfDClassificacao)
          else
              VpfNo:= Arvore.Items.AddChildObject( TTreeNode(arvore.Selected),VpfDProduto.NomProduto, VpfDClassificacao);

         VpfNo.ImageIndex := 2;
         VpfNo.SelectedIndex := 2;
         VpfDProduto.free;

         arvore.OnChange(sender,arvore.selected);
         Arvore.Update;
      end;
    end;
  end;
  if VpfResultado <> '' then
    aviso(VpfResultado);
end;



{****************alteração de Classificação e produtos*************************}
procedure TFprodutos.Alterar(Sender: TObject; Alterar : Boolean);
var
  VpfDClassificacao : TClassificacao;
  VpfDProduto : TRBDProduto;
begin
  if (arvore.Selected.Level=0) then //não dá para alterar o primeiro item
    abort;
  VpfDClassificacao := TClassificacao(arvore.Selected.Data);
  if  TClassificacao(TTreeNode(arvore.Selected).Data).Tipo = 'CL' then
  begin
    FNovaClassificacao := TFNovaClassificacao.CriarSDI(application,'',FPrincipal.VerificaPermisao('FNovaClassificacao'));
    if FNovaClassificacao.Alterar(VpfDClassificacao,'P', Alterar) then
    begin
     arvore.Selected.Text := VpfDClassificacao.CodClassificacoReduzido + ' - ' + VpfDClassificacao.NomClassificacao ;
     arvore.OnChange(sender,arvore.selected);
     arvore.Update;
    end;
   end
   else
     if TClassificacao(TTreeNode(arvore.Selected).Data).Tipo = 'PA' then
     begin
       FNovoProdutoPro := TFNovoProdutoPro.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoProdutoPro'));
       VpfDProduto := FNovoProdutoPro.AlterarProduto(varia.codigoEmpresa,varia.CodigoEmpFil,VpfDClassificacao.SeqProduto);
       if VpfDProduto <> nil then
       begin
         VpfDClassificacao.CodProduto := VpfDProduto.CodProduto;
         VpfDClassificacao.DesPathFoto := VpfDProduto.PatFoto;
         if config.VerCodigoProdutos then  // configura se mostra ou naum o codigo do produto..
           arvore.Selected.Text := VpfDClassificacao.CodProduto+ ' - '+VpfDProduto.NomProduto
         else
           arvore.Selected.Text := VpfDProduto.NomProduto;
         arvore.OnChange(sender,arvore.selected);
         VpfDProduto.free;
       end;
     end;
end;

{*****************Exclusão de Classificação e produtos*************************}
procedure TFprodutos.Excluir(Sender : TObject);
var
  VpfNo : TTreeNode;
  VpfContaReg : Integer;
begin
   if (arvore.Selected.Level=0) then
       abort;

   Vpfno := arvore.Selected;
   Vprlistar := false;

   if confirmacao(CT_DeletarItem) then
   begin
    try
       // caso seja uma classificacao
      if TClassificacao(TTreeNode(arvore.Selected).Data).Tipo = 'CL' then
      begin
        if (Arvore.Selected.HasChildren) then
        begin
           erro(CT_ErroExclusaoClassificaca);
           arvore.Selected := VpfNo;
           VprListar := true;
           abort;
        end;
        CadClassificacao.Close;
        CadClassificacao.SQL.Clear;
        CadClassificacao.SQL.Add('DELETE FROM CADCLASSIFICACAO WHERE I_COD_EMP = ' + IntToStr(varia.CodigoEmpresa) +
                                 ' and C_COD_CLA='''+ TClassificacao(TTreeNode(arvore.Selected).Data).CodClassificacao+''''+
                                  ' and C_Tip_Cla = ''P''');
         CadClassificacao.ExecSql;
         CadClassificacao.Close;
         TClassificacao(TTreeNode(arvore.selected).Data).Free;
         arvore.items.Delete(arvore.Selected);
       end
       else
         if TClassificacao(TTreeNode(arvore.Selected).Data).Tipo = 'PA' then
         begin
           UnProduto.LocalizaEstoqueProduto(Aux,TClassificacao(TTreeNode(arvore.Selected).Data).SeqProduto);

           VpfContaReg := 0;
           while not Aux.Eof do
           begin
             Inc(VpfContaReg);
             Aux.Next;
             if VpfContaReg > 3 then
               Break;
           end;

           if VpfContaReg <= 1 then
           begin
             FunProdutos.ExcluiProduto(TClassificacao(TTreeNode(arvore.Selected).Data).SeqProduto);

             TClassificacao(TTreeNode(arvore.selected).Data).Free;
             arvore.items.Delete(arvore.Selected);
           end
           else
             erro(CT_ErroDeletaRegistroPai);
         end;
    except
      erro(CT_ErroDeletaRegistroPai);
    end;

    end;
   Vprlistar := true;
   arvore.OnChange(sender,arvore.selected);
end;




{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                           Chamadas diversas dos Tree
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{*****cada deslocamento no TreeView causa uma mudança na lista da direita******}
procedure TFprodutos.ArvoreChange(Sender: TObject; Node: TTreeNode);
begin
  if VprListar then
  begin
     if TClassificacao(TTreeNode(node).Data).tipo = 'CL' then
     begin
        carregaProduto(node);
        Foto.Picture := nil;
     end
   else
   if (TClassificacao(TTreeNode(node).Data).tipo = 'PA') Then //and (paginas.ActivePage = caracteristica) then
   begin
      try
         if (VerFoto.Checked) and (TClassificacao(TTreeNode(node).Data).DesPathFoto <> '') then
            Foto.Picture.LoadFromFile(varia.DriveFoto + TClassificacao(TTreeNode(node).Data).DesPathFoto)
         else
            Foto.Picture := nil;
      except
      end;
      CarregaConsumoProduto(Node);
   end;
 arvore.Update;
end;
end;

{ *******************Cada vez que expandir um no*******************************}
procedure TFprodutos.ArvoreExpanded(Sender: TObject; Node: TTreeNode);
begin
   carregaProduto(node);
   if TClassificacao(TTreeNode(node).Data).tipo = 'CL' then
   begin
      node.SelectedIndex:=1;
      node.ImageIndex:=1;
   end;
end;

{********************Cada vez que voltar a expanção de um no*******************}
procedure TFprodutos.ArvoreCollapsed(Sender: TObject; Node: TTreeNode);
begin
   if TClassificacao(TTreeNode(node).Data).tipo = 'CL' then
   begin
     node.SelectedIndex:=0;
     node.ImageIndex:=0;
   end;
end;

{*************Chamada de alteração de produtos ou classificações***************}
procedure TFprodutos.BAlterarClick(Sender: TObject);
begin
   alterar(sender,true);  // chamnada de alteração
end;

{************Chamada de Exclusão de produtos ou classificações*****************}
procedure TFprodutos.BExcluirClick(Sender: TObject);
begin
   Excluir(sender);
end;

{ **************** se presionar a setas naum atualiza movimentos ************ }
procedure TFprodutos.ArvoreKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key in[37..40]  then
   VprListar := false;
end;

{ ************ apos soltar setas atualiza movimentos ************************ }
procedure TFprodutos.ArvoreKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Vprlistar := true;
  ArvoreChange(sender,arvore.Selected);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
              Chamadas diversas para visualizar dados dos produtos
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}



procedure TFprodutos.BitBtn1Click(Sender: TObject);
var
  Vpfcodigo, VpfSelect : string;
  somaNivel,nivelSelecao, laco : integer;
begin
  VpfSelect :=' Select PRO.C_COD_PRO, PRO.C_COD_CLA, PRO.I_SEQ_PRO, PRO.C_NOM_PRO '+
           ' from CADPRODUTOS PRO, MOVQDADEPRODUTO MOV ' +
           ' where C_NOM_PRO like ''@%''';

   if AtiPro.Checked then
      Vpfselect := Vpfselect + ' and C_ATI_PRO = ''S''';

   Vpfselect := Vpfselect + ' and PRO.I_SEQ_PRO = MOV.I_SEQ_PRO ' +
                      ' and MOV.I_EMP_FIL = ' + IntTostr(varia.CodigoEmpFil)  ;

   Vpfselect := Vpfselect + ' order by C_NOM_PRO asc';

   Localiza.info.DataBase := Fprincipal.BaseDados;
   Localiza.info.ComandoSQL := Vpfselect;
   Localiza.info.caracterProcura := '@';
   Localiza.info.ValorInicializacao := '';
   Localiza.info.CamposMostrados[0] := 'C_COD_PRO';
   Localiza.info.CamposMostrados[1] := 'C_NOM_PRO';
   Localiza.info.CamposMostrados[2] := '';
   Localiza.info.DescricaoCampos[0] := 'Código';
   Localiza.info.DescricaoCampos[1] := 'Nome';
   Localiza.info.DescricaoCampos[2] := '';
   Localiza.info.TamanhoCampos[0] := 8;
   Localiza.info.TamanhoCampos[1] := 40;
   Localiza.info.TamanhoCampos[2] := 0;
   Localiza.info.CamposRetorno[0] := 'I_SEQ_PRO';
   Localiza.info.CamposRetorno[1] := 'C_COD_CLA';
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
       Vprlistar := false;
       arvore.Selected := VprPrimeiroNo;
       arvore.Selected.Collapse(true);

       while SomaNivel <= Length(localiza.retorno[1]) do
       begin
          Vpfcodigo := copy(localiza.retorno[1], SomaNivel, VprVetorMascara[nivelSelecao]);
          SomaNivel := SomaNivel + VprVetorMascara[nivelSelecao];

          arvore.Selected := arvore.Selected.GetNext;
          while TClassificacao(arvore.Selected.Data).CodClassificacoReduzido <> VpfCodigo  do
            arvore.Selected := arvore.Selected.GetNextChild(arvore.selected);
          inc(NivelSelecao);
       end;

       carregaProduto(arvore.selected);

       for laco := 0 to arvore.Selected.Count - 1 do
        if IntToStr(TClassificacao(arvore.Selected.Item[laco].Data).SeqProduto) = localiza.retorno[0] then
        begin
          arvore.Selected := arvore.Selected.Item[laco];
          break;
        end;
   end;

   Vprlistar := true;
   ArvoreChange(sender,arvore.Selected);
   self.ActiveControl := arvore;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{****************************Fecha o Formulario corrente***********************}
procedure TFprodutos.BFecharClick(Sender: TObject);
begin
   close;
end;

{******************************************************************************}
procedure TFprodutos.FotoDblClick(Sender: TObject);
begin
   VisualizadorImagem1.execute(varia.DriveFoto + TClassificacao(arvore.Selected.Data).DesPathFoto);
end;

procedure TFprodutos.EsticarClick(Sender: TObject);
begin
 Foto.Stretch := esticar.Checked;
end;

procedure TFprodutos.BitBtn4Click(Sender: TObject);
begin
   Alterar(sender,false);
end;

procedure TFprodutos.ArvoreDblClick(Sender: TObject);
begin
   if TClassificacao(TTreeNode(arvore.Selected).Data).Tipo = 'PA'then
      BAlterar.Click;
end;


procedure TFprodutos.VerFotoClick(Sender: TObject);
begin
if VerFoto.Checked then
  ArvoreChange(arvore,arvore.Selected)
else
  Foto.Picture.Bitmap := nil;
end;

{ ***************** altera a mostra entre produtos em atividades ou naum ******}
procedure TFprodutos.AtiProClick(Sender: TObject);
begin
RecarregaLista;
end;


procedure TFprodutos.RecarregaLista;
begin
  Vprlistar := false;
  arvore.Items.Clear;
  Vprlistar := true;
  CarregaClassificacao(VprVetorMascara);
end;

{******************************************************************************}
procedure TFprodutos.BBAjudaClick(Sender: TObject);
begin
end;

{******************************************************************************}
procedure TFprodutos.MFichaTecnicaClick(Sender: TObject);
begin
  if Arvore.Selected.Data <> nil then
  begin
    if (TObject(Arvore.Selected.Data) is TClassificacao) then
    begin
      if TClassificacao(Arvore.Selected.Data).Tipo = 'PA' then
      begin
{      FImpProduto := TFImpProduto.Create(application);
      FImpProduto.ImprimeProduto(IntTostr(TClassificacao(Arvore.Selected.Data).SeqProduto));
      FImpProduto.free;}
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFprodutos.ArvoreDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  accept := (Source is TTreeview);
end;

{******************************************************************************}
procedure TFprodutos.ArvoreDragDrop(Sender, Source: TObject; X,
  Y: Integer);
Var
  VpfNoDestino : TTreeNode;
  VpfResultado : String;
begin
  VpfNoDestino := Arvore.GetNodeAt(x,y);
  if VpfNoDestino <> nil then
  begin
    if TComponent(Source).Name =  'Arvore' then
    begin
      if (TClassificacao(VpfNoDestino.Data).Tipo = 'CL') and (TClassificacao(Arvore.Selected.Data).Tipo = 'PA') then
      begin
        VpfResultado := FunProdutos.AlteraClassificacaoProduto(TClassificacao(Arvore.Selected.Data).SeqProduto,TClassificacao(VpfNoDestino.Data).CodClassificacao);
        if VpfResultado <> '' then
          StatusBar1.Panels[0].Text := VpfResultado
        else
        begin
          Arvore.Selected.MoveTo(VpfNoDestino,naAddChild);
          StatusBar1.Panels[0].Text := 'Alterado a classificação do produto com sucesso.';
        end;
      end
      else
        StatusBar1.Panels[0].Text := 'Não foi possível alterar a classificação do produto porque o destino não é uma classificação.';
    end;
  end;
end;

{******************************************************************************}
procedure TFprodutos.BLocalizaClassificacaoClick(Sender: TObject);
var
  codigo, select : string;
  somaNivel,nivelSelecao  : integer;
begin
  select :=' Select * from CADCLASSIFICACAO pro ' +
           ' where c_nom_CLA like ''@%'''+
           ' and I_COD_EMP = '+IntToStr(VARIA.CodigoEmpresa)+
           ' order by C_NOM_CLA';

   Localiza.info.DataBase := Fprincipal.BaseDados;
   Localiza.info.ComandoSQL := select;
   Localiza.info.caracterProcura := '@';
   Localiza.info.ValorInicializacao := '';
   Localiza.info.CamposMostrados[0] := 'C_cod_CLA';
   Localiza.info.CamposMostrados[1] := 'c_nom_CLA';
   Localiza.info.CamposMostrados[2] := '';
   Localiza.info.DescricaoCampos[0] := 'codigo';
   Localiza.info.DescricaoCampos[1] := 'nome';
   Localiza.info.DescricaoCampos[2] := '';
   Localiza.info.TamanhoCampos[0] := 8;
   Localiza.info.TamanhoCampos[1] := 40;
   Localiza.info.TamanhoCampos[2] := 0;
   Localiza.info.CamposRetorno[0] := 'C_cod_cla';
   Localiza.info.SomenteNumeros := false;
   Localiza.info.CorFoco := FPrincipal.CorFoco;
   Localiza.info.CorForm := FPrincipal.CorForm;
   Localiza.info.CorPainelGra := FPrincipal.CorPainelGra;
   Localiza.info.TituloForm := '   Localizar Classificação   ';

   if Localiza.execute then
     if localiza.retorno[0] <> '' Then
     begin
         SomaNivel := 1;
         NivelSelecao := 1;
         Vprlistar := false;
         arvore.Selected := VprPrimeiroNo;
         arvore.Selected.Collapse(true);

         while SomaNivel <= Length(localiza.retorno[0]) do
         begin
            codigo := copy(localiza.retorno[0], SomaNivel, VprVetorMascara[nivelSelecao]);
            SomaNivel := SomaNivel + VprVetorMascara[nivelSelecao];

            arvore.Selected := arvore.Selected.GetNext;
            while TClassificacao(arvore.Selected.Data).CodClassificacoReduzido <> Codigo  do
              arvore.Selected := arvore.Selected.GetNextChild(arvore.selected);
            inc(NivelSelecao);
         end;
     end;

   Vprlistar := true;
   ArvoreChange(sender,arvore.Selected);
   self.ActiveControl := arvore;
end;

{******************************************************************************}
procedure TFprodutos.BMenuFiscalClick(Sender: TObject);
begin
  FMenuFiscalECF := TFMenuFiscalECF.CriarSDI(self,'',true);
  FMenuFiscalECF.ShowModal;
  FMenuFiscalECF.Free;
end;

end.
