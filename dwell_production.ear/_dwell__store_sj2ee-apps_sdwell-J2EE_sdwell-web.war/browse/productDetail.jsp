<%@ page isELIgnored="false" %>
<%@ taglib prefix="dsp" uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_1" %>
<dsp:page>
<link rel="stylesheet" href="${originatingRequest.contextPath}/css/styles.css" type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${originatingRequest.contextPath}/css/screen.css" type="text/css" media="screen" title="no title" charset="utf-8" />
<body class=" cms-index-index cms-home">
<div class="wrapper">
<div class="page">
<dsp:importbean bean="/atg/endeca/assembler/droplet/InvokeAssembler"/>
<dsp:importbean bean="/atg/commerce/catalog/ProductLookup"/>
<dsp:importbean bean="/DwellDroplet/DefaultSkuDroplet"/>
<dsp:importbean bean="/atg/commerce/order/purchase/CartModifierFormHandler" />
<dsp:include page="/includes/header.jsp" />
<dsp:getvalueof var="product" param="product_id"/>
 <script type="text/javascript">
var request;  
function priceDisplay()  
{  
var v=document.vinform.stage1.value;  
var p="${product}";
var url="multiSkuPriceDisplay.jsp?val="+v+"&prod="+p;  
  
if(window.XMLHttpRequest)
{  
request=new XMLHttpRequest();  
}  
else if(window.ActiveXObject)
{  
request=new ActiveXObject("Microsoft.XMLHTTP");  
}  
  
try  
{  
request.onreadystatechange=getInfo;  
request.open("GET",url,true);  
request.send();  
}  
catch(e)  
{  
alert("Unable to connect to server");  
}  
}  
window.onload = function() 
{
document.getElementsByName('stage1')[0].onchange();
}
function getInfo()
{  
if(request.readyState==4)
{  
var val=request.responseText;  
document.getElementById('selboxId').innerHTML=val; 
document.getElementById('image').src=val;

} 
} 
</script>
<dsp:droplet name="InvokeAssembler">
    <dsp:param name="contentCollection" value="/content/Shared/Header"/>
    <dsp:oparam name="output">
      <dsp:getvalueof var="headerContent" vartype="com.endeca.infront.assembler.ContentItem" param="contentItem" />
     
    </dsp:oparam>
    <dsp:oparam name="error">
    	Error Loading Page
    </dsp:oparam>
  </dsp:droplet>
  <dsp:getvalueof var="id" param="product_id"/>

<div class="main col1-layout">
	<div class="col-main">
		<dsp:droplet name="ProductLookup">
 			<dsp:param name="id" value="${id}"/>
 			<dsp:param value="product" name="elementName" />
    		<dsp:oparam name="empty">Product Inaccessible</dsp:oparam>
		<dsp:oparam name="output">
			<div class="product-view">
				<div class="product-essential">
					<div class="product-img-box">
						<div class="product-image">
							<dsp:getvalueof var="images" param="product.LargeImage.url" />
    						<img id="image" src="/dwellstore/${images}" />
    					</div>
    				</div>
    				<div class="product-shop">
						<div class="product-main-info">
							<div class="product-name">
    							<h1 id="registry-product-detailed-title" itemprop="name"><dsp:valueof param="product.displayName" /></h1>
    						</div>
    						<dsp:droplet name="DefaultSkuDroplet">
  								<dsp:param name="product" param="product"/>
  									<dsp:oparam name="output">
    									<div class="price-area">
    										<div class="price-box">
  												<dsp:include page="priceDisplay.jsp" >
     												<dsp:param name="sku" param="defaultSKU" />
     												<dsp:param name="product" param="product"/>
      											</dsp:include>
    										</div>
    									</div>
    									<dsp:form name="vinform" method="post">
  											<dsp:getvalueof var="childSKU" param="product.childSKUs" />
  											<c:choose>
  												<c:when test="${fn:length(childSKU) gt 1}">
  													<dsp:select bean="CartModifierFormHandler.catalogRefIds" onchange="priceDisplay()"   name="stage1" id="changeImage">
   														<c:forEach var="sku" items="${childSKU}">
   															<dsp:option value="${sku.repositoryId}"> ${sku.displayName}</dsp:option>
   														</c:forEach>
 													</dsp:select>
 													<span id="selboxId"> </span> 
 												</c:when>
 												<c:otherwise>
 													<dsp:input bean="CartModifierFormHandler.catalogRefIds" paramvalue="defaultSKU.id" type="hidden"/>
 												</c:otherwise>
											</c:choose>
    										<dsp:input bean="CartModifierFormHandler.productId" paramvalue="product.repositoryId" type="hidden" />
 											Quantity: <dsp:input bean="CartModifierFormHandler.quantity" name="quantity" size="3" value="1" type="text"/>
  											<dsp:input bean="CartModifierFormHandler.addItemToOrder" value="Add to Cart" type="submit"/>
											<dsp:input bean="CartModifierFormHandler.addItemToOrderSuccessURL" value="${originatingRequest.contextPath}/checkout/cart.jsp" type="hidden"/>
										</dsp:form>
    								</dsp:oparam>
    								<div id="desc" class="menu_body" style="display:block" itemprop="description">
    									<dsp:valueof param="product.description" />
    									<dsp:valueof param="product.longDescription" />
    								</div>
    							</dsp:droplet>
    						</div>
    					</div>
    				</div>
				</div>
			</dsp:oparam>
		</dsp:droplet>
	</div>
</div>
<dsp:include page="/includes/footer.jsp" />
</div>
</div>
</dsp:page>