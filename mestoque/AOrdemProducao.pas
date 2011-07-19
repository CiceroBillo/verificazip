unit AOrdemProducao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Grids, DBGrids, Tabela, DBKeyViolation, Componentes1,
  ExtCtrls, PainelGradiente, ComCtrls, Localizacao, Db, DBTables, UnDados, UnOrdemProducao,
  Mask, numericos, UnDadosProduto, DBClient, UnRave;

type
  TFOrdemProducao = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Grade: TGridIndice;
    BCadastrar: TBitBtn;
    BConsultar: TBitBtn;
    BAlteraEstagio: TBitBtn;
    BFechar: TBitBtn;
    CPeriodo: TCheckBox;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    Label1: TLabel;
    Localiza: TConsultaPadrao;
    EEstagio: TEditLocaliza;
    SpeedButton1: TSpeedButton;
    Label2: TLabel;
    Label3: TLabel;
    OrdemProducao: TSQL;
    DataOrdemProducao: TDataSource;
    OrdemProducaoEMPFIL: TFMTBCDField;
    OrdemProducaoSEQORD: TFMTBCDField;
    OrdemProducaoDATEMI: TSQLTimeStampField;
    OrdemProducaoDATENT: TSQLTimeStampField;
    OrdemProducaoDATENP: TSQLTimeStampField;
    OrdemProducaoCODCLI: TFMTBCDField;
    OrdemProducaoCODCOM: TFMTBCDField;
    OrdemProducaoNUMPED: TFMTBCDField;
    OrdemProducaoHORPRO: TWideStringField;
    OrdemProducaoCODEST: TFMTBCDField;
    OrdemProducaoCODMAQ: TFMTBCDField;
    OrdemProducaoTIPPED: TFMTBCDField;
    OrdemProducaoC_NOM_PRO: TWideStringField;
    OrdemProducaoI_SEQ_PRO: TFMTBCDField;
    OrdemProducaoNOMEST: TWideStringField;
    OrdemProducaoProduto: TWideStringField;
    OrdemProducaoEstagio: TWideStringField;
    OrdemProducaoNOMMAQ: TWideStringField;
    OrdemProducaoQTDFIO: TFMTBCDField;
    OrdemProducaoMaquina: TWideStringField;
    Label4: TLabel;
    EPeriodoPor: TComboBoxColor;
    EPedido: Tnumerico;
    Label5: TLabel;
    EMaquina: TEditLocaliza;
    Label11: TLabel;
    SpeedButton5: TSpeedButton;
    Label12: TLabel;
    BImpOP: TBitBtn;
    Label6: TLabel;
    ENroOPCliente: Tnumerico;
    BAlterarTear: TBitBtn;
    OrdemProducaoMETTOT: TFMTBCDField;
    ENumeroOp: Tnumerico;
    Label7: TLabel;
    BAlterar: TBitBtn;
    OrdemProducaoCODPRO: TWideStringField;
    Label8: TLabel;
    EProduto: TEditLocaliza;
    SpeedButton2: TSpeedButton;
    Label9: TLabel;
    ECodSumula: Tnumerico;
    Label10: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure EEstagioFimConsulta(Sender: TObject);
    procedure OrdemProducaoCalcFields(DataSet: TDataSet);
    procedure BCadastrarClick(Sender: TObject);
    procedure BConsultarClick(Sender: TObject);
    procedure BAlteraEstagioClick(Sender: TObject);
    procedure EPeriodoPorChange(Sender: TObject);
    procedure EPedidoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BImpOPClick(Sender: TObject);
    procedure BAlterarTearClick(Sender: TObject);
    procedure BAlterarClick(Sender: TObject);
    procedure EProdutoSelect(Sender: TObject);
    procedure EProdutoRetorno(Retorno1, Retorno2: String);
  private
    { Private declarations }
    VprOrdem : String;
    VprSeqProduto : Integer;
    VprDOrdem : TRBDOrdemProducaoEtiqueta;
    FunOrdem : TRBFuncoesOrdemProducao;
    FunRave : TRBFunRave;
    procedure AtualizaConsulta(VpaPosicionar : Boolean);
  public
    { Public declarations }
  end;

var
  FOrdemProducao: TFOrdemProducao;

implementation

