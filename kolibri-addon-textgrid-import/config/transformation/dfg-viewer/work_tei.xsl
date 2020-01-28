<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://textgrid.info/namespaces/metadata/core/2010"
	xmlns:tg="http://textgrid.info/relation-ns#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:mets="http://www.loc.gov/METS/" xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:mods="http://www.loc.gov/mods/v3" xmlns:dv="http://dfg-viewer.de/"
	xmlns:tei="http://www.tei-c.org/ns/1.0">

	<xsl:output method="xml" indent="yes" encoding="UTF-8" />

	<xsl:template match="/">
		<object>
			<generic>
				<provided>
					<xsl:apply-templates select="//tei:titleStmt/tei:title[1]" />
					<format>text/tg.work+xml</format>
				</provided>
			</generic>
			<work>
				<xsl:apply-templates select="//tei:titleStmt/tei:author[1]" />
				<xsl:apply-templates select="//tei:titleStmt/tei:respStmt/tei:name[1]" />
				<xsl:apply-templates
					select="//tei:fileDesc/tei:sourceDesc/tei:msDesc[1]/tei:history/tei:origin/tei:origDate[1]" />
				<genre>other</genre>
			</work>
		</object>
	</xsl:template>

	<xsl:template match="tei:title">
		<title>
			<xsl:apply-templates />
		</title>
	</xsl:template>

	<xsl:template match="tei:author">
		<agent role="author">
			<xsl:apply-templates />
		</agent>
	</xsl:template>

	<xsl:template match="tei:name">
		<agent role="contributor">
			<xsl:apply-templates />
		</agent>
	</xsl:template>

	<xsl:template match="tei:origDate">
		<dateOfCreation>
			<xsl:if test="./@when and ./@when !=''">
			   <xsl:attribute name="date"><xsl:value-of select="./@when"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="./@from and ./@from !=''">
			   <xsl:attribute name="notBefore"><xsl:value-of select="./@from"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="./@notBefore and ./@notBefore !=''">
			   <xsl:attribute name="notBefore"><xsl:value-of select="./@notBefore"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="./@to and ./@to !=''">
			   <xsl:attribute name="notAfter"><xsl:value-of select="./@to"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="./@notAfter and ./@notAfter !=''">
			   <xsl:attribute name="notAfter"><xsl:value-of select="./@notAfter"/></xsl:attribute>
			</xsl:if>
			<xsl:value-of select="normalize-space(.)" />
		</dateOfCreation>
	</xsl:template>

</xsl:stylesheet>
