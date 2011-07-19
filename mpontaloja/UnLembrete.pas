unit UnLembrete;
{Verificado
-.edit;
}
interface
uses
  Classes, UnDados, Forms, SQLExpr, Tabela,db;

type
  TRBFuncoesLembrete = class
    private
      Cadastro,
      Tabela,
      Aux: TSQL;
      procedure ApagaDLembreteItem(VpaSeqLembrete: Integer);
      procedure CarDUsuariosLembrete(VpaSeqLembrete: Integer; VpaDLembreteCorpo: TRBDLembreteCorpo);
      function GravaDLembreteItem(VpaDLembreteCorpo: TRBDLembreteCorpo): String;
      function RSeqLembreteDisponivel: Integer;
    public
      constructor Cria(VpaBaseDados : TSQLConnection);
      destructor Destroy; override;
      procedure CarDLembrete(VpaSeqLembrete: Integer; VpaDLembreteCorpo: TRBDLembreteCorpo);
      procedure CarDUsuariosSistema(VpaUsuarios: TList; VpaCodGrupo: Integer = 0);
      function GravaDLembrete(VpaDLembreteCorpo: TRBDLembreteCorpo): String;
      function UsuarioLeuLembrete(VpaSeqLembrete, VpaCodUsuario: Integer): String;
end;

implementation
uses
  FunSql, FunData, SysUtils, FunObjeto, Constantes;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                               TRBFuncoesLembrete
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBFuncoesLembrete.Cria(VpaBaseDados : TSQLConnection);
begin
  inherited Create;
  Cadastro:= TSQL.Create(Application);
  Cadastro.ASQlConnection := VpaBaseDados;
  Tabela:= TSQL.Create(Application);
  Tabela.ASqlConnection := VpaBaseDados;
  Aux:= TSQL.Create(Application);
  Aux.ASqlConnection := VpaBaseDados;
  //Cadastro.RequestLive:= True;
end;

{******************************************************************************}
destructor TRBFuncoesLembrete.Destroy;
begin
  Cadastro.Close;
  Tabela.Close;
  Aux.Close;
  Cadastro.Free;
  Tabela.Free;
  Aux.Free;
  inherited Destroy;
end;

{******************************************************************************}
procedure TRBFuncoesLembrete.ApagaDLembreteItem(VpaSeqLembrete: Integer);
begin
  ExecutaComandoSql(Tabela,'DELETE FROM LEMBRETEUSUARIO'+
                           ' WHERE SEQLEMBRETE = '+IntToStr(VpaSeqLembrete));
  Tabela.Close;
end;

{******************************************************************************}
function TRBFuncoesLembrete.RSeqLembreteDisponivel: Integer;
begin
  AdicionaSQLAbreTabela(Aux,'SELECT MAX(SEQLEMBRETE) ULTIMO FROM LEMBRETECORPO');
  Result:= Aux.FieldByName('ULTIMO').AsInteger + 1;
  Aux.Close;
end;

{******************************************************************************}
function TRBFuncoesLembrete.GravaDLembrete(VpaDLembreteCorpo: TRBDLembreteCorpo): String;
begin
  Result:= '';
  ApagaDLembreteItem(VpaDLembreteCorpo.SeqLembrete);

  AdicionaSQLAbreTabela(Cadastro,'SELECT * FROM LEMBRETECORPO'+
                                 ' WHERE SEQLEMBRETE = '+IntToStr(VpaDLembreteCorpo.SeqLembrete));

  if Cadastro.Eof then
    Cadastro.Insert
  else
    Cadastro.Edit;

  Cadastro.FieldByName('DATLEMBRETE').AsDateTime:= VpaDLembreteCorpo.DatLembrete;
  Cadastro.FieldByName('CODUSUARIO').AsInteger:= VpaDLembreteCorpo.CodUsuario;
  Cadastro.FieldByName('INDAGENDAR').AsString:= VpaDLembreteCorpo.IndAgendar;
  if VpaDLembreteCorpo.DatAgenda > MontaData(1,1,1900) then
    Cadastro.FieldByName('DATAGENDA').AsDateTime:= VpaDLembreteCorpo.DatAgenda
  else
    Cadastro.FieldByName('DATAGENDA').Clear;
  Cadastro.FieldByName('INDTODOS').AsString:= VpaDLembreteCorpo.IndTodos;
  Cadastro.FieldByName('DESTITULO').AsString:= VpaDLembreteCorpo.DesTitulo;
  Cadastro.FieldByName('DESLEMBRETE').AsString:= VpaDLembreteCorpo.DesLembrete;

  if Cadastro.State = dsInsert then
    VpaDLembreteCorpo.SeqLembrete:= RSeqLembreteDisponivel;
  Cadastro.FieldByName('SEQLEMBRETE').AsInteger:= VpaDLembreteCorpo.SeqLembrete;
  try
    Cadastro.Post;
    if Result = '' then
      Result:= GravaDLembreteItem(VpaDLembreteCorpo);
  except
    on E:Exception do
      Result:= 'ERRO AO GRAVAR O LEMBRETE!!!'#13+E.Message;
  end;
  Cadastro.Close;
end;

{******************************************************************************}
function TRBFuncoesLembrete.GravaDLembreteItem(VpaDLembreteCorpo: TRBDLembreteCorpo): String;
var
  VpfLaco: Integer;
  VpfDLembreteItem: TRBDLembreteItem;