uses APrincipal,Constantes, ANovaOrdemProducao, AAlteraEstagioProducao, FunData, FunSql,
  AAlterarMaquina, ConstMsg;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFOrdemProducao.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunRave := TRBFunRave.cria(fPrincipal.BaseDados);
  VprOrdem := ' order by ORD.SEQORD ';
  EDatInicio.DateTime := PrimeiroDiaMes(date);
  EDatFim.DateTime := UltimoDiaMes(date);
  VprDOrdem := TRBDOrdemProducaoEtiqueta.cria;
  FunOrdem := TRBFuncoesOrdemProducao.cria(FPrincipal.BaseDados);
  EPeriodoPor.ItemIndex := 2;
  VprSeqProduto := 0;
  AtualizaConsulta(false);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFOrdemProducao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  VprDOrdem.free;
  FunOrdem.free;
  FunRave.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFOrdemProducao.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFOrdemProducao.AtualizaConsulta(VpaPosicionar : Boolean);
var
  VpfPosicao : TBookmark;
begin
  if VpaPosicionar then
    VpfPosicao := OrdemProducao.GetBookmark;
  OrdemProducao.Close;
  OrdemProducao.Sql.Clear;
  OrdemProducao.Sql.Add('Select ORD.EMPFIL, ORD.SEQORD, ORD.DATEMI, ORD.DATENT, '+
                        ' ORD.DATENP, ORD.CODCLI, ORD.CODPRO, ORD.CODCOM, '+
                        ' ORD.NUMPED, ORD.HORPRO, ORD.CODEST, ORD.CODMAQ, '+
                        ' ORD.TIPPED, ORD.METTOT, PRO.C_NOM_PRO, PRO.I_SEQ_PRO, EST.CODEST,' +
                        ' EST.NOMEST,MAQ.NOMMAQ, MAQ.QTDFIO '+
                        ' from ORDEMPRODUCAOCORPO ORD,  ESTAGIOPRODUCAO EST, '+
                        ' CADPRODUTOS PRO, MAQUINA MAQ '+
                        ' Where ORD.SEQPRO = PRO.I_SEQ_PRO '+
                        ' AND ORD.CODEST = EST.CODEST '+
                        ' AND '+SQLTextoRightJoin('ORD.CODMAQ','MAQ.CODMAQ'));
  if config.EstoqueCentralizado then
    OrdemProducao.SQl.Add('and ORD.EMPFIL = '+Inttostr(Varia.CodFilialControladoraEstoque))
  else
    OrdemProducao.SQl.Add('and ORD.EMPFIL = '+IntToStr(Varia.CodigoEmpFil));
  if ENumeroOp.AsInteger <> 0 then
    OrdemProducao.sql.Add(' and ORD.SEQORD = '+ENumeroOp.Text)
  else
    if EPedido.AsInteger <> 0 then
      OrdemProducao.SQL.Add('and NUMPED = '+EPedido.Text)
    else
    begin
      if EEstagio.AInteiro <> 0 then
        OrdemProducao.sql.Add(' and ORD.CODEST = '+EEstagio.Text);
      if CPeriodo.Checked then
        case EPeriodoPor.ItemIndex of
          0 : OrdemProducao.Sql.Add(SQLTextoDataEntreAAAAMMDD('DATENT',EDatInicio.DateTime,EDatFim.Datetime,true));
          1 : OrdemProducao.Sql.Add(SQLTextoDataEntreAAAAMMDD('DATEMI',EDatInicio.DateTime,EDatFim.Datetime,true));
          2 : OrdemProducao.Sql.Add(SQLTextoDataEntreAAAAMMDD('DATENP',EDatInicio.DateTime,EDatFim.Datetime,true));
        end;

      if ENroOPCliente.AsInteger <> 0 then
        OrdemProducao.SQL.Add('and ORDCLI = '+ENroOPCliente.Text);

      if EMaquina.AInteiro <> 0 then
        OrdemProducao.Sql.Add('and ORD.CODMAQ = '+EMaquina.Text);

      if VprSeqProduto <> 0 then
        OrdemProducao.Sql.add(' and ORD.SEQPRO = '+IntToStr(VprSeqProduto));

      if ECodSumula.AsInteger <> 0 then
        OrdemProducao.Sql.add(' and PRO.I_COD_SUM = '+ECodSumula.Text);

    end;
  OrdemProducao.SQL.Add(VprOrdem);
  OrdemProducao.Open;
  Grade.ALinhaSQLOrderBy := OrdemProducao.Sql.Count -1;
  if VpaPosicionar and not(OrdemProducao.Eof) then
  begin
    OrdemProducao.GotoBookmark(VpfPosicao);
    OrdemProducao.FreeBookmark(VpfPosicao);
  end;
end;

{******************************************************************************}
procedure TFOrdemProducao.EEstagioFimConsulta(Sender: TObject);
begin
  AtualizaConsulta(false);
end;

