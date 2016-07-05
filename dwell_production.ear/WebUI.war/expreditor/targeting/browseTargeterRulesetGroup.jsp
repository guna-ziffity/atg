<%--
  @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/expreditor/targeting/browseTargeterRulesetGroup.jsp#1 $$Change: 946917 $
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
  
  <dspel:getvalueof var="paramModel"            param="model"/>
  <dspel:getvalueof var="paramRulesetGroup"      param="rulesetGroup"/>
  <dspel:getvalueof var="paramRulesetGroupIndex" param="rulesetGroupIndex"/>
  <dspel:getvalueof var="multisiteMode" param="multisiteMode"/>
  
  
  <dspel:importbean var="config" bean="/atg/web/Configuration"/>
  <fmt:setBundle basename="${config.resourceBundle}"/>
  
  <dspel:importbean var="model" bean="${paramModel}"/>

  <c:set var="containerClass" value=""/>
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
  
  <div class="${containerClass}">
    
    <c:forEach var="ruleset" items="${paramRulesetGroup.rulesets}" varStatus="rulesetLoop">
      
      <%-- Render a separator between any rulesets after the first one. --%>
      <c:if test="${rulesetLoop.index > 0}">
        <div class="ruleSetSeperator">
          <span><fmt:message key="targeterExpressionPanel.rulesetDivider"/></span>
        </div>
      </c:if>
      
      <dspel:include page="browseTargeterRuleset.jsp">
        <dspel:param name="ruleset" value="${ruleset}"/>
        <dspel:param name="multisiteMode" value="${multisiteMode}"/>
      </dspel:include>
    </c:forEach>
  
  </div>

</dspel:page>

<%-- @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/expreditor/targeting/browseTargeterRulesetGroup.jsp#1 $$Change: 946917 $--%>