<dsp:page>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="dsp" uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_1" %>
<dsp:importbean bean="/atg/userprofiling/Profile"/>
<dsp:importbean bean="/atg/commerce/pricing/priceLists/PriceDroplet" />
<html>
<head><title>sku price</title></head>
<body>
   

<% 
String sku= request.getParameter("val");
String product= request.getParameter("prod");
pageContext.setAttribute("sku", sku);
pageContext.setAttribute("product", product);
%>
<c:set var="sku" value="${sku}"/>
<c:set var="product" value="${product}"/>
<dsp:getvalueof var="sku" value="${sku}"/>
<dsp:getvalueof var="product" value="${product}" />


<c:if test="${empty sku}">
 <dsp:getvalueof var="childSKUs" param="product.childSKUs"/>
 <!-- <c:if test="${fn:length(childSKUs) eq 1}"> -->
      <dsp:getvalueof var="sku" value="${product.childSKUs[0]}"/>
   <!-- </c:if> -->
</c:if>

<dsp:droplet name="/atg/commerce/catalog/ProductLookup">
<dsp:param name="id" value="${product}"/>
<dsp:param value="product" name="elementName"/>
<dsp:oparam name="output">
 <dsp:getvalueof var="childSKUsId" param="product.childSKUs"/>
 <dsp:getvalueof var="skuId" value="${sku}"/>
 
 <dsp:droplet name="/atg/dynamo/droplet/ForEach">
<dsp:param name="array" param="product.childSKUs"/>
<dsp:param name="elementName" value="skuId"/>
<dsp:oparam name="output">
<dsp:getvalueof var="chSku" param="skuId.repositoryId"/>
<c:choose>
 <c:when test="${chSku==sku}">
 
 <dsp:getvalueof var="images" param="skuId.largeImage.url" />

    <img src="${images}" >
 </c:when>
 <c:otherwise>
 
 </c:otherwise>
 </c:choose>
</dsp:oparam>
</dsp:droplet>

</dsp:oparam>
</dsp:droplet>






<dsp:droplet name="PriceDroplet">
<dsp:param name="product" param="product"/>

<dsp:param name="sku" value="${sku}" />

<dsp:oparam name="output">
<dsp:setvalue param="theListPrice" paramvalue="price" />
<dsp:getvalueof var="profileSalePriceList" bean="Profile.salePriceList" />
<c:choose>
 <c:when test="${not empty profileSalePriceList}">
 
  <dsp:droplet name="PriceDroplet">
   <dsp:param name="priceList" bean="Profile.salePriceList" />
   <dsp:oparam name="output">
    <dsp:getvalueof var="salePrice" param="price.listPrice" vartype="java.lang.Double" />
    <br>
   <%-- Sale Price1:--%><b>Price:</b> <dsp:valueof converter="currency" value="${salePrice}"/> 
    <dsp:getvalueof var="price" param="theListPrice.listPrice" vartype="java.lang.Double" />

  <del><%-- List Price1:--%> <dsp:valueof converter="currency" value="${price}" /></del>
   </dsp:oparam>
   <dsp:oparam name="empty">
    <dsp:getvalueof var="price" param="theListPrice.listPrice" vartype="java.lang.Double" />
    
    <dsp:valueof converter="currency" value="${price}" />
   </dsp:oparam>
  </dsp:droplet>
  </c:when>
  <c:otherwise>
   <dsp:getvalueof var="price" param="theListPrice.listPrice" vartype="java.lang.Double" />
    <dsp:valueof converter="currency" value="${price}" />
  </c:otherwise>
</c:choose>

</dsp:oparam>

<dsp:oparam name="empty">
  <dsp:getvalueof var="saleprice" param="sku.salePrice" vartype="java.lang.Double"/>
  <dsp:valueof value="${saleprice}" />
  <dsp:getvalueof var="listprice" param="sku.listPrice" vartype="java.lang.Double"/>
  <dsp:valueof value="${listprice}" />
</dsp:oparam>
</dsp:droplet>



</body>
</html>
</dsp:page>
 