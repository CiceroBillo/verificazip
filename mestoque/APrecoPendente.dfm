�
 TFPRECOPENDENTE 0�  TPF0TFPrecoPendenteFPrecoPendenteLeftXToppCaption   Preço PendenteClientHeight�ClientWidth
Color	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OldCreateOrder	PositionpoOwnerFormCenterWindowStatewsMaximizedOnClose	FormCloseOnCreate
FormCreatePixelsPerInch`
TextHeight TPainelGradientePainelGradiente1Left Top Width
Height)AlignalTop	AlignmenttaLeftJustifyCaption      Preço Pendente   Font.CharsetANSI_CHARSET
Font.ColorclWhiteFont.Height�	Font.NameTimes New Roman
Font.StylefsBold 
ParentFontTabOrder AConfiguracoesFPrincipal.CorPainelGra  TPanelColorPanelColor1Left Top)Width
HeightBAlignalClientColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderAUsarCorFormACorFormFPrincipal.CorForm TGridIndiceGridIndice1LeftTopWidthHeight@AlignalClientColorclInfoBk
DataSourceDataAmostras
FixedColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style OptionsdgTitlesdgIndicatordgColumnResize
dgColLines
dgRowLinesdgTabsdgRowSelectdgAlwaysShowSelectiondgConfirmDeletedgCancelOnExit 
ParentFontTabOrder TitleFont.CharsetDEFAULT_CHARSETTitleFont.ColorclBlueTitleFont.Height�TitleFont.NameMS Sans SerifTitleFont.Style ACorFocoFPrincipal.CorFocoAindiceInicial ALinhaSQLOrderBy ColumnsExpanded	FieldNameDATACLIENTETitle.Caption   Data RequisiçãoWidth{Visible	 Expanded	FieldName
DATAMOSTRATitle.Caption   EmissãoWidthzVisible	 Expanded	FieldName
DATENTREGATitle.Caption   Conclusão AmostraWidth~Visible	 Expanded	FieldName
CODAMOSTRATitle.Caption   CódigoVisible	 Expanded	FieldName
NOMAMOSTRATitle.CaptionNomeVisible	 Expanded	FieldName	C_NOM_CLITitle.CaptionClienteVisible	     TPanelColorPanelColor2Left TopkWidth
Height%AlignalBottomColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style ParentBackground
ParentFontTabOrderAUsarCorFormACorFormFPrincipal.CorForm TLabelLabel1Left	TopWidthLHeightCaptionQuantidade :  TBitBtnBFecharLeft�TopWidthdHeightCaption&FecharDoubleBuffered	
Glyph.Data
z  v  BMv      v   (                                    �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 3     33wwwww33333333333333333333333333333333333333333333333?33�33333s3333333333333���33��337ww�33��337���33��337ww3333333333333����33     33wwwwws3	NumGlyphsParentDoubleBufferedTabOrder OnClickBFecharClick  	TnumericoEQtdLeftXTopWidth9HeightACampoObrigatorioACorFocoFPrincipal.CorFocoANaoUsarCorNegativoColorclInfoBkAMascara ,0;- ,0Font.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrder   TSQLAmostras
Aggregates Params ProviderNameInternalProviderASQlConnectionFPrincipal.BaseDadosASqlQuery.MaxBlobSize�ASqlQuery.Params ASqlQuery.SQLConnectionFPrincipal.BaseDadosSQL.Strings"select AMI.DATAMOSTRA DATACLIENTE,C  AMO.CODAMOSTRA, AMO.NOMAMOSTRA, AMO.DATAMOSTRA, AMO.DATENTREGA,   CLI.C_NOM_CLI    .from AMOSTRA AMO, CADCLIENTES CLI, AMOSTRA AMI    $Where AMO.CODCLIENTE = CLI.I_COD_CLI-AND AMO.CODAMOSTRAINDEFINIDA = AMI.CODAMOSTRA LeftTop TSQLTimeStampFieldAmostrasDATACLIENTE	FieldNameDATACLIENTEOriginBASEDADOS.AMOSTRA.DATAMOSTRA  TFMTBCDFieldAmostrasCODAMOSTRA	FieldName
CODAMOSTRAOriginBASEDADOS.AMOSTRA.CODAMOSTRA  TWideStringFieldAmostrasNOMAMOSTRA	FieldName
NOMAMOSTRAOriginBASEDADOS.AMOSTRA.NOMAMOSTRASize2  TSQLTimeStampFieldAmostrasDATAMOSTRA	FieldName
DATAMOSTRAOriginBASEDADOS.AMOSTRA.DATAMOSTRA  TSQLTimeStampFieldAmostrasDATENTREGA	FieldName
DATENTREGAOriginBASEDADOS.AMOSTRA.DATENTREGA  TWideStringFieldAmostrasC_NOM_CLI	FieldName	C_NOM_CLIOriginBASEDADOS.CADCLIENTES.C_NOM_CLISize2   TDataSourceDataAmostrasDataSetAmostrasLeft0Top   