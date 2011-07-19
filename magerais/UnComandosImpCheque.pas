unit UnComandosImpCheque;

interface

uses
 SysUtils, Classes, StdCtrls;

// suporte
// 021 41 356-3233
// 021 41 356-2324

// CTB  Constantes Bematech

// codigo da impressora ECF
// 1 Bematech MP-20 FI II

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
       Classe de funcoes da Bematech
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

const
  // mensagens
  CTB_ErroPorta        = 'Erro ao inicializar porta %s !!';
  CTB_ErroLiberaPorta  = 'Erro ao tentar liberar porta %s !!';
  CTB_ErroComuFisica   = 'Erro de comunucação física.';
  CTB_ErroQdadeCaracter= 'A Quantidade maxima de caracteres para este procedimento é de %s.';
  CTB_ValorForaFaixa   = 'O valor %s esta acima da faixa permitida!!';

  CTB_NomeArqConfig = 'mp20fi.ret';
  CTB_NomeArqStatus = 'Status.ret';


type
 TECFBematechDP20Plus= class
  private
  public
    constructor Criar;
    destructor Destroy; override;
    function AbrePorta( porta : string ) : Boolean;  //DLL
    function FecharPorta( porta : string ) : Boolean;                  //DLL

    procedure ImprimeCheques( NumBanco, Valor,Favor, Cidade, data , Msg : string);
    procedure ImprimeTexto( texto : string);
end;

// Função para abrir a porta de comunicação.

// Função para fechar a porta de comunicação.

// Função para imprimir o cheque.


implementation

uses constmsg, funstring, funnumeros, fundata, funBases;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                 procedimentos da classe
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }



{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                 Chamadas direta a DLL  - dp2032.DLL -
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

constructor TECFBematechDP20Plus.criar;
begin
  inherited;
end;

destructor TECFBematechDP20Plus.Destroy;
begin
  inherited
end;

{ *********************** Verifica e  Abre a porta de comunicacao ************ }
function TECFBematechDP20Plus.AbrePorta( porta : string ) : Boolean;
var
   Retorno : integer;
begin
   // abre e verifica se a porta esta ativa
//   Retorno := Bematech_DP_IniciaPorta(porta);
   result := true;
   if Retorno <= 0 then
   begin
     erroFormato(CTB_ErroPorta, [ porta ]);
     result := false;
   end;
end;

{ *********** verifica e fecha a porta de comunicacao ************************ }
function TECFBematechDP20Plus.FecharPorta( porta : string ) : Boolean;
var
   Retorno : integer;
begin
// Retorno := Bematech_DP_FechaPorta();
 result := false;
 if Retorno = 0 then
    ErroFormato(CTB_ErroLiberaPorta, [ Porta ] )
 else
    result := true;
end;


{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                   Atividades na impressora de cheque
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }


procedure TECFBematechDP20Plus.ImprimeCheques( NumBanco, Valor,Favor, Cidade, data , Msg : string);
begin
//  Bematech_DP_ImprimeCheque(NumBanco, Valor, Favor, Cidade, data, Msg );
end;

procedure TECFBematechDP20Plus.ImprimeTexto( texto : string);
begin
// ComandoTX('sergio',6);
end;


end.
