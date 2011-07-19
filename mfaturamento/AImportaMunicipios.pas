unit AImportaMunicipios;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Buttons, ComCtrls, Db,
  DBTables, FMTBcd, SqlExpr, UnNFe;

type
  TFImportaMunicipios = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BImportar: TBitBtn;
    BFechar: TBitBtn;
    Animacao: TAnimate;
    Progresso: TProgressBar;
    OpenDialog1: TOpenDialog;
    Aux: TSQLQuery;
    LStatus: TLabel;
    PEstado: TProgressBar;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BImportarClick(Sender: TObject);
  private
    { Private declarations }
    FunNFE : TRBFuncoesNFe;
    procedure CadastraEstado(VpaEstado : String);
    procedure ImportaMunicipios(VpaArquivos : TStrings);
  public
    { Public declarations }
  end;

var
  FImportaMunicipios: TFImportaMunicipios;

implementation

uses APrincipal, FunSql, FunString, UnSistema;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFImportaMunicipios.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunNFE := TRBFuncoesNFe.cria(Fprincipal.BaseDados);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFImportaMunicipios.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunNFE.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFImportaMunicipios.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFImportaMunicipios.BImportarClick(Sender: TObject);
begin
  if OpenDialog1.execute then
  begin
    ImportaMunicipios(OpenDialog1.Files);
  end;
end;

{******************************************************************************}
procedure TFImportaMunicipios.CadastraEstado(VpaEstado : String);
begin
  AdicionaSqlabreTabela(Aux,'Select * from Cad_estados '+
                            ' Where COD_ESTADO = '''+VpaEstado+'''');
  if Aux.Eof then
    ExecutaComandoSql(Aux,'INSERT INTO CAD_ESTADOS(COD_ESTADO,COD_PAIS,DES_ESTADO)'+
                        'VALUES('''+VpaEstado+''',''BR'','''+VpaEstado+''')');
end;

{******************************************************************************}
procedure TFImportaMunicipios.ImportaMunicipios(VpaArquivos : TStrings);
var
  VpfArquivo, VpfEstados : TStringList;
  VpfCodigo,VpfLacoEstado, VpfLacoCidade : Integer;
  VpfLinha, VpfCodigoFiscal, VpfNomCidade,VpfUF, VpfUfAnterior : String;
begin
  VpfArquivo := TStringLIst.Create;
  VpfEstados := TStringList.Create;
  VpfCodigo := 0;
  Vpfufanterior := '';
  ExecutaComandoSql(aux,'Update CADCLIENTES SET COD_CIDADE = NULL');
  ExecutaComandoSql(aux,'Update CADFILIAIS SET COD_CIDADE = NULL');
  ExecutaComandoSql(aux,'Update CADVENDEDORES SET COD_CIDADE = NULL');
  ExecutaComandoSql(aux,'Delete from CAD_CIDADES');
  Animacao.Active := true;
  PEstado.Position := 0;
  PEstado.Max := VpaArquivos.Count;
  for VpflacoEstado := 0 to VpaArquivos.Count - 1 do
  begin
    VpfArquivo.Clear;
    VpfArquivo.LoadFromFile(VpaArquivos.Strings[VpfLacoEstado]);
    Progresso.Position := 0;
    Progresso.Max := VpfArquivo.Count;
    PEstado.StepBy(1);
    for VpfLacoCidade := 0 to VpfArquivo.Count - 1 do
    begin
      inc(VpfCodigo);
      Progresso.StepBy(1);
      VpfLinha := VpfArquivo.Strings[VpfLacoCidade];
      VpfCodigoFiscal := CopiaAteChar(VpfLinha,#9);
      VpfLinha := DeleteAteChar(VpfLinha,#9);
      //NOME CIDADE
      VpfNomCidade := SubstituiStr(UPPERCASE(RetiraAcentuacao(VpfLinha)),'''','"');
      //ESTADO
      VpfUF := FunNFE.RUF(VpfCodigoFiscal);
      if VpfUF <> VpfUfAnterior then
      begin
        CadastraEstado(VpfUF);
        VpfUfAnterior := VpfUF;
      end;
      LStatus.caption := 'Importanto estado '+VpfUF+' cidade "'+AdicionaCharD(' ', VpfNomCidade,50)+'"';
      LStatus.Refresh;
      ExecutaComandoSql(Aux,'insert into CAD_CIDADES(COD_CIDADE,COD_ESTADO,COD_PAIS,DES_CIDADE,COD_FISCAL,DAT_ULTIMA_ALTERACAO) Values('+
                            IntTostr(VpfCodigo)+','''+VpfUF+''',''BR'','''+VpfNomCidade+''','''+VpfCodigoFiscal+''','+SQLTextoDataAAAAMMMDD(DATe)+')');
    end;
  end;
  Sistema.MarcaTabelaParaImportar('CAD_CIDADES');
  Animacao.Active := false;
  VpfArquivo.free;
  VpfEstados.free;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFImportaMunicipios]);
end.
