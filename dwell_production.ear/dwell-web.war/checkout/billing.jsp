<dsp:page>
<link rel="stylesheet" href="/dwellstore/css/styles.css" type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="/dwellstore/css/screen.css" type="text/css" media="screen" title="no title" charset="utf-8" />
<body class=" cms-index-index cms-home">
<div class="wrapper">
<div class="page">
<dsp:importbean bean="/atg/commerce/order/purchase/PaymentGroupFormHandler"/>
<dsp:importbean bean="/atg/commerce/order/purchase/CreateCreditCardFormHandler"/>

<dsp:importbean bean="/atg/commerce/order/purchase/PaymentGroupDroplet"/>
<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
<dsp:importbean bean="/atg/commerce/ShoppingCart"/>


<dsp:getvalueof var="init" param="init"/>
<dsp:getvalueof var="currentItem" bean="ShoppingCart.current" />
<!-- ${currentItem.shippingGroups} -->
 <dsp:include page="/includes/header.jsp" />
<div class="main col1-layout">
<div class="col-main">

<dsp:droplet name="/atg/dynamo/droplet/ErrorMessageForEach">
        <dsp:oparam name="output">
        <b><dsp:valueof param="message"/></b><br>
        </dsp:oparam>
        <dsp:oparam name="outputStart">
        <LI>
        </dsp:oparam>
        <dsp:oparam name="outputEnd">
        </LI>
        </dsp:oparam>
        </dsp:droplet>
        
        
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
         
   		<dsp:droplet name="PaymentGroupDroplet">
   		<dsp:param name="clear" value="true"/>
 		<dsp:param name="paymentGroupTypes" value="giftCertificates, storeCredit, creditCard"/>
        <dsp:param name="initOrderPayment" value="true"/>
       	<dsp:param name="initPaymentGroups" value="true"/>
       	
     	
       			<dsp:oparam name="output">
       			<dsp:setvalue bean="PaymentGroupFormHandler.listId" value="${currentItem.id}"/>
                	${currentItem.id}	
       			</br>
       					
 	 					<dsp:droplet name="ForEach">
                   		<dsp:param name="array" param="paymentGroups" />
                   	<!-- <dsp:valueof param="paymentGroups" /> -->
                     	<dsp:oparam name="output"></br>
                     	</br>
                     	<dsp:valueof param="element.paymentMethod"/>
                		<dsp:form>
                		<table>
                		
                     <tr><td> Card Type </td><td> :<dsp:valueof  param="element.creditCardType"/></td></tr>
                     <tr><td>Card Number </td><td>:<dsp:valueof param="element.creditCardNumber" converter="creditcard" /></td></tr>
             		 
             		 </table>
<dsp:input bean="PaymentGroupFormHandler.listId" beanvalue="PaymentGroupFormHandler.listId" priority="9" type="hidden"/>
       	                 
<dsp:input bean="PaymentGroupFormHandler.currentList[0].paymentMethod" type="hidden" paramvalue="key" />
 
 <dsp:valueof param="key"/>           	 
 <dsp:input bean="PaymentGroupFormHandler.applyDefaultPaymentGroup" type="hidden" value="true"/>
<dsp:input bean="PaymentGroupFormHandler.applyPaymentGroupsSuccessURL" type="hidden" value="orderConfirmation.jsp?init=true" />
<dsp:input bean="PaymentGroupFormHandler.applyPaymentGroupsErrorURL" type="hidden" value="billing.jsp" /> </br>
<dsp:input type="submit" bean="PaymentGroupFormHandler.applyPaymentGroups" value="confirm" /> 
 	 
 </dsp:form>
                  		</dsp:oparam>
                  		</dsp:droplet>
       			</dsp:oparam>
       	</dsp:droplet>
       	</br>
       

<dsp:include page="newCreditCard.jsp" />
</div>
</div>
</div>
<dsp:include page="/includes/footer.jsp" />
</div>
</body>
</dsp:page>