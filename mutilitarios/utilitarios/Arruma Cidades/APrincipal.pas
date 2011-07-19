unit APrincipal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, Buttons;

type
  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    BaseDados: TDatabase;
    Clientes: TQuery;
    Aux: TQuery;
    Aux1: TQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

Uses FunSql, ConstMsg,FunString;

{$R *.DFM}

{******************************************************************************}
procedure TForm1.FormCreate(Sender: TObject);
begin
BaseDados.Open;
end;

{******************************************************************************}
procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  BaseDados.Close;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
var
  VpfProximoCodCidade,VpfCodCidade : Integer;
begin
  AdicionaSQLAbreTabela(Clientes,'Select * from CADCLIENTES '+
                                 ' Where COD_CIDADE IS NULL '+
                                 ' AND C_CID_CLI IS NOT NULL');
  While not Clientes.Eof do
  begin
    adicionaSqlAbreTabela(Aux,'Select * from CAD_CIDADES '+
                              ' Where DES_CIDADE = '''+UpperCase(DeletaChars(Clientes.FieldByName('C_CID_CLI').AsString,''''))+'''');
    if not Aux.Eof then
    begin
      ExecutaComandoSql(Aux1,'Update CADCLIENTES '+
                             ' Set COD_CIDADE =  '+ Aux.FieldByName('COD_CIDADE').AsString +
                             ' where I_COD_CLI = '+Clientes.FieldByName('I_COD_CLI').AsString);
    end;
    Clientes.Next;
  end;
  AdicionaSQLAbreTabela(Aux,'Select max(COD_CIDADE) Ultimo from CAD_CIDADES ');
  VpfProximoCodCidade := Aux.FieldByName('ULTIMO').AsInteger;
  AdicionaSQLAbreTabela(Clientes,'Select * from CADCLIENTES '+
                                 ' Where COD_CIDADE IS NULL '+
                                 ' AND C_CID_CLI IS NOT NULL'+
                                 ' and C_EST_CLI IS NOT NULL');
  while not Clientes.Eof do
  begin
    AdicionaSqlAbreTabela(Aux,'Select * from CAD_ESTADOS '+
                              ' Where COD_ESTADO = '''+UpperCase(Clientes.FieldByName('C_EST_CLI').AsString)+'''');
    if Aux.eof then
    begin
      ExecutaComandoSql(Aux,'Insert into CAD_ESTADOS(COD_ESTADO,COD_PAIS,DES_ESTADO)'+
                            ' VALUES('''+Clientes.FieldByName('C_EST_CLI').AsString+''',''BR'','''+Clientes.FieldByName('C_EST_CLI').AsString+''')');
    end;

    adicionaSqlAbreTabela(Aux,'Select * from CAD_CIDADES '+
                              ' Where DES_CIDADE = '''+UpperCase(DeletaChars(Clientes.FieldByName('C_CID_CLI').AsString,''''))+'''');
    IF Aux.Eof then
    begin
      inc(VpfProximoCodCidade);
      ExecutaComandoSql(Aux,'insert into CAD_CIDADES (COD_CIDADE,COD_ESTADO,COD_PAIS,DES_CIDADE) VALUES ('+
                          IntToStr(VpfProximoCodCidade)+','''+Clientes.FieldByName('C_EST_CLI').AsString +
                          ''',''BR'',''' +Uppercase(DeletaChars(Clientes.FieldByName('c_cid_cli').AsString,''''))+''')');
      VpfCodCidade := VpfProximoCodCidade;
    end
    else
      VpfCodCidade := Aux.FieldByName('COD_CIDADE').AsInteger;
    ExecutaComandoSql(Aux,'Update CADCLIENTES '+
                             ' Set COD_CIDADE =  '+ intToStr(VpfCodcidade) +
                             ' where I_COD_CLI = '+Clientes.FieldByName('I_COD_CLI').AsString);
    Clientes.Next;
  end;

  Aviso('Corrigido com sucesso!!!');
end;

end.
