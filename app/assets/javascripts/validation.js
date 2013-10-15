/**
* VALIDATION.JS
* USED FOR CLIENT SIDE VALIDATION
* N - Number alone
* E - Valid email address
* A - Only alphabet
* AS - Alphabet with space
* AN - AlphaNumeric
* ANS - AlphaNumeric with space
* 
*/

/**
* GLOBAL REGULAR EXPRESSION AND IMG TAG
**/
var errorImg="<img src='/assets/icons/error.png' width='16' height='16'>";
var successImg="<img src='/assets/icons/success.png' width='16' height='16'>";
var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/; 
var numberReg=/^[0-9]*$/;
var onlyLetterReg=/^[a-zA-Z]*$/;
var letterWithSpaceReg=/^[a-zA-Z\s]*$/;
var alphaNumericReg=/^[a-zA-Z0-9]*$/;
var alphaNumericWithSpaceReg=/^[a-zA-Z0-9\s]*$/;
var isValidLength=true;

/**
* ON INPUT TEXT FIELD BOX IS FOCUSED
* SET THE MAXLENGTH FOR THE TEXT FIELD
**/
$(document).ready(function(){
	$("input[type='text']").focus(function(){
		var maxLength=$(this).data("maxlength");
		if(numberReg.test(maxLength)) { 
			$(this).attr("maxlength",maxLength);
		}
	});
}); 

/**
* MAIN VALIDATE MATHOD
* @INPUT - OBJECTID AND VALIDATION TYPE
* @OUTPUT - VALIDATION PASSED OR FAILED
**/
function validate(objectId,type){
	var value=$("#"+objectId).val();
	var required=$("#"+objectId).data("req");
	var minLength=$("#"+objectId).data("minlength");
	var maxLength=$("#"+objectId).data("maxlength");
	var label=$("#"+objectId).data("label");
	var isNotEmpty=isRequried(objectId,value,required);
	if(isNotEmpty){
		isValidLength=isValidMinMaxLength(objectId,minLength,maxLength);
	}
	if(isNotEmpty){
		switch(type){
			case 'A':{
				checkRegExp(onlyLetterReg,objectId,value,"Only Alphabet allowed");
				break;
			}
			case 'AS':{
				checkRegExp(letterWithSpaceReg,objectId,value,"Only Alphabet with space allowed");
				break;
			}
			case 'AN':{
				checkRegExp(alphaNumericReg,objectId,value,"Only Alphabet and Number allowed");
				break;
			}
			case 'ANS':{
				checkRegExp(alphaNumericWithSpaceReg,objectId,value,"Only AlphaNumeric with space allowed");
				break;
			}
			case 'N':{
				checkRegExp(numberReg,objectId,value,"Only Number allowed");
				break;
			}
			case 'E':{
				checkRegExp(emailReg,objectId,value,"Please enter valid Email address");
				break;
			}
		}
	}
	if(!isValidLength  && isNotEmpty){
		if(minLength!='' && maxLength!=''){
			activeError(objectId,"Length should be between "+minLength+" and "+maxLength);
		}else if(minLength!='' && maxLength==''){
			activeError(objectId,"Length should not be less than "+minLength);
		}else if(minLength=='' && maxLength!=''){
			activeError(objectId,"Length should not be greater than "+maxLength);
		}
	}

}

/**
* CHECK REGULAR EXPRESSION
* @INPUT - REGULAR EXPRESSION , OBJECT ID, VALUE AND ERROR MESSAGE
* @OUTPUT - VALIDATION PASSED OR FAILED
**/
function checkRegExp(regExp,objectId,value,message){
	if(!regExp.test(value)) {  
        activeError(objectId,message);
   }else{
		inActiveError(objectId);
	} 
}


/**
* REQURIED FIELD VALIDATION
* @INPUT - OBJECT ID, VALUE AND IS REQURIED(Y OR N)
* @OUTPUT - VALIDATION PASSED OR FAILED
**/
function isRequried(objectId,value,required){
var isNotEmpty=true;
	if(required=='Y' && $.trim(value)==''){
		isNotEmpty=false;
		activeError(objectId,"Please fill the field");
	}else if(required=='Y'){
		inActiveError(objectId);
	}
	return isNotEmpty;
}

/**
* MAXLENGTH AND MINLENGTH VALIDATION
* @INPUT - OBJECT ID, MAX LENGTH AND MIN LENGTH
* @OUTPUT - VALIDATION PASSED OR FAILED
**/
function isValidMinMaxLength(objectId,minLength,maxLength){
	var isValid = true;
	if(minLength=='' && maxLength!=''){
		isValid=($("#"+objectId).val().length>maxLength) ? false : true;
	}else if(minLength!='' && maxLength==''){
		isValid=($("#"+objectId).val().length<minLength) ? false : true;
	}else{
		isValid=($("#"+objectId).val().length<minLength || $("#"+objectId).val().length>maxLength) ? false : true;
	}
	
	return isValid;
}

/**
* SHOW ERROR MESSAGE
* @INPUT - OBJECT ID AND MESSAGE
**/
function activeError(objectId,message){
	var errorTag="<div class='error-content' id='"+objectId+"_error'>"+message+"</div>";
	$("#"+objectId+"_success").remove();
	$("#"+objectId+"_error").remove();
	//$("#"+objectId).after(errorTag);
	$("#"+objectId).addClass("error-box");
}

/**
* SHOW SUCCESS ICON
* @INPUT - OBJECT ID
**/
function inActiveError(objectId){
	var successTag="<div  class='success-content' id='"+objectId+"_success'>"+successImg+"</div>";
	$("#"+objectId+"_success").remove();
	$("#"+objectId+"_error").remove();
	//$("#"+objectId).after(successTag);
	$("#"+objectId).removeClass("error-box");
}

function validateAll(object){
var submitForm=false;
	$("#"+object.id).find('input[type=text], input[type=radio], input[type=checkbox], select, textarea').each(function(){
		$("#"+this.id).trigger("onblur");
		
	});
	var errorCount=$("#"+object.id+" .error-box").length; 
	submitForm=(errorCount==0) ? true : false;
	return submitForm;
}