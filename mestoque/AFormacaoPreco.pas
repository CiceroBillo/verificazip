unit AFormacaoPreco;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Grids, DBGrids, Tabela, Db, DBTables, Componentes1, ExtCtrls,
  PainelGradiente, StdCtrls, Localizacao, Buttons, Mask, DBCtrls, numericos,
  ComCtrls, UnProdutos, Spin, DBKeyViolation, FMTBcd, SqlExpr, DBClient,UnSistema;

type
  TFFormacaoPreco = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    CadProdutos: TSQL;
    DataCadProdutos: TDataSource;
    grade: TGridIndice;
    Localiza: TConsultaPadrao;
    PanelColor1: TPanelColor;
    PanelColor4: TPanelColor;
    Label8: TLabel;
    EClassificacao: TEditLocaliza;
    SpeedButton1: TSpeedButton;
    Label4: TLabel;
    SpeedButton2: TSpeedButton;
    ECodMoeda: TEditLocaliza;
    Label6: TLabel;
    Label7: TLabel;
    aux: TSQLQuery;
    Label1: TLabel;
    ECodTabela: TEditLocaliza;
    SpeedButton3: TSpeedButton;
    Label2: TLabel;
    PanelColor3: TPanelColor;
    CAtipro: TCheckBox;
    PageControl1: TPageControl;
    PGeral: TTabSheet;
    PPErcentuais: TTabSheet;
    BAlteraValor: TBitBtn;
    BAlterarProdutosKit: TBitBtn;
    BAlteraAtividade: TBitBtn;
    BAdicionaProdutos: TBitBtn;
    PMoeda: TTabSheet;
    BitBtn13: TBitBtn;
    BitBtn14: TBitBtn;
    Label11: TLabel;
    EditLocaliza3: TEditLocaliza;
    SpeedButton5: TSpeedButton;
    Label12: TLabel;
    BitBtn7: TBitBtn;
    BitBtn10: TBitBtn;
    BitBtn11: TBitBtn;
    BitBtn12: TBitBtn;
    Label5: TLabel;
    EPercentual: Tnumerico;
    RAdicionar: TRadioButton;
    CTodos: TCheckBox;
    RSubtrair: TRadioButton;
    BitBtn3: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    CValorVendaZero: TCheckBox;
    BAlteraValorKit: TBitBtn;
    VAlteraValorTodosKits: TBitBtn;
    CKit: TCheckBox;
    BFechar: TBitBtn;
    Label15: TLabel;
    ECliente: TEditLocaliza;
    Label18: TLabel;
    SpeedButton4: TSpeedButton;
    Label20: TLabel;
    ENomProduto: TEditColor;
    BExcluirProdutoTabela: TBitBtn;
    BAdicionarProduto: TBitBtn;
    CReajustarClientes: TCheckBox;
    Label3: TLabel;
    ECodigoProduto: TEditColor;
    BAlterarProduto: TBitBtn;
    CAbrirTransacao: TCheckBox;
    PanelColor5: TPanelColor;
    PanelColor6: TPanelColor;
    PanelColor7: TPanelColor;
    CadProdutosC_COD_PRO: TWideStringField;
    CadProdutosI_SEQ_PRO: TFMTBCDField;
    CadProdutosI_COD_EMP: TFMTBCDField;
    CadProdutosC_COD_CLA: TWideStringField;
    CadProdutosC_COD_UNI: TWideStringField;
    CadProdutosI_COD_MOE: TFMTBCDField;
    CadProdutosC_NOM_PRO: TWideStringField;
    CadProdutosC_ATI_PRO: TWideStringField;
    CadProdutosC_KIT_PRO: TWideStringField;
    CadProdutosC_BAR_FOR: TWideStringField;
    CadProdutosC_PAT_FOT: TWideStringField;
    CadProdutosI_COD_TAB: TFMTBCDField;
    CadProdutosN_PER_MAK: TFMTBCDField;
    CadProdutosI_EMP_FIL: TFMTBCDField;
    CadProdutosN_PER_MAX: TFMTBCDField;
    CadProdutosN_IND_MUL: TFMTBCDField;
    CadProdutosN_VVE_ANT: TFMTBCDField;
    CadProdutosD_ULT_ALT: TSQLTimeStampField;
    CadProdutosVENDA: TFMTBCDField;
    CadProdutosREVENDA: TFMTBCDField;
    CadProdutosCOMPRA: TFMTBCDField;
    CadProdutosCUSTO: TFMTBCDField;
    CadProdutosN_VLR_VEN: TFMTBCDField;
    CadProdutosN_VLR_REV: TFMTBCDField;
    CadProdutosN_VLR_COM: TFMTBCDField;
    CadProdutosN_VLR_CUS: TFMTBCDField;
    CadProdutosC_NOM_CLA: TWideStringField;
    CadProdutosNOMTAMANHO: TWideStringField;
    CadProdutosI_COD_TAM: TFMTBCDField;
    CadProdutosI_COD_COR: TFMTBCDField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CAtiproClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure ECodMoedaRetorno(Retorno1, Retorno2: String);
    procedure BitBtn7Click(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure BAlterarProdutosKitClick(Sender: TObject);
    procedure EClassificacaoSelect(Sender: TObject);
    procedure ECodTabelaSelect(Sender: TObject);
    procedure gradeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BAlteraValorClick(Sender: TObject);
    procedure BAlteraAtividadeClick(Sender: TObject);
    procedure BAdicionaProdutosClick(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure BAlteraValorKitClick(Sender: TObject);
    procedure VAlteraValorTodosKitsClick(Sender: TObject);
    procedure BBAjudaClick(Sender: TObject);
    procedure EClassificacaoFimConsulta(Sender: TObject);
    procedure EClienteFimConsulta(Sender: TObject);
    procedure BExcluirProdutoTabelaClick(Sender: TObject);
    procedure BAdicionarProdutoClick(Sender: TObject);
    procedure ENomProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton1Click(Sender: TObject);
    procedure gradeOrdem(Ordem: String);
    procedure ECodigoProdutoEnter(Sender: TObject);
    procedure BAlterarProdutoClick(Sender: TObject);
  private
    VprCifrao,
    VprOrdem : string;
    VprTransacao : TTransactionDesc;
    FunProduto : TFuncoesProduto;
    procedure ConfiguraPermissaoUsuario;
    procedure Atualizaconsulta(VpaPosicionar :Boolean);
    procedure AtualizaDados( coluna : Integer );
    procedure AlteraPercPadrao(VpaPercentual : Double; VpaAdicionar : boolean);
    procedure TrocaMoeda( unidade : string);
    procedure MudaVisibleTab( tabs : array of TTabSheet; estado : boolean );
    procedure MudaEstadoBotoes( estado : boolean );
    procedure AbreTansacao;
    procedure ConfirmaTransacao;
    procedure CancelaTransacao;
  public
    { Public declarations }
  end;

var
  FFormacaoPreco: TFFormacaoPreco;

implementation

uses APrincipal, constantes, ConstMsg, AMontaKit, funsql, funstring, funObjeto,
   ALocalizaProdutos, ALocalizaClassificacao,
  ANovoProdutoPro;

{$R *.DFM}

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                 acoes de inicializacoes e gerais
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{ ****************** Na criação do Formulário ******************************** }
procedure TFFormacaoPreco.FormCreate(Sender: TObject);
begin
  CadProdutosVENDA.DisplayFormat := varia.MAscaraValorUnitario;

  CurrencyDecimals := varia.Decimais;
  ConfiguraPermissaoUsuario;
  grade.Columns[0].FieldName := varia.CodigoProduto;
  PageControl1.ActivePage := PGeral;
  VprOrdem := 'order by '+varia.CodigoProduto;
  ECodTabela.Text := IntToStr(varia.TabelaPreco);
  ECodTabela.Atualiza;
  ECodMoeda.Text := IntTostr(varia.MoedaBase);
  ECodMoeda.Atualiza;
  VprCifrao := CurrencyString;
  AtualizaConsulta(false);
  FPrincipal.VerificaMoeda;
  FunProduto := TFuncoesProduto.criar(self,FPrincipal.BaseDados);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFFormacaoPreco.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if FPrincipal.BaseDados.InTransaction then
    FPrincipal.BaseDados.Rollback(VprTransacao);
  TrocaMoeda(VprCifrao);
  FechaTabela(CadProdutos);
  FunProduto.free;
  Action := CaFree;
end;
{*********** localiza classificacao do produto ****************************** }
procedure TFFormacaoPreco.EClassificacaoSelect(Sender: TObject);
begin
   EClassificacao.ASelectValida.Clear;
   EClassificacao.ASelectValida.add( 'Select * from CadClassificacao'+
                                    ' where I_Cod_Emp = ' + IntToStr(varia.CodigoEmpresa) +
                                    ' and c_Cod_Cla = ''@''' +
                                    ' and c_tip_cla = ''P''' +
                                    ' and c_Con_cla = ''S'' ' );
   EClassificacao.ASelectLocaliza.Clear;
   EClassificacao.ASelectLocaliza.add( 'Select * from cadClassificacao'+
                                      ' where I_Cod_Emp = ' + IntToStr(varia.CodigoEmpresa) +
                                      ' and c_nom_Cla like ''@%'' ' +
                                      ' and c_Con_cla = ''S'' ' +
                                      ' and c_tip_cla = ''P''' +
                                      ' order by c_cod_Cla asc');
end;


{ ************* troca de moeda *********************************************}
procedure TFFormacaoPreco.TrocaMoeda( unidade : string);
begin
  CurrencyString := Unidade;
  Varia.MascaraMoeda := Unidade + ' ' + varia.MascaraValor;
end;

{****************** fecha o formulario ************************************** }
procedure TFFormacaoPreco.BFecharClick(Sender: TObject);
begin
  close;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                 Localizacao e atualizacao dos produtos
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{ ********** permite fazer a alteracao da moeda corrente ***************** }
procedure TFFormacaoPreco.ECodMoedaRetorno(Retorno1, Retorno2: String);
begin
  if ECodMoeda.Text <> '' then
    TrocaMoeda(retorno1);
  AtualizaConsulta(true);
end;

{********** select para selecionar tabela de preco ************************** }
procedure TFFormacaoPreco.ECodTabelaSelect(Sender: TObject);
begin
  ECodTabela.ASelectValida.Clear;
  ECodTabela.ASelectValida.Add(' select * from cadTabelaPreco ' +
                                  ' where  i_cod_tab =  @ ' +
                                  ' and i_cod_emp = ' + InttoStr( Varia.CodigoEmpresa));
  ECodTabela.ASelectLocaliza.Clear;
  ECodTabela.ASelectLocaliza.Add(' select * from cadTabelaPreco ' +
                                    ' where  c_nom_tab like ''@%'' ' +
                                    ' and i_cod_emp = ' + InttoStr( Varia.CodigoEmpresa));
end;

{******************************************************************************}
procedure TFFormacaoPreco.ConfiguraPermissaoUsuario;
begin
  grade.Columns[3].Visible := config.EstoquePorTamanho;

  if not((puAdministrador in varia.PermissoesUsuario) or (puPLCompleto in varia.PermissoesUsuario)or
         (puESCompleto in varia.PermissoesUsuario) or (puFACompleto in varia.PermissoesUsuario))then
  begin
    grade.Columns[4].Visible := false;
    grade.Columns[5].Visible := false;
    grade.Columns[6].Visible := false;
    grade.Columns[7].Visible := false;
    PPErcentuais.TabVisible := false;
    if (puVerPrecoCustoProduto in varia.PermissoesUsuario) then
    begin
      grade.Columns[5].Visible := true;
      grade.Columns[6].Visible := true;
    end;
    if (puVerPrecoVendaProduto in varia.PermissoesUsuario) then
    begin
      grade.Columns[4].Visible := true;
      grade.Columns[7].Visible := true;
      PPErcentuais.TabVisible := true;
    end
  end;
end;

{******************************************************************************}
procedure TFFormacaoPreco.Atualizaconsulta(VpaPosicionar :Boolean);
var
  VpfPosicao : TBookMark;
begin
  if VpaPosicionar then
    VpfPosicao := CadProdutos.GetBookMark;
  CadProdutos.Close;
  CadProdutos.Sql.Clear;
  CadProdutos.Sql.Add(' select ' + varia.CodigoProduto + ', ' +
                            ' Tab.I_SEQ_PRO, Tab.I_COD_EMP, Pro.C_COD_CLA, Pro.C_COD_UNI, ' +
                            ' Tab.I_COD_MOE, Pro.C_NOM_PRO, Pro.C_ATI_PRO, Pro.C_KIT_PRO, ' +
                            ' Pro.C_BAR_FOR, PRO.C_PAT_FOT, '+
                            ' Tab.I_COD_TAB, Pro.N_PER_MAK, Mov.I_EMP_FIL, ' +
                            ' Tab.N_PER_MAX, Pro.N_IND_MUL, TAB.N_VVE_ANT, TAB.D_ULT_ALT,' +
//d5                            CampoNumeroFormatodecimalMoeda('Tab.N_VLR_VEN','Venda','Tab.C_CIF_MOE', true) +
//                            CampoNumeroFormatodecimalMoeda('Tab.N_VLR_REV','REVenda','Tab.C_CIF_MOE', true) +
//                            CampoNumeroFormatodecimalMoeda('Mov.N_VLR_COM','compra','Pro.C_CIF_MOE',true) +
//                            CampoNumeroFormatodecimalMoeda('Mov.N_VLR_CUS','custo','Pro.C_CIF_MOE',true) +
                            ' Tab.N_VLR_VEN Venda, ' +
                            ' Tab.N_VLR_REV REVenda, ' +
                            ' Mov.N_VLR_COM compra, ' +
                            ' Mov.N_VLR_CUS custo, ' +
                            ' Tab.N_VLR_VEN, TAB.N_VLR_REV, Mov.N_VLR_COM, Mov.N_VLR_CUS, ' +
                            ' CLA.C_NOM_CLA, TAM.NOMTAMANHO, TAB.I_COD_TAM, ' +
                            ' MOV.I_COD_COR '+
                            ' from CadProdutos pro, MovTabelaPreco tab,' +
                            ' MovQdadeProduto mov, CADCLASSIFICACAO CLA, TAMANHO TAM ' +
                            ' where pro.i_cod_emp = ' + IntTostr(varia.CodigoEmpresa) +
                            ' and pro.i_cod_emp = tab.i_cod_emp ' +
                            ' and pro.i_seq_pro = tab.i_seq_pro ' +
                            ' and pro.i_seq_pro = mov.i_seq_pro ' +
                            ' and mov.i_emp_fil = ' + IntTostr(varia.CodigoEmpFil)+
                            ' and tab.I_COD_CLI = ' + IntToStr(ECliente.AInteiro)+
                            ' and PRO.I_COD_EMP = CLA.I_COD_EMP '+
                            ' and PRO.C_COD_CLA = CLA.C_COD_CLA'+
                            ' and PRO.C_TIP_CLA = CLA.C_TIP_CLA'+
                            ' and '+SQLTextoRightJoin('TAB.I_COD_TAM','TAM.CODTAMANHO')+
                            ' AND MOV.I_COD_TAM = TAB.I_COD_TAM');
  if ECodigoProduto.text <> '' Then
    Cadprodutos.SQl.add(' and '+varia.CodigoProduto+ ' like ''' + ECodigoProduto.text+'''');

  if ENomProduto.Text <> '' then
    CadProdutos.Sql.add(' and PRO.C_NOM_PRO like '''+ENomProduto.Text+'%''');

  if EClassificacao.Text <> '' then
    CadProdutos.Sql.Add(' and pro.c_cod_cla like ''' + EClassificacao.Text + '%''');

  if ECodMoeda.Text <> '' then
    CadProdutos.Sql.Add(' and tab.I_COD_MOE = ' +ECodMoeda.Text);

  if ECodTabela.Text <> '' then
    CadProdutos.Sql.Add(' and tab.i_cod_tab = ' + ECodTabela.Text);

  if CAtiPro.Checked then
    CadProdutos.Sql.Add(' and pro.c_ati_pro = ''S''');

  if CValorVendaZero.Checked then
    CadProdutos.Sql.Add(' and isnull(tab.n_vlr_ven,0) = 0 ');

  if not CKit.Checked then
    CadProdutos.Sql.Add(' and isnull(pro.c_kit_pro,''P'') = ''P'' ');

  if (puSomenteProdutos in varia.PermissoesUsuario) and (Varia.CodClassificacaoProdutos <> '') then
    CadProdutos.Sql.Add('AND CLA.C_COD_CLA like '''+Varia.CodClassificacaoProdutos+'%''')
  else
    if (puSomenteMateriaPrima in varia.PermissoesUsuario) and (Varia.CodClassificacaoMateriaPrima <> '') then
      CadProdutos.Sql.Add('AND CLA.C_COD_CLA like '''+Varia.CodClassificacaoMateriaPrima+'%''');

  CadProdutos.Sql.Add(VprOrdem);
  grade.ALinhaSQLOrderBy := CadProdutos.Sql.Count - 1;

  GravaEstatisticaConsulta(nil,CadProdutos,varia.CodigoUsuario,Self.name,NomeModulo,config.UtilizarPercentualConsulta);
  CadProdutos.Open;
  if VpaPosicionar then
  try
    CadProdutos.GotoBookMark(VpfPosicao);
    CadProdutos.FreeBookMark(VpfPosicao);
  except
    try
      CadProdutos.Last;
      CadProdutos.GotoBookMark(VpfPosicao);
    except
    end;
  end;
//  CadProdutos.SQL.SaveToFile('preco.sql');
end;

{ ************** altera  os produtos em atividade ************************** }
procedure TFFormacaoPreco.CAtiproClick(Sender: TObject);
begin
  AtualizaConsulta(true);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         pagina Geral
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********** atualiza valores da tabela de produto, qdade e preco ************ }
procedure TFFormacaoPreco.AtualizaDados( coluna : Integer );
var
  VpfValor, VpfValorAnterior : string;
begin
  VpfValor :='VAZIO';
  if RIndiceColuna(grade,'VENDA') = coluna then
    VpfValor := CadProdutos.fieldByname('N_VLR_VEN').AsString
  else
    if RIndiceColuna(grade,'COMPRA') = coluna then
      VpfValor := CadProdutos.fieldByname('N_VLR_COM').AsString
    else
      if RIndiceColuna(grade,'CUSTO') = coluna then
        VpfValor := CadProdutos.fieldByname('N_VLR_CUS').AsString
      else
        if RIndiceColuna(grade,'REVENDA') = coluna then
          VpfValor := CadProdutos.fieldByname('N_VLR_REV').AsString
        else
          if RIndiceColuna(grade,'N_PER_MAX') = coluna then
            VpfValor := CadProdutos.fieldByname('N_PER_MAX').AsString
          else
            if RIndiceColuna(grade,'N_IND_MUL') = coluna then
              VpfValor := CadProdutos.fieldByname('N_IND_MUL').AsString;
  if coluna = 0 then
    VpfValor := CadProdutos.fieldByname('C_COD_PRO').AsString;

  if VpfValor <> 'VAZIO' then
  begin
    VpfValorAnterior:= CadProdutos.fieldByname('N_VLR_VEN').AsString;
    VpfValorAnterior := SubstituiStr( VpfValorAnterior,',','.' );

    if EntradaNumero( 'Novo Valor','Digite Novo Valor',VpfValor,false,FPrincipal.CorFoco.ACorFundoFoco,
                     FPrincipal.CorForm.ACorPainel, true) then
    begin
      VpfValor := SubstituiStr( VpfValor,',','.' );

      Aux.Sql.Clear;
      if (coluna = 0) or (RIndiceColuna(grade,'N_IND_MUL') = coluna)  then
      begin
        Aux.Sql.Add(' update CADPRODUTOS SET ');
        if coluna = 0 then
          Aux.SQl.add('C_COD_PRO = '''+VpfValor+'''')
        else
          if (RIndiceColuna(grade,'N_IND_MUL') = coluna) then
            Aux.Sql.add('n_ind_mul = ' + VpfValor );
        Aux.Sql.add(' , D_Ult_Alt = '+ SQLTextoDataAAAAMMMDD(Date) +
                     ' where i_seq_pro = ' +CadProdutos.fieldByName('I_SEQ_PRO').AsString );
      end
      else
        if (RIndiceColuna(grade,'VENDA') = coluna) or
           (RIndiceColuna(grade,'N_PER_MAX') = coluna) or
           (RIndiceColuna(grade,'REVENDA') = coluna) then
        begin
          Aux.Sql.Add(' update MOVTABELAPRECO SET ');
          if (RIndiceColuna(grade,'VENDA') = coluna) then
          begin
            Aux.Sql.Add(' N_VVE_ANT = ' + VpfValorAnterior + ',');
            Aux.Sql.Add(' n_vlr_ven = ' );
          end
          else
            if (RIndiceColuna(grade,'REVENDA') = coluna) then
              Aux.Sql.Add(' n_vlr_rev = ' )
            else
              Aux.Sql.Add(' n_per_max = ' );

          Aux.Sql.Add(VpfValor + ',D_Ult_Alt = '+ SQLTextoDataAAAAMMMDD(Date)+
                                 ' where i_cod_emp = ' + IntTostr(varia.CodigoEmpresa) +
                                 ' and i_cod_tab = ' + ECodTabela.Text +
                                 ' and i_seq_pro = ' + CadProdutos.fieldByName('I_SEQ_PRO').AsString+
                                 ' and I_COD_CLI = '+ IntToStr(ECliente.Ainteiro)+
                                 ' AND I_COD_TAM = '+CadProdutos.FieldByName('I_COD_TAM').AsString);
          Sistema.MarcaTabelaParaImportar('MOVTABELAPRECO');
        end
        else
          if (RIndiceColuna(grade,'COMPRA') = coluna) or
             (RIndiceColuna(grade,'CUSTO') = coluna) then
          begin
            Aux.Sql.Add(' update MOVQDADEPRODUTO SET ' );
            if (RIndiceColuna(grade,'COMPRA') = coluna) then
              Aux.Sql.Add(' n_vlr_com = ' )
            else
              Aux.Sql.Add(' n_vlr_cus = ' );

           Aux.Sql.Add(VpfValor + ', D_Ult_Alt = '+ SQLTextoDataAAAAMMMDD(Date) +
                                  ' where i_emp_fil = ' + IntTostr(varia.CodigoEmpFil) +
                                  ' and i_seq_pro = ' +CadProdutos.fieldByName('I_SEQ_PRO').AsString+
                                  ' AND I_COD_TAM = '+CadProdutos.FieldByName('I_COD_TAM').AsString );
           Sistema.MarcaTabelaParaImportar('MOVQDADEPRODUTO');
         end;
      aux.ExecSQL;
      AtualizaConsulta(true);
    end;
  end;
end;

{****************** atualiza Informacoes F2 ******************************** }
procedure TFFormacaoPreco.BAlteraValorClick(Sender: TObject);
begin
  AbreTansacao;
  AtualizaDados(grade.SelectedIndex);
end;

{**************** altera a atividade do produto ***************************** }
procedure TFFormacaoPreco.BAlteraAtividadeClick(Sender: TObject);
begin
  AbreTansacao;
  FunProduto.AlteraAtividadeProduto(CadProdutos.fieldByName('I_SEQ_PRO').AsInteger);
  AtualizaConsulta(true);
end;

{************* atualiza todos os dados do produto em relacao a tab de preco ** }
procedure TFFormacaoPreco.BAdicionaProdutosClick(Sender: TObject);
begin
  AbreTansacao;
  FunProduto.OrganizaTabelaPreco( ECodTabela.AInteiro,ECliente.Ainteiro,Confirmacao(CT_AdicionaAtividade));
  AtualizaConsulta(true);
end;

{ ************** permite chamar a tela de cnfiguracao de kit **************** }
procedure TFFormacaoPreco.BAlterarProdutosKitClick(Sender: TObject);
begin
  AbreTansacao;
  if Cadprodutos. fieldByName('C_KIT_PRO').AsString = 'K' then
  begin
    FMontaKit := TFMontaKit.CriarSDI(application, '', true);
//    FMontaKit.CarregaTela( Cadprodutos. fieldByName('I_SEQ_PRO').AsInteger);
  end;
end;

{**************** atualiza apenas o kit selecionado **************************}
procedure TFFormacaoPreco.BAlteraValorKitClick(Sender: TObject);
begin
  if (CadProdutos.fieldByName('c_kit_pro').AsString = 'K') and (ECodTabela.Text <> '') then
  begin
    AbreTansacao;
    FunProduto.AtualizaValorKit(CadProdutos.fieldByName('i_seq_pro').AsInteger, StrToInt(ECodTabela.text));
    AtualizaConsulta(true);
  end;
end;

{****************** atualiza todos os kit *********************************** }
procedure TFFormacaoPreco.VAlteraValorTodosKitsClick(Sender: TObject);
var
  Ponto : TBookmark;
begin
  ponto := CadProdutos.GetBookmark;
  AbreTansacao;
  CadProdutos.DisableControls;
  CadProdutos.First;
  while not CadProdutos.Eof do
  begin
    if (CadProdutos.fieldByName('c_kit_pro').AsString = 'K') and (ECodTabela.Text <> '') then
      FunProduto.AtualizaValorKit(CadProdutos.fieldByName('i_seq_pro').AsInteger, StrToInt(ECodTabela.text));
    CadProdutos.Next;
  end;
  CadProdutos.EnableControls;
  Atualizaconsulta(false);
  CadProdutos.GotoBookmark(ponto);
  CadProdutos.FreeBookmark(ponto);
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         pagina Percentuais
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

///  percentual padrao para os produtos

{ ********   Adidiona Pecentual Padrao para todos os produtos ************** }
procedure TFFormacaoPreco.AlteraPercPadrao( VpaPercentual : Double; VpaAdicionar : boolean);
begin
  AbreTansacao;  // inicia uma nova tansacao

  Aux.SQl.Clear;
  Aux.Sql.Add(' update  MOVTABELAPRECO TAB' +
              ' set tab.n_vlr_ven = TAB.N_VLR_VEN ');
  if VpaAdicionar then
    Aux.Sql.Add(' + ')
  else
    Aux.Sql.Add(' - ');

  Aux.Sql.Add('((N_VLR_VEN * ' +SubstituiStr(FloatToStr(VpaPercentual),',','.')+
                                    ')/100) ' +
              ' where i_cod_emp = ' + IntTostr(varia.CodigoEmpresa) +
              ' and i_cod_tab = ' + ECodTabela.Text);

  if not CReajustarClientes.Checked then
    Aux.Sql.Add(' AND I_COD_CLI = '+ IntToStr(ECliente.Ainteiro));

  if ECodMoeda.Text <> '' then
    AdicionaSQLTabela(aux,' and i_cod_moe = ' + ECodMoeda.Text );

   if CTodos.Checked then
   begin
       AdicionaSQLTabela(aux, ' and i_seq_pro in ' +
                              ' ( select pro.i_seq_pro from cadprodutos  pro' +
                              ' where pro.i_cod_emp = ' + IntTostr(varia.CodigoEmpresa)  );

       if EClassificacao.Text <> '' then
         AdicionaSQLTabela(aux,' and pro.c_cod_cla like ''' +  EClassificacao.Text + '%''' );

       if CAtiPro.Checked then
         AdicionaSQLTabela(aux,' and pro.c_ati_pro = ''S''' );

       AdicionaSQLTabela(aux,' )' );
   end
   else
     AdicionaSQLTabela(aux,' and i_seq_pro = ' + CadProdutos.fieldByName('I_SEQ_PRO').AsString);

  if CValorVendaZero.Checked then
    AdicionaSQLTabela(aux,' and '+SQLTextoIsNull('TAB.n_vlr_ven','0')+' = 0 ');

  aux.ExecSQL;
  AtualizaConsulta(true);
end;

{ ****** chamada para alterar um perceuntual padrao para todos da select ***** }
procedure TFFormacaoPreco.BitBtn3Click(Sender: TObject);
begin
  if ECodTabela.Text <> '' then
    AlteraPercPadrao(EPercentual.AValor, RAdicionar.Checked);
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         pagina Moedas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


////   altera a moeda do produto

{ ************** calcula a alteracao da moeda Tabela ************************ }
procedure TFFormacaoPreco.BitBtn7Click(Sender: TObject);
begin
  if EditLocaliza3.text <> '' then
  begin
     AbreTansacao;
     FunProduto.ConverteMoedaTabela( StrToInt(EditLocaliza3.text),
                                   StrToInt(ECodTabela.text), CadProdutos.fieldByName('I_SEQ_PRO').AsInteger);
     AtualizaConsulta(true);
  end;
end;

{ ************** calcula a alteracao da moeda Produto *********************** }
procedure TFFormacaoPreco.BitBtn10Click(Sender: TObject);
begin
  if EditLocaliza3.text <> '' then
  begin
    AbreTansacao;
    FunProduto.ConverteMoedaProduto( StrToInt(EditLocaliza3.text),
                                    StrToInt(ECodTabela.text), CadProdutos.fieldByName('I_SEQ_PRO').AsInteger);
    AtualizaConsulta(true);
  end;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         pagina Impressao
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         diversos
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{************* chamada do teclado para funcoes ****************************** }
procedure TFFormacaoPreco.gradeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = 113) and (PageControl1.ActivePage = PGeral) then
  begin
    BAlteraValor.Click;
    abort;
  end;
  if (key = 117) and (PageControl1.ActivePage = PPErcentuais) then
    AlteraPercPadrao(EPercentual.AValor, RAdicionar.Checked);
