<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0"
  version="2.0">

  <xsl:output method="text"/>

  <xsl:template match="*">
    <xsl:if test="* and matches(string-join(text(), ''), '[^\s]')">
      <xsl:value-of select="name(.)"/>
      <xsl:text>&#xa;</xsl:text>
    </xsl:if>
    <xsl:apply-templates select="*"/>
  </xsl:template>

</xsl:stylesheet>
