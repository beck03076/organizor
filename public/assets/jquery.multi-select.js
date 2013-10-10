/*
* MultiSelect v0.8
* Copyright (c) 2012 Louis Cuny
*
* This program is free software. It comes without any warranty, to
* the extent permitted by applicable law. You can redistribute it
* and/or modify it under the terms of the Do What The Fuck You Want
* To Public License, Version 2, as published by Sam Hocevar. See
* http://sam.zoy.org/wtfpl/COPYING for more details.
*/
!function(e){var s={init:function(s){this.settings={disabledClass:"disabled",selectCallbackOnInit:!1,keepOrder:!1,dblClick:!1},s&&(this.settings=e.extend(this.settings,s));var t=this;return t.css("position","absolute").css("left","-9999px"),t.each(function(){var s=e(this);if(0==s.next(".ms-container").length){s.attr("id",s.attr("id")?s.attr("id"):"ms-"+Math.ceil(1e3*Math.random()));var l=e('<div id="ms-'+s.attr("id")+'" class="ms-container"></div>'),i=e('<div class="ms-selectable"></div>'),a=e('<div class="ms-selection"></div>'),n=e('<ul class="ms-list"></ul>'),o=e('<ul class="ms-list"></ul>');s.data("settings",t.settings);var c=null,r=null,d=0,u=0;s.find("optgroup,option").each(function(){if(e(this).is("optgroup"))c=e(this).attr("label"),r="ms-"+s.attr("id")+"-optgroup-"+d,n.append(e('<li class="ms-optgroup-container" id="'+r+'"><ul class="ms-optgroup"><li class="ms-optgroup-label">'+c+"</li></ul></li>")),d++;else{var l=e(this).attr("class")?" "+e(this).attr("class"):"",i=e('<li class="ms-elem-selectable'+l+'" ms-value="'+e(this).val()+'">'+e(this).text()+"</li>");e(this).attr("title")&&i.attr("title",e(this).attr("title")),(e(this).attr("disabled")||s.attr("disabled"))&&(i.attr("disabled","disabled"),i.addClass(t.settings.disabledClass)),t.settings.dblClick?i.dblclick(function(){s.multiSelect("select",e(this).attr("ms-value"))}):i.click(function(){s.multiSelect("select",e(this).attr("ms-value"))});var a=r?n.children("#"+r).find("ul").first():n;a.append(i)}}),t.settings.selectableHeader&&i.append(t.settings.selectableHeader),i.append(n),t.settings.selectedHeader&&a.append(t.settings.selectedHeader),a.append(o),l.append(i),l.append(a),s.after(l),s.find("option:selected").each(function(){s.multiSelect("select",e(this).val(),"init")}),e(".ms-elem-selectable",n).on("mouseenter",function(){e("li",l).removeClass("ms-hover"),e(this).addClass("ms-hover")}).on("mouseout",function(){e("li",l).removeClass("ms-hover")}),n.on("focusin",function(){e(this).addClass("ms-focus"),o.focusout()}).on("focusout",function(){e(this).removeClass("ms-focus"),e("li",l).removeClass("ms-hover")}),o.on("focusin",function(){e(this).addClass("ms-focus")}).on("focusout",function(){e(this).removeClass("ms-focus"),e("li",l).removeClass("ms-hover")}),s.on("focusin",function(){n.focus()}).on("focusout",function(){n.removeClass("ms-focus"),o.removeClass("ms-focus")}),s.onKeyDown=function(t,i){var a=e("."+i+" li:visible:not(.ms-optgroup-label, .ms-optgroup-container)",l),c=a.length,r=e("."+i+" li.ms-hover",l),d=e("."+i+" li:visible:not(.ms-optgroup-label, .ms-optgroup-container)",l).index(r),m=a.first().outerHeight(),h=Math.ceil(l.outerHeight()/m),f=Math.ceil(h/4);if(a.removeClass("ms-hover"),32==t.keyCode){var v="ms-selectable"==i?"select":"deselect";s.multiSelect(v,r.first().attr("ms-value"))}else if(40==t.keyCode){var p=d+1!=c?d+1:0,g=a.eq(p);g.addClass("ms-hover"),p>f?u+=m:0==p&&(u=0),e("."+i+" ul",l).scrollTop(u)}else if(38==t.keyCode){var b=d-1>=0?d-1:c-1,C=a.eq(b);a.removeClass("ms-hover"),C.addClass("ms-hover"),f>c-b+1?u=m*(c-f):u-=m,e("."+i+" ul",l).scrollTop(u)}else(37==t.keyCode||39==t.keyCode)&&(n.hasClass("ms-focus")?(n.focusout(),o.focusin()):(n.focusin(),o.focusout()))},s.on("keydown",function(e){if(s.is(":focus")){var t=n.hasClass("ms-focus")?"ms-selectable":"ms-selection";s.onKeyDown(e,t)}})}})},refresh:function(){e("#ms-"+e(this).attr("id")).remove(),e(this).multiSelect("init",e(this).data("settings"))},select:function(s,t){var l=this,a=l.find('option[value="'+s+'"]'),n=a.text(),o=a.attr("class"),c=a.attr("title"),r=e('<li class="ms-elem-selected'+(o?" "+o:"")+'" ms-value="'+s+'">'+n+"</li>"),d=e("#ms-"+l.attr("id")+" .ms-selectable ul"),u=e("#ms-"+l.attr("id")+" .ms-selection ul"),m=d.children('li[ms-value="'+s+'"]'),h=null;if("init"==t?h=!m.hasClass(l.data("settings").disabledClass)&&a.prop("selected"):(h=!m.hasClass(l.data("settings").disabledClass),l.focus()),h&&0==u.children('li[ms-value="'+s+'"]').length){var f=m.parent(".ms-optgroup");f.length>0&&1==f.children(".ms-elem-selectable:not(:hidden)").length&&f.children(".ms-optgroup-label").hide(),m.addClass("ms-selected"),m.hide(),a.prop("selected",!0),c&&r.attr("title",c),m.hasClass(l.data("settings").disabledClass)?r.addClass(l.data("settings").disabledClass):l.data("settings").dblClick?r.dblclick(function(){l.multiSelect("deselect",e(this).attr("ms-value"))}):r.click(function(){l.multiSelect("deselect",e(this).attr("ms-value"))});var v=u.children(".ms-elem-selected");if("init"!=t&&l.data("settings").keepOrder&&v.length>0){var p=function(e){return elems=d.children(".ms-elem-selectable"),elems.index(elems.closest('[ms-value="'+e+'"]'))},g=p(r.attr("ms-value"));if(0==g)u.prepend(r);else for(i=g-1;i>=0;i--){if(v[i]&&p(e(v[i]).attr("ms-value"))<g){e(v[i]).after(r);break}0==i&&e(v[i]).before(r)}}else u.append(r);r.on("mouseenter",function(){e("li",u).removeClass("ms-hover"),e(this).addClass("ms-hover")}).on("mouseout",function(){e("li",u).removeClass("ms-hover")}),"select_all"==t&&f.children(".ms-elem-selectable").length>0&&f.children(".ms-optgroup-label").hide(),("init"!=t||l.data("settings").selectCallbackOnInit)&&(l.trigger("change"),u.trigger("change"),d.trigger("change"),"function"!=typeof l.data("settings").afterSelect||"init"==t&&!l.data("settings").selectCallbackOnInit||l.data("settings").afterSelect.call(this,s,n))}},deselect:function(s){var t=this,l=e("#ms-"+t.attr("id")+" .ms-selection ul"),i=t.find('option[value="'+s+'"]'),a=l.children('li[ms-value="'+s+'"]');if(a){l.focusin();var n=e("#ms-"+t.attr("id")+" .ms-selectable ul"),l=e("#ms-"+t.attr("id")+" .ms-selection ul"),o=n.children('li[ms-value="'+s+'"]'),a=l.children('li[ms-value="'+s+'"]'),c=o.parent(".ms-optgroup");c.length>0&&(c.children(".ms-optgroup-label").addClass("ms-collapse").show(),c.children(".ms-elem-selectable:not(.ms-selected)").show()),i.prop("selected",!1),o.show(),o.removeClass("ms-selected"),a.remove(),l.trigger("change"),n.trigger("change"),t.trigger("change"),"function"==typeof t.data("settings").afterDeselect&&t.data("settings").afterDeselect.call(this,s,a.text())}},select_all:function(s){var t=this,l=e("#ms-"+t.attr("id")+" .ms-selectable ul");t.find("option:not(:selected)").each(function(){var i=e(this).val();if(s){var a=l.children('li[ms-value="'+i+'"]');a.filter(":visible").length>0&&t.multiSelect("select",i,"select_all")}else t.multiSelect("select",i,"select_all")})},deselect_all:function(){var s=this;e("#ms-"+s.attr("id")+" .ms-selection ul"),s.find("option:selected").each(function(){s.multiSelect("deselect",e(this).val(),"deselect_all")})}};e.fn.multiSelect=function(e){return s[e]?s[e].apply(this,Array.prototype.slice.call(arguments,1)):"object"!=typeof e&&e?(console.log&&console.log("Method "+e+" does not exist on jquery.multiSelect"),!1):s.init.apply(this,arguments)}}(jQuery);