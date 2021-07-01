<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei"
    version="2.0">
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
    <xsl:strip-space elements="*"/>
    <xsl:template match="*">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" />
        </xsl:copy>
    </xsl:template>
    <xsl:template match="@*|text()|comment()|processing-instruction()">
        <xsl:copy-of select="." />
    </xsl:template>
    <xsl:template match="/TEI/text/body/div/ab/@type"/>
    <xsl:template match="/TEI/text/body/div/ab/comment"/>
    <xsl:template match="/TEI/text/body/div/note/comment"/>
    <xsl:template match="/TEI/text/body/div/ab/hi/comment"/>
    <xsl:template match="/TEI/text/body/div/ab/blackening"/>
    <xsl:template match="/TEI/text/body/div/fw/comment"/>
    
    <xsl:template match="ab">
        <xsl:element name="lg">
            <xsl:attribute name="xml:id">
                <xsl:value-of select="@facs" />
            </xsl:attribute>
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="lb">
        <xsl:element name="l">
            <xsl:attribute name="n">
                <xsl:value-of select="@n" />
            </xsl:attribute>
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="text()[ancestor::tei:ab]">
        <xsl:for-each select="tokenize(., '[\s]')[.]">
            <w><xsl:sequence select="."/></w>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="text()[normalize-space() = '.']" />
    
    <xsl:template match="node()[following-sibling::node()[1][self::text()][normalize-space() = '.']]">
        <w>
            <xsl:copy>
                <xsl:apply-templates select="node()|@*"/>
            </xsl:copy>
            <xsl:text>.</xsl:text>
        </w>
    </xsl:template>
    
</xsl:stylesheet>
