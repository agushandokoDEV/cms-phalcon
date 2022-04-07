{% extends "layouts/base.volt" %}
{% block pagetop %}
<h1><i class="{{row_menu.icon}}"></i> {{row_menu.menu_title}}<small>{{row_menu.description}}</small></h1>
<br />
<a href="/media/add" class="btn btn-default"><span class="glyphicon glyphicon-plus"></span> Add new data</a>
{% endblock %}
{% block content %}
{{ flash.output() }}
<?php $this->partial("layouts/html/box/start",["icon"=>$row_menu->icon,"box_title"=>$row_menu->menu_title]); ?>
<table class="table table-bordered table-hover" id="dt_tbl">
    <thead>
        <tr>
            <th style="width: 10%;">File</th>
            <th>Caption</th>
			<th>Size</th>
            <th>Author</th>
            <th style="width: 7%;">Actions</th>
        </tr>
    </thead>
    <tbody>
        
    </tbody>
</table>
<?php $this->partial("layouts/html/box/end"); ?>
<div class="hide">    
	<div class="dt_index_actions">
    {{data.list_author}}
    <select class="form-control input-sm" id="list_type" onchange="filteringDt()">
        <option value="">Type</option>
        <option value="image">Image</option>
        <option value="doc">Document</option>
        <option value="video">Video</option>
    </select>
	</div>
</div>
<script>
var table;
var fil_author=$('#list_author');
var fil_type=$('#list_type');

$(function(){
	//$.fn.dataTableExt.sErrMode = 'throw';
    $.fn.dataTable.ext.errMode = 'none';
    table = $('#dt_tbl').DataTable({
    "processing": true, //Feature control the processing indicator.
    "serverSide": true, //Feature control DataTables' server-side processing mode.
    // Load data for the table's content from an Ajax source
    "ajax": {
        "url": "/media/index/all_data",
        "type": "GET"
    },
    columns: [
        {
            data: "media_path",
            searchable: false,
            render: function (data, type, row, meta) {
                var img = '-';
                var ico = [];
                ico['video']='/img/ico-video.png';
                ico['doc']='/img/ico-document.png';
                ico['image']=row.media_path;
                return '<img title="'+row.media_name+'" src="'+ico[row.media_type]+'" class="img-thumbnail" style="width: 75px; height: 75px;"/>';
            }
        },
        {data: "media_caption"},
        {data: "file_size"},
        {data: "media_author"},
    ],
    //Set column definition initialisation properties.
    "columnDefs": [
        {
            "targets": 4,
            "render": function(data, type, row, meta){
               var str='';
               str += '<a href="/media/edit/'+row.media_id+'" title="Edit '+row.media_name+'" class="btn btn-xs btn-default"><span class="glyphicon glyphicon-pencil"></span></a>';
               str += ' <a href="javascript:void(0)" onclick="del_row('+"'"+row.media_id+"'"+')" title="Delete '+row.media_name+'" class="btn btn-xs btn-default"><span class="glyphicon glyphicon-trash"></span></a>';
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

function filteringDt(){
    console.log(fil_type.val());
    table.ajax.url("/media/index/all_data?author="+fil_author.val()+"&type="+$('#list_type').val()).load();
}

function del_row(pk)
{
    var conf=confirm('Anda yakin ???');
    if(conf)
    {
        $.post('/media/delete',{pk:pk},function(r){
            var rs=jQuery.parseJSON(r);
            console.log(rs);
            if(!rs.success)
            {
                alert(rs.error.message);
                
            }
            table.ajax.reload(null,false);
        });
    }
}
</script>
{% endblock %}