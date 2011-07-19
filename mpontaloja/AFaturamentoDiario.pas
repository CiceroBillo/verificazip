unit AFaturamentoDiario;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Db, DBTables, UnDadosProduto, UnCotacao, UnDados,
  UnClientes, StdCtrls, Buttons, Grids, CGrades, ComCtrls, FMTBcd, SqlExpr;

type
  TRBDFaturamento = class
  private
  public
    NumCotacao : Integer;
    NumNota,
    NumCupom ,
    DesErro : String;
end;

type
  TFFaturamentoDiario = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    OrcamentosAFaturar: TSQLQuery;
    Timer1: TTimer;
    BFechar: TBitBtn;
    Grade: TRBStringGridColor;
    EUltimoFaturamento: TEditColor;
    Label1: TLabel;
    Label2: TLabel;
    EProximo: TEditColor;
    StatusBar1: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    VprFaturando : Boolean;
    VprFaturamentos : TList;
    procedure PosOrcamentosDiario;
    procedure ExecutaFaturamento;
    procedure CarTitulosGrade;
  public
    { Public declarations }
    procedure RodaFaturamentoDiario;
  end;

var
  FFaturamentoDiario: TFFaturamentoDiario;

implementation

uses APrincipal, FunSql, constantes, FunString, ANovoECF,
  ANovaNotaFiscalNota, FunObjeto, funData;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFFaturamentoDiario.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprFaturando := false;
  VprFaturamentos := TList.Create;
  Grade.ADados := VprFaturamentos;
  Grade.CarregaGrade;
  CarTitulosGrade;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFFaturamentoDiario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFFaturamentoDiario.RodaFaturamentoDiario;
begin
  try
    show;
  except
  end;
  Timer1.Enabled := true;
  Timer1Timer(Timer1);
end;

{******************************************************************************}
procedure TFFaturamentoDiario.PosOrcamentosDiario;
begin
  AdicionaSQLAbreTabela(OrcamentosAFaturar,'Select * from CADORCAMENTOS '+
                                           ' Where I_EMP_FIL = '+ IntToStr(VARIA.CodigoEmpfil)+
                                           ' and C_IND_PRO = ''N'''+
                                           ' and I_TIP_ORC <> '+ IntToStr(varia.TipoCotacaoContrato)+
                                           ' order by I_LAN_ORC',true);
end;

{******************************************************************************}
procedure TFFaturamentoDiario.ExecutaFaturamento;
var
  VpfDCotacao : TRBDOrcamento;
  VpfDCliente : TRBDCliente;
  VpfCotacoes : TList;
  VpfDFaturamento : TRBDFaturamento;
  VpfDTipoCotacao :TRBDTipoCotacao;
  VpfRetornoCliente : String;
begin
  VpfDTipoCotacao := TRBDTipoCotacao.cria;
  FreeTObjectsList(VprFaturamentos);
  StatusBar1.Panels[0].Text := 'Localizando cotações a Faturar';
  PosOrcamentosDiario;
  VpfCotacoes := TList.create;
  while not OrcamentosAFaturar.Eof do
  begin
    VpfDCotacao := TRBDOrcamento.cria;
    VpfDCliente := TRBDCliente.cria;

    VpfDFaturamento := TRBDFaturamento.Create;
    VpfDFaturamento.DesErro := '';
    VpfRetornoCliente := '';
    VprFaturamentos.Add(VpfDFaturamento);
    VpfDFaturamento.NumCotacao := OrcamentosAFaturar.FieldByName('I_LAN_ORC').AsInteger;

    StatusBar1.Panels[0].Text := 'Carregando dados da cotação'+OrcamentosAFaturar.FieldByName('I_LAN_ORC').AsString;
    VpfDCotacao.CodEmpFil := OrcamentosAFaturar.FieldByName('I_EMP_FIL').Asinteger;
    VpfDCotacao.LanOrcamento := OrcamentosAFaturar.FieldByName('I_LAN_ORC').AsInteger;
    FunCotacao.CarDOrcamento(VpfDCotacao);
    StatusBar1.Panels[0].Text := 'Carregando dados do cliente'+intToSTr(VpfDCotacao.CodCliente);
    VpfDCliente.CodCliente := VpfDCotacao.CodCliente;
    VpfRetornoCliente :=  FunClientes.CarDCliente(VpfDCliente);
    if (VpfDCliente.IndNotaFiscal) and // so fatura as cotações padrao e revenda
       ((VpfDCotacao.CodTipoOrcamento = varia.TipoCotacao) or (VpfDCotacao.CodTipoOrcamento = varia.TipoCotacaoRevenda)) then
    begin
      if VpfDCotacao.ValTotal < Varia.ValMinimoFaturamentoAutomatico then
        VpfDFaturamento.DesErro := 'VALOR DA COTAÇÃO INFERIOR AO VALOR MÍNIMO';
      if VpfDFaturamento.DesErro = '' then
      begin
        VpfDFaturamento.DesErro := VpfRetornoCliente;
        if VpfDFaturamento.Deserro = '' then
        begin
          if (DeletaChars(VpfDCliente.InscricaoEstadual,' ') = '') or (Uppercase(VpfDCliente.InscricaoEstadual) = 'ISENTO') then
          begin
            if VpfDCotacao.Produtos.Count > 0 then
            begin
              StatusBar1.Panels[0].Text := 'Gerando ECF da cotação '+intToSTr(VpfDCotacao.LanOrcamento);
              FNovoECF := TFNovoECF.CriarSDI(application,'', FPrincipal.VerificaPermisao('FNovoECF'));
              if not FNovoECF.GeraECFAPartirCotacao(VpfDCotacao) then
                VpfDFaturamento.DesErro := 'Erro na geração do Cupom Fiscal';
