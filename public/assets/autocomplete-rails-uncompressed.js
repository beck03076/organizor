!function(t){t.fn.railsAutocomplete=function(){var e=function(){this.railsAutoCompleter||(this.railsAutoCompleter=new t.railsAutocomplete(this))};return void 0!==t.fn.on?$(document).on("focus",this.selector,e):this.live("focus",e)},t.railsAutocomplete=function(t){_e=t,this.init(_e)},t.railsAutocomplete.fn=t.railsAutocomplete.prototype={railsAutocomplete:"0.0.1"},t.railsAutocomplete.fn.extend=t.railsAutocomplete.extend=t.extend,t.railsAutocomplete.fn.extend({init:function(e){function i(t){return t.split(e.delimiter)}function a(t){return i(t).pop().replace(/^\s+/,"")}e.delimiter=t(e).attr("data-delimiter")||null,t(e).autocomplete({source:function(i,n){t.getJSON(t(e).attr("data-autocomplete"),{term:a(i.term)},function(){0==arguments[0].length&&(arguments[0]=[],arguments[0][0]={id:"",label:"no existing match"}),t(arguments[0]).each(function(i,a){var n={};n[a.id]=a,t(e).data(n)}),n.apply(null,arguments)})},change:function(e,i){if(""!=t(t(this).attr("data-id-element")).val()){t(t(this).attr("data-id-element")).val(i.item?i.item.id:"");var a=t.parseJSON(t(this).attr("data-update-elements")),n=i.item?t(this).data(i.item.id.toString()):{};if(!a||""!=t(a.id).val())for(var r in a)t(a[r]).val(i.item?n[r]:"")}},search:function(){var t=a(this.value);return t.length<2?!1:void 0},focus:function(){return!1},select:function(a,n){var r=i(this.value);if(r.pop(),r.push(n.item.value),null!=e.delimiter)r.push(""),this.value=r.join(e.delimiter);else if(this.value=r.join(""),t(this).attr("data-id-element")&&t(t(this).attr("data-id-element")).val(n.item.id),t(this).attr("data-update-elements")){var l=t(this).data(n.item.id.toString()),o=t.parseJSON(t(this).attr("data-update-elements"));for(var u in o)t(o[u]).val(l[u])}var s=this.value;return t(this).bind("keyup.clearId",function(){t(this).val().trim()!=s.trim()&&(t(t(this).attr("data-id-element")).val(""),t(this).unbind("keyup.clearId"))}),t(e).trigger("railsAutocomplete.select",n),!1}})}}),t(document).ready(function(){t("input[data-autocomplete]").railsAutocomplete()})}(jQuery);