end;

{************** chamada para cancelar transacao ***************************** }
procedure TFFormacaoPreco.BitBtn5Click(Sender: TObject);
begin
  if confirmacao('Tem certeza que deseja cancelar as alterações de preço?') then
    CancelaTransacao;
end;

{************************** cahamada para confirmar transacao **************** }
procedure TFFormacaoPreco.BitBtn6Click(Sender: TObject);
begin
  ConfirmaTransacao;
end;

{********** configura os tab sheet ****************************************** }
procedure TFFormacaoPreco.MudaVisibleTab( tabs : array of TTabSheet; estado : boolean );
var
  laco : Integer;
begin
  for laco := low(tabs) to High(tabs) do
    tabs[laco].TabVisible := estado;
end;

{*********** configura os botoes conforme paginas *************************** }
procedure TFFormacaoPreco.MudaEstadoBotoes( estado : boolean );
begin
  if estado then
    MudaVisibleTab([PGeral, PPErcentuais, PMoeda], estado);
  case PageControl1.ActivePage.TabIndex of
    0 : begin MudaVisibleTab([PPErcentuais, PMoeda], estado); AlterarEnabled([bitbtn13,bitbtn14,BFechar]); end;
    1 : begin MudaVisibleTab([PGeral, PMoeda], estado); AlterarEnabled([bitbtn5,bitbtn6,BFechar]); end;
    2 : begin MudaVisibleTab([PGeral, PPErcentuais], estado); AlterarEnabled([bitbtn11,bitbtn12,BFechar]); end;
  end;
  ConfiguraPermissaoUsuario;
