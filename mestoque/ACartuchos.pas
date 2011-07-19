unit ACartuchos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, Componentes1, StdCtrls, Buttons, PainelGradiente, Grids, UnArgox, UnDadosProduto,
  DBGrids, Tabela, DBKeyViolation, Localizacao, ComCtrls, Db, DBTables, unProdutos,
  DBClient;

type
  TFCartuchos = class(TFormularioPermissao)
    PanelColor1: TPanelColor;
    PainelGradiente1: TPainelGradiente;
    BFechar: TBitBtn;
    PanelColor2: TPanelColor;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    EDataInicial: TCalendario;
    EDataFinal: TCalendario;
    EFilial: TEditLocaliza;
    SpeedButton1: TSpeedButton;
    Label10: TLabel;
    Localiza: TConsultaPadrao;
    EOrcamento: TEditLocaliza;
    SpeedButton2: TSpeedButton;
    Label6: TLabel;
    GCartuchos: TGridIndice;
    PESOCARTUCHO: TSQL;
    DataPESOCARTUCHO: TDataSource;
    ESequencial: TEditColor;
    PESOCARTUCHOSEQCARTUCHO: TFMTBCDField;
    PESOCARTUCHODATPESO: TSQLTimeStampField;
    PESOCARTUCHOC_NOM_PRO: TWideStringField;
    PESOCARTUCHOPESCARTUCHO: TFMTBCDField;
    PESOCARTUCHONOMCELULA: TWideStringField;
    PESOCARTUCHOC_NOM_USU: TWideStringField;
    PESOCARTUCHONOMPO: TWideStringField;
    PESOCARTUCHONOMCILINDRO: TWideStringField;
    PESOCARTUCHONOMCHIP: TWideStringField;
    PESOCARTUCHODATSAIDA: TSQLTimeStampField;
    PESOCARTUCHOCODFILIAL: TFMTBCDField;
    PESOCARTUCHOLANORCAMENTO: TFMTBCDField;
    CPeriodo: TCheckBox;
    BPesar: TBitBtn;
    PESOCARTUCHOI_SEQ_PRO: TFMTBCDField;
    PESOCARTUCHOC_COD_PRO: TWideStringField;
    PESOCARTUCHOC_TIP_CAR: TWideStringField;
    PESOCARTUCHOI_COD_COR: TFMTBCDField;
    PESOCARTUCHOC_COD_CTA: TWideStringField;
    PESOCARTUCHOC_CIL_NOV: TWideStringField;
    PESOCARTUCHOC_CHI_NOV: TWideStringField;
    PESOCARTUCHOI_QTD_MLC: TFMTBCDField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ESequencialExit(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure GCartuchosOrdem(Ordem: String);
    procedure BPesarClick(Sender: TObject);
  private
    VprOrdem: String;
    FunArgox : TRBFuncoesArgox;
    procedure InicializaTela;
    procedure AtualizaConsulta;
    procedure AdicionaFiltros(VpaSelect: TStrings);
  public
  end;

var
  FCartuchos: TFCartuchos;

implementation
uses
  APrincipal, FunData, Constantes, FunSQL, APesarCartucho;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFCartuchos.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  InicializaTela;
  VprOrdem:= ' ORDER BY SEQCARTUCHO';
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFCartuchos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
  PESOCARTUCHO.Close;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFCartuchos.GCartuchosOrdem(Ordem: String);
begin
  VprOrdem:= Ordem;
end;

{******************************************************************************}
procedure TFCartuchos.BFecharClick(Sender: TObject);
begin
  Close;
end;

{******************************************************************************}
procedure TFCartuchos.InicializaTela;
begin
  EDataInicial.DateTime:= PrimeiroDiaMes(Date);
  EDataFinal.DateTime:= UltimoDiaMes(Date);
  EOrcamento.AInteiro:= 0;
  EOrcamento.Atualiza;
  ActiveControl:= ESequencial;
end;

{******************************************************************************}
procedure TFCartuchos.ESequencialExit(Sender: TObject);
begin
  AtualizaConsulta;
end;

{******************************************************************************}
procedure TFCartuchos.AtualizaConsulta;
begin
  PESOCARTUCHO.Close;
  PESOCARTUCHO.SQL.Clear;
  PESOCARTUCHO.SQL.Add('SELECT'+
                       ' PSC.SEQCARTUCHO, PSC.DATPESO, PRO.C_NOM_PRO, PSC.PESCARTUCHO,'+
                       ' CLT.NOMCELULA, USU.C_NOM_USU,'+
                       ' POT.C_NOM_PRO NOMPO, CIL.C_NOM_PRO NOMCILINDRO, CHP.C_NOM_PRO NOMCHIP,'+
                       ' PSC.DATSAIDA, PSC.CODFILIAL, PSC.LANORCAMENTO,'+
                       '  PRO.I_SEQ_PRO, PRO.C_COD_PRO, PRO.C_TIP_CAR, PRO.I_COD_COR, PRO.C_COD_CTA, '+
                       ' PRO.C_CIL_NOV, PRO.C_CHI_NOV, PRO.I_QTD_MLC '+
                       ' FROM'+
                       ' PESOCARTUCHO PSC, CADPRODUTOS PRO, CELULATRABALHO CLT,'+
                       ' CADUSUARIOS USU, CADPRODUTOS POT, CADPRODUTOS CIL,'+
                       ' CADPRODUTOS CHP'+
                       ' WHERE'+
                       ' PRO.I_SEQ_PRO = PSC.SEQPRODUTO'+
                       ' AND CLT.CODCELULA = PSC.CODCELULA'+
                       ' AND USU.I_COD_USU = PSC.CODUSUARIO'+
                       ' AND '+SQLTextoRightJoin('PSC.SEQPRODUTOPO','POT.I_SEQ_PRO')+
                       ' AND '+SQLTextoRightJoin('PSC.SEQPRODUTOCILINDRO','CIL.I_SEQ_PRO')+
                       ' AND '+SQLTextoRightJoin('PSC.SEQPRODUTOCHIP','CHP.I_SEQ_PRO'));
  AdicionaFiltros(PESOCARTUCHO.SQL);
  PESOCARTUCHO.SQL.Add(VprOrdem);
  PESOCARTUCHO.Open;
  GCartuchos.ALinhaSQLOrderBy:= PESOCARTUCHO.SQL.Count-1;
end;

{******************************************************************************}
procedure TFCartuchos.AdicionaFiltros(VpaSelect: TStrings);
begin
  if ESequencial.AInteiro <> 0 then
    VpaSelect.Add(' AND PSC.SEQCARTUCHO = '+ESequencial.Text)
  else
  begin
    if CPeriodo.Checked then
      VpaSelect.Add(SQLTextoDataEntreAAAAMMDD('PSC.DATPESO',EDataInicial.DateTime,IncDia(EDataFinal.DateTime,1),True));
    if EFilial.AInteiro <> 0 then
      VpaSelect.Add(' AND PSC.CODFILIAL = '+EFilial.Text);
    if EOrcamento.AInteiro <> 0 then
      VpaSelect.Add(' AND PSC.LANORCAMENTO = '+EOrcamento.Text);
  end;
end;

{******************************************************************************}
procedure TFCartuchos.BPesarClick(Sender: TObject);
var
  VpfDCartucho : TRBDPesoCartucho;
begin
  FunArgox := TRBFuncoesArgox.cria(Varia.PortaComunicacaoImpTermica);
  VpfDCartucho := TRBDPesoCartucho.cria;
  VpfDCartucho.SeqCartucho := PESOCARTUCHOSEQCARTUCHO.AsInteger;
  VpfDCartucho.SeqProduto := PESOCARTUCHOI_SEQ_PRO.AsInteger;
  VpfDCartucho.CodProduto := PESOCARTUCHOC_COD_PRO.AsString;
  VpfDCartucho.NomProduto := PESOCARTUCHOC_NOM_PRO.AsString;
  VpfDCartucho.CodReduzidoCartucho := PESOCARTUCHOC_COD_CTA.AsString;
  VpfDCartucho.DesTipoCartucho := PESOCARTUCHOC_TIP_CAR.AsString;
  VpfDCartucho.NomCorCartucho := FunProdutos.RNomeCor(PESOCARTUCHOI_COD_COR.AsString);
  VpfDCartucho.IndCilindroNovo := PESOCARTUCHOC_CIL_NOV.AsString = 'S';
  VpfDCartucho.IndChipNovo := PESOCARTUCHOC_CHI_NOV.AsString = 'S';
  VpfDCartucho.DatPeso := PESOCARTUCHODATPESO.AsDateTime;
  VpfDCartucho.PesCartucho := PESOCARTUCHOPESCARTUCHO.AsFloat;
  VpfDCartucho.QtdMLCartucho := PESOCARTUCHOI_QTD_MLC.AsFloat;
  FunArgox.ImprimeEtiqueta(VpfDCartucho);
  FunArgox.free;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFCartuchos]);
end.
