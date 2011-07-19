unit AEtiquetaCliente;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Db, DBTables, Localizacao, ComCtrls, Componentes1, StdCtrls, Buttons,
  Grids, DBGrids, Tabela, DBKeyViolation, ExtCtrls, PainelGradiente, Mask,
  numericos, unclassesImprimir, DBCtrls, unimpressao, Spin, Gauges;

type
  TFEtiquetaClientes = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor3: TPanelColor;
    Label18: TLabel;
    SpeedButton6: TSpeedButton;
    Label20: TLabel;
    EditLocaliza4: TEditLocaliza;
    GridIndice1: TGridIndice;
    PanelColor2: TPanelColor;
    BBAjuda: TBitBtn;
    BFechar: TBitBtn;
    Data1: TCalendario;
    Data2: TCalendario;
    Localiza: TConsultaPadrao;
    Consulta: TQuery;
    DataConsulta: TDataSource;
    ConsultaC_NOM_CLI: TStringField;
    ConsultaC_END_CLI: TStringField;
    ConsultaC_BAI_CLI: TStringField;
    ConsultaC_CEP_CLI: TStringField;
    ConsultaC_EST_CLI: TStringField;
    ConsultaC_CID_CLI: TStringField;
    ConsultaC_FO1_CLI: TStringField;
    ConsultaD_DAT_NAS: TDateField;
    ConsultaI_NUM_END: TIntegerField;
    CPeriodo: TComboBoxColor;
    ConsultaD_DAT_CAD: TDateField;
    ConsultaD_DAT_ALT: TDateField;
    ConsultaI_COD_CLI: TIntegerField;
    numerico1: Tnumerico;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    Label2: TLabel;
    CModelo: TDBLookupComboBoxColor;
    DBText2: TDBText;
    CAD_DOC: TQuery;
    CAD_DOCI_NRO_DOC: TIntegerField;
    CAD_DOCI_SEQ_IMP: TIntegerField;
    CAD_DOCC_NOM_DOC: TStringField;
    CAD_DOCC_TIP_DOC: TStringField;
    CAD_DOCC_NOM_IMP: TStringField;
    DATACAD_DOC: TDataSource;
    CAD_DOCN_COL_ETI: TFloatField;
    Nulo: TGroupBox;
    CRua: TCheckBox;
    CNumero: TCheckBox;
    CBairro: TCheckBox;
    CEstado: TCheckBox;
    CCidade: TCheckBox;
    CCep: TCheckBox;
    Label76: TLabel;
    ESituacao: TEditLocaliza;
    SpeedButton5: TSpeedButton;
    Label78: TLabel;
    Label82: TLabel;
    ERegiao: TEditLocaliza;
    SpeedButton10: TSpeedButton;
    Label83: TLabel;
    Label12: TLabel;
    ECidade: TEditLocaliza;
    BCidade: TSpeedButton;
    CPessoa: TComboBoxColor;
    Label3: TLabel;
    Label4: TLabel;
    EPRofissao: TEditLocaliza;
    SpeedButton2: TSpeedButton;
    Label47: TLabel;
    ConsultaI_COD_PRF: TIntegerField;
    ConsultaI_COD_SIT: TIntegerField;
    ConsultaI_COD_REG: TIntegerField;
    ConsultaC_TIP_PES: TStringField;
    CSexo: TComboBoxColor;
    Label5: TLabel;
    ConsultaC_SEX_CLI: TStringField;
    idade1: TSpinEditColor;
    idade2: TSpinEditColor;
    CIDade: TCheckBox;
    Label6: TLabel;
    CCliFor: TComboBoxColor;
    Barra: TGauge;
    SomaCli: TQuery;
    LSomaCli: TLabel;
    Label7: TLabel;
    BitBtn2: TBitBtn;
    ConsultaC_COM_END: TStringField;
    BitBtn3: TBitBtn;
    GroupBox1: TGroupBox;
    CRRua: TCheckBox;
    CRNumero: TCheckBox;
    CRBairro: TCheckBox;
    CREstado: TCheckBox;
    CRCidade: TCheckBox;
    CRCep: TCheckBox;
    ConsultaIdadeCli: TSmallintField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure EditLocaliza4FimConsulta(Sender: TObject);
    procedure CIDadeClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    IMP : TFuncoesImpressao;
    Ajustar : boolean;
    RRua, RNumero, RBairro, RCEP,  REstado,  RCidade : string;
    procedure CarregaDados;
    procedure ImprimirTodos;
    procedure ImprimirSelecionado;
    procedure CarregaRotulos;
  public
    { Public declarations }
  end;

