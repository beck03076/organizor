// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_directory .
//= require jquery_nested_form
//= require tinymce
//= require tinymce-jquery
//= require dataTables/jquery.dataTables
//= require jquery.purr
//= require best_in_place
//= require private_pub
//= require fullcalendar


$(function(){
    
    $(".dateField").datepicker({
    inline: true,
    changeMonth: true, 
    changeYear: true, 
    dateFormat: "yy-mm-dd",
    yearRange: '1980:2050'
    });
    
    $.datepicker.setDefaults({
        inline: true,
        changeMonth: true, 
        changeYear: true, 
        dateFormat: "yy-mm-dd",
        yearRange: '1980:2050'
    });
    
    $(".dateTimeField").datetimepicker({
            inline: true,
            changeMonth: true, 
            changeYear: true, 
            yearRange: '1950:2030',
            controlType: 'select',
            dateFormat: 'yy-mm-dd', 
            timeFormat: 'hh:mm:ss'});
    
    setColorsFromSession();
    
    $('span.todo_checkbox').on("click",function(){
      if ($(this).find('span').data('state') == 'fill'){
        $(this).parent().parent().find('small.todo_desc').css("text-decoration","none");
       } 
      else if ($(this).find('span').data('state') == 'empty'){
        $(this).parent().parent().find('small.todo_desc').css("text-decoration","line-through");
       } 
    });
    
    $('#calendar').fullCalendar({
    editable: true,
    draggable: true,
    header: {
      left: 'prev,next today',
      center: 'title',
      right: 'month,agendaWeek,agendaDay'
    },
    defaultView: 'month',
    height: 500,
    slotMinutes: 30,
    eventSources: [
      {
        url: '/follow_ups',
        ignoreTimezone: false
      },
      {
        url: '/todos',
        ignoreTimezone: false
      }
    ],
    selectable: true,
    selectHelper: true,
    select: function(start, end, allDay) {

               $.get('/cal_click/'+ start + '/' + end,function(table){
                 $(".cal_click_container").empty();
                 var $container = $(".cal_click_container").html(table);
                 setColorsFromSession();
                  var $dTF = $('.dateTimeField', $container);
                  if ($dTF.length > 0) {
                    $dTF.datetimepicker({
                        inline: true,
                        changeMonth: true, 
                        changeYear: true, 
                        yearRange: '1950:2030',
                        controlType: 'select',
                        dateFormat: 'yy-mm-dd', 
                        timeFormat: 'hh:mm:ss'});
                  }
                 
                 showPopUp('cal_click');
               });

            },
    timeFormat: 'h:mm t{ - h:mm t} ',
    dragOpacity: "0.5",
    eventRender: function(event, element) { 
      element.parent().find('a.todo_this > .fc-event-inner').attr('class','todo_class');
      /*var target = element.parent().find('a  .fc-event-title');
      target.data("follow_up_id",event.id);
      target.attr('class','fc_event_title preview');
     
      imagePreview("follow_up");*/
    },

    });
    
     $('form#invite_users').submit(function(event){
        
        var sel = $('#role_select').val();
        if (sel.length == 0){
          event.preventDefault();
          info("No Role","Assign a role to the user(s) before inviting them to Organizor");
        }
        else{
          return true;
        }
        
    });
    
    
    
    $('#mini-calendar').fullCalendar({
        theme: true,
        editable: true,
        header: {
      left: 'prev,next today',
      right: 'month,agendaWeek,agendaDay'
    },
     

        eventSources: [
      {
        url: '/follow_ups'
      },
      {
        url: '/todos'
      }
    ],
      eventMouseover: function(event, jsEvent, view) {
            if (view.name !== 'agendaDay') {
                $(jsEvent.target).attr('title', event.title);
            }
        },
    eventRender: function(event, element) { 
      element.parent().find('a.todo_this > .fc-event-inner').attr('class','todo_class');

      //imagePreview("follow_up",event.id);
    },
    });
    
    dropdownUser('select#assigned_to_todo','/todo_assigned_to/');
    dropdownUser('select#assigned_by_todo','/todo_assigned_by/');
    dropdownUser('select#sent_by_email','/email_sent_by/');
    //dropdownUser('select#calendar_user','/calendar_user/');
});

function dropdownUser(elem,url){
  $(elem).change(function(event){
     var id = $(this).val();
     window.open(url + id,'_self',false);    
    });
}


function div_toggle(obj,div){   
    $(obj).parent().find(div).slideToggle();
    return false;
}

function sel_toggle(obj,div1,div2){   
    i = $(obj).parent()
    i.find(div1).slideToggle();
    i.find(div2).slideToggle();
    return false;
}

