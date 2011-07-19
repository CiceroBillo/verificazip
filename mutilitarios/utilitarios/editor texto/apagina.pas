unit APagina;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Menus, ExtCtrls, Buttons, ComCtrls;

type

  TFPagina = class(TForm)
    MainMenu1: TMainMenu;
    SaveDialog1: TSaveDialog;
    FontDialog1: TFontDialog;
    MEditar: TMenuItem;
    SelecionarTudo: TMenuItem;
    N7: TMenuItem;
    Mexcluir: TMenuItem;
    MColar: TMenuItem;
    MCopiar: TMenuItem;
    MRecortar: TMenuItem;
    Mformatar: TMenuItem;
    MFonte: TMenuItem;
    N8: TMenuItem;
    MRetorno: TMenuItem;
    N9: TMenuItem;
    MCentralizado: TMenuItem;
    MDireita: TMenuItem;
    MEsquerda: TMenuItem;
    Mdesfazer: TMenuItem;
    N4: TMenuItem;
    MNegrito: TMenuItem;
    MItalico: TMenuItem;
    MSublinhado: TMenuItem;
    PrintDialog1: TPrintDialog;
    Texto: TRichEdit;

    procedure Save1Click(Sender: TObject);
    procedure SaveAs1Click(Sender: TObject);

    procedure MRecortarClick(Sender: TObject);
    procedure MCopiarClick(Sender: TObject);
    procedure MColarClick(Sender: TObject);
    procedure MexcluirClick(Sender: TObject);
    procedure MdesfazerClick(Sender: TObject);
    procedure SelecionarTudoClick(Sender: TObject);

    procedure CharAlignClick(Sender: TObject);
    procedure MNegritoClick(Sender: TObject);
    procedure MItalicoClick(Sender: TObject);
    procedure MSublinhadoClick(Sender: TObject);
    procedure MRetornoClick(Sender: TObject);
    procedure MFonteClick(Sender: TObject);

    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Print1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure MNovoClick(Sender: TObject);
    procedure MAbrirClick(Sender: TObject);
    procedure MFecharClick(Sender: TObject);
    procedure MSairClick(Sender: TObject);
    function GetCurrentText: TTextAttributes;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    Extencao : string;
  public
    procedure AbrirArquivo( NomeArq : String);
    procedure ConfiguraBotoes;
    procedure ConfiguraExtencao;
  end;

var
  FPagina: TFPagina;

implementation

uses Printers, AEditor, funstring;

{$R *.DFM}



procedure TFPagina.Save1Click(Sender: TObject);
begin
//  Texto.Lines.SaveToFile('c:\Texto');
  if Caption = 'Novo Texto.ind' then
    SaveAs1Click(nil)
  else
  begin
    if SaveDialog1.FilterIndex = 2 then
      texto.PlainText := true;
    texto.Lines.SaveToFile(Caption);
    texto.Modified := false;
  end;
end;

procedure TFPagina.SaveAs1Click(Sender: TObject);
begin
  if Extencao = '' then
    Extencao := 'ind';
  SaveDialog1.DefaultExt := Extencao;
  if UpperCase(Extencao) = 'IND' then
    SaveDialog1.FilterIndex := 0
  else
    if UpperCase(Extencao) = 'TXT' then
      SaveDialog1.FilterIndex := 1
    else
      if UpperCase(Extencao) = 'SQL' then
        SaveDialog1.FilterIndex := 2
      else
        SaveDialog1.FilterIndex := 3;

  SaveDialog1.FileName := Caption;
  if SaveDialog1.Execute then
  begin
    Extencao := copy(SaveDialog1.FileName, length(SaveDialog1.FileName) -2, 3);
    ConfiguraExtencao;
    Caption := SaveDialog1.FileName;
    Save1Click(nil);
  end;
end;

procedure TFPagina.MRecortarClick(Sender: TObject);
begin
  texto.CutToClipBoard;
end;

procedure TFPagina.MCopiarClick(Sender: TObject);
begin
  texto.CopyToClipBoard;
end;

procedure TFPagina.MColarClick(Sender: TObject);
begin
  texto.PasteFromClipBoard;
end;

procedure TFPagina.MexcluirClick(Sender: TObject);
begin
  texto.ClearSelection;
end;

procedure TFPagina.MdesfazerClick(Sender: TObject);
begin
  texto.Perform(EM_UNDO, 0, 0);
end;

procedure TFPagina.SelecionarTudoClick(Sender: TObject);
begin
  texto.SelectAll;
end;

procedure TFPagina.CharAlignClick(Sender: TObject);
begin
  MEsquerda.Checked := false;
  Mdireita.Checked := false;
  MCentralizado.Checked := false;

  if Sender is TMenuItem then begin
    TMenuItem(Sender).Checked := true;
    with Texto.Paragraph do
      if MEsquerda.Checked then
        Alignment := taLeftJustify
      else if MDireita.Checked then
        Alignment := taRightJustify
      else if MCentralizado.Checked then
        Alignment := taCenter;
  end
  else if Sender is TSpeedButton then begin
    Texto.Paragraph.Alignment :=
       TAlignment(TSpeedButton(Sender).Tag);
    case Texto.Paragraph.Alignment of
      taLeftJustify: MEsquerda.Checked := True;
      taRightJustify: MDireita.Checked := True;
      taCenter: MCentralizado.Checked := True;
    end;
  end;
 ConfiguraBotoes;
