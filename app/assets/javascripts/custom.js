function deactivateGroup(obj,target_div){
  var itemValue = obj.options[obj.selectedIndex].text.toLowerCase();
  if (itemValue == "educational"){  	
  	$(target_div).prop('disabled', false);
  }else{
  	$(target_div).prop('disabled', true);
  }
}