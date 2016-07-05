var hotspotVisibilityColor = null;
var hotspotVisibilityColorHover = null;
var hotspotsEnabled  = null;
var $atg = jQuery.noConflict();

function filterOutPreviewElement(currentElement) {
    var child = currentElement;
    var previewID = extractPreviewClass(child.className);
    var filterOutPreviewElement = false;

    while (child) {
      currentNode = child;
      child = child.parentNode;
      if (child && child.className && extractPreviewClass(child.className) == previewID) {
        filterOutPreviewElement = true;
        return filterOutPreviewElement;
      }
    }
  return filterOutPreviewElement;
}

function showPreviewHotspots(pShow, pHotspotVisibilityColor, pHotspotVisibilityColorHover) {
  removeHotspots('preview-hotspot');
  removeHotspots('preview-hotspot-inline');
  hotspotsEnabled = pShow;
  if (pShow) {
    var hotspotIndex = 0;
    hotspotVisibilityColor = pHotspotVisibilityColor;
    hotspotVisibilityColorHover = pHotspotVisibilityColorHover;
    var allMarkedElement = getAllElementsByClass(document, "atgRepo-");
    for (var i=0; i < allMarkedElement.length; i++) {
      var _this = allMarkedElement[i];
      var filterOutElement = filterOutPreviewElement(_this);
      if (!filterOutElement) {
        var hotspot = document.createElement('div');
        hotspot.style.border = "solid 5px " + getRgba(hotspotVisibilityColor, "0.6");
        
        var position = getStyle(_this,'position');
        if (position != 'relative' && position != 'absolute') {
            _this.style.position = "relative";
        }
          
        var display = getStyle(_this,'display');
        if (display == 'inline') {
          if (position != 'relative' && position != 'absolute') {
              _this.parentNode.style.position = "relative";
          }
          hotspot.className = hotspot.className + ' preview-hotspot-inline';
          
          hotspot.style.left = (getPosition(_this).left - 5).toString() + "px";
           if (_this.offsetWidth != 0) {
            hotspot.style.width = (_this.offsetWidth - 10).toString() + "px";
          } else {
            hotspot.style.width = (hotspot.style.width - 10).toString() + "px";
          }
          
          hotspot.style.top = (getPosition(_this).top - 5).toString() + "px";
          if (_this.offsetHeight != 0) { 
            hotspot.style.height = (_this.offsetHeight - 10).toString() + "px";
          } else {
            hotspot.style.height = (hotspot.style.height - 10).toString() + "px";
          }
          _this.parentNode.insertBefore(hotspot, _this);
        
        } else {
          if (position != 'relative' && position != 'absolute') {
              _this.style.position = "relative";
          }
          hotspot.className = hotspot.className + ' preview-hotspot';
          _this.appendChild(hotspot);
        }
        
        if (_this.addEventListener) {
          _this.addEventListener('mouseover',showTooltip,false);
          _this.addEventListener('mouseout',hideTooltip,false);
        }
        else {
          _this.attachEvent('onmouseover',showTooltip);
          _this.attachEvent('onmouseout',hideTooltip);
        }
      }
    }
  }
}

function getPosition(element) {

  if (!element) return;
  var childOffset, offset, parent;
  var parentOffset = { top: 0, left: 0 };  
  

  if ( element.style.position === "fixed" ) {
    offset = elem.getBoundingClientRect();
  } else {
    offset = getOffset(element);
    
    parent = element.parentNode;
    if ( parent.nodeName !== "html" )  {
      parentOffset = getOffset(parent);
    }
    parentOffset.top += parent.style.borderTopWidth;
    parentOffset.left += parent.style.borderLeftWidth;
  }
  var childOffset = {top: offset.top - parentOffset.top - element.style.marginTop,
                     left: offset.left - parentOffset.left - element.style.marginLeft};
  return childOffset;
}

function getOffset(element) {
  if (!element) return;
  
  var box = { top: 0, left: 0 };
  box = element.getBoundingClientRect();
		return {
			top: box.top + window.pageYOffset - element.ownerDocument.documentElement.clientTop,
			left: box.left + window.pageXOffset - element.ownerDocument.documentElement.clientLeft
		}
}

