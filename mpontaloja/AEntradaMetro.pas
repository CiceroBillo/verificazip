unit AEntradaMetro;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, ComCtrls, StdCtrls, AxCtrls,
  OleCtrls, UnEntradaMetros, Buttons, Spin, UnCotacao, TeeEdiGrad,
  TeePenDlg, TeCanvas, Grids, CGrades, DBGrids, Tabela, DBKeyViolation, DB,
  DBClient, Provider, UnRave;

type
  TFEntradaMetro = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Label3: TLabel;
    Label4: TLabel;
    EDatInicio: TCalendario;
    EDatFim: TCalendario;
    BAtualizar: TBitBtn;
    BFechar: TBitBtn;
    DataSetProvider1: TDataSetProvider;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BAtualizarClick(Sender: TObject);
    procedure BImprimeClick(Sender: TObject);
  private
    { Private declar ations }
    VprDatGeradaIni,
    VprDatGeradaFim : TDatetime;
    FunEntradaMEtros : TRBFuncoesEntradaMetros;
    FunRave : TRBFunRave;
  public
    { Public declarations }
    procedure EntradaMetros;
  end;

var
  FEntradaMetro: TFEntradaMetro;

implementation

uses APrincipal, FunObjeto;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFEntradaMetro.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunEntradaMEtros := TRBFuncoesEntradaMetros.cria(FPrincipal.BaseDados);
  FunRave := TRBFunRave.cria(FPrincipal.BaseDados);
  EDatInicio.DateTime := date;
  EDatFim.DateTime := date;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFEntradaMetro.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  FunEntradaMEtros.free;
  FunRave.free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFEntradaMetro.EntradaMetros;
begin
  ShowModal;
end;

{******************************************************************************}
procedure TFEntradaMetro.BFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFEntradaMetro.BImprimeClick(Sender: TObject);
begin

end;

{******************************************************************************}
procedure TFEntradaMetro.BAtualizarClick(Sender: TObject);
begin
  if (EDatInicio.DateTime <> VprDatGeradaIni) or
     (EDatFim.DateTime <> VprDatGeradaFim) then
  begin
    VprDatGeradaIni := EDatInicio.DateTime;
    VprDatGeradaFim := EDatFim.DateTime;
    FunCotacao.AtualizaEntradaMetrosDiario(EDatInicio.DateTime,EDatFim.DateTime);
  end;
  FunRave.ImprimeEntradaMetros(EDatInicio.DateTime,EDatFim.DateTime);
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFEntradaMetro]);
end.
