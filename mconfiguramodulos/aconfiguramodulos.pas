unit AconfiguraModulos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, BotaoCadastro, StdCtrls,
  Buttons, DBCtrls, Db, DBTables, Tabela, Mask, UnRegistro, Spin;

type
  TFConfiguracoesModulos = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PFundo: TPanelColor;
    PanelColor2: TPanelColor;
    PFinanceiro: TGroupBox;
    RBancario: TCheckBox;
    RCaixa: TCheckBox;
    RComissoes: TCheckBox;
    RContaspagar: TCheckBox;
    RContasReceber: TCheckBox;
    Bfechar: TBitBtn;
    DSalvar: TSaveDialog;
    BSalvaModulos: TBitBtn;
    BitBtn3: TBitBtn;
    DAbrir: TOpenDialog;
    RFluxo: TCheckBox;
    RProduto: TCheckBox;
    RCusto: TCheckBox;
    REstoque: TCheckBox;
    Rservico: TCheckBox;
    RNotaFiscal: TCheckBox;
    RECF: TCheckBox;
    RTEF: TCheckBox;
    RcodigoBarra: TCheckBox;
    RGaveta: TCheckBox;
    RDocumentos: TCheckBox;
    ROrcamento: TCheckBox;
    RImpExp: TCheckBox;
    RSenhas: TCheckBox;
    GExe: TGroupBox;
    CFinanceiro: TCheckBox;
    CPontoLoja: TCheckBox;
    CImpExp: TCheckBox;
    CEstoque: TCheckBox;
    CFaturamento: TCheckBox;
    CCaixa: TCheckBox;
    CRelatorios: TCheckBox;
    GroupBox3: TGroupBox;
    BaseOficial: TCheckBox;
    BaseDemo: TCheckBox;
    BitBtn4: TBitBtn;
    Label5: TLabel;
    Meses: TSpinEdit;
    RVersao: TRadioGroup;
    BRelatorios: TBitBtn;
    RMala: TCheckBox;
    RAGenda: TCheckBox;
    RPedido: TCheckBox;
    ROS: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BfecharClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BSalvaModulosClick(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BaseOficialClick(Sender: TObject);
    procedure BRelatoriosClick(Sender: TObject);
  private
    Lista, ListaRelatorios : TStringList;
    Reg : TRegistro;
    procedure GeraLista;
    function GeraListaModulos : String;
    procedure LeLista;
    procedure LimpaCheckBox;

    procedure MODULOS_MOD(Path : string);  // modulos.mod
    procedure EXE_INI(Path : string);
    procedure EXE_MOD(Path : string);
  public
    { Public declarations }
  end;

var
  FConfiguracoesModulos: TFConfiguracoesModulos;

implementation

uses APrincipal, funobjeto, constmsg, FunHardware, funvalida, funstring,
  AConfigRelatorios;

{$R *.DFM}

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                             Formulario
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{ ****************** Na criação do Formulário ******************************** }
procedure TFConfiguracoesModulos.FormCreate(Sender: TObject);
begin
  Lista := TStringList.create;
  Reg := TRegistro.Create;
  ListaRelatorios := TStringList.create;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFConfiguracoesModulos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  lista.Free;
  Reg.Free;
  Action := CaFree;
end;

{ *************** Fecha o Formulario **************************************** }
procedure TFConfiguracoesModulos.BfecharClick(Sender: TObject);
begin
self.close;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                             Funcoes das Listas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************* mostra configuracao da base oficial ******************* }
procedure TFConfiguracoesModulos.BaseOficialClick(Sender: TObject);
begin
  RVersao.Enabled := BaseOficial.Checked;
  meses.Enabled := BaseOficial.Checked;
  Label5.Enabled := BaseOficial.Checked;
end;

{************ limpa todo os checkBox do formulario ************************** }
procedure TFConfiguracoesModulos.LimpaCheckBox;
var
  laco, laco1 : integer;
