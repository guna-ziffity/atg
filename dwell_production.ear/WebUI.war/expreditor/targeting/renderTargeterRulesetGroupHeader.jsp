<%--
  Page fragment that renders a ruleset group header for a targeter.

  @param  container           The ID of the container for this expression editor.
  @param  rulesetGroup        The ruleset group being edited.
  @param  rulesetGroupIndex   The index of the ruleset group being edited.
  @param  headerId            The id of ruleset group header
  @param  type                The type of ruleset group

  @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/expreditor/targeting/renderTargeterRulesetGroupHeader.jsp#1 $$Change: 946917 $
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
  <dspel:getvalueof var="rulesetGroup" param="rulesetGroup"/>
  <dspel:getvalueof var="index" param="rulesetGroupIndex"/>
  <dspel:getvalueof var="headerId" param="headerId"/>
  <dspel:getvalueof var="type" param="type"/>
  
  <dspel:importbean var="config" bean="/atg/web/Configuration"/>
  <fmt:setBundle basename="${config.resourceBundle}"/>

  <c:set var="isNotDefault" value="${type ne 'DEFAULT'}" />

  <%-- TODO: modify styles --%>
  <div class="containerHeader" style="min-height: 20px; height: auto;" id="${headerId}">
     <table>
       <tr>
         <td valign="top" style="width: 100%">
           <dspel:include page="renderRulesetGroupType.jsp">
             <dspel:param name="rulesetGroup" value="${rulesetGroup}"/>
             <dspel:param name="rulesetGroupIndex" value="${index}"/>
             <dspel:param name="type" value="${type}"/>
           </dspel:include>
         </td>
         <td valign="top" style="width: 50px">
           <div style="height: 20px; width: 50px; overflow:hidden;">
           <c:if test="${isNotDefault}" >
            <%-- default rulesetGroup can't be deleted --%>

            <fmt:message var="overrideTypeName" key="${type == 'SITE' ? 'siteOverrideTypeName' : 'siteGroupOverrideTypeName'}" />
            <fmt:message var="deleteButtonTitle" key='renderGroupRuleset.deleteSiteOverrideRule'>
              <fmt:param value="${overrideTypeName}"/>
            </fmt:message>

             <a href="#" class="iconPanelClose"
                title="<c:out value='${deleteButtonTitle}' />"
                onclick="atg.expreditor.performTargetingOperation({
                         containerId:  '<c:out value="${container}"/>',
                         rulesetGroupIndex: '<c:out value="${index}"/>',
                         operation:    'deleteRulesetGroup',
                         rulesetGroupType: '${type}'})"></a>
           </c:if>
           <a href="#" class="iconPanelMinimize rulesTrigger"
              title="<fmt:message key="renderTargeterRulesetGroup.hideRulesets"/>"
              onclick="atg.expreditor.rulesDisplay(
                       this,
                       '<fmt:message key="renderTargeterRuleset.hideRuleset"/>',
                       '<fmt:message key="renderTargeterRuleset.showRuleset"/>');"></a>
           </div>
        </td>
      </tr>
    </table>
  </div>
  
</dspel:page>
<%-- @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/expreditor/targeting/renderTargeterRulesetGroupHeader.jsp#1 $$Change: 946917 $--%>