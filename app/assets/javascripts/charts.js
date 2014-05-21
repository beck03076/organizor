function change_chart(type,obj,model){    
    $.post('/partial_' + type + '.js',{asso: $(obj).val(), model: model });
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



function init_chart(type,series_data1,meta,series_data2) {

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

    }
    else if(type == "bar"){        
        
        $('#bar').highcharts({
            chart: {
                type: 'bar'
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
                    text: 'Population (millions)',
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
        }    
    }