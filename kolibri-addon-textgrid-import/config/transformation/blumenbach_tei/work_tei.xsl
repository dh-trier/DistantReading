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

	<xsl:template match="/">
		<object>
			<generic>
				<provided>
					<!--xsl:apply-templates select="//tei:titleStmt/tei:title[1]" /-->
                    <title>
                    	<xsl:choose>
	                    	<xsl:when test="//tei:fileDesc/tei:titleStmt/tei:title[@type='uniform']">
	                    		<xsl:value-of select="normalize-space(//tei:fileDesc/tei:titleStmt/tei:title[@type='uniform'])" />
	                    	</xsl:when>
	                    	<xsl:otherwise>
	                    		<xsl:value-of select="normalize-space(//tei:fileDesc/tei:titleStmt/tei:title[@type='main'])" />
	                    	</xsl:otherwise>
                    	</xsl:choose>
                    </title>
					<format>text/tg.work+xml</format>
				</provided>
			</generic>
			<work>
				<xsl:apply-templates select="//tei:fileDesc/tei:titleStmt/tei:author[1]" />
				<xsl:apply-templates select="//tei:profileDesc/tei:textClass" />
				<!-- xsl:apply-templates select="//tei:titleStmt/tei:respStmt/tei:name[1]" /-->
				<!-- xsl:apply-templates
					select="//tei:fileDesc/tei:sourceDesc/tei:msDesc[1]/tei:history/tei:origin/tei:origDate[1]" /-->
				
				
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
	
	<!-- TODO: redo -->
	<xsl:template match="tei:textClass">
		<!-- DDC comes from here-->
		<subject>
			<xsl:attribute name="type"><xsl:value-of select="substring-after(./tei:classCode/@scheme, '#')"/></xsl:attribute>
			<xsl:attribute name="id"><xsl:value-of select="normalize-space(./tei:classCode)" /></xsl:attribute>
			<xsl:value-of select="normalize-space(./tei:classCode)" />
		</subject>
		
		<!-- TODO: value, DDC / GND ? -->
		<xsl:for-each select="tei:keywords[@scheme='#Gnd']//tei:term">
		<subject>
			<xsl:attribute name="type">Gnd</xsl:attribute>
			<xsl:attribute name="id"><xsl:value-of select="substring-after( ./@ref, '#GndId:')" /></xsl:attribute>
			<xsl:value-of select="normalize-space(.)" />
		</subject>
		</xsl:for-each>
		
		<genre>other</genre>
		
		<!-- TODO: according to the schema this will break (xs:restriction) -->
		<xsl:for-each select="tei:keywords[@scheme='#JFBO_Genretypen']//tei:term">
			<type>
				<xsl:value-of select="normalize-space(.)" />
			</type>
		</xsl:for-each>

		<!-- TODO: according to the schema this will break (xs:restriction) -->
		<xsl:if test="tei:keywords[@scheme='frei']">
		<notes>
		<xsl:for-each select="tei:keywords[@scheme='frei']//tei:term">
			<xsl:value-of select="normalize-space(.)" />
			<xsl:if test="position() != last()">, </xsl:if>
		</xsl:for-each>
		</notes>
		</xsl:if>
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
