�
 TFRECIBOLOCACAO 0�<  TPF0TFReciboLocacaoFReciboLocacaoLeft� ToplCaption   Recibo LocaçãoClientHeight�ClientWidthColor	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OldCreateOrder	PositionpoDesktopCenterWindowStatewsMaximizedOnClose	FormCloseOnCreate
FormCreatePixelsPerInch`
TextHeight 	TSplitter	Splitter1Left Top� WidthHeightCursorcrVSplitAlignalTopExplicitLeftExplicitTop� ExplicitWidth  TPainelGradientePainelGradiente1Left Top WidthHeight)AlignalTop	AlignmenttaLeftJustifyCaption      Recibo Locação   Font.CharsetANSI_CHARSET
Font.ColorclWhiteFont.Height�	Font.NameTimes New Roman
Font.StylefsBold 
ParentFontTabOrder AConfiguracoesFPrincipal.CorPainelGra  TPanelColorPanelColor1Left Top)WidthHeightZAlignalTopColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style ParentBackground
ParentFontTabOrderAUsarCorFormACorFormFPrincipal.CorForm TLabelLabel4Left�Top
WidthHeight	AlignmenttaRightJustifyCaption   até :  TLabelLClienteLeft� TopWidth� HeightAutoSizeCaption                     TSpeedButtonSpeedButton1Left}TopWidthHeight
Glyph.Data
z  v  BMv      v   (                   �  �               �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 3333333333333?3333330 333333�w333333 33333?ws333330 333333�w333333 333?�?ws337 ;p333?ws�w333ww �333w37ws330��p3337�337�33w����s3373337?33����33333333����33333333����33s�333s33w����s337�337�330��p3337?�3�3333ww3333w?�s33337 333333ws3333	NumGlyphs  TLabelLabel1LeftTop
Width/Height	AlignmenttaRightJustifyCaption	Cliente :  TLabelLabel15LeftTop%Width"Height	AlignmenttaRightJustifyCaptionFilial :  TSpeedButtonSpeedButton6Left}Top!WidthHeight
Glyph.Data
z  v  BMv      v   (                   �  �               �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 3333333333333?3333330 333333�w333333 33333?ws333330 333333�w333333 333?�?ws337 ;p333?ws�w333ww �333w37ws330��p3337�337�33w����s3373337?33����33333333����33333333����33s�333s33w����s337�337�330��p3337?�3�3333ww3333w?�s33337 333333ws3333	NumGlyphs  TLabelLabel6Left�Top&Width9Height	AlignmenttaRightJustifyCaption   Cotação :  TLabelLabel2LeftTopBWidth2Height	AlignmenttaRightJustifyCaptionRecibo :  	TCheckBoxCPeriodoLeft�TopWidthGHeightCaption
   Período :Checked	State	cbCheckedTabOrder OnClickCPeriodoClick  TCalendario
EDatInicioLeft1TopWidthXHeightDate 8a�⯅�@Time 8a�⯅�@ColorclInfoBkFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderOnExitEDatInicioExitACorFocoFPrincipal.CorFoco  TCalendarioEDatFimLeft�TopWidthaHeightDate HLi鯅�@Time HLi鯅�@ColorclInfoBkFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderOnExitEDatFimExitACorFocoFPrincipal.CorFoco  TEditLocalizaEClienteLeftATopWidth;HeightColorclInfoBkFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderACampoObrigatorioAIgnorarCorACorFocoFPrincipal.CorFocoAInteiro ATextoLClienteABotaoSpeedButton1	ADataBaseFPrincipal.BaseDadosACorFormFPrincipal.CorFormACorPainelGraFPrincipal.CorPainelGra	ALocalizalocalizaASelectValida.StringsSelect * from CadClientes Where I_Cod_cli = @ ASelectLocaliza.StringsSelect * from CadClientes Where C_Nom_Cli like '@%'order by c_Nom_Cli  APermitirVazio	ASomenteNumeros	AInfo.CampoCodigo	I_Cod_cliAInfo.CampoNome	C_Nom_CliAInfo.Nome1   CódigoAInfo.Nome2NomeAInfo.Tamanho1AInfo.Tamanho2(AInfo.Tamanho3 AInfo.TituloForm   Localiza Cliente   ADarFocoDepoisdoLocaliza	OnFimConsultaEClienteFimConsulta  TEditLocalizaEFilialLeftATop"Width;HeightColorclInfoBkFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderACampoObrigatorioAIgnorarCorACorFocoFPrincipal.CorFocoAInteiro ABotaoSpeedButton6	ADataBaseFPrincipal.BaseDadosACorFormFPrincipal.CorFormACorPainelGraFPrincipal.CorPainelGra	ALocalizalocalizaASelectValida.StringsSelect * from CADFILIAISWhere I_EMP_FIL = @ ASelectLocaliza.StringsSelect * from CADFILIAISWhere C_NOM_FAN LIKE '@%'order by  C_NOM_FAN APermitirVazio	ASomenteNumeros	AInfo.CampoCodigo	I_EMP_FILAInfo.CampoNome	C_NOM_FANAInfo.Nome1   CódigoAInfo.Nome2NomeAInfo.Tamanho1AInfo.Tamanho2(AInfo.Tamanho3 AInfo.TituloForm   Localiza Filial      ADarFocoDepoisdoLocaliza	OnFimConsultaEFilialFimConsulta  
TEditColorECotacaoLeft0Top"WidthWHeightAutoSizeColorclInfoBkFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderOnExitECotacaoExitACampoObrigatorioAIgnorarCorACorFocoFPrincipal.CorFocoAInteiro   
TEditColorEReciboLeftATop?Width;HeightAutoSizeColorclInfoBkFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderOnExitEReciboExitACampoObrigatorioAIgnorarCorACorFocoFPrincipal.CorFocoAInteiro    TDBGridColor
GradeCorpoLeft Top� WidthHeight� AlignalClientColorclInfoBk
DataSourceDataRECIBOLOCACAOCORPODrawingStyle
gdsClassic
FixedColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style OptionsdgTitlesdgIndicatordgColumnResize
dgColLines
dgRowLinesdgTabsdgRowSelectdgConfirmDeletedgCancelOnExitdgTitleClickdgTitleHotTrack 
ParentFont	PopupMenu	MenuGradeReadOnly	TabOrderTitleFont.CharsetDEFAULT_CHARSETTitleFont.ColorclBlueTitleFont.Height�TitleFont.NameMS Sans SerifTitleFont.Style OnDrawColumnCellGradeCorpoDrawColumnCellOnKeyUpGradeCorpoKeyUpACorFocoFPrincipal.CorFocoColumnsExpanded	FieldName	CODFILIALTitle.CaptionFilialWidth6Visible	 Expanded	FieldName	SEQRECIBOTitle.CaptionSeq. ReciboWidth[Visible	 Expanded	FieldNameLANORCAMENTOTitle.Caption	OrcamentoWidthYVisible	 Expanded	FieldName	C_NOM_CLITitle.CaptionClienteWidth�Visible	 Expanded	FieldName
DATEMISSAOTitle.CaptionData EmissaoWidth}Visible	 Expanded	FieldNameVALTOTALTitle.CaptionValor TotalWidth`Visible	 Expanded	FieldNameINDCANCELADOTitle.Caption	CanceladoVisible	 Expanded	FieldNameDESMOTIVOCANCELAMENTOTitle.CaptionMotivo CancelamentoVisible	 Expanded	FieldNameDATCANCELAMENTOTitle.CaptionData CancelamentoWidth� Visible	 Expanded	FieldName	C_NOM_USUTitle.CaptionUsuario CancelamentoWidth� Visible	    TPanelColorPanelColor2Left TopDWidthHeight� AlignalBottomColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style ParentBackground
ParentFontTabOrderAUsarCorFormACorFormFPrincipal.CorForm TDBGridColor	GradeItemLeftTopWidthHeight7AlignalClientColorclInfoBk
DataSourceDataRECIBOLOCACAOSERVICODrawingStyle
gdsClassic
FixedColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style OptionsdgTitlesdgIndicatordgColumnResize
dgColLines
dgRowLinesdgTabsdgRowSelectdgConfirmDeletedgCancelOnExitdgTitleClickdgTitleHotTrack 
ParentFontReadOnly	TabOrder TitleFont.CharsetDEFAULT_CHARSETTitleFont.ColorclBlueTitleFont.Height�TitleFont.NameMS Sans SerifTitleFont.Style ACorFocoFPrincipal.CorFocoColumnsExpanded	FieldNameSEQITEMTitle.CaptionItemWidth?Visible	 Expanded	FieldName	C_NOM_SERTitle.CaptionServicoVisible	 Expanded	FieldName
QTDSERVICOTitle.Caption
QuantidadeWidthQVisible	 Expanded	FieldNameVALUNITARIOTitle.CaptionValor UnitarioVisible	 Expanded	FieldNameVALTOTALTitle.CaptionValor TotalVisible	    TDBMemoColorDBMemoColor1LeftTop8WidthHeightAlignalBottomColorclInfoBk	DataFieldDESOBSERVACAO
DataSourceDataRECIBOLOCACAOCORPOFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderACampoObrigatorioACorFocoFPrincipal.CorFoco  TPanelColorPanelColor3LeftTopuWidthHeight)AlignalBottomColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style ParentBackground
ParentFontTabOrderAUsarCorFormACorFormFPrincipal.CorForm TBitBtnBFecharLeft�TopWidthdHeightHelpContextCaption&FecharDoubleBuffered	
Glyph.Data
z  v  BMv      v   (                                    �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 3     33wwwww33333333333333333333333333333333333333333333333?33�33333s3333333333333���33��337ww�33��337���33��337ww3333333333333����33     33wwwwws3	NumGlyphsParentDoubleBufferedTabOrder OnClickBFecharClick  TBitBtn	BImprimirLeft6TopWidthdHeightCaption	&ImprimirDoubleBuffered	
Glyph.Data
z  v  BMv      v   (                                    �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 0      ?��������������wwwwwww�������wwwwwww        ���������������wwwwwww�������wwwwwww�������wwwwww        wwwwwww30����337���?330� 337�wss330����337��?�330�  337�swws330���3337��73330��3337�ss3330�� 33337��w33330  33337wws333	NumGlyphsParentDoubleBufferedTabOrderOnClickBImprimirClick  TBitBtn	BCancelarLeftTopWidthdHeightCaption	&CancelarDoubleBuffered	
Glyph.Data
�  �  BM�      v   (   $            h                       �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ��� 333333333333333333  33�33333333?333333  39�33�3333��33?33  3939�338�3?��3  39��338�8��3�3  33�338�3��38�  339�333�3833�3  333�33338�33?�3  3331�33333�33833  3339�333338�3�33  333��33333833�33  33933333�33�33  33����333838�8�3  33�39333�3��3�3  33933�333��38�8�  33333393338�33���  3333333333333338�3  333333333333333333  	NumGlyphsParentDoubleBufferedTabOrderOnClickBCancelarClick   TPanelColorPTotalLeftTopVWidthHeightAlignalBottomColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style ParentBackground
ParentFontTabOrderAUsarCorFormACorFormFPrincipal.CorForm TLabelLabel10Left=TopWidthHHeight	AlignmenttaRightJustifyCaptionValor Total :  	TCheckBoxCTotalLeftTopWidth{HeightCaptionAtualizar TotaisTabOrder OnClickCTotalClick  	TnumericoEValorTotalLeft�TopWidth� HeightACampoObrigatorioACorFocoFPrincipal.CorFocoANaoUsarCorNegativoColorclInfoBkFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrder    TConsultaPadraolocaliza
ACadastrarAAlterarLeft�Top`  TSQLRECIBOLOCACAOCORPO
Aggregates PacketRecordsParams ProviderNameInternalProviderAfterScrollRECIBOLOCACAOCORPOAfterScrollASQlConnectionFPrincipal.BaseDadosASqlQuery.MaxBlobSize�ASqlQuery.Params ASqlQuery.SQL.StringsJ  SELECT REC.CODFILIAL, REC.SEQRECIBO, REC.SEQLEITURALOCACAO, REC.LANORCAMENTO, CLI.C_NOM_CLI,  REC.DATEMISSAO, REC.VALTOTAL, REC.DESOBSERVACAO, REC.INDCANCELADO, REC.DESMOTIVOCANCELAMENTO, REC.DATCANCELAMENTO,REC.CODUSUARIOCANCELAMENTO,  USU.C_NOM_USU, USU.I_COD_USU  FROM RECIBOLOCACAOCORPO REC, CADCLIENTES CLI, CADUSUARIOS USU  ZWHERE REC.CODCLIENTE = CLI.I_COD_CLI  AND  REC.CODUSUARIOCANCELAMENTO = USU.I_COD_USU (+)  ASqlQuery.SQLConnectionFPrincipal.BaseDadosSQL.StringsJ  SELECT REC.CODFILIAL, REC.SEQRECIBO, REC.SEQLEITURALOCACAO, REC.LANORCAMENTO, CLI.C_NOM_CLI,  REC.DATEMISSAO, REC.VALTOTAL, REC.DESOBSERVACAO, REC.INDCANCELADO, REC.DESMOTIVOCANCELAMENTO, REC.DATCANCELAMENTO,REC.CODUSUARIOCANCELAMENTO,  USU.C_NOM_USU, USU.I_COD_USU  FROM RECIBOLOCACAOCORPO REC, CADCLIENTES CLI, CADUSUARIOS USU  ZWHERE REC.CODCLIENTE = CLI.I_COD_CLI  AND  REC.CODUSUARIOCANCELAMENTO = USU.I_COD_USU (+)  Left`Top TFMTBCDFieldRECIBOLOCACAOCORPOCODFILIAL	FieldName	CODFILIALRequired		Precision
Size   TFMTBCDFieldRECIBOLOCACAOCORPOSEQRECIBO	FieldName	SEQRECIBORequired		Precision
Size   TFMTBCDField#RECIBOLOCACAOCORPOSEQLEITURALOCACAO	FieldNameSEQLEITURALOCACAO	Precision
Size   TFMTBCDFieldRECIBOLOCACAOCORPOLANORCAMENTO	FieldNameLANORCAMENTO	Precision
Size   TWideStringFieldRECIBOLOCACAOCORPOC_NOM_CLI	FieldName	C_NOM_CLISize2  TSQLTimeStampFieldRECIBOLOCACAOCORPODATEMISSAO	FieldName
DATEMISSAO  TFMTBCDFieldRECIBOLOCACAOCORPOVALTOTAL	FieldNameVALTOTAL	PrecisionSize  TWideStringFieldRECIBOLOCACAOCORPODESOBSERVACAO	FieldNameDESOBSERVACAOSize�  TWideStringFieldRECIBOLOCACAOCORPOINDCANCELADO	FieldNameINDCANCELADO	FixedChar	Size  TWideStringField'RECIBOLOCACAOCORPODESMOTIVOCANCELAMENTO	FieldNameDESMOTIVOCANCELAMENTOSize(  TSQLTimeStampField!RECIBOLOCACAOCORPODATCANCELAMENTO	FieldNameDATCANCELAMENTO  TFMTBCDField(RECIBOLOCACAOCORPOCODUSUARIOCANCELAMENTO	FieldNameCODUSUARIOCANCELAMENTO	Precision
Size   TWideStringFieldRECIBOLOCACAOCORPOC_NOM_USU	FieldName	C_NOM_USUSize<  TFMTBCDFieldRECIBOLOCACAOCORPOI_COD_USU	FieldName	I_COD_USU	Precision
Size    TDataSourceDataRECIBOLOCACAOCORPODataSetRECIBOLOCACAOCORPOLeft�Top  TDataSourceDataRECIBOLOCACAOSERVICODataSetRECIBOLOCACAOSERVICOLeft(TopF  TSQLRECIBOLOCACAOSERVICO
Aggregates PacketRecordsParams ProviderNameInternalProviderASQlConnectionFPrincipal.BaseDadosASqlQuery.MaxBlobSize�ASqlQuery.Params ASqlQuery.SQL.StringsQSELECT REC.SEQITEM, SER.C_NOM_SER, REC.QTDSERVICO, REC.VALUNITARIO, REC.VALTOTAL / FROM RECIBOLOCACAOSERVICO REC, CADSERVICO SER % WHERE REC.CODSERVICO = SER.I_COD_SER AND REC.CODFILIAL = 11 AND REC.SEQRECIBO = 1 ASqlQuery.SQLConnectionFPrincipal.BaseDadosSQL.StringsQSELECT REC.SEQITEM, SER.C_NOM_SER, REC.QTDSERVICO, REC.VALUNITARIO, REC.VALTOTAL / FROM RECIBOLOCACAOSERVICO REC, CADSERVICO SER % WHERE REC.CODSERVICO = SER.I_COD_SER AND REC.CODFILIAL = 11 AND REC.SEQRECIBO = 1 LeftTopF TFMTBCDFieldRECIBOLOCACAOSERVICOSEQITEM	FieldNameSEQITEMRequired		Precision
Size   TWideStringFieldRECIBOLOCACAOSERVICOC_NOM_SER	FieldName	C_NOM_SERSize2  TFMTBCDFieldRECIBOLOCACAOSERVICOQTDSERVICO	FieldName
QTDSERVICO	PrecisionSize  TFMTBCDFieldRECIBOLOCACAOSERVICOVALUNITARIO	FieldNameVALUNITARIO	PrecisionSize  TFMTBCDFieldRECIBOLOCACAOSERVICOVALTOTAL	FieldNameVALTOTAL	PrecisionSize   TSQLAux
Aggregates Params ProviderNameInternalProviderASQlConnectionFPrincipal.BaseDadosASqlQuery.MaxBlobSize�ASqlQuery.Params ASqlQuery.SQLConnectionFPrincipal.BaseDadosLeft�TopV  
TPopupMenu	MenuGradeLeft�TopX 	TMenuItemMVisualizarNotaCaptionConsulta CotacaoOnClickMVisualizarNotaClick    