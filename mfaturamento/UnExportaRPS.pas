Unit UnExportaRPS;

Interface

Uses Classes, DBTables, ComCtrls, UnDados, SysUtils, Tabela, SqlExpr;

//classe localiza
Type TRBLocalizaExportaRPS = class
  private
  public
    constructor cria;
end;
//classe funcoes
Type TRBFuncoesExportaRPS = class(TRBLocalizaExportaRPS)
  private
    Aux,
    Notas : TSQL;
    VprBarraStatus : TStatusBar;
    procedure LocalizaNotas(VpaTabela : TSQL;VpaDExportaRPS : TRBDExportacaoRPS);
    procedure AtualizaStatus(VpaTexto : string);
    function ExisteProdutosnaNota(VpaCodFilial, VpaSeqNota : Integer) : Boolean;
    function ExportaCabecalhoNotaBlu(VpaDExportaRPS : TRBDExportacaoRPS):string;
    function ExportaNotasNotaBlu(VpaDExportaRPS : TRBDExportacaoRPS):string;
    function ExportaRodapeNotaBlu(VpaDExportaRPS : TRBDExportacaoRPS):string;
    function ExportaRPSNotaBlu(VpaDExportaRPS : TRBDExportacaoRPS):string;
    function AdicionaItensArquivoNotaBlu(VpaDExportaRPS : TRBDExportacaoRPS):string;
    function AtualizaDataUltimoRPS(VpaDExportaRPS : TRBDExportacaoRPS):string;
  public
    constructor cria(VpaBaseDados : TSQLConnection);
    destructor destroy;override;
    function ExportaRPS(VpaDExportaRPS : TRBDExportacaoRPS;VpaBarraStatus : TStatusBar):string;
end;



implementation

Uses FunSql, FunString, FunArquivos, UnSistema, FunNumeros, constantes;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              eventos da classe TRBLocalizaExportaRPS
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBLocalizaExportaRPS.cria;
begin
  inherited create;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            eventos da classe TRBFuncoesExportaRPS
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
function TRBFuncoesExportaRPS.AdicionaItensArquivoNotaBlu(VpaDExportaRPS: TRBDExportacaoRPS): string;
var
  VpfLaco : Integer;
  VpfDNotaBlu : TRBDNotaBlu;
  VpfLinha : String;
