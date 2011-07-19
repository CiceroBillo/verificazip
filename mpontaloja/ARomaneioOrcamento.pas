unit ARomaneioOrcamento;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios, Grids, DBGrids, Tabela,
  DBKeyViolation, Componentes1, ExtCtrls, PainelGradiente, DB, DBClient, CBancoDados, StdCtrls, ComCtrls, Mask,
  numericos, Buttons, Localizacao, UnCotacao, UnDados, UnDadosProduto, UnContasAreceber,
  Menus, UnNotaFiscal;

type
  TFRomaneioOrcamento = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Grade: TGridIndice;
    RomaneioOrcamento: TRBSQL;
    RomaneioOrcamentoCODFILIAL: TFMTBCDField;
    RomaneioOrcamentoSEQROMANEIO: TFMTBCDField;
    RomaneioOrcamentoDATINICIO: TSQLTimeStampField;
    RomaneioOrcamentoDATFIM: TSQLTimeStampField;
    RomaneioOrcamentoNUMNOTA: TFMTBCDField;
    RomaneioOrcamentoCODFILIALNOTA: TFMTBCDField;
    RomaneioOrcamentoSEQNOTA: TFMTBCDField;
    RomaneioOrcamentoCODCLIENTE: TFMTBCDField;
    RomaneioOrcamentoC_NOM_USU: TWideStringField;
    RomaneioOrcamentoC_NOM_CLI: TWideStringField;
    DataOrcamentoRomaneio: TDataSource;
    Label1: TLabel;
    ERomaneio: Tnumerico;
    Label2: TLabel;
    ESituacao: TComboBoxColor;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    Label4: TLabel;
    CPeriodo: TCheckBox;
    ECliente: TRBEditLocaliza;
    SpeedButton1: TSpeedButton;
    Label3: TLabel;
    Label5: TLabel;
    BFechar: TBitBtn;
    BCadastrar: TBitBtn;
    BAlterar: TBitBtn;
    BGeraNota: TBitBtn;
    BExcluir: TBitBtn;
    Bimprimir: TBitBtn;
    MenuGrade: TPopupMenu;
    GeraCotacaoParcial1: TMenuItem;
    ConsultaCotacaoParcial1: TMenuItem;
    RomaneioOrcamentoCODFILIALORCAMENTOBAIXA: TFMTBCDField;
    RomaneioOrcamentoLANORCAMENTOBAIXA: TFMTBCDField;
    RomaneioOrcamentoSEQORCAMENTOPARCIALBAIXA: TFMTBCDField;
    N1: TMenuItem;
    ConsultarNoa1: TMenuItem;
    Aux: TSQL;
    N2: TMenuItem;
    MBloquear: TMenuItem;
    RomaneioOrcamentoINDBLOQUEADO: TWideStringField;
    BConsultar: TBitBtn;
    RomaneioOrcamentoDESMOTIVOBLOQUEIO: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure ERomaneioExit(Sender: TObject);
    procedure ERomaneioKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BCadastrarClick(Sender: TObject);
    procedure BAlterarClick(Sender: TObject);
    procedure BGeraNotaClick(Sender: TObject);
    procedure BExcluirClick(Sender: TObject);
    procedure BimprimirClick(Sender: TObject);
    procedure GeraCotacaoParcial1Click(Sender: TObject);
    procedure ConsultaCotacaoParcial1Click(Sender: TObject);
    procedure ConsultarNoa1Click(Sender: TObject);
    procedure MBloquearClick(Sender: TObject);
    procedure RomaneioOrcamentoAfterScroll(DataSet: TDataSet);
    procedure BConsultarClick(Sender: TObject);
    procedure BImprimeClienteClick(Sender: TObject);
  private
    { Private declarations }
    VprOrdem : string;
    procedure AtualizaConsulta;
    procedure AdicionaFiltros(VpaSelect : TStrings);
    function GeraCotacaoParcialRomaneio(VpaCodFilial,VpaSeqRomaneio : Integer) : string;
    function BaixaCotacaoRomaneio(VpaCodFilial, VpaSeqRomaneio : INteger) : string;
    function AssociaNotaRomaneio(VpaCodFilial, VpaSeqRomaneio: integer):string;
  public
    VprDRomaneioOrcamento : TRBDRomaneioOrcamento;
  end;

