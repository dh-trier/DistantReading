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
					<xsl:apply-templates select="//mets:dmdSec[1]//mods:titleInfo/mods:title" />
					<format>text/tg.work+xml</format>
					<xsl:apply-templates select="//mets:dmdSec[1]//mods:note[1]" />
				</provided>
			</generic>
			<work>
				<xsl:apply-templates select="//mets:dmdSec[1]//mods:name/mods:namePart" />
				<xsl:apply-templates
					select="//mets:dmdSec[1]//mods:originInfo[1]/mods:dateIssued" />
			    <xsl:choose>
				   <xsl:when test="//mets:dmdSec[1]//mods:genre">
				      <genre>
				   	     <xsl:apply-templates select="//mets:dmdSec[1]//mods:genre" />
				      </genre>
				   </xsl:when>
				   <xsl:otherwise><genre>other</genre></xsl:otherwise>
				</xsl:choose>
			</work>
		</object>
	</xsl:template>

	<xsl:template match="mods:title">
		<title>
			<xsl:apply-templates />
		</title>
	</xsl:template>

	<xsl:template match="mods:genre">
		<xsl:apply-templates />
	</xsl:template>

	<xsl:template match="mods:namePart">
		<agent role="author">
			<xsl:apply-templates />
		</agent>
	</xsl:template>

	<xsl:template match="mods:note">
		<notes>
			<xsl:apply-templates />
		</notes>
	</xsl:template>

	<xsl:template match="mods:dateIssued">
		<dateOfCreation>
			<xsl:apply-templates />
		</dateOfCreation>
	</xsl:template>

</xsl:stylesheet>
