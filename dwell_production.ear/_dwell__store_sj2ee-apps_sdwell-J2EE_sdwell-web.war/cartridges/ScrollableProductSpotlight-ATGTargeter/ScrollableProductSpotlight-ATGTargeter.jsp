<%--
  Renders a list of products within a Dojo horizontal scroller widget.
  The widget provides paging by means of previous and next buttons
  to move back/forward through sub pages of products. 

  Required parameters:
    contentItem
      The content item to render.
      
  Optional Parameters:
    none
--%>

<dsp:page>
  <dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
  <dsp:importbean bean="/atg/commerce/catalog/ProductLookup"/>
  <dsp:importbean bean="/atg/multisite/Site"/>
    <dsp:importbean bean="/atg/targeting/TargetingFirst"/>
    <dsp:importbean bean="/DwellDroplet/DefaultSkuDroplet"/>
  <dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}"/>
  <dsp:getvalueof var="itemsPerPage" value="5"  /> <%-- Hardcoded but the XMGR template can be updated to provide this --%>
  <dsp:getvalueof var="contextPath" vartype="java.lang.String" value="${originatingRequest.contextPath}"/>
  <c:set var="totalProducts" value="${fn:length(contentItem['atg:contents'].items)}"/>
  <c:set var="pagingAction" value="${contentItem.pagingActionTemplate.navigationState}" />
<div class="std">
<div class="category-products">
					<ul class="products-grid first odd">
  						<dsp:importbean bean="/atg/multisite/Site"/>
						<dsp:getvalueof bean="Site.id" var="siteID"/>
  						<dsp:droplet name="TargetingFirst">
  							<dsp:param name="targeter" bean="/atg/registry/RepositoryTargeters/FeaturedProduct" />
  							<dsp:param name="howMany" value="24" />
  							<dsp:oparam name="output">
  							<li class="item">
  								<dsp:getvalueof var="imgurl" param="element.LargeImage.url" />
  								<dsp:a class="product-image" href="/dwellstore/browse/productDetail.jsp">
  									<dsp:param name="product_id" param="element.id" />
  									<img src="${imgurl}" width="240" height="200" />
  								</dsp:a>
  								<h2 class="product-name">
  									<dsp:a href="/dwellstore/browse/productDetail.jsp"><dsp:param name="product_id" param="element.id" /><dsp:valueof param="element.DisplayName" /></dsp:a>
  								</h2>
  								<div class="product-price">
									<div class="price-box">
										<dsp:droplet name="DefaultSkuDroplet">
  											<dsp:param name="product" param="element"/>
  											<dsp:oparam name="output">
     											<span class="regular-price">
     												<dsp:include page="/browse/priceDisplay.jsp" >
     													<dsp:param name="sku" param="defaultSKU" />
      												</dsp:include>
      											</span>
      										</dsp:oparam>
     							 		</dsp:droplet>
     							 	</div>
     							 </div>
      							 <dsp:droplet name="/atg/commerce/multisite/SiteIdForCatalogItem">
   								 	<dsp:param name="item" param="element" />
   								 	<dsp:oparam name="output">
      							 		<%-- Store the site ID obtained by SiteIdForCatalogItem in a productSiteId variable. --%>
      							 		<dsp:getvalueof var="productSiteId" param="siteId" />
      							 	</dsp:oparam>
      							 </dsp:droplet>
      						 </li>
      						</dsp:oparam>
      						<dsp:oparam name="empty">
  								No Products
      						</dsp:oparam>
  						</dsp:droplet>
					</ul>
				</div>
</div>
</dsp:page>