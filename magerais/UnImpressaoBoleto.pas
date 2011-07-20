unit UnImpressaoBoleto;
{Verificado
-.edit;
}
interface

uses UnContasAReceber, Classes, gbCobranca, UnClassesImprimir, DBTables, UnDados, UnDadosCR, SysUtils,
     SQLExpr,db;

type
  TImpressaoBoleto = class
    private
      Tabela: TSQLQuery;
      procedure CarDCaixaEconomica(VpaContaCorrente : String;VpaCendente : TgbPessoa);
      procedure CarDCedente(VpaDContasAReceber : TRBDContasCR;VpaDParcela :TRBDMovContasCR;VpaTitulo : TgbTitulo);
      procedure CarDTitulo(VpaDContasAReceber : TRBDContasCR;VpaDParcela : TRBDMovContasCR;VpaTitulo : TgbTitulo);
      procedure CarDSacado(VpaDCliente : TRBDCliente;VpaTitulo : TgbTitulo);
      procedure CarDInstrucoes(VpaDParcela : TRBDMovContasCR;VpaTitulo : TgbTitulo);
      procedure MontaEmailHTML(VpaDCliente : TRBDCliente;VpaTExto : TStringList);
    public
      Constructor cria(VpaBaseDados : TSqlConnection);
      Destructor destroy; override;
      procedure ImprimeBoleto(VpaCodFilial,VpaLanReceber,VpaNumParcela : integer;VpaDCliente : TRBDCliente;VpaPreview: boolean;VpaImpressora : String;VpaEnviarEmail : boolean);
      function GeraPDFBoleto(VpaCodFilial,VpaLanReceber,VpaNumParcela : integer;VpaDCliente : TRBDCliente):string;
  end;

implementation

uses  FunSql, FunString, Constantes, FunDAta, UnSistema, FunArquivos;

{******************************************************************************}
Constructor TImpressaoBoleto.cria(VpaBaseDados : TSqlConnection);
begin
  inherited Create;
  Tabela := TSQLQuery.Create(nil);
  Tabela.SQLCOnnection := VpaBaseDados;
end;

{******************************************************************************}
Destructor TImpressaoBoleto.destroy;
begin
  Tabela.Free;
  inherited destroy;
end;

{******************************************************************************}
function TImpressaoBoleto.GeraPDFBoleto(VpaCodFilial, VpaLanReceber,VpaNumParcela: integer; VpaDCliente: TRBDCliente): string;
var
  VpfBoleto : TgbTitulo;
  VpfDContasReceber : TRBDContasCR;
  vpfDParcela : TRBDMovContasCR;
  VpfTextoEmail : TStringList;
begin
  VpfBoleto := TgbTitulo.Create(nil);
  VpfDContasReceber := TRBDContasCR.cria;
  VpfBoleto.DiretorioAnexo := varia.PathVersoes+'\Anexos\BOLETO\';
  NaoExisteCriaDiretorio(VpfBoleto.DiretorioAnexo,false);

  vpfDParcela := TRBDMovContasCR.cria;
  FunContasAReceber.CarDContasReceber(IntToStr(VpaCodFilial),IntToStr(VpaLanReceber),VpfDContasReceber,false);
  FunContasAReceber.LocalizaParcela(Tabela,VpaCodFilial,VpaLanReceber,VpaNumParcela);
  FunContasAReceber.CarDMovContasCR(Tabela,vpfDParcela);

  CarDTitulo(VpfDContasReceber,vpfDParcela,VpfBoleto);
  CarDCedente(VpfDContasReceber,vpfDParcela,VpfBoleto);
  CarDSacado(VpaDCliente,VpfBoleto);
  CarDInstrucoes(vpfDParcela,VpfBoleto);

  result := VpfBoleto.geraPDF;

  if Config.AdicionarRemessaAoImprimirBoleto then
    FunContasAReceber.AdicionaRemessa(VpaCodFilial,VpaLanReceber,VpaNumParcela,1,'Remessa');

  VpfBoleto.Free;
end;

{******************************************************************************}
procedure TImpressaoBoleto.CarDCedente(VpaDContasAReceber : TRBDContasCR;VpaDParcela :TRBDMovContasCR; VpaTitulo : TgbTitulo);
var
  VpfDFilial : TRBDFilial;
