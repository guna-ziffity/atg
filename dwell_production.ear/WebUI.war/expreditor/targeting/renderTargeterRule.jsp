<%--
  Page fragment that renders a single Show or Hide rule inside of a
  targeter. Targeter rules contain 4 distinct sets of conditions related
  to People, Content, Time, and Environment.

  @param  rulesetIndex        The index of the ruleset that contains the rule.
  @param  rule                The rule being rendered.
  @param  ruleType            The type of rule (either accept or reject).
  @param  ruleIndex           The index of the rule being rendered.
  @param  container           The ID of the container for this expression editor
  @param  rulesetGroupIndex   The index of the ruleset group being edited.
  @param  type                The type of ruleset group

  @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/expreditor/targeting/renderTargeterRule.jsp#1 $$Change: 946917 $
  @updated $DateTime: 2015/01/26 17:26:27 $$Author: jsiddaga $
  --%>

<%@ taglib prefix="c"     uri="http://java.sun.com/jsp/jstl/core"              %>
<%@ taglib prefix="dspel" uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_0" %>
<%@ taglib prefix="fmt"   uri="http://java.sun.com/jsp/jstl/fmt"               %>
<%@ taglib prefix="ee"    uri="http://www.atg.com/taglibs/expreditor_rt"       %>

<dspel:page>

  <%-- Unpack DSP parameters --%>
  <dspel:getvalueof var="paramRulesetIndex" param="rulesetIndex"/>
  <dspel:getvalueof var="paramRule" param="rule"/>
  <dspel:getvalueof var="paramRuleType" param="ruleType"/>
  <dspel:getvalueof var="paramRuleIndex" param="ruleIndex"/>
  <dspel:getvalueof var="paramContainer" param="container"/>
  <dspel:getvalueof var="rulesetGroupIndex" param="rulesetGroupIndex"/>
  <dspel:getvalueof var="type" param="type"/>

  <dspel:importbean var="config" bean="/atg/web/Configuration"/>
  <fmt:setBundle basename="${config.resourceBundle}"/>

  <%-- Determine the operation to be invoked to delete this rule. --%>
  <c:if test="${paramRuleType eq 'accept'}">
     <c:set var="operation" value="deleteAcceptRule"/>
  </c:if>
  <c:if test="${paramRuleType eq 'reject'}">
     <c:set var="operation" value="deleteRejectRule"/>
  </c:if>

  <%-- Render the header and any toolbar buttons --%>
  <div class="panelHeader">
    <h5>
      <fmt:message key="renderTargeterRuleset.${paramRule.isAcceptRule ? 'show' : 'hide'}Rule"/>
    </h5>
    <div class="actions">
      <a href="#" class="iconPanelClose"
         title="<fmt:message key="renderGroupRule.deleteRule"/>"
         onclick="atg.expreditor.performTargetingOperation({containerId:  '<c:out value="${paramContainer}"/>',
                                                            rulesetIndex: '<c:out value="${paramRulesetIndex}"/>',
                                                            ruleIndex:    '<c:out value="${paramRuleIndex}"/>',
                                                            rulesetGroupIndex: '<c:out value="${rulesetGroupIndex}"/>',
                                                            operation:    '<c:out value="${operation}"/>',
                                                            rulesetGroupType: '<c:out value="${type}"/>'})"></a>

      <a href="#" class="iconPanelMinimize rulesTrigger"
         title="<fmt:message key="renderGroupRule.hideRule"/>"
         onclick="atg.expreditor.rulesDisplay(this,
                                             '<fmt:message key="renderGroupRule.hideRule"/>',
                                             '<fmt:message key="renderGroupRule.showRule"/>');"></a>


    </div>
  </div>

  <%-- Render each of the conditions being used to edit this rule --%>
  <div class="panelContent expressionBlocks ruleSetContent">
    <table width="100%" class="ruleSet">

      <%-- Render the content conditions --%>
      <tr>
        <td class="ruleSetLabel" nowrap="nowrap">
          <fmt:message key="renderTargeterRule.ContentConditionTitle"/>
        </td>

        <td class="ruleSetExpression">
          <table>
            <tr>
              <td colspan="2">
                <ee:createTargetingExpressionId var="editorId"
                                                rulesetGroupType="${type}"
                                                rulesetGroupIndex="${rulesetGroupIndex}"
                                                rulesetIndex="${paramRulesetIndex}"
                                                ruleType="${paramRuleType}"
                                                ruleIndex="${paramRuleIndex}"
                                                conditionType="content"/>
                <ee:getTerminalEditors var="editors" expression="${paramRule.contentSubExpression}"/>
                <c:forEach var="editor" items="${editors}">
                  <dspel:include otherContext="${editor.contextRoot}" page="${editor.page}">
                    <dspel:param name="expression" value="${editor.expression}"/>
                    <dspel:param name="editorId" value="${editorId}"/>
                  </dspel:include>
                </c:forEach>
              </td>
            </tr>
          </table>
        </td>
      </tr>

      <%-- Render the people conditions --%>
      <tr>
        <td class="ruleSetLabel" nowrap="nowrap">
          <fmt:message key="renderTargeterRule.PeopleConditionTitle"/>
        </td>

        <td class="ruleSetExpression">
          <table>
            <tr>
              <td colspan="2">
                <ee:createTargetingExpressionId var="editorId"
                                                rulesetGroupType="${type}"
                                                rulesetGroupIndex="${rulesetGroupIndex}"                
                                                rulesetIndex="${paramRulesetIndex}"
                                                ruleType="${paramRuleType}"
                                                ruleIndex="${paramRuleIndex}"
                                                conditionType="people"/>
                <ee:getTerminalEditors var="editors" expression="${paramRule.peopleSubExpression}"/>
                <c:forEach var="editor" items="${editors}">
                  <dspel:include otherContext="${editor.contextRoot}" page="${editor.page}">
                    <dspel:param name="expression" value="${editor.expression}"/>
                    <dspel:param name="editorId" value="${editorId}"/>
                  </dspel:include>
                </c:forEach>
              </td>
            </tr>
          </table>
        </td>
      </tr>

      <%-- Render the time conditions --%>
      <tr>
        <td class="ruleSetLabel" nowrap="nowrap">
          <fmt:message key="renderTargeterRule.TimeConditionTitle"/>
        </td>

        <td class="ruleSetExpression">
          <table>
            <tr>
              <td colspan="2">
                <ee:createTargetingExpressionId var="editorId"
                                                rulesetGroupType="${type}"
                                                rulesetGroupIndex="${rulesetGroupIndex}"                
                                                rulesetIndex="${paramRulesetIndex}"
                                                ruleType="${paramRuleType}"
                                                ruleIndex="${paramRuleIndex}"
                                                conditionType="time"/>
                <ee:getTerminalEditors var="editors" expression="${paramRule.timeSubExpression}"/>
                <c:forEach var="editor" items="${editors}">
                  <dspel:include otherContext="${editor.contextRoot}" page="${editor.page}">
                    <dspel:param name="expression" value="${editor.expression}"/>
                    <dspel:param name="editorId" value="${editorId}"/>
                  </dspel:include>
                </c:forEach>
              </td>
            </tr>
          </table>
        </td>
      </tr>

      <%-- Render the environment conditions --%>
      <tr>
        <td class="ruleSetLabel last" nowrap="nowrap">
          <fmt:message key="renderTargeterRule.EnvironmentConditionTitle"/>
        </td>

        <td class="ruleSetExpression last">
          <table>
            <tr>
              <td colspan="2">
                <ee:createTargetingExpressionId var="editorId"
                                                rulesetGroupType="${type}"
                                                rulesetGroupIndex="${rulesetGroupIndex}"
                                                rulesetIndex="${paramRulesetIndex}"
                                                ruleType="${paramRuleType}"
                                                ruleIndex="${paramRuleIndex}"
                                                conditionType="environment"/>
                <ee:getTerminalEditors var="editors" expression="${paramRule.environmentSubExpression}"/>
                <c:forEach var="editor" items="${editors}">
                  <dspel:include otherContext="${editor.contextRoot}" page="${editor.page}">
                    <dspel:param name="expression" value="${editor.expression}"/>
                    <dspel:param name="editorId" value="${editorId}"/>
                  </dspel:include>
                </c:forEach>
              </td>
            </tr>
          </table>
        </td>
      </tr>

    </table>
  </div>

</dspel:page>
<%-- @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/expreditor/targeting/renderTargeterRule.jsp#1 $$Change: 946917 $--%>