begin
  for VpfLaco := 0 to VpaDExportaRPS.NotasBlu.Count - 1 do
  begin
    VpfDNotaBlu := TRBDNotaBlu(VpaDExportaRPS.NotasBlu.Items[VpfLaco]);
    VpfLinha := '2'+
    //TIPO DO RPS 2-2
    IntToStr(VpfDNotaBlu.CodTipoRPS)+
    //SERIE DO RPS 3-7
    AdicionaCharD(' ',VpfDNotaBlu.DesSerieNota,5)+
    //NUMERO DO RPS 8-22
    AdicionaCharE('0',IntToStr(VpfDNotaBlu.NumNota),15)+
    //DATA DE EMISSAO DO RPS 23-30
    FormatDateTime('YYYYMMDD',VpfDNotaBlu.DatEmissaoNota)+
    //SITUACAO DO RPS 31-31
    VpfDNotaBlu.DesSituacaoRPS+
    //VALOR DOS SERVICOS 32-46
    DeletaChars(FormatFloat('0000000000000.00',VpfDNotaBlu.ValServicos),',') +
    //VALOR DAS DEDUCOES 47-61
    DeletaChars(FormatFloat('0000000000000.00',0),',') +
    //CODIGO DO SERVICO PRESTADO
    AdicionaCharE('0',IntToStr(VpfDNotaBlu.CodFiscalServico),8)+
    //ALIQUOTA 70-74
    DeletaChars(FormatFloat('000.00',VpfDNotaBlu.PerISSQN),',') +
    //ISS RETIDO 75-75
    '0'+
    //INDICADOR DE CPF/CNPJ DO TOMARDOR 76-76
    VpfDNotaBlu.DesTipoPessoa+
    // CPF ou CNPJ  do tomaador 77-90
    AdicionaCharE('0',VpfDNotaBlu.DesCNPJCPF,14)+
    //inscricao municipal do tomador 91-105
    AdicionaCharE('0','0',15)+
    //inscricao estadual do tomador 106-120
    AdicionaCharE('0',DeletaChars(DeletaChars(DeletaChars(DeletaEspaco(VpfDNotaBlu.DesInscricaoEstadual),'-'),'.'),'/'),15)+
    //NOME/RAZAO SOCIAL DO TOMADOR 121-235
    AdicionaCharD(' ',VpfDNotaBlu.NomCliente,115)+
    //Tipo do endereco 236-238
    '   '+
    //Endereco do tomador 239-338
    AdicionaCharD(' ',VpfDNotaBlu.DesEndereco,100)+
    //numero do endereo do tomador 339-348
    AdicionaCharD(' ',VpfDNotaBlu.DesNumeroEndereco,10)+
    //Complemento do endereco 349-408
    AdicionaCharD(' ',VpfDNotaBlu.DesComplementoEndereco,60)+
    //Bairro do tomador 409-480
    AdicionaCharD(' ',VpfDNotaBlu.DesBairro,72)+
    //Cidade do tomador 481-530
    AdicionaCharD(' ',VpfDNotaBlu.DesCidade,50)+
    //UF do tomador 531-532
    AdicionaCharD(' ',VpfDNotaBlu.DesUF,2)+
    //CEP do tomador 533-540
    AdicionaCharE('0',VpfDNotaBlu.DesCEP,8)+
    //email do tomador 541-620
    AdicionaCharD(' ',copy(VpfDNotaBlu.DesEmail,1,80),80)+
    //valor cofins 621-635
    AdicionaCharE('0','0',15)+
    //valor CSLL 636-650
    AdicionaCharE('0','0',15)+
    //valor INSS 651-665
    AdicionaCharE('0','0',15)+
    //valor IRPJ 666-680
    AdicionaCharE('0','0',15)+
    //valor PIS 681-695
    AdicionaCharE('0','0',15)+
    //Discriminacao dos servicos 696
    VpfDNotaBlu.DesServico;
    VpaDExportaRPS.Arquivo.Add(VpfLinha);
  end;
end;

{******************************************************************************}
function TRBFuncoesExportaRPS.AtualizaDataUltimoRPS(VpaDExportaRPS: TRBDExportacaoRPS): string;
begin
  AdicionaSQLAbreTabela(Notas,'Select * from CADFILIAIS ' +
                              ' Where I_EMP_FIL = '+IntToStr(VpaDExportaRPS.CodFilial));
  Notas.edit;
  Notas.FieldByName('D_ULT_RPS').AsDateTime := VpaDExportaRPS.DatFim;
  Notas.Post;
  result := notas.AMensagemErroGravacao;
end;

{******************************************************************************}
procedure TRBFuncoesExportaRPS.AtualizaStatus(VpaTexto: string);
begin
  if VprBarraStatus <> nil then
  begin
    VprBarraStatus.Panels[0].Text := VpaTexto;
    VprBarraStatus.Refresh;
  end;
end;

{******************************************************************************}
constructor TRBFuncoesExportaRPS.cria(VpaBaseDados : TSQLConnection);
begin
  inherited create;
  VprBarraStatus := nil;
  Aux := TSQL.Create(nil);
  Aux.ASQlConnection := VpaBaseDados;
  Notas := TSQL.Create(nil);
  Notas.ASQlConnection := VpaBaseDados;
end;

{******************************************************************************}
destructor TRBFuncoesExportaRPS.destroy;
begin
  Aux.Free;
  Notas.Free;
  inherited;
end;

