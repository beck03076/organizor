/* jquery.nicescroll.plus
-- the addon for nicescroll
-- version 1.0.0 BETA
-- copyright 13 InuYaksa*2013
-- licensed under the MIT
--
-- http://areaaperta.com/nicescroll
-- https://github.com/inuyaksa/jquery.nicescroll
--
*/
!function(r){function o(r){var o={};switch(r){case"fb":o.autohidemode=!1,o.cursorcolor="#7B7C7E",o.railcolor="",o.cursoropacitymax=.8,o.cursorwidth=10,o.cursorborder="1px solid #868688",o.cursorborderradius="10px"}return o}function i(r,o){function i(){o._stylerfbstate=!1,o.rail.css({backgroundColor:""}),o.cursor.stop().animate({width:3},200)}if(o.rail)switch(r){case"fb":o.rail.css({"-webkit-border-radius":"10px","-moz-border-radius":"10px","border-radius":"10px"}),o.cursor.css({width:3});var t=o.ispage?o.rail:o.win;t.hover(function(){o._stylerfbstate=!0,o.rail.css({backgroundColor:"#CED0D3"}),o.cursor.stop().css({width:10})},function(){o.rail.drag||i()}),c(document).mouseup(function(){o._stylerfbstate&&i()})}}var c=r;if(c&&"nicescroll"in c){c.extend(c.nicescroll.options,{styler:!1});var t={niceScroll:c.fn.niceScroll,getNiceScroll:c.fn.getNiceScroll};c.fn.niceScroll=function(r,s){"undefined"!=typeof r&&"object"==typeof r&&(s=r,r=!1);var n=s&&s.styler||c.nicescroll.options.styler||!1;n&&(nw=o(n),c.extend(nw,s),s=nw);var l=t.niceScroll.call(this,r,s);return n&&i(n,l),l.scrollTo=function(r){var o=this.win.position(),i=this.win.find(r).position();if(i){var c=Math.floor(i.top-o.top+this.scrollTop());this.doScrollTop(c)}},l},c.fn.getNiceScroll=function(r){var o=t.getNiceScroll.call(this,r);return o.scrollTo=function(r){this.each(function(){this.scrollTo.call(this,r)})},o}}}(jQuery);