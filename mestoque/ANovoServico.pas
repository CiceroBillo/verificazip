unit ANovoServico;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Mask, DBCtrls, Tabela, Db, BotaoCadastro, Buttons,
  DBTables, Grids, DBGrids, Componentes1, formularios, PainelGradiente,
  DBKeyViolation, LabelCorMove, Localizacao, EditorImagem, UnProdutos, UnClassificacao,
  numericos, UnServicos, DBClient, unSistema;

type
  TFNovoServico = class(TFormularioPermissao)
    DataServico: TDataSource;
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    Localiza: TConsultaPadrao;
    ValidaGravacao1: TValidaGravacao;
    PanelColor1: TPanelColor;
    Label4: TLabel;
    CodigoFil: TDBEditColor;
    Label1: TLabel;
    Label3: TLabel;
    Descricao: TDBEditColor;
    Label6: TLabel;
    ECodClassificacao: TDBEditColor;
    BCla: TSpeedButton;
    LCla: TLabel;
    CadServico: TSQL;
    CadServicoI_COD_SER: TFMTBCDField;
    CadServicoC_NOM_SER: TWideStringField;
    CadServicoI_COD_EMP: TFMTBCDField;
    CadServicoC_COD_CLA: TWideStringField;
    CadServicoC_TIP_CLA: TWideStringField;
    CadServicoL_OBS_SER: TWideStringField;
    CadServicoC_ATI_SER: TWideStringField;
    Label2: TLabel;
    DBMemoColor1: TDBMemoColor;
    BGravar: TBitBtn;
    BCancelar: TBitBtn;
    BFechar: TBitBtn;
    CadServicoD_ULT_ALT: TSQLTimeStampField;
    CadServicoN_PER_ISS: TFMTBCDField;
    DBEditNumerico1: TDBEditNumerico;
    Label7: TLabel;
    ECodigo: TDBKeyViolation;
    CadServicoI_COD_FIS: TFMTBCDField;
    CAtivo: TDBCheckBox;
    Label5: TLabel;
    DBEditNumerico2: TDBEditNumerico;
    Label8: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBEditLocaliza1Change(Sender: TObject);
    procedure BClaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ECodClassificacaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BFecharClick(Sender: TObject);
    procedure CadServicoAfterInsert(DataSet: TDataSet);
    procedure CadServicoAfterEdit(DataSet: TDataSet);
    procedure CadServicoBeforePost(DataSet: TDataSet);
    procedure BGravarClick(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure DBEditColor1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CadServicoAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
    VprDescricao, VprCodigo : String;
    UnCla : TFuncoesClassificacao;
    Servicos : TFuncoesServico;
    VprInseriu : Boolean;
    function LocalizaClassificacao : Boolean;
  public
    function InsereNovoServico(VpaCodClassificacao: string;var VpaCodServico, VpaDescricao : string; ChamadaExterna: Boolean): Boolean;
    function AlteraServico(VpaCodClassificacao : String; var VpaCodServico, VpaDescricao : string; VpaAlterar: Boolean): Boolean;
  end;

var
  FNovoServico: TFNovoServico;

implementation

uses APrincipal, FunSql, funObjeto, constantes, ConstMsg,
     ALocalizaClassificacao;

{$R *.DFM}


{**********************ocorre na criação do formulario*************************}
procedure TFNovoServico.FormCreate(Sender: TObject);
begin
  UnCla := TFuncoesClassificacao.criar(self, FPrincipal.BaseDados);
  Servicos := TFuncoesServico.Cria(FPrincipal.BaseDados);
  InicializaVerdadeiroeFalsoCheckBox(PanelColor1,'S','N');
  AdicionaSQLAbreTabela(CadSErvico,'Select * from Cadservico '+
                                  ' WHERE I_COD_EMP = 1 AND I_COD_SER = 1');
end;

{********************ocorre quando o formulario é fechado**********************}
procedure TFNovoServico.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  CAdServico.Close;
  Action := Cafree;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações de camadas externas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************** inseri um novo servico ********************************}
function TFNovoServico.InsereNovoServico(VpaCodClassificacao: string;var VpaCodServico, VpaDescricao : string; ChamadaExterna: Boolean): Boolean;
begin
  try
    // carrega a mascara da classificacao
    ECodClassificacao.Field.EditMask := RetornaPicture(varia.mascaraCLASer, VpaCodClassificacao, '_');

    CadServico.Insert;
    BCla.Enabled := ChamadaExterna;
    ECodClassificacao.Enabled := ChamadaExterna;

    CadServicoC_COD_CLA.Value := VpaCodClassificacao;
    if not ChamadaExterna then
       LCla.Caption := UnCla.RetornaNomeClassificacao(VpaCodClassificacao,'S');

    if  ShowModal = MrOK Then
    begin
      VpaCodServico := VprCodigo;
      VpaDescricao  := VprDescricao;
      Result := True;
    end
    else
      result  := false;
  except
    Result := False;
    Aviso('Erro na inclusão do serviço.');
    CadServico.Cancel;
  end;
end;

