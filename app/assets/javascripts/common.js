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
        /* ACTIVE CURRENT TABS */
        $(this).addClass("active-tab");
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

function showPop(objectId,e){
xOffset = 50;
yOffset = -130;        
$("#"+objectId).css("display","inline");
        $("#"+objectId)
            .css("top",(e.pageY - xOffset) + "px")
            .css("left",(e.pageX + yOffset) + "px")
            .fadeIn("fast");    

}


$(document).ready(function(){
	/* ON CLICKING THEME MENU*/
	$(".theme-colrs li span").click(function(){
		var theme=$(this).data("theme");
		var mainColor="#2A88C8";
		var thickColor="#00336C";
		var lightColor="#3BA7F2";
		var lightestColor="#E8F0FD";
		/* REMOVE ALL ACTIVE THEME MENU CLASS NAME */
		$(".theme-colrs li").removeClass("theme-colrs-active");
		/* ADD ACTIVE THEME MENU CLASS NAME */
		$(this).parent().addClass("theme-colrs-active");
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
		}
		$("#header").css({"background":mainColor,"border-bottom-color":thickColor});
		$(".btnp").css({"background":mainColor,"border-color":thickColor});
		$(".theme").css({"background":mainColor});
		$(".uibox").css({"background":lightColor,"border-color":mainColor});
		$(".tab-content,.tab-menus .active-tab,.tab-menus li:hover").css({"background":lightestColor});
		$(".btnpd").css({"background":lightColor,"border-color":mainColor,"color":mainColor});
		$(".tb-stylev tr th,.theme-l").css({"background":lightColor,"color":thickColor});
		
		$(".uibox").hover(function(){
			$(this).css({"background":"#fff"});
				$(".uiboxs").css({"background":"#fff"});
			},function(){
				$(".uibox").css({"background":lightColor,"border-color":mainColor});
		});
		
		$(".tab-menus li").click(function(){
			$(".tab-menus li").css({"background":"#EAEAEA"});
			$(".tab-menus .active-tab").css({"background":lightestColor});
		},function(){
				$(this).css({"background":lightestColor});
		});
		
		$(".tab-menus li").hover(function(){
			$(".tab-menus li").css({"background":"#EAEAEA"});
			$(this).css({"background":lightestColor});
		});
		
		
	});
	
});
