<%--
  Page fragment that displays an expression editor for editing scenario actions.

  @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/expreditor/scenario/actionEditor.jsp#1 $ $Change: 946917 $
  @updated $DateTime: 2015/01/26 17:26:27 $ $Author: jsiddaga $
  --%>

<%@ taglib prefix="c"     uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="dspel" uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_0" %>

<dspel:page>

  <c:set var="actionModel" value="/atg/web/scenario/ActionExpressionModel"/>
  <c:set var="containerId" value="expreditorContainer"/>

  <div class="expreditorContainer">
    <div id="<c:out value='${containerId}'/>" class="expreditorPanel">
      <dspel:include page="/expreditor/inlineExpressionPanel.jsp">
        <dspel:param name="model" value="${actionModel}"/>
        <dspel:param name="container" value="${containerId}"/>
      </dspel:include>
    </div>
  </div>

</dspel:page>
<%-- @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/expreditor/scenario/actionEditor.jsp#1 $ $Change: 946917 $ --%>