begin
  VpfDFilial := TRBDFilial.cria;
  Sistema.CarDFilial(VpfDFilial,VpaDContasAReceber.CodEmpFil);
  VpaTitulo.Cedente.CodigoCedente := CopiaAteChar(VpaDParcela.NroContaBoleto,'-');
  VpaTitulo.Cedente.DigitoCodigoCedente := DeleteAteChar(VpaDParcela.NroContaBoleto,'-');
  VpaTitulo.Cedente.TipoInscricao := tiPessoaJuridica;
  VpaTitulo.Cedente.NumeroCPFCGC := VpfDFilial.DesCNPJ;
  VpaTitulo.Cedente.Nome := VpfDFilial.NomFantasia;

  VpaTitulo.Cedente.Endereco.Rua := VpfDFilial.DesEndereco;
  VpaTitulo.Cedente.Endereco.Bairro := VpfDFilial.DesBairro;
  VpaTitulo.Cedente.Endereco.Cidade := VpfDFilial.DesBairro;
  if varia.emailECobranca <> '' then
    VpaTitulo.Cedente.Endereco.EMail := varia.emailECobranca
  else
    VpaTitulo.Cedente.Endereco.EMail := varia.EMailFilial;
  VpaTitulo.Cedente.Endereco.Estado := VpfDFilial.DesUF;
  VpaTitulo.Cedente.Endereco.CEP := VpfDFilial.DesCep;

  VpaTitulo.Cedente.ContaBancaria.Banco.Codigo := IntToStr(VpaDParcela.CodBanco);
  VpaTitulo.Cedente.ContaBancaria.CodigoAgencia := CopiaAtechar(VpaDParcela.NroAgencia,'-');
  VpaTitulo.Cedente.ContaBancaria.DigitoAgencia := DeleteAteChar(VpaDParcela.NroAgencia,'-');
  VpaTitulo.Cedente.ContaBancaria.NumeroConta := CopiaAteChar(VpaDParcela.NroContaBoleto,'-');
  VpaTitulo.Cedente.ContaBancaria.DigitoConta := DeleteAteChar(VpaDParcela.NroContaBoleto,'-');
  VpaTitulo.Cedente.ContaBancaria.NomeCliente := VpfDFilial.NomFilial;
  if VpaDParcela.CodBanco = 104 then
    CarDCaixaEconomica(VpaDParcela.NroContaBoleto,VpaTitulo.Cedente); ;
  VpfDFilial.Free;
end;

