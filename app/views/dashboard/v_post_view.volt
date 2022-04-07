<div class="box box-info">
    <div class="box-header with-border">
      <div class="row">
        <div class="col-md-10">
            <h3 class="box-title"><i class="fa fa-bar-chart"></i> Grafik post views</h3>
        </div>
        <div class="col-md-2">
            {{data.list_fil_post_view}}
        </div>
      </div>
    </div>
    <div class="box-body">
        <div id="grafik-post-view"></div>
    </div>
</div>
<script>
$(document).ready(function(){
    _on_load_post_view($('#list_fil_post_view').val());
});


function _on_load_post_view(thn){
    $('#grafik-post-view').html('<p class="text-center">Loading...!!!<br/><i class="fa fa-spinner fa-spin"></i></p>');
    $.get('/dashboard/index/grafik_total_post_view',{thn:thn},function(r){
        var rs=jQuery.parseJSON(r);
        console.log(rs);
        if(rs.success){
            load_post_view(thn,rs.data.categories,rs.data.series);
        }else{
            alert(rs.error.message);
        }
    });
}

function load_post_view(thn,cat,series){
    Highcharts.chart('grafik-post-view', {
        chart: {
            type: 'line'
        },
        credits: {
            enabled: false
        },
        title: {
            text: 'Total Post Views'
        },
        subtitle: {
            text: 'Tahun '+thn
        },
        xAxis: {
            categories: cat,
            crosshair: true
        },
        yAxis: {
            min: 0,
            title: {
                text: 'Total'
            }
        },
        tooltip: {
            headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                '<td style="padding:0"><b>{point.y:1f}</b></td></tr>',
            footerFormat: '</table>',
            shared: true,
            useHTML: true
        },
        plotOptions: {
            column: {
                pointPadding: 0.2,
                borderWidth: 0
            }
        },
        series: [series]
    });
}



function load_post_viewx(thn,dt){
    Highcharts.chart('grafik-post-view', {
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false,
            type: 'pie'
        },
        credits: {
            enabled: false
        },
        title: {
            text: 'Total Post Views'
        },
        subtitle: {
            text: 'Tahun '+thn
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.y:1f}</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    format: '<b>{point.name}</b>: {point.y:1f}',
                    style: {
                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                    }
                },
                showInLegend: true
            }
        },
        series: [{
            name: 'Total',
            colorByPoint: true,
            data: dt,
        }]
    });
}
</script>