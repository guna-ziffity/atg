<%--
  Page fragment that displays the contents of a targeter, segment or content group.

  @param  model          An ExpressionModel component containing the expression to
                         be edited.
  @param  container      The ID of the page element that contains this fragment.
                         This allows the element to be reloaded when the user
                         interacts with the controls in this editor.
  @param  operation      An optional operation to be performed on the expression
                         prior to rendering it.  Valid values are "updateChoice",
                         "updateLiteral", "updateToken", "addAcceptRule",
                         "addRejectRule", "deleteAcceptRule", "deleteRejectRule",
                         "addRuleset", "deleteRuleset", "moveRulesetUp",
                         "moveRulesetDown", "addRulesetGroup".
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
  @param  expressionType Type of expression (targeter or group)
  @param  groupRenderer  Path to group renderer

  @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/expreditor/targeting/commonExpressionPanelEditor.jsp#1 $$Change: 946917 $
  @updated $DateTime: 2015/01/26 17:26:27 $$Author: jsiddaga $
  --%>

<%@ page pageEncoding="UTF-8" %>

<%@ taglib prefix="c"     uri="http://java.sun.com/jsp/jstl/core"              %>
<%@ taglib prefix="dspel" uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_0" %>
<%@ taglib prefix="fmt"   uri="http://java.sun.com/jsp/jstl/fmt"               %>
<%@ taglib prefix="ee"    uri="http://www.atg.com/taglibs/expreditor_rt"       %>
<%@ taglib prefix="fn"    uri="http://java.sun.com/jsp/jstl/functions"         %>

