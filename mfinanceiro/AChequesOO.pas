unit AChequesOO;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Grids, CGrades, unDadosCR, unDados,
  StdCtrls, Buttons, Mask, numericos, Localizacao, UnDadosLocaliza;

type
  TRBDColunaGrade =(clCodBanco,clCodFormaPagamento,clNomFormaPagamento,clValCheque,clNomEmitente,clNumCheque,clDatVencimento,clNumContaCaixa,clNomContaCaixa,clDatEmissao,clCodCliente,clNomCliente, clNumConta, clNumAgencia);

  TFChequesOO = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    Grade: TRBStringGridColor;
    EFormaPagamento: TEditLocaliza;
    Localiza: TConsultaPadrao;
    EContaCaixa: TEditLocaliza;
    PanelColor4: TPanelColor;
    PanelColor2: TPanelColor;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    PanelColor3: TPanelColor;
    Label1: TLabel;
    Label2: TLabel;
    EValParcela: Tnumerico;
    EValCheques: Tnumerico;
    EBanco: TRBEditLocaliza;
    ECliente: TRBEditLocaliza;
    EEmitente: TRBEditLocaliza;
    CDuplicar: TCheckBox;
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
    procedure EBancoRetorno(VpaColunas: TRBColunasLocaliza);
    procedure EClienteRetorno(VpaColunas: TRBColunasLocaliza);
    procedure EEmitenteRetorno(VpaColunas: TRBColunasLocaliza);
    procedure EQtdParcelasKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    VprAcao,
    VprCadastrandoChequeAvulso : Boolean;
    VprNomCliente : String;
    VprCodFormaPagamentoAnterior : Integer;
    VprDBaixa : TRBDBaixaCR;
    VprDCheque,
    VprDChequeAnterior : TRBDCheque;
    function ExisteFormaPagamento : Boolean;
    function ExisteContaCorrente : Boolean;
    procedure CarTitulosGrade;
    procedure CarDChequeClasse;
    procedure CarDChequeClasseDuplicado;
    function RColunaGrade(VpaColuna : TRBDColunaGrade):Integer;
  public
    { Public declarations }
    function CadastraCheques(VpaDBaixa : TRBDBaixaCR) : boolean;
    procedure ConsultaCheques(VpaCheques : TList);
    function CadastraChequesAvulso : Boolean;
  end;

var
  FChequesOO: TFChequesOO;

implementation

uses APrincipal,Constantes, funData, funString,ConstMsg, unContasAReceber,
  AFormasPagamento, unClientes;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFChequesOO.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao := false;
  VprCadastrandoChequeAvulso := false;
  CarTitulosGrade;
  VprDChequeAnterior := TRBDCheque.cria;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFChequesOO.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
function TFChequesOO.ExisteFormaPagamento : Boolean;
begin
  result := false;
  if Grade.Cells[rcolunagrade(clCodFormaPagamento),Grade.ALinha] <> '' then
  begin
    if StrToInt(Grade.Cells[RColunaGrade(clCodFormaPagamento),Grade.ALinha]) = VprCodFormaPagamentoAnterior then
    result := true
    else
    begin
      result := FunContasAReceber.ExisteFormaPagamento(StrToInt(Grade.Cells[RColunaGrade(clCodFormaPagamento),Grade.ALinha]));
      if result then
      begin
        EFormaPagamento.Text := Grade.Cells[RColunaGrade(clCodFormaPagamento),Grade.ALinha];
        EFormaPagamento.Atualiza;
      end;
    end;
  end;
end;

{******************************************************************************}
function TFChequesOO.ExisteContaCorrente : Boolean;
begin
  result := false;
  if Grade.Cells[RColunaGrade(clNumContaCaixa),Grade.ALinha] <> '' then
  begin
    result := FunContasAReceber.ExisteContaCorrente(Grade.Cells[RColunaGrade(clNumContaCaixa),Grade.ALinha]);
    if result then
    begin
      EContaCaixa.Text := Grade.Cells[RColunaGrade(clNumContaCaixa),Grade.ALinha];
      EContaCaixa.Atualiza;
    end;
  end;
