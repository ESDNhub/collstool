<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
  xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:mods="http://www.loc.gov/mods/v3"
  xmlns:oai_pmh="http://www.openarchives.org/OAI/2.0/" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="xs" version="2.0">
  <xsl:output indent="yes"/>
  <xsl:template match="/">

    <!-- Repox. -->
    <xsl:element name="repox">
      <xsl:variable name="total-grande"><xsl:value-of select="count(.//oai_pmh:record)"/></xsl:variable>
      <xsl:variable name="nyh-total">
        <xsl:call-template name="hosting-counts-inst">
          <xsl:with-param name="thehost">nyh</xsl:with-param>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="hrvh-total">
        <xsl:call-template name="hosting-counts-inst">
          <xsl:with-param name="thehost">hrvh</xsl:with-param>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="dcmny-total">
        <xsl:call-template name="hosting-counts-inst">
          <xsl:with-param name="thehost">dcmny</xsl:with-param>
        </xsl:call-template>
      </xsl:variable>
      <xsl:element name="total">
        <xsl:value-of select="$total-grande"/>
      </xsl:element>
      <xsl:element name="hosting-totals">
        <xsl:element name="nyh-total"><xsl:value-of select="$nyh-total"/></xsl:element>
        <xsl:element name="hrvh-total"><xsl:value-of select="$hrvh-total"/></xsl:element>
        <xsl:element name="dcmny-total"><xsl:value-of select="$dcmny-total"/></xsl:element>
        <xsl:element name="hosted-total">
          <xsl:value-of select="$dcmny-total + $hrvh-total + $nyh-total"/>
        </xsl:element>
        <xsl:element name="non-hosted-total"><xsl:value-of select="$total-grande - ($nyh-total+$hrvh-total+$dcmny-total)"/></xsl:element>
    </xsl:element>

      <!-- Repox/Council.-->
      <xsl:element name="councils">
        
        <!-- Other councils. -->
        <xsl:for-each-group select="//mods:mods" group-by="./mods:note[@type = 'regional council']">
          <xsl:sort select="current-grouping-key()"/>
          <xsl:element name="council">
            <xsl:element name="name">
              <xsl:value-of select="current-grouping-key()"/>
            </xsl:element>
            <xsl:variable name="council-total"><xsl:value-of select="count(current-group())"/></xsl:variable>
            <xsl:element name="total">
              <xsl:value-of select="$council-total"/>
            </xsl:element>
            <xsl:variable name="nyh-council-total">
              <xsl:call-template name="hosting-counts-council">
                <xsl:with-param name="thecouncil"><xsl:value-of select="current-grouping-key()"/></xsl:with-param>
                <xsl:with-param name="thehost">nyh</xsl:with-param>
              </xsl:call-template>
            </xsl:variable>
            <xsl:variable name="hrvh-council-total">
              <xsl:call-template name="hosting-counts-council">
                <xsl:with-param name="thecouncil"><xsl:value-of select="current-grouping-key()"/></xsl:with-param>
                <xsl:with-param name="thehost">hrvh</xsl:with-param>
              </xsl:call-template>
            </xsl:variable>
            <xsl:variable name="dcmny-council-total">
              <xsl:call-template name="hosting-counts-council">
                <xsl:with-param name="thecouncil"><xsl:value-of select="current-grouping-key()"/></xsl:with-param>
                <xsl:with-param name="thehost">dcmny</xsl:with-param>
              </xsl:call-template>
            </xsl:variable>
            <xsl:variable name="council-hosted-total" select="$dcmny-council-total + $hrvh-council-total + $nyh-council-total"/>
            <xsl:element name="hosting-totals">
              <xsl:element name="nyh-council-total"><xsl:value-of select="$nyh-council-total"/></xsl:element>
              <xsl:element name="hrvh-council-total"><xsl:value-of select="$hrvh-council-total"/></xsl:element>
              <xsl:element name="dcmny-council-total"><xsl:value-of select="$dcmny-council-total"/></xsl:element>
              <xsl:element name="council-hosted-total">
                <xsl:value-of select="$council-hosted-total"/>
              </xsl:element>
              <xsl:element name="non-hosted-total"><xsl:value-of select="$council-total - ($nyh-council-total+$hrvh-council-total+$dcmny-council-total)"/></xsl:element>
            </xsl:element>

            <!-- Orphaned institutions. -->
            <xsl:choose>
              <xsl:when test="current-grouping-key() = 'Metropolitan New York Library Council'">
                <xsl:call-template name="make_provider">
                  <xsl:with-param name="inst">Fordham University</xsl:with-param>
                </xsl:call-template>
                <xsl:call-template name="make_provider">
                  <xsl:with-param name="inst">American Jewish Joint Distribution Committee Archives</xsl:with-param>
                </xsl:call-template>
                <xsl:call-template name="make_provider">
                  <xsl:with-param name="inst">Harrison Public Library</xsl:with-param>
                </xsl:call-template>
                <xsl:call-template name="make_provider">
                  <xsl:with-param name="inst">Queens Borough Public Library</xsl:with-param>
                </xsl:call-template>
                <xsl:call-template name="make_provider">
                  <xsl:with-param name="inst">New York Philharmonic Leon Levy Digital Archives</xsl:with-param>
                </xsl:call-template>
              </xsl:when>
              <xsl:when test="current-grouping-key() = 'Rochester Regional Library Council'">
                <xsl:call-template name="make_provider">
                  <xsl:with-param name="inst">University of Rochester, River Campus Libraries</xsl:with-param>
                </xsl:call-template>
              </xsl:when>
              <xsl:when
                test="current-grouping-key() = 'Southeastern New York Library Resources Council'">
                <xsl:call-template name="make_provider">
                  <xsl:with-param name="inst">The Culinary Institute of America</xsl:with-param>
                </xsl:call-template>
                <xsl:call-template name="make_provider">
                  <xsl:with-param name="inst">Vassar College Libraries, Poughkeepsie, N.Y</xsl:with-param>
                </xsl:call-template>
              </xsl:when>
            </xsl:choose>

            <!-- Repox/Council/Provider. -->
            <xsl:for-each-group select="current-group()" group-by="./mods:note[@type = 'ownership']">
              <xsl:sort select="current-grouping-key()"/>
              <xsl:element name="provider">
                <xsl:element name="name">
                  <xsl:value-of select="current-grouping-key()"/>
                </xsl:element>
                <xsl:element name="total">
                  <xsl:value-of select="count(current-group())"/>
                </xsl:element>

                <!-- Repox/Council/Provider/Collection -->
                <xsl:choose>
                  <xsl:when
                    test="exists(./mods:relatedItem[@type = 'host' and @displayLabel = 'Sub-Collection']/mods:titleInfo/mods:title)">
                    <xsl:for-each-group select="current-group()"
                      group-by="./mods:relatedItem[@type = 'host' and @displayLabel = 'Sub-Collection']/mods:titleInfo/mods:title">
                      <xsl:sort select="current-grouping-key()"/>
                      <xsl:element name="coll">
                        <xsl:element name="name">
                          <xsl:value-of select="current-grouping-key()"/>
                        </xsl:element>
                        <xsl:element name="spec">
                          <xsl:value-of select="../../oai_pmh:header/oai_pmh:setSpec"/>
                        </xsl:element>
                        <xsl:element name="count">
                          <xsl:value-of select="count(current-group())"/>
                        </xsl:element>
                      </xsl:element>
                    </xsl:for-each-group>
                  </xsl:when>
                  <xsl:when
                    test="exists(./mods:relatedItem[@type = 'host' and @displayLabel = 'Collection']/mods:titleInfo/mods:title)">
                    <xsl:for-each-group select="current-group()"
                      group-by="./mods:relatedItem[@type = 'host' and @displayLabel = 'Collection']/mods:titleInfo/mods:title">
                      <xsl:sort select="current-grouping-key()"/>
                      <xsl:element name="coll">
                        <xsl:element name="name">
                          <xsl:value-of select="current-grouping-key()"/>
                        </xsl:element>
                        <xsl:element name="spec">
                          <xsl:value-of select="../../oai_pmh:header/oai_pmh:setSpec"/>
                        </xsl:element>
                        <xsl:element name="count">
                          <xsl:value-of select="count(current-group())"/>
                        </xsl:element>
                      </xsl:element>
                    </xsl:for-each-group>
                  </xsl:when>
                  <xsl:otherwise/>
                </xsl:choose>
              </xsl:element>
            </xsl:for-each-group>
          </xsl:element>
        </xsl:for-each-group>
        <!-- Govt Agencies. -->
        <xsl:element name="council">
          <xsl:variable name="nysl_total"><xsl:value-of
            select="count(//mods:mods[./mods:note[./text() = 'New York State Library']])"/></xsl:variable>
          <xsl:variable name="nysa_total"><xsl:value-of
            select="count(//mods:mods[./mods:note[./text() = 'New York State Archives']])"/></xsl:variable>
          <xsl:variable name="ga_total"><xsl:value-of select="$nysa_total + $nysl_total"/></xsl:variable>
          <xsl:element name="name">Government Agencies</xsl:element>
          <xsl:element name="total">
            <xsl:value-of
              select="$ga_total"/>
          </xsl:element>
          <xsl:element name="provider">
            <xsl:element name="name">New York State Library</xsl:element>
            <xsl:element name="total">
              <xsl:value-of
                select="$nysl_total"/>
            </xsl:element>
            <xsl:for-each-group
              select="//mods:mods[./mods:note[./text() = 'New York State Library']]"
              group-by="./mods:relatedItem[@type = 'host' and @displayLabel = 'Collection']/mods:titleInfo/mods:title">
              <xsl:sort select="current-grouping-key()"/>
              <xsl:element name="coll">
                <xsl:element name="name">
                  <xsl:value-of select="current-grouping-key()"/>
                </xsl:element>
                <xsl:element name="spec">
                  <xsl:value-of select="../../oai_pmh:header/oai_pmh:setSpec"/>
                </xsl:element>
                <xsl:element name="count">
                  <xsl:value-of select="count(current-group())"/>
                </xsl:element>
              </xsl:element>
            </xsl:for-each-group>
          </xsl:element>
          <xsl:element name="provider">
            <xsl:element name="name">New York State Archives</xsl:element>
            <xsl:element name="total">
              <xsl:value-of
                select="$nysa_total"/>
            </xsl:element>
            <xsl:for-each-group
              select="//mods:mods[./mods:note[./text() = 'New York State Archives']]"
              group-by="./mods:relatedItem[@type = 'host' and @displayLabel = 'Collection']/mods:titleInfo/mods:title">
              <xsl:sort select="current-grouping-key()"/>
              <xsl:element name="coll">
                <xsl:element name="name">
                  <xsl:value-of select="current-grouping-key()"/>
                </xsl:element>
                <xsl:element name="spec">
                  <xsl:value-of select="../../oai_pmh:header/oai_pmh:setSpec"/>
                </xsl:element>
                <xsl:element name="count">
                  <xsl:value-of select="count(current-group())"/>
                </xsl:element>
              </xsl:element>
            </xsl:for-each-group>
          </xsl:element>
        </xsl:element>
      </xsl:element>

      <!-- Repox/Owners -->
      <xsl:element name="owners">
        <xsl:for-each-group select="//mods:mods" group-by="./mods:note[@type = 'ownership']">
          <xsl:sort select="current-grouping-key()"/>
          <xsl:variable name="inst_total"><xsl:value-of select="count(current-group())"/></xsl:variable>
          <xsl:element name="owner">
            <xsl:element name="name">
              <xsl:value-of select="current-grouping-key()"/>
            </xsl:element>
            <xsl:element name="total">
              <xsl:value-of select="$inst_total"/>
            </xsl:element>
            <xsl:variable name="nyh-total">
              <xsl:call-template name="hosting-counts-inst">
                <xsl:with-param name="thehost">nyh</xsl:with-param>
              </xsl:call-template>
            </xsl:variable>
            <xsl:variable name="hrvh-total">
              <xsl:call-template name="hosting-counts-inst">
                <xsl:with-param name="thehost">hrvh</xsl:with-param>
              </xsl:call-template>
            </xsl:variable>
            <xsl:variable name="dcmny-total">
              <xsl:call-template name="hosting-counts-inst">
                <xsl:with-param name="thehost">dcmny</xsl:with-param>
              </xsl:call-template>
            </xsl:variable>
            <xsl:element name="hosting-totals">
              <xsl:element name="nyh-total"><xsl:value-of select="$nyh-total"/></xsl:element>
              <xsl:element name="hrvh-total"><xsl:value-of select="$hrvh-total"/></xsl:element>
              <xsl:element name="dcmny-total"><xsl:value-of select="$dcmny-total"/></xsl:element>
              <xsl:element name="hosted-total">
                <xsl:value-of select="$dcmny-total + $hrvh-total + $nyh-total"/>
              </xsl:element>
              <xsl:element name="non-hosted-total"><xsl:value-of select="$inst_total - ($nyh-total+$hrvh-total+$dcmny-total)"/></xsl:element>
            </xsl:element>            
            <xsl:element name="council">
              <xsl:value-of select="./mods:note[@type = 'regional council']"/>
            </xsl:element>
            <!-- Repox/Owner/Collection -->
            <xsl:choose>
              <xsl:when
                test="exists(./mods:relatedItem[@type = 'host' and @displayLabel = 'Sub-Collection']/mods:titleInfo/mods:title)">
                <xsl:for-each-group select="current-group()"
                  group-by="./mods:relatedItem[@type = 'host' and @displayLabel = 'Sub-Collection']/mods:titleInfo/mods:title">
                  <xsl:sort select="current-grouping-key()"/>
                  <xsl:element name="coll">
                    <xsl:element name="name">
                      <xsl:value-of select="current-grouping-key()"/>
                    </xsl:element>
                    <xsl:element name="spec">
                      <xsl:value-of select="../../oai_pmh:header/oai_pmh:setSpec"/>
                    </xsl:element>
                    <xsl:element name="total">
                      <xsl:value-of select="count(current-group())"/>
                    </xsl:element>
                  </xsl:element>
                </xsl:for-each-group>
              </xsl:when>
              <xsl:when
                test="exists(./mods:relatedItem[@type = 'host' and @displayLabel = 'Collection']/mods:titleInfo/mods:title)">
                <xsl:for-each-group select="current-group()"
                  group-by="./mods:relatedItem[@type = 'host' and @displayLabel = 'Collection']/mods:titleInfo/mods:title">
                  <xsl:sort select="current-grouping-key()"/>
                  <xsl:element name="coll">
                    <xsl:element name="name">
                      <xsl:value-of select="current-grouping-key()"/>
                    </xsl:element>
                    <xsl:element name="spec">
                      <xsl:value-of select="../../oai_pmh:header/oai_pmh:setSpec"/>
                    </xsl:element>
                    <xsl:element name="total">
                      <xsl:value-of select="count(current-group())"/>
                    </xsl:element>
                  </xsl:element>
                </xsl:for-each-group>
              </xsl:when>
              <xsl:otherwise/>
            </xsl:choose>
          </xsl:element>
        </xsl:for-each-group>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <xsl:template name="make_provider">
    <xsl:param name="inst"/>

    <xsl:element name="provider">
      <xsl:element name="name">
        <xsl:value-of select="$inst"/>
      </xsl:element>
      <xsl:element name="total">
        <xsl:value-of
          select="count(//mods:mods[mods:note[@type = 'ownership'][./text() = $inst/text()]])"/>
      </xsl:element>

      <xsl:for-each-group
        select="//mods:mods[mods:note[@type = 'ownership'][./text() = $inst/text()]]"
        group-by="./mods:note[@type = 'ownership']">
        <xsl:choose>
          <xsl:when
            test="exists(./mods:relatedItem[@type = 'host' and @displayLabel = 'Sub-Collection']/mods:titleInfo/mods:title)">
            <xsl:for-each-group select="current-group()"
              group-by="./mods:relatedItem[@type = 'host' and @displayLabel = 'Sub-Collection']/mods:titleInfo/mods:title">
              <xsl:element name="coll">
                <xsl:element name="name">
                  <xsl:value-of select="current-grouping-key()"/>
                </xsl:element>
                <xsl:element name="spec">
                  <xsl:value-of select="../../oai_pmh:header/oai_pmh:setSpec"/>
                </xsl:element>
                <xsl:element name="count">
                  <xsl:value-of select="count(current-group())"/>
                </xsl:element>
              </xsl:element>
            </xsl:for-each-group>
          </xsl:when>
          <xsl:when
            test="exists(./mods:relatedItem[@type = 'host' and @displayLabel = 'Collection']/mods:titleInfo/mods:title)">
            <xsl:for-each-group select="current-group()"
              group-by="./mods:relatedItem[@type = 'host' and @displayLabel = 'Collection']/mods:titleInfo/mods:title">
              <xsl:element name="coll">
                <xsl:element name="name">
                  <xsl:value-of select="current-grouping-key()"/>
                </xsl:element>
                <xsl:element name="spec">
                  <xsl:value-of select="../../oai_pmh:header/oai_pmh:setSpec"/>
                </xsl:element>
                <xsl:element name="count">
                  <xsl:value-of select="count(current-group())"/>
                </xsl:element>
              </xsl:element>
            </xsl:for-each-group>
          </xsl:when>
          <xsl:otherwise/>
        </xsl:choose>
      </xsl:for-each-group>
    </xsl:element>
  </xsl:template>

  <xsl:template name="hosting-counts-inst">
    <xsl:param name="thehost"/>
    <xsl:variable name="hosts">
      <host key="nyh">olean public library</host>
      <host key="nyh">syracuse polish home</host>
      <host key="nyh">mcgraw historical society</host>
      <host key="nyh">erieville-nelson heritage society</host>
      <host key="nyh">hobart and william smith colleges</host>
      <host key="nyh">clifton park-halfmoon public library</host>
      <host key="nyh">hofstra university</host>
      <host key="nyh">remsen steuben historical society</host>
      <host key="nyh">hamilton public library</host>
      <host key="nyh">capital district library council</host>
      <host key="nyh">the college of saint rose</host>
      <host key="nyh">hudson valley community college</host>
      <host key="nyh">suny college of environmental science and forestry</host>
      <host key="nyh">corning community college</host>
      <host key="nyh">erie community college</host>
      <host key="nyh">d'youville college</host>
      <host key="nyh">onondaga county public library-local history &amp; genealogy department</host>
      <host key="nyh">albany public library</host>
      <host key="nyh">elmira college</host>
      <host key="nyh">ithaca college</host>
      <host key="nyh">buffalo and erie county public library</host>
      <host key="nyh">misci</host>
      <host key="nyh">dewitt community library</host>
      <host key="nyh">genesee community college</host>
      <host key="nyh">university at buffalo</host>
      <host key="nyh">onondaga community college</host>
      <host key="nyh">wells college</host>
      <host key="nyh">suny plattsburgh</host>
      <host key="nyh">chautaqua county historical society</host>
      <host key="nyh">suny fredonia</host>
      <host key="nyh">siena college</host>
      <host key="nyh">maria college</host>
      <host key="nyh">highland hospital</host>
      <host key="nyh">memorial art gallery of the university of rochester</host>
      <host key="nyh">american pomeroy historic genealogical association</host>
      <host key="nyh">university of rochester medical center, eastman institute for oral
        health</host>
      <host key="nyh">suny geneseo</host>
      <host key="nyh">dunham public library</host>
      <host key="nyh">salina free library</host>
      <host key="nyh">rochester museum &amp; science center</host>
      <host key="nyh">mundy branch library</host>
      <host key="nyh">adirondack architectural heritage collection</host>
      <host key="nyh">the history center in tompkins county</host>
      <host key="nyh">saratoga springs public library</host>
      <host key="nyh">tupper lake public library</host>
      <host key="nyh">the sage colleges</host>
      <host key="nyh">appellate division, fourth department law library</host>
      <host key="nyh">fort plains free library</host>
      <host key="nyh">solvay-geddes historical society</host>
      <host key="nyh">herschell carrousel factory museum</host>
      <host key="nyh">erie canal museum</host>
      <host key="nyh">watertown flower memorial library</host>
      <host key="nyh">liverpool public library</host>
      <host key="nyh">utica public library</host>
      <host key="nyh">mendon public library</host>
      <host key="nyh">niagara county historical society</host>
      <host key="nyh">henrietta public library</host>
      <host key="nyh">albany law school</host>
      <host key="nyh">sardinia historical society</host>
      <host key="nyh">buffalo museum of science</host>
      <host key="nyh">oneida public library</host>
      <host key="nyh">jewish buffalo archives project</host>
      <host key="nyh">skaneateles library association</host>
      <host key="nyh">geneva public library</host>
      <host key="nyh">town of ballston community library</host>
      <host key="nyh">fulton-montgomery community college</host>
      <host key="nyh">st. lawrence-lewis school library system collection</host>
      <host key="nyh">altamont free library</host>
      <host key="nyh">cazenovia college</host>
      <host key="nyh">niagara university</host>
      <host key="nyh">newark public library</host>
      <host key="nyh">fayetteville free library</host>
      <host key="nyh">buffalo niagara heritage village</host>
      <host key="nyh">geneva historical society</host>
      <host key="nyh">the buffalo history museum-buffalo address book and family directory</host>
      <host key="nyh">bethlehem public library</host>
      <host key="nyh">the buffalo history museum</host>
      <host key="nyh">nioga library system</host>
      <host key="nyh">middleburgh library</host>
      <host key="nyh">dudley observatory</host>
      <host key="nyh">rochester public library</host>
      <host key="nyh">waterville public library</host>
      <host key="nyh">center for inquiry libraries</host>
      <host key="nyh">alfred university</host>
      <host key="nyh">freeport memorial library</host>
      <host key="nyh">buffalo and erie county public library-buffalo city directories</host>
      <host key="nyh">central new york library resources council</host>
      <host key="nyh">canastota public library</host>
      <host key="nyh">steinmetz digital collection of schenectady</host>
      <host key="nyh">new york state military museum</host>
      <host key="nyh">buffalo olmsted parks conservancy</host>
      <host key="nyh">suny upstate medical university</host>
      <host key="nyh">skaneateles historical society</host>
      <host key="hrvh">newburgh free library</host>
      <host key="hrvh">hudson river valley institute</host>
      <host key="hrvh">cornwall public library</host>
      <host key="hrvh">franklin d. roosevelt library</host>
      <host key="hrvh">palisades interstate park commission</host>
      <host key="hrvh">wilderstein historic site</host>
      <host key="hrvh">nyack library</host>
      <host key="hrvh">marlboro free library</host>
      <host key="hrvh">scarsdale public library</host>
      <host key="hrvh">vassar brothers medical center</host>
      <host key="hrvh">suny new paltz</host>
      <host key="hrvh">library association of rockland county</host>
      <host key="hrvh">historic huguenot street</host>
      <host key="hrvh">chester historical society</host>
      <host key="hrvh">ellenville public library &amp; museum</host>
      <host key="hrvh">bard college</host>
      <host key="dcmny">wcs library</host>
      <host key="dcmny">wcs and nybg libraries</host>
      <host key="dcmny">wildlife conservation society archives</host>
      <host key="dcmny">whitney museum library</host>
      <host key="dcmny">wcs library</host>
      <host key="dcmny">white plains public library-white plains collection</host>
      <host key="dcmny">new york academy of medicine</host>
      <host key="dcmny">brooklyn public library</host>
      <host key="dcmny">new-york historical society</host>
    </xsl:variable>
    <xsl:for-each-group
      select="//mods:mods[lower-case(./mods:note[@type = 'ownership']/text()) = $hosts/host[@key = $thehost]]"
      group-by="$thehost">
      <xsl:value-of select="count(current-group())"/>
    </xsl:for-each-group>
  </xsl:template>


  <xsl:template name="hosting-counts-per-inst">
    <xsl:param name="the_inst"/>
    <xsl:param name="thehost"/>
    <xsl:variable name="hosts">
      <host key="nyh">olean public library</host>
      <host key="nyh">syracuse polish home</host>
      <host key="nyh">mcgraw historical society</host>
      <host key="nyh">erieville-nelson heritage society</host>
      <host key="nyh">hobart and william smith colleges</host>
      <host key="nyh">clifton park-halfmoon public library</host>
      <host key="nyh">hofstra university</host>
      <host key="nyh">remsen steuben historical society</host>
      <host key="nyh">hamilton public library</host>
      <host key="nyh">capital district library council</host>
      <host key="nyh">the college of saint rose</host>
      <host key="nyh">hudson valley community college</host>
      <host key="nyh">suny college of environmental science and forestry</host>
      <host key="nyh">corning community college</host>
      <host key="nyh">erie community college</host>
      <host key="nyh">d'youville college</host>
      <host key="nyh">onondaga county public library-local history &amp; genealogy department</host>
      <host key="nyh">albany public library</host>
      <host key="nyh">elmira college</host>
      <host key="nyh">ithaca college</host>
      <host key="nyh">buffalo and erie county public library</host>
      <host key="nyh">misci</host>
      <host key="nyh">dewitt community library</host>
      <host key="nyh">genesee community college</host>
      <host key="nyh">university at buffalo</host>
      <host key="nyh">onondaga community college</host>
      <host key="nyh">wells college</host>
      <host key="nyh">suny plattsburgh</host>
      <host key="nyh">chautaqua county historical society</host>
      <host key="nyh">suny fredonia</host>
      <host key="nyh">siena college</host>
      <host key="nyh">maria college</host>
      <host key="nyh">highland hospital</host>
      <host key="nyh">memorial art gallery of the university of rochester</host>
      <host key="nyh">american pomeroy historic genealogical association</host>
      <host key="nyh">university of rochester medical center, eastman institute for oral
        health</host>
      <host key="nyh">suny geneseo</host>
      <host key="nyh">dunham public library</host>
      <host key="nyh">salina free library</host>
      <host key="nyh">rochester museum &amp; science center</host>
      <host key="nyh">mundy branch library</host>
      <host key="nyh">adirondack architectural heritage collection</host>
      <host key="nyh">the history center in tompkins county</host>
      <host key="nyh">saratoga springs public library</host>
      <host key="nyh">tupper lake public library</host>
      <host key="nyh">the sage colleges</host>
      <host key="nyh">appellate division, fourth department law library</host>
      <host key="nyh">fort plains free library</host>
      <host key="nyh">solvay-geddes historical society</host>
      <host key="nyh">herschell carrousel factory museum</host>
      <host key="nyh">erie canal museum</host>
      <host key="nyh">watertown flower memorial library</host>
      <host key="nyh">liverpool public library</host>
      <host key="nyh">utica public library</host>
      <host key="nyh">mendon public library</host>
      <host key="nyh">niagara county historical society</host>
      <host key="nyh">henrietta public library</host>
      <host key="nyh">albany law school</host>
      <host key="nyh">sardinia historical society</host>
      <host key="nyh">buffalo museum of science</host>
      <host key="nyh">oneida public library</host>
      <host key="nyh">jewish buffalo archives project</host>
      <host key="nyh">skaneateles library association</host>
      <host key="nyh">geneva public library</host>
      <host key="nyh">town of ballston community library</host>
      <host key="nyh">fulton-montgomery community college</host>
      <host key="nyh">st. lawrence-lewis school library system collection</host>
      <host key="nyh">altamont free library</host>
      <host key="nyh">cazenovia college</host>
      <host key="nyh">niagara university</host>
      <host key="nyh">newark public library</host>
      <host key="nyh">fayetteville free library</host>
      <host key="nyh">buffalo niagara heritage village</host>
      <host key="nyh">geneva historical society</host>
      <host key="nyh">the buffalo history museum-buffalo address book and family directory</host>
      <host key="nyh">bethlehem public library</host>
      <host key="nyh">the buffalo history museum</host>
      <host key="nyh">nioga library system</host>
      <host key="nyh">middleburgh library</host>
      <host key="nyh">dudley observatory</host>
      <host key="nyh">rochester public library</host>
      <host key="nyh">waterville public library</host>
      <host key="nyh">center for inquiry libraries</host>
      <host key="nyh">alfred university</host>
      <host key="nyh">freeport memorial library</host>
      <host key="nyh">buffalo and erie county public library-buffalo city directories</host>
      <host key="nyh">central new york library resources council</host>
      <host key="nyh">canastota public library</host>
      <host key="nyh">steinmetz digital collection of schenectady</host>
      <host key="nyh">new york state military museum</host>
      <host key="nyh">buffalo olmsted parks conservancy</host>
      <host key="nyh">suny upstate medical university</host>
      <host key="nyh">skaneateles historical society</host>
      <host key="hrvh">newburgh free library</host>
      <host key="hrvh">hudson river valley institute</host>
      <host key="hrvh">cornwall public library</host>
      <host key="hrvh">franklin d. roosevelt library</host>
      <host key="hrvh">palisades interstate park commission</host>
      <host key="hrvh">wilderstein historic site</host>
      <host key="hrvh">nyack library</host>
      <host key="hrvh">marlboro free library</host>
      <host key="hrvh">scarsdale public library</host>
      <host key="hrvh">vassar brothers medical center</host>
      <host key="hrvh">suny new paltz</host>
      <host key="hrvh">library association of rockland county</host>
      <host key="hrvh">historic huguenot street</host>
      <host key="hrvh">chester historical society</host>
      <host key="hrvh">ellenville public library &amp; museum</host>
      <host key="hrvh">bard college</host>
      <host key="dcmny">wcs library</host>
      <host key="dcmny">wcs and nybg libraries</host>
      <host key="dcmny">wildlife conservation society archives</host>
      <host key="dcmny">whitney museum library</host>
      <host key="dcmny">wcs library</host>
      <host key="dcmny">white plains public library-white plains collection</host>
      <host key="dcmny">new york academy of medicine</host>
      <host key="dcmny">brooklyn public library</host>
      <host key="dcmny">new-york historical society</host>
    </xsl:variable>
    <xsl:for-each-group
      select="//mods:mods[lower-case(./mods:note[@type = 'ownership']/text()) = $hosts/host[@key = $thehost]]"
      group-by="$thehost">
      <xsl:value-of select="count(current-group())"/>
    </xsl:for-each-group>
  </xsl:template>

  <xsl:template name="hosting-counts-council">
    <xsl:param name="thecouncil"/>
    <xsl:param name="thehost"/>
    <xsl:variable name="hosts">
      <host key="nyh">olean public library</host>
      <host key="nyh">syracuse polish home</host>
      <host key="nyh">mcgraw historical society</host>
      <host key="nyh">erieville-nelson heritage society</host>
      <host key="nyh">hobart and william smith colleges</host>
      <host key="nyh">clifton park-halfmoon public library</host>
      <host key="nyh">hofstra university</host>
      <host key="nyh">remsen steuben historical society</host>
      <host key="nyh">hamilton public library</host>
      <host key="nyh">capital district library council</host>
      <host key="nyh">the college of saint rose</host>
      <host key="nyh">hudson valley community college</host>
      <host key="nyh">suny college of environmental science and forestry</host>
      <host key="nyh">corning community college</host>
      <host key="nyh">erie community college</host>
      <host key="nyh">d'youville college</host>
      <host key="nyh">onondaga county public library-local history &amp; genealogy department</host>
      <host key="nyh">albany public library</host>
      <host key="nyh">elmira college</host>
      <host key="nyh">ithaca college</host>
      <host key="nyh">buffalo and erie county public library</host>
      <host key="nyh">misci</host>
      <host key="nyh">dewitt community library</host>
      <host key="nyh">genesee community college</host>
      <host key="nyh">university at buffalo</host>
      <host key="nyh">onondaga community college</host>
      <host key="nyh">wells college</host>
      <host key="nyh">suny plattsburgh</host>
      <host key="nyh">chautaqua county historical society</host>
      <host key="nyh">suny fredonia</host>
      <host key="nyh">siena college</host>
      <host key="nyh">maria college</host>
      <host key="nyh">highland hospital</host>
      <host key="nyh">memorial art gallery of the university of rochester</host>
      <host key="nyh">american pomeroy historic genealogical association</host>
      <host key="nyh">university of rochester medical center, eastman institute for oral
        health</host>
      <host key="nyh">suny geneseo</host>
      <host key="nyh">dunham public library</host>
      <host key="nyh">salina free library</host>
      <host key="nyh">rochester museum &amp; science center</host>
      <host key="nyh">mundy branch library</host>
      <host key="nyh">adirondack architectural heritage collection</host>
      <host key="nyh">the history center in tompkins county</host>
      <host key="nyh">saratoga springs public library</host>
      <host key="nyh">tupper lake public library</host>
      <host key="nyh">the sage colleges</host>
      <host key="nyh">appellate division, fourth department law library</host>
      <host key="nyh">fort plains free library</host>
      <host key="nyh">solvay-geddes historical society</host>
      <host key="nyh">herschell carrousel factory museum</host>
      <host key="nyh">erie canal museum</host>
      <host key="nyh">watertown flower memorial library</host>
      <host key="nyh">liverpool public library</host>
      <host key="nyh">utica public library</host>
      <host key="nyh">mendon public library</host>
      <host key="nyh">niagara county historical society</host>
      <host key="nyh">henrietta public library</host>
      <host key="nyh">albany law school</host>
      <host key="nyh">sardinia historical society</host>
      <host key="nyh">buffalo museum of science</host>
      <host key="nyh">oneida public library</host>
      <host key="nyh">jewish buffalo archives project</host>
      <host key="nyh">skaneateles library association</host>
      <host key="nyh">geneva public library</host>
      <host key="nyh">town of ballston community library</host>
      <host key="nyh">fulton-montgomery community college</host>
      <host key="nyh">st. lawrence-lewis school library system collection</host>
      <host key="nyh">altamont free library</host>
      <host key="nyh">cazenovia college</host>
      <host key="nyh">niagara university</host>
      <host key="nyh">newark public library</host>
      <host key="nyh">fayetteville free library</host>
      <host key="nyh">buffalo niagara heritage village</host>
      <host key="nyh">geneva historical society</host>
      <host key="nyh">the buffalo history museum-buffalo address book and family directory</host>
      <host key="nyh">bethlehem public library</host>
      <host key="nyh">the buffalo history museum</host>
      <host key="nyh">nioga library system</host>
      <host key="nyh">middleburgh library</host>
      <host key="nyh">dudley observatory</host>
      <host key="nyh">rochester public library</host>
      <host key="nyh">waterville public library</host>
      <host key="nyh">center for inquiry libraries</host>
      <host key="nyh">alfred university</host>
      <host key="nyh">freeport memorial library</host>
      <host key="nyh">buffalo and erie county public library-buffalo city directories</host>
      <host key="nyh">central new york library resources council</host>
      <host key="nyh">canastota public library</host>
      <host key="nyh">steinmetz digital collection of schenectady</host>
      <host key="nyh">new york state military museum</host>
      <host key="nyh">buffalo olmsted parks conservancy</host>
      <host key="nyh">suny upstate medical university</host>
      <host key="nyh">skaneateles historical society</host>
      <host key="hrvh">newburgh free library</host>
      <host key="hrvh">hudson river valley institute</host>
      <host key="hrvh">cornwall public library</host>
      <host key="hrvh">franklin d. roosevelt library</host>
      <host key="hrvh">palisades interstate park commission</host>
      <host key="hrvh">wilderstein historic site</host>
      <host key="hrvh">nyack library</host>
      <host key="hrvh">marlboro free library</host>
      <host key="hrvh">scarsdale public library</host>
      <host key="hrvh">vassar brothers medical center</host>
      <host key="hrvh">suny new paltz</host>
      <host key="hrvh">library association of rockland county</host>
      <host key="hrvh">historic huguenot street</host>
      <host key="hrvh">chester historical society</host>
      <host key="hrvh">ellenville public library &amp; museum</host>
      <host key="hrvh">bard college</host>
      <host key="dcmny">wcs library</host>
      <host key="dcmny">wcs and nybg libraries</host>
      <host key="dcmny">wildlife conservation society archives</host>
      <host key="dcmny">whitney museum library</host>
      <host key="dcmny">wcs library</host>
      <host key="dcmny">white plains public library-white plains collection</host>
      <host key="dcmny">new york academy of medicine</host>
      <host key="dcmny">brooklyn public library</host>
      <host key="dcmny">new-york historical society</host>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="exists(//mods:mods[(./mods:note[@type='regional council']=$thecouncil) and (lower-case(./mods:note[@type = 'ownership']/text()) = $hosts/host[@key = $thehost])])">
        <xsl:for-each-group
          select="//mods:mods[(./mods:note[@type='regional council']=$thecouncil) and (lower-case(./mods:note[@type = 'ownership']/text()) = $hosts/host[@key = $thehost])]"
          group-by="$thehost">
          <xsl:value-of select="count(current-group())"/>
        </xsl:for-each-group>
      </xsl:when>
      <xsl:otherwise>0</xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>
