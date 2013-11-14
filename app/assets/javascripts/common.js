/**
* SHOW TABS
**/
$(document).ready(function(){
    /* ON CLICKING MAIN MENU*/
    $(".tab-menus li").click(function(){
        /* HIDE ALL TABS CONTENT*/
        $(".tab-content").hide();
        /* SHOW THE CORESPONDING TAB CONTENT*/
        $("#"+this.lang).show();
        /* INACTIVE ALL TABS */
        $(".tab-menus li").removeClass("active-tab");
        $(".tab-menus li").css({"background":"#EAEAEA"});
        /* ACTIVE CURRENT TABS */
        $(this).addClass("active-tab");
		/* SET DATATABLE WIDTH */
		setDataTableWidth();
    });
    
    /* ON CLICKING MAIN MENU*/
    $(".subtab-menus li").click(function(){
        /* HIDE ALL TABS CONTENT*/
        $(".subtab-content").hide();
        /* SHOW THE CORESPONDING TAB CONTENT*/
        $("#"+this.lang).show();
        /* INACTIVE ALL TABS */
        $(".subtab-menus li").removeClass("active-tab");
        /* ACTIVE CURRENT TABS */
        $(this).addClass("active-tab");
    });
    
    /* ON CLICKING MAIN MENU*/
    $(".tabs-list").click(function(){
        /* HIDE ALL TABS CONTENT*/
        $(".tab-content").hide();
        /* SHOW THE CORESPONDING TAB CONTENT*/
        $("#"+this.lang).show();
        /* INACTIVE ALL TABS */
        $(".tab-menus li").removeClass("active-tab");
    });
    
    /* HIDE ALL TABS CONTENT*/
    $(".subtab-content").hide();
    /* SHOW THE CORESPONDING TAB CONTENT*/
    $(".subtab-container .subtab-content:first").show();
    /* INACTIVE ALL TABS */
    $(".subtab-menus li").removeClass("active-tab");
    /* ACTIVE CURRENT TABS */
    $(".subtab-menus li:first").addClass("active-tab");
    
    
    /* ON CLICKING MAIN MENU*/
    $(".sbox").hover(function(){
        $(".sbox input").show();
        $(".sbox").animate({"left":"-242px"});
    },function(){
        $(".sbox input").hide();
        $(".sbox").animate({"left":"-43px"});
    });
    
    $(".pr-icon").click(function(){
        window.print() ;
    });
    $(".tab-menus li, .tabs-list").click(function(){
        placeFooter();
    });
    window.onload=placeFooter;
    window.onresize=placeFooter;
    window.onscroll=placeFooter;
    $("input[type='radio']").click(function(){
        placeFooter();
    });
    function placeFooter(){
        var bodyHeight=$("#main-body").height();
        var menuHeight=$("#left-panel").height();
        //bodyHeight=(bodyHeight>menuHeight) ? bodyHeight : menuHeight ; 
        $("#left-panel").css({"height":bodyHeight+"px"});
    }
});


$(document).ready(function(){
 $(".jqlink").click(function(){
     $("#"+this.lang).slideToggle();     
  });    
});

function activeTab(mainContentClass,activeTabContentId,activeTabId){
    /* HIDE ALL TABS CONTENT*/
    $("."+mainContentClass).hide();
    /* SHOW THE CORESPONDING TAB CONTENT*/
    $(".tab-container #"+activeTabContentId).show();
    /* INACTIVE ALL TABS */
    $(".tab-menus li").removeClass("active-tab");
    /* ACTIVE CURRENT TABS */
    $(".tab-menus #"+activeTabId).addClass("active-tab");
}

function activeMM(menuId){
    /* INACTIVE ALL TABS */
    $("#menu-main li").removeClass("active-main-menu");
    /* ACTIVE CURRENT TABS */
    $("#"+menuId).addClass("active-main-menu");    
}

function showPopUp(objectId){
    $("#"+objectId).bPopup();    
}


function toggleHS(objectId,mainClassName){
    $("."+mainClassName).hide();
    $("#"+objectId).show();    
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}


/**
* CHECK RADIO BUTTON IN THE TABLE
**/
$(document).ready(function(){
    $(".tb-stylev tr td input[type='checkbox']").click(function(){
        if($(this).is(':checked')){
            $(this).closest("tr").addClass("active-rows");    
        }else{
            $(this).closest("tr").removeClass("active-rows");    
        }
        
    });    
});


/**
* Add new go_create js
**/

$(document).ready(function(){
    $(".Bpclose").click(function(){
    $("#"+this.lang).css("display","none");
    });
});


function closePop(objectId){
$("#"+objectId).css("display","none");
}


function showPop(objectId,e){
xOffset = -10;
        yOffset = -40;        

$("#"+objectId).css("display","inline");
        $("#"+objectId)
            .css("top",(e.pageY - xOffset) + "px")
            .css("left",(e.pageX + yOffset) + "px")
            .fadeIn("slow");    

}

