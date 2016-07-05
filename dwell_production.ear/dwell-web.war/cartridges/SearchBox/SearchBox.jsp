<%--
  Renders a search box which allows the user to query for search results.
  Provides checkboxes to allow user to search across sites (where applicable)
  and also supports auto auggest (provides a list of possible matches as
  the user types)

  Required parameters:
    contentItem
      The "Search Box" content item
    
  Optional parameters:
    None.
--%>
<dsp:page>
  <dsp:importbean bean="/OriginatingRequest" var="originatingRequest"/>
  <dsp:importbean bean="/atg/dynamo/droplet/multisite/CartSharingSitesDroplet" />
  <dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
  <dsp:importbean bean="/atg/multisite/Site" var="currentSite"/>
  <dsp:importbean bean="/atg/endeca/assembler/SearchFormHandler"/>
  <dsp:importbean bean="/atg/endeca/assembler/cartridge/manager/DefaultActionPathProvider"/>

  <dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}"/> 
  <dsp:getvalueof var="contextPath" vartype="java.lang.String" value="${originatingRequest.contextPath}"/>
  <dsp:getvalueof var="actionPath" bean="DefaultActionPathProvider.defaultExperienceManagerNavigationActionPath"/>

  <fmt:message var="hintText" key="common.search.input"/>
  <fmt:message var="submitText" key="search_simpleSearch.submit"/>
  
  <div id="atg_store_search">
    
    <%-- The search form --%>
    <dsp:form action="${contextPath}${actionPath}" id="searchForm" requiresSessionConfirmation="false">
      <input type="hidden" name="Dy" value="1"/>
      <input type="hidden" name="Nty" value="1"/>
      <dsp:input bean="SearchFormHandler.siteScope" type="hidden" value="ok" name="siteScope"/>

      <%--
        The autocomplete attribute specifies whether or not an input field 
        should have autocomplete enabled. Autocomplete allows the browser to 
        display a list of options to fill in the field, based on earlier typed values.
        Turn off browser autocomplete when auto suggest is enabled so that only one
        list of options is displayed to the user.
      --%>
      <c:set var="nativeAutoCompleteState" value="on" />

      <c:if test="${contentItem.autoSuggestEnabled}">
        <dsp:getvalueof var="minAutoSuggestInputLength" value="${contentItem.minAutoSuggestInputLength}" />
        <%--
          Instantiate the Dojo AutoSuggest widget, passing in values for any
          properties that are required or that require a value other than
          the default value. See AutoSuggest.js
        --%>
        <span dojotype="atg.store.widget.AutoSuggest"
              id="autoSuggest"
              ajaxUrl="${contextPath}/assembler"
              contentCollection="/content/Shared/Auto-Suggest Panels"
              siteContextPath="${contextPath}"
              searchBoxId="atg_store_searchInput"
              submitButtonId="atg_store_searchSubmit"
              minInputLength="${minAutoSuggestInputLength}"
              animationDuration="500">
        </span>
        <c:set var="nativeAutoCompleteState" value="off" />
      </c:if>
      
      <dsp:input class="text atg_store_searchInput" bean="SearchFormHandler.intxt" name="Ntt" value="" placeholder="Search Here" type="text" 
        id="atg_store_searchInput" title="${hintText}" autocomplete="${nativeAutoCompleteState}"/>
      
      
      <span class="atg_store_smallButton">
      	<dsp:input type="submit" bean="SearchFormHandler.SuccessURL"
          type="hidden" value="cartridges/DwellProductList/DwellProductList.jsp"/>
        <dsp:input type="submit" bean="SearchFormHandler.search" name="search" 
          value="search" id="atg_store_searchSubmit" title="${submitText}"/>
      </span>
      
    </dsp:form> 
  </div>
  

</dsp:page>
<%-- @version $Id: //hosting-blueprint/B2CBlueprint/version/11.2/Storefront/j2ee/store.war/cartridges/SearchBox/SearchBox.jsp#1 $$Change: 946917 $--%>
