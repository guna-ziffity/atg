<%--
  Page fragment that displays a read-only view of a single Include or Exclude
  rule inside of a segment or content group.

  @param  rule          The rule being rendered.

  @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/expreditor/targeting/browseGroupRule.jsp#1 $$Change: 946917 $
  @updated $DateTime: 2015/01/26 17:26:27 $$Author: jsiddaga $
  --%>

<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core"                    %>
<%@ taglib prefix="dspel"  uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_0" %>
<%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt"                     %>
<%@ taglib prefix="web-ui" uri="http://www.atg.com/taglibs/web-ui_rt"                %>

<dspel:page>

  <%-- Unpack all DSP parameters (see coding standards for more info) --%>
  <dspel:getvalueof var="paramRule" param="rule"/>

  <dspel:importbean var="config" bean="/atg/web/Configuration"/>
  <fmt:setBundle basename="${config.resourceBundle}"/>

  <%-- Titlebar --%>
  <div class="panelHeader">
    <h5>
      <fmt:message key="renderGroupRuleset.${paramRule.isAcceptRule ? 'include' : 'exclude'}Rule"/>
    </h5>
  </div>

  <%-- Render the div and table that enclose each Include or Exclude rule --%>
  <div class="panelContent expressionBlocks">
    <table>
      <tr>
        <td colspan="2" style="border:none;">
          <%-- Render the expression. --%>
          <web-ui:renderExpression var="expression"
                                   expression="${paramRule.contentSubExpression}"/>
          <c:out value="${expression}"/>
        </td>
      </tr>
    </table>
  </div>

</dspel:page>
<%-- @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/expreditor/targeting/browseGroupRule.jsp#1 $$Change: 946917 $--%>
