unit AChequesCP;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Grids, CGrades, unDadosCR, unDados,
  StdCtrls, Buttons, Mask, numericos, Localizacao;

type
  TFChequesCP = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Grade: TRBStringGridColor;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    PanelColor3: TPanelColor;
    EValParcela: Tnumerico;
    EValCheques: Tnumerico;
    Label1: TLabel;
    Label2: TLabel;
    EFormaPagamento: TEditLocaliza;
    Localiza: TConsultaPadrao;
    EContaCaixa: TEditLocaliza;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BGravarClick(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GradeDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure GradeGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GradeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GradeKeyPress(Sender: TObject; var Key: Char);
    procedure GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GradeNovaLinha(Sender: TObject);
    procedure EFormaPagamentoRetorno(Retorno1, Retorno2: String);
    procedure GradeSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure GradeDepoisExclusao(Sender: TObject);
    procedure EFormaPagamentoChange(Sender: TObject);
    procedure EContaCaixaRetorno(Retorno1, Retorno2: String);
    procedure BFecharClick(Sender: TObject);
  private
    { Private declarations }
    VprAcao,
    VprExisteVariosCheques : Boolean;
    VprNomCliente : String;
    VprCodFormaPagamentoAnterior : Integer;
    VprDBaixa : TRBDBaixaCP;
    VprDCheque : TRBDCheque;
    VprNumChequeAnterior : Integer;
    function ExisteFormaPagamento : Boolean;
    function ExisteContaCorrente : Boolean;
    function ExisteCheque : Boolean;
    function LocalizaCheque : Boolean;
    procedure CarTitulosGrade;
    procedure CarDChequeClasse;
    procedure CarDChequeTerceiroGrade;
    function RValCheques(VpaCheques : TList):Double;
  public
    { Public declarations }
    function CadastraCheques(VpaDBaixa : TRBDBaixaCP) : boolean;
    function CadastraChequesAvulso(VpaValor : Double;VpaCheques : TList):Boolean;
    procedure ConsultaCheques(VpaCheques : TList);
  end;

var
  FChequesCP: TFChequesCP;

implementation

uses APrincipal,Constantes, funData, funString,ConstMsg, unContasAReceber,
  AFormasPagamento, unClientes, UnContasAPagar, AConsultacheques;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFChequesCP.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao := false;
  CarTitulosGrade;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFChequesCP.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
function TFChequesCP.ExisteFormaPagamento : Boolean;
begin
  result := false;
  if Grade.Cells[1,Grade.ALinha] <> '' then
  begin
    if StrToInt(Grade.Cells[1,Grade.ALinha]) = VprCodFormaPagamentoAnterior then
    result := true
    else
    begin
      result := FunContasAReceber.ExisteFormaPagamento(StrToInt(Grade.Cells[1,Grade.ALinha]),VprDCheque);
      if result then
      begin
        Grade.Cells[2,Grade.ALinha] := VprDCheque.NomFormaPagamento;
        VprDCheque.SeqCheque := 0;
        VprDCheque.NumCheque := 0;
        VprNumChequeAnterior := 0;
        Grade.Cells[5,Grade.ALinha] := '';
        VprCodFormaPagamentoAnterior := VprDCheque.CodFormaPagamento;
        if VprDCheque.TipFormaPagamento = fpCheque then
        begin
          VprDCheque.NomEmitente := VprNomCliente;
          Grade.Cells[5,Grade.ALinha] := VprNomCliente;
        end;
      end;
    end;
  end;
  if not result then
  begin
    VprDCheque.SeqCheque := 0;
    VprDCheque.NumCheque := 0;
  end;
end;

{******************************************************************************}
function TFChequesCP.ExisteContaCorrente : Boolean;
begin
  result := false;
  if Grade.Cells[3,Grade.ALinha] <> '' then
  begin
    result := FunContasAReceber.ExisteContaCorrente(Grade.Cells[3,Grade.ALinha]);
    if result then
    begin
      EContaCaixa.Text := Grade.Cells[3,Grade.ALinha];
      EContaCaixa.Atualiza;
    end;
  end;
end;


{******************************************************************************}
function TFChequesCP.ExisteCheque : Boolean;
begin
  result := true;
  VprDCheque.CodCliente:= VprDBaixa.CodFornecedor;
  if (VprDCheque.TipFormaPagamento in[fpChequeTerceiros,fpCheque])then
  begin
    result := false;
    if (Grade.Cells[5,Grade.ALinha] <> '')  then
    begin
      if VprNumChequeAnterior = StrToInt(Grade.Cells[5,Grade.ALinha]) then
        result := true
      else
      begin
        result := true;
        if VprDCheque.TipFormaPagamento = fpChequeTerceiros then
        begin
          result := false;
          begin
            result := FunContasAPagar.ExisteCheque(StrToInt(Grade.Cells[5,Grade.ALinha]),VprExisteVariosCheques,VprDCheque);
            if result then
            begin
              CarDChequeTerceiroGrade;
            end
            else
            begin
              aviso('CHEQUE INVALIDO!!!'#13'O cheque digitado nao existe ou ele esta reservado para outro Fornecedor.');
              VprDCheque.SeqCheque := 0;
              if VprExisteVariosCheques then
                result := LocalizaCheque;
            end;
            if result then
              VprNumChequeAnterior := VprDCheque.NumCheque;
          end;
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFChequesCP.LocalizaCheque : Boolean;
var
  VpfNumCheque : Integer;
begin
  VprDCheque.CodCliente:= VprDBaixa.CodFornecedor;
  if VprDCheque.TipFormaPagamento = fpChequeTerceiros then
  begin
    if (Grade.Cells[5,Grade.ALinha] <> '') and VprExisteVariosCheques then
      VpfNumCheque := StrToInt(Grade.Cells[5,Grade.ALinha])
    else
      VpfNumCheque := 0;
    FConsultaCheques := TFConsultaCheques.CriarSDI(self,'',FPrincipal.VerificaPermisao('FConsultaCheques'));
    result := FConsultaCheques.ConsultaChequeBaixaCP(VpfNumCheque,VprDCheque);
    FConsultaCheques.free;
    if result then
      CarDChequeTerceiroGrade
    else
      VprDCheque.SeqCheque := 0;
  end;
end;

{******************************************************************************}
procedure TFChequesCP.CarTitulosGrade;
begin
  Grade.Cells[1,0] := 'Código';
  Grade.Cells[2,0] := 'Forma Pagamento';
  Grade.Cells[3,0] := 'Conta Caixa';
  Grade.Cells[4,0] := 'Descrição';
  Grade.Cells[5,0] := 'Nro Cheque';
  Grade.Cells[6,0] := 'Banco';
  Grade.Cells[7,0] := 'Valor';
  Grade.Cells[8,0] := 'Vencimento';
  Grade.Cells[9,0] := 'Emitente';
  Grade.Cells[10,0] := 'Destinatario/Nominal';
end;

{******************************************************************************}
procedure TFChequesCP.CarDChequeClasse;
begin
  if Grade.Cells[1,Grade.ALinha] <> '' then
    VprDCheque.CodFormaPagamento := StrToInt(Grade.Cells[1,Grade.ALinha])
  else
    VprDCheque.CodFormaPagamento := 0;

  if Grade.Cells[5,Grade.ALinha] <> '' then
    VprDCheque.NumCheque := StrToInt(Grade.Cells[5,Grade.ALinha])
  else
    VprDCheque.NumCheque := 0;
  if Grade.Cells[6,Grade.ALinha] <> '' then
    VprDCheque.CodBanco := StrToInt(Grade.Cells[6,Grade.ALinha])
  else
    VprDCheque.CodBanco := 0;
  if (VprDCheque.TipFormaPagamento <> fpChequeTerceiros) then // cheque de terceiros não permite alterar o vencimento
  begin
    VprDCheque.NumContaCaixa := Grade.Cells[3,Grade.ALinha];
    VprDCheque.ValCheque := StrToFloat(DeletaChars(Grade.Cells[7,Grade.ALinha],'.'));
    VprDCheque.NomEmitente := Grade.Cells[9,Grade.alinha];
    VprDCheque.NomNomimal := Grade.Cells[10,Grade.ALinha];
    VprDCheque.DatCadastro := now;
    VprDCheque.CodUsuario := varia.CodigoUsuario;
    try
      VprDCheque.DatVencimento := StrToDate(Grade.Cells[8,Grade.ALinha])
    except
      VprDCheque.DatVencimento :=  MontaData(1,1,1900);
    end;
  end;
end;

{******************************************************************************}
procedure TFChequesCP.CarDChequeTerceiroGrade;
begin
  Grade.Cells[5,Grade.ALinha] := IntToStr(VprDCheque.NumCheque);
  Grade.Cells[6,Grade.ALinha] := IntToStr(VprDCheque.CodBanco);
  Grade.Cells[7,Grade.ALinha] := FormatFloat(varia.MascaraValor,VprDCheque.ValCheque);
  Grade.Cells[8,Grade.ALinha]:= FormatDateTime('DD/MM/YYYY',VprDCheque.DatVencimento);
  Grade.Cells[9,Grade.ALinha] := VprDCheque.NomEmitente;
  EContaCaixa.Text := VprDCheque.NumContaCaixa;
  EContaCaixa.Atualiza;
end;

{******************************************************************************}
function TFChequesCP.RValCheques(VpaCheques : TList):Double;
var
  VpfLaco : Integer;
begin
  result := 0;
  for VpfLaco := 0 to VprDBaixa.Cheques.Count - 1 do
  begin
    result := result + TRBDCheque(VprDBaixa.Cheques.Items[VpfLaco]).ValCheque;
  end;
end;

{******************************************************************************}
function TFChequesCP.CadastraCheques(VpaDBaixa : TRBDBaixaCP) : boolean;
begin
  VprDBaixa := VpaDBaixa;
  VprDBaixa.Cheques := VpaDBaixa.Cheques;
  Grade.ADados := VprDBaixa.Cheques;
  Grade.CarregaGrade;
  EValParcela.AValor := VpaDBaixa.ValorPago;
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
function TFChequesCP.CadastraChequesAvulso(VpaValor : Double;VpaCheques : TList):Boolean;
begin
  VprDBaixa := TRBDBaixaCP.Cria;
  VprDBaixa.DatPagamento := date;
  VprDBaixa.Cheques := VpaCheques;
  Grade.ADados := VprDBaixa.Cheques;
  Grade.CarregaGrade;
  EValParcela.AValor := VpaValor;
  showmodal;
  VprDBaixa.Cheques := nil;
  VprDBaixa.free;
  result := VprAcao;
end;


{******************************************************************************}
procedure TFChequesCP.ConsultaCheques(VpaCheques : TList);
begin
  VprDBaixa := TRBDBaixaCP.cria;
  VprDBaixa.Cheques := VpaCheques;
  Grade.ADados := VpaCheques;
  Grade.CarregaGrade;
  show;
end;

{******************************************************************************}
procedure TFChequesCP.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFChequesCP.BGravarClick(Sender: TObject);
var
  VpfValoresOk : Boolean;
begin
  VpfValoresOk := true;
  if EValParcela.AValor <> EValCheques.AValor then
    VpfValoresOk := confirmacao('VALORES DIFERENTES!!!'#13'O Valor da parcela é diferente da somatória dos cheques. Tem certeza que deseja continuar?');
  if VpfValoresOk then
  begin
    VprAcao := true;
    Close;
  end;
end;

{******************************************************************************}
procedure TFChequesCP.BCancelarClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFChequesCP.GradeCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDCheque := TRBDCheque(VprDBaixa.Cheques.Items[VpaLinha-1]);
  if VprDCheque.CodFormaPagamento <> 0 then
    Grade.Cells[1,VpaLinha] := IntToStr(VprDCheque.CodFormaPagamento)
  else
    Grade.Cells[1,VpaLinha] := '';
  Grade.Cells[2,VpaLinha] := VprDCheque.NomFormaPagamento;
  Grade.cells[3,VpaLinha] := VprDCheque.NumContaCaixa;
  Grade.cells[4,VpaLinha] := VprDCheque.NomContaCaixa;
  if VprDCheque.NumCheque <> 0 then
    Grade.cells[5,VpaLinha] := IntToStr(VprDCheque.NumCheque)
  else
    Grade.cells[5,VpaLinha] := '';
  if VprDCheque.CodBanco <> 0 then
    Grade.Cells[6,VpaLinha] := IntToStr(VprDCheque.CodBanco)
  else
    Grade.Cells[6,VpaLinha] := '';
  Grade.Cells[7,VpaLinha] := FormatFloat(varia.MascaraValor,VprDCheque.ValCheque);
  if VprDCheque.DatVencimento > MontaData(1,1,1900) then
    Grade.Cells[8,VpaLinha]:= FormatDateTime('DD/MM/YYYY',VprDCheque.DatVencimento)
  else
    Grade.Cells[8,VpaLinha] := '';
  Grade.Cells[9,VpaLinha] := VprDCheque.NomEmitente;
  Grade.Cells[10,VpaLinha] := VprDCheque.NomNomimal;
end;

{******************************************************************************}
procedure TFChequesCP.GradeDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if not ExisteFormaPagamento then
  begin
    aviso('FORMA DE PAGAMENTO INVÁLIDA!!!'#13'A forma de pagamento digitada não é valida ou não foi preechida.');
    Vpavalidos := false;
    Grade.Col := 1;
  end
  else
    if not ExisteContaCorrente  then
    begin
      aviso('CONTA CAIXA INVALIDA!!!'#13'A conta caixa digitada não é válida ou não foi preenchida.');
      Vpavalidos := false;
      Grade.Col := 3;
    end
    else
      if not ExisteCheque then
      begin
        aviso('NUMERO DO CHEQUE INVÁLIDO!!!'#13'O numero do cheque digitado não existe.');
        Vpavalidos := false;
        Grade.Col := 5;
      end
      else
        if Grade.Cells[7,Grade.ALinha] = '' then
        begin
          aviso('VALOR NÃO PREENCHIDO!!!'#13'É necessário preencher o valor.');
          Vpavalidos := false;
          Grade.Col := 7;
        end;
  if VpaValidos then
  begin
    CarDChequeClasse;
    if VprDCheque.DatVencimento <= MontaData(1,1,1900) then
    begin
      aviso('VENCIMENTO INVÁLIDO!!!'#13'A data de vencimento preenchida é inválida.');
      Vpavalidos := false;
      Grade.Col := 8;
    end
    else
      if VprDCheque.ValCheque = 0  then
      begin
        aviso('VALOR INVÁLIDO!!!'#13'O valor preenchido é inválido.');
        Vpavalidos := false;
        Grade.Col := 7;
      end
  end;
  if VpaValidos then
  begin
    if (VprDCheque.TipFormaPagamento in [fpChequeTerceiros,fpCheque]) then //cheque, cheque de terceiro
    begin
      if VprDCheque.CodBanco = 0 then
      begin
        aviso('CÓDIGO DO BANCO NÃO PREENCHIDO!!!'#13'É necessário preencher o codigo do banco quando a forma de pagamento é cheque.');
        Grade.Col := 6;
        VpaValidos := false;
      end
      else
        if VprDCheque.NomEmitente = '' then
        begin
          aviso('NOME DO EMITENTE NÃO PREENCHIDO!!!'#13'É necessário preencher o nome do emitente quando a forma de pagamento é cheque.');
          Grade.Col := 9;
          VpaValidos := false;
        end
        else
          if VprDCheque.NumCheque = 0 then
          begin
            aviso('NÚMERO DO CHEQUE NÃO PREENCHIDO!!!'#13'É necessário preencher o numero do cheque quando a forma de pagamento é cheque.');
            Grade.Col := 5;
            VpaValidos := false;
          end
    end;
  end;

  if VpaValidos then
    EValCheques.Avalor := RValCheques(VprDBaixa.Cheques);
end;

{******************************************************************************}
procedure TFChequesCP.GradeGetEditMask(Sender: TObject; ACol, ARow: Integer;
  var Value: String);
begin
  case acol of
    1 : Value := '00000;0; ';
    5 : Value := '000000000;0; ';
    6 : Value := '000;0; ';
    8 : Value := FPrincipal.CorFoco.AMascaraData;
  end;
end;

{******************************************************************************}
procedure TFChequesCP.GradeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case  Key of
    114 :
        begin
          case Grade.Col of
            1 : EFormaPagamento.AAbreLocalizacao;
            3 : EContaCaixa.AAbreLocalizacao;
            5 : LocalizaCheque;
          end;
        end;
  end;
end;

{******************************************************************************}
procedure TFChequesCP.GradeKeyPress(Sender: TObject; var Key: Char);
begin
  case Grade.Col of
    2,4 : key := #0;
  end;
  if (key = '.') and  (Grade.col in [7]) then
    key := DecimalSeparator;
end;

{******************************************************************************}
procedure TFChequesCP.GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
  VpaLinhaAnterior: Integer);
begin
  if VprDBaixa.Cheques.Count > 0 then
  begin
    VprDCheque := TRBDCheque(VprDBaixa.Cheques.Items[VpaLinhaAtual -1]);
    VprCodFormaPagamentoAnterior := VprDCheque.CodFormaPagamento;
    VprNumChequeAnterior := VprDCheque.NumCheque;
  end;
end;

{******************************************************************************}
procedure TFChequesCP.GradeNovaLinha(Sender: TObject);
begin
  VprCodFormaPagamentoAnterior := 0;
  VprDCheque := VprDBaixa.AddCheque;
  VprDCheque.TipCheque := 'D';
  EContaCaixa.Text := VprDBaixa.NumContaCaixa;
  EContaCaixa.Atualiza;
  VprDCheque.CodFormaPagamento := VprDBaixa.CodFormaPAgamento;
  EFormaPagamento.AInteiro := VprDBaixa.CodFormaPAgamento;
  EFormaPagamento.Atualiza;
  VprDCheque.ValCheque := EValParcela.AValor - EValCheques.AValor;
  VprDCheque.DatVencimento := VprDBaixa.DatPagamento;
end;

{******************************************************************************}
procedure TFChequesCP.EFormaPagamentoRetorno(Retorno1, Retorno2: String);
begin
  Grade.Cells[1,Grade.ALinha] := EFormaPagamento.Text;
  Grade.cells[2,grade.ALinha] := Retorno1;
  VprDCheque.TipFormaPagamento := FunContasAReceber.RTipoFormaPagamento(Retorno2);
  ExisteFormaPagamento;
end;

{******************************************************************************}
procedure TFChequesCP.GradeSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  if Grade.AEstadoGrade in [egInsercao,EgEdicao] then
    if Grade.AColuna <> ACol then
    begin
      case Grade.AColuna of
        1 :if not ExisteFormaPagamento then
           begin
             if not EFormaPagamento.AAbreLocalizacao then
             begin
               Grade.Cells[1,Grade.ALinha] := '';
               abort;
             end;
           end;
        3 :if not ExisteContaCorrente then
           begin
             if not EContaCaixa.AAbreLocalizacao then
              begin
                Grade.Cells[3,Grade.ALinha]:='';
                abort;
              end;
           end;
        5 : if not ExisteCheque then
            begin
              if not LocalizaCheque then
              begin
                Grade.Cells[5,Grade.ALinha]:='';
                abort;
              end;
            end;
      end;
    end;
end;

{******************************************************************************}
procedure TFChequesCP.GradeDepoisExclusao(Sender: TObject);
begin
  EValCheques.Avalor := RValCheques(VprDBaixa.Cheques);
end;

{******************************************************************************}
procedure TFChequesCP.EFormaPagamentoChange(Sender: TObject);
begin
  FFormasPagamento := TFFormasPagamento.CriarSDI(self,'',FPrincipal.VerificaPermisao('FFormasPagamento'));
  FFormasPagamento.BotaoCadastrar1.Click;
  FFormasPagamento.showmodal;
  FFormasPagamento.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFChequesCP.EContaCaixaRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
  begin
    Grade.Cells[3,Grade.ALinha] := EContaCaixa.Text;
    Grade.cells[4,grade.ALinha] := Retorno1;
    VprDCheque.NumContaCaixa := EContaCaixa.Text;
    VprDCheque.NomContaCaixa := Retorno1;
    if VprDCheque.TipFormaPagamento = fpCheque Then
    begin
      VprDCheque.CodBanco := StrtoInt(Retorno2);
      Grade.Cells[6,Grade.Alinha] := retorno2;
      VprDCheque.NomEmitente := Retorno1;
      Grade.Cells[9,Grade.Alinha] := retorno1;
    end
    else
      if VprDCheque.TipFormaPagamento = fpChequeTerceiros Then //CHEQUES DE TERCEIRO
        VprDCheque.DatCompensacao := date;

  end
  else
  begin
    Grade.Cells[3,Grade.ALinha] := '';
    Grade.Cells[4,Grade.ALinha] := '';
    VprDCheque.NumContaCaixa :='';
  end;

end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFChequesCP]);
end.
