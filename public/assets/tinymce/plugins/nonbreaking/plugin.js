tinymce.PluginManager.add("nonbreaking",function(n){var e=n.getParam("nonbreaking_force_tab");if(n.addCommand("mceNonBreaking",function(){n.insertContent(n.plugins.visualchars&&n.plugins.visualchars.state?'<span data-mce-bogus="1" class="mce-nbsp">&nbsp;</span>':"&nbsp;")}),n.addButton("nonbreaking",{title:"Insert nonbreaking space",cmd:"mceNonBreaking"}),n.addMenuItem("nonbreaking",{text:"Nonbreaking space",cmd:"mceNonBreaking",context:"insert"}),e){var a=+e>1?+e:3;n.on("keydown",function(e){if(9==e.keyCode){if(e.shiftKey)return;e.preventDefault();for(var t=0;a>t;t++)n.execCommand("mceNonBreaking")}})}});