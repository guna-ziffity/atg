<%--
  Page fragment that renders a single ruleset group inside of a segment or a content group.

  @param  model               An ExpressionModel component containing the expression to
                              be edited.
  @param  container           The ID of the container for this expression editor.
  @param  rulesetGroup        The ruleset group being edited.
  @param  rulesetGroupIndex   The index of the ruleset group being edited.
  @param  multisiteMode       True if we are in a multisite mode.
  @param  headerId            The id of ruleset group header
  @param  type                The type of ruleset group


  @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/expreditor/targeting/renderGroupRulesetGroup.jsp#1 $$Change: 946917 $
  @updated $DateTime: 2015/01/26 17:26:27 $$Author: jsiddaga $
  --%>

<%@ taglib prefix="c"     uri="http://java.sun.com/jsp/jstl/core"              %>
<%@ taglib prefix="dspel" uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_0" %>
<%@ taglib prefix="fmt"   uri="http://java.sun.com/jsp/jstl/fmt"               %>
<%@ taglib prefix="ee"    uri="http://www.atg.com/taglibs/expreditor_rt"       %>

<dspel:page>
  
  <dspel:getvalueof var="paramModel"            param="model"/>
  <dspel:getvalueof var="paramContainer"        param="container"/>
  <dspel:getvalueof var="rulesetGroup"          param="rulesetGroup"/>
  <dspel:getvalueof var="rulesetGroupIndex"     param="rulesetGroupIndex"/>
  <dspel:getvalueof var="multisiteMode"         param="multisiteMode"/>
  <dspel:getvalueof var="multisiteContent"      param="multisiteContent"/>
  <dspel:getvalueof var="type"                  param="type"/>
  <dspel:getvalueof var="headerId"              param="headerId"/>
  
  <dspel:importbean var="model" bean="${paramModel}"/>
  <c:set var="siteFilterAvailable" value="${not model.siteFilterUnavailable and multisiteContent and multisiteMode}"/>

  <c:forEach var="ruleset" items="${rulesetGroup.rulesets}" varStatus="rulesetLoop">
    <dspel:include page="renderGroupRuleset.jsp">
      <dspel:param name="rulesetGroup" value="${rulesetGroup}"/>
      <dspel:param name="rulesetGroupIndex" value="${rulesetGroupIndex}"/>
      <dspel:param name="ruleset" value="${ruleset}"/>
      <dspel:param name="rulesetIndex" value="${rulesetLoop.index}"/>
      <dspel:param name="multisiteMode" value="${multisiteMode}"/>
      <dspel:param name="headerId" value="${headerId}"/>
      <dspel:param name="type" value="${type}"/>
      <dspel:param name="siteFilterAvailable" value="${siteFilterAvailable}"/>
    </dspel:include>
  </c:forEach>

</dspel:page>

<%-- @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/expreditor/targeting/renderGroupRulesetGroup.jsp#1 $$Change: 946917 $--%>