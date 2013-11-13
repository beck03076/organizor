/*
 * Tooltip script 
 * powered by jQuery (http://www.jquery.com)
 * 
 * written by Alen Grakalic (http://cssglobe.com)
 * 
 * for more info visit http://cssglobe.com/post/1695/easiest-tooltip-and-image-preview-using-jquery
 *
 */
 

this.mytooltip = function(){	
	/* CONFIG */		
		xOffset = 10;
		yOffset = 20;		
	/* END CONFIG */		
	$(".tooltip").hover(function(e){											  
		this.t = this.title;
		this.title = "";						
		/* TYPE SHOULD BE (E,T,F) like data-type="E" */
		var type=$(this).data("type");
		if(type!="E"){
			$("#preview").css("width","320px");
			$(".previewBox").css("width","280px");
		}else{
			$("#preview").css("width","730px");
			$(".previewBox").css("width","700px");
		}
		
		$("body").append("<span id='tooltip'><img src='/images/icons/tooltip-arrow.png' class='tooltip-ar' />"+ this.t +"</span>");
		
		if(type!="E"){
			$("#preview").css("width","320px");
			$(".previewBox").css("width","280px");
		}else{
			$("#preview").css("width","730px");
			$(".previewBox").css("width","700px");
		}
		
		$("#tooltip")
			.css("top",(e.pageY - xOffset) + "px")
			.css("left",(e.pageX + yOffset) + "px")
			.fadeIn("slow");		
    },
	function(){
		this.title = this.t;		
		$("#tooltip").remove();
    });	
	$(".tooltip").mousemove(function(e){
		$("#tooltip")
			.css("top",(e.pageY - xOffset) + "px")
			.css("left",(e.pageX + yOffset) + "px");
	});			
};


$(document).ready(function(){
	mytooltip();
});
