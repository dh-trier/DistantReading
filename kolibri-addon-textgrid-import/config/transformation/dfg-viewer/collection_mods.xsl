<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://textgrid.info/namespaces/metadata/core/2010"
	xmlns:tg="http://textgrid.info/relation-ns#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:mets="http://www.loc.gov/METS/" xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:mods="http://www.loc.gov/mods/v3" xmlns:dv="http://dfg-viewer.de/"
	xmlns:tei="http://www.tei-c.org/ns/1.0">

	<xsl:output method="xml" indent="yes" encoding="UTF-8" />
	<xsl:strip-space elements="mods:recordIdentifier mods:identifier" />

	<xsl:template match="/">
		<object>
			<generic>
				<provided>
					<title>
						<xsl:value-of select="normalize-space(//mets:dmdSec[1]//mods:titleInfo/mods:title)"/>
					</title>
					<xsl:apply-templates
						select="//mets:dmdSec[1]//mods:recordInfo/mods:recordIdentifier" />
					<xsl:apply-templates select="//mets:dmdSec[1]//mods:identifier" />
					<format>text/tg.collection+tg.aggregation+xml</format>
				</provided>
			</generic>
			<collection>
				<xsl:apply-templates select="//mets:amdSec[1]//mets:rightsMD//dv:owner" />
			</collection>
			<custom>
			    <xsl:copy-of select="//mets:dmdSec[1]//mods:mods"/>
			</custom>
		</object>
	</xsl:template>

	<xsl:template match="dv:owner">
		<collector>
			<xsl:apply-templates />
		</collector>
	</xsl:template>
	
	<xsl:template match="mods:recordIdentifier">
		<xsl:if test="./text() != ''">
			<identifier>
			    <xsl:attribute name="type">mods:recordIdentifier</xsl:attribute>
				<xsl:value-of select="normalize-space(.)" />
			</identifier>
		</xsl:if>
	</xsl:template>

	<xsl:template match="mods:identifier">
		<xsl:if test="./text() != ''">
			<identifier>
				<xsl:attribute name="type">
        <xsl:value-of select="./@type" />
      </xsl:attribute>
				<xsl:value-of select="normalize-space(.)" />
			</identifier>
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>
