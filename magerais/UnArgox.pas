unit UnArgox;
{Verificado
-.edit;
}

interface

Uses SysUtils,Dialogs, UnDadosProduto, Classes, windows, UnDados;


  (*Funções da DLL de comunicação com a impressora de Codigo de Barras*)
   function  A_Set_Darkness ( darkness:integer):integer;stdcall;external 'WINPPLA.DLL';
   function  A_CreatePrn    ( selection:integer;FileName:PAnsiChar):integer;stdcall;external 'WINPPLA.DLL';
   function  A_Print_Out    ( width,height,copies,amount:integer):integer;stdcall;external 'WINPPLA.DLL';
   function  A_Prn_Text     ( x,y,ori,font,typee,hor_factor,ver_factor:integer;mode:PAnsichar;numeric:integer;data:Pansichar):integer;stdcall;external 'WINPPLA.DLL';
   function  A_Prn_Barcode  ( x,y,ori:integer;typee:PAnsichar;narrow,width,height:integer;mode:PAnsichar;numeric:integer;data:PAnsiChar):integer;stdcall;external 'WINPPLA.DLL';
   function  A_Prn_Text_TrueType ( x,y,FSize:integer;FType:AnsiChar;Fspin,FWeight,FItalic,FUnline,FStrikeOut:integer;id_name,data:AnsiChar;mem_mode:integer):integer;stdcall;external 'WINPPLA.DLL';
   function  A_Get_Graphic  ( x,y,mem_mode:integer;format:PAnsiChar;filename:PAnsiChar):integer;stdcall;external 'WINPPLA.DLL';
   function  A_Draw_Box     ( mode, x, y, width, height, top, side:integer):integer;stdcall;external 'WINPPLA.DLL';
   function  A_Draw_Line    (mode, x, y, width, height:integer):integer;stdcall;external 'WINPPLA.DLL';
   Procedure A_ClosePrn     ();stdcall;external 'WINPPLA.DLL';
   procedure A_Feed_Label   ();stdcall;external 'WINPPLA.DLL';
   function  A_Set_Backfeed (back :integer):integer;stdcall;external 'WINPPLA.DLL';
Type
  TRBFuncoesArgox = class
    private
      function ImprimeEtiquetaCartucho5X2e5SemLogo(VpaDPesoCartucho : TRBDPesoCartucho):Integer;
      function ImprimeEtiquetaCartucho5X2e5ComLogo(VpaDPesoCartucho : TRBDPesoCartucho):integer;
      function ImprimeEtiquetaCartucho2E5X3e5SemLogo(VpaDPesoCartucho : TRBDPesoCartucho):integer;
      function ImprimeEtiquetaCartucho2E5X3e5ComLogo(VpaDPesoCartucho : TRBDPesoCartucho):integer;
    public
      constructor cria(VpaPorta : String);
      destructor destroy;override;
      function ImprimeEtiqueta(VpaDPesoCartucho : TRBDPesoCartucho):integer;
      function ImprimeEtiquetaProduto8X15(VpaEtiquetas : TList) : Integer;
      function ImprimeEtiquetaProduto50X25(VpaEtiquetas : TList) : Integer;
      function ImprimeEtiquetaKairosTexto(VpaEtiquetas : TList) : Integer;
      function ImprimeEtiquetaOrdemCorte25X50(VpaDordemOrdemProducao : TRBDOrdemProducao):string;
      function ImprimeEtiquetaOrdemProducao25X50(VpaDordemOrdemProducao : TRBDOrdemProducao):string;
      function ImprimeEtiquetaProduto54X28(VpaEtiquetas : TList) : Integer;
      function ImprimeEtiquetaProduto35X89(VpaEtiquetas : TList) : Integer;
      function ImprimeEtiquetaProduto34X23(VpaEtiquetas : TList) : Integer;
      function ImprimeEtiquetaProduto33X14(VpaEtiquetas : TList) : Integer;
      function ImprimeEtiquetaProduto100X38(VpaEtiquetas : TList) : Integer;
      function ImprimeEtiquetaSeparacao(VpaBaixas : TList):integer;
      function ImprimeEtiquetaConsumoTecido(VpaBaixas : TList): Integer;
      function ImprimeNumerosModulo10(VpaLista : TStringList): string;
      function ImprimeEtiquetaEnderecoClienteNota(VpaDNota : TRBDNotaFiscal;VpaDCliente : TRBDCliente):String;
      function ImprimeEtiquetaVolumeCotacao5x2e5(VpaDCotacao : TRBDOrcamento): String;
      function ImprimeEtiquetaRomaneioCotacao32X18(VpaDRomaneioItem : TRBDRomaneioOrcamentoItem):string;
      function ImprimeEtiquetaRomaneioCotacaoCliente(VpaDRomaneio : TRBDRomaneioOrcamento):string;
      function ImprimeEtiquetaProdutoComCodigoBarra25x35(VpaEtiquetas : TList): integer;
      procedure VoltarEtiqueta;
end;



implementation

Uses FunString, Constantes, UnOrdemProducao, unProdutos, unClientes, UnCotacao;


{******************************************************************************}
constructor TRBFuncoesArgox.cria(VpaPorta : String);
var
  VpfPorta : Integer;
  VpfLaco : INteger;
  Peso: array[0..35]of Ansichar;
begin
  inherited create;
  VpfPorta := 1;
  if uppercase(VpaPorta) = 'LPT1' then
    VpfPorta := 1
  else
    if uppercase(VpaPorta) = 'LPT2' then
      VpfPorta := 2
    else
      if uppercase(VpaPorta) = 'LPT3' then
        VpfPorta := 3
      else
        if uppercase(VpaPorta) = 'COM1' then
          VpfPorta := 4
        else
          if uppercase(VpaPorta) = 'COM2' then
            VpfPorta := 5
          else
            if uppercase(VpaPorta) = 'COM3' then
              VpfPorta := 6
            else
              VpfPorta := 10;

  CharToOem(PChar(VpaPorta), Peso);

  A_CreatePrn(VpfPorta,Peso);
//A_CreatePrn(VpfPorta,PAnsiChar(VpaPorta));
//  A_CreatePrn(VpfPorta,StrToPAnsiChar(Vpaporta));
end;

{******************************************************************************}
destructor TRBFuncoesArgox.destroy;
begin
  A_ClosePrn;
  inherited destroy;
end;

{******************************************************************************}
function TRBFuncoesArgox.ImprimeEtiquetaCartucho5X2e5SemLogo(VpaDPesoCartucho : TRBDPesoCartucho):integer;
var
  VpfTexto : AnsiString;
  VpfSeqCartucho : Integer;
