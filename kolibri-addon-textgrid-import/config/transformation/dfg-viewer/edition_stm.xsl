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
						<xsl:value-of select="normalize-space(//tei:msIdentifier/tei:repository[1])" />
						<xsl:if test="normalize-space(//tei:msIdentifier/tei:idno[1]) != ''">
							<xsl:text>, </xsl:text>
							<xsl:value-of select="normalize-space(//tei:msIdentifier/tei:idno[1])" />
						</xsl:if>
						<xsl:if test="normalize-space(//tei:titleStmt/tei:title[1]) != ''">
							<xsl:text>: </xsl:text>
						        <xsl:value-of select="normalize-space(//tei:titleStmt/tei:title[1])" />
						</xsl:if>
					</title>
					<identifier type="idno">
						<xsl:value-of select="normalize-space(//tei:msIdentifier/tei:idno[1])" />
					</identifier>
					<format>text/tg.edition+tg.aggregation+xml</format>
				</provided>
			</generic>
			<edition>
				<isEditionOf>
					<xsl:value-of select="$tguriwork" />
				</isEditionOf>
<!--			<xsl:apply-templates select="//mets:metsHdr/mets:agent[1]" /> -->
				<agent role="editor">Virtuelles Skriptorium St. Matthias (www.stmatthias.uni-trier.de)</agent>
				<source>
					<bibliographicCitation>
<!--						<author>
							<xsl:value-of select="normalize-space(//tei:titleStmt/tei:author[1])" />
						</author>
						<editor>
							<xsl:value-of select="normalize-space(//mets:metsHdr/mets:agent/mets:name)" />
						</editor> -->
						<editionTitle>
							<xsl:value-of select="normalize-space(//tei:titleStmt/tei:title[1])" />
						</editionTitle>
						<placeOfPublication>
							<value>
								<xsl:value-of
									select="normalize-space(//tei:msDesc/tei:history/tei:origin/tei:origPlace[1])" />
							</value>
						</placeOfPublication>
						<dateOfPublication>
							<xsl:apply-templates
								select="//tei:msDesc[1]/tei:history/tei:origin/tei:origDate[1]" />
						</dateOfPublication>
						<bibIdentifier type="Ms">
							<xsl:value-of select="normalize-space(//tei:msIdentifier/tei:idno[1])" />
						</bibIdentifier>
					</bibliographicCitation>
				</source>
			</edition>
			<custom>
			    <xsl:copy-of select="//mets:dmdSec[1]//tei:teiHeader"/>
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
	
	<xsl:template match="tei:origDate">
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
	</xsl:template>

</xsl:stylesheet>
