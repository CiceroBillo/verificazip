unit APrincipal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, Buttons, ComCtrls, Componentes1, UnDadosCR, UnContasAreceber,
  PainelGradiente, ExtCtrls, UnProdutos;

Const
  CampoPermissaoModulo = 'c_mod_fin';
  CampoFormModulos ='c_mod_fin';
  NomeModulo = 'Correcoes';

type
  TFPrincipal = class(TForm)
    BitBtn1: TBitBtn;
    BaseDados: TDatabase;
    Aux: TQuery;
    Orcamentos: TQuery;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    Label1: TLabel;
    Label2: TLabel;
    BarraStatus: TStatusBar;
    CorForm: TCorForm;
    CorPainelGra: TCorPainelGra;
    CorFoco: TCorFoco;
    tempo: TPainelTempo;
    BaseEndereco: TDatabase;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    Tabela: TQuery;
    MovOrcamentos: TQuery;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    CEPCorreios: TQuery;
    Endereco: TQuery;
    AuxEndereco: TQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
     function RCodCidadeDisponivel:Integer;
     function RCodRua:Integer;
     function RCodCidade(VpaNomCidade : String):Integer;
     Function  VerificaPermisao( nome : string ) : Boolean;
     procedure ValidaBotoesGrupos( botoes : array of TComponent);
     procedure AlteraNomeEmpresa;
     procedure VerificaMoeda;

  end;

var
  FPrincipal: TFPrincipal;

implementation

{$R *.DFM}
Uses FunSql, ConstMsg, FunData, Constantes, funObjeto, FunString;

{******************************************************************************}
function TFPrincipal.RCodCidadeDisponivel:Integer;
begin
  AdicionaSQLAbreTabela(AuxEndereco,'Select MAX(COD_CIDADE) ULTIMO FROM CAD_CIDADES');
  result := AuxEndereco.FieldByName('ULTIMO').AsInteger + 1;
  AuxEndereco.Close;
end;

{******************************************************************************}
function TFPrincipal.RCodRua:Integer;
begin
  AdicionaSQLAbreTabela(AuxEndereco,'Select MAX(COD_RUA) ULTIMO FROM CAD_CEPS');
  result := AuxEndereco.FieldByName('ULTIMO').AsInteger + 1;
  AuxEndereco.Close;
end;

