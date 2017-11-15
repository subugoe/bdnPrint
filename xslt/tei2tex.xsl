<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns:math="http://exslt.org/math" version="2.0">
    
    <xsl:output method="text"/>
    
    <xsl:strip-space elements="*"/>
    <xsl:preserve-space elements="abbr byline corr docImprint edition head hi
        item label lem note p persName rdg ref sic term titlePart"/>
    
    <xsl:template match="TEI"><!-- ok -->
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <xsl:template match="teiHeader"/><!-- ok -->
    
    
    <xsl:template match="body"><!-- ok -->
        <xsl:if test="ancestor::group">
            <xsl:call-template name="new-page"/>
        </xsl:if>
        <xsl:apply-templates/>
    </xsl:template>
 
 
    <!-- when edition text starts, page numbering in Arabic letters 
        starts with 1 -->
    <xsl:template match="group"><!-- ok -->
        <xsl:text>\noheaderandfooterlines </xsl:text>          
        <xsl:text>\startbodymatter </xsl:text>
        <xsl:text>\setuppagenumber[number=1]</xsl:text>
        <xsl:text>\marking[evHeader]{{\tfx\it </xsl:text>
        <xsl:apply-templates select="//teiHeader//title[@level = 'a']/title[@type = 'condensed']"/>
        <xsl:text>}}</xsl:text>
  
        <xsl:apply-templates/>
        <xsl:text>\stopbodymatter </xsl:text>
    </xsl:template>
    
    
    <!-- within critical text -->
    <xsl:template match="front[ancestor::group]"><!-- ok -->
        <xsl:apply-templates/>
        <xsl:if test="ancestor::group/descendant::front[1] = .">
            <xsl:text>\resetnumber[page]</xsl:text>
            <xsl:text>\setuppagenumber[number=1]</xsl:text>
        </xsl:if>
    </xsl:template>
    
    
    <!-- within modern editorial text -->
    <xsl:template match="front[not(ancestor::group)]"><!-- ok -->        
        <xsl:text>\startfrontmatter </xsl:text>
        <xsl:apply-templates/>
        <xsl:text>\stopfrontmatter </xsl:text>
    </xsl:template>
    
    
    <xsl:template match="text"><!-- ok -->
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <!-- outside edition text -->
    <xsl:template match="div[@type = 'preface' and not(parent::front)]"><!-- ok -->
        <xsl:text>\page[yes,left,empty]</xsl:text>
        <xsl:text>\noheaderandfooterlines </xsl:text>
        
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <!-- inside edition text -->
    <xsl:template match="div[@type = 'preface' and parent::front]"><!-- ok -->
        <xsl:text>\setuppagenumber[number=5]</xsl:text>       
        <xsl:call-template name="make-both-columns">
            <xsl:with-param name="contents" select="head"/>
        </xsl:call-template>       
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <xsl:template match="titlePage"><!-- ok -->
        <xsl:text>\marking[oddHeader]{Vorreden}</xsl:text>
        <xsl:if test="ancestor::lem">
            <xsl:text>\writetolist[part]{}{Vorreden}</xsl:text>
        </xsl:if>
        
        <xsl:text>{\startalignment[center]</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>\stopalignment}</xsl:text>
    </xsl:template>
    
    
    <xsl:template match="titlePart"><!-- ok -->
        <xsl:apply-templates/>
        
        <xsl:if test="descendant::seg[@type = 'toc-item']">
            <xsl:apply-templates select="descendant::seg[@type = 'toc-item']"/>
        </xsl:if>
        
        <xsl:if test="descendant::seg[@type = 'condensed']">
            <xsl:apply-templates select="descendant::seg[@type = 'condensed']"/>
        </xsl:if>
    </xsl:template>
    
    
    <xsl:template match="closer"><!-- ok -->
        <xsl:text>\blank </xsl:text>
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <xsl:template match="div[@type = 'corrigenda']"><!-- ok -->
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <xsl:template match="div[@type = 'editorialNotes']"><!-- ok -->
        <xsl:call-template name="make-both-columns">
            <xsl:with-param name="contents" select="head[1]"/>
        </xsl:call-template>
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-- within critical text -->   
    <xsl:template match="div[@type = 'contents' and not(@subtype = 'print')]"><!-- ok -->     
        <xsl:text>\marking[oddHeader]{Inhalt}</xsl:text>
        <xsl:text>\page[right]</xsl:text>
        <xsl:text>\noheaderandfooterlines </xsl:text>
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <!-- within modern editorial text -->
    <xsl:template match="div[@type = 'contents' and @subtype = 'print']"><!-- ok -->
        <xsl:apply-templates select="descendant::divGen[@type = 'Inhalt']"/>
    </xsl:template>
    
    
    <xsl:template match="div[@type = 'pseudo-container']"><!-- ok -->
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <xsl:template match="div[@type = 'part']"><!-- ok -->
        <xsl:if test="not(preceding::div[1][@type = 'titlePage'])">
            <xsl:call-template name="new-page"/>
        </xsl:if>    

        <xsl:apply-templates/>  
    </xsl:template>
    
    
    <xsl:template match="div[@type = 'chapter']"><!-- ok -->
        <xsl:call-template name="new-page"/>
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <!-- within critical text -->
    <xsl:template match="div[@type = 'introduction' and ancestor::group]"><!-- ok -->
        <xsl:if test="not(preceding-sibling::*[1][descendant::div[@type = 'titlePage']])">
            <xsl:text>\page[right,empty]</xsl:text>
        </xsl:if>
        <xsl:text>\noheaderandfooterlines </xsl:text>
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <!-- within modern editorial text -->
    <xsl:template match="div[@type = 'introduction' and not(ancestor::group)]"><!-- ok -->
        <xsl:text>\resetcounter[footnote]</xsl:text>
        <xsl:call-template name="make-both-columns">
            <xsl:with-param name="contents" select="head[1]"/>
        </xsl:call-template>        
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <xsl:template match="div[@type = 'section-group']"><!-- ok -->
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <xsl:template match="div[@type = 'section']"><!-- ok -->
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <xsl:template match="div[@type = 'editorial']"><!-- ok -->
        <xsl:text>\resetcounter[footnote]</xsl:text>
        <xsl:call-template name="make-both-columns">
            <xsl:with-param name="contents" select="head[1]"/>
        </xsl:call-template>        
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <!-- is this still needed? -->
    <xsl:template match="div[@type = 'editors']"><!-- ok -->
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <xsl:template match="docDate"><!-- ok -->
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <xsl:template match="docImprint"><!-- ok -->
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <xsl:template match="docTitle"><!-- ok -->
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <xsl:template match="byline"><!-- ok -->
        <xsl:apply-templates/>
    </xsl:template>
 
 
    <xsl:template match="head[not(ancestor::group)]">
        <xsl:if test="descendant::seg[@type = 'toc-item']">
            <xsl:apply-templates select="descendant::seg[@type = 'toc-item']"/>
        </xsl:if>
        <xsl:if test="descendant::seg[@type = 'condensed']">
            <xsl:apply-templates select="descendant::seg[@type = 'condensed']"/>
        </xsl:if>
        
        <xsl:text>\title[]{</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>}</xsl:text>        
    </xsl:template>

    <xsl:template match="head[ancestor::group and (@type = 'main' or not(@type) and not(ancestor::list))]">
        <xsl:if test="descendant::seg[@type = 'toc-item']">
            <xsl:apply-templates select="descendant::seg[@type = 'toc-item']"/>
        </xsl:if>
        <xsl:if test="descendant::seg[@type = 'condensed']">
            <xsl:apply-templates select="descendant::seg[@type = 'condensed']"/>
        </xsl:if>
        
        <xsl:text>\subject[]{</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>}</xsl:text> 
    </xsl:template> 
    
    
    <xsl:template match="head[@type = 'sub']">
        <xsl:choose>
            <xsl:when test="ancestor::group">
                <xsl:text>\subject[]{</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>}</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>\notTOCsection[]{</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>}</xsl:text>
            </xsl:otherwise>
        </xsl:choose>       
    </xsl:template>

 
    <xsl:template match="head[ancestor::list]">
        <xsl:choose>
            <xsl:when test="ancestor::rdg and (@type = 'main' or not(@type))">
                <xsl:text>\listmainheadrdg[]{</xsl:text>
            </xsl:when>
            <xsl:when test="ancestor::rdg and @type = 'sub'">
                <xsl:text>\listsubheadrdg[]{</xsl:text>
            </xsl:when>
            <xsl:when test="ancestor::lem and (@type = 'main' or not(@type))">
                <xsl:text>\listmainhead[]{</xsl:text>
            </xsl:when>
            <xsl:when test="ancestor::lem and (@type = 'sub')">
                <xsl:text>\listsubhead[]{</xsl:text>
            </xsl:when>
        </xsl:choose>

        <xsl:apply-templates/>
        <xsl:text>}</xsl:text>
    </xsl:template>


    <xsl:template match="p">
        <xsl:apply-templates/>
    </xsl:template>


    <xsl:template match="hi"><!--ok -->
        <xsl:choose>
            <xsl:when test="not(@rend)">
                <xsl:text>\italic{</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>}</xsl:text>
            </xsl:when>
            
            <xsl:when test="@rend = 'bold'">
                <xsl:text>\bold{</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>}</xsl:text>
            </xsl:when>
            
            <xsl:when test="@rend = 'right-aligned'">
                <xsl:choose>
                    <xsl:when test="ancestor::rdg[@type = 'pp' or @type = 'pt']">
                        <xsl:apply-templates/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>\crlf </xsl:text>
                        <xsl:text>\rightaligned{</xsl:text>
                        <xsl:apply-templates/>
                        <xsl:text>}</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            
            <xsl:when test="@rend = 'center-aligned'">
                <xsl:choose>
                    <xsl:when test="child::lb">
                        <xsl:text>\startalignment[center]</xsl:text>
                        <xsl:apply-templates/>
                        <xsl:text>\stopalignment</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>\midaligned{</xsl:text>
                        <xsl:apply-templates/>
                        <xsl:text>}</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
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
            
            <xsl:when test="@rend = 'overline'">
                <xsl:text>\overbar{</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>}</xsl:text>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
 
 
    <xsl:template match="choice"><!-- ok -->
        <xsl:apply-templates select="child::*[not(self::seg or self::sic or self::expan)]"/>
    </xsl:template>
 
 
    <xsl:template match="abbr"><!-- ok -->
        <xsl:apply-templates/>
    </xsl:template>
 
 
    <xsl:template match="expan"/><!-- ok -->
 
 
    <xsl:template match="sic"><!-- ok -->
        <xsl:apply-templates/>
    </xsl:template>
 
 
    <xsl:template match="orig"><!-- ok -->
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <xsl:template match="app"><!-- ok -->
        <xsl:if test="not(lem[@type = 'missing-structure'])">
            <xsl:apply-templates/>
        </xsl:if>
    </xsl:template>
    
    
    <xsl:template match="rdg[@type = 'ppl' or @type = 'ptl']">
       <xsl:if test="parent::app/child::rdg[@type = 'ppl' or @type = 'ptl'][1] = .">
            <xsl:text>\crlf </xsl:text>
        </xsl:if> 
        <xsl:text>{</xsl:text>
        <xsl:choose>
            <xsl:when test="child::*[1][self::note[@type = 'authorial']]">
                <xsl:text>\startnarrow</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:if test="not(child::*[1][self::titlePage])">
                    <xsl:text>{\startrdg</xsl:text>
                </xsl:if>
                <xsl:if test="child::*[1][self::p]">
                    <xsl:call-template name="paragraph-indent"/>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text>\switchtobodyfont[8.5pt]</xsl:text> 
        <xsl:apply-templates/>
        <xsl:if test="position() != last()">
            <xsl:text>\par </xsl:text>
            <xsl:text>\blank[2pt]  </xsl:text>
        </xsl:if>
        
        <xsl:choose>
            <xsl:when test="child::*[1][self::note[@type = 'authorial']]">
                <xsl:text>\stopnarrow</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:if test="not(child::*[1][self::titlePage])">
                    <xsl:text>\stoprdg}</xsl:text>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text>}</xsl:text>
        <xsl:text>\noindentation </xsl:text>
    </xsl:template>
    
    
    <xsl:template match="rdg[@type = 'pp' or @type = 'pt']"><!-- ok -->
        <xsl:if test="not(preceding-sibling::rdg[@type = 'pp' or @type = 'pt'])">
            <xsl:text>{\dvl}</xsl:text>
        </xsl:if>
        <xsl:apply-templates select="." mode="footnote"/>
    </xsl:template>
    
    
    <xsl:template match="rdg[@type = 'v']"><!-- ok -->
        <xsl:apply-templates select="." mode="footnote"/>
    </xsl:template>
    
    
    <xsl:template match="rdg" mode="footnote"><!-- ok -->
        <xsl:variable name="wit" select="replace(@wit, '[# ]+', '')"/>
        
        <xsl:text>\</xsl:text>
        <xsl:value-of select="$wit"/>
        <xsl:text>Note{</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>}</xsl:text>       
    </xsl:template>
 
 
    <xsl:template match="rdg[@type = 'om' or @type = 'typo_corr' or @type = 'var-structure']"/><!-- ok -->
    
    
    <xsl:template match="rdgMarker">
        <xsl:variable name="wit" select="replace(@wit, ' ', '')"/>
        
        <xsl:choose>
            <xsl:when test="(@type = 'ppl' or @type = 'pp') and @context = 'lem'">
                <xsl:if test="@mark = 'open'">
                    <xsl:text>{\tfx\high{/</xsl:text>
                    <xsl:value-of select="$wit"/>                   
                    <xsl:text>}}</xsl:text>
                </xsl:if>
                <xsl:if test="@mark = 'close'">
                    <xsl:text>{\tfx\high{</xsl:text>
                    <xsl:value-of select="$wit"/>                   
                    <xsl:text>\textbackslash}}</xsl:text>                   
                </xsl:if>
            </xsl:when>
            <xsl:when test="@type = 'ptl' or (@type = 'ppl' and @context = 'rdg')">
                <xsl:if test="@mark = 'open'">
                    <xsl:text>\margin{}{plOpen}{</xsl:text>
                    <xsl:text>}{\tfx\high{</xsl:text>
                    <xsl:value-of select="$wit"/>
                    <xsl:text>}}{</xsl:text>
                    <xsl:value-of select="$wit"/>
                    <xsl:text>}</xsl:text>                   
                </xsl:if>
                <xsl:if test="@mark = 'close'">
                    <xsl:text>\margin{}{plClose}{</xsl:text>
                    <xsl:text>}{\tfx\high{</xsl:text>
                    <xsl:value-of select="$wit"/>
                    <xsl:text>}}{</xsl:text>
                    <xsl:value-of select="$wit"/>
                    <xsl:text>} </xsl:text>                     
                </xsl:if>                
            </xsl:when>
            <xsl:when test="@type = 'om'">
                <xsl:if test="@mark = 'open'">
                    <xsl:text>\margin{}{omOpen}{</xsl:text>
                    <xsl:text>}{\tfx\high{/</xsl:text>
                    <xsl:value-of select="$wit"/>
                    <xsl:text>}}{/</xsl:text>
                    <xsl:value-of select="$wit"/>
                    <xsl:text>}</xsl:text>                   
                </xsl:if>
                <xsl:if test="@mark = 'close'">
                    <xsl:text>\margin{}{omClose}{</xsl:text>
                    <xsl:text>}{\tfx\high{</xsl:text>
                    <xsl:value-of select="$wit"/>
                    <xsl:text>\textbackslash}}{</xsl:text>
                    <xsl:value-of select="$wit"/>
                    <xsl:text>\textbackslash} </xsl:text>   
                </xsl:if>                
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    
    <xsl:template match="lem"><!-- ok -->
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <xsl:template match="foreign[@xml:lang = 'gr']"><!-- ok -->
        <xsl:apply-templates/>
    </xsl:template>


    <xsl:template match="foreign[@xml:lang = 'he']"><!-- ok -->
        <xsl:text>{\switchtobodyfont[7pt] </xsl:text>
        <xsl:text>\ezraFont </xsl:text>
        <xsl:apply-templates/>
        <xsl:text>}</xsl:text>
    </xsl:template>


    <xsl:template match="pb"><!-- ok -->
        <xsl:choose>
            <xsl:when test="parent::rdg[@type = 'v' or @type = 'pp' or @type = 'pt']">
                <xsl:text>{\vl}</xsl:text>
                <xsl:call-template name="make-pb-content">
                    <xsl:with-param name="pb" select="."/>
                </xsl:call-template>
                <xsl:text>{\vl}</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>\margin{}{pb}{}{</xsl:text>
                <xsl:choose>
                    <!-- single vl when several pb occur on the same spot -->
                    <xsl:when test="preceding-sibling::node()[1][self::pb] 
                        or not(preceding-sibling::node()[1][matches(., '\w')]) 
                        and preceding-sibling::node()[2][self::pb]">
                        <xsl:text>\hbox{}</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>\vl</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>               
                <xsl:text>}{</xsl:text>
                <xsl:call-template name="make-pb-content">
                    <xsl:with-param name="pb" select="."/>
                </xsl:call-template>               
                <xsl:text>}</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
 
 
    <!-- within critical text -->
    <xsl:template match="note[@type = 'authorial' and ancestor::group]">
        <xsl:apply-templates/>
    </xsl:template>
 
 
    <!-- within modern editorial text -->
    <xsl:template match="note[@type = 'authorial' and not(ancestor::group)]">
        <xsl:apply-templates/>
    </xsl:template>
 
 
    <!-- editorial comments -->
    <xsl:template match="note[@type = 'editorial']">
        <xsl:text>\editor{</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>}</xsl:text>
    </xsl:template>
 
 
    <xsl:template match="index[@indexName = 'classical-authors']">
        <xsl:text>\classical-authorsIndex{</xsl:text>
        <xsl:value-of select="persName"/>
        
        <!-- Achtung: auch Fälle mit zwei term-Elementen!! -->
        <!-- OS: Wir haben bislang nur wenige Fälle der Indexierung mit zwei <terms>. 
            Hier sollte sich die Seitenanzeige im Print nur bei dem zweiten Term ausgegeben werden.-->
        
        <xsl:if test="term/title">
            <xsl:text>+</xsl:text>
        </xsl:if>
        
        <xsl:apply-templates select="term/title"/>
        <xsl:text> </xsl:text>
        <xsl:apply-templates select="term/measure"/>
        <xsl:text>}</xsl:text>
    </xsl:template>
 
 
    <xsl:template match="bibl[@type = 'biblical-reference']"><!-- ok -->        
        <xsl:choose>
            <xsl:when test="citedRange/@from">
                <xsl:variable name="from" select="tokenize(citedRange/@from, ':')"/>
                <xsl:variable name="from-bibl-book" select="$from[1]"/>
                <xsl:variable name="from-chapter" select="$from[2]"/>
                <xsl:variable name="from-verse" select="$from[3]"/>
                <xsl:variable name="from-passage" select="concat($from-chapter,',', $from-verse)"/>
                <xsl:variable name="to" select="tokenize(citedRange/@to, ':')"/>
                <xsl:variable name="to-bibl-book" select="$to[1]"/>
                <xsl:variable name="to-chapter" select="$to[2]"/>
                <xsl:variable name="to-verse" select="$to[3]"/>
                <xsl:variable name="to-passage" select="concat($to-chapter,',', $to-verse)"/>
                
                <xsl:text>\bibelIndex{</xsl:text>
                <xsl:value-of select="$from-bibl-book"/>
                <xsl:text>+</xsl:text>  
                <xsl:value-of select="$from-passage"/>
                <xsl:choose>
                    <xsl:when test="matches($to-bibl-book, 'f')">
                        <xsl:value-of select="$to-bibl-book"/>
                    </xsl:when>
                    <xsl:when test="$from-bibl-book = $to-bibl-book 
                        and $from-chapter = $to-chapter">
                        <xsl:text>\endash</xsl:text>
                        <xsl:value-of select="$to-verse"/>                      
                    </xsl:when>
                    <xsl:when test="$from-bibl-book = $to-bibl-book">
                        <xsl:text>\endash</xsl:text>
                        <xsl:value-of select="$to-passage"/>
                    </xsl:when>
                    <!-- does the otherwise case ever occur? -->
                    <xsl:otherwise/>
                </xsl:choose>
                <xsl:text>}</xsl:text>
            </xsl:when>
            <xsl:when test="citedRange/@n">
                <xsl:variable name="reference" select="tokenize(citedRange/@n, ' ')"/>
                <xsl:for-each select="$reference">
                    <xsl:variable name="n" select="tokenize(., ':')"/>
                    <xsl:variable name="bibl-book" select="$n[1]"/>
                    <xsl:variable name="chapter" select="$n[2]"/>
                    <xsl:variable name="verse" select="$n[3]"/> 
                    <xsl:variable name="passage" select="concat($chapter,',', $verse)"/>
                    
                    <xsl:text>\bibelIndex{</xsl:text>
                    <xsl:value-of select="$bibl-book"/>
                    <xsl:text>+</xsl:text>
                    <xsl:choose>
                        <xsl:when test="not($verse)">
                            <xsl:value-of select="$chapter"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$passage"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:text>}</xsl:text>                   
                </xsl:for-each>
            </xsl:when>
        </xsl:choose>       
        <xsl:apply-templates/>
    </xsl:template>
 
 
    <xsl:template match="index[@indexName = 'persons']">
        <xsl:choose>
            <xsl:when test="count(term) gt 1">
                <xsl:text>\seepersonsIndex{</xsl:text>
                <xsl:value-of select="substring-before(child::term[1], ',')"/>
                <xsl:text>}{</xsl:text>
                <xsl:value-of select="substring-after(child::term[1], 's. ')"/>
                <xsl:text>}</xsl:text>  
                <xsl:text>\personsIndex{</xsl:text>
                <xsl:value-of select="child::term[2]"/>
                <xsl:text>}</xsl:text>                
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>\personsIndex{</xsl:text>
                <xsl:value-of select="child::term"/>
                <xsl:text>}</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
 
 
    <xsl:template match="index[@indexName = 'subjects']"><!-- ok -->
        <xsl:text>\subjectsIndex{</xsl:text>
        <xsl:value-of select="term"/>
        <xsl:text>}</xsl:text>
    </xsl:template>
 
 
    <xsl:template match="term"/><!-- ok -->
 
 
    <xsl:template match="list">
        <xsl:text>\crlf </xsl:text>
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <xsl:template match="list[ancestor::div[@type = 'contents']]">
        <xsl:text>\setupindenting[yes,medium]</xsl:text>
        <xsl:text>\setupitemgroup[itemize][indenting={40pt,next}]</xsl:text>
        <xsl:text>\startitemize[packed, paragraph, joinedup</xsl:text>
        
        <!-- in a TOC the first level shouldn't be indented --> 
        <!--<xsl:if test="ancestor::div[@type = 'contents']/descendant::list[1] = .">
            <xsl:text>, inmargin</xsl:text>
        </xsl:if>       --> 
        <xsl:text>]</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>\stopitemize </xsl:text>       
    </xsl:template>


    <xsl:template match="list[ancestor::div[@type = 'editorial']]"><!-- ok -->
        <xsl:text>\starttwocolumns </xsl:text>
        <xsl:apply-templates/>
        <xsl:text>\stoptwocolumns </xsl:text>    
        <xsl:text>\noindentation </xsl:text> 
    </xsl:template>
 
 
    <xsl:template match="item"><!-- ok -->
        <xsl:choose>
            <xsl:when test="preceding-sibling::*[1][self::label]">
                <xsl:text>\NC </xsl:text>
                <xsl:apply-templates/>
                <xsl:text>\NC \NR </xsl:text>
            </xsl:when>
            <xsl:when test="ancestor::div[@type = 'contents']">
                <xsl:text>\sym{}</xsl:text>
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
                <xsl:text>\crlf </xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
 
 
    <xsl:template match="label"><!-- ok -->
        <xsl:if test="not(ancestor::note[@type = 'editorial'])">
            <xsl:text>\NC </xsl:text>
        </xsl:if>
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <xsl:template match="lb"><!-- ok -->
        <xsl:if test="not(preceding-sibling::*[1][self::head])">
            <xsl:text>\crlf </xsl:text>
        </xsl:if>
    </xsl:template>

    
    <xsl:template match="milestone[@type = 'structure']"><!-- ok -->
        <xsl:choose>
            <xsl:when test="ancestor::rdg[@type = 'ppl' or @type = 'ptl'] 
                and preceding-sibling::node() and not(preceding-sibling::pb)">
                <xsl:text>\crlf </xsl:text>
                <xsl:choose>
                    <xsl:when test="@unit = 'p' and (not(preceding-sibling::*[1][self::list]) and not(preceding-sibling::*[1][self::seg][child::*[last()][self::list]]))">
                        <xsl:call-template name="paragraph-indent"/>
                    </xsl:when>                   
                    <xsl:when test="@unit = 'p' and (preceding-sibling::*[1][self::list] or preceding-sibling::*[1][self::seg][child::*[last()][self::list]])">
                        <xsl:text>\hspace[p] </xsl:text>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="make-milestone">
                    <xsl:with-param name="milestone" select="."/>
                </xsl:call-template>                  
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    <xsl:template match="milestone[@type = 'fn-break']"><!-- ok -->
        <xsl:variable name="edt" select="replace(replace(@edRef, '#', ''), ' ', '')"/>
        <xsl:variable name="n" select="@n"/>
        
        <xsl:text>|</xsl:text>
        <xsl:value-of select="concat($edt, $n)"/>
        <xsl:text>|</xsl:text>
    </xsl:template>
    
    
    <xsl:template match="persName"><!-- ok -->
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <xsl:template match="ptr[matches(@target, '^#erl_')]"><!-- ok -->      
        <xsl:choose>
            <xsl:when test="ancestor::rdg[not(@type = 'ppl' or @type = 'ptl')]">
                <xsl:text>[E] </xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>\margin{}{e}{}{\hbox{}}{E}</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text>\pagereference[</xsl:text>
        <xsl:value-of select="generate-id()"/>
        <xsl:text>]</xsl:text>
    </xsl:template>
    
    
    <xsl:template match="ref"><!-- ok -->
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <xsl:template match="table"><!-- ok -->
        <xsl:text>\starttabulatehead</xsl:text>
        <xsl:text>\FL </xsl:text>        
        <xsl:for-each select="row[1]/cell[@role = 'label']">
            <xsl:apply-templates select="."/>
            <xsl:if test="not(following-sibling::cell)">
                <xsl:text>\NC \AR </xsl:text>               
            </xsl:if>
        </xsl:for-each>      
        <xsl:text>\LL </xsl:text>
        <xsl:text>\stoptabulatehead</xsl:text>       
        <xsl:text>\starttabulate[|</xsl:text>       
        <xsl:for-each select="row[1]/cell">
            <xsl:text>p|</xsl:text>
        </xsl:for-each>       
        <xsl:text>] </xsl:text>
        <xsl:apply-templates/>
        <xsl:text>\HL </xsl:text>
        <xsl:text>\stoptabulate </xsl:text>
    </xsl:template>    
    
    
    <xsl:template match="row"><!-- ok -->
        <xsl:if test="not(child::cell/@role = 'label')">
            <xsl:apply-templates/>
            <xsl:text>\NC \NR </xsl:text>           
        </xsl:if>
    </xsl:template>
    
    
    <xsl:template match="row[@rend = 'line']"><!-- ok -->
        <xsl:text>\HL </xsl:text>
    </xsl:template>
    
    
    <xsl:template match="cell"><!-- ok -->
        <xsl:text>\NC </xsl:text>
        <xsl:if test="@rend = 'center-aligned'">
            <xsl:text>\midaligned{</xsl:text>
        </xsl:if>
        <xsl:if test="@role = 'label'">
            <xsl:text>{\switchtobodyfont[10pt]</xsl:text>
        </xsl:if>       
        <xsl:apply-templates/>       
        <xsl:if test="@role = 'label'">
            <xsl:text>}</xsl:text>
        </xsl:if>       
        <xsl:if test="@rend = 'center-aligned'">
            <xsl:text>}</xsl:text>
        </xsl:if>
    </xsl:template>
    
    
    <xsl:template match="seg"><!-- ok -->
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <xsl:template match="seg[@type = 'item']"><!-- ok -->
        <xsl:apply-templates/>
        <xsl:text>\crlf </xsl:text>
    </xsl:template>
    
    
    <xsl:template match="seg[@type = 'toc-item']"><!-- ok -->
        <xsl:choose>
            <xsl:when test="not(ancestor::titlePart[@type = 'main'])">
                <xsl:text>\writetolist[</xsl:text>
                
                <xsl:choose>
                    <xsl:when test="ancestor::titlePart[@type = 'volume']">
                        <xsl:text>part</xsl:text>
                    </xsl:when>
                    <xsl:when test="ancestor::div[@type = 'chapter']">
                        <xsl:text>section</xsl:text>
                    </xsl:when>
                    <xsl:when test="ancestor::div[@type = 'part' or @type = 'introduction']">
                        <xsl:text>chapter</xsl:text>
                    </xsl:when>
                </xsl:choose>
                <xsl:text>]{}{</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>}</xsl:text>
            </xsl:when>
            <xsl:when test="ancestor::titlePart[@type = 'main']">
                <xsl:text>\writebetweenlist[part]{</xsl:text>
                <xsl:text>{\startalignment[center]</xsl:text>
                <xsl:text>\subject[</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>]{</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>}\stopalignment}}</xsl:text>
            </xsl:when>           
        </xsl:choose>
    </xsl:template>
    
    
    <xsl:template match="seg[@type = 'condensed']"><!-- ok -->
        <xsl:text>\marking[oddHeader]{</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>}</xsl:text>
    </xsl:template>
    
    
    <xsl:template match="signed"><!-- ok -->
        <xsl:text>\wordright{</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>}</xsl:text>
    </xsl:template>
    
    
    <xsl:template match="supplied"><!-- ok -->
        <xsl:text>{[</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>]}</xsl:text>
        
        <xsl:if test="parent::hi[parent::lem/child::*[last()] = .]/child::*[last()] = .">
            <xsl:text>~</xsl:text>
        </xsl:if>
    </xsl:template>
    
    
    <xsl:template match="back"><!-- ok -->
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <xsl:template match="divGen[@type = 'Inhalt']"><!-- ok -->
        <xsl:call-template name="make-both-columns">
            <xsl:with-param name="contents" select="string('Inhalt')"/>
        </xsl:call-template>
        
        <xsl:text>\title[</xsl:text>
        <xsl:value-of select="preceding-sibling::head"/>
        <xsl:text>]{</xsl:text>
        <xsl:value-of select="preceding-sibling::head"/>
        <xsl:text>}</xsl:text>
        <xsl:text>\placecontent </xsl:text>
    </xsl:template>
    
    
    <xsl:template match="divGen[@type = 'editorialNotes']"><!-- ok -->
        <xsl:text>\definelayout[odd]</xsl:text>
        <xsl:text>[backspace=48.5mm,</xsl:text>
        <xsl:text>width=113mm,</xsl:text>
        <xsl:text>height=191mm]</xsl:text>

        <xsl:text>\definelayout[even]</xsl:text>
        <xsl:text>[backspace=48.5mm,</xsl:text>
        <xsl:text>width=113mm,</xsl:text>
        <xsl:text>height=191mm]</xsl:text>

        <xsl:text>\setuplayout</xsl:text>
        
        <xsl:text>\blank[9mm]</xsl:text>
        <xsl:text>\starttabulate[|lp(10mm)|xp(103mm)|]</xsl:text>
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
        <xsl:text>\stoptabulate </xsl:text>
        <xsl:text>\stoppart </xsl:text>
    </xsl:template>


    <xsl:template match="divGen[@type = 'editorial_corrigenda']">
        <xsl:apply-templates/>
    </xsl:template>


    <xsl:template match="divGen[@type = 'bibel' or @type = 'persons' 
        or @type = 'classical-authors' or @type = 'subjects']"><!-- ok -->
        <xsl:call-template name="make-indices">
            <xsl:with-param name="divGen" select="."/>
        </xsl:call-template>
    </xsl:template>    
 
 
    <!-- called templates -->
    <xsl:template name="make-subject">
        <xsl:param name="content"/>
        
        <xsl:text>\subject[]{</xsl:text>
        <xsl:apply-templates select="$content"/>
        <xsl:text>}</xsl:text>
    </xsl:template>
    
    
    <xsl:template name="make-indices"><!-- ok -->
        <xsl:param name="divGen"/>
        <xsl:variable name="type" select="$divGen/@type"/>
        
        <xsl:text>\writetolist[chapter]{}{</xsl:text>
        <!-- TODO: solution with variable leads to dynamic error -->
        <xsl:choose>
            <xsl:when test="$type = 'bibel'">
                <xsl:text>Bibelstellen</xsl:text>
            </xsl:when>
            <xsl:when test="$type = 'classical-authors'">
                <xsl:text>Antike Autoren</xsl:text>
            </xsl:when>
            <xsl:when test="$type = 'persons'">
                <xsl:text>Personen</xsl:text>
            </xsl:when>
            <xsl:when test="$type = 'subjects'">
                <xsl:text>Sachen</xsl:text>
            </xsl:when>
        </xsl:choose>
        <xsl:text>}</xsl:text>
        <xsl:text>\startsetups[a]</xsl:text>
        <xsl:text>\switchtobodyfont[default]</xsl:text>
        <xsl:text>\rlap{}</xsl:text>
        <xsl:text>\hfill</xsl:text>
        <xsl:text>{\tfx\it </xsl:text> 
        
        <!-- TODO: solution with variable leads to dynamic error -->
        <xsl:choose>
            <xsl:when test="$type = 'bibel'">
                <xsl:text>Bibelstellen</xsl:text>
            </xsl:when>
            <xsl:when test="$type = 'classical-authors'">
                <xsl:text>Antike Autoren</xsl:text>
            </xsl:when>
            <xsl:when test="$type = 'persons'">
                <xsl:text>Personen</xsl:text>
            </xsl:when>
            <xsl:when test="$type = 'subjects'">
                <xsl:text>Sachen</xsl:text>
            </xsl:when>
        </xsl:choose>
        
        <xsl:text>}</xsl:text>
        <xsl:text>\hfill</xsl:text>
        <xsl:text> \llap{\pagenumber}</xsl:text>
        <xsl:text>\stopsetups</xsl:text>
        <xsl:text>{\startcolumns</xsl:text>
        <xsl:text>\place</xsl:text>
        <xsl:value-of select="$type"/>
        <xsl:text>Index</xsl:text>
        <xsl:text>\stopcolumns}</xsl:text>
    </xsl:template>
    
    
    <xsl:template name="make-milestone"><!-- ok -->
        <xsl:param name="milestone"/>
        <xsl:variable name="edition" select="replace(@edRef, '[#\s]+', '')"/>
        
        <xsl:if test="$milestone/@unit = 'p'">
            <xsl:text> \p{}</xsl:text>
        </xsl:if>      
        <xsl:if test="$milestone/@unit = 'line'">
            <xsl:text> \line{}</xsl:text>
        </xsl:if>       
        <xsl:if test="$milestone/@unit = 'no-p'">
            <xsl:text> \nop{}</xsl:text>
        </xsl:if>
        <xsl:if test="$milestone/@unit = 'no-line'">
            <xsl:text> \noline{}</xsl:text>
        </xsl:if>
        
        <xsl:text>{\tfx\high{</xsl:text>
        <xsl:value-of select="$edition"/>
        <xsl:text>}} </xsl:text>       
    </xsl:template>
    
    
    <xsl:template name="make-pb-content"><!-- ok -->
        <xsl:param name="pb"/>

        <xsl:value-of select="replace($pb/@edRef, '[# ]+', '')"/>        
        <xsl:if test="@type = 'sp'">
            <xsl:text>[</xsl:text>
        </xsl:if>       
        <xsl:value-of select="$pb/@n"/>       
        <xsl:if test="@type = 'sp'">
            <xsl:text>]</xsl:text>
        </xsl:if>
    </xsl:template>
    
    
    <xsl:template name="new-page">
        <xsl:text>\page[right,empty]</xsl:text>
        <xsl:text>\noheaderandfooterlines </xsl:text>
    </xsl:template>
    
    
    <xsl:template name="paragraph-indent">
        <xsl:text>\starteffect[hidden]</xsl:text>
        <xsl:text>.</xsl:text>
        <xsl:text>\stopeffect</xsl:text>
        <xsl:text>\hspace[p]</xsl:text>
    </xsl:template>
    
    
    <xsl:template name="make-both-columns">
        <xsl:param name="contents"/>
        
        <xsl:text>\marking[oddHeader]{</xsl:text>
        <xsl:value-of select="$contents"/>
        <xsl:text>}</xsl:text>
        
        <xsl:text>\marking[evHeader]{</xsl:text>
        <xsl:value-of select="$contents"/>
        <xsl:text>}</xsl:text>
    </xsl:template>
</xsl:stylesheet>