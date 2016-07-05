<%--
  Page fragment that renders a single ruleset inside of a segment or content group.

  @param  rulesetGroup        The ruleset group being edited.
  @param  ruleset             The ruleset being edited.
  @param  rulesetIndex        The index of the ruleset being edited inside an expression service.
  @param  container           The ID of the container for this expression editor.
  @param  multisiteMode       True if we are in a multisite mode.
  @param  overrideRuleset     Defines rendering mode, true for rulesets (targeters), 
                              false for rules (content groups / user segments).
  @param  siteFilterAvailable True if site filer should be displayed.
  @param  headerId            The id of ruleset group header
  @param  type                The type of ruleset group


  @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/expreditor/targeting/renderGroupRuleset.jsp#1 $$Change: 946917 $
  @updated $DateTime: 2015/01/26 17:26:27 $$Author: jsiddaga $
  --%>

<%@ taglib prefix="c"     uri="http://java.sun.com/jsp/jstl/core"              %>
<%@ taglib prefix="dspel" uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_0" %>
<%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt"              %>
<%@ taglib prefix="ee"    uri="http://www.atg.com/taglibs/expreditor_rt"       %>

<dspel:page>

  <%-- Unpack DSP parameters --%>
  <dspel:getvalueof var="paramRulesetGroup" param="rulesetGroup"/>
  <dspel:getvalueof var="paramRulesetGroupIndex" param="rulesetGroupIndex"/>
  <dspel:getvalueof var="paramRuleset" param="ruleset"/>
  <dspel:getvalueof var="paramRulesetIndex" param="rulesetIndex"/>
  <dspel:getvalueof var="paramContainer" param="container"/>
  <dspel:getvalueof var="multisiteMode" param="multisiteMode"/>
  <dspel:getvalueof var="type" param="type"/>
  <dspel:getvalueof var="siteFilterAvailable" param="siteFilterAvailable"/>
  <dspel:getvalueof var="headerId" param="headerId"/>

  <dspel:importbean var="config" bean="/atg/web/Configuration"/>
  <fmt:setBundle basename="${config.resourceBundle}"/>

  <dspel:include page="renderGroupRulesetHeader.jsp">
    <dspel:param name="container" value="${paramContainer}"/>
    <dspel:param name="ruleset" value="${paramRuleset}"/>
    <dspel:param name="rulesetGroup" value="${paramRulesetGroup}"/>
    <dspel:param name="rulesetGroupIndex" value="${paramRulesetGroupIndex}"/>
    <dspel:param name="rulesetIndex" value="${paramRulesetIndex}"/>
    <dspel:param name="type" value="${type}"/>
    <dspel:param name="multisiteMode" value="${multisiteMode}"/>
    <dspel:param name="headerId" value="${headerId}"/>
    <dspel:param name="siteFilterAvailable" value="${siteFilterAvailable}"/>
  </dspel:include>
  
  <%-- Div which contains each of the individual rules inside this ruleset --%>
  <div class="panelContent">
    <c:if test="${multisiteMode and (not (empty paramRuleset.siteFilter))}">
      <dspel:include page="renderSiteFilter.jsp">
        <dspel:param name="rulesetGroupIndex" value="${paramRulesetGroupIndex}"/>
        <dspel:param name="rulesetIndex" value="${0}"/>
        <dspel:param name="rule" value="${paramRuleset.siteFilter}"/>
        <dspel:param name="type" value="${type}"/>
      </dspel:include>
    </c:if>

    <c:forEach var="acceptRule" items="${paramRuleset.acceptRules}" varStatus="acceptLoop">
      <dspel:include page="renderGroupRule.jsp">
        <dspel:param name="rulesetGroupIndex" value="${paramRulesetGroupIndex}"/>
        <dspel:param name="rulesetIndex" value="${0}"/>
        <dspel:param name="rule" value="${acceptRule}"/>
        <dspel:param name="ruleType" value="accept"/>
        <dspel:param name="ruleIndex" value="${acceptLoop.index}"/>
        <dspel:param name="type" value="${type}"/>
      </dspel:include>
    </c:forEach>

    <c:forEach var="rejectRule" items="${paramRuleset.rejectRules}" varStatus="rejectLoop">
      <dspel:include page="renderGroupRule.jsp">
        <dspel:param name="rulesetGroupIndex" value="${paramRulesetGroupIndex}"/>
        <dspel:param name="rulesetIndex" value="${0}"/>
        <dspel:param name="rule" value="${rejectRule}"/>
        <dspel:param name="ruleType" value="reject"/>
        <dspel:param name="ruleIndex" value="${rejectLoop.index}"/>
        <dspel:param name="type" value="${type}"/>
      </dspel:include>
    </c:forEach>
  </div>

</dspel:page>
<%-- @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/expreditor/targeting/renderGroupRuleset.jsp#1 $$Change: 946917 $--%>