{******************************************************************************}
function TRBFuncoesExportaRPS.ExisteProdutosnaNota(VpaCodFilial,VpaSeqNota: Integer): Boolean;
begin
  AdicionaSQLAbreTabela(Aux,'Select count(I_EMP_FIL) QTD from MOVNOTASFISCAIS ' +
                            ' Where I_EMP_FIL = '+IntToStr(VpaCodFilial)+
                            ' AND I_SEQ_NOT = '+IntToStr(VpaSeqNota));
  result := Aux.FieldByName('QTD').AsInteger > 0;
  Aux.Close;
end;

{******************************************************************************}
function TRBFuncoesExportaRPS.ExportaCabecalhoNotaBlu(VpaDExportaRPS : TRBDExportacaoRPS): string;
var
  VpfLinha : string;
begin
  result := '';
  AtualizaStatus('Adicionando cabecalho do arquivo da NOTABLU');
  VpfLinha := '1' +
  // versao do arquivo  2-4
  '002'+
  //inscricao Municipal do tomador 5-19
   AdicionaCharE('0',DeletaEspaco(VpaDExportaRPS.DFilial.DesInscricaoMunicipal),15)+
  // DAta de inicio 20-27
  FormatDateTime('YYYYMMDD',VpaDExportaRPS.DatInicio)+
  //data de fim 28-35
  FormatDateTime('YYYYMMDD',VpaDExportaRPS.DatFim);
  //caracter de fim de linha 37-38;
  VpaDExportaRPS.Arquivo.Add(VpfLinha);
end;

{******************************************************************************}
function TRBFuncoesExportaRPS.ExportaNotasNotaBlu(VpaDExportaRPS: TRBDExportacaoRPS): string;
var
  VpfLinha,VpfTipoRPS, VpfSituacaoRPS, VpfTipPessoa,VpfCNPJCPFCliente,VpfEmail : string;
  VpfCodfiscalAtual,VpfSeqNotaAtual  : Integer;
  VpfTotalServico : Double;
  VpfDNotaBlu : TRBDNotaBlu;
