tinymce.PluginManager.add("visualchars",function(e){function a(a){var n,t,s,i,r,c,d=e.getBody(),l=e.selection;if(o=!o,e.fire("VisualChars",{state:o}),a&&(c=l.getBookmark()),o)for(t=[],tinymce.walk(d,function(e){3==e.nodeType&&e.nodeValue&&-1!=e.nodeValue.indexOf(" ")&&t.push(e)},"childNodes"),s=0;s<t.length;s++){for(i=t[s].nodeValue,i=i.replace(/(\u00a0)/g,'<span data-mce-bogus="1" class="mce-nbsp">$1</span>'),r=e.dom.create("div",null,i);n=r.lastChild;)e.dom.insertAfter(n,t[s]);e.dom.remove(t[s])}else for(t=e.dom.select("span.mce-nbsp",d),s=t.length-1;s>=0;s--)e.dom.remove(t[s],1);l.moveToBookmark(c)}function n(){var a=this;e.on("VisualChars",function(e){a.active(e.state)})}var o;e.addCommand("mceVisualChars",a),e.addButton("visualchars",{title:"Show invisible characters",cmd:"mceVisualChars",onPostRender:n}),e.addMenuItem("visualchars",{text:"Show invisible characters",cmd:"mceVisualChars",onPostRender:n,selectable:!0,context:"view",prependToContext:!0}),e.on("beforegetcontent",function(e){o&&"raw"!=e.format&&!e.draft&&(o=!0,a(!1))})});