<%--
  Page fragment that displays the contents of a segment or content group.

  @param  model          An ExpressionModel component containing the expression to
                         be edited.
  @param  container      The ID of the page element that contains this fragment.
                         This allows the element to be reloaded when the user
                         interacts with the controls in this editor.
  @param  operation      An optional operation to be performed on the expression
                         prior to rendering it.  Valid values are "updateChoice",
                         "updateLiteral", "updateToken", "addAcceptRule",
                         "addRejectRule", "deleteAcceptRule", "deleteRejectRule"
  @param  terminalId     The ID of the sub-expression on which the given operation
                         is to be performed.
  @param  value          The value to be assigned to the sub-expression on which
                         the given operation is to be performed.

  @param  editorId       An encoded id string of the form
                         ruleset_rulesetIndex_ruleType_ruleIndex_conditionType,
                         where rulesetIndex is the index of the ruleset to
                         operate on within the segment or group, ruleType is the
                         type of rule to operate on within the ruleset, ruleIndex
                         is the index of the rule within the ruleset, and
                         conditionType is the type of condition being edited
                         within the rule.
  @param  rulesetIndex   The index of the ruleset to operate on within the
                         segment or group.
  @param  ruleIndex      The index of the rule within the ruleset.
  @param  callback       A JavaScript function to be called when the expression is
                         changed
  @param  callbackData   A string to be passed to the callback function

  @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/expreditor/targeting/groupExpressionPanel.jsp#1 $$Change: 946917 $
  @updated $DateTime: 2015/01/26 17:26:27 $$Author: jsiddaga $
  --%>

<%@ page pageEncoding="UTF-8" %>

<%@ taglib prefix="c"     uri="http://java.sun.com/jsp/jstl/core"              %>
<%@ taglib prefix="dspel" uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_0" %>
<%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt"              %>
<%@ taglib prefix="ee"    uri="http://www.atg.com/taglibs/expreditor_rt"       %>

<dspel:page>

  <%-- Unpack DSP parameters --%>
  <dspel:getvalueof var="paramModel"        param="model"/>
  <dspel:getvalueof var="paramContainer"    param="container"/>
  <dspel:getvalueof var="paramCallback"     param="callback"/>
  <dspel:getvalueof var="paramCallbackData" param="callbackData"/>

  <dspel:include page="commonExpressionPanelEditor.jsp">
    <dspel:param name="model" value="${paramModel}"/>
    <dspel:param name="container" value="${paramContainer}"/>
    <dspel:param name="callback" value="${paramCallback}"/>
    <dspel:param name="callbackData" value="${paramCallbackData}"/>
    <dspel:param name="currentExpressionType" value="group"/>
    <dspel:param name="groupRenderer" value="/expreditor/targeting/renderGroupRulesetGroup.jsp"/>
  </dspel:include>

</dspel:page>
<%-- @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/expreditor/targeting/groupExpressionPanel.jsp#1 $$Change: 946917 $--%>
