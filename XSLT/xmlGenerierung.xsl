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
                          <xsl:value-of select="/tei:TEI/tei:teiHeader[1]/tei:fileDesc[1]/tei:sourceDesc[1]/tei:bibl[1]/tei:title"/>  <!-- kommt das hierein, oder DEU001? -->
<!--                          <xsl:apply-templates select="tei:TEI/@xml:id"></xsl:apply-templates>-->
                      </title> 
                  </titleStmt>
                  <publicationStmt>
                      <idno type="handle">hdl:11858/00-1734-0000-0002-B0FA-D</idno>  <!-- immer gleich? -->
                      <idno type="TextGridUri">textgrid:n1s9.0</idno>  <!-- immer gleich? -->
                      <availibility>
                          <p> Der annotierte Datenbestand der Digitalen Bibliothek inklusive Metadaten sowie
                              davon einzeln zugängliche Teile sind eine Abwandlung des Datenbestandes von
                              www.editura.de durch TextGrid und werden unter der Lizenz Creative Commons
                              Namensnennung 3.0 Deutschland Lizenz (by-Nennung TextGrid) veröffentlicht. Die
                              Lizenz bezieht sich nicht auf die der Annotation zu Grunde liegenden
                              allgemeinfreien Texte (Siehe auch Punkt 2 der Lizenzbestimmungen). </p>
                          <p>
                              <ref target="http://creativecommons.org/licenses/by/3.0/de/legalcode"
                                  >Lizenzvertrag</ref>
                          </p>
                          <p>
                              <ref target="http://creativecommons.org/licenses/by/3.0/de/"> Eine vereinfachte
                                  Zusammenfassung des rechtsverbindlichen Lizenzvertrages in
                                  allgemeinverständlicher Sprache </ref>
                          </p>
                          <p>
                              <ref target="http://www.textgrid.de/Digitale-Bibliothek">Hinweise zur Lizenz und
                                  zur Digitalen Bibliothek</ref>
                          </p>
                      </availibility>
                  </publicationStmt>
                  <notesStmt>
                      <note></note> <!-- wo Info? -->
                  </notesStmt>
                  <sourceDesc>
                      <biblFull>
                          <titleStmt>
                              <title></title> <!-- wo Info? -->
                              <author>
                                  <xsl:attribute name="key">
                                      <xsl:value-of select="/tei:TEI/tei:teiHeader[1]/tei:fileDesc[1]/tei:titleStmt[1]/tei:author[1]/@ref"/>
                                  </xsl:attribute>
                                  <xsl:value-of select="/tei:TEI/tei:teiHeader[1]/tei:fileDesc[1]/tei:sourceDesc[1]/tei:bibl[1]/tei:author"/>
                              </author>
                          </titleStmt>
                          <extent></extent>  <!-- wo Info? -->
                          <publicationStmt>
                              <date>
                                  <xsl:value-of select="/tei:TEI/tei:teiHeader[1]/tei:fileDesc[1]/tei:sourceDesc[1]/tei:bibl[1]/tei:date"/>
                              </date>
                              <pubPlace></pubPlace> <!-- wo Info? -->
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
                        <keywords scheme="http://textgrid.info/namespaces/metadata/core/2010#genre"></keywords>   <!-- immer gleich? -->
                        <term>prose</term>
                    </textClass>
                </profileDesc>
          </teiHeader>  
            <front>
                <div type="front">
                    <head type="h3" xml:d=""> <!-- woher xml:id? -->
                         <xsl:value-of select="/tei:TEI/tei:teiHeader[1]/tei:fileDesc[1]/tei:sourceDesc[1]/tei:bibl[1]/tei:author"/>
                     </head> 
                    <head type="h2" xml:id=""> <!--  woher xml:id? -->
                         <xsl:apply-templates select="tei:TEI/@xml:id"></xsl:apply-templates>
                     </head> 
                    <head type="h4" xml:id=""> <!-- woher xml:id?; Roman=DEU? -->
                         <xsl:call-template name="head4"></xsl:call-template>
                     </head> 
                     <milestone unit="sigel" n="Fontane-RuE Bd. 4" xml:id="tg430.3.5"/> <!-- woher die Werte für die Attribute? -->
                </div>
            </front>
            <body>
                <!-- wonach richten sich die Unterteilungen mit Attributen? -->
                <!-- wonach richtet sich die Zählung? -->
            </body>
            
        </TEI>
    </xsl:template>
    
    
    <xsl:template name="head4">
        <xsl:value-of select="substring(tei:TEI/@xml:id, 1, 3)"></xsl:value-of>
    </xsl:template>
    <xsl:template match="tei:TEI/@xml:id">
        <xsl:value-of select="."/>
    </xsl:template>
</xsl:stylesheet>