<%@ page pageEncoding="UTF-8" %>

<%@ taglib prefix="c"       uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="dspel"   uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_0" %>
<%@ taglib prefix="fmt"     uri="http://java.sun.com/jsp/jstl/fmt" %>

<dspel:page>
  <c:catch var="ex">
    <dspel:importbean var="previewInfoService" bean="/atg/dynamo/service/preview/PreviewInfoService"/>
    <c:out value='${previewInfoService.previewInfoJsonString}' escapeXml='false'/>
  </c:catch>
  <c:if test="${ex != null}">
    {"errors":["<c:out value='${ex}'/>"],
     "success":false}
    <% 
      Exception e = (Exception) pageContext.findAttribute("ex");
      e.printStackTrace(System.err);
    %>
  </c:if>
</dspel:page>

<%-- @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/preview/getPreviewServerInfo.jsp#1 $$Change: 946917 $--%>