function getStyle(element, strCss){
  var cssValue = "";
  if(document.defaultView && document.defaultView.getComputedStyle){
      cssValue = document.defaultView.getComputedStyle(element, "").getPropertyValue(strCss);
  }
  else if(element.currentStyle){
      cssValue = element.currentStyle[strCss];
  }
  return cssValue;
}

function getAllElementsByClass(node, classname) {
  var elements = [];
  var regexp = new RegExp('(^| )'+classname);
  var allElements = node.getElementsByTagName("*");
  for(var i=0; i < allElements.length; i++) {
     if(regexp.test(allElements[i].className)) {
      elements.push(allElements[i]);
    }
  }
  return elements;
}

function removeHotspots(className) {
  var hotspots = document.getElementsByClassName(className);
  var currentHotspot;
  while ((currentHotspot = hotspots[0])) {
    currentHotspot.parentNode.removeChild(currentHotspot);
  }
}

function showTooltip() {
  if (!hotspotsEnabled) return;
  var itemId = extractPreviewId(convertUnicodeToUTF8(extractPreviewClass(this.className)));
  var tooltip = document.createElement('span');
  tooltip.className = 'preview-hotspot-tooltip';
  tooltip.innerHTML = itemId;
  var child = getAllElementsByClass(this, 'preview-hotspot');
  if (child.length != 0) {
    child = child[0];
  } else {
    child = this.previousSibling;
  }
  child.style.border = "solid 5px " + getRgba(hotspotVisibilityColorHover, "0.6");  
  child.appendChild(tooltip);
}

function hideTooltip() {
  if (!hotspotsEnabled) return;
  var child = getAllElementsByClass(this, 'preview-hotspot');
  if (child.length != 0) {
    child = child[0];
  } else {
    child = this.previousSibling;
  }
  child.style.border = "solid 5px " + getRgba(hotspotVisibilityColor, "0.6");    
  child.removeChild(child.childNodes[child.childNodes.length - 1] );
}

function extractPreviewId(previewClass) {
  var parts = previewClass.split("/", 4);
  return parts[parts.length - 1];
}

function extractPreviewClass(classString) {
  var array = classString.split(/\s+/);
  for(i=0; i < array.length; i++) {
    if (array[i].indexOf('atgRepo-') == 0)
      return array[i];
  }
  return null;
}

function convertUnicodeToUTF8(unicodeString) {
  var hexArray = {"0":0x00, "1":0x01, "2":0x02, "3":0x03, "4":0x04, "5":0x05, "6":0x06,
       "7":0x07, "8":0x08, "9":0x09, "a":0x0A, "b":0x0B, "c":0x0C, "d":0x0D, 
       "e":0x0E, "f":0x0F};

  if (unicodeString != null && unicodeString != "") {
    var result = "";
    for (var i = 0; i < unicodeString.length; i++) {
      if (unicodeString.charAt(i) != '\\') {
        result += unicodeString.charAt(i);
        continue;
      }
      if ((i + 1) < unicodeString.length && unicodeString.charAt(i + 1) == 'u') {
        i++;
        if ((i + 4) < unicodeString.length) {
          var one = hexArray[unicodeString.charAt(i + 1)]
          var two = hexArray[unicodeString.charAt(i + 2)]
          var three = hexArray[unicodeString.charAt(i + 3)]
          var four = hexArray[unicodeString.charAt(i + 4)]
          i += 4;
              
          var final = 0;
          final = one << 4;
          final = final | two;
          final = final << 4;
          final = final | three;
          final = final << 4;
          final = final | four;

          result += String.fromCharCode(final);
        } else {
          result += unicodeString.charAt(i);
        }
      } else {
        result += unicodeString.charAt(i);
      }
    }
    return result;
  }
  return null;
}

function getRgba(color, a) {
  return "rgba(" + [hexToR(color),hexToG(color),hexToB(color),a].join(',') +")";
}

function hexToR(h) {return parseInt((cutHex(h)).substring(0,2),16)}
function hexToG(h) {return parseInt((cutHex(h)).substring(2,4),16)}
function hexToB(h) {return parseInt((cutHex(h)).substring(4,6),16)}
function cutHex(h) {return (h.charAt(0)=="#") ? h.substring(1,7):h}