begin
  result := '';
  VpfDNotaBlu := nil;
  VpfSeqNotaAtual := 0;
  VpfCodfiscalAtual := 0;
  AtualizaStatus('Localizando as notas fiscais');
  VpaDExportaRPS.ValTotalServicos := 0;
  LocalizaNotas(Notas,VpaDExportaRPS);
  while not Notas.Eof do
  begin
    VpaDExportaRPS.ValTotalServicos := VpaDExportaRPS.ValTotalServicos + ArredondaDecimais(Notas.FieldByName('N_TOT_SER').AsFloat,2);
    AtualizaStatus('Gerando nota fiscal "'+Notas.FieldByName('I_NRO_NOT').AsString);
    if (VpfCodfiscalAtual <> Notas.FieldByName('I_COD_FIS').AsInteger) or
       (VpfSeqNotaAtual <> Notas.FieldByName('I_SEQ_NOT').AsInteger) then
    begin
      if VpfDNotaBlu <> nil then
        VpfDNotaBlu.DesServico := COPY(VpfDNotaBlu.DesServico,1,Length(VpfDNotaBlu.DesServico)-3);
      VpfSeqNotaAtual := Notas.FieldByName('I_SEQ_NOT').AsInteger;
      VpfCodfiscalAtual := Notas.FieldByName('I_COD_FIS').AsInteger;
      VpfDNotaBlu := VpaDExportaRPS.AddNotaBlu;
      with VpfDNotaBlu do
      begin
        if ExisteProdutosnaNota(Notas.FieldByName('I_EMP_FIL').AsInteger,Notas.FieldByName('I_SEQ_NOT').AsInteger) then
          CodTipoRPS := 1
        else
          CodTipoRPS := 0;
        if Notas.FieldByName('C_NOT_CAN').AsString = 'S' then
          DesSituacaoRPS := 'C'
        else
          DesSituacaoRPS := 'T';
        if Notas.FieldByName('C_TIP_PES').AsString = 'F' then
        begin
          DesTipoPessoa := '1';
          DesCNPJCPF := Notas.FieldByName('C_CPF_CLI').AsString;
        end
        else
          if Notas.FieldByName('C_TIP_PES').AsString = 'J' then
          begin
            DesTipoPessoa := '2';
            DesCNPJCPF := Notas.FieldByName('C_CGC_CLI').AsString;
          end
          else
            DesTipoPessoa := '3';
        DesCNPJCPF := DeletaChars(DeletaChars(DeletaChars(DesCNPJCPF,'/'),'.'),'-');
        if Notas.FieldByName('C_EMA_NFE').AsString <> '' then
          DesEmail := Notas.FieldByName('C_EMA_NFE').AsString
        else
          DesEmail := Notas.FieldByName('C_END_ELE').AsString;

        DesSerieNota := Notas.FieldByName('C_SER_NOT').AsString;
        NumNota := Notas.FieldByName('I_NRO_NOT').AsInteger;
        DatEmissaoNota := Notas.FieldByName('D_DAT_EMI').AsDateTime;
        CodFiscalServico := Notas.FieldByName('I_COD_FIS').AsInteger;
        PerISSQN := Notas.FieldByName('N_PER_ISQ').AsFloat;
        DesInscricaoEstadual := Notas.FieldByName('C_INS_CLI').AsString;
        NomCliente := Notas.FieldByName('C_NOM_CLI').AsString;
        DesEndereco := Notas.FieldByName('C_END_CLI').AsString;
        DesNumeroEndereco := Notas.FieldByName('I_NUM_END').AsString;
        DesComplementoEndereco := Notas.FieldByName('C_COM_END').AsString;
        DESBAIRRO := Notas.FieldByName('C_BAI_CLI').AsString;
        DesCidade := Notas.FieldByName('C_CID_CLI').AsString;
        DesUF := Notas.FieldByName('C_EST_CLI').AsString;
        DesCEP := Notas.FieldByName('C_CEP_CLI').AsString;
      end;
    end;
    VpfDNotaBlu.ValServicos := VpfDNotaBlu.ValServicos + ArredondaDecimais(Notas.FieldByName('N_TOT_SER').AsFloat,2);
    VpfDNotaBlu.DesServico := VpfDNotaBlu.DesServico + Notas.FieldByName('C_NOM_SER').AsString+ ' /  ';
    Notas.Next;
  end;
  if VpfDNotaBlu <> nil then
    VpfDNotaBlu.DesServico := COPY(VpfDNotaBlu.DesServico,1,Length(VpfDNotaBlu.DesServico)-3);

  Notas.Close;
end;

{******************************************************************************}
function TRBFuncoesExportaRPS.ExportaRodapeNotaBlu(VpaDExportaRPS: TRBDExportacaoRPS): string;
var
  VpfLinha : String;
begin
  result := '';
  VpfLinha := '9'+
  //NUMERO DE LINHAS 2-8
  AdicionaCharE('0',intToStr(VpaDExportaRPS.Arquivo.Count-1),7)+
  //valor total dos servicos 9-23
  AdicionaCharE('0',DeletaChars(FormatFloat('000000000000.00',VpaDExportaRPS.ValTotalServicos),','),15)+
  //valor total das deducoes 24-38
  AdicionaCharE('0','0',15)+
  //valor total das retencoes de cofinz 39-53
  AdicionaCharE('0','0',15)+
  //valor total das retencoes de CSLL 54-68
  AdicionaCharE('0','0',15)+
  //valor total das retencoes de INSS 69-83
  AdicionaCharE('0','0',15)+
  //valor total das retencoes de IRPJ 84-98
  AdicionaCharE('0','0',15)+
  //valor total das retencoes de PIS 99-113
  AdicionaCharE('0','0',15);
  VpaDExportaRPS.Arquivo.Add(VpfLinha);
end;

