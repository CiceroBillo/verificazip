unit AConfigRelatorios;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente, FileCtrl,
  ComCtrls, ImgList,IniFiles;


type
  TFConfigRelatorios = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BGravar: TBitBtn;
    DirectoryListBox1: TDirectoryListBox;
    LRelatorios: TListView;
    Label1: TLabel;
    ImageList1: TImageList;
    Label2: TLabel;
    BCancelar: TBitBtn;
    BAbrir: TBitBtn;
    OpenDialog1: TOpenDialog;
    DriveComboBox1: TDriveComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BGravarClick(Sender: TObject);
    procedure LRelatoriosClick(Sender: TObject);
    procedure DirectoryListBox1Change(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure BAbrirClick(Sender: TObject);
  private
    { Private declarations }
    VprRelatorios, VprConfiguracoes : TStringList;
    VprCancelado : Boolean;
    procedure CarregaListaRelatorios;
    procedure MarcaDesmarcaGrupo(VpaGrupo : String;VpaEstado : Boolean);
    function  RetornaConfiguracoes : TStringList;
    procedure AbrirArquivo(VpaNomArquivo : String);
  public
    { Public declarations }
    Function RetornaRelatorios : TStringlist;
  end;


var
  FConfigRelatorios: TFConfigRelatorios;

implementation

uses APrincipal, FunString;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFConfigRelatorios.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprRelatorios := TStringList.Create;
  VprConfiguracoes := TStringList.Create;
  CarregaListaRelatorios;
  VprCancelado := False;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFConfigRelatorios.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  VprRelatorios.Free;
  VprConfiguracoes.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          eventos das configuracoes
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{*********** configura os relatorios e retorna um String list *****************}
function TFConfigRelatorios.RetornaRelatorios : TStringlist;
begin
  ShowModal;
  if not VprCancelado then
    result := RetornaConfiguracoes
  else
    result := TStringList.create;

end;

{******************** grava as configuracoes dos relatorios *******************}
function TFConfigRelatorios.RetornaConfiguracoes : TStringList;
var
  VpfLaco, VpfQtdLinhas : Integer;
  VpfLinha, VpfNomeSecaoIni : String;
begin
  result := TStringList.Create;
  result.Clear;
  //adicona a secao do ini
  result.Add('[RELATORIOS]');
  //joga o nome do item em uma variavel para quando quiser mudar o nome do item é só alterar aqui
  VpfNomeSecaoIni := 'INSTALAR';

  VpfQtdLinhas := 1;
  //Carrega a primeira secao para a linha
  VpfLinha := VpfNomeSecaoIni+ Inttostr(VpfQtdLinhas) +'=';

  for VpfLaco := 0 to LRelatorios.Items.Count -1 do
  begin
    // o conteudo do item pode ter no máximo 256 caracteres que é o que o wise aceito.
    if Length(Vpflinha) > 240 then
    begin
      //adiciona o item
      result.Add(VpfLinha);
      //cria um novo item
      inc(VpfQtdLinhas);
      VpfLinha := VpfNomeSecaoIni+ Inttostr(VpfQtdLinhas)+'=';
    end;
    //se o item está marcado adicoina a linha
    if LRelatorios.Items[VpfLaco].Checked Then
      if LRelatorios.Items[VpfLaco].SubItems.Strings[0] = 'ITEM' THEN
        VpfLinha := VpfLinha + LRelatorios.Items[VpfLaco].SubItems.Strings[2];
  end;

  //adiciona o item
  result.Add(VpfLinha);
  //informa a qtd de itens
  result.Add('QTD='+ IntToStr(VpfQtdLinhas));
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                             eventos da lista
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{****************** inicializa a lista de relatorios **************************}
procedure TFConfigRelatorios.CarregaListaRelatorios;
var
  VpfLaco : Integer;
  VpfNo : TListItem;
  VpfGrupoAtual, VpfLinha : String;
begin
  try
    LRelatorios.ReadOnly := false;
    LRelatorios.Items.Clear;

    VprRelatorios.Clear;
    VprRelatorios.LoadFromFile(DirectoryListBox1.Directory+ '\Relatorios.Txt');
    VpfGrupoAtual := '';

    for  VpfLaco := 0 To VprRelatorios.Count - 1 do
    begin
      if VpfGrupoAtual <>  copy(VprRelatorios.Strings[VpfLaco],2,2) Then
      begin
        VpfGrupoAtual := copy(VprRelatorios.Strings[VpfLaco],2,2);
        VpfNo := LRelatorios.Items.Add;
        VpfNo.ImageIndex := -1;
        VpfNo.Caption := '----------------------'+copy(VprRelatorios.Strings[VpfLaco],2,2)+'---------------------';
        VpfNo.SubItems.Add('GRUPO');
        VpfNo.SubItems.Add(VpfGrupoAtual);
        VpfNo.SubItems.Add(' ');
      end;
      VpfNo := LRelatorios.Items.Add;
      VpfNo.ImageIndex := 0;
      VpfLinha := copy(DeletaEspacoD(VprRelatorios.Strings[VpfLaco]),11,length(VprRelatorios.Strings[VpfLaco])-16);
      VpfNo.Caption := SubstituiStr(DeletaEspaco(VpfLinha),'_', ' ');
      //cria o dado que identifica o tipo e o codigo do relatorio.
      VpfNo.SubItems.Add('ITEM');
      VpfNo.SubItems.Add(VpfGrupoAtual);
      VpfNo.SubItems.Add(copy(DeletaEspacoD(VprRelatorios.Strings[VpfLaco]),length(VprRelatorios.Strings[VpfLaco])-4,5));
    end;
  except
  end;
  LRelatorios.ReadOnly := true;
end;

{********************* marca desmarca os grupos *******************************}
procedure TFConfigRelatorios.MarcaDesmarcaGrupo(VpaGrupo : String;VpaEstado : Boolean);
var
  Vpflaco : Integer;
begin
  for VpfLaco := 0 to LRelatorios.Items.Count - 1 do
  begin
    if LRelatorios.Items[VpfLaco].SubItems.Strings[1] = VpaGrupo Then
      LRelatorios.Items[VpfLaco].Checked := VpaEstado;
  end;
end;

{***************************** abri o arquivo *********************************}
procedure TFConfigRelatorios.AbrirArquivo(VpaNomArquivo : String);
var
  VpfQtdIni, VpfLaco, VpfLacoAux1,VpfLacoAux2 : Integer;
  VpfAquivoIni : TIniFile;
  VpfLinha, VpfItem : String;
begin
  //verifica se existem items na lista e se o nome nao esta vazio
  if (LRelatorios.Items.Count = 0) or (DeletaEspaco(VpaNomArquivo) = '')  then
    exit;
  //desmarca todos os relatorios
  for Vpflaco := 0 to LRelatorios.Items.Count - 1 do
    LRelatorios.Items[Vpflaco].Checked := false;

  VpfAquivoIni := TIniFile.Create(VpaNomArquivo);
  //recupera a qtd de iten que possui o ini
  VpfQtdIni := VpfAquivoIni.ReadInteger('RELATORIOS','QTD',0);

  For VpfLaco := 1 to VpfQtdIni do
  begin
    //recupera o item
    VpfLinha := DeletaEspaco(VpfAquivoIni.ReadString('RELATORIOS','INSTALAR'+IntToStr(VpfLaco),''));
    for Vpflacoaux1 := 1 to (length(Vpflinha) div 5) do
    begin
      //pega um relatorio do item
      VpfItem := copy(vpflinha,((VpflacoAux1 - 1)*5)+1,5);
      for VpflacoAux2 := 0 to LRelatorios.Items.Count - 1 do
        //procura o relatorio na lista de relatorios
        if LRelatorios.Items[VpflacoAux2].SubItems.Strings[2] = VpfItem then
        begin
          LRelatorios.Items[VpflacoAux2].Checked := true;
          //se achou vai para o proximo
          break;
        end;
    end;
  end;
  VpfAquivoIni.Free;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                             eventos diversos
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{*********************** fecha o formulario corrente **************************}
procedure TFConfigRelatorios.BGravarClick(Sender: TObject);
begin
  VprCancelado := false;
  Close;
end;

{***************** quando se da um clique nos relatorios **********************}
procedure TFConfigRelatorios.LRelatoriosClick(Sender: TObject);
begin
  if LRelatorios.Selected <> nil then
  begin
    LRelatorios.Selected.Checked := not LRelatorios.Selected.Checked;
    if LRelatorios.Selected.SubItems.Strings[0] ='GRUPO' Then
      MarcaDesmarcaGrupo(LRelatorios.Selected.SubItems.Strings[1],LRelatorios.Selected.Checked);
  end;

end;

{****************** quando é alterado o diretorio corrente ********************}
procedure TFConfigRelatorios.DirectoryListBox1Change(Sender: TObject);
begin
  CarregaListaRelatorios;
end;

{******************* cancela as configuracoes do usuario **********************}
procedure TFConfigRelatorios.BCancelarClick(Sender: TObject);
begin
  VprCancelado := true;
  Close;
end;


procedure TFConfigRelatorios.BAbrirClick(Sender: TObject);
begin
  if OpenDialog1.Execute Then
    AbrirArquivo(OpenDialog1.FileName);
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFConfigRelatorios]);
end.