end;

{******************************************************************************}
procedure TFChequesOO.CarTitulosGrade;
begin
  Grade.Cells[RColunaGrade(clCodBanco),0] := 'Banco';
  Grade.Cells[RColunaGrade(clCodFormaPagamento),0] := 'Código';
  Grade.Cells[RColunaGrade(clNomFormaPagamento),0] := 'Forma Pagamento';
  Grade.Cells[RColunaGrade(clValCheque),0] := 'Valor';
  Grade.Cells[RColunaGrade(clNomEmitente),0] := 'Emitente';
  Grade.Cells[RColunaGrade(clNumCheque),0] := 'Nro Cheque';
  Grade.Cells[RColunaGrade(clDatVencimento),0] := 'Vencimento';
  Grade.Cells[RColunaGrade(clNumContaCaixa),0] := 'Conta Caixa';
  Grade.Cells[RColunaGrade(clNomContaCaixa),0] := 'Descrição';
  Grade.Cells[RColunaGrade(clDatEmissao),0] := 'Data Emissão';
  Grade.Cells[RColunaGrade(clCodCliente),0] := 'Código';
  Grade.Cells[RColunaGrade(clNomCliente),0] := 'Cliente';
  Grade.Cells[RColunaGrade(clNumConta),0] := 'Nro Conta';
  Grade.Cells[RColunaGrade(clNumAgencia),0] := 'Nro Agencia';
end;

{******************************************************************************}
procedure TFChequesOO.CarDChequeClasse;
begin
  if Grade.Cells[RColunaGrade(clCodBanco),Grade.ALinha] <> '' then
    VprDCheque.CodBanco := StrToInt(Grade.Cells[RColunaGrade(clCodBanco),Grade.ALinha])
  else
    VprDCheque.CodBanco := 0;
  if Grade.Cells[RColunaGrade(clCodFormaPagamento),Grade.ALinha] <> '' then
    VprDCheque.CodFormaPagamento := StrToInt(Grade.Cells[RColunaGrade(clCodFormaPagamento),Grade.ALinha])
  else
    VprDCheque.CodFormaPagamento := 0;
  VprDCheque.ValCheque := StrToFloat(DeletaChars(Grade.Cells[RColunaGrade(clValCheque),Grade.ALinha],'.'));
  VprDCheque.NomEmitente := UpperCase(Grade.Cells[RColunaGrade(clNomEmitente),Grade.alinha]);
  if Grade.Cells[RColunaGrade(clNumCheque),Grade.ALinha] <> '' then
    VprDCheque.NumCheque := StrToInt(Grade.Cells[RColunaGrade(clNumCheque),Grade.ALinha])
  else
    VprDCheque.NumCheque := 0;
  try
    VprDCheque.DatVencimento := StrToDate(Grade.Cells[RColunaGrade(clDatVencimento),Grade.ALinha])
  except
    VprDCheque.DatVencimento :=  MontaData(1,1,1900);
  end;
  VprDCheque.NumContaCaixa := Grade.Cells[RColunaGrade(clNumContaCaixa),Grade.ALinha];
  if Grade.Cells[RColunaGrade(clCodCliente),Grade.ALinha] <> '' then
    VprDCheque.CodCliente := StrToInt(Grade.Cells[RColunaGrade(clCodCliente),Grade.ALinha])
  else
    VprDCheque.CodCliente := 0;
  VprDCheque.CodUsuario := varia.CodigoUsuario;
  VprDCheque.DatCadastro := now;
  try
    VprDCheque.DatEmissao := StrToDate(Grade.Cells[RColunaGrade(clDatEmissao),Grade.ALinha])
  except
    VprDCheque.DatEmissao :=  MontaData(1,1,1900);
  end;
  if Grade.Cells[RColunaGrade(clNumConta),Grade.ALinha] <> '' then
    VprDCheque.NumConta := StrToInt(Grade.Cells[RColunaGrade(clNumConta),Grade.ALinha])
  else
    VprDCheque.NumConta := 0;

  if Grade.Cells[RColunaGrade(clNumAgencia),Grade.ALinha] <> '' then
    VprDCheque.NumAgencia := StrToInt(Grade.Cells[RColunaGrade(clNumAgencia),Grade.ALinha])
  else
    VprDCheque.NumAgencia := 0;
  FunContasAReceber.CopiaDCheque(VprDCheque,VprDChequeAnterior);