//09-08-2009 - foi colocado em comentario para ver se para o erro de acces violation.
//              FNovoECF.free;
              StatusBar1.Panels[0].Text := 'ECF gerado com sucesso da cotação '+intToSTr(VpfDCotacao.LanOrcamento);
              VpfDFaturamento.NumCupom := VpfDCotacao.NumCupomfiscal;
            end;
          end;
          if VpfDFaturamento.DesErro = '' then
          begin
            if VpfDCliente.TipoPessoa = 'J' then
            begin
              VpfCotacoes.Add(VpfDCotacao);
              StatusBar1.Panels[0].Text := 'Gerando nota fiscal da cotação '+intToSTr(VpfDCotacao.LanOrcamento);
              FNovaNotaFiscalNota := TFNovaNotaFiscalNota.CriarSDI(application,'', FPrincipal.VerificaPermisao('FNovaNotaFiscalNota'));
              VpfDFaturamento.DesErro := FNovaNotaFiscalNota.GeraNotaCotacoesAutomatico(VpfCotacoes,VpfDCliente, StatusBar1);
              FNovaNotaFiscalNota.free;
              StatusBar1.Panels[0].Text := 'Nota Fiscal gerada com sucesso da cotação'+intToSTr(VpfDCotacao.LanOrcamento);
              VpfCotacoes.Delete(0);
              VpfDFaturamento.NumNota := CopiaAteChar(VpfDCotacao.NumNotas,'/');
            end;
          end;
          if VpfDFaturamento.DesErro = '' then
          begin
            StatusBar1.Panels[0].Text := 'Gravando os dados da cotação'+intToSTr(VpfDCotacao.LanOrcamento);
            FunCotacao.GravaDCotacao(VpfDCotacao,nil);
          end;
        end;
      end;
    end;

    if VpfDFaturamento.DesErro = '' then
    begin
      StatusBar1.Panels[0].Text := 'Carregando o tipo da cotação '+intToSTr(VpfDCotacao.LanOrcamento);
      FunCotacao.CarDtipoCotacao(VpfDTipoCotacao,VpfDCotacao.CodTipoOrcamento);
      if VpfDCotacao.CodTransportadora = varia.CodTransportadoraVazio then // adiciona direto no arquivo de remessa pois já foi entregue pelo tecnico
      begin
        StatusBar1.Panels[0].Text := 'Alterando o estagio da cotação '+intToSTr(VpfDCotacao.LanOrcamento);
        FunCotacao.AlteraEstagioCotacao(VpfDCotacao.CodEmpFil,varia.CodigoUsuarioSistema,VpfDCotacao.LanOrcamento,varia.EstagioFinalOrdemProducao,'')
      end
      else
        FunCotacao.AlteraEstagioCotacao(VpfDCotacao.CodEmpFil,varia.CodigoUsuarioSistema,VpfDCotacao.LanOrcamento,varia.EstagioOrdemProducaoAlmoxarifado,'');
      StatusBar1.Panels[0].Text := 'Flagando cotação como gerada '+intToSTr(VpfDCotacao.LanOrcamento);
      FunCotacao.SetaOrcamentoProcessado(VpfDCotacao.CodEmpFil,VpfDCotacao.LanOrcamento);
    end;
    OrcamentosAFaturar.next;
    StatusBar1.Panels[0].Text := 'Liberando memoria da cotacao';
//    VpfDCliente.free;
    VpfDCotacao.Free;
  end;
  StatusBar1.Panels[0].Text := 'Faturamento processado com sucesso';
  VpfCotacoes.free;
  EUltimoFaturamento.Text := formatDatetime('DD/MM/YYYY - HH:MM:SS',now);
  EProximo.Text := FormatDateTime('DD/MM/YYYY - HH:MM:SS',IncMinuto(now,7));
  Grade.CarregaGrade;
  VpfDTipoCotacao.free;
end;

{******************************************************************************}
procedure TFFaturamentoDiario.CarTitulosGrade;
begin
  Grade.Cells[1,0] := 'Cotação';
  Grade.Cells[2,0] := 'Nota';
  Grade.Cells[3,0] := 'Cupom';
  Grade.Cells[4,0] := 'Erro';
end;

{******************************************************************************}
procedure TFFaturamentoDiario.BFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFFaturamentoDiario.GradeCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
var
  VpfDFaturamento :TRBDFaturamento;
begin
  VpfDFaturamento := TRBDFaturamento(VprFaturamentos.Items[VpaLinha-1]);
  grade.Cells[1,VpaLinha] := IntToStr(VpfDFaturamento.NumCotacao);
  Grade.Cells[2,VpaLinha] := VpfDFaturamento.NumNota;
  Grade.Cells[3,VpaLinha] := VpfDFaturamento.NumCupom;
  Grade.Cells[4,VpaLinha] := VpfDFaturamento.DesErro;
end;

{******************************************************************************}
procedure TFFaturamentoDiario.Timer1Timer(Sender: TObject);
begin
  if not VprFaturando then
  begin
    VprFaturando := true;
    ExecutaFaturamento;
    VprFaturando := false;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFFaturamentoDiario]);
end.