{******************************************************************************}
function TFPrincipal.RCodCidade(VpaNomCidade : String):Integer;
begin
  AdicionaSQLAbreTabela(AuxEndereco,'Select COD_CIDADE FROM CAD_CIDADES '+
                                    ' Where DES_CIDADE = '''+VpaNomCidade+'''');
  result := AuxEndereco.FieldByName('COD_CIDADE').AsInteger;
  AuxEndereco.close;
end;

{******************************************************************************}
Function  TFPrincipal.VerificaPermisao( nome : string ) : Boolean;
begin
  result := true;
end;

procedure TFPrincipal.ValidaBotoesGrupos( botoes : array of TComponent);
begin
end;

{******************************************************************************}
procedure TFPrincipal.AlteraNomeEmpresa;
begin

end;

{******************************************************************************}
procedure TFPrincipal.VerificaMoeda;
begin

end;

{******************************************************************************}
procedure TFPrincipal.FormCreate(Sender: TObject);
begin
  BaseDados.Open;
  Varia := TVariaveis.cria;
  Config := TConfig.Create;
  ConfigModulos := TConfigModulo.Create;
  CarregaEmpresaFilial(1,11,BaseDados);
  carregaCFG(BaseDados);
  EDatInicio.DateTime := PrimeiroDiaMesAnterior;
  EDatFim.Datetime := UltimoDiaMesAnterior;
  FunContasAReceber := TFuncoesContasAReceber.criar(self,BaseDados);
  FunProdutos := TFuncoesProduto.criar(self,BaseDados);

end;

{******************************************************************************}
procedure TFPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FunContasaReceber.free;
  BaseDados.Close;
  FunProdutos.free;
end;

{******************************************************************************}
procedure TFPrincipal.BitBtn1Click(Sender: TObject);
Var
  VpfDContaCR : TRBDContasCR;
  VpfResultado : string;
begin
  BarraStatus.Panels[0].Text := 'Excluindo comissão';
  BarraStatus.refresh;
  ExecutaComandoSql(Aux,'Delete from MOVCOMISSOES '+
                        ' Where D_DAT_EMI >= '+SQLTextoDataAAAAMMMDD(EDatInicio.Datetime)+
                        ' and D_DAT_EMI <= '+SQLTextoDataAAAAMMMDD(EDatFim.DateTime));
  BarraStatus.Panels[0].Text := 'Excluindo MOVCONTASARECEBER';
  BarraStatus.refresh;
  ExecutaComandosql(Aux,'Delete from movcontasareceber '+
                        ' where exists (select * from cadcontasareceber cad '+
                        ' where cad.i_emp_fil = movcontasareceber.i_emp_fil '+
                        ' and cad.i_lan_rec = movcontasareceber.i_lan_rec '+
                        ' and cad.d_dat_emi >= '+ SQLTextoDataAAAAMMMDD(EDatInicio.DateTime)+
                        ' and cad.d_dat_emi <= '+SQLTextoDataAAAAMMMDD(EDatFim.Datetime)+
                        ' )');
  BarraStatus.Panels[0].Text := 'Excluindo CADCONTASARECEBER';
  BarraStatus.refresh;
  ExecutacomandoSql(Aux,'Delete from CADCONTASARECEBER '+
                        ' Where D_DAT_EMI >= '+SqlTextoDataAAAAMMMDD(EDatInicio.DateTime)+
                        ' and D_DAT_EMI <= '+ SQLTextoDataAAAAMMMDD(EDatFim.DateTime));
  VpfDContaCR := TRBDContasCR.cria;
  AdicionaSqlAbreTabela(aux,'select  * from CADORCAMENTOS '+
                            ' where D_DAT_ORC >= '+SQLTextoDataAAAAMMMDD(EDatInicio.DateTime)+
                            ' and D_DAT_ORC <= '+ SQLTextoDataAAAAMMMDD(EDatFim.DateTime)+
                            ' AND C_FLA_SIT = ''E''');
  While not Aux.Eof do
  begin
    FreeTObjectsList(VpfDContaCR.Parcelas);
    VpfDContaCR.Parcelas.Clear;
    BarraStatus.Panels[0].Text := 'Processando Cotação '+Aux.FieldByName('I_LAN_ORC').AsString;;
    BarraStatus.refresh;
    VpfDContaCR.CodEmpFil := Aux.FieldByName('I_EMP_FIL').AsInteger;
    VpfDContaCR.NroNota := Aux.FieldByName('I_LAN_ORC').AsInteger;
    VpfDContaCR.SeqNota := 0;
    VpfDContaCR.CodCondicaoPgto := Aux.FieldByName('I_COD_PAG').AsInteger;
    VpfDContaCR.CodCliente := Aux.FieldByName('I_COD_CLI').AsInteger;
    VpfDContaCR.CodFrmPagto := 1103;
    VpfDContaCR.CodMoeda :=  1101;
    VpfDContaCR.CodUsuario := 1;
    VpfDContaCR.DatMov := Aux.FieldByName('D_DAT_ORC').Asdatetime;
    VpfDContaCR.DatEmissao := Aux.FieldByName('D_DAT_ORC').Asdatetime;
    VpfDContaCR.PlanoConta := '1001002';
    VpfDContaCR.ValTotal := Aux.FieldByName('N_VLR_TOT').AsFloat;
    VpfDContaCR.PercentualDesAcr := 0;
    VpfDContaCR.MostrarParcelas := false;
    VpfDContaCR.IndGerarComissao := true;

    // comissao
    if Aux.FieldByName('I_COD_VEN').AsInteger <> 0 then
    begin
      VpfDContaCR.CodVendedor := Aux.FieldByName('I_COD_VEN').AsInteger;
      VpfDContaCR.TipoComissao := 0; // comissao direta
      VpfDContaCR.PerComissaoPro := Aux.FieldByName('N_PER_COM').AsFloat;
      VpfDContaCR.ValComPro := Aux.FieldByName('N_VLR_TOT').AsFloat;
    end
    else
    begin
      VpfDContaCR.CodVendedor := 0;
      VpfDContaCR.PerComissaoPro := 0;
      VpfDContaCR.ValComPro := 0;
    end;
    VpfDContaCR.PerComissaoServ := 0;
    VpfDContaCR.EsconderConta := true;
    FunContasAreceber.CriaContasaReceber(VpfDContaCR, VpfResultado);
    if Vpfresultado <> '' then
    begin
      aviso(vpfresultado);
      break;
    end;
    Aux.Next;
  end;
  VpfDContaCr.free;
  if VpfResultado = '' then
  begin
    BarraStatus.Panels[0].Text := 'Comissões processadas com sucesso';
    BarraStatus.refresh;
  end;