{******************************************************************************}
function TRBFuncoesExportaRPS.ExportaRPS(VpaDExportaRPS : TRBDExportacaoRPS; VpaBarraStatus: TStatusBar): string;
begin
  result := '';
  VprBarraStatus := VpaBarraStatus;
  Sistema.CarDFilial(VpaDExportaRPS.DFilial,VpaDExportaRPS.CodFilial);
  ExportaRPSNotaBlu(VpaDExportaRPS);
  Varia.DatUltimoRPS := VpaDExportaRPS.DatFim;
  result := AtualizaDataUltimoRPS(VpaDExportaRPS);
end;

{******************************************************************************}
function TRBFuncoesExportaRPS.ExportaRPSNotaBlu(VpaDExportaRPS: TRBDExportacaoRPS): string;
Var
  VpfNomArquivo : string;
begin
  VpaDExportaRPS.Arquivo.Clear;
  ExportaCabecalhoNotaBlu(VpaDExportaRPS);
  ExportaNotasNotaBlu(VpaDExportaRPS);
  AdicionaItensArquivoNotaBlu(VpaDExportaRPS);
  ExportaRodapeNotaBlu(VpaDExportaRPS);

  VpfNomArquivo :=RetornaDiretorioCorrente+'\RPS\'+IntToStr(VpaDExportaRPS.CodFilial)+'_'+ FormatDateTime('DDMMYYYY',now)+'.txt';
  NaoExisteCriaDiretorio(RetornaDiretorioArquivo(VpfNomArquivo),false);
  DeletaArquivo(RetornaDiretorioArquivo(VpfNomArquivo)+'\*.*');
  VpaDExportaRPS.Arquivo.SaveToFile(VpfNomArquivo);
  AtualizaStatus('Arquivo gerado com sucesso "'+VpfNomArquivo+'"');
end;

{******************************************************************************}
procedure TRBFuncoesExportaRPS.LocalizaNotas(VpaTabela: TSQL;VpaDExportaRPS: TRBDExportacaoRPS);
begin
  AdicionaSQLAbreTabela(VpaTabela,'SELECT CAD.I_EMP_FIL, CAD.I_SEQ_NOT, CAD.C_SER_NOT, CAD.I_NRO_NOT, CAD.D_DAT_EMI, ' +
                                  ' CAD.N_PER_ISQ, CAD.C_NOT_CAN, '+
                                  ' MOV.N_TOT_SER,  '+
                                  ' SER.I_COD_FIS, SER.C_NOM_SER, '+
                                  ' CLI.C_TIP_PES, CLI.C_CGC_CLI, CLI.C_CPF_CLI, CLI.C_INS_CLI, CLI.C_NOM_CLI, CLI.C_END_CLI, ' +
                                  ' CLI.I_NUM_END, CLI.C_COM_END, CLI.C_BAI_CLI, CLI.C_CID_CLI, CLI.C_EST_CLI, CLI.C_CEP_CLI, ' +
                                  ' CLI.C_EMA_NFE, CLI.C_END_ELE '+
                                  ' FROM CADNOTAFISCAIS CAD, MOVSERVICONOTA MOV, CADSERVICO SER, CADCLIENTES CLI  ' +
                                  ' Where '+SQLTextoDataEntreAAAAMMDD('CAD.D_DAT_EMI',VpaDExportaRPS.DatInicio,VpaDExportaRPS.DatFim,false)+
                                  ' and CAD.I_EMP_FIL = '+IntToStr(VpaDExportaRPS.CodFilial)+
                                  ' AND CAD.I_EMP_FIL = MOV.I_EMP_FIL ' +
                                  ' AND CAD.I_SEQ_NOT = MOV.I_SEQ_NOT ' +
                                  ' AND MOV.I_COD_SER = SER.I_COD_SER '+
                                  ' AND CAD.I_COD_CLI = CLI.I_COD_CLI '+
                                  ' ORDER BY CAD.I_SEQ_NOT, SER.I_COD_FIS');
end;

end.
