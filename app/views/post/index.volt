{% extends "layouts/base.volt" %}
{% block pagetop %}
<h1><i class="{{row_menu.icon}}"></i> {{row_menu.menu_title}} - {{row_post.post_title}}<small>{{row_menu.description}}</small></h1>
{% endblock %}
{% block content %}
{{ flash.output() }}
<a href="/post/add/{{row_post.post_type}}" class="btn btn-default"><span class="glyphicon glyphicon-plus"></span> Add new {{row_post.post_title}}</a>
<?php $this->partial("layouts/html/box/start",['icon'=>$row_post->post_icon,'box_title'=>$row_post->post_title]); ?>
<table class="table table-bordered table-hover" id="dt_tbl">
    <thead>
        <tr>
            <th>No</th>
            <th>Title</th>
            <th>Status</th>
			<th>Category</th>
            <th>Publish</th>
            <th>Author</th>
            <th>Schedule</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        
    </tbody>
</table>

<?php $this->partial("layouts/html/box/end"); ?>
<div class="hide">    
	<div class="dt_index_actions">
    {{data.list_post_author}}
    {{data.list_category}}
    <select class="form-control input-sm" id="fil_stts" onchange="filteringDt()">
        <option value="">Status</option>
        <option value="draft">Draft</option>
        <option value="publish">Publish</option>
    </select>
	</div>
</div>
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
        "url": "/post/index/{{row_post.post_type}}/get_all_data?author="+$('#list_post_author').val()+"&type={{row_post.post_type}}&category="+$('#list_category').val(),
        "type": "GET"
    },
    columns: [
        {
            data: "post_id",
            searchable: false,
            render: function (data, type, row, meta) {
                return meta.row + meta.settings._iDisplayStart + 1;
            }
        },
        {data: "post_title"},
        {data: "post_status"},
        {data: "category"},
        {data: "publish_on"},
        {data: "full_name"},
        {
            data: "publish_schedule",
            searchable: false,
            orderable:false,
            render: function (data, type, row, meta) {
                var sc=row.publish_schedule;
                if(sc ==null){
                    sc='N';
                }
                return sc;
            }
        }
    ],
    //Set column definition initialisation properties.
    "columnDefs": [
        {
            "targets": 7,
            "render": function(data, type, row, meta){
               var str='';
               str += '<a href="/post/edit/{{row_post.post_type}}/'+row.post_id+'" title="Edit '+row.post_title+'" class="btn btn-xs btn-default"><span class="glyphicon glyphicon-pencil"></span></a>';
               str += ' <a href="#" onclick="del_row('+"'"+row.post_id+"'"+')" title="Delete '+row.post_title+'" class="btn btn-xs btn-default"><span class="glyphicon glyphicon-trash"></span></a>';
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
    var fil_author=$('#list_post_author').val();
    var fil_stts=$('#fil_stts').val();
    var fil_lang=$('#fil_lang').val();
    
    table.ajax.url("/post/index/{{row_post.post_type}}/get_all_data?type={{row_post.post_type}}&author="+fil_author+"&status="+fil_stts+"&category="+$('#list_category').val()+"").load();
}
function del_row(pk)
{
    var conf=confirm('Anda yakin ???');
    if(conf)
    {
        $.post('/post/delete/{{row_post.post_type}}',{postid:pk},function(r){
            var rs=jQuery.parseJSON(r);
            console.log(rs);
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
</script>
{% endblock %}