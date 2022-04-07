{% extends "layouts/base.volt" %}
{% block pagetop %}
<a href="/menu" title="Back" class="btn btn-default"><span class="glyphicon glyphicon-arrow-left"></span></a>
{% endblock %}
{% block content %}
{{ flash.output() }}
<?php $this->partial("layouts/html/box/start",['icon'=>$row_menu->icon,'box_title'=>$row_menu->menu_title]); ?>
<form action="/menu/add" method="POST" id="form-add">
  <div class="form-group label-floating">
    <label class="control-label" for="exampleInputEmail1">Title</label>
    <input type="text" class="form-control" name="title" id="title">
  </div>
  <div class="checkbox">
    <label>
      <input name="parent_only" id="parent_only" onchange="_on_parent_checked()" type="checkbox" value="Y"> Parent Only
    </label>
  </div>
  <div class="form-group label-floating">
    <label class="control-label" for="exampleInputEmail1">Module</label>
    <input type="text" class="form-control" name="resources" id="resources">
  </div>
  <div class="form-group label-floating">
    <label class="control-label" for="exampleInputEmail1">Access</label>
    <select class="form-control" name="access" id="access">
        <option value="*">All</option>
        <option value="add">Create</option>
        <option value="index">Read</option>
        <option value="edit">Update</option>
        <option value="delete">Delete</option>
    </select>
  </div>
  
  <div class="form-group label-floating">
    <label class="control-label" for="exampleInputEmail1">Description</label>
    <input type="text" class="form-control" name="deskripsi">
  </div>
  <!--
  <div class="form-group label-floating">
    <label class="control-label" for="exampleInputEmail1">Parent</label>
    {{data['menu_parent']}}
  </div>
  -->
  <div class="form-group label-floating">
    <label class="control-label" for="exampleInputEmail1">Icon</label>
    <select class="form-control" name="icon" id="s_icon" data-show-icon="true" data-live-search="true">
        <option value="">-</option>
        {% for ico in list_icon %}
        <option data-icon="{{ico.icon_name}}" class="material-icons" value="{{ico.icon_name}}">{{ico.icon_name}}</option>
        {% endfor %}
    </select>
  </div>
  <button type="submit" class="btn btn-success">Submit</button>
  <a href="/menu" class="btn btn-default">Kembali</a>
</form>
<?php $this->partial("layouts/html/box/end"); ?>

<script>
$(document).ready(function(){
    _on_parent_checked();
    $('#s_icon').selectpicker({size: 8});
    $('#form-add').formValidation({
        framework: 'bootstrap',
        locale: 'id_ID',
        fields: {
            resources: {
                validators: {
                    notEmpty: {},
                    regexp: {
                        regexp: /^[A-Za-z0-9_\_#]+$/,
                        message: 'Karakter tidak valid, underscore(_) untuk pemisah karakter'
                    }
                }
            },
            access: {
                validators: {
                    notEmpty: {}
                }
            },
            deskripsi: {
                validators: {
                    notEmpty: {},
                }
            }
        }
    });
});

function _on_parent_checked(){
    if($('input#parent_only').prop('checked') == true){
        $('#resources')
            .val('#')
            .attr('readonly','readonly');
        $('#access')
            .attr('disabled','disabled');
    }else{
        $('#resources')
            .val('')
            .removeAttr('readonly');
        $('#access')
            .removeAttr('disabled');
    }
}
</script>
{% endblock %}