var
  FRomaneioOrcamento: TFRomaneioOrcamento;

implementation

uses APrincipal,FunSql, Fundata, ANovoRomaneioOrcamento, Constantes, ANovaNotaFiscalNota, ConstMsg,dmRave,
   UnClientes, AConsultaBaixaParcial, FunObjeto, UnAmostra, UnArgox;

{$R *.DFM}


{ **************************************************************************** }
procedure TFRomaneioOrcamento.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  EDatInicio.Date := PrimeiroDiaMes(date);
  EDatFim.Date := UltimoDiaMes(date);
  ESituacao.ItemIndex := 0;
  VprOrdem := ' order by ROM.CODFILIAL, ROM.SEQROMANEIO';
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFRomaneioOrcamento.GeraCotacaoParcial1Click(Sender: TObject);
var
  VpfResultado : string;
begin
  if Confirmacao('Tem certeza que deseja gerar a cotação Parcial ?') then
  begin
    VpfResultado := GeraCotacaoParcialRomaneio(RomaneioOrcamentoCODFILIAL.AsInteger,RomaneioOrcamentoSEQROMANEIO.AsInteger);
    if VpfResultado = '' then
      BaixaCotacaoRomaneio(RomaneioOrcamentoCODFILIAL.AsInteger,RomaneioOrcamentoSEQROMANEIO.AsInteger);

    if VpfResultado <> '' then
      aviso(VpfResultado);

      AssociaNotaRomaneio(RomaneioOrcamentoCODFILIAL.AsInteger, RomaneioOrcamentoSEQROMANEIO.AsInteger);

      AtualizaConsulta;
  end;
end;

{******************************************************************************}
function TFRomaneioOrcamento.GeraCotacaoParcialRomaneio(VpaCodFilial,VpaSeqRomaneio: Integer): string;
var
  VpfDCotacao : TRBDOrcamento;
  VpfSeqParcialCotacao : Integer;
begin
  result := '';
  VpfDCotacao := FunCotacao.CarRomaneioOrcamentoBaixaCotacao(VpaCodFilial,VpaSeqRomaneio);
  if VpfDCotacao <> nil then
  begin
    result := FunCotacao.GravaBaixaParcialCotacao(VpfDCotacao,VpfSeqParcialCotacao);
    if result = ''  then
    begin
      result := FunCotacao.AsssociaCotacaoParcialRomaneioOrcamento(VpaCodFilial,VpaSeqRomaneio,VpfDCotacao.CodEmpFil,VpfDCotacao.LanOrcamento,VpfSeqParcialCotacao);
      if result = '' then
      begin
        VpfDCotacao.ValTotal := VpfDCotacao.ValTotalLiquido;
        FunCotacao.GeraFinanceiroParcial(VpfDCotacao,FunContasAReceber,VpfSeqParcialCotacao,result);
        if result = '' then
        begin
          dtRave := TdtRave.create(self);
          dtRave.ImprimePedidoParcial(VpfDCotacao.CodEmpFil,VpfDCotacao.LanOrcamento,VpfSeqParcialCotacao);
          dtRave.free;
        end;

      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFRomaneioOrcamento.MBloquearClick(Sender: TObject);
var
  VpfResultado, VpfMotivoBloqueio : string;
begin
  if RomaneioOrcamentoINDBLOQUEADO.AsString = 'S' then
     VpfResultado := FunCotacao.DesBloqueiaRomaneio(RomaneioOrcamentoCODFILIAL.AsInteger,RomaneioOrcamentoSEQROMANEIO.AsInteger)
  else
  begin
    if Entrada('Motivo Bloqueio','Motivo Bloqueio',VpfMotivoBloqueio,false,ERomaneio.Color,PanelColor1.Color) then
      VpfResultado := FunCotacao.BloqueiaRomaneio(RomaneioOrcamentoCODFILIAL.AsInteger,RomaneioOrcamentoSEQROMANEIO.AsInteger,VpfMotivoBloqueio);
  end;
  AtualizaConsulta;
  if VpfResultado <> '' then
    aviso( vpfresultado);
