unit ABaixaCotacaoPaga;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Localizacao, StdCtrls, Buttons,
  Db, DBTables, ComCtrls;

type
  TFBaixaCotacaoPaga = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BAdiciona: TBitBtn;
    BBaixa: TBitBtn;
    BFechar: TBitBtn;
    ECotacao: TEditLocaliza;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    ConsultaPadrao1: TConsultaPadrao;
    Aux: TQuery;
    StatusBar1: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure ECotacaoSelect(Sender: TObject);
    procedure BAdicionaClick(Sender: TObject);
    procedure BBaixaClick(Sender: TObject);
    procedure ECotacaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AdicionaOrcamento;
    procedure BaixaOrcamento;
  end;

var
  FBaixaCotacaoPaga: TFBaixaCotacaoPaga;

implementation

uses APrincipal, funSql,Constantes;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFBaixaCotacaoPaga.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFBaixaCotacaoPaga.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFBaixaCotacaoPaga.AdicionaOrcamento;
begin
  BBaixa.Visible := false;
  Caption := 'Adicionar Orcamentos ';
  PainelGradiente1.Caption := '  '+caption;
  ShowModal;
end;

{******************************************************************************}
procedure TFBaixaCotacaoPaga.BaixaOrcamento;
begin
  BAdiciona.Visible := false;
  Caption := 'Baixar Orcamentos ';
  PainelGradiente1.Caption := '  '+caption;
  ShowModal;
end;

{******************************************************************************}
procedure TFBaixaCotacaoPaga.BFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFBaixaCotacaoPaga.ECotacaoSelect(Sender: TObject);
begin
  ECotacao.ASelectLocaliza.Text := 'Select ORC.I_LAN_ORC, CLI.C_NOM_CLI '+
                                   ' from  CADCLIENTES CLI, CADORCAMENTOS ORC '+
                                   ' Where CLI.C_NOM_CLI LIKE ''@%'''+
                                   ' and ORC.I_COD_CLI = CLI.I_COD_CLI '+
                                   ' and ORC.I_EMP_FIL = '+IntToStr(VARIA.CodigoEmpfil);

  ECotacao.ASelectValida.Text := 'Select ORC.I_LAN_ORC, CLI.C_NOM_CLI '+
                                   ' from  CADCLIENTES CLI, CADORCAMENTOS ORC '+
                                   ' Where ORC.I_LAN_ORC = @'+
                                   ' and ORC.I_COD_CLI = CLI.I_COD_CLI '+
                                   ' and ORC.I_EMP_FIL = '+IntToStr(VARIA.CodigoEmpfil);
end;

{******************************************************************************}
procedure TFBaixaCotacaoPaga.BAdicionaClick(Sender: TObject);
begin
  if ECotacao.AInteiro <>0 then
  begin
    ExecutaComandoSql(Aux,'UPDATE CADORCAMENTOS '+
                          ' Set C_IND_PAG = ''N'''+
                          ' Where I_EMP_FIL = '+IntToStr(Varia.CodigoEmpfil)+
                          ' and I_LAN_ORC = '+ECotacao.Text);
    StatusBar1.Panels[0].Text :=  'Cotação "'+ECotacao.Text+'" adicionada';
  end;
end;

{******************************************************************************}
procedure TFBaixaCotacaoPaga.BBaixaClick(Sender: TObject);
begin
  if ECotacao.AInteiro <>0 then
  begin
    ExecutaComandoSql(Aux,'UPDATE CADORCAMENTOS '+
                          ' Set C_IND_PAG = ''S'''+
                          ' Where I_EMP_FIL = '+IntToStr(Varia.CodigoEmpfil)+
                          ' and I_LAN_ORC = '+ECotacao.Text);
    StatusBar1.Panels[0].Text :=  'Cotação "'+ECotacao.Text+'" baixada';
  end;
end;

procedure TFBaixaCotacaoPaga.ECotacaoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  IF KEY = 13 THEN
  begin
    ECotacao.Atualiza;
    if BAdiciona.Visible then
      BAdiciona.Click
    else
      BBaixa.click;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFBaixaCotacaoPaga]);
end.
