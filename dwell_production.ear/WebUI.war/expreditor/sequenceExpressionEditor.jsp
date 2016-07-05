<%--
  An expression editor for SequenceExpression instances.

  This page expects the following parameters:
    expression - The Expression instance to be rendered

  @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/expreditor/sequenceExpressionEditor.jsp#1 $$Change: 946917 $
  @updated $DateTime: 2015/01/26 17:26:27 $$Author: jsiddaga $
  --%>

<%@ taglib prefix="c"     uri="http://java.sun.com/jsp/jstl/core"                    %>
<%@ taglib prefix="dspel" uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_0" %>

<dspel:page>

  <%-- Unpack all DSP parameters (see coding standards for more info) --%>
  <dspel:getvalueof var="paramExpression" param="expression"/>

  <%-- Render all of this expression's children --%>
  <c:forEach var="childExpression" items="${paramExpression.elements}">
    <dspel:include page="renderExpression.jsp">
      <dspel:param name="expression" value="${childExpression}"/>
    </dspel:include>
  </c:forEach>

</dspel:page>
<%-- @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/expreditor/sequenceExpressionEditor.jsp#1 $$Change: 946917 $ --%>
