var EVENT_TYPE = 'afterupdate';

var reLetterOrDigit = /^([a-zA-Z]|\d)$/;

var isPreviewRunningInIframe = null;

//returns class string if preview is running in iframe, returns empty string otherwise
function getRepositoryItemIdentifier(repositoryName, itemDescriptorName, repositoryId) {
  if (checkPreview())
    return convertToUnicodeString('atgRepo-atgrep:/' + repositoryName + '/' + itemDescriptorName + '/' + repositoryId); 
  else
    return ""; 
}

//checks whether preview is running or not
function checkPreview() {
  if (isPreviewRunningInIframe != null)
   return isPreviewRunningInIframe;
  
  if (this.name != "previewPageFrame") {
    isPreviewRunningInIframe = false;
	return isPreviewRunningInIframe;
  } 
    
  var request = null;
  if(window.ActiveXObject){
    request = new ActiveXObject("Microsoft.XMLHTTP");
  } else if(window.XMLHttpRequest){
    request = new XMLHttpRequest();
  } else {
    return handleError(null);    
  }
  
  // sync request
  request.open('GET', "/WebUI/preview/preview_tagging.jsp", false);   
  request.send("");
    
  //request is synchronous so handle responce here.
  if(request.readyState == 4){
    if (request.status == 200) {
      var reqParam = request.responseText.replace(/^\s+|\s+$/g, "").toLowerCase();
      if (reqParam === "true" || reqParam === "false") {
        isPreviewRunningInIframe = reqParam === "true";
		return isPreviewRunningInIframe;
      } else
        return handleError(request);
    } else
      return handleError(request);
  }
}

function handleError(errObj){
  isPreviewRunningInIframe = false;
  return false;
}

function convertToUnicodeString(string) {
    var output = '';
    var char;
    for (var i = 0, l = string.length; i < l; i++) {
      char = string.charAt(i);
      if (reLetterOrDigit.test(char) || char == '-' || char == '_')
        output += char;
      else
        output += '\\u' + (string.charCodeAt(i) + 0x10000).toString(16).slice(1);
    }
    return output;
}

//triggers event to bind context menu if preview is running
function updatePreview() {  
  if (checkPreview()) 
    rebindContextMenuHandlers();
}

function previewHandlePageDataUpdated() {
  if (window.postPreviewInfo) {
    var request;
    if (window.ActiveXObject) {
      request = new ActiveXObject("Microsoft.XMLHTTP");
    }
    else if (window.XMLHttpRequest) {
      request = new XMLHttpRequest();
    }
    if (request) {
      request.onreadystatechange = function() {
        if (request.readyState === 4) {
          if (request.status === 200) {
            window.previewInfo = request.responseText;
            postPreviewInfo();
          }
        }
      };
      // Date is passed as parameter to prevent request caching. Bug 17516256.
      request.open("GET", "/WebUI/preview/getPreviewServerInfo.jsp?&atgForcePreview=true?" + new Date(), true);
      request.send("");
    }
  }
}
