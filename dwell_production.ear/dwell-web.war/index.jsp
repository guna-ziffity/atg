<%@ page isELIgnored="false" %>
<%@ taglib prefix="dsp" uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_1" %>
<%--
  It's a welcome page for the CRS application.
  The user will see this page when he first comes to the store, or after he's clicked the store icon on the page.

  Required parameters:
    None.

  Optional parameters:
    None.
--%>
<dsp:page>

  <dsp:importbean bean="/atg/endeca/assembler/droplet/InvokeAssembler"/>
  <dsp:importbean bean="/atg/targeting/TargetingFirst"/>
  <dsp:importbean bean="/DwellDroplet/DefaultSkuDroplet"/>
  

  <%--
    The InvokeAssembler droplet is used to retrieve content from Experience 
    Manager. In this instance we request the ContentItem representing the home
    page.
  
    Input Parameters:
      contentCollection is the full path to the content in Experience Manager.
  
    Open Parameters:
      output The open parameter in which our output parameter is rendered in.
  
    Output Parameters:
      contentItem The ContentItem representing the content requested from Experience
      Manager.
  --%>
  <dsp:droplet name="InvokeAssembler">
    <dsp:param name="contentCollection" value="/content/Web/Home Pages"/>
    <dsp:oparam name="output">
      <dsp:getvalueof var="homePageContent" vartype="com.endeca.infront.assembler.ContentItem" param="contentItem" />
    </dsp:oparam>
  </dsp:droplet>

		
  					<c:if test="${not empty homePageContent}">
    					<dsp:renderContentItem contentItem="${homePageContent}" />
  					</c:if>

			<c:if test="${empty sku}">
				<dsp:getvalueof var="childSKUs" param="product.childSKUs"/>
				<!--<c:if test="${fn:length(childSKUs) eq 1}">-->
      			<dsp:getvalueof var="sku2" value="${product.childSKUs[0]}"/>
    			<!--</c:if>-->
			</c:if>

	

</dsp:page>
<%-- @version $Id: //hosting-blueprint/B2CBlueprint/version/11.2/Storefront/j2ee/store.war/index.jsp#1 $$Change: 946917 $ --%>