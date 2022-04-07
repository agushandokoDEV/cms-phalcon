{% extends "layouts/base.volt" %}
{% block pagetop %}
<h1><i class="{{row_menu.icon}}"></i> {{row_menu.menu_title}}<small>{{row_menu.description}}</small></h1>
{% endblock %}
{% block content %}
<?php $this->partial("layouts/html/box/start",["icon"=>$row_menu->icon,"box_title"=>$row_menu->menu_title]); ?>
<div class="hidden" id="loader-body"></div>
<div class="row">
    <div class="col-md-8">
        <div class="panel panel-default">
          <div class="panel-heading">
            <h3 class="panel-title">Panel Struktur Menu</h3>
          </div>
          <div class="panel-body" style="max-height: 290px;overflow: scroll;">
            <div class="dd" id="nestable" style="width: 100%;">{{menuItem}}</div>
            <div class="clear"></div>
          </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="panel panel-default">
          <div class="panel-heading">
            <h3 class="panel-title">Panel Form</h3>
          </div>
          <div class="panel-body">
            <form method="POST" id="form-add" action="/pagemenuposition/add/save_new_uri">
              <div class="form-group">
                <label for="exampleInputEmail1">Parent :</label>
                <input type="text" class="form-control" id="mn-parent" value="-" readonly>
                <input type="hidden" value="0" id="parent-modul" name="parent_modul"/>
                <input type="hidden" value="0" name="pk" id="pk"/>
              </div>
              <div class="form-group">
                <label for="exampleInputEmail1">Menu :</label>
                <input type="text" class="form-control" name="menu_title" id="menu-title" placeholder="Menu title">
              </div>
              <div class="form-group">
                <label for="exampleInputEmail1">Url :</label>
                <input type="text" class="form-control" name="url_modul" id="url-modul" placeholder="Url controller">
              </div>
              <button type="submit" class="btn btn-primary">Submit</button>
              <button type="reset" class="btn btn-default">Reset</button>
            </form>
          </div>
        </div>
    </div>
</div>
<textarea class="hidden" id="nestable-output"></textarea>
<?php $this->partial("layouts/html/box/end"); ?>

<script>
var updateOutput = function(e)
    {
        var list   = e.length ? e : $(e.target),
            output = list.data('output');
        if (window.JSON) {
            output.val(window.JSON.stringify(list.nestable('serialize')));//, null, 2));
        } else {
            output.val('JSON browser support required for this demo.');
        }
    };

$(document).ready(function(){
    // activate Nestable for list 1
    $('#nestable').nestable({
        group: 1
    })
    .on('change', updateOutput);
    updateOutput($('#nestable').data('output', $('#nestable-output')));
    
    $('.dd').on('change', function() {
        $('#loader-body').removeClass('hidden');
        $.post('/pagemenuposition/edit/setPosition',{data:$("#nestable-output").val()},function(){
            
        })
        .done(function(r){
            var rs = jQuery.parseJSON(r);
            if(!rs.success)
            {
               alert(rs.error.message);
            }
            $('#loader-body').addClass('hidden');
        })
        .fail(function(x,y,z){
            $('#loader-body').addClass('hidden');
        });
        
    });
    
    $('#form-add').formValidation({
        framework: 'bootstrap',
        locale: 'id_ID',
        fields: {
            url_modul: {
                validators: {
                    notEmpty: {},
                    regexp: {
                        regexp: /^[A-Za-z0-9_\_#]+$/,
                        message: 'Karakter tidak valid, underscore(_) untuk pemisah karakter'
                    }
                }
            },
            menu_title: {
                validators: {
                    notEmpty: {}
                }
            }
        }
    })
    .on('success.form.fv', function(e) {
        // Prevent form submission
        e.preventDefault();

        var $form = $(e.target),
            fv    = $form.data('formValidation');

        // Use Ajax to submit form data
        $.ajax({
            url: $form.attr('action'),
            type: 'POST',
            data: $form.serialize(),
            success: function(r) {
                var rs=jQuery.parseJSON(r);
                console.log(rs);
                if(rs.success){
                    alert(rs.message);
                    location.reload();
                }else{
                    alert(rs.error.message);
                }
            }
        });
    });
});
$(document).on("click",".edit-button",function() {
    var id = $(this).attr('id');
    var resources = $(this).attr('resources');
    var access = $(this).attr('access');
    var parent = $(this).attr('parent');
    console.log(id+'-'+parent+'-'+resources+'-'+access);
    //$('#nestable').nestable('collapseAll');
});

function get_row(menuid,mntitle){
    $('#parent-modul').val(menuid);
    $('#mn-parent').val(mntitle);
}

function upd_row(menuid,mntitle,modul){
    $('#pk').val(menuid);
    $('#url-modul')
        .val(modul)
        .attr('readonly','readonly');
    $('#menu-title').val(mntitle);
}

function del_row(pk){
    var conf=confirm('Anda yakin ???');
    if(conf)
    {
        $.post('/pagemenuposition/delete',{pk:pk},function(){
        
        })
        .done(function(r){
            var rs=jQuery.parseJSON(r);
            if(rs.success){
                alert('menu berhasi dihapus');
                location.reload();
            }else{
                alert(rs.error.message);
            }
        });
    }
}

</script>
{% endblock %}