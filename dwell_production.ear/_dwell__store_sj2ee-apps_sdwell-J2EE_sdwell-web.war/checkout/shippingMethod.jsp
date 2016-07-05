<dsp:page>
  <dsp:importbean bean="/atg/commerce/order/purchase/ShippingGroupFormHandler"/>
 <dsp:importbean bean="/atg/commerce/pricing/AvailableShippingMethods"/>
  <dsp:importbean bean="/atg/commerce/ShoppingCart"/>
  <dsp:importbean bean="/atg/store/pricing/PriceShippingMethod"/>
  <dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
<dsp:form action="billing.jsp?init=true">
<dsp:getvalueof var="currentItem" bean="ShoppingCart.current" />
<dsp:getvalueof var="shippingGroup" value="${currentItem.shippingGroups}" />
${shippingGroup[0].shippingMethod}
<dsp:getvalueof var="method" value="${shippingGroup[0].shippingMethod}" />

<dsp:droplet name="ForEach">
        <dsp:param name="array" bean="ShoppingCart.current.shippingGroups" />
  <dsp:oparam name="output"></br>
  <b>Shipping Address</b></br></br>
        Name :<dsp:valueof param="element.shippingAddress.firstName"/>&nbsp;<dsp:valueof param="element.shippingAddress.lastName"/></br>
  Address :<dsp:valueof param="element.shippingAddress.address1"/>,</br>
        <tab><dsp:valueof param="element.shippingAddress.address2"/>,</br>
        <tab><dsp:valueof param="element.shippingAddress.city"/>,</br>
        <tab><dsp:valueof param="element.shippingAddress.country"/></br>
                      
         </dsp:oparam>
         </dsp:droplet>

    <dsp:droplet name="AvailableShippingMethods">
          <dsp:param name="shippingGroup" value="${shippingGroup[0]}"/>
          <dsp:oparam name="output">
          <dsp:getvalueof var="availableShippingMethods" vartype="java.lang.Object"
                            param="availableShippingMethods"/> 
             
             <c:forEach var="methods" items="${availableShippingMethods}">
             </br>
          <dsp:input type="radio" bean="ShoppingCart.current.shippingGroups[0].shippingMethod" value="${methods}"/>
           ${methods}
          </c:forEach>
            
         </dsp:oparam>
         </dsp:droplet>
   <%-- <dsp:input bean="ShippingGroupFormHandler.updateShippingMethodSuccessURL" type="hidden" value="billing.jsp?init=true" />
          <dsp:input bean="ShippingGroupFormHandler.updateShippingMethodErrorURL" type="hidden" value="shippingMethod.jsp" /> </br>
           <dsp:input type="submit" bean="ShippingGroupFormHandler.updateShippingMethod" value="update shipping method" /> 
          --%>
          <input type="submit"  value="update shipping method" />
</dsp:form>
</dsp:page>