if(!this.JSON){JSON={}}(function(){function f(n){return n<10?"0"+n:n}if(typeof Date.prototype.toJSON!=="function"){Date.prototype.toJSON=function(key){return this.getUTCFullYear()+"-"+f(this.getUTCMonth()+1)+"-"+f(this.getUTCDate())+"T"+f(this.getUTCHours())+":"+f(this.getUTCMinutes())+":"+f(this.getUTCSeconds())+"Z"};String.prototype.toJSON=Number.prototype.toJSON=Boolean.prototype.toJSON=function(key){return this.valueOf()}}var cx=/[\u0000\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g,escapable=/[\\\"\x00-\x1f\x7f-\x9f\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g,gap,indent,meta={"\b":"\\b","\t":"\\t","\n":"\\n","\f":"\\f","\r":"\\r",'"':'\\"',"\\":"\\\\"},rep;function quote(string){escapable.lastIndex=0;return escapable.test(string)?'"'+string.replace(escapable,function(a){var c=meta[a];return typeof c==="string"?c:"\\u"+("0000"+a.charCodeAt(0).toString(16)).slice(-4)})+'"':'"'+string+'"'}function str(key,holder){var i,k,v,length,mind=gap,partial,value=holder[key];if(value&&typeof value==="object"&&typeof value.toJSON==="function"){value=value.toJSON(key)}if(typeof rep==="function"){value=rep.call(holder,key,value)}switch(typeof value){case"string":return quote(value);case"number":return isFinite(value)?String(value):"null";case"boolean":case"null":return String(value);case"object":if(!value){return"null"}gap+=indent;partial=[];if(Object.prototype.toString.apply(value)==="[object Array]"){length=value.length;for(i=0;i<length;i+=1){partial[i]=str(i,value)||"null"}v=partial.length===0?"[]":gap?"[\n"+gap+partial.join(",\n"+gap)+"\n"+mind+"]":"["+partial.join(",")+"]";gap=mind;return v}if(rep&&typeof rep==="object"){length=rep.length;for(i=0;i<length;i+=1){k=rep[i];if(typeof k==="string"){v=str(k,value);if(v){partial.push(quote(k)+(gap?": ":":")+v)}}}}else{for(k in value){if(Object.hasOwnProperty.call(value,k)){v=str(k,value);if(v){partial.push(quote(k)+(gap?": ":":")+v)}}}}v=partial.length===0?"{}":gap?"{\n"+gap+partial.join(",\n"+gap)+"\n"+mind+"}":"{"+partial.join(",")+"}";gap=mind;return v}}if(typeof JSON.stringify!=="function"){JSON.stringify=function(value,replacer,space){var i;gap="";indent="";if(typeof space==="number"){for(i=0;i<space;i+=1){indent+=" "}}else{if(typeof space==="string"){indent=space}}rep=replacer;if(replacer&&typeof replacer!=="function"&&(typeof replacer!=="object"||typeof replacer.length!=="number")){throw new Error("JSON.stringify")}return str("",{"":value})}}if(typeof JSON.parse!=="function"){JSON.parse=function(text,reviver){var j;function walk(holder,key){var k,v,value=holder[key];if(value&&typeof value==="object"){for(k in value){if(Object.hasOwnProperty.call(value,k)){v=walk(value,k);if(v!==undefined){value[k]=v}else{delete value[k]}}}}return reviver.call(holder,key,value)}cx.lastIndex=0;if(cx.test(text)){text=text.replace(cx,function(a){return"\\u"+("0000"+a.charCodeAt(0).toString(16)).slice(-4)})}if(/^[\],:{}\s]*$/.test(text.replace(/\\(?:["\\\/bfnrt]|u[0-9a-fA-F]{4})/g,"@").replace(/"[^"\\\n\r]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g,"]").replace(/(?:^|:|,)(?:\s*\[)+/g,""))){j=eval("("+text+")");return typeof reviver==="function"?walk({"":j},""):j}throw new SyntaxError("JSON.parse")}}}());String.prototype.f=function(b){var a=this.toString();return a.replace(/{{\s*(.*?)\s*}}/g,function(c,e){var d=b;$.each(e.split("."),function(f,g){d=d[g]});return d})};String.prototype.remainder=function(a){var b=this.indexOf(a);return this.substring(b+a.length,this.length)};jQuery.fn.center=function(b){var f=this;var g=$(window);var c={x:g.width(),y:g.height()};var h={x:f.width(),y:f.height()};var a={x:c.x,y:c.y};a.x-=h.x;a.y-=h.y;a.x/=2;a.y/=2;if(a.x<0){a.x=0}if(a.y<0){a.y=0}var e=Math.round(a.x)+"px";var d=Math.round(a.y)+"px";if(b){f.animate({left:e,top:d},{duration:"slow",easing:"swing",queue:false})}else{f.css({left:e,top:d})}};function popup_alert(b,e){$(".menu").hide();var d=$("#popup");d.find(".content:first").html("<h1>{{ subject }}</h1><p>{{ msg }}</p>".f({subject:b,msg:e}));var c=d.find(".button.cancel");c.hide();var a=d.find(".ok");a.html("OK");a.click(function(f){if(!jQuery.support.opacity){d.hide()}else{d.fadeOut("fast")}});d.show();d.center()}function dismiss_popup(){$("#popup").fadeOut("fast")}function popup(b,g,j,c){$(".menu").hide();var a=$("#popup");a.stop(true,true);var h=$("#msg_"+b);var d=h.html();if(c!==undefined){d=d.f(c)}a.find(".content:first").html(d);var e=a.find(".button.cancel");if(j===undefined){e.hide()}if(j){e.show()}a.find(".button.cancel").click(function(k){if(!jQuery.support.opacity){a.hide()}else{a.fadeOut("fast")}});var f=a.find(".ok");f.unbind("click");if(g!==undefined){f.html(g.label);function i(){var k=g.callback();if(k){a.fadeOut("fast")}}f.click(i)}else{f.html("OK");f.click(function(k){if(!jQuery.support.opacity){a.hide()}else{a.fadeOut("fast")}})}a.stop(true,true).show();a.center();a.find("input[type=text]:first").focus()}function desktop_alert(b,a){popup("alert",undefined,undefined,{title:b,message:a})}function text_to_html(b){var a=b.replace(/&/g,"&amp;").replace(/</g,"&lt;").replace(/>/g,"&gt;");a=a.split("\n").join("<br/>");return a}function pathjoin(c){var d="";for(var b=0;b<c.length;b++){var a=c[b];if(a.search(":")){d=a;continue}if(d){while(a[0]=="/"){a=a.substr(1)}}if(d[a.length-1]=="/"){d+="/"+a}else{d+=a}}return d}function get_img_template(a){if(a.use_favicon&&a.has_favicon){return a.favicon_img_url_template}else{return a.img_url_template}}function get_icon_sizes(a){if(a.use_favicon&&a.has_favicon){return a.favicon_sizes}else{return a.icon_sizes}}preload_images=[];function dynamic_preload(a,b){img=new Image();img.onload=b;img.src=a;preload_images.push(img)}Array.prototype.unique=function(){for(var a=1;a<this.length;a++){if(this[a-1]==this[a]){this.splice(a,1)}}};Array.prototype.clone=Array.prototype.slice;