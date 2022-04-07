{% extends "layouts/base.volt" %}
{% block pagetop %}
<h1><i class="{{row_menu.icon}}"></i> {{row_menu.menu_title}}<small>{{row_menu.description}}</small></h1>
{% endblock %}
{% block content %}
{{ flash.output() }}
<a href="/advertising/add" class="btn btn-default"><i class="fa fa-plus"></i> Add new data</a>
<?php $this->partial("layouts/html/box/start",["icon"=>$row_menu->icon,"box_title"=>$row_menu->menu_title]); ?>
<table class="table table-bordered table-hover" id="dt_tbl">
    <thead>
        <tr>
            <th>No</th>
            <th>Advertiser</th>
            <th>Post Location</th>
            <th>Date Start</th>
            <th>Date End</th>
            <th>Status</th>
			<th>Aksi</th>
        </tr>
    </thead>
    <tbody>
        
    </tbody>
</table>
<?php $this->partial("layouts/html/box/end"); ?>
<script>
var table;
$(function(){
	//$.fn.dataTableExt.sErrMode = 'throw';
    $.fn.dataTable.ext.errMode = 'none';
    table = $('#dt_tbl').DataTable({
    "processing": true, //Feature control the processing indicator.
    "serverSide": true, //Feature control DataTables' server-side processing mode.
    // Load data for the table's content from an Ajax source
    "ajax": {
        "url": "/advertising/index/all_data",
        "type": "GET"
    },
    columns: [
        {
            data: "id",
            searchable: false,
            render: function (data, type, row, meta) {
                return meta.row + meta.settings._iDisplayStart + 1;
            }
        },
        {data: "advertiser"},
        {data: "post_location"},
        {data: "start_date"},
        {data: "end_date"},
        {data: "status"}
    ],
    //Set column definition initialisation properties.
    "columnDefs": [
        {
            "targets": 6,
            "render": function(data, type, row, meta){
               var str='';
               str += '<a href="/advertising/edit/'+row.id+'" title="Edit data" class="btn btn-xs btn-default"><span class="glyphicon glyphicon-pencil"></span></a>';
               //str += ' <a href="#" onclick="del_row('+"'"+row.id+"'"+')" title="Delete data" class="btn btn-xs btn-default"><span class="glyphicon glyphicon-trash"></span></a>';
               return str;
            }
        },
        {
            "searchable": false,
            "orderable": false,
            "targets": 0
        },
    ],
    "language": {
            "lengthMenu": "_MENU_",
    },
    "order": [[ 1, 'desc' ]],
    "sDom": "<'row'<'col-sm-1'l><'col-sm-8'<'dt_actions'>><'col-sm-3'f>r>t<'row'<'col-sm-5'i><'col-sm-7'p>>",
  });
  //$("div.toolbar").html(' <select class="form-control input-sm"><option value="">a</option></select>');
  $('#dt_tbl tbody').on( 'click', 'tr', function(){
    if ($(this).hasClass('selected')) {
        $(this).removeClass('selected');
    }
    else {
        table.$('tr.selected').removeClass('selected');
        $(this).addClass('selected');
    }
  });
  $('.dt_actions').html($('.dt_index_actions').html());
});
</script>
{% endblock %}