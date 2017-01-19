<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns:math="http://exslt.org/math" version="2.0">

    <xsl:output method="text"/>

    <xsl:strip-space elements="*"/>
    <xsl:preserve-space elements="abbr byline corr docImprint edition head hi
    item label lem note p persName rdg ref sic term titlePart"/>

    <xsl:template match="expan"/>
    <xsl:template match="teiHeader"/>
    <xsl:template match="sic"/>


    <!-- TEI -->

    <xsl:template match="TEI">
        <xsl:apply-templates/>
    </xsl:template>


    <!-- app -->

    <xsl:template match="app">
        <xsl:variable name="ppWitTmp" select="string-join(rdg[@type = 'pp' or @type = 'ppl']/@wit, '')"/>
        <xsl:variable name="ppWit" select="replace($ppWitTmp, '[^a-z]', '')"/>

        <xsl:variable name="omWitTmp" select="string-join(rdg[@type = 'om']/@wit, '')"/>
        <xsl:variable name="omWit" select="replace($omWitTmp, '[^a-z]', '')"/>

        <!--<xsl:if test="rdg[@type = 'v']">
            <xsl:apply-templates select="lem"/>
            
            <xsl:for-each select="rdg[@type = 'v']">
                <xsl:apply-templates select="." mode="footnote"/>
            </xsl:for-each>
        </xsl:if>
        
        
        <xsl:if test="rdg[@type = 'om']">
            <xsl:choose>
                <xsl:when test="rdg[@type = 'v']">
                </xsl:when>
                
                <xsl:otherwise>
                    <xsl:for-each select="rdg[@type = 'om']">
                        <xsl:text>\margin{}{omOpen}{</xsl:text>
                        <xsl:value-of select="generate-id()"/>
                        <xsl:text>}{\tfx\high{/</xsl:text>
                        <xsl:value-of select="@wit"/>
                        <xsl:text>}}{/</xsl:text>
                        <xsl:value-of select="@wit"/>
                        <xsl:text>}</xsl:text>     
                    </xsl:for-each>
                    
                    <xsl:apply-templates select="lem"/>
                    
                    <xsl:for-each select="rdg[@type = 'om']">
                        <xsl:text>\margin{}{omClose}{</xsl:text>
                        <xsl:value-of select="generate-id()"/>
                        <xsl:text>}{\tfx\high{</xsl:text>
                        <xsl:value-of select="$omWit"/>
                        <xsl:text>\textbackslash}}{</xsl:text>
                        <xsl:value-of select="$omWit"/>
                        <xsl:text>\textbackslash}</xsl:text>     
                    </xsl:for-each>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
        
        <xsl:if test="rdg[@type = 'pp']">
            
        </xsl:if>
        
        <xsl:if test="rdg[@type = 'pt']">
            
        </xsl:if>
        
        <xsl:if test="rdg[@type = 'ppl']">
            <xsl:for-each select="rdg[@type ='ppl']">
                <xsl:value-of select="string('ppl')"/>
            </xsl:for-each>
        </xsl:if>
        
        <xsl:if test="rdg[@type = 'ptl']">
            
        </xsl:if>-->



        <!--<xsl:choose>
            <xsl:when test="rdg[@type = 'missing-structure']"/>

            <xsl:when test="rdg[@type = 'om' or @type = 'pp' or @type = 'ppl']">
                <xsl:if test="not(rdg[@type = 'om'] and substring(lem, 1, 1) = (';', ','))">
                    <xsl:text> </xsl:text>
                </xsl:if>
                
                <xsl:choose>
                    <xsl:when test="count(rdg) = 1 and rdg[@type = 'om']">
                        <xsl:text>\margin{}{omOpen}{</xsl:text>
                        <xsl:value-of select="generate-id()"/>
                        <xsl:text>}{\tfx\high{/</xsl:text>
                        <xsl:value-of select="$omWit"/>
                        <xsl:text>}}{/</xsl:text>
                        <xsl:value-of select="$omWit"/>
                        <xsl:text>}</xsl:text>                       
                    </xsl:when>
                    
                    <xsl:when test="count(rdg) = 1 and rdg[@type = 'pp' or @type = 'ppl']">
                        <xsl:text>{\tfx\high{/</xsl:text>
                        <xsl:value-of select="$ppWit"/>
                        <xsl:text>}}</xsl:text>                        
                    </xsl:when>
                    
                    <xsl:when test="count(rdg) &gt; 1 and rdg[@type = 'v']">
                        <xsl:if test="rdg[@type = 'om']">
                            <xsl:text>\margin{}{omOpen}{</xsl:text>
                            <xsl:value-of select="generate-id()"/>
                            <xsl:text>}{\tfx\high{/</xsl:text>
                            <xsl:value-of select="$omWit"/>
                            <xsl:text>}}{/</xsl:text>
                            <xsl:value-of select="$omWit"/>
                            <xsl:text>}</xsl:text>                             
                        </xsl:if>
                        
                        <xsl:if test="count(rdg) &gt; 1 and rdg[@type = 'pp']">
                            <xsl:text>{\tfx\high{/</xsl:text>
                            <xsl:value-of select="$ppWit"/>
                            <xsl:text>}}</xsl:text>                            
                        </xsl:if>
                    </xsl:when>
                    
                    <xsl:when test="count(rdg) &gt; 1 and rdg[@type = 'typo_corr']">
                        <xsl:if test="rdg[@type = 'om']">
                            <xsl:text>\margin{}{omOpen}{</xsl:text>
                            <xsl:value-of select="generate-id()"/>
                            <xsl:text>}{\tfx\high{/</xsl:text>
                            <xsl:value-of select="$omWit"/>
                            <xsl:text>}}{/</xsl:text>
                            <xsl:value-of select="$omWit"/>
                            <xsl:text>}</xsl:text>                             
                        </xsl:if>
                    </xsl:when>
                </xsl:choose>
        
            <xsl:apply-templates select="lem"/>
        
            <xsl:choose>
                <xsl:when test="count(rdg) = 1 and rdg[@type = 'om']">
                    <xsl:text>\margin{}{omClose}{</xsl:text>
                    <xsl:value-of select="generate-id()"/>
                    <xsl:text>}{\tfx\high{</xsl:text>
                    <xsl:value-of select="$omWit"/>
                    <xsl:text>\textbackslash}}{</xsl:text>
                    <xsl:value-of select="$omWit"/>
                    <xsl:text>\textbackslash}</xsl:text>                     
                </xsl:when>
                
                <xsl:when test="count(rdg) = 1 and rdg[@type = 'pp']">
                    <xsl:text>{\tfx\high{</xsl:text>
                    <xsl:value-of select="$ppWit"/>
                    <xsl:text>\textbackslash}}</xsl:text> 
                    <xsl:text>{\dvl} </xsl:text>
                    <xsl:apply-templates select="rdg[@type = 'pp']" mode="footnote"/>
                </xsl:when>
                
                <xsl:when test="count(rdg) &gt; 1 and rdg[@type = 'v']">-->
        <!-- case: if an app has a rdg[@type = 'om'] and a 
                            rdg[@type = 'v'], the vizualisation should be
                            <sup>/om</sup>lemlemlem<sup>v om\</sup>.
                            ATTENTION: the second part of the conditional test 
                            makes sure that this rule applies if the corresponding lem has only one word in it-->
        <!--<xsl:if test="rdg[@type = 'v'][preceding-sibling::rdg[@type = 'om'] or following-sibling::rdg[@type = 'om']] 
                    and (string-length(normalize-space(lem)) - string-length(translate(normalize-space(lem), ' ', '')) + 1 = 1)">   
                        <xsl:apply-templates select="rdg[@type = 'v']" mode="footnote"/>
                        <xsl:text> </xsl:text>
                    </xsl:if>
                
                    <xsl:if test="rdg[@type = 'om']">
                        <xsl:text>\margin{}{omClose}{</xsl:text>
                        <xsl:value-of select="generate-id()"/>
                        <xsl:text>}{\tfx\high{</xsl:text>
                        <xsl:value-of select="$omWit"/>
                        <xsl:text>\textbackslash}}{</xsl:text>
                        <xsl:value-of select="$omWit"/>
                        <xsl:text>\textbackslash}</xsl:text>                   
                    </xsl:if>
                
                    <xsl:if test="rdg[@type = 'pp']">
                        <xsl:apply-templates select="rdg[@type = 'v']" mode="footnote"/>
                        <xsl:text> </xsl:text>
                    
                        <xsl:text>{\tfx\high{</xsl:text>
                        <xsl:value-of select="$ppWit"/>
                        <xsl:text>\textbackslash}}</xsl:text>                    
                    </xsl:if>
                </xsl:when>
            
                <xsl:when test="count(rdg) &gt; 1 and rdg[@type = 'typo_corr']">
                    <xsl:if test="rdg[@type = 'om']">
                        <xsl:text>\margin{}{omClose}{</xsl:text>
                        <xsl:value-of select="generate-id()"/>
                        <xsl:text>}{\tfx\high{</xsl:text>
                        <xsl:value-of select="$omWit"/>
                        <xsl:text>\textbackslash}}{</xsl:text>
                        <xsl:value-of select="$omWit"/>
                        <xsl:text>\textbackslash}</xsl:text>                     
                    </xsl:if>
                </xsl:when>
            </xsl:choose>
            </xsl:when>
            
            <xsl:when test="count(rdg) = 1 and rdg[@type = 'v']">
                <xsl:apply-templates select="lem"/>

                <xsl:apply-templates select="rdg" mode="footnote"/>
            </xsl:when>
        </xsl:choose>-->

        <!-- NEUER ANSATZ -->

        <xsl:if test="rdg[@type = 'pp' or @type = 'ppl']">
            <xsl:text>{\tfx\high{/</xsl:text>
            <xsl:for-each select="rdg[@type = 'pp' or @type = 'ppl']">
                <xsl:value-of select="replace(@wit, '#', '')"/>
            </xsl:for-each>
            <xsl:text>}}</xsl:text>
        </xsl:if>

        <xsl:if test="rdg[@type = 'om'] and not(lem/note[@type = 'authorial'])">
            <xsl:for-each select="rdg[@type = 'om']">
                <xsl:text>\margin{}{omOpen}{</xsl:text>
                <xsl:value-of select="generate-id()"/>
                <xsl:text>}{\tfx\high{/</xsl:text>
                <xsl:value-of select="replace(@wit, '#', '')"/>
                <xsl:text>}}{/</xsl:text>
                <xsl:value-of select="replace(@wit, '#', '')"/>
                <xsl:text>}</xsl:text>
            </xsl:for-each>
        </xsl:if>

        <xsl:apply-templates select="lem"/>

        <xsl:if test="rdg[@type = 'v']">
            <xsl:for-each select="rdg[@type = 'v']">
                <xsl:apply-templates select="." mode="footnote"/>
            </xsl:for-each>
        </xsl:if>

        <xsl:if test="rdg[@type = 'om'] and not(lem/note[@type = 'authorial'])">
            <xsl:for-each select="rdg[@type = 'om']">
                <xsl:text>\margin{}{omClose}{</xsl:text>
                <xsl:value-of select="generate-id()"/>
                <xsl:text>}{\tfx\high{</xsl:text>
                <xsl:value-of select="replace(@wit, '#', '')"/>
                <xsl:text>\textbackslash}}{</xsl:text>
                <xsl:value-of select="replace(@wit, '#', '')"/>
                <xsl:text>\textbackslash}</xsl:text>
            </xsl:for-each>
        </xsl:if>

        <xsl:if test="rdg[@type = 'pp' or @type = 'ppl']">
            <xsl:text>{\tfx\high{</xsl:text>
            <xsl:for-each select="rdg[@type = 'pp' or @type = 'ppl']">
                <xsl:value-of select="replace(@wit, '#', '')"/>
            </xsl:for-each>
            <xsl:text>\textbackslash}}</xsl:text>
        </xsl:if>

        <xsl:if test="rdg[@type = 'pp' or @type = 'pt']">
            <xsl:text>{\dvl} </xsl:text>
            <xsl:for-each select="rdg[@type = 'pp' or @type = 'pt']">
                <xsl:apply-templates select="." mode="footnote"/>
            </xsl:for-each>
        </xsl:if>

        <xsl:if test="rdg[@type = 'ppl' or @type = 'ptl']">
            <xsl:for-each select="rdg[@type = 'ppl' or @type = 'ptl']">
                <xsl:choose>
                    <xsl:when test="parent::note/*[1] = .">
                        <xsl:text>\blank[-4pt]</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>\blank[4pt]</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>

                <xsl:text>{\switchtobodyfont[8.5pt]</xsl:text>

                <xsl:if test="child::*[1][self::note[@type = 'authorial']]">
                    <xsl:text>\startnarrower[left]</xsl:text>
                </xsl:if>

                <xsl:text>\noindent</xsl:text>

                <!-- SOME PROBLEM HERE WITH MODE PL -->
                <xsl:text>\margin{}{plOpen}{</xsl:text>
                <xsl:value-of select="generate-id()"/>
                <xsl:text>}{\tfx\high{</xsl:text>
                <xsl:value-of select="replace(@wit, '#', '')"/>
                <xsl:text>}}{</xsl:text>
                <xsl:value-of select="replace(@wit, '#', '')"/>
                <xsl:text>}</xsl:text>

                <xsl:apply-templates select="."/>

                <!-- GENERATE-ID() MACHT PROBLEME. WARUM? -->
                <xsl:text>\margin{}{plClose}{</xsl:text>
                <!--<xsl:value-of select="generate-id()"/>-->
                <xsl:text>}{\tfx\high{</xsl:text>
                <xsl:value-of select="replace(@wit, '#', '')"/>
                <xsl:text>}}{</xsl:text>
                <xsl:value-of select="replace(@wit, '#', '')"/>
                <xsl:text>}</xsl:text>


                <xsl:if test="position() != last()">
                    <xsl:text>
                    \par
                    \blank[4pt]
                    \noindent
                    </xsl:text>
                </xsl:if>

                <xsl:if test="child::*[1][self::note[@type = 'authorial']]">
                    <xsl:text>\stopnarrower</xsl:text>
                </xsl:if>

                <xsl:text>
                                }
                                \blank[4pt]
                                \noindent
                </xsl:text>
            </xsl:for-each>
        </xsl:if>




        <!--        <xsl:if test="starts-with(lem, ';')">
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
                <xsl:text>{\switchtobodyfont[8.5pt]</xsl:text>-->
        <!--\startnarrower[left]-->
        <!--<xsl:text>\noindent</xsl:text>
                <xsl:apply-templates select="rdg[@type = 'ptl' or @type = 'ppl']" mode="pl"/>-->
        <!--\stopnarrower-->
        <!-- <xsl:text>
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
                    <xsl:if test="rdg[@type != 'v']">-->
        <!-- <xsl:text>~‖</xsl:text> -->
        <!-- <xsl:text>~\|\kern-.1em\|</xsl:text> -->
        <!--<xsl:text> {\dvl}</xsl:text>
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
        </xsl:choose>-->
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

                <xsl:if test="@unit = 'no-p'">
                    <xsl:text> \nop{}</xsl:text>
                </xsl:if>

                <xsl:if test="@unit = 'no-line'">
                    <xsl:text> \noline{}</xsl:text>
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

                <xsl:if test="@unit = 'no-p'">
                    <xsl:text> \nop{}</xsl:text>
                </xsl:if>

                <xsl:if test="@unit = 'no-line'">
                    <xsl:text> \noline{}</xsl:text>
                </xsl:if>

                <xsl:text>{\tfx\high{</xsl:text>
                <xsl:value-of select="$edt"/>
                <xsl:text>}} </xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


    <xsl:template match="milestone[@unit = 'fn-break']">
        <xsl:variable name="edt" select="replace(replace(@edRef, '#', ''), ' ', '')"/>
        <xsl:variable name="n" select="@n"/>

        <xsl:text>|</xsl:text>
        <xsl:value-of select="concat($edt, $n)"/>
        <xsl:text>|</xsl:text>
    </xsl:template>


    <xsl:template match="div[@type = 'section-group']">
        <xsl:apply-templates/>
    </xsl:template>


    <xsl:template match="div[@type = 'section']">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="divGen[@type = 'Inhalt']">
        <xsl:text>\placecontent 
        \emptyEvenPage </xsl:text>
    </xsl:template>

    <xsl:template match="div[@type = 'index']">
        <xsl:text>
            \emptyEvenPage
            \startpart[title={Register}]

            \startsetups[b]
            \switchtobodyfont[default]
            \rlap{\pagenumber}
            \hfill
            {\tfx\it Register}
            \hfill
            \llap{}
            \stopsetups
        </xsl:text>

        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="divGen[@type = 'bibel']">
        <xsl:text>
            \writetolist[chapter]{}{Bibelstellen}
            \subject[Bibelstellen]{Bibelstellen}
 
                \startsetups[a]
                \switchtobodyfont[default]
                \rlap{}
                \hfill
                {\tfx\it Bibelstellen}
                \hfill
                \llap{\pagenumber}
                \stopsetups
 
                \startcolumns
                \placebibelIndex
                \stopcolumns
        </xsl:text>
    </xsl:template>

    <xsl:template match="divGen[@type = 'persons']">
        <xsl:text>
            \writetolist[chapter]{}{Personen}
            \subject[Personen]{Personen}
 
                \startsetups[a]
                \switchtobodyfont[default]
                \rlap{}
                \hfill
                {\tfx\it Personen}
                \hfill
                \llap{\pagenumber}
                \stopsetups
 
                \startcolumns
                \placepersIndex
                \stopcolumns
        </xsl:text>
    </xsl:template>

    <xsl:template match="divGen[@type = 'classical-authors']">
        <xsl:text>              
            \writetolist[chapter]{}{Antike Autoren}
            \subject[Antike Autoren]{Antike Autoren}
 
                \startsetups[a]
                \switchtobodyfont[default]
                \rlap{}
                \hfill
                {\tfx\it Antike Autoren}
                \hfill
                \llap{\pagenumber}
                \stopsetups
 
                {\startcolumns
                \placeantIndex
                \stopcolumns}
        </xsl:text>
    </xsl:template>

    <xsl:template match="divGen[@type = 'subjects']">
        <xsl:text>
            \writetolist[chapter]{}{Sachen}
            \subject[Sachen]{Sachen}
 
            \startsetups[a]
            \switchtobodyfont[default]
            \rlap{}
            \hfill
            {\tfx\it Sachen}
            \hfill
            \llap{\pagenumber}
            \stopsetups

            {\startcolumns
            \placesachIndex
            \stopcolumns}
        </xsl:text>
    </xsl:template>


    <xsl:template match="head[ancestor::group]">
        <!--<xsl:text>\startsubject[title={</xsl:text>
        <xsl:call-template name="pbHead"/>
        <xsl:value-of select="."/>
        <xsl:text>}]</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>\stopsubject </xsl:text> -->

        <xsl:text>\subject[</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>]{</xsl:text>

        <xsl:choose>
            <xsl:when test="ancestor::rdg">
                <xsl:text>{\switchtobodyfont[8pt]</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>{\switchtobodyfont[9pt]</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:apply-templates/>
        <xsl:text>}}</xsl:text>

        <xsl:if test="descendant::seg[@type = 'toc-item']">
            <xsl:apply-templates select="descendant::seg[@type = 'toc-item']"/>
        </xsl:if>
    </xsl:template>


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
                <xsl:text>\crlf </xsl:text>
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
                <xsl:text>\startalignment[center]</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>\stopalignment </xsl:text>
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
        <!--<xsl:value-of select="persName"/>-->
        <xsl:value-of select="persName"/>

        <!-- Achtung: auch Fälle mit zwei term-Elementen!! -->
        <!-- OS: Wir haben bislang nur wenige Fälle der Indexierung mit zwei <terms>. 
            Hier sollte sich die Seitenanzeige im Print nur bei dem zweiten Term ausgegeben werden.-->

        <xsl:if test="title">
            <xsl:text>+</xsl:text>
        </xsl:if>

        <xsl:apply-templates select="title"/>
        <xsl:text> </xsl:text>
        <xsl:apply-templates select="measure"/>
        <xsl:text>}</xsl:text>
    </xsl:template>

    <xsl:template match="bibl[@type = 'biblical-reference']">
        <xsl:choose>
            <xsl:when test="contains(citedRange/@to, 'f')">
                <xsl:text>\bibelIndex{</xsl:text>
                <xsl:value-of select="substring-before(citedRange/@from, ':')"/>
                <xsl:text>+</xsl:text>
                <xsl:value-of select="replace(substring-after(citedRange/@from, ':'), ':', ',')"/>
                <xsl:value-of select="citedRange/@to"/>
                <xsl:text>}</xsl:text>
                <xsl:apply-templates select="citedRange"/>
            </xsl:when>
            
            <xsl:when test="citedRange/@to">
                <xsl:text>\bibelIndex{</xsl:text>
                <xsl:value-of select="substring-before(citedRange/@from, ':')"/>
                <xsl:text>+</xsl:text>
                <xsl:value-of select="replace(substring-after(citedRange/@from, ':'), ':', ',')"/>
                <xsl:text>\endash</xsl:text>
                
                <xsl:variable name="to-tmp" select="citedRange/@to"/>
                
                <xsl:choose>
                    <xsl:when test="contains(citedRange/@from, concat(substring-before($to-tmp, ':'), ':', substring-before(substring-after($to-tmp, ':'), ':')))">
                        <xsl:value-of select="replace(substring-after($to-tmp, ':'), ':', ',')"/>
                    </xsl:when>
                    <xsl:when test="contains(citedRange/@from, substring-before($to-tmp, ':'))">
                        <xsl:value-of select="substring-after(substring-after($to-tmp, ':'), ':')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="replace(substring-after($to-tmp, ':'), ':', ',')"/>
                    </xsl:otherwise>
                </xsl:choose>
                
                <xsl:text>}</xsl:text>
                <xsl:apply-templates select="citedRange"/>                
            </xsl:when>
            
            <xsl:when test="contains(citedRange/@n, ' ')">
                <xsl:variable name="bib-refs" select="tokenize(citedRange/@n, ' ')"/>
                <xsl:for-each select="$bib-refs">
                    <xsl:text>\bibelIndex{</xsl:text>
                    <xsl:value-of select="substring-before(., ':')"/>
                    <xsl:text>+</xsl:text>
                    <xsl:value-of select="replace(substring-after(., ':'), ':', ',')"/>
                    <xsl:text>}</xsl:text>
                </xsl:for-each>
                <xsl:apply-templates select="citedRange"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>\bibelIndex{</xsl:text>
                <xsl:value-of select="substring-before(citedRange/@n, ':')"/>
                <xsl:text>+</xsl:text>
                <xsl:value-of select="replace(substring-after(citedRange/@n, ':'), ':', ',')"/>
                <xsl:text>}</xsl:text>
                <xsl:apply-templates select="citedRange"/>
            </xsl:otherwise>
        </xsl:choose>
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
            <!--<xsl:when test="preceding-sibling::*[1][self::note] or preceding-sibling::*[1][self::app/rdg[@type = 'ppl' or 'ptl']] or preceding-sibling::*[1][self::p]">-->
            <xsl:when test="preceding-sibling::*[1][self::note] or preceding-sibling::*[1][self::app/rdg[@type = 'ppl' or 'ptl']]">
                <!--<xsl:text>\blank[-10pt]</xsl:text>-->
                <xsl:text>\blank[-5pt]</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>\blank[5pt]</xsl:text>
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
            \blank[2pt]
            \noindent
        </xsl:text>
    </xsl:template>

    <xsl:template match="app[not(@type = 'structural-variance')]/lem/note[@type = 'authorial']">
        <xsl:variable name="omWitTmp" select="string-join(../../rdg[@type = 'om']/@wit, '')"/>
        <xsl:variable name="omWit" select="replace($omWitTmp, '[^a-z]', '')"/>
        <xsl:text>
            \blank[4pt]
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
            \blank[4pt]
            \noindent
        </xsl:text>
    </xsl:template>

    <!--<xsl:template match="rdg/note[@type = 'authorial']">
        <xsl:call-template name="pbBefore"/>
        <xsl:apply-templates/>
    </xsl:template>-->

    <xsl:template match="note[@type = 'editorial' and @place = 'bottom']">
        <xsl:text>\editor{</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>}</xsl:text>
    </xsl:template>

    <xsl:template match="note[@type = 'editorial' and @place = 'end']"/>

    <xsl:template match="seg">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="seg[@type = 'item']">
        <!-- usage of \sym instead of \item is necessary to get a list without bullets etc. -->
        <xsl:text>\sym{}</xsl:text>
        <xsl:apply-templates/>
    </xsl:template>


    <xsl:template match="p">
        <xsl:call-template name="pbBefore"/>
        <xsl:apply-templates/>
        <xsl:if test="not(parent::rdg[@type = 'ppl' or @type = 'ptl']) and (following-sibling::* or preceding-sibling::*)">
            <xsl:text>\par </xsl:text>
        </xsl:if>
    </xsl:template>


    <xsl:template match="p[@rend = 'margin-vertical']">
        <xsl:text>\crlf \crlf</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>\par </xsl:text>
    </xsl:template>


    <xsl:template match="pb">
        <xsl:text>\margin{}{pb}{}{\vl}{</xsl:text>
        <xsl:value-of select="replace(@edRef, '[# ]+', '')"/>

        <xsl:if test="@type = 'sp'">
            <xsl:text>[</xsl:text>
        </xsl:if>

        <xsl:value-of select="@n"/>

        <xsl:if test="@type = 'sp'">
            <xsl:text>]</xsl:text>
        </xsl:if>

        <xsl:text>}</xsl:text>
        <!--<xsl:if test="(following::node())[1][self::index]">
            <xsl:text> </xsl:text>
        </xsl:if>-->
    </xsl:template>


    <xsl:template match="rdg[@type = 'typo_corr']"/>


    <xsl:template name="pbBefore">
        <xsl:variable name="pb" select="preceding-sibling::*[1][self::pb]"/>
        <xsl:if test="$pb">
            <xsl:text>\margin{}{pb}{}{\vl}{</xsl:text>
            <xsl:value-of select="replace($pb/@edRef, '[# ]+', '')"/>
            <xsl:value-of select="$pb/@n"/>
            <xsl:text>}</xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template name="pbHead">
        <xsl:variable name="pb" select="preceding-sibling::*[1][self::pb]"/>
        <xsl:if test="$pb">
            <xsl:text>\vl\margindata[inouter]{</xsl:text>
            <xsl:value-of select="replace($pb/@edRef, '[# ]+', '')"/>
            <xsl:value-of select="$pb/@n"/>
            <xsl:text>}</xsl:text>
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
            <!--<xsl:variable name="wit" select="replace(@wit, '[# ]+', '')"/>

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
            </xsl:if>-->
        </xsl:if>
        <xsl:value-of select="string('ppl/ptl')"/>
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

        <xsl:if test="descendant::orig">
            <xsl:apply-templates select="orig"/>
        </xsl:if>

        <xsl:if test="(following::node())[1][self::app or self::persName or self::choice]">
            <xsl:text> </xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template match="list[not(ancestor::div[@type = 'contents'])]">
        <xsl:text>
           \setupindenting[yes,medium]
	       \setupitemgroup[itemize][indenting={40pt,next}]
	       \startitemize[packed, joinedup, nowhite, inmargin]
	    </xsl:text>
        <xsl:apply-templates/>
        <xsl:text>\stopitemize </xsl:text>
    </xsl:template>

    <xsl:template match="list[ancestor::div[@type = 'contents']]">
        <xsl:text>
           \setupindenting[yes,medium]
	       \setupitemgroup[itemize][indenting={40pt,next}]
	       \startitemize[packed, paragraph, joinedup]
	    </xsl:text>
        <xsl:apply-templates/>
        <xsl:text>\stopitemize </xsl:text>
    </xsl:template>

    <xsl:template match="item">
        <!-- usage of \sym instead of \item is necessary to get a list without bullets etc. -->
        <xsl:text>\sym{}</xsl:text>
        <xsl:apply-templates/>
    </xsl:template>


    <xsl:template match="titlePage">
        <xsl:text>{\startalignment[center]</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>\stopalignment}</xsl:text>
    </xsl:template>

    <xsl:template match="lem[child::*[1][self::titlePage]]">
        <xsl:apply-templates/>
        <!--<xsl:text>\blank[10pt]</xsl:text>-->
    </xsl:template>

    <!-- regel greift nicht. genauer formulieren und siglen nicht vergessen! -->
    <!--<xsl:template match="rdg[child::*[1][self::titlePage]]">
        <xsl:apply-templates/>
        <xsl:text>\blank[10pt]</xsl:text>
    </xsl:template>-->


    <xsl:template match="titlePart[@type = 'main']">
        <xsl:apply-templates/>

        <xsl:if test="descendant::seg[@type = 'toc-item']">
            <xsl:apply-templates select="descendant::seg[@type = 'toc-item']"/>
        </xsl:if>
    </xsl:template>


    <xsl:template match="titlePart[@type = 'volume']">
        <xsl:apply-templates/>
    </xsl:template>


    <xsl:template match="choice[parent::titlePart]">
        <xsl:apply-templates select="descendant::orig[1]/node()[self::text() or self::*]"/>
    </xsl:template>


    <xsl:template match="byline">
        <xsl:apply-templates/>
    </xsl:template>


    <xsl:template match="docImprint">
        <xsl:apply-templates/>
    </xsl:template>


    <xsl:template match="docDate">
        <xsl:apply-templates/>
    </xsl:template>


    <xsl:template match="div[@type = 'preface']">
        <xsl:apply-templates/>
    </xsl:template>


    <xsl:template match="div[@type = 'contents']">
        <xsl:if test="not(ancestor::group)"> </xsl:if>
        <xsl:apply-templates/>
    </xsl:template>


    <xsl:template match="p[@rend = 'center-aligned']">
        <xsl:apply-templates/>
    </xsl:template>


    <xsl:template match="text">
        <xsl:apply-templates/>
    </xsl:template>


    <xsl:template match="front">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="seg[@type = 'toc-item']">
        <xsl:choose>
            <xsl:when test="ancestor::titlePart[@type = 'volume']">
                <xsl:text>\writetolist[chapter]{}{</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>}</xsl:text>
            </xsl:when>

            <xsl:when test="ancestor::titlePart[@type = 'main']">
                <xsl:text>\writetolist[part]{}{</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>}</xsl:text>
            </xsl:when>

            <xsl:when test="ancestor::div[@type = 'chapter']">
                <xsl:text>\writetolist[subsection]{}{</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>}</xsl:text>
            </xsl:when>

            <xsl:when test="ancestor::div[@type = 'part' or @type = 'introduction']">
                <xsl:text>\writetolist[section]{}{</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>}</xsl:text>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="back">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="div[@type = 'editorialNotes']">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="divGen[@type = 'editorialNotes']">
        <xsl:text>
            \emptyEvenPage
            \writebetweenlist[part]{\blank[20pt]}
            \writetolist[part]{}{Erläuterungen}
            \subject[Erläuterungen]{Erläuterungen}
    
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

    <xsl:template match="div[@type = 'editors']">
        <xsl:text>\emptyEvenPage </xsl:text>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="space">
        <xsl:choose>
            <xsl:when test="@quantity = '3'">
                <xsl:text>\hspace[threeem] </xsl:text>
            </xsl:when>
        </xsl:choose>
    </xsl:template>


    <xsl:template match="group">
        <xsl:text>\emptyEvenPage </xsl:text>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="supplied">
        <!-- TO BE DONE -->
        <!--<xsl:text>\[</xsl:text>-->
        <xsl:apply-templates/>
        <!--<xsl:text>\]</xsl:text>-->
    </xsl:template>

</xsl:stylesheet>
