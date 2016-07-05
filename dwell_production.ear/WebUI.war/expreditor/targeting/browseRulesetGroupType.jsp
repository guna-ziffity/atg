<%--
  @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/expreditor/targeting/browseRulesetGroupType.jsp#1 $$Change: 946917 $
--%>

<%@ taglib prefix="c"
    uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt"
    uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="dspel"
    uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_0"%>
<%@ taglib prefix="ee"
    uri="http://www.atg.com/taglibs/expreditor_rt"%>
<%@ taglib prefix="web-ui"
    uri="http://www.atg.com/taglibs/web-ui_rt"%>

<dspel:page>
  
  <dspel:getvalueof var="paramRulesetGroup" param="rulesetGroup"/>
  
  <dspel:importbean var="config" bean="/atg/web/Configuration"/>
  <fmt:setBundle basename="${config.resourceBundle}"/>
  
  <web-ui:renderExpression var="expression"
          expression="${paramRulesetGroup.typeExpression}"/> 
  <table>
    <tr>
      <td>
        <h5 style="padding-right: 5px; padding-left: 5px;">
          <c:out value="${expression}"/>
        </h5>
      </td>
    </tr>
  </table>

</dspel:page>

<%-- @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/expreditor/targeting/browseRulesetGroupType.jsp#1 $$Change: 946917 $--%>