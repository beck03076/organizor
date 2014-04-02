function dataTableStart(table,filterValue,cols,cols_size,ransack)
{


  tableId = "#" + table;
  var hide_follow_up_sort = parseInt(cols_size);

  var oTable = $(tableId).dataTable({
    "bDestroy": true,
    "bJQueryUI": true,
    "bProcessing": true,
    "bServerSide": true,
    "sAjaxSource": $(tableId).data('source'),
    "fnServerParams": function ( aoData ) {
      aoData.push( { "name": "sFilter", "value": filterValue },
                   { "name": "sCols", "value": cols },
                   {"name": "sSearch_2", "value": ransack });
    },
    "aoColumnDefs": [
      { "bSortable": false, "aTargets": [ 0,hide_follow_up_sort,(hide_follow_up_sort + 1) ] }
    ],
    "iDisplayLength": 10,
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



    $('input#id_search').on('keyup',function(){
        var key =$(this).val();
        oTable.fnFilter(key);
    });

   $('body').on('click', tableId + ' #master_check, .row_check', function () {
     $('#mass-actions-pills').slideDown(); 
    });

   /* this is the ransack add/remove fields initialization */
   $('form').on('click', '.remove_fields', function (event) {
    $(this).closest('.field').remove();
    event.preventDefault();
   });

    $('.add_fields').unbind('click');

    $('.add_fields').click(function (event) {
        time = new Date().getTime();
        regexp = new RegExp($(this).data('id'), 'g');
        $(this).before($(this).data('fields').replace(regexp, time));
        event.preventDefault();
    });

   return oTable;

}
