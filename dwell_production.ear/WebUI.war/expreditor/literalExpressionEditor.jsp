<%--
  An expression editor for LiteralExpression instances.

  This page expects the following parameters:
    expression - The Expression instance to be rendered
    renderTerminal - Flag indicating whether to actually render the expression

  @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/expreditor/literalExpressionEditor.jsp#1 $$Change: 946917 $
  @updated $DateTime: 2015/01/26 17:26:27 $$Author: jsiddaga $
  --%>

<%@ taglib prefix="c"     uri="http://java.sun.com/jsp/jstl/core"                    %>
<%@ taglib prefix="dspel" uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_0" %>

<dspel:page>

  <%-- Unpack all DSP parameters (see coding standards for more info) --%>
  <dspel:getvalueof var="paramExpression"     param="expression"/>
  <dspel:getvalueof var="paramRenderTerminal" param="renderTerminal"/>

  <c:choose>
    <c:when test="${paramRenderTerminal}">

      <%-- Render our literal editor --%>
      <input type="text"
             id="literal_<c:out value='${paramExpression.identifier}'/>"
             value="<c:out value='${paramExpression.value}'/>"
             onchange="literalExprUpdated('literal_<c:out value="${paramExpression.identifier}"/>', 
                                          '<c:out value="${paramExpression.identifier}"/>')"/>

    </c:when>
    <c:otherwise>

      <%-- Render a page that may end up recursively including this page again,
           passing the renderTerminal flag.  This should be re-written once we
           support JSP2.0 to use the OPARAM equivalent that allows you to pass
           a template to a child page to render in its context. --%>
      <dspel:include page="terminalExpressionEditor.jsp">
        <dspel:param name="expression" value="${paramExpression}"/>
      </dspel:include>

    </c:otherwise>
  </c:choose>
</dspel:page>
<%-- @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/expreditor/literalExpressionEditor.jsp#1 $$Change: 946917 $ --%>