<dspel:page>

  <%-- Unpack DSP parameters --%>
  <dspel:getvalueof var="paramModel"        param="model"/>
  <dspel:getvalueof var="paramContainer"    param="container"/>
  <dspel:getvalueof var="paramCallback"     param="callback"/>
  <dspel:getvalueof var="paramCallbackData" param="callbackData"/>
  <dspel:getvalueof var="expressionType" param="currentExpressionType"/>
  <dspel:getvalueof var="groupRenderer" param="groupRenderer"/>

  <dspel:importbean var="config" bean="/atg/web/Configuration"/>
  <fmt:setBundle basename="${config.resourceBundle}"/>

  <c:set var="newOverrideHeaderId" value="newHeader" />

  <%-- To prevent JavaScript syntax errors, provide a default value for the callback --%>
  <c:if test="${empty paramCallback}">
    <c:set var="paramCallback" value="null"/>
  </c:if>

  <%-- Unless we are rendering as part of an Ajax request, register this
       expression editor --%>
  <c:if test="${empty param.isAjax}">  
    <c:url var="panelUrl" context="${config.contextRoot}" value="/expreditor/targeting/${expressionType}ExpressionPanel.jsp">
      <c:param name="model"     value="${paramModel}"/>
      <c:param name="container" value="${paramContainer}"/>
      <c:param name="isAjax"    value="1"/>
    </c:url>
    <c:url var="controllerUrl" context="${config.contextRoot}" value="/expreditor/targeting/${expressionType}ExpressionController.jsp">
      <c:param name="model" value="${paramModel}"/>
    </c:url>
    <script type="text/javascript">
      atg.expreditor.registerExpressionEditor("<c:out value='${paramContainer}'/>",
        {
          panelUrl:      "<c:out value='${panelUrl}' escapeXml='false'/>",
          controllerUrl: "<c:out value='${controllerUrl}' escapeXml='false'/>",
          callback:      <c:out value="${paramCallback}"/>,
          callbackData:  "<c:out value='${paramCallbackData}'/>"
        }
      );

      function scrollToNewOverride() {
        var newRulesetGroup = document.getElementById('${newOverrideHeaderId}');
        if (newRulesetGroup) {
          newRulesetGroup.scrollIntoView();
        }
      }

    </script>
  </c:if>

  <%-- Perform the requested operation (if any) on the expression --%>
  <c:if test="${not empty param.operation}">  
    <dspel:include page="/expreditor/targeting/${expressionType}ExpressionController.jsp"/>
    <c:if test="${param.operation == 'addRulesetGroup'}">
      <c:set var="typeWithNewRuleset" value="${param.type}" />
    </c:if>
  </c:if>

  <%-- Render the rulesets. --%>
  <dspel:importbean var="model" bean="${paramModel}"/>
  <ee:isMultisiteMode var="multisiteMode"/>
  <ee:isMultisiteEnabled var="multisiteContent" expressionModel="${model}"/>

  <c:set var="overrideDescriptionRequired" value="${false}"/>
  <c:choose>
    <c:when test="${multisiteMode}">
      <c:set var="ruleGroupOrder">DEFAULT,SITE,SITEGROUP</c:set>
      <c:set var="overrideDescriptionRequired" value="${not empty model.overrideRulesetGroups}"/>
    </c:when>
    <c:otherwise>
      <c:set var="ruleGroupOrder">DEFAULT</c:set>
    </c:otherwise>
  </c:choose>


  <c:forEach var="type" items="${ruleGroupOrder}" varStatus="groupLoop">

    <ee:getRulesetGroupsByType var="rulesetGroups" rulesetGroupType="${type}" expressionModel="${model}"/>
    <c:forEach var="rulesetGroup" items="${rulesetGroups}" varStatus="groupLoop">

      <%-- Render a separator --%>
      <div class="rulesetGroupsSeparator"></div>

      <c:choose>
        <%-- simplify --%>
        <c:when test="${typeWithNewRuleset eq type and groupLoop.index == fn:length(rulesetGroups)-1}">
          <c:set var="headerId" value="${newOverrideHeaderId}" />
        </c:when>
        <c:otherwise>
          <c:set var="headerId" value="${type}_Header${groupLoop.index}" />
        </c:otherwise>
      </c:choose>

      <dspel:include page="${groupRenderer}">
        <dspel:param name="model" value="${paramModel}"/>
        <dspel:param name="container" value="${paramContainer}"/>
        <dspel:param name="rulesetGroup" value="${rulesetGroup}"/> 
        <dspel:param name="rulesetGroupIndex" value="${groupLoop.index}"/>
        <dspel:param name="multisiteMode" value="${multisiteMode}"/>
        <dspel:param name="multisiteContent" value="${multisiteContent}"/>
        <dspel:param name="headerId" value="${headerId}"/>
        <dspel:param name="type" value="${type}"/>
      </dspel:include>

    </c:forEach>
    
    <c:if test="${overrideDescriptionRequired and type eq 'DEFAULT'}" >
      <div class="rulesetGroupsSeparator"></div>
      <div class="overrideLogicDescriptionContainer">
        <fmt:message key="${expressionType}ExpressionPanel.evaluationOrderLogicDescription" />
      </div>
    </c:if>
  </c:forEach>
    
  <c:if test="${multisiteMode}">
    <input type="button" class="small bottom"
           value="<fmt:message key="${expressionType}ExpressionPanel.addSiteOverride"/>"
           onclick="atg.expreditor.performTargetingOperation({containerId: '<c:out value="${paramContainer}"/>',
                                                              operation:   'addRulesetGroup',
                                                              rulesetGroupType: 'SITE',
                                                              callback: scrollToNewOverride})"/>
    <input type="button" class="small bottom"
           value="<fmt:message key="${expressionType}ExpressionPanel.addSiteGroupOverride"/>"
           onclick="atg.expreditor.performTargetingOperation({containerId: '<c:out value="${paramContainer}"/>',
                                                              operation:   'addRulesetGroup',
                                                              rulesetGroupType: 'SITEGROUP',
                                                              callback: scrollToNewOverride})"/>
  </c:if>  

</dspel:page>
<%-- @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/expreditor/targeting/commonExpressionPanelEditor.jsp#1 $$Change: 946917 $--%>
