<?xml version='1.0' encoding="WINDOWS-1252"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:template match="CUSTOMER">
		<html>
			<head>
				<title>Using XSLT to transform the Orders XML document into formatted HTML</title>
			</head>
			<body>
				<xsl:apply-templates select="COMPANY"/>
				<xsl:apply-templates select="ORDERHEADER"/>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="COMPANY">
		<h1>Orders for <xsl:value-of select="."/></h1>
	</xsl:template>
	<xsl:template match="ORDERHEADER">
		<h3>Order Number: <xsl:value-of select="@ID"/> Date: <xsl:value-of select="DATE"/> Total: <xsl:value-of select="AMOUNT"/></h3>
		<ul>
			<xsl:apply-templates select="ORDERLINE"/>
		</ul>
	</xsl:template>
	<xsl:template match="ORDERLINE">			
		<li><xsl:value-of select="concat(QUANTITY, ' ')"/><xsl:value-of select="PRODUCT"/></li>
	</xsl:template>
</xsl:stylesheet>			
				
