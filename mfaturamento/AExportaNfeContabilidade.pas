unit AExportaNfeContabilidade;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios, StdCtrls, Buttons,
  Componentes1, ExtCtrls, PainelGradiente, Spin, ZipMstr19, UnNfe, Gauges;

type
  TFExportanfeContabilidade = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BExportar: TBitBtn;
    EMes: TSpinEditColor;
    EAno: TSpinEditColor;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    EEmail: TEditColor;
    ZM: TZipMaster19;
    BFechar: TBitBtn;
    ProgressoArquivo: TGauge;
    LStatus: TLabel;
    LTamahoArquivo: TLabel;
    ProgressoTotal: TGauge;
    CXML: TCheckBox;
    CPDF: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BExportarClick(Sender: TObject);
    procedure ZMProgress(Sender: TObject; details: TZMProgressDetails);
  private
    { Private declarations }
    FunNfe : TRBFuncoesNFe;
    function geraArquivo : string;
    procedure AtualizaStatus(VpaTexto : String);
  public
    { Public declarations }
  end;

var
  FExportanfeContabilidade: TFExportanfeContabilidade;

implementation

uses APrincipal, FunData, constantes, FunArquivos, FunString, Constmsg;

{$R *.DFM}


{ **************************************************************************** }
procedure TFExportanfeContabilidade.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunNfe :=  TRBFuncoesNFe.cria(FPrincipal.BaseDados);
  EMes.Value := Mes(UltimoDiaMesAnterior);
  EAno.Value := ano(UltimoDiaMesAnterior);
end;

{******************************************************************************}
function TFExportanfeContabilidade.geraArquivo: string;
var
  VpfArquivos : TStringList;
  VpfLaco : Integer;
  VpfDiretorioNotas,VpfArquivoPDF : string;
begin
  result :=varia.PathVersoes+'ANEXOS\NFE\'+DeletaChars(DeletaChars(DeletaChars(Varia.CNPJFilial,'.'),'-'),'/')+'\'+IntToStr(EAno.Value)+formatFloat('00',EMes.Value)+'.zip';
  AtualizaStatus('Arquivo Destino "'+Result+'"');
  naoexistecriadiretorio(RetornaDiretorioArquivo(Result),false);
  ZM.Clear;
  ZM.ZipFileName := result;
  VpfDiretorioNotas := Varia.PathVersoes+'NFe\'+DeletaChars(DeletaChars(DeletaChars(Varia.CNPJFilial,'.'),'-'),'/')+'\'+EAno.Text+FormatFloat('00',EMes.Value)+'\';
  VpfArquivos := RetornaArquivosMascara(VpfDiretorioNotas+'*-nfe.xml');
  for VpfLaco := 0 to VpfArquivos.Count - 1 do
  begin
    if CXML.Checked then
      ZM.FSpecArgs.Add(VpfDiretorioNotas+VpfArquivos.Strings[VpfLaco]);
    if CPDF.Checked then
    begin
      VpfArquivoPDF := VpfDiretorioNotas+CopiaAteChar(VpfArquivos.Strings[VpfLaco],'-')+'.pdf';
      try
        if not ExisteArquivo(VpfArquivoPDF) then
        begin
          LTamahoArquivo.Caption := 'Gerando PDF da nota '+copy(VpfArquivos.Strings[VpfLaco],26,9);
          LTamahoArquivo.refresh;
          FunNfe.GeraPDFXML(VpfDiretorioNotas+VpfArquivos.Strings[VpfLaco]);
        end;
        ZM.FSpecArgs.Add(VpfArquivoPDF);
      finally

      end;
    end;
  end;
{
    VpfArquivos := RetornaArquivosMascara(VpfDiretorioNotas+'*.pdf');
    for VpfLaco := 0 to VpfArquivos.Count - 1 do
  end;}
  ZM.add;
  AtualizaStatus('Arquivo compactado');
  LTamahoArquivo.Caption := 'Tamanho Arquivo : '+FormatFloat('#,##0.00',((ZM.ZipFileSize)/1024)/1024)+'mb';
  LTamahoArquivo.refresh;
end;

{******************************************************************************}
procedure TFExportanfeContabilidade.ZMProgress(Sender: TObject;
  details: TZMProgressDetails);
begin
  ProgressoTotal.Progress := details.TotalPerCent;
  ProgressoArquivo.Progress := details.ItemPerCent;
  LTamahoArquivo.Caption := 'Compactando '+RetornaNomArquivoSemDiretorio(details.ItemName);
  LTamahoArquivo.Refresh;
end;

{ *************************************************************************** }
procedure TFExportanfeContabilidade.AtualizaStatus(VpaTexto: String);
begin
  LStatus.Caption := VpaTexto;
  LStatus.Refresh;
end;

{******************************************************************************}
procedure TFExportanfeContabilidade.BExportarClick(Sender: TObject);
var
  VpfResultado : string;
begin
  VpfResultado := FunNfe.EnviaEmailContabilidadeNfe(geraArquivo,EEmail.Text,EMes.Value,EAno.Value);
  if VpfResultado <> '' then
    aviso(VpfResultado)
  else
    aviso('E-mail enviado com sucesso!!!');
end;

procedure TFExportanfeContabilidade.BFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFExportanfeContabilidade.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunNfe.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFExportanfeContabilidade]);
end.
