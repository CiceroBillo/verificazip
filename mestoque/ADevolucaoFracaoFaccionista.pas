unit ADevolucaoFracaoFaccionista;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Grids, DBGrids, Tabela, DBKeyViolation, Componentes1, ExtCtrls,
  PainelGradiente, Db, DBTables, StdCtrls, DBCtrls, ComCtrls, Localizacao,
  Buttons, UnOrdemProducao, DBClient;

type
  TFDevolucaoFracaoFaccionista = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    DevolucaoFracao: TSQL;
    DataDevolucaoFracao: TDataSource;
    DevolucaoFracaoSEQDEVOLUCAO: TFMTBCDField;
    DevolucaoFracaoDATREAL: TSQLTimeStampField;
    DevolucaoFracaoQTDDEVOLVIDO: TFMTBCDField;
    DevolucaoFracaoDATRETORNO: TSQLTimeStampField;
    DevolucaoFracaoDATCADASTRO: TSQLTimeStampField;
    DevolucaoFracaoCODFILIAL: TFMTBCDField;
    DevolucaoFracaoSEQORDEM: TFMTBCDField;
    DevolucaoFracaoSEQFRACAO: TFMTBCDField;
    DevolucaoFracaoSEQESTAGIO: TFMTBCDField;
    DevolucaoFracaoQTDENVIADO: TFMTBCDField;
    DevolucaoFracaoDESUM: TWideStringField;
    DevolucaoFracaoCODFACCIONISTA: TFMTBCDField;
    DevolucaoFracaoSEQITEM: TFMTBCDField;
    DevolucaoFracaoNOMFACCIONISTA: TWideStringField;
    DevolucaoFracaoC_NOM_PRO: TWideStringField;
    DevolucaoFracaoNOM_COR: TWideStringField;
    DevolucaoFracaoDiasDevolucao: TFMTBCDField;
    DevolucaoFracaoCODMOTIVO: TFMTBCDField;
    DevolucaoFracaoDESMOTIVO: TWideStringField;
    DevolucaoFracaoTipoMotivo: TWideStringField;
    Localiza: TConsultaPadrao;
    Label9: TLabel;
    SpeedButton5: TSpeedButton;
    Label10: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label8: TLabel;
    SpeedButton2: TSpeedButton;
    Label5: TLabel;
    Label7: TLabel;
    SpeedButton4: TSpeedButton;
    Label6: TLabel;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    Label11: TLabel;
    Label12: TLabel;
    SpeedButton3: TSpeedButton;
    Label13: TLabel;
    Label14: TLabel;
    SpeedButton6: TSpeedButton;
    Label15: TLabel;
    Label16: TLabel;
    SpeedButton7: TSpeedButton;
    Label17: TLabel;
    EFaccionista: TEditLocaliza;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    ETipoPeriodo: TComboBoxColor;
    CPeriodo: TCheckBox;
    EProduto: TEditLocaliza;
    EIDEstagio: TEditLocaliza;
    ECombinacao: TEditLocaliza;
    EFilial: TEditLocaliza;
    EOrdemProducao: TEditLocaliza;
    EFracao: TEditLocaliza;
    PanelColor3: TPanelColor;
    DBMemoColor1: TDBMemoColor;
    GridIndice1: TGridIndice;
    BCadastrar: TBitBtn;
    BExcluir: TBitBtn;
    BFechar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DevolucaoFracaoCalcFields(DataSet: TDataSet);
    procedure EDatInicioCloseUp(Sender: TObject);
    procedure EOrdemProducaoSelect(Sender: TObject);
    procedure EFracaoSelect(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure BCadastrarClick(Sender: TObject);
    procedure BExcluirClick(Sender: TObject);
    procedure EProdutoRetorno(Retorno1, Retorno2: String);
  private
    { Private declarations }
    VprSeqProduto : Integer;
    FunOrdemProducao : TRBFuncoesOrdemProducao;
    procedure AtualizaConsulta;
    procedure AdicionaFiltro(VpaConsulta : TStrings);
  public
    { Public declarations }
  end;

var
  FDevolucaoFracaoFaccionista: TFDevolucaoFracaoFaccionista;

implementation

uses APrincipal, fundata, FunSql, ANovaFracaoFaccionista, Constmsg;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFDevolucaoFracaoFaccionista.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunOrdemProducao := TRBFuncoesOrdemProducao.cria(FPrincipal.BaseDados);
  VprSeqProduto := 0;
  EDatInicio.DateTime := date;
  EDatFim.DateTime := date;
  ETipoPeriodo.ItemIndex := 0;
  AtualizaConsulta;
End;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFDevolucaoFracaoFaccionista.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  DevolucaoFracao.close;
  FunOrdemProducao.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
procedure TFDevolucaoFracaoFaccionista.AtualizaConsulta;
begin
  DevolucaoFracao.Close;
  DevolucaoFracao.sql.clear;
  DevolucaoFracao.sql.add('select DFF.SEQDEVOLUCAO, DFF.DATCADASTRO DATREAL, DFF.QTDDEVOLVIDO,  FRF.DATRETORNO, '+
                          ' DFF.CODMOTIVO, DFF.DESMOTIVO, '+
                          ' FRF.DATCADASTRO, FRF.CODFILIAL, FRF.SEQORDEM,FRF.SEQFRACAO, FRF.SEQESTAGIO, FRF.QTDENVIADO, '+
                          ' FRF.DESUM, FRF.CODFACCIONISTA, FRF.SEQITEM, '+
                          ' FAC.NOMFACCIONISTA, '+
                          ' PRO.C_NOM_PRO, '+
                          ' COR.NOM_COR '+
                          ' from DEVOLUCAOFRACAOOPFACCIONISTA DFF, FRACAOOPFACCIONISTA FRF, FACCIONISTA FAC, ORDEMPRODUCAOCORPO ORD, '+
                          ' CADPRODUTOS PRO, COR '+
                          ' Where DFF.CODFACCIONISTA = FRF.CODFACCIONISTA '+
                          ' AND DFF.SEQITEM = FRF.SEQITEM '+
                          ' AND FRF.CODFACCIONISTA = FAC.CODFACCIONISTA '+
                          ' AND FRF.CODFILIAL = ORD.EMPFIL '+
                          ' AND FRF.SEQORDEM = ORD.SEQORD '+
                          ' AND ORD.SEQPRO = PRO.I_SEQ_PRO '+
                          ' AND '+SQLTextoRightJoin('ORD.CODCOM','COR.COD_COR'));
  AdicionaFiltro(DevolucaoFracao.SQl);
  DevolucaoFracao.SQL.SaveToFile('consulta.sql');
  DevolucaoFracao.open;
end;

{******************************************************************************}
procedure TFDevolucaoFracaoFaccionista.AdicionaFiltro(VpaConsulta : TStrings);
begin
  if EFaccionista.AInteiro <> 0 then
    VpaConsulta.Add(' and FRF.CODFACCIONISTA = ' +EFaccionista.Text);
  if CPeriodo.Checked then
  begin
    case ETipoPeriodo.ItemIndex of
      0 : VpaConsulta.add(SQLTextoDataEntreAAAAMMDD('DFF.DATCADASTRO',EDatInicio.DateTime,EDatFim.DateTime+1,true));
      1 : VpaConsulta.add(SQLTextoDataEntreAAAAMMDD('RFF.DATREVISADO',EDatInicio.DateTime,EDatFim.DateTime+1,true));
    end;
  end;
  if VprSeqProduto <> 0 then
    VpaConsulta.add(' and ORD.SEQPRO = ' +IntToStr(VprSeqProduto));
  if EIDEstagio.AInteiro <> 0 then
    VpaConsulta.add('and FRF.SEQESTAGIO = ' +EIDEstagio.Text);
  if ECombinacao.AInteiro <> 0 then
    VpaConsulta.add('and ORD.CODCOM = '+ECombinacao.Text);
  if EFilial.AInteiro <> 0 then
    VpaConsulta.Add('and FRF.CODFILIAL = '+EFilial.Text);
  if EOrdemProducao.AInteiro <> 0 then
    VpaConsulta.add('and FRF.SEQORDEM = '+EOrdemProducao.text);
  if EFracao.AInteiro <> 0 then
    VpaConsulta.add('and FRF.SEQFRACAO = '+EFracao.Text);
end;

{******************************************************************************}
procedure TFDevolucaoFracaoFaccionista.DevolucaoFracaoCalcFields(
  DataSet: TDataSet);
begin
  DevolucaoFracaoDiasDevolucao.AsInteger := DiasPorPeriodo(DevolucaoFracaoDATCADASTRO.AsDateTime,DevolucaoFracaoDATREAL.AsDateTime);
  case DevolucaoFracaoCODMOTIVO.AsInteger of
    0 : DevolucaoFracaoTipoMotivo.AsString := 'Prazo Entrega';
    1 : DevolucaoFracaoTipoMotivo.AsString := 'Preco';
    2 : DevolucaoFracaoTipoMotivo.AsString := 'Dificuldade';
    3 : DevolucaoFracaoTipoMotivo.AsString := 'Outros';
  end;
end;

{******************************************************************************}
procedure TFDevolucaoFracaoFaccionista.EDatInicioCloseUp(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFDevolucaoFracaoFaccionista.EOrdemProducaoSelect(
  Sender: TObject);
begin
  EOrdemProducao.ASelectLocaliza.Text := 'Select ORD.SEQORD, ORD.DATEMI, CLI.C_NOM_CLI from ORDEMPRODUCAOCORPO ORD, CADCLIENTES CLI '+
                                         ' Where ORD.EMPFIL = '+ IntToStr(EFilial.AInteiro)+
                                         ' and ORD.CODCLI = CLI.I_COD_CLI '+
                                         ' AND CLI.C_NOM_CLI like ''@%''';
  EOrdemProducao.ASelectValida.Text := 'Select ORD.SEQORD, ORD.DATEMI, CLI.C_NOM_CLI From ORDEMPRODUCAOCORPO ORD, CADCLIENTES CLI '+
                                         ' Where ORD.EMPFIL = '+ IntToStr(EFilial.AInteiro)+
                                         ' and ORD.CODCLI = CLI.I_COD_CLI '+
                                         ' AND ORD.SEQORD = @';
end;

{******************************************************************************}
procedure TFDevolucaoFracaoFaccionista.EFracaoSelect(Sender: TObject);
begin
  EFracao.ASelectLocaliza.Text := 'SELECT FRA.SEQFRACAO, FRA.DATENTREGA, FRA.QTDPRODUTO, FRA.CODESTAGIO from FRACAOOP FRA '+
                                  ' Where FRA.SEQFRACAO LIKE ''@%'''+
                                  ' AND FRA.CODFILIAL = '+IntToStr(EFilial.AInteiro)+
                                  ' and FRA.SEQORDEM = '+IntToStr(EOrdemProducao.AInteiro);
  EFracao.ASelectValida.Text := 'SELECT FRA.SEQFRACAO, FRA.DATENTREGA, FRA.QTDPRODUTO, FRA.CODESTAGIO from FRACAOOP FRA '+
                                  ' Where FRA.SEQFRACAO = @ '+
                                  ' AND FRA.CODFILIAL = '+IntToStr(EFilial.AInteiro)+
                                  ' and FRA.SEQORDEM = '+IntToStr(EOrdemProducao.AInteiro);
end;

{******************************************************************************}
procedure TFDevolucaoFracaoFaccionista.BFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFDevolucaoFracaoFaccionista.BCadastrarClick(Sender: TObject);
begin
  FNovaFracaoFaccionista := TFNovaFracaoFaccionista.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovaFracaoFaccionista'));
  if FNovaFracaoFaccionista.DevolucaoFracaoFaccionista then
    AtualizaConsulta;
  FNovaFracaoFaccionista.free;
end;

procedure TFDevolucaoFracaoFaccionista.BExcluirClick(Sender: TObject);
begin
  if DevolucaoFracaoCODFILIAL.AsInteger <> 0 then
  begin
    if confirmacao(CT_DeletarItem) then
    begin
      FunOrdemProducao.ExcluiDevolucaoFracaoFaccionista(DevolucaoFracaoCODFACCIONISTA.AsInteger,DevolucaoFracaoSEQITEM.AsInteger,DevolucaoFracaoSEQDEVOLUCAO.AsInteger);
      AtualizaConsulta;
    end;
  end;
end;

{******************************************************************************}
procedure TFDevolucaoFracaoFaccionista.EProdutoRetorno(Retorno1,
  Retorno2: String);
begin
  if Retorno1 <> '' then
    VprSeqProduto := StrToInt(Retorno1)
  else
    VprSeqProduto := 0;
  AtualizaConsulta;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFDevolucaoFracaoFaccionista]);
end.
