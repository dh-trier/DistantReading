<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://textgrid.info/namespaces/metadata/core/2010"
	xmlns:tg="http://textgrid.info/relation-ns#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:mets="http://www.loc.gov/METS/" xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:mods="http://www.loc.gov/mods/v3" xmlns:dv="http://dfg-viewer.de/"
	xmlns:tei="http://www.tei-c.org/ns/1.0">

	<xsl:output method="xml" indent="yes" encoding="UTF-8" />

	<xsl:param name="tguriwork" select="'null'" />
	<!-- TextGrid-URI des zugehörigen Work-Objekts -->

	<xsl:template match="/">
		<object>
			<generic>
				<provided>
					<title>
						<xsl:value-of select="normalize-space(//mets:dmdSec[1]//mods:titleInfo/mods:title[1])" />
					</title>
					<xsl:apply-templates
						select="//mets:dmdSec[1]//mods:recordInfo/mods:recordIdentifier" />
					<xsl:apply-templates select="//mets:dmdSec[1]//mods:identifier" />
					<format>text/tg.edition+tg.aggregation+xml</format>
				</provided>
			</generic>
			<edition>
				<isEditionOf>
					<xsl:value-of select="$tguriwork" />
				</isEditionOf>
				<xsl:apply-templates select="//mets:metsHdr/mets:agent[1]" />
				<source>
					<bibliographicCitation>
						<editor>
							<xsl:value-of select="normalize-space(//mets:metsHdr/mets:agent/mets:name)" />
						</editor>
						<editionTitle>
							<xsl:value-of select="normalize-space(//mets:dmdSec[1]//mods:titleInfo/mods:title[1])" />
						</editionTitle>
						<placeOfPublication>
							<value>
								<xsl:value-of select="normalize-space(//mets:dmdSec[1]//mods:originInfo[1]/mods:place[1]/mods:placeTerm[1])" />
							</value>
						</placeOfPublication>
						<dateOfPublication>
							<xsl:value-of
								select="normalize-space(//mets:dmdSec[1]//mods:originInfo[1]/mods:dateIssued[1])" />
						</dateOfPublication>
						<bibIdentifier type="Ms">
							<xsl:apply-templates
								select="//mets:dmdSec[1]//mods:recordInfo/mods:recordIdentifier" mode="bib"/>
						</bibIdentifier>
					</bibliographicCitation>
				</source>
			</edition>
			<custom>
			    <xsl:copy-of select="//mets:dmdSec[1]//mods:mods"/>
			</custom>
		</object>
	</xsl:template>

	<xsl:template match="mets:agent">
		<agent>
			<xsl:attribute name="role">
               <xsl:value-of select="translate(./@ROLE, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')" />
            </xsl:attribute>
			<xsl:value-of select="normalize-space(mets:name)" />
		</agent>
	</xsl:template>

	<xsl:template match="mods:recordIdentifier">
		<xsl:if test="./text() != ''">
		   <identifier>
			  <xsl:attribute name="type">mods:recordIdentifier</xsl:attribute>
			  <xsl:value-of select="normalize-space(.)" />
		   </identifier>
		</xsl:if>
	</xsl:template>

	<xsl:template match="mods:recordIdentifier" mode="bib">
		<xsl:if test="./text() != ''">
		   <xsl:attribute name="type">mods:recordIdentifier</xsl:attribute>
           <xsl:value-of select="normalize-space(.)" />
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
