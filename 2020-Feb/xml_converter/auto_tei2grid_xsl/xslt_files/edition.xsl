<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:ore="http://www.openarchives.org/ore/terms/" xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xi="http://www.w3.org/2001/XInclude"
    xmlns:tns="http://textgrid.info/namespaces/metadata/core/2010">
    <xsl:output indent="yes"></xsl:output>
    <xsl:template match="/">
        <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
            xmlns:ore="http://www.openarchives.org/ore/terms/" xmlns="http://www.tei-c.org/ns/1.0"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns:xi="http://www.w3.org/2001/XInclude"
            xmlns:tns="http://textgrid.info/namespaces/metadata/core/2010">
            <rdf:Description> 
                <xsl:attribute name="rdf:about">
                    <xsl:apply-templates select="tei:TEI/@xml:id"></xsl:apply-templates>   
                </xsl:attribute>
                <ore:aggregates>
                    <xsl:attribute name="rdf:resource">
                        <xsl:call-template name="aggre"></xsl:call-template>
                    </xsl:attribute>
                </ore:aggregates> 
            </rdf:Description>
        </rdf:RDF>
    </xsl:template>
    <xsl:template match="tei:TEI/@xml:id">
        <xsl:value-of select="concat(., '-', ., '.edition')"/>
    </xsl:template>
    <xsl:template name="aggre">
        <xsl:value-of select="concat(tei:TEI/@xml:id, '/-', tei:TEI/@xml:id, '.xml')"/>
    </xsl:template>
</xsl:stylesheet>