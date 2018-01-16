<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns:math="http://exslt.org/math" version="2.0">
    
    <xsl:output method="text"/>
    
    <xsl:strip-space elements="*"/>
    <xsl:preserve-space elements="abbr byline corr docImprint edition head hi
        item label lem note p persName rdg sic term titlePart"/>
    
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
        <xsl:text>\blank </xsl:text>
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <xsl:template match="div[@type = 'corrigenda']">
        <xsl:apply-templates/>
    </xsl:template>
    
    
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
        <xsl:text>\newOddPage</xsl:text>
    </xsl:template>
    
    
    <xsl:template match="div[@type = 'section-group']">
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <xsl:template match="div[@type = 'section']">
        <xsl:apply-templates/>        
        <xsl:if test="not(head)">
            <xsl:text>\blank[10pt] </xsl:text>
        </xsl:if>
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
            <xsl:when test="parent::div[@type]">
                <xsl:text>\title[]{</xsl:text> 
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
        <xsl:if test="parent::*/child::*[1] = .">
            <xsl:text>\noindentation </xsl:text>
        </xsl:if>
        <xsl:if test="preceding-sibling::p">
            <xsl:text>\par </xsl:text>
        </xsl:if>
        <xsl:apply-templates/>
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
 
 
    <xsl:template match="choice">
        <xsl:apply-templates select="child::*[not(self::seg or self::sic or self::expan)]"/>
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
    </xsl:template>
    
    
    <xsl:template match="rdg[@type = 'ppl' or @type = 'ptl']">
        <xsl:if test="not(child::*[1][self::note])">
            <xsl:text>\startrdg </xsl:text>
        </xsl:if>
        <xsl:if test="child::*[1][self::p]">
            <xsl:call-template name="paragraph-indent"/>
        </xsl:if>
        
        <xsl:apply-templates/>
        
        <xsl:if test="position() != last()">
            <xsl:text>\par </xsl:text>
        </xsl:if>
        <xsl:if test="not(child::*[1][self::note])">
            <xsl:text>\stoprdg </xsl:text>
        </xsl:if>
        <xsl:text>\noindentation </xsl:text>
    </xsl:template>
    
    
    <xsl:template match="rdg[@type = 'pp' or @type = 'pt']">
        <xsl:if test="not(preceding-sibling::rdg[@type = 'pp' or @type = 'pt'])">
            <xsl:text>{\dvl}</xsl:text>
        </xsl:if>
        <xsl:choose>
            <xsl:when test="ancestor::note[@place = 'bottom']">
                <xsl:apply-templates select="." mode="in-footnote"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="." mode="normal-note"/>
            </xsl:otherwise>
        </xsl:choose>
        <!--<xsl:apply-templates select="." mode="footnote"/>-->
    </xsl:template>
    
    
    <xsl:template match="rdg[@type = 'v']">
        <xsl:choose>
            <xsl:when test="ancestor::note[@place = 'bottom']">
                <xsl:apply-templates select="." mode="in-footnote"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="." mode="normal-note"/>
            </xsl:otherwise>
        </xsl:choose>
        <!--<xsl:apply-templates select="." mode="footnote"/>-->
    </xsl:template>
    
    
    <xsl:template match="rdg" mode="footnote">
        <xsl:variable name="wit" select="replace(@wit, '[# ]+', '')"/>
        
        <xsl:text>\</xsl:text>
        <xsl:value-of select="$wit"/>
        <xsl:text>Note{</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>}</xsl:text>       
    </xsl:template>
    
    
    <xsl:template match="rdg" mode="normal-note">
        <xsl:variable name="wit" select="replace(@wit, '[# ]+', '')"/>
        
        <xsl:text>\</xsl:text>
        <xsl:value-of select="$wit"/>
        <xsl:text>Note{</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>}</xsl:text>       
    </xsl:template>
    
    
    <xsl:template match="rdg" mode="in-footnote">
        <xsl:variable name="wit" select="replace(@wit, '[# ]+', '')"/>
        
        <xsl:text>\note[</xsl:text>
        <xsl:value-of select="$wit"/>
        <xsl:text>Note][</xsl:text>
        <xsl:value-of select="@id"/>
        <xsl:text>]</xsl:text>       
    </xsl:template>
 
 
    <xsl:template match="rdg[@type = 'om' or @type = 'typo_corr' or @type = 'var-structure']"/>
    
    
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
    </xsl:template>


    <xsl:template match="foreign[@xml:lang = 'he']">
        <xsl:text>{\switchtobodyfont[7pt] </xsl:text>
        <xsl:text>\ezraFont </xsl:text>
        <xsl:apply-templates/>
        <xsl:text>}</xsl:text>
    </xsl:template>


    <xsl:template match="pb">
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
    </xsl:template>
 
 
    <!-- within critical text -->
    <xsl:template match="note[@type = 'authorial' and ancestor::group]">
        <xsl:choose>
            <xsl:when test="@place = 'bottom'">
                <!--<xsl:text>{\startbottomnote</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>\stopbottomnote}</xsl:text>-->
                <xsl:text>\footnote{</xsl:text>
                <xsl:apply-templates/>
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
 
 
    <xsl:template match="index[@indexName = 'subjects']">
        <xsl:text>\subjectsIndex{</xsl:text>
        <xsl:value-of select="term"/>
        <xsl:text>}</xsl:text>
    </xsl:template>
 
 
    <xsl:template match="term"/>
 
 
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
    
    
    <xsl:template match="milestone[@unit = 'fn-break']">
        <xsl:variable name="edt" select="replace(replace(@edRef, '#', ''), ' ', '')"/>
        <xsl:variable name="n" select="@n"/>
        
        <xsl:text>{\vl}</xsl:text>
        <xsl:value-of select="concat($edt, $n)"/>
        <xsl:text>{\vl}</xsl:text>
    </xsl:template>
    
    
    <xsl:template match="persName">
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <xsl:template match="ptr[matches(@target, '^#erl_')]">      
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
    
    
    <xsl:template match="ref">
        <xsl:apply-templates/>
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
        <!--<xsl:if test="not(ancestor::group)">
            <xsl:text>\newOddPage</xsl:text> 
        </xsl:if>-->
        <xsl:apply-templates/>
    </xsl:template>
    
    
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


    <xsl:template match="divGen[@type = 'editorial_corrigenda']">
        <xsl:variable name="base-text" select="//desc[@type = 'base-text']/ancestor::witness/@xml:id"/>
        
        <xsl:text>\starttabulatehead</xsl:text>
        <xsl:text>\FL </xsl:text>
        <xsl:text>\NC Seite </xsl:text>
        <xsl:text>\NC fehlerhaftes Original </xsl:text>
        <xsl:text>\NC stillschweigende Korrektur \NC \AR </xsl:text>
        <xsl:text>\LL </xsl:text>
        <xsl:text>\stoptabulatehead</xsl:text>       
        <xsl:text>\starttabulate[|p(1cm)|p|p|] </xsl:text>
        <xsl:for-each select="//choice[child::sic and child::corr[@type = 'editorial']]">
            <xsl:text> \NC </xsl:text>
            <xsl:choose>
                <xsl:when test="not(./ancestor::rdg)">
                    <xsl:value-of select="$base-text"/>
                    <xsl:value-of select="./preceding::pb[matches(@edRef, $base-text)][1]/@n"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:variable name="wits" select="replace(./ancestor::rdg[1]/@wit, '#', '')"/>
                    <xsl:variable name="wits-array" select="tokenize($wits, '\s')"/>
                    <xsl:call-template name="find-prev-pbs">
                        <xsl:with-param name="iii" select="1"/>
                        <xsl:with-param name="limit" select="count($wits-array)"/>
                        <xsl:with-param name="context" select="."/>
                        <xsl:with-param name="wits" select="$wits-array"/>
                    </xsl:call-template>
                </xsl:otherwise>
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
        <xsl:value-of select="$type"/>
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
        <xsl:if test="@type = 'sp'">
            <xsl:text>[</xsl:text>
        </xsl:if>       
        <xsl:value-of select="$pb/@n"/>       
        <xsl:if test="@type = 'sp'">
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
            <xsl:variable name="prev-pb" select="$context/preceding::pb[matches(@edRef, $wits[$iii])][1]"/>
            <xsl:value-of select="$wits[$iii]"/>
            <xsl:value-of select="$prev-pb/@n"/>
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
</xsl:stylesheet>