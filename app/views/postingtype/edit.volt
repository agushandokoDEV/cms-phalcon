{% extends "layouts/base.volt" %}
{% block pagetop %}
<a href="/postingtype" title="Back" class="btn btn-default"><span class="glyphicon glyphicon-arrow-left"></span></a>
{% endblock %}
{% block content %}
{{ flash.output() }}
<?php $this->partial("layouts/html/box/start",['icon'=>$row_menu->icon,'box_title'=>$row_menu->menu_title]); ?>
<form action="/postingtype/edit/{{data.post_type}}" method="POST" id="form-add">
  <div class="form-group">
    <label for="exampleInputEmail1">Type</label>
    <input type="text" class="form-control" name="type" placeholder="Type" value="{{data.post_type}}" readonly>
  </div>
  <div class="form-group">
    <label for="exampleInputEmail1">Title</label>
    <input type="text" class="form-control" name="title" placeholder="Title" value="{{data.post_title}}">
  </div>
  <div class="form-group label-floating">
    <label class="control-label" for="exampleInputEmail1">Icon</label>
    <select class="form-control" name="icon" id="s_icon" data-show-icon="true" data-live-search="true">
        <option value="">-</option>
        {% for ico in list_icon %}
        <option data-icon="{{ico.icon_name}}" class="material-icons" value="{{ico.icon_name}}">{{ico.icon_name}}</option>
        {% endfor %}
    </select>
  </div>
  <div class="form-group">
    <label for="exampleInputEmail1">Type</label>
    <select class="form-control" name="status" id="status">
        <option value="Y">Y</option>
        <option value="N">N</option>
    </select>
  </div>
  <div class="form-group">
    <label for="exampleInputPassword1">Descroption</label>
    <textarea class="form-control" rows="3" name="description" placeholder="Descroption">{{data.post_type_des}}</textarea>
  </div>
  <button type="submit" class="btn btn-success">Submit</button>
  <a href="/postingtype" class="btn btn-default">Kembali</a>
</form>
<?php $this->partial("layouts/html/box/end"); ?>
<script>
$(document).ready(function(){
    $('#status').val('{{data.post_type_status}}');
    $('#s_icon')
    .val('{{data.post_icon}}')
    .selectpicker({size: 8});
});
</script>
{% endblock %}