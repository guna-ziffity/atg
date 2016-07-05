    var PREPARE_VARIABLES  = "0";
    var SHOW_CONTEXT_MENU   = "1";
    var GET_PREVIEW_URL     = "2";
    var RELOAD_PREVIEW_URL  = "3";
    var HANDLE_DRAG_START   = "5";
    var HANDLE_DRAG_OVER    = "6";
    var HANDLE_DRAG_END     = "7";
    var CLEAN_DRAG_PROXY    = "8";
    var HANDLE_DRAG         = "9";
    var CHANGE_PAGE_CONTEXT = "10";
    var PROCESS_PREVIEW_INFO = "11";
    var SHOW_PREVIEW_HOTSPOTS = "12";

    var hotspotsEnabled = null;
    var hotspotVisibilityColor = null;
    var hotspotVisibilityColorHover = null;
    
    var isIE  = (navigator.appVersion.indexOf("MSIE") != -1) ? true : false;
    var isFirefox = (navigator.userAgent.indexOf("Firefox") != -1) ? true : false;

    //node's class string 
    var classString = null;
    //wheter drag is started
    var isDragStarted = false;
    //wheter drag is started
    var isDragInit = true;

    //mousedown x coordinate
    var clickX;
    //mousedown y coordinate
    var clickY;

    // page context
    var pageContext = null;
    
    var $atg = jQuery.noConflict();
    $atg(document).ready(function (e) {
      prepareVariables();

      $atg("[class*='atgRepo-']").bind("contextmenu", showContextMenu);
      $atg("[class*='atgRepo-']").bind("mousedown", handleMouseDown);
      getPreviewURL();

      //IE8 spicific issue fix
      if (document.attachEvent)
        document.ondragstart = function() {return false;};

      //stop drag operation on mouse leave
      $atg(window).mouseleave(function(e){
        var target = e.target;
        if (isDragStarted && (!target || target.nodeName == "HTML")) {
          if (window.captureEvents)
            window.releaseEvents(Event.MOUSEMOVE|Event.MOUSEUP);
            cleanDragProxy ();
          window.parent.postMessage(CLEAN_DRAG_PROXY, "*");
        }
      });

      postPreviewInfo();
    });
    
    if (window.addEventListener) {
      window.addEventListener("message", receiveMessage, false);  
    }
    else if (window.attachEvent) {
      window.attachEvent("onmessage", receiveMessage);  
    }
    else if (document.attachEvent) {
      document.attachEvent("onmessage", receiveMessage);  
    }
    
    function receiveMessage(event) {
      var msg = event.data.split(",");
      if (msg[0] == PREPARE_VARIABLES) {
        onVariablesPrepared(msg);
      }
      else if (msg[0] == GET_PREVIEW_URL) {
        getPreviewURL();
      }
      else if (msg[0] == RELOAD_PREVIEW_URL) {
        window.location.reload();
      }
      else if (msg[0] == HANDLE_DRAG_END) {
        cleanDragProxy();
      }
      else if (msg[0] == SHOW_PREVIEW_HOTSPOTS) {
        hotspotsEnabled = msg[1] == "true";
        showPreviewHotspots(hotspotsEnabled, hotspotVisibilityColor, hotspotVisibilityColorHover);
      }
    }
    
    function onVariablesPrepared(msg) {
      for (var i = 1; i < msg.length; i+=2) {
        if (msg[i] == "hotspotsEnabled") {
          hotspotsEnabled = msg[i+1] == "true";
        } else if (msg[i] == 'hotspotVisibilityColor') {
           hotspotVisibilityColor = msg[i+1];
        } else if (msg[i] == 'hotspotVisibilityColorHover') {
           hotspotVisibilityColorHover = msg[i+1];
        }
      }
      showPreviewHotspots(hotspotsEnabled, hotspotVisibilityColor, hotspotVisibilityColorHover);
    }

    function getPreviewURL() {
      var msg = [GET_PREVIEW_URL, window.location.href];
      window.parent.postMessage(msg.join(","), "*");
    }
    
    function showContextMenu(e) {
      var msg = [SHOW_CONTEXT_MENU, $atg(this).attr('class'), e.clientX, e.clientY];
      window.parent.postMessage(msg.join(","), "*");
      return false;
    }

    function prepareVariables() {
      var msg = [PREPARE_VARIABLES];
      window.parent.postMessage(msg.join(","), "*");
      return false;
    }
    
    //handles mouseDown event. Prepares for drag.
    function handleMouseDown(e){
       if ((e.button == 2) || (e.target.type == 'text'))
         return;
       if (e.preventDefault)
        e.preventDefault();
      else
        e.returnValue= false; 
      if (window.captureEvents) {
        window.captureEvents(Event.MOUSEMOVE|Event.MOUSEUP);
        window.onmousemove = handleMouseMove;
        window.onmouseup = handleMouseUp;
      } else {
        $atg(document.body).bind("mousemove", handleMouseMove);
        $atg(document.body).bind("mouseup", handleMouseUp);
      }
      classString = $atg(this).attr('class');
      pageContext = classString;
      clickX = e.screenX;
      clickY = e.screenY;
      
      if (this.attachEvent) {   // IE before version 9
        this.detachEvent("ondragstart", handleDragStart);
        this.attachEvent("ondragstart", handleDragStart);
        this.attachEvent("onselectstart", handleSelectStart);
      }
      isDragInit = false; 
      return false;
    }

    //IE prevent selection
    function handleSelectStart(event) {
      if (event.srcElement.type != "text")
        return false;
    }

    //IE specific. Prevents default drag behavior
    function handleDragStart(event) { 
      if (event.preventDefault)
        event.preventDefault();
      else
        event.returnValue = false;
      return false;
    }

    //moves drag proxy 
    function handleMouseMove(e) {
      var x;
      var y;
      if (isFirefox) {
        y = e.screenY;
        x = e.screenX;
      } else {
        y = e.screenY - window.screenTop;
        x = e.screenX - window.screenLeft;
      }
      if (classString && !isDragInit) {
        var msg = [HANDLE_DRAG, classString, x, y];
        window.parent.postMessage(msg.join(","), "*");
        isDragInit = true;
      }
      if (classString && distanceMached(e)) {
        var msg = [HANDLE_DRAG_START, x, y];
        window.parent.postMessage(msg.join(","), "*");
        isDragStarted = true; 
        classString = null;
        pageContext = null;
        clickX = null;
        clickY = null;
      }
      if (isDragStarted) {
        var msg = [HANDLE_DRAG_OVER, x, y, e.ctrlKey, e.altKey, e.shiftKey];
        window.parent.postMessage(msg.join(","), "*");
      }
    }

    //stops drag operation
    function handleMouseUp (event) {
      if (isDragStarted) {
        isDragStarted = false;
        var x = event.screenX;
        var y = event.screenY;
        if (isIE){
          x -= window.screenLeft;
          y -= window.screenTop;
        }
        var msg = [HANDLE_DRAG_END, x, y, event.ctrlKey, event.altKey, event.shiftKey];
        window.parent.postMessage(msg.join(","), "*"); 
      }
      if (window.captureEvents) {
        window.releaseEvents(Event.MOUSEMOVE|Event.MOUSEUP);
      } else {
        $atg(document.body).unbind("mousemove", handleMouseMove);
        $atg(document.body).unbind("mouseup", handleMouseUp);
      }
      if (pageContext != null) {
        var msg = [CHANGE_PAGE_CONTEXT, classString];
        window.parent.postMessage(msg.join(","), "*");
        pageContext = null;
      }
      cleanDragProxy();
    }

    //cleans drag variables
    function cleanDragProxy () {
      classString = null;
      isDragStarted = false;
    }

    //whether to start drag. Drag starts after 20px mouse move
    function distanceMached(e) {
      return ((clickX - e.screenX)*(clickX - e.screenX) + (clickY - e.screenY)*(clickY - e.screenY)) > 400;
    }

    function rebindContextMenuHandlers() {
      $atg("[class*='atgRepo-']").unbind("contextmenu");
      $atg("[class*='atgRepo-']").bind("contextmenu", showContextMenu);
      rebindDragAndDrop();
      showPreviewHotspots(hotspotsEnabled, hotspotVisibilityColor, hotspotVisibilityColorHover);
    }

    //rebinds drag and drop operation handlers
    function rebindDragAndDrop() {
      $atg("[class*='atgRepo-']").unbind("mousedown");
      $atg("[class*='atgRepo-']").bind("mousedown", handleMouseDown);
    }

    function postPreviewInfo() {
      var msg = [PROCESS_PREVIEW_INFO, escape(previewInfo)];
      window.parent.postMessage(msg.join(","), "*");
    }
    