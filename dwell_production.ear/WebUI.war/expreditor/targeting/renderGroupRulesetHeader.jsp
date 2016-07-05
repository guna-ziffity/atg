<%--
  Page fragment that renders a ruleset group header for segment or content group.

  @param  container           The ID of the container for this expression editor.
  @param  rulesetGroup        The ruleset group being edited.
  @param  index               The index of the ruleset being edited inside an expression service.
  @param  multisiteMode       True if we are in a multisite mode.
  @param  override            Defines rendering mode, true for rulesets (targeters), 
                              false for rules (content groups / user segments).
  @param  siteFilterAvailable True if site filer should be displayed.
  @param  type                The type of ruleset group
  @param  headerId            Thee id of header element

  @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/expreditor/targeting/renderGroupRulesetHeader.jsp#1 $$Change: 946917 $
  @updated $DateTime: 2015/01/26 17:26:27 $$Author: jsiddaga $
  --%>

<%@ taglib prefix="c"
    uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="dspel"
    uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_0"%>
<%@ taglib prefix="fmt"
    uri="http://java.sun.com/jsp/jstl/fmt"%>

<dspel:page>

  <dspel:getvalueof var="container" param="container"/>
  <dspel:getvalueof var="ruleset" param="ruleset"/>
  <dspel:getvalueof var="rulesetGroup" param="rulesetGroup"/>
  <dspel:getvalueof var="rulesetGroupIndex" param="rulesetGroupIndex"/>
  <dspel:getvalueof var="index" param="rulesetIndex"/>
  <dspel:getvalueof var="type" param="type"/>
  <dspel:getvalueof var="multisiteMode" param="multisiteMode"/>
  <dspel:getvalueof var="siteFilterAvailable" param="siteFilterAvailable"/>
  <dspel:getvalueof var="headerId" param="headerId"/>

  <dspel:importbean var="config" bean="/atg/web/Configuration"/>
  <fmt:setBundle basename="${config.resourceBundle}"/>

  <div class="panelHeader" id="${headerId}">
    <div valign="middle" style="float:left">
      <c:choose>
        <c:when test="${multisiteMode}">
          <dspel:include page="renderRulesetGroupType.jsp">
            <dspel:param name="rulesetGroup" value="${rulesetGroup}"/>
            <dspel:param name="rulesetGroupIndex" value="${rulesetGroupIndex}"/>
           </dspel:include>
        </c:when>
        <c:otherwise>
          <h5><fmt:message key="renderGroupRuleset.rulesetTitle" /></h5>
        </c:otherwise>
      </c:choose>
    </div>

    <div class="actions">
      <c:if test="${type ne 'DEFAULT'}">

        <fmt:message var="overrideTypeName" key="${type == 'SITE' ? 'siteOverrideTypeName' : 'siteGroupOverrideTypeName'}" />
        <fmt:message var="deleteButtonTitle" key='renderGroupRuleset.deleteSiteOverrideRule'>
          <fmt:param value="${overrideTypeName}"/>
        </fmt:message>

        <a class="iconPanelClose"
           title="<c:out value='${deleteButtonTitle}' />"
            href="javascript:atg.expreditor.performTargetingOperation({
                    containerId: '<c:out value="${container}"/>',
                    rulesetIndex: '<c:out value="${index}"/>',
                    operation:    'deleteRulesetGroup',
                    rulesetGroupIndex: '<c:out value="${rulesetGroupIndex}"/>',
                    rulesetGroupType: '<c:out value="${type}"/>'})"></a>
      </c:if>
      <fmt:message key="renderGroupRuleset.toolbarTitle"/>
      <c:if test="${siteFilterAvailable}">
        <input type="button"
            <c:choose>
              <c:when test="${not empty ruleset.siteFilter}">
                class="small disabled"
                onclick="return false"
              </c:when>
              <c:otherwise>
                class="small"
                onclick="atg.expreditor.performTargetingOperation({
                    containerId:  '<c:out value="${container}"/>',
                    rulesetIndex: '<c:out value="${index}"/>',
                    operation:    'addSiteFilterDefinition',
                    rulesetGroupIndex: '<c:out value="${rulesetGroupIndex}"/>',
                    rulesetGroupType: '<c:out value="${type}"/>'})"
              </c:otherwise>
            </c:choose>
            value="<fmt:message key='renderGroupRuleset.asSeenOn'/>"/>
      </c:if>
      
      <input type="button" class="small"
          value="<fmt:message key='renderGroupRuleset.includeRule'/>"
          onclick="atg.expreditor.performTargetingOperation({
                  containerId:  '<c:out value="${container}"/>',
                  rulesetIndex: '<c:out value="${index}"/>',
                  operation:    'addAcceptRule',
                  rulesetGroupIndex: '<c:out value="${rulesetGroupIndex}"/>',
                  rulesetGroupType: '<c:out value="${type}"/>'})"/>
      <input type="button" class="small"
          value="<fmt:message key='renderGroupRuleset.excludeRule'/>"
          onclick="atg.expreditor.performTargetingOperation({
                  containerId:  '<c:out value="${container}"/>',
                  rulesetIndex: '<c:out value="${index}"/>',
                  operation:    'addRejectRule',
                  rulesetGroupIndex: '<c:out value="${rulesetGroupIndex}"/>',
                  rulesetGroupType: '<c:out value="${type}"/>'})"/>
    </div>
  </div>
  
</dspel:page>

<%-- @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/expreditor/targeting/renderGroupRulesetHeader.jsp#1 $$Change: 946917 $--%>