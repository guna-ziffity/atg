/*
  Accessibility fix. Added empty title attribute to the iframe created by Dojo back library.
*/

dojo.require("dojo.back");
dojo.back.init = function(){
  if(dojo.byId("dj_history")){
    return;
  }
  var src=dojo.config["dojoIframeHistoryUrl"]||dojo.moduleUrl("dojo","resources/iframe_history.html");
  if(dojo._postLoad){
    console.error("dojo.back.init() must be called before the DOM has loaded. "+"If using xdomain loading or djConfig.debugAtAllCosts, include dojo.back "+"in a build layer.");
  }else{
    document.write("<iframe style=\"border:0;width:1px;height:1px;position:absolute;visibility:hidden;bottom:0;right:0;\" name=\"dj_history\" id=\"dj_history\" src=\""+src+"\" title=\"\"></iframe>");
  }
};


/*
  Accessibility fix. Added empty title attribute to the iframe created by Dojo digit library.
*/
dijit._frames = new function(){
	// summary:
	//		cache of iframes

	var queue = [];

	this.pop = function(){
		var iframe;
		if(queue.length){
			iframe = queue.pop();
			iframe.style.display="";
		}else{
			if(dojo.isIE < 9){
				var burl = dojo.config["dojoBlankHtmlUrl"] || (dojo.moduleUrl("dojo", "resources/blank.html")+"") || "javascript:\"\"";
				var html="<iframe src='" + burl + "'"
					+ " style='position: absolute; left: 0px; top: 0px;"
					+ "z-index: -1; filter:Alpha(Opacity=\"0\");'>";
				iframe = dojo.doc.createElement(html);
			}else{
			 	iframe = dojo.create("iframe");
				iframe.src = 'javascript:""';
				iframe.className = "dijitBackgroundIframe";
				dojo.style(iframe, "opacity", 0.1);
			}
			iframe.tabIndex = -1; // Magic to prevent iframe from getting focus on tab keypress - as style didn't work.
			dijit.setWaiRole(iframe,"presentation");
                        iframe.title = "";
		}
		return iframe;
	};

	this.push = function(iframe){
		iframe.style.display="none";
		queue.push(iframe);
	}
}();
