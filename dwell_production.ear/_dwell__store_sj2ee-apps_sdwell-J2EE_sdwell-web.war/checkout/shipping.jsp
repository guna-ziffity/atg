<dsp:page>
<link rel="stylesheet" href="/dwellstore/css/styles.css" type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="/dwellstore/css/screen.css" type="text/css" media="screen" title="no title" charset="utf-8" />
<body class=" cms-index-index cms-home">
<div class="wrapper">
<div class="page">
<dsp:importbean bean="/atg/commerce/order/purchase/ShippingGroupFormHandler"/>
<dsp:importbean bean="/atg/commerce/order/purchase/ShippingGroupDroplet"/>
<dsp:importbean bean="/OriginatingRequest" var="originatingRequest"/>
<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>

<style>
    tab { padding-left: 4em; }
</style>



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

 <dsp:getvalueof var="init" param="init"/>
 <dsp:include page="/includes/header.jsp" />
<div class="main col1-layout">
<div class="col-main">
   <dsp:droplet name="ShippingGroupDroplet">
    <dsp:param name="initShippingGroups" value="true"/>
        <dsp:param name="initBasedOnOrder" value="true"/>
       <dsp:param name="shippingGroupTypes" value="hardgoodShippingGroup"/>
 	<dsp:oparam name="output">
 	<select name="shipping_address" id="shipping_address">
 	 				<dsp:droplet name="ForEach">
 	 				
                   <dsp:param name="array" param="shippingGroups"/>
                     <dsp:oparam name="output">
                     <dsp:form method="post">
                    <dsp:valueof param="element.shippingAddress" /></br>
                    <option value=""><dsp:valueof param="element.shippingAddress.firstName"/>&nbsp;<dsp:valueof param="element.shippingAddress.lastName"/></br>,dsp:valueof param="element.shippingAddress.address1"/>,</br><dsp:valueof param="element.shippingAddress.address2"/>,</br><dsp:valueof param="element.shippingAddress.city"/>,</br><dsp:valueof param="element.shippingAddress.country"/></option>
                    Name :<dsp:valueof param="element.shippingAddress.firstName"/>&nbsp;<dsp:valueof param="element.shippingAddress.lastName"/></br></br>
					Address :<dsp:valueof param="element.shippingAddress.address1"/>,</br>
							 <tab><dsp:valueof param="element.shippingAddress.address2"/>,</br>
							 <tab><dsp:valueof param="element.shippingAddress.city"/>,</br>
							 <tab><dsp:valueof param="element.shippingAddress.country"/></br>
							 <dsp:a bean="/atg/userprofiling/ProfileFormHandler.editAddress" href="editShipping.jsp"
                                      paramvalue="${element.shippingAddress.key}">edit this</dsp:a>
                                      <dsp:input bean="ShippingGroupFormHandler.applyDefaultShippingGroup" type="hidden" value="true"/>
                                      <br><dsp:input bean="ShippingGroupDroplet.shippingGroupMapContainer.defaultShippingGroupName" paramvalue="key" type="hidden"/> 
               <dsp:input bean="ShippingGroupDroplet.defaultShippingGroup.shippingMethod" value="Ground" type="hidden"/> 
     <dsp:input bean="ShippingGroupFormHandler.applyShippingGroups" type="submit" value="Ship to this address"/>
    <dsp:input bean="ShippingGroupFormHandler.applyShippingGroupsSuccessURL" type="hidden" value="billing.jsp"/>
    <dsp:input bean="ShippingGroupFormHandler.applyShippingGroupsErrorURL" type="hidden" value="${originatingRequest.requestURI}"/>
                      	</dsp:form>
                      	</dsp:oparam>
                      	
 					</dsp:droplet>
  				
 
 	</select>
    	</dsp:oparam>				
 </dsp:droplet>
 </br> </br>
    

 <dsp:include page="shippingSingle.jsp" />
 </div>
 </div>
 </div>
 <dsp:include page="/includes/footer.jsp" />
 </div>
 </body>
</dsp:page>