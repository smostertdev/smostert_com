<?xml version="1.0"?>

<!-- A sample XML transformation style sheet for displaying the Subversion
  directory listing that is generated by mod_dav_svn when the "SVNIndexXSLT"
  directive is used. -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

        <xsl:output method="html"/>

        <xsl:template match="*"/>

        <xsl:template match="svn">
                <html>
                        <head>
                                <title>
                                        <xsl:if test="string-length(index/@name) != 0">
                                                <xsl:value-of select="index/@name"/>
                                                <xsl:text>: </xsl:text>
                                        </xsl:if>
                                        <xsl:value-of select="index/@path"/>
                                </title>
                                <link rel="stylesheet" type="text/css" href="/svnindex.css"/>
                                <script type="text/javascript">
                                        function onLoadHandler(){
                                                for(var i = 0; i &lt; document.links.length; i++){
                                                        if(document.links[i].target == 'tsvn'){
                                                                document.links[i].href = 'tsvn:' + document.links[i].href;
                                                        }
                                                }
                                        }
                                </script>
                        </head>
                        <body onload="onLoadHandler()">
                                <div class="svn">
                                        <xsl:apply-templates/>
                                </div>
                                <div class="footer">
                                        <xsl:element name="a">
                                                <xsl:attribute name="style">float: right;</xsl:attribute>
                                                <xsl:attribute name="href">
                                                        http://tortoisesvn.net
                                                </xsl:attribute>
                                                <xsl:text>TortoiseSVN</xsl:text>
                                        </xsl:element>

                                        <xsl:text>Powered by </xsl:text>
                                        <xsl:element name="a">
                                                <xsl:attribute name="href">
                                                        <xsl:value-of select="@href"/>
                                                </xsl:attribute>
                                                <xsl:text>Subversion</xsl:text>
                                        </xsl:element>
                                        <xsl:text> </xsl:text>
                                        <xsl:value-of select="@version"/>
                                </div>
                        </body>
                </html>
        </xsl:template>

        <xsl:template match="index">
                <div class="rev">
                        <xsl:if test="string-length(@name) != 0">
                                <xsl:value-of select="@name"/>
                                <xsl:if test="string-length(@rev) != 0">
                                        <xsl:text> &#8212; </xsl:text>
                                </xsl:if>
                        </xsl:if>
                        <xsl:if test="string-length(@rev) != 0">
                                <xsl:text>Revision </xsl:text>
                                <xsl:value-of select="@rev"/>
                        </xsl:if>
                </div>
                <div class="path">
                        <xsl:value-of select="@path"/>
                </div>
                <xsl:apply-templates select="updir"/>
                <xsl:apply-templates select="dir"/>
                <xsl:apply-templates select="file"/>
        </xsl:template>

        <xsl:template match="updir">
                <div class="updir">
                        <xsl:text>[</xsl:text>
                        <xsl:element name="a">
                                <xsl:attribute name="href">..</xsl:attribute>
                                <xsl:text>Parent Directory</xsl:text>
                        </xsl:element>
                        <xsl:text>]</xsl:text>
                </div>
    <!-- xsl:apply-templates/ -->
        </xsl:template>

        <xsl:template match="dir">
                <div class="dir">
                        <xsl:element name="a">
                                <xsl:attribute name="title">Checkout: <xsl:value-of select="@href"/></xsl:attribute>
                                <xsl:attribute name="style">float: right;</xsl:attribute>
                                <xsl:attribute name="target">tsvn</xsl:attribute>
                                <xsl:attribute name="href">
                                        <xsl:value-of select="@href"/>
                                </xsl:attribute>
                                <img src="/menucheckout.ico"/>
                        </xsl:element>
                        <xsl:element name="a">
                                <xsl:attribute name="style">margin-right: 22px</xsl:attribute>
                                <xsl:attribute name="href">
                                        <xsl:value-of select="@href"/>
                                </xsl:attribute>
                                <xsl:value-of select="@name"/>
                                <xsl:text>/</xsl:text>
                        </xsl:element>
                </div>
    <!-- <xsl:apply-templates/ -->
        </xsl:template>

        <xsl:template match="file">
                <div class="file">
                        <xsl:element name="a">
                                <xsl:attribute name="href">
                                        <xsl:value-of select="@href"/>
                                </xsl:attribute>
                                <xsl:value-of select="@name"/>
                        </xsl:element>
                </div>
    <!-- xsl:apply-templates/ -->
        </xsl:template>

</xsl:stylesheet>