/* Senthil added this to use the parent() function to operate of the current go create pop  */
function showPopGoCreate(objectId,e,obj){
        xOffset = -10;
        yOffset = -40;        

        $(obj).parent().find("#"+objectId).css("display","inline");
        $(obj).parent().find("#"+objectId)
            .css("top",(e.pageY - xOffset) + "px")
            .css("left",(e.pageX + yOffset) + "px")
            .fadeIn("fast");    

}
/* Senthil added this to use the parent() function to operate of the current go create pop  */
function closePopGoCreate(objectId,obj){
  $(obj).parent().parent().parent().find("#"+objectId).css("display","none");
}


/*Storing in sessions here*/
function storeThemeInSession(){ 

          var themeColor = $("ul#theme-color > li.theme-colrs-active > span").data("theme");
          var bgColor = $("ul#bg-color > li.theme-colrs-active > span").data("bg");
          var waColor = $("ul#wa-color > li.theme-colrs-active > span").data("wa");
          $.cookie('themeColor', themeColor , { path: '/' });
          $.cookie('bgColor', bgColor , { path: '/' });
          $.cookie('waColor', waColor , { path: '/' });          
          info("Message","Saved your selection!.\ Theme Color : " + themeColor + ", Background Color : " + bgColor + ", Work Area Color : " + waColor);

}

/*SET THE THEME SESION VALUE HERE*/
function setColorsFromSession(){
    var backgroundColor = ($.cookie('bgColor') == undefined) ? "white" : $.cookie('bgColor') ;
    setBGColor(backgroundColor);
    
    var themeColor = ($.cookie('themeColor') == undefined) ? "blue" : $.cookie('themeColor') ;
    setThemeColor(themeColor);
    
    var waColor = ($.cookie('waColor') == undefined) ? "white" : $.cookie('waColor') ;
    setWAColor(waColor);
}


function activateTheme(removeClass,objectId,what){

/* REMOVE ALL ACTIVE THEME MENU CLASS NAME */
    $("#"+objectId).parent().parent().find("li").removeClass("theme-colrs-active");
    /* ADD ACTIVE THEME MENU CLASS NAME */
    $("#"+objectId).parent().addClass("theme-colrs-active");
    var col = $("#"+objectId).data(what);
    if (what == "theme"){ setThemeColor(col); }
    else if (what == "bg"){ setBGColor(col); }
    else if (what == "wa"){ setWAColor(col); }

}

/* wrote 1 function that acticates the bkgrnd, wk area and theme */
/*
function activateColor(objectId){

    $(".theme-colrs li").removeClass("theme-colrs-active");

    $("#"+objectId).parent().addClass("theme-colrs-active");
    
    var themeColor = $("#"+objectId).data('theme');
    
    setThemeColor(themeColor);

}

function activateBg(objectId){
  
    $("#bg-color li").removeClass("theme-colrs-active");
  
    $("#"+objectId).parent().addClass("theme-colrs-active");

}
*/
function setThemeColor(theme){
    /* APPLY THEMES */
    switch(theme){
        case "yellow":{
            mainColor="#FFC20E";
            thickColor="#DDA600";
            lightColor="#FFCD37";
            lightestColor="#FFFFCD";
            break;
        }
        case "blue":{
            mainColor="#2A88C8";
            thickColor="#00336C";
            lightColor="#3BA7F2";
            lightestColor="#E8F0FD";
            break;
        }
        case "orange":{
            mainColor="#FF6501";
            thickColor="#EA7500";
            lightColor="#FF9E3E";
            lightestColor="#FFEFDF";
            break;
        }
        case "green":{
            mainColor="#22B14C";
            thickColor="#177232";
            lightColor="#37D968";
            lightestColor="#D5FFD5";
            break;
        }
        case "violet":{
            mainColor="#713F98";
            thickColor="#682C91";
            lightColor="#915BBB";
            lightestColor="#EBE1F2";
            break;
        }
        case "pink":{
            mainColor="#C8158D";
            thickColor="#A61176";
            lightColor="#DF27AA";
            lightestColor="#FAD1ED";
            break;
        }
        case "red":{
            mainColor="#cc0000";
            thickColor="#a40000";
            lightColor="#d95151";
            lightestColor="#f5e8e8";
            break;
        }
        case "darkorange":{
            mainColor="#ce5c00";
            thickColor="#853010";
            lightColor="#eecdaa";
            lightestColor="#FFEFDF";
            break;
        }
    }
    $("#header").css({"background":mainColor,"border-bottom-color":thickColor});
    $(".btnp").css({"background":mainColor,"border-color":thickColor});
    $(".theme,.popuptitle").css({"background":mainColor});
    $(".uibox").css({"background":lightColor,"border-color":mainColor});
    $(".tab-content,.tab-menus .active-tab,.tab-menus li:hover,.tab-menus1 .active-tab,.tab-menus1 li:hover").css({"background":lightestColor});
    $(".btnpd").css({"background":lightColor,"border-color":mainColor,"color":mainColor});
    $(".tb-stylev tr th,.theme-l,theme-ls").css({"background":lightColor,"color":thickColor});


    
    $(".uibox").hover(function(){
        $(this).css({"background":"#fff"});
            $(".uiboxs").css({"background":"#fff"});
        },function(){
            $(".uibox").css({"background":lightColor,"border-color":mainColor});
    });
    
    $(".tab-menus li,.tab-menus1 li").click(function(){
        $(".tab-menus li,.tab-menus1 li").css({"background":"#EAEAEA"});
        $(".tab-menus .active-tab,.tab-menus1 .active-tab").css({"background":lightestColor});
    },function(){
        $(this).css({"background":lightestColor});
    });
}
/* ON CLICKING BG MENU*/
function setBGColor(bg){

    switch(bg){
        case "gray":{
            bgColor="#F3F0EB";
            borderColor="#F3F0EB";
            break;
        }
        case "white":{
            bgColor="#fff";
            borderColor="#fff";
            break;
        }
        case "cream":{
            bgColor="#FAF3E9";
            borderColor="#FAF3E9";
            break;
        }
        case "blue":{
            bgColor="#E7ECF2";
            borderColor="#E7ECF2";
            break;
        }
        case "darkblue":{
            bgColor="#729fcf";
            borderColor="#729fcf";
            break;
        }
        case "green":{
            bgColor="#E5FAE3";
            borderColor="#E5FAE3";
            break;
        }
        case "pink":{
            bgColor="#FAE3E5";
            borderColor="#FAE3E5";
            break;
        }
        case "lightblack2":{
            bgColor="#888a85";
            borderColor="#888a85";
            break;
        }
        case "darkblue1":{
            bgColor="#204a87";
            borderColor="#204a87";
            break;
        }
    }

   // $(".tab-content-theme").css({"background":bgColor});
    $("#right-panel").css({"background":bgColor});
    $("#main-body").css({"background":bgColor});

}



