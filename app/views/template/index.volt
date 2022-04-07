{% extends "layouts/base.volt" %}
{% block pagetop %}
<h1><i class="{{row_menu.icon}}"></i> {{row_menu.menu_title}}<small>{{row_menu.description}}</small></h1>
{% endblock %}
{% block content %}
{{ flash.output() }}
<a href="/template/add" class="btn btn-default"><i class="fa fa-plus"></i> Add new data</a>
<?php $this->partial("layouts/html/box/start",["icon"=>$row_menu->icon,"box_title"=>$row_menu->menu_title]); ?>
<table class="table table-bordered table-hover" id="dt_tbl">
    <thead>
        <tr>
            <th>Name</th>
            <th>Title</th>
            <th>Active</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        
    </tbody>
</table>
<?php $this->partial("layouts/html/box/end"); ?>
<script>
$(function(){
	//$.fn.dataTableExt.sErrMode = 'throw';
    $.fn.dataTable.ext.errMode = 'none';
    table = $('#dt_tbl').DataTable({
    "processing": true, //Feature control the processing indicator.
    "serverSide": true, //Feature control DataTables' server-side processing mode.
    // Load data for the table's content from an Ajax source
    "ajax": {
        "url": "/template/index/all_data",
        "type": "GET"
    },
    columns: [
        {data: "name"},
        {data: "title"}
    ],
    //Set column definition initialisation properties.
    "columnDefs": [
        {
            "targets": 2,
            "render": function(data, type, row, meta){
               var str='';
               var stts=[];
               var val_stts=[];
               stts['0']='';
               stts['1']='checked';
               val_stts['0']=1;
               val_stts['1']=0;
               
               str ='<input type="checkbox" onchange="set_active('+"'"+row.name+"'"+','+"'"+val_stts[row.active]+"'"+')" '+stts[row.active]+'/>';
               return str;
            }
        },
        {
            "targets": 3,
            "render": function(data, type, row, meta){
               var str='';
               str += '<a href="/template/edit/'+row.name+'" title="Edit '+row.name+'" class="btn btn-xs btn-default"><span class="glyphicon glyphicon-pencil"></span></a>';
               str += ' <a href="javascript:void(0)" onclick="del_row('+"'"+row.name+"'"+')" title="Hapus '+row.title+'" class="btn btn-xs btn-default"><span class="glyphicon glyphicon-trash"></span></a>';
               return str;
            }
        }
    ],
    "language": {
            "lengthMenu": "_MENU_",
    },
    "order": [[ 0, 'desc' ]],
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

function set_active(pk,stts){
    var conf=confirm('Anda yakin ???');
    if(conf){
        
        $.post('/template/edit/'+pk+'/set_active',{pk:pk,stts:stts},function(){
            
        })
        .done(function(r){
            var rs=jQuery.parseJSON(r);
            if(rs.success){
                alert('Set aktif template OK');
            }else{
                alert(rs.error.message);
            }
            table.ajax.reload(null,false);
        });
    }
}

function del_row(pk)
{
    var conf=confirm('Semua template folder '+name+' akan ikut terhapus, anda yakin ???');
    if(conf)
    {
        $.post('/template/delete',{pk:pk},function(r){
            var rs=jQuery.parseJSON(r);
            if(rs.success)
            {
                alert(rs.message);
                table.ajax.reload(null,false);
            }
            else
            {
                console.log(rs);
                alert(rs.error.message);
            }
        });
    }
}
</script>
{% endblock %}