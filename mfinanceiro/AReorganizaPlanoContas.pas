unit AReorganizaPlanoContas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios, ComCtrls, Componentes1, ExtCtrls, PainelGradiente,
  FMTBcd, DB, SqlExpr, ImgList, StdCtrls, Localizacao, Buttons, UnContasAPagar;

type
  TFReorganizaPlanoContas = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    PanelColor3: TPanelColor;
    PanelColor4: TPanelColor;
    AOrigem: TTreeView;
    ADestino: TTreeView;
    PainelGradiente2: TPainelGradiente;
    EditLocaliza1: TEditLocaliza;
    ImageList1: TImageList;
    Imagens: TImageList;
    CadPlano: TSQLQuery;
    BMigrar: TSpeedButton;
    BFechar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BMigrarClick(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
  private
    QdadeNiveis : Byte;
    VetorMascara : array [1..6] of byte;
    VetorNo: array [0..6] of TTreeNode;
    PrimeiroNo : TTreeNode;
    creditoDebito : string;
    Acao : boolean;
    function CarregaMascara : Boolean;
    function DesmontaMascara(var Vetor : array of byte; mascara:string):byte;
    procedure CarregaClassificacao(VpaArvore :TTreeView; VetorInfo : array of byte; tipoCreDeb : string);
    { Private declarations }
  public
    { Public declarations }
  end;
type
  TDados = class
    Codigo    : string;
    TipDebitoCredito,
    Descricao : string;
end;

var
  FReorganizaPlanoContas: TFReorganizaPlanoContas;

implementation

uses APrincipal, Constantes,ConstMsg;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFReorganizaPlanoContas.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  if CarregaMascara then
  begin
    CarregaClassificacao(AOrigem,VetorMascara, 'D');
    CarregaClassificacao(ADestino,VetorMascara, 'D');
  end;
end;

{******************************************************************************}
procedure TFReorganizaPlanoContas.BMigrarClick(Sender: TObject);
begin
  if (AOrigem.Selected.Data <> nil)and
     (ADestino.Selected.Data <> nil)  then
  begin
    if AOrigem.Selected.HasChildren then
      aviso('É NECESSÁRIO PRIMEIRO REESTRUTURAR AS CONTAS FILHAS.')
    else
    begin
      if TDados(AOrigem.Selected.Data).Codigo = TDados(ADestino.Selected.Data).Codigo then
      begin
        aviso('PLANO DE CONTAS DESTINO IGUAL A ORIGEM!!!'#13'O plano de contas destino não pode ser igual ao plano de contas de origem.');
      end
      else
      begin
        FunContasAPagar.ExcluiPlanoContas(TDados(AOrigem.Selected.Data).Codigo,TDados(ADestino.Selected.Data).Codigo);
        AOrigem.Selected.Delete;
      end;
   end;
  end;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFReorganizaPlanoContas.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFReorganizaPlanoContas.CarregaClassificacao(VpaArvore :TTreeView; VetorInfo: array of byte; tipoCreDeb: string);
var
  Dado : TDados;
  no : TTreeNode;
  tamanho, nivel : word;
  codigo :string;
begin
  creditoDebito := tipoCreDeb;
  VpaArvore.Items.Clear;
  Dado := Tdados.create;
  dado.Codigo := '';
  dado.Descricao := '';
  no := VpaArvore.Items.AddObject(VpaArvore.Selected, 'Plano de Conta',dado);
  no.ImageIndex:=0;
  no.SelectedIndex:=0;

  PrimeiroNo := no;
  VetorNo[0]:=no;
  VpaArvore.Update;

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
    no := VpaArvore.Items.AddChildObject(VetorNo[nivel], codigo+ ' - '+
                                      CadPlano.FieldByName('C_NOM_PLA').AsString, dado);
    VetorNo[nivel+1]:= no;

    CadPlano.Next;
  end;
  VpaArvore.FullExpand;
end;

{******************************************************************************}
function TFReorganizaPlanoContas.CarregaMascara: Boolean;
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
  end;

  QdadeNiveis := DesmontaMascara(VetorMascara, varia.MascaraPlanoConta);  // busca em constantes
end;

{******************************************************************************}
function TFReorganizaPlanoContas.DesmontaMascara(var Vetor: array of byte; mascara: string): byte;
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
procedure TFReorganizaPlanoContas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFReorganizaPlanoContas]);
end.
