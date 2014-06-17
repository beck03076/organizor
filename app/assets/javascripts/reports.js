function filterIndicator(bar){
  var bar = bar || '';
  $('#from' + bar + ',' + '#to' + bar).blur(function() {
    $('#last_months' + bar).prop('selectedIndex',0);
  });
  $('#last_months' + bar).focus(function() {
    $('#from' + bar + ',' + '#to' + bar).val('');
  });
}  

function save_report(obj){
    var form = getFormObj('ransack_form');
    $.post ('/save_report',form);
    return false;
}

function getFormObj(formId) {
    var formObj = {};
    var inputs = $('#'+formId).serializeArray();
    $.each(inputs, function (i, input) {        
        if (input.value.length != 0){
          formObj[input.name] = input.value;
        }
    });
    return formObj;
}

function change_chart(type,container,model,bar){ 
    var bar = bar || '';
    if($(container).find('#asso').val().length == 0){
      bootbox.alert("Choose a resource to create a chart!")
    }else {
        var data = {};
        var elem = ["asso","sub_asso","last_months" + bar, "from" + bar, "to" + bar];
        $.each(elem,function(i,val){
            data[val] =  $(container).find('#' + val).val();
        });
        data["model"] = model;        
        $.post('/partial_' + type + '.js',data);
    }
}

function change_split(type,obj,model){    
    var asso = $('.bar_chart').val();   
    if (asso.length == 0){
        bootbox.alert("Select a -bar- value first.")
    }   
    else{
      $.post('/partial_' + type + '.js',{split: $(obj).val(), model: model, asso: asso });
    }
}

/* function to scroll the window to this position of the element passed */
function scrollToCurrent(obj){
    var offset = $(obj).offset(); 
     offset.left -= 20;
     offset.top -= 200;
     scroll(offset.top,offset.left);    
}
/* given co ordinates as numbers to top and left it will scroll */
function scroll(top,left){
   $('html, body').animate({
        scrollTop: top,
        scrollLeft: left
   });  
}

function init_negative_chart(container,cat,ser,title){

       $(container).highcharts({
            chart: {
                type: 'column'
            },
            title: {
                text: title
            },
            xAxis: {
                categories: cat
            },
            yAxis: {
                min: 0,
                title: {
                    text: 'Total fruit consumption'
                },
                stackLabels: {
                    enabled: true,
                    style: {
                        fontWeight: 'bold',
                        color: (Highcharts.theme && Highcharts.theme.textColor) || 'gray'
                    }
                }
            },
            tooltip: {
                formatter: function() {
                    return '<b>'+ this.x +'</b><br/>'+
                        this.series.name +': '+ this.y +'<br/>'+
                        'Total: '+ this.point.stackTotal;
                }
            },
            credits: {
                enabled: false
            },
            series: ser
        });
}

function init_donut_chart(container,title,subtitle,data_name,data){
        $(container).highcharts({
                chart: {
                    type: 'pie',
                    options3d: {
                        enabled: true,
                        alpha: 45
                    }
                },
                title: {
                    text: title
                },
                subtitle: {
                    text: subtitle
                },
                plotOptions: {
                    pie: {
                        innerSize: 100,
                        depth: 45
                    }
                },
                series: [{
                    name: data_name,
                    data: data
                }]
            });
}    

function init_chart(type,series_data1,meta,series_data2,from){
   var from = from || "html"; 
   if (type == "pie"){
    
    // Build the chart
    $('#pie').highcharts({
            chart: {
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false
            },
            title: {
                text: meta
            },
            tooltip: {
              pointFormat: '{series.name}: <b>{point.y}</b>'
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true,
                        format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                        style: {
                            color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                        },
                        connectorColor: 'silver'
                    }
                }
            },
            series: [{
                type: 'pie',
                name: 'Total Number',
                data: series_data1
            }]
        });
        if (from == "js"){
        var a = $('#pie');
          scrollToCurrent(a);       
        }


    }
    else if(type == "bar"){        
        
        $('#bar').highcharts({
            chart: {
                type: 'column'
            },
            title: {
                text: meta
            },
            subtitle: {
                text: 'Bar chart that shows enquiries'
            },
            xAxis: {
                categories: series_data1,
                title: {
                    text: null
                }
            },
            yAxis: {
                min: 0,
                title: {
                    text: 'Units',
                    align: 'high'
                },
                labels: {
                    overflow: 'justify'
                }
            },
            tooltip: {
                valueSuffix: ' items'
            },
            plotOptions: {
                bar: {
                    dataLabels: {
                        enabled: true
                    }
                }
            },
            legend: {
                layout: 'vertical',
                align: 'right',
                verticalAlign: 'top',
                x: -40,
                y: 100,
                floating: true,
                borderWidth: 1,
                backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor || '#FFFFFF'),
                shadow: true
            },
            credits: {
                enabled: false
            },
            series: series_data2
        });  
          if (from == "js"){
          var a = $('#bar');
          scrollToCurrent(a);
          }      
     }
 }