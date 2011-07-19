unit ACartuchoCotacao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Grids, CGrades, StdCtrls,
  Localizacao, Buttons, Db, DBTables, UnDadosProduto, UnCotacao,
  DBKeyViolation, SQLEXPR, FMTBcd, Mask, numericos;

type
  TFCartuchoCotacao = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    GCartuchos: TRBStringGridColor;
    Label2: TLabel;
    SpeedButton3: TSpeedButton;
    Label5: TLabel;
    ECotacao: TEditLocaliza;
    Label1: TLabel;
    Localiza: TConsultaPadrao;
    ESequencial: TEditColor;
    Aux: TSQLQuery;
    Label3: TLabel;
    ETransportadora: TRBEditLocaliza;
    SpeedButton1: TSpeedButton;
    Label4: TLabel;
    ValidaGravacao1: TValidaGravacao;
    PVolume: TPanelColor;
    Label6: TLabel;
    PanelColor2: TPanelColor;
    BCadatrar: TBitBtn;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    BFechar: TBitBtn;
    BImprimeVolume: TBitBtn;
    EQtdVolume: Tnumerico;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ECotacaoSelect(Sender: TObject);
    procedure GCartuchosCarregaItemGrade(Sender: TObject;
      VpaLinha: Integer);
    procedure ESequencialExit(Sender: TObject);
    procedure ECotacaoFimConsulta(Sender: TObject);
    procedure ESequencialKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BFecharClick(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
    procedure BCadatrarClick(Sender: TObject);
    procedure ECotacaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ETransportadoraChange(Sender: TObject);
    procedure BImprimeVolumeClick(Sender: TObject);
  private
    { Private declarations }
    VprCartuchos : TList;
    VprDNovoCartucho,
    VprDCartucho : TRBDCartuchoCotacao;
    VprDCotacao : TRBDOrcamento;
    procedure CarTitulosGrade;
    procedure CarDClasse;
    procedure AdicionaCartucho(VpaLanOrcamento, VpaSeqCartucho : integer);
    procedure EstadoBotoes(VpaEstado : Boolean);
    procedure InicializaTela;
    function ExisteCartucho(VpaSequencial : Integer) : Boolean;
    function ExisteProdutoCotacao(VpaSeqproduto : Integer) : Boolean;
  public
    { Public declarations }
    procedure AssociaCartuchoCotacao;
  end;

var
  FCartuchoCotacao: TFCartuchoCotacao;

implementation

uses APrincipal,constantes,FunObjeto, FunSql, Constmsg, FunString,
  ACartuchoCotacaoProduto;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFCartuchoCotacao.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  CarTitulosGrade;
  VprCartuchos.free;
  VprCartuchos := TList.create;
  GCartuchos.ADados := VprCartuchos;
  ValidaGravacao1.execute;
  if not Config.NoCartuchoCotacaoImprimirEtiquetaVolume then
  begin
    PVolume.Visible:= False;
    BImprimeVolume.Visible:= False;
  end;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFCartuchoCotacao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFCartuchoCotacao.CarDClasse;
begin
//  VprDCotacao.QtdVolumesTransportadora:= EQtdVolume.AsInteger;
end;

{******************************************************************************}
procedure TFCartuchoCotacao.CarTitulosGrade;
begin
  GCartuchos.Cells[1,0] := 'Sequencial';
  GCartuchos.Cells[2,0] := 'Código';
  GCartuchos.Cells[3,0] := 'Produto';
  GCartuchos.Cells[4,0] := 'Peso';
  GCartuchos.Cells[5,0] := 'Embalado';
  GCartuchos.Cells[6,0] := 'Celula Trabalho';
end;

{******************************************************************************}
procedure TFCartuchoCotacao.AdicionaCartucho(VpaLanOrcamento, VpaSeqCartucho : integer);
var
  VpfResultado : string;
begin
  VpfResultado := '';
  if not ExisteCartucho(VpaSeqCartucho) then
    VpfResultado := 'SEQUENCIAL CARTUCHO INVÁLIDO!!!'#13'O sequencial do cartucho digitado não existe pesado no sistema.';
  if VpfResultado = '' then
  begin
    VprDNovoCartucho.CodFilial := varia.CodigoEmpFil;
    VprDNovoCartucho.LanOrcamento := ECotacao.AInteiro;
    VprDNovoCartucho.DatSaida := now;
    if not ExisteProdutoCotacao(VprDNovoCartucho.SeqProduto) then
    begin
      FCartuchoCotacaoCartucho := TFCartuchoCotacaoCartucho.CriarSDI(self,'',FPrincipal.VerificaPermisao('FCartuchoCotacaoCartucho'));
      if not FCartuchoCotacaoCartucho.TrocaCartuchoCotacao(VprDNovoCartucho) then
      begin
        VprDNovoCartucho.free;
        vpfResultado := 'PRODUTO NÃO ADICIONADO NA COTAÇÃO!!!'#13'O produto referente ao sequencial selecionado não existe adicionado na cotação.';
      end;
      FCartuchoCotacaoCartucho.free;
    end;
    if VpfResultado = '' then
    begin
      VprCartuchos.Add(VprDNovoCartucho);
      GCartuchos.CarregaGrade;
      if Config.NoCartuchoCotacaoImprimirEtiquetaVolume then
        EQtdVolume.AValor:= EQtdVolume.AValor+1;
    end;
  end;

  if VpfResultado <> '' then
    aviso(VpfResultado);
end;

{******************************************************************************}
procedure TFCartuchoCotacao.EstadoBotoes(VpaEstado : Boolean);
begin
  BCadatrar.Enabled := not VpaEstado;
  BGravar.Enabled := VpaEstado;
  BCancelar.Enabled := VpaEstado;
  BFechar.Enabled := VpaEstado;
end;

{******************************************************************************}
procedure TFCartuchoCotacao.InicializaTela;
begin
//  FreeTObjectsList(VprCartuchos);
  VprDCotacao.Free;
  VprDCotacao := TRBDOrcamento.cria; 
  VprCartuchos.free;
  VprCartuchos := TList.create;
  GCartuchos.ADados := VprCartuchos;
  GCartuchos.CarregaGrade;
  ECotacao.Clear;
  ECotacao.Atualiza;
  ESequencial.clear;
  if ETransportadora.AInteiro = 0 then
    ActiveControl := ETransportadora
  else
    ActiveControl := ECotacao;
  EstadoBotoes(true);
end;

{******************************************************************************}
function TFCartuchoCotacao.ExisteCartucho(VpaSequencial : Integer) : Boolean;
begin
  if VpaSequencial <> 0 then
  begin
    AdicionaSQLAbreTabela(Aux,'Select CAR.SEQPRODUTO, CAR.DATPESO, CAR.PESCARTUCHO, '+
                            ' CEL.NOMCELULA, PRO.C_COD_PRO, PRO.C_NOM_PRO '+
                            ' From PESOCARTUCHO CAR, CADPRODUTOS PRO, CELULATRABALHO CEL '+
                            ' Where CAR.SEQCARTUCHO = ' +IntToStr(VpaSequencial)+
                            ' and CAR.SEQPRODUTO = PRO.I_SEQ_PRO '+
                            ' and CAR.CODCELULA = CEL.CODCELULA ');
    result := not Aux.eof;
    if result then
    begin
      VprDNovoCartucho := TRBDCartuchoCotacao.cria;
      VprDNovoCartucho.SeqCartucho := VpaSequencial;
      VprDNovoCartucho.SeqProduto := Aux.FieldByname('SEQPRODUTO').AsInteger;
      VprDNovoCartucho.CodProduto := Aux.FieldByname('C_COD_PRO').AsString;
      VprDNovoCartucho.NomProduto := Aux.FieldByname('C_NOM_PRO').AsString;
      VprDNovoCartucho.CelulaTrabalho := Aux.FieldByname('NOMCELULA').AsString;
      VprDNovoCartucho.PesCartucho := Aux.FieldByname('PESCARTUCHO').AsFloat;
      VprDNovoCartucho.DatEmbalado := Aux.FieldByname('DATPESO').AsDateTime;

    end;
    Aux.close;
  end;
end;

{******************************************************************************}
function TFCartuchoCotacao.ExisteProdutoCotacao(VpaSeqproduto : Integer) : Boolean;
var
  VpfLaco : Integer;
  VpfDItem : TRBDOrcProduto;
begin
  result := false;
  for VpfLaco := 0 to VprDCotacao.Produtos.Count - 1 do
  begin
    VpfDItem := TRBDOrcProduto(VprDCotacao.Produtos.Items[VpfLaco]);
    if VpfDItem.SeqProduto = VpaSeqproduto then
    begin
      result := true;
      break;
    end;
  end;
end;

{******************************************************************************}
procedure TFCartuchoCotacao.AssociaCartuchoCotacao;
begin
  InicializaTela;
  showmodal;
end;

{******************************************************************************}
procedure TFCartuchoCotacao.ECotacaoSelect(Sender: TObject);
begin
  ECotacao.ASelectLocaliza.Text := 'Select CLI.C_NOM_CLI, COT.I_LAN_ORC '+
                                   ' from CADCLIENTES CLI, CADORCAMENTOS COT '+
                                   ' Where CLI.I_COD_CLI = COT.I_COD_CLI '+
                                   ' and COT.I_EMP_FIL = '+inttoStr(Varia.CodigoEmpFil)+
                                   ' and CLI.C_NOM_CLI LIKE ''@%''';
  ECotacao.ASelectValida.Text := 'Select CLI.C_NOM_CLI, COT.I_LAN_ORC '+
                                   ' from CADCLIENTES CLI, CADORCAMENTOS COT '+
                                   ' Where CLI.I_COD_CLI = COT.I_COD_CLI '+
                                   ' and COT.I_EMP_FIL = '+inttoStr(Varia.CodigoEmpFil)+
                                   ' and COT.I_LAN_ORC = @';
end;

{******************************************************************************}
procedure TFCartuchoCotacao.GCartuchosCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDCartucho := TRBDCartuchoCotacao(VprCartuchos.Items[VpaLinha-1]);
  GCartuchos.Cells[1,VpaLinha] := IntToStr(VprDCartucho.SeqCartucho);
  GCartuchos.Cells[2,VpaLinha] := VprDCartucho.CodProduto;
  GCartuchos.Cells[3,VpaLinha] := VprDCartucho.NomProduto;
  GCartuchos.Cells[4,VpaLinha] := FormatFloat('###,###,##0.0####',VprDCartucho.PesCartucho);
  GCartuchos.Cells[5,VpaLinha] := FormatDateTime('DD/MM/YYYY HH:MM:SS',VprDCartucho.DatEmbalado);
  GCartuchos.Cells[6,VpaLinha] := VprDCartucho.CelulaTrabalho;
end;

{******************************************************************************}
procedure TFCartuchoCotacao.ESequencialExit(Sender: TObject);
begin
  if ESequencial.AInteiro <> 0 then
    AdicionaCartucho(ECotacao.AInteiro,ESequencial.AInteiro);
end;

{******************************************************************************}
procedure TFCartuchoCotacao.ECotacaoFimConsulta(Sender: TObject);
begin
  if VprDCotacao <> nil then
    VprDCotacao.free;
  VprDCotacao := TRBDOrcamento.cria;
  VprDCotacao.CodEmpFil := varia.CodigoEmpFil;
  VprDCotacao.LanOrcamento := ECotacao.AInteiro;
  FunCotacao.CarDOrcamento(VprDCotacao);
  FreeTObjectsList(VprCartuchos);
  GCartuchos.CarregaGrade;
end;

{******************************************************************************}
procedure TFCartuchoCotacao.ESequencialKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 13 then
  begin
    if ESequencial.Text <> '' then
    begin
      ESequencialExit(ESequencial);
      ESequencial.Clear;
    end
    else
      BGravar.Click;

  end;
end;

{******************************************************************************}
procedure TFCartuchoCotacao.BFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFCartuchoCotacao.BCancelarClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFCartuchoCotacao.BGravarClick(Sender: TObject);
var
  VpfResultado : String;
  VpfTransacao : TTransactionDesc;
begin
  if VprDCotacao.LanOrcamento <> 0 then
  begin
    if FunCotacao.TodosCartuchosAssociados(VprDCotacao,VprCartuchos) then
    begin
      VpfTransacao.IsolationLevel := xilREADCOMMITTED;
      FPrincipal.BaseDados.StartTransaction(VpfTransacao);
      VpfResultado := FunCotacao.GravaCartuchoCotacao(VprDCotacao,VprCartuchos);
      if VpfResultado = '' then
      begin
        if ETransportadora.AInteiro <> 0 then
        begin
          FunCotacao.AlteraTransportadora(VprDCotacao,ETransportadora.AInteiro);
          VpfResultado:= FunCotacao.GravaRoteiroEntrega(VprDCotacao);
          if VpfResultado <> '' then
            FunCotacao.AlteraEstagioCotacao(VprDCotacao.CodEmpFil,varia.CodigoUsuario,VprDCotacao.LanOrcamento,Varia.EstagioNaEntrega,'');
        end;
      end;
      if  vpfresultado <> '' then
      begin
        FPrincipal.BaseDados.Rollback(VpfTransacao);
        aviso(VpfResultado);
      end
      else
      begin
        FPrincipal.BaseDados.commit(VpfTransacao);
        EstadoBotoes(false);
        BCadatrar.Click;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFCartuchoCotacao.BImprimeVolumeClick(Sender: TObject);
begin
  VprDCotacao.QtdVolumesTransportadora:= EQtdVolume.AsInteger;
  FunCotacao.ImprimeEtiquetaVolume(VprDCotacao);
  EQtdVolume.AsInteger:= 0;
end;

{******************************************************************************}
procedure TFCartuchoCotacao.BCadatrarClick(Sender: TObject);
begin
  InicializaTela;
end;

{******************************************************************************}
procedure TFCartuchoCotacao.ECotacaoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 13 then
  begin
    ECotacao.Text := DeletaChars(ECotacao.text,'.');
    ActiveControl := ESequencial;
  end;
end;

{******************************************************************************}
procedure TFCartuchoCotacao.ETransportadoraChange(Sender: TObject);
begin
  ValidaGravacao1.execute;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFCartuchoCotacao]);
end.
