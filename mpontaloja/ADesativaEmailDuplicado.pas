unit ADesativaEmailDuplicado;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Buttons, Db, DBTables, unClientes,
  UnProspect, FMTBcd, SqlExpr, DBClient, Tabela;

type
  TFDesativaEmailDuplicado = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BExecutar: TBitBtn;
    BFechar: TBitBtn;
    EClienteAnalisados: TMemoColor;
    EClientesAlterados: TMemoColor;
    PanelColor3: TPanelColor;
    EQtdAnalisados: TEditColor;
    Label1: TLabel;
    EQtdDuplicado: TEditColor;
    Label2: TLabel;
    Email: TSQL;
    Aux: TSQLQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BExecutarClick(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
  private
    { Private declarations }
    function CorrigeEmail(VpaEmail : String) : string;
    function ExisteEmailContatoCliente(VpaDesEmail : String):Boolean;
    function ExisteEmailProspect(VpaDesEmail : String):Boolean;
    function ExisteEmailContatoProspect(VpaDesEmail : String):Boolean;
    function DesativaEmailContatoProspect(VpaDesEmail : String):Boolean;
    procedure CorrigeEmailsInvaldo;
    procedure VerificaEmailContatoProspect;
    procedure VerificaEmailContatoCliente;
    procedure VerificaEmailProspect;
    procedure VerificaEmailCliente;
  public
    { Public declarations }
  end;

var
  FDesativaEmailDuplicado: TFDesativaEmailDuplicado;

implementation

uses APrincipal, FunSql, FunString;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFDesativaEmailDuplicado.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFDesativaEmailDuplicado.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { fecha tabelas }
  { chamar a rotina de atualização de menus }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
procedure TFDesativaEmailDuplicado.VerificaEmailContatoProspect;
begin
  EClienteAnalisados.Lines.Insert(0,'Verificando e-mail duplicado nos contatos do prospect');
  //verifica os e-mail duplicados no proprio cadastro
  AdicionaSQLAbreTabela(Email,'select DESEMAIL, COUNT(DESEMAIL) QTD  from CONTATOPROSPECT '+
                           ' Where INDACEITAEMARKETING = ''S'''+
                           ' AND INDEMAILINVALIDO = ''N'''+
                           ' GROUP BY DESEMAIL '+
                           ' HAVING COUNT(DESEMAIL) > 1');

  while not Email.eof do
  begin
    if Email.FieldByname('DESEMAIL').AsString <> '' then
    begin
      AdicionaSQLAbreTabela(Aux,'Select * from CONTATOPROSPECT '+
                            ' Where DESEMAIL = '''+Email.FieldByname('DESEMAIL').AsString+''''+
                            ' AND INDACEITAEMARKETING = ''S'''+
                            ' AND INDEMAILINVALIDO = ''N''');
      EClienteAnalisados.Lines.Insert(0,'Verificando e-mail do contato do prospect '''+Aux.FieldByname('NOMCONTATO').AsString+'''');
      EQtdAnalisados.AInteiro := EQtdAnalisados.AInteiro +1;
      Aux.Next;
      While not Aux.Eof do
      begin
        EClientesAlterados.Lines.Insert(0,'Desativando o e-mail do prospect '''+Aux.FieldByname('DESEMAIL').AsString+'''');
        FunProspect.AtivarEmailContatoProspect(Aux.FieldByname('CODPROSPECT').AsInteger,Aux.FieldByname('SEQCONTATO').AsInteger,false);
        EQtdDuplicado.AInteiro := EQtdDuplicado.AInteiro +1;
        Aux.next;
      end;
    end;
    Email.next;
  end;
  AdicionaSQLAbreTabela(Email,'select * from CONTATOPROSPECT ' +
                              ' where INDACEITAEMARKETING = ''S'''+
                              ' AND INDEMAILINVALIDO = ''N''');
  While not Email.eof do
  begin
    if Email.FieldByname('DESEMAIL').AsString <> '' THEN
    begin
      Email.Edit;
      Email.FieldByName('DESEMAIL').AsString := DeletaEspaco(LowerCase(Email.FieldByName('DESEMAIL').AsString));
      Email.Post;
      EQtdAnalisados.AInteiro := EQtdAnalisados.AInteiro + 1;
      EClienteAnalisados.Lines.Insert(0,'Verificando e-mail do contato '''+Email.FieldByname('NOMCONTATO').AsString+'''');
    end;
    Email.next;
  end;

end;

{******************************************************************************}
procedure TFDesativaEmailDuplicado.VerificaEmailContatoCliente;
begin
  EClienteAnalisados.Lines.Insert(0,'Verificando e-mail duplicado nos contatos do cliente');
  //verifica os e-mail duplicados no proprio cadastro
  AdicionaSQLAbreTabela(Email,'select DESEMAIL, COUNT(DESEMAIL) QTD  from CONTATOCLIENTE '+
                           ' Where INDACEITAEMARKETING = ''S'''+
                           ' AND INDEMAILINVALIDO = ''N'''+
                           ' GROUP BY DESEMAIL '+
                           ' HAVING COUNT(DESEMAIL) > 1');

  while not Email.eof do
  begin
    if Email.FieldByname('DESEMAIL').AsString <> '' then
    begin
      AdicionaSQLAbreTabela(Aux,'Select * from CONTATOCLIENTE '+
                            ' Where DESEMAIL = '''+Email.FieldByname('DESEMAIL').AsString+''''+
                            ' AND INDACEITAEMARKETING = ''S'''+
                            ' AND INDEMAILINVALIDO = ''N''');
      EClienteAnalisados.Lines.Insert(0,'Verificando e-mail do contato do cliente '''+Aux.FieldByname('NOMCONTATO').AsString+'''');
      EQtdAnalisados.AInteiro := EQtdAnalisados.AInteiro +1;
      Aux.Next;
      While not Aux.Eof do
      begin
        EClientesAlterados.Lines.Insert(0,'Desativando o e-mail do cliente '''+Aux.FieldByname('NOMCONTATO').AsString+'''');
        FunClientes.AtivarEmailContatoCliente(Aux.FieldByname('CODCLIENTE').AsInteger,Aux.FieldByname('SEQCONTATO').AsInteger,false);
        EQtdDuplicado.AInteiro := EQtdDuplicado.AInteiro +1;
        Aux.next;
      end;
    end;
    Email.next;
  end;

  AdicionaSQLAbreTabela(Email,'select * from CONTATOCLIENTE ' +
                              ' where INDACEITAEMARKETING = ''S'''+
                              ' AND INDEMAILINVALIDO = ''N''');
  While not Email.eof do
  begin
    if Email.FieldByname('DESEMAIL').AsString <> '' THEN
    begin
      Email.Edit;
      Email.FieldByName('DESEMAIL').AsString := DeletaEspaco(LowerCase(Email.FieldByName('DESEMAIL').AsString));
      Email.Post;
      EQtdAnalisados.AInteiro := EQtdAnalisados.AInteiro + 1;
      EClienteAnalisados.Lines.Insert(0,'Verificando e-mail do contato '''+Email.FieldByname('NOMCONTATO').AsString+'''');
      if ExisteEmailProspect(Email.FieldByname('DESEMAIL').AsString) or (ExisteEmailContatoProspect(Email.FieldByname('DESEMAIL').AsString)) then
      begin
        EClientesAlterados.Lines.Insert(0,'Desativando o e-mail '''+Email.FieldByname('DESEMAIL').AsString+''' do contato "'+Email.FieldByname('NOMCONTATO').AsString+'"');
        FunClientes.AtivarEmailContatoCliente(Email.FieldByname('CODCLIENTE').AsInteger,Email.FieldByname('SEQCONTATO').AsInteger,false);
        EQtdDuplicado.AInteiro := EQtdDuplicado.AInteiro +1;
      end;
    end;
    Email.next;
  end;
  Email.close;
end;

{******************************************************************************}
procedure TFDesativaEmailDuplicado.VerificaEmailProspect;
begin
  EClienteAnalisados.Lines.Insert(0,'Verificando e-mail duplicado dos prospect');
  //verifica os e-mail duplicados no proprio cadastro
  AdicionaSQLAbreTabela(Email,'select DESEMAILCONTATO, COUNT(DESEMAILCONTATO) QTD  from PROSPECT '+
                           ' Where INDACEITASPAM = ''S'''+
                           ' AND INDEMAILINVALIDO = ''N'''+
                           ' GROUP BY DESEMAILCONTATO '+
                           ' HAVING COUNT(DESEMAILCONTATO) > 1');

  while not Email.eof do
  begin
    if Email.FieldByname('DESEMAILCONTATO').AsString <> '' then
    begin
      AdicionaSQLAbreTabela(Aux,'Select * from PROSPECT '+
                            ' Where DESEMAILCONTATO = '''+Email.FieldByname('DESEMAILCONTATO').AsString+''''+
                            ' AND INDACEITASPAM = ''S'''+
                            ' AND INDEMAILINVALIDO = ''N''');
      EClienteAnalisados.Lines.Insert(0,'Verificando e-mail do prospect '''+Aux.FieldByname('NOMPROSPECT').AsString+'''');
      EQtdAnalisados.AInteiro := EQtdAnalisados.AInteiro +1;
      Aux.Next;
      While not Aux.Eof do
      begin
        EClientesAlterados.Lines.Insert(0,'Desativando o e-mail do prospect '''+Aux.FieldByname('DESEMAILCONTATO').AsString+'''');
        FunProspect.AtivarEmailProspect(Aux.FieldByname('CODPROSPECT').AsInteger,false);
        EQtdDuplicado.AInteiro := EQtdDuplicado.AInteiro +1;
        Aux.next;
      end;
    end;
    Email.next;
  end;

  AdicionaSQLAbreTabela(Email,'select * from PROSPECT ' +
                              ' where INDACEITASPAM = ''S'''+
                              ' and INDEMAILINVALIDO = ''N''');
  While not Email.eof do
  begin
    if Email.FieldByname('DESEMAILCONTATO').AsString <> '' THEN
    begin
      Email.Edit;
      Email.FieldByName('DESEMAILCONTATO').AsString := DeletaEspaco(LowerCase(Email.FieldByName('DESEMAILCONTATO').AsString));
      Email.Post;

      EQtdAnalisados.AInteiro := EQtdAnalisados.AInteiro + 1;
      EClienteAnalisados.Lines.Insert(0,'Verificando e-mail do prospect '''+Email.FieldByname('DESEMAILCONTATO').AsString+'''');
      DesativaEmailContatoProspect(Email.FieldByname('DESEMAILCONTATO').AsString);
    end;
    Email.next;
  end;
  Email.close;

end;

{******************************************************************************}
procedure TFDesativaEmailDuplicado.VerificaEmailCliente;
begin
  EQtdAnalisados.Clear;
  EQtdDuplicado.Clear;
  //verifica os e-mail duplicados no proprio cadastro
  EClienteAnalisados.Lines.Insert(0,'Verificando e-mail duplicado no cadastro do cliente');
  AdicionaSQLAbreTabela(Email,'select C_END_ELE, COUNT(C_END_ELE) QTD  from CADCLIENTES '+
                           ' Where C_ACE_SPA = ''S'''+
                           ' GROUP BY C_END_ELE '+
                           ' HAVING COUNT(C_END_ELE) > 1');
  while not Email.eof do
  begin
    if Email.FieldByname('C_END_ELE').AsString <> '' then
    begin
      AdicionaSQLAbreTabela(Aux,'Select * from CADCLIENTES '+
                            ' Where C_END_ELE = '''+Email.FieldByname('C_END_ELE').AsString+''''+
                            ' AND C_ACE_SPA = ''S''');
      EClienteAnalisados.Lines.Insert(0,'Verificando e-mail do cliente '''+Email.FieldByname('C_END_ELE').AsString+'''');
      EQtdAnalisados.AInteiro := EQtdAnalisados.AInteiro +1;
      Aux.Next;
      While not Aux.Eof do
      begin
        EClientesAlterados.Lines.Insert(0,'Desativando o e-mail do cliente '''+Aux.FieldByname('C_NOM_CLI').AsString+'''');
        FunClientes.AtivarEmailCliente(Aux.FieldByname('I_COD_CLI').AsInteger,false);
        EQtdDuplicado.AInteiro := EQtdDuplicado.AInteiro +1;
        Aux.next;
      end;
    end;
    Email.next;
  end;

  AdicionaSQLAbreTabela(Email,'select * from CADCLIENTES ' +
                              ' where C_ACE_SPA = ''S'''+
                              ' and C_EMA_INV = ''N''');
  While not Email.eof do
  begin
    if Email.FieldByname('C_END_ELE').AsString <> '' THEN
    begin
      Email.Edit;
      Email.FieldByName('C_END_ELE').AsString := DeletaEspaco(LowerCase(Email.FieldByName('C_END_ELE').AsString));
      Email.Post;
      EQtdAnalisados.AInteiro := EQtdAnalisados.AInteiro + 1;
      EClienteAnalisados.Lines.Insert(0,'Verificando e-mail do cliente '''+Email.FieldByname('C_END_ELE').AsString+'''');
      ExisteEmailContatoCliente(Email.FieldByname('C_END_ELE').AsString);
      if ExisteEmailProspect(Email.FieldByname('C_END_ELE').AsString) or (ExisteEmailContatoProspect(Email.FieldByname('C_END_ELE').AsString)) then
      begin
        EClientesAlterados.Lines.Insert(0,'Desativando o e-mail do cliente '''+Email.FieldByname('C_NOM_CLI').AsString+'''');
        FunClientes.AtivarEmailCliente(Email.FieldByname('I_COD_CLI').AsInteger,false);
        EQtdDuplicado.AInteiro := EQtdDuplicado.AInteiro +1;
      end;

    end;
    Email.next;
  end;
  Email.close;
  EClienteAnalisados.Lines.insert(0,'Clientes Analisados com sucesso.');
end;

{******************************************************************************}
function TFDesativaEmailDuplicado.ExisteEmailContatoCliente(VpaDesEmail : String):Boolean;
begin
  result := false;
  AdicionaSQLAbreTabela(Aux,'Select COUNT(CODCLIENTE) QTD from CONTATOCLIENTE '+
                            ' Where DESEMAIL = '''+VpaDesEmail+''''+
                            '  AND INDACEITAEMARKETING = ''S''');
  if Aux.FieldByname('QTD').AsInteger > 0 then
  begin
    EClienteAnalisados.Lines.insert(0,'Localizado "'+Aux.FieldByname('QTD').AsString+'" e-mails nos contatos de clientes');
    AdicionaSQLAbreTabela(Aux,'Select * from CONTATOCLIENTE '+
                            ' Where DESEMAIL = '''+VpaDesEmail+''''+
                            '  AND INDACEITAEMARKETING = ''S''');
    while not Aux.eof do
    begin
      EClientesAlterados.Lines.insert(0,'Desativando e-mail "'+VpaDesEmail+'"  nos contatos de clientes');
      FunClientes.AtivarEmailContatoCliente(Aux.FieldByname('CODCLIENTE').AsInteger,Aux.FieldByname('SEQCONTATO').AsInteger,false);
      EQtdDuplicado.AInteiro := EQtdDuplicado.AInteiro +1;
      Aux.next;
    end;
    Aux.Close;
  end;
  Aux.close;
end;

{******************************************************************************}
function TFDesativaEmailDuplicado.ExisteEmailProspect(VpaDesEmail : String):Boolean;
begin
  AdicionaSQLAbreTabela(Aux,'Select COUNT(CODPROSPECT) QTD from PROSPECT '+
                            ' Where DESEMAILCONTATO = '''+VpaDesEmail+''''+
                            '  AND INDACEITASPAM = ''S''');
  result := Aux.FieldByname('QTD').AsInteger > 0;
  Aux.close;
end;

{******************************************************************************}
function TFDesativaEmailDuplicado.ExisteEmailContatoProspect(VpaDesEmail : String):Boolean;
begin
  AdicionaSQLAbreTabela(Aux,'Select COUNT(CODPROSPECT) QTD from CONTATOPROSPECT '+
                            ' Where DESEMAIL = '''+VpaDesEmail+''''+
                            '  AND INDACEITAEMARKETING = ''S''');
  result := Aux.FieldByname('QTD').AsInteger > 0;
  Aux.close;
end;

{******************************************************************************}
function TFDesativaEmailDuplicado.DesativaEmailContatoProspect(VpaDesEmail : String):Boolean;
begin
  result := false;
  AdicionaSQLAbreTabela(Aux,'Select COUNT(CODPROSPECT) QTD from CONTATOPROSPECT '+
                            ' Where DESEMAIL = '''+VpaDesEmail+''''+
                            '  AND INDACEITAEMARKETING = ''S'''+
                            ' AND INDEMAILINVALIDO = ''N''');
  if Aux.FieldByname('QTD').AsInteger > 0 then
  begin
    EClienteAnalisados.Lines.insert(0,'Localizado "'+Aux.FieldByname('QTD').AsString+'" e-mails nos contatos do prospect');
    AdicionaSQLAbreTabela(Aux,'Select * from CONTATOPROSPECT '+
                            ' Where DESEMAIL = '''+VpaDesEmail+''''+
                            '  AND INDACEITAEMARKETING = ''S'''+
                            ' AND INDEMAILINVALIDO = ''N''');
    while not Aux.eof do
    begin
      EClientesAlterados.Lines.insert(0,'Desativando e-mail "'+VpaDesEmail+'"  nos contatos do prospect');
      FunProspect.AtivarEmailContatoProspect(Aux.FieldByname('CODPROSPECT').AsInteger,Aux.FieldByname('SEQCONTATO').AsInteger,false);
      EQtdDuplicado.AInteiro := EQtdDuplicado.AInteiro +1;
      Aux.next;
    end;
    Aux.Close;
  end;
  Aux.close;
end;

{select DESEMAIL, COUNT(DESEMAIL) QTD  from CONTATOPROSPECT
Where desemail <> ''
and INDACEITAEMARKETING = 'S'
GROUP BY DESEMAIL
HAVING QTD > 1}

{******************************************************************************}
procedure TFDesativaEmailDuplicado.BExecutarClick(Sender: TObject);
begin
  CorrigeEmailsInvaldo;
  VerificaEmailCliente;
  VerificaEmailContatoCliente;
  VerificaEmailProspect;
  VerificaEmailContatoProspect;
end;

procedure TFDesativaEmailDuplicado.BFecharClick(Sender: TObject);
begin
  close;
end;

{******************************************************************************}
function TFDesativaEmailDuplicado.CorrigeEmail(VpaEmail: String): string;
begin
  EClientesAlterados.Lines.insert(0,'Corrigindo e-mail "'+VpaEmail+'"');
  VpaEmail := DeletaEspaco(LowerCase(VpaEmail));
  if Pos('<',VpaEmail) = 1 then
  begin
    result := DeletaChars(DeletaChars(VpaEmail,'<'),'>');
  end
  else
    if Pos('<',VpaEmail) > 1 then
    begin
      VpaEmail := DeleteAteChar(VpaEmail,'<');
      Result := CopiaAteChar(VpaEmail,'>');
    end
    else
      if ExisteLetraString('>',VpaEmail) then
        Result := CopiaAteChar(VpaEmail,'>');
end;

{******************************************************************************}
procedure TFDesativaEmailDuplicado.CorrigeEmailsInvaldo;
begin
  EClienteAnalisados.Lines.Insert(0,'Corrigindo e-mail invalido nos contatos do prospect');
  AdicionaSQLAbreTabela(Email,'select CODPROSPECT, SEQCONTATO, DESEMAIL  from CONTATOPROSPECT '+
                           ' Where INDACEITAEMARKETING = ''S'''+
                           ' AND INDEMAILINVALIDO = ''N'''+
                           ' and (DESEMAIL LIKE ''%<%'' or ' +
                           ' DESEMAIL LIKE ''%>%'')');
  while not email.Eof do
  begin
    Email.Edit;
    Email.FieldByName('DESEMAIL').AsString := CorrigeEmail(Email.FieldByName('DESEMAIL').AsString);
    Email.Post;
    Email.Next;
  end;



end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFDesativaEmailDuplicado]);
end.
