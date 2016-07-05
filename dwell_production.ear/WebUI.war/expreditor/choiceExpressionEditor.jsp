<%--
  An expression editor for ChoiceExpression instances.

  This page expects the following parameters:
    expression - The Expression instance to be rendered

  @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/expreditor/choiceExpressionEditor.jsp#1 $$Change: 946917 $
  @updated $DateTime: 2015/01/26 17:26:27 $$Author: jsiddaga $
  --%>

<%@ taglib prefix="dspel"  uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_0" %>

<dspel:page>

  <%-- Unpack all DSP parameters (see coding standards for more info) --%>
  <dspel:getvalueof var="paramExpression" param="expression"/>

  <%-- Render this expression's current choice --%>
  <dspel:include page="renderExpression.jsp">
    <dspel:param name="expression" value="${paramExpression.currentChoice}"/>
  </dspel:include>
  
</dspel:page>
<%-- @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/expreditor/choiceExpressionEditor.jsp#1 $$Change: 946917 $ --%>