end;

{******************************************************************************}
procedure TFRomaneioOrcamento.RomaneioOrcamentoAfterScroll(DataSet: TDataSet);
begin
  AlterarEnabledDet([BAlterar,BExcluir,BGeraNota],true);
  if RomaneioOrcamentoINDBLOQUEADO.AsString = 'S' then
  begin
    MBloquear.Caption := 'Desbloquear';
    AlterarEnabledDet([BAlterar,BExcluir,BGeraNota],false);
  end
  else
    MBloquear.Caption := 'Bloquear';
end;

{ *************************************************************************** }
procedure TFRomaneioOrcamento.AdicionaFiltros(VpaSelect: TStrings);
begin
  if ERomaneio.AsInteger <> 0 then
    VpaSelect.Add('and ROM.SEQROMANEIO = ' +ERomaneio.Text)
  else
  begin
    if CPeriodo.Checked then
      VpaSelect.Add(SQLTextoDataEntreAAAAMMDD('TRUNC(ROM.DATINICIO)',EDatInicio.Date,EDatFim.Date,True));
    case ESituacao.ItemIndex of
      0 : VpaSelect.Add('and ROM.DATFIM IS NULL and ROM.INDBLOQUEADO = ''N''');
      1 : VpaSelect.Add('and ROM.DATFIM IS NOT NULL AND ROM.INDBLOQUEADO = ''N''');
      2 : VpaSelect.Add('and ROM.INDBLOQUEADO = ''S''');
    end;
    if ECliente.AInteiro <> 0 then
      VpaSelect.Add('AND ROM.CODCLIENTE = ' +ECliente.Text);
  end;
end;

{******************************************************************************}
function TFRomaneioOrcamento.AssociaNotaRomaneio(VpaCodFilial, VpaSeqRomaneio: integer): string;
begin
  AdicionaSQLAbreTabela(Aux,'Select * FROM ROMANEIOORCAMENTO ' +
                                 ' Where CODFILIAL = ' +IntToStr(VpaCodFilial)+
                                 ' AND SEQROMANEIO = ' +IntToStr(VpaSeqRomaneio));
  Aux.Edit;
  Aux.FieldByName('DATFIM').AsDateTime := now;
  Aux.Post;
  result := Aux.AMensagemErroGravacao;
  Aux.Close;
end;

{******************************************************************************}
procedure TFRomaneioOrcamento.AtualizaConsulta;
begin
  RomaneioOrcamento.Close;
  LimpaSQLTabela(RomaneioOrcamento);
  AdicionaSQLTabela(RomaneioOrcamento,'Select  ROM.CODFILIAL, ROM.SEQROMANEIO, ROM.DATINICIO, ROM.DATFIM, ROM.NUMNOTA, ROM.CODFILIALNOTA, ROM.SEQNOTA, ' +
                                      ' ROM.CODCLIENTE, ROM.CODFILIALORCAMENTOBAIXA, ROM.LANORCAMENTOBAIXA, '+
                                      ' ROM.SEQORCAMENTOPARCIALBAIXA, ROM.INDBLOQUEADO, ROM.DESMOTIVOBLOQUEIO, ' +
                                      ' USU.C_NOM_USU, ' +
                                      ' CLI.C_NOM_CLI ' +
                                      ' from ROMANEIOORCAMENTO ROM, CADCLIENTES CLI, CADUSUARIOS USU ' +
                                      ' Where ROM.CODCLIENTE = CLI.I_COD_CLI ' +
                                      ' AND ROM.CODUSUARIO = USU.I_COD_USU' );
  AdicionaFiltros(RomaneioOrcamento.SQL);
  AdicionaSQLTabela(RomaneioOrcamento,VprOrdem);
  Grade.ALinhaSQLOrderBy := RomaneioOrcamento.SQL.Count - 1;
  RomaneioOrcamento.Open;
  Grade.Columns[RIndiceColuna(Grade,'DESMOTIVOBLOQUEIO')].Visible := ESituacao.ItemIndex in [2,3];
end;

