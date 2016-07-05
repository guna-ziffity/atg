<dsp:page>
<link rel="stylesheet" href="/dwellstore/css/styles.css" type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="/dwellstore/css/screen.css" type="text/css" media="screen" title="no title" charset="utf-8" />
<body class=" cms-index-index cms-home">
<div class="wrapper">
<div class="page">
<dsp:importbean bean="/OriginatingRequest" var="originatingRequest"/>
<dsp:importbean bean="/atg/endeca/assembler/droplet/InvokeAssembler"/>
<dsp:importbean bean="/atg/commerce/catalog/ProductLookup"/>
<dsp:importbean bean="/DwellDroplet/DefaultSkuDroplet" />
<dsp:getvalueof var="content" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}"/> 
  <dsp:droplet name="InvokeAssembler">
    <dsp:param name="contentCollection" value="/content/Web/Browse"/>
    <dsp:oparam name="output">
      <dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" param="contentItem" />  
      
    </dsp:oparam>
    <dsp:oparam name="error">
     Error Loading Page
    </dsp:oparam>
  </dsp:droplet>

<dsp:include page="/includes/header.jsp" />
<div class="main col1-layout">
<div class="col-main">
<div class="std">
<div class="category-products">
<ul class="products-grid first odd">
 <c:forEach var="content" items="${contentItem.contents}">
 <c:forEach var="record" items="${content.Results.records}">

 <dsp:droplet name="ProductLookup">
 <dsp:param name="id" value="${record.attributes['product.repositoryId']}"/>
<dsp:param value="product" name="elementName" /> 
 <dsp:oparam name="output"><br>
    <li class="item">
    <dsp:a href="/dwellstore/browse/productDetail.jsp">
    <dsp:param name="product_id" param="product.id" />
 <dsp:getvalueof var="img" param="product.LargeImage.URL" />
 <img src="/dwellstore/${img}" width="240" height="200" />
<h2 class="product-name"><dsp:valueof param="product.displayname"/></h2>
 <!--<p><dsp:valueof param="product.description"/></p>-->
	<div class="product-price">
  		<div class="price-box">
    		<dsp:droplet name="DefaultSkuDroplet">
  				<dsp:param name="product" param="product"/>
  				<dsp:oparam name="output">
     				<dsp:include page="/browse/priceDisplay.jsp" >
     					<dsp:param name="sku" param="defaultSKU" />
     					<dsp:param name="product" param="product"/>
      				</dsp:include>
    			</dsp:oparam>
    		</dsp:droplet>
    	</div>
    </div>
    </dsp:a>
 </li>
</dsp:oparam> 
<dsp:oparam name="empty">
  Shopping Cart Is Empty
</dsp:oparam>
 </dsp:droplet>

 </c:forEach>

 <!-- <dsp:renderContentItem contentItem="${content.HeaderContent}" /> -->

</c:forEach>
</ul>
</div>
</div>
 </div>
</div>
      <dsp:include page="/includes/footer.jsp" />
</div>
</body>
</dsp:page>