function regAppStatus(obj,div1){   
    $(div1).slideToggle();
    return false;
}

// Click on any of the radio buttons of programme_type(language_school or univeresity)
function p_type_click(obj,lang){
    //Fetching the object_name either enquiry or registration
    var o = $('#object_name').data('obj');
    //The parent div that contains the whole programme form
    i = $(obj).parent();
    // Setting the value of the countries_select to --Country-- when the radio button of programme_type is switched
    i.find('.countries_select').val($(".countries_select option:first").val());
    // Emptying the cities_select and institutions_select when the radio button of programme_type is switched
    empPromptSelect(i,'.cities_select','--City--');
    empPromptSelect(i,'.institutions_select','--Institution--');    
    // Based on the object_name and programme_type, the divs are shown and hidden
    if( o == "registration"){
      i.find(".ins_ref_no").show();
      i.find(".application_status_div").show();
    }
    if(lang == "language_school" && o == "enquiry"){
        i.find(".course_level_div").hide();
    }else if(lang == "university" && o == "enquiry") {
        i.find(".course_level_div").show();
    }else if(lang == "language_school" && o == "registration") {
        i.find(".course_subject_div").show();
        i.find(".course_level_div").hide();
        i.find(".course_subject_text_div").hide();
        i.find(".end_date_div").show();
        i.find(".start_date").text('Start date');
    }else if(lang == "university" && o == "registration") {
        i.find(".course_subject_div").hide();
        i.find(".course_level_div").show();
        i.find(".course_subject_text_div").show();
        i.find(".end_date_div").hide();
        i.find(".start_date").text('Intake Date');
    }

}


function empPromptSelect(o,cl,prom){
  o.find(cl).empty().append('<option value= selected="selected">' + prom + '</option>');
}

function submit_link(obj,tog,obj_name){
           var name = $(obj).parent().find("input#name").val();
           var desc = $(obj).parent().find("textarea#desc").val();

           if (name.length != 0){
               var param = {};
               param[obj_name] = {name: name, desc: desc};
               var sel = '.' + obj_name + '_select'
               obj_name = (obj_name == 'todo_status') ? 'todo_statuse' : obj_name
               obj_name = (obj_name == 'doc_category') ? 'doc_categorie' : obj_name
               obj_name = (obj_name == 'application_status') ? 'application_statuse' : obj_name
           $.ajax({
                url: '/'+obj_name+'s', //sumbits it to the given url of the form
                data:  param,
                type: 'POST',
                dataType: "JSON" }).success(function(json){                
                var id = json.id;
                var name = json.name;
                $(obj).parent().parent().find(sel).append('<option value=' + id + ' selected="selected">' + name + '</option>');
            });
            
            }
            $(obj).parent().parent().find(tog).css("display","none");
            $("input#name").val('');
            $("textarea#desc").val('');
            //$("#"+obj.lang).css("display","none");
            return false;
}

function prepareSelect(sourObj,destVar,hit)
{

    var index = sourObj.id.split("_")[3];
    var obj = $('div#object_name').data("obj");
    var destDiv = '#' + obj + destVar.replace("index", index);
    var pTypeId = $(sourObj).parent().parent().parent().parent().find('input:radio.programme_type:checked').val();
    var itemId = sourObj.options[sourObj.selectedIndex].value;
    
        if (hit == '/get_cities/'){
            var urlTo = hit + itemId;
        }
        else{
            var urlTo = hit + itemId + '/' + pTypeId;
        }
    
              if (itemId.length != 0){
                $.ajax({
                    url: urlTo,
                    type: 'GET',
                    dataType: "JSON",
                    success: function( json ) {
                        $(destDiv).empty();
                        $(destDiv).append('<option value= selected="selected">--Choose--</option>');
                        $.each(json, function(i,value) {                          
                          $(destDiv).append($('<option>').text(value.name).attr('value', value.id));
                        });
                    }
                });
              }
}

//list is 1 so the previous actions table for the enquirie will be returned in this partial
function action_partial(model,action,id)
{
  $.get("/" + model + "_action_partial/" + action + '/' + id + '/1',function(partial){
      
      var $container = $("#action_div").html(partial);
      setColorsFromSession();
      var $dTF = $('.dateTimeField', $container);
      if ($dTF.length > 0) {
        $dTF.datetimepicker({
            inline: true,
            changeMonth: true, 
            changeYear: true, 
            yearRange: '1950:2030',
            controlType: 'select',
            dateFormat: 'yy-mm-dd', 
            timeFormat: 'hh:mm:ss'});
      }
  });
}


