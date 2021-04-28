<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" exclude-result-prefixes="xs math xd">
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="/root">
        <mei>
            <xsl:apply-templates select="/root/TEI"/>
        </mei>
    </xsl:template>
    <xsl:template match="/root/TEI">
        <music>
            <xsl:apply-templates select="/root/TEI/children"/>
        </music>
    </xsl:template>
    <xsl:template match="/root/TEI/children">
        <body>
            <xsl:apply-templates select="/root/TEI/children/item"/>
        </body>
    </xsl:template>
    <xsl:template match="/root/TEI/children/item">
        <mdiv>
            <xsl:apply-templates select="/root/TEI/children/item/children"/>
        </mdiv>
    </xsl:template>
    
    <xsl:template match="/root/TEI/children/item/children/item">
        <score>
            <xsl:apply-templates select="/root/TEI/children/item/children/item/children/text()"/>
            <scoreDef>
                <staffGrp>
                    <staffDef>
                        <xsl:copy-of select="shape"/>
                        <xsl:attribute name="clef.shape">
                            <xsl:value-of select=".//shape/text()"/>
                            <xsl:apply-templates select=".//shape[text()]"/>
                        </xsl:attribute>
                        <!--
                                                <xsl:attribute name="clef.line"/>
                                                -->
                        <xsl:attribute name="n"/>
                        <xsl:attribute name="lines"/>
                        <xsl:attribute name="notationtype">
                            <xsl:apply-templates select="'mensural.black'"/>
                        </xsl:attribute>
                        
                    </staffDef>
                </staffGrp>
            </scoreDef>
        </score>
        <section>
            <xsl:attribute name="n">
                <xsl:number level="single"/>
            </xsl:attribute>
            <measure>
            <xsl:apply-templates select="/root/TEI/children/item/children/item/children/text()"/>
           
                <staff>
                    <xsl:attribute name="n">
                        <xsl:number level="single"/>
                    </xsl:attribute>
                
                    <layer>
                        <xsl:attribute name="n">
                            <xsl:number level="multiple"/>
                        </xsl:attribute>
                        <xsl:for-each
                            select=".//children/item">
                        <neume>
                            <xsl:element name="nc">
                                <xsl:attribute name="pname">
                                    <xsl:value-of select=".//base/text()"/>
                                    <xsl:apply-templates select="base[text()]"/>
                                </xsl:attribute>
                                <xsl:attribute name="oct">
                                    <xsl:value-of select=".//octave/text()"/>
                                    <xsl:apply-templates select="octave[text()]"/>
                                </xsl:attribute>
                                <!--
                                                        <xsl:attribute name="dur">
                                                            <xsl:apply-templates select="'brevis'"/>
                                                        </xsl:attribute>
                                                        -->
                                <xsl:element name="plica">
                                    <xsl:attribute name="dir"/>
                                </xsl:element>
                            </xsl:element>
                            <xsl:element name="syllabe">
                                <xsl:apply-templates select=".//text/text()"/>
                            </xsl:element>
                        </neume>
                        </xsl:for-each>
                    </layer>
                </staff>
               
            </measure>
        </section>
    </xsl:template>



</xsl:stylesheet>