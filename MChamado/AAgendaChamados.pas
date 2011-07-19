unit AAgendaChamados;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, ComCtrls, Db, DBTables, Grids,
  DBGrids, Tabela, DBKeyViolation, UnChamado, UnDados, StdCtrls, Buttons,WideStrings,
  CGrades, Menus, FMTBcd, SqlExpr, DBClient;

type
  TFAgendaChamados = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    EDatInicio: TMonthCalendar;
    EDatFim: TMonthCalendar;
    Aux: TSQLQUERY;
    PChamados: TPanelColor;
    Tecnicos: TSQLQUERY;
    Cadastro: TSQLQUERY;
    PopupMenu: TPopupMenu;
    N1: TMenuItem;
    SalvarConfiguraesGrade1: TMenuItem;
    ConsultarChamado1: TMenuItem;
    PanelColor2: TPanelColor;
    BFechar: TBitBtn;
    PAgenda: TPopupMenu;
    NovoLembrete1: TMenuItem;
    GLembretes: TGridIndice;
    LEMBRETECORPO: TSQL;
    DataLEMBRETECORPO: TDataSource;
    Lerlembrete1: TMenuItem;
    N2: TMenuItem;
    Alterarlembrete1: TMenuItem;
    N3: TMenuItem;
    Verificarleituras1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure EDatInicioClick(Sender: TObject);
    procedure SalvarConfiguraesGrade1Click(Sender: TObject);
    procedure ConsultarChamado1Click(Sender: TObject);
    procedure NovoLembrete1Click(Sender: TObject);
    procedure Lerlembrete1Click(Sender: TObject);
    procedure Alterarlembrete1Click(Sender: TObject);
    procedure Verificarleituras1Click(Sender: TObject);
    procedure GLembretesDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    VprQtdTecnicos : Integer;
    VprColunas : TList;
    FunChamados : TRBFuncoesChamado;
    procedure CarColunasUsuario;
    procedure PosicionaTecnicos(VpaTabela : TSQLQUERY);
    procedure PosicionaChamadosdoTecnico(VpaTabela : TDataSet;VpaCodTecnico : Integer);
    function RQtdTecnicos : Integer;
    function RTabelaChamados(VpaPainel : TPanel):TSQL;
    procedure CriaScroolBox(VpaDono : TPanel);
    procedure DuploCliqueGrade(VpaObjeto : TObject);
    procedure CorCelula(VpaObjeto : TObject; const Rect: TRect; Field: TField; State: TGridDrawState);
    procedure DragOver(Sender,Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure CliqueImprimir(VpaObjeto : TObject);
    procedure CriaPanel(VpaDono : TScrollBox;VpaCodTecnico : Integer);
    procedure CriaBotaoImprimir(VpaDono : TPanel);
    procedure CriaColunas(VpaGrade : TGridIndice);
    procedure CriaColuna(VpaGrade : TGridIndice;VpaNomCampo : String;VpaTamCampo : Integer);
    procedure ConfiguraAlturaScrollBox(VpaDono : TPanel);
    procedure MontaTela(VpaQtdTecnicos : Integer);
    procedure AtualizaConsultaTecnico(VpaCodTecnico : Integer);
    function RGradeTela : TGridIndice;
    procedure Atualizaconsulta;
    procedure AtualizaLembretes;
    procedure AdicionaFiltrosLembrete(VpaSelect: TStrings);
    procedure SalvaColunasUsuario(VpaGrade : TGridIndice);
  public
    { Public declarations }
    procedure AgendaChamados;
  end;

var
  FAgendaChamados: TFAgendaChamados;

implementation

uses APrincipal, funSql, FunNumeros, AHoraAgendaChamado, Fundata,
  Constmsg, Constantes, FunObjeto, ANovoChamadoTecnico, UnCrystal,
  ANovoLembrete, AVerificaLeituraLembrete, dmRave;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFAgendaChamados.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  VprColunas := Tlist.Create;
  FunChamados := TRBFuncoesChamado.cria(FPrincipal.BaseDados);
  EDatInicio.Date := date;
  EDatFim.Date := date;
  PanelColor1.Width := EDatInicio.Width-26;
  CarColunasUsuario;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFAgendaChamados.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
 { chamar a rotina de atualização de menus }
// SalvaColunasUsuario;
  FreeTObjectsList(VprColunas);
  FunChamados.free;
  Action := CaFree;
end;

{******************************************************************************}
function TFAgendaChamados.RQtdTecnicos : Integer;
begin
  AdicionaSQLAbreTabela(Aux,'Select COUNT(DISTINCT(CODTECNICO)) QTD from CHAMADOCORPO '+
                            ' Where DATPREVISAO >= '+SQLTextoDataAAAAMMMDD(EDatInicio.Date)+
                            ' and DATPREVISAO < '+SQLTextoDataAAAAMMMDD(incdia(EDatFim.Date,1)));
  Result := Aux.FieldByName('QTD').AsInteger;
  Aux.Close;
end;

{******************************************************************************}
procedure TFAgendaChamados.CarColunasUsuario;
Var
  VpfDColuna : TRBDColunaAgenda;
begin
  FreeTObjectsList(VpRColunas);
  AdicionaSQLAbreTabela(Aux,'Select * from COLUNAAGENDACHAMADO '+
                            ' Where CODUSUARIO = '+InttoStr(Varia.CodigoUsuario)+
                            ' order by SEQITEM');
  While not Aux.Eof do
  begin
    VpfDColuna := TRBDColunaAgenda.Create;
    VprColunas.add(VpfDColuna);
    VpfDColuna.NomCampo := Aux.FieldByName('NOMCAMPO').AsString;
    VpfDColuna.TamCampo := Aux.FieldByName('TAMCAMPO').AsInteger;
    Aux.Next;
  end;
  Aux.close;
end;

{******************************************************************************}
procedure TFAgendaChamados.PosicionaTecnicos(VpaTabela : TSQLQUERY);
begin
  AdicionaSQLAbreTabela(VpaTabela,'Select DISTINCT(CODTECNICO) Tecnico from CHAMADOCORPO '+
                                 ' Where DATPREVISAO >= '+SQLTextoDataAAAAMMMDD(EDatInicio.Date)+
                                 ' and DATPREVISAO < '+SQLTextoDataAAAAMMMDD(incdia(EDatFim.Date,1)))
end;

{******************************************************************************}
procedure TFAgendaChamados.PosicionaChamadosdoTecnico(VpaTabela : TDataSet;VpaCodTecnico : Integer);
begin
  AdicionaSQLAbreTabela(VpaTabela,'Select CHA.DATPREVISAO, CLI.C_NOM_CLI, CHA.CODFILIAL , CHA.NUMCHAMADO,  CHA.NOMSOLICITANTE,  CLI.C_CID_CLI, '+
                                  ' CHA.CODESTAGIO Estagio, '+
                                  ' TIC.NOMTIPOCHAMADO '+
                                 ' from CHAMADOCORPO CHA, CADCLIENTES CLI, TIPOCHAMADO TIC '+
                                 ' Where CHA.CODTECNICO = ' +IntToStr(VpaCodTecnico)+
                                 ' and DATPREVISAO >= '+SQLTextoDataAAAAMMMDD(EDatInicio.Date)+
                                 ' and DATPREVISAO < '+SQLTextoDataAAAAMMMDD(incdia(EDatFim.Date,1))+
                                 ' AND CHA.CODCLIENTE = CLI.I_COD_CLI'+
                                 ' AND CHA.CODTIPOCHAMADO = TIC.CODTIPOCHAMADO '+
                                 ' order by DATPREVISAO');
end;

{******************************************************************************}
function TFAgendaChamados.RTabelaChamados(VpaPainel : TPanel):TSQL;
var
  VpfLaco : Integer;
begin
  for VpfLaco := 0 to VpaPainel.ComponentCount - 1 do
  begin
    if (VpaPainel.Components[VpfLaco] is TSQL) then
    begin
      result := TSQL(VpaPainel.Components[VpfLaco]);
      exit;
    end;
  end;
end;

{******************************************************************************}
procedure TFAgendaChamados.CriaScroolBox(VpaDono : TPanel);
var
  VpfScrollBox : TScrollBox;
begin
  VpfScrollBox := TScrollBox.Create(VpaDono);
  VpfScrollBox.Align := alTop;
  VpfScrollBox.ParentColor := true;
  VpfScrollBox.ParentFont := true;
  VpaDono.InsertControl(VpfScrollBox);
  ConfiguraAlturaScrollBox(pChamados);
end;

{******************************************************************************}
procedure TFAgendaChamados.DuploCliqueGrade(VpaObjeto : TObject);
var
  VpfDChamado : TRBDChamado;
begin
  VpfDChamado := TRBDChamado.Cria;
  VpfDChamado.CodFilial := TSQLQUERY(TGridIndice(VpaObjeto).DataSource.DataSet).FieldByName('CODFILIAL').AsInteger;
  VpfDChamado.NumChamado := TSQLQUERY(TGridIndice(VpaObjeto).DataSource.DataSet).FieldByName('NUMCHAMADO').AsInteger;
  if VpfDChamado.CodFilial <> 0 then
  begin
    FunChamados.CarDChamado(VpfDChamado.CodFilial,VpfDChamado.NumChamado,VpfDChamado);
    FHoraAgendaChamado := TFHoraAgendaChamado.CriarSDI(self,'',FPrincipal.VerificaPermisao('FHoraAgendaChamado'));
    if FHoraAgendaChamado.AlteraAgenda(VpfDChamado) then
    begin
      PosicionaChamadosdoTecnico(TSQLQUERY(TGridIndice(VpaObjeto).DataSource.DataSet),TGridIndice(VpaObjeto).Tag);
      if VpfDChamado.CodTecnico <> TGridIndice(VpaObjeto).Tag then
        AtualizaConsultaTecnico(VpfDChamado.CodTecnico);
    end;
    FHoraAgendaChamado.free;
  end;
  VpfDChamado.free;
end;

{******************************************************************************}
procedure TFAgendaChamados.CorCelula(VpaObjeto: TObject; const Rect: TRect; Field: TField; State: TGridDrawState);
var
  VpfTabela : TSQLQUERY;
  VpfGrade : TGridIndice;
begin
  VpfGrade := TGridIndice(VpaObjeto);
  VpfTabela := TSQLQUERY(VpfGrade.DataSource.DataSet);
  if (VpfTabela.FieldByName('Estagio').AsInteger < varia.EstagioChamadoFinalizado)and
     (VpfTabela.FieldByName('Data').AsDateTime < date)  then
  begin
    VpfGrade.Canvas.brush.Color := clred;
    VpfGrade.Canvas.Font.Color := clWhite;
    VpfGrade.Canvas.Pen.Color := clred;
    VpfGrade.DefaultDrawDataCell(Rect, Field, State);

  end;
end;

{******************************************************************************}
procedure TFAgendaChamados.DragOver(Sender,Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := Source is TGridIndice;
end;

{******************************************************************************}
procedure TFAgendaChamados.DragDrop(Sender, Source: TObject; X, Y: Integer);
var
  VpfCodFilial, VpfNumChamado : Integer;
  VpfTabelaOrigem : TSQLQUERY;
  VpfResultado : String;
begin
  if (Source is TGridIndice) then
  begin
    VpfTabelaOrigem := TSQLQUERY(TGridIndice(Source).DataSource.DataSet);
    VpfCodFilial := VpfTabelaOrigem.FieldByName('Fl').AsInteger;
    VpfNumChamado := VpfTabelaOrigem.FieldByName('Chamado').AsInteger;
    VpfResultado := FunChamados.AlteraTecnico(VpfCodFilial,VpfNumChamado,TGridIndice(Sender).Tag);

    PosicionaChamadosdoTecnico(VpfTabelaOrigem,TGridIndice(Source).Tag);
    PosicionaChamadosdoTecnico(TSQLQUERY(TGridIndice(Sender).DataSource.DataSet),TGridIndice(Sender).Tag);

    if VpfResultado <> '' then
      aviso(VpfResultado);
  end;
end;

{******************************************************************************}
procedure TFAgendaChamados.CliqueImprimir(VpaObjeto : TObject);
var
  VpfTabela : TSQL;
begin
  if Confirmacao('Tem certeza que deseja imprimir os chamados do técnico?') then
  begin
    VpfTabela := RTabelaChamados(TPanel(TPanel(VpaObjeto).parent));
    VpfTabela.first;
    dtRave := TdtRave.create(self);
    while not VpfTabela.Eof do
    begin
      dtRave.ImprimeChamado(VpfTabela.FieldByName('CODFILIAL').AsInteger,VpfTabela.FieldByName('NUMCHAMADO').AsInteger,false);
      VpfTabela.Next;
    end;
    dtRave.free;
  end;
end;

{******************************************************************************}
procedure TFAgendaChamados.CriaPanel(VpaDono : TScrollBox;VpaCodTecnico : Integer);
var
  VpfPanel,VpfTitulo : tpanel;
  VpfGrade : TGridIndice;
  VpfTabela : TSQL;
  VpfDataSource : TDataSource;
begin
  VpfPanel := TPanel.Create(VpaDono);
  VpfPanel.Align := alLeft;
  VpfPanel.Caption := IntToStr(VpaCodTecnico);
  VpfPanel.Tag := VpaCodTecnico;
  VpfPanel.ParentColor := true;
  VpfPanel.ParentFont := true;
  VpfPanel.Width := 300;
  VpaDono.InsertControl(VpfPanel);

  VpfTitulo := TPanel.Create(VpfPanel);
  VpfTitulo.Align := altop;
  VpfTitulo.Caption := FunChamados.RNomeTecnico(VpaCodTecnico);
  VpfTitulo.ParentColor := true;
  VpfTitulo.Font.Size := 14;
  VpfTitulo.parent := VpfPanel;
  VpfTitulo.Height := 30;
  if not((varia.CNPJFilial = CNPJ_COPYLINE) or
     (varia.CNPJFilial = CNPJ_Impox)) then
    CriaBotaoImprimir(VpfPanel);

  VpfTabela := TSQL.Create(VpfPanel);
  VpfTabela.ASqlConnection := FPrincipal.BaseDados;
  VpfTabela.Name := 'TabelaTecnico'+IntToStr(VpaCodTecnico);
  PosicionaChamadosdoTecnico(VpfTabela,VpaCodTecnico);

  VpfDataSource :=TDataSource.Create(VpfPanel);
  VpfDataSource.DataSet := VpfTabela;

  VpfGrade := TGridIndice.Create(VpfPanel);
  VpfGrade.ACorFoco := FPrincipal.CorFoco;
  VpfGrade.Align := alclient;
  VpfGrade.parent := VpfPanel;
  VpfGrade.Tag := VpaCodTecnico;
  VpfGrade.DataSource := VpfDataSource;
  VpfGrade.DragMode := dmManual;
  VpfGrade.Options := VpfGrade.Options + [dgRowSelect,dgalwaysShowSelection];
  if not((varia.CNPJFilial = CNPJ_COPYLINE) or
     (varia.CNPJFilial = CNPJ_Impox)) then
    VpfGrade.PopupMenu := PopupMenu;
  VpfGrade.OnDblClick := DuploCliqueGrade;
  VpfGrade.OnDrawDataCell := CorCelula;
  VpfGrade.OnDragOver := DragOver;
  VpfGrade.OnDragDrop := DragDrop;
  TDateTimeField(VpfGrade.Columns[0].Field).DisplayFormat:='DD/MM/YY HH:MM';
  CriaColunas(VpfGrade);
end;

{******************************************************************************}
procedure TFAgendaChamados.CriaBotaoImprimir(VpaDono : TPanel);
var
  VpfBotao : TPanel;
begin
  VpfBotao := TPanel.Create(VpaDono);
  VpfBotao.ParentColor := true;
  VpfBotao.parent := VpaDono;
  VpfBotao.Align := alBottom;
  VpfBotao.Height := 25;
  VpfBotao.Caption := 'Imprimir';
  VpfBotao.OnClick := CliqueImprimir;
end;

{******************************************************************************}
procedure TFAgendaChamados.CriaColunas(VpaGrade : TGridIndice);
var
  VpfColuna : TColumn;
  VpfDColuna : TRBDColunaAgenda;
  VpfLaco : Integer;
begin
  if VprColunas.Count > 0 then
  begin
    for VpfLaco := 0 to VprColunas.Count - 1 do
    begin
      VpfDColuna := TRBDColunaAgenda(VprColunas.Items[VpfLaco]);
      CriaColuna(VpaGrade,VpfDColuna.NomCampo,VpfDColuna.TamCampo);
    end;
  end
  else
  begin
    CriaColuna(VpaGrade,'DATPREVISAO',90);
    CriaColuna(VpaGrade,'NOMTIPOCHAMADO',90);
    CriaColuna(VpaGrade,'C_NOM_CLI',120);
    CriaColuna(VpaGrade,'CODFILIAL',20);
    CriaColuna(VpaGrade,'NUMCHAMADO',65);
    CriaColuna(VpaGrade,'NOMSOLICITANTE',120);
    CriaColuna(VpaGrade,'C_CID_CLI',100);
  end;
end;

{******************************************************************************}
procedure TFAgendaChamados.CriaColuna(VpaGrade : TGridIndice;VpaNomCampo : String;VpaTamCampo : Integer);
var
  VpfColuna : TColumn;
begin
  VpfColuna := VpaGrade.Columns.Add;
  VpfColuna.FieldName := VpaNomCampo;
  VpfColuna.Width := VpaTamCampo;
  if VpaNomCampo = 'DATPREVISAO' then
    VpfColuna.Title.Caption := 'Previsão'
  else
    if VpaNomCampo = 'C_NOM_CLI' then
      VpfColuna.Title.Caption := 'Cliente'
    else
      if VpaNomCampo = 'CODFILIAL' then
        VpfColuna.Title.Caption := 'Fl'
      else
        if VpaNomCampo = 'NUMCHAMADO' then
          VpfColuna.Title.Caption := 'Chamado'
        else
          if VpaNomCampo = 'NOMSOLICITANTE' then
            VpfColuna.Title.Caption := 'Solicitante'
          else
            if VpaNomCampo = 'C_CID_CLI' then
              VpfColuna.Title.Caption := 'Cidade'
            else
              if VpaNomCampo = 'NOMTIPOCHAMADO' then
                VpfColuna.Title.Caption := 'Tipo'
end;

{******************************************************************************}
procedure TFAgendaChamados.ConfiguraAlturaScrollBox(VpaDono : TPanel);
var
  VpfLaco : Integer;
begin
  for VpfLaco := 0 to VpaDono.ComponentCount -1 do
    TScrollBox(VpaDono.Components[VpfLaco]).Height := RetornaInteiro(VpaDono.Height / VpaDono.ComponentCount);
end;

{******************************************************************************}
procedure TFAgendaChamados.MontaTela(VpaQtdTecnicos : Integer);
var
  VpfNumTecnico : Integer;
  VpfScrollBox : TScrollBox;
begin
  CriaScroolBox(PChamados);
  if VpaQtdTecnicos > 4 then
    CriaScroolBox(PChamados);
  PosicionaTecnicos(Tecnicos);
  VpfNumTecnico := 0;
  while not Tecnicos.eof do
  begin
    inc(VpfNumTecnico);
    if (VpfNumTecnico <= (RetornaInteiro(VprQtdTecnicos/2))) or
       (VpfNumTecnico <= 4)  then
      VpfScrollBox := TScrollBox(PChamados.Components[0])
    else
      VpfScrollBox := TScrollBox(PChamados.Components[1]);

    CriaPanel(VpfScrollBox,Tecnicos.FieldByName('TECNICO').AsInteger);
    Tecnicos.Next;
  end;
end;

{******************************************************************************}
procedure TFAgendaChamados.AtualizaConsultaTecnico(VpaCodTecnico : Integer);
var
  VpfLacoPainel, VpfLacoScrool,VpfLacoTecnico : Integer;
  VpfPainel : TPanel;
begin
  for VpfLacoPainel := 0 to PChamados.ComponentCount - 1 do
  begin
    for VpfLacoScrool := 0 to TScrollBox(PChamados.Components[VpfLacoPainel]).ComponentCount - 1 do
    begin
      VpfPainel := TPAnel(TScrollBox(PChamados.Components[VpfLacoPainel]).Components[VpfLacoScrool]);
      if VpfPainel.Tag = VpaCodTecnico then
      begin
        for VpflacoTecnico := 0 to VpfPainel.ComponentCount - 1 do
        begin
          if VpfPainel.Components[VpfLacoTecnico] is TSQLQUERY then
          begin
            PosicionaChamadosdoTecnico(TSQLQUERY(VpfPainel.Components[VpfLacoTecnico]),VpaCodTecnico);
            exit;
          end;
        end;
      end;
    end;
  end;
  CriaPanel(TScrollBox(PChamados.Components[0]),VpaCodTecnico);
end;

{******************************************************************************}
function TFAgendaChamados.RGradeTela : TGridIndice;
var
  VpfLacoPainel, VpfLacoScrool,VpfLacoTecnico : Integer;
  VpfPainel : TPanel;
begin
  for VpfLacoPainel := 0 to PChamados.ComponentCount - 1 do
  begin
    for VpfLacoScrool := 0 to TScrollBox(PChamados.Components[VpfLacoPainel]).ComponentCount - 1 do
    begin
      VpfPainel := TPAnel(TScrollBox(PChamados.Components[VpfLacoPainel]).Components[VpfLacoScrool]);
      for VpflacoTecnico := 0 to VpfPainel.ComponentCount - 1 do
      begin
        if VpfPainel.Components[VpfLacoTecnico] is TGridIndice then
        begin
          result :=  TGridIndice(VpfPainel.Components[VpfLacoTecnico]);
          exit;
        end;
      end;
    end;
  end;
end;

{******************************************************************************}
procedure TFAgendaChamados.Atualizaconsulta;
var
  VpfLaco : Integer;
begin
  for VpfLaco := pred(PChamados.ComponentCount) downto 0 do
    TScrollBox(PChamados.Components[VpfLaco]).free;

  VprQtdTecnicos := RQtdTecnicos;
  MontaTela(VprQtdTecnicos);
end;

{******************************************************************************}
procedure TFAgendaChamados.SalvaColunasUsuario(VpaGrade : TGridIndice);
var
  VpfLaco : Integer;
begin
  if VpaGrade <> nil then
  begin
    ExecutaComandoSql(Aux,'delete from COLUNAAGENDACHAMADO '+
                           ' Where CODUSUARIO = '+IntToStr(Varia.CodigoUsuario));
    AdicionaSQLAbreTabela(Cadastro,'Select * from COLUNAAGENDACHAMADO');
    for Vpflaco := 0 to  VpaGrade.Columns.Count - 1 do
    begin
      Cadastro.Insert;
      Cadastro.FieldByName('CODUSUARIO').AsInteger := Varia.CodigoUsuario;
      Cadastro.FieldByName('SEQITEM').AsInteger := VpfLaco +1;
      Cadastro.FieldByName('NOMCAMPO').AsString := VpaGrade.Columns[Vpflaco].FieldName;
      Cadastro.FieldByName('TAMCAMPO').AsInteger := VpaGrade.Columns[VpfLaco].Width;
      Cadastro.post;
    end;
    Cadastro.close;
    CarColunasUsuario;
    Atualizaconsulta;
  end;
end;

{******************************************************************************}
procedure TFAgendaChamados.AgendaChamados;
begin
  VprQtdTecnicos := RQtdTecnicos;
  MontaTela(VprQtdTecnicos);
  AtualizaLembretes;  
  Showmodal;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{******************************************************************************}
procedure TFAgendaChamados.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
procedure TFAgendaChamados.EDatInicioClick(Sender: TObject);
begin
  Atualizaconsulta;
  AtualizaLembretes;
end;

{******************************************************************************}
procedure TFAgendaChamados.SalvarConfiguraesGrade1Click(Sender: TObject);
begin
  SalvaColunasUsuario(TGridIndice(PopupMenu.PopupComponent));
end;

{******************************************************************************}
procedure TFAgendaChamados.ConsultarChamado1Click(Sender: TObject);
begin
  if TSQLQUERY(TGridIndice(PopupMenu.PopupComponent).DataSource.DataSet).FieldByName('CODFILIAL').AsInteger <> 0 then
  begin
    FNovoChamado := TFNovoChamado.CriarSDI(self,'',FPrincipal.VerificaPermisao('FNovoChamado'));
    FNovoChamado.ConsultaChamado(TSQLQUERY(TGridIndice(PopupMenu.PopupComponent).DataSource.DataSet).FieldByName('CODFILIAL').AsInteger,TSQLQUERY(TGridIndice(PopupMenu.PopupComponent).DataSource.DataSet).FieldByName('NUMCHAMADO').AsInteger);
    FNovoChamado.free;
  end;
end;

{******************************************************************************}
procedure TFAgendaChamados.NovoLembrete1Click(Sender: TObject);
begin
  FNovoLembrete:= TFNovoLembrete.CriarSDI(Application,'',True);
  if FNovoLembrete.NovoLembrete then
    AtualizaLembretes;
  FNovoLembrete.Free;
end;

{******************************************************************************}
procedure TFAgendaChamados.AtualizaLembretes;
var
  VpfBookmark: TBookmark;
begin
  VpfBookmark:= LEMBRETECORPO.GetBookmark;
  LEMBRETECORPO.Close;
  LEMBRETECORPO.SQL.Clear;
  LEMBRETECORPO.SQL.Add('SELECT'+
                        ' LBC.SEQLEMBRETE,'+
                        ' LBC.DATAGENDA||'' - ''||DESTITULO DESTITULO,'+
                        ' LBI.INDLIDO'+
                        ' FROM'+
                        ' LEMBRETECORPO LBC, LEMBRETEITEM LBI'+
                        ' WHERE'+ SQLTextoRightJoin(' LBC.SEQLEMBRETE','LBI.SEQLEMBRETE'));
                        //' AND LBI.CODUSUARIO = '+IntToStr(Varia.CodigoUsuario));
  AdicionaFiltrosLembrete(LEMBRETECORPO.SQL);
  LEMBRETECORPO.Open;
  try
    LEMBRETECORPO.GotoBookmark(VpfBookmark);
    LEMBRETECORPO.FreeBookmark(VpfBookmark);
  except
  end;
end;

{******************************************************************************}
procedure TFAgendaChamados.AdicionaFiltrosLembrete(VpaSelect: TStrings);
begin
  VpaSelect.Add(' AND (LBC.INDTODOS = ''S'''+
                '      OR EXISTS(SELECT *'+
                '                FROM LEMBRETEUSUARIO LBU'+
                '                WHERE LBU.SEQLEMBRETE = LBC.SEQLEMBRETE'+
                '                AND LBU.CODUSUARIO = '+IntToStr(Varia.CodigoUsuario)+')'+
                '      OR LBC.CODUSUARIO = '+IntToStr(Varia.CodigoUsuario)+')');
  VpaSelect.Add(' AND'+
                ' (LBC.DATAGENDA IS NULL'+
                '  OR '+SQLTextoDataEntreAAAAMMDD('LBC.DATAGENDA',EDatInicio.Date,EDatFim.Date+1,False)+')');
end;

{******************************************************************************}
procedure TFAgendaChamados.Lerlembrete1Click(Sender: TObject);
begin
  if LEMBRETECORPO.FieldByName('SEQLEMBRETE').AsInteger <> 0 then
  begin
    FNovoLembrete:= TFNovoLembrete.CriarSDI(Application,'',True);
    FNovoLembrete.LerLembrete(LEMBRETECORPO.FieldByName('SEQLEMBRETE').AsInteger,Varia.CodigoUsuario);
    AtualizaLembretes;
    FNovoLembrete.Free;
  end
  else
    aviso('LEMBRETE NÃO SELECIONADO!!!'#13+
          'É necessário selecionar um lembrete para prosseguir.');
end;

{******************************************************************************}
procedure TFAgendaChamados.Alterarlembrete1Click(Sender: TObject);
begin
  if LEMBRETECORPO.FieldByName('SEQLEMBRETE').AsInteger <> 0 then
  begin
    FNovoLembrete:= TFNovoLembrete.CriarSDI(Application,'',True);
    if FNovoLembrete.AlterarLembrete(LEMBRETECORPO.FieldByName('SEQLEMBRETE').AsInteger,Varia.CodigoUsuario) then
      AtualizaLembretes;
    FNovoLembrete.Free;
  end
  else
    aviso('LEMBRETE NÃO SELECIONADO!!!'#13+
          'É necessário selecionar um lembrete para prosseguir.');
end;

{******************************************************************************}
procedure TFAgendaChamados.Verificarleituras1Click(Sender: TObject);
begin
  if LEMBRETECORPO.FieldByName('SEQLEMBRETE').AsInteger <> 0 then
  begin
    FVerificaLeituraLembrete:= TFVerificaLeituraLembrete.CriarSDI(Application,'',True);
    FVerificaLeituraLembrete.VerificaLeitura(LEMBRETECORPO.FieldByName('SEQLEMBRETE').AsInteger,Varia.CodigoUsuario);
    FVerificaLeituraLembrete.Free;
  end
  else
    aviso('LEMBRETE NÃO SELECIONADO!!!'#13+
          'É necessário selecionar um lembrete para prosseguir.');
end;

{******************************************************************************}
procedure TFAgendaChamados.GLembretesDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if LEMBRETECORPO.FieldByName('INDLIDO').IsNull then
  begin
    GLembretes.Canvas.Font.Style:= GLembretes.Canvas.Font.Style + [fsBold];
    GLembretes.DefaultDrawDataCell(Rect, GLembretes.Columns[DataCol].Field, State);
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFAgendaChamados]);
end.
