unit AFormacaoPrecoServico;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Grids, DBGrids, Tabela, Db, DBTables, Componentes1, ExtCtrls,
  PainelGradiente, StdCtrls, Localizacao, Buttons, Mask, DBCtrls, numericos,
  ComCtrls, UnServicos, Spin, FMTBcd, SqlExpr, DBClient;

type
  TFFormacaoPrecoServico = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    CadServico: TSQL;
    DataCadProdutos: TDataSource;
    Localiza: TConsultaPadrao;
    PanelColor1: TPanelColor;
    aux: TSQLQuery;
    PanelColor3: TPanelColor;
    CAtiPro: TCheckBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    BitBtn1: TBitBtn;
    BAlterarAtividade: TBitBtn;
    BAdicionar: TBitBtn;
    TabSheet3: TTabSheet;
    BCancelar: TBitBtn;
    BConfirmar: TBitBtn;
    Label11: TLabel;
    ENovaMoeda: TEditLocaliza;
    SpeedButton5: TSpeedButton;
    Label12: TLabel;
    BitBtn7: TBitBtn;
    BitBtn11: TBitBtn;
    BitBtn12: TBitBtn;
    Label5: TLabel;
    numerico1: Tnumerico;
    RadioButton1: TRadioButton;
    Todos: TCheckBox;
    RadioButton2: TRadioButton;
    BPercentual: TBitBtn;
    BCancelarPercentual: TBitBtn;
    BConfirmarPercentual: TBitBtn;
    CSomenteSemValor: TCheckBox;
    PanelColor4: TPanelColor;
    Label8: TLabel;
    SpeedButton1: TSpeedButton;
    Label4: TLabel;
    SpeedButton2: TSpeedButton;
    Label6: TLabel;
    Label7: TLabel;
    Label1: TLabel;
    SpeedButton3: TSpeedButton;
    Label2: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    EClassificacao: TEditLocaliza;
    EMoeda: TEditLocaliza;
    ETabela: TEditLocaliza;
    ENomServico: TEditColor;
    ECodServico: TEditColor;
    grade: TDBGridColor;
    BitBtn8: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CAtiProClick(Sender: TObject);
    procedure BPercentualClick(Sender: TObject);
    procedure EMoedaRetorno(Retorno1, Retorno2: String);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure EClassificacaoSelect(Sender: TObject);
    procedure ETabelaSelect(Sender: TObject);
    procedure ETabelaRetorno(Retorno1, Retorno2: String);
    procedure gradeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn1Click(Sender: TObject);
    procedure BAlterarAtividadeClick(Sender: TObject);
    procedure BAdicionarClick(Sender: TObject);
    procedure BCancelarPercentualClick(Sender: TObject);
    procedure BConfirmarPercentualClick(Sender: TObject);
    procedure ECodServicoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure numerico1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    cifrao : string;
    Servicos : TFuncoesServico;
    VprTransacao : TTransactionDesc;
    procedure AtualizaConsulta;
    procedure AdicionaFiltros(VpaSelect : TStrings);
    procedure AtualizaDados;
    procedure AlteraPercPadrao(VpaPercentual : Double; VpaAdicionar : boolean);  // altera um percentual padrao para todos os produtos
    procedure TrocaMoeda( unidade : string);
    procedure MudaMascaraNumerico( numericos : array of TNumerico );  // na mundanca de moeda
    procedure LimpaFiltros;
    procedure MudaVisibleTab( tabs : array of TTabSheet; estado : boolean );
    procedure MudaEstadoBotoes( estado : boolean );
    procedure AbreTansacao;
    procedure ConfirmaTransacao;
    procedure CancelaTransacao;
  public
    { Public declarations }
  end;

var
  FFormacaoPrecoServico: TFFormacaoPrecoServico;

implementation

uses APrincipal, constantes, ConstMsg, AMontaKit, funsql, funstring, funObjeto;

{$R *.DFM}

