unit AConsultaBaixaParcial;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente, Db, DBTables,
  Grids, DBGrids, Tabela, DBKeyViolation, UnCotacao, UnDadosProduto, UnContasAReceber,
  DBClient,sqlexpr;

type
  TFConsultaBaixaParcial = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BImprimir: TBitBtn;
    BExcluir: TBitBtn;
    BFechar: TBitBtn;
    GridIndice1: TGridIndice;
    GridIndice2: TGridIndice;
    OrcamentoParcialCorpo: TSQL;
    DataOrcamentoParcialCorpo: TDataSource;
    OrcamentoParcialCorpoCODFILIAL: TFMTBCDField;
    OrcamentoParcialCorpoLANORCAMENTO: TFMTBCDField;
    OrcamentoParcialCorpoSEQPARCIAL: TFMTBCDField;
    OrcamentoParcialCorpoDATPARCIAL: TSQLTimeStampField;
    OrcamentoParcialItem: TSQL;
    DataOrcamentoParcialItem: TDataSource;
    BEnviar: TBitBtn;
    OrcamentoParcialCorpoVALTOTAL: TFMTBCDField;
    OrcamentoParcialCorpoC_NOM_USU: TWideStringField;
    OrcamentoParcialItemQTDPARCIAL: TFMTBCDField;
    OrcamentoParcialItemDESUM: TWideStringField;
    OrcamentoParcialItemCODCOR: TFMTBCDField;
    OrcamentoParcialItemNOM_COR: TWideStringField;
    OrcamentoParcialItemC_COD_PRO: TWideStringField;
    OrcamentoParcialItemC_NOM_PRO: TWideStringField;
    OrcamentoParcialItemQTDCONFERIDO: TFMTBCDField;
    OrcamentoParcialCorpoQTDVOLUME: TFMTBCDField;
    OrcamentoParcialCorpoPESLIQUIDO: TFMTBCDField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure OrcamentoParcialCorpoAfterScroll(DataSet: TDataSet);
    procedure BImprimirClick(Sender: TObject);
    procedure BExcluirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    VprPressionadoR,
    VprFinanceiroGerado : Boolean;
    FunCotacao : TFuncoesCotacao;
    VprCodFilial,
    VprLanOrcamento,
    VprSeqParcial : Integer;
    VprDCotacao : TRBDOrcamento;
    procedure AtualizaConsulta;
    procedure PosItemOrcamento;
    procedure GeraFinanceiro;
  public
    { Public declarations }
    procedure ConsultaBaixasParciais(VpaCodFilial,VpaLanOrcamento : Integer);overload;
    procedure ConsultaBaixasParciais(VpaCodFilial,VpaLanOrcamento,VpaSeqParcial : Integer);Overload;
  end;

var
  FConsultaBaixaParcial: TFConsultaBaixaParcial;

implementation

uses APrincipal, ConstMsg, Constantes, UnClientes,
  dmRave, FunSql;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFConsultaBaixaParcial.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunCotacao := TFuncoesCotacao.Cria(FPrincipal.BaseDados);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFConsultaBaixaParcial.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunCotacao.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
procedure TFConsultaBaixaParcial.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFConsultaBaixaParcial.AtualizaConsulta;
begin
  OrcamentoParcialItem.Close;
  OrcamentoParcialCorpo.Close;
  OrcamentoParcialCorpo.Sql.Clear;
  OrcamentoParcialCorpo.Sql.Add('Select ORC.CODFILIAL, ORC.LANORCAMENTO, ORC.SEQPARCIAL, ORC.QTDVOLUME, ORC.PESLIQUIDO, '+
                                ' ORC.DATPARCIAL, ORC.VALTOTAL, USU.C_NOM_USU '+
                                ' from ORCAMENTOPARCIALCORPO ORC, CADUSUARIOS USU '+
                                ' Where ORC.CODUSUARIO = USU.I_COD_USU ' +
                                ' and CODFILIAL = '+ IntToStr(VprCodFilial)+
                                ' and LANORCAMENTO = '+ InttoStr(VprLanOrcamento));
  if VprSeqParcial <> 0 then
    OrcamentoParcialCorpo.Sql.Add('and SEQPARCIAL = '+ InttoStr(VprSeqParcial));
  OrcamentoparcialCorpo.sql.add('order by DATPARCIAL');
  OrcamentoParcialCorpo.open;
end;

{******************************************************************************}
procedure TFConsultaBaixaParcial.PosItemOrcamento;
begin
  if OrcamentoParcialCorpoCODFILIAL.AsInteger <> 0 then
  begin
    OrcamentoParcialItem.Close;
    OrcamentoParcialItem.Sql.Clear;
    OrcamentoParcialItem.Sql.Add('select ITE.QTDPARCIAL,  ITE.QTDCONFERIDO, ITE.DESUM, ITE.CODCOR, '+
                                 ' COR.NOM_COR,'+
                                 ' PRO.C_COD_PRO, PRO.C_NOM_PRO '+
                                 ' from ORCAMENTOPARCIALITEM ITE, CADPRODUTOS PRO, COR '+
                                 ' Where  ITE.SEQPRODUTO = PRO.I_SEQ_PRO '+
                                 ' AND '+SQLTEXTORightJoin('ITE.CODCOR','COR.COD_COR')+
                                ' AND ITE.CODFILIAL = '+OrcamentoParcialCorpoCODFILIAL.AsString+
                                ' and ITE.LANORCAMENTO = '+ OrcamentoParcialCorpoLANORCAMENTO.AsString+
                                ' and ITE.SEQPARCIAL = '+ OrcamentoParcialCorpoSEQPARCIAL.AsString);
    OrcamentoParcialItem.Sql.Add('order by PRO.C_COD_PRO');
    OrcamentoParcialItem.open;
  end
  else
    OrcamentoParcialItem.close;
