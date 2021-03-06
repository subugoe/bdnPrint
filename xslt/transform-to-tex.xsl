<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns:math="http://exslt.org/math" version="2.0">

    <xsl:output method="text"/>

    <xsl:strip-space elements="*"/>
    <xsl:preserve-space elements="abbr byline corr docImprint edition head hi
    item label lem note p persName rdg ref sic term titlePart"/>

    <xsl:template match="div"/>
    <xsl:template match="front"/>
    <xsl:template match="expan"/>
    <xsl:template match="head"/>
    <xsl:template match="teiHeader"/>
    <xsl:template match="sic"/>


    <!-- TEI -->

    <xsl:template match="TEI">
        <xsl:apply-templates/>

        <xsl:text>
            \emptyEvenPage
            \startpart[title={Erläuterungen}]
    
            \definelayout[odd]
            [backspace=48.5mm,
            width=113mm,
            height=191mm]

            \definelayout[even]
            [backspace=48.5mm,
            width=113mm,
            height=191mm]

            \setuplayout

            \startsetups[a]
            \switchtobodyfont[default]
            \rlap{}
            \hfill
            {\tfx\it Erläuterungen}
            \hfill
            \llap{\pagenumber}
            \stopsetups

            \startsetups[b]
            \switchtobodyfont[default]
            \rlap{\pagenumber}
            \hfill
            {\tfx\it Erläuterungen}
            \hfill
            \llap{}
            \stopsetups
        </xsl:text>
        
        <xsl:text>
            \blank[9mm]

            \starttabulate[|lp(10mm)|xp(103mm)|]</xsl:text>
            <xsl:for-each select="//ptr">
                <xsl:if test="matches(@target, '^#erl_')">
                    <xsl:variable name="target" select="replace(@target, '^#', '')"/>
                    <xsl:text>\NC\at[</xsl:text>
                    <xsl:value-of select="generate-id()"/>
                    <xsl:text>]\NC\italic{</xsl:text>
                    <xsl:apply-templates select="//note[@xml:id = $target]/label"/>
                    <xsl:text>}\crlf\setupindenting[yes, 4mm, next] </xsl:text>
                    <xsl:apply-templates select="//note[@xml:id = $target]/p"/>
                    <xsl:text>\NC\AR</xsl:text>
                </xsl:if>
            </xsl:for-each>
            <xsl:text>
                \stoptabulate
                \stoppart
            </xsl:text>
    </xsl:template>


    <!-- app -->

    <xsl:template match="app">
        <xsl:variable name="ppWitTmp" select="string-join(rdg[@type = 'pp' or @type = 'ppl']/@wit, '')"/>
        <xsl:variable name="ppWit" select="replace($ppWitTmp, '[^a-z]', '')"/>

        <xsl:variable name="omWitTmp" select="string-join(rdg[@type = 'om']/@wit, '')"/>
        <xsl:variable name="omWit" select="replace($omWitTmp, '[^a-z]', '')"/>

        <xsl:if test="starts-with(lem, ';')">
            <xsl:text> </xsl:text>
        </xsl:if>

        <xsl:if test="rdg[@type = 'pp' or @type = 'ppl']">
            <xsl:text>{\tfx\high{/</xsl:text>
            <xsl:value-of select="$ppWit"/>
            <xsl:text>}}</xsl:text>
        </xsl:if>

        <xsl:if test="rdg[@type = 'om'] and not(lem/note)">
            <xsl:text>\margin{}{omOpen}{</xsl:text>
            <xsl:value-of select="generate-id()"/>
            <xsl:text>}{\tfx\high{/</xsl:text>
            <xsl:value-of select="$omWit"/>
            <xsl:text>}}{/</xsl:text>
            <xsl:value-of select="$omWit"/>
            <xsl:text>}</xsl:text>
        </xsl:if>

        <xsl:apply-templates select="lem"/>

        <xsl:if test="rdg[@type = 'om'] and not(lem/note)">
            <xsl:text>\margin{}{omClose}{</xsl:text>
            <xsl:value-of select="generate-id()"/>
            <xsl:text>}{\tfx\high{</xsl:text>
            <xsl:value-of select="$omWit"/>
            <xsl:text>\textbackslash}}{</xsl:text>
            <xsl:value-of select="$omWit"/>
            <xsl:text>\textbackslash}</xsl:text>

            <xsl:if test="rdg[@type = 'om' and (following::*)[1][self::index]]">
                <xsl:text> </xsl:text>
            </xsl:if>
        </xsl:if>

        <xsl:choose>
            <xsl:when test="count(rdg) gt 1 and rdg[@type = 'pp']">
                <xsl:if test="rdg[@type = 'v']">
                    <xsl:apply-templates select="rdg[@type = 'v']" mode="footnote"/>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>

        <xsl:if test="rdg[@type = 'pp' or @type = 'ppl']">
            <xsl:text>{\tfx\high{</xsl:text>
                <xsl:value-of select="$ppWit"/>
            <xsl:text>\textbackslash}}</xsl:text>
        </xsl:if>

        <xsl:choose>
            <xsl:when test="count(rdg) >= 2 and rdg[(@type = 'ptl' or @type = 'ppl')] and rdg[@type = 'pp']">
                <xsl:choose>
                    <xsl:when test="parent::note/*[1] = .">
                        <xsl:text>\blank[-6pt]</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                    <xsl:text>\blank[6pt]</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:text>{\switchtobodyfont[8.5pt]</xsl:text>
                <!--\startnarrower[left]-->
                <xsl:text>\noindent</xsl:text>
                <xsl:apply-templates select="rdg[@type = 'ptl' or @type = 'ppl']" mode="pl"/>
                <!--\stopnarrower-->
                <xsl:text>
                    }
                    \blank[6pt]
                    \noindent
                </xsl:text>

                <xsl:text> {\dvl}</xsl:text>
                <xsl:apply-templates select="rdg[@type = 'pp']" mode="footnote"/>
            </xsl:when>
            
            <xsl:when test="rdg[@type = 'ptl' or @type = 'ppl']">
                <xsl:choose>
                    <xsl:when test="parent::note/*[1] = .">
                        <xsl:text>\blank[-6pt]</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>\blank[6pt]</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
                
                <xsl:text>{\switchtobodyfont[8.5pt]</xsl:text>
                
                <xsl:if test="rdg[@type = 'ptl' or @type = 'ppl']/(child::*)[1][self::note[@type = 'authorial']]">
                    <xsl:text>\startnarrower[left]</xsl:text>
                </xsl:if>
                
                <xsl:text>\noindent</xsl:text>
                
                <xsl:apply-templates select="rdg" mode="pl"/>
                
                <xsl:if test="rdg[@type = 'ptl' or @type = 'ppl']/(child::*)[1][self::note[@type = 'authorial']]">
                    <xsl:text>\stopnarrower</xsl:text>
                </xsl:if>
                
                <xsl:text>
                    }
                    \blank[6pt]
                    \noindent
                </xsl:text>
            </xsl:when>
            
            <xsl:otherwise>
                <xsl:if test="rdg[@type != 'om' and @type != 'typo_corr']">
                    <xsl:if test="rdg[@type != 'v']">
                        <!-- <xsl:text>~‖</xsl:text> -->
                        <!-- <xsl:text>~\|\kern-.1em\|</xsl:text> -->
                        <xsl:text> {\dvl}</xsl:text>
                    </xsl:if>

                    <xsl:choose>
                        <xsl:when test="count(rdg) gt 1 and rdg[@type = 'pp']">
                            <xsl:choose>
                                <xsl:when test="rdg[@type = 'v']">
                                    <xsl:apply-templates select="rdg[@type = 'pp']" mode="footnote"/>
                                </xsl:when>
                                
                                <xsl:otherwise>
                                    <xsl:apply-templates select="rdg" mode="footnote"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        
                        <xsl:otherwise>
                            <xsl:apply-templates select="rdg" mode="footnote"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- app: structural variance. ignoring lems with missing structure -->
    <xsl:template match="app[@type = 'structural-variance']">
        <xsl:choose>
            <xsl:when test="not(lem[@type = 'missing-structure'])">
                <xsl:apply-templates/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>


    <!-- structural variance: scribal abbreviations. declared in header.tex. -->

    <xsl:template match="milestone[@type = 'structure']">
        <xsl:variable name="edt" select="replace(@edRef, '^#', '')"/>
        <xsl:variable name="parent" select="(parent::rdg)[1]/@type"/>
        <xsl:choose>
            <xsl:when test="($parent = 'ppl' or $parent = 'ptl') and not(preceding-sibling::*)">
                <xsl:if test="@unit = 'p'">
                    <xsl:text> \p{}</xsl:text>
                </xsl:if>

                <xsl:if test="@unit = 'line'">
                    <xsl:text> \line{}</xsl:text>
                </xsl:if>

                <xsl:text>{\tfx\high{</xsl:text>
                <xsl:value-of select="$edt"/>
                <xsl:text>}} </xsl:text>
            </xsl:when>

            <xsl:when test="$parent = 'ppl' or $parent = 'ptl'">
                <xsl:text>\\</xsl:text>
                <xsl:if test="@unit = 'p'">
                    <!-- hidden element necessary, otherwise no display of hspace 
                    at the beginning of a paragraph -->
                    <xsl:text>
                        \starteffect[hidden]
                            .
                        \stopeffect
                        \hspace[p]
                    </xsl:text>
                </xsl:if>
            </xsl:when>

            <xsl:otherwise>
                <xsl:if test="@unit = 'p'">
                    <xsl:text> \p{}</xsl:text>
                </xsl:if>

                <xsl:if test="@unit = 'line'">
                    <xsl:text> \line{}</xsl:text>
                </xsl:if>

                <xsl:text>{\tfx\high{</xsl:text>
                <xsl:value-of select="$edt"/>
                <xsl:text>}} </xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


    <!-- div -->

    <xsl:template match="div[@type = 'section-group']">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="div[@type = 'section']">
        <xsl:text>\startsubject[title={</xsl:text>
        <xsl:call-template name="pbHead"/>
        <xsl:value-of select="head[1]/text()"/>
        <xsl:text>}]</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>\stopsubject </xsl:text>
    </xsl:template>


    <!-- Test paragraph -->

    <!-- <xsl:template match="div[preceding-sibling::div[1][@n = 150]]">
    <xsl:text>\startsubject[title={</xsl:text>
    <xsl:call-template name="pbHead"/>
    <xsl:value-of select="head[1]/text()"/>
    <xsl:text>}]</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>\stopsubject </xsl:text>
  </xsl:template> -->


    <!-- foreign -->

    <xsl:template match="foreign[@xml:lang = 'gr']">
        <!-- ebFont has to be taken away, otherwise diacritica are displayed wrongly -->
        <!--<xsl:text>{\ebFont </xsl:text>-->
        <xsl:apply-templates/>
        <!--<xsl:text>}</xsl:text>-->
    </xsl:template>

    <xsl:template match="foreign[@xml:lang = 'he']">
        <xsl:text>{\ezraFont </xsl:text>
        <xsl:apply-templates/>
        <xsl:text>}</xsl:text>
    </xsl:template>


    <!-- hi -->

    <xsl:template match="hi">
        <xsl:text>\italic{</xsl:text>
            <xsl:apply-templates/>
        <xsl:text>}</xsl:text>
        <xsl:if test="(following::node())[1][self::app or self::index]">
            <xsl:text> </xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template match="hi[@rend]">
        <xsl:choose>
            <xsl:when test="@rend = 'right-aligned'">
                <xsl:text>\rightaligned{</xsl:text>
                    <xsl:apply-templates/>
                <xsl:text>}</xsl:text>
            </xsl:when>
            
            <xsl:when test="@rend = 'bold'">
                <xsl:text>\bold{</xsl:text>
                    <xsl:apply-templates/>
                <xsl:text>}</xsl:text>
            </xsl:when>
            
            <xsl:when test="@rend = 'center-aligned'">
                <xsl:text>\startalignment[center]%</xsl:text>
                    <xsl:apply-templates/>
                <xsl:text>\stopalignment%</xsl:text>
            </xsl:when>
            
            <xsl:when test="@rend = 'small-caps'">
                <xsl:text>{\sc </xsl:text>
                    <xsl:apply-templates/>
                <xsl:text>}</xsl:text>
            </xsl:when>
            
            <xsl:when test="@rend = 'compact'">
                <!-- to be done -->
            </xsl:when>
            
            <xsl:when test="@rend = 'spaced-out'">
                <!-- to be done -->
            </xsl:when>
            
            <xsl:when test="@rend = 'margin-vertical'">
                <xsl:text>\\</xsl:text>
                <xsl:apply-templates/>
            </xsl:when>
            
            <xsl:when test="@rend = 'margin-horizontal'">
                <xsl:text>\hspace[margin-horizontal]</xsl:text>
                <xsl:apply-templates/>
            </xsl:when>
            
            <xsl:when test="@rend = 'subscript'">
                <xsl:text>{\tx\low{</xsl:text>
                    <xsl:apply-templates/>
                <xsl:text>}}</xsl:text>
            </xsl:when>
            
            <xsl:when test="@rend = 'superscript'">
                <xsl:text>\high{{\tx </xsl:text>
                    <xsl:apply-templates/>
                <xsl:text>}}</xsl:text>
            </xsl:when>
        </xsl:choose>
    </xsl:template>


    <!-- index -->

    <xsl:template match="index/term" priority="-1"/>

    <xsl:template match="index[@indexName = 'classical-authors']/term">
        <xsl:text>\antIndex{</xsl:text>
        <!--<xsl:value-of select="normalize-space(persName/text())"/>-->
        <xsl:value-of select="persName"/>

        <xsl:if test="title">
            <xsl:text>+</xsl:text>
        </xsl:if>

        <xsl:apply-templates select="title"/>
        <xsl:text>}</xsl:text>
    </xsl:template>

    <xsl:template match="index[@indexName = 'bibel']/term">
        <xsl:text>\bibelIndex{</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>}</xsl:text>
    </xsl:template>

    <xsl:template match="index[@indexName = 'persons']/term">
        <xsl:text>\persIndex{</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>}</xsl:text>
    </xsl:template>

    <xsl:template match="index[@indexName = 'subjects']/term">
        <xsl:text>\sachIndex[</xsl:text>
        <!-- necessary for indexing. 
            otherwise terms beginning with lower case will be sorted after terms with upper case.
            only sachIndex has items which start with lower case letters. -->
        <xsl:value-of select="upper-case(.)"/>
        <xsl:text>]{</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>}</xsl:text>
    </xsl:template>

    <xsl:template match="lb">
        <xsl:text>\crlf </xsl:text>
    </xsl:template>
    
    <xsl:template match="persName">
        <xsl:apply-templates/>
    </xsl:template>


    <!-- note -->

    <xsl:template match="note[@type = 'authorial']" priority="-1">
        <xsl:choose>
            <xsl:when test="preceding-sibling::*[1][self::note] or preceding-sibling::*[1][self::app/rdg[@type = 'ppl' or 'ptl']] or preceding-sibling::*[1][self::p]">
                <xsl:text>\blank[-10pt]</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>\blank[6pt]</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text>
            {\switchtobodyfont[8.5pt]
            \startnarrower[left]
            \noindent
        </xsl:text>
        <xsl:call-template name="pbBefore"/>
        <xsl:apply-templates/>
        <xsl:text>
            \stopnarrower}
            \blank[6pt]
            \noindent
        </xsl:text>
    </xsl:template>

    <xsl:template match="app[not(@type = 'structural-variance')]/lem/note[@type = 'authorial']">
        <xsl:variable name="omWitTmp" select="string-join(../../rdg[@type = 'om']/@wit, '')"/>
        <xsl:variable name="omWit" select="replace($omWitTmp, '[^a-z]', '')"/>
        <xsl:text>
            \blank[6pt]
            {\switchtobodyfont[8.5pt]
            \startnarrower[left]
            \noindent
        </xsl:text>
        <xsl:text>\margin{}{omOpen}{</xsl:text>
        <xsl:value-of select="generate-id()"/>
        <xsl:text>}{\tfx\high{/</xsl:text>
        <xsl:value-of select="$omWit"/>
        <xsl:text>}}{/</xsl:text>
        <xsl:value-of select="$omWit"/>
        <xsl:text>}</xsl:text>

        <xsl:call-template name="pbBefore"/>
        <xsl:apply-templates/>

        <xsl:text>\margin{}{omClose}{</xsl:text>
        <xsl:value-of select="generate-id()"/>
        <xsl:text>}{\tfx\high{</xsl:text>
        <xsl:value-of select="$omWit"/>
        <xsl:text>\textbackslash}}{</xsl:text>
        <xsl:value-of select="$omWit"/>
        <xsl:text>
            \textbackslash}
            \stopnarrower}
            \blank[6pt]
            \noindent
        </xsl:text>
    </xsl:template>

    <xsl:template match="rdg/note[@type = 'authorial']">
        <xsl:call-template name="pbBefore"/>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="note[@type = 'editorial' and @place = 'bottom']">
        <xsl:text>\editor{</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>}</xsl:text>
    </xsl:template>

    <xsl:template match="note[@type = 'editorial' and @place = 'end']"/>

    <xsl:template match="seg">
        <xsl:apply-templates/>
    </xsl:template>


    <!-- p -->

    <xsl:template match="p">
        <xsl:call-template name="pbBefore"/>
        <xsl:apply-templates/>
        <xsl:text>\par </xsl:text>
    </xsl:template>


    <!-- pb -->

    <xsl:template match="p//pb" priority="-1">
        <xsl:text>\margin{}{pb}{}{\vl}{</xsl:text>
        <xsl:value-of select="replace(@edRef, '[# ]+', '')"/>
        <xsl:value-of select="@n"/>
        <xsl:text>}</xsl:text>
        <xsl:if test="(following::node())[1][self::index]">
            <xsl:text> </xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template match="note//pb" priority="-1">
        <xsl:text>\margin{}{pb}{}{\vl}{</xsl:text>
        <xsl:value-of select="replace(@edRef, '[# ]+', '')"/>
        <xsl:value-of select="@n"/>
        <xsl:text>}</xsl:text>
        <xsl:if test="(following::node())[1][self::index]">
            <!--<xsl:text> </xsl:text>-->
        </xsl:if>
    </xsl:template>

    <xsl:template match="rdg[@type != 'ppl' and @type != 'ptl']//pb">
        <xsl:text>{\tf{\vl}</xsl:text>
        <xsl:variable name="wit" select="@edRef"/>
        <xsl:value-of select="replace($wit, '#', '')"/>
        <xsl:value-of select="@n"/>
        <xsl:text>\vl}</xsl:text>
    </xsl:template>

    <xsl:template match="rdg[@type = 'typo_corr']"/>

    <xsl:template name="pbBefore">
        <xsl:variable name="pb" select="preceding-sibling::*[1][self::pb]"/>
        <xsl:if test="$pb">
            <xsl:text>\margin{}{pb}{}{\vl}{</xsl:text>
            <xsl:value-of select="replace($pb/@edRef, '[# ]+', '')"/>
            <xsl:value-of select="$pb/@n"/>
            <xsl:text>} </xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template name="pbHead">
        <xsl:variable name="pb" select="preceding-sibling::*[1][self::pb]"/>
        <xsl:if test="$pb">
            <xsl:text>\vl\margindata[inouter]{</xsl:text>
            <xsl:value-of select="replace($pb/@edRef, '[# ]+', '')"/>
            <xsl:value-of select="$pb/@n"/>
            <xsl:text>} </xsl:text>
        </xsl:if>
    </xsl:template>


    <!-- ptr -->

    <xsl:template match="ptr">
        <xsl:if test="matches(@target, '^#erl_') and (not(ancestor::rdg) or ancestor::rdg[@type = 'ptl' or @type = 'ppl'])">
            <xsl:text>\margin{}{e}{}{\hbox{}}{E}\pagereference[</xsl:text>
            <xsl:value-of select="generate-id()"/>
            <xsl:text>]</xsl:text>
        </xsl:if>
        <xsl:if test="matches(@target, '^#erl_') and ancestor::rdg and not(ancestor::rdg[@type = 'ptl' or @type = 'ppl'])">
            <xsl:text>[E] \pagereference[</xsl:text>
            <xsl:value-of select="generate-id()"/>
            <xsl:text>]</xsl:text>
        </xsl:if>
    </xsl:template>


    <!-- rdg -->

    <xsl:template match="rdg" mode="pl">
        <xsl:if test="@type != 'om' and @type != 'typo_corr'">
            <xsl:variable name="wit" select="replace(@wit, '[# ]+', '')"/>

            <xsl:text>\margin{}{plOpen}{</xsl:text>
            <xsl:value-of select="generate-id()"/>
            <xsl:text>}{\tfx\high{</xsl:text>
            <xsl:value-of select="$wit"/>
            <xsl:text>}}{</xsl:text>
            <xsl:value-of select="$wit"/>
            <xsl:text>}</xsl:text>

            <xsl:apply-templates/>

            <xsl:text>\margin{}{plClose}{</xsl:text>
            <xsl:value-of select="generate-id()"/>
            <xsl:text>}{\tfx\high{</xsl:text>
            <xsl:value-of select="$wit"/>
            <xsl:text>}}{</xsl:text>
            <xsl:value-of select="$wit"/>
            <xsl:text>}</xsl:text>

            <xsl:if test="position() != last()">
                <xsl:text>
                    \par
                    \blank[6pt]
                    \noindent
                </xsl:text>
            </xsl:if>
        </xsl:if>
    </xsl:template>

    <xsl:template match="rdg" mode="footnote">
        <xsl:if test="@type != 'om' and @type != 'typo_corr'">
            <xsl:variable name="wit" select="replace(@wit, '[# ]+', '')"/>

            <xsl:text>\</xsl:text>
            <xsl:value-of select="$wit"/>
            <xsl:text>Note{</xsl:text>
                <xsl:apply-templates/>
            <xsl:text>}</xsl:text>
        </xsl:if>

        <xsl:if test="following::*[self::app]">
            <xsl:text> </xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template match="rdg[@type = 'var-structure']"/>

    <xsl:template match="choice">
        <xsl:if test="descendant::abbr">
            <xsl:apply-templates select="abbr"/>
        </xsl:if>

        <xsl:if test="descendant::corr">
            <xsl:apply-templates select="corr"/>
        </xsl:if>
        
        <xsl:if test="(following::node())[1][self::app]">
            <xsl:text> </xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template match="list">
        <xsl:text>
           \setupindenting[yes,medium]
	       \setupitemgroup[itemize][indenting={40pt,next}]
	       \startitemize[packed, joinedup, nowhite, inmargin]
	    </xsl:text>
        <xsl:apply-templates/>
        <xsl:text>\stopitemize</xsl:text>
    </xsl:template>

    <xsl:template match="item">
        <!-- usage of \sym instead of \item is necessary to get a list without bullets etc. -->
        <xsl:text>\sym{}</xsl:text>
        <xsl:apply-templates/>
    </xsl:template>
</xsl:stylesheet>
