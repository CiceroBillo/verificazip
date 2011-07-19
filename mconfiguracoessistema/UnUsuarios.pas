unit UnUsuarios;

interface
uses
  UnDados,
  Forms, Classes, SysUtils, SQLExpr,tabela;

type
  TRBFuncoesUsuario = class
    private
      Aux,
      Tabela: TSQLQuery;
      Cadastro : TSQL;
    public
      constructor Cria(VpaBaseDados : TSqlConnection);
      destructor Destroy; override;
      procedure CarDUsuarioVendedor(VpaCodUsuario: Integer; VpaUsuarios: TList);
      function GravaDUsuarioVendedor(VpaCodUsuario: Integer; VpaUsuarios: TList): String;
      function VendedorJaUsado(VpaCodVenvedor, VpaPosicao: Integer; VpaUsuarioVendedor: TList): Boolean;
end;

implementation
uses
  FunObjeto, FunSQL;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                    TFunUsuario
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************************************************************}
constructor TRBFuncoesUsuario.Cria(VpaBaseDados : TSqlConnection);
begin
  inherited Create;
  Aux:= TSQLQuery.Create(Application);
  Aux.SQLConnection := VpaBaseDados;
  Tabela:= TSQLQuery.Create(Application);
  Tabela.SQLConnection := VpaBaseDados;
  Cadastro:= TSQL.Create(Application);
  Cadastro.ASQLConnection := VpaBaseDados;
end;

{******************************************************************************}
destructor TRBFuncoesUsuario.Destroy;
begin
  Aux.Free;
  Tabela.Free;
  Cadastro.Free;
  inherited Destroy;
end;

{******************************************************************************}
procedure TRBFuncoesUsuario.CarDUsuarioVendedor(VpaCodUsuario: Integer;
  VpaUsuarios: TList);
var
  VpfDUsuarioVendedor: TRBDUsuarioVendedor;
begin
  FreeTObjectsList(VpaUsuarios);
  AdicionaSQLAbreTabela(Aux,'SELECT USV.CODVENDEDOR, VEN.C_NOM_VEN'+
                            ' FROM USUARIOVENDEDOR USV, CADVENDEDORES VEN'+
                            ' WHERE CODUSUARIO = '+IntToStr(VpaCodUsuario)+
                            ' AND VEN.I_COD_VEN = USV.CODVENDEDOR');
  while not Aux.Eof do
  begin
    VpfDUsuarioVendedor:= TRBDUsuarioVendedor.Cria;
    VpaUsuarios.Add(VpfDUsuarioVendedor);
    VpfDUsuarioVendedor.CodVendedor:= Aux.FieldByName('CODVENDEDOR').AsInteger;
    VpfDUsuarioVendedor.NomVendedor:= Aux.FieldByName('C_NOM_VEN').AsString;

    Aux.Next;
  end;
  Aux.Close;
end;

{******************************************************************************}
function TRBFuncoesUsuario.GravaDUsuarioVendedor(VpaCodUsuario: Integer;
  VpaUsuarios: TList): String;
var
  VpfLaco: Integer;
  VpfDUsuarioVendedor: TRBDUsuarioVendedor;
begin
  Result:= '';
  ExecutaComandoSql(Aux,'DELETE FROM USUARIOVENDEDOR WHERE CODUSUARIO = '+IntToStr(VpaCodUsuario));
  AdicionaSQLAbreTabela(Cadastro,'SELECT * FROM USUARIOVENDEDOR');
  for VpfLaco:= 0 to VpaUsuarios.Count-1 do
  begin
    Cadastro.Insert;
    VpfDUsuarioVendedor:= TRBDUsuarioVendedor(VpaUsuarios.Items[VpfLaco]);
    Cadastro.FieldByName('CODUSUARIO').AsInteger:= VpaCodUsuario;
    Cadastro.FieldByName('CODVENDEDOR').AsInteger:= VpfDUsuarioVendedor.CodVendedor;
    try
      Cadastro.post;
    except
      on E:Exception do
        Result:= 'ERRO NA GRAVAÇÃO DOS VENDEDORES DO USUÁRIO!!!'#13+E.Message;
    end;
  end;
  Cadastro.Close;
end;

{******************************************************************************}
function TRBFuncoesUsuario.VendedorJaUsado(VpaCodVenvedor, VpaPosicao: Integer; VpaUsuarioVendedor: TList): Boolean;
var
  VpfLaco: Integer;
  VpfDUsuarioVendedor: TRBDUsuarioVendedor;
begin
  Result:= False;
  for VpfLaco:= 0 to VpaUsuarioVendedor.Count -1 do
  begin
    if VpfLaco+1 <> VpaPosicao then
    // verifica se é diferente da linha que estou modificando
    begin
      VpfDUsuarioVendedor:= TRBDUsuarioVendedor(VpaUsuarioVendedor.Items[VpfLaco]);
      if VpfDUsuarioVendedor.CodVendedor = VpaCodVenvedor then
      begin
        Result:= True;
        Break;
      end;
    end;
  end;
end;

end.
