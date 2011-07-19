unit ACartuchoCotacaoProduto;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, PainelGradiente, StdCtrls, Componentes1, UnDadosProduto,
  Buttons, Db, DBTables, Grids, DBGrids, Tabela, DBKeyViolation, DBClient;

type
  TFCartuchoCotacaoCartucho = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    LTextoTroca: TLabel;
    GridIndice1: TGridIndice;
    MovOrcamento: TSQL;
    DataMovOrcamento: TDataSource;
    MovOrcamentoC_COD_PRO: TWideStringField;
    MovOrcamentoC_NOM_PRO: TWideStringField;
    MovOrcamentoN_QTD_PRO: TFMTBCDField;
    BOk: TBitBtn;
    BCancelar: TBitBtn;
    Label1: TLabel;
    MovOrcamentoI_SEQ_PRO: TFMTBCDField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BOkClick(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
  private
    { Private declarations }
    VprAcao : Boolean;
    VprDCartucho : TRBDCartuchoCotacao;
    procedure AtualizaConsulta;
  public
    { Public declarations }
    function TrocaCartuchoCotacao(VpaDCartucho : TRBDCartuchoCotacao):Boolean;
  end;

var
  FCartuchoCotacaoCartucho: TFCartuchoCotacaoCartucho;

implementation

uses APrincipal;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFCartuchoCotacaoCartucho.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprAcao := false;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFCartuchoCotacaoCartucho.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  MovOrcamento.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFCartuchoCotacaoCartucho.AtualizaConsulta;
begin
  MovOrcamento.sql.clear;
  MovOrcamento.sql.add('Select PRO.I_SEQ_PRO, PRO.C_COD_PRO,  PRO.C_NOM_PRO, MOV.N_QTD_PRO '+
                       ' from MOVORCAMENTOS MOV, CADPRODUTOS PRO '+
                       ' Where MOV.I_EMP_FIL = '+IntToStr(VprDCartucho.CodFilial)+
                       ' and MOV.I_LAN_ORC = '+IntToStr(VprDCartucho.LanOrcamento)+
                       ' AND MOV.I_SEQ_PRO = PRO.I_SEQ_PRO ');
  MovOrcamento.open;
end;

{******************************************************************************}
function TFCartuchoCotacaoCartucho.TrocaCartuchoCotacao(VpaDCartucho : TRBDCartuchoCotacao):Boolean;
begin
  VprDCartucho := VpaDCartucho;
  AtualizaConsulta;
  LTextoTroca.Caption := 'O cartucho "'+VpaDCartucho.CodProduto+'-'+VpaDCartucho.NomProduto+'"';
  showmodal;
  result := vprAcao;
end;

{******************************************************************************}
procedure TFCartuchoCotacaoCartucho.BOkClick(Sender: TObject);
begin
  VprAcao := true;

  if MovOrcamentoI_SEQ_PRO.AsInteger <> 0 then
    VprDCartucho.SeqProdutoTrocado := MovOrcamentoI_SEQ_PRO.AsInteger
  else
    VprAcao := false;

  close;
end;

{******************************************************************************}
procedure TFCartuchoCotacaoCartucho.BCancelarClick(Sender: TObject);
begin
  close;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFCartuchoCotacaoCartucho]);
end.