end;

{*********** abre transacao ************************************************ }
procedure TFFormacaoPreco.AbreTansacao;
begin
  if CAbrirTransacao.Checked then
  begin
    if not FPrincipal.BaseDados.InTransaction then
    begin
      MudaEstadoBotoes(false);
      CAbrirTransacao.Enabled := false;
      VprTransacao.IsolationLevel:=xilREADCOMMITTED;
      FPrincipal.BaseDados.StartTransaction(VprTransacao);
    end;
  end;
end;

{************ cancela transacao ********************************************* }
procedure TFFormacaoPreco.CancelaTransacao;
begin
  if FPrincipal.BaseDados.InTransaction then
  begin
    MudaEstadoBotoes(true);
    FPrincipal.BaseDados.Rollback(VprTransacao);
  end;
  CAbrirTransacao.Enabled := true;
  AtualizaConsulta(true);
end;

{************ confirma transacao ********************************************* }
procedure TFFormacaoPreco.ConfirmaTransacao;
begin
  if FPrincipal.BaseDados.InTransaction then
    if Confirmacao(CT_AlteraTabelaPreco) then
    begin
      MudaEstadoBotoes(true);
      FPrincipal.BaseDados.Commit(VprTransacao);
    end;
  CAbrirTransacao.Enabled := true;
  AtualizaConsulta(true);