{ ****************** Na cria��o do Formul�rio ******************************** }
procedure TFFormacaoPrecoServico.FormCreate(Sender: TObject);
begin
  ETabelaSelect(self);
  ETabela.Text := IntToStr(varia.TabelaPrecoServico);
  ETabela.Atualiza;
  EMoeda.Atualiza;
  cifrao := CurrencyString;
  AtualizaConsulta;
  Servicos := TFuncoesServico.Cria(Fprincipal.BaseDados);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFFormacaoPrecoServico.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if FPrincipal.BaseDados.InTransaction then
   FPrincipal.BaseDados.Rollback(VprTransacao);
 TrocaMoeda(cifrao);
 CadServico.close;
 Servicos.free;
 Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         pagina Percentual Padrao
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

///  percentual padrao para os produtos

{ ********   Adidiona Pecentual Padrao para todos os produtos ************** }
procedure TFFormacaoPrecoServico.AlteraPercPadrao(VpaPercentual : Double; VpaAdicionar : boolean);
var
  VpfPercentual : string;
  VpfPosicao : TBookmark;
begin
  if ETabela.text <> '' then
  begin

    AbreTansacao;  // inicia uma nova tansacao

    VpfPercentual := SubstituiStr(FloatToStr(VpaPercentual /100),',','.');

    LimpaSQLTabela(aux);
    AdicionaSQLTabela(aux, ' update  movtabelaprecoServico  tab' +
                           ' set tab.n_vlr_ven = tab.n_vlr_ven ' );


    if VpaAdicionar then      // caso adicionar ou subtrair
      AdicionaSQLTabela(aux,' * ')
    else
      AdicionaSQLTabela(aux,' / ');

    AdicionaSQLTabela(aux,' ( 1 + ' + VpfPercentual + ' ) ' );

    AdicionaSQLTabela(aux,' where i_cod_emp = ' + IntTostr(varia.CodigoEmpresa) +
                           ' and i_cod_tab = ' + ETabela.Text );

    if EMoeda.Text <> '' then
      AdicionaSQLTabela(aux,' and i_cod_moe = ' + EMoeda.Text );

    if Todos.Checked then
    begin
      AdicionaSQLTabela(aux, ' and i_Cod_Ser in ' +
                                ' ( select Ser.i_Cod_Ser from cadServico Ser' +
                                ' where Ser.i_cod_emp = ' + IntTostr(varia.CodigoEmpresa) );

      if EClassificacao.Text <> '' then
           AdicionaSQLTabela(aux,' and Ser.c_cod_cla like ''' +  EClassificacao.Text + '%''' );

      if CAtiPro.Checked then
        AdicionaSQLTabela(aux,' and Ser.c_ati_Ser = ''S''' );

      if ENomServico.Text <> '' Then
        AdicionaSQLTabela(aux,' and Ser.c_Nom_Ser like  '''+ ENomServico.text + '%''');

      AdicionaSQLTabela(aux,' )' );

      if EMoeda.Text <> '' then
        AdicionaSQLTabela(aux,' and Tab.I_Cod_Moe = '+ EMoeda.Text);

      if ETabela.Text <> '' then
        AdicionaSQLTabela(aux,'and Tab.I_Cod_Tab = '+ ETabela.Text );
     end
     else
       AdicionaSQLTabela(aux,' and i_Cod_Ser = ' + CadServico.fieldByName('I_COD_SER').AsString);

    if CSomenteSemValor.Checked then
      AdicionaSQLTabela(aux,' and isnull(tab.n_vlr_ven,0) = 0 ');

    aux.ExecSQL;
    VpfPosicao := CadServico.GetBookmark;
    AtualizaConsulta;
    CadServico.GotoBookmark(VpfPosicao);
    cAdServico.FreebookMark(VpfPosicao);
  end;
end;

{ ****** chamada para alterar um perceuntual padrao para todos da select ***** }
procedure TFFormacaoPrecoServico.BPercentualClick(Sender: TObject);
begin
  AlteraPercPadrao(Numerico1.AValor, RadioButton1.Checked);
end;

////   altera a moeda do produto

{ ************** calcula a alteracao da moeda ******************************** }
procedure TFFormacaoPrecoServico.BitBtn7Click(Sender: TObject);
var
  VpfPosicao : TBookmark;
