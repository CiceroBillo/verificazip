{$A+,B-,C+,D+,E-,F-,G+,H+,I+,J+,K-,L+,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
unit UnClassesImprimir;
{Verificado
-.edit;
}
interface

uses
  Classes, SysUtils;

  Type
    TRBDItemImpressao = class
      public
        SeqDocumento,
        PosVertical,
        PosHorizontal,
        TamCampo,
        QtdLinhasItem : Integer;
        NomCampo,
        DesAlinhamento : String;
        IndNegrito,
        IndItalico,
        IndCondessado,
        IndReduzido,
        IndItemDocumento : boolean;
        constructor cria;
        destructor destroy;override;
  end;

  Type
    TRBDImpressao = class
      public
        NumDocumento,
        QtdDocumentos,
        SeqImpressora,
        NumLinhaAtual,
        QtdComandosLinha,
        QtdLinhasSaltoPagina,
        QtdLinhasRodDocumento,
        QtdLinhasFatura,
        QtdColunasFatura,
        QtdLinhasProdutos,
        QtdLinhasObservacao,
        QtdLinhasDadosAdicionais,
        QtdLinhasServicos,
        IndiceItem,
        IndiceProduto,
        IndiceFaturas,
        IndiceServico : Integer;
        NomDocumento,
        DesTipoDocumento : String;
        IndAltLinhaReduzida,
        IndDeteccaoFimPapel,
        IndFolhaemBranco,
        IndImprimeAsterisco : Boolean;
        DesCharDireita,
        DesCharEsquerda : Char;
        ItensImpressao,
        ItensDocumento : TList;
        constructor cria;
        destructor destroy;override;
        function AddItemImpressao : TRBDItemImpressao;
  end;


    TDadosPromissoria = class
      DiaVencimento,            // 1.
      MesVencimento,            // 2.
      AnoVencimento,            // 3.
      NumeroDocumento: string;  // 4.
      ValorDocumento: Double;   // 5.
      DescricaoDuplicata1,      // 6.
      DescricaoDuplicata2,      // 6.
      PessoaDuplicata,          // 7.
      NumeroCGCCPF,             // 8.
      DescricaoValor1,          // 9.
      DescricaoValor2,          // 10.
      DescricaoPagamento,       // 11.
      Emitente,                 // 12.
      CPFCGCEmitente,           // 13.
      EnderecoEmitente: string; // 14.
    end;

    TDadosCheque = Class
      ValorCheque: Double;    // 1,
      DescValor1,             // 2,
      DescValor2,             // 3,
      DescNominal,            // 4,
      CidadeEmitido,          // 5,
      DiaDeposito,            // 6,
      MesDeposito,            // 7,
      AnodeDeposito,          // 8.
      Traco,
      Numero,
      Agencia,
      Banco,
      Conta,
      Observ: string;
    end;

    TDadosBoleto = class
      LocalPagamento,         // 1,
      Cedente,                // 2,
      NumeroDocumento,        // 4,
      EspecieDocumento,       // 5,
      Aceite,                 // 6,
      Carteira,               // 8,
      Especie,                // 9,
      Quantidade,             // 10,
      Agencia,                // 13,
      NossoNumero: string;    // 14,
      LanReceber,
      NumParcela,
      NumeroConvenio : Integer;
      DataDocumento,          // 3,
      DataProcessamento,      // 7,
      Vencimento: TDateTime;  // 12,
      Valor,                  // 11,
      ValorDocumento,         // 15,
      Desconto,               // 16,
      Outras,                 // 17,
      MoraMulta,              // 18,
      Acrescimos,             // 19,
      ValoCobrado: Double;    // 20.
      Instrucoes,             // 21,
      Sacado : TStringList;   // 22.
    end;

    TDadosCarne = class
      CodigoClienteL,
      NomeClienteL,
      NumeroDocumentoL,
      ObservacoesL,
      AutentificacaoL,
      CodigoClienteC,
      NomeClienteC,
      ParcelaC,
      NumeroDocumentoC,
      ObservacoesC,
      AutentificacaoC,
      ParcelaL: string;
      VencimentoL,
      VencimentoC: TDateTime;
      ValorParcelaL,
      AcrDescL,
      ValorTotalL,
      ValorParcelaC,
      AcrDescC,
      ValorTotalC: Double;
    end;

    TDadosRecibo = class
      Valor: Double;
      Numero,
      Pessoa,
      DescValor1,
      DescValor2,
      DescReferente1,
      DescReferente2,
      Cidade,
      Dia,
      Mes,
      Ano,
      Emitente,
      CGCCPFGREmitente,
      EnderecoEmitente: string;
    end;

    TDadosDuplicata = class
      DataEmissao,
      DataVencimento,
      DataPagtoAte: TDateTime;
      DescontoDe,
      Valor,
      ValorTotal: Double;
      Representante,
      Cod_Representante,
      Cod_Sacado,
      CEP,
      Numero,
      NroOrdem,
      CondEspeciais,
      NomeSacado,
      EnderecoSacado,
      Bairro,
      CidadeSacado,
      EstadoSacado,
      InscricaoCGC,
      InscricaoEstadual,
      PracaPagto,
      DescValor1,
      DescValor2: string;
    end;

    TDadosEnvelope = class
      nomeDes,
      ruaDes,
      bairroDes,
      cidade_EstadoDes,
      cepDes,
      ContatoDes,
      nomeRem,
      ruaRem,
      bairroRem,
      cidade_EstadoRem,
      cepRem : String;
    end;

   TDadosEtiquetaCliente = class
      nome,
      Endereco,
      bairro,
      cidade,
      Estado,
      cep,
      Complemento,
      nome1,
      Endereco1,
      bairro1,
      cidade1,
      Estado1,
      cep1,
      Complemento1,
      nome2,
      Endereco2,
      bairro2,
      cidade2,
      Estado2,
      cep2,
      Complemento2 : String;
    end;

implementation

Uses FunObjeto;

{******************************************************************************}
constructor TRBDItemImpressao.cria;
begin
  inherited create;
end;

{******************************************************************************}
destructor TRBDItemImpressao.destroy;
begin
  inherited destroy;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                           TRBDImpressao
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBDImpressao.cria;
begin
  inherited create;
  ItensImpressao := TList.create;
  ItensDocumento := TList.Create;
  IndImprimeAsterisco := false;
end;

{******************************************************************************}
destructor TRBDImpressao.destroy;
begin
  FreeTObjectsList(ItensImpressao);
  ItensImpressao.free;
  ItensDocumento.free;
  inherited destroy;
end;

{******************************************************************************}
function TRBDImpressao.AddItemImpressao : TRBDItemImpressao;
begin
  result := TRBDItemImpressao.cria;
  ItensImpressao.Add(result);
end;

end.