end;


procedure TFFormacaoPreco.BBAjudaClick(Sender: TObject);
begin
end;

{******************************************************************************}
procedure TFFormacaoPreco.EClassificacaoFimConsulta(Sender: TObject);
begin
  Atualizaconsulta(true);
end;

{******************************************************************************}
procedure TFFormacaoPreco.EClienteFimConsulta(Sender: TObject);
begin
  Atualizaconsulta(true);
  BExcluirProdutoTabela.Enabled := (ECliente.AInteiro <> 0);
end;

{******************************************************************************}
procedure TFFormacaoPreco.BExcluirProdutoTabelaClick(Sender: TObject);
begin
  AbreTansacao;
  if FunProduto.ExcluiProdutoTabelaPreco(ECodTabela.Ainteiro,CadProdutos.fieldByName('I_SEQ_PRO').AsInteger,ECliente.Ainteiro) then
    AtualizaConsulta(true);
end;

{******************************************************************************}
procedure TFFormacaoPreco.BAdicionarProdutoClick(Sender: TObject);
var
   VpfCadastrou :Boolean;
   VpfSeqProduto : Integer;
   VpfCodProduto, VpfNomProduto : String;
begin
  FlocalizaProduto := TFlocalizaProduto.criarSDI(Application,'',FPrincipal.VerificaPermisao('FlocalizaProduto'));
  if FlocalizaProduto.LocalizaProduto(vpfCadastrou,VpfSeqProduto,VpfCodProduto,VpfNomProduto) then
  begin
    FunProduto.InserePrecoProdutoCliente(VpfSeqProduto,ECodTabela.Ainteiro,ECliente.Ainteiro,0,0);
    AtualizaConsulta(true);
  end;
  FlocalizaProduto.free;

