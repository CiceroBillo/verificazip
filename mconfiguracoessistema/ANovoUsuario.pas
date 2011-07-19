unit ANovoUsuario;
{          Autor: Sergio Luiz Censi
    Data Criação: 01/04/1999;
          Função: Cadastrar um novo Usuario
  Data Alteração: 01/04/1999;
    Alterado por: Rafael Budag
Motivo alteração: -
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, ExtCtrls, StdCtrls, DBCtrls, Mask, Buttons, Grids, DBGrids,
  constantes, constMsg, UnDados, UnVendedor, UnUsuarios,
  ComCtrls, formularios, BotaoCadastro,  Tabela, FunValida, Componentes1,
  PainelGradiente, DBKeyViolation, Localizacao, CGrades, DBClient;

type
  TFNovoUsuario = class(TFormularioPermissao)
    DataUsuarios: TDataSource;
    CadUsuarios: TSQL;
    PanelColor2: TPanelColor;
    BotaoGravar: TBotaoGravar;
    BotaoCancelar: TBotaoCancelar;
    PainelGradiente1: TPainelGradiente;
    CadUsuariosI_EMP_FIL: TFMTBCDField;
    CadUsuariosI_COD_USU: TFMTBCDField;
    CadUsuariosI_COD_GRU: TFMTBCDField;
    CadUsuariosC_NOM_USU: TWideStringField;
    CadUsuariosC_NOM_LOG: TWideStringField;
    CadUsuariosC_SEN_USU: TWideStringField;
    CadUsuariosC_USU_ATI: TWideStringField;
    CadUsuariosC_OBS_USU: TWideStringField;
    CadUsuariosD_DAT_MOV: TSQLTimeStampField;
    CadUsuariosC_EFO_COR: TWideStringField;
    CadUsuariosI_EFO_TAM: TFMTBCDField;
    CadUsuariosC_EFO_NOM: TWideStringField;
    CadUsuariosC_EFO_ATR: TWideStringField;
    CadUsuariosC_EFU_COR: TWideStringField;
    CadUsuariosC_EFF_COR: TWideStringField;
    CadUsuariosC_EFF_FCO: TWideStringField;
    CadUsuariosC_EFO_FCO: TWideStringField;
    CadUsuariosC_GFO_COR: TWideStringField;
    CadUsuariosI_GFO_TAM: TFMTBCDField;
    CadUsuariosC_GFO_NOM: TWideStringField;
    CadUsuariosC_GFO_ATR: TWideStringField;
    CadUsuariosC_GTI_COR: TWideStringField;
    CadUsuariosC_SFO_COR: TWideStringField;
    CadUsuariosI_SFO_TAM: TFMTBCDField;
    CadUsuariosC_SFO_NOM: TWideStringField;
    CadUsuariosC_SFO_ATR: TWideStringField;
    CadUsuariosC_SPA_COR: TWideStringField;
    CadUsuariosI_TIT_ALI: TFMTBCDField;
    CadUsuariosI_TIT_TEX: TFMTBCDField;
    CadUsuariosI_TIT_FUN: TFMTBCDField;
    CadUsuariosC_TCO_SOM: TWideStringField;
    CadUsuariosC_TCO_INI: TWideStringField;
    CadUsuariosC_TCO_FIM: TWideStringField;
    CadUsuariosC_TFO_COR: TWideStringField;
    CadUsuariosI_TFO_TAM: TFMTBCDField;
    CadUsuariosC_TFO_NOM: TWideStringField;
    CadUsuariosC_TFO_ATR: TWideStringField;
    CadUsuariosC_SIS_COR: TWideStringField;
    CadUsuariosC_SIS_PAP: TWideStringField;
    CadUsuariosC_SIS_IMA: TWideStringField;
    CadUsuariosC_CON_SIS: TWideStringField;
    CadUsuariosC_CON_USU: TWideStringField;
    CadUsuariosC_MOD_FIN: TWideStringField;
    CadUsuariosC_MOD_CAI: TWideStringField;
    CadUsuariosC_MOD_EST: TWideStringField;
    CadUsuariosC_MOD_PON: TWideStringField;
    CadUsuariosC_MOD_FAT: TWideStringField;
    CadUsuariosC_MOD_TRX: TWideStringField;
    CadUsuariosD_ULT_ALT: TSQLTimeStampField;
    CadUsuariosC_MOD_REL: TWideStringField;
    CadUsuariosC_DBA_SIS: TWideStringField;
    BFechar: TBitBtn;
    ConsultaPadrao1: TConsultaPadrao;
    CadUsuariosI_COD_REG: TFMTBCDField;
    CadUsuariosC_MOD_AGE: TWideStringField;
    CadUsuariosC_MOD_CHA: TWideStringField;
    CadUsuariosI_COD_TEC: TFMTBCDField;
    CadUsuariosC_MOD_CRM: TWideStringField;
    PanelColor1: TPanelColor;
    Paginas: TPageControl;
    PUsuario: TTabSheet;
    PanelColor3: TPanelColor;
    Label2: TLabel;
    Label7: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label1: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    SpeedButton2: TSpeedButton;
    Label10: TLabel;
    Label11: TLabel;
    SpeedButton3: TSpeedButton;
    Label12: TLabel;
    CodigoFilial: TDBEditColor;
    Nome: TDBEditColor;
    Login: TDBEditColor;
    ConfSenha: TEditColor;
    DBMemoColor1: TDBMemoColor;
    Senhas: TEditColor;
    GroupBox1: TGroupBox;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    DBCheckBox5: TDBCheckBox;
    DBCheckBox6: TDBCheckBox;
    DBCheckBox7: TDBCheckBox;
    DBCheckBox9: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBEditLocaliza1: TDBEditLocaliza;
    DBEditLocaliza2: TDBEditLocaliza;
    PVendedores: TTabSheet;
    Grade: TRBStringGridColor;
    EVendedor: TEditLocaliza;
    Label13: TLabel;
    DBEditLocaliza3: TDBEditLocaliza;
    SpeedButton4: TSpeedButton;
    Label14: TLabel;
    CadUsuariosI_COD_COM: TFMTBCDField;
    DBCheckBox4: TDBCheckBox;
    CadUsuariosI_COD_VEN: TFMTBCDField;
    Label15: TLabel;
    SpeedButton5: TSpeedButton;
    Label16: TLabel;
    DBEditLocaliza4: TDBEditLocaliza;
    ECodigo: TDBKeyViolation;
    EGrupo: TDBEditLocaliza;
    SpeedButton1: TSpeedButton;
    Label17: TLabel;
    ValidaGravacao1: TValidaGravacao;
    Label18: TLabel;
    DBEditLocaliza5: TDBEditLocaliza;
    SpeedButton6: TSpeedButton;
    Label19: TLabel;
    CadUsuariosC_CON_CAI: TWideStringField;
    DBEditColor1: TDBEditColor;
    Label20: TLabel;
    CadUsuariosC_DES_EMA: TWideStringField;
    DBCheckBox8: TDBCheckBox;
    CadUsuariosC_MOD_SIP: TWideStringField;
    DBCheckBox10: TDBCheckBox;
    ScrollBox1: TScrollBox;
    DBCheckBox11: TDBCheckBox;
    CadUsuariosC_MOD_PDV: TWideStringField;
    PAssinaturaEmail: TTabSheet;
    DBMemoColor2: TDBMemoColor;
    CadUsuariosC_ASS_EMA: TWideStringField;
    CadUsuariosI_CAM_VEN: TFMTBCDField;
    RBDBEditLocaliza1: TRBDBEditLocaliza;
    Label21: TLabel;
    SpeedButton7: TSpeedButton;
    Label22: TLabel;
    CadUsuariosI_COR_AGE: TFMTBCDField;
    ECorAgenda: TColorBox;
    Label23: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ConfSenhaExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CadUsuariosAfterInsert(DataSet: TDataSet);
    procedure CadUsuariosBeforePost(DataSet: TDataSet);
    procedure CadUsuariosAfterPost(DataSet: TDataSet);
    procedure SpeedButton1Click(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure DBEditLocaliza1Cadastrar(Sender: TObject);
    procedure CadUsuariosAfterScroll(DataSet: TDataSet);
    procedure GradeCarregaItemGrade(Sender: TObject; VpaLinha: Integer);
    procedure GradeDadosValidos(Sender: TObject; var VpaValidos: Boolean);
    procedure GradeGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GradeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EVendedorRetorno(Retorno1, Retorno2: String);
    procedure GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
      VpaLinhaAnterior: Integer);
    procedure GradeNovaLinha(Sender: TObject);
    procedure GradeSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure EGrupoCadastrar(Sender: TObject);
    procedure NomeChange(Sender: TObject);
    procedure RBDBEditLocaliza1Cadastrar(Sender: TObject);
  private
    VprDUsuarioVendedor: TRBDUsuarioVendedor;
    VprUsuarios: TList;
    FunVendedores: TRBFuncoesVendedor;
    FunUsuario: TRBFuncoesUsuario;
    procedure CarTitulosGrade;
    function ExisteVendedor: Boolean;
    function VendedorJaUsado: Boolean;
    procedure CarDClasseUsuarioVendedor;
  public
    { Public declarations }
  end;

var
  FNovoUsuario: TFNovoUsuario;
  ultimo : Integer;

implementation

uses AUsuarios, APrincipal, AGrupos, FunObjeto, ARegiaoVenda, FunSQL, UnSistema,
  ACampanhaVendas;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFNovoUsuario.FormCreate(Sender: TObject);
begin
  FunVendedores:= TRBFuncoesVendedor.cria(FPrincipal.BaseDAdos);
  FunUsuario:= TRBFuncoesUsuario.Cria(FPrincipal.BaseDAdos);
  VprUsuarios:= TList.Create;
  CarTitulosGrade;
  Grade.ADados:= VprUsuarios;
  Grade.CarregaGrade;
  Paginas.ActivePage:= PUsuario;
  CadUsuarios.open;
  InicializaVerdadeiroeFalsoCheckBox(PanelColor1,'S', 'N');
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovoUsuario.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FunVendedores.Free;
  FunUsuario.Free;
  FreeTObjectsList(VprUsuarios);
  VprUsuarios.Free;
  CadUsuarios.close;
  Action := CaFree;
end;

{******************************************************************************}
procedure TFNovoUsuario.CarTitulosGrade;
begin
  Grade.Cells[1,0]:= 'Código';
  Grade.Cells[2,0]:= 'Vendedor';
end;


{ ***************** Verifica a confirmação da senha ************************** }
procedure TFNovoUsuario.ConfSenhaExit(Sender: TObject);
begin
if Senhas.Text <> ConfSenha.Text then
begin
   beep;
   MessageDlg(CT_ConfirmaSenha, mtWarning , [mbOK], 0);
   Senhas.SetFocus;
end;
end;

{ ***************** Qaundo o formulario é Iniciado *************************** }
procedure TFNovoUsuario.FormShow(Sender: TObject);
begin
   Nome.SetFocus;
   ConfSenha.Text := senhas.Text;
end;


{ **************** Executado apos o insert em usuarios *********************** }
procedure TFNovoUsuario.CadUsuariosAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ProximoCodigo;
   codigoFilial.Field.Value := Varia.CodigoEmpFil;
   CadUsuarios.FieldByName('D_DAT_MOV').Value := date;
   CadUsuarios.FieldByName('C_USU_ATI').Value := 'S';
   CadUsuarios.FieldByName('C_DBA_SIS').Value := 'N';

   CadUsuarios.FieldByName('C_CON_SIS').Value := 'N';
   CadUsuarios.FieldByName('C_CON_USU').Value := 'N';
   CadUsuarios.FieldByName('C_MOD_FIN').Value := 'N';
   CadUsuariosC_MOD_CAI.AsString := 'N';
   CadUsuariosC_MOD_EST.AsString := 'N';
   CadUsuariosC_MOD_PON.AsString := 'N';
   CadUsuariosC_MOD_FAT.AsString := 'N';
   CadUsuariosC_MOD_TRX.AsString := 'N';
   CadUsuariosC_MOD_REL.AsString := 'N';
   CadUsuariosC_MOD_AGE.AsString := 'S';
   CadUsuariosC_MOD_CHA.AsString := 'N';
   CadUsuariosC_MOD_CRM.AsString := 'N';
   CadUsuariosC_MOD_SIP.AsString := 'N';
   CadUsuariosC_MOD_PDV.AsString := 'N';
   BotaoGravar.Enabled := false;
end;


{ *************** Executado antes da gravação em usuários ******************** }
procedure TFNovoUsuario.CadUsuariosBeforePost(DataSet: TDataSet);
begin
  //atualiza a data de alteracao para poder exportar
  CadUsuariosD_ULT_ALT.AsDateTime := Sistema.RDataServidor;
  CadUsuarios.FieldByName('C_SEN_USU').Value := Criptografa(senhas.Text);
  CadUsuariosI_COR_AGE.AsInteger := ECorAgenda.Selected;
   if CadUsuarios.State = dsinsert then
   begin
     ECodigo.VerificaCodigoUtilizado;

     CadUsuarios.FieldByName('C_EFO_COR').AsString :=   'clBlack';
     CadUsuarios.FieldByName('I_EFO_TAM').AsInteger :=  10;
     CadUsuarios.FieldByName('C_EFO_NOM').AsString :=   'MS Sans Serif';
     CadUsuarios.FieldByName('C_EFO_ATR').AsString :=   '';
     CadUsuarios.FieldByName('C_EFU_COR').AsString :=   'clInfoBk';
     CadUsuarios.FieldByName('C_EFF_COR').AsString :=   'clwhite';
     CadUsuarios.FieldByName('C_EFF_FCO').AsString :=   '$00B1F0FE';
     CadUsuarios.FieldByName('C_EFO_FCO').AsString :=   'clblue';

     CadUsuarios.FieldByName('C_GFO_COR').AsString :=   'clBlue';
     CadUsuarios.FieldByName('I_GFO_TAM').AsInteger :=  10;
     CadUsuarios.FieldByName('C_GFO_NOM').AsString :=   'MS Sans Serif';
     CadUsuarios.FieldByName('C_GFO_ATR').AsString :=   '';
     CadUsuarios.FieldByName('C_GTI_COR').AsString :=   'clSilver';

     CadUsuarios.FieldByName('C_SFO_COR').AsString :=  'clBlack';
     CadUsuarios.FieldByName('I_SFO_TAM').AsInteger :=  10;
     CadUsuarios.FieldByName('C_SFO_NOM').AsString :=  'MS Sans Serif';
     CadUsuarios.FieldByName('C_SFO_ATR').AsString :=  '';
     CadUsuarios.FieldByName('C_SPA_COR').AsString :=   'clSilver';

     CadUsuarios.FieldByName('I_TIT_ALI').AsInteger :=  0;
     CadUsuarios.FieldByName('C_TCO_SOM').AsString :=   'ClBlack';
     CadUsuarios.FieldByName('C_TCO_INI').AsString :=   'clTeal';
     CadUsuarios.FieldByName('C_TCO_FIM').AsString :=   'clwhite';
     CadUsuarios.FieldByName('I_TIT_TEX').AsInteger :=  2;
     CadUsuarios.FieldByName('I_TIT_FUN').AsInteger :=  2;
     CadUsuarios.FieldByName('C_TFO_COR').AsString :=   'clAqua';
     CadUsuarios.FieldByName('I_TFO_TAM').AsInteger :=  12;
     CadUsuarios.FieldByName('C_TFO_NOM').AsString :=   'MS Sans Serif';
     CadUsuarios.FieldByName('C_TFO_ATR').AsString :=   'fsBold;';

     CadUsuarios.FieldByName('C_SIS_COR').AsString :=   'clSilver';
     CadUsuarios.FieldByName('C_SIS_PAP').AsString :=  '';
     CadUsuarios.FieldByName('C_SIS_IMA').AsString :=  'NENHUM';
   end;
end;

{******************************Atualiza a tabela*******************************}
procedure TFNovoUsuario.CadUsuariosAfterPost(DataSet: TDataSet);
var
  VpfResultado: String;
begin
  VpfResultado:= FunUsuario.GravaDUsuarioVendedor(CadUsuariosI_COD_USU.AsInteger,VprUsuarios);
  if VpfResultado <> '' then
    aviso(VpfResultado)
  else
    Sistema.MarcaTabelaParaImportar('CADUSUARIOS');
end;

{*************************Cadastra um novo grupo*******************************}
procedure TFNovoUsuario.SpeedButton1Click(Sender: TObject);
begin
end;

{******************************************************************************}
procedure TFNovoUsuario.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFNovoUsuario.DBEditLocaliza1Cadastrar(Sender: TObject);
begin
  FRegiaoVenda := tFRegiaoVenda.CriarSDI(self,'',FPrincipal.VerificaPermisao('FRegiaoVenda'));
  FRegiaoVenda.BotaoCadastrar1.Click;
  FRegiaoVenda.Showmodal;
  FRegiaoVenda.free;
  ConsultaPadrao1.AtualizaConsulta;
end;

{******************************************************************************}
procedure TFNovoUsuario.CadUsuariosAfterScroll(DataSet: TDataSet);
begin
  AtualizaLocalizas(PanelColor1);
  ECorAgenda.Selected := CadUsuariosI_COR_AGE.AsInteger;
  if ECodigo.Text <> '' then
  begin
    FunUsuario.CarDUsuarioVendedor(CadUsuariosI_COD_USU.AsInteger,VprUsuarios);
    Grade.ADados:= VprUsuarios;
    Grade.CarregaGrade;
  end;
end;

{******************************************************************************}
procedure TFNovoUsuario.GradeCarregaItemGrade(Sender: TObject;
  VpaLinha: Integer);
begin
  VprDUsuarioVendedor:= TRBDUsuarioVendedor(VprUsuarios.Items[VpaLinha-1]);
  if VprDUsuarioVendedor.CodVendedor <> 0 then
    Grade.Cells[1,Grade.ALinha]:= IntToStr(VprDUsuarioVendedor.CodVendedor)
  else
    Grade.Cells[1,Grade.ALinha]:= '';
  Grade.Cells[2,Grade.ALinha]:= VprDUsuarioVendedor.NomVendedor;
end;

{******************************************************************************}
procedure TFNovoUsuario.GradeDadosValidos(Sender: TObject;
  var VpaValidos: Boolean);
begin
  VpaValidos:= True;

  if CadUsuarios.State <> dsBrowse then
  begin
    if not ExisteVendedor then
    begin
      aviso('VENDEDOR NÃO CADASTRADO!!!'#13'Informe um vendedor que esteja cadastrado.');
      VpaValidos:= False;
      Grade.Col:= 1;
    end;

    if VpaValidos then
    begin
      CarDClasseUsuarioVendedor;
      if VendedorJaUsado then
      begin
        aviso('VENDEDOR JÁ UTILIZADO!!!'#13'Informe um vendedor que ainda não esteja em uso.');
        VpaValidos:= False;
        Grade.Col:= 1;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFNovoUsuario.CarDClasseUsuarioVendedor;
begin
  if Grade.Cells[1,Grade.ALinha] <> '' then
    VprDUsuarioVendedor.CodVendedor:= StrToInt(Grade.Cells[1,Grade.ALinha])
  else
    VprDUsuarioVendedor.CodVendedor:= 0;
  VprDUsuarioVendedor.NomVendedor:= Grade.Cells[2,Grade.ALinha];
end;

{******************************************************************************}
function TFNovoUsuario.ExisteVendedor: Boolean;
var
  VpfNomUsuario: String;
begin
  Result:= False;
  if Grade.Cells[1,Grade.ALinha] <> '' then
  begin
    VpfNomUsuario:= FunVendedores.RNomVendedor(Grade.Cells[1,Grade.ALinha]);
    Grade.Cells[2,Grade.ALinha]:= VpfNomUsuario;
    Result:= (VpfNomUsuario <> '');
  end;
end;

{******************************************************************************}
function TFNovoUsuario.VendedorJaUsado: Boolean;
begin
  Result:= FunUsuario.VendedorJaUsado(VprDUsuarioVendedor.CodVendedor, Grade.ALinha, VprUsuarios);
end;

{******************************************************************************}
procedure TFNovoUsuario.GradeGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    1: Value:= '000000;0; ';
  end;
end;

{******************************************************************************}
procedure TFNovoUsuario.GradeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    114: case Grade.AColuna of
           1: EVendedor.AAbreLocalizacao;
         end;
  end;
end;

{******************************************************************************}
procedure TFNovoUsuario.EGrupoCadastrar(Sender: TObject);
begin
   FGrupos := TFGrupos.CriarSDI(application,'',true);
   FGrupos.ShowModal;
   consultapadrao1.Atualizaconsulta;
end;

procedure TFNovoUsuario.EVendedorRetorno(Retorno1, Retorno2: String);
begin
  if Grade.ALinha > 0 then
  begin
    Grade.Cells[1,Grade.ALinha]:= Retorno1;
    Grade.Cells[2,Grade.ALinha]:= Retorno2;
  end;
end;

{******************************************************************************}
procedure TFNovoUsuario.GradeMudouLinha(Sender: TObject; VpaLinhaAtual,
  VpaLinhaAnterior: Integer);
begin
  if VprUsuarios.Count > 0 then
    VprDUsuarioVendedor:= TRBDUsuarioVendedor(VprUsuarios.Items[VpaLinhaAtual-1]);
end;

{******************************************************************************}
procedure TFNovoUsuario.GradeNovaLinha(Sender: TObject);
begin
  VprDUsuarioVendedor:= TRBDUsuarioVendedor.Cria;
  VprUsuarios.Add(VprDUsuarioVendedor);
end;

{******************************************************************************}
procedure TFNovoUsuario.GradeSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if Grade.AEstadoGrade in [egInsercao,EgEdicao] then
    if Grade.AColuna <> ACol then
    begin
      case Grade.AColuna of
        1: if not ExisteVendedor then
             if not EVendedor.AAbreLocalizacao then
             begin
               Grade.Cells[1,Grade.ALinha]:= '';
               Grade.Cells[2,Grade.ALinha]:= '';
               Abort;
             end;
      end;
    end;
end;

{******************************************************************************}
procedure TFNovoUsuario.NomeChange(Sender: TObject);
begin
  if CADUSUARIOS <> nil then
    if CadUsuarios.state in [dsinsert,dsedit] then
      ValidaGravacao1.execute;
end;

procedure TFNovoUsuario.RBDBEditLocaliza1Cadastrar(Sender: TObject);
begin
  FCampanhaVendas := TFCampanhaVendas.criarSDI(Application,'',FPrincipal.VerificaPermisao('FCampanhaVendas'));
  FCampanhaVendas.showmodal;
  FCampanhaVendas.free;
end;

Initialization
  RegisterClasses([TFNovoUsuario]);

end.
