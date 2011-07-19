unit ANovaLeituraLocacao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Grids, CGrades, Componentes1, ExtCtrls, PainelGradiente, StdCtrls,
  Buttons, Localizacao, Spin, ComCtrls, Mask, numericos, UnDados, Constantes, UnContrato,
  DBKeyViolation, Db, DBTables, FMTBcd, SqlExpr;

type
  TFNovaLeituraLocacao = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor3: TPanelColor;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    Localiza: TConsultaPadrao;
    ValidaGravacao1: TValidaGravacao;
    BFechar: TBitBtn;
    Aux: TSQLQuery;
    ScrollBox1: TScrollBox;
    PanelColor4: TPanelColor;
    Grade: TRBStringGridColor;
    PanelColor1: TPanelColor;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    SpeedButton2: TSpeedButton;
    Label5: TLabel;
    Label6: TLabel;
    SpeedButton3: TSpeedButton;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Bevel1: TBevel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label17: TLabel;
    Label19: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    ECodCliente: TEditLocaliza;
    EContrato: TEditLocaliza;
    EDatLeitura: TCalendario;
    ECodResponsavelLeitura: TEditLocaliza;
    EMesLocacao: TSpinEditColor;
    EAnoLocacao: TSpinEditColor;
    EValContrato: Tnumerico;
    EQtdFranquia: TEditColor;
    EValExcedente: Tnumerico;
    EValDesconto: Tnumerico;
    EObservacoes: TMemoColor;
    EQtdFranquiaColor: TEditColor;
    EValExcedenteColor: Tnumerico;
    PanelColor2: TPanelColor;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label18: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    ETotalCopias: TEditColor;
    EValTotal: Tnumerico;
    EQtdExcedente: TEditColor;
    EQtdDefeitos: TEditColor;
    EValTotalDesconto: Tnumerico;
    Panel1: TPanel;
    ETotalCopiasColor: TEditColor;
    EQtdDefeitosColor: TEditColor;
    EQtdExcedenteColor: TEditColor;
    Label24: TLabel;
    EOrdemCompra: TEditColor;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancelarClick(Sender: TObject);
    procedure EContratoSelect(Sender: TObject);
    procedure EContratoRetorno(Retorno1, Retorno2: String);
    procedure BGravarClick(Sender: TObject);
    procedure GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GradeDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure GradeKeyPress(Sender: TObject; var Key: Char);
    procedure GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure ECodClienteChange(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure EAnoLocacaoExit(Sender: TObject);
    procedure GradeGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure EValDescontoExit(Sender: TObject);
  private
    { Private declarations }
    VprAcao : Boolean;
    VprOperacao : TRBDOperacaoCadastro;
    VprDLeitura : TRBDLeituraLocacaoCorpo;
    VprDItem : TRBDLeituraLocacaoItem;
    VprDContrato : TRBDContratoCorpo;
    FunContrato : TRBFuncoesContrato;
    procedure CarTitulosGrade;
    procedure CarDClasse;
    procedure carDTela;
    procedure CarDContratoTela;
    procedure CarDItemLeitura;
    procedure InicializaTela;
    procedure CalculaValorTotal;
    function ExisteLeituraDigitada : boolean;
  public
    { Public declarations }
    function NovaLeitura : Boolean;
    function AlteraLeitura(VpaDLeitura : TRBDLeituraLocacaoCorpo):boolean;
    procedure ConsultaLeitura(VpaDLeitura : TRBDLeituraLocacaoCorpo);
  end;

var
  FNovaLeituraLocacao: TFNovaLeituraLocacao;

implementation

uses APrincipal, FunObjeto,Fundata, FunString, ConstMsg, FunSql, FunNumeros;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovaLeituraLocacao.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunContrato := TRBFuncoesContrato.cria(FPrincipal.BaseDados);
  VprDContrato := TRBDContratoCorpo.cria;
  CartitulosGrade;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovaLeituraLocacao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunContrato.free;
  VprDContrato.free;
  Action := CaFree;
end;

{******************************************************************************}
procedure TFNovaLeituraLocacao.CarTitulosGrade;
begin
  Grade.Cells[1,0] := 'Código';
  Grade.Cells[2,0] := 'Produto';
  Grade.Cells[3,0] := 'Número de Série';
  Grade.Cells[4,0] := 'Série Interno';
  Grade.Cells[5,0] := 'Setor';
  Grade.Cells[6,0] := 'Medidor Anterior';
  Grade.Cells[7,0] := 'Medidor Atual';
  Grade.Cells[8,0] := 'Qtd defeitos';
  Grade.Cells[9,0] := 'Medidor Anterior Color';
  Grade.Cells[10,0] := 'Medidor Atual Color';
  Grade.Cells[11,0] := 'Qtd defeitos Color';
  Grade.Cells[12,0] := 'Total Cópias';
  Grade.Cells[13,0] := 'Total Cópias Color';
end;

{******************************************************************************}
procedure TFNovaLeituraLocacao.CarDClasse;
begin
  with VprDLeitura do
  begin
    CodFilial := varia.CodigoEmpFil;
    CodCliente := ECodCliente.Ainteiro;
    MesLocacao := EMesLocacao.Value;
    AnoLocacao := EAnoLocacao.Value;
    SeqContrato := EContrato.AInteiro;
    CodTecnicoLeitura := ECodResponsavelLeitura.AInteiro;
    DatLeitura := EDatLeitura.DateTime;
    DesObservacao := EObservacoes.Lines.text;
    DesOrdemCompra := EOrdemCompra.Text;
    if VprOperacao = ocinsercao then
    begin
      CodUsuario := varia.CodigoUsuario;
      DatDigitacao := now;
    end;
    ValContrato:= EValContrato.AValor;
    QtdFranquia:= EQtdFranquia.AInteiro;
    QtdFranquiaColor:= EQtdFranquiaColor.AInteiro;
    ValExcessoFranquia:= EValExcedente.AValor;
    ValExcessoFranquiaColor:= EValExcedenteColor.AValor;

  end;
end;

{******************************************************************************}
procedure TFNovaLeituraLocacao.carDTela;
begin
  with VprDLeitura do
  begin
    ECodCliente.Ainteiro := CodCliente;
    ECodCliente.Atualiza;
    EMesLocacao.Value := MesLocacao;
    EAnoLocacao.Value := AnoLocacao;
    EContrato.AInteiro := SeqContrato;
    EContrato.Atualiza;
    ECodResponsavelLeitura.AInteiro := CodTecnicoLeitura;
    EDatLeitura.DateTime := DatLeitura;
    EValDesconto.AValor := ValDesconto;
    EObservacoes.Lines.Text := DesObservacao;
    EValContrato.AValor:= ValContrato;
    EQtdFranquia.AInteiro:= QtdFranquia;
    EQtdFranquiaColor.AInteiro:= QtdFranquiaColor;
    EValExcedente.AValor:= ValExcessoFranquia;
    EValExcedenteColor.AValor:= ValExcessoFranquiaColor;
    EOrdemCompra.Text:= DesOrdemCompra;
    CalculaValorTotal;
  end;
end;

{******************************************************************************}
procedure TFNovaLeituraLocacao.CarDContratoTela;
begin
  EValContrato.AValor := VprDContrato.ValContrato;
  EQtdFranquia.AInteiro := VprDContrato.QtdFranquia;
  EValExcedente.AValor := VprDContrato.ValExcedenteFranquia;
  EQtdFranquiaColor.AInteiro := VprDContrato.QtdFranquiaColorida;
  EValExcedenteColor.AValor := VprDContrato.ValExcedenteColorido;
  ECodResponsavelLeitura.AInteiro := VprDContrato.CodTecnicoLeitura;
  ECodResponsavelLeitura.Atualiza;
  if VprOperacao in [ocinsercao,ocedicao] then
  begin
    VprDLeitura.ValDesconto := VprDContrato.ValDesconto;
    EValDesconto.AValor := VprDContrato.ValDesconto;
  end;
end;

{******************************************************************************}
procedure TFNovaLeituraLocacao.CarDItemLeitura;
begin
  if Grade.Cells[7,Grade.ALinha] <> '' then
    VprDItem.QtdMedidorAtual := StrToInt(DeletaChars(Grade.Cells[7,Grade.ALinha],'.'))
  else
    VprDItem.QtdMedidorAtual := 0;
  if Grade.Cells[8,Grade.ALinha] <> '' then
    VprDItem.QtdDefeitos := StrToInt(DeletaChars(Grade.Cells[8,Grade.ALinha],'.'))
  else
    VprDItem.QtdDefeitos := 0;
  if VprDItem.QtdMedidorAtual > 0 then
  begin
    VprDItem.QtdTotalCopias := (VprDItem.QtdMedidorAtual - VprDItem.QtdUltimaLeitura) - VprDItem.QtdDefeitos;
  end
  else
    VprDItem.QtdTotalCopias := 0;

  if Grade.Cells[10,Grade.ALinha] <> '' then
    VprDItem.QtdMedidorAtualColor := StrToInt(DeletaChars(Grade.Cells[10,Grade.ALinha],'.'))
  else
    VprDItem.QtdMedidorAtualColor := 0;
  if Grade.Cells[11,Grade.ALinha] <> '' then
    VprDItem.QtdDefeitosColor := StrToInt(DeletaChars(Grade.Cells[11,Grade.ALinha],'.'))
  else
    VprDItem.QtdDefeitosColor := 0;
  if VprDItem.QtdMedidorAtualColor > 0 then
    VprDItem.QtdTotalCopiasColor := (VprDItem.QtdMedidorAtualColor - VprDItem.QtdUltimaLeituraColor) - VprDItem.QtdDefeitosColor
  else
    VprDItem.QtdTotalCopiasColor := 0;
end;

{******************************************************************************}
procedure TFNovaLeituraLocacao.InicializaTela;
begin
  LimpaComponentes(PanelColor4,0);
  EDatLeitura.DateTime := date;
  EAnoLocacao.Value := varia.AnoLocacao;
  EMesLocacao.Value := varia.MesLocacao;
  ValidaGravacao1.execute;
end;

{******************************************************************************}
procedure TFNovaLeituraLocacao.CalculaValorTotal;
var
  VpfLaco : Integer;
begin
  VprDLeitura.QtdCopias := 0;
  VprDLeitura.QtdDefeitos := 0;
  VprDLeitura.QtdCopiasColor := 0;
  VprDLeitura.QtdDefeitosColor := 0;
  for VpfLaco := 0 to VprDLeitura.ItensLeitura.Count - 1 do
  begin
    VprDLeitura.QtdCopias := VprDLeitura.QtdCopias + TRBDLeituraLocacaoItem(VprDLeitura.ItensLeitura.Items[VpfLaco]).QtdTotalCopias;
    VprDLeitura.QtdDefeitos := VprDLeitura.QtdDefeitos + TRBDLeituraLocacaoItem(VprDLeitura.ItensLeitura.Items[VpfLaco]).QtdDefeitos;
    VprDLeitura.QtdCopiasColor := VprDLeitura.QtdCopiasColor + TRBDLeituraLocacaoItem(VprDLeitura.ItensLeitura.Items[VpfLaco]).QtdTotalCopiasColor;
    VprDLeitura.QtdDefeitosColor := VprDLeitura.QtdDefeitosColor + TRBDLeituraLocacaoItem(VprDLeitura.ItensLeitura.Items[VpfLaco]).QtdDefeitosColor;
  end;
  VprDLeitura.QtdExcedente :=  VprDLeitura.QtdCopias - VprDContrato.QtdFranquia;
  if VprDLeitura.QtdExcedente < 0 then
    VprDLeitura.QtdExcedente := 0;
  VprDLeitura.QtdExcednteColor :=  VprDLeitura.QtdCopiasColor - VprDContrato.QtdFranquiaColorida;
  if VprDLeitura.QtdExcednteColor < 0 then
    VprDLeitura.QtdExcednteColor := 0;
  VprDLeitura.ValTotal := VprDContrato.ValContrato + ArredondaDecimais((VprDLeitura.QtdExcedente * VprDContrato.ValExcedenteFranquia),2)+ ArredondaDecimais((VprDLeitura.QtdExcednteColor * VprDContrato.ValExcedenteColorido),2);
  VprDLeitura.ValTotalComDesconto :=  VprDLeitura.ValTotal - VprDLeitura.ValDesconto;

  EQtdExcedente.AInteiro := VprDLeitura.QtdExcedente;
  EValTotal.AValor := VprDLeitura.ValTotal;
  EValTotalDesconto.AValor := VprDLeitura.ValTotalComDesconto;
  ETotalCopias.AInteiro := VprDLeitura.QtdCopias;
  EQtdDefeitos.AInteiro := VprDLeitura.QtdDefeitos;

  EQtdExcedenteColor.AInteiro := VprDLeitura.QtdExcednteColor;
  ETotalCopiasColor.AInteiro := VprDLeitura.QtdCopiasColor;
  EQtdDefeitosColor.AInteiro := VprDLeitura.QtdDefeitosColor;
end;

{******************************************************************************}
function TFNovaLeituraLocacao.ExisteLeituraDigitada : boolean;
begin
  AdicionaSQLAbreTabela(Aux,'Select * from LEITURALOCACAOCORPO '+
                            ' Where CODCLIENTE = '+IntToStr(ECodCliente.AInteiro)+
                            ' and SEQCONTRATO = '+IntToStr(EContrato.AInteiro)+
                            ' and MESLOCACAO = '+IntToStr(EMesLocacao.Value)+
                            ' and ANOLOCACAO = '+IntToStr(EAnoLocacao.Value));
  result := not Aux.eof;
  Aux.close;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
function TFNovaLeituraLocacao.NovaLeitura : Boolean;
begin
  if varia.DatFimLocacao < date then
  begin
    Aviso('PERÍODO DE FATURAMENTO FINALIZADO!!!'#13'A data final para as leituras de locação foi ultrapassada, solicite ao administrador um novo mês de locação.');
    exit;
  end;
  VprOperacao := ocInsercao;
  VprDLeitura := TRBDLeituraLocacaoCorpo.cria;
  Grade.ADados := VprDLeitura.ItensLeitura;
  Grade.CarregaGrade;
  InicializaTela;
  Showmodal;
  result := VprAcao;
  VprDLeitura.free;
end;

{******************************************************************************}
function TFNovaLeituraLocacao.AlteraLeitura(VpaDLeitura : TRBDLeituraLocacaoCorpo):boolean;
begin
  VprOperacao := ocEdicao;
  VprDLeitura := VpaDLeitura;
  Grade.ADados := VprDLeitura.ItensLeitura;
  Grade.CarregaGrade;
  carDTela;
  Showmodal;
  Result := VprAcao;
end;

{******************************************************************************}
procedure TFNovaLeituraLocacao.ConsultaLeitura(VpaDLeitura : TRBDLeituraLocacaoCorpo);
begin
  VprOperacao := ocConsulta;
  VprDLeitura := VpaDLeitura;
  Grade.ADados := VprDLeitura.ItensLeitura;
  Grade.CarregaGrade;
  carDTela;
  PanelColor1.Enabled := false;
  AlterarEnabledDet([BGravar,BCancelar],false);
  BFechar.Enabled := true;
  Grade.Options := Grade.Options -[goEditing];
  Showmodal;
end;

{******************************************************************************}
procedure TFNovaLeituraLocacao.BCancelarClick(Sender: TObject);
begin
  VprAcao := false;
  Close;
end;

{******************************************************************************}
procedure TFNovaLeituraLocacao.EContratoSelect(Sender: TObject);
begin
  EContrato.ASelectValida.Text := 'Select CON.SEQCONTRATO, TIP.NOMTIPOCONTRATO from CONTRATOCORPO CON, TIPOCONTRATO TIP '+
                             ' Where CON.CODFILIAL = '+IntToStr(varia.CodigoEmpfil)+
                             ' AND CON.CODTIPOCONTRATO = TIP.CODTIPOCONTRATO '+
                             ' and CON.CODCLIENTE = '+IntToStr(ECodCliente.AInteiro)+
                             ' and CON.SEQCONTRATO = @';
  EContrato.ASelectLocaliza.Text := 'Select CON.SEQCONTRATO, TIP.NOMTIPOCONTRATO from CONTRATOCORPO CON, TIPOCONTRATO TIP '+
                             ' Where CON.CODFILIAL = '+IntToStr(varia.CodigoEmpfil)+
                             ' AND CON.CODTIPOCONTRATO = TIP.CODTIPOCONTRATO '+
                             ' and CON.CODCLIENTE = '+IntToStr(ECodCliente.AInteiro)+
                             ' and TIP.NOMTIPOCONTRATO LIKE ''@%''';
end;

{******************************************************************************}
procedure TFNovaLeituraLocacao.EContratoRetorno(Retorno1,
  Retorno2: String);
var
  VpfResultado : string;
begin
  VpfResultado := '';
  if Retorno1 <> '' then
  begin
    FunContrato.CarDContrato(VprDContrato,varia.codigoEmpFil,StrToint(REtorno1));
    if VprDContrato.DatCancelamento > MontaData(1,1,1950) then
      vpfresultado := 'CONTRATO CANCELADO!!!'#13'Não é possivel fazer a leitura do contrato pois o mesmo se encontra cancelado.';
    if VpfResultado = '' then
    begin
      VpfResultado := FunContrato.ValidaNumeroSeriesProdutosContrato(VprDContrato);
      if Vpfresultado = '' then
      begin
        if VprOperacao = ocinsercao then
        begin
          FunContrato.InicializaLeituraContratoLocacao(VprDContrato,VprDLeitura);
          Grade.CarregaGrade;
          CalculaValorTotal;
          if ExisteLeituraDigitada then
            aviso('LEITURA DUPLICADA!!!'#13'Já existe uma leitura digitada para esse contrato nesse mês.');
        end;
      end;
    end;
  end
  else
  begin
    FreeTObjectsList(VprDLeitura.ItensLeitura);
    Grade.CarregaGrade;
  end;
  if VpfResultado = '' then
  begin
    CarDContratoTela
  end
  else
  begin
    aviso(Vpfresultado);
    EContrato.clear;
  end;
end;

{******************************************************************************}
procedure TFNovaLeituraLocacao.BGravarClick(Sender: TObject);
var
  VpfResultado : String;
begin
  CalculaValorTotal;
  CarDClasse;
  VpfREsultado := FunContrato.GravaDLeituraLocacao(VprDLeitura);
  if VpfResultado = '' then
  begin
    VprAcao := true;
    Close;
  end
end;

{******************************************************************************}
procedure TFNovaLeituraLocacao.GradeCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDItem := TRBDLeituraLocacaoItem(VprDLeitura.ItensLeitura.Items[vpaLinha-1]);
  Grade.Cells[1,VpaLinha] := VprDItem.CodProduto;
  Grade.Cells[2,VpaLinha] := VprDItem.NomProduto;
  Grade.Cells[3,VpaLinha] := VprDItem.NumSerieProduto;
  Grade.Cells[4,VpaLinha] := VprDItem.NumSerieInterno;
  Grade.Cells[5,VpaLinha] := VprDItem.DesSetorEmpresa;
  if VprDItem.QtdUltimaLeitura > 0 then
    Grade.Cells[6,VpaLinha] := IntToStr(VprDItem.QtdUltimaLeitura)
  else
    Grade.Cells[6,VpaLinha] := '';
  if VprDItem.QtdMedidorAtual > 0 then
    Grade.Cells[7,VpaLinha] := IntTostr(VprDItem.QtdMedidorAtual)
  else
    Grade.Cells[7,VpaLinha] :=  '';
  if VprDItem.QtdDefeitos > 0 then
    Grade.Cells[8,VpaLinha] := IntToStr(VprDItem.QtdDefeitos)
  else
    Grade.Cells[8,VpaLinha] := '';
  if VprDItem.QtdUltimaLeituraColor > 0 then
    Grade.Cells[9,VpaLinha] := IntToStr(VprDItem.QtdUltimaLeituraColor)
  else
    Grade.Cells[9,VpaLinha] := '';
  if VprDItem.QtdMedidorAtualColor > 0 then
    Grade.Cells[10,VpaLinha] := IntTostr(VprDItem.QtdMedidorAtualColor)
  else
    Grade.Cells[10,VpaLinha] :=  '';
  if VprDItem.QtdDefeitosColor > 0 then
    Grade.Cells[11,VpaLinha] := IntToStr(VprDItem.QtdDefeitosColor)
  else
    Grade.Cells[11,VpaLinha] := '';
  Grade.Cells[12,VpaLinha] := IntToStr(VprDItem.QtdTotalCopias);
  Grade.Cells[13,VpaLinha] := IntToStr(VprDItem.QtdTotalCopiasColor);
end;

{******************************************************************************}
procedure TFNovaLeituraLocacao.GradeDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  if Vpavalidos then
  begin
    CarDItemLeitura;
    if (VprDItem.QtdTotalCopias < 0) then
    begin
      VpaValidos := false;
      aviso('QTD COPIAS INVÁLIDA!!!'#13'A quantidade de cópias não pode ser negativa.');
    end
    else
      if (VprDItem.QtdTotalCopiasColor < 0) then
      begin
        VpaValidos := false;
        aviso('QTD COPIAS COLORIDA INVÁLIDA!!!'#13'A quantidade de cópias coloridas não pode ser negativa.');
      end
      else
        if (VprDItem.QtdUltimaLeituraColor > 0) and
           (VprDItem.QtdTotalCopiasColor = 0) then
        begin
          VpaValidos := false;
          aviso('QTD COPIAS COLORIDA INVÁLIDA!!!'#13'É necessário digitar a quantidade de cópias coloridas.');
        end;
    if VpaValidos then
      CalculaValorTotal;
  end;
end;

{******************************************************************************}
procedure TFNovaLeituraLocacao.GradeKeyPress(Sender: TObject;
  var Key: Char);
begin
  IF (Grade.Col < 7) or VprDItem.IndDesativar then
    key := #0;
end;

{******************************************************************************}
procedure TFNovaLeituraLocacao.GradeMudouLinha(Sender: TObject;
  VpaLinhaAtual, VpaLinhaAnterior: Integer);
begin
  if VprDLeitura.ItensLeitura.Count >0 then
  begin
    VprDItem := TRBDLeituraLocacaoItem(VprDLeitura.ItensLeitura.Items[VpaLinhaAtual-1]);
  end;
end;

procedure TFNovaLeituraLocacao.ECodClienteChange(Sender: TObject);
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
    ValidaGravacao1.execute;
end;

{******************************************************************************}
procedure TFNovaLeituraLocacao.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFNovaLeituraLocacao.EAnoLocacaoExit(Sender: TObject);
begin
  if ExisteLeituraDigitada then
    aviso('LEITURA DUPLICADA!!!'#13'Já existe uma leitura digitada para esse contrato nesse mês.');
end;

{******************************************************************************}
procedure TFNovaLeituraLocacao.GradeGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
var
  VpfDItem : TRBDLeituraLocacaoItem;
begin
  if (ACol > 0) and (ARow > 0) and (VprDLeitura <> nil) then
  begin
    if VprDLeitura.ItensLeitura.Count > 0  then
    begin
      VpfDItem := TRBDLeituraLocacaoItem(VprDLeitura.ItensLeitura.Items[Arow-1]);
      if VpfDItem.IndDesativar then
        ABrush.Color := clYellow;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovaLeituraLocacao.EValDescontoExit(Sender: TObject);
begin
  if VprOperacao in [ocInsercao,ocEdicao] then
  begin
    VprDLeitura.ValDesconto := EValDesconto.AValor;
    CalculaValorTotal;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovaLeituraLocacao]);
end.
