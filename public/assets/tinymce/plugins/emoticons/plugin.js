tinymce.PluginManager.add("emoticons",function(t,e){function n(){var t;return t='<table role="presentation" class="mce-grid">',tinymce.each(i,function(n){t+="<tr>",tinymce.each(n,function(n){var i=e+"/img/smiley-"+n+".gif";t+='<td><a href="#" data-mce-url="'+i+'" tabindex="-1"><img src="'+i+'" style="width: 18px; height: 18px"></a></td>'}),t+="</tr>"}),t+="</table>"}var i=[["cool","cry","embarassed","foot-in-mouth"],["frown","innocent","kiss","laughing"],["money-mouth","sealed","smile","surprised"],["tongue-out","undecided","wink","yell"]];t.addButton("emoticons",{type:"panelbutton",popoverAlign:"bc-tl",panel:{autohide:!0,html:n,onclick:function(e){var n=t.dom.getParent(e.target,"a");n&&(t.insertContent('<img src="'+n.getAttribute("data-mce-url")+'" />'),this.hide())}},tooltip:"Emoticons"})});