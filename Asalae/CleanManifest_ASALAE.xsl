<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:seda="fr:gouv:culture:archivesdefrance:seda:v1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ns2="http://www.w3.org/1999/xlink"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns="fr:gouv:culture:archivesdefrance:seda:v1.0" exclude-result-prefixes="seda">
    <!-- XSL mintika 2020 -->
    <!-- Transformation des manifest produits par Octave pour les rendre compatibles avec As@lae V1.6 -->
    <!-- GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 -->

    <xsl:strip-space elements="*"/>
    <xsl:output indent="yes" method="xml" encoding="utf-8" omit-xml-declaration="yes"/>

    <!-- Paramètres passés en entrée -->
    <xsl:param name="ArchivalAgency" required="yes"/>
    <xsl:param name="TransferringAgency" required="yes"/>

    <!-- Récupération de tous les noeuds et attributs -->
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

    <!-- Retrait du noeud ArchiveObject supplémentaire de SEDA 1-->
    <xsl:template match="seda:Archive">
        <xsl:apply-templates select="seda:ArchiveObject"/>
    </xsl:template> 
    <xsl:template match="seda:ArchiveObject">
        <xsl:element name="Archive">
            <xsl:element name="DescriptionLanguage">
                <xsl:text>fra</xsl:text>
            </xsl:element>
            <xsl:copy-of select="node()" />
        </xsl:element>
    </xsl:template>

    <!-- Ajout de l'id du contrat d'entrée & d'un identifiant de transfert -->
    <xsl:template match="seda:TransferIdentifier">
        <xsl:comment>
            <xsl:text>XSL mintika 2020 : Transformation des manifest produits par Octave pour les rendre compatibles avec As@lae V1.6</xsl:text>
        </xsl:comment>
        <xsl:element name="TransferIdentifier">
            <xsl:text>Id_</xsl:text>
            <xsl:value-of select="current-time()"/>
        </xsl:element>
    </xsl:template>

    <!-- Nettoyage des @ format et mimeCode de Attachment pour laisser au SAE le soin de les compléter -->
    <xsl:template match="@format"/>
    <xsl:template match="@mimeCode"/>

    <!-- Retrait du hash base64 incopatible avec As@lae. Le SAE le recalculera -->
    <xsl:template match="seda:Integrity"/>

    <!-- Ajout de l'id du service d'archives -->
    <xsl:template match="seda:ArchivalAgency">
        <xsl:element name="ArchivalAgency">
            <xsl:element name="Identification">
                <xsl:value-of select="$ArchivalAgency"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>

    <!-- Ajout de l'id du service versant -->
    <xsl:template match="seda:TransferringAgency">
        <xsl:element name="TransferringAgency">
            <xsl:element name="Identification">
                <xsl:value-of select="$TransferringAgency"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>

</xsl:stylesheet>
