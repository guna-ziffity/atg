<%@ page isELIgnored="false" %>
<%@ taglib prefix="dsp" uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_1" %>

<dsp:page>
<html>

<head>

     
<style>
.Row
{
display:table;
width:100%;
table-layout:fixed;
border-spacing:10px;
}
.Column
{
display:table-cell;
}
</style>

 </head>

<dsp:importbean bean="/atg/commerce/order/purchase/CartModifierFormHandler" />
<dsp:importbean bean="/atg/commerce/ShoppingCart"/>
<dsp:importbean bean="/atg/commerce/order/purchase/ShippingGroupFormHandler" />
<dsp:importbean bean="/atg/commerce/order/purchase/ShippingGroupDroplet" />
<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
<dsp:importbean bean="/atg/dynamo/droplet/Switch" />
<dsp:importbean bean="/atg/commerce/pricing/UserPricingModels"/>
<dsp:importbean bean="/atg/commerce/pricing/AvailableShippingMethods"/>
<dsp:importbean bean="/atg/commerce/order/ShoppingCartModifier"/>

<dsp:importbean bean="/OriginatingRequest" var="originatingRequest"/>
<dsp:importbean bean="/atg/commerce/order/purchase/PaymentGroupFormHandler" />
<dsp:importbean bean="/atg/commerce/order/purchase/PaymentGroupDroplet" />
<dsp:importbean bean="/atg/commerce/order/purchase/CreateCreditCardFormHandler" />
<dsp:importbean bean="/atg/commerce/order/ShoppingCartModifier"/>
<dsp:importbean bean="/atg/commerce/order/purchase/RepriceOrderDroplet"/>
 <dsp:importbean bean="/atg/commerce/order/purchase/CreateCreditCardFormHandler"/>
<dsp:importbean bean="/atg/userprofiling/Profile"/>
<dsp:importbean bean="/atg/commerce/order/purchase/RepriceOrderDroplet" />

<body>
 
 <dsp:include page="/includes/header.jsp"/>
 
<h2>DWELL STORE CHECKOUT</h2>
<h5>Please fill in the fields below and click "Place Order" to complete your purchase</h5>

<%-- New Row --%>

<div class="Row">
  
<%-- New Column --%>

  <div class="Column">
      
      <table border="0">
      
      
 
<dsp:droplet name="ShippingGroupDroplet">
<dsp:param value="true" name="clear"/>
 <dsp:param name="clearShippingInfos" param="init"/>
  <dsp:param name="clearShippingGroups" value="true"/>
  <dsp:param name="shippingGroupTypes" value="hardgoodShippingGroup"/>
  <dsp:param name="initShippingGroups" param="init"/>
  <dsp:param name="initBasedOnOrder" param="init"/>
  <dsp:oparam name="output">

      <tr><td><h3><b>Shipping Address</tr></td>
  <tr><td>
  Select a shipping address from your address book<br>or enter a new address.
<br>


<dsp:droplet name="ForEach">
<dsp:param name="array" param="shippingGroups"/>
<dsp:oparam name="output">
<dsp:form method="post"> 


<dsp:input bean="ShippingGroupFormHandler.applyDefaultShippingGroup" type="hidden" value="true"/> 
<dsp:input bean="ShippingGroupDroplet.shippingGroupMapContainer.defaultShippingGroupName" paramvalue="key" type="hidden"/>              
	
   <select style="max-width:60%;"
    onchange="java_script_:showCreateShipping(this.options[this.selectedIndex].value)">
  
<option value="SelectAddress" >-- Select Your Address --</option>

<option value="Address"> 
    
<dsp:valueof param="element.shippingAddress.firstName"/> <dsp:valueof param="element.shippingAddress.lastName"/>,
<dsp:valueof param="element.shippingAddress.address1"/>,<dsp:valueof param="element.shippingAddress.city"/>,
<dsp:valueof param="element.shippingAddress.state"/>,<dsp:valueof param="element.shippingAddress.country"/>

</option> 
	    
<option value="New">Create New</option>
		    
</select>


    
    <br>
       	
     <dsp:input bean="ShippingGroupDroplet.shippingGroupMapContainer.defaultShippingGroupName" paramvalue="key" type="hidden"/>              
     <dsp:input bean="ShippingGroupFormHandler.applyShippingGroupsErrorURL" type="hidden" value="expresscheckout.jsp"/>
     <dsp:input bean="ShippingGroupFormHandler.applyShippingGroupsSuccessURL" type="hidden" value="expresscheckout.jsp?init=true"/> 
    
    <div style="display:none;">
     <dsp:input id="submit" bean="ShippingGroupFormHandler.applyShippingGroups" type="submit" />  
	</div>
	
</dsp:form>
</dsp:oparam>
</dsp:droplet>

	
	
<script>
  function showCreateShipping(param) 
  {
    if (param == "New")
     {
    hiddenDiv.style.display='inline-block';
    Form.fileURL.focus();
    } 
    else if (param == "Address")
    {
   		submit.click();
    }
    else
    {
    hiddenDiv.style.display='none';
    }
  };
  
  function shippingSubmit(param2)
  { 
  if (param2 == "Address")
 	{
 	submit.click();
 	}
  };
  
  
   function shippingMethodSubmit()
  {
 	smSubmit.click();
 	alert("submitted")
  };
        
