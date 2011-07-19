unit ALocalizaFracaoOP;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, PainelGradiente, Grids, DBGrids, Tabela, DBKeyViolation,
  Componentes1, StdCtrls, Buttons, Localizacao, Mask, numericos, UnDadosProduto,
  Db, DBTables, UnOrdemproducao, DBClient, UnDados, UnPedidoCompra, UnProdutos;

type
  TFLocalizaFracaoOP = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    GridIndice1: TGridIndice;
    PanelColor2: TPanelColor;
    Label7: TLabel;
    Label15: TLabel;
    SpeedButton6: TSpeedButton;
    Label16: TLabel;
    ENumeroOp: Tnumerico;
    EFilial: TEditLocaliza;
    Localiza: TConsultaPadrao;
    Fracoes: TSQL;
    DataFracoes: TDataSource;
    FracoesCODFILIAL: TFMTBCDField;
    FracoesSEQORDEM: TFMTBCDField;
    FracoesSEQFRACAO: TFMTBCDField;
    FracoesINDPLANOCORTE: TWideStringField;
    FracoesC_COD_PRO: TWideStringField;
    FracoesC_NOM_PRO: TWideStringField;
    CNaoAdicionados: TCheckBox;
    BAdicionar: TBitBtn;
    FracoesSEQPRODUTO: TFMTBCDField;
    BFechar: TBitBtn;
    PPedidoCompra: TPanelColor;
    EEstagio: TRBEditLocaliza;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    SpeedButton3: TSpeedButton;
    Label4: TLabel;
    EProduto: TEditColor;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
    procedure EFilialFimConsulta(Sender: TObject);
    procedure BAdicionarClick(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure EEstagioSelect(Sender: TObject);
    procedure EProdutoExit(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure EProdutoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    VprLocalizaPedidoCompra,
    VprAcao : Boolean;
    VprOrdem : string;
    VprSeqProduto : Integer;
    VprPlanoCorte : TRBDPlanoCorteCorpo;
    VprDPedidoCorpo : TRBDPedidoCompraCorpo;
    FunPedidoCompra : TRBFunPedidoCompra;
    procedure AtualizaConsulta;
    procedure AdicionaFiltros(VpaSelect : TStrings);
    procedure ConfiguraTela;
    procedure AdicionaProdutoTerceirizacao(VpaDPedidoCorpo : TRBDPedidoCompraCorpo);
    function ExisteProduto: Boolean;
    function LocalizaProduto: Boolean;
  public
    { Public declarations }
    function LocalizaFracao(VpaDPlanoCorte : TRBDPlanoCorteCorpo):boolean;overload;
    function LocalizaFracao(VpaDPedidoCompra : TRBDPedidoCompraCorpo) : boolean;overload;
  end;

var
  FLocalizaFracaoOP: TFLocalizaFracaoOP;

implementation

uses APrincipal, FunObjeto, AAdicionaProdutosTerceirizacao, ALocalizaProdutos;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFLocalizaFracaoOP.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunPedidoCompra := TRBFunPedidoCompra.cria(FPrincipal.BaseDados);
  VprOrdem := 'order by PRO.C_COD_PRO ';
  VprAcao := false;
  VprLocalizaPedidoCompra := false;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFLocalizaFracaoOP.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunPedidoCompra.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
function TFLocalizaFracaoOP.LocalizaFracao(VpaDPedidoCompra: TRBDPedidoCompraCorpo): boolean;
begin
  VprLocalizaPedidoCompra := true;
  VprDPedidoCorpo := VpaDPedidoCompra;
  ConfiguraTela;
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
function TFLocalizaFracaoOP.LocalizaProduto: Boolean;
var
  VpfCodProduto,
  VpfNomProduto,
  VpfDesUM,
  VpfClaFiscal: String;
begin
  FlocalizaProduto :=  TFlocalizaProduto.criarSDI(Application,'',FPrincipal.VerificaPermisao('FlocalizaProduto'));
  Result:= FlocalizaProduto.LocalizaProduto(VprSeqProduto,VpfCodProduto,VpfNomProduto,VpfDesUM,VpfClaFiscal);
  FlocalizaProduto.free;
  if Result then
  begin
    EProduto.Text:= VpfCodProduto;
    Label4.Caption:= VpfNomProduto;
  end
  else
  begin
    EProduto.Text:= '';
    Label4.Caption:= '';
  end;
end;

{******************************************************************************}
procedure TFLocalizaFracaoOP.BCancelarClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
function TFLocalizaFracaoOP.LocalizaFracao(VpaDPlanoCorte : TRBDPlanoCorteCorpo):boolean;
begin
  ConfiguraTela;
  VprPlanoCorte := VpaDPlanoCorte;
  EFilial.AInteiro := VprPlanoCorte.CodFilial;
  EFilial.Atualiza;
//  ENumeroOp.AsInteger := VpaDPlanoCorte.SeqOrdemProducao;
  showmodal;
end;

{******************************************************************************}
procedure TFLocalizaFracaoOP.SpeedButton3Click(Sender: TObject);
begin
  if LocalizaProduto then
    AtualizaConsulta;
end;

{******************************************************************************}
procedure TFLocalizaFracaoOP.EEstagioSelect(Sender: TObject);
begin
  EEstagio.ASelectValida.Text := 'Select CODEST, NOMEST ' +
                            ' FROM ESTAGIOPRODUCAO '+
                            ' WHERE TIPEST = ''P'''+
                            ' AND CODEST = @ ';
  EEstagio.ASelectLocaliza.Text := 'Select CODEST, NOMEST ' +
                            ' FROM ESTAGIOPRODUCAO '+
                            ' WHERE TIPEST = ''P''';
end;

{******************************************************************************}
procedure TFLocalizaFracaoOP.AdicionaProdutoTerceirizacao(VpaDPedidoCorpo: TRBDPedidoCompraCorpo);
var
  VpfDProdutoPedido : TRBDProdutoPedidoCompra;
begin
  VpfDProdutoPedido := FunPedidoCompra.RProdutoPedidoCompra(VpaDPedidoCorpo,FracoesSEQPRODUTO.AsInteger,0,0,0);
  if VpfDProdutoPedido = nil then
  begin
    VpfDProdutoPedido := VpaDPedidoCorpo.AddProduto;
    FunProdutos.ExisteProduto(FracoesC_COD_PRO.AsString,VpfDProdutoPedido);
    VpfDProdutoPedido.QtdProduto := 0;
    VpfDProdutoPedido.QtdSolicitada := 0;
    VpfDProdutoPedido.CodCor := 0;
    VpfDProdutoPedido.NomCor := '';
    VpfDProdutoPedido.LarChapa := 0;
    VpfDProdutoPedido.ComChapa := 0;
  end;
  VpfDProdutoPedido.QtdProduto :=  VpfDProdutoPedido.QtdProduto + 1;
  VpfDProdutoPedido.QtdSolicitada :=  VpfDProdutoPedido.QtdSolicitada + 1;

  FAdicionaProdutosTerceirizacao := TFAdicionaProdutosTerceirizacao.CriarSDI(self,'',true);
  FAdicionaProdutosTerceirizacao.AdicionaProdutos(VprDPedidoCorpo,VpfDProdutoPedido,FracoesCODFILIAL.AsInteger,FracoesSEQORDEM.AsInteger,FracoesSEQFRACAO.AsInteger);
  FAdicionaProdutosTerceirizacao.Free;
  FunOrdemProducao.MarcaEstagioComoTerceirizado(FracoesCODFILIAL.AsInteger,FracoesSEQORDEM.AsInteger,FracoesSEQFRACAO.AsInteger,EEstagio.AInteiro);
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFLocalizaFracaoOP.AtualizaConsulta;
var
  VpfPosicao : TBookmark;
begin
  VpfPosicao := Fracoes.GetBookmark;
  Fracoes.close;
  Fracoes.sql.clear;
  Fracoes.sql.add('select FRA.CODFILIAL, FRA.SEQORDEM, FRA.SEQFRACAO,  INDPLANOCORTE, '+
                  ' FRA.SEQPRODUTO, '+
                  ' PRO.C_COD_PRO, PRO.C_NOM_PRO '+
                  ' from FRACAOOP FRA, CADPRODUTOS PRO '+
                  ' WHERE FRA.SEQPRODUTO = PRO.I_SEQ_PRO ');
  AdicionaFiltros(Fracoes.sql);
  Fracoes.Sql.add(VprOrdem);
  GridIndice1.ALinhaSQLOrderBy := Fracoes.SQL.count-1;
  Fracoes.open;
  try
    Fracoes.GotoBookmark(VpfPosicao);
  except
    Fracoes.Last;
    try
      Fracoes.GotoBookmark(VpfPosicao);
    except
    end;
  end;
  Fracoes.FreeBookmark(VpfPosicao);
end;

{******************************************************************************}
procedure TFLocalizaFracaoOP.AdicionaFiltros(VpaSelect : TStrings);
begin
  if EFilial.AInteiro <> 0 then
    VpaSelect.Add('and FRA.CODFILIAL = '+ EFilial.Text);
  if ENumeroOp.AsInteger <> 0 then
    VpaSelect.Add('and FRA.SEQORDEM = '+ENumeroOp.Text);
  if VprPlanoCorte <> nil then
  begin
    if VprPlanoCorte.SeqMateriaPrima <> 0 then
      VpaSelect.add(' and exists(Select FRC.CODFILIAL FROM FRACAOOPCONSUMO FRC '+
                    ' Where FRA.CODFILIAL = FRC.CODFILIAL '+
                    ' AND FRA.SEQORDEM = FRC.SEQORDEM '+
                    ' AND FRA.SEQFRACAO = FRC.SEQFRACAO '+
                    ' AND FRC.SEQPRODUTO = '+IntToStr(VprPlanoCorte.SeqMateriaPrima)+')');
  end;
  if EEstagio.AInteiro <> 0 then
  begin
    VpaSelect.Add('and exists( Select FRE.CODFILIAL FROM FRACAOOPESTAGIO FRE ' +
                    ' Where FRA.CODFILIAL = FRE.CODFILIAL '+
                    ' AND FRA.SEQORDEM = FRE.SEQORDEM '+
                    ' AND FRA.SEQFRACAO = FRE.SEQFRACAO '+
                    ' AND FRE.CODESTAGIO = '+IntToStr(EEstagio.AInteiro));
    if CNaoAdicionados.Checked then
      VpaSelect.Add(' AND FRE.INDTERCEIRIZADO = ''N''');
    VpaSelect.Add(')');
  end;
  if VprSeqProduto <> 0 then
  begin
    VpaSelect.Add(' AND FRA.SEQPRODUTO = '+IntToStr(VprSeqProduto));
  end;

  if not VprLocalizaPedidoCompra then
    if CNaoAdicionados.Checked then
      VpaSelect.add('AND FRA.INDPLANOCORTE = ''N''');
end;

{******************************************************************************}
procedure TFLocalizaFracaoOP.EFilialFimConsulta(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFLocalizaFracaoOP.EProdutoExit(Sender: TObject);
begin
  ExisteProduto;
  AtualizaConsulta;
end;

procedure TFLocalizaFracaoOP.EProdutoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    13: begin
          if ExisteProduto then
            AtualizaConsulta
          else
            if LocalizaProduto then
              AtualizaConsulta;
        end;
    114: if LocalizaProduto then
           AtualizaConsulta;
  end;
end;

{******************************************************************************}
function TFLocalizaFracaoOP.ExisteProduto: Boolean;
var
  VpfUM,
  VpfNomProduto: String;
begin
  Result:= FunProdutos.ExisteProduto(EProduto.Text,VprSeqProduto,VpfNomProduto,VpfUM);
  if Result then
    Label4.Caption:= VpfNomProduto
  else
  begin
    Label4.Caption:= '';
    if EProduto.Text <> '' then
      LocalizaProduto;
  end;
end;

{******************************************************************************}
procedure TFLocalizaFracaoOP.BAdicionarClick(Sender: TObject);
var
  VpfDFracao : TRBDPlanoCorteFracao;
begin
  if VprLocalizaPedidoCompra  then
  begin
    AdicionaProdutoTerceirizacao(VprDPedidoCorpo);
    VprAcao := true;
    AtualizaConsulta;
  end
  else
  begin
    if VprPlanoCorte <> nil then
    begin
      if FracoesSEQPRODUTO.AsInteger <> 0 then
      begin
        VpfDFracao :=  FunOrdemProducao.AdicionaFracaoPlanoCorte(VprPlanoCorte,FracoesSEQPRODUTO.AsInteger,FracoesC_COD_PRO.AsString,FracoesC_NOM_PRO.AsString);
        VpfDFracao.CodFilial := FracoesCODFILIAL.AsInteger;
        VpfDFracao.SeqOrdem := FracoesSEQORDEM.AsInteger;
        VpfDFracao.SeqFracao := FracoesSEQFRACAO.AsInteger;
        FunOrdemProducao.SetaPlanoCorteGerado(FracoesCODFILIAL.AsInteger,FracoesSEQORDEM.AsInteger,FracoesSEQFRACAO.AsInteger,true);
        AtualizaConsulta;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFLocalizaFracaoOP.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFLocalizaFracaoOP.ConfiguraTela;
begin
  AlterarVisibleDet([PPedidoCompra],VprLocalizaPedidoCompra);
  if  VprLocalizaPedidoCompra then
  begin
    PanelColor1.Height := EProduto.Top +EProduto.Height + 5 +PPedidoCompra.Height;
  end
  else
    PanelColor1.Height := EProduto.Top +EProduto.Height + 5;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFLocalizaFracaoOP]);
end.
