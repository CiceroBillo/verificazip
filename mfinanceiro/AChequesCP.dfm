˙
 TFCHEQUESCP 0˛  TPF0TFChequesCP
FChequesCPLeft:Top CaptionChequesClientHeightClientWidthîColor	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Heightő	Font.NameMS Sans Serif
Font.Style OldCreateOrder	PositionpoScreenCenterOnClose	FormCloseOnCreate
FormCreatePixelsPerInch`
TextHeight TPainelGradientePainelGradiente1Left Top WidthîHeight)AlignalTop	AlignmenttaLeftJustifyCaption   Cheques   Font.CharsetANSI_CHARSET
Font.ColorclWhiteFont.Heightč	Font.NameTimes New Roman
Font.StylefsBold 
ParentFontTabOrder AConfiguracoesFPrincipal.CorPainelGra  TPanelColorPanelColor1Left Top)WidthîHeight;AlignalClientColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Heightó	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderAUsarCorFormACorFormFPrincipal.CorForm TRBStringGridColorGradeLeftTopWidthěHeightAlignalClientColorclInfoBkColCountDefaultRowHeightDrawingStyle
gdsClassic
FixedColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Heightó	Font.NameMS Sans Serif
Font.Style OptionsgoFixedVertLinegoFixedHorzLine
goVertLine
goHorzLinegoRangeSelectgoRowSizinggoColSizing	goEditinggoTabs 
ParentFontTabOrder OnGetEditMaskGradeGetEditMask	OnKeyDownGradeKeyDown
OnKeyPressGradeKeyPressOnSelectCellGradeSelectCellACorFocoFPrincipal.CorFocoALinha AColuna AEstadoGradeegNavegacaoAPermiteExcluir	APermiteInserir	APossuiDadosForadaGradeReadOnlyOnDadosValidosGradeDadosValidosOnMudouLinhaGradeMudouLinhaOnNovaLinhaGradeNovaLinhaOnDepoisExclusaoGradeDepoisExclusaoOnCarregaItemGradeGradeCarregaItemGrade	ColWidths<Ú [Ď Y9fVź ˇ    TPanelColorPanelColor3LeftTopWidthěHeight$AlignalBottomColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Heightó	Font.NameMS Sans Serif
Font.Style ParentBackground
ParentFontTabOrderAUsarCorFormACorFormFPrincipal.CorForm TLabelLabel1LeftTopWidthXHeightCaptionValor Parcela :  TLabelLabel2LeftíTopWidth}HeightCaption   SomatĂłria Cheques :  	TnumericoEValParcelaLeftdTopWidthqHeightACampoObrigatorioACorFocoFPrincipal.CorFocoANaoUsarCorNegativoColorclInfoBkFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Heightó	Font.NameMS Sans Serif
Font.Style 
ParentFontReadOnly	TabOrder   	TnumericoEValChequesLeftmTopWidthyHeightACampoObrigatorioACorFocoFPrincipal.CorFocoANaoUsarCorNegativoColorclInfoBkFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Heightó	Font.NameMS Sans Serif
Font.Style 
ParentFontReadOnly	TabOrder   TEditLocalizaEFormaPagamentoLeft Top WidthyHeightColorclInfoBkFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Heightó	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderVisibleACampoObrigatorioAIgnorarCorACorFocoFPrincipal.CorFocoAInteiro 	ADataBaseFPrincipal.BaseDadosACorFormFPrincipal.CorFormACorPainelGraFPrincipal.CorPainelGra	ALocalizaLocalizaASelectValida.Strings&Select I_COD_FRM, C_NOM_FRM, C_FLA_TIPfrom CADFORMASPAGAMENTOWhere I_COD_FRM =@ ASelectLocaliza.Strings&Select I_COD_FRM, C_NOM_FRM, C_FLA_TIPfrom CADFORMASPAGAMENTOWhere C_NOM_FRM Like '@%'order by C_NOM_FRM APermitirVazio	AInfo.CampoCodigo	I_COD_FRMAInfo.CampoNome	C_NOM_FRMAInfo.Nome1   CĂłdigoAInfo.Nome2NomeAInfo.Tamanho1AInfo.Tamanho2(AInfo.Tamanho3 AInfo.TituloForm!   Localiza Forma de Pagamento   AInfo.Cadastrar	AInfo.RetornoExtra1	C_NOM_FRMAInfo.RetornoExtra2	C_FLA_TIPADarFocoDepoisdoLocalizaOnCadastrarEFormaPagamentoChange	OnRetornoEFormaPagamentoRetorno  TEditLocalizaEContaCaixaLeft°Top  WidthyHeightColorclInfoBkFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Heightó	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderVisibleACampoObrigatorioAIgnorarCorACorFocoFPrincipal.CorFocoAInteiro 	ADataBaseFPrincipal.BaseDadosACorFormFPrincipal.CorFormACorPainelGraFPrincipal.CorPainelGra	ALocalizaLocalizaASelectValida.Strings3Select CON.C_NRO_CON, CON.C_NOM_CRR, BAN.C_NOM_BAN,CON.I_COD_BAN!from CADCONTAS CON, CADBANCOS BANWhere CON.C_NRO_CON = '@'!AND CON.I_COD_BAN = BAN.I_COD_BAN ASelectLocaliza.Strings4Select CON.C_NRO_CON, CON.C_NOM_CRR, BAN.C_NOM_BAN,           CON.I_COD_BAN!from CADCONTAS CON, CADBANCOS BANWhere CON.C_NOM_CRR LIKE '@%'!AND CON.I_COD_BAN = BAN.I_COD_BANORDER BY CON.C_NOM_CRR APermitirVazio	AInfo.CampoCodigo	C_NRO_CONAInfo.CampoNome	C_NOM_CRRAInfo.Nome1ContaAInfo.Nome2CorrentistaAInfo.Tamanho1AInfo.Tamanho2(AInfo.Tamanho3 AInfo.TituloForm   Localiza Conta Caixa   AInfo.RetornoExtra1	C_NOM_CRRAInfo.RetornoExtra2	I_COD_BANADarFocoDepoisdoLocaliza	OnRetornoEContaCaixaRetorno   TPanelColorPanelColor2Left TopdWidthîHeight)AlignalBottomColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Heightó	Font.NameMS Sans Serif
Font.Style ParentBackground
ParentFontTabOrderAUsarCorFormACorFormFPrincipal.CorForm TBitBtnBGravarLeft!TopWidthdHeightCaption&GravarDoubleBuffered	
Glyph.Data
â  Ţ  BMŢ      v   (   $            h                                    ŔŔŔ    ˙  ˙   ˙˙ ˙   ˙ ˙ ˙˙  ˙˙˙ 333333333333333333  333333333333ó33333  334C3333333833333  33B$33333338ó3333  34""C333338333333  3B""$33333338ó333  4"*""C3338ó8ó3333  2"Ł˘"C3338ó3333  :*3:"$3338ř38ó8ó33  3Ł33˘"C33333333  3333:"$3333338ó8ó3  33333˘"C33333333  33333:"$3333338ó8ó  333333˘"C3333333  333333:"C3333338ó  3333333˘#3333333  3333333:3333333383  333333333333333333  	NumGlyphsParentDoubleBufferedTabOrder OnClickBGravarClick  TBitBtn	BCancelarLeftTopWidthdHeightCaption	&CancelarDoubleBuffered	
Glyph.Data
â  Ţ  BMŢ      v   (   $            h                                    ŔŔŔ    ˙  ˙   ˙˙ ˙   ˙ ˙ ˙˙  ˙˙˙ 333333333333333333  3333333333?333333  39333333ó33?33  3939338ó3?ó3  39338ó8óř33  33338ó338ó  3393333833ř3  33333338ó33?3  33313333333833  3339333338ó333  3333333383333  339333333333  33333838ó8ó3  3339333333  33933333ř38ó8ó  3333339333833˙  33333333333333383  333333333333333333  	NumGlyphsParentDoubleBufferedTabOrderOnClickBCancelarClick   TConsultaPadraoLocaliza
ACadastrarAAlterarLeft Top   