begin
  if ENovaMoeda.Text <> '' then
  begin
     AbreTansacao;
     Servicos.ConverteMoedaTabela(StrToInt(ENovaMoeda.Text), StrToInt(ETabela.text),
                                  CadServico.fieldByName('I_COD_SER').AsInteger);
     VpfPosicao := CadServico.GetBookmark;
     AtualizaConsulta;
     CadServico.GotoBookMark(VpfPosicao);
     CadSErvico.FreeBookmark(VpfPosicao);
  end;
end;

procedure TFFormacaoPrecoServico.MudaVisibleTab( tabs : array of TTabSheet; estado : boolean );
var
  laco : Integer;
begin
  for laco := low(tabs) to High(tabs) do
    tabs[laco].TabVisible := estado;
end;


procedure TFFormacaoPrecoServico.MudaEstadoBotoes( estado : boolean );
begin
  if estado then
    MudaVisibleTab([TabSheet1, TabSheet2, TabSheet3], estado);
  case PageControl1.ActivePage.TabIndex of
    0 : begin MudaVisibleTab([TabSheet2, TabSheet3], estado); AlterarEnabledDet([BCancelar,BConfirmar,bitbtn8],not estado);AlterarEnabledDet([bitbtn8],estado); end;
    1 : begin MudaVisibleTab([TabSheet1, TabSheet3], estado); AlterarEnabled([BCancelarPercentual,BConfirmarPercentual,bitbtn8]); end;
    2 : begin MudaVisibleTab([TabSheet1, TabSheet2], estado); AlterarEnabled([bitbtn11,bitbtn12,bitbtn8]); end;
  end;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                 eventos da Consulta
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{************************** atualiza a consulta *******************************}
procedure TFFormacaoPrecoServico.AtualizaConsulta;
begin
  CadServico.Close;
  CadServico.sql.Clear;
  CadServico.sql.add('Select Ser.I_Cod_Ser, Ser.C_Nom_Ser, Ser.C_COD_CLA, Ser.C_Ati_Ser, '+
                     ' Tab.I_COD_EMP, Tab.I_COD_MOE, Tab.I_COD_TAB, Tab.N_VLR_VEN, ' +
                     ' Tab.N_VLR_VEN  Venda, '+
                     ' Moe.C_Nom_Moe ' +
                     ' from CadServico Ser, MovTabelaPrecoServico Tab, cadmoedas Moe '+
                     ' where Ser.i_cod_emp = ' + IntToStr(Varia.codigoEmpresa));
  AdicionaFiltros(CadServico.Sql);
  CadServico.Sql.Add(' and Ser.i_cod_emp = tab.i_cod_emp ' +
                     ' and Ser.i_Cod_ser = tab.i_cod_ser ' +
                     ' and  tab.i_cod_moe = moe.i_cod_moe ');
  CadServico.Sql.Add(' order by SEr.I_Cod_Ser ');
  GravaEstatisticaConsulta(nil,CadServico,varia.CodigoUsuario,Self.name,NomeModulo,config.UtilizarPercentualConsulta);
  CadServico.Open;
end;

{******************* adiciona os filtros da consulta **************************}
procedure TFFormacaoPrecoServico.AdicionaFiltros(VpaSelect : TStrings);
begin
  if ECodServico.Text <> '' then
    VpaSelect.add('  and Ser.I_Cod_Ser = ' + ECodServico.Text );

  if EClassificacao.Text <> '' Then
    VpaSelect.add('  and Ser.C_Cod_Cla like ''' + EClassificacao.Text + '%''' );

  if ENomServico.Text <> '' then
    VpaSelect.Add(' and Ser.C_nom_Ser like ''' + ENomServico.Text + '%''');

  if EMoeda.text <> ''  Then
    VpaSelect.add(' and Tab.I_Cod_Moe = ' + EMoeda.TExt);

  if ETabela.Text <> '' Then
    VpaSelect.add(' and Tab.I_Cod_Tab = ' + ETabela.TExt);

  if CAtiPro.Checked then
    VpaSelect.add(' and Ser.C_Ati_ser = ''S''');

  if CSomenteSemValor.Checked then
    VpaSelect.add(' and (Tab.N_Vlr_Ven is null or Tab.N_Vlr_Ven = 0)' );

