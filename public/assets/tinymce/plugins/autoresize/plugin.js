tinymce.PluginManager.add("autoresize",function(e){function t(o){var a,s,r=e.getDoc(),g=r.body,l=r.documentElement,m=tinymce.DOM,h=i.autoresize_min_height;"setcontent"==o.type&&o.initial||e.plugins.fullscreen&&e.plugins.fullscreen.isFullscreen()||(s=tinymce.Env.ie?g.scrollHeight:tinymce.Env.webkit&&0===g.clientHeight?0:g.offsetHeight,s>i.autoresize_min_height&&(h=s),i.autoresize_max_height&&s>i.autoresize_max_height?(h=i.autoresize_max_height,g.style.overflowY="auto",l.style.overflowY="auto"):(g.style.overflowY="hidden",l.style.overflowY="hidden",g.scrollTop=0),h!==n&&(a=h-n,m.setStyle(m.get(e.id+"_ifr"),"height",h+"px"),n=h,tinymce.isWebKit&&0>a&&t(o)))}var i=e.settings,n=0;e.settings.inline||(i.autoresize_min_height=parseInt(e.getParam("autoresize_min_height",e.getElement().offsetHeight),10),i.autoresize_max_height=parseInt(e.getParam("autoresize_max_height",0),10),e.on("init",function(){e.dom.setStyle(e.getBody(),"paddingBottom",e.getParam("autoresize_bottom_margin",50)+"px")}),e.on("change setcontent paste keyup",t),e.getParam("autoresize_on_init",!0)&&e.on("load",t),e.addCommand("mceAutoResize",t))});