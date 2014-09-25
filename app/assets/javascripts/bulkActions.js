// This is a manifest file that'll be compiled into one file in the production
// This js file has all the scripts thats necessary for bulk actions 
//  
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.

function pillClickShowModal(_id){
    $('.mass-actions-pills .pilled').click(function(){       
       var rows = getCheckedRowsAsArray(_id);
       var clicked = $(this).data('value');   
       $('.' + clicked + 'Modal').modal('show');
     });
}

function compareUsers(id,obj){
  var link = $(obj).data('link');
  var ids = getCheckedRowsAsArray(id);
  if (ids.length < 5)  
    window.open((link + '/' + ids.join("-")),'_top');  
  else
    bootbox.alert("You cannot compare more than 4 users!")
}

function toggleAllCheck(obj,tableId){
    var checkedStatus = obj.checked;
    $("#" + tableId +' tbody tr').find('td:first :checkbox').each(function () {
        $(this).prop('checked', checkedStatus);
    });
    if (checkedStatus == false){ 
      $('.mass-actions-pills').slideUp(); 
    }     
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

function getCheckedRowsAsArray(tableId,stop){
       stop = stop || 1;
       var idVal = '#' + tableId + ' #tr'
       var rowIds = $(idVal + ':checked').map(function(){
                                                  return $(this).val();
                                                }).get();
       if (rowIds.length == 0 && stop == 1){
         bootbox.alert("Mark at least one record. (Use checkboxes)");
         throw "stop execution";
       }else{
         return rowIds;
       }
}

function updateCommClaim(tableId,idPartialFee){
  var idPartialFee = idPartialFee || 0;  
  bulkAssoUpdate(tableId,"select","comm_claim_status_",'/update_comm_claim/programmes',
                'commClaimStatusModal',0,0,0,idPartialFee);
}

function updateAppStatus(tableId){
  bulkAssoUpdate(tableId,"select","app_status_",'/bulk_asso_update',
                 'appStatusModal','programme','application_status','app_status_id');
}

function updateProgStatus(tableId){
  bulkAssoUpdate(tableId,"select","prog_status_",'/bulk_asso_update',
                 'progStatusModal','registration','progression_status','progression_status_id');
}

function updateStudSource(tableId){
  bulkAssoUpdate(tableId,"select","stud_source_",'/bulk_asso_update',
                 'studSourceModal','enquiry','student_source','source_id');
}

function changeBranch(tableId){
  bulkAssoUpdate(tableId,"select","change_branch_",'/bulk_asso_update',
                 'changeBranchModal','registration','branch','branch_id');
}

function groupAssignTo(tableId){
       var rows = getCheckedRowsAsArray(tableId);
       sel_user = "select#branch_user_id"
       sel_branch = "select#group_assign_branch_" + tableId
       var user_id = $(sel_user).val();
       var branch_id = $(sel_branch).val();
       var model = $("#group_assign_to_" + tableId).data("model");

       url = '/group_assign/' + model + '/' + rows + '/branch/' + branch_id + '/user/' + user_id;

       $.get(url,function(table){
         $("#group_assign_to_" + tableId).css("display","none");
         // redrawing the datatable
         $('#' + tableId).dataTable().fnDraw();
         // closing the modal window
         $('.assignToModal').modal('toggle');
         // unchecking the master check box
         $('input#master_check').prop('checked', false);
         // restting the search filters
         resetDataTable();
       });
}


function groupDelete(tableId){
       var rows = getCheckedRowsAsArray(tableId);
       var model = $("#group_assign_to_" + tableId).data("model");

       url = '/group_delete/' + model + '/' + rows ;

       $.get(url,function(table){
         $('#' + tableId).dataTable().fnDraw();
         // closing the modal window
         $('.groupDeleteModal').modal('toggle');
         // unchecking the master check box
         $('input#master_check').prop('checked', false);
       });
}

function bulkEmail(tableId){
       var rows = getCheckedRowsAsArray(tableId);
       var model = $("#group_assign_to_" + tableId).data("model");
       url = '/bulk_email/' + model + '/' + rows ;
       // closing the modal window
       $('.bulkEmailModal').modal('toggle');
       window.open(url,
                   '_blank',
                   'location=yes,height=570,width=520,scrollbars=yes,status=yes');

}


function exportDetails(tableId){
       var rows = getCheckedRowsAsArray(tableId);
       var model = $("#export_details_format_" + tableId).data("model");
       sel = "select#export_details_format_" + tableId
       var format = $(sel).val();

       url = '/export_details/' + model + '/' + rows + '.' + format ;
   
       var $idown;
       if ($idown) {
            $idown.attr('src',url);
          } else {
            $idown = $('<iframe>', { id:'idown', src:url }).hide().appendTo('body');
       }
       
         // closing the modal window
         $('.exportDetailsModal').modal('toggle');
         // unchecking the master check box
         $('input#master_check').prop('checked', false);

       return false;
}

function bulkAssoUpdate(tableId,elem,what_,url,modal,main,asso,asso_col,id_partial_fee){
  //var main = main || 0;
  var asso = asso || 0;
  var asso_col = asso_col || 0;
  var id_partial_fee = id_partial_fee || 0;
   
  var rows = getCheckedRowsAsArray(tableId);
  sel = elem + "#" + what_ + tableId
  var status_id = $(sel).val();
  var user_id = $("#" + what_ + tableId).data("user-id");
  var main = $("#" + what_ + tableId).data("model");
  
  var data = {};
  data['main_ids'] = rows;
  data['asso_id'] = status_id;
  data['user_id'] = user_id;
  data['main'] = main;
  data['asso'] = asso;  
  data['asso_col'] = asso_col;
  data['id_partial_fee'] = id_partial_fee;
  
  var posting = $.post(url,data);
  
   // Put the results in a div
  posting.done(function( data ) {
    afterDatatableMass(tableId,modal);
    resetDataTable();
    $('.modal').modal('hide');
    bootbox.alert(data);
    
  });

}


function deselectAllCheck(divId){
    $(divId).find(':checkbox').each(function () {
        $(this).prop('checked',false);
     });
}

function afterDatatableMass(tableId,action){
  // redrawing the datatable
  $('#' + tableId).dataTable().fnDraw();
  // closing the modal window
  $('#' + action).modal('toggle');
  // unchecking the master check box
  $('input#master_check').prop('checked', false);
}

