<%--
  Page fragment that renders a site filter expression.

  @param  rulesetIndex        The index of the ruleset being edited inside an expression service.
  @param  rule                The rule being rendered.
  @param  ruleType            The type of rule (either accept or reject).
  @param  ruleIndex           The index of the rule being rendered.
  @param  container           The ID of the container for this expression editor.
  @param  overrideRuleset     Defines rendering mode, true for rulesets (targeters), 
                              false for rules (content groups / user segments).
  @param  rulesetGroupIndex   The index of the ruleset group being edited.

  @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/expreditor/targeting/renderSiteFilter.jsp#1 $$Change: 946917 $
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

  <%-- Unpack DSP parameters --%>
  <dspel:getvalueof var="rulesetIndex" param="rulesetIndex"/>
  <dspel:getvalueof var="paramRule" param="rule"/>
  <dspel:getvalueof var="paramRuleType" param="ruleType"/>
  <dspel:getvalueof var="paramRuleIndex" param="ruleIndex"/>
  <dspel:getvalueof var="paramContainer" param="container"/>
  <dspel:getvalueof var="overrideRuleset" param="overrideRuleset"/>
  <dspel:getvalueof var="rulesetGroupIndex" param="rulesetGroupIndex"/>
  <dspel:getvalueof var="type" param="type"/>
  
  <dspel:importbean var="config" bean="/atg/web/Configuration"/>
  <fmt:setBundle basename="${config.resourceBundle}"/>

  
  <%-- Render the header and any toolbar buttons --%>
  <div class="panelHeader">
    <h5><fmt:message key="renderGroupRuleset.asSeenOn" /></h5>
    <div class="actions">
      <a class="iconPanelClose"
          title="<fmt:message key="renderGroupRule.deleteRule"/>"
          href="javascript:atg.expreditor.performTargetingOperation({
              containerId: '<c:out value="${paramContainer}"/>',
              rulesetGroupIndex: '<c:out value="${rulesetGroupIndex}"/>',
              rulesetIndex: '<c:out value="${rulesetIndex}"/>',
              ruleIndex: '<c:out value="${paramRuleIndex}"/>',
              operation: 'deleteSiteFilterDefinition',
              rulesetGroupType: '<c:out value="${type}"/>'})"></a>

      <a href="#" class="iconPanelMinimize rulesTrigger"
          title="<fmt:message key="renderGroupRule.hideRule"/>"
          onclick="atg.expreditor.rulesDisplay(
              this,
              '<fmt:message key="renderGroupRule.hideRule"/>',
              '<fmt:message key="renderGroupRule.showRule"/>');"></a>
    </div>
  </div>
  <%-- Render the div and table that enclose each Include or Exclude rule --%>
  <div class="panelContent expressionBlocks">
    <table>
      <tr>
        <td colspan="2" style="border:none;">
          <%-- Create an ID for the expression editor containing info about this rule --%>
          <ee:createTargetingExpressionId var="editorId"
              rulesetGroupType="${type}"
              rulesetGroupIndex="${rulesetGroupIndex}"
              rulesetIndex="${rulesetIndex}"
              ruleType="siteFilter"
              ruleIndex="${0}"
              conditionType="content"/>
          <%-- Render the condition being used to edit this rule --%>
          <ee:getTerminalEditors var="editors" expression="${paramRule.expression}"/>
          <c:forEach var="editor" items="${editors}">
            <dspel:include otherContext="${editor.contextRoot}" page="${editor.page}">
              <dspel:param name="expression" value="${editor.expression}"/>
              <dspel:param name="editorId" value="${editorId}"/>
            </dspel:include>
          </c:forEach>
        </td>
      </tr>
    </table>
  </div>

</dspel:page>
<%-- @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/expreditor/targeting/renderSiteFilter.jsp#1 $$Change: 946917 $--%>
