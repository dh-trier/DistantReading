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
                    <xsl:apply-templates select="tei:TEI/@xml:id"></xsl:apply-templates>  
                </title>
                <format>text/tg.aggregation+xml</format>  
            </provided>
            <generated></generated>
        </generic>
        <item>
            <rightsHolder id="">
                <xsl:value-of select="/tei:TEI/tei:teiHeader[1]/tei:fileDesc[1]/tei:titleStmt[1]/tei:respStmt[1]/tei:resp"/>  
            </rightsHolder>    
        </item>
        </object>
    </xsl:template>
    <xsl:template match="tei:TEI/@xml:id">
        <xsl:value-of select="substring(., 1, 3)"></xsl:value-of>
    </xsl:template>
</xsl:stylesheet>