end;

procedure TFPrincipal.BitBtn2Click(Sender: TObject);
begin
{  ExecutaComandoSql(Aux,'update movestoqueprodutos '+
                        ' set c_cod_uni = ''m3'''+
                        ' where i_seq_pro in '+
                        ' (select cad.i_seq_pro from cadprodutos cad, movestoqueprodutos mov '+
                        ' where cad.i_seq_pro = mov.i_seq_pro '+
                        ' and cad.c_cod_uni = ''m3'''+
                        ' and mov.c_cod_uni = ''m2'')');
  ExecutaComandoSql(Aux,'update movestoqueprodutos '+
                        ' set c_cod_uni = ''m3'''+
                        ' where i_seq_pro in '+
                        ' (select cad.i_seq_pro from cadprodutos cad, movestoqueprodutos mov '+
                        ' where cad.i_seq_pro = mov.i_seq_pro '+
                        ' and cad.c_cod_uni = ''m3'''+
                        ' and mov.c_cod_uni = ''mt'')');
  ExecutaComandoSql(Aux,'update movestoqueprodutos '+
                        ' set c_cod_uni = ''mt'''+
                        ' where i_seq_pro in '+
                        ' (select cad.i_seq_pro from cadprodutos cad, movestoqueprodutos mov '+
                        ' where cad.i_seq_pro = mov.i_seq_pro '+
                        ' and cad.c_cod_uni = ''mt'''+
                        ' and mov.c_cod_uni = ''m3'')');}
  ExecutaComandoSql(Aux,'update movestoqueprodutos '+
                        ' set c_cod_uni = ''m2'''+
                        ' where i_seq_pro in '+
                        ' (select cad.i_seq_pro from cadprodutos cad, movestoqueprodutos mov '+
                        ' where cad.i_seq_pro = mov.i_seq_pro '+
                        ' and cad.c_cod_uni = ''m2'''+
                        ' and mov.c_cod_uni = ''pc'')'+
                        ' and d_Dat_mov between ''2006/09/01''and ''2006/09/30''');
  ExecutaComandoSql(Aux,'update movestoqueprodutos '+
                        ' set c_cod_uni = ''pc'''+
                        ' where i_seq_pro in '+
                        ' (select cad.i_seq_pro from cadprodutos cad, movestoqueprodutos mov '+
                        ' where cad.i_seq_pro = mov.i_seq_pro '+
                        ' and cad.c_cod_uni = ''pc'''+
                        ' and mov.c_cod_uni = ''m2'')'+
                        ' and d_Dat_mov between ''2006/09/01''and ''2006/09/30''');
  BarraStatus.Panels[0].Text := 'Efetuado com sucesso!!!';
  BarraStatus.refresh;

end;

procedure TFPrincipal.BitBtn3Click(Sender: TObject);
begin
  AdicionaSQLAbreTabela(Aux,'Select * from CADCONDICOESPAGTO');
  While not Aux.Eof do
  begin
    ExecutaComandoSql(Orcamentos,'Update MOVCONDICAOPAGTO '+
                                 ' set N_PER_PAG = '+SubstituiStr(FloatToStr(100/Aux.FieldByName('I_QTD_PAR').AsInteger),',','.')+
                                 ' , N_PER_COM = '+SubstituiStr(FloatToStr(100/Aux.FieldByName('I_QTD_PAR').AsInteger),',','.')+
                                 ' Where I_COD_PAG = '+Aux.FieldByName('I_COD_PAG').AsString);
    Aux.next;
  end;
  BarraStatus.Panels[0].Text := 'Efetuado com sucesso!!!';
  BarraStatus.refresh;
