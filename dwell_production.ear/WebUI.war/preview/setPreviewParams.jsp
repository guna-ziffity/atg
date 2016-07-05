<%@ page pageEncoding="UTF-8" %>

<%@ taglib prefix="c"       uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="dspel"   uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_0" %>

<dspel:page>
  <dspel:importbean bean="/atg/userprofiling/preview/PreviewContext"/>

  <c:catch var="ex">
    <%
      String encodedUrl = (String)request.getParameter("url");
      String url = null;
      if (encodedUrl != null) {
        url = java.net.URLDecoder.decode(encodedUrl);
      }
      pageContext.setAttribute("previewUrl", url, javax.servlet.jsp.PageContext.SESSION_SCOPE);
      
      String encodedSiteId = (String)request.getParameter("site");
      String siteId = null;
      if (encodedSiteId != null) {
        siteId = java.net.URLDecoder.decode(encodedSiteId, "UTF-8");
      }
      pageContext.setAttribute("siteId", siteId, javax.servlet.jsp.PageContext.REQUEST_SCOPE);
    %>

    <dspel:setvalue bean="PreviewContext.previewURL" value="${previewUrl}"/>
    <dspel:setvalue bean="PreviewContext.previewUserId" paramvalue="atgPreviewId"/>
    <dspel:setvalue bean="PreviewContext.previewSiteId" value="${siteId}"/>
    <dspel:setvalue bean="PreviewContext.assetURI" paramvalue="assetURI"/>

    {
      <c:out value='"success":true' escapeXml='false'/>
    }
  </c:catch>
  <c:if test="${ex != null}">
    <% 
      Exception e = (Exception) pageContext.findAttribute("ex");
      e.printStackTrace(System.err);
    %>
  </c:if>
</dspel:page>

<%-- @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/preview/setPreviewParams.jsp#1 $$Change: 946917 $--%>