var
  FEtiquetaClientes: TFEtiquetaClientes;

implementation

uses APrincipal, funsql, fundata, constantes, constmsg;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFEtiquetaClientes.FormCreate(Sender: TObject);
begin
  IMP := TFuncoesImpressao.Criar(self, FPrincipal.BaseDados);
  Data1.Date := date;
  Data2.Date := date;
  CPeriodo.ItemIndex := 0;
  CPessoa.ItemIndex := 0;
  CSexo.ItemIndex := 0;
  CCliFor.ItemIndex := 0;
  AbreTabela(CAD_DOC);
  CModelo.KeyValue:=CAD_DOCI_NRO_DOC.AsInteger; // Posiciona no Primeiro;
  CarregaDados;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFEtiquetaClientes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  IMP.free;
  FechaTabela(CAD_DOC);
  FechaTabela(Consulta);
  Action := CaFree;
end;

procedure TFEtiquetaClientes.CarregaDados;
var
  nulo : string;
begin
  LimpaSQLTabela(Consulta);
  AdicionaSQLTabela(Consulta, 'Select' );
  AdicionaSQLTabela(Consulta, '  year(now())-year(d_dat_nas) idadeCli, * ' );
  AdicionaSQLTabela(Consulta, ' from CadClientes where i_cod_cli is not null ' );

  if EditLocaliza4.Text <> '' then
    AdicionaSQLTabela(Consulta, ' and  I_COD_CLI = ' +  EditLocaliza4.Text)
  else
    AdicionaSQLTabela(Consulta, ' ');

  case CPeriodo.ItemIndex of
    0 : AdicionaSQLTabela(Consulta, '  ' );
    1 : AdicionaSQLTabela(Consulta, SQLTextoDataEntreAAAAMMDD('D_DAT_ALT',data1. date, data2.date, true));
    2 : AdicionaSQLTabela(Consulta, SQLTextoDataEntreAAAAMMDD('D_DAT_CAD',data1. date, data2.date, true));
    3 : AdicionaSQLTabela(Consulta, ' and month(D_DAT_NAS) >= ' + IntTostr(mes(data1.DateTime)) +
                                    ' and month(D_DAT_NAS) <= ' + IntTostr(mes(data2.DateTime)) +
                                    ' and  ( day(D_DAT_NAS) >= ' + IntTostr(dia(data1.DateTime)) +
                                    '        or month(D_DAT_NAS) <> ' + IntTostr(mes(data1.DateTime)) + ')' +
                                    ' and  ( day(D_DAT_NAS) <= ' + IntTostr(dia(data2.DateTime)) +
                                    '        or month(D_DAT_NAS) <> ' + IntTostr(mes(data2.DateTime)) + ')' );
  end;

  if numerico1.AValor <> 0 then
    AdicionaSQLTabela(Consulta, ' and i_cod_cli > ' + IntToStr(trunc(numerico1.avalor)) )
  else
    AdicionaSQLTabela(Consulta, ' ');

    nulo := '';
    if not CRua.Checked then
      nulo := nulo + ' and c_end_cli is not null';
    if not CNumero.Checked then
      nulo := nulo + ' and i_num_end is not null';
    if not CBairro.Checked then
      nulo := nulo + ' and c_bai_cli is not null';
    if not CCidade.Checked then
      nulo := nulo + ' and c_cid_cli is not null';
    if not CEstado.Checked then
      nulo := nulo + ' and c_est_cli is not null';
    if not CCep.Checked then
      nulo := nulo + ' and c_cep_cli is not null';
   AdicionaSQLTabela(Consulta, nulo);

  if EPRofissao.Text <> '' then
    AdicionaSQLTabela(Consulta, ' and i_cod_prf = ' + EPRofissao.text )
  else
    AdicionaSQLTabela(Consulta, ' ');

  if ESituacao.Text <> '' then
    AdicionaSQLTabela(Consulta, ' and i_cod_sit = ' + ESituacao.text )
  else
    AdicionaSQLTabela(Consulta, ' ');

  if ERegiao.Text <> '' then
    AdicionaSQLTabela(Consulta, ' and i_cod_reg = ' + ERegiao.text )
  else
    AdicionaSQLTabela(Consulta, ' ');

   if ECidade.Text <> '' then
    AdicionaSQLTabela(Consulta, ' and c_cid_cli = ''' + ECidade.text + '''' )
  else
    AdicionaSQLTabela(Consulta, ' ');

  case CPessoa.ItemIndex of
    0 : AdicionaSQLTabela(Consulta, ' ');
    1 : AdicionaSQLTabela(Consulta, ' and C_TIP_PES = ''J''');
    2 : AdicionaSQLTabela(Consulta, ' and C_TIP_PES = ''F''');
  end;

  case CSexo.ItemIndex of
    0 : AdicionaSQLTabela(Consulta, ' ');
    1 : AdicionaSQLTabela(Consulta, ' and C_SEX_CLI = ''M''');
    2 : AdicionaSQLTabela(Consulta, ' and C_SEX_CLI = ''F''');
  end;

  if CIDade.Checked then
    AdicionaSQLTabela(Consulta, ' and year(now())-year(d_dat_nas) >= ' + IntTostr(idade1.Value) +
                                ' and year(now())-year(d_dat_nas) <= ' + IntTostr(idade2.Value) )
  else
   AdicionaSQLTabela(Consulta, ' ');

  case CCliFor.ItemIndex of
    0 : AdicionaSQLTabela(Consulta, ' and C_TIP_CAD <> ''F''');
    1 : AdicionaSQLTabela(Consulta, ' and C_TIP_CAD <> ''C''');
    2 : AdicionaSQLTabela(Consulta, ' ');
  end;
  AdicionaSQLTabela(Consulta, ' order by i_cod_cli');
  AbreTabela(Consulta);

  SomaCli.sql := Consulta.SQL;
  SomaCli.sql.Delete(1);
  SomaCli.sql.Insert(1, ' count(*) conta ');
  SomaCli.sql.Delete(GridIndice1.ALinhaSQLOrderBy);
  AbreTabela(SomaCli);
  Barra.MaxValue := somacli.fieldByName('conta').AsInteger;
  LSomaCli.Caption := ' Total de clientes filtrado : ' + somacli.fieldByName('conta').AsString;