end;


{******************************************************************************}
procedure TFChequesOO.CarDChequeClasseDuplicado;
begin
  if Grade.Cells[RColunaGrade(clCodBanco),Grade.ALinha-1] <> '' then
    VprDCheque.CodBanco := StrToInt(Grade.Cells[RColunaGrade(clCodBanco),1])
  else
    VprDCheque.CodBanco := 0;
  if Grade.Cells[RColunaGrade(clCodFormaPagamento),1] <> '' then
    VprDCheque.CodFormaPagamento := StrToInt(Grade.Cells[RColunaGrade(clCodFormaPagamento),1])
  else
    VprDCheque.CodFormaPagamento := 0;
  VprDCheque.NomFormaPagamento:= Grade.Cells[RColunaGrade(clNomFormaPagamento),1];
  VprDCheque.ValCheque := StrToFloat(DeletaChars(Grade.Cells[RColunaGrade(clValCheque),1],'.'));
  VprDCheque.NomEmitente := Grade.Cells[RColunaGrade(clNomEmitente),1];
  if Grade.Cells[RColunaGrade(clNumCheque),1] <> '' then
    VprDCheque.NumCheque := StrToInt(Grade.Cells[RColunaGrade(clNumCheque),1])
  else
    VprDCheque.NumCheque := 0;
  try
    VprDCheque.DatVencimento := StrToDate(Grade.Cells[RColunaGrade(clDatVencimento),1])
  except
    VprDCheque.DatVencimento :=  MontaData(1,1,1900);
  end;
  VprDCheque.NumContaCaixa := Grade.Cells[RColunaGrade(clNumContaCaixa),1];
  VprDCheque.NomContaCaixa:= Grade.Cells[RColunaGrade(clNomContaCaixa),1];
  if Grade.Cells[RColunaGrade(clCodCliente),1] <> '' then
    VprDCheque.CodCliente := StrToInt(Grade.Cells[RColunaGrade(clCodCliente),1])
  else
    VprDCheque.CodCliente := 0;
  VprDCheque.NomCliente:= Grade.Cells[RColunaGrade(clNomCliente),1];
  VprDCheque.CodUsuario := varia.CodigoUsuario;
  VprDCheque.DatCadastro := now;
  try
    VprDCheque.DatEmissao := StrToDate(Grade.Cells[RColunaGrade(clDatEmissao),1])
  except
    VprDCheque.DatEmissao :=  MontaData(1,1,1900);
  end;
  if Grade.Cells[RColunaGrade(clNumConta),1] <> '' then
    VprDCheque.NumConta := StrToInt(Grade.Cells[RColunaGrade(clNumConta),1])
  else
    VprDCheque.NumConta := 0;

  if Grade.Cells[RColunaGrade(clNumAgencia),1] <> '' then
    VprDCheque.NumAgencia := StrToInt(Grade.Cells[RColunaGrade(clNumAgencia),1])
  else
    VprDCheque.NumAgencia := 0;
end;

