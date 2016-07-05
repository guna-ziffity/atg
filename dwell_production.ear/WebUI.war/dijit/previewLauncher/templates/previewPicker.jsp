<%--
  The preview picker page.

  @version $Id $$Change $
  @updated $DateTime $$Author $
  --%>

<%@ page pageEncoding="UTF-8" %>

<%@ taglib prefix="dspel"  uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_0" %>
<%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt"                     %>

<dspel:page>

  <dspel:importbean var="config"    bean="/atg/web/Configuration"/>

  <fmt:setBundle basename="${config.resourceBundle}"/>
  <fmt:setLocale value="${request.locale}"/>

  <div id="atg_previewPicker" class="atg_previewPicker" dojoattachpoint="wrapper">
  
    <div dojoattachpoint="contents" style="position: relative; z-index: 2;">
  
  
     <div id="ppHeader">
       <a id="ppCloser" href="#" title="<fmt:message key='previewPicker.closeButtonTooltip'/>" dojoAttachEvent="onclick: hide">X</a>
       <fmt:message key="previewPicker.previewLauncherTitle"/>
    </div>
  
     <div id="ppPicker" dojoattachpoint="ppPicker">
     <!-- <em>Loading Data...</em> -->
     </div>
     <div id="ppFooter">
  
       <h3><fmt:message key="previewPicker.launchSettingsTitle"/></h3>
       <div id="ppChosen">
           <div id="userChosen">
             <span dojoattachpoint="userChosenLabel"><fmt:message key="previewPicker.asUserLabel"/> </span><em dojoattachpoint="chosenUser"><fmt:message key="previewPicker.selectMessage"/></em>
          </div>
           <div id="urlChosen">
             <span dojoattachpoint="urlChosenLabel"><fmt:message key="previewPicker.landingPageLabel"/> </span><em dojoattachpoint="chosenURL"><fmt:message key="previewPicker.selectMessage"/></em>
          </div>
           <div id="siteChosen">
             <span dojoattachpoint="siteChosenLabel"><fmt:message key="previewPicker.onSiteLabel"/> </span><em dojoattachpoint="chosenSite"><fmt:message key="previewPicker.selectMessage"/></em>
          </div>
       </div>
  
       <input dojoattachpoint="previewLaunchButton" id="previewLaunchButton" disabled="true" type="submit" value="<fmt:message key="previewPicker.launchButtonLabel"/>" class="submit" dojoAttachEvent="onclick: launchClicked"></input>
  
  
     </div>
  
  
    </div>
  
  </div>

</dspel:page>
<%-- @version $Id: //product/WebUI/version/11.2/src/web-apps/WebUI/dijit/previewLauncher/templates/previewPicker.jsp#1 $$Change: 946917 $--%>
