unit AEstoqueNumeroSerie;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, PainelGradiente, StdCtrls, Buttons, Componentes1, Grids, DBGrids,
  Tabela, DBKeyViolation, DB, DBClient;

type
  TFEstoqueNumeroSerie = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    BFechar: TBitBtn;
    GProduto: TGridIndice;
    EstoqueNumeroSerie: TSQL;
    DataEstoqueNumeroSerie: TDataSource;
    EstoqueNumeroSerieSEQPRODUTO: TFMTBCDField;
    EstoqueNumeroSerieDESNUMEROSERIE: TWideStringField;
    EstoqueNumeroSerieQTDPRODUTO: TFMTBCDField;
    EstoqueNumeroSerieNOM_COR: TWideStringField;
    EstoqueNumeroSerieNOMTAMANHO: TWideStringField;
    EstoqueNumeroSerieCOD_COR: TFMTBCDField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
  private
     VprSeqProduto,
     VprCodCor: Integer;
     procedure AtualizaConsulta;
  public
     procedure ConsultaEstoqueNumeroSerie(VpaSeqProduto, VpaCodCor: Integer);
  end;

var
  FEstoqueNumeroSerie: TFEstoqueNumeroSerie;

implementation

uses APrincipal, FunSql;

{$R *.DFM}


{ **************************************************************************** }
procedure TFEstoqueNumeroSerie.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

{ *************************************************************************** }
procedure TFEstoqueNumeroSerie.AtualizaConsulta;
begin
  EstoqueNumeroSerie.sql.clear;
  EstoqueNumeroSerie.sql.add('SELECT EST.SEQPRODUTO, EST.DESNUMEROSERIE, EST.QTDPRODUTO, ' +
                             ' COR.COD_COR, COR.NOM_COR, TAM.NOMTAMANHO '+
                             ' FROM ESTOQUENUMEROSERIE EST, COR COR, TAMANHO TAM '+
                             ' WHERE ' + SQLTextoRightJoin('EST.CODCOR', 'COR.COD_COR') +
                             ' AND ' + SQLTextoRightJoin('EST.CODTAMANHO', 'TAM.CODTAMANHO') +
                             ' AND EST.SEQPRODUTO = ' + IntToStr(VprSeqProduto)+
                             ' AND EST.CODCOR = ' + IntToStr(VprCodCor));
  EstoqueNumeroSerie.Open;
end;

{ *************************************************************************** }
procedure TFEstoqueNumeroSerie.BFecharClick(Sender: TObject);
begin
  close;
end;

{ *************************************************************************** }
procedure TFEstoqueNumeroSerie.ConsultaEstoqueNumeroSerie(VpaSeqProduto, VpaCodCor: Integer);
begin
  VprSeqProduto:= VpaSeqProduto;
  VprCodCor:= VpaCodCor;
  AtualizaConsulta;
  showmodal;
end;

{ *************************************************************************** }
procedure TFEstoqueNumeroSerie.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFEstoqueNumeroSerie]);
end.
