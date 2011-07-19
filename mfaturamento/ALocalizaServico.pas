unit ALocalizaServico;
{          Autor: Rafael Budag
    Data Criação: 16/04/1999;
          Função: Gerar um orçamento

    Motivo alteração:
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Localizacao, StdCtrls, Buttons, Componentes1, Db, DBTables, ExtCtrls,
  PainelGradiente, DBGrids, Tabela, DBCtrls, Mask, UnDados, UnClassificacao,
  numericos, LabelCorMove, CheckLst, BotaoCadastro, DBKeyViolation, Grids,
  unDadosProduto, FMTBcd, SqlExpr, DBClient;

type
  TFlocalizaServico = class(TFormularioPermissao)
    CadServico: TSQL;
    PanelColor2: TPanelColor;
    PanelColor5: TPanelColor;
    Label3: TLabel;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    LDesClassificacao: TLabel;
    CProAti: TCheckBox;
    PanelColor16: TPanelColor;
    ENomeServico: TEditColor;
    GProdutos: TGridIndice;
    DBMemoColor1: TDBMemoColor;
    PainelGradiente1: TPainelGradiente;
    BOk: TBitBtn;
    BCancelar: TBitBtn;
    BotaoCadastrar1: TBitBtn;
    CadServicoI_COD_SER: TFMTBCDField;
    CadServicoC_NOM_SER: TWideStringField;
    CadServicoN_VLR_VEN: TFMTBCDField;
    CadServicoC_Nom_Moe: TWideStringField;
    CadServicoL_OBS_SER: TWideStringField;
    DataCadServico: TDataSource;
    EClassificacao: TEditColor;
    Aux: TSQLQuery;
    CadServicoN_PER_ISS: TFMTBCDField;
    CadServicoC_COD_CLA: TWideStringField;
    CadServicoN_PER_COM: TFMTBCDField;
    CadServicoI_COD_EMP: TFMTBCDField;
    CadServicoI_COD_FIS: TFMTBCDField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CProAtiClick(Sender: TObject);
    procedure EClassificacaoRetorno(Retorno1, Retorno2: String);
    procedure ENomeProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BOkClick(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure BotaoCadastrar1Click(Sender: TObject);
    procedure EClassificacaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ENomeServicoEnter(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure EClassificacaoExit(Sender: TObject);
    procedure GProdutosEnter(Sender: TObject);
    procedure GProdutosExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    Cadastrou : Boolean;
    VprAcao : boolean;
    FunClassificacao: TFuncoesClassificacao;
    procedure AtualizaConsulta;
    procedure AdicionaFiltrosProduto(VpaSelect : TStrings);
    function LocalizaClassificacao: Boolean;
    function ExisteClassificacao: Boolean;
  public
    procedure ConsultaServico;
    function LocalizaServico( var VpaCadastrou : Boolean; var VpaCodServico : integer; Var VpaValorVenda :Double; Var VpaPerISSQN : Double ) : boolean; overload;
    function LocalizaServico( var VpaCadastrou : Boolean; var VpaCodServico : integer; var VpaNomServico : string; Var VpaValorVenda, VpaPerISSQN : Double ) : boolean; overload;
    function LocalizaServico(VpaDServicoNota : TRBDNotaFiscalServico ) : boolean; overload;
    function LocalizaServico(VpaDServicoNota : TRBDNotaFiscalForServico ) : boolean; overload;
    function LocalizaServico(VpaDServicoContrato : TRBDContratoServico ) : boolean; overload;
    function LocalizaServico(VpaDServicoCotacao : TRBDOrcServico) : boolean;overload;
    function LocalizaServico(VpaDServicoExecutado: TRBDChamadoServicoExecutado): Boolean; overload;
    function LocalizaServico(VpaDServicoOrcado: TRBDChamadoServicoOrcado): Boolean; overload;
    function LocalizaServico(VpaDServicoAmostra : TRBDServicoFixoAmostra):boolean;overload;
  end;

var
  FlocalizaServico: TFlocalizaServico;

implementation

uses APrincipal, Constantes,ConstMsg, ALocalizaClassificacao, FunSql,
  ANovoServico, UnSistema;
{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFlocalizaServico.FormCreate(Sender: TObject);
begin
  FunClassificacao:= TFuncoesClassificacao.criar(Self,FPrincipal.BaseDados);
  AtualizaConsulta;
  CadServicoN_VLR_VEN.EditFormat:= Varia.MascaraValor;
  CadServicoN_VLR_VEN.DisplayFormat:= Varia.MascaraValor;
  Cadastrou:= False;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFlocalizaServico.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FunClassificacao.Free;
  Action:= CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                               eventos do filtro superior
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{**************** chama a rotina para atualizar a consulta ********************}
procedure TFlocalizaServico.EClassificacaoRetorno(Retorno1,
  Retorno2: String);
begin
  AtualizaConsulta;
end;

{*************Chama a Rotina para atualizar a select dos produtos**************}
procedure TFlocalizaServico.CProAtiClick(Sender: TObject);
begin
  AtualizaConsulta;
  BOk.Default := true;
end;

{************ se for pressionado enter atualiza a consulta ********************}
procedure TFlocalizaServico.ENomeProdutoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    13: AtualizaConsulta;
    VK_UP: begin
             ActiveControl:= EClassificacao;
           end;
    VK_DOWN: begin
               ActiveControl:= GProdutos;
             end;
  end;
end;

{******************* verifica as teclas pressionadas **************************}
procedure TFlocalizaServico.EClassificacaoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    13: if ExisteClassificacao then
          AtualizaConsulta
        else
          if LocalizaClassificacao then
            AtualizaConsulta;
    VK_DOWN: ActiveControl:= ENomeServico;
    VK_F3: LocalizaClassificacao;
  end;
end;

{******************* tira o botao fechar como default *************************}
procedure TFlocalizaServico.ENomeServicoEnter(Sender: TObject);
begin
  BOk.Default:= False;
end;

{********************* localiza as classificacoes *****************************}
Function TFlocalizaServico.LocalizaClassificacao : Boolean;
Var
  VpfCodClassificacao, VpfNomClassificacao : String;
begin
  FLocalizaClassificacao := TFLocalizaClassificacao.CriarSDI(application,'', true);
  Result:= FLocalizaClassificacao.LocalizaClassificacao(VpfCodClassificacao,VpfNomClassificacao,'S');

  if Result then
  begin
    EClassificacao.Text := VpfCodClassificacao;
    LDesClassificacao.Caption  := VpfNomClassificacao;
    AtualizaConsulta;
  end;
  FLocalizaClassificacao.free;
end;

{****************** verifica se existe a classificacao ************************}
function TFlocalizaServico.ExisteClassificacao : Boolean;
var
  VpfNomClassificacao: String;
begin
  // verificar se posso fazer desta forma
  VpfNomClassificacao:= FunClassificacao.RetornaNomeClassificacao(EClassificacao.Text,'S');
  Result:= (VpfNomClassificacao <> '');

  LDesClassificacao.Caption:= VpfNomClassificacao;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         ações da consulta do Servico
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{****************** atualiza a consulta dos produtos **************************}
procedure TFlocalizaServico.AtualizaConsulta;
begin
  CadServico.Close;
  CadServico.sql.clear;
  CadServico.sql.add('Select ' +
                     ' SER.I_COD_SER, SER.I_COD_EMP, SER.C_NOM_SER, SER.L_OBS_SER, SER.N_PER_ISS, ' +
                     ' SER.I_COD_FIS, '+
                     ' (PRE.N_VLR_VEN * MOE.N_Vlr_Dia) N_VLR_VEN, ' +
                     ' Moe.C_Nom_Moe,  ' +
                     ' CLA.C_COD_CLA, CLA.N_PER_COM '+
                     ' from CadServico Ser, MovTabelaPrecoServico Pre, ' +
                     ' CadMoedas Moe, CADCLASSIFICACAO CLA');
  AdicionaFiltrosProduto(CadServico.Sql);
  CadServico.sql.add(' and Pre.I_Cod_Emp = Ser.I_Cod_Emp '+
                     ' and Pre.I_Cod_Ser = Ser.I_Cod_Ser '+
                     ' and Moe.I_Cod_Moe = Pre.I_Cod_Moe' +
                     ' and SER.I_COD_EMP = CLA.I_COD_EMP '+
                     ' and SER.C_COD_CLA = CLA.C_COD_CLA '+
                     ' and SER.C_TIP_CLA = CLA.C_TIP_CLA '+
                     ' order by c_nom_ser ');
  GravaEstatisticaConsulta(nil,CadServico,varia.CodigoUsuario,Self.name,NomeModulo,config.UtilizarPercentualConsulta);
  CadServico.Open;
end;

{******************* adiciona os filtros da consulta **************************}
procedure TFlocalizaServico.AdicionaFiltrosProduto(VpaSelect : TStrings);
begin
  VpaSelect.add('Where Ser.I_Cod_Emp = ' + inttostr(Varia.CodigoEmpresa));

  if ENomeServico.text <> '' Then
    VpaSelect.Add('and Ser.C_Nom_Ser like '''+ENomeServico.text +'%''');

  if EClassificacao.text <> ''Then
    VpaSelect.add(' and Ser.C_Cod_Cla like '''+ EClassificacao.text+ '%''');

  if CProAti.Checked then
    VpaSelect.add(' and Ser.C_Ati_Ser = ''S''');

  VpaSelect.Add(' and Pre.I_Cod_Tab = ' + IntToStr(Varia.TabelaPrecoServico));
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                             eventos dos botoes inferiores
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{*********************** fecha o formulario ***********************************}
procedure TFlocalizaServico.BOkClick(Sender: TObject);
begin
  VprAcao := true;
  self.close;
end;

{*********************** Cancela a consulta ***********************************}
procedure TFlocalizaServico.BCancelarClick(Sender: TObject);
begin
  VprAcao:= false;
  self.close;
end;

{******************** cadastra um novo servico ********************************}
procedure TFlocalizaServico.BotaoCadastrar1Click(Sender: TObject);
var
  VpfCodClassificacao, VpfNomClassificacao : String;
begin
  FNovoServico:= TFNovoServico.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoServico'));
  Cadastrou:= FNovoServico.InsereNovoServico('',VpfCodClassificacao,VpfNomClassificacao,true);
  if Cadastrou then
    AtualizaConsulta;
  FNovoServico.Free;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                 eventos diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************** consulta o servico ************************************}
procedure TFlocalizaServico.ConsultaServico;
begin
  ShowModal;
end;

{ ********************** chamada externa da localizacao de servicos ********** }
function TFlocalizaServico.LocalizaServico( var VpaCadastrou: Boolean; var VpaCodServico : integer; Var VpaValorVenda : Double;var VpaPerISSQN : Double ) : boolean;
begin
  BotaoCadastrar1.Visible:= VpaCadastrou;
  ShowModal;
  Result:= VprAcao;
  VpaCadastrou:= Cadastrou;
  if CadServico.IsEmpty then
    Result:= False;
  if VprAcao then
  begin
    VpaCodServico:= CadServicoI_COD_SER.AsInteger;
    VpaValorVenda:= CadServicoN_VLR_VEN.AsFloat;
    VpaPerISSQN:= CadServicoN_PER_ISS.AsFloat;
  end;
end;

{ ********************** chamada externa da localizacao de produtos ********** }
function TFlocalizaServico.LocalizaServico( var VpaCadastrou : Boolean; var VpaCodServico : integer; var VpaNomServico : string; Var VpaValorVenda, VpaPerISSQN : Double ) : boolean;
begin
  Result:= LocalizaServico(VpaCadastrou,VpaCodServico,VpaValorVenda,vpaPerISSQN);
  VpaCadastrou:= Cadastrou;
  if Result then
    VpaNomServico := CadServicoC_NOM_SER.AsString
  else
    VpaNomServico := '';
end;

{******************************************************************************}
function TFlocalizaServico.LocalizaServico(VpaDServicoNota : TRBDNotaFiscalServico ) : boolean;
begin
  ShowModal;
  Result:= VprAcao;
  if CadServico.IsEmpty then
    Result:= False;
  if VprAcao then
  begin
    VpaDServicoNota.CodServico := CadServicoI_COD_SER.AsInteger;
    VpaDServicoNota.ValUnitario := CadServicoN_VLR_VEN.AsFloat;
    if CadServicoN_PER_ISS.AsFloat > 0 then
      VpaDServicoNota.PerISSQN := CadServicoN_PER_ISS.AsFloat
    else
      VpaDServicoNota.PerISSQN := varia.ISSQN;
    VpaDServicoNota.CodClassificacao := CadServicoC_COD_CLA.AsString;
    VpaDServicoNota.PerComissaoClassificacao := CadServicoN_PER_COM.AsFloat;
    VpaDServicoNota.NomServico := CadServicoC_NOM_SER.AsString;
    VpaDServicoNota.CodFiscal := CadServicoI_COD_FIS.AsInteger;
  end;
end;

{******************************************************************************}
function TFlocalizaServico.LocalizaServico(VpaDServicoCotacao : TRBDOrcServico) : boolean;
begin
  ShowModal;
  Result:= VprAcao;
  if CadServico.IsEmpty then
    Result:= false;
  if VprAcao then
  begin
    VpaDServicoCotacao.CodServico := CadServicoI_COD_SER.AsInteger;
    VpaDServicoCotacao.ValUnitario := CadServicoN_VLR_VEN.AsFloat;
    VpaDServicoCotacao.PerISSQN := CadServicoN_PER_ISS.AsFloat;
    VpaDServicoCotacao.CodClassificacao := CadServicoC_COD_CLA.AsString;
    VpaDServicoCotacao.PerComissaoClassificacao := CadServicoN_PER_COM.AsFloat;
    VpaDServicoCotacao.NomServico := CadServicoC_NOM_SER.AsString;
    VpaDServicoCotacao.CodFiscal := CadServicoI_COD_FIS.AsInteger;
  end;
end;

{************************** localiza a classificacao **************************}
procedure TFlocalizaServico.SpeedButton1Click(Sender: TObject);
begin
  LocalizaClassificacao;
end;

{***************** valida a classificacao digitada ****************************}
procedure TFlocalizaServico.EClassificacaoExit(Sender: TObject);
begin
  LDesClassificacao.Caption:= '';
  if EClassificacao.Text <> '' then
    if not ExisteClassificacao Then
      if not LocalizaClassificacao then
      begin
        EClassificacao.Text:= '';
        LDesClassificacao.Caption:= '';
        ActiveControl:= EClassificacao;
      end;
  AtualizaConsulta;
end;

{********************** quando entra nos servicos *****************************}
procedure TFlocalizaServico.GProdutosEnter(Sender: TObject);
begin
  BOk.Default:= true;
end;

{********************* quando sai da grade ************************************}
procedure TFlocalizaServico.GProdutosExit(Sender: TObject);
begin
  BOk.Default:= false;
end;

{******************************************************************************}
procedure TFlocalizaServico.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_DOWN: begin
               ActiveControl:= GProdutos;
               CadServico.Next;
             end;
    VK_UP: begin
             ActiveControl:= GProdutos;
             CadServico.Prior;
           end;
  end;
end;

{******************************************************************************}
function TFlocalizaServico.LocalizaServico(VpaDServicoExecutado: TRBDChamadoServicoExecutado): Boolean;
begin
  ShowModal;
  Result:= VprAcao;
  if CadServico.IsEmpty then
    Result:= False;
  if VprAcao then
  begin
    VpaDServicoExecutado.CodServico:= CadServicoI_COD_SER.AsInteger;
    VpaDServicoExecutado.ValUnitario:= CadServicoN_VLR_VEN.AsFloat;
    VpaDServicoExecutado.CodEmpresaServico:= CadServicoI_COD_EMP.AsInteger;
    VpaDServicoExecutado.NomServico:= CadServicoC_NOM_SER.AsString;
    VpaDServicoExecutado.Quantidade := 1;
  end;
end;

{******************************************************************************}
function TFlocalizaServico.LocalizaServico(VpaDServicoOrcado: TRBDChamadoServicoOrcado): Boolean;
begin
  ShowModal;
  Result:= VprAcao;
  if CadServico.IsEmpty then
    Result:= False;
  if VprAcao then
  begin
    VpaDServicoOrcado.CodServico:= CadServicoI_COD_SER.AsInteger;
    VpaDServicoOrcado.ValUnitario:= CadServicoN_VLR_VEN.AsFloat;
    VpaDServicoOrcado.CodEmpresaServico:= CadServicoI_COD_EMP.AsInteger;
    VpaDServicoOrcado.NomServico:= CadServicoC_NOM_SER.AsString;
    VpaDServicoOrcado.QtdServico := 1;
  end;
end;

{******************************************************************************}
function TFlocalizaServico.LocalizaServico(VpaDServicoAmostra : TRBDServicoFixoAmostra):boolean;
begin
  ShowModal;
  Result:= VprAcao;
  if CadServico.IsEmpty then
    Result:= False;
  if VprAcao then
  begin
    VpaDServicoAmostra.CodServico:= CadServicoI_COD_SER.AsInteger;
    VpaDServicoAmostra.ValUnitario:= CadServicoN_VLR_VEN.AsFloat;
    VpaDServicoAmostra.CodEmpresaServico:= CadServicoI_COD_EMP.AsInteger;
    VpaDServicoAmostra.NomServico:= CadServicoC_NOM_SER.AsString;
    VpaDServicoAmostra.QtdServico := 1;
  end;
end;

{******************************************************************************}
function TFlocalizaServico.LocalizaServico(VpaDServicoContrato: TRBDContratoServico): boolean;
begin
  ShowModal;
  Result:= VprAcao;
  if CadServico.IsEmpty then
    Result:= False;
  if VprAcao then
  begin
    VpaDServicoContrato.CodServico := CadServicoI_COD_SER.AsInteger;
    VpaDServicoContrato.ValUnitario := CadServicoN_VLR_VEN.AsFloat;
    VpaDServicoContrato.PerISSQN := CadServicoN_PER_ISS.AsFloat;
    VpaDServicoContrato.CodClassificacao := CadServicoC_COD_CLA.AsString;
    VpaDServicoContrato.NomServico := CadServicoC_NOM_SER.AsString;
    VpaDServicoContrato.CodFiscal := CadServicoI_COD_FIS.AsInteger;
  end;
end;

{******************************************************************************}
function TFlocalizaServico.LocalizaServico(VpaDServicoNota: TRBDNotaFiscalForServico): boolean;
begin
  ShowModal;
  Result:= VprAcao;
  if CadServico.IsEmpty then
    Result:= False;
  if VprAcao then
  begin
    VpaDServicoNota.CodServico := CadServicoI_COD_SER.AsInteger;
    VpaDServicoNota.ValUnitario := CadServicoN_VLR_VEN.AsFloat;
    VpaDServicoNota.PerISSQN := CadServicoN_PER_ISS.AsFloat;
    VpaDServicoNota.CodClassificacao := CadServicoC_COD_CLA.AsString;
    VpaDServicoNota.NomServico := CadServicoC_NOM_SER.AsString;
    VpaDServicoNota.CodFiscal := CadServicoI_COD_FIS.AsInteger;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFlocalizaServico]);
end.
