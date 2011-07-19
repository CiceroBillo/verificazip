unit AConsultaReceitaDespesa;
{          Autor: Sergio Luiz Censi }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls, DBTables, Db, DBCtrls, Grids, DBGrids,
  Buttons, Menus, constantes, formularios, PainelGradiente, constMsg,
  Tabela, Componentes1, LabelCorMove, funObjeto, Localizacao, Mask,
  EditorImagem, ImgList, numericos;

type
  TFConsultaReceitaDespesa = class(TFormularioPermissao)
    CadPlano: TQuery;
    Imagens: TImageList;
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    Arvore: TTreeView;
    EditLocaliza1: TEditLocaliza;
    ConsultaPadrao1: TConsultaPadrao;
    ImageList1: TImageList;
    PanelColor1: TPanelColor;
    BitBtn3: TBitBtn;
    BLocaliza: TBitBtn;
    Grade: TDBGridColor;
    Splitter1: TSplitter;
    PanelColor3: TPanelColor;
    Contas: TQuery;
    DataContas: TDataSource;
    Data1: TCalendario;
    Data2: TCalendario;
    CTipo: TComboBoxColor;
    Cdata: TComboBoxColor;
    CadFilial: TQuery;
    CFiliais: TComboBoxColor;
    CadFilialI_EMP_FIL: TIntegerField;
    CadFilialI_COD_EMP: TIntegerField;
    CadFilialC_NOM_FAN: TStringField;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ArvoreExpanded(Sender: TObject; Node: TTreeNode);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ArvoreCollapsed(Sender: TObject; Node: TTreeNode);
    procedure BFecharClick(Sender: TObject);
    procedure ttClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EditLocaliza1Select(Sender: TObject);
    procedure ArvoreChange(Sender: TObject; Node: TTreeNode);
    procedure Data1Change(Sender: TObject);
  private
    QdadeNiveis : Byte;
    VetorMascara : array [1..6] of byte;
    VetorNo: array [0..6] of TTreeNode;
    PrimeiroNo : TTreeNode;
    creditoDebito : string;
    consultar : Boolean;
    procedure CarregaFiliais;
    Procedure CarregaMascara;
    function DesmontaMascara(var Vetor : array of byte; mascara:string):byte;
    procedure CarregaClassificacao(VetorInfo : array of byte );
    function AdicionaSelectMovimento( tamanho, CodCla : string; Pagar : boolean ) : string;
    procedure CarregaConsulta;
  public
    procedure CarregaPlanoContas;
  end;

type
  TDados = class
    Codigo    : string;
    Descricao : string;
    CreDeb : string;
    TamanhoMascara : string;
end;

type
  TDadosfilial = class
    CodigoEmpFil : integer;
  end;

var
  FConsultaReceitaDespesa : TFConsultaReceitaDespesa;

implementation

uses APrincipal, fundata, funsql, ANovoPlanoConta;

{$R *.DFM}


{***********************No fechamento do Formulario****************************}
procedure TFConsultaReceitaDespesa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   FechaTabela(CadPlano);
   Action := CaFree;
end;

{************************Quanto criado novo formulario*************************}
procedure TFConsultaReceitaDespesa.FormCreate(Sender: TObject);
begin
  data1.date := PrimeiroDiaMes(date);
  data2.date := UltimoDiaMes(date);
  CTipo.ItemIndex := 0;
  Cdata.ItemIndex := 0;
  consultar := false;
  CarregaFiliais;
end;

{************** carrega combo filiais ************************************* }
procedure TFConsultaReceitaDespesa.CarregaFiliais;
var
  Dados : TDadosfilial;
  item, itemFilialAtual : integer;
begin
  // empresa atual
  Dados := TDadosfilial.Create;
  dados.CodigoEmpFil := 0;
  item := CFiliais.Items.AddObject('Toda Empresa',dados);

  CadFilial.open;
  while not CadFilial.Eof do
  begin
    Dados := TDadosfilial.Create;
    dados.CodigoEmpFil := CadFilialI_EMP_FIL.AsInteger;
    item := CFiliais.Items.AddObject(CadFilialI_EMP_FIL.AsString + '  -  '+ CadFilialC_NOM_FAN.AsString,dados);
    if varia.CodigoEmpFil = CadFilialI_EMP_FIL.AsInteger then
      itemFilialAtual := item;
    CadFilial.Next;
  end;
  CFiliais.ItemIndex := itemFilialAtual;
end;

