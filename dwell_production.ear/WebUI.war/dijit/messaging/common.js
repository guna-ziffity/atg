dojo.provide("atg.widget.messaging.common");

/*
 * Define utility methods not in dojo as of 0.4.2
 * At the time this comment was writtng, this functionality was buried 
 * in the buildRendering process in the dojo widget creation scheme
 */
//atg.widget.messaging.loadCss = function(/* Object */ object, /* String or URL */ cpath) {
//  if (dojo.isString(cpath)) {
//    cpath = cpath;
//  }
//  if(cpath && !dojo.widget._cssFiles[cpath.toString()]){
//    if((!object.extraTemplateCssString)&&(cpath)){
//      object.extraTemplateCssString = dojo.hostenv.getText(cpath);
//    }
//    dojo.widget._cssFiles[cpath.toString()] = true;
//  }
//  if((object.extraTemplateCssString)&&(!object.extraTemplateCssString.loaded)){
//    dojo.html.insertCssText(object.extraTemplateCssString, null, cpath);
//    object.extraTemplateCssString.loaded = true;
//  }
//}
