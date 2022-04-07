{% extends "layouts/base.volt" %}
{% block pagetop %}
<a href="/menu" title="Back" class="btn btn-default"><span class="glyphicon glyphicon-arrow-left"></span></a>
{% endblock %}
{% block content %}

{{ flash.output() }}
<?php $this->partial("layouts/html/box/start",['icon'=>$row_menu->icon,'box_title'=>$row_menu->menu_title]); ?>
<form action="/menu/edit/{{resources.menu_id}}" method="POST">
  <div class="form-group">
    <label for="exampleInputEmail1">Title</label>
    <input type="text" class="form-control" name="title" placeholder="Title" id="title" value="{{resources.menu_title}}">
  </div>
  <div class="form-group label-floating">
    <label class="control-label" for="exampleInputEmail1">Resources</label>
    <input type="text" class="form-control" name="resources" value="{{resources.resources_name}}" readonly>
  </div>
  <div class="form-group label-floating">
    <label class="control-label" for="exampleInputEmail1">Access</label>
    <input type="text" class="form-control" name="access" value="{{resources.access_name}}" readonly>
  </div>
  <div class="form-group">
    <label for="exampleInputEmail1">Description</label>
    <input type="text" class="form-control" name="deskripsi" placeholder="Description" value="{{resources.description}}">
  </div>
  <div class="form-group">
    <label for="exampleInputEmail1">Icon</label>
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
var access_name = '{{resources.access_name}}';
$(function(){
    $('#access').val(access_name);
    $('#s_icon')
    .val('{{resources.icon}}')
    .selectpicker({size: 8});
});
</script>
{% endblock %}