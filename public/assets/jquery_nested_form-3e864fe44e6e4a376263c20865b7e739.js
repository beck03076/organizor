!function(e){window.NestedFormEvents=function(){this.addFields=e.proxy(this.addFields,this),this.removeFields=e.proxy(this.removeFields,this)},NestedFormEvents.prototype={addFields:function(t){var r=t.currentTarget,d=e(r).data("association"),i=e("#"+e(r).data("blueprint-id")),n=i.data("blueprint"),s=(e(r).closest(".fields").closestChild("input, textarea, select").eq(0).attr("name")||"").replace(new RegExp("[[a-z_]+]$"),"");if(s)for(var a=s.match(/[a-z_]+_attributes(?=\]\[(new_)?\d+\])/g)||[],l=s.match(/[0-9]+/g)||[],o=0;o<a.length;o++)l[o]&&(n=n.replace(new RegExp("(_"+a[o]+")_.+?_","g"),"$1_"+l[o]+"_"),n=n.replace(new RegExp("(\\["+a[o]+"\\])\\[.+?\\]","g"),"$1["+l[o]+"]"));var f=new RegExp("new_"+d,"g"),c=this.newId();n=e.trim(n.replace(f,c));var g=this.insertFields(n,d,r);return g.trigger({type:"nested:fieldAdded",field:g}).trigger({type:"nested:fieldAdded:"+d,field:g}),!1},newId:function(){return(new Date).getTime()},insertFields:function(t,r,d){var i=e(d).data("target");return i?e(t).appendTo(e(i)):e(t).insertBefore(d)},removeFields:function(t){var r=e(t.currentTarget),d=r.data("association"),i=r.prev("input[type=hidden]");i.val("1");var n=r.closest(".fields");return n.hide(),n.trigger({type:"nested:fieldRemoved",field:n}).trigger({type:"nested:fieldRemoved:"+d,field:n}),!1}},window.nestedFormEvents=new NestedFormEvents,e(document).delegate("form a.add_nested_fields","click",nestedFormEvents.addFields).delegate("form a.remove_nested_fields","click",nestedFormEvents.removeFields)}(jQuery),/*
 * Copyright 2011, Tobias Lindig
 *
 * Dual licensed under the MIT (http://www.opensource.org/licenses/mit-license.php)
 * and GPL (http://www.opensource.org/licenses/gpl-license.php) licenses.
 *
 */
function(e){e.fn.closestChild=function(t){if(t&&""!=t){var r=[];for(r.push(this);r.length>0;)for(var d=r.shift(),i=d.children(),n=0;n<i.length;++n){var s=e(i[n]);if(s.is(t))return s;r.push(s)}}return e()}}(jQuery);