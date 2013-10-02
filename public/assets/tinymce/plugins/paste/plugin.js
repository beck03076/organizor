!function(t,e){"use strict";function n(t,e){for(var n,i=[],o=0;o<t.length;++o){if(n=r[t[o]]||a(t[o]),!n)throw"module definition dependecy not found: "+t[o];i.push(n)}e.apply(null,i)}function i(t,i,a){if("string"!=typeof t)throw"invalid module definition, module id must be defined and be a string";if(i===e)throw"invalid module definition, dependencies must be specified";if(a===e)throw"invalid module definition, definition function must be specified";n(i,function(){r[t]=a.apply(null,arguments)})}function a(e){for(var n=t,i=e.split(/[.\/]/),a=0;a<i.length;++a){if(!n[i[a]])return;n=n[i[a]]}return n}function o(n){for(var i=0;i<n.length;i++){for(var a=t,o=n[i],s=o.split(/[.\/]/),l=0;l<s.length-1;++l)a[s[l]]===e&&(a[s[l]]={}),a=a[s[l]];a[s[s.length-1]]=r[o]}}var r={},s="tinymce/pasteplugin/Clipboard",l="tinymce/Env",c="tinymce/util/Tools",u="tinymce/util/VK",d="tinymce/pasteplugin/WordFilter",p="tinymce/html/DomParser",f="tinymce/html/Schema",g="tinymce/html/Serializer",m="tinymce/html/Node",v="tinymce/pasteplugin/Quirks",h="tinymce/pasteplugin/Plugin",b="tinymce/PluginManager";i(s,[l,c,u],function(t,e,n){function i(){return!t.gecko&&("ClipboardEvent"in window||t.webkit&&"FocusEvent"in window)}return function(a){function o(){return(new Date).getTime()}function r(t){return n.metaKeyPressed(t)&&86==t.keyCode||t.shiftKey&&45==t.keyCode}function s(t){return t.innerText||t.textContent}function l(){return o()-g<100||"text"==m.pasteFormat}function c(t,n){return e.each(n,function(e){t=e.constructor==RegExp?t.replace(e,""):t.replace(e[0],e[1])}),t}function u(e){var n=a.fire("PastePreProcess",{content:e});e=n.content,a.settings.paste_data_images||(e=e.replace(/<img src=\"data:image[^>]+>/g,"")),(a.settings.paste_remove_styles||a.settings.paste_remove_styles_if_webkit!==!1&&t.webkit)&&(e=e.replace(/ style=\"[^\"]+\"/g,"")),n.isDefaultPrevented()||a.insertContent(e)}function d(t){t=a.dom.encode(t).replace(/\r\n/g,"\n");var e=a.dom.getParent(a.selection.getStart(),a.dom.isBlock);t=e&&/^(PRE|DIV)$/.test(e.nodeName)||!a.settings.forced_root_block?c(t,[[/\n/g,"<br>"]]):c(t,[[/\n\n/g,"</p><p>"],[/^(.*<\/p>)(<p>)$/,"<p>$1"],[/\n/g,"<br />"]]);var n=a.fire("PastePreProcess",{content:t});n.isDefaultPrevented()||a.insertContent(n.content)}function p(){var t=a.dom.getViewPort().y,e=a.dom.add(a.getBody(),"div",{contentEditable:!1,"data-mce-bogus":"1",style:"position: absolute; top: "+t+"px; left: 0; width: 1px; height: 1px; overflow: hidden"},'<div contentEditable="true" data-mce-bogus="1">X</div>');return a.dom.bind(e,"beforedeactivate focusin focusout",function(t){t.stopPropagation()}),e}function f(t){a.dom.unbind(t),a.dom.remove(t)}var g,m=this;if(a.on("keydown",function(t){n.metaKeyPressed(t)&&t.shiftKey&&86==t.keyCode&&(g=o())}),i())a.on("paste",function(t){function e(t,e){for(var i=0;i<n.types.length;i++)if(n.types[i]==t)return e(n.getData(t)),!0}var n=t.clipboardData;n&&(t.preventDefault(),l()?e("text/plain",d)||e("text/html",u):e("text/html",u)||e("text/plain",d))});else{if(t.ie){var v=0;a.on("keydown",function(t){if(r(t)&&!t.isDefaultPrevented()){t.stopImmediatePropagation();var e=p();v=o(),a.dom.bind(e,"paste",function(){setTimeout(function(){a.selection.setRng(n),f(e),l()?d(s(e.firstChild)):u(e.firstChild.innerHTML)},0)});var n=a.selection.getRng();e.firstChild.focus(),e.firstChild.innerText=""}}),a.on("init",function(){var t=a.dom;a.dom.bind(a.getBody(),"paste",function(e){if(o()-v>100){var n,i=p();e.preventDefault(),t.bind(i,"paste",function(t){t.stopPropagation(),n=!0});var r=a.selection.getRng(),c=t.doc.body.createTextRange();if(c.moveToElementText(i.firstChild),c.execCommand("Paste"),f(i),!n)return a.windowManager.alert("Please use Ctrl+V/Cmd+V keyboard shortcuts to paste contents."),void 0;a.selection.setRng(r),l()?d(s(i.firstChild)):u(i.firstChild.innerHTML)}})})}else a.on("init",function(){a.dom.bind(a.getBody(),"paste",function(t){var e=a.getDoc();return t.preventDefault(),t.clipboardData||e.dataTransfer?(d((t.clipboardData||e.dataTransfer).getData("Text")),void 0):(t.preventDefault(),a.windowManager.alert("Please use Ctrl+V/Cmd+V keyboard shortcuts to paste contents."),void 0)})}),a.on("keydown",function(e){if(r(e)&&!e.isDefaultPrevented()){e.stopImmediatePropagation();var n=p(),i=a.selection.getRng();t.webkit&&a.inline&&(n.contentEditable=!0),a.selection.select(n,!0),a.dom.bind(n,"paste",function(t){t.stopPropagation(),setTimeout(function(){f(n),a.lastRng=i,a.selection.setRng(i);var t=n.firstChild;t.lastChild&&"BR"==t.lastChild.nodeName&&t.removeChild(t.lastChild),l()?d(s(t)):u(t.innerHTML)},0)})}});a.settings.paste_data_images||a.on("drop",function(t){var e=t.dataTransfer;e&&e.files&&e.files.length>0&&t.preventDefault()})}a.paste_block_drop&&a.on("dragend dragover draggesture dragdrop drop drag",function(t){t.preventDefault(),t.stopPropagation()}),this.paste=u,this.pasteText=d}}),i(d,[c,p,f,g,m],function(t,e,n,i,a){return function(o){var r=t.each;o.on("PastePreProcess",function(s){function l(t){r(t,function(t){f=t.constructor==RegExp?f.replace(t,""):f.replace(t[0],t[1])})}function c(t){function e(t,e,r,s){var l=t._listLevel||o;l!=o&&(o>l?n&&(n=n.parent.parent):(i=n,n=null)),n&&n.name==r?n.append(t):(i=i||n,n=new a(r,1),s>1&&n.attr("start",""+s),t.wrap(n)),t.name="li",e.value="";var c=e.next;c&&3==c.type&&(c.value=c.value.replace(/^\u00a0+/,"")),l>o&&i&&i.lastChild.append(n),o=l}for(var n,i,o=1,r=t.getAll("p"),s=0;s<r.length;s++)if(t=r[s],"p"==t.name&&t.firstChild){for(var l="",c=t.firstChild;c&&!(l=c.value);)c=c.firstChild;if(/^\s*[\u2022\u00b7\u00a7\u00d8o\u25CF]\s*$/.test(l)){e(t,c,"ul");continue}if(/^\s*\w+\./.test(l)){var u=/([0-9])\./.exec(l),d=1;u&&(d=parseInt(u[1],10)),e(t,c,"ol",d);continue}n=null}}function u(e,n){if("p"===e.name){var i=/mso-list:\w+ \w+([0-9]+)/.exec(n);i&&(e._listLevel=parseInt(i[1],10))}if(o.getParam("paste_retain_style_properties","none")){var a="";if(t.each(o.dom.parseStyle(n),function(t,e){switch(e){case"horiz-align":return e="text-align",void 0;case"vert-align":return e="vertical-align",void 0;case"font-color":case"mso-foreground":return e="color",void 0;case"mso-background":case"mso-highlight":e="background"}("all"==d||p&&p[e])&&(a+=e+":"+t+";")}),a)return a}return null}var d,p,f=s.content;if(d=o.settings.paste_retain_style_properties,d&&(p=t.makeMap(d)),o.settings.paste_enable_default_filters!==!1&&/class="?Mso|style="[^"]*\bmso-|style='[^'']*\bmso-|w:WordDocument/i.test(s.content)){s.wordContent=!0,l([/<!--[\s\S]+?-->/gi,/<(!|script[^>]*>.*?<\/script(?=[>\s])|\/?(\?xml(:\w+)?|img|meta|link|style|\w:\w+)(?=[\s\/>]))[^>]*>/gi,[/<(\/?)s>/gi,"<$1strike>"],[/&nbsp;/gi," "],[/<span\s+style\s*=\s*"\s*mso-spacerun\s*:\s*yes\s*;?\s*"\s*>([\s\u00a0]*)<\/span>/gi,function(t,e){return e.length>0?e.replace(/./," ").slice(Math.floor(e.length/2)).split("").join(" "):""}]]);var g=new n({valid_elements:"@[style],-strong/b,-em/i,-span,-p,-ol,-ul,-li,-h1,-h2,-h3,-h4,-h5,-h6,-table,-tr,-td[colspan|rowspan],-th,-thead,-tfoot,-tbody,-a[!href],sub,sup,strike"}),m=new e({},g);m.addAttributeFilter("style",function(t){for(var e,n=t.length;n--;)e=t[n],e.attr("style",u(e,e.attr("style"))),"span"!=e.name||e.attributes.length||e.unwrap()});var v=m.parse(f);c(v),s.content=new i({},g).serialize(v)}})}}),i(v,[l,c],function(t,e){return function(n){function i(t){n.on("PastePreProcess",function(e){e.content=t(e.content)})}function a(t,n){return e.each(n,function(e){t=e.constructor==RegExp?t.replace(e,""):t.replace(e[0],e[1])}),t}function o(t){return t=a(t,[/^[\s\S]*<!--StartFragment-->|<!--EndFragment-->[\s\S]*$/g,[/<span class="Apple-converted-space">\u00a0<\/span>/g," "],/<br>$/])}function r(t){if(!s){var i=[];e.each(n.schema.getBlockElements(),function(t,e){i.push(e)}),s=new RegExp("(?:<br>&nbsp;[\\s\\r\\n]+|<br>)*(<\\/?("+i.join("|")+")[^>]*>)(?:<br>&nbsp;[\\s\\r\\n]+|<br>)*","g")}return t=a(t,[[s,"$1"]]),t=a(t,[[/<br><br>/g,"<BR><BR>"],[/<br>/g," "],[/<BR><BR>/g,"<br>"]])}var s;t.webkit&&i(o),t.ie&&i(r)}}),i(h,[b,s,d,v],function(t,e,n,i){var a;t.add("paste",function(t){function o(){"text"==r.pasteFormat?(this.active(!1),r.pasteFormat="html"):(r.pasteFormat="text",this.active(!0),a||(t.windowManager.alert("Paste is now in plain text mode. Contents will now be pasted as plain text until you toggle this option off."),a=!0))}var r,s=this;s.clipboard=r=new e(t),s.quirks=new i(t),s.wordFilter=new n(t),t.settings.paste_as_text&&(s.clipboard.pasteFormat="text"),t.addCommand("mceInsertClipboardContent",function(t,e){e.content&&s.clipboard.paste(e.content),e.text&&s.clipboard.pasteText(e.text)}),t.addButton("pastetext",{icon:"pastetext",tooltip:"Paste as text",onclick:o,active:"text"==s.clipboard.pasteFormat}),t.addMenuItem("pastetext",{text:"Paste as text",selectable:!0,active:r.pasteFormat,onclick:o})})}),o([s,d,v,h])}(this);