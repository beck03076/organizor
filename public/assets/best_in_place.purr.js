/**
 * jquery.purr.js
 * Copyright (c) 2008 Net Perspective (net-perspective.com)
 * Licensed under the MIT License (http://www.opensource.org/licenses/mit-license.php)
 *
 * @author R.A. Ray
 * @projectDescription  jQuery plugin for dynamically displaying unobtrusive messages in the browser. Mimics the behavior of the MacOS program "Growl."
 * @version 0.1.0
 *
 * @requires jquery.js (tested with 1.2.6)
 *
 * @param fadeInSpeed           int - Duration of fade in animation in miliseconds
 *                          default: 500
 *  @param fadeOutSpeed         int - Duration of fade out animationin miliseconds
                            default: 500
 *  @param removeTimer          int - Timeout, in miliseconds, before notice is removed once it is the top non-sticky notice in the list
                            default: 4000
 *  @param isSticky             bool - Whether the notice should fade out on its own or wait to be manually closed
                            default: false
 *  @param usingTransparentPNG  bool - Whether or not the notice is using transparent .png images in its styling
                            default: false
 */
!function(e){e.purr=function(n,t){function r(){var r=document.createElement("a");if(e(r).attr({className:"close",href:"#close"}).appendTo(n).click(function(){return a(),!1}),e(document).keyup(function(e){27===e.keyCode&&a()}),n.appendTo(i).hide(),n.fadeIn(t.fadeInSpeed),!t.isSticky)var o=setInterval(function(){0===n.prevAll(".purr").length&&(clearInterval(o),setTimeout(function(){a()},t.removeTimer))},200)}function a(){n.animate({opacity:"0"},{duration:t.fadeOutSpeed,complete:function(){n.animate({height:"0px"},{duration:t.fadeOutSpeed,complete:function(){n.remove()}})}})}n=e(n),n.addClass("purr");var i=document.getElementById("purr-container");i||(i='<div id="purr-container"></div>'),i=e(i),e("body").append(i),r()},e.fn.purr=function(n){return n=n||{},n.fadeInSpeed=n.fadeInSpeed||500,n.fadeOutSpeed=n.fadeOutSpeed||500,n.removeTimer=n.removeTimer||4e3,n.isSticky=n.isSticky||!1,n.usingTransparentPNG=n.usingTransparentPNG||!1,this.each(function(){new e.purr(this,n)}),this}}(jQuery),jQuery(document).on("best_in_place:error",function(e,n){jQuery.each(jQuery.parseJSON(n.responseText),function(e,n){"object"==typeof n&&(n=e+" "+n.toString());var t=jQuery("<span class='flash-error'></span>").html(n);t.purr()})});