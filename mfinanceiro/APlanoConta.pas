unit APlanoConta;
{          Autor: Sergio Luiz Censi }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls, DBTables, Db, DBCtrls, Grids, DBGrids,
  Buttons, Menus, constantes, formularios, PainelGradiente, constMsg,
  Tabela, Componentes1, LabelCorMove, funObjeto, Localizacao, Mask,
  EditorImagem, ImgList, numericos, FMTBcd, SqlExpr;

type
  TFPlanoConta = class(TFormularioPermissao)
    CadPlano: TSQLQuery;
    Imagens: TImageList;
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    Arvore: TTreeView;
    PanelColor4: TPanelColor;
    BAlterar: TBitBtn;
    BExcluir: TBitBtn;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BFechar: TBitBtn;
    PopupMenu1: TPopupMenu;
    NovaClassificao1: TMenuItem;
    N1: TMenuItem;
    Alterar1: TMenuItem;
    Excluir1: TMenuItem;
    Localizar1: TMenuItem;
    N2: TMenuItem;
    EditLocaliza1: TEditLocaliza;
    ConsultaPadrao1: TConsultaPadrao;
    ImageList1: TImageList;
    PanelColor1: TPanelColor;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure ArvoreExpanded(Sender: TObject; Node: TTreeNode);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ArvoreCollapsed(Sender: TObject; Node: TTreeNode);
    procedure Alterar(Sender: TObject;Alterar : Boolean);
    Procedure Excluir(Sender : TObject);
    procedure BAlterarClick(Sender: TObject);
    procedure BExcluirClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EditLocaliza1Select(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ArvoreDblClick(Sender: TObject);
  private
    QdadeNiveis : Byte;
    VetorMascara : array [1..6] of byte;
    VetorNo: array [0..6] of TTreeNode;
    PrimeiroNo : TTreeNode;
    creditoDebito : string;
    Acao : boolean;
    function CarregaMascara : Boolean;
    function DesmontaMascara(var Vetor : array of byte; mascara:string):byte;
    procedure CarregaClassificacao(VetorInfo : array of byte; tipoCreDeb : string);
  public
    function CarregaPlanoContas( TipoCreDeb : string ) : string;
    procedure CarregaCadastraPlanoContas;
    function verificaCodigo( var Codigo : string; TipoCreDeb : string; descricao : Tlabel; Cadastrar  : Boolean; ClickBotao : boolean = false  ) : Boolean;
  end;

type
  TDados = class
    Codigo    : string;
    TipDebitoCredito,
    Descricao : string;
end;

var
  FPlanoConta: TFPlanoConta;

implementation

uses APrincipal, fundata, funsql, ANovoPlanoConta;

{$R *.DFM}


{***********************No fechamento do Formulario****************************}
procedure TFPlanoConta.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   FechaTabela(CadPlano);
   Action := CaFree;
end;

{************************Quanto criado novo formulario*************************}
procedure TFPlanoConta.FormCreate(Sender: TObject);
begin
  acao := true;
end;

{*********** carrega a mascara do plano de conta ***************************** }
function TFPlanoConta.CarregaMascara : Boolean;
begin
  result := true;
  FillChar(VetorMascara, SizeOf(VetorMascara), 0);

  CadPlano.sql.Clear;
  CadPlano.sql.Add('Select * from cadempresas where i_cod_emp = ' + IntToStr(varia.CodigoEmpresa) +
                           ' and C_MAS_PLA <> ''0''' );
  CadPlano.open;

  if not CadPlano.EOF then
    varia.MascaraPlanoConta := CadPlano.FieldByName('C_MAS_PLA').AsString  // carrega mascara
  else
  begin
    result := false;
    Aviso(CT_FilialSemMascara);   // caso a mascara seje 0
    BAlterar.Enabled := false;
    BExcluir.Enabled := false;
    BitBtn1.Enabled := false;
    BitBtn2.Enabled := false;
  end;

  QdadeNiveis := DesmontaMascara(VetorMascara, varia.MascaraPlanoConta);  // busca em constantes

end;


{******Desmonata a mascara pardão para a configuração das classificações*******}
function TFPlanoConta.DesmontaMascara(var Vetor : array of byte; mascara:string):byte;
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

{*************** carrega o plano de contas ******************************** }
function TFPlanoConta.CarregaPlanoContas( TipoCreDeb : string ) : string;
begin
  result := '0';
  if CarregaMascara then
  begin
    CarregaClassificacao(VetorMascara, TipoCreDeb);
    self.ShowModal;
    if acao then
      result := TDados(TTreeNode(arvore.Selected).Data).Codigo
    else
      result := '';
  end
  else
    self.close;
end;


{ ********** carrega o plano de contas e permite cadastro ******************** }
procedure TFPlanoConta.CarregaCadastraPlanoCOntas;
begin
  AlterarVisibleDet([NovaClassificao1, Alterar1, Excluir1,n1,n2], true);
  PanelColor1.visible :=  false;
  CarregaPlanoContas('');
end;

{************************carrega Classificacao*********************************}
procedure TFPlanoConta.CarregaClassificacao(VetorInfo : array of byte; tipoCreDeb : string);
var
  Dado : TDados;
  no : TTreeNode;
  tamanho, nivel : word;
  codigo :string;
begin
  creditoDebito := tipoCreDeb;
  Arvore.Items.Clear;
  Dado := Tdados.create;
  dado.Codigo := '';
  dado.Descricao := '';
  no := arvore.Items.AddObject(arvore.Selected, 'Plano de Conta',dado);
  no.ImageIndex:=0;
  no.SelectedIndex:=0;

  PrimeiroNo := no;
  VetorNo[0]:=no;
  Arvore.Update;

  CadPlano.SQL.Clear;
  CadPlano.SQL.Add('SELECT * FROM CAD_PLANO_CONTA WHERE I_COD_EMP = ' + IntToStr(varia.CodigoEmpresa) );

  if tipoCreDeb <> '' then
    CadPlano.sql.Add(' and C_TIP_PLA = ''' + tipoCreDeb + '''');

  CadPlano.sql.Add(' ORDER BY C_CLA_PLA ');

  CadPlano.Open;

  while not(CadPlano.EOF) do
  begin
    tamanho := VetorInfo[0];
    nivel := 0;
    while length(CadPlano.FieldByName('C_CLA_PLA').AsString)<> tamanho do
    begin
      inc(nivel);
      tamanho:=tamanho+VetorInfo[nivel];
    end;

    codigo := CadPlano.FieldByName('C_CLA_PLA').AsString;

    dado :=  Tdados.create;
    dado.Codigo := Codigo;
    dado.Descricao := CadPlano.FieldByName('C_NOM_PLA').AsString;
    dado.TipDebitoCredito := CadPlano.FieldByName('C_TIP_PLA').AsString;
    no := Arvore.Items.AddChildObject(VetorNo[nivel], codigo+ ' - '+
                                      CadPlano.FieldByName('C_NOM_PLA').AsString, dado);
    VetorNo[nivel+1]:= no;

    CadPlano.Next;
  end;
  Arvore.FullExpand;
end;


{******************************************************************************
            Inserção de Classificação
  ListaDblClick :  um duplo clique na lista da direita causa uma inserçao
               se estiver posicionado na primeira ou segunda posição da lista
****************************************************************************** }
procedure TFPlanoConta.BitBtn2Click(Sender: TObject);
var
  dado : Tdados;
  desc, codigo, VpfCreditoDebito : string;
begin
  if (QdadeNiveis <= arvore.Selected.Level) then
  begin
    erro(CT_FimInclusaoClassificacao);
    abort;
  end;
    FNovoPlanoConta := TFNovoPlanoConta.CriarSDI(application,'', Fprincipal.VerificaPermisao('FNovaClassificacao'));
    codigo :=  TDados(TTreeNode(arvore.Selected).Data).Codigo;
    VpfCreditoDebito := TDados(TTreeNode(arvore.Selected).Data).TipDebitoCredito;
    if (FNovoPlanoConta.Inseri(desc, codigo, VetorMascara[arvore.Selected.Level+1], VpfCreditoDebito)) then
    begin
      dado := Tdados.create;
      dado.Codigo := codigo;
      dado.Descricao := desc;
      dado.TipDebitoCredito := VpfCreditoDebito;
      Arvore.Items.AddChildObject( TTreeNode(arvore.Selected),Codigo + ' - ' +  Desc, dado);
      Arvore.Update;
    end;
end;

{****************alteração de Classificação e produtos*************************}
procedure TFPlanoConta.Alterar(Sender: TObject; Alterar : Boolean);
var
  codigo, desc : string;
begin
  if (arvore.Selected.Level=0) then {não dá para alterar o primeiro item}
    abort;

   FNovoPlanoConta := TFNovoPlanoConta.CriarSDI(application,'',FPrincipal.VerificaPermisao('FNovaClassificacao'));
   if FNovoPlanoConta.Alterar(TDados(arvore.Selected.Data).Codigo, desc, creditoDebito) then
   begin
     codigo := TDados(TTreeNode(Arvore.Selected).Data).Codigo;
     TDados(TTreeNode(Arvore.Selected).Data).Descricao := desc;
     arvore.Selected.Text := codigo + ' - ' + desc;
     arvore.Update;
   end;
end;

{*****************Exclusão de Classificação e produtos*************************}
procedure TFPlanoConta.Excluir(Sender : TObject);
var
no : TTreeNode;
begin
   if (arvore.Selected.Level=0) then
       abort;

   no := arvore.Selected;

   if (Arvore.Selected.HasChildren) then
     begin
       erro(CT_ErroExclusaoClassificaca);
       arvore.Selected := no;
       abort;
   end;

   if confirmacao(CT_DeletarItem) then
   begin
    try
       CadPlano.Close;
       CadPlano.SQL.Clear;
       CadPlano.SQL.Add('DELETE FROM CAD_PLANO_CONTA WHERE I_COD_EMP = ' + IntToStr(varia.CodigoEmpresa) +
                        ' and C_CLA_PLA = ''' + TDados(TTreeNode(arvore.Selected).Data).Codigo + '''');
       CadPlano.ExecSql;
       CadPlano.Close;
       Arvore.Selected.Delete;
    except

    end;
end;
end;


{ *******************Cada vez que expandir um no*******************************}
procedure TFPlanoConta.ArvoreExpanded(Sender: TObject; Node: TTreeNode);
begin
   node.SelectedIndex:=1;
   node.ImageIndex:=1;
end;

{********************Cada vez que voltar a expanção de um no*******************}
procedure TFPlanoConta.ArvoreCollapsed(Sender: TObject; Node: TTreeNode);
begin
   node.SelectedIndex:=0;
   node.ImageIndex:=0;
end;

{*************Chamada de alteração de produtos ou classificações***************}
procedure TFPlanoConta.BAlterarClick(Sender: TObject);
begin
   alterar(sender,true);  // chamnada de alteração
end;

{************Chamada de Exclusão de produtos ou classificações*****************}
procedure TFPlanoConta.BExcluirClick(Sender: TObject);
begin
   Excluir(sender);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{****************************Fecha o Formulario corrente***********************}
procedure TFPlanoConta.BFecharClick(Sender: TObject);
begin
  Acao := true;
  close;
end;

{****************************cancela o Formulario corrente ********************}
procedure TFPlanoConta.BitBtn4Click(Sender: TObject);
begin
  Acao := false;
  close;
end;

{*********** localiza uma conta ********************************************* }
procedure TFPlanoConta.BitBtn1Click(Sender: TObject);
var
    codigo : string;
    somaNivel,nivelSelecao : integer;
begin
  EditLocaliza1.AAbreLocalizacao;
  if (TDados(arvore.Selected.Data).Codigo <> EditLocaliza1.Text)and (EditLocaliza1.Text <> '') then
  begin
    SomaNivel := 1;
    NivelSelecao := 1;
    arvore.Selected := PrimeiroNo;
    arvore.Selected.Collapse(true);
    codigo := '';

    while SomaNivel <= Length(EditLocaliza1.text) do
    begin
      codigo := codigo + copy(EditLocaliza1.text, SomaNivel, VetorMascara[nivelSelecao]);
      SomaNivel := SomaNivel + VetorMascara[nivelSelecao];

      arvore.Selected := arvore.Selected.GetNext;
      while TDados(arvore.Selected.Data).Codigo <> Codigo  do
        arvore.Selected := arvore.Selected.GetNextChild(arvore.selected);
      inc(NivelSelecao);
    end;
   end;
end;

{****************** chamada externa para a localizacao da conta ************** }
function TFPlanoConta.verificaCodigo( var Codigo : string; TipoCreDeb : string; descricao : Tlabel; Cadastrar : Boolean; ClickBotao : boolean = false ) : Boolean;
var
  VpfAuxCod : string;
begin
  result := true;
  if cadastrar then
  begin
    AlterarVisibleDet([NovaClassificao1, Alterar1, Excluir1,n1,n2], true);
    PanelColor1.visible :=  false;
  end;

  try
    if (codigo <> '') or (ClickBotao) then
    begin
      if not ClickBotao then
      begin
        CadPlano.SQL.Clear;
        CadPlano.SQL.Add('SELECT * FROM CAD_PLANO_CONTA WHERE I_COD_EMP = ' + IntToStr(varia.CodigoEmpresa) +
                         ' and C_CLA_PLA = ''' + codigo + '''' );

        if tipoCreDeb <> '' then
          CadPlano.sql.Add(' and C_TIP_PLA = ''' + tipoCreDeb + '''');

        CadPlano.Open;
      end;

      if CadPlano.Eof then
      begin
          VpfAuxCod := CarregaPlanoContas(TipoCreDeb);
          if VpfAuxCod <> '' then
          begin
            codigo := VpfAuxCod;
            descricao.Caption := TDados(TTreeNode(arvore.Selected).Data).Descricao;
          end
          else
            result := false;
      end
      else
      begin
         codigo := CadPlano.fieldByName('C_CLA_PLA').AsString;
         descricao.Caption := CadPlano.fieldByName('C_NOM_PLA').AsString;
      end;
    end
    else
      descricao.Caption := '';
  finally
    Self.close;
  end;
end;

{**************** quando inicizliza o formulario **************************** }
procedure TFPlanoConta.FormShow(Sender: TObject);
begin
  Arvore.SetFocus;
  Arvore.Selected := PrimeiroNo;
end;

{************* select do edit localiza ************************************* }
procedure TFPlanoConta.EditLocaliza1Select(Sender: TObject);
begin
  EditLocaliza1.ASelectValida.clear;
  EditLocaliza1.ASelectValida.Add(' select * from cad_plano_conta '+
                                  ' where c_cla_pla = ''@''' );
  EditLocaliza1.ASelectLocaliza.clear;
  EditLocaliza1.ASelectLocaliza.Add(' select * from cad_plano_conta  ' +
                                    ' where c_nom_pla like ''@%''' );
  if creditoDebito <> '' then
  begin
    EditLocaliza1.ASelectValida.Add(' and C_TIP_PLA = ''' + creditoDebito + '''');
    EditLocaliza1.ASelectLocaliza.Add(' and C_TIP_PLA = ''' + creditoDebito + '''');
  end;
end;

procedure TFPlanoConta.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 114 then
    BitBtn5.Click;
end;

{******************************************************************************}
procedure TFPlanoConta.ArvoreDblClick(Sender: TObject);
begin
  if PanelColor1.Visible then
    BitBtn3.click;
end;

end.