end;

{******************************************************************************}
procedure TFPrincipal.BitBtn4Click(Sender: TObject);
begin
  AdicionaSQLAbreTabela(Orcamentos,'Select * from CADCLIENTES'+
                                   ' WHERE C_FO1_CLI LIKE ''(47)%''');
  While not OrcamentoS.Eof do
  begin

    if (copy(Orcamentos.FieldByName('C_FO1_CLI').AsString,5,1) = ' ') AND (Orcamentos.FieldByName('C_FO1_CLI').AsString <> '') then
    begin
      Orcamentos.Edit;
      Orcamentos.FieldByName('C_FO1_CLI').AsString := copy(Orcamentos.FieldByName('C_FO1_CLI').AsString,1,4) +'3'+copy(Orcamentos.FieldByName('C_FO1_CLI').AsString,6,14);
      Orcamentos.Post;
    end;
    Orcamentos.next;
  end;
  BarraStatus.Panels[0].Text := 'Efetuado com sucesso!!!';
  BarraStatus.refresh;
end;

{******************************************************************************}
procedure TFPrincipal.BitBtn5Click(Sender: TObject);
begin
  AdicionaSQLAbreTabela(Orcamentos,'Select * from CADCLIENTES ');
  while not Orcamentos.eof do
  begin
    BarraStatus.Panels[0].Text := 'Atualizando Cliente '+Orcamentos.FieldByName('C_NOM_CLI').AsString;
    BarraStatus.refresh;
    if Orcamentos.FieldByName('C_NOM_CLI').AsString = UpperCase(Orcamentos.FieldByName('C_NOM_CLI').AsString) then
    begin
      Orcamentos.Edit;
      Orcamentos.FieldByName('C_NOM_CLI').AsString := PrimeirasMaiusculas(Orcamentos.FieldByName('C_NOM_CLI').AsString);
      Orcamentos.FieldByName('C_NOM_FAN').AsString := PrimeirasMaiusculas(Orcamentos.FieldByName('C_NOM_FAN').AsString);
      Orcamentos.post;
    end;

    Orcamentos.Next;
  end;

end;