end;

{******************************************************************************}
procedure TFFormacaoPreco.ENomProdutoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    13 :
    begin
      AtualizaConsulta(false);
      if TWinControl(Sender).Name = 'ECodigoProduto' then
        ECodigoProduto.SelectAll;
    end;
  end;
end;

procedure TFFormacaoPreco.SpeedButton1Click(Sender: TObject);
var
  VpfCodcla, VpfNomeCla : string;
begin
  FLocalizaClassificacao := TFLocalizaClassificacao.CriarSDI(application,'', true);
  if FLocalizaClassificacao.LocalizaClassificacao(VpfCodCla,VpfNomeCla, 'P') then
  begin
    EClassificacao.Text := VpfCodCla;
    label4. Caption := Vpfnomecla;
    AtualizaConsulta(false);
  end;

end;

procedure TFFormacaoPreco.gradeOrdem(Ordem: String);
begin
  VprOrdem := Ordem;
end;

procedure TFFormacaoPreco.ECodigoProdutoEnter(Sender: TObject);
begin
  ECodigoProduto.SelectAll;
end;

{******************************************************************************}
procedure TFFormacaoPreco.BAlterarProdutoClick(Sender: TObject);
begin
  FNovoProdutoPro := TFNovoProdutoPro.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoProdutoPro'));
  if FNovoProdutoPro.AlterarProduto(varia.codigoEmpresa,varia.CodigoEmpFil,CadProdutos.FieldByName('I_SEQ_PRO').AsInteger) <> nil then
    Atualizaconsulta(true);
  FNovoProdutoPro.free;
end;

Initialization
 RegisterClasses([TFFormacaoPreco]);
end.
