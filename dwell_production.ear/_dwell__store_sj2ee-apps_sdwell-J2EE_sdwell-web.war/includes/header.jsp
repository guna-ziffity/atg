<dsp:page>
<dsp:importbean bean="/atg/endeca/assembler/droplet/InvokeAssembler"/>
<dsp:importbean bean="/atg/userprofiling/Profile"/>
<dsp:importbean bean="/OriginatingRequest" var="originatingRequest"/>
<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler" />
<dsp:importbean bean="/atg/commerce/ShoppingCart"/>
<div class="header-container">
	<div class="dwell-header">
		<div class="topbar">
			<div class="back-to-dwell">
				<ul>
					<li class="first"><a href="http://www.dwell.com/">Dwell</a></li>
					<li class="last"><a href="http://www.dwellondesign.com/">Dwell on Design</a></li>
					<li class="last"><a href="http://www.dwellhomes.com/">Dwell Homes</a></li>
				</ul>
			</div>
			<div class="msg"><a href="http://store.dwell.com/featured/sale.html">Shop sale items while supplies last!</a></div>
			<div class="dwell-quick-access">
				<dsp:getvalueof var="profile" bean="Profile.transient" />
				<ul class="links">
 				<c:choose>
 					<c:when test="${profile eq true}">
  						welcome guest,&nbsp;&nbsp;
   						<li class="first"><dsp:a href="${originatingRequest.contextPath}/account/login.jsp">Sign In</dsp:a></li>
   						<li class=" last"><dsp:a href="${originatingRequest.contextPath}/account/register.jsp">Register</dsp:a></li>
  					</c:when>
  					<c:otherwise>
  						Welcome, <dsp:valueof bean="Profile.firstName" />&nbsp;&nbsp;
   						<dsp:form action="header.jsp" method="post">
   							<dsp:input bean="ProfileFormHandler.logoutSuccessURL" type="hidden" value="${originatingRequest.contextPath}"/>
							<dsp:input bean="ProfileFormHandler.Logout" type="submit" value="Logout" />  
							<li class="first"><dsp:a href="${originatingRequest.contextPath}/account/myaccount.jsp"> MyAccount</dsp:a></li>
  		 				</dsp:form>
  					</c:otherwise>
				</c:choose>
				</ul>
                <div class="top-cart">
    				<div class="block-title">
    					<strong id="cartHeader">
    						<dsp:a href="${originatingRequest.contextPath}/checkout/cart.jsp">
								<dsp:getvalueof var="CartCount" bean="ShoppingCart.current.CommerceItemCount" />
								Cart(${CartCount})
							</dsp:a>
    					</strong>
    				</div>
    			</div>
    			<div class="checkout-link">
    				<ul class="links">
						<li class="first last"><dsp:a href="${originatingRequest.contextPath}/includes/shipping.jsp">Checkout</dsp:a></li>
					</ul>
				</div>
    		</div>
    	</div>
    </div>
    <dsp:droplet name="InvokeAssembler">
    	<dsp:param name="contentCollection" value="/content/Shared/Header"/>
    	<dsp:oparam name="output">
      		<dsp:getvalueof var="headerContent" vartype="com.endeca.infront.assembler.ContentItem" param="contentItem" />
    	</dsp:oparam>
    	<dsp:oparam name="error">
     		Error Loading Page
    	</dsp:oparam>
  	</dsp:droplet>
    <div class="header">
			<c:if test="${not empty headerContent}"> 
    			<dsp:renderContentItem contentItem="${headerContent}" />
   			</c:if>
  </div> 
 </div>
</dsp:page>