end;

{ *************** Registra a classe para evitar duplicidade ****************** }
procedure TFEtiquetaClientes.BFecharClick(Sender: TObject);
begin
  self.close;
end;

procedure TFEtiquetaClientes.EditLocaliza4FimConsulta(Sender: TObject);
begin
  case CPeriodo.ItemIndex  of
    1 : begin GridIndice1.Columns[1].FieldName := 'D_DAT_ALT'; GridIndice1.Columns[1].Title.Caption := 'Data Alt.'; end;
    2 : begin GridIndice1.Columns[1].FieldName := 'D_DAT_CAD'; GridIndice1.Columns[1].Title.Caption := 'Data Cad.'; end;
    3 : begin GridIndice1.Columns[1].FieldName := 'D_DAT_NAS'; GridIndice1.Columns[1].Title.Caption := 'Data Nasc.'; end;
  end;
  CarregaDados;
end;

{************** carrega os rotulos ******************************************}
procedure  TFEtiquetaClientes.CarregaRotulos;
begin
  RRua := '';
  RNumero := '';
  RBairro := '';
  RCEP := '';
  REstado := '';
  RCidade := '';
  if CRRua.Checked then
    RRua := 'Rua: ';
  if CRBairro.Checked then
    RBairro := 'Bairro: ';
  if CNumero.Checked then
    RNumero := 'Nº ';
  if CRCidade.Checked then
    RCidade := 'Cidade: ';
  if CREstado.Checked then
    REstado := 'UF: ';
  if CRCep.Checked then
    RCEP := 'CEP: ';
end;

{*********************** imprime etiquetas ***********************************}
procedure TFEtiquetaClientes.ImprimirTodos;
var
  Dados : TDadosEtiquetaCliente;
