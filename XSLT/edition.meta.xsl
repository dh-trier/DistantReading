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
                        <xsl:apply-templates select="/tei:TEI/tei:teiHeader[1]/tei:fileDesc[1]/tei:titleStmt[1]/tei:title[1]"></xsl:apply-templates>
                    </title>  
                    <format>text/tg.edition+tg.aggregation+xml</format>
                    <notes></notes>  <!-- leer lassen, da nicht genutzt -->
                </provided>
                <generated></generated>
            </generic>
            <edition>
                <isEditionOf>
                    <xsl:apply-templates select="tei:TEI/@xml:id"></xsl:apply-templates>
                </isEditionOf>   
                <agent role="author" id="">
                    <xsl:value-of select="/tei:TEI/tei:teiHeader[1]/tei:fileDesc[1]/tei:sourceDesc[1]/tei:bibl[1]/tei:author"/>
                </agent>
                <source>
                    <bibliographicCitation>
                        <author>
                            <xsl:attribute name="id">
                                <xsl:value-of select="/tei:TEI/tei:teiHeader[1]/tei:fileDesc[1]/tei:titleStmt[1]/tei:author[1]/@ref"/> 
                            </xsl:attribute>
                            <xsl:value-of select="/tei:TEI/tei:teiHeader[1]/tei:fileDesc[1]/tei:sourceDesc[1]/tei:bibl[1]/tei:author"/>
                        </author>
                        <editionTitle>
                            <xsl:value-of select="/tei:TEI/tei:teiHeader[1]/tei:fileDesc[1]/tei:titleStmt[1]/tei:title[1]"/>  
                        </editionTitle>
                        <placeOfPublication>
                            <value>Trier</value>  
                        </placeOfPublication>
                        <dateOfPublication>
                            <xsl:value-of select="/tei:TEI/tei:teiHeader[1]/tei:fileDesc[1]/tei:sourceDesc[1]/tei:bibl[1]/tei:date"/>
                        </dateOfPublication>
                        <spage></spage>  <!-- brauchen wir nicht -->
                    </bibliographicCitation>
                </source>
                <license>
                    <xsl:value-of select="/tei:TEI/tei:teiHeader[1]/tei:fileDesc[1]/tei:publicationStmt[1]/tei:availability[1]/tei:licence[1]/@target"/>
                </license>
            </edition>
        </object>
    </xsl:template>
    <xsl:template match="tei:TEI/@xml:id">
        <xsl:variable name="i" select="substring(., 1, 3)"/>
        <xsl:variable name="ii" select="."/>
        <xsl:value-of select="concat($i, '/', $ii, '.work')"/>
    </xsl:template>
    <xsl:template match="tei:title[1]">
        <xsl:value-of select="substring-before(current(), ': ELTeC')"/>
    </xsl:template>
</xsl:stylesheet>