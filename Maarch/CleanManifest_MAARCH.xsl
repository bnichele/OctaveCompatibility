<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:seda="fr:gouv:culture:archivesdefrance:seda:v2.1"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:ns2="http://www.w3.org/1999/xlink" 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns="fr:gouv:culture:archivesdefrance:seda:v2.1" exclude-result-prefixes="seda">
    <!-- XSL mintika 2020 -->
    <!-- Transformation des manifest produits par Octave pour les rendre compatibles avec Maarch v2.6-->
    <!-- GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 -->

    <xsl:strip-space elements="*"/>
    <xsl:output indent="yes" method="xml" encoding="utf-8" omit-xml-declaration="yes"/>

    <!-- Paramètres passés en entrée -->
    <xsl:param name="ArchivalAgreement" required="yes"/>
    <xsl:param name="ArchivalProfile" required="yes"/>
    <xsl:param name="ArchivalAgency" required="yes"/>
    <xsl:param name="TransferringAgency" required="yes"/>

    <!-- Récupération de tous les noeuds et attributs -->
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

    <!-- Remplacement de l'@ algorithme d'Integrity avec la valeur attendue par défaut -->
    <xsl:template match="@algorithm">
        <xsl:attribute name="algorithm">
            <xsl:text>sha512</xsl:text>
        </xsl:attribute>
    </xsl:template>
    
    <!-- Nettoyage des @ format et mimeCode de Attachment pour laisser au SAE le soin de les compléter -->
    <xsl:template match="@xml:id" /> 
    <xsl:template match="@xsi:schemaLocation" /> 

    <!-- Ajout de l'id du contrat d'entrée & d'un identifiant de transfert -->
    <xsl:template match="seda:MessageIdentifier">
        <xsl:element name="MessageIdentifier">
            <xsl:text>Id_</xsl:text>
            <xsl:value-of select="current-time()"/>
        </xsl:element>
        <xsl:element name="ArchivalAgreement">
            <xsl:value-of select="$ArchivalAgreement"/>
        </xsl:element>
    </xsl:template>

    <!-- Ajout de l'id du profil d'archives -->
    <xsl:template match="seda:ManagementMetadata">
        <xsl:element name="ManagementMetadata">
            <xsl:element name="ArchivalProfile">
                <xsl:value-of select="$ArchivalProfile"/>
            </xsl:element>
            <xsl:copy-of select="*"/>
        </xsl:element>
    </xsl:template>
    
    <!-- Ajout de l'id du service d'archives -->
    <xsl:template match="seda:ArchivalAgency">
        <xsl:element name="ArchivalAgency">
            <xsl:element name="Identifier">
                <xsl:value-of select="$ArchivalAgency"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    <!-- Ajout de l'id du service versant -->
    <xsl:template match="seda:TransferringAgency">
        <xsl:element name="TransferringAgency">
            <xsl:element name="Identifier">
                <xsl:value-of select="$TransferringAgency"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>

</xsl:stylesheet>
