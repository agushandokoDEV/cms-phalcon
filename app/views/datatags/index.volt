{% extends "layouts/base.volt" %}
{% block pagetop %}
<h1><i class="{{row_menu.icon}}"></i> {{row_menu.menu_title}}<small>{{row_menu.description}}</small></h1>
{% endblock %}
{% block content %}
{{ flash.output() }}
<a href="/datatags/add" class="btn btn-default"><i class="fa fa-plus"></i> Add new data</a>
<?php $this->partial("layouts/html/box/start",['icon'=>$row_menu->icon,'box_title'=>$row_menu->menu_title]); ?>
<table class="table table-bordered table-hover" id="dt_tbl">
    <thead>
        <tr>
            <th>No</th>
            <th>Tags</th>
            <th>Slug</th>
            <th>Type</th>
			<th>Aksi</th>
        </tr>
    </thead>
    <tbody>
        
    </tbody>
</table>
<?php $this->partial("layouts/html/box/end"); ?>
<div class="hide">    
	<div class="dt_index_actions">
    {{data.list_category}}
	</div>
</div>
<script>
var table;
$(function(){
	//$.fn.dataTableExt.sErrMode = 'throw';
    //$.fn.dataTable.ext.errMode = 'none';
    table = $('#dt_tbl').DataTable({
    "processing": true, //Feature control the processing indicator.
    "serverSide": true, //Feature control DataTables' server-side processing mode.
     fixedHeader: {
            header: true,
            footer: true
        },
    // Load data for the table's content from an Ajax source
    "ajax": {
        "url": "/datatags/index/all_data?type="+$('#list_category').val(),
        "type": "GET"
    },
    columns: [
        {
            data: "tags_id",
            searchable: false,
            render: function (data, type, row, meta) {
                return meta.row + meta.settings._iDisplayStart + 1;
            }
        },
        {data: "tags_title"},
        {data: "tags_slug"},
        {data: "tags_type"}
    ],
    //Set column definition initialisation properties.
    "columnDefs": [
        {
            "targets": 4,
            "render": function(data, type, row, meta){
               var str='';
               //str += '<a href="/datatags/edit/'+row.tags_id+'" title="Edit Menu" class="btn btn-xs btn-default"><i class="fa fa-pencil"></i></a>';
               str += ' <a href="#" onclick="del_row('+"'"+row.tags_id+"'"+')" title="Delete data" class="btn btn-xs btn-default"><i class="fa fa-trash-o"></i></a>';
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
            "processing": "<img src='/img/loading.gif' />"
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

function del_row(pk)
{
    var conf=confirm('Anda yakin ???');
    if(conf)
    {
        $.post('/datatags/delete',{pk:pk},function(r){
            var rs=jQuery.parseJSON(r);
            if(rs.success)
            {
                alert(rs.message);
                table.ajax.reload(null,false);
            }
            else
            {
                alert(rs.error.message);
            }
        });
    }
}

function filteringDt(){
    table.ajax.url("/datatags/index/all_data?type="+$('#list_category').val()).load();
}
</script>
{% endblock %}