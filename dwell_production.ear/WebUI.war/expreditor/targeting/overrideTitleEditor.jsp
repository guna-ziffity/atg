<%--
  An expression editor for ruleset group titles.

  @param  expression  The expression to be rendered

  @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/expreditor/targeting/overrideTitleEditor.jsp#1 $$Change: 946917 $
  @updated $DateTime: 2015/01/26 17:26:27 $$Author: jsiddaga $
  --%>

<%@ taglib prefix="c"     uri="http://java.sun.com/jsp/jstl/core"              %>
<%@ taglib prefix="dspel" uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_0" %>

<dspel:page>

  <%-- Unpack DSP parameters --%>
  <dspel:getvalueof var="paramExpression" param="expression"/>
  <h5 style="padding-right: 5px; padding-left: 5px;" >
    <c:out value="${paramExpression.text}"/>
  </h5>

</dspel:page>
<%-- @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/expreditor/targeting/overrideTitleEditor.jsp#1 $$Change: 946917 $--%>