{******************************************************************************}
function TFChequesOO.CadastraCheques(VpaDBaixa : TRBDBaixaCR) : boolean;
begin
  VprDBaixa := VpaDBaixa;
  VprDBaixa.Cheques := VpaDBaixa.Cheques;
  Grade.ADados := VprDBaixa.Cheques;
  Grade.CarregaGrade;
  EValParcela.AValor := VpaDBaixa.ValorPago;
  if VpaDBaixa.Parcelas.Count > 0 then
    VprNomCliente := FunClientes.RNomCliente(InttoStr(TRBDParcelaBaixaCR(VpaDBaixa.Parcelas.Items[0]).CodCliente));
  EValCheques.Avalor := FunContasAReceber.RValTotalCheques(VprDBaixa.Cheques);
  showmodal;
  result := VprAcao;
end;

{******************************************************************************}
procedure TFChequesOO.ConsultaCheques(VpaCheques : TList);
begin
  VprDBaixa := TRBDBaixaCR.cria;
  VprDBaixa.Cheques := VpaCheques;
  Grade.ADados := VpaCheques;
  Grade.CarregaGrade;
  show;
end;

{******************************************************************************}
function TFChequesOO.CadastraChequesAvulso : Boolean;
begin
  VprCadastrandoChequeAvulso := true;
  VprDBaixa := TRBDBaixaCR.Cria;
  Grade.ADados := VprDBaixa.Cheques;
  Grade.CarregaGrade;
  EValParcela.AValor := VprDBaixa.ValorPago;
  EValCheques.Avalor := FunContasAReceber.RValTotalCheques(VprDBaixa.Cheques);

  EFormaPagamento.ASelectValida.text := 'Select I_COD_FRM, C_NOM_FRM, C_FLA_TIP '+
                                        ' from CADFORMASPAGAMENTO ' +
                                        ' Where I_COD_FRM =@ '+
                                        ' AND C_FLA_TIP IN (''C'',''R'',''P'') ';

  EFormaPagamento.ASelectLocaliza.text := 'Select I_COD_FRM, C_NOM_FRM, C_FLA_TIP '+
                                        ' from CADFORMASPAGAMENTO ' +
                                        ' Where C_NOM_FRM Like ''@%''' +
                                        ' AND C_FLA_TIP IN (''C'',''R'',''P'') '+
                                        ' order by C_NOM_FRM  ';
  showmodal;
  FunContasAReceber.GravaDCheques(VprDBaixa.Cheques);
  result := VprAcao;
end;

{******************************************************************************}
procedure TFChequesOO.BGravarClick(Sender: TObject);
var
  VpfValoresOk : Boolean;