/* ON CLICKING BG MENU*/
function setWAColor(wa){

    /* APPLY BG */
    switch(wa){
        case "gray":{
            wa="#F3F0EB";
            break;
        }
        case "white":{
            wa="#fff";
            break;
        }
        case "cream":{
            wa="#FAF3E9";
            break;
        }
        case "blue":{
            wa="#E7ECF2";
            break;
        }
        case "darkblue":{
            wa="#729fcf";
            break;
        }
        case "green":{
            wa="#E5FAE3";
            break;
        }
        case "pink":{
            wa="#FAE3E5";
            break;
        }
    }

    $("div#tab-content62").css({"background":wa});
    $(".boxstheme").css({"border-color":wa});
    $(".box-theme-ch").css({"background":wa});
    
    
}
/**
*  THEME - STARTS
**/
$(document).ready(function(){
    /* ON CLICKING MAIN THEME*/
    $("#theme-color li span").click(function(){
        /* REMOVE ACTIVE CLASS FROM ALL SPAN TAGS */
        $("#theme-colrs li span").removeClass("theme-colrs-active");
        /* ACTIVE CURRENT THEME */
        $(this).addClass("theme-colrs-active");
    });
    
    /* ON CLICKING BG THEME*/
    $("#bg-color li span").click(function(){
        /* REMOVE ACTIVE CLASS FROM ALL SPAN TAGS */
        $("#bg-color li span").removeClass("theme-colrs-active");
        /* ACTIVE CURRENT THEME */
        $(this).addClass("theme-colrs-active");
    });
    
    /* ON CLICKING WORK AREA THEME*/
    $("#wa-color li span").click(function(){
        /* REMOVE ACTIVE CLASS FROM ALL SPAN TAGS */
        $("#wa-color li span").removeClass("theme-colrs-active");
        /* ACTIVE CURRENT THEME */
        $(this).addClass("theme-colrs-active");
    });
});

