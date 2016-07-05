<%--
  Page fragment that displays a read-only view of the contents of a segment
  or content group.

  @param  model          An ExpressionModel component containing the expression.

  @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/expreditor/targeting/browseGroupPanel.jsp#1 $$Change: 946917 $
  @updated $DateTime: 2015/01/26 17:26:27 $$Author: jsiddaga $
--%>

<%@ taglib prefix="c"
    uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="dspel"
    uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_0"%>
<%@ taglib prefix="ee"
    uri="http://www.atg.com/taglibs/expreditor_rt"%>

<dspel:page>
  
  <dspel:getvalueof var="expressionModelPath" param="model"/>
  <dspel:importbean var="model" bean="${expressionModelPath}"/>
  
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

  <c:forEach var="type" items="${ruleGroupOrder}">
    <ee:getRulesetGroupsByType var="rulesetGroups" rulesetGroupType="${type}" expressionModel="${model}"/>

    <c:forEach var="rulesetGroup" items="${rulesetGroups}">
      <c:forEach var="ruleset" items="${rulesetGroup.rulesets}">
        <dspel:include page="browseGroupRuleset.jsp">
          <dspel:param name="rulesetGroup" value="${rulesetGroup}"/>
          <dspel:param name="ruleset" value="${ruleset}"/>
          <dspel:param name="multisiteMode" value="${multisiteMode}"/>
          <dspel:param name="type" value="${type}"/>
        </dspel:include>
      </c:forEach>
    </c:forEach>

   </c:forEach>

</dspel:page>
<%-- @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/expreditor/targeting/browseGroupPanel.jsp#1 $$Change: 946917 $--%>