{*********** carrega a mascara do plano de conta ***************************** }
Procedure TFConsultaReceitaDespesa.CarregaMascara;
begin
  FillChar(VetorMascara, SizeOf(VetorMascara), 0);

  CadPlano.sql.Clear;
  CadPlano.sql.Add('Select * from cadempresas where i_cod_emp = ' + IntToStr(varia.CodigoEmpresa) +
                           ' and C_MAS_PLA <> ''0''' );
  CadPlano.open;

  if not CadPlano.EOF then
    varia.MascaraPlanoConta := CadPlano.FieldByName('C_MAS_PLA').AsString  // carrega mascara
  else
  begin
    Aviso(CT_FilialSemMascara);   // caso a mascara seje 0
  end;

  QdadeNiveis := DesmontaMascara(VetorMascara, varia.MascaraPlanoConta);  // busca em constantes
end;


{******Desmonata a mascara pardão para a configuração das classificações*******}
function TFConsultaReceitaDespesa.DesmontaMascara(var Vetor : array of byte; mascara:string):byte;
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
procedure TFConsultaReceitaDespesa.CarregaPlanoContas;
begin
  CarregaMascara;
  CarregaClassificacao(VetorMascara);
  self.ShowModal;
end;

{************************carrega Classificacao*********************************}
procedure TFConsultaReceitaDespesa.CarregaClassificacao(VetorInfo : array of byte);
var
  Dado : TDados;
  no : TTreeNode;
  tamanho, nivel : word;
  codigo :string;
begin
  Arvore.Items.Clear;
  Dado := Tdados.create;
  dado.Codigo := '';
  dado.Descricao := '';
  Dado.CreDeb := '';
  Dado.TamanhoMascara := IntToStr(vetorInfo[0]);
  no := arvore.Items.AddObject(arvore.Selected, 'Plano de Conta',dado);
  no.ImageIndex:=0;
  no.SelectedIndex:=0;

  PrimeiroNo := no;
  VetorNo[0]:=no;
  Arvore.Update;

  CadPlano.SQL.Clear;
  CadPlano.SQL.Add('SELECT * FROM CAD_PLANO_CONTA WHERE I_COD_EMP = ' + IntToStr(varia.CodigoEmpresa) );

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
    Dado.CreDeb := CadPlano.FieldByName('C_TIP_PLA').AsString;

    if VetorInfo[nivel + 1] <> 0 then
      Dado.TamanhoMascara := IntToStr(tamanho + VetorInfo[nivel+1])
   else
      Dado.TamanhoMascara := IntToStr(tamanho + 4);

    no := Arvore.Items.AddChildObject(VetorNo[nivel], codigo+ ' - '+
                                      CadPlano.FieldByName('C_NOM_PLA').AsString, dado);
    VetorNo[nivel+1]:= no;

    CadPlano.Next;
  end;
  consultar := true;
  arvore.FullCollapse;
end;

{ *******************Cada vez que expandir um no*******************************}
procedure TFConsultaReceitaDespesa.ArvoreExpanded(Sender: TObject; Node: TTreeNode);
begin
   node.SelectedIndex:=1;
   node.ImageIndex:=1;
end;

{********************Cada vez que voltar a expanção de um no*******************}
procedure TFConsultaReceitaDespesa.ArvoreCollapsed(Sender: TObject; Node: TTreeNode);
begin
   node.SelectedIndex:=0;
   node.ImageIndex:=0;
end;



