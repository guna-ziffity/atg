<dsp:page>
 
 <style>
 #section {
     background-color:#eeeeee;
}
</style>

<dsp:importbean bean="/atg/commerce/ShoppingCart"/>
<dsp:getvalueof var="commerceItems" bean="ShoppingCart.current.commerceItems"/>
<dsp:getvalueof var="order" bean="ShoppingCart.current" />
${order.priceInfo}
 <hr>
 
 
 
<div id="section">

<b>ORDER SUMMARY</b>	
</div>

<table cellpadding="5px" cellspacing="10px">
<tr>

<th>Product Name</th>
<th>Price</th>
<th>Quantity</th>
<th>Discount</th>
<th>Total</th>
</tr>

<dsp:droplet name="/atg/dynamo/droplet/ForEach">
<dsp:param name="array" value="${commerceItems}"/>
<dsp:setvalue param="currentItem" paramvalue="element" />
<dsp:oparam name="output">

<tr>

<dsp:getvalueof var="currentItem" param="currentItem"/>
<dsp:getvalueof var="product" value="${currentItem.auxiliaryData.productRef}" />
<dsp:getvalueof var="sku" value="${currentItem.auxiliaryData.catalogRef}" />

<td>${product.displayName}</td>
<td>
<dsp:getvalueof var="listPrice" vartype="java.lang.Double" param="currentItem.priceInfo.listPrice" />
<dsp:getvalueof var="salePrice" vartype="java.lang.Double" param="currentItem.priceInfo.salePrice" />
<dsp:getvalueof var="adjustment" vartype="java.lang.Double" param="currentItem.priceInfo.adjustments" />


<c:choose>
	<c:when test="${salePrice gt 0}">
		<del><dsp:valueof value="${listPrice}"/></del>
		<dsp:valueof value="${salePrice}"/>
	</c:when>
	<c:otherwise>
		<dsp:valueof value="${listPrice}"/>
	</c:otherwise>
	</c:choose>
</td>
<td>
	<dsp:valueof param="currentItem.quantity" /></td>
<td>
	<c:forEach var="discount" items="${adjustment}">
	<c:if test="${discount.adjustmentDescription eq 'Item Discount'}">
	${discount.totalAdjustment}
	</c:if>
	</c:forEach>
</td>

<td> 
	<dsp:valueof param="currentItem.priceInfo.amount" />
</td>

</tr>
</dsp:oparam>
</dsp:droplet>

<tr>
<td></td><td></td><td></td>
<th>Subtotal</th>
<td>

<dsp:valueof value="${order.priceInfo.rawSubtotal}"/>
</td>
</tr>

<c:if test="${order.priceInfo.discountAmount gt 0}">
 <tr>
<td></td><td></td><td></td>
<th>Order Discount</th>
<td>
<dsp:valueof value="${order.priceInfo.discountAmount}"/>
</td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>

</c:if>
<th>Shipping Amount</th>
<td>

<dsp:valueof converter="currency" bean="ShoppingCart.current.priceInfo.shipping" />
</td>
<th>Grand Total</th>
<td>

<dsp:valueof value="${order.priceInfo.total}"/>
</td>
</td>
</tr>

</table>


</dsp:page>