<%@ page pageEncoding="UTF-8" %>

<%@ taglib prefix="c"       uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="dspel"   uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_0" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"               %>

<dspel:page>

<fmt:setBundle basename="atg.web.WebAppResources"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  <head>
    <title>
      <fmt:message key="atgPreview.windowTitle"/>
    </title>
    <link rel="icon" href="<c:url value='/images/favicon.ico'/>" type="image/x-icon"/>
    <link rel="shortcut icon" href="<c:url value='/images/favicon.ico'/>" type="image/x-icon"/>
  </head>

<%--  This JSP should either load the frameset as outlined below
      but with the actual preview URL rather than the previewURL.jsp for the second src
      If the preview in a frameset option is set to false, this JSP should redirect to
      the preview URL as the selected user instead.
--%>

  <c:set var="unescapedURL" value="${param.url}"/>
  <%
    String encodedURL = java.net.URLEncoder.encode((String) pageContext.findAttribute("unescapedURL"), "UTF-8");
    pageContext.setAttribute("encodedURL", encodedURL, javax.servlet.jsp.PageContext.PAGE_SCOPE);
  %>

    <c:choose>
    <c:when test="${empty param.pushSite}">
      <c:url var="titleUrl" value="/preview/title.jsp">
        <c:param name="atgPreviewId" value="${param.atgPreviewId}"/>
        <c:param name="url" value="${param.url}"/>
      </c:url>
      <c:set var="previewUrl" value="${param.url}"/>
    </c:when>
    <c:otherwise>
      <c:url var="titleUrl" value="/preview/title.jsp">
        <c:param name="atgPreviewId" value="${param.atgPreviewId}"/>
        <c:param name="pushSite" value="${param.pushSite}"/>
        <c:param name="stickySite" value="setSite"/>
        <c:param name="url" value="${param.url}"/>
      </c:url>
      <c:url var="previewUrl" value="${param.url}">
        <c:param name="pushSite" value="${param.pushSite}"/>
        <c:param name="stickySite" value="setSite"/>
      </c:url>
    </c:otherwise>
  </c:choose>

  <frameset rows="35px, *" border="0" frameborder="0" framespacing="0">
    <frame src ="<c:out value='${titleUrl}'/>" name="title"></frame>
    <frame src ="<c:out value='${previewUrl}'/>" name="preview"></frame>
  </frameset>
</html>

</dspel:page>
<%-- @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/preview/launched.jsp#1 $$Change: 946917 $--%>
