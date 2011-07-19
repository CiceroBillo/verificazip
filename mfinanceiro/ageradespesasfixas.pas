unit AGeraDespesasFixas;
{          Autor: Sergio Luiz Censi
    Data Criação: 06/04/1999;
          Função: Cadastrar um novo


Motivo alteração: - Adicionado os comentários e o blocos nas rotinas, e realizado
                    um teste - 06/04/199 / Rafael Budag
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, PainelGradiente, Componentes1, Db, DBTables, StdCtrls, Buttons,
  Mask, DBCtrls, Tabela, Localizacao, numericos;

type
   TCamposAdicionar = class
     Filial : integer;
     CodigoDespesa : integer;
     CodigoHistorico : integer;
     CodigoFornecedor : integer;
     CodigoConta : string;
     Datavencimento : TDateTime;
     Valor : double;
     CodigoMoeda : Integer;
  end;


type
  TFGeraDespesasFixas = class(TFormulario)
    Cabecalho: TPainelGradiente;
    Painel: TPanelColor;
    Label1: TLabel;
    Aux: TQuery;
    Localiza: TConsultaPadrao;
    Label4: TLabel;
    BOk: TBitBtn;
    Label5: TLabel;
    Despesa: TEditColor;
    EditColor5: TEditColor;
    Label6: TLabel;
    Historico: TEditColor;
    EditColor7: TEditColor;
    Label7: TLabel;
    CaixaDia: TEditColor;
    adicionara: TQuery;
    BCancelar: TBitBtn;
    Atualiza: TQuery;
    Label8: TLabel;
    ValorInicial: Tnumerico;
    SpeedButton1: TSpeedButton;
    Label16: TLabel;
    Fornecedor: TEditLocaliza;
    Label2: TLabel;
    Conta: TEditLocaliza;
    SpeedButton2: TSpeedButton;
    Label3: TLabel;
    Label9: TLabel;
    SpeedButton3: TSpeedButton;
    Label10: TLabel;
    CodigoMoeda: TEditLocaliza;
    procedure FormCreate(Sender: TObject);
    procedure BOkClick(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure CaixaDiaChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FornecedorCadastrar(Sender: TObject);
    procedure ValorInicialExit(Sender: TObject);
    procedure ContaCadastrar(Sender: TObject);
  private
     campos : TCamposAdicionar;
     acao : Boolean;
     procedure VerificaOk;
  public
    procedure AdicionaRegistro( reg : TCamposAdicionar);
    procedure GeraDespesaFixas( mesMedia : Integer; mesGerar : integer; CodigoDespesa : integer; CodigoHistorico : Integer);
  end;

var
  FGeraDespesasFixas: TFGeraDespesasFixas;

implementation

uses APrincipal, fundata, constantes, constMsg, funstring,
    ABancos, ANovoCliente, AContas;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFGeraDespesasFixas.FormCreate(Sender: TObject);
begin
  campos := TCamposAdicionar.Create;
  acao := true;
end;


{******************************Valida a gravacao*******************************}
procedure TFGeraDespesasFixas.VerificaOk;
begin
  if (CaixaDia.Text <> '') and (ValorInicial.AValor <> 0) and (Fornecedor.Text <> '')  then
     BOk.enabled := true
  else
     BOk.enabled := false;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Geram a Despesa
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{ *****************************gera as contas fixas*****************************}
procedure TFGeraDespesasFixas.GeraDespesaFixas( mesMedia : Integer; mesGerar : integer; CodigoDespesa : integer; CodigoHistorico : Integer);
var
  somaDia : integer;
  somaValor : Double;
  SomaRegistro : word;
  laco : integer;
  NovoMes : TDateTime;
begin
  SomaDia := 0;
  self.Aux.close;          // verifica se a historicos nos meses anteriores
  self.aux.sql.clear;
  self.aux.sql.Add('select ' +
              ' CP.I_COD_HIS, CP.I_COD_CLI, MCP.C_NRO_CON, CP.I_COD_MOE, ' +
              ' MCP.D_DAT_VEN, MCP.N_VLR_DUP, CP.I_EMP_FIL, CP.I_COD_DES ' +
              ' from dba.CadContasaPagar as CP, dba.MovContasaPagar as MCP' +
              ' where  CP.I_EMP_FIL = MCP.I_EMP_FIL and CP.I_LAN_APG = MCP.I_LAN_APG ' +
              ' and CP.I_EMP_FIL = ' + IntToStr(varia.codigoEmpFil) +
              ' and CP.I_COD_DES = ' + IntToStr(CodigoDespesa) +
              ' and MCP.D_DAT_VEN between ''' + DataToStrFormato(AAAAMMDD,PrimeiroDiaMes(decmes(date,MesMedia)),'/') + '''' +
              ' and ''' + DataToStrFormato(AAAAMMDD,UltimoDiaMesAnterior,'/') + '''' );
  self.aux.open;
  if self.aux.EOF then   // se não possuir historico
  begin
    Despesa.Text := IntToStr(CodigoDespesa);
    Historico.Text := IntToStr(CodigoHistorico);
    showModal;
      if acao then     // caso o usuario cancele a operacao
      begin
        campos.Filial  := varia.CodigoEmpFil;       // carrega a objeto om informacoes para gerar o inserção
        campos.CodigoDespesa  := StrToInt(despesa.Text);
        campos.CodigoHistorico := StrToInt(Historico.Text);
        campos.CodigoFornecedor := StrToInt(Fornecedor.Text);
        campos.CodigoConta := Conta.text;
        campos.Valor  := valorInicial.AValor;
        campos.CodigoMoeda := StrToInt(CodigoMoeda.text);
        SomaDia := StrToInt(CaixaDia.text);
      end;
      end
   else                // se possuir historico
   begin
      somadia := 0;
      somaValor := 0;
      SomaRegistro := 0;
      self.aux.First;
      while not self.aux.EOF do
      begin
        SomaDia := SomaDia + dia(self.aux.fieldByName('D_DAT_VEN').AsDateTime);
        SomaValor := SomaValor + self.aux.fieldByName('N_VLR_DUP').AsFloat;
        inc(SomaRegistro);
        self.aux.next;
      end;
      SomaDia := SomaDia div SomaRegistro;   // calcula a media do dia do vencimento
      SomaValor := SomaValor / SomaRegistro; // calcula a media do valor de pagamento


      self.aux.Last;
      campos.Filial  := self.aux.fieldByName('I_EMP_FIL').asInteger; // carrega a objeto com informacoes para gerar o inserção
      campos.CodigoDespesa  := self.aux.fieldByName('I_COD_DES').asInteger;
      campos.CodigoHistorico := self.aux.fieldByName('I_COD_HIS').asInteger;
      campos.CodigoFornecedor := self.aux.fieldByName('I_COD_cli').asInteger;
      campos.CodigoConta := self.aux.fieldByName('C_NRO_CON').AsString;
      campos.CodigoMoeda := self.aux.fieldByName('I_COD_MOE').AsInteger;
      campos.Valor  := SomaValor;
   end;
  if acao then   // caso o usuario cancele a operacao
  begin
    NovoMes := date;
    for  laco := 1 to MesGerar do      // gera as despesas para os proximos meses
    begin
       self.aux.close;
       self.aux.sql.clear;
       self.aux.sql.Add('select CP.I_LAN_APG ' +
                   ' from dba.CadContasaPagar as CP, dba.MovContasaPagar as MCP' +
                   ' where  CP.I_EMP_FIL = MCP.I_EMP_FIL and CP.I_LAN_APG = MCP.I_LAN_APG ' +
                   ' and CP.I_EMP_FIL = ' + IntToStr(varia.codigoEmpFil) +
                   ' and CP.I_COD_DES = ' + IntToStr(CodigoDespesa) +
                   ' and MCP.D_DAT_VEN between ''' + DataToStrFormato(AAAAMMDD,PrimeiroDiaMes(NovoMes),'/') + '''' +
                   ' and ''' + DataToStrFormato(AAAAMMDD,UltimoDiaMes(NovoMes),'/') + '''' );
       self.aux.open;

       if self.aux.EOF then
       begin
          campos.Datavencimento := MontaData(SomaDia,Mes(NovoMes),ano(Novomes));
          AdicionaRegistro(campos);
       end;
     NovoMes := IncMes(date,laco);
    end;
  end;
end;

{****************************Adiciona o registro*******************************}
procedure TFGeraDespesasFixas.AdicionaRegistro( reg : TCamposAdicionar);
var
   proximolan : integer;
begin
   adicionara.close;
   adicionara.sql.Clear;
   adicionara.sql.Add('select * from dba.CadContasaPagar where i_emp_fil = ' +
                     intToStr(varia.codigoEmpFil) + ' order by  i_lan_apg ');
   adicionara.open;
   adicionara.last;
   ProximoLan := adicionara.fieldByName('I_LAN_APG').AsInteger + 1;

   Adicionara.close;
   Adicionara.sql.Clear;    // adiciona o cabecalho
   Adicionara.SQl.Add('insert into dba.CadContasaPagar(I_EMP_FIL, I_LAN_APG, ' +
                     'I_COD_DES, I_COD_HIS, ' +
                     ' I_COD_CLI, D_DAT_MOV, '+
                     'D_DAT_EMI,  I_QTD_PAR, N_VLR_TOT, I_COD_MOE ) ' +
                     'VALUES( ' +
                     IntToStr(reg.Filial) + ',' +
                     IntToStr(Proximolan) + ',' +
                     IntToStr(reg.CodigoDespesa) + ',' +
                     IntToStr(reg.CodigoHistorico) + ',' +
                     IntToStr(reg.CodigoFornecedor) + ',' +
                     '''' + dataToStrFormato(AAAAMMDD,date,'/') + ''',' +
                     '''' + dataToStrFormato(AAAAMMDD,date,'/') + ''',' +
                     '1,' +
                     SubstituiStr(FloatToStr(reg.Valor),',','.') + ',' +
                     IntToStr(reg.CodigoMoeda) + ')' );
   adicionara.ExecSQL;

   adicionara.close;
   Adicionara.sql.Clear;     // adiciona o movimento
   Adicionara.SQl.Add('insert into dba.MovContasaPagar(I_EMP_FIL, I_LAN_APG, ' +
                     'I_NRO_PAR, D_DAT_VEN, N_VLR_DUP, L_OBS_APG, C_NRO_CON ) ' +
                     'VALUES( ' +
                     IntToStr(reg.Filial) + ',' +
                     IntToStr(Proximolan) + ',' +
                     '1,' +
                     '''' + dataToStrFormato(AAAAMMDD,reg.Datavencimento,'/') + ''',' +
                     SubstituiStr(FloatToStr(reg.Valor),',','.') + ','+ '''Conta gerada pelo sistema ''' + ','  );
   if reg.CodigoConta <> '' then
     Adicionara.SQl.Add('''' + reg.CodigoConta +  ''')' )
   else
     Adicionara.SQl.Add(' null )' );
   adicionara.ExecSQL;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações dos localizas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{***********************Cadastra um novo fornecedor****************************}
procedure TFGeraDespesasFixas.FornecedorCadastrar(Sender: TObject);
begin
  FNovoCliente := TFNovoCliente.CriarSDI(application,'',true);
  FNovoCliente.CadClientes.Insert;
  FNovoCliente.ShowModal;
  Localiza.AtualizaConsulta;
end;

{*************************Cadastra uma nova conta******************************}
procedure TFGeraDespesasFixas.ContaCadastrar(Sender: TObject);
begin
  FContas := TFContas.CriarSDI(Application,'',FPrincipal.VerificaPermisao('FContas'));
  FContas.CadContas.insert;
  FContas.ShowModal;
  Localiza.AtualizaConsulta;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{****************************Fecha o Formulario corrente***********************}
procedure TFGeraDespesasFixas.BOkClick(Sender: TObject);
begin
  close;
end;

{****************************Cancela a operacao********************************}
procedure TFGeraDespesasFixas.BCancelarClick(Sender: TObject);
begin
  acao := false;
  close;
end;

{**********************So deixa digitar dias ate o dia 28**********************}
procedure TFGeraDespesasFixas.CaixaDiaChange(Sender: TObject);
begin
  if caixaDia.Text <> '' then
    if (StrToInt(Caixadia.text) > 28)  then
      Caixadia.text := '';
  VerificaOk;
end;

{************************Quando o formulario é mostrado************************}
procedure TFGeraDespesasFixas.FormShow(Sender: TObject);
begin
  Fornecedor.Text := '';
  ValorInicial.AValor := 0;
  CaixaDia.Text := '';
end;


{*******************Valida a gravacao quando sai do campo**********************}
procedure TFGeraDespesasFixas.ValorInicialExit(Sender: TObject);
begin
  VerificaOk;
end;


Initialization
 RegisterClasses([TFGeraDespesasFixas]);
end.