{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{****************************Fecha o Formulario corrente***********************}
procedure TFConsultaReceitaDespesa.BFecharClick(Sender: TObject);
begin
  close;
end;

{*********** localiza uma conta ********************************************* }
procedure TFConsultaReceitaDespesa.ttClick(Sender: TObject);
begin
  consultar := false;
  EditLocaliza1.AAbreLocalizacao;
  arvore.Selected := PrimeiroNo;
  while TDados(arvore.Selected.Data).Codigo <> EditLocaliza1.Text  do
   arvore.Selected := arvore.Selected.GetNext;
  Arvore.SetFocus;
  consultar := true;
  CarregaConsulta;
end;

{**************** quando inicizliza o formulario **************************** }
procedure TFConsultaReceitaDespesa.FormShow(Sender: TObject);
begin
  Arvore.SetFocus;
  Arvore.Selected := PrimeiroNo;
end;

{************* select do edit localiza ************************************* }
procedure TFConsultaReceitaDespesa.EditLocaliza1Select(Sender: TObject);
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


function TFConsultaReceitaDespesa.AdicionaSelectMovimento( tamanho, CodCla : string; Pagar : boolean ) : string;
var
  tabelas, campo, somador, filtroPagaAberta, data, CampoData, filial : string;
begin
 if pagar then
 begin
  tabelas := ' from cadcontasapagar cad key join movcontasapagar mov, cad_plano_conta pla, cadMoedas moe ';
  campo :=   'mov.n_vlr_dup';
 end
 else
 begin
   tabelas := ' from cadcontasareceber cad key join movcontasareceber mov, cad_plano_conta pla, cadMoedas moe ';
   campo :=   'mov.n_vlr_par';
 end;

  case CTipo.ItemIndex of
    0 : Begin
          somador := ' sum(isnull(mov.n_vlr_pag,(' + campo + ' * moe.n_vlr_dia))) soma ';
          filtroPagaAberta := '';
        end;
    1 : begin
          somador := ' sum(isnull(mov.n_vlr_pag,0)) soma ';
          filtroPagaAberta := ' and mov.d_dat_pag is not null ';
        end;
    2 : Begin
          somador := ' sum(isnull(' + campo + ' * moe.n_vlr_dia, 0)) soma ';
          filtroPagaAberta  := ' and mov.d_dat_pag is null ';
        end;
   end;

   case cdata.ItemIndex of
     0 : data := '';
     1 : data := ', Mov.d_dat_ven';
     2 : data := ', Mov.d_dat_pag';
     3 : data := ', cad.d_dat_mov';
     4 : data := ', cad.d_dat_emi';
   end;

   result := data;

   if data <> '' then
     CampoData := data + ' data ';

   if TDadosfilial(CFiliais.Items.Objects[CFiliais.ItemIndex]).CodigoEmpFil <> 0 then
     filial := ' and cad.i_emp_fil = ' + IntToStr(TDadosfilial(CFiliais.Items.Objects[CFiliais.ItemIndex]).CodigoEmpFil)
   else
     filial := ' and pla.i_cod_emp = ' + IntToStr(varia.CodigoEmpresa);

 AdicionaSQLTabela(contas, ' select left(cad.c_cla_pla,'+ tamanho + ') codpla, ' +
                           ' pla.c_nom_pla nome, ' +  somador + CampoData );
  AdicionaSQLTabela(contas, tabelas );
  AdicionaSQLTabela(contas, ' where ' +
                            SQLTextoDataEntreAAAAMMDD('mov.d_dat_ven',data1.DateTime,data2.DateTime, false) +
                            ' and cad.c_cla_pla like ''' + CodCla + '%'' '+
                            filtroPagaAberta +
                            filial +
                            ' and ISNULL(mov.C_DUP_CAN, ''N'') = ''N''' +
                            ' and cad.i_cod_emp = pla.i_cod_emp ' +
                            ' and mov.i_cod_moe =  moe.i_cod_moe ' +
                            ' and pla.c_cla_pla = codpla ' +

                            ' group by left(cad.c_cla_pla,'+ tamanho + '), pla.c_nom_pla '  + data );
end;

procedure  TFConsultaReceitaDespesa.CarregaConsulta;
var
  data : string;
begin
  LimpaSQLTabela(Contas);
  grade.Columns[3].Visible := not (Cdata.ItemIndex = 0);
  if TDados(Arvore.Selected.Data).CreDeb = '' then
  begin
    AdicionaSelectMovimento( TDados(Arvore.Selected.Data).TamanhoMascara, '', false);
    AdicionaSQLTabela(contas, ' UNION all ' );
    AdicionaSelectMovimento( TDados(Arvore.Selected.Data).TamanhoMascara, '', true);
    AdicionaSQLTabela(contas, ' order by 1 ' );
  end
  else
  begin
    if TDados(Arvore.Selected.Data).CreDeb = 'D' then
      data := AdicionaSelectMovimento( TDados(Arvore.Selected.Data).TamanhoMascara, TDados(Arvore.Selected.Data).Codigo, true)
    else
      data := AdicionaSelectMovimento( TDados(Arvore.Selected.Data).TamanhoMascara, TDados(Arvore.Selected.Data).Codigo, false);
    AdicionaSQLTabela(contas, ' order by left(cad.c_cla_pla,'+ TDados(Arvore.Selected.Data).TamanhoMascara + ')' + data );
  end;

  AbreTabela(contas);
  if (Contas.Fields[2] is TFloatField) then
    (Contas.Fields[2] as TFloatField).currency := true;
end;


procedure TFConsultaReceitaDespesa.ArvoreChange(Sender: TObject;
  Node: TTreeNode);
begin
  if consultar then
    CarregaConsulta;
end;

procedure TFConsultaReceitaDespesa.Data1Change(Sender: TObject);
begin
  CarregaConsulta;
end;

end.
