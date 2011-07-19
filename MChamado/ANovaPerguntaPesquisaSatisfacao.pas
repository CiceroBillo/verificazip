unit ANovaPerguntaPesquisaSatisfacao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente, ComCtrls,
  Mask, numericos, Constantes, DBKeyViolation, Db, DBTables;

type
  TFNovaPerguntaPesquisaSatisfacao = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    Paginas: TPageControl;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    BPagina: TSpeedButton;
    PMatriz: TTabSheet;
    ETitulo: TEditColor;
    Label1: TLabel;
    EIndice: Tnumerico;
    Label2: TLabel;
    Label3: TLabel;
    EPergunta: TMemoColor;
    Label4: TLabel;
    RadioButton1: TRadioButton;
    RadioButton4: TRadioButton;
    RadioButton11: TRadioButton;
    Label5: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    numerico1: Tnumerico;
    numerico2: Tnumerico;
    Label6: TLabel;
    RadioButton12: TRadioButton;
    Bevel4: TBevel;
    RadioGroup1: TRadioGroup;
    RadioGroup2: TRadioGroup;
    PanelColor3: TPanelColor;
    Label7: TLabel;
    ENomPesquisa: TEditColor;
    ValidaGravacao1: TValidaGravacao;
    CAtivo: TCheckBox;
    PesquisaCorpo: TQuery;
    DataPesquisaCorpo: TDataSource;
    PesquisaCorpoCODPESQUISA: TIntegerField;
    PesquisaCorpoNOMPESQUISA: TStringField;
    PesquisaCorpoINDATIVA: TStringField;
    PesquisaCorpoQTDPESQUISAS: TIntegerField;
    Aux: TQuery;
    PesquisaItem: TQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton1Click(Sender: TObject);
    procedure PaginasDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure BCancelarClick(Sender: TObject);
    procedure ETituloChange(Sender: TObject);
    procedure EIndiceExit(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure PaginasChange(Sender: TObject);
    procedure ENomPesquisaChange(Sender: TObject);
    procedure BGravarClick(Sender: TObject);
  private
    { Private declarations }
    VprAcao : Boolean;
    VprOperacao : TRBDOperacaoCadastro;
    function RSeqPesquisaDisponivel : Integer;
    procedure CarValorCampo(VpaTabela : TQuery;VpaObjeto : TWinControl);
    function GravaPesquisaCorpo : string;
    function GravaPesquisaItem : String;
    function GravaDados :Boolean;
    procedure CriaLabel(VpaLabelMatriz : tlabel;VpaDono : TWinControl);
    procedure CriaEditColor(VpaEditMatriz : TEditColor;VpaDono : TWinControl);
    procedure CriaEditNumerico(VpaEditMatriz : Tnumerico;VpaDono : TWinControl);
    procedure CriaMemoColor(VpaEditMatriz : TMemoColor; VpaDono : twincontrol);
    procedure CriaRadioButton(VpaEditMatriz : TRadioButton; VpaDono : twincontrol);
    procedure CriaRadioGroup(VpaEditMatriz : TRadioGroup;VpaDono : twincontrol);
    procedure CriaBevel(VpaEditMatriz : TBevel; VpaDono : twincontrol);
    procedure CriaComponentesPergunta(VpaPagina : TTabSheet);
    procedure AdicionaPagina;
  public
    { Public declarations }
    function NovasPerguntas : boolean;
  end;

var
  FNovaPerguntaPesquisaSatisfacao: TFNovaPerguntaPesquisaSatisfacao;

implementation

uses APrincipal,constmsg, FunSql;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFNovaPerguntaPesquisaSatisfacao.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao := false;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovaPerguntaPesquisaSatisfacao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  PesquisaCorpo.Close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
function TFNovaPerguntaPesquisaSatisfacao.NovasPerguntas : boolean;
begin
  AdicionaPagina;
  CAtivo.Checked := true;
  VprOperacao := ocInsercao;
  ValidaGravacao1.execute;
  showmodal;
  result := Vpracao;
end;

{******************************************************************************}
procedure TFNovaPerguntaPesquisaSatisfacao.AdicionaPagina;
Var
  VpfPagina : TTabSheet;
begin
  VpfPagina := TTabSheet.Create(Paginas);
  Paginas.InsertControl(VpfPagina);
  VpfPagina.PageControl := Paginas;
  Paginas.ActivePage:= VpfPagina;
  VpfPagina.Caption := 'Pergunta '+ IntToStr(VpfPagina.PageIndex);
  CriaComponentesPergunta(VpfPagina);

  BPagina.Caption := 'Página '+IntToStr(VpfPagina.PageIndex)+ ' de '+IntToStr(Paginas.PageCount-1);
end;

{******************************************************************************}
procedure TFNovaPerguntaPesquisaSatisfacao.CriaLabel(VpaLabelMatriz : tlabel;VpaDono : TWinControl);
var
  VpfLabel : TLabel;
begin
  VpfLabel := TLabel.Create(self);
  VpfLabel.Parent :=VpaDono;
  VpfLabel.Caption := VpaLabelMatriz.Caption;
  VpfLabel.Top := VpaLabelMatriz.Top;
  VpfLabel.Alignment := VpaLabelMatriz.Alignment;
  VpfLabel.Left := VpaLabelMatriz.Left;
end;

{******************************************************************************}
function TFNovaPerguntaPesquisaSatisfacao.RSeqPesquisaDisponivel : Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select MAX(CODPESQUISA) ULTIMO from PESQUISASATISFACAOCORPO ');
  result := Aux.FieldByname('ULTIMO').AsInteger + 1;
  Aux.Close;
end;

{******************************************************************************}
procedure TFNovaPerguntaPesquisaSatisfacao.CarValorCampo(VpaTabela : TQuery;VpaObjeto : TWinControl);
begin
  case VpaObjeto.Tag of
    10 : VpaTabela.FieldByname('DESTITULO').AsString := TEditColor(VpaObjeto).Text;
    30 : VpaTabela.FieldByname('DESPERGUNTA').AsString := TMemoColor(VpaObjeto).Lines.Text;
    40 : VpaTabela.FieldByname('NUMNOTAINICIAL').AsInteger := Tnumerico(VpaObjeto).AsInteger;
    50 : VpaTabela.FieldByname('NUMNOTAFINAL').AsInteger := Tnumerico(VpaObjeto).AsInteger;
    100 : if TRadioButton(VpaObjeto).Checked then VpaTabela.FieldByname('TIPRESPOSTA').AsInteger := 1;
    110 : if TRadioButton(VpaObjeto).Checked then VpaTabela.FieldByname('TIPRESPOSTA').AsInteger := 2;
    120 : if TRadioButton(VpaObjeto).Checked then VpaTabela.FieldByname('TIPRESPOSTA').AsInteger := 3;
    130 : if TRadioButton(VpaObjeto).Checked then VpaTabela.FieldByname('TIPRESPOSTA').AsInteger := 4;
  end;
end;

{******************************************************************************}
function TFNovaPerguntaPesquisaSatisfacao.GravaPesquisaCorpo : String;
begin
  result := '';
  AdicionaSQLAbreTabela(PesquisaCorpo,'Select * from PESQUISASATISFACAOCORPO');
  if VprOperacao = ocinsercao then
  begin
    PesquisaCorpo.Insert;
    PesquisaCorpoCODPESQUISA.AsInteger := RSeqPesquisaDisponivel;
  end
  else
  begin

  end;

  PesquisaCorpoNOMPESQUISA.AsString := ENomPesquisa.Text;
  if CAtivo.Checked then
    PesquisaCorpoINDATIVA.AsString := 'S'
  else
    PesquisaCorpoINDATIVA.AsString := 'N';
  try
    PesquisaCorpo.Post;
  except
    on e : exception do result := 'ERRO NA GRAVAÇÃO DA PESQUISASATISFAÇÃOCORPO!!!'#13+e.message;
  end;
  if result = '' then
    Result := GravaPesquisaItem;
  PesquisaCorpo.close;
end;

{******************************************************************************}
function TFNovaPerguntaPesquisaSatisfacao.GravaPesquisaItem : String;
var
  VpfLacoPaginas, VpfLacoComponentes, VpfSeqPergunta : Integer;
begin
  result := '';
  VpfSeqPergunta := 0;
  AdicionaSQLAbreTabela(PesquisaItem,'Select * from PESQUISASATISFACAOITEM');
  for VpfLacoPaginas :=0 to Paginas.PageCount -1 do
  begin
    if Uppercase(Paginas.Pages[VpfLacoPaginas].Name) <> 'PMATRIZ' then
    begin
      inc(vpfSeqPergunta);
      PesquisaItem.Insert;
      PesquisaItem.FieldByname('CODPESQUISA').AsInteger := PesquisaCorpoCODPESQUISA.AsInteger;
      PesquisaItem.FieldByname('SEQPERGUNTA').AsInteger := VpfSeqPergunta;
      for VpfLacoComponentes := 0 to Paginas.Pages[VpfLacoPaginas].ControlCount - 1 do
      begin
        CarValorCampo(PesquisaItem,TWinControl(Paginas.Pages[VpfLacoPaginas].Controls[VpfLacoComponentes]));
      end;

      try
        PesquisaItem.post;
      except
        on e : exception do result := 'ERRO NA GRAVAÇÃO DA PESQUISASATISFAÇÃOITEM!!!'#13+e.message;
      end;
    end;
    if result <> '' then
      break;
  end;
end;

{******************************************************************************}
Function TFNovaPerguntaPesquisaSatisfacao.GravaDados :boolean;
var
  VpfResultado :String;
begin
  result := false;
  VpfResultado := '';
  if VprOperacao in [ocInsercao,ocedicao] then
  begin
    VpfREsultado := GravaPesquisaCorpo;

    result := VpfResultado = '';
  end;
  if VpfResultado <> '' then
    aviso(VpfREsultado);
end;

{******************************************************************************}
procedure TFNovaPerguntaPesquisaSatisfacao.CriaEditColor(VpaEditMatriz : TEditColor;VpaDono : TWinControl);
var
  VpfEdit :  TEditColor;
begin
  VpfEdit := TEditColor.Create(VpaDono);
  VpfEdit.parent := VpaDono;
  VpfEdit.ACorFoco := VpaEditMatriz.ACorFoco;
  VpfEdit.Width := VpaEditMatriz.Width;
  VpfEdit.Height := VpaEditMatriz.Height;
  VpfEdit.Tag := VpaEditMatriz.Tag;
  VpfEdit.Top := VpaEditMatriz.Top;
  VpfEdit.Left := VpaEditMatriz.Left;
  VpfEdit.OnChange := VpaEditMatriz.OnChange;
end;

{******************************************************************************}
procedure TFNovaPerguntaPesquisaSatisfacao.CriaEditNumerico(VpaEditMatriz : Tnumerico;VpaDono : TWinControl);
var
  VpfNumerico : Tnumerico;
begin
  VpfNumerico := Tnumerico.Create(VpaDono);
  VpfNumerico.parent := VpaDono;
  VpfNumerico.ACorFoco := VpaEditMatriz.ACorFoco;
  VpfNumerico.Width := VpaEditMatriz.Width;
  VpfNumerico.Height := VpaEditMatriz.Height;
  VpfNumerico.Tag := VpaEditMatriz.Tag;
  VpfNumerico.Top := VpaEditMatriz.Top;
  VpfNumerico.Left := VpaEditMatriz.Left;
  VpfNumerico.AMascara := VpaEditMatriz.AMascara;
  VpfNumerico.ADecimal := VpfNumerico.ADecimal;
  VpfNumerico.OnExit := VpaEditMatriz.OnExit;
  if VpaEditMatriz.Tag = 20 then
    VpfNumerico.AsInteger := TTabSheet(VpaDono).PageIndex;
end;

{******************************************************************************}
procedure TFNovaPerguntaPesquisaSatisfacao.CriaMemoColor(VpaEditMatriz : TMemoColor; VpaDono : twincontrol);
var
  VpfMemo : TMemoColor;
begin
  VpfMemo := TMemoColor.Create(VpaDono);
  VpfMemo.parent := VpaDono;
  VpfMemo.ACorFoco := VpaEditMatriz.ACorFoco;
  VpfMemo.Width := VpaEditMatriz.Width;
  VpfMemo.Height := VpaEditMatriz.Height;
  VpfMemo.Tag := VpaEditMatriz.Tag;
  VpfMemo.Top := VpaEditMatriz.Top;
  VpfMemo.Left := VpaEditMatriz.Left;
end;

{******************************************************************************}
procedure TFNovaPerguntaPesquisaSatisfacao.CriaRadioButton(VpaEditMatriz : TRadioButton; VpaDono : twincontrol);
var
  VpfRadio : TRadioButton;
begin
  VpfRadio := TRadioButton.Create(VpaDono);
  VpfRadio.parent := VpaDono;
  VpfRadio.Width := VpaEditMatriz.Width;
  VpfRadio.Height := VpaEditMatriz.Height;
  VpfRadio.Tag := VpaEditMatriz.Tag;
  VpfRadio.Top := VpaEditMatriz.Top;
  VpfRadio.Left := VpaEditMatriz.Left;
  VpfRadio.Caption := VpaEditMatriz.Caption;
  IF VpfRadio.Tag = 100 THEN
    VpfRadio.Checked := true;
end;

{******************************************************************************}
procedure TFNovaPerguntaPesquisaSatisfacao.CriaRadioGroup(VpaEditMatriz : TRadioGroup;VpaDono : twincontrol);
var
  VpfRadio : TRadioGroup;
begin
  VpfRadio := TRadioGroup.Create(VpaDono);
  VpfRadio.parent := VpaDono;
  VpfRadio.Width := VpaEditMatriz.Width;
  VpfRadio.Height := VpaEditMatriz.Height;
  VpfRadio.Tag := VpaEditMatriz.Tag;
  VpfRadio.Top := VpaEditMatriz.Top;
  VpfRadio.Left := VpaEditMatriz.Left;
  VpfRadio.Columns := VpaEditMatriz.Columns;
  VpfRadio.Items.Assign(VpaEditMatriz.Items);
end;

{******************************************************************************}
procedure TFNovaPerguntaPesquisaSatisfacao.CriaBevel(VpaEditMatriz : TBevel; VpaDono : twincontrol);
var
  VpfBevel : Tbevel;
begin
  VpfBevel := TBevel.Create(VpaDono);
  VpfBevel.parent := VpaDono;
  VpfBevel.Width := VpaEditMatriz.Width;
  VpfBevel.Height := VpaEditMatriz.Height;
  VpfBevel.Tag := VpaEditMatriz.Tag;
  VpfBevel.Top := VpaEditMatriz.Top;
  VpfBevel.Left := VpaEditMatriz.Left;
  VpfBevel.Shape := VpaEditMatriz.Shape;
end;

{******************************************************************************}
procedure TFNovaPerguntaPesquisaSatisfacao.CriaComponentesPergunta(VpaPagina : TTabSheet);
var
  VpfLaco : Integer;
begin
  for VpfLaco := 0 to PMatriz.ControlCount - 1 do
  begin
    if PMatriz.Controls[VpfLaco] is TLabel then
      CriaLabel(TLabel(PMatriz.Controls[VpfLaco]),VpaPagina)
    else
      if PMatriz.Controls[VpfLaco] is TEditColor then
        CriaEditColor(TEditColor(PMatriz.Controls[VpfLaco]),VpaPagina)
      else
        if PMatriz.Controls[VpfLaco] is Tnumerico then
          CriaEditNumerico(Tnumerico(PMatriz.Controls[VpfLaco]),VpaPagina)
        else
          if PMatriz.Controls[VpfLaco] is TMemoColor then
            CriaMemoColor(TMemoColor(PMatriz.Controls[VpfLaco]),VpaPagina)
          else
            if PMatriz.Controls[VpfLaco] is TRadioButton then
              CriaRadioButton(TRadioButton(PMatriz.Controls[VpfLaco]),VpaPagina)
            else
              if PMatriz.Controls[VpfLaco] is TRadioGroup then
                CriaRadioGroup(TRadioGroup(PMatriz.Controls[VpfLaco]),VpaPagina)
              else
                if PMatriz.Controls[VpfLaco] is TBevel then
                  CriaBevel(TBevel(PMatriz.Controls[VpfLaco]),VpaPagina)

  end;
end;

{******************************************************************************}
procedure TFNovaPerguntaPesquisaSatisfacao.SpeedButton1Click(
  Sender: TObject);
begin
  AdicionaPagina;
end;

{******************************************************************************}
procedure TFNovaPerguntaPesquisaSatisfacao.PaginasDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := true;
end;

{******************************************************************************}
procedure TFNovaPerguntaPesquisaSatisfacao.BCancelarClick(Sender: TObject);
begin
  VprAcao := false;
  close;
end;

{******************************************************************************}
procedure TFNovaPerguntaPesquisaSatisfacao.ETituloChange(
  Sender: TObject);
begin
  TTabSheet(TEditColor(Sender).parent).Caption := TEditColor(Sender).Text;
end;

{******************************************************************************}
procedure TFNovaPerguntaPesquisaSatisfacao.EIndiceExit(Sender: TObject);
begin
  TTabSheet(Tnumerico(Sender).Parent).PageIndex := Tnumerico(Sender).AsInteger;
end;

{******************************************************************************}
procedure TFNovaPerguntaPesquisaSatisfacao.SpeedButton2Click(
  Sender: TObject);
begin
  if Paginas.PageCount > 1 then
    Paginas.ActivePage.Destroy;
end;

{******************************************************************************}
procedure TFNovaPerguntaPesquisaSatisfacao.PaginasChange(Sender: TObject);
begin
  BPagina.Caption := 'Página '+IntToStr(Paginas.ActivePage.PageIndex)+ ' de '+IntToStr(Paginas.PageCount-1);
end;

{******************************************************************************}
procedure TFNovaPerguntaPesquisaSatisfacao.ENomPesquisaChange(
  Sender: TObject);
begin
  if VprOperacao in [ocedicao,ocinsercao] then
    ValidaGravacao1.execute;
end;

procedure TFNovaPerguntaPesquisaSatisfacao.BGravarClick(Sender: TObject);
begin
  if GravaDados then
  begin
    VprAcao := true;
    close;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovaPerguntaPesquisaSatisfacao]);
end.

