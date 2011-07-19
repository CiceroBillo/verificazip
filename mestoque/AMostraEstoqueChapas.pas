unit AMostraEstoqueChapas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios, StdCtrls, Buttons, DB,
  DBClient, Tabela, CBancoDados, Grids, DBGrids, DBKeyViolation, Componentes1, ExtCtrls, PainelGradiente, UnZebra,
  UnDadosProduto;

type
  TFMostraEstoqueChapas = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    Grade: TGridIndice;
    Chapas: TRBSQL;
    ChapasC_COD_PRO: TWideStringField;
    ChapasC_NOM_PRO: TWideStringField;
    ChapasLARCHAPA: TFMTBCDField;
    ChapasCOMCHAPA: TFMTBCDField;
    ChapasPERCHAPA: TFMTBCDField;
    ChapasPESCHAPA: TFMTBCDField;
    ChapasSEQNOTAFORNECEDOR: TFMTBCDField;
    ChapasCODFILIAL: TFMTBCDField;
    DataChapas: TDataSource;
    BFechar: TBitBtn;
    ChapasSEQCHAPA: TFMTBCDField;
    BEtiqueta: TBitBtn;
    POK: TPanelColor;
    BCancelar: TBitBtn;
    BOK: TBitBtn;
    PanelColor1: TPanelColor;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure GradeDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure BEtiquetaClick(Sender: TObject);
    procedure BOKClick(Sender: TObject);
  private
    { Private declarations }
    VprCodFilial,
    VprSeqNota,
    VprSeqProduto : Integer;
    VprOrdem : String;
    VprAcao : Boolean;
    FunZebra : TRBFuncoesZebra;
    procedure AtualizaConsulta;
    procedure AdicionaFiltros(VpaSelect : TStrings);
  public
    { Public declarations }
    procedure MostraEstoqueChapasNota(VpaCodFilial, VpaSeqNota : Integer);
    function MostraEstoqueChapasProduto(VpaSeqproduto : Integer;VpaDPlanoCorte : TRBDPlanoCorteCorpo) : Integer;
  end;

var
  FMostraEstoqueChapas: TFMostraEstoqueChapas;

implementation

uses APrincipal, constantes;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFMostraEstoqueChapas.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprOrdem := 'order by CHA.SEQCHAPA';
  FunZebra := TRBFuncoesZebra.cria(Varia.PortaComunicacaoImpTermica,176,lzEPL);
  VprAcao := false;
end;

{ **************************************************************************** }
procedure TFMostraEstoqueChapas.GradeDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
  Column: TColumn; State: TGridDrawState);
begin
  if State <> [gdSelected] then
  begin
    if Column.FieldName = 'SEQCHAPA' then
    begin
      Grade.Canvas.Brush.Color:= clyellow;
      Grade.DefaultDrawDataCell(Rect, Grade.columns[datacol].field, State);
    end;
  end;

end;

{ **************************************************************************** }
procedure TFMostraEstoqueChapas.MostraEstoqueChapasNota(VpaCodFilial, VpaSeqNota: Integer);
begin
  VprCodFilial := VpaCodFilial;
  VprSeqNota := VpaSeqNota;
  AtualizaConsulta;
  showmodal;
end;

{ **************************************************************************** }
function TFMostraEstoqueChapas.MostraEstoqueChapasProduto(VpaSeqproduto: Integer;VpaDPlanoCorte : TRBDPlanoCorteCorpo):Integer;
begin
  result := 0;
  VprSeqProduto := VpaSeqproduto;
  AtualizaConsulta;
  PanelColor2.Visible := false;
  POK.Visible := true;
  showmodal;
  if VprAcao  then
  begin
    Result := ChapasSEQCHAPA.AsInteger;
    VpaDPlanoCorte.SeqChapa :=ChapasSEQCHAPA.AsInteger;
    VpaDPlanoCorte.PesoChapa := ChapasPESCHAPA.AsFloat;
  end;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFMostraEstoqueChapas.AdicionaFiltros(VpaSelect: TStrings);
begin
  if VprCodFilial <> 0 then
     VpaSelect.Add('AND CHA.CODFILIAL = '+IntToStr(VprCodFilial));
  if VprSeqNota <> 0 then
    VpaSelect.Add('AND CHA.SEQNOTAFORNECEDOR = '+IntToStr(VprSeqNota));
  if VprSeqProduto <> 0 then
    VpaSelect.Add('AND CHA.SEQPRODUTO = '+IntToStr(VprSeqProduto));

end;

{ **************************************************************************** }
procedure TFMostraEstoqueChapas.AtualizaConsulta;
begin
  Chapas.Close;
  Chapas.SQL.Clear;
  Chapas.SQL.Add('SELECT  PRO.C_COD_PRO, PRO.C_NOM_PRO, '+
                 ' CHA.SEQCHAPA, CHA.LARCHAPA, CHA.COMCHAPA, CHA.PERCHAPA, CHA.PESCHAPA, '+
                 ' CHA.SEQNOTAFORNECEDOR, CHA.CODFILIAL '+
                 ' FROM ESTOQUECHAPA CHA, CADPRODUTOS PRO '+
                 ' WHERE PRO.I_SEQ_PRO = CHA.SEQPRODUTO ');
  AdicionaFiltros(Chapas.SQL);
  Chapas.SQL.Add(VprOrdem);
  Chapas.Open;
end;

{ **************************************************************************** }
procedure TFMostraEstoqueChapas.BEtiquetaClick(Sender: TObject);
begin
  FunZebra.ImprimeEtiquetaIdentificaChapa33X22(Chapas);
end;

{ **************************************************************************** }
procedure TFMostraEstoqueChapas.BFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFMostraEstoqueChapas.BOKClick(Sender: TObject);
begin
  VprAcao := true;
  close;
end;

{ **************************************************************************** }
procedure TFMostraEstoqueChapas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunZebra.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFMostraEstoqueChapas]);
end.
