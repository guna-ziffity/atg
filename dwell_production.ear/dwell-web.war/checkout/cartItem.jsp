<dsp:page>
<div class="cart">
<dsp:importbean bean="/atg/endeca/assembler/droplet/InvokeAssembler"/>
<dsp:importbean bean="/atg/commerce/order/purchase/CartModifierFormHandler" />
<dsp:importbean bean="/OriginatingRequest" var="originatingRequest"/>
<dsp:importbean bean="/atg/commerce/ShoppingCart"/>
<dsp:importbean bean="/DwellDroplet/DefaultSkuDroplet" />

<dsp:droplet name="InvokeAssembler">
    <dsp:param name="contentCollection" value="/content/Shared/Header"/>
    <dsp:oparam name="output">
      <dsp:getvalueof var="headerContent" vartype="com.endeca.infront.assembler.ContentItem" param="contentItem" />
     
    </dsp:oparam>
    <dsp:oparam name="error">
    	Error Loading Page
    </dsp:oparam>
  </dsp:droplet>

<dsp:form>
<fieldset>
<table id="shopping-cart-table" class="data-table cart-table" >
<thead>
<tr class="first last">
<th rowspan="1"> </th>
<th rowspan="1"><span class="nobr">Product Name</span></th>
<th class="a-center" colspan="1"><span class="nobr">Item Price</span></th>
<th class="a-center" rowspan="1">Quantity</th>
<th width="1" rowspan="1">Discount</th>
<th class="a-center" width="150px" colspan="1">Total</th>
</tr>
</thead>
<tfoot>
<tr class="first last">
<td class="a-right last" colspan="50">
<dsp:input bean="CartModifierFormHandler.setOrder" type="submit"
value="Update Shopping Cart"/>
</td>
</tr>
</tfoot>
<dsp:droplet name="/atg/dynamo/droplet/ForEach">
<dsp:param name="array" param="commerceItems"/>
<dsp:setvalue param="currentItem" paramvalue="element" />
<dsp:oparam name="output">
<dsp:getvalueof var="currentItem" param="currentItem"/>
<dsp:getvalueof var="product" value="${currentItem.auxiliaryData.productRef}" />

<tbody>
<tr class="first odd">
<td></td>
<td><h2 class="product-name">${product.displayName}</h2></td>
<td class="a-right">
<span class="cart-price">
<dsp:getvalueof var="listPrice" vartype="java.lang.Double" param="currentItem.priceInfo.listPrice" />
<dsp:getvalueof var="salePrice" vartype="java.lang.Double" param="currentItem.priceInfo.salePrice" />

 <c:choose>
 <c:when test="${salePrice gt 0}">
  <del><dsp:valueof value="${listPrice}"/></del>
  <span class="price"><dsp:valueof value="${salePrice}"/></span>
 </c:when>
 <c:otherwise>
  <span class="price"><dsp:valueof value="${listPrice}"/></span>
 </c:otherwise>
 </c:choose>
 </span>
</td>
<td class="a-center">
 <dsp:input bean="CartModifierFormHandler.quantity" name="quantity" size="3" type="text" value="${currentItem.quantity}"/>
</td>
<td class="a-center" width="1"> </td>
<td class="a-right last">
<span class="cart-price">
<span class="price"><dsp:valueof param="currentItem.priceInfo.amount" /></span>
</span>
   <dsp:getvalueof id="skuId" param="CommerceItem.catalogRefId">
      <dsp:input type="checkbox" bean=
         "CartModifierFormHandler.removalCatalogRefIds" value="${currentItem.catalogRefId}"/>
   </dsp:getvalueof>
</td>
</tr>


<%--
GoTo this URL if user pushes RECALCULATE button and there are no errors:
--%>
<dsp:input bean="CartModifierFormHandler.setOrderSuccessURL" type="hidden"
   value="../checkout/cart.jsp"/>

<%--
GoTo this URL if user pushes RECALCULATE button and there are errors:
--%>
<dsp:input bean="CartModifierFormHandler.setOrderErrorURL" type="hidden"
   value="../checkout/cart.jsp"/>

<%-- CHECKOUT Order button: --%>
&nbsp; &nbsp;   

<dsp:input bean="CartModifierFormHandler.moveToPurchaseInfoSuccessURL"
   type="hidden" value="../checkout/shipping.jsp"/> <%-- move on to shipping --%>
</tr>
</dsp:oparam>
<dsp:oparam name="empty">
  Shopping Cart Is Empty
</dsp:oparam>
</dsp:droplet>
</tbody>
</table>
</fieldset>
<div class="cart-collaterals">
<div class="col2-set"></div>
<div class="totals">
<ul class="checkout-types">
<li>
<div class="continue_shopping">
<a class="continue-shopping" title="Continue Shopping" href="/dwellstore">Continue Shopping</a>
</div>
<dsp:input bean="CartModifierFormHandler.moveToPurchaseInfo" type="submit" value="Checkout"/>

</li>
</ul>
</div>
</div>
</div>
</dsp:form>
</dsp:page>