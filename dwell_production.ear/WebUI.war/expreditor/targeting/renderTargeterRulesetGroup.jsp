<%--
  Page fragment that renders a single ruleset group inside of a targeter.

  @param  model               An ExpressionModel component containing the expression to
                              be edited.
  @param  container           The ID of the container for this expression editor.
  @param  rulesetGroup        The ruleset group being edited.
  @param  rulesetGroupIndex   The index of the ruleset group being edited.
  @param  multisiteMode       True if we are in a multisite mode.
  @param  type                The type of ruleset group
  @param  headerId            The Id of group header

  @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/expreditor/targeting/renderTargeterRulesetGroup.jsp#1 $$Change: 946917 $
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
  
  <dspel:importbean var="config" bean="/atg/web/Configuration"/>
  <fmt:setBundle basename="${config.resourceBundle}"/>
  
  <dspel:importbean var="model" bean="${paramModel}"/>
  
  <c:set var="containerClass" value=""/>
  <c:if test="${multisiteMode}" >
    <dspel:include page="renderTargeterRulesetGroupHeader.jsp">
      <dspel:param name="container" value="${paramContainer}"/>
      <dspel:param name="rulesetGroup" value="${rulesetGroup}"/>
      <dspel:param name="rulesetGroupIndex" value="${rulesetGroupIndex}"/>
      <dspel:param name="type" value="${type}"/>
      <dspel:param name="headerId" value="${headerId}"/>
    </dspel:include>
    <c:set var="containerClass" value="containerContent"/>
  </c:if>

  <div class="${containerClass}">
    
    <c:forEach var="ruleset" items="${rulesetGroup.rulesets}" varStatus="rulesetLoop">
      
      <%-- Render a separator between any rulesets after the first one. --%>
      <c:if test="${rulesetLoop.index > 0}">
        <div class="ruleSetSeperator">
          <span><fmt:message key="targeterExpressionPanel.rulesetDivider"/></span>
        </div>
      </c:if>

      <dspel:include page="renderTargeterRuleset.jsp">
        <dspel:param name="ruleset" value="${ruleset}"/>
        <dspel:param name="rulesetIndex" value="${rulesetLoop.index}"/>
        <dspel:param name="rulesetGroupIndex" value="${rulesetGroupIndex}"/>
        <dspel:param name="multisiteMode" value="${multisiteMode}"/>
        <dspel:param name="multisiteContent" value="${multisiteContent}"/>
        <dspel:param name="type" value="${type}"/>
      </dspel:include>
    </c:forEach>
  
    <input type="button" class="small bottom"
           value="<fmt:message key="targeterExpressionPanel.addRuleSet"/>"
           onclick="atg.expreditor.performTargetingOperation({containerId: '<c:out value="${paramContainer}"/>',
                                                              rulesetGroupIndex: '<c:out value="${rulesetGroupIndex}"/>',
                                                              operation:   'addRuleset',
                                                              rulesetGroupType: '<c:out value="${type}"/>'})"/>
                                                                
  </div>

</dspel:page>

<%-- @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/expreditor/targeting/renderTargeterRulesetGroup.jsp#1 $$Change: 946917 $--%>