begin
  VpfValoresOk := true;
  if not VprCadastrandoChequeAvulso then
    if EValParcela.AValor <> EValCheques.AValor then
      VpfValoresOk := confirmacao('VALORES DIFERENTES!!!'#13'O Valor da parcela é diferente da somatória dos cheques. Tem certeza que deseja continuar?');
  if VpfValoresOk then
  begin
    VprAcao := true;
    Close;
  end;
end;

{******************************************************************************}
procedure TFChequesOO.BCancelarClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFChequesOO.GradeCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDCheque := TRBDCheque(VprDBaixa.Cheques.Items[VpaLinha-1]);
  if VprDCheque.CodBanco <> 0 then
    Grade.Cells[RColunaGrade(clCodBanco),Grade.ALinha] := IntToStr(VprDCheque.CodBanco)
  else
    Grade.Cells[RColunaGrade(clCodBanco),Grade.ALinha] := '';
  if VprDCheque.CodFormaPagamento <> 0 then
    Grade.Cells[RColunaGrade(clCodFormaPagamento),Grade.ALinha] := IntToStr(VprDCheque.CodFormaPagamento)
  else
    Grade.Cells[RColunaGrade(clCodBanco),Grade.ALinha] := '';
  Grade.Cells[RColunaGrade(clNomFormaPagamento),Grade.ALinha] := VprDCheque.NomFormaPagamento;
  Grade.Cells[RColunaGrade(clValCheque),Grade.ALinha] := FormatFloat(varia.MascaraValor,VprDCheque.ValCheque);
  Grade.Cells[RColunaGrade(clNomEmitente),Grade.ALinha] := VprDCheque.NomEmitente;
  if VprDCheque.NumCheque <> 0 then
    Grade.cells[RColunaGrade(clNumCheque),Grade.ALinha] := IntToStr(VprDCheque.NumCheque)
  else
    Grade.cells[RColunaGrade(clNumCheque),Grade.ALinha] := '';
  if VprDCheque.DatVencimento > MontaData(1,1,1900) then
    Grade.Cells[RColunaGrade(clDatVencimento),Grade.ALinha]:= FormatDateTime('DD/MM/YYYY',VprDCheque.DatVencimento)
  else
    Grade.Cells[RColunaGrade(clDatVencimento),Grade.ALinha] := '';
  Grade.cells[RColunaGrade(clNumContaCaixa),Grade.ALinha] := VprDCheque.NumContaCaixa;
  Grade.cells[RColunaGrade(clNomContaCaixa),Grade.ALinha] := VprDCheque.NomContaCaixa;
  if VprDCheque.DatEmissao > MontaData(1,1,1900) then
    Grade.Cells[RColunaGrade(clDatEmissao),Grade.ALinha]:= FormatDateTime('DD/MM/YYYY',VprDCheque.DatEmissao)
  else
    Grade.Cells[RColunaGrade(clDatEmissao),Grade.ALinha] := '';
  if VprDCheque.CodCliente <> 0 then
    Grade.Cells[RColunaGrade(clCodCliente),Grade.ALinha] := IntToStr(VprDCheque.CodCliente)
  else
    Grade.Cells[RColunaGrade(clCodCliente),Grade.ALinha] := '';
  Grade.Cells[RColunaGrade(clNomCliente),Grade.ALinha] := VprDCheque.NomCliente;
  Grade.Cells[RColunaGrade(clNumConta),Grade.ALinha] := IntToStr(VprDCheque.NumConta);
  Grade.Cells[RColunaGrade(clNumAgencia),Grade.ALinha] := IntToStr(VprDCheque.NumAgencia);
end;

{******************************************************************************}
procedure TFChequesOO.GradeDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos := true;
  if not ExisteFormaPagamento then
  begin
    aviso('FORMA DE PAGAMENTO INVÁLIDA!!!'#13'A forma de pagamento digitada não é valida ou não foi preechida.');
    Vpavalidos := false;
    Grade.Col := RColunaGrade(clCodFormaPagamento);
  end
  else
    if Grade.Cells[4,Grade.ALinha] = '' then
    begin
      aviso('VALOR NÃO PREENCHIDO!!!'#13'É necessário preencher o valor.');
      Vpavalidos := false;
      Grade.Col := RColunaGrade(clValCheque);
    end
    else
      if not ExisteContaCorrente  then
      begin
        aviso('CONTA CAIXA INVALIDA!!!'#13'A conta caixa digitada não é válida ou não foi preenchida.');
        Vpavalidos := false;
        Grade.Col := RColunaGrade(clNumContaCaixa);
      end
      else
        if not ECliente.AExisteCodigo(Grade.Cells[RColunaGrade(clCodCliente),Grade.ALinha]) then
        begin
          aviso('CLIENTE NÃO CADASTRADO!!!'#13'O cliente digitado não existe cadastrado.');
          Grade.Col := RColunaGrade(clCodCliente);
        end;

  if VpaValidos then
  begin
    CarDChequeClasse;
    if VprDCheque.DatVencimento <= MontaData(1,1,1900) then
    begin
      aviso('VENCIMENTO INVÁLIDO!!!'#13'A data de vencimento preenchida é inválida.');
      Vpavalidos := false;
      Grade.Col := RColunaGrade(clDatVencimento);
    end
    else
      if VprDCheque.ValCheque = 0  then
      begin
        aviso('VALOR INVÁLIDO!!!'#13'O valor preenchido é inválido.');
        Vpavalidos := false;
        Grade.Col := RColunaGrade(clValCheque);
    end

  end;
  if VpaValidos then
  begin
    if (VprDCheque.TipFormaPagamento in [fpCheque,fpChequeTerceiros])then //cheque, cheque de terceiro
    begin
      if VprDCheque.CodBanco = 0 then
      begin
        aviso('CÓDIGO DO BANCO NÃO PREENCHIDO!!!'#13'É necessário preencher o codigo do banco quando a forma de pagamento é cheque.');
        Grade.Col := RColunaGrade(clCodBanco);
        VpaValidos := false;
      end
      else
        if VprDCheque.NomEmitente = '' then
        begin
          aviso('NOME DO EMITENTE NÃO PREENCHIDO!!!'#13'É necessário preencher o nome do emitente quando a forma de pagamento é cheque.');
          Grade.Col := RColunaGrade(clNomEmitente);
          VpaValidos := false;
        end
        else
          if VprDCheque.NumCheque = 0 then
          begin
            aviso('NÚMERO DO CHEQUE NÃO PREENCHIDO!!!'#13'É necessário preencher o numero do cheque quando a forma de pagamento é cheque.');
            Grade.Col := RColunaGrade(clNumCheque);
            VpaValidos := false;
          end
    end;
  end;

  if VpaValidos then
    EValCheques.Avalor := FunContasAReceber.RValTotalCheques(VprDBaixa.Cheques);
end;

{******************************************************************************}
procedure TFChequesOO.GradeGetEditMask(Sender: TObject; ACol, ARow: Integer;
  var Value: String);
begin
  if ACol = RColunaGrade(clCodBanco) then
    Value := '000;0; '
  else
    if (ACol = RColunaGrade(clCodFormaPagamento)) or
       (ACol = RColunaGrade(clCodCliente)) then
      Value := '000000;0; '
    else
      if ACol = RColunaGrade(clNumCheque) then
        Value := '000000000;0; '
      else
        if (ACol = RColunaGrade(clDatVencimento)) or
           (ACol = RColunaGrade(clDatEmissao)) then
          Value := FPrincipal.CorFoco.AMascaraData;
end;

{******************************************************************************}
procedure TFChequesOO.GradeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case  Key of
    114 :
        begin
          if RColunaGrade(clCodBanco) = Grade.Col then
            EBanco.AAbreLocalizacao
          else
            if RColunaGrade(clCodFormaPagamento) = Grade.Col then
              EFormaPagamento.AAbreLocalizacao
            else
              if RColunaGrade(clNomEmitente) = Grade.Col then
                EEmitente.AAbreLocalizacao
              else
                if RColunaGrade(clNumContaCaixa) = Grade.Col then
                  EContaCaixa.AAbreLocalizacao
                else
                  if RColunaGrade(clCodCliente) = Grade.Col then
                    ECliente.AAbreLocalizacao
        end;
  end;
end;

{******************************************************************************}
procedure TFChequesOO.GradeKeyPress(Sender: TObject; var Key: Char);
begin
  if (RColunaGrade(clNomFormaPagamento) = Grade.Col) or
     (RColunaGrade(clNomCliente) = Grade.Col) or
     (RColunaGrade(clNomContaCaixa) = Grade.Col) then
    key := #0;

  if (key = '.') and  (RColunaGrade(clValCheque) = Grade.Col) then
    key := DecimalSeparator;
end;

{******************************************************************************}
procedure TFChequesOO.GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
  VpaLinhaAnterior: Integer);
begin
  if VprDBaixa.Cheques.Count > 0 then
  begin
    VprDCheque := TRBDCheque(VprDBaixa.Cheques.Items[VpaLinhaAtual -1]);
    VprCodFormaPagamentoAnterior := VprDCheque.CodFormaPagamento;
  end;
end;

{******************************************************************************}
procedure TFChequesOO.GradeNovaLinha(Sender: TObject);
begin
  VprDCheque := VprDBaixa.AddCheque;
  if VprDBaixa.Parcelas.Count > 0 then
  begin
    if VprDBaixa.IndContaOculta then
      VprDCheque.IdeOrigem := 'S'
    else
      VprDCheque.IdeOrigem := 'N';
  end
  else
    VprDCheque.IdeOrigem := 'A';

  VprDCheque.TipCheque := 'C';
  EContaCaixa.Text := VprDBaixa.NumContaCaixa;
  EContaCaixa.Atualiza;
  VprDCheque.CodFormaPagamento := VprDBaixa.CodFormaPAgamento;
  EFormaPagamento.AInteiro := VprDBaixa.CodFormaPAgamento;
  EFormaPagamento.Atualiza;
  if not VprCadastrandoChequeAvulso then
    VprDCheque.ValCheque := VprDBaixa.ValorPago - EValCheques.AValor;
  VprDCheque.DatVencimento := VprDBaixa.DatPagamento;

  EValCheques.Avalor := FunContasAReceber.RValTotalCheques(VprDBaixa.Cheques);
  if CDuplicar.Checked then
  begin
    if VprDChequeAnterior.CodBanco <> 0 then
    begin
      FunContasAReceber.CopiaDCheque(VprDChequeAnterior,VprDCheque);
      Grade.CarregaGrade(true);
      Grade.Col := RColunaGrade(clNumCheque);
    end;
  end;
end;

{******************************************************************************}
procedure TFChequesOO.EFormaPagamentoRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
  begin
    Grade.Cells[RColunaGrade(clCodFormaPagamento) ,Grade.ALinha] := EFormaPagamento.Text;
    Grade.cells[RColunaGrade(clNomFormaPagamento),grade.ALinha] := Retorno1;
    VprDCheque.TipFormaPagamento :=  FunContasAReceber.RTipoFormaPagamento(Retorno2);
    VprDCheque.CodFormaPagamento := EFormaPagamento.AInteiro;
    VprDCheque.NomFormaPagamento := Retorno1;
    VprCodFormaPagamentoAnterior := VprDCheque.CodFormaPagamento;
    if VprDCheque.TipFormaPagamento =fpCheque then
    begin
      VprDCheque.NomEmitente := VprNomCliente;
      Grade.Cells[RColunaGrade(clNomEmitente),Grade.ALinha] := VprNomCliente;
    end;
  end
  else
  begin
    Grade.Cells[RColunaGrade(clCodFormaPagamento),Grade.ALinha] := '';
    Grade.Cells[RColunaGrade(clNomFormaPagamento),Grade.ALinha] := '';
    VprDCheque.CodFormaPagamento :=0;
  end;
end;

{******************************************************************************}
procedure TFChequesOO.EQtdParcelasKeyPress(Sender: TObject; var Key: Char);
begin
  if (not (Key in [ '0'..'9',#8,#13])) then  // somente permite digitar numeros
   key := #0;
end;

{******************************************************************************}
procedure TFChequesOO.GradeSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  if Grade.AEstadoGrade in [egInsercao,EgEdicao] then
    if Grade.AColuna <> ACol then
    begin
      if RColunaGrade(clCodFormaPagamento) = Grade.AColuna then
      begin
        if not ExisteFormaPagamento then
           begin
             if not EFormaPagamento.AAbreLocalizacao then
             begin
               Grade.Cells[RColunaGrade(clCodFormaPagamento),Grade.ALinha] := '';
               abort;
             end;
           end;
      end
      else
        if RColunaGrade(clNumContaCaixa) = Grade.AColuna then
        begin
          if not ExisteContaCorrente then
          begin
            if not EContaCaixa.AAbreLocalizacao then
            begin
              Grade.Cells[RColunaGrade(clNumContaCaixa),Grade.ALinha]:='';
              abort;
            end;
          end;
        end
      //cliente
      else
        if RColunaGrade(clCodCliente) = Grade.AColuna then
        begin
          if not ECliente.AExisteCodigo(Grade.Cells[RColunaGrade(clCodCliente),Grade.ALinha]) then
          begin
            if not ECliente.AAbreLocalizacao then
            begin
              Grade.Cells[RColunaGrade(clCodBanco),Grade.ALinha]:='';
              abort;
            end;
          end;
        end;
    end;
end;

{******************************************************************************}
function TFChequesOO.RColunaGrade(VpaColuna: TRBDColunaGrade): Integer;
begin
  case VpaColuna of
    clCodBanco: result:=1;
    clCodFormaPagamento: result:=2;
    clNomFormaPagamento : result:=3;
    clValCheque: result:=4;
    clNomEmitente:result:=5;
    clNumCheque: result:=6;
    clDatVencimento: result:=7;
    clNumContaCaixa: result:=8;
    clNomContaCaixa: result:=9;
    clDatEmissao: result:=10;
    clCodCliente : result := 11;
    clNomCliente : result := 12;
    clNumConta : Result:=13;
    clNumAgencia : Result:= 14;
  end;
end;

{******************************************************************************}
procedure TFChequesOO.GradeDepoisExclusao(Sender: TObject);
begin
  EValCheques.Avalor := FunContasAReceber.RValTotalCheques(VprDBaixa.Cheques);
end;

{******************************************************************************}
procedure TFChequesOO.EFormaPagamentoChange(Sender: TObject);
begin
  FFormasPagamento := TFFormasPagamento.CriarSDI(self,'',FPrincipal.VerificaPermisao('FFormasPagamento'));
  FFormasPagamento.BotaoCadastrar1.Click;
  FFormasPagamento.showmodal;
  FFormasPagamento.free;
  Localiza.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFChequesOO.EClienteRetorno(VpaColunas: TRBColunasLocaliza);
begin
  Grade.Cells[RColunaGrade(clCodCliente),Grade.ALinha] := VpaColunas[0].AValorRetorno;
  Grade.Cells[RColunaGrade(clNomCliente),Grade.ALinha] := VpaColunas[1].AValorRetorno;
  if VpaColunas[0].AValorRetorno <> '' then
  begin
    VprDCheque.CodCliente := StrToInt(VpaColunas[0].AValorRetorno);
    VprDCheque.NomCliente := VpaColunas[1].AValorRetorno;
  end
  else
  begin
    VprDCheque.CodCliente := 0;
    VprDCheque.NomCliente := '';
  end;
end;

{******************************************************************************}
procedure TFChequesOO.EContaCaixaRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
  begin
    Grade.Cells[RColunaGrade(clNumContaCaixa),Grade.ALinha] := EContaCaixa.Text;
    Grade.cells[RColunaGrade(clNomContaCaixa),grade.ALinha] := Retorno1;
    VprDCheque.NumContaCaixa := EContaCaixa.Text;
    VprDCheque.NomContaCaixa := Retorno1;
    VprDCheque.TipContaCaixa := Retorno2;
  end
  else
  begin
    Grade.Cells[RColunaGrade(clNumContaCaixa),Grade.ALinha] := '';
    Grade.Cells[RColunaGrade(clNomContaCaixa),Grade.ALinha] := '';
    VprDCheque.NumContaCaixa :='';
  end;
end;

procedure TFChequesOO.EEmitenteRetorno(VpaColunas: TRBColunasLocaliza);
begin
  if EEmitente.AInteiro <> 0 then
  begin
    Grade.Cells[RColunaGrade(clNomEmitente),Grade.ALinha] := VpaColunas[1].AValorRetorno;
    ECliente.Text := EEmitente.Text;
    ECliente.Atualiza;
  end
end;

{******************************************************************************}
procedure TFChequesOO.EBancoRetorno(VpaColunas: TRBColunasLocaliza);
begin
  Grade.Cells[RColunaGrade(clCodBanco),Grade.ALinha] := VpaColunas[0].AValorRetorno;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFChequesOO]);
end.
