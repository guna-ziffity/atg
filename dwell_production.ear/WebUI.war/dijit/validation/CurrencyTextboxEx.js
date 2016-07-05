dojo.provide("atg.widget.validation.CurrencyTextboxEx");
dojo.require("dijit.form.CurrencyTextBox");
dojo.require("dojo.currency");

//making the currency textbox widget as locale aware.
//If the locale is present in the widget, that takes the precedence over the constraints.
//Also making locale Currency Symbol aware, if the symbol is available in the widget, that takes the
//precedence over the constraints.

dojo.declare(
    "atg.widget.validation.CurrencyTextboxEx",
    dijit.form.CurrencyTextBox,
    {
      locale : "",
      currencySymbol : "",

      // if the widget's locale and currency symbols are not null, those are used to parse the currency.
      parse: function(/* String */ value, /* Object */ constraints){
      if (this.locale != "") {
        constraints.locale = this.locale;
      }
      if (this.currencySymbol != "") {
        constraints.symbol = this.currencySymbol;
      }

      return dojo.currency.parse (value, constraints);
    },

    // if the widget's locale and currency symbols are not null, those are used to format the currency.
    format: function(/* String */ value, /* Object */ constraints){
      if (this.locale != "") {
        constraints.locale = this.locale;
      }
      if (this.currencySymbol != "") {
        constraints.symbol = this.currencySymbol;
      }
      return dojo.currency.format (value, constraints);
    }
    }
);


dojo.number._parseInfo = function(/*Object?*/options){
  options = options || {};
  var locale = dojo.i18n.normalizeLocale(options.locale);
  var bundle = dojo.i18n.getLocalization("dojo.cldr", "number", locale);
  var pattern = options.pattern || bundle[(options.type || "decimal") + "Format"];
//TODO: memoize?
  var group = bundle.group;
  var decimal = bundle.decimal;
  var factor = 1;

  if(pattern.indexOf('%') != -1){
    factor /= 100;
  }else if(pattern.indexOf('\u2030') != -1){
    factor /= 1000; // per mille
  }else{
    var isCurrency = pattern.indexOf('\u00a4') != -1;
    if(isCurrency){
      group = bundle.currencyGroup || group;
      decimal = bundle.currencyDecimal || decimal;
    }
  }

  //TODO: handle quoted escapes
  var patternList = pattern.split(';');
  if(patternList.length == 1){
    patternList.push("-" + patternList[0]);
  }

  var re = dojo.regexp.buildGroupRE(patternList, function(pattern){
    pattern = "(?:"+dojo.regexp.escapeString(pattern, '.')+")";
    return pattern.replace(dojo.number._numberPatternRE, function(format){
      var flags = {
        signed: false,
        separator: options.strict ? group : [group,""],
        fractional: options.fractional,
        decimal: decimal,
        exponent: false};
      var parts = format.split('.');
      var places = options.places;
      if(parts.length == 1 || places === 0){flags.fractional = false;}
      else{
        if(typeof places == "undefined"){ places = parts[1].lastIndexOf('0')+1; }
        if(places && options.fractional == undefined){flags.fractional = true;} // required fractional, unless otherwise specified
        if(!options.places && (places < parts[1].length)){ places += "," + parts[1].length; }
        flags.places = places;
      }
      var groups = parts[0].split(',');
      if(groups.length>1){
        flags.groupSize = groups.pop().length;
        if(groups.length>1){
          flags.groupSize2 = groups.pop().length;
        }
      }
      return "("+dojo.number._realNumberRegexp(flags)+")";
    });
  }, true);

  if(isCurrency){
    // substitute the currency symbol for the placeholder in the pattern
    re = re.replace(/([\s\xa0]*)(\u00a4{1,3})([\s\xa0]*)/g, function(match, before, target, after){
      var prop = ["symbol", "currency", "displayName"][target.length-1];
        var symbol = dojo.regexp.escapeString(options[prop] || options.currency || "");
      before = before ? "[\\s\\xa0]" : "";
      after = after ? "[\\s\\xa0]" : "";
      if(!options.strict){
        if(before){before += "*";}
        if(after){after += "*";}
        return "(?:"+before+symbol+after+")?";
      }
      return before+symbol+after;
    });
  }

//TODO: substitute localized sign/percent/permille/etc.?

  // normalize whitespace and return
  return {regexp: re.replace(/[\xa0 ]/g, "[\\s\\xa0]"), group: group, decimal: decimal, factor: factor}; // Object
};

