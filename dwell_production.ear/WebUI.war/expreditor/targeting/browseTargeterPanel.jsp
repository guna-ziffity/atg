<%--
  Page fragment for browsing the contents of a targeter.

  @param  model   An ExpressionModel component containing the targeter contents.

  @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/expreditor/targeting/browseTargeterPanel.jsp#1 $$Change: 946917 $
  @updated $DateTime: 2015/01/26 17:26:27 $$Author: jsiddaga $
  --%>

<%@ taglib prefix="c"
    uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="dspel"
    uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_0"%>
<%@ taglib prefix="fmt"
    uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ee"
    uri="http://www.atg.com/taglibs/expreditor_rt"%>

<dspel:page>

  <dspel:getvalueof var="expressionModelPath" param="model"/>
  <dspel:importbean var="model" bean="${expressionModelPath}"/>

  <dspel:importbean var="config" bean="/atg/web/Configuration"/>
  <fmt:setBundle basename="${config.resourceBundle}"/>
  
  <ee:isMultisiteMode var="multisiteMode"/>
  <ee:isMultisiteEnabled var="multisiteContent" expressionModel="${model}"/>
  
   <c:choose>
    <c:when test="${multisiteMode}">
      <c:set var="ruleGroupOrder">DEFAULT,SITE,SITEGROUP</c:set>
    </c:when>
    <c:otherwise>
      <c:set var="ruleGroupOrder">DEFAULT</c:set>
    </c:otherwise>
  </c:choose>


  <c:forEach var="type" items="${ruleGroupOrder}" varStatus="groupLoop">
    <ee:getRulesetGroupsByType var="rulesetGroups" rulesetGroupType="${type}" expressionModel="${model}"/>
    <c:forEach var="rulesetGroup" items="${rulesetGroups}" varStatus="groupLoop">
      <%-- Render a separator --%>
      <%-- todo: move style to CSS --%>
      <div style="width:90%; height:10px;"></div>

      <dspel:include page="browseTargeterRulesetGroup.jsp">
        <dspel:param name="model" value="${paramModel}"/>
        <dspel:param name="rulesetGroup" value="${rulesetGroup}"/> 
        <dspel:param name="rulesetGroupIndex" value="${groupLoop.index}"/>
        <dspel:param name="multisiteMode" value="${multisiteMode}"/>
        <dspel:param name="type" value="${type}"/>
      </dspel:include>

    </c:forEach>
   </c:forEach>
  
</dspel:page>
<%-- @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/expreditor/targeting/browseTargeterPanel.jsp#1 $$Change: 946917 $--%>
