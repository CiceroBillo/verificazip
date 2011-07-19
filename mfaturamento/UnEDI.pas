Unit UnEDI;

{Instrucoes EDI Sultec X Marcopolo

Site : http://oc.marcopolo.com.br
usuario: SU792470
senha: Sultec

O arquivo gerado pelo sistema e colocado no site da marcopolo.
} 

Interface

Uses Classes, DBTables, UnDados,Sysutils;

//classe localiza
Type TRBLocalizaEDI = class
  private
  public
    procedure LHeader01(VpaTabela : TQuery;VpaFilial, VpaSeqNota : String);
    procedure LHeader02(VpaTabela : TQuery;VpaFilial, VpaSeqNota : String);
    procedure LHeader03(VpaTabela : TQuery;VpaFilial, VpaSeqNota : String);
    constructor cria;
end;
//classe funcoes
Type TRBFuncoesEDI = class(TRBLocalizaEDI)
  private
    EDIAux : TQuery;
  public
    constructor cria;
    destructor destroy;override;
    function GeraArquivoEDI(VpaFilial,VpaSeqNotaFiscal : String) : String;
end;



implementation

Uses FunSql, FunString, FunNumeros, FunArquivos;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              eventos da classe TRBLocalizaEDI
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBLocalizaEDI.cria;
begin
  inherited create;
end;

{******************************************************************************}
procedure TRBLocalizaEDI.LHeader01(VpaTabela : TQuery;VpaFilial, VpaSeqNota : String);
begin
  AdicionaSQLAbreTabela(VpaTabela,' Select CAD.I_NRO_NOT, CAD.C_SER_NOT,CAD.D_DAT_EMI,CAD.I_QTD_VOL, CAD.C_TIP_EMB, ' +
             ' CAD.C_COD_NAT,CAD.N_OUT_DES,N_VLR_FRE, N_VLR_SEG, CAD.N_VLR_PER, ' +
             ' CAD.N_PES_BRU, CAD.N_PES_LIQ, CAD.N_BAS_CAL,N_TOT_PRO,N_VLR_ICM, ' +
             ' CAD.N_TOT_IPI, CAD.N_TOT_NOT, CAD.C_ORD_COM, ' +
             ' CLI.C_CGC_CLI, '+
             ' TRA.C_CGC_TRA ' +
             ' from CADTRANSPORTADORAS TRA, CADNOTAFISCAIS CAD, CADCLIENTES CLI '+
             ' WHERE CAD.I_COD_TRA *= TRA.I_COD_TRA '+
             ' AND CAD.I_COD_CLI = CLI.I_COD_CLI '+
             ' AND CAD.I_EMP_FIL = ' +VpaFilial+
             ' AND CAD.I_SEQ_NOT =' + VpaSeqNota);
end;

{******************************************************************************}
procedure TRBLocalizaEDI.LHeader02(VpaTabela : TQuery;VpaFilial, VpaSeqNota : String);
begin
  AdicionaSQLAbreTabela(VpaTabela,' Select MOV.C_COD_PRO,  MOV.N_QTD_PRO,MOV.N_VLR_PRO, MOV.C_CLA_FIS, MOV.N_TOT_PRO, ' +
            ' MOV.N_VLR_IPI, MOV.N_PER_IPI, MOV.N_PER_ICM, '+
            ' PRO.C_NOM_PRO,' +
            ' UNI.C_NOM_UNI ' +
            ' from MOVNOTASFISCAIS MOV, CADPRODUTOS PRO, CADUNIDADE UNI ' +
            ' where MOV.I_SEQ_PRO = PRO.I_SEQ_PRO ' +
            ' AND MOV.C_COD_UNI = UNI.C_COD_UNI ' +
            ' AND MOV.I_EMP_FIL = ' +VpaFilial+
            ' AND MOV.I_SEQ_NOT =' + VpaSeqNota+
            ' ORDER BY MOV.I_SEQ_MOV');
end;

{******************************************************************************}
procedure TRBLocalizaEDI.LHeader03(VpaTabela : TQuery;VpaFilial, VpaSeqNota : String);
begin
  AdicionaSQLAbreTabela(VpaTabela,' select CAD.I_NRO_NOT,MOV.D_DAT_VEN, N_VLR_PAR ' +
                               ' from CADCONTASARECEBER CAD, MOVCONTASARECEBER MOV ' +
                               ' Where CAD.I_EMP_FIL = MOV.I_EMP_FIL ' +
                               '  AND CAD.I_LAN_REC = MOV.I_LAN_REC ' +
                               '  AND CAD.I_EMP_FIL = ' +VpaFilial +
                               '  AND CAD.I_SEQ_NOT = '+ VpaSeqNota);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            eventos da classe TRBFuncoesEDI
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************************* cria a classe ********************************}
constructor TRBFuncoesEDI.cria;
begin
  inherited create;
  EDIAux := TQuery.create(nil);
  EDIAux.DatabaseName := 'BaseDados';
end;

{******************************************************************************}
destructor TRBFuncoesEDI.destroy;
begin
  EDIAux.free;
  inherited destroy;
end;


{******************************************************************************}
function TRBFuncoesEDI.GeraArquivoEDI(VpaFilial,VpaSeqNotaFiscal : String) : String;
var
  VpfArquivo : TStringList;
begin
end;

end.
