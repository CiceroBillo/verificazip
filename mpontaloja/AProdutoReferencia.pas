unit AProdutoReferencia;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Componentes1, Localizacao, Buttons, ExtCtrls, PainelGradiente,
  Db, DBTables, Grids, DBGrids, Tabela, DBKeyViolation, UnProdutos, DBClient;

type
  TFReferenciaProduto = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BFechar: TBitBtn;
    Localiza: TConsultaPadrao;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    Label2: TLabel;
    ECliente: TEditLocaliza;
    GProdutos: TGridIndice;
    ProdutoReferencia: TSQL;
    ProdutoReferenciaSEQ_PRODUTO: TFMTBCDField;
    ProdutoReferenciaSEQ_REFERENCIA: TFMTBCDField;
    ProdutoReferenciaCOD_COR: TFMTBCDField;
    ProdutoReferenciaDES_REFERENCIA: TWideStringField;
    ProdutoReferenciaCOD_PRODUTO: TWideStringField;
    DataProdutoReferencia: TDataSource;
    CadProdutos: TSQL;
    ProdutoReferenciaNOM_PRODUTO: TWideStringField;
    Cor: TSQL;
    ProdutoReferenciaNom_Cor: TWideStringField;
    ProdutoReferenciaCOD_CLIENTE: TFMTBCDField;
    CadClientes: TSQL;
    ProdutoReferenciaNom_Cliente: TWideStringField;
    Label4: TLabel;
    EProduto: TEditLocaliza;
    SpeedButton2: TSpeedButton;
    Label5: TLabel;
    EConsultaProduto: TEditLocaliza;
    ECor: TEditLocaliza;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure ProdutoReferenciaBeforeInsert(DataSet: TDataSet);
    procedure ProdutoReferenciaAfterInsert(DataSet: TDataSet);
    procedure EProdutoSelect(Sender: TObject);
    procedure EProdutoRetorno(Retorno1, Retorno2: String);
    procedure EClienteRetorno(Retorno1, Retorno2: String);
    procedure GProdutosColExit(Sender: TObject);
    procedure EConsultaProdutoRetorno(Retorno1, Retorno2: String);
    procedure GProdutosColEnter(Sender: TObject);
    procedure ECorCadastrar(Sender: TObject);
    procedure ECorRetorno(Retorno1, Retorno2: String);
    procedure GProdutosEditButtonClick(Sender: TObject);
    procedure GProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ProdutoReferenciaBeforePost(DataSet: TDataSet);
    procedure ProdutoReferenciaAfterPost(DataSet: TDataSet);
    procedure GProdutosExit(Sender: TObject);
  private
    { Private declarations }
    VprSeqProduto : Integer;
    VprCodigoProdutoAtual : String;
    FunProdutos : TFuncoesProduto;
    procedure AtualizaConsulta(VpaPosicionar : Boolean);
    function ValidaProduto : Boolean;
    function DadosValidos : Boolean;
  public
    { Public declarations }
  end;

var
  FReferenciaProduto: TFReferenciaProduto;

implementation

uses APrincipal, ConstMsg, Constantes, ACores;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFReferenciaProduto.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunProdutos := TFuncoesProduto.criar(self,FPrincipal.BaseDados);
  CadClientes.Open;
  CadProdutos.Open;
  Cor.Open;
  AtualizaConsulta(false);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFReferenciaProduto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  ProdutoReferencia.close;
  CadProdutos.close;
  CadClientes.Close;
  Cor.Close;
  FunProdutos.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFReferenciaProduto.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFReferenciaProduto.AtualizaConsulta(VpaPosicionar : Boolean);
var
  VpfPosicao : TBookMark;
begin
  VpfPosicao := ProdutoReferencia.GetBookmark;
  ProdutoReferencia.close;
  ProdutoReferencia.SQL.CLEAR;
  ProdutoReferencia.sql.Add('Select * from PRODUTO_REFERENCIA'+
                            ' Where SEQ_PRODUTO = SEQ_PRODUTO');
  if ECliente.Text <> '' then
    ProdutoReferencia.Sql.Add('and COD_CLIENTE = '+ECliente.Text);
  if EProduto.Text <> '' then
    ProdutoReferencia.Sql.Add('and SEQ_PRODUTO = '+IntToStr(VprSeqProduto));
  ProdutoReferencia.Sql.Add('order by COD_CLIENTE, COD_PRODUTO');
  ProdutoReferencia.Open;

  if VpaPosicionar then
  begin
    ProdutoReferencia.GotoBookMark(VpfPosicao);
  end;
  ProdutoReferencia.FreeBookmark(VpfPosicao);