{******************************************************************************}
procedure TImpressaoBoleto.CarDCaixaEconomica(VpaContaCorrente : String;VpaCendente : TgbPessoa);
begin
  AdicionaSQLAbreTabela(Tabela,'Select C_CON_BAN from CADCONTAS '+
                               ' Where C_NRO_CON = '''+VpaContaCorrente+'''');
  VpaCendente.ContaBancaria.ContaCaixa := Tabela.FieldByname('C_CON_BAN').AsString;
  Tabela.close;
end;

{******************************************************************************}
procedure TImpressaoBoleto.CarDTitulo(VpaDContasAReceber : TRBDContasCR;VpaDParcela : TRBDMovContasCR; VpaTitulo : TgbTitulo);
begin
  AdicionaSQLAbreTabela(Tabela,'Select * from CADCONTAS '+
                               ' Where C_NRO_CON = '''+ VpaDParcela.NroContaBoleto +'''');
  VpaTitulo.CodFilial := VpaDContasAReceber.CodEmpFil;
  VpaTitulo.LanReceber := VpaDContasAReceber.LanReceber;
  VpaTitulo.NumParcela := VpaDParcela.NumParcela;
  VpaTitulo.SeuNumero := VpaDParcela.NroDuplicata;
  VpaTitulo.NossoNumero := VpaDParcela.NossoNumero;
  VpaTitulo.Carteira := Tabela.FieldByName('I_NUM_CAR').AsString;
  VpaTitulo.DataDocumento := VpaDContasAReceber.DatMov;
  if VpaDParcela.DatVencimento < date then
  begin
    if VpaDParcela.DatProrrogacao > date then
      VpaTitulo.DataVencimento := VpaDParcela.DatProrrogacao
    else
      VpaTitulo.DataVencimento := IncDia(date, Varia.QtdDiasVencimentoBoletoVencido);
    VpaTitulo.ValorDocumento := VpaDParcela.Valor +VpaDParcela.ValAcrescimo+VpaDParcela.ValTarifasBancarias;
  end
  else
  begin
    VpaTitulo.DataVencimento := VpaDParcela.DatVencimento;
    VpaTitulo.ValorDocumento := VpaDParcela.Valor;
  end;

  Tabela.Close;
end;

{******************************************************************************}
procedure TImpressaoBoleto.CarDSacado(VpaDCliente : TRBDCliente;VpaTitulo : TgbTitulo);
begin
  if VpaDCliente.TipoPessoa = 'J' then
    VpaTitulo.Sacado.TipoInscricao := tiPessoaJuridica
  else
    VpaTitulo.Sacado.TipoInscricao := tiPessoaFisica;

  VpaTitulo.Sacado.NumeroCPFCGC := DeletaChars(DeletaChars(DeletaChars(VpaDCliente.CGC_CPF,'.'),'/'),'-');
  VpaTitulo.Sacado.Nome := InttoStr(VpaDCliente.CodCliente) +'-'+ VpaDCliente.NomCliente;
  if VpaDCliente.DesEnderecoCobranca <> '' then
  begin
    VpaTitulo.Sacado.Endereco.Rua := VpaDCliente.DesEnderecoCobranca;
    VpaTitulo.Sacado.Endereco.Numero := VpaDCliente.NumEnderecoCobranca;
    VpaTitulo.Sacado.Endereco.Bairro := VpaDCliente.DesBairroCobranca;
    VpaTitulo.Sacado.Endereco.Cidade := VpaDCliente.DesCidadeCobranca;
    VpaTitulo.Sacado.Endereco.Estado := VpaDCliente.DesUfCobranca;
    VpaTitulo.Sacado.Endereco.CEP := VpaDCliente.CepClienteCobranca;
  end
  else
  begin
    VpaTitulo.Sacado.Endereco.Rua := VpaDCliente.DesEndereco;
    VpaTitulo.Sacado.Endereco.Numero := VpaDCliente.NumEndereco;
    VpaTitulo.Sacado.Endereco.Complemento := VpaDCliente.DesComplementoEndereco;
    VpaTitulo.Sacado.Endereco.Bairro := VpaDCliente.DesBairro;
    VpaTitulo.Sacado.Endereco.Cidade := VpaDCliente.DesCidade;
    VpaTitulo.Sacado.Endereco.Estado := VpaDCliente.DesUF;
    VpaTitulo.Sacado.Endereco.CEP := VpaDCliente.CepCliente;
  end;
//  VpaTitulo.Sacado.Endereco.EMail := 'rafael@eficaciaconsultoria.com.br';
  if VpaDCliente.DesEmailFinanceiro <> ''then
    VpaTitulo.Sacado.Endereco.EMail := VpaDCliente.DesEmailFinanceiro
  else
    VpaTitulo.Sacado.Endereco.EMail := VpaDCliente.DesEmail;
  if VpaDCliente.IndProtestar then
  begin
    if VpaDCliente.QtdDiasProtesto <> 0 then
      VpaTitulo.Sacado.Endereco.DiasProtesto := VpaDCliente.QtdDiasProtesto
    else
      VpaTitulo.Sacado.Endereco.DiasProtesto := varia.QtdDiasProtesto;
  end
  else
    VpaTitulo.Sacado.Endereco.DiasProtesto := 0;

end;

{******************************************************************************}
procedure TImpressaoBoleto.CarDInstrucoes(VpaDParcela : TRBDMovContasCR;VpaTitulo : TgbTitulo);
begin
  VpaTitulo.Instrucoes.Add('APÓS O VENCIMENTO, PAGAR SOMENTE NO '+UpperCase(VpaTitulo.Cedente.ContaBancaria.Banco.Nome));
  if  VpaDParcela.PerMulta > 0 then
    VpaTitulo.Instrucoes.add('APÓS VENCIMENTO, COBRAR MULTA DE '+FormatFloat('#,###,##0%',VpaDParcela.PerMulta));
  if  VpaDParcela.PerMora > 0 then
    VpaTitulo.Instrucoes.add('APÓS VENCIMENTO, COBRAR JUROS DE MORA DE R$ '+FormatFloat('#,###,##0.00',((VpaDParcela.Valor*VpaDParcela.PerMora)/100)/30)+' AO DIA');
  if VpaTitulo.Sacado.Endereco.DiasProtesto > 0 then
    VpaTitulo.Instrucoes.Add('PROTESTAR NO '+ IntToStr(Varia.QtdDiasProtesto)+'o. DIA APÓS O VENCIMENTO' );
  if VpaDParcela.ValAcrescimoFrm > 0 then
     VpaTitulo.Instrucoes.add('VALOR DE ACRÉSCIMO FINANCEIRO REF BOLETO - '+FormatFloat('R$ ###,###,##0.00',VpaDParcela.ValAcrescimoFrm));
  VpaTitulo.Instrucoes.Add('');
  VpaTitulo.Instrucoes.text := VpaTitulo.Instrucoes.text +VARIA.DesObservacaoBoleto;
end;

{******************************************************************************}
procedure TImpressaoBoleto.MontaEmailHTML(VpaDCliente : TRBDCliente;VpaTExto : TStringList);
Var
  VpfAssinatura : TStringList;
  VpfLaco : Integer;
begin
  VpfAssinatura := TStringList.Create;
  VpfAssinatura.text :=  Varia.RodapeECobranca;

  VpaTexto.add('<html>');
  VpaTexto.add('<title> www.eficaciaconsultoria.com.br');
  VpaTexto.add('</title>');
  VpaTexto.add('<body>');
  VpaTexto.add('<left>');
  if VpaDCliente.NomContatoFinanceiro <> '' then
    VpaTExto.add('Sr(a) <b>'+VpaDCliente.NomContatoFinanceiro+'</b>,')
  else
    if VpaDCliente.NomContato <> '' then
      VpaTExto.add('Sr(a) <b>'+VpaDCliente.NomContato+'</b>')
    else
      VpaTExto.add('Sr(a) <b>'+VpaDCliente.NomCliente+'</b>');
  VpaTexto.add('<br>');
  VpaTexto.add('<br>');
  VpaTexto.add('Conforme contato, segue anexo o boleto bancário');
  VpaTexto.add('</left>');

  for VpfLaco := 0 to VpfAssinatura.Count - 1 do
  begin
    VpaTExto.add(VpfAssinatura.Strings[VpfLaco]);
  end;
  VpaTexto.add('<hr>');
  VpaTexto.add('<center>');
  if sistema.PodeDivulgarEficacia then
    VpaTexto.add('<address>Sistema de gestão desenvolvido por <a href="http://www.eficaciaconsultoria.com.br">Eficácia Sistemas e Consultoria Ltda.</a>  </address>');
  VpaTexto.add('</center>');
  VpaTexto.add('</body>');
  VpaTexto.add('</html>');
  VpfAssinatura.free;
end;

{******************************************************************************}
procedure TImpressaoBoleto.ImprimeBoleto(VpaCodFilial,VpaLanReceber,VpaNumParcela : integer;VpaDCliente : TRBDCliente; VpaPreview: boolean;VpaImpressora : String;VpaEnviarEmail : boolean);
var
  VpfBoleto : TgbTitulo;
  VpfDContasReceber : TRBDContasCR;
  vpfDParcela : TRBDMovContasCR;
  VpfTextoEmail : TStringList;
begin
  VpfBoleto := TgbTitulo.Create(nil);
  VpfBoleto.NomeImpressora := VpaImpressora;
  VpfBoleto.DiretorioAnexo := varia.PathVersoes+'\Anexos\BOLETO\';
  VpfDContasReceber := TRBDContasCR.cria;
  vpfDParcela := TRBDMovContasCR.cria;
  FunContasAReceber.CarDContasReceber(IntToStr(VpaCodFilial),IntToStr(VpaLanReceber),VpfDContasReceber,false);
  FunContasAReceber.LocalizaParcela(Tabela,VpaCodFilial,VpaLanReceber,VpaNumParcela);
  FunContasAReceber.CarDMovContasCR(Tabela,vpfDParcela);

  CarDTitulo(VpfDContasReceber,vpfDParcela,VpfBoleto);
  CarDCedente(VpfDContasReceber,vpfDParcela,VpfBoleto);
  CarDSacado(VpaDCliente,VpfBoleto);
  CarDInstrucoes(vpfDParcela,VpfBoleto);

  if VpaEnviarEmail then
  begin
    VpfTextoEmail := TStringList.create;
    MontaEmailHTML(VpaDCliente,VpfTextoEmail);
    VpfBoleto.EnviarPorEMail(Varia.ServidorSMTP,varia.UsuarioSMTP,varia.ServidorPop,Varia.SenhaEmail, 25,Varia.NomeFilial+' - Boleto Bancario - Duplicata "'+vpfDParcela.NroDuplicata+'"',VpfTextoEmail);
    VpfTextoEmail.free;
  end
  else
  begin
    if VpaPreview then
      VpfBoleto.Visualizar
    else
      VpfBoleto.Imprimir;
  end;

  if Config.AdicionarRemessaAoImprimirBoleto then
    FunContasAReceber.AdicionaRemessa(VpaCodFilial,VpaLanReceber,VpaNumParcela,1,'Remessa');

  VpfBoleto.Free;
end;

end.
