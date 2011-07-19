unit ANovoEmailMedidores;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, PainelGradiente, StdCtrls, Buttons, ComCtrls, Componentes1, DB,
  DBClient, Tabela, FMTBcd, SqlExpr, UnContrato, Constantes, UnDados;

type
  TFNovoEmailMedidores = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Animate1: TAnimate;
    Progresso: TProgressBar;
    BEnviar: TBitBtn;
    BFechar: TBitBtn;
    EMAILMEDIDORCORPO: TSQL;
    EMAILMEDIDORITEM: TSQLQuery;
    EMAILMEDIDORITEMSEQEMAIL: TFMTBCDField;
    EMAILMEDIDORITEMCODFILIAL: TFMTBCDField;
    EMAILMEDIDORITEMSEQCONTRATO: TFMTBCDField;
    EMAILMEDIDORITEMINDENVIADO: TWideStringField;
    EMAILMEDIDORITEMDESSTATUS: TWideStringField;
    Aux: TSQL;
    EMAILMEDIDORCORPOSEQEMAIL: TFMTBCDField;
    EMAILMEDIDORCORPODATENVIO: TSQLTimeStampField;
    EMAILMEDIDORCORPOCODUSUARIO: TFMTBCDField;
    BarraStatus: TStatusBar;
    BImprimir: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BEnviarClick(Sender: TObject);
    procedure TCancelarTimer(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
  private
    { Private declarations }
    VprDMedidores   : TRBDEmailMedidorCorpo;
    VprDItemMedidor : TRBDEmailMedidorItem;
    FunContrato     : TRBFuncoesContrato;

    procedure InicializaDMedidorCorpo;
    procedure InicializaDMedidorItem;

    procedure AtualizaBarraStatus(VpaTexto : String);
    procedure EnviaEmailsMedidores;
  public
    { Public declarations }
    procedure EnviaEmailsContratos(VpaSql: TStrings);
  end;

var
  FNovoEmailMedidores: TFNovoEmailMedidores;

implementation

uses APrincipal, FunSql, ConstMsg, dmRave;

{$R *.DFM}


{ **************************************************************************** }
procedure TFNovoEmailMedidores.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  FunContrato := TRBFuncoesContrato.cria(FPrincipal.BaseDados);
end;

{ *************************************************************************** }
procedure TFNovoEmailMedidores.InicializaDMedidorCorpo;
begin
  VprDMedidores := TRBDEmailMedidorCorpo.cria;
  VprDMedidores.SeqEmail := FunContrato.RSeqEmailMedidorDisponivel;
  VprDMedidores.CodUsuario := varia.CodigoUsuario;
  VprDMedidores.DataEnvio := now;
end;

{ *************************************************************************** }
procedure TFNovoEmailMedidores.InicializaDMedidorItem;
begin
  VprDItemMedidor := VprDMedidores.AddItem;
  VprDItemMedidor.CodFilial   := Aux.FieldByName('CODFILIAL').AsInteger;
  VprDItemMedidor.SeqContrato := Aux.FieldByName('SEQCONTRATO').AsInteger;
  VprDItemMedidor.Enviado     := 'N';
  VprDItemMedidor.Status      := '';
end;

{ *************************************************************************** }
procedure TFNovoEmailMedidores.TCancelarTimer(Sender: TObject);
begin
  close;
end;

{ *************************************************************************** }
procedure TFNovoEmailMedidores.AtualizaBarraStatus(VpaTexto: String);
begin
  BarraStatus.Panels[0].Text := VpaTexto;
  BarraStatus.Refresh;
end;

{ *************************************************************************** }
procedure TFNovoEmailMedidores.BEnviarClick(Sender: TObject);
begin
  BEnviar.Enabled := false;
  InicializaDMedidorCorpo;
  EnviaEmailsMedidores;
  AtualizaBarraStatus('E-mail''s enviados com sucesso.');
end;

{ *************************************************************************** }
procedure TFNovoEmailMedidores.BFecharClick(Sender: TObject);
begin
  Close;
end;

{ *************************************************************************** }
procedure TFNovoEmailMedidores.BImprimirClick(Sender: TObject);
begin
  dtRave := TdtRave.Create(self);
  dtRave.ImprimeEmailMedidores(VprDMedidores);
  dtRave.Free;
end;

{ *************************************************************************** }
procedure TFNovoEmailMedidores.EnviaEmailsMedidores;
var
  VpfResultado : String;
begin
  if Aux.FieldByName('CODFILIAL').AsInteger > 0 then
  begin
    Animate1.Active := True;
    Progresso.Max := Aux.RecordCount;
    Progresso.Position := 0;
    Aux.First;
    while (not Aux.Eof) do
    begin
      InicializaDMedidorItem;
      VpfResultado := FunContrato.EnviaMedidorEmail(Aux.FieldByName('CODFILIAL').AsInteger,
                                                    Aux.FieldByName('SEQCONTRATO').AsInteger);
      if VpfResultado = '' then
        VprDItemMedidor.Enviado := 'S'
      else
      begin
        VprDItemMedidor.Status  := VpfResultado;
        VprDItemMedidor.Enviado := 'N';
      end;
      AtualizaBarraStatus('Filial : '+ Aux.FieldByName('CODFILIAL').AsString+' Contrato : ' +Aux.FieldByName('SEQCONTRATO').AsString + ' - '+ VpfResultado);
      Progresso.Position := Progresso.Position + 1;
      Aux.Next;
    end;
    Animate1.Active := false;
    Aux.Close;
    AtualizaBarraStatus('e-mail''s enviados com sucesso.');
    VpfResultado := FunContrato.GravaDEmailMedidor(VprDMedidores);
    if VpfResultado <> '' then
      aviso(VpfResultado)
    else
      BImprimir.Enabled := True;
  end;
end;

{ *************************************************************************** }
procedure TFNovoEmailMedidores.EnviaEmailsContratos(VpaSql: TStrings);
begin
  AdicionaSQLAbreTabela(Aux, VpaSql.Text);
  ShowModal;
end;

{ *************************************************************************** }
procedure TFNovoEmailMedidores.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  if FunContrato <> nil then
    FunContrato.Free;
  if VprDMedidores <> nil then
    VprDMedidores.Free;
  //if VprDItemMedidor <> nil then
  //  VprDItemMedidor.Free;
  if Aux.Active then
    Aux.Close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFNovoEmailMedidores]);
end.