//list is 0, no list table will be returned
function sel_act(sel){  
    var eTempId = sel.options[sel.selectedIndex].value;
    var enqId = $('#enquiry_id_div');
    var regId = $('#registration_id_div');
    var emailTo = $('#email_to').val().split(', ');
    var model = $('#email_model').val();
    var subject_ids = $('#email_' + model + '_ids_').val();
    if (enqId.length != 0){
      var eId = enqId.data("enquiry_id");
      var model = enqId.data("model_sing");
    }else if (regId.length != 0){
      var eId = regId.data("registration_id");
      var model = regId.data("model_sing");
    }

    $.post('/email_templates/partial', { etemp_id: eTempId, 
                                    model: model, 
                                    subject_ids: subject_ids, 
                                    list: 0,
                                    email_to: emailTo }, function (partial) {
            $('#email-action').html(partial); 
            setColorsFromSession();
            });
}

// enquiries tabs switching
function enquiryTabSwitch(obj){
    
    var cond = $(obj).data("cond");
    var partial = $(obj).data("partial");
    var enquiry_id = $(obj).data("enquiry_id");
    var lang = $(obj).attr("lang");
    
    url = '/enquiries/tab/' + cond + '/' + partial + '/'
    
    if (typeof enquiry_id !== "undefined"){ url = url + enquiry_id; }
    
    $('#'+lang).html("<div align='center'><h2>Loading...</h2></div>");
    
    $.get(url,function(table){

      var $container = $('#'+lang).html(table);
      var $dateField = $('.dateField', $container);
      var $mSel = $('#multiselect',$container);

      
      if ($dateField.length > 0) {
        $dateField.datepicker({
            inline: true,
            changeMonth: true, 
            changeYear: true, 
            dateFormat: "yy-mm-dd",
            yearRange: '1980:2050' });
        }
        
      if ($mSel.length > 0) {
        $mSel.multiSelect({
          keepOrder: true,
          size: 5
        });
       
           var $dSel = $('#deselect-all',$container);
           $('#deselect-all').click(function(){
             $mSel.multiSelect('deselect_all');
             return false;
           });
       
           $(".searchKey").keyup(function(){
        
            var searchWord=$.trim(this.value);
            searchWord=$.trim(searchWord.charAt(0).toUpperCase() + searchWord.slice(1));
            
            if(searchWord==''){
                $("#ms-multiselect .ms-selectable:first-child ul li").show();
                $("#ms-multiselect .ms-selectable:first-child ul .ms-selected").css({"display":"none"});
            }
            else{
                $("#ms-multiselect .ms-selectable:first-child ul li").hide();
                $("#ms-multiselect .ms-selectable:first-child ul li:contains('"+searchWord+"')").show();
                $("#ms-multiselect .ms-selectable:first-child ul .ms-selected").css({"display":"none"});
            }
           });
           $('#multiselect').multiSelect('deselect_all');
           
           var c_ids = $('#ms-selected-countries').data('country_ids');
           $.each(c_ids, function( index, value ){
             $("#ms-multiselect .ms-selectable:first-child ul li[ms-value="+ value +"]").trigger("click");
           });
           
      }
      
      

    });

}

function dataTableStart(table,filterValue,cols,cols_size)
{
  tableId = "#" + table;
  var hide_follow_up_sort = parseInt(cols_size);
  
  var oTable = $(tableId).dataTable({
    "bJQueryUI": true,
    "bProcessing": true,
    "bServerSide": true,
    "sAjaxSource": $(tableId).data('source'),
    "sPaginationType": "full_numbers",
    "fnServerParams": function ( aoData ) {
      aoData.push( { "name": "sFilter", "value": filterValue },
                   { "name": "sCols", "value": cols });
    },
    "aoColumnDefs": [
      { "bSortable": false, "aTargets": [ 0,1,hide_follow_up_sort ] }
    ], 
    "aLengthMenu": [[25, 50, 75, 100], [25, 50, 75, 100]],
    "iDisplayLength": 25,
     "fnRowCallback": function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
          var reg = $(aData[0]).data('registered');
          var fu_now = $(aData[0]).data('fu-now');
          var fu_week = $(aData[0]).data('fu-week');
          $(nRow).addClass(reg);
          $(nRow).addClass(fu_week);
          $(nRow).addClass(fu_now);
         
        }
  });
  
   $('select#mySelect').on('change',function(){
        var selectedValue = $(this).val();
        oTable.fnFilter(selectedValue, 0, true); //Exact value, column, reg
    });
    
    $('select#followUpSelect').on('change',function(){
        var selectedValue = $(this).val();
        oTable.fnFilter(selectedValue, 1, true); //Exact value, column, reg
    });
    
   $('body').on('click', tableId + ' tbody tr td:not(:first-child,:nth-child(2))', function () {
       var subId = $(this).parent().find("td > input").data('launch');
       window.open(subId,'_self',false);
   });

}



