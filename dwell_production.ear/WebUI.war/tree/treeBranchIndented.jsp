<%--
  Page fragment for displaying an indented tree branch.
  
  See tree.jsp for more information.
  
  @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/tree/treeBranchIndented.jsp#1 $$Change: 946917 $
  @updated $DateTime: 2015/01/26 17:26:27 $$Author: jsiddaga $
  --%>

<%@ page pageEncoding="UTF-8" %>

<%@ taglib prefix="c"     uri="http://java.sun.com/jsp/jstl/core"                    %>
<%@ taglib prefix="dspel" uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_0" %>

<dspel:page>

  <dspel:importbean var="config" bean="/atg/web/Configuration"/>
  
  <div id="<c:out value='subtreeDisplay_${requestScope.nodePath}'/>">
    <table border="0" cellpadding="0" cellspacing="0" width="100%">
      <tr>
        <td width="15">
          <dspel:img page="${config.imageRoot}/folderActionNone.gif"
                     border="0" align="absmiddle" width="15" alt=""/>
        </td>
        <td>
          <dspel:include page="/tree/treeBranch.jsp"/>
        </td>
      </tr>
    </table>  
  </div>

</dspel:page>
<%-- @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/tree/treeBranchIndented.jsp#1 $$Change: 946917 $--%>
