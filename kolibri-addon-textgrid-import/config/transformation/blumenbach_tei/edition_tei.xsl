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

	<xsl:param name="tguriwork" select="'null'" />
	<!-- TextGrid-URI des zugehörigen Work-Objekts -->

	<xsl:template match="/">
		<object>
			<generic>
				<provided>
					<title>
						<!-- optionaly add ck-jfb number to title if provided -->
						<xsl:variable name="ckjfb">
							<xsl:if test="//tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:idno[@type='CK_JFB_number']">
								- CK_JFB_number <xsl:value-of select="normalize-space(//tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:idno[@type='CK_JFB_number'])" />						
							</xsl:if>							
						</xsl:variable>
						<xsl:value-of select="normalize-space(concat(//tei:fileDesc//tei:titleStmt/tei:title[@type='main'],$ckjfb))" />
					</title>
					<format>text/tg.edition+tg.aggregation+xml</format>
				</provided>
			</generic>
			<edition>
				<isEditionOf>
					<xsl:value-of select="$tguriwork" />
				</isEditionOf>
				<xsl:apply-templates select="//tei:titleStmt//tei:author" />
				<xsl:apply-templates select="//tei:titleStmt//tei:editor" />
				<xsl:apply-templates select="//tei:titleStmt//tei:respStmt" />
				<xsl:apply-templates select="//tei:publicationStmt//tei:publisher" />
				<source>
					<!-- TODO: more than one author, editor, ...-->
					<bibliographicCitation>
						<author>
							<xsl:value-of select="normalize-space(//tei:monogr/tei:author[1])" />
						</author>
						<editor>
							<xsl:value-of select="normalize-space(//tei:monogr/tei:editor[1])" />
						</editor>
						<editionTitle>
							<xsl:value-of select="normalize-space(//tei:monogr/tei:title[@level='m'][@type='main'])" />
						</editionTitle>
						<!-- getty ID !-->
						<placeOfPublication>
							<value>
								<xsl:value-of select="normalize-space(//tei:monogr/tei:imprint/tei:pubPlace/tei:placeName[1])" />
							</value>
						</placeOfPublication>
						<publisher>
							<value>
								<xsl:value-of select="normalize-space(//tei:monogr/tei:imprint/tei:publisher[1])" />
							</value>							
						</publisher>
						<dateOfPublication>
							<xsl:attribute name="date">
								<xsl:value-of select="normalize-space(//tei:monogr/tei:imprint/tei:date/@when)" />
							</xsl:attribute>
							<xsl:value-of select="normalize-space(//tei:monogr/tei:imprint/tei:date[1])" />
						</dateOfPublication>
						<editionNo>
							<xsl:value-of select="normalize-space(//tei:monogr/tei:edition[1])" />
						</editionNo>
						<series>
							<xsl:value-of select="normalize-space(//tei:monogr/tei:title[@level='j'][@type='uniform'])" />
						</series>
						<volume>
							<xsl:value-of select="normalize-space(//tei:monogr/tei:imprint/tei:biblScope[@type='vol'])" />
						</volume>
						<issue>
							<xsl:value-of select="normalize-space(//tei:monogr/tei:imprint/tei:biblScope[@type='issue'])" />
						</issue>
						<spage>
							<xsl:value-of select="normalize-space(//tei:monogr/tei:imprint/tei:biblScope[@type='pp']/@from)" />
						</spage>
						<epage>
							<xsl:value-of select="normalize-space(//tei:monogr/tei:imprint/tei:biblScope[@type='pp']/@to)" />
						</epage>
					</bibliographicCitation>
				</source>
				<license>
					<xsl:attribute name="licenseUri">
						<xsl:value-of select="normalize-space(//tei:publicationStmt/tei:availability/tei:licence/@target)" />
					</xsl:attribute>
					<xsl:value-of select="normalize-space(//tei:publicationStmt/tei:availability/tei:licence)" />
				</license>
			</edition>
		</object>
	</xsl:template>

	<!-- TODO: generic template for orgName, persName and surename/forename tags, also pnd/gnd -->
	<xsl:template match="tei:author">
		<agent>
			<xsl:attribute name="role">author</xsl:attribute>
			<xsl:value-of select="normalize-space(.)" />
		</agent>
	</xsl:template>
	<xsl:template match="tei:editor">
		<agent>
			<xsl:attribute name="role">editor</xsl:attribute>
			<xsl:value-of select="normalize-space(.)" />
		</agent>
	</xsl:template>	
	<xsl:template match="tei:respStmt">
		<xsl:if test="./tei:persName/@role = 'egr'">
			<agent>
				<xsl:attribute name="role">engraver</xsl:attribute>
				<xsl:value-of select="normalize-space(./tei:persName)" />
			</agent>
		</xsl:if>
		<xsl:if test="./tei:persName/@role = 'dte'">
			<agent>
				<xsl:attribute name="role">dedicatee</xsl:attribute>
				<xsl:value-of select="normalize-space(./tei:persName)" />
			</agent>
		</xsl:if>
	</xsl:template>
	<xsl:template match="tei:publisher">
		<xsl:if test="./tei:orgName/@role = 'pbl'">
			<agent>
				<xsl:attribute name="role">publisher</xsl:attribute>
				<xsl:value-of select="normalize-space(./tei:orgName)" />
			</agent>
		</xsl:if>
	</xsl:template>
	
</xsl:stylesheet>