procedure TFPrincipal.BitBtn6Click(Sender: TObject);
begin
  AdicionaSQLAbreTabela(Orcamentos,'Select * from CADCLIENTES ');
  while not Orcamentos.eof do
  begin
    BarraStatus.Panels[0].Text := 'Atualizando Cliente '+Orcamentos.FieldByName('C_NOM_CLI').AsString;
    BarraStatus.refresh;
    if CopiaAteChar(Orcamentos.FieldByName('C_OBS_CLI').AsString,'=') = 'Contato Financeiro ' then
    begin
      Orcamentos.Edit;
      Orcamentos.FieldByName('C_OBS_CLI').AsString := DeletaCharE(DeleteAteChar(Orcamentos.FieldByName('C_OBS_CLI').AsString,'='),' ');
      Orcamentos.FieldByName('C_CON_FIN').AsString := CopiaAteChar(Orcamentos.FieldByName('C_OBS_CLI').AsString,#13);
      Orcamentos.FieldByName('C_OBS_CLI').AsString := DeleteAteChar(Orcamentos.FieldByName('C_OBS_CLI').AsString,#13);
      Orcamentos.post;
    end;

    Orcamentos.Next;
  end;
end;

{******************************************************************************}
procedure TFPrincipal.BitBtn7Click(Sender: TObject);
begin
  AdicionaSQLAbreTabela(Orcamentos,'Select * from CADORCAMENTOS '+
                                   ' Where D_DAT_ORC >= ''2006/05/01''');
  While not Orcamentos.Eof do
  begin
    AdicionaSQLAbreTabela(Tabela,'Select MOV.I_SEQ_PRO, MOV.I_LAN_ORC, MOV.N_QTD_MOV, MOV.N_VLR_MOV, '+
                                 ' MOV.I_COD_COR, MOV.C_COD_UNI, PRO.C_COD_UNI UNIORIGINAL '+
                                 ' from MOVESTOQUEPRODUTOS MOV, CADPRODUTOS PRO '+
                                 ' Where MOV.I_EMP_FIL = '+Orcamentos.FieldByName('I_EMP_FIL').AsString+
                                 ' and MOV.I_LAN_ORC = '+Orcamentos.FieldByName('I_LAN_ORC').AsString+
                                 ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO ');
    while not Tabela.Eof do
    begin
      AdicionaSQLAbreTabela(MovOrcamentos,'Select * from MOVORCAMENTOS ' +
                                          ' Where I_EMP_FIL = '+Orcamentos.FieldByName('I_EMP_FIL').AsString +
                                          ' and I_LAN_ORC = ' + Orcamentos.FieldByName('I_LAN_ORC').AsString +
                                          ' and I_SEQ_PRO = '+Tabela.FieldByName('I_SEQ_PRO').AsString);
      if MovOrcamentos.eof then
      begin
        FunProdutos.BaixaProdutoEstoque(Tabela.FieldByName('I_SEQ_PRO').AsInteger,varia.OperacaoEstoqueEstornoEntrada,0,
                                  Tabela.FieldByName('I_LAN_ORC').AsInteger,Tabela.FieldByName('I_LAN_ORC').AsInteger,1101,Tabela.FieldByName('I_COD_COR').AsInteger,date,
                                  Tabela.FieldByName('N_QTD_MOV').AsFloat,Tabela.FieldByName('N_VLR_MOV').AsFloat,Tabela.FieldByName('C_COD_UNI').AsString,
                                  Tabela.FieldByName('UNIORIGINAL').AsString,'', false,false);


      end;
      Tabela.Next;
    end;
    Orcamentos.Next;
  end;
end;

procedure TFPrincipal.BitBtn8Click(Sender: TObject);
begin
  ExecutaComandoSql(Aux,'UPDATE CONTRATOCORPO '+
                        ' SET DATULTIMAEXECUCAO = '+SQLTextoDataAAAAMMMDD(PrimeiroDiaMesAnterior));  
end;


{******************************************************************************}
procedure TFPrincipal.BitBtn9Click(Sender: TObject);
begin
{  AdicionaSQLAbreTabela(CEPCorreios,'Select DISTINCT(LOCAL_LOG) FROM DCEPPR ');
  AdicionaSQLAbreTabela(Endereco,'Select * from CAD_CIDADES ');
  while not CEPCorreios.Eof do
  begin
    if CEPCorreios.FieldByName('LOCAL_LOG').AsString <> '' then
    begin
      Endereco.Insert;
      Endereco.FieldByName('COD_ESTADO').AsString := 'PR';
      Endereco.FieldByName('COD_PAIS').AsString := 'BR';
      Endereco.FieldByName('DES_CIDADE').AsString := CEPCorreios.FieldByName('LOCAL_LOG').AsString;
      Endereco.FieldByName('COD_CIDADE').AsInteger := RCodCidadeDisponivel;
      Endereco.Post;
    end;
    CEPCorreios.next;
  end;}
  AdicionaSQLAbreTabela(CEPCorreios,'Select * FROM DCEPPR ');
  AdicionaSQLAbreTabela(Endereco,'Select * from CAD_CEPS ');
  while not CEPCorreios.Eof do
  begin
    if CEPCorreios.FieldByName('CEP8_LOG').AsInteger <> 0 then
    begin
      Endereco.Insert;
      Endereco.FieldByName('COD_CIDADE').AsInteger := RCodCidade(CEPCorreios.FieldByName('LOCAL_LOG').AsString);
      Endereco.FieldByName('NUM_CEP').AsString := CEPCorreios.FieldByName('CEP8_LOG').AsString;
      Endereco.FieldByName('COD_RUA').AsInteger := RCodRua;
      Endereco.FieldByName('COD_LOGRADOURO').AsString := CEPCorreios.FieldByName('TIPO_LOG').AsString;
      Endereco.FieldByName('DES_RUA').AsString := CEPCorreios.FieldByName('NOME_LOG').AsString;
      Endereco.FieldByName('DES_BAIRRO').AsString := CEPCorreios.FieldByName('BAIR1_LOG').AsString;
      Endereco.Post;
    end;
    CEPCorreios.next;
  end;
end;

end.
