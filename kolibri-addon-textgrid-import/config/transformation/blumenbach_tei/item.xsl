<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns="http://textgrid.info/namespaces/metadata/core/2010"
	xmlns:tg="http://textgrid.info/relation-ns#" 
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:tei="http://www.tei-c.org/ns/1.0"
	xsi:schemaLocation=" 
		http://textgridlab.org/schema/textgrid-metadata_2010.xsd
	">

	<xsl:output method="xml" indent="yes" encoding="UTF-8" />

	<xsl:param name="teiid" select="'null'" />
	<!-- z.B. in <mets:file ID="T0805-00001-DEF"...> -->
	
	<!-- z.B. <mets:dmdSec ID="T0048-DMD-00024"> -->
	
	<xsl:template match="/">
		<object>
			<generic>
				<provided>
					<title>
						<xsl:value-of select="$teiid" />
					</title>
					<format>
						text/xml
					</format>
				</provided>
				<notes><xsl:value-of select="normalize-space(//tei:editionStmt)"/></notes>
			</generic>
			<item>
				<xsl:apply-templates select="//tei:fileDesc/tei:publicationStmt/tei:publisher" />
			</item>
		</object>
	</xsl:template>

	<xsl:template match="tei:publisher">
		<rightsHolder>
			<xsl:value-of select="normalize-space(.)"/>
		</rightsHolder>
	</xsl:template>

</xsl:stylesheet>