end;

{*********************** Valida o  Produto ********************************** }
function TFReferenciaProduto.ValidaProduto : Boolean;
var
  VpfSeqProduto :integer;
  VpfCodProduto, VpfNomProduto : String;
begin
  result := true;
  if ProdutoReferencia.State in [ dsedit, dsinsert ] then
  begin
    VpfCodProduto := ProdutoReferenciaCOD_PRODUTO.AsString;
    if FunProdutos.ExisteCodigoProduto(VpfSeqProduto,VpfCodProduto,VpfNomProduto) then
    begin
       ProdutoReferenciaSEQ_PRODUTO.AsInteger := VpfSeqProduto;
    end
    else
      result := EConsultaProduto.AAbreLocalizacao;
  end;
end;

{******************************************************************************}
function TFReferenciaProduto.DadosValidos : Boolean;
begin
  result := true;
  if ProdutoReferenciaSEQ_PRODUTO.AsInteger = 0 then
  begin
    aviso('PRODUTO INVÁLIDO!!!'#13'É necessário digitar um código de produto.');
    result := false;
  end
  else
    if ProdutoReferenciaDES_REFERENCIA.AsString = '' then
    begin
      aviso('REFERENCIA DO CLIENTE INVÁLIDA!!!'#13'É necessário digitar uma referencia para o cliente.');
      result := false;
    end
    else
      if not ValidaProduto then
      begin
        aviso('PRODUTO INVÁLIDO!!!'#13'É código do produto digitado não existe cadastrado');
        result := false;
      end
      else
        if ProdutoReferenciaCOD_COR.AsInteger <> 0 then
        begin
          if not FunProdutos.ExisteCor(ProdutoReferenciaCOD_COR.AsString) then
          begin
            Aviso('COR INVÁLIDA!!!'#13'A cor digitada não existe cadastrada.');
            result := false;
          end;
        end;
end;

{******************************************************************************}
procedure TFReferenciaProduto.ProdutoReferenciaBeforeInsert(
  DataSet: TDataSet);
begin
  if ECliente.Text = '' then
  begin
    aviso('FALTA ESCOLHER O CLIENTE!!!'#13'Para inserir uma referência é necessário antes escolher o cliente');
    abort;
  end;
end;

{******************************************************************************}
procedure TFReferenciaProduto.ProdutoReferenciaAfterInsert(
  DataSet: TDataSet);
begin
  ProdutoReferenciaCOD_CLIENTE.AsInteger := ECliente.AInteiro;
  GProdutos.SelectedIndex := 2;
end;

{******************************************************************************}
procedure TFReferenciaProduto.EProdutoSelect(Sender: TObject);
begin
  TEditLocaliza(Sender).ASelectValida.Text := 'Select * from CADPRODUTOS Where '+Varia.CodigoProduto + ' = ''@'' and C_ATI_PRO = ''S''';
  TEditLocaliza(Sender).ASelectLocaliza.Text := 'Select * from CADPRODUTOS Where C_NOM_PRO like  ''@%'' and C_ATI_PRO = ''S''';
end;

{******************************************************************************}
procedure TFReferenciaProduto.EProdutoRetorno(Retorno1, Retorno2: String);
begin
  VprSeqProduto := 0;
  if Retorno1 <> '' then
    VprSeqProduto := StrToInt(Retorno1);
  AtualizaConsulta(false);
end;

{******************************************************************************}
procedure TFReferenciaProduto.EClienteRetorno(Retorno1, Retorno2: String);
begin
  AtualizaConsulta(false);
end;

{******************************************************************************}
procedure TFReferenciaProduto.GProdutosColExit(Sender: TObject);
begin
  if (ProdutoReferencia.State in [dsedit,dsinsert]) then
  begin
    case GProdutos.SelectedIndex of
      2 : begin
            if (VprCodigoProdutoAtual <> ProdutoReferenciaCOD_PRODUTO.AsString) or ( ProdutoReferenciaCOD_PRODUTO.AsString = '') then
              if not ValidaProduto then
                abort;
          end;
      4 : begin
            if ProdutoReferenciaCOD_COR.AsInteger <> 0 then
              if not(FunProdutos.ExisteCor(ProdutoReferenciaCOD_COR.AsString)) then
              begin
                if not ECor.AAbreLocalizacao then
                  abort;
              end;
          end;
    end;
  end;
end;

{******************************************************************************}
procedure TFReferenciaProduto.EConsultaProdutoRetorno(Retorno1,
  Retorno2: String);
begin
  if retorno1 <> '' then
  begin
    ProdutoReferenciaSEQ_PRODUTO.AsString := Retorno1;
    ProdutoReferenciaCOD_PRODUTO.AsString := EConsultaProduto.Text;
  end;
end;

{******************************************************************************}
procedure TFReferenciaProduto.GProdutosColEnter(Sender: TObject);
begin
  VprCodigoProdutoAtual := ProdutoReferenciaCOD_PRODUTO.AsString;
end;

{******************************************************************************}
procedure TFReferenciaProduto.ECorCadastrar(Sender: TObject);
begin
  FCores := TFCores.CriarSDI(application, '', FPrincipal.VerificaPermisao('FCores'));
  FCores.BotaoCadastrar1.Click;
  FCores.showmodal;
  FCores.free;
  Localiza.AtualizaConsulta;
  Cor.Close;
  Cor.Open;
end;

{******************************************************************************}
procedure TFReferenciaProduto.ECorRetorno(Retorno1, Retorno2: String);
begin
  if (ProdutoReferencia.State in [dsedit,dsinsert]) then
  begin
    ProdutoReferenciaCOD_COR.AsInteger := ECor.AInteiro;
  end;
end;

procedure TFReferenciaProduto.GProdutosEditButtonClick(Sender: TObject);
begin
  if ProdutoReferencia.State in [dsedit,dsinsert] then
  begin
    case GProdutos.SelectedIndex of
      2 : EConsultaProduto.AAbreLocalizacao;
      4 : ECor.AAbreLocalizacao;
    end;
  end;
end;

{******************************************************************************}
procedure TFReferenciaProduto.GProdutosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 114 then
    if ProdutoReferencia.State in [dsedit,dsinsert] then
    begin
      case GProdutos.SelectedIndex of
        2 : EConsultaProduto.AAbreLocalizacao;
        4 : ECor.AAbreLocalizacao;
      end;
    end;
  if key = 46 then
  begin
    if Confirmacao(CT_DeletarItem) then
      ProdutoReferencia.Delete;
  end;
end;

{******************************************************************************}
procedure TFReferenciaProduto.ProdutoReferenciaBeforePost(
  DataSet: TDataSet);
begin
  if DadosVAlidos then
  begin
    if FunProdutos.ReferenciaProdutoDuplicada(ECliente.AInteiro,ProdutoReferenciaSEQ_PRODUTO.AsInteger,ProdutoReferenciaSEQ_REFERENCIA.AsInteger,ProdutoReferenciaCOD_COR.AsInteger) then
    begin
      aviso('REFERÊNCIA DO PRODUTO DUPLICADA!!!'#13'Já existe uma referencia cadastrada para esse produto');
      abort;
    end;
    ProdutoReferenciaSEQ_REFERENCIA.AsInteger := FunProdutos.RSeqReferenciaDisponivel(ProdutoReferenciaSEQ_PRODUTO.AsInteger,ProdutoReferenciaCOD_CLIENTE.AsInteger);
  end
  else
    abort;
end;

{******************************************************************************}
procedure TFReferenciaProduto.ProdutoReferenciaAfterPost(
  DataSet: TDataSet);
begin
  AtualizaConsulta(false);
  ProdutoReferencia.Last;
end;

procedure TFReferenciaProduto.GProdutosExit(Sender: TObject);
begin
  if ProdutoReferencia.State in [dsedit,dsinsert] then
    ProdutoReferencia.post;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFReferenciaProduto]);
end.
