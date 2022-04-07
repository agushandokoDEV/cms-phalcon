{% extends "layouts/base.volt" %}
{% block pagetop %}
<h1><i class="{{row_menu.icon}}"></i> {{row_menu.menu_title}}<small>{{row_menu.description}}</small></h1>
{% endblock %}
{% block content %}
<?php $this->partial("layouts/html/box/start",['icon'=>$row_menu->icon,'box_title'=>$row_menu->menu_title]); ?>
<div class="hidden" id="loader-body"></div>
{{data['list_roles']}}
<hr />
<div id="load-access"></div>
<?php $this->partial("layouts/html/box/end"); ?>
<script>
var type="";
var aksi="";
var roles = $('#roles').val();
var allowed=0;
load_access();

function load_access(r)
{
    $('#loader-body').removeClass('hidden');
    if(r)
    {
        $.post('/menuakses/index/get_list_menu_by_role',{roles:r},function(data){
            var rs=jQuery.parseJSON(data);
            
            if(rs.success)
            {
                $('#load-access').html(rs.data);
                $('#treeGrid').treetable({ expandable: true});
                $('#loader-body').addClass('hidden');
            }
        });
    }
    else
    {
        $('#loader-body').addClass('hidden');
        $('#load-access').html('');
    }
}

function checkAll(r)
{
    console.log(r);
    var checked = [];
    var sel = $("input[name='"+r+"[]']");
    var data = sel.map(function(){
        return $(this).val();
    });
    type = "many";
    
    $(sel).each(function ()
    {
        if(sel.prop('checked')){
            $('.'+r).prop('checked', true);
            allowed=1;
        }
        else
        {
            $('.'+r).prop('checked', false);
            allowed=0;
        }
    });
    $('#loader-body').removeClass('hidden');
    $.post('/menuakses/edit/setAccess',{type:type,roles:$('#roles').val(),resources:r,access:data.get(),allowed:allowed},function(data){
        var rs=jQuery.parseJSON(data);
        console.log(rs);
        if(!rs.success)
        {
            alert(rs.error.message);
        }
        $('#loader-body').addClass('hidden');
    });
}

function checkOne(r,a,i)
{
    var sel = $("#"+r+i);
    type = "one";    
    if (sel.prop('checked')) {
        allowed=1;
    }
    else
    {
        allowed=0;
    }
    //console.log(a+' '+$('#roles').val()+' '+r+' '+sel.val()+' '+allowed);
    
    $('#loader-body').removeClass('hidden');
    $.post('/menuakses/edit/setAccess/',{type:type,roles:$('#roles').val(),resources:r,access:a,allowed:allowed},function(data){
        var rs=jQuery.parseJSON(data);
        console.log(rs);
        if(!rs.success)
        {
            alert(rs.error.message);
        }
        $('#loader-body').addClass('hidden');
    });
    
}
</script>
{% endblock %}