{******************************************************************************}
procedure TFOrdemProducao.OrdemProducaoCalcFields(DataSet: TDataSet);
begin
  OrdemProducaoProduto.AsString := OrdemProducaoCODPRO.AsString +'-'+OrdemProducaoC_NOM_PRO.AsString;
  OrdemProducaoEstagio.AsString := OrdemProducaoCODEST.AsString +'-'+OrdemProducaoNOMEST.AsString;
  OrdemProducaoMaquina.AsString := OrdemProducaoCODMAQ.AsString +'-'+ OrdemProducaoNOMMAQ.AsString;
end;

{******************************************************************************}
procedure TFOrdemProducao.BCadastrarClick(Sender: TObject);
begin
  FNovaOrdemProducao := TFNovaOrdemProducao.criarSDI(Application,'',FPrincipal.verificaPermisao(''));
  FNovaOrdemProducao.NovaOrdem;
  AtualizaConsulta(true);
end;

{******************************************************************************}
procedure TFOrdemProducao.BConsultarClick(Sender: TObject);
begin
  FNovaOrdemProducao := TFNovaOrdemProducao.criarSDI(Application,'',FPrincipal.verificaPermisao('FNovaOrdemProducao'));
  FNovaOrdemProducao.ConsultaOrdem(OrdemProducaoEMPFIL.AsInteger,OrdemProducaoSEQORD.AsInteger);
end;

{******************************************************************************}
procedure TFOrdemProducao.BAlteraEstagioClick(Sender: TObject);
begin
  FAlteraEstagioProducao := TFAlteraEstagioProducao.criarSDI(Application,'',FPrincipal.verificaPermisao('FAlteraEstagioProducao'));
  VprDOrdem.CodEmpresafilial := OrdemProducaoEMPFIL.AsInteger;
  VprDOrdem.SeqOrdem := OrdemProducaoSEQORD.AsInteger;
  FunOrdem.CarDOrdemProducao(VprDOrdem);
  if  FAlteraEstagioProducao.AlteraEstagio(VprDOrdem) then
    AtualizaConsulta(true);
  FAlteraEstagioProducao.free;
end;

{******************************************************************************}
procedure TFOrdemProducao.EPeriodoPorChange(Sender: TObject);
begin
  AtualizaConsulta(False);
end;

{******************************************************************************}
procedure TFOrdemProducao.EPedidoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    13 : AtualizaConsulta(false);
  end;
end;

{******************************************************************************}
procedure TFOrdemProducao.BImpOPClick(Sender: TObject);
begin
  VprDOrdem.CodEmpresafilial := OrdemProducaoEMPFIL.AsInteger;
  VprDOrdem.SeqOrdem := OrdemProducaoSEQORD.AsInteger;
  FunOrdem.CarDOrdemProducao(VprDOrdem);

{  FImpOrdemProducao := TFImpOrdemProducao.Create(Application);
  FImpOrdemProducao.ImprimeOP(VprDOrdem,true);
  FImpOrdemProducao.Free;}

  FunRave.ImprimeOrdemProducaoEtikArt(VprDOrdem,true);

end;

{******************************************************************************}
procedure TFOrdemProducao.BAlterarTearClick(Sender: TObject);
begin
  FAlterarMaquina := TFAlterarMaquina.criarSDI(Application,'',FPrincipal.VerificaPermisao('FAlterarMaquina'));
  VprDOrdem.CodEmpresafilial := OrdemProducaoEMPFIL.AsInteger;
  VprDOrdem.SeqOrdem := OrdemProducaoSEQORD.AsInteger;
  FunOrdem.CarDOrdemProducao(VprDOrdem);
  if FAlterarMaquina.AlteraMaquina(VprDOrdem) then
    AtualizaConsulta(true);
  FAlterarMaquina.free;
end;

{******************************************************************************}
procedure TFOrdemProducao.BAlterarClick(Sender: TObject);
begin
  FNovaOrdemProducao := TFNovaOrdemProducao.CriarSDI(application , '', FPrincipal.VerificaPermisao('FNovaOrdemProducao'));
  FNovaOrdemProducao.AlteraOrdem(OrdemProducaoEMPFIL.AsInteger,OrdemProducaoSEQORD.AsInteger);
  FNovaOrdemProducao.free;
end;

{******************************************************************************}
procedure TFOrdemProducao.EProdutoSelect(Sender: TObject);
begin
  EProduto.ASelectValida.Text := 'Select * from CADPRODUTOS Where '+Varia.CodigoProduto + ' = ''@'' and C_ATI_PRO = ''S''';
  EPRoduto.ASelectLocaliza.Text := 'Select * from CADPRODUTOS Where C_NOM_PRO like  ''@%'' and C_ATI_PRO = ''S''';
end;

{******************************************************************************}
procedure TFOrdemProducao.EProdutoRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
    VprSeqProduto := StrToInt(Retorno1)
  else
    VprSeqProduto := 0;
  AtualizaConsulta(false) ;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFOrdemProducao]);
end.