end;
{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     eventos dos filtros superirores
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{*********** localiza classificacao do produto ****************************** }
procedure TFFormacaoPrecoServico.EClassificacaoSelect(Sender: TObject);
begin
   EClassificacao.ASelectValida.Clear;
   EClassificacao.ASelectValida.add( 'Select * from dba.CadClassificacao'+
                                    ' where I_Cod_Emp = ' + IntToStr(varia.CodigoEmpresa) +
                                    ' and c_Cod_Cla = ''@''' +
                                    ' and c_tip_cla = ''S''' +
                                    ' and c_Con_cla = ''S'' ' );
   EClassificacao.ASelectLocaliza.Clear;
   EClassificacao.ASelectLocaliza.add( 'Select * from dba.cadClassificacao'+
                                      ' where I_Cod_Emp = ' + IntToStr(varia.CodigoEmpresa) +
                                      ' and c_nom_Cla like ''@%'' ' +
                                      ' and c_Con_cla = ''S'' ' +
                                      ' and c_tip_cla = ''S''' +
                                      ' order by c_cod_Cla asc');
end;

{ ********* quando muda a moeda de localiza atualiza os numericos ************ }
procedure TFFormacaoPrecoServico.MudaMascaraNumerico( numericos : array of TNumerico );
var
  laco : integer;
begin
 for laco := low(numericos) to high(numericos) do
   numericos[laco].AMascara := CurrencyString + ',0.00;-' + CurrencyString + ',0.00';
end;

{********************** limpa os filtros da consulta **************************}
procedure TFFormacaoPrecoServico.LimpaFiltros;
begin
  LimpaEdits(PanelColor4);
  AtualizaLocalizas([EClassificacao,EMoeda,ETabela]);
end;

{ ************* troca de moeda *********************************************}
procedure TFFormacaoPrecoServico.TrocaMoeda( unidade : string);
begin
  CurrencyString := Unidade;
  Varia.MascaraMoeda := Unidade + ' ' + varia.MascaraValor;
end;

{ ********** permite fazer a alteracao da moeda corrente ***************** }
procedure TFFormacaoPrecoServico.EMoedaRetorno(Retorno1, Retorno2: String);
begin
  if EMoeda.Text <> '' then
  begin
    TrocaMoeda(retorno1);
    AtualizaConsulta
  end;
end;

{********** select para selecionar tabela de preco ************************** }
procedure TFFormacaoPrecoServico.ETabelaSelect(Sender: TObject);
begin
  ETabela.ASelectValida.Clear;
  ETabela.ASelectValida.Add(' select * from cadTabelaPreco ' +
                                  ' where  i_cod_tab =  @ ' +
                                  ' and i_cod_emp = ' + InttoStr( Varia.CodigoEmpresa));
  ETabela.ASelectLocaliza.Clear;
  ETabela.ASelectLocaliza.Add(' select * from cadTabelaPreco ' +
                                    ' where  c_nom_tab like ''@%'' ' +
                                    ' and i_cod_emp = ' + InttoStr( Varia.CodigoEmpresa));
end;

{ ************ retorno da tabela de preco ************************************ }
procedure TFFormacaoPrecoServico.ETabelaRetorno(Retorno1, Retorno2: String);
begin
  AtualizaConsulta;
end;

{ ************** altera  os produtos em atividade ************************** }
procedure TFFormacaoPrecoServico.CAtiProClick(Sender: TObject);
begin
  AtualizaConsulta;
end;

{********************* atualiza a consulta ***********************************}
procedure TFFormacaoPrecoServico.ECodServicoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 13 Then
    AtualizaConsulta
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                           eventos dos botoes inferirores
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{****************** fecha o formulario ************************************** }
procedure TFFormacaoPrecoServico.BitBtn8Click(Sender: TObject);
begin
  close;
end;

{******************* botao que cancela a transacao ****************************}
procedure TFFormacaoPrecoServico.BCancelarPercentualClick(Sender: TObject);
begin
  CancelaTransacao;
  AtualizaConsulta;
end;

{******************** botao que confirma a transacao **************************}
procedure TFFormacaoPrecoServico.BConfirmarPercentualClick(Sender: TObject);
begin
  ConfirmaTransacao;
end;

{*************** adiciona um novo servico na tabela de preco *****************}
procedure TFFormacaoPrecoServico.BAdicionarClick(Sender: TObject);
begin
  AbreTansacao;
  Servicos.OrganizaTabelaPreco( StrToInt(ETabela.text),confirmacao(CT_AdicionaAtividade));
  AtualizaConsulta;
end;

{**************** altera a atividade do produto ***************************** }
procedure TFFormacaoPrecoServico.BAlterarAtividadeClick(Sender: TObject);
var
  VpfPosicao : TBookmark;
begin
  AbreTansacao;
  Servicos.AlterarAtividadeServico(CadServico.FieldByName('I_Cod_Ser').Asstring,
                                   CadServico.FieldByName('C_Ati_Ser').Asstring);
  VpfPosicao := CadServico.GetBookmark;
  AtualizaConsulta;
  CadServico.GotoBookmark(VpfPosicao);
  CadServico.FreeBookmark(VpfPosicao);
end;

{******************* altera o valor da tabela de preco ************************}
procedure TFFormacaoPrecoServico.BitBtn1Click(Sender: TObject);
begin
  AbreTansacao;
  AtualizaDados;
end;

{********** atualiza valores da tabela de produto, qdade e preco ************ }
procedure TFFormacaoPrecoServico.AtualizaDados;
var
  Vpfvalor : string;
  VpfPosicao : TBookmark;
begin
  VpfPosicao := CadServico.GetBookmark;
  VpfValor := CadServico.fieldByname('N_VLR_VEN').AsString;
  if EntradaNumero( 'Novo Valor','Digite Novo Valor',Vpfvalor,false,FPrincipal.CorFoco.ACorFundoFoco,
                     FPrincipal.CorForm.ACorPainel, true) then
  begin
    Servicos.AlteraValorServico(CadServico.FieldByName('I_Cod_Ser').Asstring,ETabela.Text,VpfValor);
    AtualizaConsulta;
  end;
  CadServico.GotoBookmark(VpfPosicao);
  CadServico.FreeBookmark(VpfPosicao);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                               eventos da transa��o
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{**************************** abre a transacao ********************************}
procedure TFFormacaoPrecoServico.AbreTansacao;
begin
  if not FPrincipal.BaseDados.InTransaction then
  begin
    MudaEstadoBotoes(false);
    VprTransacao.IsolationLevel := xilREADCOMMITTED;
    FPrincipal.BaseDados.StartTransaction(VprTransacao);
  end;
end;

{************************* cancela a trasacao *********************************}
procedure TFFormacaoPrecoServico.CancelaTransacao;
begin
  if FPrincipal.BaseDados.InTransaction then
  begin
    MudaEstadoBotoes(true);
    FPrincipal.BaseDados.Rollback(VprTransacao);
  end;
end;

{************************ confirma  a transacao *******************************}
procedure TFFormacaoPrecoServico.ConfirmaTransacao;
begin
  if FPrincipal.BaseDados.InTransaction then
    if Confirmacao(CT_AlteraTabelaPreco) then
    begin
      MudaEstadoBotoes(true);
      FPrincipal.BaseDados.Commit(VprTransacao);
    end;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                 eventos diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{************* chamada do teclado para funcoes ****************************** }
procedure TFFormacaoPrecoServico.gradeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_f2 :
      begin
        BitBtn1.Click;
        abort;
      end;
    vk_f6 :
      if(PageControl1.ActivePage = TabSheet2) then
        AlteraPercPadrao(Numerico1.AValor, RadioButton1.Checked);
    vk_f7 : BAlterarAtividade.Click;
  end;
end;

{******************* altera o percetual do preco *****************************}
procedure TFFormacaoPrecoServico.numerico1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 13 Then
    BPercentual.Click;
end;

{******************** quando � pressioado alguma tecla ************************}
procedure TFFormacaoPrecoServico.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    Vk_f5 : LimpaFiltros;
  end;
end;


Initialization
 RegisterClasses([TFFormacaoPrecoServico]);
end.
