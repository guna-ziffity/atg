<%--
  Page fragment that renders a site list expression.

  @param  ruleType            The type of rule (either accept or reject).
  @param  rulesetGroup        The ruleset group being edited.
  @param  rulesetGroupIndex   The index of the ruleset group being edited.

  @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/expreditor/targeting/renderRulesetGroupType.jsp#1 $$Change: 946917 $
  @updated $DateTime: 2015/01/26 17:26:27 $$Author: jsiddaga $
  --%>

<%@ taglib prefix="c"
    uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt"
    uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="dspel"
    uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_0"%>
<%@ taglib prefix="ee"
    uri="http://www.atg.com/taglibs/expreditor_rt"%>

<dspel:page>
  
  <dspel:getvalueof var="rulesetType" param="rulesetType"/>
  <dspel:getvalueof var="rulesetGroup" param="rulesetGroup"/>
  <dspel:getvalueof var="rulesetGroupIndex" param="rulesetGroupIndex"/>
  <dspel:getvalueof var="rulesetGroupType" param="type"/>
  
  <%-- Create an ID for the expression editor containing info about this rule --%>
  <ee:createTargetingExpressionId var="exprid"
      rulesetGroupType="${rulesetGroupType}"
      rulesetGroupIndex="${rulesetGroupIndex}"
      rulesetIndex="${0}"
      ruleType="siteList"
      ruleIndex="${0}"
      conditionType="content"/>
  
  <%-- Render the condition being used to edit this rule --%>
  <ee:getTerminalEditors var="editors" expression="${rulesetGroup.typeExpression}"/>
  <c:forEach var="editor" items="${editors}">
    <dspel:include otherContext="${editor.contextRoot}" page="${editor.page}">
      <dspel:param name="expression" value="${editor.expression}"/>
      <dspel:param name="editorId" value="${exprid}"/>
    </dspel:include>
  </c:forEach>
</dspel:page>

<%-- @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/expreditor/targeting/renderRulesetGroupType.jsp#1 $$Change: 946917 $--%>