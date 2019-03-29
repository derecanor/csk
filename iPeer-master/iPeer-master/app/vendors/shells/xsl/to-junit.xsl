<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <!-- convert xml output generated by simpletest xml into junit xml format -->
    <xsl:output method="xml"/>

    <xsl:template match="/">
        <xsl:apply-templates select="run/group"/>
    </xsl:template>

    <xsl:template match="run/group">
        <testsuite>
            <xsl:attribute name="errors"><xsl:value-of select="count(.//exception)"/></xsl:attribute>
            <xsl:attribute name="failures"><xsl:value-of select="count(.//fail)"/></xsl:attribute>
            <xsl:attribute name="tests"><xsl:value-of select="count(.//test)"/></xsl:attribute>
            <xsl:attribute name="name"><xsl:value-of select="name"/></xsl:attribute>
            <xsl:attribute name="time"><xsl:value-of select="sum(//time)"/></xsl:attribute>
            <xsl:apply-templates select=".//case/test"/>
            <xsl:copy-of select="//system-err"/>
        </testsuite>
    </xsl:template>

    <xsl:template match="case/test">
        <testcase>
            <xsl:attribute name="classname"><xsl:value-of select="../name"/></xsl:attribute>
            <xsl:attribute name="name"><xsl:value-of select="name"/></xsl:attribute>
            <xsl:attribute name="time"><xsl:value-of select="time"/></xsl:attribute>
            <xsl:apply-templates select="fail"/>
            <xsl:apply-templates select="exception"/>
        </testcase>
    </xsl:template>

    <xsl:template match="fail">
        <failure><xsl:attribute name="message"><xsl:value-of select="."/></xsl:attribute>
            <!-- content is for stacktrace; not available / broken out by simpletest -->
        </failure>
    </xsl:template>

    <xsl:template match="exception">
        <!-- assuming same format as fail -->
        <error><xsl:attribute name="message"><xsl:value-of select="."/></xsl:attribute>
            <!-- content is for stacktrace; not available / broken out by simpletest -->
        </error>
    </xsl:template>

</xsl:stylesheet>