begin
  Result:= '';
  AdicionaSQLAbreTabela(Cadastro,'SELECT * FROM LEMBRETEUSUARIO');
  for VpfLaco:= 0 to VpaDLembreteCorpo.Usuarios.Count -1 do
  begin
    VpfDLembreteItem:= TRBDLembreteItem(VpaDLembreteCorpo.Usuarios.Items[VpfLaco]);

    if VpfDLembreteItem.CodUsuario <> 0 then
    begin
      Cadastro.Insert;

      Cadastro.FieldByName('SEQLEMBRETE').AsInteger:= VpaDLembreteCorpo.SeqLembrete;
      Cadastro.FieldByName('CODUSUARIO').AsInteger:= VpfDLembreteItem.CodUsuario;

      try
        Cadastro.Post;
      except
        on E:Exception do
          Result:= 'ERRO AO GRAVAR OS USUARIOS DO LEMBRETE!!!'#13+E.Message;
      end;
      if Result <> '' then
        Break;
    end;
  end;
  Cadastro.Close;
end;

{******************************************************************************}
function TRBFuncoesLembrete.UsuarioLeuLembrete(VpaSeqLembrete, VpaCodUsuario: Integer): String;
begin
  Result:= '';
  AdicionaSQLAbreTabela(Cadastro,'SELECT * FROM LEMBRETEITEM'+
                                 ' WHERE SEQLEMBRETE = '+IntToStr(VpaSeqLembrete)+
                                 ' AND CODUSUARIO = '+IntToStr(VpaCodUsuario));
  if Cadastro.Eof then
    Cadastro.Insert
  else
    Cadastro.Edit;

  Cadastro.FieldByName('SEQLEMBRETE').AsInteger:= VpaSeqLembrete;
  Cadastro.FieldByName('CODUSUARIO').AsInteger:= VpaCodUsuario;
  Cadastro.FieldByName('INDLIDO').AsString:= 'S';
  Cadastro.FieldByName('QTDVISUALIZACAO').AsInteger:= Cadastro.FieldByName('QTDVISUALIZACAO').AsInteger+1;

  try
    Cadastro.Post;
  except
    on E:Exception do
      Result:= 'ERRO AO ATUALIZAR A TABELA DE LEITURA DOS LEMBRETES'#13+E.Message;
  end;
  Cadastro.Close;
end;

{******************************************************************************}
procedure TRBFuncoesLembrete.CarDLembrete(VpaSeqLembrete: Integer; VpaDLembreteCorpo: TRBDLembreteCorpo);
begin
  AdicionaSQLAbreTabela(Tabela,'SELECT * FROM LEMBRETECORPO'+
                               ' WHERE SEQLEMBRETE = '+IntToStr(VpaSeqLembrete));

  VpaDLembreteCorpo.SeqLembrete:= Tabela.FieldByName('SEQLEMBRETE').AsInteger;
  VpaDLembreteCorpo.CodUsuario:= Tabela.FieldByName('CODUSUARIO').AsInteger;
  VpaDLembreteCorpo.DatLembrete:= Tabela.FieldByName('DATLEMBRETE').AsDateTime;
  VpaDLembreteCorpo.DatAgenda:= Tabela.FieldByName('DATAGENDA').AsDateTime;
  VpaDLembreteCorpo.IndAgendar:= Tabela.FieldByName('INDAGENDAR').AsString;
  VpaDLembreteCorpo.IndTodos:= Tabela.FieldByName('INDTODOS').AsString;
  VpaDLembreteCorpo.DesTitulo:= Tabela.FieldByName('DESTITULO').AsString;
  VpaDLembreteCorpo.DesLembrete:= Tabela.FieldByName('DESLEMBRETE').AsString;
  Tabela.Close;
  CarDUsuariosLembrete(VpaSeqLembrete, VpaDLembreteCorpo);
end;

{******************************************************************************}
procedure TRBFuncoesLembrete.CarDUsuariosLembrete(VpaSeqLembrete: Integer; VpaDLembreteCorpo: TRBDLembreteCorpo);
var
  VpfDLembreteItem: TRBDLembreteItem;
begin
  AdicionaSQLAbreTabela(Tabela,'SELECT * FROM LEMBRETEUSUARIO'+
                               ' WHERE SEQLEMBRETE = '+IntToStr(VpaSeqLembrete));
  while not Tabela.Eof do
  begin
    VpfDLembreteItem:= VpaDLembreteCorpo.AddUsuario;

    VpfDLembreteItem.CodUsuario:= Tabela.FieldByName('CODUSUARIO').AsInteger;
    Tabela.Next;
  end;
  Tabela.Close;
end;

{******************************************************************************}
procedure TRBFuncoesLembrete.CarDUsuariosSistema(VpaUsuarios: TList; VpaCodGrupo: Integer = 0);
var
  VpfDUsuario: TRBDLembreteItem;
begin
  FreeTObjectsList(VpaUsuarios);
  Tabela.Close;
  Tabela.SQL.Clear;
  Tabela.SQL.Add('SELECT * FROM CADUSUARIOS');
  Tabela.SQL.Add(' WHERE C_USU_ATI = ''S''');
  if VpaCodGrupo <> 0 then
    Tabela.SQL.Add(' AND I_COD_GRU = '+IntToStr(VpaCodGrupo));
  Tabela.SQL.Add(' AND I_EMP_FIL = '+IntToStr(Varia.CodigoEmpFil));
  Tabela.SQL.Add(' ORDER BY C_NOM_USU');

  Tabela.Open;
  while not Tabela.Eof do
  begin
    VpfDUsuario:= TRBDLembreteItem.Cria(False);
    VpaUsuarios.Add(VpfDUsuario);
    VpfDUsuario.CodUsuario:= Tabela.FieldByName('I_COD_USU').AsInteger;
    VpfDUsuario.NomUsuario:= Tabela.FieldByName('C_NOM_USU').AsString;
    Tabela.Next;
  end;
  Tabela.Close;
end;

end.
