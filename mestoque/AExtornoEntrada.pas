unit AExtornoEntrada;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Localizacao, Db, Constantes,
  DBTables, Buttons, Mask, DBCtrls, Tabela, Grids, DBGrids, ConstMsg,UnNotasFiscaisFor,
  unContasAPagar, DBKeyViolation, ComCtrls, numericos, UnDadosProduto, UnDAdosLocaliza, UnCrystal,
  SqlExpr, DBClient, Menus;

type
  TFExtornoEntrada = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BExcluir: TBitBtn;
    BFechar: TBitBtn;
    CadNotasFiscaisFor: TSQL;
    DataCadNotasFiscaisFor: TDataSource;
    Localiza: TConsultaPadrao;
    MovNotasfiscaisFor: TSQL;
    DataMovNotasFiscaisFor: TDataSource;
    MovNotasfiscaisForI_Seq_Not: TFMTBCDField;
    MovNotasfiscaisForC_Cod_pro: TWideStringField;
    MovNotasfiscaisForN_Qtd_Pro: TFMTBCDField;
    MovNotasfiscaisForN_Vlr_Pro: TFMTBCDField;
    MovNotasfiscaisForN_Per_Icm: TFMTBCDField;
    MovNotasfiscaisForN_Per_IPI: TFMTBCDField;
    MovNotasfiscaisForN_Tot_Pro: TFMTBCDField;
    MovNotasfiscaisForC_Cod_Cst: TWideStringField;
    MovNotasfiscaisForI_Seq_Mov: TFMTBCDField;
    MovNotasfiscaisForC_Cod_Uni: TWideStringField;
    MovNotasfiscaisForC_Nom_pro: TWideStringField;
    CadNotasFiscaisForI_Emp_Fil: TFMTBCDField;
    CadNotasFiscaisForI_Seq_Not: TFMTBCDField;
    CadNotasFiscaisForI_Nro_Not: TFMTBCDField;
    CadNotasFiscaisForC_Ser_Not: TWideStringField;
    CadNotasFiscaisForD_Dat_Emi: TSQLTimeStampField;
    CadNotasFiscaisForN_Tot_Not: TFMTBCDField;
    CadNotasFiscaisForFornecedor: TWideStringField;
    ESerie: TEditColor;
    EFornecedor: TEditLocaliza;
    EDataInicial: TCalendario;
    EDataFinal: TCalendario;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    SpeedButton1: TSpeedButton;
    Label6: TLabel;
    ENro: TEditColor;
    MovNotasfiscaisForI_Emp_Fil: TFMTBCDField;
    PainelTempo1: TPainelTempo;
    CadNotasFiscaisForD_ULT_ALT: TSQLTimeStampField;
    PanelColor3: TPanelColor;
    Splitter1: TSplitter;
    GProdutos: TDBGridColor;
    GridIndice1: TGridIndice;
    BAlterar: TBitBtn;
    BCadastrar: TBitBtn;
    BConsultar: TBitBtn;
    RBEditLocaliza1: TRBEditLocaliza;
    Label7: TLabel;
    SpeedButton2: TSpeedButton;
    Label8: TLabel;
    CadNotasFiscaisForC_IND_DEV: TWideStringField;
    BImprimir: TBitBtn;
    MovNotasfiscaisForNOMPRODUTONOTA: TWideStringField;
    MovNotasfiscaisForNOMEPRODUTO: TWideStringField;
    PopupMenu1: TPopupMenu;
    VisualizaPedidosCompra1: TMenuItem;
    N1: TMenuItem;
    ConsultaEstoqueChapa1: TMenuItem;
    CadNotasFiscaisForC_NOM_USU: TWideStringField;
    BGeraNota: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BExcluirClick(Sender: TObject);
    procedure ENroKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ENroExit(Sender: TObject);
    procedure CadNotasFiscaisForAfterScroll(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure BAlterarClick(Sender: TObject);
    procedure BCadastrarClick(Sender: TObject);
    procedure BConsultarClick(Sender: TObject);
    procedure RBEditLocaliza1Retorno(VpaColunas: TRBColunasLocaliza);
    procedure BImprimirClick(Sender: TObject);
    procedure MovNotasfiscaisForCalcFields(DataSet: TDataSet);
    procedure VisualizaPedidosCompra1Click(Sender: TObject);
    procedure ConsultaEstoqueChapa1Click(Sender: TObject);
    procedure GridIndice1DblClick(Sender: TObject);
    procedure BGeraNotaClick(Sender: TObject);
  private
    { Private declarations }
    UnNotasFiscaisFor : TFuncoesNFFor;
    FunNotaFor : TFuncoesNFFor;
    UnCP : TFuncoesContasAPagar;
    VprDNotaFor : TRBDNotaFiscalFor;
    VprOrdem : String;
    VprSeqProduto : Integer;
    procedure AtualizaConsulta(VpaGuardar : Boolean = false);
    procedure Adicionafiltros(VpaSelect : TSTrings);
    procedure PosicionaMovNota(VpaCodFilial,VpaSeqNota : String);
    procedure GeraNotaFiscal;
  public
    { Public declarations }
  end;

var
  FExtornoEntrada: TFExtornoEntrada;

implementation

uses APrincipal,funsql, FunData, ANovaNotaFiscaisFor, dmRave, APedidoCompra, AMostraEstoqueChapas,
  ANovaNotaFiscalNota, UnDados;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFExtornoEntrada.FormCreate(Sender: TObject);
begin
  FunNotaFor := TFuncoesNFFor.criar(self,FPrincipal.BaseDados);
  VprOrdem := 'order by I_Nro_Not';
  EDataInicial.DateTime := PrimeiroDiaMes(Date);
  EDataFinal.DateTime := UltimoDiaMes(Date);
  UnNotasFiscaisFor := TFuncoesNFFor.criar(self,FPrincipal.BaseDados);
  UnCP := TFuncoesContasAPagar.criar(self,FPrincipal.BaseDados);
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFExtornoEntrada.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   UnNotasFiscaisFor.Free;
   UnCP.Free;
   FechaTabela(CadNotasFiscaisFor);
   FechaTabela(MovNotasfiscaisFor);
   FunNotaFor.Free;
   Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                 eventos da consulta
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{************************** atualiza a consulta *******************************}
procedure TFExtornoEntrada.AtualizaConsulta(VpaGuardar : Boolean = false);
var
  VpfPosicao : TBookmark;
begin
  VpfPosicao := CadNotasFiscaisFor.GetBookmark;
  CadNotasFiscaisFor.Close;
  CadNotasFiscaisFor.Sql.Clear;
  CadNotasFiscaisFor.Sql.add('Select Cad.I_Emp_Fil, Cad.I_Seq_Not, Cad.I_Nro_Not, Cad.C_Ser_Not, '+
                             ' Cad.D_Dat_Emi, N_Tot_Not, Cad.D_ULT_ALT, CAD.C_IND_DEV, usu.c_nom_usu,'+
                             ' Cad.I_Cod_Cli ||''-''|| Cli.C_Nom_Cli Fornecedor'+
                             ' from CadnotaFiscaisFor CAD, CadClientes Cli, CadUsuarios usu '+
                             ' Where Cad.I_Cod_Cli = Cli.I_Cod_Cli'+
                             ' and Cad.I_cod_usu = usu.I_cod_usu'+
                             ' and cad.I_EMP_FIL = '+ IntToStr(Varia.CodigoEmpFil));
  Adicionafiltros(CadNotasFiscaisFor.Sql);
  CadNotasFiscaisFor.SQL.Add(VprOrdem);
  GridIndice1.ALinhaSQLOrderBy := CadNotasFiscaisFor.SQL.Count -1;
  CadNotasFiscaisFor.open;
  if VpaGuardar then
  begin
    try
      if not CadNotasFiscaisFor.eof then
        CadNotasFiscaisFor.GotoBookmark(vpfPosicao);
    except
      try
        CadNotasFiscaisFor.Last;
        CadNotasFiscaisFor.GotoBookmark(vpfPosicao);
      except
      end;
    end;
  end;
  CadNotasFiscaisFor.FreeBookMark(VpfPosicao);
//  CadNotasFiscaisFor.sql.savetofile('c:\notas.sql');
end;

{**************** adiciona os filtros da consulta *****************************}
procedure TFExtornoEntrada.Adicionafiltros(VpaSelect : TSTrings);
begin
  if ENro.AInteiro <> 0 then
    VpaSelect.Add(' and I_Nro_Not = ' + ENro.Text)
  else
  begin
    VpaSelect.Add('and '+ SQLTextoDataEntreAAAAMMDD('D_Dat_Emi',EDataInicial.DateTime,EDataFinal.DateTime,false));
    if ESerie.Text <> ''then
      VpaSelect.Add(' and C_Ser_Not = ''' + ESerie.Text+'''');
    if EFornecedor.Text <> '' then
      VpaSelect.Add(' And Cad.I_cod_Cli = ' + EFornecedor.Text);
    if VprSeqProduto <> 0 then
      VpaSelect.add(' and exists (Select * from MOVNOTASFISCAISFOR MOV '+
                    ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL '+
                    ' AND CAD.I_SEQ_NOT = MOV.I_SEQ_NOT ' +
                    ' AND MOV.I_SEQ_PRO = '+IntToStr(VprSeqProduto)+')');
  end;
end;

{********************* posiciona o movnotasfiscaisfor *************************}
procedure TFExtornoEntrada.PosicionaMovNota(VpaCodFilial,VpaSeqNota : String);
begin
  if VpaSeqNota <> '' then
    AdicionaSQLAbreTabela(MovNotasfiscaisFor,'Select Mov.I_Emp_Fil, Mov.I_Seq_Not, Mov.C_Cod_pro, Mov.N_Qtd_Pro,' +
                         ' Mov.N_Vlr_Pro, Mov.N_Per_Icm, Mov.N_Per_IPI, ' +
                         ' Mov.N_Tot_Pro,  Mov.C_Cod_Cst, Mov.I_Seq_Mov, Mov.C_Cod_Uni, MOV.C_NOM_PRO NOMPRODUTONOTA, '+
                         ' Pro.C_Nom_pro '+
                         ' From MovNotasFiscaisFor Mov, CadProdutos Pro '+
                         ' Where  Mov.I_Seq_pro = Pro.I_Seq_pro '+
                         ' and Mov.I_Emp_Fil = ' + VpaCodFilial+
                         ' and Mov.I_Seq_Not = '+ VpaSeqNota +
                         ' order by i_seq_Mov asc')
  else
    MovNotasfiscaisFor.close;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                             eventos dos filtros superiores
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************* filtra as tecla pressionadas *****************************}
procedure TFExtornoEntrada.ENroKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    13 : AtualizaConsulta;
  end;
end;

{***************** chama a rotina que atualiza a consulta *********************}
procedure TFExtornoEntrada.ENroExit(Sender: TObject);
begin
  AtualizaConsulta;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                 eventos diversos
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{*************** estorna a nota fiscal de entrada **************************** }
procedure TFExtornoEntrada.BExcluirClick(Sender: TObject);
var
  VpfTransacao : TTransactionDesc;
begin
   if ConfirmacaoFormato(CT_DeletarNota,[cadNotasFiscaisForI_Nro_Not.Asstring]) Then
   begin
     try
       VpfTransacao.IsolationLevel := xilREADCOMMITTED;
       FPrincipal.BaseDados.StartTransaction(VpfTransacao);
       PainelTempo1.execute('Excluindo Contas a Pagar da Nota de Entrada...');
       if UnCP.ExcluiContaNotaFiscal(  CadNotasFiscaisForI_SEQ_NOT.AsInteger ) then
       begin
         PainelTempo1.execute('Excluindo nota fiscal de entrada...');
         UnNotasFiscaisFor.EstornaNotaEntrada(CadNotasFiscaisForI_Emp_Fil.AsInteger,CadNotasFiscaisForI_SEQ_NOT.AsInteger);
         AtualizaConsulta(true);
       end;
       PainelTempo1.fecha;
       FPrincipal.BaseDados.Commit(VpfTransacao);
     except
       on e : exception do
       begin
         FPrincipal.BaseDados.Rollback(VpfTransacao);
         aviso('OCORREU UM ERRO NA EXCLUSÃO DA NOTA DE ENTRADA!!!'#13+e.message);
       end;
     end;
   end;
end;

{********************* fecha o formulario ********************************** }
procedure TFExtornoEntrada.BFecharClick(Sender: TObject);
begin
   close;
end;

{******************************************************************************}
procedure TFExtornoEntrada.BGeraNotaClick(Sender: TObject);
begin
  GeraNotaFiscal;
  AtualizaConsulta(true);
end;

{*************** posiciona o movimento de notas fiscais ***********************}
procedure TFExtornoEntrada.CadNotasFiscaisForAfterScroll(
  DataSet: TDataSet);
begin
  PosicionaMovNota(CadNotasFiscaisForI_Emp_Fil.AsString,CadNotasFiscaisForI_Seq_Not.AsString);
end;

{******************************************************************************}
procedure TFExtornoEntrada.ConsultaEstoqueChapa1Click(Sender: TObject);
begin
  if CadNotasFiscaisForI_Emp_Fil.AsInteger <> 0 then
  begin
    FMostraEstoqueChapas := TFMostraEstoqueChapas.CriarSDI(self,'',true);
    FMostraEstoqueChapas.MostraEstoqueChapasNota(CadNotasFiscaisForI_Emp_Fil.AsInteger,CadNotasFiscaisForI_Seq_Not.AsInteger);
    FMostraEstoqueChapas.Free;
  end;
end;

{******************************************************************************}
procedure TFExtornoEntrada.FormShow(Sender: TObject);
begin
end;

{******************************************************************************}
procedure TFExtornoEntrada.GeraNotaFiscal;
var
  VpfDNotaEntrada: TRBDNotaFiscalFor;
begin
  VpfDNotaEntrada := TRBDNotaFiscalFor.Cria;
  VpfDNotaEntrada.CodFilial := CadNotasFiscaisForI_Emp_Fil.AsInteger;
  VpfDNotaEntrada.SeqNota := CadNotasFiscaisForI_Seq_Not.AsInteger;
  FunNotaFor.CarDNotaFor(VpfDNotaEntrada);
  PainelTempo1.execute('Gerando Nota Fiscal...');
  FNovaNotaFiscalNota := TFNovaNotaFiscalNota.criarSDI(Application,'',FPrincipal.VerificaPermisao('FNovaNotaFiscalNota'));
  if FNovaNotaFiscalNota.GeraNotaNotaEntrada(VpfDNotaEntrada) then
    AtualizaConsulta(true);
  FNovaNotaFiscalNota.free;
  PainelTempo1.fecha;
  VpfDNotaEntrada.free;
end;

{******************************************************************************}
procedure TFExtornoEntrada.GridIndice1DblClick(Sender: TObject);
begin
  BConsultar.Click;
end;

{******************************************************************************}
procedure TFExtornoEntrada.BAlterarClick(Sender: TObject);
begin
  VprDNotaFor := TRBDNotaFiscalFor.cria;
  VprDNotaFor.CodFilial := CadNotasFiscaisForI_Emp_Fil.AsInteger;
  VprDNotaFor.SeqNota := CadNotasFiscaisForI_Seq_Not.AsInteger;
  UnNotasFiscaisFor.CarDNotaFor(VprDNotaFor);
  FNovaNotaFiscaisFor := TFNovaNotaFiscaisFor.CriarSDI(application , '', FPrincipal.VerificaPermisao('FNovaNotaFiscaisFor'));
  if FNovaNotaFiscaisFor.Alterar(VprDNotaFor) then
    AtualizaConsulta(true);
  FNovaNotaFiscaisFor.free;
end;

{******************************************************************************}
procedure TFExtornoEntrada.BCadastrarClick(Sender: TObject);
begin
  FNovaNotaFiscaisFor := TFNovaNotaFiscaisFor.CriarSDI(application , '', FPrincipal.VerificaPermisao('FNovaNotaFiscaisFor'));
  if FNovaNotaFiscaisFor.Cadastrar then
    AtualizaConsulta;
  FNovaNotaFiscaisFor.free;
end;

{******************************************************************************}
procedure TFExtornoEntrada.BConsultarClick(Sender: TObject);
begin
  FNovaNotaFiscaisFor := TFNovaNotaFiscaisFor.CriarSDI(application , '', FPrincipal.VerificaPermisao('FNovaNotaFiscaisFor'));
  FNovaNotaFiscaisFor.ConsultaNota(CadNotasFiscaisForI_Emp_Fil.AsInteger,CadNotasFiscaisForI_Seq_Not.AsInteger);
  FNovaNotaFiscaisFor.free;
end;

{******************************************************************************}
procedure TFExtornoEntrada.RBEditLocaliza1Retorno(
  VpaColunas: TRBColunasLocaliza);
begin
  if VpaColunas[2].AValorRetorno <> '' then
  begin
    VprSeqProduto := StrToInt(VpaColunas[2].AValorRetorno);
  end
  else
  begin
    VprSeqProduto := 0;
  end;
  AtualizaConsulta;
end;

procedure TFExtornoEntrada.VisualizaPedidosCompra1Click(Sender: TObject);
begin
  if CadNotasFiscaisForI_Emp_Fil.AsInteger <> 0 then
  begin
    FPedidoCompra := TFPedidoCompra.CriarSDI(self,'',true);
    FPedidoCompra.ConsultaNotaEntrada(CadNotasFiscaisForI_Emp_Fil.AsInteger,CadNotasFiscaisForI_Seq_Not.AsInteger);
    FPedidoCompra.Free;
  end;
end;

{******************************************************************************}
procedure TFExtornoEntrada.BImprimirClick(Sender: TObject);
begin
  if CadNotasFiscaisForI_Seq_Not.AsInteger <> 0 then
  begin
    dtRave := TdtRave.create(self);
    dtRave.ImprimeNotaFiscalEntrada(CadNotasFiscaisForI_Emp_Fil.AsInteger,CadNotasFiscaisForI_Seq_Not.AsInteger,true);
    dtRave.free;
  end;
end;

{******************************************************************************}
procedure TFExtornoEntrada.MovNotasfiscaisForCalcFields(DataSet: TDataSet);
begin
  if config.PermiteAlteraNomeProdutonaNotaEntrada then
    MovNotasfiscaisForNOMEPRODUTO.AsString := MovNotasfiscaisForNOMPRODUTONOTA.AsString
  else
    MovNotasfiscaisForNOMEPRODUTO.AsString := MovNotasfiscaisForC_Nom_pro.AsString;
end;

Initialization
 RegisterClasses([TFExtornoEntrada]);
end.
