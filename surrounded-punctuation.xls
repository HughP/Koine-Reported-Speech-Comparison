<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:param name="pSeparators">&#x2018;&#x2019;&#x201C;&#x201D; </xsl:param>
    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="corpus/text()" name="tokenize">
        <xsl:param name="pString" select="."/>
        <xsl:param name="pMask"
                   select="translate(.,translate(.,$pSeparators,''),'')"/>
        <xsl:param name="pCount" select="1"/>
        <xsl:choose>
            <xsl:when test="not($pString)"/>
            <xsl:when test="$pMask">
                <xsl:variable name="vSeparator"
                              select="substring($pMask,1,1)"/>
                <xsl:variable name="vString"
                              select="substring-before($pString,$vSeparator)"/>
                <xsl:call-template name="tokenize">
                    <xsl:with-param name="pString" select="$vString"/>
                    <xsl:with-param name="pMask"/>
                    <xsl:with-param name="pCount" select="$pCount"/>
                </xsl:call-template>
                <xsl:value-of select="$vSeparator"/>
                <xsl:call-template name="tokenize">
                    <xsl:with-param name="pString"
                               select="substring-after($pString,$vSeparator)"/>
                    <xsl:with-param name="pMask"
                                    select="substring($pMask,2)"/>
                    <xsl:with-param name="pCount"
                                    select="$pCount + boolean($vString)"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <pc>
                    <xsl:value-of select="$pString"/>
                </pc>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
