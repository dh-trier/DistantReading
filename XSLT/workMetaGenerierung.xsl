<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output indent="yes"></xsl:output>
    <xsl:template match="/">
       <object xmlns="http://textgrid.info/namespaces/metadata/core/2010"
            xmlns:tg="http://textgrid.info/relation-ns#"
            xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
        <generic>
            <provided>
                <title>
                    <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:bibl/tei:title/text()"/>
                </title>
                <format>text/tg.work+xml</format>
            </provided>
            <generated></generated>
        </generic>
        <work>
            <agent role="author">
<!--                <xsl:apply-templates select="tei:TEI/tei:teiHeader[1]/tei:fileDesc[1]/tei:titleStmt[1]/tei:author[1]/@ref"></xsl:apply-templates>-->
                <xsl:attribute name="id">
                    <xsl:value-of select="/tei:TEI/tei:teiHeader[1]/tei:fileDesc[1]/tei:titleStmt[1]/tei:author[1]/@ref"/>  <!-- aktualisiert -->
                </xsl:attribute>
                <xsl:value-of select="tei:TEI/tei:teiHeader[1]/tei:fileDesc[1]/tei:sourceDesc[1]/tei:bibl[1]/tei:author[1]/text()"/>
            </agent>
            <dateOfCreation>
                <xsl:attribute name="notBefore">
                    <xsl:value-of select="tei:TEI/tei:teiHeader[1]/tei:fileDesc[1]/tei:sourceDesc[1]/tei:bibl[1]/tei:date[1]/text()"/>
                </xsl:attribute>
                <xsl:attribute name="notAfter">
                    <xsl:value-of select="tei:TEI/tei:teiHeader[1]/tei:fileDesc[1]/tei:sourceDesc[1]/tei:bibl[1]/tei:date[1]/text()"/>
                </xsl:attribute>
                <xsl:value-of select="tei:TEI/tei:teiHeader[1]/tei:fileDesc[1]/tei:sourceDesc[1]/tei:bibl[1]/tei:date[1]/text()"/>
            </dateOfCreation>
            <temporal>
                <xsl:value-of select="tei:TEI/tei:teiHeader[1]/tei:profileDesc[1]/tei:textDesc[1]/*[namespace-uri()='http://distantreading.net/eltec/ns' and local-name()='timeSlot'][1]/@key"/>
            </temporal>
            <genre>prose</genre>
        </work>
        </object>
    </xsl:template>
    <!--<xsl:template match="tei:author/@ref">
        <xsl:variable name="ii" select="substring-after(current(), 'gnd/')"/>
        <xsl:variable name="i">gnd:</xsl:variable>
            <xsl:attribute name="id">
                <xsl:value-of select="concat($i, $ii)"/>
            </xsl:attribute>
    </xsl:template>-->
</xsl:stylesheet>