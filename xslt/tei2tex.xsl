<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.tei-c.org/ns/1.0" 
    xmlns:math="http://exslt.org/math" version="2.0">
    
    <xsl:output method="text"/>
    
    <xsl:strip-space elements="*"/>
    <xsl:preserve-space elements="abbr byline corr docImprint edition head hi
        item label lem note p pb persName rdg sic term titlePart titlePage"/>
    
    <xsl:template match="TEI">
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <xsl:template match="teiHeader"/>
    
    
    <xsl:template match="body">
        <xsl:if test="ancestor::group">
            <xsl:text>\setupnotation[footnote][numbercommand=\gobbleoneargument, rule=off]</xsl:text>
            <xsl:text>\setupnote[footnote][textcommand=\gobbleoneargument, rule=off]</xsl:text>
        </xsl:if>
        <xsl:apply-templates/>
    </xsl:template>
 
 
    <!-- when edition text starts, page numbering in Arabic letters 
        starts with 1. On the left page (even numbers) a short bibliographic
        info in the column title is displayed, on the right page (odd numbers)
        the current chapter -->
    <xsl:template match="group">
        <xsl:text>\noheaderandfooterlines </xsl:text>          
        <xsl:text>\startbodymatter </xsl:text>
        <xsl:text>\setuppagenumber[number=1]</xsl:text>
        <xsl:text>\marking[evHeader]{{\tfx\it </xsl:text>
        <xsl:apply-templates select="//teiHeader//title[@type = 'condensed'][1]"/>
        <xsl:text>}}</xsl:text>
  
        <xsl:apply-templates/>
        <xsl:text>\stopbodymatter </xsl:text>
    </xsl:template>
    
    
    <!-- within critical text -->
    <xsl:template match="front[ancestor::group]">
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <!-- within modern editorial text -->
    <xsl:template match="front[not(ancestor::group)]">  
        <!-- frontmatter necessary for Roman page numbering (specified in header.tex) -->
        <xsl:text>\startfrontmatter </xsl:text>
        <xsl:apply-templates/>
        <xsl:text>\stopfrontmatter </xsl:text>
    </xsl:template>
    
    
    <xsl:template match="text">
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <xsl:template match="div[@type = 'epilog']">
        <xsl:text>\newOddPage</xsl:text>
        <xsl:apply-templates/>
    </xsl:template>


    <xsl:template match="div[@type = 'imprimatur']">
        <xsl:text>\newOddPage</xsl:text>
        <xsl:apply-templates/>
    </xsl:template>

    
    <!-- outside edition text -->
    <xsl:template match="div[@type = 'preface' and ancestor::group]">    
        <xsl:choose>
            <xsl:when test="ancestor::front/descendant::div[@type = 'preface'][1] = .">
                <xsl:text>\newOddPage</xsl:text>
            </xsl:when>
            <!-- only first preface has to be on an odd page -->
            <xsl:otherwise>
                <xsl:text>\page</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <!-- within modern editorial text -->
    <xsl:template match="div[@type = 'preface' and not(ancestor::group)]">
        <!-- according to publisher guidelines the first page has to be 'V' when there 
            is no dedication -->
        <xsl:text>\setuppagenumber[number=5]</xsl:text>       
        <xsl:call-template name="make-both-columns">
            <xsl:with-param name="contents" select="head"/>
        </xsl:call-template>  
        <xsl:apply-templates/>
        <xsl:text>\newOddPage</xsl:text>
    </xsl:template>
    
    
    <xsl:template match="titlePage">
        <!-- TODO: adjust -->
        <xsl:if test="ancestor::lem">
            <xsl:text>\marking[oddHeader]{Vorreden}</xsl:text>
            <xsl:text>\writetolist[part]{}{Vorreden}</xsl:text>
        </xsl:if>
        
        <xsl:text>{\startalignment[center]</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>\stopalignment}</xsl:text>
    </xsl:template>
    
    
    <xsl:template match="titlePart">
        <xsl:apply-templates/>
        
        <xsl:if test="descendant::seg[@type = 'toc-item']">
            <xsl:apply-templates select="descendant::seg[@type = 'toc-item']"/>
        </xsl:if>
        
        <xsl:if test="descendant::seg[@type = 'condensed']">
            <xsl:apply-templates select="descendant::seg[@type = 'condensed']"/>
        </xsl:if>
    </xsl:template>
    
    
    <xsl:template match="closer">
        <xsl:text>\blank \noindentation </xsl:text>
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <xsl:template match="div[@type = 'corrigenda']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="div[@type = 'index']">
        @@@!@@@
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <!--<xsl:template match="div[@type = 'editorial-notes']">-->
    <xsl:template match="div[@type = 'editorialNotes']">
        <xsl:call-template name="make-both-columns">
            <xsl:with-param name="contents" select="head[1]"/>
        </xsl:call-template>
        <xsl:apply-templates/>
    </xsl:template>
 
 
    <!-- within critical text -->   
    <xsl:template match="div[@type = 'contents' and not(@subtype = 'print')]">     
        <xsl:text>\marking[oddHeader]{Inhalt}</xsl:text>
        <xsl:choose>
            <xsl:when test="ancestor::front/descendant::div[@type = 'contents'][1] = .">
                <xsl:text>\newOddPage</xsl:text>
            </xsl:when>
            <!-- only first toc has to be on an odd page -->
            <xsl:otherwise>
                <xsl:text>\newPage</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <!-- within modern editorial text -->
    <xsl:template match="div[@type = 'contents' and @subtype = 'print']">
        <xsl:apply-templates select="descendant::divGen[@type = 'Inhalt']"/>
        <xsl:text>\newOddPage</xsl:text>
    </xsl:template>
    
    
    <xsl:template match="div[@type = 'pseudo-container']">
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <xsl:template match="div[@type = 'part']">
        <!-- <xsl:if test="not(preceding::label[1][@type = 'half-title'])"> -->
        <xsl:if test="not(preceding::div[1][@type = 'titlePage'])">
            <xsl:text>\newOddPage</xsl:text>
        </xsl:if>    

        <xsl:apply-templates/>  
    </xsl:template>
    
    
    <xsl:template match="div[@type = 'chapter']">
        <xsl:text>\newOddPage</xsl:text>
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <!-- within critical text -->
    <xsl:template match="div[@type = 'introduction' and ancestor::group]">
        <!--<xsl:if test="not(preceding-sibling::*[1][descendant::label[@type = 'half-title']])">  -->
        <xsl:if test="not(preceding-sibling::*[1][descendant::div[@type = 'titlePage']])">
            <xsl:text>\newOddPage</xsl:text>
        </xsl:if>
        <xsl:text>\noheaderandfooterlines </xsl:text>
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <!-- within modern editorial text -->
    <xsl:template match="div[@type = 'introduction' and not(ancestor::group)]">
        <xsl:text>\resetcounter[footnote]</xsl:text>
        <xsl:call-template name="make-both-columns">
            <xsl:with-param name="contents" select="head[1]"/>
        </xsl:call-template>        
        <xsl:apply-templates/>
        <!--<xsl:text>\newOddPage</xsl:text>-->
    </xsl:template>
    
    
    <xsl:template match="div[@type = 'section-group']">
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <xsl:template match="div[@type = 'section']">
        <xsl:text>\startdivsection </xsl:text>
        <xsl:apply-templates/>        
        <!--<xsl:if test="not(head)">
            <xsl:text>\blank[12pt] </xsl:text>
        </xsl:if>-->
        <xsl:text>\stopdivsection </xsl:text>
    </xsl:template>
    
    
    <xsl:template match="div[@type = 'editorial']">
        <xsl:text>\resetcounter[footnote]</xsl:text>
        <xsl:call-template name="make-both-columns">
            <xsl:with-param name="contents" select="head[1]"/>
        </xsl:call-template>        
        <xsl:apply-templates/>
        <xsl:text>\newOddPage</xsl:text>
    </xsl:template>
    
    
    <!-- is this still needed? -->
    <xsl:template match="div[@type = 'editors']">
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <xsl:template match="docDate">
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <xsl:template match="docImprint">
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <xsl:template match="docTitle">
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <xsl:template match="byline">
        <xsl:apply-templates/>
    </xsl:template>
 
 
    <xsl:template match="head[not(ancestor::group)]">
        <xsl:choose>
            <xsl:when test="@type = 'sub'
                or parent::div[not(@type)]/preceding-sibling::*[1][self::head]">
                <xsl:text>\subtitle[]{</xsl:text> 
                <xsl:apply-templates/>
                <xsl:text>}</xsl:text>                 
            </xsl:when>
            <xsl:when test="parent::div[@type]">
                <xsl:choose>
                    <xsl:when test="parent::div[@type = 'editorial' 
                        or @type ='introduction']">
                        <xsl:text>\maintitle[]{</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>\title[]{</xsl:text>
                    </xsl:otherwise>
                </xsl:choose> 
                <xsl:apply-templates/>
                <xsl:text>}</xsl:text>
                
                <xsl:text>\writetolist[part]{}{</xsl:text>
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
    
    
    <xsl:template match="head">
        <!--<xsl:if test="parent::div[@type = 'introduction' or @type = 'part' or @type = 'chapter']">-->
        <xsl:if test="descendant::seg[@type='toc-item']">
            <xsl:apply-templates select="descendant::seg[@type='toc-item']"/>
        </xsl:if>
        <xsl:if test="descendant::seg[@type='condensed']">
            <xsl:apply-templates select="descendant::seg[@type='condensed']"/>
        </xsl:if>
        
        <xsl:choose><!-- adjust -->
            <xsl:when test="ancestor::list">
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
                    <xsl:when test="ancestor::lem and @type = 'sub'">
                        <xsl:text>\listsubhead[]{</xsl:text>
                    </xsl:when>
                </xsl:choose>
                <xsl:apply-templates/>
                <xsl:text>}</xsl:text>
            </xsl:when>   
            <xsl:when test="ancestor::rdg">
                <xsl:text>\rdgsubject[]{</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>}</xsl:text>                
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>\subject[]{</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>}</xsl:text>                
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


    <xsl:template match="p">
        <xsl:if test="ancestor::div/descendant::p[1] = .
            or parent::note[@type='editorial']/descendant::p[1] = .">
            <xsl:text>\noindentation </xsl:text>
        </xsl:if>
        <xsl:if test="(preceding-sibling::p
            or not(ancestor::div/descendant::p[1] = .))
            and not(parent::note[@type='editorial'])">
            <xsl:text>\par </xsl:text>
        </xsl:if>
        <xsl:apply-templates/>
        <xsl:if test="@break-after = 'yes'">
            <xsl:text> </xsl:text>
        </xsl:if>
    </xsl:template>
    
    
    <xsl:template match="p[@rend = 'margin-vertical']"> 
        <xsl:text>\blank[big]</xsl:text>
        <xsl:text>\noindentation </xsl:text>
        <xsl:apply-templates/>
    </xsl:template>


    <xsl:template match="hi">
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
        
        <xsl:if test="@break-after = 'yes'">
            <xsl:text> </xsl:text>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="aligned">
        <xsl:choose>
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
        </xsl:choose>       
    </xsl:template>
 
 
    <xsl:template match="choice">
        <xsl:apply-templates select="child::*[not(self::seg or self::sic or self::expan)]"/>
        <xsl:if test="@break-after = 'yes'">
            <xsl:text> </xsl:text>
        </xsl:if>
    </xsl:template>
 
 
    <xsl:template match="abbr">
        <xsl:apply-templates/>
    </xsl:template>
 
 
    <xsl:template match="expan"/>
 
 
    <xsl:template match="sic"/>


    <xsl:template match="sic" mode="editorial-corrigenda">
        <xsl:apply-templates/>
    </xsl:template>
 
 
    <xsl:template match="orig">
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <xsl:template match="app">
        <xsl:if test="not(lem[@type = 'missing-structure'])">
            <xsl:apply-templates/>
        </xsl:if>
        
        <xsl:if test="@break-after = 'yes'">
            <xsl:text> </xsl:text>
        </xsl:if>
    </xsl:template>
    
    
    <xsl:template match="rdg[@type = 'ppl' or @type = 'ptl']">
        <xsl:if test="not(child::*[1][self::note])">
            <xsl:text>\startrdg </xsl:text>
        </xsl:if>
        <xsl:if test="child::*[1][self::p]">
            <xsl:call-template name="paragraph-indent"/>
        </xsl:if>
        
        <xsl:choose>
            <!-- special case: when a rdg[@type = 'ppl' or @type = 'ptl']
            has only bottom notes as children then summarize these single notes
            to one. this is done because otherwise these notes might be displayed
            on seperate pages in the book (which is unwanted) -->
            <xsl:when test="count(child::*[self::note[@place = 'bottom']]) > 1 
                and not(child::*[not(self::note[@place = 'bottom'])])">
                <xsl:text>\authorbottomnote{</xsl:text>
                <xsl:apply-templates select="descendant::rdgMarker[@mark = 'open']"/>
                <xsl:for-each select="child::note[@place = 'bottom']/text()">
                    <xsl:apply-templates select="."/>
                    <xsl:if test="not(ancestor::rdg[1]/child::note[@place = 'bottom'][last()] = .)">
                        <xsl:text>\crlf </xsl:text>
                    </xsl:if>
                </xsl:for-each>
                <xsl:apply-templates select="descendant::rdgMarker[@mark = 'close']"/>
                <xsl:text>}</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
        
        <xsl:if test="position() != last() and not(titlePage)">
            <xsl:text>\par </xsl:text>
        </xsl:if>
        <xsl:if test="not(child::*[1][self::note])">
            <xsl:text>\stoprdg </xsl:text>
        </xsl:if>
        <xsl:if test="not(note[@place = 'bottom'])">
            <xsl:text>\noindentation </xsl:text>
        </xsl:if>
    </xsl:template>
    
    
    <xsl:template match="rdg[@type = 'pp' or @type = 'pt']">
        <xsl:if test="not(preceding-sibling::rdg[@type = 'pp' or @type = 'pt'])">
            <xsl:text>\hspace[insert]{\dvl}</xsl:text>
        </xsl:if>
        <xsl:call-template name="make-app-entry">
            <xsl:with-param name="node" select="."/>
            <xsl:with-param name="wit" select="replace(@wit, '[# ]+', '')"/>
        </xsl:call-template>
    </xsl:template>
    
    
    <xsl:template match="rdg[@type = 'v']">
        <xsl:call-template name="make-app-entry">
            <xsl:with-param name="node" select="."/>
            <xsl:with-param name="wit" select="replace(@wit, '[# ]+', '')"/>
        </xsl:call-template>        
    </xsl:template>
 <!--
    <xsl:template match="rdg[@type = 'om' or @type = 'typo-correction' 
        or @type = 'varying-structure']"/>-->
    <xsl:template match="rdg[@type = 'om' or @type = 'typo_corr' or @type = 'var-structure']"/>
    
    
    <xsl:template match="rdgMarker">
        <xsl:variable name="wit" select="replace(@wit, ' ', '')"/>
        
        <xsl:choose>
            <xsl:when test="@type = 'v' and @mark = 'close' 
                and parent::lem">
                <xsl:variable name="refs-array" select="tokenize(@ref, ' ')"/>
                <!--<xsl:variable name="ref" select="./@ref"/>
                <xsl:apply-templates select="//rdg[@id = $ref]" mode="default"/>  -->
                
                <xsl:choose>
                    <xsl:when test="count($refs-array) = 1">
                        <xsl:variable name="ref" select="./@ref"/>
                        <xsl:apply-templates select="//rdg[@id = $ref]" mode="default"/> 
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="set-all-variants">
                            <xsl:with-param name="iii" select="1"/>
                            <xsl:with-param name="limit" select="count($refs-array)"/>
                            <xsl:with-param name="refs" select="$refs-array"/>
                        </xsl:call-template>  
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
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
                    <xsl:value-of select="@ref"/>
                    <xsl:text>}{\tfx\high{</xsl:text>
                    <xsl:value-of select="$wit"/>
                    <xsl:text>}}{</xsl:text>
                    <xsl:value-of select="$wit"/>
                    <xsl:text>}</xsl:text>                   
                </xsl:if>
                <xsl:if test="@mark = 'close'">
                    <xsl:text>\margin{}{plClose}{</xsl:text>
                    <xsl:value-of select="@ref"/>
                    <xsl:text>}{\tfx\high{</xsl:text>
                    <xsl:value-of select="$wit"/>
                    <xsl:text>}}{</xsl:text>
                    <xsl:value-of select="$wit"/>
                    <xsl:text>}</xsl:text>                     
                </xsl:if>                
            </xsl:when>
            <xsl:when test="@type = 'om'">
                <xsl:if test="@mark = 'open'">
                    <xsl:text>\margin{}{omOpen}{</xsl:text>
                    <xsl:value-of select="@ref"/>
                    <xsl:text>}{\tfx\high{/</xsl:text>
                    <xsl:value-of select="$wit"/>
                    <xsl:text>}}{/</xsl:text>
                    <xsl:value-of select="$wit"/>
                    <xsl:text>}</xsl:text>                   
                </xsl:if>
                <xsl:if test="@mark = 'close'">
                    <xsl:text>\margin{}{omClose}{</xsl:text>
                    <xsl:value-of select="@ref"/>
                    <xsl:text>}{\tfx\high{</xsl:text>
                    <xsl:value-of select="$wit"/>
                    <xsl:text>\textbackslash}}{</xsl:text>
                    <xsl:value-of select="$wit"/>
                    <xsl:text>\textbackslash}</xsl:text>   
                </xsl:if>                
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    
    <xsl:template match="lem">
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <xsl:template match="foreign[@xml:lang = 'gr']">
        <xsl:apply-templates/>
        <xsl:if test="@break-after = 'yes'">
            <xsl:text> </xsl:text>
        </xsl:if>
    </xsl:template>


    <xsl:template match="foreign[@xml:lang = 'he']">
        <xsl:text>{\switchtobodyfont[7pt] </xsl:text>
        <xsl:text>\ezraFont </xsl:text>
        <xsl:apply-templates/>
        <xsl:text>}</xsl:text>
        <xsl:if test="@break-after = 'yes'">
            <xsl:text> </xsl:text>
        </xsl:if>
    </xsl:template>


    <xsl:template match="pb">
        <xsl:if test="@break-before = 'yes'
            and not(preceding-sibling::*[1][self::rdgMarker])">
            <xsl:text> </xsl:text>
        </xsl:if>
        
        <xsl:choose>
            <xsl:when test="ancestor::rdg[@type = 'v' or @type = 'pp' or @type = 'pt']">
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
        
        <xsl:if test="@break-after = 'yes'">
            <xsl:text> </xsl:text>
        </xsl:if>
    </xsl:template>
 
 
    <!-- within critical text -->
    <xsl:template match="note[@type = 'authorial' and ancestor::group]">
        <xsl:choose>
            <xsl:when test="@place = 'bottom'">
                <!--<xsl:text>{\startbottomnote</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>\stopbottomnote}</xsl:text>-->
                <!--<xsl:text>\footnote{</xsl:text>-->
                <xsl:text>\authorbottomnote{</xsl:text>
                <xsl:if test="ancestor::rdg[@type = 'ppl' or @type = 'ptl']/descendant::note[@place = 'bottom'][1] = .">
                    <xsl:apply-templates select="preceding::rdgMarker[1][@ref = ancestor::rdg[@type = 'ppl' 
                        or @type = 'ptl']/@id and @mark = 'open']"/>
                </xsl:if>
                <xsl:apply-templates/>
                <xsl:if test="ancestor::rdg[@type = 'ppl' or @type = 'ptl']/descendant::note[@place = 'bottom'][last()] = .">
                    <xsl:apply-templates select="following::rdgMarker[1][@ref = ancestor::rdg[@type = 'ppl' 
                        or @type = 'ptl']/@id and @mark = 'close']"/>                   
                </xsl:if>
                <xsl:text>}</xsl:text>
                
                <xsl:variable name="rdgs" select="descendant::rdg[@type = 'v' or @type = 'pp' or @type = 'pt']"/>
                <xsl:for-each select="$rdgs">
                    <xsl:variable name="wit" select="replace(./@wit, '[# ]+', '')"/>
                    <xsl:text>\setnotetext[</xsl:text>
                    <xsl:value-of select="$wit"/>
                    <xsl:text>Note][</xsl:text>
                    <xsl:value-of select="@id"/>
                    <xsl:text>]{</xsl:text>
                    <xsl:apply-templates/>
                    <xsl:text>}</xsl:text>
                </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>\startauthornote </xsl:text>  
                <xsl:apply-templates/>
                <xsl:text>\stopauthornote </xsl:text>  
                <xsl:text>\noindentation </xsl:text>  
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
 
 
    <!-- within modern editorial text -->
    <xsl:template match="note[@type = 'authorial' and not(ancestor::group)]">
        <xsl:text>\footnote{</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>}</xsl:text>
    </xsl:template>
 
 
    <xsl:template match="note[@type = 'editorial']"/>
 
 
    <xsl:template match="index[@indexName = 'classical-authors']">
        <xsl:text>\classicalauthorsIndex{</xsl:text>
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
 
 
    <xsl:template match="bibl[@type = 'biblical-reference']">        
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
                    <!-- does the other case ever occur? -->
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
        <xsl:if test="@break-after = 'yes'">
            <xsl:text> </xsl:text>
        </xsl:if>
    </xsl:template>
 
 
    <xsl:template match="index[@indexName = 'persons']">
        <xsl:choose>
            <xsl:when test="count(term) gt 1">
                <xsl:text>\seepersonsIndex{</xsl:text>
                <xsl:value-of select="substring-before(term[1], ',')"/>
                <xsl:text>}{</xsl:text>
                <xsl:value-of select="substring-after(term[1], 's\. ')"/>
                <xsl:text>}</xsl:text>  
                <xsl:text>\personsIndex{</xsl:text>
                <xsl:value-of select="term[2]"/>
                <xsl:text>}</xsl:text>                
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>\personsIndex{</xsl:text>
                <xsl:value-of select="term"/>
                <xsl:text>}</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
 
 
    <xsl:template match="index[@indexName = 'subjects']">
        <xsl:text>\subjectsIndex{</xsl:text>
        <xsl:value-of select="term"/>
        <xsl:text>}</xsl:text>
    </xsl:template>
 
 
    <xsl:template match="term"/>
 
 
    <xsl:template match="l">
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <xsl:template match="lg">
        <xsl:apply-templates/>
    </xsl:template>
 
 
    <xsl:template match="list">
        <xsl:text>\crlf </xsl:text>
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <xsl:template match="list[ancestor::div[@type = 'contents']]">
        <xsl:text>\setupindenting[yes,medium]</xsl:text>
        <xsl:text>\setupitemgroup[itemize][indenting={40pt,next}]</xsl:text>
        <xsl:text>\startitemize[packed, paragraph, joinedup</xsl:text>
        
        <!-- in a TOC the first level shouldn't be indented --> 
        <xsl:if test="ancestor::div[@type = 'contents']/descendant::list[1] = .">
            <xsl:text>, inmargin</xsl:text>
        </xsl:if>       
        <xsl:text>]</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>\stopitemize </xsl:text>       
    </xsl:template>


    <xsl:template match="list[ancestor::div[@type = 'editorial']]">
        <xsl:text>\starttwocolumns </xsl:text>
        <xsl:apply-templates/>
        <xsl:text>\stoptwocolumns </xsl:text>    
        <xsl:text>\noindentation </xsl:text> 
    </xsl:template>
 
 
    <xsl:template match="item">
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
 
 
    <xsl:template match="label">
        <xsl:if test="not(ancestor::note[@type = 'editorial'])">
            <xsl:text>\NC </xsl:text>
        </xsl:if>
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <xsl:template match="lb">
        <xsl:if test="not(preceding-sibling::*[1][self::head])">
            <xsl:text>\crlf </xsl:text>
        </xsl:if>
    </xsl:template>

    
    <xsl:template match="milestone[@type = 'structure']">
        <xsl:choose>
            <xsl:when test="ancestor::rdg[@type = 'ppl' or @type = 'ptl'] 
                and preceding-sibling::node() and not(preceding-sibling::pb)">
                <xsl:text>\crlf </xsl:text>
                <xsl:choose>
                    <xsl:when test="@unit = 'p' and (not(preceding-sibling::*[1][self::list]) 
                        and not(preceding-sibling::*[1][self::seg][child::*[last()][self::list]]))">
                        <xsl:call-template name="paragraph-indent"/>
                    </xsl:when>                   
                    <xsl:when test="@unit = 'p' and (preceding-sibling::*[1][self::list] 
                        or preceding-sibling::*[1][self::seg][child::*[last()][self::list]])">
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
    
    
    <xsl:template match="milestone[@unit = 'fn-break']">
        <xsl:variable name="edt" select="replace(replace(@edRef, '#', ''), ' ', '')"/>
        <xsl:variable name="n" select="@n"/>
        
        <xsl:text>{\vl}</xsl:text>
        <xsl:value-of select="concat($edt, $n)"/>
        <xsl:text>{\vl}</xsl:text>
    </xsl:template>
    
    
    <xsl:template match="persName">
        <xsl:apply-templates/>
        <xsl:if test="@break-after ='yes'">
            <xsl:text> </xsl:text>
        </xsl:if>       
    </xsl:template>
    
    <xsl:template match="rs">
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-- <xsl:template match="ptr[@type = 'editorial-commentary']"> -->
    <xsl:template match="ptr[matches(@target, '^#erl_')]">      
        <xsl:choose>
            <xsl:when test="ancestor::rdg[not(@type = 'ppl' or @type = 'ptl')]">
                <xsl:text>[E] </xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>\margin{</xsl:text>
                <xsl:value-of select="generate-id()"/>
                <xsl:text>}{e}{}{\hbox{}}{E}</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text>\pagereference[</xsl:text>
        <xsl:value-of select="generate-id()"/>
        <xsl:text>]</xsl:text>
    </xsl:template>
    
    
    <xsl:template match="ref">
        <xsl:apply-templates/>
        <xsl:if test="@break-after ='yes'">
            <xsl:text> </xsl:text>
        </xsl:if>
    </xsl:template>
    
    
    <xsl:template match="table">
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
    
    
    <xsl:template match="row">
        <xsl:if test="not(child::cell/@role = 'label')">
            <xsl:apply-templates/>
            <xsl:text>\NC \NR </xsl:text>           
        </xsl:if>
    </xsl:template>
    
    
    <xsl:template match="row[@rend = 'line']">
        <xsl:text>\HL </xsl:text>
    </xsl:template>
    
    
    <xsl:template match="cell">
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
    
    
    <xsl:template match="seg">
        <xsl:apply-templates/>
        <xsl:if test="@break-after">
            <xsl:text> </xsl:text>
        </xsl:if>
    </xsl:template>
    
    
    <xsl:template match="seg[@type = 'item']">
        <xsl:apply-templates/>
        <xsl:text>\crlf </xsl:text>
    </xsl:template>
    
    
    <xsl:template match="seg[@type = 'toc-item']">
        <xsl:choose>
            <xsl:when test="not(ancestor::titlePart[@type = 'main'])">
                <xsl:text>\writetolist[</xsl:text>
                
                <xsl:choose>
                    <xsl:when test="ancestor::titlePart[@type = 'volume']">
                        <xsl:text>part</xsl:text>
                    </xsl:when>
                    <!-- for Griesbach -->
                    <xsl:when test="ancestor::div[@type = 'section']">
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
    
    
    <xsl:template match="seg[@type = 'condensed']">
        <xsl:text>\marking[oddHeader]{</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>}</xsl:text>
    </xsl:template>
    
    
    <xsl:template match="signed">
        <xsl:text>\wordright{</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>}</xsl:text>
    </xsl:template>
    
    
    <xsl:template match="supplied">
        <xsl:text>{[</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>]}</xsl:text>
        
        <xsl:if test="parent::hi[parent::lem/child::*[last()] = .]/child::*[last()] = .">
            <xsl:text>~</xsl:text>
        </xsl:if>
    </xsl:template>
    
    
    <xsl:template match="back">
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-- <xsl:template match="divGen[@type = 'content']"> -->
    <xsl:template match="divGen[@type = 'Inhalt']">
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
    
<!--    <xsl:template match="divGen[@type = 'editorial-notes']">-->
    <xsl:template match="divGen[@type = 'editorialNotes']">
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
        <!-- <xsl:for-each select="//ptr[@type = 'editorial-commentary']">  -->
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
        <xsl:text>\newOddPage </xsl:text>
    </xsl:template>


<!--    <xsl:template match="divGen[@type = 'editorial-corrigenda']">-->
    <xsl:template match="divGen[@type = 'editorial_corrigenda']">
        <xsl:variable name="base-text" select="//desc[@type = 'base-text']/ancestor::witness/@xml:id"/>
        <!--<xsl:variable name="base-text" select="//witness[@n = 'base-text']/@n"/>-->
        
        <xsl:text>\starttabulatehead</xsl:text>
        <xsl:text>\FL </xsl:text>
        <xsl:text>\NC Seite </xsl:text>
        <xsl:text>\NC fehlerhaftes Original </xsl:text>
        <xsl:text>\NC stillschweigende Korrektur \NC \AR </xsl:text>
        <xsl:text>\LL </xsl:text>
        <xsl:text>\stoptabulatehead</xsl:text>       
        <xsl:text>\starttabulate[|p(1cm)|p|p|] </xsl:text>
        <xsl:for-each select="//choice[corr[@type = 'editorial']]">
            <xsl:text> \NC </xsl:text>
            <xsl:choose>
                <xsl:when test="ancestor::note[@place = 'bottom'][not(parent::rdg)]">
                    <xsl:choose>
                        <xsl:when test="parent::lem[not(@wit)] or not(parent::rdg or parent::lem[@wit])"> 
                            <xsl:variable name="prev-fn-break" select="preceding-sibling::milestone[@unit = 'fn-break'][matches(@edRef, $base-text)][1]"/>
                            <xsl:variable name="prev-pb" select="ancestor::note[@place = 'bottom']/preceding::pb[matches(@edRef, $base-text)][1]"/>
                            
                            <xsl:choose>
                                <xsl:when test="$prev-fn-break">
                                    <xsl:call-template name="make-pb-content">
                                        <xsl:with-param name="pb" select="$prev-fn-break"/>
                                    </xsl:call-template> 
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:call-template name="make-pb-content">
                                        <xsl:with-param name="pb" select="$prev-pb"/>
                                    </xsl:call-template> 
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:when test="parent::rdg or parent::lem[@wit]">
                            <xsl:variable name="wit" select="parent::rdg/@wit"/>
                            <xsl:variable name="prev-fn-break" select="ancestor::app[1]/preceding-sibling::milestone[@unit = 'fn-break'][matches(@edRef, $wit)][1]"/>
                            <xsl:variable name="prev-pb" select="ancestor::note[@place = 'bottom']/preceding::pb[matches(@edRef, $wit)][1]"/>

                            <xsl:choose>
                                <xsl:when test="$prev-fn-break">
                                    <xsl:call-template name="make-pb-content">
                                        <xsl:with-param name="pb" select="$prev-fn-break"/>
                                    </xsl:call-template> 
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:call-template name="make-pb-content">
                                        <xsl:with-param name="pb" select="$prev-pb"/>
                                    </xsl:call-template>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                    </xsl:choose>
                </xsl:when>
                <xsl:when test="ancestor::note[parent::rdg]">
                    <xsl:variable name="wit" select="ancestor::note/parent::rdg/@wit"/>
                    <xsl:variable name="prev-fn-break" select="preceding-sibling::milestone[@unit = 'fn-break'][matches(@edRef, $wit)][1]"/>
                    <xsl:variable name="prev-pb" select="ancestor::note/ancestor::app[1]/preceding::pb[matches(@edRef, $wit)][1]"/>

                    <xsl:choose>
                        <xsl:when test="$prev-fn-break">
                            <xsl:call-template name="make-pb-content">
                                <xsl:with-param name="pb" select="$prev-fn-break"/>
                            </xsl:call-template> 
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:call-template name="make-pb-content">
                                <xsl:with-param name="pb" select="$prev-pb"/>
                            </xsl:call-template>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:when test="parent::rdg">
                    <xsl:variable name="wit" select="parent::rdg/@wit"/>
                    <xsl:choose>
                        <xsl:when test="matches($wit, '# ')">
                            <xsl:variable name="wits" select="replace($wit, '#', '')"/>
                            <xsl:variable name="wits-array" select="tokenize($wits, '\s')"/>
                            <xsl:call-template name="find-prev-pbs">
                                <xsl:with-param name="iii" select="1"/>
                                <xsl:with-param name="limit" select="count($wits-array)"/>
                                <xsl:with-param name="context" select="."/>
                                <xsl:with-param name="wits" select="$wits-array"/>
                            </xsl:call-template>   
                        </xsl:when>
                        <xsl:otherwise> 
                            <xsl:variable name="prev-pb" select="preceding-sibling::pb[matches(@edRef, $wit)][1]"/>
                            <xsl:variable name="prev-app-pb" select="ancestor::app[1]/preceding::pb[matches(@edRef, $wit)][1]"/>
                            
                            <xsl:choose>
                                <xsl:when test="$prev-pb">
                                    <xsl:call-template name="make-pb-content">
                                        <xsl:with-param name="pb" select="$prev-pb"/>
                                    </xsl:call-template>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:call-template name="make-pb-content">
                                        <xsl:with-param name="pb" select="$prev-app-pb"/>
                                    </xsl:call-template>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:when test="parent::lem">
                    <xsl:variable name="prev-pb" select="ancestor::app[1]/preceding::pb[matches(@edRef, $base-text)][1]"/>
                    <xsl:call-template name="make-pb-content">
                        <xsl:with-param name="pb" select="$prev-pb"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:when test="not(ancestor::app)">
                    <xsl:variable name="prev-pb" select="preceding::pb[matches(@edRef, $base-text)][1]"/>
                    <xsl:call-template name="make-pb-content">
                        <xsl:with-param name="pb" select="$prev-pb"/>
                    </xsl:call-template>                    
                </xsl:when>
            </xsl:choose>
            <xsl:text> \NC </xsl:text>
            <xsl:apply-templates select="sic" mode="editorial-corrigenda"/>
            <xsl:text>\NC </xsl:text>
            <xsl:apply-templates select="corr"/>
            <xsl:text>\NC \NR </xsl:text>            
        </xsl:for-each>
        <xsl:apply-templates/>
        <xsl:text>\HL </xsl:text>
        <xsl:text>\stoptabulate </xsl:text>
    </xsl:template>


    <xsl:template match="divGen[@type = 'bibel' or @type = 'persons' 
        or @type = 'classical-authors' or @type = 'subjects']">
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
    
    
    <xsl:template name="make-app-entry">
        <xsl:param name="wit"/> 
        <xsl:param name="node"/>
        
        <xsl:choose>
            <xsl:when test="$node/ancestor::note[@place = 'bottom']">
                <xsl:text>\note[</xsl:text>
                <xsl:value-of select="$wit"/>
                <xsl:text>Note][</xsl:text>
                <xsl:value-of select="$node/@id"/>
                <xsl:text>]</xsl:text> 
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>\</xsl:text>
                <xsl:value-of select="$wit"/>
                <xsl:text>Note{</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>}</xsl:text> 
            </xsl:otherwise>
        </xsl:choose>
        
        <xsl:if test="following::node()[1][self::text()]
            or not($node/@type = $node/preceding-sibling::rdg/@type)">
            <xsl:text> </xsl:text>
        </xsl:if>
    </xsl:template>
    
    
    <xsl:template name="make-indices">
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
        <xsl:value-of select="replace($type, '-', '')"/>
        <xsl:text>Index</xsl:text>
        <xsl:text>\stopcolumns}</xsl:text>
    </xsl:template>
    
    
    <xsl:template name="make-milestone">
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
    
    
    <xsl:template name="make-pb-content">
        <xsl:param name="pb"/>

        <xsl:value-of select="replace($pb/@edRef, '[# ]+', '')"/>        
        <xsl:if test="$pb/@type = 'sp'">
            <xsl:text>[</xsl:text>
        </xsl:if>  
        <xsl:value-of select="replace($pb/@n, '\*', '')"/>       
        <xsl:if test="$pb/@type = 'sp'">
            <xsl:text>]</xsl:text>
        </xsl:if>
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
    
    
    <xsl:template name="find-prev-pbs">
        <xsl:param name="iii"/>
        <xsl:param name="limit"/>
        <xsl:param name="context"/>
        <xsl:param name="wits"/>
        
        <xsl:if test="$iii &lt;= $limit">
            <xsl:variable name="prev-pb" select="$context/preceding::pb[1][matches(@edRef, $wits[$iii])]"/>
            <xsl:variable name="prev-pb-no" select="$prev-pb/@n"/>
            <xsl:variable name="fn-break" select="$context/preceding::milestone[@unit = 'fn-break'][matches(@edRef, $wits[$iii])][1]"/>
            <xsl:variable name="fn-break-no" select="replace($fn-break/@n, '[^\d]', '')"/>
            <xsl:choose>
                <xsl:when test="$fn-break-no &gt; $prev-pb-no">
                    <xsl:value-of select="$wits[$iii]"/>
                    <xsl:value-of select="$fn-break-no"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$wits[$iii]"/>
                    <xsl:if test="$prev-pb/@type = 'sp'">
                        <xsl:text>[</xsl:text>
                    </xsl:if>
                    <xsl:value-of select="$prev-pb/@n"/>  
                    <xsl:if test="$prev-pb/@type = 'sp'">
                        <xsl:text>]</xsl:text>
                    </xsl:if>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="$iii &lt; $limit">
                <xsl:text>, </xsl:text>
            </xsl:if>
            
            <xsl:call-template name="find-prev-pbs">
                <xsl:with-param name="iii" select="$iii + 1"/>
                <xsl:with-param name="limit" select="$limit"/>
                <xsl:with-param name="context" select="$context"/>
                <xsl:with-param name="wits" select="$wits"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="set-all-variants">
        <xsl:param name="iii"/>
        <xsl:param name="limit"/>
        <xsl:param name="refs"/>
        
        <xsl:if test="$iii &lt;= $limit">
            <xsl:variable name="ref" select="$refs[$iii]"/>
            <xsl:apply-templates select="//rdg[@id = $ref]" mode="default"/>
            
            <xsl:call-template name="set-all-variants">
                <xsl:with-param name="iii" select="$iii + 1"/>
                <xsl:with-param name="limit" select="$limit"/>
                <xsl:with-param name="refs" select="$refs"/>
            </xsl:call-template> 
        </xsl:if>       
    </xsl:template>
</xsl:stylesheet>