{***************** altera o servico passado como parametro ********************}
function TFNovoServico.AlteraServico(VpaCodClassificacao : String; var VpaCodServico, VpaDescricao : string; VpaAlterar: Boolean): Boolean;
begin
  try
    ECodClassificacao.Field.EditMask := RetornaPicture(varia.mascaraCLASer, VpaCodClassificacao, '_');
    LCla.Caption := UnCla.RetornaNomeClassificacao(VpaCodClassificacao,'S');

    AdicionaSQLAbreTabela(CadServico,'Select * from CadServico ' +
                                     ' Where I_Cod_Emp = ' + IntToStr(Varia.CodigoEmpresa) +
                                     ' and I_Cod_Ser = ' + VpaCodServico);
    if not CadServico.Eof then
    begin
      if VpaAlterar then
      begin
        ActiveControl := Descricao;
        CadServico.Edit;
        if ShowModal =  mrOk Then
        begin
          VpaCodServico := VprCodigo;
          VpaDescricao := VprDescricao;
          Result := True;
        end
        else
        result := false;
      end
      else
      begin
        Descricao.Enabled := False;
        BGravar.Enabled := false;
        BCancelar.Enabled := False;
        ShowModal;
        Result := False;
      end;
    end
    else
    begin
      Aviso('Não foi possível localizar este serviço.');
      Result := False;
      Close;
    end;
  except
    Result := False;
    Aviso('Erro na alteração do serviço.');
    CadServico.Cancel;
  end;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            eventos da tabela servico
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{************** apo o evento de insercao da tabela de servico *****************}
procedure TFNovoServico.CadServicoAfterInsert(DataSet: TDataSet);
begin
  ECodigo.ProximoCodigo;
  CadServicoI_COD_EMP.AsInteger := Varia.CodigoEmpresa;
  CadServicoC_TIP_CLA.AsString := 'S';
  CadServicoC_Ati_Ser.Asstring := 'S';
  ECodigo.ReadOnly := false;
  VprInseriu := true;
end;

{**************** nao permite alterar o codigo da classificacao ***************}
procedure TFNovoServico.CadServicoAfterEdit(DataSet: TDataSet);
begin
  ECodigo.ReadOnly := true;
  VprInseriu := false;
end;

{*********************** eventos antes de gravar ******************************}
procedure TFNovoServico.CadServicoBeforePost(DataSet: TDataSet);
begin
  CadServicoD_ULT_ALT.AsDateTime := Sistema.RDataServidor;
  // guarda a descricao porque depois de gravado o registro é perdido
  VprDescricao := CadServicoC_Nom_Ser.Asstring;
  VprCodigo := CadServicoI_Cod_Ser.Asstring;
  if CadServico.State = dsinsert then
    ECodigo.VerificaCodigoUtilizado;
  Sistema.MarcaTabelaParaImportar('CADSERVICO');
end;

{******************* eventos apos a gravacao da tabela ************************}
procedure TFNovoServico.CadServicoAfterPost(DataSet: TDataSet);
begin
  if VprInseriu then
    Servicos.AdicionaServicoNaTabelaPreco(CadServicoI_cod_Ser.AsInteger,varia.MoedaBase,
                                           varia.TabelaPrecoServico, 0, CurrencyString );

end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              eventos da classificacao
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{************************ localiza a classificacao ****************************}
procedure TFNovoServico.ECodClassificacaoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = 114 then
    LocalizaClassificacao;
end;

{************* abre a localizacao das classificacao ************************* }
function TFNovoServico.LocalizaClassificacao : Boolean;
var
  VpfCodClassificacao, VpfDescricao : string;
begin
  result := true;
  FLocalizaClassificacao := TFLocalizaClassificacao.CriarSDI(application,'', true);
  if FLocalizaClassificacao.LocalizaClassificacao(VpfCodClassificacao, VpfDescricao, 'S') then
  begin
    CadServicoC_COD_CLA.AsString := VpfCodClassificacao;
    LCla. Caption := VpfDescricao;
  end
  else
    result := false;
end;

{******************* chama a localizacao da classificacao *********************}
procedure TFNovoServico.BClaClick(Sender: TObject);
begin
  LocalizaClassificacao;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                    eventos dos botoes inferiores
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{************************* fecha o formulario *********************************}
procedure TFNovoServico.BFecharClick(Sender: TObject);
begin
  close;
end;

{************************* grava o servico ************************************}
procedure TFNovoServico.BGravarClick(Sender: TObject);
begin
  CadServico.post;
end;

{************-************* cancela o servico ********************************}
procedure TFNovoServico.BCancelarClick(Sender: TObject);
begin
  CadServico.cancel;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                 eventos diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************** quando o formulario é mostrado **************************}
procedure TFNovoServico.FormShow(Sender: TObject);
begin
  if ECodClassificacao.Enabled then
    ECodClassificacao.SetFocus
  else
    if not ECodigo.ReadOnly Then
      ECodigo.SetFocus;
end;

{****************************Valida a gravacao*********************************}
procedure TFNovoServico.DBEditLocaliza1Change(Sender: TObject);
begin
  if CadServico.State in [ dsInsert, dsEdit ] then
     ValidaGravacao1.execute;
end;

procedure TFNovoServico.DBEditColor1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if not(key in [78,83,8,9,46]) Then
    key := 0
end;

end.
