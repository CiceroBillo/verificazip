�
 TFPENDENCIASCOMPRAS 0�  TPF0TFPendenciasComprasFPendenciasComprasLeft/Top� CaptionPendencias ComprasClientHeight�ClientWidth(Color	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OldCreateOrder	PositionpoOwnerFormCenterWindowStatewsMaximizedOnClose	FormCloseOnCreate
FormCreatePixelsPerInch`
TextHeight TPainelGradientePainelGradiente1Left Top Width(Height)AlignalTop	AlignmenttaLeftJustifyCaption      Pendências Compras   Font.CharsetANSI_CHARSET
Font.ColorclWhiteFont.Height�	Font.NameTimes New Roman
Font.StylefsBold 
ParentFontTabOrder AConfiguracoesFPrincipal.CorPainelGra  TPanelColorPanelColor1Left Top)Width(HeightAlignalTopColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderAUsarCorFormACorFormFPrincipal.CorForm  TPanelColorPanelColor2Left Top�Width(Height)AlignalBottomColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderAUsarCorFormACorFormFPrincipal.CorForm TBitBtnBFecharLeft@TopWidthdHeightCaption&FecharDoubleBuffered	
Glyph.Data
z  v  BMv      v   (                                    �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 3     33wwwww33333333333333333333333333333333333333333333333?33�33333s3333333333333���33��337ww�33��337���33��337ww3333333333333����33     33wwwwws3	NumGlyphsParentDoubleBufferedTabOrder OnClickBFecharClick   TGridIndiceGridIndice1Left Top1Width(HeightfAlignalClientColorclInfoBk
DataSourceDataPendenciaCompra
FixedColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style OptionsdgTitlesdgIndicatordgColumnResize
dgColLines
dgRowLinesdgTabsdgRowSelectdgAlwaysShowSelectiondgConfirmDeletedgCancelOnExit 
ParentFont	PopupMenu
PopupMenu1TabOrderTitleFont.CharsetDEFAULT_CHARSETTitleFont.ColorclBlueTitleFont.Height�TitleFont.NameMS Sans SerifTitleFont.Style ACorFocoFPrincipal.CorFocoAindiceInicial ALinhaSQLOrderBy ColumnsExpanded	FieldNameDATPENDENCIATitle.Caption   Dt PendênciaWidthzVisible	 Expanded	FieldName	CODFILIALTitle.CaptionFlWidthVisible	 Expanded	FieldName	SEQPEDIDOTitle.CaptionPedido CompraVisible	 Expanded	FieldName	DATPEDIDOTitle.Caption   EmissãoVisible	 Expanded	FieldNameDATPREVISTATitle.CaptionEntrega PrevistaVisible	 Expanded	FieldNameDATRENEGOCIADOTitle.CaptionRenegociadoVisible	 Expanded	FieldName	C_NOM_CLITitle.Caption
FornecedorVisible	 Expanded	FieldNameNOMCOMPRADORTitle.Caption	CompradorVisible	    TSQLPendenciaCompra
Aggregates PacketRecordsParams ProviderNameInternalProviderASQlConnectionFPrincipal.BaseDadosASqlQuery.MaxBlobSize�ASqlQuery.Params ASqlQuery.SQLConnectionFPrincipal.BaseDadosSQL.StringsDselect PED.DATPEDIDO, PED.CODFILIAL, PED.SEQPEDIDO, PED.DATPREVISTA,          PED.DATRENEGOCIADO, ,         PEN.DATPENDENCIA, PEN.SEQPENDENCIA,        CLI.C_NOM_CLI,       COM.NOMCOMPRADOROfrom PENDENCIACOMPRA PEN, PEDIDOCOMPRACORPO PED, CADCLIENTES CLI, COMPRADOR COM#WHERE PEN.CODFILIAL = PED.CODFILIAL!AND PEN.SEQPEDIDO = PED.SEQPEDIDO"AND PED.CODCLIENTE = CLI.I_COD_CLI'AND PED.CODCOMPRADOR = COM.CODCOMPRADOR  TSQLTimeStampFieldPendenciaCompraDATPEDIDO	FieldName	DATPEDIDOOrigin%BASEDADOS.PEDIDOCOMPRACORPO.DATPEDIDO  TFMTBCDFieldPendenciaCompraCODFILIAL	FieldName	CODFILIALOrigin%BASEDADOS.PEDIDOCOMPRACORPO.CODFILIAL  TFMTBCDFieldPendenciaCompraSEQPEDIDO	FieldName	SEQPEDIDOOrigin%BASEDADOS.PEDIDOCOMPRACORPO.SEQPEDIDO  TSQLTimeStampFieldPendenciaCompraDATPREVISTA	FieldNameDATPREVISTAOrigin'BASEDADOS.PEDIDOCOMPRACORPO.DATPREVISTA  TSQLTimeStampFieldPendenciaCompraDATRENEGOCIADO	FieldNameDATRENEGOCIADOOrigin*BASEDADOS.PEDIDOCOMPRACORPO.DATRENEGOCIADO  TSQLTimeStampFieldPendenciaCompraDATPENDENCIA	FieldNameDATPENDENCIAOrigin&BASEDADOS.PENDENCIACOMPRA.DATPENDENCIA  TWideStringFieldPendenciaCompraC_NOM_CLI	FieldName	C_NOM_CLIOriginBASEDADOS.CADCLIENTES.C_NOM_CLISize2  TWideStringFieldPendenciaCompraNOMCOMPRADOR	FieldNameNOMCOMPRADOROrigin BASEDADOS.COMPRADOR.NOMCOMPRADORSize2  TFMTBCDFieldPendenciaCompraSEQPENDENCIA	FieldNameSEQPENDENCIAOrigin&BASEDADOS.PENDENCIACOMPRA.SEQPENDENCIA   TDataSourceDataPendenciaCompraDataSetPendenciaCompraLeft0  
TPopupMenu
PopupMenu1Left 	TMenuItemConcluirPendncia1Caption   Concluir PendênciaOnClickConcluirPendncia1Click  	TMenuItemN1Caption-  	TMenuItemConsultaPedidoCompra1CaptionConsulta Pedido CompraOnClickConsultaPedidoCompra1Click  	TMenuItemN2Caption-  	TMenuItemAgendamento1CaptionAgendamentoOnClickAgendamento1Click    