end;

{******************************************************************************}
procedure TFConsultaBaixaParcial.GeraFinanceiro;
var
  VpfResultado : String;
  VpfDCotacao : TRBDOrcamento;
  VpfTransacao : TTransactionDesc;
begin
  if VprFinanceiroGerado then
    if not confirmacao('FINANCEIRO JÁ FOI GERADO!!!'#13'O financeiro dessa baixa parcial já foi gerado, tem certeza que deseja gerar novamente?') then
      exit;

  VprDCotacao := TRBDOrcamento.cria;
  VprDCotacao.CodEmpFil := OrcamentoParcialCorpoCODFILIAL.AsInteger;
  VprDCotacao.LanOrcamento := OrcamentoParcialCorpoLANORCAMENTO.AsInteger;
  FunCotacao.CarDOrcamento(VprDCotacao);
  VprDCotacao.ValTotalLiquido := OrcamentoParcialCorpoVALTOTAL.AsFloat;
  VprDCotacao.ValTotal := OrcamentoParcialCorpoVALTOTAL.AsFloat;
  VpfTransacao.IsolationLevel := xilREADCOMMITTED;
  FPrincipal.BaseDados.StartTransaction(VpfTransacao);
  if FunCotacao.GeraFinanceiroParcial(VprDCotacao,FunContasAReceber,OrcamentoParcialCorpoSEQPARCIAL.AsInteger, VpfResultado) then
  begin
    if VpfResultado ='' then
    begin
      FunCotacao.SetaFinanceiroGerado(VprDCotacao);
      VprDCotacao.FinanceiroGerado := true;
    end;
    if VpfResultado <> '' then
    begin
      FPrincipal.BaseDados.Rollback(VpfTransacao);
      aviso(VpfResultado);
    end
    else
      FPrincipal.BaseDados.Commit(VpfTransacao);
    VprFinanceiroGerado := true;
  end
  else
    FPrincipal.BaseDados.Rollback(VpfTransacao);
  VprDCotacao.free;
end;


{******************************************************************************}
procedure TFConsultaBaixaParcial.ConsultaBaixasParciais(VpaCodFilial,VpaLanOrcamento : Integer);
begin
  VprCodFilial := VpaCodFilial;
  VprLanorcamento := VpaLanorcamento;
  AtualizaConsulta;
  Showmodal;
end;

{******************************************************************************}
procedure TFConsultaBaixaParcial.OrcamentoParcialCorpoAfterScroll(
  DataSet: TDataSet);
begin
  PosItemOrcamento;
end;

{******************************************************************************}
procedure TFConsultaBaixaParcial.BImprimirClick(Sender: TObject);
begin
  dtRave := TdtRave.create(self);
  dtRave.ImprimePedidoParcial(OrcamentoParcialCorpoCODFILIAL.AsInteger,OrcamentoParcialCorpoLANORCAMENTO.AsInteger,OrcamentoParcialCorpoSEQPARCIAL.AsInteger);
  dtRave.free;
end;

{******************************************************************************}
procedure TFConsultaBaixaParcial.ConsultaBaixasParciais(VpaCodFilial,VpaLanOrcamento, VpaSeqParcial: Integer);
begin
  VprCodFilial := VpaCodFilial;
  VprLanorcamento := VpaLanorcamento;
  VprSeqParcial := VpaSeqParcial;
  AtualizaConsulta;
  Showmodal;
end;

{******************************************************************************}
procedure TFConsultaBaixaParcial.BExcluirClick(Sender: TObject);
var
  VpfResultado : String;
begin
  if confirmacao(CT_DeletaRegistro) then
  begin
    VpfResultado :=  FunCotacao.ExcluiBaixaParcialCotacao(OrcamentoParcialCorpoCODFILIAL.AsInteger,OrcamentoParcialCorpoLANORCAMENTO.AsInteger,OrcamentoParcialCorpoSEQPARCIAL.AsInteger);
    if VpfResultado <> '' then
      aviso(VpfResultado)
    else
      AtualizaConsulta;
  end;
end;

{******************************************************************************}
procedure TFConsultaBaixaParcial.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Shift = [ssCtrl,ssAlt])  then
  begin
    if (key = 82) then
      VprPressionadoR := true
    else
      if VprPressionadoR then
        if (key = 87) then
        begin
          GeraFinanceiro;
          VprPressionadoR := false;
        end
        else
          VprPressionadoR := false;
  end;

end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFConsultaBaixaParcial]);
end.