/**
*  REGISTRATION LAUNCH TABS - STARTS
**/
$(document).ready(function(){
    /* ON CLICKING MAIN MENU*/
    $(".newtab-menus li").click(function(){
        /* HIDE ALL TABS CONTENT*/
        $(".newtab-content").hide();
        /* SHOW THE CORESPONDING TAB CONTENT*/
        $("#"+this.lang).show();
        /* INACTIVE ALL TABS */
        $(".newtab-menus li").removeClass("active-tab");
        /* ACTIVE CURRENT TABS */
        $(this).addClass("active-tab");
    });
    
    $("#addInviteUserEmail input[type='text']").on("blur",function(){
        var totalEmptyTag=0;
        
        $("#addInviteUserEmail input[type='text']").each(function(){
            if(this.value == "") 
            totalEmptyTag=totalEmptyTag+1;
        });
        
        if(totalEmptyTag==1 || totalEmptyTag==0){
            var tag="<div class='frbox'><label>Email Address</label>";
                tag+="&nbsp;<input type='text' placeholder='Email Address'/>&nbsp;&nbsp;";
                tag+="<img src='/images/icons/deactivate.png' class='jqAddUserRemove pt'/></div>";
            $("#addInviteUserEmail").append(tag);
        }
    });
    
    $("#addInviteUserEmail .jqAddUserRemove").on("click",function(){
        $(this).parent().remove();
    });

});
    
function activeNewSubTab(mainContentClass,activeTabContentId,activeTabId){
    /* HIDE ALL TABS CONTENT*/
    $("."+mainContentClass).hide();
    /* SHOW THE CORESPONDING TAB CONTENT*/
    $(".newtab-container #"+activeTabContentId).show();
    /* INACTIVE ALL TABS */
    $(".newtab-menus li").removeClass("active-tab");
    /* ACTIVE CURRENT TABS */
    $(".newtab-menus #"+activeTabId).addClass("active-tab");
}




function toggleRightPanel(){
$('td#right-panel').slideToggle(function(){
    var width=$(".dataTables_wrapper").width();
    width=(width>830) ? "820px" : "1100px";
    $(".dataTables_wrapper").css({"width":width});
});

}

function setDataTableWidth(){
	var disp=$("td#right-panel").css("display");
	var width=$(".dataTables_wrapper").width();
    width=(disp!="none") ? "820px" : "1100px";
    $(".dataTables_wrapper").css({"width":width});
}


function showNotifiy(){
    $(".notify-msg").slideToggle(500);
    var uId = $(".notify-msg").data("user_id");
    if($(".notify-down").hasClass("dn")){
        $(".notify-up").addClass("dn");
        $(".notify-down").removeClass("dn");
    }else{
        $(".notify-down").addClass("dn");
        $(".notify-up").removeClass("dn");
    }
    
    $.post('/mark_all_check/' + uId);
    $("#notify_no").html('')
}


this.imagePreview = function(matter,matter_id){    
    /* CONFIG */
        
        xOffsetX = 12;
        yOffsetY = 40;
        var differenceWidth=0;
                
    /* END CONFIG */
    $(".preview").hover(function(e){
        //if ($(this).find('td.sload').length == 0){
        //  $('td.sload').remove();
        //    $(this).prepend('<td class="sload"><img src="/images/icons/sload.gif"></td>');
          $("#preview").remove();
        //}
//        $.data(this, "timer", setTimeout($.proxy(function() {
        
            this.title='';
            if (typeof matter_id === "undefined"){
              var id = $(this).data(matter + "_id");
            }
            else{
              var id = matter_id
            }
            
            $.get('/' + matter +'_hover/' + id,function(reply){
                var bodyContent = reply;
                differenceWidth=parseInt($(window).width())-parseInt(e.pageX);
                if(differenceWidth<450){
                    yOffsetY=-400;
                }else{
                    yOffsetY=-500;
                    }

                $("body").append('<div id="preview" class="otbox"><span class="close-pre fr">x</span>'+bodyContent+'</div>');                                 

                $("#preview")
                    .css("top",(e.pageY - xOffsetX) + "px")
                    .css("left",(e.pageX + yOffsetY) + "px")
                    .fadeIn("fast");
               
            });
//        $('td.sload').remove();
//        clearTimeout($.data(this, "timer"));
//        }, this), 1500));
        

    },function(){
          //clearTimeout($.data(this, "timer"));
//          $('td.sload').remove();
          
          $(".close-pre").click(function(){
                $("#preview").remove();
            });
    });
    
    /*
    $(".preview").mousemove(function(e){
        differenceWidth=parseInt($(window).width())-parseInt(e.pageX);
        if(differenceWidth<450){
            yOffsetY=-400;
        }else{
            yOffsetY=40;
            }
        $("#preview")
            .css("top",(e.pageY - xOffsetX) + "px")
            .css("left",(e.pageX + yOffsetY) + "px");
    });        */

};

$(document).ready(function(){
  $(".close-pre").on("click",function(){
   $("div[id^='preview']").remove();
 });
});

/**
* CALL THIS FUNCTION TO SHOW NOTIFICATION FOR SOME SECOND AND HIDE
**/
function showNotificationMsg(msg){
	$(".jqnotifymsg").remove();
	var tag="<center><div class='info-msg jqnotifymsg'>"+msg+"</div></center>";
	$(".notify-icon-box").append(tag);
	setTimeout(function(){$(".jqnotifymsg").fadeOut( "slow" );},4000);
}


