unit AMostraEnvelope;

{          Autor: Douglas Thomas Jacobsen
    Data Criação: 28/02/2000;
          Função: TELA BÁSICA
  Data Alteração:
    Alterado por:
Motivo alteração:
}

interface

uses
  Windows, SysUtils, Classes,Controls, Forms, Componentes1, ExtCtrls,
  PainelGradiente, Formularios, StdCtrls, Buttons,
  Mask, DBGrids, LabelCorMove, numericos,ComCtrls,UnDados;

type
  TFMostraEnvelope = class(TFormularioPermissao)
    PanelFechar: TPanelColor;
    BFechar: TBitBtn;
    BImprimir: TBitBtn;
    PainelTitulo: TPainelGradiente;
    PanelColor3: TPanelColor;
    ENome: TEditColor;
    ERua: TEditColor;
    EBairro: TEditColor;
    ECidade: TEditColor;
    ECEP: TEditColor;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label7: TLabel;
    EContato: TEditColor;
    Paginas: TPageControl;
    Destinatario: TTabSheet;
    Shape1: TShape;
    PanelColor1: TPanelColor;
    Shape8: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Label2: TLabel;
    LNome: TLabel;
    LEndereco: TLabel;
    LBairro: TLabel;
    LCidade: TLabel;
    LCEP: TLabel;
    LContato: TLabel;
    BOK: TBitBtn;
    EUF: TEditColor;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ENomeChange(Sender: TObject);
    procedure ERuaChange(Sender: TObject);
    procedure EBairroChange(Sender: TObject);
    procedure ECidadeChange(Sender: TObject);
    procedure ECEPChange(Sender: TObject);
    procedure EContatoChange(Sender: TObject);
  private
    procedure DesativaEdits;
  public
    { Public declarations }
    procedure ImprimeDocumento;
  end;

var
  FMostraEnvelope : TFMostraEnvelope;

implementation

uses APrincipal, FunSql, FunString, ConstMsg, FunObjeto, Constantes, dmRave;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFMostraEnvelope.FormCreate(Sender: TObject);
begin
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFMostraEnvelope.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := CaFree;
end;

{************** fecha formualrio ********************************************* }
procedure TFMostraEnvelope.BFecharClick(Sender: TObject);
begin
  Close;
end;

{*************** chama a impressa do  documento ****************************** }
procedure TFMostraEnvelope.BImprimirClick(Sender: TObject);
begin
  ImprimeDocumento;
end;

{**************************** Imprime documento ***************************** }
procedure TFMostraEnvelope.ImprimeDocumento;
Var
  VpfDCliente : TRBDCliente;
begin
  VpfDCliente := TRBDCliente.Cria;
  VpfDCliente.NomCliente := ENome.Text;
  VpfDCliente.DesEndereco := ERua.Text;
  VpfDCliente.DesBairro := EBairro.Text;
  VpfDCliente.CepCliente := ECEP.Text;
  VpfDCliente.DesCidade := ECidade.Text;
  VpfDCliente.DesUF := EUF.Text;
  VpfDCliente.NomContato := EContato.Text;
  dtRave := TdtRave.create(self);
  dtRave.ImprimeEnvelope(VpfDCliente);
  dtRave.free;
  VpfDCliente.free;
end;

{********** esconde os edit de digitacao ************************************ }
procedure TFMostraEnvelope.DesativaEdits;
begin
  PanelColor3.Visible := false;
end;

{*********** posiciona e configura os edits ******************************** }
procedure TFMostraEnvelope.FormShow(Sender: TObject);
begin
end;

{*********** adiciona o campo nome ao label nome ***************************** }
procedure TFMostraEnvelope.ENomeChange(Sender: TObject);
begin
  LNome.Caption := ENome.Text
end;

{*********** adiciona o campo endereco ao label endereco ********************* }
procedure TFMostraEnvelope.ERuaChange(Sender: TObject);
begin
  LEndereco.Caption := ERua.Text
end;

{*********** adiciona o campo bairro ao bairro nome ************************* }
procedure TFMostraEnvelope.EBairroChange(Sender: TObject);
begin
  LBairro.Caption := EBairro.Text;
end;

{*********** adiciona o campo cidade ao cidade nome ************************* }
procedure TFMostraEnvelope.ECidadeChange(Sender: TObject);
begin
  LCidade.Caption :=  ECidade.Text + '/'+EUF.Text;
end;

{*********** adiciona o campo CEP ao label CEP ******************************* }
procedure TFMostraEnvelope.ECEPChange(Sender: TObject);
begin
  LCEP.Caption := ECEP.Text;
end;

procedure TFMostraEnvelope.EContatoChange(Sender: TObject);
begin
  LContato.Caption := EContato.Text
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                        chamada Externa
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }



Initialization
 RegisterClasses([TFMostraEnvelope]);
end.
