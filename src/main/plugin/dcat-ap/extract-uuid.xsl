<?xml version="1.0" encoding="UTF-8"?>
<!--
  ~ Copyright (C) 2001-2016 Food and Agriculture Organization of the
  ~ United Nations (FAO-UN), United Nations World Food Programme (WFP)
  ~ and United Nations Environment Programme (UNEP)
  ~
  ~ This program is free software; you can redistribute it and/or modify
  ~ it under the terms of the GNU General Public License as published by
  ~ the Free Software Foundation; either version 2 of the License, or (at
  ~ your option) any later version.
  ~
  ~ This program is distributed in the hope that it will be useful, but
  ~ WITHOUT ANY WARRANTY; without even the implied warranty of
  ~ MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  ~ General Public License for more details.
  ~
  ~ You should have received a copy of the GNU General Public License
  ~ along with this program; if not, write to the Free Software
  ~ Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA
  ~
  ~ Contact: Jeroen Ticheler - FAO - Viale delle Terme di Caracalla 2,
  ~ Rome - Italy. email: geonetwork@osgeo.org
  -->
<xsl:stylesheet version="2.0"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:dct="http://purl.org/dc/terms/"
                xmlns:dcat="http://www.w3.org/ns/dcat#">

    <xsl:template match="/">
      <xsl:variable name="isVirtualCatalog"
                    select="exists(rdf:RDF[not(//(dcat:Dataset|dcat:DataService|dcat:DatasetSeries))]/dcat:Catalog)"/>
      <uuid>
        <xsl:value-of select="if ($isVirtualCatalog)
                                           then rdf:RDF/dcat:Catalog/dcat:record/dcat:CatalogRecord[not(@rdf:about = ../dcat:Catalog/dcat:record/@rdf:resource)]/dct:identifier
                                           else rdf:RDF/dcat:Catalog/dcat:record/dcat:CatalogRecord/dct:identifier"/>
      </uuid>
  </xsl:template>

</xsl:stylesheet>
