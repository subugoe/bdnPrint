<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns:math="http://exslt.org/math" version="2.0">
    
    <xsl:output method="text"/>
    
    <xsl:strip-space elements="*"/>
    <xsl:preserve-space elements="abbr byline corr docImprint edition head hi
        item label lem note p persName rdg ref sic term titlePart"/>
    
    <xsl:template match="TEI"><!-- ok -->
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="teiHeader"/><!-- ok -->
    
    <xsl:template match="body">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="group">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="front">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="text">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="div[@type = 'preface']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="titlePage">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="titlePart">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="closer">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="div[@type = 'corrigenda']"><!-- ok -->
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="div[@type = 'editorialNotes']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="div[@type = 'contents']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="div[@type = 'pseudo-container']"><!-- ok -->
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="div[@type = 'part']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="div[@type = 'chapter']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="div[@type = 'introduction']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="div[@type = 'section-group']"><!-- ok -->
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="div[@type = 'section']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="div[@type = 'editorial']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="div[@type = 'editors']">
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
    
    <xsl:template match="head">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="head[ancestor::table]">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="p">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="hi">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="choice">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="abbr">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="expan">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="sic">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="orig">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="app">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="rdg">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="rdg[@type = 'typo_corr']"/>
    
    <xsl:template match="rdg[@type = 'var-structure']"/>
    
    <xsl:template match="rdgMarker">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="lem">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="foreign[@xml:lang = 'gr']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="foreign[@xml:lang = 'he']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="pb">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="note[@type = 'authorial' and @place = 'bottom']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="note[@type = 'authorial' and @place = 'end']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="note[@type = 'editorial']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="index[@name = 'classical-authors']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="bibl[@type = 'biblical-reference']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="index[@name = 'persons']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="index[@name = 'subjects']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="term">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="list">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="item">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="label">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="lb">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="milestone">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="persName"><!-- ok -->
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="ptr">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="ref">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="table">
        <xsl:apply-templates/>
    </xsl:template>    
    
    <xsl:template match="row">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="cell">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="seg">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="signed">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="supplied">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="back"><!-- ok -->
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="divGen[@type = 'Inhalt']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="divGen[@type = 'bible']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="divGen[@type = 'classical-authors']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="divGen[@type = 'editorialNotes']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="divGen[@type = 'editorial_corrigenda']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="divGen[@type = 'persons']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="divGen[@type = 'subjects']">
        <xsl:apply-templates/>
    </xsl:template>
</xsl:stylesheet>