�
 TFVERIFICALEITURALEMBRETE 0I  TPF0TFVerificaLeituraLembreteFVerificaLeituraLembreteLeftdTopnCaptionVerificar Leitura do LembreteClientHeightWClientWidth�Color	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OldCreateOrder	OnClose	FormCloseOnCreate
FormCreatePixelsPerInch`
TextHeight TPainelGradientePainelGradiente1Left Top Width�Height)AlignalTop	AlignmenttaLeftJustifyCaption  Verificar Leitura LembreteFont.CharsetANSI_CHARSET
Font.ColorclWhiteFont.Height�	Font.NameTimes New Roman
Font.StylefsBold 
ParentFontTabOrder AConfiguracoesFPrincipal.CorPainelGra  TPanelColorPanelColor1Left Top)Width�Height#AlignalTopColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderAUsarCorFormACorFormFPrincipal.CorForm TLabelLabel5LeftTop
Width'HeightCaption	   Título :  
TEditColorETituloLeft8TopWidth�HeightColorclInfoBkFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontReadOnly	TabOrder ACampoObrigatorioAIgnorarCorACorFocoFPrincipal.CorFocoAInteiro    TPanelColorPanelColor2Left TopLWidth�Height� AlignalClientColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderAUsarCorFormACorFormFPrincipal.CorForm TGridIndiceUSUARIOSNAOLIDOSLeftTopWidth� Height� ColorclInfoBk
DataSourceDataLEMBRETEITEMNAOLIDOS
FixedColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrder TitleFont.CharsetDEFAULT_CHARSETTitleFont.ColorclBlueTitleFont.Height�TitleFont.NameMS Sans SerifTitleFont.Style ACorFocoFPrincipal.CorFocoAindiceInicial ALinhaSQLOrderBy ColumnsExpanded	FieldName	C_NOM_USUTitle.Caption   Usuários que NÃO leramWidth� Visible	    TGridIndiceUSUARIOSLIDOSLeftTopWidth� Height� ColorclInfoBk
DataSourceDataLEMBRETEITEM
FixedColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderTitleFont.CharsetDEFAULT_CHARSETTitleFont.ColorclBlueTitleFont.Height�TitleFont.NameMS Sans SerifTitleFont.Style ACorFocoFPrincipal.CorFocoAindiceInicial ALinhaSQLOrderBy ColumnsExpanded	FieldName	C_NOM_USUTitle.Caption   Usuários que leramWidth� Visible	     TPanelColorPanelColor3Left Top.Width�Height)AlignalBottomColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderAUsarCorFormACorFormFPrincipal.CorForm TBitBtnBFecharLeft�TopWidthdHeightCaptionFecharDoubleBuffered	
Glyph.Data
z  v  BMv      v   (                                    �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 3     33wwwww33333333333333333333333333333333333333333333333?33�33333s3333333333333���33��337ww�33��337���33��337ww3333333333333����33     33wwwwws3	NumGlyphsParentDoubleBufferedTabOrder OnClickBFecharClick   TSQLLEMBRETEITEMLIDOS
Aggregates Params ProviderNameInternalProviderASQlConnectionFPrincipal.BaseDadosASqlQuery.MaxBlobSize�ASqlQuery.Params ASqlQuery.SQLConnectionFPrincipal.BaseDadosSQL.StringsSELECT USU.C_NOM_USU' FROM CADUSUARIOS USU, LEMBRETEITEM LBI% WHERE USU.I_COD_USU = LBI.CODUSUARIO AND USU.I_EMP_FIL = 0 AND LBI.SEQLEMBRETE = 0 LeftHTop TWideStringFieldLEMBRETEITEMLIDOSC_NOM_USU	FieldName	C_NOM_USUOriginBASEDADOS.CADUSUARIOS.C_NOM_USUSize<   TDataSourceDataLEMBRETEITEMDataSetLEMBRETEITEMLIDOSLefthTop  TDataSourceDataLEMBRETEITEMNAOLIDOSDataSetLEMBRETEITEMNAOLIDOSLeft(Top  TSQLLEMBRETEITEMNAOLIDOS
Aggregates Params ProviderNameInternalProviderASQlConnectionFPrincipal.BaseDadosASqlQuery.MaxBlobSize�ASqlQuery.Params ASqlQuery.SQLConnectionFPrincipal.BaseDadosSQL.StringsSELECT USU.C_NOM_USU( FROM CADUSUARIOS USU, LEMBRETECORPO LBC WHERE USU.I_EMP_FIL = 0 AND USU.C_USU_ATI = 'S' AND LBC.SEQLEMBRETE = 0 AND NOT EXISTS (SELECT *&                 FROM LEMBRETEITEM LBI5                 WHERE LBI.CODUSUARIO = USU.I_COD_USU7                 AND LBI.SEQLEMBRETE = LBC.SEQLEMBRETE) AND (EXISTS (SELECT *&              FROM LEMBRETEUSUARIO LBU2              WHERE LBU.CODUSUARIO = USU.I_COD_USU4              AND LBU.SEQLEMBRETE = LBC.SEQLEMBRETE)      OR LBC.INDTODOS = 'S')ORDER BY USU.C_NOM_USU LeftTop TWideStringFieldLEMBRETEITEMNAOLIDOSC_NOM_USU	FieldName	C_NOM_USUSize<    