{******************************************************************************}
function TFRomaneioOrcamento.BaixaCotacaoRomaneio(VpaCodFilial,VpaSeqRomaneio: INteger): string;
var
  VpfDRomaneio : TRBDRomaneioOrcamento;
  VpfCotacoes : TList;
  VpfLaco : Integer;
  VpfDCotacao : TRBDOrcamento;
begin
  result := '';
  VpfCotacoes := TList.Create;
  VpfDRomaneio := TRBDRomaneioOrcamento.cria;
  FunCotacao.CarDRomaneioOrcamento(VpfDRomaneio,VpaCodFilial,VpaSeqRomaneio);
  FunCotacao.CarCotacoesParaBaixarRomaneio(VpfDRomaneio,VpfCotacoes);
  for VpfLaco := 0 to VpfCotacoes.Count - 1 do
  begin
    VpfDCotacao := TRBDOrcamento(VpfCotacoes.Items[VpfLaco]);
    Result := FunCotacao.GravaDCotacao(VpfDCotacao,nil);
    if result <> '' then
      break;
  end;
  FreeTObjectsList(VpfCotacoes);
end;

{******************************************************************************}
procedure TFRomaneioOrcamento.BAlterarClick(Sender: TObject);
begin
  if RomaneioOrcamentoCODFILIAL.AsInteger <> 0 then
  begin
    FNovoRomaneioOrcamento := TFNovoRomaneioOrcamento.criarSDI(Application,'',FPrincipal.VerificaPermisao('FNovoRomaneioOrcamento'));
    FNovoRomaneioOrcamento.AlteraRomaneio(RomaneioOrcamentoCODFILIAL.AsInteger,RomaneioOrcamentoSEQROMANEIO.AsInteger);
    FNovoRomaneioOrcamento.free;
  end;
end;

{******************************************************************************}
procedure TFRomaneioOrcamento.BCadastrarClick(Sender: TObject);
begin
  FNovoRomaneioOrcamento := TFNovoRomaneioOrcamento.criarSDI(Application,'',FPrincipal.VerificaPermisao('FNovoRomaneioOrcamento'));
  if FNovoRomaneioOrcamento.NovoRomaneio then
    AtualizaConsulta;
  FNovoRomaneioOrcamento.free;
end;

{******************************************************************************}
procedure TFRomaneioOrcamento.BConsultarClick(Sender: TObject);
begin
  if RomaneioOrcamentoCODFILIAL.AsInteger <> 0 then
  begin
    FNovoRomaneioOrcamento := TFNovoRomaneioOrcamento.criarSDI(Application,'',FPrincipal.VerificaPermisao('FNovoRomaneioOrcamento'));
    FNovoRomaneioOrcamento.ConsultaRomaneio(RomaneioOrcamentoCODFILIAL.AsInteger,RomaneioOrcamentoSEQROMANEIO.AsInteger);
    FNovoRomaneioOrcamento.free;
  end;
end;

{******************************************************************************}
procedure TFRomaneioOrcamento.BExcluirClick(Sender: TObject);
begin
  if RomaneioOrcamentoSEQROMANEIO.AsInteger <> 0 then
  begin
    if Confirmacao(CT_DeletaRegistro) then
    Begin
      FunCotacao.ExcluiRomaneioOrcamento(RomaneioOrcamentoCODFILIAL.AsInteger,RomaneioOrcamentoSEQROMANEIO.AsInteger);
      AtualizaConsulta;
    End;
  end;
end;

{******************************************************************************}
procedure TFRomaneioOrcamento.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFRomaneioOrcamento.BGeraNotaClick(Sender: TObject);
var
  VpfDCliente : TRBDCliente;
  VpfResultado : string;
