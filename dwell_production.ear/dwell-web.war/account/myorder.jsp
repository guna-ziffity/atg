<dsp:page>

  <dsp:importbean bean="/atg/commerce/order/OrderLookup"/>
  <dsp:importbean bean="/atg/userprofiling/Profile"/>
  <dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
  <dsp:importbean bean="/atg/commerce/order/OrderStatesDetailed"/>
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


  <dsp:getvalueof var="submittedDate" vartype="java.util.Date" param="order.submittedDate"/>
  
   <dsp:droplet name="OrderLookup">
          <dsp:param name="userId" bean="Profile.id"/>
          <dsp:param name="sortBy" value="submittedDate"/>
          <dsp:param name="state" value="open"/>
          <dsp:param name="numOrders" value="5"/>      
      
          <dsp:oparam name="output">
       
         <dsp:getvalueof var="orders" param="result"/>
         <dsp:getvalueof var="size" param="count" />
         
         </br>       
   
         </br></br>
        <div id="flip-tabs" >  
        <ul id="flip-navigation" >  
            <li class="selected"><a href="#" id="tab-0"  ><i><b>My Orders(${size})</b></i></a></li>  
            <li><a href="editprofile.jsp" id="tab-1" ><i>Profile</i></a></li>  
            
        </ul>  
        <div id="flip-container" >  
            <div>  
                 		<table cellpadding="5px" cellspacing="10px">
         <tr>
         <th>Order Id</th>
         <th>Items</th>
   		 <th>Creation Date</th>
   		 <th>Submitted Date</th>
   		 <th>Status</th>
   		 <th>Order total</th>
         </tr>
          <dsp:droplet name="ForEach">
              <dsp:param name="array" param="result"/>
              <dsp:oparam name="output">
              
         <tr>
         <td><dsp:valueof param="element.id" /> </td> 
         <td><dsp:valueof param="element.CommerceItemCount" /> </td> 
         <td><dsp:valueof date="M/dd/yyyy" param="element.creationDate"/></td>
         <td><dsp:valueof date="M/dd/yyyy" param="element.submittedDate"/></td>
         <td>
         	  <dsp:droplet name="OrderStatesDetailed">
         	  <dsp:param name="state" param="element.state"/>
         	   <dsp:param name="elementName" value="orderStateDescription"/>
         	  <dsp:oparam name="output">
      			<dsp:valueof param="orderStateDescription" />
      		   </dsp:oparam>
      		  </dsp:droplet> 
         </td>
         <td><dsp:valueof param="element.priceInfo.total"/></td>
         </tr>
        
          </dsp:oparam>
          </dsp:droplet>
          
           </table>
            </div>  
           
        </div>  
    </div>  
  
         
         
       	
   </dsp:oparam>
   </dsp:droplet>          
  </dsp:page>