begin
  VpfSeqCartucho := VpaDPesoCartucho.SeqCartucho;
  A_Prn_Barcode(15,1,1,PAnsiChar('D'),2,5,30,PAnsiChar('N'),1,StrToPAnsiChar(AdicionaCharE('0',InttoStr(VpfSeqCartucho),10)));
  VpfTexto := VpaDPesoCartucho.CodProduto;
  A_Prn_Text(10,70,1,9,5,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
  if VpaDPesoCartucho.NomCorCartucho <> '' then
    A_Prn_Text(10,50,1,9,3,1,1,PAnsiChar('N'),0,StrToPAnsiChar(AdicionaCharDE(' ',VpaDPesoCartucho.NomCorCartucho,25)));
  VpfTexto := FormatFloat('#,##0gr',VpaDPesoCartucho.PesCartucho);
  A_Prn_Text(120,26,1,9,4,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
  VpfTExto := FormatDateTime('DD/MM/YY',now);
  A_Prn_Text(180,47,4,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
  A_Prn_Text(190,55,4,9,1,1,1,PAnsiChar('N'),0,StrToPAnsiChar(FormatDateTime('HH:MM',now)));
  if VpaDPesoCartucho.IndCilindroNovo and VpaDPesoCartucho.IndChipNovo then
    A_Prn_Text(105,1,1,9,3,1,1,PAnsiChar('N'),0,StrToPAnsiChar('Cil/Chip Novo'))
  else
    if VpaDPesoCartucho.IndCilindroNovo then
      A_Prn_Text(105,1,1,9,3,1,1,PAnsiChar('N'),0,StrToPAnsiChar('Cilindro Novo'))
    else
      if VpaDPesoCartucho.IndChipNovo then
        A_Prn_Text(105,1,1,9,3,1,1,PAnsiChar('N'),0,StrToPAnsiChar('Chip Novo'));

  A_Prn_Barcode(213,1,1,PAnsiChar('D'),2,5,30,PAnsiChar('N'),1,StrToPAnsiChar(AdicionaCharE('0',InttoStr(VpfSeqCartucho),10)));
  A_Prn_Text(210,70,1,9,5,1,1,PAnsiChar('N'),0,StrToPAnsiChar(VpaDPesoCartucho.CodProduto));
  if VpaDPesoCartucho.NomCorCartucho <> '' then
    A_Prn_Text(210,50,1,9,3,1,1,PAnsiChar('N'),0,StrToPAnsiChar(AdicionaCharDE(' ',VpaDPesoCartucho.NomCorCartucho,25)));
  A_Prn_Text(375,47,4,9,1,1,1,PAnsiChar('N'),0,StrToPAnsiChar(FormatDateTime('DD/MM/YY',now)));
  A_Prn_Text(320,26,1,9,4,1,1,PAnsiChar('N'),0,StrToPAnsiChar(FormatFloat('#,##0gr',VpaDPesoCartucho.PesCartucho)));
  A_Prn_Text(385,55,4,9,1,1,1,PAnsiChar('N'),0,StrToPAnsiChar(FormatDateTime('HH:MM',now)));
  if VpaDPesoCartucho.IndCilindroNovo and VpaDPesoCartucho.IndChipNovo then
    A_Prn_Text(300,1,1,9,3,1,1,PAnsiChar('N'),0,StrToPAnsiChar('Cil/Chip Novo'))
  else
    if VpaDPesoCartucho.IndCilindroNovo then
      A_Prn_Text(300,1,1,9,3,1,1,PAnsiChar('N'),0,StrToPAnsiChar('Cilindro Novo'))
    else
      if VpaDPesoCartucho.IndChipNovo then
        A_Prn_Text(300,1,1,9,3,1,1,PAnsiChar('N'),0,StrToPAnsiChar('Chip Novo'));

  result := A_Print_Out(1,1,1,1);
end;

{******************************************************************************}
function TRBFuncoesArgox.ImprimeEtiquetaCartucho5X2e5ComLogo(VpaDPesoCartucho : TRBDPesoCartucho): Integer;
var
  VpfProduto : String;
  VpfSeqCartucho : Integer;
begin
  VpfSeqCartucho := VpaDPesoCartucho.SeqCartucho;
  if VpaDPesoCartucho.CodReduzidoCartucho <> '' then
    VpfProduto := VpaDPesoCartucho.CodProduto +'-'+VpaDPesoCartucho.CodReduzidoCartucho
  else
    VpfProduto := VpaDPesoCartucho.CodProduto +'-'+VpaDPesoCartucho.NomProduto;
  VpfProduto := copy(VpfProduto,1,24);
  A_Get_Graphic(15,65,1,PAnsiChar('B'),StrToPAnsiChar(varia.PathVersoes+'\'+intToStr(varia.CodigoEmpFil)+'a.bmp'));
  A_Prn_Text(80,75,1,9,2,1,1,PAnsiChar('N'),0,StrToPAnsiChar(Varia.FoneFilial));
  A_Prn_Barcode(22,1,1,PAnsiChar('D'),2,5,30,PAnsiChar('N'),1,StrToPAnsiChar(AdicionaCharE('0',InttoStr(VpfSeqCartucho),10)));
  A_Prn_Text(15,50,1,9,2,1,1,PAnsiChar('N'),0,StrToPAnsiChar(VpfProduto));
  A_Prn_Text(120,26,1,9,4,1,1,PAnsiChar('N'),0,StrToPAnsiChar(FormatFloat('#,##0gr',VpaDPesoCartucho.PesCartucho)));
  A_Prn_Text(180,47,4,9,1,1,1,PAnsiChar('N'),0,StrToPAnsiChar(FormatDateTime('DD/MM/YY',now)));
  A_Prn_Text(190,55,4,9,1,1,1,PAnsiChar('N'),0,StrToPAnsiChar(FormatDateTime('HH:MM',now)));
  if VpaDPesoCartucho.IndCilindroNovo and VpaDPesoCartucho.IndChipNovo then
    A_Prn_Text(112,1,1,9,3,1,1,PAnsiChar('N'),0,StrToPAnsiChar('Cil/Chip Novo'))
  else
    if VpaDPesoCartucho.IndCilindroNovo then
      A_Prn_Text(112,1,1,9,3,1,1,PAnsiChar('N'),0,StrToPAnsiChar('Cilindro Novo'))
    else
      if VpaDPesoCartucho.IndChipNovo then
        A_Prn_Text(112,1,1,9,3,1,1,PAnsiChar('N'),0,StrToPAnsiChar('Chip Novo'));

  A_Get_Graphic(210,65,1,PAnsiChar('B'),StrToPAnsiChar(varia.PathVersoes+'\'+intToStr(varia.CodigoEmpFil)+'a.bmp'));
  A_Prn_Text(275,75,1,9,2,1,1,PAnsiChar('N'),0,StrToPAnsiChar(varia.FoneFilial ));
  A_Prn_Barcode(217,1,1,PAnsiChar('D'),2,5,30,PAnsiChar('N'),1,StrToPAnsiChar(AdicionaCharE('0',InttoStr(VpfSeqCartucho),10)));
  A_Prn_Text(210,50,1,9,2,1,1,PAnsiChar('N'),0,StrToPAnsiChar(VpfProduto));
  A_Prn_Text(375,47,4,9,1,1,1,PAnsiChar('N'),0,StrToPAnsiChar(FormatDateTime('DD/MM/YY',now)));
  A_Prn_Text(385,55,4,9,1,1,1,PAnsiChar('N'),0,StrToPAnsiChar(FormatDateTime('HH:MM',now)));
  if VpaDPesoCartucho.IndCilindroNovo and VpaDPesoCartucho.IndChipNovo then
    A_Prn_Text(307,20,1,9,3,1,1,PAnsiChar('N'),0,StrToPAnsiChar('Cil/Chip Novo'))
  else
    if VpaDPesoCartucho.IndCilindroNovo then
      A_Prn_Text(307,10,1,9,3,1,1,PAnsiChar('N'),0,StrToPAnsiChar('Cilindro Novo'))
    else
      if VpaDPesoCartucho.IndChipNovo then
        A_Prn_Text(307,1,1,9,3,1,1,PAnsiChar('N'),0,StrToPAnsiChar('Chip Novo'));

  result := A_Print_Out(1,1,1,1);
end;


{******************************************************************************}
function TRBFuncoesArgox.ImprimeEtiquetaCartucho2E5X3e5ComLogo(VpaDPesoCartucho: TRBDPesoCartucho): integer;
var
  VpfSeqCartucho : Integer;
  VpfProduto, VpfNomProduto : string;
begin
  VpfSeqCartucho := VpaDPesoCartucho.SeqCartucho;
  A_Prn_Barcode(15,5,1,PAnsiChar('D'),2,5,25,PAnsiChar('N'),1,StrToPAnsiChar(AdicionaCharE('0',InttoStr(VpfSeqCartucho),10)));
  if VpaDPesoCartucho.CodReduzidoCartucho <> '' then
    VpfProduto := VpaDPesoCartucho.CodReduzidoCartucho
  else
    VpfProduto := '('+VpaDPesoCartucho.CodProduto+')';
  A_Prn_Text(25,75,1,9,5,1,1,PAnsiChar('N'),0,StrToPAnsiChar(copy(VpfProduto,1,10)));

  VpfProduto := VpaDPesoCartucho.CodProduto+'-'+VpaDPesoCartucho.NomProduto;
  A_Prn_Text(25,65,1,9,1,1,1,PAnsiChar('N'),0,StrToPAnsiChar(copy(VpfProduto,1,26)));

  if VpaDPesoCartucho.IndCilindroNovo and VpaDPesoCartucho.IndChipNovo then
    A_Prn_Text(25,51,1,9,3,1,1,PAnsiChar('N'),0,StrToPAnsiChar('Cil/Chip Novo'))
  else
    if VpaDPesoCartucho.IndCilindroNovo then
      A_Prn_Text(25,51,1,9,3,1,1,PAnsiChar('N'),0,StrToPAnsiChar('Cilindro Novo'))
    else
      if VpaDPesoCartucho.IndChipNovo then
        A_Prn_Text(25,51,1,9,3,1,1,PAnsiChar('N'),0,StrToPAnsiChar('Chip Novo'));

  if VpaDPesoCartucho.NomCorCartucho <> '' then
    A_Prn_Text(25,38,1,9,3,1,1,PAnsiChar('N'),0,StrToPAnsiChar(VpaDPesoCartucho.NomCorCartucho));
  if VpaDPesoCartucho.QtdMLCartucho <> 0 then
    A_Prn_Text(100,38,1,9,3,1,1,PAnsiChar('N'),0,StrToPAnsiChar(FormatFloat('#,##0ml',VpaDPesoCartucho.QtdMLCartucho)));
  A_Prn_Text(103,23,1,9,4,1,1,PAnsiChar('N'),0,StrToPAnsiChar(FormatFloat('#,##0g',VpaDPesoCartucho.PesCartucho)));
  A_Prn_Text(107,15,1,9,1,1,1,PAnsiChar('N'),0,StrToPAnsiChar(FormatDateTime('DD/MM/YY',now)));
  A_Prn_Text(110,5,1,9,1,1,1,PAnsiChar('N'),0,StrToPAnsiChar(FormatDateTime('HH:MM',now)));


  A_Prn_Barcode(188,5,1,PAnsiChar('D'),2,5,25,PAnsiChar('N'),1,StrToPAnsiChar(AdicionaCharE('0',InttoStr(VpfSeqCartucho),10)));
  if VpaDPesoCartucho.CodReduzidoCartucho <> '' then
    VpfProduto := VpaDPesoCartucho.CodReduzidoCartucho
  else
    VpfProduto := '('+VpaDPesoCartucho.CodProduto+')';
  A_Prn_Text(193,75,1,9,5,1,1,PAnsiChar('N'),0,StrToPAnsiChar(copy(VpfProduto,1,10)));

  VpfProduto := VpaDPesoCartucho.CodProduto+'-'+VpaDPesoCartucho.NomProduto;
  A_Prn_Text(193,65,1,9,1,1,1,PAnsiChar('N'),0,StrToPAnsiChar(copy(VpfProduto,1,26)));

  if VpaDPesoCartucho.IndCilindroNovo and VpaDPesoCartucho.IndChipNovo then
    A_Prn_Text(193,51,1,9,3,1,1,PAnsiChar('N'),0,StrToPAnsiChar('Cil/Chip Novo'))
  else
    if VpaDPesoCartucho.IndCilindroNovo then
      A_Prn_Text(193,51,1,9,3,1,1,PAnsiChar('N'),0,StrToPAnsiChar('Cilindro Novo'))
    else
      if VpaDPesoCartucho.IndChipNovo then
        A_Prn_Text(193,51,1,9,3,1,1,PAnsiChar('N'),0,StrToPAnsiChar('Chip Novo'));


  if VpaDPesoCartucho.NomCorCartucho <> '' then
    A_Prn_Text(193,38,1,9,3,1,1,PAnsiChar('N'),0,StrToPAnsiChar(VpaDPesoCartucho.NomCorCartucho));
  if VpaDPesoCartucho.QtdMLCartucho <> 0 then
    A_Prn_Text(273,38,1,9,3,1,1,PAnsiChar('N'),0,StrToPAnsiChar(FormatFloat('#,##0ml',VpaDPesoCartucho.QtdMLCartucho)));
  A_Prn_Text(276,23,1,9,4,1,1,PAnsiChar('N'),0,StrToPAnsiChar(FormatFloat('#,##0g',VpaDPesoCartucho.PesCartucho)));
  A_Prn_Text(280,15,1,9,1,1,1,PAnsiChar('N'),0,StrToPAnsiChar(FormatDateTime('DD/MM/YY',now)));
  A_Prn_Text(283,5,1,9,1,1,1,PAnsiChar('N'),0,StrToPAnsiChar(FormatDateTime('HH:MM',now)));

  result := A_Print_Out(1,1,1,1);
end;

{******************************************************************************}
function TRBFuncoesArgox.ImprimeEtiquetaCartucho2E5X3e5SemLogo(VpaDPesoCartucho : TRBDPesoCartucho):integer;
var
  VpfSeqCartucho : Integer;
begin
  VpfSeqCartucho := VpaDPesoCartucho.SeqCartucho;
  A_Prn_Barcode(5,5,1,PAnsiChar('D'),2,5,30,PAnsiChar('N'),1,StrToPAnsiChar(AdicionaCharE('0',InttoStr(VpfSeqCartucho),10)));
  A_Prn_Text(5,70,1,9,5,1,1,PAnsiChar('N'),0,StrToPAnsiChar(VpaDPesoCartucho.CodProduto));
  if VpaDPesoCartucho.NomCorCartucho <> '' then
    A_Prn_Text(5,45,1,9,3,1,1,PAnsiChar('N'),0,StrToPAnsiChar(VpaDPesoCartucho.NomCorCartucho));
  if VpaDPesoCartucho.QtdMLCartucho <> 0 then
    A_Prn_Text(90,45,1,9,3,1,1,PAnsiChar('N'),0,StrToPAnsiChar(FormatFloat('#,##0ml',VpaDPesoCartucho.QtdMLCartucho)));
  A_Prn_Text(93,26,1,9,4,1,1,PAnsiChar('N'),0,StrToPAnsiChar(FormatFloat('#,##0g',VpaDPesoCartucho.PesCartucho)));
  A_Prn_Text(97,15,1,9,1,1,1,PAnsiChar('N'),0,StrToPAnsiChar(FormatDateTime('DD/MM/YY',now)));
  A_Prn_Text(100,5,1,9,1,1,1,PAnsiChar('N'),0,StrToPAnsiChar(FormatDateTime('HH:MM',now)));

  A_Prn_Barcode(148,5,1,PAnsiChar('D'),2,5,30,PAnsiChar('N'),1,StrToPAnsiChar(AdicionaCharE('0',InttoStr(VpfSeqCartucho),10)));
  A_Prn_Text(148,70,1,9,5,1,1,PAnsiChar('N'),0,StrToPAnsiChar(VpaDPesoCartucho.CodProduto));
  if VpaDPesoCartucho.NomCorCartucho <> '' then
    A_Prn_Text(148,50,1,9,3,1,1,PAnsiChar('N'),0,StrToPAnsiChar(VpaDPesoCartucho.NomCorCartucho));
  if VpaDPesoCartucho.QtdMLCartucho <> 0 then
    A_Prn_Text(230,50,1,9,3,1,1,PAnsiChar('N'),0,StrToPAnsiChar(FormatFloat('#,##0ml',VpaDPesoCartucho.QtdMLCartucho)));
  A_Prn_Text(238,15,1,9,1,1,1,PAnsiChar('N'),0,StrToPAnsiChar(FormatDateTime('DD/MM/YY',now)));
  A_Prn_Text(242,5,1,9,1,1,1,PAnsiChar('N'),0,StrToPAnsiChar(FormatDateTime('HH:MM',now)));

  {  A_Prn_Barcode(210,1,1,'D',2,5,30,'N',1,StrToPAnsiChar(AdicionaCharE('0',InttoStr(VpaDPesoCartucho.SeqCartucho),10)));
  A_Prn_Text(210,70,1,9,5,1,1,'N',0,StrToPAnsiChar(VpaDPesoCartucho.CodProduto));
  if VpaDPesoCartucho.NomCorCartucho <> '' then
    A_Prn_Text(210,50,1,9,3,1,1,'N',0,StrToPAnsiChar(AdicionaCharDE(' ',VpaDPesoCartucho.NomCorCartucho,25)));
  A_Prn_Text(375,47,4,9,1,1,1,'N',0,StrToPAnsiChar(FormatDateTime('DD/MM/YY',now)));
  A_Prn_Text(320,26,1,9,4,1,1,'N',0,StrToPAnsiChar(FormatFloat('#,##0gr',VpaDPesoCartucho.PesCartucho)));
  A_Prn_Text(385,55,4,9,1,1,1,'N',0,StrToPAnsiChar(FormatDateTime('HH:MM',now)));}

  result := A_Print_Out(1,1,1,1);
end;

{******************************************************************************}
function TRBFuncoesArgox.ImprimeEtiqueta(VpaDPesoCartucho : TRBDPesoCartucho):integer;
begin
  if VpaDPesoCartucho.DesTipoCartucho = 'TI' then //cartucho de tinta
  begin                                           // se estiver em branco é para dar preferencia para o toner.
    case varia.ModeloEtiquetaCartuchoTinta of
      0 : Result := ImprimeEtiquetaCartucho2E5X3e5SemLogo(VpaDPesoCartucho);
      1 : Result := ImprimeEtiquetaCartucho2E5X3e5ComLogo(VpaDPesoCartucho);
    end;
  end
  else
  begin//cartucho de toner.
    case Varia.ModeloEtiquetaCartuchoToner of
      0 : result := ImprimeEtiquetaCartucho5X2e5ComLogo(VpaDPesoCartucho);
      1 : result := ImprimeEtiquetaCartucho5X2e5SemLogo(VpaDPesoCartucho);
      2 : Result := ImprimeEtiquetaCartucho2E5X3e5ComLogo(VpaDPesoCartucho);
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesArgox.ImprimeEtiquetaProduto8X15(VpaEtiquetas : TList) : Integer;
var
  VpfPosicaoX: Integer;
  VpfLacoEtiquetas, VpfLacoQtd, VpfColuna, VpfQtdEtiquetasImpressas : Integer;
  VpfDEtiquetaPrincipal, VpfDEtiquetaCopia: TRBDEtiquetaProduto;
  VpfCodProduto,VpfSeqProduto,VpfNomProduto, VpfNumPedido : String;
begin
  Result := 0;
  VpfColuna := -1;
  for VpfLacoEtiquetas := 0 to VpaEtiquetas.Count - 1 do
  begin
    VpfDEtiquetaPrincipal := TRBDEtiquetaProduto(VpaEtiquetas.Items[VpfLacoEtiquetas]);

    if VpfLacoEtiquetas > 0 then
    begin
      inc(VpfColuna);
      VpfPosicaoX := VpfColuna * 59;
      A_Prn_Text(VpfPosicaoX+25,15,4,9,3,1,1,PAnsiChar('N'),0,PAnsiChar('OUTRO'));
      A_Prn_Text(VpfPosicaoX+45,15,4,9,3,1,1,PAnsiChar('N'),0,PAnsiChar('PRODUTO'));
    end;

    while (VpfDEtiquetaPrincipal.QtdEtiquetas > 0)  do
    begin
      VpfQtdEtiquetasImpressas := 0;
      for VpfLacoQtd := 1 to VpfDEtiquetaPrincipal.QtdEtiquetas do
      begin
        VpfDEtiquetaCopia := TRBDEtiquetaProduto.cria;
        VpfDEtiquetaCopia.Produto := TRBDProduto.Cria;
        FunProdutos.CarDProduto(VpfDEtiquetaCopia.Produto,VpfDEtiquetaPrincipal.Produto.CodEmpresa,VpfDEtiquetaPrincipal.Produto.CodEmpFil,VpfDEtiquetaPrincipal.Produto.SeqProduto);
        VpfDEtiquetaCopia.NumPedido := VpfDEtiquetaPrincipal.NumPedido;
        VpfDEtiquetaCopia.IndParaEstoque := VpfDEtiquetaPrincipal.IndParaEstoque;
        inc(VpfColuna);
        if VpfColuna > 6 then
           break;
        inc(VpfQtdEtiquetasImpressas);
        VpfPosicaoX := VpfColuna * 59;
        VpfCodProduto := VpfDEtiquetaCopia.Produto.CodProduto;
        VpfNomProduto := Copy(VpfDEtiquetaCopia.Produto.NomProduto,1,19);
        VpfNumPedido := IntToStr(VpfDEtiquetaCopia.NumPedido);
        if VpfDEtiquetaCopia.IndParaEstoque then
        begin
          VpfSeqProduto := AdicionaCharE('0',InttoStr(VpfDEtiquetaCopia.Produto.SeqProduto),6);
          A_Prn_Text(VpfPosicaoX+10,1,1,9,1,1,1,PAnsiChar('N'),0,StrToPAnsiChar(VpfCodProduto));
          A_Prn_Text(VpfPosicaoX+15,95,1,9,1,1,1,PAnsiChar('N'),0,StrToPAnsiChar(FormatDateTime('DD/MM/YY',now)));
          A_Prn_Barcode(VpfPosicaoX+51,14,4,PAnsiChar('D'),3,6,30,PAnsiChar('N'),1,StrToPAnsiChar(VpfSeqProduto));
          A_Prn_Text(VpfPosicaoX+60,15,4,9,1,1,1,PAnsiChar('N'),0,StrToPAnsiChar(VpfNomProduto));
        end
        else
        begin
          VpfSeqProduto := AdicionaCharE('0',InttoStr(VpfDEtiquetaCopia.Produto.SeqProduto),5);
          A_Prn_Barcode(VpfPosicaoX+50,4,4,PAnsiChar('D'),3,6,30,PAnsiChar('N'),1,StrToPAnsiChar(VpfSeqProduto));
          A_Prn_Text(VpfPosicaoX+15,95,1,9,1,1,1,PAnsiChar('N'),0,StrToPAnsiChar(VpfNumPedido));
          A_Prn_Text(VpfPosicaoX+63,15,4,9,2,1,1,PAnsiChar('N'),0,StrToPAnsiChar(VpfCodProduto));
        end;
      end;
      if VpfColuna >= 6 then
      begin
        result := A_Print_Out(1,1,1,1);
        VpfColuna := -1;
      end;
      VpfDEtiquetaPrincipal.QtdEtiquetas := VpfDEtiquetaPrincipal.QtdEtiquetas - VpfQtdEtiquetasImpressas;
    end;
  end;
  if VpfColuna > -1 then
  begin
    result := A_Print_Out(1,1,1,1);
  end;
end;

{******************************************************************************}
function TRBFuncoesArgox.ImprimeEtiquetaProdutoComCodigoBarra25x35(VpaEtiquetas : TList): Integer;
var
  VpfPosicaoX : Integer;
  VpfLacoEtiquetas, VpfLacoQtd, VpfColuna, VpfQtdEtiquetasImpressas : Integer;
  VpfDEtiqueta : TRBDEtiquetaProduto;
  VpfTexto  : AnsiString;
begin
  Result := 0;
  VpfColuna := -1;
  for VpfLacoEtiquetas := 0 to VpaEtiquetas.Count - 1 do
  begin
    VpfDEtiqueta := TRBDEtiquetaProduto(VpaEtiquetas.Items[VpfLacoEtiquetas]);
    while (VpfDEtiqueta.QtdEtiquetas > 0)  do
    begin
      VpfQtdEtiquetasImpressas := 0;
      for VpfLacoQtd := 1 to VpfDEtiqueta.QtdEtiquetas do
      begin
        inc(VpfColuna);
        if VpfColuna > 3 then
           break;
        inc(VpfQtdEtiquetasImpressas);
        VpfPosicaoX := VpfColuna * 98;
        VpfTexto:= copy(VpfDEtiqueta.Produto.NomProduto,1,19);
        A_Prn_Text(VpfPosicaoX+20,1,4,9,2,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
        if Length(VpfDEtiqueta.Produto.NomProduto) > 17  then
        begin
          VpfTexto:= copy(VpfDEtiqueta.Produto.NomProduto,20,19);
          A_Prn_Text(VpfPosicaoX+33,1,4,9,2,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
        end;
        VpfTexto:= 'REF: ' + VpfDEtiqueta.Produto.CodProduto + '-' + FunCotacao.RNomClassificacao(VpfDEtiqueta.Produto.CodClassificacao);
        VpfTexto := copy(VpfTexto,1,19);
        A_Prn_Text(VpfPosicaoX+46,1,4,9,2,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
        VpfTexto:= 'BRASIL';
        A_Prn_Text(VpfPosicaoX+59,1,4,9,2,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
        if VpfDEtiqueta.DesCodBarras <> '' then
        begin
          VpfTExto := VpfDEtiqueta.DesCodBarras;
          A_Prn_Barcode(VpfPosicaoX+100,4,4,PAnsiChar('F'),2,8,25,PAnsiChar('N'),1,PAnsiChar(VpfTexto));
        end;
      end;
      if VpfColuna >= 4 then
      begin
        result := A_Print_Out(1,1,1,1);
        VpfColuna := -1;
      end;
      VpfDEtiqueta.QtdEtiquetas := VpfDEtiqueta.QtdEtiquetas - VpfQtdEtiquetasImpressas;
    end;
  end;
  if VpfColuna > -1 then
  begin
    result := A_Print_Out(1,1,1,1);
  end;
end;

{******************************************************************************}
function TRBFuncoesArgox.ImprimeEtiquetaRomaneioCotacao32X18(VpaDRomaneioItem: TRBDRomaneioOrcamentoItem): string;
var
  VpfPosicaoX: Integer;
  VpfColuna : Integer;
  VpfQtdProduto, VpfQtdImprimir : Double;
  VpfTexto: AnsiString;
begin
  Result := '';
  VpfColuna := -1;
  if VpaDRomaneioItem.QtdEmbalagem > 0 then
  begin
    VpfQtdProduto := VpaDRomaneioItem.QtdProduto;
    while VpfQtdProduto > 0 do
    begin
      inc(VpfColuna);
      VpfPosicaoX := VpfColuna * 124;
      VpfTexto := 'VENETO BORD. LTDA';
      A_Prn_Text(VpfPosicaoX+10,60,1,9,2,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
      VpfTexto := 'REF: '+VpaDRomaneioItem.CodProduto+' / '+IntToStr(VpaDRomaneioItem.CodCor);
      A_Prn_Text(VpfPosicaoX+10,47,1,9,2,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
      if VpfQtdProduto > VpaDRomaneioItem.QtdEmbalagem then
        VpfQtdImprimir := VpaDRomaneioItem.QtdEmbalagem
      else
        VpfQtdImprimir := VpfQtdProduto;
      VpfTexto :=  FormatFloat('#,###,##0',VpfQtdImprimir)+' PC';
      A_Prn_Text(VpfPosicaoX+10,34,1,9,2,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));

      VpfQtdProduto := VpfQtdProduto - VpaDRomaneioItem.QtdEmbalagem;

      VpfTexto := 'REF. CLI: ';
      A_Prn_Text(VpfPosicaoX+10,21,1,9,2,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));

      VpfTexto := VpaDRomaneioItem.DesReferenciaCliente;
      A_Prn_Text(VpfPosicaoX+10,8,1,9,2,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));


      if VpfColuna >= 2 then
      begin
        VpfColuna := -1;
        A_Print_Out(1,1,1,1);
      end;
    end;
  end;
  if VpfColuna > -1 then
  begin
    A_Print_Out(1,1,1,1);
  end;
end;

{******************************************************************************}
function TRBFuncoesArgox.ImprimeEtiquetaRomaneioCotacaoCliente(VpaDRomaneio: TRBDRomaneioOrcamento): string;
var
  VpfPosicaoX: Integer;
  VpfColuna : Integer;
  VpfQtdVolume, VpfQtdImprimir : Double;
  VpfTexto: AnsiString;
  VpfDCliente: TRBDCliente;
begin
  Result := '';
  VpfDCliente:= TRBDCliente.cria;
  VpfDCliente.CodCliente:= VpaDRomaneio.CodCliente;
  FunClientes.CarDCliente(VpfDCliente);
  if VpaDRomaneio.QtdVolume > 0 then
  begin
    VpfQtdVolume := VpaDRomaneio.QtdVolume;
    while VpfQtdVolume > 0 do
    begin
      VpfPosicaoX :=0;
      VpfTexto := VpfDCliente.NomCliente; //Nome Cliente
      A_Prn_Text(VpfPosicaoX+10,130,1,9,4,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
      if VpfDCliente.DesComplementoEndereco <> '' then
        VpfTexto :=VpfDCliente.DesEndereco + ', ' + VpfDCliente.NumEndereco + ' - ' + VpfDCliente.DesComplementoEndereco
      else
        VpfTexto :=VpfDCliente.DesEndereco + ', ' + VpfDCliente.NumEndereco;
      A_Prn_Text(VpfPosicaoX+10,110,1,9,4,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto)); //Endereco

      VpfTexto := VpfDCliente.DesBairro; //Bairro
      A_Prn_Text(VpfPosicaoX+10,90,1,9,4,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
      VpfTexto := VpfDCliente.DesCidade + ' - '+ VpfDCliente.DesUF; //Cidade
      A_Prn_Text(VpfPosicaoX+10,70,1,9,4,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));

      VpfTexto := 'CEP:' + VpfDCliente.CepCliente; //Cep
      A_Prn_Text(VpfPosicaoX+10,50,1,9,4,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));

      if A_Print_Out(1,1,1,1) <> 0 then
         result := 'ERRO AO IMPRIMIR!!!'#13'Não foi possível imprimir';

      VpfQtdVolume :=  VpfQtdVolume - 1;

    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesArgox.ImprimeEtiquetaProduto50X25(VpaEtiquetas : TList) : Integer;
var
  VpfPosicaoX : Integer;
  VpfLacoEtiquetas, VpfLacoQtd, VpfColuna, VpfQtdEtiquetasImpressas, VpfSeqProduto : Integer;
  VpfDEtiqueta : TRBDEtiquetaProduto;
  VpfTexto  : AnsiString;
begin
  Result := 0;
  VpfColuna := -1;
//  VoltarEtiqueta;
  for VpfLacoEtiquetas := 0 to VpaEtiquetas.Count - 1 do
  begin
    VpfDEtiqueta := TRBDEtiquetaProduto(VpaEtiquetas.Items[VpfLacoEtiquetas]);
    while (VpfDEtiqueta.QtdEtiquetas > 0)  do
    begin
      VpfQtdEtiquetasImpressas := 0;
      for VpfLacoQtd := 1 to VpfDEtiqueta.QtdEtiquetas do
      begin
        inc(VpfColuna);
        if VpfColuna > 1 then
           break;
        inc(VpfQtdEtiquetasImpressas);
        VpfPosicaoX := VpfColuna * 200;
        VpfTexto := AdicionaCharE('0',InttoStr(VpfDEtiqueta.Produto.SeqProduto),10);
        A_Prn_Barcode(VpfPosicaoX +25,1,1,PAnsiChar('D'),2,5,30,PAnsiChar('N'),1,PAnsiChar(VpfTexto));

        VpfTexto := VpfDEtiqueta.Produto.CodProduto;
        A_Prn_Text(VpfPosicaoX+15,75,1,9,5,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
        VpfTexto := copy(VpfDEtiqueta.Produto.NomProduto,1,23);
        A_Prn_Text(VpfPosicaoX+15,60,1,9,3,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
        if Length(VpfDEtiqueta.Produto.NomProduto) > 23 then
        begin
          VpfTexto := copy(VpfDEtiqueta.Produto.NomProduto,24,23);
          A_Prn_Text(VpfPosicaoX+15,45,1,9,3,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
        end;
        VpfTexto := FormatDateTime('DD/MM/YYYY',Date);
        A_Prn_Text(VpfPosicaoX+150,15,1,9,2,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
        VpfTexto := IntToStr(VpfDEtiqueta.NumPedido);
        A_Prn_Text(VpfPosicaoX+160,5,1,9,2,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));


      end;
      if VpfColuna >= 1 then
      begin
        result := A_Print_Out(1,1,1,1);
        VpfColuna := -1;
      end;
      VpfDEtiqueta.QtdEtiquetas := VpfDEtiqueta.QtdEtiquetas - VpfQtdEtiquetasImpressas;
    end;
  end;
  if VpfColuna > -1 then
  begin
    result := A_Print_Out(1,1,1,1);
  end;
end;


{******************************************************************************}
function TRBFuncoesArgox.ImprimeEtiquetaKairosTexto(VpaEtiquetas : TList) : Integer;
var
  VpfPosicaoX : Integer;
  VpfLacoEtiquetas, VpfLacoQtd, VpfColuna, VpfQtdEtiquetasImpressas : Integer;
  VpfDEtiqueta : TRBDEtiquetaProduto;
  VpfTexto  : AnsiString;
begin
  Result := 0;
  VpfColuna := -1;
  for VpfLacoEtiquetas := 0 to VpaEtiquetas.Count - 1 do
  begin
    VpfDEtiqueta := TRBDEtiquetaProduto(VpaEtiquetas.Items[VpfLacoEtiquetas]);
    while (VpfDEtiqueta.QtdEtiquetas > 0)  do
    begin
      VpfQtdEtiquetasImpressas := 0;
      for VpfLacoQtd := 1 to VpfDEtiqueta.QtdEtiquetas do
      begin
        inc(VpfColuna);
        if VpfColuna > 2 then
           break;
        inc(VpfQtdEtiquetasImpressas);
        VpfPosicaoX := VpfColuna * 138;
        A_Prn_Text(VpfPosicaoX+13,47,1,9,1,2,1,PAnsiChar('N'),0,PAnsiChar('Pro : '));
        VpfTExto := VpfDEtiqueta.Produto.CodProduto;
        A_Prn_Text(VpfPosicaoX+50,47,1,9,1,2,1,PAnsiChar('N'),0,PAnsiChar(VpfTExto));
        VpfTExto := Copy(RetiraAcentuacao(VpfDEtiqueta.Produto.NomProduto),1,26);
        A_Prn_Text(VpfPosicaoX+13,38,1,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
        if Length(VpfDEtiqueta.Produto.NomProduto) > 26 then
        begin
          VpfTExto := Copy(RetiraAcentuacao(VpfDEtiqueta.Produto.NomProduto),27,25);
          A_Prn_Text(VpfPosicaoX+13,29,1,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
        end;
        A_Prn_Text(VpfPosicaoX+13,13,1,9,1,2,1,PAnsiChar('N'),0,PAnsiChar('Cor : '));
        VpfTexto := IntToStr(VpfDEtiqueta.CodCor);
        A_Prn_Text(VpfPosicaoX+60,13,1,9,1,3,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
        VpfTexto := Copy(RetiraAcentuacao(VpfDEtiqueta.NomCor),1,20);
        A_Prn_Text(VpfPosicaoX+13,3,1,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTExto));
        VpfTexto := FormatDateTime('DD/MM/YY',now);
        A_Prn_Text(VpfPosicaoX+133,3,4,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
      end;
      if VpfColuna >= 2 then
      begin
        result := A_Print_Out(1,1,1,1);
        VpfColuna := -1;
      end;
      VpfDEtiqueta.QtdEtiquetas := VpfDEtiqueta.QtdEtiquetas - VpfQtdEtiquetasImpressas;
    end;
  end;
  if VpfColuna > -1 then
  begin
    result := A_Print_Out(1,1,1,1);
  end;
end;

{******************************************************************************}
function TRBFuncoesArgox.ImprimeEtiquetaOrdemCorte25X50(VpaDordemOrdemProducao: TRBDOrdemProducao): string;
var
  VpfPosicaoX : Integer;
  VpfLacoOrdemCorte, VpfLacoFracao, VpfColuna: Integer;
  VpfDOrdemCorteItem : TRBDOrdemCorteItem;
  VpfDFracao : TRBDFracaoOrdemProducao;
  VpfTexto  : AnsiString;
  VpfDProduto : TRBDProduto;
begin
  Result := '';
  VpfColuna := -1;
  for VpfLacoOrdemCorte := 0 to VpaDordemOrdemProducao.OrdemCorte.Itens.Count - 1 do
  begin
    VpfDOrdemCorteItem := TRBDOrdemCorteItem(VpaDordemOrdemProducao.OrdemCorte.Itens.Items[VpfLacoOrdemCorte]);
    VpfDOrdemCorteItem.NomCor := FunProdutos.RNomeCor(IntToStr(VpfDOrdemCorteItem.CodCor));
    VpfDProduto := TRBDProduto.Cria;
    FunProdutos.CarDProduto(VpfDProduto,Varia.CodigoEmpresa,VpaDordemOrdemProducao.CodEmpresafilial,VpfDOrdemCorteItem.SeqProduto);
    if VpfDOrdemCorteItem.CodFaca <> 0 then
    begin
      for VpfLacofracao := 0 to VpaDordemOrdemProducao.Fracoes.Count - 1 do
      begin
        VpfDFracao := TRBDFracaoOrdemProducao(VpaDordemOrdemProducao.Fracoes.Items[VpfLacoFracao]);
        begin
          inc(VpfColuna);
          if VpfColuna > 3 then
          begin
            A_Print_Out(1,1,1,1);
            VpfColuna := -1;
          end;
          VpfPosicaoX := VpfColuna * 100;
          A_Prn_Text(VpfPosicaoX+25,10,4,9,1,2,2,PAnsiChar('N'),0,PAnsiChar('Fl'));
          VpfTExto := IntToStr(VpaDordemOrdemProducao.CodEmpresafilial);
          A_Prn_Text(VpfPosicaoX+25,35,4,9,1,2,2,PAnsiChar('N'),0,PAnsiChar(VpfTExto));
          A_Prn_Text(VpfPosicaoX+25,65,4,9,1,2,2,PAnsiChar('N'),0,PAnsiChar('OP'));
          VpfTExto := FormatFloat('#,###,##0',VpaDordemOrdemProducao.SeqOrdem);
          A_Prn_Text(VpfPosicaoX+25,90,4,9,1,2,2,PAnsiChar('N'),0,PAnsiChar(VpfTExto));
          A_Prn_Text(VpfPosicaoX+25,140,4,9,1,2,2,PAnsiChar('N'),0,PAnsiChar('Fra'));
          VpfTExto := IntToStr(VpfDFracao.SeqFracao);
          A_Prn_Text(VpfPosicaoX+25,170,4,9,1,2,2,PAnsiChar('N'),0,PAnsiChar(VpfTExto));

          A_Prn_Text(VpfPosicaoX+45,10,4,9,1,2,2,PAnsiChar('N'),0,PAnsiChar('Faca'));
          VpfTExto := IntToStr(VpfDOrdemCorteItem.CodFaca);
          A_Prn_Text(VpfPosicaoX+45,55,4,9,1,2,2,PAnsiChar('N'),0,PAnsiChar(VpfTExto));
          A_Prn_Text(VpfPosicaoX+45,100,4,9,1,2,2,PAnsiChar('N'),0,PAnsiChar('QTD'));
          VpfTExto := FormatFloat('#,###,##0',VpfDOrdemCorteItem.QtdProduto * VpfDFracao.QtdProduto);
          A_Prn_Text(VpfPosicaoX+45,150,4,9,1,2,2,PAnsiChar('N'),0,PAnsiChar(VpfTExto));

          A_Prn_Text(VpfPosicaoX+55,10,4,9,1,1,1,PAnsiChar('N'),0,PAnsiChar('MP'));
          VpfTExto := VpfDProduto.CodProduto + '-'+VpfDProduto.NomProduto;
          A_Prn_Text(VpfPosicaoX+55,35,4,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTExto));

          A_Prn_Text(VpfPosicaoX+65,10,4,9,1,1,1,PAnsiChar('N'),0,PAnsiChar('Cor'));
          VpfTExto := IntToStr(VpfDOrdemCorteItem.CodCor) + '-'+VpfDOrdemCorteItem.NomCor;
          A_Prn_Text(VpfPosicaoX+65,35,4,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTExto));

          A_Prn_Text(VpfPosicaoX+75,10,4,9,1,1,1,PAnsiChar('N'),0,PAnsiChar('Combinacao'));
          VpfTExto := IntToStr(VpaDordemOrdemProducao.CodCor);
          A_Prn_Text(VpfPosicaoX+75,65,4,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTExto));
        end;
        if VpfColuna >= 3 then
        begin
          A_Print_Out(1,1,1,1);
          VpfColuna := -1;
        end;
      end;
    end;
    VpfDProduto.Free;
  end;
  if VpfColuna > -1 then
  begin
    A_Print_Out(1,1,1,1);
  end;
end;

{******************************************************************************}
function TRBFuncoesArgox.ImprimeEtiquetaOrdemProducao25X50(VpaDordemOrdemProducao: TRBDOrdemProducao): string;
var
  VpfPosicaoX : Integer;
  VpfLacoFracao, VpfColuna: Integer;
  VpfDFracao : TRBDFracaoOrdemProducao;
  VpfTexto  : AnsiString;
  VpfDProduto : TRBDProduto;
  VpfNomCliente : String;
begin
  Result := '';
  VpfColuna := -1;
  VpfNomCliente := FunClientes.RNomCliente(IntToStr(VpaDordemOrdemProducao.CodCliente));
  VpfDProduto := TRBDProduto.Cria;
  FunProdutos.CarDProduto(VpfDProduto,Varia.CodigoEmpresa,VpaDordemOrdemProducao.CodEmpresafilial,VpaDordemOrdemProducao.SeqProduto);
  for VpfLacoFracao := 0 to VpaDordemOrdemProducao.Fracoes.Count - 1 do
  begin
    VpfDFracao := TRBDFracaoOrdemProducao(VpaDordemOrdemProducao.Fracoes.Items[VpfLacoFracao]);
    inc(VpfColuna);
    if VpfColuna > 3 then
    begin
      A_Print_Out(1,1,1,1);
      VpfColuna := 0;
    end;
    VpfPosicaoX := VpfColuna * 100;
    VpfTexto := 'Fl';
    A_Prn_Text(VpfPosicaoX+25,10,4,9,1,2,2,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
    VpfTExto := IntToStr(VpaDordemOrdemProducao.CodEmpresafilial);
    A_Prn_Text(VpfPosicaoX+25,35,4,9,1,2,2,PAnsiChar('N'),0,PAnsiChar(VpfTExto));
    VpfTexto := 'OP';
    A_Prn_Text(VpfPosicaoX+25,65,4,9,1,2,2,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
    VpfTExto := FormatFloat('#,###,##0',VpaDordemOrdemProducao.SeqOrdem);
    A_Prn_Text(VpfPosicaoX+25,90,4,9,1,2,2,PAnsiChar('N'),0,PAnsiChar(VpfTExto));
    A_Prn_Text(VpfPosicaoX+25,140,4,9,1,2,2,PAnsiChar('N'),0,PAnsiChar('Fra'));
    VpfTExto := IntToStr(VpfDFracao.SeqFracao);
    A_Prn_Text(VpfPosicaoX+25,170,4,9,1,2,2,PAnsiChar('N'),0,PAnsiChar(VpfTExto));

    A_Prn_Text(VpfPosicaoX+45,10,4,9,1,2,2,PAnsiChar('N'),0,PAnsiChar('QTD'));
    VpfTExto := FormatFloat('#,###,##0',VpfDFracao.QtdProduto)+' '+VpaDordemOrdemProducao.UMPedido;
    A_Prn_Text(VpfPosicaoX+45,50,4,9,1,1,2,PAnsiChar('N'),0,PAnsiChar(VpfTExto));
    A_Prn_Text(VpfPosicaoX+45,110,4,9,1,2,2,PAnsiChar('N'),0,PAnsiChar('Lote'));
    VpfTExto := IntToStr(VpfDFracao.SeqFracao)+'/'+IntToStr(VpaDordemOrdemProducao.Fracoes.Count);
     A_Prn_Text(VpfPosicaoX+45,150,4,9,1,2,2,PAnsiChar('N'),0,PAnsiChar(VpfTExto));

    A_Prn_Text(VpfPosicaoX+55,10,4,9,1,1,1,PAnsiChar('N'),0,PAnsiChar('Pro'));
    VpfTExto := VpfDProduto.CodProduto + '-'+VpfDProduto.NomProduto;
    A_Prn_Text(VpfPosicaoX+55,35,4,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTExto));

    A_Prn_Text(VpfPosicaoX+65,10,4,9,1,1,1,PAnsiChar('N'),0,PAnsiChar('Cor'));
    VpfTExto := IntToStr(VpaDordemOrdemProducao.CodCor);
    A_Prn_Text(VpfPosicaoX+65,35,4,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTExto));
    A_Prn_Text(VpfPosicaoX+65,120,4,9,1,1,1,PAnsiChar('N'),0,PAnsiChar('Entrega'));
    VpfTExto := FormatDateTime('DD/MM/YY',VpaDordemOrdemProducao.DatEntregaPrevista);
    A_Prn_Text(VpfPosicaoX+65,155,4,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTExto));

    A_Prn_Text(VpfPosicaoX+75,10,4,9,1,1,1,PAnsiChar('N'),0,PAnsiChar('Cliente'));
    VpfTExto := VpfNomCliente;
    A_Prn_Text(VpfPosicaoX+75,45,4,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTExto));

    VpfTexto := FloattoStr(VpfDFracao.CodBarras);
    A_Prn_Barcode(VpfPosicaoX+105,24,4,PAnsiChar('D'),3,6,17,PAnsiChar('N'),1,PAnsiChar(VpfTexto));
  end;
  if VpfColuna >= 3 then
  begin
    A_Print_Out(1,1,1,1);
    VpfColuna := -1;
  end;
  VpfDProduto.Free;
  if VpfColuna > -1 then
  begin
    A_Print_Out(1,1,1,1);
  end;
end;

{******************************************************************************}
function TRBFuncoesArgox.ImprimeEtiquetaProduto54X28(VpaEtiquetas : TList) : Integer;
var
  VpfPosicaoX : Integer;
  VpfLacoEtiquetas, VpfLacoQtd, VpfColuna, VpfQtdEtiquetasImpressas : Integer;
  VpfDEtiqueta : TRBDEtiquetaProduto;
  VpfNomProduto : String;
begin
  Result := 0;
  VpfColuna := -1;
  for VpfLacoEtiquetas := 0 to VpaEtiquetas.Count - 1 do
  begin
    VpfDEtiqueta := TRBDEtiquetaProduto(VpaEtiquetas.Items[VpfLacoEtiquetas]);
    while (VpfDEtiqueta.QtdEtiquetas > 0)  do
    begin
      VpfQtdEtiquetasImpressas := 0;
      for VpfLacoQtd := 1 to VpfDEtiqueta.QtdEtiquetas do
      begin
        inc(VpfColuna);
        if VpfColuna > 0 then
           break;
        inc(VpfQtdEtiquetasImpressas);
        VpfPosicaoX := VpfColuna * 195;
        if VpfDEtiqueta.Produto.CodReduzidoCartucho <> '' then
          VpfNomProduto := VpfDEtiqueta.Produto.CodReduzidoCartucho
        else
          VpfNomProduto := VpfDEtiqueta.Produto.NomProduto;

{        A_Prn_Barcode(VpfPosicaoX + 15,1,1,'D',2,5,30,'N',1,StrToPAnsiChar(AdicionaCharE('0',IntToStr(VpfDEtiqueta.Produto.SeqProduto),15)));
        A_Prn_Text(VpfPosicaoX + 15,100,1,9,2,1,1,'N',0,StrToPAnsiChar(copy(VpfNomProduto,1,29)));
        if Length(VpfNomProduto) > 29 then
          A_Prn_Text(VpfPosicaoX + 15,90,1,9,2,1,1,'N',0,StrToPAnsiChar(copy(VpfNomProduto,30,length(vpfNomProduto)-29)));
        A_Prn_Text(VpfPosicaoX + 210,10,4,9,2,1,1,'N',0,StrToPAnsiChar(CopiaAteChar(varia.NomeFilial,' ')));
        A_Prn_Text(VpfPosicaoX + 15,45,1,9,2,2,2,'N',0,StrToPAnsiChar(VpfDEtiqueta.Produto.CodProduto));}
      end;
      if VpfColuna >= 1 then
      begin
        result := A_Print_Out(1,1,1,1);
        VpfColuna := -1;
      end;
      VpfDEtiqueta.QtdEtiquetas := VpfDEtiqueta.QtdEtiquetas - VpfQtdEtiquetasImpressas;
    end;
  end;
  if VpfColuna > -1 then
  begin
    result := A_Print_Out(1,1,1,1);
  end;
end;

{******************************************************************************}
function TRBFuncoesArgox.ImprimeEtiquetaProduto100X38(VpaEtiquetas: TList): Integer;
var
  VpfPosicaoX : Integer;
  VpfLacoEtiquetas, VpfLacoQtd, VpfColuna, VpfQtdEtiquetasImpressas : Integer;
  VpfDEtiqueta : TRBDEtiquetaProduto;
  VpfTexto  : AnsiString;
begin
  Result := 0;
  VpfColuna := -1;
  for VpfLacoEtiquetas := 0 to VpaEtiquetas.Count - 1 do
  begin
    VpfDEtiqueta := TRBDEtiquetaProduto(VpaEtiquetas.Items[VpfLacoEtiquetas]);
    while (VpfDEtiqueta.QtdEtiquetas > 0)  do
    begin
      VpfQtdEtiquetasImpressas := 0;
      VpfColuna := 0;
      VpfPosicaoX := 10;
      VpfTExto := AdicionaCharE('0',IntToStr(VpfDEtiqueta.Produto.SeqProduto),5);
      A_Prn_Barcode(VpfPosicaoX+63,72,1,PAnsiChar('D'),4,10,25,PAnsiChar('N'),1,PAnsiChar(VpfTexto));
      VpfTExto := VpfDEtiqueta.Produto.CodProduto;
      A_Prn_Text(VpfPosicaoX+188,79,1,9,3,2,2,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
      A_Prn_Text(VpfPosicaoX+4,57,1,9,3,1,1,PAnsiChar('N'),0,PAnsiChar('Produto : '));
      VpfTExto := copy(RetiraAcentuacao(VpfDEtiqueta.Produto.NomProduto),1,37);
      A_Prn_Text(VpfPosicaoX+70,57,1,9,3,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTExto));
      if Length(VpfDEtiqueta.Produto.NomProduto) > 37 then
      begin
        VpfTExto := copy(RetiraAcentuacao(VpfDEtiqueta.Produto.NomProduto),38,20);
        A_Prn_Text(VpfPosicaoX+70,40,1,9,3,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTExto));
      end;
      A_Prn_Text(VpfPosicaoX+21,15,1,9,2,1,1,PAnsiChar('N'),0,PAnsiChar('Pedido : '));
      VpfTExto := RetiraAcentuacao(IntToStr(VpfDEtiqueta.NumPedido));
      A_Prn_Text(VpfPosicaoX+70,15,1,9,2,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTExto));
      A_Prn_Text(VpfPosicaoX+21,3,1,9,2,1,1,PAnsiChar('N'),0,PAnsiChar('Cliente : '));
      VpfTExto := RetiraAcentuacao(VpfDEtiqueta.Cliente);
      A_Prn_Text(VpfPosicaoX+70,3,1,9,2,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTExto));
      VpfTexto := FormatDateTime('DD/MM/YY',now);
      Sleep(1000);
      result := A_Print_Out(1,1,1,1);
      VpfDEtiqueta.QtdEtiquetas := VpfDEtiqueta.QtdEtiquetas - 1;
    end;
  end;
end;

{******************************************************************************}
function TRBFuncoesArgox.ImprimeEtiquetaProduto33X14(VpaEtiquetas: TList): Integer;
var
  VpfPosicaoX : Integer;
  VpfLacoEtiquetas, VpfLacoQtd, VpfColuna, VpfQtdEtiquetasImpressas : Integer;
  VpfDEtiqueta : TRBDEtiquetaProduto;
  VpfTexto  : AnsiString;
begin
  Result := 0;
  VpfColuna := -1;
  for VpfLacoEtiquetas := 0 to VpaEtiquetas.Count - 1 do
  begin
    VpfDEtiqueta := TRBDEtiquetaProduto(VpaEtiquetas.Items[VpfLacoEtiquetas]);
    while (VpfDEtiqueta.QtdEtiquetas > 0)  do
    begin
      VpfQtdEtiquetasImpressas := 0;
      for VpfLacoQtd := 1 to VpfDEtiqueta.QtdEtiquetas do
      begin
        inc(VpfColuna);
        if VpfColuna > 2 then
           break;
        inc(VpfQtdEtiquetasImpressas);
        VpfPosicaoX := VpfColuna * 143;
        VpfTExto := Copy(RetiraAcentuacao(VpfDEtiqueta.Produto.NomProduto),1,24);
        A_Prn_Text(VpfPosicaoX+20,32,1,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
        if Length(VpfDEtiqueta.Produto.NomProduto) > 24 then
        begin
          VpfTExto := Copy(RetiraAcentuacao(VpfDEtiqueta.Produto.NomProduto),25,25);
          A_Prn_Text(VpfPosicaoX+20,22,1,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
        end;
        VpfTExto := 'NF:' + IntToStr(VpfDEtiqueta.NumPedido);
        A_Prn_Text(VpfPosicaoX+95,5,1,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTExto));
        VpfTExto := 'COD: '+ VpfDEtiqueta.Produto.CodProduto;
        A_Prn_Text(VpfPosicaoX+20,5,1,9,3,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTExto));
//        VpfTExto := IntToStr(VpfDEtiqueta.Produto.SeqProduto);
//        A_Prn_Barcode(VpfPosicaoX+18,0,1,PAnsiChar('D'),2,5,10,PAnsiChar('N'),2,PAnsiChar(VpfTexto));
      end;
      if VpfColuna >= 2 then
      begin
        result := A_Print_Out(1,1,1,1);
        VpfColuna := -1;
      end;
      VpfDEtiqueta.QtdEtiquetas := VpfDEtiqueta.QtdEtiquetas - VpfQtdEtiquetasImpressas;
    end;
  end;
  if VpfColuna > -1 then
  begin
    result := A_Print_Out(1,1,1,1);
  end;
end;

function TRBFuncoesArgox.ImprimeEtiquetaProduto34X23(VpaEtiquetas: TList): Integer;
var
  VpfPosicaoX : Integer;
  VpfLacoEtiquetas, VpfLacoQtd, VpfColuna, VpfQtdEtiquetasImpressas : Integer;
  VpfDEtiqueta : TRBDEtiquetaProduto;
  VpfTexto  : AnsiString;
begin
  Result := 0;
  VpfColuna := -1;
  for VpfLacoEtiquetas := 0 to VpaEtiquetas.Count - 1 do
  begin
    VpfDEtiqueta := TRBDEtiquetaProduto(VpaEtiquetas.Items[VpfLacoEtiquetas]);
    while (VpfDEtiqueta.QtdEtiquetas > 0)  do
    begin
      VpfQtdEtiquetasImpressas := 0;
      for VpfLacoQtd := 1 to VpfDEtiqueta.QtdEtiquetas do
      begin
        inc(VpfColuna);
        if VpfColuna > 2 then
           break;
        inc(VpfQtdEtiquetasImpressas);
        VpfPosicaoX := VpfColuna * 138;
        VpfTExto := copy(VpfDEtiqueta.Produto.CodBarraFornecedor,1,12);
        A_Prn_Barcode(VpfPosicaoX+13,57,1,PAnsiChar('F'),2,10,25,PAnsiChar('N'),1,PAnsiChar(VpfTexto));
        A_Prn_Text(VpfPosicaoX+13,42,1,9,1,1,1,PAnsiChar('N'),0,PAnsiChar('Codigo Interno: '));
        VpfTExto := VpfDEtiqueta.Produto.CodProduto;
        A_Prn_Text(VpfPosicaoX+80,42,1,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTExto));
        VpfTExto := Copy(RetiraAcentuacao(VpfDEtiqueta.Produto.NomProduto),1,24);
        A_Prn_Text(VpfPosicaoX+13,32,1,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
        if Length(VpfDEtiqueta.Produto.NomProduto) > 24 then
        begin
          VpfTExto := Copy(RetiraAcentuacao(VpfDEtiqueta.Produto.NomProduto),25,25);
          A_Prn_Text(VpfPosicaoX+13,22,1,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
        end;
        A_Prn_Text(VpfPosicaoX+13,10,1,9,1,1,1,PAnsiChar('N'),0,PAnsiChar('Capac: '));
        VpfTexto := FormatFloat('#,###0 ml',VpfDEtiqueta.Produto.CapLiquida) ;
        A_Prn_Text(VpfPosicaoX+45,10,1,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
        A_Prn_Text(VpfPosicaoX+80,10,1,9,1,1,1,PAnsiChar('N'),0,PAnsiChar('Alt: '));
        VpfTexto := FormatFloat('#,###0 cm',VpfDEtiqueta.Produto.AltProduto) ;;
        A_Prn_Text(VpfPosicaoX+95,10,1,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
      end;
      if VpfColuna >= 2 then
      begin
        result := A_Print_Out(1,1,1,1);
        VpfColuna := -1;
      end;
      VpfDEtiqueta.QtdEtiquetas := VpfDEtiqueta.QtdEtiquetas - VpfQtdEtiquetasImpressas;
    end;
  end;
  if VpfColuna > -1 then
  begin
    result := A_Print_Out(1,1,1,1);
  end;
end;

{******************************************************************************}
function TRBFuncoesArgox.ImprimeEtiquetaProduto35X89(VpaEtiquetas : TList) : Integer;
var
  VpfPosicaoX : Integer;
  VpfLacoEtiquetas, VpfLacoQtd, VpfColuna, VpfQtdEtiquetasImpressas : Integer;
  VpfDEtiqueta : TRBDEtiquetaProduto;
  VpfTexto  : AnsiString;
begin
  Result := 0;
  VpfColuna := -1;
  for VpfLacoEtiquetas := 0 to VpaEtiquetas.Count - 1 do
  begin
    VpfDEtiqueta := TRBDEtiquetaProduto(VpaEtiquetas.Items[VpfLacoEtiquetas]);
    while (VpfDEtiqueta.QtdEtiquetas > 0)  do
    begin
      VpfQtdEtiquetasImpressas := 0;
      VpfColuna := 0;
      VpfPosicaoX := 10;
      VpfTExto := copy(VpfDEtiqueta.Produto.CodBarraFornecedor,1,12);
      A_Prn_Barcode(VpfPosicaoX+73,87,1,PAnsiChar('F'),4,10,25,PAnsiChar('N'),1,PAnsiChar(VpfTexto));
      A_Prn_Text(VpfPosicaoX+43,72,1,9,2,1,1,PAnsiChar('N'),0,PAnsiChar('Decricao : '));
      VpfTExto := copy(RetiraAcentuacao(VpfDEtiqueta.Produto.NomProduto),1,37);
      A_Prn_Text(VpfPosicaoX+99,72,1,9,2,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTExto));
      if Length(VpfDEtiqueta.Produto.NomProduto) > 37 then
      begin
        VpfTExto := copy(RetiraAcentuacao(VpfDEtiqueta.Produto.NomProduto),38,20);
        A_Prn_Text(VpfPosicaoX+99,60,1,9,2,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTExto));
      end;
      A_Prn_Text(VpfPosicaoX+15,47,1,9,2,1,1,PAnsiChar('N'),0,PAnsiChar('Codigo Interno : '));
      VpfTExto := RetiraAcentuacao(VpfDEtiqueta.Produto.CodProduto);
      A_Prn_Text(VpfPosicaoX+99,47,1,9,2,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTExto));
      A_Prn_Text(VpfPosicaoX+25,37,1,9,2,1,1,PAnsiChar('N'),0,PAnsiChar('Cap. Liquida : '));
      VpfTExto := RetiraAcentuacao(FormatFloat('#,###,##0 ml',VpfDEtiqueta.Produto.CapLiquida));
      A_Prn_Text(VpfPosicaoX+99,37,1,9,2,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTExto));
      A_Prn_Text(VpfPosicaoX+58,27,1,9,2,1,1,PAnsiChar('N'),0,PAnsiChar('Altura : '));
      VpfTExto := RetiraAcentuacao(FormatFloat('#,###,##0 cm',VpfDEtiqueta.Produto.AltProduto));
      A_Prn_Text(VpfPosicaoX+99,27,1,9,2,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTExto));
      VpfTexto := FormatDateTime('DD/MM/YY',now);
      A_Prn_Text(VpfPosicaoX+350,3,4,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
      result := A_Print_Out(1,1,1,1);
      VpfDEtiqueta.QtdEtiquetas := VpfDEtiqueta.QtdEtiquetas - 1;
    end;
  end;
END;

{******************************************************************************}
function TRBFuncoesArgox.ImprimeEtiquetaSeparacao(VpaBaixas : TList):integer;
var
  VpfPosicaoX : Integer;
  VpfLaco, VpfLacoQtd, VpfColuna, VpfQtdEtiquetasImpressas : Integer;
  VpfDProdutoBaixa : TRBDConsumoFracaoOP;
  VpfDFracao : TRBDFracaoOrdemProducao;
  VpfTexto, VpfTexto2 : AnsiString;
begin
  Result := 0;
  VpfColuna := -1;
  for VpfLaco := 0 to VpaBaixas.Count - 1 do
  begin
    VpfDProdutoBaixa := TRBDConsumoFracaoOP(VpaBaixas.Items[VpfLaco]);
    if VpfDProdutoBaixa.QtdABaixar <> 0 then
    begin
      VpfDFracao := FunOrdemProducao.CarDFracaoOP(nil,VpfDProdutoBaixa.CodFilial,VpfDProdutoBaixa.SeqOrdem,VpfDProdutoBaixa.SeqFracao);
      inc(VpfColuna);
      VpfPosicaoX := VpfColuna * 140;
      VpfTexto := FloatToSTr(VpfDFracao.codBarras);
      A_Prn_Barcode(VpfPosicaoX+13,43,1,PAnsiChar('D'),2,5,15,PAnsiChar('N'),1,PAnsiChar(VpfTexto));
      VpfTexto := VpfDProdutoBaixa.CodProduto+'-'+ Copy(RetiraAcentuacao(VpfDProdutoBaixa.NomProduto),1,21);
      A_Prn_Text(VpfPosicaoX+5,35,1,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
      if Length(VpfDProdutoBaixa.NomProduto) > 21 then
      begin
        VpfTexto := Copy(RetiraAcentuacao(VpfDProdutoBaixa.NomProduto),22,30);
        A_Prn_Text(VpfPosicaoX+5,25,1,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
      end;
      VpfTexto :='Cor : '+IntToStr(VpfDProdutoBaixa.CodCor)+ Copy(RetiraAcentuacao(VpfDProdutoBaixa.NomCor),1,15);
      A_Prn_Text(VpfPosicaoX+5,13,1,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
      VpfTexto2 := 'Qtd Unitaria : '+FloatToStr(VpfDProdutoBaixa.QtdUnitario)+' '+VpfDProdutoBaixa.DesUMUnitario;
      A_Prn_Text(VpfPosicaoX+5,0,1,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto2));
      VpfTexto := 'Qtd Fra : '+ FloatToStr(VpfDFracao.QtdProduto);
      A_Prn_Text(VpfPosicaoX+127,0,4,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
      if VpfColuna >= 2 then
      begin
        result := A_Print_Out(1,1,1,1);
        VpfColuna := -1;
      end;
      VpfDFracao.free;
    end;
  end;
  if VpfColuna > -1 then
  begin
    result := A_Print_Out(1,1,1,1);
  end;
end;

{******************************************************************************}
function TRBFuncoesArgox.ImprimeEtiquetaVolumeCotacao5x2e5(
  VpaDCotacao: TRBDOrcamento): String;
var
  VpfTexto: AnsiString;
  VpfPosicaoX,
  VpfLaco,VpfLacoInt, VpfVolume, VpfQtdEtiquetaLinha, VpfQtdVolumeOriginal: Integer;
begin
  VpfPosicaoX := 0;
  VpfVolume:= 1;
  VpfQtdEtiquetaLinha:= 2;
  VpfQtdVolumeOriginal:= VpaDCotacao.QtdVolumesTransportadora;
  for VpfLaco := 0 to VpaDCotacao.QtdVolumesTransportadora - 1 do
  begin
    if VpaDCotacao.QtdVolumesTransportadora = 1 then
    begin
      VpfPosicaoX := 0;
      if VpaDCotacao.NumNotas <> '' then
      begin
        VpfTexto := 'Nota : ' + (VpaDCotacao.NumNotas);
      end
      else
      begin
        VpfTexto := 'Cotacao : ' + IntToStr(VpaDCotacao.LanOrcamento);
      end;
      A_Prn_Text(VpfPosicaoX+10,75,1,9,4,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
      VpfTexto:= FunClientes.RNomCliente(IntToStr(VpaDCotacao.CodCliente));
      A_Prn_Text(VpfPosicaoX+10,55,1,9,4,1,1,PAnsiChar('N'),0,PAnsiChar(copy(VpfTexto,1,18)));
      VpfTexto:= FunClientes.RNomCliente(IntToStr(VpaDCotacao.CodCliente));
      A_Prn_Text(VpfPosicaoX+10,35,1,9,4,1,1,PAnsiChar('N'),0,PAnsiChar(copy(VpfTexto,19,18)));
      VpfTexto:= 'Volumes : ' + IntToStr(VpfVolume) + '/' + IntToStr(VpfQtdVolumeOriginal);
      A_Prn_Text(VpfPosicaoX+10,5,1,9,4,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
      if A_Print_Out(1,1,1,1) <> 0 then
      begin
         VpfPosicaoX := -100
      end;
      VpaDCotacao.QtdVolumesTransportadora:= VpaDCotacao.QtdVolumesTransportadora - 1;
    end
    else
    begin
    if VpaDCotacao.QtdVolumesTransportadora > 1 then
    begin
      for VpfLacoInt := 0 to VpfQtdEtiquetaLinha - 1 do
      begin
        if VpaDCotacao.NumNotas <> '' then
        begin
          VpfTexto := 'Nota : ' + (VpaDCotacao.NumNotas);
        end
        else
        begin
          VpfTexto := 'Cotacao : ' + IntToStr(VpaDCotacao.LanOrcamento);
        end;
        A_Prn_Text(VpfPosicaoX+10,75,1,9,4,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
        VpfTexto:= FunClientes.RNomCliente(IntToStr(VpaDCotacao.CodCliente));
        A_Prn_Text(VpfPosicaoX+10,55,1,9,4,1,1,PAnsiChar('N'),0,PAnsiChar(copy(VpfTexto,1,18)));
        VpfTexto:= FunClientes.RNomCliente(IntToStr(VpaDCotacao.CodCliente));
        A_Prn_Text(VpfPosicaoX+10,35,1,9,4,1,1,PAnsiChar('N'),0,PAnsiChar(copy(VpfTexto,19,18)));
        VpfTexto:= 'Volumes : ' + IntToStr(VpfVolume) + '/' + IntToStr(VpfQtdVolumeOriginal);
        A_Prn_Text(VpfPosicaoX+10,5,1,9,4,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
        VpfVolume:= VpfVolume+1;
        VpfPosicaoX := VpfPosicaoX + 200;
      end;
      if A_Print_Out(1,1,1,1) <> 0 then
      begin
        VpfPosicaoX := -100
      end;
      VpaDCotacao.QtdVolumesTransportadora:= VpaDCotacao.QtdVolumesTransportadora - 2;
      VpfPosicaoX := 0;
    end;
  end;
  end;
end;

{******************************************************************************}
function TRBFuncoesArgox.ImprimeEtiquetaConsumoTecido(VpaBaixas : TList): Integer;
var
  VpfPosicaoX : Integer;
  VpfLaco, VpfLacoQtd, VpfColuna, VpfQtdEtiquetasImpressas : Integer;
  VpfDProdutoBaixa : TRBDConsumoFracaoOP;
  VpfDFracao : TRBDFracaoOrdemProducao;
  VpfTexto, VpfTexto2 : AnsiString;
begin
  Result := 0;
  VpfColuna := -1;
  for VpfLaco := 0 to VpaBaixas.Count - 1 do
  begin
    VpfDProdutoBaixa := TRBDConsumoFracaoOP(VpaBaixas.Items[VpfLaco]);
    if VpfDProdutoBaixa.QtdABaixar <> 0 then
    begin
      VpfDFracao := FunOrdemProducao.CarDFracaoOP(nil,VpfDProdutoBaixa.CodFilial,VpfDProdutoBaixa.SeqOrdem,VpfDProdutoBaixa.SeqFracao);
      inc(VpfColuna);
      VpfPosicaoX := VpfColuna * 140;
      VpfTexto := FloatToSTr(VpfDFracao.codBarras);
      VpfTexto := 'Fil : '+ IntToStr(VpfDFracao.CodFilial)+ '    OP : '+IntToStr(VpfDFracao.SeqOrdemProducao);
      A_Prn_Text(VpfPosicaoX+13,46,1,9,2,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
      VpfTexto := VpfDProdutoBaixa.CodProduto+'-'+ Copy(RetiraAcentuacao(VpfDProdutoBaixa.NomProduto),1,21);
      A_Prn_Text(VpfPosicaoX+5,35,1,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
      if Length(VpfDProdutoBaixa.NomProduto) > 21 then
      begin
        VpfTexto := Copy(RetiraAcentuacao(VpfDProdutoBaixa.NomProduto),22,30);
        A_Prn_Text(VpfPosicaoX+5,25,1,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
      end;
      VpfTexto :='Cor : '+IntToStr(VpfDProdutoBaixa.CodCor)+ Copy(RetiraAcentuacao(VpfDProdutoBaixa.NomCor),1,19);
      A_Prn_Text(VpfPosicaoX+5,13,1,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
      VpfTexto2 := 'Qtd Total : '+FloatToStr(VpfDProdutoBaixa.QtdABaixar)+' '+VpfDProdutoBaixa.DesUM;
      A_Prn_Text(VpfPosicaoX+5,0,1,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto2));
      if VpfColuna >= 2 then
      begin
        result := A_Print_Out(1,1,1,1);
        VpfColuna := -1;
      end;
      VpfDFracao.free;
    end;
  end;
  if VpfColuna > -1 then
  begin
    result := A_Print_Out(1,1,1,1);
  end;
end;

{******************************************************************************}
function TRBFuncoesArgox.ImprimeEtiquetaEnderecoClienteNota(VpaDNota: TRBDNotaFiscal; VpaDCliente: TRBDCliente): String;
var
  VpfTexto, VpfTexto2 : AnsiString;
  VpfPularLinha : Integer;
begin
  VpfPularLinha := 0;
  VpfTexto := 'Destinatario:'+copy(VpaDCliente.NomCliente,1,25);
  A_Prn_Text(15,130,1,9,4,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
  VpfTexto := VpaDCliente.DesEndereco + ', '+VpaDCliente.NumEndereco+ ' - '+VpaDCliente.DesComplementoEndereco;
  A_Prn_Text(15,110,1,9,4,1,1,PAnsiChar('N'),0,PAnsiChar(copy(VpfTexto,1,36)));
  if length(VpfTexto) > 36 then
  begin
    VpfPularLinha := 20;
    A_Prn_Text(15,90,1,9,4,1,1,PAnsiChar('N'),0,PAnsiChar(copy(VpfTexto,36,36)));
  end;
  VpfTexto := 'Bairro:'+VpaDCliente.DesBairro;
  A_Prn_Text(15,90-VpfPularLinha,1,9,4,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
  VpfTexto := 'Cidade:'+VpaDCliente.DesCidade+'-'+VpaDCliente.DesUF;
  A_Prn_Text(15,70-VpfPularLinha,1,9,4,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
  VpfTexto := 'Cep:'+VpaDCliente.CepCliente;
  A_Prn_Text(15,50-VpfPularLinha,1,9,4,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
  VpfTexto := 'Fone:'+VpaDCliente.DesFone1;
  A_Prn_Text(170,50-VpfPularLinha,1,9,4,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
  VpfTexto := 'Nota:'+IntToStr(VpaDNota.NumNota);
  A_Prn_Text(15,30-VpfPularLinha,1,9,4,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));

  if A_Print_Out(1,1,1,1) <> 0 then
    result := 'ERRO AO IMPRIMIR!!!'#13'Não foi possível imprimir';
end;

{******************************************************************************}
function TRBFuncoesArgox.ImprimeNumerosModulo10(VpaLista : TStringList): string;
var
  VpfLaco, VpfIndice, VpfColuna : Integer;
  VpfNumero :  string;
  VpfTexto, VpfTexto2 : AnsiString;
begin
  VpfIndice := 0;
  for VpfLaco := 0 to VpaLista.Count - 1 do
  begin
    VpfNumero := VpaLista.Strings[VpfLaco];
    VpfColuna := 197 *(VpfLaco mod 2);

    VpfTexto := varia.PathVersoes+'\'+intToStr(varia.CodigoEmpFil)+'a.bmp';
    A_Get_Graphic(VpfColuna+15,65,1,PAnsiChar('B'),PAnsiChar(VpfTexto));
    VpfTexto := 'Suporte tecnico';
    A_Prn_Text(VpfColuna+90,78,1,9,3,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
    VpfTexto := 'e suprimentos';
    A_Prn_Text(VpfColuna+95,63,1,9,3,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
    VpfTexto := DeletaChars(varia.FoneFilial,'*');
    A_Prn_Text(VpfColuna+79,42,1,9,4,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
    VpfTexto := 'sac@copylinebnu.com.br';
    A_Prn_Text(VpfColuna+70,31,1,9,2,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
    VpfTexto := 'N.';
    A_Prn_Text(VpfColuna+100,5,1,9,5,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
    VpfTexto := 'o';
    A_Prn_Text(VpfColuna+115,15,1,9,1,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
    VpfTexto := AdicionaCharE('0',VpfNumero,5);
    A_Prn_Text(VpfColuna+130,5,1,9,5,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
    VpfTexto := 'assistencia';
    A_Prn_Text(VpfColuna+10,37,1,9,2,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
    VpfTexto := 'toner';
    A_Prn_Text(VpfColuna+10,26,1,9,2,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
    VpfTexto := 'impressoras';
    A_Prn_Text(VpfColuna+10,14,1,9,2,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
    VpfTexto := 'multifuncionais';
    A_Prn_Text(VpfColuna+10,3,1,9,2,1,1,PAnsiChar('N'),0,PAnsiChar(VpfTexto));
    if (VpfLaco mod 2) = 1 then
      if A_Print_Out(1,1,1,1) <> 0 then
        result := 'ERRO AO IMPRIMIR!!!'#13'Não foi possível imprimir';
  end;
  if VpaLista.Count > 0 then
  begin
    if (VpfLaco mod 2) = 0 then
      if A_Print_Out(1,1,1,1) <> 0 then
        result := 'ERRO AO IMPRIMIR!!!'#13'Não foi possível imprimir';
  end;
end;

{******************************************************************************}
procedure TRBFuncoesArgox.VoltarEtiqueta;
begin
  A_Set_Backfeed(350);
  A_Print_Out(1,1,1,1);
end;

end.
