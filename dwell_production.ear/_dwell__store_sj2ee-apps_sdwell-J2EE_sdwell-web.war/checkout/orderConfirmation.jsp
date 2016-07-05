<dsp:page>
<link rel="stylesheet" href="/dwellstore/css/styles.css" type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="/dwellstore/css/screen.css" type="text/css" media="screen" title="no title" charset="utf-8" />
<body class=" cms-index-index cms-home">
<div class="wrapper">
<div class="page">
<dsp:importbean bean="/atg/commerce/order/purchase/PaymentGroupDroplet"/>
<dsp:importbean bean="/atg/commerce/ShoppingCart"/>
<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
<dsp:importbean bean="atg/commerce/order/purchase/ExpressCheckoutFormHandler" />
<style>
 tab { padding-left: 4em; }
 #section {
     background-color:#eeeeee;
}
</style>
 <dsp:include page="/includes/header.jsp" />
<div class="main col1-layout">
<div class="col-main">
<dsp:include page="orderSummary.jsp" />
<hr>
<div id="section">


<b>PAYMENT SUMMARY</b>	
</div>
 	 					<dsp:droplet name="ForEach">
                   		<dsp:param name="array" bean="ShoppingCart.current.paymentGroups" />
                   	<!-- <dsp:valueof param="paymentGroups" /> -->
                     	<dsp:oparam name="output"></br>
                     	</br>
                     	<table cellspacing="10px">
                     	<tr><td>
                     	<table>
                     	<tr><th>
                     Card Details:</th></tr>
               		<tr><td> Payment Method </td><td> :<dsp:valueof param="element.paymentMethod"/></td></tr>
                    <tr><td> Card Type </td><td> :<dsp:valueof  param="element.creditCardType"/></td></tr>
                     <tr><td>Card Number </td><td>:<dsp:valueof param="element.creditCardNumber" converter="creditcard" /></td></tr>
             		 </table></td>
             		<td>
             		 <table>
             		 <tr>  <th>Billing Address</th></tr>
             		 <tr><td><dsp:valueof  param="element.billingAddress.address1"/>,</td></tr>
             		 <tr><td><dsp:valueof  param="element.billingAddress.state"/>,</td></tr>
             		 <tr><td><dsp:valueof  param="element.billingAddress.city"/></td></tr>
             		 <tr><td><dsp:valueof  param="element.billingAddress.postalCode"/></td></tr>
             		 <tr><td><dsp:valueof  param="element.billingAddress.country"/></td></tr>
             		 </table>	</td>
             		 </table>
			</dsp:oparam>    		
			</dsp:droplet>
<div id="section">
<b>SHIPPING DETAILS</b>	
</div>	
 		<dsp:droplet name="ForEach">
        <dsp:param name="array" bean="ShoppingCart.current.shippingGroups" />
		<dsp:oparam name="output"></br>
		<b>Shipping Address</b></br></br>
        Name :<dsp:valueof param="element.shippingAddress.firstName"/>&nbsp;<dsp:valueof param="element.shippingAddress.lastName"/></br>
		Address :<dsp:valueof param="element.shippingAddress.address1"/>,</br>
							 <tab><dsp:valueof param="element.shippingAddress.address2"/>,</br>
							 <tab><dsp:valueof param="element.shippingAddress.city"/>,</br>
							 <tab><dsp:valueof param="element.shippingAddress.country"/></br>
                      <dsp:valueof param="element.shippingMethod" />
         </dsp:oparam>
         </dsp:droplet>
		<dsp:form>
			<dsp:input bean="ExpressCheckoutFormHandler.commitOrder" type="hidden" value="true"/>
			<dsp:input bean="ExpressCheckoutFormHandler.expressCheckoutErrorURL" type="hidden" value="orderConfirmation.jsp" />
			<dsp:input bean="ExpressCheckoutFormHandler.expressCheckoutSuccessURL" type="hidden" value="orderSuccess.jsp" /> </br>
	        <dsp:input type="submit" bean="ExpressCheckoutFormHandler.expressCheckout" value="Confirm Order" /> 
 		
		</dsp:form>
</div>
</div>
</div>
<dsp:include page="/includes/footer.jsp" />
</div>
</body>	
</dsp:page>