begin
  if not CAD_DOC.Eof then
  begin
    CarregaRotulos;
    Consulta.sql.Delete(GridIndice1.ALinhaSQLOrderBy);
    Consulta.sql.Insert(GridIndice1.ALinhaSQLOrderBy, ' order by i_cod_cli');
    AbreTabela(Consulta);
    Consulta.First;

    while not Consulta.Eof do
    begin
       IMP.InicializaImpressao(CAD_DOCI_NRO_DOC.AsInteger, CAD_DOCI_SEQ_IMP.AsInteger);
       Dados := TDadosEtiquetaCliente.create;
       with Dados do
       begin
         Nome := ConsultaC_NOM_CLI.AsString;
         Endereco := RRua + ConsultaC_END_CLI.AsString + ', ' + RNumero + ConsultaI_NUM_END.AsString;
         Bairro := RBairro + ConsultaC_BAI_CLI.AsString;
         Cidade := RCidade + ConsultaC_CID_CLI.AsString;
         Estado := REstado + ConsultaC_EST_CLI.AsString;
         CEP := RCEP + ConsultaC_CEP_CLI.AsString;
         Complemento := ConsultaC_COM_END.AsString;
         consulta.next;
         barra.Progress := barra.Progress + 1;

         if (not Consulta.Eof) and (CAD_DOCN_COL_ETI.AsInteger > 1) then
         begin
           Nome1 := ConsultaC_NOM_CLI.AsString;
           Endereco1 := RRua + ConsultaC_END_CLI.AsString + ', ' + RNumero + ConsultaI_NUM_END.AsString;
           Bairro1 := RBairro + ConsultaC_BAI_CLI.AsString;
           Cidade1 := RCidade + ConsultaC_CID_CLI.AsString;
           Estado1 := REstado + ConsultaC_EST_CLI.AsString;
           CEP1 := RCEP + ConsultaC_CEP_CLI.AsString;
           Complemento1 := ConsultaC_COM_END.AsString;
           barra.Progress := barra.Progress + 1;
           consulta.next;
         end;

         if (not Consulta.Eof) and (CAD_DOCN_COL_ETI.AsInteger > 2) then
         begin
           Nome2 := ConsultaC_NOM_CLI.AsString;
           Endereco2 := RRua + ConsultaC_END_CLI.AsString + ', ' + RNumero + ConsultaI_NUM_END.AsString;
           Bairro2 := RBairro + ConsultaC_BAI_CLI.AsString;
           Cidade2 := RCidade + ConsultaC_CID_CLI.AsString;
           Estado2 := REstado + ConsultaC_EST_CLI.AsString;
           CEP2 := RCEP + ConsultaC_CEP_CLI.AsString;
           Complemento2 := ConsultaC_COM_END.AsString;
           barra.Progress := barra.Progress + 1;
           consulta.next;
         end;

       end;
       IMP.ImprimeEtiquetaCliente(Dados);
       IMP.FechaImpressao(Config.ImpPorta, 'C:\IMP.TXT');
       if Ajustar then
         Break;
     end;
  end
  else
    aviso('Não existe modelo de documento para imprimir.');
  barra.Progress := 0;
  Consulta.First;
end;

{*********************** imprime etiquetas ***********************************}
procedure TFEtiquetaClientes.ImprimirSelecionado;
var
  Dados : TDadosEtiquetaCliente;
begin
  if not CAD_DOC.Eof then
  begin
    CarregaRotulos;
    IMP.InicializaImpressao(CAD_DOCI_NRO_DOC.AsInteger, CAD_DOCI_SEQ_IMP.AsInteger);
    with Dados do
    begin
      Dados := TDadosEtiquetaCliente.create;
      Nome := ConsultaC_NOM_CLI.AsString;
      Endereco := RRua + ConsultaC_END_CLI.AsString + ', ' + RNumero + ConsultaI_NUM_END.AsString;
      Bairro := RBairro + ConsultaC_BAI_CLI.AsString;
      Cidade := RCidade + ConsultaC_CID_CLI.AsString;
      Estado := REstado + ConsultaC_EST_CLI.AsString;
      CEP :=  RCEP + ConsultaC_CEP_CLI.AsString;
      Complemento := ConsultaC_COM_END.AsString;
    end;
    IMP.ImprimeEtiquetaCliente(Dados);
    IMP.FechaImpressao(Config.ImpPorta, 'C:\IMP.TXT');
  end
  else
    aviso('Não existe modelo de documento para imprimir.');
end;

procedure TFEtiquetaClientes.CIDadeClick(Sender: TObject);
begin
  idade1.Enabled := CIDade.Checked;
  idade2.Enabled := CIDade.Checked;
  CarregaDados;
end;

procedure TFEtiquetaClientes.BitBtn1Click(Sender: TObject);
begin
  ajustar := false;
  ImprimirTodos;
end;

procedure TFEtiquetaClientes.BitBtn2Click(Sender: TObject);
begin
  ajustar := true;
  ImprimirTodos;
end;

procedure TFEtiquetaClientes.BitBtn3Click(Sender: TObject);
begin
  ImprimirSelecionado;
end;

Initialization
 RegisterClasses([TFEtiquetaClientes]);
end.
