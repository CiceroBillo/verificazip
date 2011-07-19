unit AImportaEnder;

{          Autor: Douglas Thomas Jacobsen
    Data Criação: 19/10/1999;
          Função: Cadastrar um novo Caixa
  Data Alteração:
    Alterado por:
Motivo alteração:
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, BotaoCadastro, Constantes,
  StdCtrls, Buttons, Db, DBTables, Tabela, Mask, DBCtrls, Grids, DBGrids,
  DBKeyViolation, Localizacao, ComCtrls, Gauges;

type
  TFImportaEnderecos = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    GEstados: TGroupBox;
    CSP: TCheckBox;
    CRJ: TCheckBox;
    CSC: TCheckBox;
    CRS: TCheckBox;
    CPR: TCheckBox;
    ENDER: TQuery;
    AUX: TQuery;
    CADASTRO: TQuery;
    Gauge: TGauge;
    PanelColor2: TPanelColor;
    PMostrar: TPanelColor;
    BitBtn1: TBitBtn;
    BFechar: TBitBtn;
    procedure BFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BBAjudaClick(Sender: TObject);
  private
    VprEstados: string;
    function ProximoCodigoCidade: string;
    function MontaEstados: string;
    function ImportaEnder: string;
    function CadastrarCidades: Boolean;
    function CadastrarPais: Boolean;
    function CadastrarEstados: Boolean;
    function ExisteEstado(VpaEstado: string): Boolean;
    function ExisteCidade(VpaEstado, VpaCidade: string): Boolean;
    function BuscaPaisEstado(VpaEstado: string): string;
    function BuscaNomeEstado(VpaEstado: string): string;
    procedure Texto( texto : string );
  public
    { Public declarations }
  end;

var
  FImportaEnderecos: TFImportaEnderecos;

implementation

uses FunSql, APrincipal, ConstMsg, FunData, FunValida, FunString;

{$R *.DFM}

{********************** quando o formulario e criado **************************}
procedure TFImportaEnderecos.FormCreate(Sender: TObject);
begin
end;

{****************** quando o formulario e fechado *****************************}
procedure TFImportaEnderecos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                       eventos dos botoes Inferiores
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{ ******************* Quando o formulario e fechado ************************** }
procedure TFImportaEnderecos.BFecharClick(Sender: TObject);
begin
  Close;
end;

{******************* chama a rotina para importar *****************************}
procedure TFImportaEnderecos.BitBtn1Click(Sender: TObject);
begin
//d5 ImportaEnder;
end;

{ ************************* aciona a ajuda *********************************** }
procedure TFImportaEnderecos.BBAjudaClick(Sender: TObject);
begin
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              eventos da importacao
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{ *************** monta a stringo de filtro dos estados ********************** }
function TFImportaEnderecos.MontaEstados: string;
begin
  Result:='';
  if CSP.Checked then
    Result:=Result + '''' + CSP.Caption + ''',';
  if CRJ.Checked then
    Result:=Result + '''' + CRJ.Caption + ''',';
  if CSC.Checked then
    Result:=Result + '''' + CSC.Caption + ''',';
  if CRS.Checked then
    Result:=Result + '''' + CRS.Caption + ''',';
  if CPR.Checked then
    Result:=Result + '''' + CPR.Caption + ''',';
  if result <> '' then
  begin
    result := copy(result, 0, length(result)-1);
    result :='(' + result + ')';
  end;
end;

{ ********************* importa os enderecos ********************************* }
function TFImportaEnderecos.ImportaEnder: string;
begin
  VprEstados:=MontaEstados;
    if CadastrarPais then
      if CadastrarEstados then
         CadastrarCidades
end;

{ ***************** cadastra as cidades caso não existam ********************* }
function TFImportaEnderecos.CadastrarCidades: Boolean;
begin
  Gauge.Progress:=0;
  Texto('Cadastrando Cidades...');
  Result:=True;
  begin
    AdicionaSQLAbreTabela(ENDER, ' SELECT UPPER(COD_ESTADO) ESTADOS, UPPER(DES_CIDADE) CIDADES '+
                                 ' FROM CAD_CIDADES ' +
                                 ' WHERE COD_ESTADO IN ' + VprEstados +
                                 ' GROUP BY COD_ESTADO, DES_CIDADE ' +
                                 ' ORDER BY DES_CIDADE ');
    Gauge.MaxValue:=ENDER.RecordCount;
    ENDER.First;
    while (not ENDER.EOF) do
    begin
      if (not ExisteCidade(ENDER.FieldByName('ESTADOS').AsString,
                           ENDER.FieldByName('CIDADES').AsString)) then
      begin
        // CADASTRAR A CIDADE.
        ExecutaComandoSql(CADASTRO, ' INSERT INTO CAD_CIDADES(COD_CIDADE,COD_ESTADO,COD_PAIS, DES_CIDADE, DAT_ULTIMA_ALTERACAO) ' +
                                    ' VALUES (' +
                                    ProximoCodigoCidade + ',''' +
                                    Trim(UpperCase(ENDER.FieldByName('ESTADOS').AsString)) +
                                    ''',''' + BuscaPaisEstado(ENDER.FieldByName('ESTADOS').AsString) +
                                    ''',''' +
                                    Trim(UpperCase(ENDER.FieldByName('CIDADES').AsString)) + ''',' +
                                    SQLTextoDataAAAAMMMDD(date) + ' )');
      end;
      Gauge.AddProgress(1);
      ENDER.Next;
    end;
  end;
end;

{ ***************** cadastra o pais default que é o brasil ******************* }
function TFImportaEnderecos.CadastrarPais: Boolean;
begin
  try
    AdicionaSQLAbreTabela(AUX, ' SELECT * FROM CAD_PAISES ' +
                               ' WHERE UPPER(COD_PAIS) = ''BR''');
    if AUX.EOF then
      ExecutaComandoSql(CADASTRO,'INSERT INTO CAD_PAISES VALUES (''BR'',''Brasil'')');
  except
    Result := False;
  end;
end;

{ ****************** retorna o nome dos estado para cadastro ***************** }
function TFImportaEnderecos.BuscaNomeEstado(VpaEstado: string): string;
begin
  Result:='';
  if VpaEstado = 'SC' then
    Result:='Santa Catarina'
  else
    if VpaEstado = 'PR' then
      Result:='Paraná'
    else
      if VpaEstado = 'RS' then
        Result:='Rio Grande do Sul'
      else
        if VpaEstado = 'SP' then
          Result:='São Paulo'
        else
          if VpaEstado = 'RJ' then
            Result:='Rio de Janeiro';
end;


{ ***************** cadastra os estados caso não existam ********************* }
function TFImportaEnderecos.CadastrarEstados: Boolean;
begin
  Gauge.Progress:=0;
  Texto('Cadastrando Estados...');
  Result:=True;
  VprEstados:=MontaEstados;
  if VprEstados = '' then
  begin
    Aviso('Não foram selecionados estados para a importação');
    Result:=False;
  end
  else
  begin
    AdicionaSQLAbreTabela(ENDER, ' SELECT COD_ESTADO FROM CAD_CIDADES ' +
                                 ' WHERE COD_ESTADO IN ' + VprEstados +
                                 ' GROUP BY COD_ESTADO ');
    Gauge.MaxValue:=ENDER.RecordCount;
    ENDER.First;
    Gauge.Visible:=True;
    while (not ENDER.EOF) do
    begin
      if (not ExisteEstado(ENDER.FieldByName('COD_ESTADO').AsString)) then
      begin
        // CADASTAR O ESTADO. - Default - BR.
        ExecutaComandoSql(CADASTRO,'INSERT INTO CAD_ESTADOS VALUES (''' +
                          Trim(UpperCase(ENDER.FieldByName('COD_ESTADO').AsString)) +
                          ''',''BR'',''' + BuscaNomeEstado(Trim(UpperCase(ENDER.FieldByName('COD_ESTADO').AsString))) + ''')');
      end;
      Gauge.AddProgress(1);
      ENDER.Next;
    end;
  end;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                   ROTINAS AUXILIARES
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{ ********************* verifica se o estado existe ************************** }
function TFImportaEnderecos.ExisteEstado(VpaEstado: string): Boolean;
begin
  AdicionaSQLAbreTabela(AUX, ' SELECT COD_ESTADO FROM CAD_ESTADOS ' +
                             ' WHERE UPPER(COD_ESTADO) = ''' + UpperCase(VpaEstado) + '''');
  Result:=(not AUX.EOF);
end;


{************************ verifica se a cidade existe ************************ }
function TFImportaEnderecos.ExisteCidade(VpaEstado, VpaCidade: string): Boolean;
begin
  AdicionaSQLAbreTabela(AUX, ' SELECT COD_ESTADO, DES_CIDADE FROM CAD_CIDADES ' +
                             ' WHERE UPPER(COD_ESTADO) = ''' + UpperCase(VpaEstado) + '''' +
                             ' AND   UPPER(DES_CIDADE) = ''' + UpperCase(VpaCidade)+ '''');
  Result:=(not AUX.EOF);
end;

{ ******************** retorna o pais do estado especificado ***************** }
function TFImportaEnderecos.BuscaPaisEstado(VpaEstado: string): string;
begin
  AdicionaSQLAbreTabela(AUX, ' SELECT COD_PAIS FROM CAD_ESTADOS ' +
                             ' WHERE UPPER(COD_ESTADO) = ''' + UpperCase(VpaEstado) + '''');
  Result:=UpperCase(AUX.FieldByName('COD_PAIS').AsString);
end;

{ ********************* retorna o proximo codigo da cidade ******************* }
function TFImportaEnderecos.ProximoCodigoCidade: string;
begin
  AdicionaSQLAbreTabela(AUX, ' SELECT MAX(COD_CIDADE) COD_CIDADE FROM CAD_CIDADES ');
  Result:=IntToStr(AUX.FieldByName('COD_CIDADE').AsInteger + 1);
end;

{ ************************** mostra o texto **********************/*********** }
procedure TFImportaEnderecos.Texto( Texto: string );
begin
  PMostrar.Caption := texto;
  PMostrar.Refresh;
end;


Initialization
 RegisterClasses([TFImportaEnderecos]);
end.