// registrations tabs switching
function registrationTabSwitch(obj){
    
    var cond = $(obj).data("cond");
    var partial = $(obj).data("partial");
    var _id = $(obj).data("registration_id");
    var enquiry_id = $(obj).data("enquiry_id");
    var note = $(obj).data("note");
    var lang = $(obj).attr("lang");

    url = '/registrations/tab/' + cond + '/' + partial + '/'
    
    if (typeof _id !== "undefined"){ url = url + _id; }
    else if (typeof enquiry_id === "undefined" || enquiry_id.length == 0   ){ url = url + _id; }
    else if (typeof enquiry_id !== "undefined" )
    { url = '/register/tab/new_registration/form/' + enquiry_id + "/" + note; }

     $('#'+lang).html("<div align='center'><h2>Loading...</h2></div>");
   
    $.get(url,function(table){
     
      var $container = $('#'+lang).html(table);
      var $dateField = $('.dateField', $container);
      
      if ($dateField.length > 0) {
        $dateField.datepicker({
            inline: true,
            changeMonth: true, 
            changeYear: true, 
            dateFormat: "yy-mm-dd",
            yearRange: '1980:2050' });
        }
    });
}



function toggleAllCheck(obj,tableId){
    var checkedStatus = obj.checked;
    $("#" + tableId +' tbody tr').find('td:first :checkbox').each(function () {
        $(this).prop('checked', checkedStatus);
     });
}

function toggleAllCheckRow(obj){
    var checkedStatus = obj.checked;
    $(obj).parent().parent().parent().parent().find('td :checkbox').each(function () {
        $(this).prop('checked', checkedStatus);
     });
}

function toggleAllCheckCol(obj){
     var checkedStatus = obj.checked;
     var index = $(obj).parent().index();
        $(obj).closest('table').find('tr').each(function () {
          $(this).find("td:eq("+index+") :checkbox").prop('checked', checkedStatus);
        });
}

function getCheckedRowsAsArray(tableId){
       var idVal = '#' + tableId + ' #tr'
       var rowIds = $(idVal + ':checked').map(function(){
                                                  return $(this).val();
                                                }).get(); 
       if (rowIds.length == 0){
         info("Message","Mark at least one record. (Use checkboxes)");
         throw "stop execution";
       }else{
         return rowIds;
       }
}

function groupAssignTo(tableId){
       var rows = getCheckedRowsAsArray(tableId);
       var user_id = $("select#group_assign_user_" + tableId).val();
       var model = $("#group_assign_to_" + tableId).data("model");
   
       url = '/group_assign/' + model + '/' + rows + '/user/' + user_id;

       $.get(url,function(table){
         $("#group_assign_to_" + tableId).css("display","none");
         $('#' + tableId).dataTable().fnDraw();
         
       });
}


function groupDelete(tableId){
       var rows = getCheckedRowsAsArray(tableId);
       var model = $("#group_assign_to_" + tableId).data("model");
   
       url = '/group_delete/' + model + '/' + rows ;

       $.get(url,function(table){
         $('#' + tableId).dataTable().fnDraw();
         $("#group_delete_to_" + tableId).bClose();
       });
}

function bulkEmail(tableId){
       var rows = getCheckedRowsAsArray(tableId);
       var model = $("#group_assign_to_" + tableId).data("model");
       url = '/bulk_email/' + model + '/' + rows ;
       
       window.open(url,
                   '_blank',
                   'location=yes,height=570,width=520,scrollbars=yes,status=yes');

}


function deselectAllCheck(divId){
    $(divId).find(':checkbox').each(function () {
        $(this).prop('checked',false);
     });
}

function manageRole(){
   var role_id = $("#role_select").val();
   $.get('/permissions/role/' + role_id,function(table){
         $('#' + 'permissions_container').html(table);
         $('#' + 'permissions_container').slideToggle();
   });
}


function checkRole(e){
      e.preventDefault();
      var sel = $('#role_select').val();
      if (typeof sel === "undefined"){
        alert("Choose a role");
      }
      return false
  }


function showHide(one,two){
  $('#' + one).css('display','none');
  $('#' + two).css('display','');
}

function resetDataTable(){
  $('.dataTables_filter input').val('').keyup();$('#mySelect').val($('#mySelect option:first').val()).trigger('change');$('#followUpSelect').val($('#followUpSelect option:first').val()).trigger('change');
}