begin
  if RomaneioOrcamentoSEQROMANEIO.AsInteger <> 0 then
  begin
    VpfDCliente := TRBDCliente.cria;
    VpfDCliente.CodCliente := RomaneioOrcamentoCODCLIENTE.AsInteger;
    FunClientes.CarDCliente(VpfDCliente);
    if VpfDCliente.IndNotaFiscal or VpfDCliente.IndQuarto or
       VpfDCliente.IndMeia or VpfDCliente.IndVintePorcento or
       VpfDCliente.IndDecimo  then
    begin
      FNovaNotaFiscalNota := TFNovaNotaFiscalNota.criarSDI(Application,'',FPrincipal.VerificaPermisao('FNovaNotaFiscalNota'));
      FNovaNotaFiscalNota.GeraRonameioOrcamento(RomaneioOrcamentoCODFILIAL.AsInteger,RomaneioOrcamentoSEQROMANEIO.AsInteger);
      FNovaNotaFiscalNota.free;

      if VpfDCliente.IndQuarto or VpfDCliente.IndDecimo or
         VpfDCliente.IndMeia or VpfDCliente.IndVintePorcento then
      begin
        VpfResultado := GeraCotacaoParcialRomaneio(RomaneioOrcamentoCODFILIAL.AsInteger,RomaneioOrcamentoSEQROMANEIO.AsInteger);
      end;
    end
    else
    begin
      if confirmacao('Falta configuração da nota fiscal do cliente. Tem certeza que deseja faturar esse romaneio?') then
      begin
        VpfResultado := GeraCotacaoParcialRomaneio(RomaneioOrcamentoCODFILIAL.AsInteger,RomaneioOrcamentoSEQROMANEIO.AsInteger);
        if VpfResultado = '' then
        begin
          BaixaCotacaoRomaneio(RomaneioOrcamentoCODFILIAL.AsInteger,RomaneioOrcamentoSEQROMANEIO.AsInteger);
        end;
      end;
    //gerar somente romaneio;
    end;

    AtualizaConsulta;
    VpfDCliente.Free;
  end;
  if VpfResultado <> '' then
    aviso(VpfResultado);
end;

procedure TFRomaneioOrcamento.BImprimeClienteClick(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFRomaneioOrcamento.BimprimirClick(Sender: TObject);
begin
  if RomaneioOrcamentoCODFILIAL.AsInteger <> 0 then
  begin
    dtRave := TdtRave.create(self);
    dtRave.ImprimeRomaneio(RomaneioOrcamentoCODFILIAL.AsInteger,RomaneioOrcamentoSEQROMANEIO.AsInteger,true);
    dtRave.free;
  end;
end;

{******************************************************************************}
procedure TFRomaneioOrcamento.ConsultaCotacaoParcial1Click(Sender: TObject);
begin
  FConsultaBaixaParcial := TFConsultaBaixaParcial.CriarSDI(application , '', FPrincipal.VerificaPermisao('FConsultaBaixaParcial'));
  FConsultaBaixaParcial.ConsultaBaixasParciais(RomaneioOrcamentoCODFILIALORCAMENTOBAIXA.AsInteger,RomaneioOrcamentoLANORCAMENTOBAIXA.AsInteger,RomaneioOrcamentoSEQORCAMENTOPARCIALBAIXA.AsInteger);
  FConsultaBaixaParcial.free;
end;

{******************************************************************************}
procedure TFRomaneioOrcamento.ConsultarNoa1Click(Sender: TObject);
var
  VpfDNotaFiscal : TRBDNotaFiscal;
begin
  if RomaneioOrcamentoCODFILIAL.AsInteger <> 0 then
  begin
    VpfDNotaFiscal := TRBDNotaFiscal.cria;
    VpfDNotaFiscal.CodFilial := RomaneioOrcamentoCODFILIALNOTA.AsInteger;
    VpfDNotaFiscal.SeqNota := RomaneioOrcamentoSEQNOTA.AsInteger;
    FunNotaFiscal.CarDNotaFiscal(VpfDNotaFiscal);
    FNovaNotaFiscalNota := TFNovaNotaFiscalNota.criarSDI(Application,'',FPrincipal.VerificaPermisao('FNovaNotaFiscalNota'));
    FNovaNotaFiscalNota.ConsultaNota(VpfDNotaFiscal);
    FNovaNotaFiscalNota.free;
  end;
end;

{******************************************************************************}
procedure TFRomaneioOrcamento.ERomaneioExit(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFRomaneioOrcamento.ERomaneioKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = 13 then
    AtualizaConsulta;
end;

{******************************************************************************}
procedure TFRomaneioOrcamento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  RomaneioOrcamento.Close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFRomaneioOrcamento]);
end.
