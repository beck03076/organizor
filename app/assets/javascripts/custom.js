function deactivateGroup(obj,target_div){
  var itemValue = obj.options[obj.selectedIndex].text.toLowerCase();
  if (itemValue == "educational"){  	
  	$(target_div).prop('disabled', false);
  	$("a.recruitment_territories").show();
  	$("a.sliding_scales").show();  	
  }else{
  	$(target_div).prop('disabled', true);
  	$("a.recruitment_territories").hide();
  	$("a.sliding_scales").hide();
  }
}