</script>


 <br/><br/>
<div style="display:none;" id="hiddenDiv">

<dsp:include page="createShippingGroup.jsp" name='business'/>
 <br/>
</div>

  </dsp:oparam>
</dsp:droplet>


</tr></td></table>

<%-- Column Ending --%>
</div>


<%-- New Column --%>

  <div class="Column">
      
      <table border="0">


      
      <tr><td><h3><b>Shipping Method</tr></td>
  <tr><td>
  
 
      
      <dsp:form action="expresscheckout.jsp?init=true" method="post">
 
 
 
  <dsp:input bean="ShippingGroupFormHandler.applyDefaultShippingGroup" type="hidden" value="true"/>   

<dsp:getvalueof var="currentItem" bean="ShoppingCart.current"/>

<dsp:getvalueof var="shippingGroup" value="${currentItem.shippingGroups}"/>


<dsp:droplet name="AvailableShippingMethods">
          <dsp:param name="shippingGroup" value="${shippingGroup[0]}"/>
          <dsp:oparam name="output">
          
          <dsp:getvalueof var="availableShippingMethods" vartype="java.lang.Object"
                            param="availableShippingMethods"/>  

 Available Shipping Options:  <br> <br>     
         <c:forEach var="methods" items="${availableShippingMethods}"> 
                        
&nbsp;<dsp:input type="radio" bean="ShoppingCart.current.shippingGroups[0].shippingMethod"
    name="shippingMethod" value="${methods}"
    onclick="shippingMethodSubmit()"/>${methods}
    <br>	
		 </c:forEach>

<div style="display:none;">
<input bean="ShoppingCart.current.shippingGroups[0].shippingMethod" type="submit" id="smSubmit" value="Submit"/>
</div>

</dsp:oparam>
</dsp:droplet>           
                                                 
</dsp:form>


</tr></td></table>

<%-- Column Ending--%>
</div>

<%-- New Column --%>
<div class="Column">
      
      <table border="0">

<dsp:droplet name="PaymentGroupDroplet">

  <dsp:param value="true" name="clear"/>
  <dsp:param value="storeCredit, creditCard"
              name="paymentGroupTypes"/>
  <dsp:param name="initOrderPayment" value="true"/>
  <dsp:param value="true" name="initPaymentGroups"/>
      
  <dsp:oparam name="output">
  
       <tr><td><h3><b>Payment Details</tr></td>
  <tr><td>
      
      Your Available Credit Cards<br><br>
      <dsp:form method="post">

 	<dsp:input bean="PaymentGroupFormHandler.listId" beanvalue="PaymentGroupFormHandler.listId" priority="9" type="hidden"/>
 	<dsp:valueof param="key"/>

<dsp:select bean="PaymentGroupDroplet.paymentGroupMapContainer.defaultPaymentGroupName" paramvalue="key" style="max-width:75%;"
 onchange="java_script_:showCreatePayment(this.options[this.selectedIndex].value)">     

<dsp:option value="SelectCard" selected="selected">-- Select Your Card --</dsp:option>
      
  <dsp:droplet name="ForEach">
  <dsp:param name="array" param="paymentGroups"/>
  <dsp:oparam name="output">     
      
<dsp:option value="CreditCard">
<dsp:valueof param="element.creditCardType"/> <dsp:valueof param="element.creditCardNumber"/>
</dsp:option>

   </dsp:oparam>
</dsp:droplet> 

<dsp:option value="CreateNew">Create New</dsp:option>
            
 </dsp:select>                 
                                 
 <dsp:input bean="PaymentGroupFormHandler.applyDefaultPaymentGroup" type="hidden" value="true"/>
 <dsp:input bean="PaymentGroupFormHandler.applyPaymentGroupsSuccessURL" type="hidden" value="orderSummary.jsp"/>
 <dsp:input bean="PaymentGroupFormHandler.applyPaymentGroupsErrorURL" type="hidden" value="expresscheckout.jsp?init=true"/>  
    
 <div style="display:none;">
 <dsp:input bean="PaymentGroupFormHandler.applyPaymentGroups" id="pgSubmit" type="submit" value="Select & Continue"/>
  </div>
    
               
    </dsp:form>

  </dsp:oparam>
</dsp:droplet>


</tr></td></table>

<script>
  function showCreatePayment(param1) 
  {
    if (param1 == "CreateNew")
     {
    hiddenDiv2.style.display='inline-block';
    Form.fileURL.focus();
    } 
    else if (param1 == "CreditCard")
    {
    	pgSubmit.click();
    } 
    
    else
    {
    hiddenDiv2.style.display='none';
    }
  }          
</script>

<br/><br/>

<div style="display:none;" id="hiddenDiv2">

<dsp:include page="createPaymentGroup.jsp"/>
 <br/>
</div>

<%-- Column Ending--%>
</div>



<%-- Row Ending--%>
</div> 
<center>


</center>
</body>

</html>

</dsp:page>