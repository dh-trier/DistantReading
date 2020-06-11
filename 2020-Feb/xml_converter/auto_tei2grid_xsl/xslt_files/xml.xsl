<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0" xmlns:jxb="http://java.sun.com/xml/ns/jaxb" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:tns="http://textgrid.info/namespaces/metadata/core/2010"
    xmlns:tgl="http://textgrid.info/namespaces/metadata/language/2010"
    xmlns:tgs="http://textgrid.info/namespaces/metadata/script/2010"
    xmlns:tgr="http://textgrid.info/namespaces/metadata/agent/2010">
    <xsl:output indent="yes"></xsl:output>
    <xsl:template match="/">
        <TEI xmlns:jxb="http://java.sun.com/xml/ns/jaxb" xmlns:tei="http://www.tei-c.org/ns/1.0"
            xmlns="http://www.tei-c.org/ns/1.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:tns="http://textgrid.info/namespaces/metadata/core/2010"
            xmlns:tgl="http://textgrid.info/namespaces/metadata/language/2010"
            xmlns:tgs="http://textgrid.info/namespaces/metadata/script/2010"
            xmlns:tgr="http://textgrid.info/namespaces/metadata/agent/2010">
            <teiHeader xmlns:fn="http://www.w3.org/2005/xpath-functions"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:a="http://www.textgrid.info/namespace/digibib/authors">
              <fileDesc>
                  <titleStmt>
                      <title>
                          <xsl:value-of select="/tei:TEI/tei:teiHeader[1]/tei:fileDesc[1]/tei:sourceDesc[1]/tei:bibl[1]/tei:title"/>  <!-- title aus titleStmt ohne eltec -->
                      </title> 
                  </titleStmt>
                  <publicationStmt>
<!--                      <idno type="handle">hdl:11858/00-1734-0000-0002-B0FA-D</idno>  -->
                      <idno type="Zenodo-DOI">
                          <xsl:value-of select="/tei:TEI/tei:teiHeader[1]/tei:fileDesc[1]/tei:publicationStmt[1]/tei:ref[1]/@target"/>
                      </idno>  
                      <availibility>
                          <p>All texts included in this collection are in the public domain. The textual markup is provided with a Creative Commons Attribution International 4.0 licence (CC BY, https://creativecommons.org/licenses/by/4.0/).</p>
                      </availibility>
                  </publicationStmt>
                  <notesStmt>
                      <note></note> 
                  </notesStmt>
                  <sourceDesc>
                      <biblFull>
                          <titleStmt>
                              <title></title> <!-- wo Info? aus printsource -->
                              <author>
                                  <xsl:attribute name="key">
                                      <xsl:value-of select="/tei:TEI/tei:teiHeader[1]/tei:fileDesc[1]/tei:titleStmt[1]/tei:author[1]/@ref"/>
                                  </xsl:attribute>
                                  <xsl:value-of select="/tei:TEI/tei:teiHeader[1]/tei:fileDesc[1]/tei:sourceDesc[1]/tei:bibl[1]/tei:author"/>
                              </author>
                          </titleStmt>
                          <publicationStmt>
                              <date>
                                  <xsl:value-of select="/tei:TEI/tei:teiHeader[1]/tei:fileDesc[1]/tei:sourceDesc[1]/tei:bibl[1]/tei:date"/>  <!-- aus printsource -->
                              </date>
                              <pubPlace></pubPlace> <!-- printsource -->
                          </publicationStmt>
                      </biblFull>
                  </sourceDesc>
              </fileDesc>
                <profileDesc>
                    <creation>
                        <date>
                            <xsl:attribute name="notBefore">
                                <xsl:value-of select="/tei:TEI/tei:teiHeader[1]/tei:fileDesc[1]/tei:sourceDesc[1]/tei:bibl[1]/tei:date"/>
                            </xsl:attribute>
                            <xsl:attribute name="notAfter">
                                <xsl:value-of select="/tei:TEI/tei:teiHeader[1]/tei:fileDesc[1]/tei:sourceDesc[1]/tei:bibl[1]/tei:date"/>
                            </xsl:attribute>
                        </date>
                    </creation>
                    <textClass>
                        <keywords scheme="http://textgrid.info/namespaces/metadata/core/2010#genre"></keywords>   <!-- erstmal so belassen -->
                        <term>prose</term>
                    </textClass>
                </profileDesc>
          </teiHeader>  
            <text>
                <xsl:copy-of select="/tei:TEI/tei:text"></xsl:copy-of>
            </text>  
        </TEI>
    </xsl:template>
    <xsl:template name="head4">
        <xsl:value-of select="substring(tei:TEI/@xml:id, 1, 3)"></xsl:value-of>
    </xsl:template>
    <xsl:template match="tei:TEI/@xml:id">
        <xsl:value-of select="."/>
    </xsl:template>
</xsl:stylesheet>