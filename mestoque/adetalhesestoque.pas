unit ADetalhesEstoque;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Grids, DBGrids, Tabela, UnDadosProduto,
  DBKeyViolation, StdCtrls, Localizacao, Buttons, Db, DBTables, ComCtrls, UnNotaFiscal,
  DBClient;

type
  TFDetalhesEstoque = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    PanelColor3: TPanelColor;
    Label11: TLabel;
    SpeedButton1: TSpeedButton;
    Label12: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    RData: TRadioButton;
    RDataUnidade: TRadioButton;
    RMes: TRadioButton;
    RMesUnidade: TRadioButton;
    ROperacao: TRadioButton;
    ROperacaoUnidade: TRadioButton;
    RNenhum: TRadioButton;
    EditLocaliza1: TEditLocaliza;
    Grade: TGridIndice;
    Estoque: TSQL;
    DataEstoque: TDataSource;
    AtiPro: TCheckBox;
    Data1: TCalendario;
    Data2: TCalendario;
    Localiza: TConsultaPadrao;
    BFechar: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    BNota: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RNenhumClick(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure EditLocaliza1Retorno(Retorno1, Retorno2: String);
    procedure BNotaClick(Sender: TObject);
  private
    CodigoProduto, CodigoFilial, TipoItem : string;
    TipoMov : char;
    procedure GeraEstoqueProduto( CodigoProduto, CodigoFilial, TipoItem : string; TipoMovimento : char );
  public
    procedure MostraDetalhes( CodigoProduto, CodigoFilial, TipoItem : string; TipoMovimento : char );
  end;

var
  FDetalhesEstoque: TFDetalhesEstoque;

implementation

uses APrincipal, fundata, constantes, funObjeto, constMsg, funstring, funsql,
  ANovaNotaFiscalNota;


{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFDetalhesEstoque.FormCreate(Sender: TObject);
begin
  data1.date := PrimeiroDiaMes(date);
  data2.date := UltimoDiaMes(date);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFDetalhesEstoque.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 { fecha tabelas }
 { chamar a rotina de atualização de menus }
 Action := CaFree;
end;

{************* gera estoque dos produtos ************************************ }
procedure TFDetalhesEstoque.GeraEstoqueProduto( CodigoProduto, CodigoFilial, TipoItem : string;  TipoMovimento : char );
var
  VpaCampos, VpaGrupo : string;
begin
  MudaVisibleTodasColunasGrid( Grade, true );
  if RNenhum.Checked then
  begin
    VpaCampos := ' pro.c_nom_pro, mov.c_cod_uni, mov.n_qtd_mov, mov.n_vlr_mov, ' +
                 ' op.c_nom_ope, mov.d_dat_mov, mov.c_tip_mov, mov.i_nro_not, mov.i_not_sai, mov.i_not_ent, ' +
                 ' decode(mov.n_qtd_mov,null,0, mov.n_vlr_mov / mov.n_qtd_mov)  ValorMedio';
    VpaGrupo := ' ';
  end
  else
    if RData.Checked then
    begin
      VpaCampos := ' mov.d_dat_mov, sum(mov.n_vlr_mov) n_vlr_mov, ' +
                   ' sum(n_qtd_mov) n_qtd_mov, '+
                   ' decode(sum(n_qtd_mov),null,0, sum(n_vlr_mov) / sum(n_qtd_mov)) ValorMedio ';
      VpaGrupo := 'group by mov.d_dat_mov order by mov.d_dat_mov';
      MudaVisibleDetColunasGrid(Grade, [0,1,3,7,8], false);
    end
    else
      if RDataUnidade.Checked then
      begin
        VpaCampos := ' mov.d_dat_mov, sum(mov.n_vlr_mov) n_vlr_mov, sum(n_qtd_mov) n_qtd_mov,  pro.c_cod_uni, ' +
                     ' decode(sum(n_qtd_mov),NULL,0, sum(n_vlr_mov) / sum(n_qtd_mov)) ValorMedio ';
        VpaGrupo := ' group by mov.d_dat_mov, pro.c_cod_uni order by mov.d_dat_mov';
        MudaVisibleDetColunasGrid(Grade, [0,1,7,8], false);
      end
      else
        if RMes.Checked then
        begin
          VpaCampos :=  SQLTextoMes('mov.d_dat_mov')+' d_dat_mov, sum(mov.n_vlr_mov) n_vlr_mov, sum(n_qtd_mov) n_qtd_mov, ' +
                       ' decode(sum(n_qtd_mov),NULL,0, sum(n_vlr_mov) / sum(n_qtd_mov)) ValorMedio';
          VpaGrupo := ' group by '+SQLTextoMes('mov.d_dat_mov')+' order by '+SQLTextoMes('mov.d_dat_mov');
          MudaVisibleDetColunasGrid(Grade, [0,1,3,7,8], false);
        end
        else
          if RMesUnidade.Checked then
          begin
            VpaCampos := SQLTextoMes('mov.d_dat_mov')+' d_dat_mov, sum(mov.n_vlr_mov) n_vlr_mov, sum(n_qtd_mov) n_qtd_mov, pro.c_cod_uni, ' +
                         ' decode(sum(n_qtd_mov),NULL,0, sum(n_vlr_mov) / sum(n_qtd_mov)) ValorMedio ';
            VpaGrupo := ' group by '+SQLTextoMes('mov.d_dat_mov')+', pro.c_cod_uni order by '+SQLTextoMes('mov.d_dat_mov');
            MudaVisibleDetColunasGrid(Grade, [0,1,7,8], false);
          end
          else
            if ROperacao.Checked then
            begin
              VpaCampos := ' mov.i_cod_ope,  op.c_nom_ope, mov.c_tip_mov, sum(mov.n_vlr_mov) n_vlr_mov, sum(n_qtd_mov) n_qtd_mov, ' +
                           ' decode(sum(n_qtd_mov),NULL,0, sum(n_vlr_mov) / sum(n_qtd_mov)) ValorMedio ';
              VpaGrupo := ' group by mov.i_cod_ope, op.c_nom_ope, mov.c_tip_mov order by (op.c_nom_ope)';
              MudaVisibleDetColunasGrid(Grade, [0,2,3,8], false);
            end
            else
              if ROperacaoUnidade.Checked then
              begin
                VpaCampos := ' mov.i_cod_ope,  op.c_nom_ope, mov.c_tip_mov, sum(mov.n_vlr_mov) n_vlr_mov, sum(n_qtd_mov) n_qtd_mov, pro.c_cod_uni, ' +
                             ' decode(sum(n_qtd_mov),NULL,0, sum(n_vlr_mov) / sum(n_qtd_mov)) ValorMedio ';
                VpaGrupo := ' group by mov.i_cod_ope, op.c_nom_ope, mov.c_tip_mov, pro.c_cod_uni order by (op.c_nom_ope)';
                MudaVisibleDetColunasGrid(Grade, [0,2,8], false);
               end;


  LimpaSQLTabela(estoque);
  AdicionaSQLTabela(Estoque,'select ');
  AdicionaSQLTabela(Estoque,VpaCampos);
  AdicionaSQLTabela(Estoque,'from MovEstoqueProdutos  MOV, cadOperacaoEstoque OP, CadProdutos PRO ' +
                            ' where MOV.I_COD_OPE = OP.I_COD_OPE ' +
                            ' and PRO.I_SEQ_PRO = MOV.I_SEQ_PRO ');

  if (StrToInt(CodigoFilial) > 10 ) then
    AdicionaSQLTabela(Estoque,' and MOV.I_EMP_FIL = ' + CodigoFilial );


  if (TipoItem = 'PA') and (CodigoProduto <> '') then
     AdicionaSQLTabela(Estoque,' and MOV.I_SEQ_PRO = ' + CodigoProduto )
  else
    if TipoItem = 'CL' then
      AdicionaSQLTabela(Estoque,' and PRO.C_COD_CLA like ''' + CodigoProduto + '%''');

    if AtiPro.Checked then
       estoque.sql.add(' and PRO.C_ATI_PRO = ''S''');

  case TipoMovimento of
   'S' : estoque.sql.add(' and MOV.C_TIP_MOV = ''S'' ');
   'E' : estoque.sql.add(' and MOV.C_TIP_MOV = ''E'' ');
   'T' : estoque.sql.add(' and MOV.C_TIP_MOV = ''T'' ');
  end;

  if EditLocaliza1.Text <> '' then
    estoque.sql.add(' and MOV.I_COD_OPE = ' + EditLocaliza1.Text);

  Estoque.sql.add(SQLTextoDataEntreAAAAMMDD('MOV.D_DAT_MOV',Data1.Date,Data2.Date,true));

  Estoque.sql.add(VpaGrupo);

  estoque.open;

  if ( estoque.FieldByName('n_vlr_mov') is TFloatField) then
    (estoque.FieldByName('n_vlr_mov') as TFloatField).DisplayFormat :=  Varia.MascaraMoeda;
  if ( estoque.FieldByName('n_qtd_mov') is TFloatField) then
    (estoque.FieldByName('n_qtd_mov') as TFloatField).DisplayFormat :=  Varia.MascaraValor;
  if ( estoque.FieldByName('ValorMedio') is TFloatField) then
    (estoque.FieldByName('ValorMedio') as TFloatField).DisplayFormat :=  Varia.MascaraMoeda;
end;

procedure TFDetalhesEstoque.MostraDetalhes( CodigoProduto, CodigoFilial, TipoItem : string; TipoMovimento : char );
begin
  GeraEstoqueProduto( CodigoProduto, CodigoFilial, TipoItem, TipoMovimento);
  self.CodigoProduto := CodigoProduto;
  self.CodigoFilial := CodigoFilial;
  self.TipoItem := TipoItem;
  self.TipoMov := TipoMovimento;
  self.ShowModal;
end;


{ *************** Registra a classe para evitar duplicidade ****************** }
procedure TFDetalhesEstoque.RNenhumClick(Sender: TObject);
begin
  BNota.Enabled := RNenhum.Checked;
  GeraEstoqueProduto( CodigoProduto, CodigoFilial, TipoItem, TipoMov );
end;

procedure TFDetalhesEstoque.BFecharClick(Sender: TObject);
begin
self.close;
end;

procedure TFDetalhesEstoque.EditLocaliza1Retorno(Retorno1,
  Retorno2: String);
begin
 if Retorno1 <> '' then
  GeraEstoqueProduto( CodigoProduto, CodigoFilial, TipoItem, retorno1[1] );
end;

{************************ mostra a nota fiscal de entrada e saida *********** }
procedure TFDetalhesEstoque.BNotaClick(Sender: TObject);
Var
  VpfDNota : TRBDNotaFiscal;
begin
  if Estoque.fieldByName('i_not_sai').AsInteger <> 0 then
  begin
    VpfDNota := TRBDNotaFiscal.cria; //não precisa destruir o vpfdnotafiscal porque a novanotafiscalnota já destroi
    VpfDNota.CodFilial := Estoque.FieldByName('I_EMP_FIL').AsInteger;
    VpfDNota.SeqNota := Estoque.FieldByName('I_SEQ_NOT').AsInteger;
    FunNotaFiscal.CarDNotaFiscal(VpfDNota);
    FNovaNotaFiscalNota := TFNovaNotaFiscalNota.CriarSDI(self,'',true);
    FNovaNotaFiscalNota.ConsultaNota(VpfDNota);
    FNovaNotaFiscalNota.free;
  end
  else
    if Estoque.fieldByName('i_not_ent').AsInteger <> 0 then
    begin
{      FCadNotaFiscaisFor := TFCadNotaFiscaisFor.CriarSDI(application, '', true);
      FCadNotaFiscaisFor.ConsultaNotaFiscal(Estoque.fieldByName('i_not_ent').AsInteger);}
    end
end;

Initialization
 RegisterClasses([TFDetalhesEstoque]);
end.
