<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://textgrid.info/namespaces/metadata/core/2010"
	xmlns:tg="http://textgrid.info/relation-ns#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:mets="http://www.loc.gov/METS/" xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:mods="http://www.loc.gov/mods/v3" xmlns:dv="http://dfg-viewer.de/"
	xmlns:tei="http://www.tei-c.org/ns/1.0">

	<xsl:output method="xml" indent="yes" encoding="UTF-8" />

	<xsl:param name="metsid" select="'null'" />
	<!-- z.B. in <mets:file ID="T0805-00001-DEF"...> -->
	<xsl:variable name="dmdsecid" select="//mets:div[mets:fptr/@FILEID=$metsid]/@DMDID"/>
	<!-- z.B. <mets:dmdSec ID="T0048-DMD-00024"> -->
	
	<xsl:template match="/">
		<object>
			<generic>
				<provided>
					<title>
						<xsl:value-of select="$metsid" />
						<xsl:choose>
							<xsl:when test="$dmdsecid != '' and //mets:dmdSec[@ID=$dmdsecid]//mods:mods//mods:title[1]">
						        <xsl:text> - </xsl:text>
						        <xsl:value-of select="normalize-space(//mets:dmdSec[@ID=$dmdsecid]//mods:mods//mods:title[1])"/>
						    </xsl:when>
							<xsl:when test="//mets:div[mets:fptr/@FILEID=$metsid]/@LABEL != ''">
								<xsl:text> - </xsl:text>
								<xsl:value-of select="//mets:div[mets:fptr/@FILEID=$metsid]/@LABEL" />
							</xsl:when>
							<xsl:when test="//mets:div[mets:fptr/@FILEID=$metsid]/@TYPE != ''">
								<xsl:text> - </xsl:text>
								<xsl:value-of select="//mets:div[mets:fptr/@FILEID=$metsid]/@TYPE" />
								<xsl:if test="//mets:div[mets:fptr/@FILEID=$metsid]/@ORDER != ''">
									<xsl:text> </xsl:text>
									<xsl:value-of select="//mets:div[mets:fptr/@FILEID=$metsid]/@ORDER" />
								</xsl:if>
							</xsl:when>
						</xsl:choose>
					</title>
					<identifier type="METSXMLID">
						<xsl:value-of select="$metsid" />
					</identifier>
					<format>
						<xsl:apply-templates select="//mets:file[@ID=$metsid]/@MIMETYPE" />
					</format>
				</provided>
			</generic>
			<item>
				<xsl:apply-templates select="//mets:amdSec[1]//mets:rightsMD//dv:owner" />
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

	<xsl:template match="dv:owner">
		<rightsHolder>
			<xsl:apply-templates />
		</rightsHolder>
	</xsl:template>

</xsl:stylesheet>