begin
for laco1 := 0 to PFundo.ControlCount - 1 do
  if (PFundo.Controls[laco1] is TGroupBox) then
    for laco := 0 to (PFundo.Controls[laco1] as TGroupBox).ControlCount - 1 do
      if ((PFundo.Controls[laco1] as TGroupBox).Controls[laco] is TCheckBox) then
        ((PFundo.Controls[laco1] as TGroupBox).Controls[laco] as TCheckBox).Checked := false;
end;

{********************* Cria a lista de modulos marcados pelos checkBox ******* }
procedure TFConfiguracoesModulos.GeraLista;
begin
  lista.Clear;
  if RContaspagar.Checked then
    lista.Add(CT_CONTAPAGAR);
  if RContasReceber.Checked then
    lista.Add(CT_CONTARECEBER);
  if RComissoes.Checked then
    lista.Add(CT_COMISSAO);
  if RBancario.Checked then
    lista.Add(CT_BANCARIO);
  if RCaixa.Checked then
    lista.Add(CT_CAIXA);
  if RFluxo.Checked then
    lista.Add(CT_FLUXO);
  if RNotaFiscal.Checked then
    lista.Add(CT_NOTAFISCAL);
  if RGaveta.Checked then
    lista.Add(CT_GAVETA);
  if RProduto.Checked then
    lista.Add(CT_PRODUTO);
  if Rservico.Checked then
    lista.Add(CT_SERVICO);
  if REstoque.Checked then
    lista.Add(CT_ESTOQUE);
  if RCusto.Checked then
    lista.Add(CT_CUSTO);
  if RcodigoBarra.Checked then
    lista.Add(CT_CODIGOBARRA);
  if ROrcamento.Checked then
    lista.Add(CT_ORCAMENTOVENDA);
  if RDocumentos.Checked then
    lista.Add(CT_IMPDOCUMENTOS);
  if RImpExp.Checked then
    lista.Add(CT_IMPORTACAOEXPORTACAO);
  if RSenhas.Checked then
    lista.Add(CT_SENHAGRUPO);
  if RMala.Checked then
    lista.Add(CT_MALACLIENTE);
  if RAGenda.Checked then
    lista.Add(CT_AGENDACLIENTE);
  if RPedido.Checked then
    lista.Add(CT_PEDIDOVENDA);
  if ROS.Checked then
    lista.Add(CT_ORDEMSERVICO);
end;

{********************* gera a lista dos executaveis ************************** }
function TFConfiguracoesModulos.GeraListaModulos : string;
var
  modulos : string;
begin
  modulos := '';
  if CFinanceiro.Checked then
    modulos := modulos + 'A';
  if CPontoLoja.Checked then
    modulos := modulos + 'B';
  if CImpExp.Checked then
    modulos := modulos + 'C';
  if CEstoque.Checked then
    modulos := modulos + 'D';
  if CFaturamento.Checked then
    modulos := modulos + 'E';
  if CCaixa.Checked then
    modulos := modulos + 'F';
  if CRelatorios.Checked then
    modulos := modulos + 'G';
  result := modulos;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Abre arquivos
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{****** abre a lista de modulos ja cadastrada para um determinado cliente **}
procedure TFConfiguracoesModulos.BitBtn3Click(Sender: TObject);
begin
  if DAbrir.Execute then
  begin
    LimpaCheckBox;
    Lista.LoadFromFile(DAbrir.FileName);
    Reg.DesCriptografaLista(lista);
    LeLista;
  end;
end;

{********** le a lista e marca os CheckBox correspondentes ****************** }
procedure TFConfiguracoesModulos.LeLista;
var
  laco : integer;
