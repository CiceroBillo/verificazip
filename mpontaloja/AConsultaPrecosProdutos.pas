unit AConsultaPrecosProdutos;
{          Autor: Rafael Budag
    Data Criação: 16/04/1999;
          Função: Gerar um orçamento

    Motivo alteração:
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Localizacao, StdCtrls, Buttons, Componentes1, Db, DBTables, ExtCtrls,
  PainelGradiente,  DBGrids, Tabela, DBKeyViolation, DBCtrls,
  numericos, LabelCorMove, Parcela, BotaoCadastro,
  EditorImagem, ConvUnidade,UnCotacao, Grids, Mask, Funarquivos, FMTBcd,
  SqlExpr, DBClient;

type
  TFConsultaPrecosProdutos = class(TFormularioPermissao)
    CadProdutos: TSQL;
    Localiza: TConsultaPadrao;
    DataCadProdutos: TDataSource;
    PanelColor2: TPanelColor;
    PanelColor5: TPanelColor;
    Label3: TLabel;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    EClassificacaoProduto: TEditLocaliza;
    CProAti: TCheckBox;
    PainelFoto: TPanelColor;
    PanelColor8: TPanelColor;
    Shape1: TShape;
    VerFoto: TCheckBox;
    Esticar: TCheckBox;
    Panel5: TPanel;
    Foto: TImage;
    ECodigoProduto: TEditColor;
    Label6: TLabel;
    ENomeProduto: TEditColor;
    CadProdutosC_COD_PRO: TWideStringField;
    CadProdutosC_COD_UNI: TWideStringField;
    CadProdutosC_NOM_PRO: TWideStringField;
    CadProdutosC_ATI_PRO: TWideStringField;
    CadProdutosC_KIT_PRO: TWideStringField;
    CadProdutosL_DES_TEC: TWideStringField;
    CadProdutosC_PAT_FOT: TWideStringField;
    CadProdutosN_PER_KIT: TFMTBCDField;
    CadProdutosN_QTD_MIN: TFMTBCDField;
    CadProdutosN_QTD_PRO: TFMTBCDField;
    CadProdutosN_VLR_VEN: TFMTBCDField;
    CadProdutosVlrREal: TFMTBCDField;
    DBMemoColor2: TDBMemoColor;
    GProdutos: TGridIndice;
    BCotacao: TSpeedButton;
    BMenuFiscal: TSpeedButton;
    BKit: TSpeedButton;
    BFechar: TSpeedButton;
    Bevel1: TBevel;
    CadProdutosC_Cod_Bar: TWideStringField;
    CadProdutosC_Nom_Moe: TWideStringField;
    CadProdutosI_SEQ_PRO: TFMTBCDField;
    CadProdutosN_QTD_RES: TFMTBCDField;
    CadProdutosQTDREAL: TFMTBCDField;
    BAltera: TSpeedButton;
    PanelColor1: TPanelColor;
    ECondicao: TEditColor;
    SpeedButton2: TSpeedButton;
    LCondicao: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    EValorCondicao: TEditColor;
    Aux: TSQLQuery;
    CriaParcelas: TCriaParcelasReceber;
    SpeedButton3: TSpeedButton;
    CadProdutosN_Per_Max: TFMTBCDField;
    ECliente: TEditLocaliza;
    Label18: TLabel;
    SpeedButton7: TSpeedButton;
    Label20: TLabel;
    CadProdutosCor: TWideStringField;
    CadProdutosI_COD_COR: TFMTBCDField;
    CadProdutosC_NOM_CLA: TWideStringField;
    PFarmacia: TPanelColor;
    EPrincipioAtivo: TEditLocaliza;
    Label7: TLabel;
    SpeedButton5: TSpeedButton;
    Label8: TLabel;
    CGenericos: TCheckBox;
    CadProdutosI_PRI_ATI: TFMTBCDField;
    CadProdutosC_IND_GEN: TWideStringField;
    CadProdutosPrincipioAtivo: TWideStringField;
    CadProdutosGenerico: TWideStringField;
    Label9: TLabel;
    ESeqProduto: TEditColor;
    CadProdutosI_COD_TAM: TFMTBCDField;
    CadProdutosTAMANHO: TWideStringField;
    CadProdutosC_ARE_TRU: TWideStringField;
    CadProdutosI_DES_PRO: TFMTBCDField;
    CadProdutosINDICADORPRODUCAO: TStringField;
    CadProdutosN_RED_ICM: TFMTBCDField;
    CadProdutosC_SIT_TRI: TWideStringField;
    CadProdutosAliquotaICMS: TFloatField;
    CadProdutosC_REC_PRE: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CProAtiClick(Sender: TObject);
    procedure CadProdutosAfterScroll(DataSet: TDataSet);
    procedure EsticarClick(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure BCotacaoClick(Sender: TObject);
    procedure VerFotoClick(Sender: TObject);
    procedure BKitClick(Sender: TObject);
    procedure EClassificacaoProdutoSelect(Sender: TObject);
    procedure EClassificacaoProdutoRetorno(Retorno1, Retorno2: String);
    procedure ENomeProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GProdutosKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ECondicaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ECondicaoExit(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure ECodigoProdutoEnter(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure CadProdutosCalcFields(DataSet: TDataSet);
    procedure EPrincipioAtivoFimConsulta(Sender: TObject);
    procedure BAlteraClick(Sender: TObject);
    procedure BMenuFiscalClick(Sender: TObject);
    procedure GProdutosOrdem(Ordem: string);
    procedure GProdutosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FotoDblClick(Sender: TObject);
    procedure PanelColor8Click(Sender: TObject);
  private
    { Private declarations }
    VprTeclaPresionada : Boolean;
    VprAliquotaICMS :Double;
    VprOrdem : string;
    procedure ConfiguraPermissaoUsuario;
    procedure AtualizaConsulta;
    procedure AdicionaFiltrosProduto(VpaSelect : TStrings);
    procedure CarregaFoto;
    procedure LocalizaCondicaoPgto;
    function ExisteCondicao(VpaCondicao: Integer):Boolean;
    Function ValorProduto(VpaValor : Double):Double;
  public
    { Public declarations }
  end;

var
  FConsultaPrecosProdutos: TFConsultaPrecosProdutos;

implementation

uses APrincipal, Constantes,ConstMsg, FunObjeto,
  AProdutosKit,FunSql, ACotacao, AConsultaCondicaoPgto,
  ANovaCotacao, UnProdutos, ANovaNotaFiscalNota,
  ANovoProdutoPro, AMenuFiscalECF;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFConsultaPrecosProdutos.FormCreate(Sender: TObject);
begin
  CurrencyDecimals := varia.Decimais;
  ConfiguraPermissaoUsuario;
  VprAliquotaICMS := FunCotacao.RAliquotaICMSUF(varia.UFFilial);
  VprTeclaPresionada := false;
  if config.NaArvoreOrdenarProdutoPeloCodigo then
  begin
    VprOrdem := 'order by PRO.C_COD_PRO';
    GProdutos.AindiceInicial := 0;
  end
  else
  begin
    VprOrdem := 'order by PRO.C_NOM_PRO';
    GProdutos.AindiceInicial := 1;
  end;
  AtualizaConsulta;
  CadProdutosN_VLR_VEN.EditFormat := Varia.MascaraValor;
  CadProdutosN_VLR_VEN.DisplayFormat := Varia.MascaraValor;
  PainelFoto.Align := alBottom;
  if Config.CodigoBarras then
    ActiveControl := ECodigoProduto;
  with GProdutos.AListaCAmpos do
  begin
    Clear;
    Add(varia.CodigoProduto);
    Add('C_Nom_Pro');
    add('C_NOM_MOE');
  end;

  if not ConfigModulos.Estoque then
  begin
     GProdutos.Columns[5].Visible := false;
     GProdutos.Columns[6].Visible := false;
     GProdutos.Columns[7].Visible := false;
  end;
  if not config.EstoquePorCor then
  begin
    GProdutos.Columns[2].Visible := false;
  end;
  if not config.EstoquePorTamanho then
    GProdutos.Columns[3].Visible := false;

  if not config.Farmacia then
  begin
    PFarmacia.Visible := false;
    PanelColor5.Height := PanelColor5.Height - PFarmacia.Height;
    GProdutos.Columns[9].Visible := false;
    GProdutos.Columns[8].visible := false;
  end;

  BCotacao.Visible := ConfigModulos.OrcamentoVenda;
  SpeedButton3.Visible := ConfigModulos.NotaFiscal;
end;

procedure TFConsultaPrecosProdutos.FotoDblClick(Sender: TObject);
begin
//   VisualizadorImagem1.execute(varia.DriveFoto + CadProdutosC_PAT_FOT.AsString);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFConsultaPrecosProdutos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   CadProdutos.close;
   Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         ações da consulta do produto
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFConsultaPrecosProdutos.ConfiguraPermissaoUsuario;
begin
  if not((puAdministrador in varia.PermissoesUsuario) or (puPLCompleto in varia.PermissoesUsuario)or
         (puESCompleto in varia.PermissoesUsuario) or (puFACompleto in varia.PermissoesUsuario))then
  begin
    AlterarVisibleDet([BAltera],false);
    GProdutos.Columns[5].Visible := false;
    if (puVerPrecoVendaProduto in varia.PermissoesUsuario) then
    begin
      GProdutos.Columns[5].Visible := true;
    end;
    if (puManutencaoProdutos in Varia.PermissoesUsuario) then
      AlterarVisibleDet([BAltera],true);
  end;
  BMenuFiscal.Visible := NomeModulo = 'PDV';
end;

{****************** atualiza a consulta dos produtos **************************}
procedure TFConsultaPrecosProdutos.AtualizaConsulta;
begin
  CadProdutos.close;
  CadProdutos.sql.clear;
  CadProdutos.sql.add('Select PRO.I_SEQ_PRO,'+varia.CodigoProduto +' C_COD_PRO, C_COD_UNI,  C_NOM_PRO, ' +
                     ' C_ATI_PRO, C_KIT_PRO, L_DES_TEC, C_PAT_FOT, PRO.C_ARE_TRU, PRO.I_DES_PRO,'+
                     ' PRO.I_PRI_ATI, PRO.C_IND_GEN, PRO.C_SIT_TRI, N_RED_ICM, '+
                     ' PRO.C_REC_PRE, '+
                     ' PRO.N_PER_KIT, Qtd.C_Cod_Bar, ' +
                     ' Qtd.N_QTD_MIN, '+SqlTextoIsNull('QTD.N_QTD_PRO','0')+' N_QTD_PRO, ' +
                     SqlTextoIsNull('QTD.N_QTD_RES','0') +' N_QTD_RES, ' +
                     ' (QTD.N_QTD_PRO - '+SqlTextoIsNull('QTD.N_QTD_RES','0')+') QTDREAL,' +
                     ' PRE.N_VLR_VEN, (PRE.N_VLR_VEN * MOE.N_Vlr_Dia) VlrREal, '+
                     ' QTD.I_COD_COR, QTD.I_COD_TAM, '+
                     ' Moe.C_Nom_Moe, Pre.N_Per_Max, ' +
                     ' CLA.C_NOM_CLA '+
                     ' from CadProdutos pro, MovQdadeProduto Qtd, MovTabelaPreco Pre, '+
                     ' CadMoedas Moe, CADCLASSIFICACAO CLA');
  AdicionaFiltrosProduto(Cadprodutos.Sql);
  CadProdutos.sql.add(' and Pre.I_Cod_Tab = ' + IntToStr(Varia.TabelaPreco) +
                      ' and Qtd.I_Seq_Pro = Pro.I_Seq_Pro '+
                      ' and Pre.I_Cod_Emp = Pro.I_Cod_Emp '+
                      ' and Pre.I_Seq_Pro = Pro.I_Seq_Pro '+
                      ' and '+SQLTextoRightJoin('QTD.I_COD_COR','PRE.I_COD_COR')+
                      ' and Moe.I_Cod_Moe = Pro.I_Cod_Moe' +
                      ' AND CLA.C_TIP_CLA = ''P'''+
                      ' AND CLA.I_COD_EMP = '+IntToStr(Varia.CodigoEmpresa)+
                      ' and CLA.C_COD_CLA = PRO.C_COD_CLA');
   CadProdutos.SQL.Add(VprOrdem);
  if FPrincipal.CorFoco.AGravarConsultaSQl then
    CadProdutos.Sql.Savetofile(RetornaDiretorioCorrente+'Consulta.sql');
  GravaEstatisticaConsulta(nil,CadProdutos,varia.CodigoUsuario,Self.name,NomeModulo,config.UtilizarPercentualConsulta);
  CadProdutos.Open;
  GProdutos.ALinhaSQLOrderBy := CadProdutos.sql.count - 1;
end;

{******************* adiciona os filtros da consulta **************************}
procedure TFConsultaPrecosProdutos.AdicionaFiltrosProduto(VpaSelect : TStrings);
begin
  VpaSelect.add('Where Qtd.I_Emp_Fil = ' + inttostr(Varia.CodigoEmpFil));


  if ECodigoProduto.text <> '' Then
    VpaSelect.add(' and '+varia.CodigoProduto+ ' like ''' + ECodigoProduto.text+'''')
  else
  begin
    if ENomeProduto.text <> '' Then
      VpaSelect.Add('and Pro.C_Nom_Pro like '''+ENomeProduto.text +'%''');
    if ESeqProduto.AInteiro <> 0 Then
      VpaSelect.Add('and Pro.I_SEQ_PRO = '+ ESeqProduto.Text);
    if EClassificacaoProduto.text <> ''Then
      VpaSelect.add(' and Pro.C_Cod_Cla like '''+ EClassificacaoProduto.text+ '%''');
    if CProAti.Checked then
      VpaSelect.add(' and Pro.C_Ati_Pro = ''S''');
    if EPrincipioAtivo.AInteiro <> 0 then
      VpaSelect.Add(' and PRO.I_PRI_ATI = '+EPrincipioAtivo.Text);
    if CGenericos.Checked then
      VpaSelect.Add(' and PRO.C_IND_GEN = ''T''');
  end;
  if (puSomenteProdutos in varia.PermissoesUsuario) and (Varia.CodClassificacaoProdutos <> '') then
    VpaSelect.Add('AND CLA.C_COD_CLA like '''+Varia.CodClassificacaoProdutos+'%''')
  else
    if (puSomenteMateriaPrima in varia.PermissoesUsuario) and (Varia.CodClassificacaoMateriaPrima <> '') then
      VpaSelect.Add('AND CLA.C_COD_CLA like '''+Varia.CodClassificacaoMateriaPrima+'%''');


  VpaSelect.add(' and PRE.I_COD_CLI = '+ IntToStr(ECliente.Ainteiro));
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      Servicos dos  botoes superiores
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{********************Mostra ou esconde o painel do orçamento*******************}
procedure TFConsultaPrecosProdutos.BCotacaoClick(Sender: TObject);
begin
  FNovaCotacao := TFNovaCotacao.criarSDI(Application,'',FPrincipal.VerificaPermisao('FNovaCotacao'));
  FNovaCotacao.NovaCotacao;
  FNovaCotacao.free;
  AtualizaConsulta;
end;

{ ******************* chama o formulario para visualizar kit **************** }
procedure TFConsultaPrecosProdutos.BKitClick(Sender: TObject);
begin
   FProdutosKit := TFProdutosKit.CriarSDI(Application,'',FPrincipal.VerificaPermisao('FProdutosKit'));
   FProdutosKit.MostraKit(CadProdutosI_Seq_Pro.Asstring,Varia.CodigoEmpFil);
end;

{****************************Fecha o Formulario corrente***********************}
procedure TFConsultaPrecosProdutos.BFecharClick(Sender: TObject);
begin
   close;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                             Ações dos filtros superiores
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{****************** carrega a select do localiza classificacao ****************}
procedure TFConsultaPrecosProdutos.EClassificacaoProdutoSelect(Sender: TObject);
begin
  EClassificacaoProduto.ASelectLocaliza.text := 'Select * from CadClassificacao '+
                                                ' where c_nom_Cla like ''@%'''+
                                                ' and I_cod_emp = ' + InttoStr(Varia.CodigoEmpresa)+
                                                ' and C_Con_Cla  = ''S'''+
                                                ' and C_Tip_Cla = ''P''';
  EClassificacaoProduto.ASelectValida.text := 'Select * from CadClassificacao '+
                                                ' where C_Cod_Cla = ''@'''+
                                                ' and I_cod_emp = ' + InttoStr(Varia.CodigoEmpresa)+
                                                ' and C_Con_Cla = ''S'''+
                                                ' and C_Tip_Cla = ''P''';
  if (puSomenteProdutos in varia.PermissoesUsuario) and (Varia.CodClassificacaoProdutos <> '') then
  begin
    EClassificacaoProduto.ASelectLocaliza.text := EClassificacaoProduto.ASelectLocaliza.text +'AND C_COD_CLA like '''+Varia.CodClassificacaoProdutos+'%''';
    EClassificacaoProduto.ASelectValida.text := EClassificacaoProduto.ASelectValida.text + 'AND C_COD_CLA like '''+Varia.CodClassificacaoProdutos+'%''';
  end
  else
    if (puSomenteMateriaPrima in varia.PermissoesUsuario) and (Varia.CodClassificacaoMateriaPrima <> '') then
    begin
      EClassificacaoProduto.ASelectLocaliza.text := EClassificacaoProduto.ASelectLocaliza.text +'AND C_COD_CLA like '''+Varia.CodClassificacaoMateriaPrima+'%''';
      EClassificacaoProduto.ASelectValida.text := EClassificacaoProduto.ASelectValida.text + 'AND C_COD_CLA like '''+Varia.CodClassificacaoMateriaPrima+'%''';
    end;


end;

{**************** chama a rotina para atualizar a consulta ********************}
procedure TFConsultaPrecosProdutos.EClassificacaoProdutoRetorno(Retorno1,
  Retorno2: String);
begin
  AtualizaConsulta;
end;

{*************Chama a Rotina para atualizar a select dos produtos**************}
procedure TFConsultaPrecosProdutos.CProAtiClick(Sender: TObject);
begin
  AtualizaConsulta;
  if  config.CodigoBarras then
//    if ENomeProduto.Focused then
//    begin
//      ECodigoProduto.setfocus;
//      ECodigoProduto.SelectAll;
//    end;
end;

{**************  quando sair do campo de codigo de barra ******************* }
procedure TFConsultaPrecosProdutos.ECodigoProdutoEnter(Sender: TObject);
begin
  ECodigoProduto.SelectAll;
end;

{************ se for pressionado enter atualiza a consulta ********************}
procedure TFConsultaPrecosProdutos.ENomeProdutoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    13 :
    begin
      AtualizaConsulta;
      if TWinControl(Sender).Name = 'ECodigoProduto' then
        ECodigoProduto.SelectAll;
    end;
  end;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                 eventos da foto
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}
{********************************Mostra a Foto*********************************}
procedure TFConsultaPrecosProdutos.CarregaFoto;
begin
  try
    if (VerFoto.Checked) and (CadProdutosC_PAT_FOT.AsString <> '') then
      Foto.Picture.LoadFromFile(varia.DriveFoto + CadProdutosC_PAT_FOT.AsString)
    else
      Foto.Picture := nil;
  except
      Foto.Picture := nil;
  end;
end;

{******************* consulta a condicao de pagamento *************************}
procedure TFConsultaPrecosProdutos.LocalizaCondicaoPgto;
var
  VpfCondicao : Integer;
begin
  if Econdicao.text <> '' Then
    VpfCondicao := StrToInt(ECondicao.text)
  else
    VpfCondicao := 0;
  FConsultaCondicaoPgto := TFConsultaCondicaoPgto.create(self);
  FConsultaCondicaoPgto.VisualizaParcelas(CadProdutosVlrREal.Asfloat,VpfCondicao, false);
  FConsultaCondicaoPgto.free;
  if VpfCondicao <> 0 then
  begin
    ECondicao.text := IntTostr(VpfCondicao);
    ExisteCondicao(VpfCondicao)
  end
  else
  begin
    ECondicao.Clear;
    LCondicao.caption := '';
    EValorCondicao.text := FormatFloat(Varia.MascaraMoeda,CadProdutosVlrReal.Asfloat);
  end;
end;

procedure TFConsultaPrecosProdutos.PanelColor8Click(Sender: TObject);
begin
end;

{************** verifica se existe a condicao de pagamento ********************}
function TFConsultaPrecosProdutos.ExisteCondicao(VpaCondicao: Integer):Boolean;
begin
  AdicionaSQLAbreTabela(Aux,'Select * from CADCONDICOESPAGTO ' +
                            ' Where I_Cod_Pag = ' + IntToStr(VpaCondicao));
  result := not aux.Eof;

  if result Then
  begin
    LCondicao.caption := Aux.FieldByName('C_Nom_Pag').Asstring;
    CriaParcelas.Parcelas(CadProdutosVlrReal.AsFloat,VpaCondicao,false,Date);
    EValorCondicao.text := FormatFloat('###,###,###,##0.00',CriaParcelas.ValorTotal);
  end
  else
  begin
    LCondicao.caption := '';
    EValorcondicao.clear;
  end;
end;

{************** retorna o valor do produto na condicao de pagamento ***********}
Function TFConsultaPrecosProdutos.ValorProduto(VpaValor : Double):Double;
begin
  if ECondicao.text = '' then
    result := VpaValor
  else
  begin
    CriaParcelas.Parcelas(VpaValor,StrToInt(Econdicao.text),false,date);
    result := CriaParcelas.ValorTotal;
  end;
end;

{***************************Estica ou nao a foto*******************************}
procedure TFConsultaPrecosProdutos.EsticarClick(Sender: TObject);
begin
  Foto.Stretch := esticar.Checked;
end;

{********************Visualiza ou não a foto do produto************************}
procedure TFConsultaPrecosProdutos.VerFotoClick(Sender: TObject);
begin
  if VerFoto.Checked then
     CarregaFoto
  else
    Foto.Picture.Bitmap := nil;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            eventos diversos
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{**************************eventos do produto**********************************}
procedure TFConsultaPrecosProdutos.CadProdutosAfterScroll(
  DataSet: TDataSet);
begin
  if not VprTeclaPresionada then
  begin
    BKit.Enabled := CadProdutosC_KIT_PRO.Asstring = 'K';
    carregaFoto;
    EValorCondicao.Text := FormatFloat(CurrencyString+' ###,###,##0.00',ValorProduto(CadProdutosVlrReal.AsFloat));
  end;
end;

{*************** quando e pressionado uma tecla no grid ***********************}
procedure TFConsultaPrecosProdutos.GProdutosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if (State <> [gdSelected]) then
  begin
    if CadProdutosC_REC_PRE.AsString = 'S' then
    begin
      GProdutos.Canvas.Font.Color:= clBlue;
      GProdutos.DefaultDrawDataCell(Rect, GProdutos.columns[datacol].field, State);
    end;
    if CadProdutosC_ATI_PRO.AsString = 'N' then
    begin
      GProdutos.Canvas.Font.Color:= clred;
      GProdutos.DefaultDrawDataCell(Rect, GProdutos.columns[datacol].field, State);
    end;
  end;
end;

{******************************************************************************}
procedure TFConsultaPrecosProdutos.GProdutosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  VprTeclaPresionada := true;
end;

procedure TFConsultaPrecosProdutos.GProdutosKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  VprTeclaPresionada := false;
  if key in[37..40]  then
    CadProdutosAfterScroll(CadProdutos);
end;

procedure TFConsultaPrecosProdutos.GProdutosOrdem(Ordem: string);
begin
  VprOrdem := Ordem;
end;

{******************** localiza a condicao de pagamento ************************}
procedure TFConsultaPrecosProdutos.ECondicaoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    Vk_f3 :  LocalizaCondicaoPgto;
  end;
end;

{*************** valida a condicao de pagamento digitada **********************}
procedure TFConsultaPrecosProdutos.ECondicaoExit(Sender: TObject);
begin
  if ECondicao.text <> '' then
    if not ExisteCondicao(StrToInt(Econdicao.Text)) then
    begin
      LocalizaCondicaoPgto;
      ECondicao.SetFocus;
    end;

end;

{************** chama a rotina para localiza a condicao de pgto ***************}
procedure TFConsultaPrecosProdutos.SpeedButton2Click(Sender: TObject);
begin
  LocalizaCondicaoPgto;
end;

{********************** chama a nova nota fiscal ******************************}
procedure TFConsultaPrecosProdutos.SpeedButton3Click(Sender: TObject);
begin
  FNovaNotaFiscalNota := TFNovaNotaFiscalNota.CriarSDI(application, '',FPrincipal.VerificaPermisao('FNovaNotaFiscalNota'));
  FNovaNotaFiscalNota.NovaNotaFiscal;
  FNovaNotaFiscalNota.free;
end;

procedure TFConsultaPrecosProdutos.BMenuFiscalClick(Sender: TObject);
begin
  FMenuFiscalECF := TFMenuFiscalECF.CriarSDI(self,'',true);
  FMenuFiscalECF.ShowModal;
  FMenuFiscalECF.Free;
end;

{************************** chama o ecf ***************************************}
procedure TFConsultaPrecosProdutos.SpeedButton5Click(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFConsultaPrecosProdutos.CadProdutosCalcFields(
  DataSet: TDataSet);
begin
  if CadProdutosI_COD_COR.AsInteger <> 0 then
    CadProdutosCor.AsString := CadProdutosI_COD_COR.AsString+'-'+FunProdutos.RNomeCor(CadProdutos.FieldByName('I_COD_COR').AsString)
  else
    CadProdutosCor.Clear;
  if config.EstoquePorTamanho then
  begin
    CadProdutosTAMANHO.AsString := FunProdutos.RNomeTamanho(CadProdutosI_COD_TAM.AsInteger);
  end;

  if config.Farmacia then
  begin
    if CadProdutosC_IND_GEN.AsString = 'T' then
      CadProdutosGenerico.AsString := 'GENÉRICO'
    else
      CadProdutosGenerico.Clear;
    CadProdutosPrincipioAtivo.AsString := FunProdutos.RNomePrincipioAtivo(CadProdutosI_PRI_ATI.AsInteger);
  end;
  if CadProdutosI_DES_PRO.AsInteger in [3,4,5] then
    CadProdutosINDICADORPRODUCAO.AsString := 'P'
  else
    CadProdutosINDICADORPRODUCAO.AsString := 'T';
  if (CadProdutosC_SIT_TRI.AsString = 'T') then
  begin
    if CadProdutosN_RED_ICM.AsFloat <> 0 then
      CadProdutosAliquotaICMS.AsFloat := CadProdutosN_RED_ICM.AsFloat
    else
      CadProdutosAliquotaICMS.AsFloat := VprAliquotaICMS;
  end
  else
    CadProdutosAliquotaICMS.AsFloat := 0;
end;

{******************************************************************************}
procedure TFConsultaPrecosProdutos.EPrincipioAtivoFimConsulta(
  Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFConsultaPrecosProdutos.BAlteraClick(Sender: TObject);
begin
  FNovoProdutoPro := TFNovoProdutoPro.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoProdutoPro'));
  if FNovoProdutoPro.AlterarProduto(varia.codigoEmpresa,varia.CodigoEmpFil,CadProdutosI_SEQ_PRO.AsInteger) <> nil then
    AtualizaConsulta;
  FNovoProdutoPro.free;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFConsultaPrecosProdutos]);
end.