end;

procedure TFPagina.MNegritoClick(Sender: TObject);
begin
  if not MNegrito.Checked then
    GetCurrentText.Style := GetCurrentText.Style + [fsBold]
  else
    GetCurrentText.Style := GetCurrentText.Style - [fsBold];
end;

procedure TFPagina.MItalicoClick(Sender: TObject);
begin
  if not MItalico.Checked then
    GetCurrentText.Style := GetCurrentText.Style + [fsItalic]
  else
    GetCurrentText.Style := GetCurrentText.Style - [fsItalic];
end;

procedure TFPagina.MSublinhadoClick(Sender: TObject);
begin
  if not MSublinhado.Checked then
    GetCurrentText.Style := GetCurrentText.Style + [fsUnderline]
  else
    GetCurrentText.Style := GetCurrentText.Style - [fsUnderline];
end;

procedure TFPagina.MRetornoClick(Sender: TObject);
begin
  with Texto do begin
    WordWrap := not WordWrap;    if WordWrap then
      ScrollBars := ssVertical
    else
      ScrollBars := ssNone;
    Mretorno.Checked := WordWrap;
  end;
end;

procedure TFPagina.MFonteClick(Sender: TObject);
begin
  FontDialog1.Font.Assign(Texto.SelAttributes);
  if FontDialog1.Execute then
    GetCurrentText.Assign(FontDialog1.Font);
  Texto.SetFocus;
end;

procedure TFPagina.FormCloseQuery(Sender: TObject;
     var CanClose: Boolean);
const
  CloseMsg = '''%s'' foi modificado, Salvar?';
var
  MsgVal: integer;
  FileName: string;
begin
  inherited;
  FileName := Caption;
  if Texto.Modified then begin
    MsgVal := MessageDlg(Format(CloseMsg, [FileName]),
              mtConfirmation, [mbYes,mbNo,mbCancel], 0);
    case MsgVal of
      mrYes: Save1Click(Self);
      mrCancel: CanClose := false;
    end;
  end;
end;

procedure TFPagina.AbrirArquivo( NomeArq : string);
begin
  texto.Lines.LoadFromFile(NomeArq);
  DeletaEspacoDE(NomeArq);
  Extencao := copy(NomeArq, length(NomeArq)- 2, 3);
  Caption := NomeArq;
  ConfiguraExtencao;
  Texto.Modified := false;
end;

procedure TFPagina.ConfiguraBotoes;
begin
  MNegrito.Checked := fsBold in texto.Font.Style;
  MItalico.Checked := fsItalic in texto.Font.Style;
  MSublinhado.Checked := fsUnderline in texto.Font.Style;
  FEditor.BNegrito.Down := MNegrito.Checked;
  FEditor.BItalico.Down := MItalico.Checked;
  FEditor.BSublinhado.Down := MSublinhado.Checked;
  FEditor.BEsquerda.Down := MEsquerda.Checked;
  FEditor.BDireita.Down := MDireita.Checked;
  FEditor.BCentralizado.Down := MCentralizado.Checked;
end;

procedure TFPagina.Print1Click(Sender: TObject);
//var
//  i: integer;
//  PText: TextFile;
begin
{  if PrintDialog1.Execute then begin
    AssignPrn(PText);
    Rewrite(PText);
    try
      Printer.Canvas.Font := texto.Font;
      for i := 0 to texto.Lines.Count -1 do
        writeln(PText, texto.Lines[i]);
    finally
      CloseFile(PText);
    end;
  end;}
  texto.Print(Caption);
end;

procedure TFPagina.FormActivate(Sender: TObject);
begin
  FEditor.configuraPagina;
end;

procedure TFPagina.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  FEditor.HabilitaBotoes(false);
end;

procedure TFPagina.MNovoClick(Sender: TObject);
begin
  FEditor.MNovoClick(nil);
end;

procedure TFPagina.MAbrirClick(Sender: TObject);
begin
  FEditor.MAbrirClick(nil);
end;

procedure TFPagina.MFecharClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFPagina.MSairClick(Sender: TObject);
begin
  FEditor.Close;
end;

function  TFPagina.GetCurrentText: TTextAttributes;
begin
  if texto.SelLength > 0 then
    Result := texto.SelAttributes
  else
    Result := texto.DefAttributes;
end;

procedure TFPagina.FormShow(Sender: TObject);
begin
  ConfiguraBotoes;
end;

procedure TFPagina.ConfiguraExtencao;
begin
  if UpperCase(Extencao) <> 'IND' then
  begin
     texto.PlainText := true;
     texto.Font.Name := 'Courier';
     FEditor.HabilitaBotoesFormato(false);
     Mformatar.Visible := false;
  end

end;


procedure TFPagina.FormCreate(Sender: TObject);
begin
 Extencao := '';
end;

end.


