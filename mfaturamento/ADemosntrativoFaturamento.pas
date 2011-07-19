unit ADemosntrativoFaturamento;

{          Autor: Rafael Budag
    Data Criação: 19/05/1999;
          Função: Consultar as notas fiscais.
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Componentes1, ExtCtrls, PainelGradiente, Localizacao, Buttons,
  Db, DBTables, ComCtrls, Grids, DBGrids, printers, Mask,
  numericos, Tabela, DBCtrls, DBKeyViolation, Geradores, DBClient;

type
  TFDemonstrativoFaturamento = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Localiza: TConsultaPadrao;
    DATANOTAS: TDataSource;
    BitBtn3: TBitBtn;
    PageControl1: TPageControl;
    PanelColor3: TPanelColor;
    Label8: TLabel;
    Label10: TLabel;
    Label7: TLabel;
    SpeedButton4: TSpeedButton;
    Label11: TLabel;
    Data1: TCalendario;
    data2: TCalendario;
    EClientes: TEditLocaliza;
    NotaGrid: TGridIndice;
    RDemonstrativo: TRadioGroup;
    ETotalNotas: Tnumerico;
    ETotalServico: Tnumerico;
    EICMS: Tnumerico;
    EISQN: Tnumerico;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    CEmpresaFilial: TComboBoxColor;
    Label5: TLabel;
    NOTAS: TSQL;
    NOTASEMISSAO: TWideStringField;
    NOTASNOTAS: TFMTBCDField;
    NOTASICMS: TFMTBCDField;
    NOTASSERVICO: TFMTBCDField;
    NOTASISQN: TFMTBCDField;
    AUX: TSQL;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EClientesSelect(Sender: TObject);
    procedure ENotasRetorno(Retorno1, Retorno2: String);
    procedure Data1Exit(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
  private
     procedure PosicionaNota;
  public
    { Public declarations }
  end;

var
  FDemonstrativoFaturamento: TFDemonstrativoFaturamento;

implementation

uses APrincipal, constantes, fundata, constMsg,
  funstring, funNumeros, FunSql;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFDemonstrativoFaturamento.FormCreate(Sender: TObject);
begin
  CEmpresaFilial.ItemIndex := 0;
  Data1.DateTime := PrimeiroDiaMes(date);
  Data2.DateTime := UltimoDiaMes(Date);
  PosicionaNota;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFDemonstrativoFaturamento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FechaTabela(Notas);
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      Ações dos Localizas da nota de Saida
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

procedure TFDemonstrativoFaturamento.PosicionaNota;
begin
  LimpaSQLTabela(Notas);
  case RDemonstrativo.ItemIndex of
    0 : NotaGrid.Columns[0].Title.Caption := 'Ano';
    1 : NotaGrid.Columns[0].Title.Caption := 'Mês';
    2 : NotaGrid.Columns[0].Title.Caption := 'Data de Emissão';
  end;
  InseriLinhaSQL(Notas, 0, ' select ');
  InseriLinhaSQL(Notas, 1, ' ');
  InseriLinhaSQL(Notas, 2,
      ' SUM(COALESCE(N_TOT_NOT, 0)) NOTAS, ' +
      ' SUM(COALESCE(N_VLR_ICM, 0)) ICMS, ' +
      ' SUM(COALESCE(N_TOT_SER, 0)) SERVICO, ' +
      ' SUM(COALESCE(N_VLR_ISQ, 0)) ISQN from ' +
      ' CadNotaFiscais NF ' +
      ' WHERE C_NOT_CAN = ''N''');
  InseriLinhaSQL(Notas, 3, SQLTextoDataEntreAAAAMMDD( ' and D_DAT_EMI ', Data1.Date, Data2.Date, False) );

  if CEmpresaFilial.ItemIndex = 0 then
    InseriLinhaSQL(Notas, 4, ' and NF.I_EMP_FIL = ' + IntToStr(varia.CodigoEmpFil) )
  else
    InseriLinhaSQL(Notas, 4, ' and left(NF.I_EMP_FIL,1) = '  + IntToStr(varia.CodigoEmpresa) );



  if (EClientes.Text <> '') then
    InseriLinhaSQL(Notas, 5, ' and I_COD_CLI = ' + EClientes.Text)
  else
    InseriLinhaSQL(Notas, 5, '');
  AUX.SQL.Clear;
  AUX.SQL := Notas.SQL;
  AbreTabela(AUX);
  // Soma Valores;
  ETotalNotas.AValor := AUX.FieldByName('NOTAS').AsFloat;
  ETotalServico.AValor := AUX.FieldByName('SERVICO').AsFloat;
  EICMS.AValor := AUX.FieldByName('ICMS').AsFloat;
  EISQN.AValor := AUX.FieldByName('ISQN').AsFloat;
  DeletaLinhaSQL(Notas, 1);
  case RDemonstrativo.ItemIndex of
    0 : InseriLinhaSQL(Notas, 1, ' CAST(EXTRACT(YEAR FROM D_DAT_EMI) AS CHAR(10)) EMISSAO, ');
    1 : InseriLinhaSQL(Notas, 1, ' CAST(EXTRACT(MONTH FROM D_DAT_EMI) AS CHAR(10)) EMISSAO, ');
    2 : InseriLinhaSQL(Notas, 1, ' CAST(D_DAT_EMI AS CHAR(10)) EMISSAO, ');
  end;
  case RDemonstrativo.ItemIndex of
    0 : InseriLinhaSQL(Notas, 6, ' GROUP BY CAST(EXTRACT(YEAR FROM D_DAT_EMI) AS CHAR(10)) ');
    1 : InseriLinhaSQL(Notas, 6, ' GROUP BY CAST(EXTRACT(YEAR FROM D_DAT_EMI) AS CHAR(10)) ');
    2 : InseriLinhaSQL(Notas, 6, ' GROUP BY D_DAT_EMI ORDER BY D_DAT_EMI ');
  end;
  AbreTabela(Notas);
end;
{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          Ações das Notas de Entrada
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{************************Procura pelo Cliente**********************************}
procedure TFDemonstrativoFaturamento.EClientesSelect(Sender: TObject);
begin
  EClientes.ASelectValida.Clear;
  EClientes.ASelectValida.Add(' select * from CadClientes Cli ' +
                              ' where c_ind_cli = ''S'''+
                              ' and CLI.C_NOM_CLI = ''@'' ' );
  EClientes.ASelectLocaliza.Clear;
  EClientes.ASelectLocaliza.Add(' select * from CadClientes Cli ' +
                                ' where c_ind_cli = ''S'''+
                                ' and CLI.C_NOM_CLI like ''@%'' order by c_nom_cli' );
end;


procedure TFDemonstrativoFaturamento.ENotasRetorno(Retorno1, Retorno2: String);
begin
   PosicionaNota;
end;

procedure TFDemonstrativoFaturamento.Data1Exit(Sender: TObject);
begin
   PosicionaNota;
end;

procedure TFDemonstrativoFaturamento.BitBtn3Click(Sender: TObject);
begin
  Close;
end;

procedure TFDemonstrativoFaturamento.BitBtn4Click(Sender: TObject);
begin
  // CARREGA A NOTA FISCAL.
end;

Initialization
 RegisterClasses([TFDemonstrativoFaturamento]);
end.
