<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://textgrid.info/namespaces/metadata/core/2010"
	xmlns:tg="http://textgrid.info/relation-ns#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:mets="http://www.loc.gov/METS/" xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:mods="http://www.loc.gov/mods/v3" xmlns:dv="http://dfg-viewer.de/"
	xmlns:tei="http://www.tei-c.org/ns/1.0">

	<xsl:output method="xml" indent="yes" encoding="UTF-8" />

	<xsl:param name="metsdivid" select="'null'" />
	<!-- z.B. in <mets:div ID="T0805-PHYSICAL-00038"...> -->
	<xsl:variable name="dmdsecid" select="//mets:div[@ID=$metsdivid]/@DMDID"/>
	<!-- z.B. <mets:dmdSec ID="T0048-DMD-00024"> -->

	<xsl:template match="/">
		<object>
			<generic>
				<provided>
					<title>
<!--						<xsl:value-of select="$metsdivid" /> -->
						<xsl:choose>
						    <xsl:when test="$dmdsecid != '' and //mets:dmdSec[@ID=$dmdsecid]//mods:mods//mods:title[1]">
						        <xsl:text> - </xsl:text>
						        <xsl:value-of select="normalize-space(//mets:dmdSec[@ID=$dmdsecid]//mods:mods//mods:title[1])"/>
						    </xsl:when>
							<xsl:when test="//mets:div[@ID=$metsdivid]/@LABEL != ''">
<!--								<xsl:text> - </xsl:text> -->
								<xsl:apply-templates select="//mets:div[@ID=$metsdivid]/@LABEL" />
							</xsl:when>
							<xsl:when test="//mets:div[@ID=$metsdivid]/@TYPE != ''">
								<xsl:text> - </xsl:text>
								<xsl:apply-templates select="//mets:div[@ID=$metsdivid]/@TYPE" />
								<xsl:if test="//mets:div[@ID=$metsdivid]/@ORDER != ''">
									<xsl:text> </xsl:text>
									<xsl:apply-templates select="//mets:div[@ID=$metsdivid]/@ORDER" />
								</xsl:if>
							</xsl:when>
						</xsl:choose>
					</title>
					<xsl:if test="$metsdivid != 'null'">
						<identifier>
						    <xsl:choose>
							   <xsl:when test="$metsdivid='StructMapPhysical' or $metsdivid='StructMapLogical'">
								  <xsl:attribute name="type">metsStructMap</xsl:attribute>
							   </xsl:when>
							   <xsl:otherwise>
							      <xsl:attribute name="type">METSXMLID</xsl:attribute>
							   </xsl:otherwise>
							</xsl:choose>
							<xsl:value-of select="$metsdivid" />
						</identifier>
					</xsl:if>
					<format>text/tg.aggregation+xml</format>
				</provided>
			</generic>
			<item>
				<rightsHolder>
					<xsl:value-of select="//mets:rightsMD//dv:owner" />
				</rightsHolder>
			</item>
			<xsl:choose>
			  <xsl:when test="$dmdsecid != '' and //mets:dmdSec[@ID=$dmdsecid]//mods:mods">
			    <custom>
			      <xsl:copy-of select="//mets:dmdSec[@ID=$dmdsecid]//mods:mods"/>
			    </custom>
			  </xsl:when>
			  <xsl:when test="$dmdsecid != '' and //mets:dmdSec[@ID=$dmdsecid]//tei:teiHeader">
			    <custom>
			      <xsl:copy-of select="//mets:dmdSec[@ID=$dmdsecid]//tei:teiHeader"/>
			    </custom>
			  </xsl:when>
			</xsl:choose>
		</object>
	</xsl:template>

</xsl:stylesheet>