begin
  // financeiro
  for laco := 1 to lista.Count - 1 do
  begin
    if Lista.Strings[laco] = CT_CONTAPAGAR then RContaspagar.Checked := true;
    if Lista.Strings[laco] = CT_CONTARECEBER then RContasReceber.Checked := true;
    if Lista.Strings[laco] = CT_COMISSAO then RComissoes.Checked := true;
    if Lista.Strings[laco] = CT_BANCARIO then  RBancario.Checked := true;
    if Lista.Strings[laco] = CT_CAIXA then RCaixa.Checked := true;
    if Lista.Strings[laco] = CT_FLUXO then RFluxo.Checked := true;
    if Lista.Strings[laco] = CT_NOTAFISCAL then  RNotaFiscal.Checked := true;
    if Lista.Strings[laco] = CT_GAVETA then RGaveta.Checked := true;
    if Lista.Strings[laco] = CT_PRODUTO then RProduto.Checked := true;
    if Lista.Strings[laco] = CT_SERVICO then Rservico.Checked := true;
    if Lista.Strings[laco] = CT_ESTOQUE then REstoque.Checked := true;
    if Lista.Strings[laco] = CT_CUSTO then RCusto.Checked := true;
    if Lista.Strings[laco] = CT_CODIGOBARRA then RcodigoBarra.Checked := true;
    if Lista.Strings[laco] = CT_ORCAMENTOVENDA then ROrcamento.Checked := true;
    if Lista.Strings[laco] = CT_IMPDOCUMENTOS then RDocumentos.Checked := true;
    if Lista.Strings[laco] = CT_IMPORTACAOEXPORTACAO then RImpExp.Checked := true;
    if Lista.Strings[laco] = CT_SENHAGRUPO then RSenhas.Checked := true;
    if Lista.Strings[laco] = CT_MALACLIENTE then RMala.Checked := true;
    if Lista.Strings[laco] = CT_AGENDACLIENTE then RAGenda.Checked := true;
    if Lista.Strings[laco] = CT_PEDIDOVENDA then RPedido.Checked := true;
    if Lista.Strings[laco] = CT_ORDEMSERVICO then ROS.Checked := true;

  end;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Gera arquivos
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{*********************  Salva a lista de modulos ***************************** }
procedure TFConfiguracoesModulos.MODULOS_MOD(Path : string);  // modulos.mod
begin
  GeraLista;  // modulos
  reg.CriptografaLista(lista);  // criptografa modulos
  Lista.Insert(0,GeraListaModulos);  // inseri executaveis abcde...
  Lista.SaveToFile(Path);
end;

{***************** salva lista dos executaveis instalaveis ****************** }
procedure TFConfiguracoesModulos.EXE_INI(Path : string);
var
  Banco : string;
begin
  lista.Clear;
  Lista.add('[EXE]');
  if BaseDemo.Checked then
    lista.add('PRG = ABCDEFG')    // inseri todos os executaveis
  else
    lista.add('PRG = ' + GeraListaModulos);  // inseri executaveis abcde...

  banco := '';
  if BaseOficial.Checked then
    banco := 'O';
  if BaseDemo.Checked then
    Banco := Banco + 'D';

  lista.add('BANCO = ' +  banco);    // inseri O, D ou OD - oficial , Demonstracao

  lista.text := lista.text + ListaRelatorios.Text;

  Lista.SaveToFile(Path);
end;

{***************** salva lista versao oficial, demonstracao ****************** }
procedure TFConfiguracoesModulos.EXE_MOD(Path : string);
begin
  lista.Clear;
  lista.Insert(0,IntToStr(Meses.Value)); // quantidade de meses valido
  lista.Insert(1,IntToStr(RVersao.ItemIndex)); // tipo de versao do sistema odicial - oficial ou demonstracao
  reg.CriptografaLista(lista);
  Lista.SaveToFile(Path);
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          Salva Arquivos
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************* somente modulos *************************************** }
procedure TFConfiguracoesModulos.BSalvaModulosClick(Sender: TObject);
begin
  if Dsalvar.Execute then
    MODULOS_MOD(DSalvar.FileName);
end;

{******************* arquivos para instalacao ******************************* }
procedure TFConfiguracoesModulos.BitBtn4Click(Sender: TObject);
begin
  MODULOS_MOD('a:\modulos.mod');
  EXE_INI('a:\exe.ini');
  EXE_MOD('a:\exe.mod');
end;

{************************** carrega os relatorios *****************************}
procedure TFConfiguracoesModulos.BRelatoriosClick(Sender: TObject);
begin
  FConfigRelatorios := TFConfigRelatorios.CriarSDI(Application,'',true);
  ListaRelatorios := FConfigRelatorios.RetornaRelatorios;
  FConfigRelatorios.free;
end;

Initialization
 RegisterClasses([TFConfiguracoesModulos]);
end.
