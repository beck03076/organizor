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
//= require jquery.purr
//= require best_in_place
//= require private_pub
//= require fullcalendar
//= require data-confirm-modal
//= require see_more




$(function(){

 $(document).on('nested:fieldAdded', function(event){
              var field = event.field;
              var dateField = field.find('.datepicker');
              dateField.datepicker({
                inline: true,
                changeMonth: true,
                changeYear: true,
                dateFormat: "yy-mm-dd",
                yearRange: '1980:2050'
              });
 });


  

dataConfirmModal.setDefaults({
  title: 'Confirm your action',
  commit: 'Continue',
  cancel: 'Cancel'
});

$('.datepicker').datepicker();

      dom_tokens('.token_coun_pro',"/srch_countries.json");
      dom_tokens('.token_coun_per',"/srch_countries.json");
      dom_tokens('.token_reg_pro',"/srch_regions.json");
      dom_tokens('.token_reg_per',"/srch_regions.json");

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




    $('#calendar').fullCalendar({
    editable: true,
    draggable: true,
    header: {
      left: 'prev,next today',
      center: 'title',
      right: 'month,agendaWeek,agendaDay'
    },
    defaultView: 'month',
    height: 700,
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
                 var $container = $(".cal_click_container").html(table);

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
                  $('#cal_create').modal("show");
               });

            },
    timeFormat: 'h:mm t{ - h:mm t} ',
    dragOpacity: "0.5",
    eventRender: function(event, element) {
      element.parent().find('a.todo_item div.fc-event-inner').addClass('cal_todo');
      element.parent().find('a.follow_up_item > .fc-event-inner').addClass('cal_follow_up');
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

function sel_toggle(div1,div2){
    $(div1).slideToggle();
    $(div2).slideToggle();
    return false;
}

function regAppStatus(obj,div1){
    $(div1).slideToggle();
    return false;
}

// Click on any of the radio buttons of programme_type(language_school or univeresity)
function ins_type_change(obj){
    lang = obj.options[obj.selectedIndex].text;
    //Fetching the object_name either enquiry or registration
    var o = $('#object_name').data('obj');
    //The parent div that contains the whole programme form
    i = $('.fields');
    // Setting the value of the countries_select to --Country-- when the radio button of programme_type is switched
    //i.find('.countries_select').val($(".countries_select option:first").val());
    // Emptying the cities_select and institutions_select when the radio button of programme_type is switched
    //empPromptSelect(i,'.cities_select','--City--');
    //empPromptSelect(i,'.institutions_select','--Institution--');
    // Based on the object_name and programme_type, the divs are shown and hidden
    if( o == "registration"){
      i.find(".ins_ref_no").show();
      i.find(".application_status_div").show();
    }
    if(lang == "Language School" && o == "enquiry"){
        i.find(".course_level_div").hide();
    }else if(lang == "University" && o == "enquiry") {
        i.find(".course_level_div").show();
    }else if(lang == "Language School" && o == "registration") {
        i.find(".course_subject_div").show();
        i.find(".course_level_div").hide();
        i.find(".course_subject_text_div").hide();
        i.find(".end_date_div").show();
        i.find(".start_date").text('Start date');
    }else if(lang == "University" && o == "registration") {
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
                obj_name = (obj_name == 'contract_doc_category') ? 'contract_doc_categorie' : obj_name
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
    selectUpdate(itemId,urlTo,destDiv);

}

//list is 1 so the previous actions table for the enquirie will be returned in this partial
function action_partial(model,action,id)
{
  $("#action_div").html("<img class=temp src=/images/icons/sload.gif >");
  $.get("/" + model + "_action_partial/" + action + '/' + id + '/1',function(partial){
      
      var $container = $("#action_div").html(partial);
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
function chooseEmailTemplate(sel){
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
            });
}


function activateTab(id,lang){
  var all_li = $('ul.seperator > li');
  /* HIDE ALL TABS CONTENT*/
  $(".tab-content").hide();
  /* SHOW THE CORESPONDING TAB CONTENT*/
  $("#"+lang).show();
}


// enquiries tabs switching
function enquiryTabSwitch(obj){

    var cond = $(obj).data("cond");
    var partial = $(obj).data("partial");
    var enquiry_id = $(obj).data("enquiry_id");
    var lang = $(obj).attr("lang");

    activateTab(cond,lang); //to make the clicked tab active

    url = '/enquiries/tab/' + cond + '/' + partial + '/'

    if (typeof enquiry_id !== "undefined"){ url = url + enquiry_id; }

    $('#'+lang).html("<div align='center'><h2>Loading...</h2></div>");

    $.get(url,function(table){

      var $container = $('#'+lang).html(table);
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

    activateTab(cond,lang); //to make the clicked tab active

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



// institutions tabs switching
function institutionTabSwitch(obj){
  TabSwitch(obj,'institution','institutions');
}

// people tabs switching
function personTabSwitch(obj){
  TabSwitch(obj,'person','people');
}

// generic tabs switching
function TabSwitch(obj,model,model_pl){

    var cond = $(obj).data("cond");
    var partial = $(obj).data("partial");
    // (eg) model = institution
    var institution_id = $(obj).data(model + "_id");
    var note = $(obj).data("note");
    var lang = $(obj).attr("lang");

    activateTab(cond,lang); //to make the clicked tab active

    // (eg) model_pl = institutions
    url = '/' + model_pl + '/tab/' + cond + '/' + partial + '/'

    if (typeof institution_id !== "undefined"){ url = url + institution_id; }

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
  $('input#id_search').val('').keyup();
  $('#mySelect').val($('#mySelect option:first').val()).trigger('change');
}

function simplePrepareSelect(sourObj,destSel,hit)
{
  var itemId = sourObj.options[sourObj.selectedIndex].value;
  var urlTo = hit + itemId + "/simple";
  selectUpdate(itemId,urlTo,destSel);
}

function prepSelect(sourObj,destSel,hit)
{
  var itemId = sourObj.options[sourObj.selectedIndex].value;
  var urlTo = hit + itemId;
  selectUpdate(itemId,urlTo,destSel);
}

function showInstitution(obj){
   if (obj.options[obj.selectedIndex].text == "Institution"){
    $('.institution').fadeIn(1000);
   }else{
    $('.institution').fadeOut(1000);
   }
}


//Creates the multiple areas text box
function tokens(textFieldId,url){

   $(textFieldId).tokenInput(url, {
    propertyToSearch: "name",
    crossDomain: false,
    theme: "facebook",
//    onAdd: updateNumbers,
//    onDelete: updateNumbers,
    prePopulate: $(textFieldId).data("pre"),
//    tokenDelimiter: "-",
    noResultsText: "Organizor found no results!",
    searchingText: "Organizor is searching...",
    preventDuplicates: true,
    resultsLimit:10,
//    tokenLimit:3,
    hintText: "Start searching..."
  });

}

function dom_tokens(cl,url){
  $(cl).each(function(){
        tokens('#' + this.id,url);
  });
}

function validateRecruit(obj){
  var institution_id = obj.options[obj.selectedIndex].value;
  var model = $(obj).data('model');
  if (model == "enquiry"){
    item_id = $('#enquiry_id').data('id');
  }else if (model == "registration"){
    item_id = $('#registration_id').data('id');
  }
  // new or edit scenario
  if ($('#' + model + '_country_id').length != 0){
    // nationality(country_id) from _form
    form_country_id = $('#' + model + '_country_id').val();
    // no nationality selected in _form scenario
    if (form_country_id.length == 0){ 
      bootbox.alert("Select a Nationality for this student in order to validate recruitment territory!"); 
      // Stop everything
      throw "stop execution";
    }
    // yes nationality selected in _form scenario
    else { url= '/validate_recruit/' + institution_id + '/' + form_country_id; }
  }
  // show scenario
  else{ url= '/validate_recruit/' + institution_id + '/0/' + model + '/' + item_id; }

  $.get(url,function(out){
    bootbox.alert(out);
  });
}

function selectUpdate(itemId,urlTo,destSel,query){
  query = query || "name";
  if (itemId.length != 0){

    $(destSel).fadeOut(1000);
                $.ajax({
                    url: urlTo,
                    type: 'GET',
                    dataType: "JSON",
                    success: function( json ) {
                        if (json == "") {  alert("No institutions configured"); }
                        $(destSel).empty();
                        $(destSel).append('<option value= selected="selected">-choose-</option>');
                        $.each(json, function(i,value) {
                          $(destSel).append($('<option>').text(eval("value." + query)).attr('value', value.id));
                        });
                    }
                });
    $(destSel).fadeIn(1000);
  }
}

function setInsTypeData(obj,dest){
  var itemId = obj.options[obj.selectedIndex].value;
  $(dest).data('city_id',itemId);
}

function changeInsType(obj,dest,type){
  var cityId = $(obj).data('city_id');
  var itemId = obj.options[obj.selectedIndex].value;
  if (type == "country"){
    var url = '/get_institutions/' + itemId}
  else if (type == "city"){
    var url = '/get_institutions/0/' + itemId}
  else if (type == "ins_type"){
    var city_id = $(obj).parent().parent().parent().siblings().find('.cities_select').val();
    var country_id = $(obj).parent().parent().parent().siblings().find('.countries_select').val();
    var url = '/get_institutions/' + country_id + '/' + city_id + '/' + itemId }
  var index = obj.id.split("_")[3];
  var obj = $('div#object_name').data("obj");
  var destDiv = '#' + obj + dest.replace("index", index);
  selectUpdate(itemId,url,destDiv);
}

/* Payments  Start */

function calcComm(obj){
  form = $(obj).parents('form');

  fee = parseFloat(form.find('input#fee_tuition_fee').val().replace(",",''));
  sch = parseFloat(form.find('input#fee_scholarship').val().replace(",",''));
  per = parseFloat(form.find('input#fee_commission_percentage').val().replace(",",''));
  
  
  result = (((fee - sch) / 100) * per).toFixed(2);

  if (!isNaN(result)){
   form.find('input#fee_commission_amount').val(result);
  }else{
   form.find('input#fee_commission_amount').val('');
  }
}

function checkRemaining(val,rem,name){

  if ((val * 100) > rem){
     bootbox.alert(name + "'s entered commission is higher than the remaining commission!");
     throw "stop execution";
  }
}


function tabLength(oTable,obj){
 var selectedValue = obj.options[obj.selectedIndex].text;
 var oSettings = oTable.fnSettings();
 oSettings._iDisplayLength = selectedValue;
 oTable.fnDraw();
}

function importContacts(url){
  $('#import_contacts_button').text("Importing...")
  $(this).submit();
}

function actmm(what){
  $('ul.main-menu li').removeClass('active');
  $('ul.main-menu li#' + what).addClass('active');
}

function actsm(what){
    $('ul.sub-menu li').removeClass("active");
    $('ul.sub-menu li#' + what).addClass("active");
}

function acttab(what){
    $('ul.seperator li').removeClass("active");
    $('ul.seperator li#' + what).addClass("active");
}

function actdd(){
    $('ul.seperator li.dropdown').addClass("active");
}

function colsClick(model){
  var cols = $('#' + model).data('cols');

  $.each(cols, function( index, value ){
    $("#ms-user_config_" + model + "_ .ms-selectable:first-child ul li[id="+ value +"-selectable]").trigger("click");
  });

    var selector = "#ms-user_config_" + model + "_ .ms-selectable"

    $(selector + " ul").click(function(){
      var colsNo = $(selector + " ul.ms-list > li.ms-selected").length ;
      if (colsNo > 10){
        bootbox.alert("You can select only 10 columns to display!");
        $("#ms-user_config_" + model + "_ .ms-selection ul.ms-list > li.ms-selected").last().trigger("click");
      }

    });

}

function filterUsers(obj,model){
  $('.users > h3').append("<img class=temp src=/images/icons/sload.gif >");
  $.getScript("/filter_users/" + model +"/" + obj.value);
}

function filterTodos(){
  $('h3').append("<img class=temp src=/images/icons/sload.gif >");
  var e = ['period', 'done', 'assigned_by','topic'];

  $.each(e, function(key, value) {
    window[value] = $('#todo-filter #' + value).val();
  });

  var duedate = $('#todo-filter #duedate').val();

  $.post('/filter_todos.js', { filter: true,
                     period: period,
                     done: done,
                     assigned_by: assigned_by,
                     topic_id: topic,
                     duedate: duedate});
}

function filterTodosReset(){
  $('input#duedate').val('');
  var e = ['period', 'done', 'assigned_by','topic'];

  $.each(e, function(key, value) {
    $('#' + value).val($('#' + value + ' option:first').val());
    // triggering change on select to reset the whole table.
    if (key == 3){
      $('#' + value).val($('#' + value + ' option:first').val()).trigger("change");
    }
  });
}

function actMultiSelect(cl){
  $('.' + cl).multiSelect({
        selectableHeader: "<input type='text' class='form-control' autocomplete='off' placeholder='Search...'>",
        selectionHeader: "<input type='text' class='form-control' autocomplete='off' placeholder='Search...'>",
        afterInit: function(ms){
          var that = this,
              $selectableSearch = that.$selectableUl.prev(),
              $selectionSearch = that.$selectionUl.prev(),
              selectableSearchString = '#'+that.$container.attr('id')+' .ms-elem-selectable:not(.ms-selected)',
              selectionSearchString = '#'+that.$container.attr('id')+' .ms-elem-selection.ms-selected';

          that.qs1 = $selectableSearch.quicksearch(selectableSearchString)
          .on('keydown', function(e){
            if (e.which === 40){
              that.$selectableUl.focus();
              return false;
            }
          });

          that.qs2 = $selectionSearch.quicksearch(selectionSearchString)
          .on('keydown', function(e){
            if (e.which == 40){
              that.$selectionUl.focus();
              return false;
            }
          });
        },
        afterSelect: function(){
          this.qs1.cache();
          this.qs2.cache();
        },
        afterDeselect: function(){
          this.qs1.cache();
          this.qs2.cache();
        }
      });

}


function token(model,filter){
$('.filter_container').html('');
  $.get('/get_column_names/' + model + '/' + filter,function(out){
      $.each(out, function(i,col){
         $('.filter_container').append('<input class="' + col +'" name=' + model +'[' + col+']  placeholder="'+col+'" type="text"><br/>')
         $("." + col).tokenInput("/search/" + model + '/' +  col +"/token.json", {
           placeHolderText: col,
           propertyToSearch: col,
           crossDomain: false,
           theme: "facebook",
           preventDuplicates: true,
           resultsLimit:10,
           tokenLimit:5,
         });
      });
  });
}

function slidingScale(field){
  field = field || $(document);
  field.find( ".slider-range" ).slider({
          range: true,
          min: 1,
          max: 100,
          values: [ 1, 50 ],
          slide: function( event, ui ) {
            $(this).siblings().find( "#from" ).val( ui.values[ 0 ]);
            $(this).siblings().find( "#to" ).val( ui.values[ 1 ]);
          }
  });
}



function fetchContract(progId){
  
  var posting = $.post('/fetch_contract',{'prog_id': progId });
  
   // Put the results in a div
  posting.done(function( data ) {
    bootbox.alert(data);
    $('input#fee_commission_percentage').val(data);
    $('input#fee_commission_percentage').keyup();
  });

 
}
//stands for find reset and hide, specific function, removes slider and range
//Sr - Sliding Range
function fRHideSr(obj,ids,s,whole_div){
  var elems = $(obj).parent().siblings().find(ids);
  var slider_obj = $(obj).closest(s);
  var elems1 = $(obj).closest(whole_div);
  elems.remove();  
  elems1.remove();  
  $(slider_obj).slider("destroy");
}

//stands for find reset and hide, specific function
//Sr - Sliding Scale
// pr - progression, cl =course level
function fRHideSs(obj,type){
  if (type=="pr"){
    var elem = $(obj).parents(3).siblings('#progression');
  }else if(type=="cl"){
    var elem = $(obj).parents(2).children('#course_level');
  }
  elem.val('');
  elem.toggle('fast');
  
}

function setCurrency(obj,dest)
{
  var itemId = obj.options[obj.selectedIndex].value;
  var url = "/get_currency/" + itemId;
  var index = obj.id.split("_")[3];
  var obj = $('div#object_name').data("obj");
  var destDiv = '#' + obj + dest.replace("index", index);
  selectUpdate(itemId,url,destDiv);
}











