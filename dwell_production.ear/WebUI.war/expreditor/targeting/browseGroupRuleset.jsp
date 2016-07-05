<%--
  Page fragment that displays a read-only view of a single ruleset inside of a
  segment or content group.

  @param  ruleset         The ruleset being edited.
  @param  rulesetIndex    The index of the ruleset being edited inside an expression service.
  @param  type            The type of ruleset
  @param  multisiteMode   Indicates whether multisite mode is on.

  @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/expreditor/targeting/browseGroupRuleset.jsp#1 $$Change: 946917 $
  @updated $DateTime: 2015/01/26 17:26:27 $$Author: jsiddaga $
  --%>

<%@ taglib prefix="c"
    uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="dspel"
    uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_0"%>
<%@ taglib prefix="fmt"
    uri="http://java.sun.com/jsp/jstl/fmt"%>

<dspel:page>

  <%-- Unpack all DSP parameters (see coding standards for more info) --%>
  <dspel:getvalueof var="paramRulesetGroup" param="rulesetGroup"/>
  <dspel:getvalueof var="paramRuleset" param="ruleset"/>
  <dspel:getvalueof var="multisiteMode" param="multisiteMode"/>
  <dspel:getvalueof var="type" param="type"/>
  
  <dspel:importbean var="config" bean="/atg/web/Configuration"/>
  <fmt:setBundle basename="${config.resourceBundle}"/>

  <c:set var="typeIsNotDefault" value="${type ne 'DEFAULT'}" />

  <c:if test="${multisiteMode}" >
    <div class="containerHeader" style="min-height: 20px; height: auto">
      <table>
        <tr>
          <td valign="middle" style="width: 100%">
            <dspel:include page="browseRulesetGroupType.jsp">
              <dspel:param name="rulesetGroup" value="${paramRulesetGroup}"/>
            </dspel:include>
          </td>
        </tr>
      </table>
    </div>
    <c:set var="containerClass" value="containerContent"/>
  </c:if>

  <%-- Div which contains each of the individual rules inside this ruleset --%>
  <div class="${containerClass}">
    <c:if test="${multisiteMode and (not (empty paramRuleset.siteFilter))}">
      <dspel:include page="browseSiteFilter.jsp">
        <dspel:param name="rule" value="${paramRuleset.siteFilter}"/>
      </dspel:include>
    </c:if>
    
    <c:forEach var="acceptRule" items="${paramRuleset.acceptRules}" varStatus="acceptLoop">
      <dspel:include page="browseGroupRule.jsp">
        <dspel:param name="rule" value="${acceptRule}"/>
      </dspel:include>
    </c:forEach>
    
    <c:forEach var="rejectRule" items="${paramRuleset.rejectRules}" varStatus="rejectLoop">
      <dspel:include page="browseGroupRule.jsp">
        <dspel:param name="rule" value="${rejectRule}"/>
      </dspel:include>
    </c:forEach>
  </div>

</dspel:page>
<%-- @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/expreditor/targeting/browseGroupRuleset.jsp#1 $$Change: 946917 $--%>
