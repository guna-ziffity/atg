<dsp:page>
  <dsp:importbean bean="/atg/commerce/order/OrderLookup"/>
    <dsp:importbean bean="/atg/userprofiling/Profile"/>
    <dsp:importbean bean="/atg/userprofiling/ProfileFormHandler" />
  <dsp:include page="/includes/header.jsp"/>
<style>
#flip-tabs{  

    position:relative;  
} 
#flip-navigation{  
    margin:0 0 10px; padding:0;   
    list-style:none;  
}  
#flip-navigation li{   
    display:inline;   
}  
#flip-navigation li a{  
    text-decoration:none; padding:10px;   
    margin-right:0px;  
    background:#f9f9f9;  
    color:#333; outline:none;  
    font-family:Arial; font-size:12px; text-transform:uppercase;  
}  
#flip-navigation li a:hover{  
    background:#999;   
    color:#f0f0f0;  
}  
#flip-navigation li.selected a{  
    background:#999;  
    color:#f0f0f0;  
}  
#flip-container{    
   
    font-family:Arial; font-size:13px;  
}  
#flip-container div{   
    background:#fff;  
} 

</style>

<dsp:droplet name="OrderLookup">
          <dsp:param name="userId" bean="Profile.id"/>
          <dsp:param name="sortBy" value="submittedDate"/>
          <dsp:param name="state" value="open"/>
          <dsp:param name="numOrders" value="5"/>      
      
          <dsp:oparam name="output">
       
         <dsp:getvalueof var="orders" param="result"/>
         <dsp:getvalueof var="count" param="count" />
         </br>       
   
         </br></br>

 <div id="flip-tabs" >  
        <ul id="flip-navigation" >  
            <li><a href="myOrders.jsp" id="tab-0"  ><i><b>My Orders(${count})</b></i></a></li>  
            <li class="selected"><a href="editProfile.jsp" id="tab-1" ><i>Profile</i></a></li>  
            
        </ul>  
        <div id="flip-container" >  
            <div>  
			

<dsp:form action="<%=request.getRequestURI()%>" method="post">

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
  <table>
  <tr><td>
 Login:</td><td>
 <dsp:input bean="ProfileFormHandler.value.login" required="<%=true%>" type="text"/> 
       </td></tr>  
   <tr><td>     
 First name:</td><td>
 <dsp:input bean="ProfileFormHandler.value.firstname"  type="text"/> 
       </td></tr>  
   <tr><td>     
 Last name:</td><td>
 <dsp:input bean="ProfileFormHandler.value.lastname"  type="text"/>
 </td></tr>  
   <tr><td> 
 Email Address:</td><td>
 <dsp:input bean="ProfileFormHandler.value.email"  type="text"/>
 </td></tr>  
   <tr><td> 
Address:</td><td>
 <dsp:input bean="ProfileFormHandler.value.shippingAddress.address1"  type="text"/>
 </td></tr>  
   <tr><td> 
 City:</td><td>
 <dsp:input bean="ProfileFormHandler.value.shippingAddress.city" type="text"/>
 </td></tr>  
   <tr><td> 
State:</td><td>
 <dsp:input bean="ProfileFormHandler.value.shippingAddress.state"  type="text"/>
 </td></tr>  
   <tr><td> 
Country:</td><td>
 <dsp:input bean="ProfileFormHandler.value.shippingAddress.country"  type="text"/>
 </td></tr>  

 <dsp:input bean="ProfileFormHandler.updateSuccessURL" type="hidden" value="${originatingRequest.contextPath}"/>
 <dsp:input bean="ProfileFormHandler.cancelURL" type="hidden" value="${originatingRequest.contextPath}"/>
 <tr><td><dsp:input bean="ProfileFormHandler.update" type="Submit" value="update"/>
 <dsp:input bean="ProfileFormHandler.cancel" type="Submit" value="Cancel"/></td></tr>
     </table>  
</dsp:form> 
			</div>
			<div>
			</div>
 </dsp:oparam>
   </dsp:droplet>   

</dsp:page>