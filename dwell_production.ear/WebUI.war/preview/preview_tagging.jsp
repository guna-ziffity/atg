<%@ page pageEncoding="UTF-8" %>

<%@ taglib prefix="dspel"   uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_0" %>

<%--This JSP determines if preview is running.--%>
<dspel:page>
  <dspel:importbean var="previewManager" bean="/atg/dynamo/service/preview/PreviewManager"/>
    ${previewManager != null}
</dspel:page>
<%-- @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/preview/preview_tagging.jsp#1 $$Change: 946917 $--%>